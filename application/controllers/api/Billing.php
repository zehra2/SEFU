<?php

defined('BASEPATH') or exit('No direct script access allowed');

/**
 * Kenya HIE & SHA Billing REST API Controller
 * Provides itemized billing lookup, patient financial vouchers, tariff breakdowns,
 * and invoice states ready for Social Health Authority (SHA) claims submission.
 */
class Billing extends API_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * GET /api/v1/billing
     */
    public function index()
    {
        $limit = min(100, max(1, intval($this->input->get('limit', TRUE)) ?: 25));
        $this->db->select('t.*, p.patient_name, p.national_id, p.upi, p.insurance_id');
        $this->db->from('transactions t');
        $this->db->join('patients p', 'p.id = t.patient_id', 'left');
        $this->db->order_by('t.id', 'DESC')->limit($limit);
        $transactions = $this->db->get()->result_array();

        $invoices = array();
        foreach ($transactions as $tx) {
            $invoices[] = array(
                'transaction_id' => intval($tx['id']),
                'receipt_no'     => 'RCPT-' . $tx['id'],
                'date'           => $tx['payment_date'] ?: $tx['created_at'],
                'patient'        => array(
                    'id'           => intval($tx['patient_id']),
                    'name'         => $tx['patient_name'],
                    'national_id'  => $tx['national_id'],
                    'upi'          => $tx['upi'],
                    'insurance_id' => $tx['insurance_id']
                ),
                'amount'         => floatval($tx['amount']),
                'currency'       => 'KES',
                'payment_mode'   => $tx['payment_mode'],
                'section'        => $tx['section'],
                'type'           => $tx['type']
            );
        }

        $this->log_api_audit('BILLING_TRANSACTIONS_QUERY');
        $this->response_json(array('total' => count($invoices), 'invoices' => $invoices), 200);
    }

    /**
     * GET /api/v1/billing/patient/$id
     * Returns full itemized billing ledger for a specific patient (by ID, UPI, or National ID)
     */
    public function patient($id = null)
    {
        if (empty($id)) {
            $this->error_json("Missing patient identifier parameter.", 400);
        }

        // Find patient
        $this->db->from('patients');
        if (is_numeric($id)) {
            $this->db->group_start()->where('id', intval($id))->or_where('national_id', $id)->or_where('upi', $id)->group_end();
        } else {
            $this->db->group_start()->where('upi', $id)->or_where('national_id', $id)->or_where('identification_number', $id)->group_end();
        }
        $patient = $this->db->get()->row_array();

        if (!$patient) {
            $this->error_json("Patient not found matching: " . htmlspecialchars($id), 404);
        }

        $patient_id = intval($patient['id']);
        $line_items = array();
        $total_billed = 0.0;

        // 1. Pharmacy Bills
        $pharm_bills = $this->db->where('patient_id', $patient_id)->get('pharmacy_bill_basic')->result_array();
        foreach ($pharm_bills as $pb) {
            $net = floatval($pb['net_amount']);
            $total_billed += $net;
            $line_items[] = array(
                'bill_no'     => !empty($pb['bill_no']) ? 'PHARM-' . $pb['bill_no'] : 'PHARM-BILL-' . $pb['id'],
                'category'    => 'Pharmacy',
                'description' => 'Prescription Medicine Dispensing',
                'amount'      => $net,
                'date'        => $pb['date']
            );
        }

        // 2. Physiotherapy Bills
        $physio_bills = $this->db->where('patient_id', $patient_id)->get('physiotherapy')->result_array();
        foreach ($physio_bills as $pt) {
            $net = floatval($pt['apply_charge']);
            $total_billed += $net;
            $line_items[] = array(
                'bill_no'     => $pt['bill_no'],
                'category'    => 'Physiotherapy',
                'description' => 'Physiotherapy Rehabilitation Session (' . $pt['session_duration'] . ' mins)',
                'amount'      => $net,
                'date'        => $pt['session_date']
            );
        }

        // 3. Pediatric Bills
        $ped_bills = $this->db->where('patient_id', $patient_id)->get('pediatric')->result_array();
        foreach ($ped_bills as $ped) {
            $net = floatval($ped['apply_charge']);
            $total_billed += $net;
            $line_items[] = array(
                'bill_no'     => $ped['bill_no'],
                'category'    => 'Pediatric',
                'description' => 'Pediatric Consultation & Growth Assessment',
                'amount'      => $net,
                'date'        => date('Y-m-d', strtotime($ped['created_at']))
            );
        }

        // 4. Gynaecology Bills
        $gyn_bills = $this->db->where('patient_id', $patient_id)->get('gynaecology')->result_array();
        foreach ($gyn_bills as $gyn) {
            $net = floatval($gyn['apply_charge']);
            $total_billed += $net;
            $line_items[] = array(
                'bill_no'     => $gyn['bill_no'],
                'category'    => 'Gynaecology',
                'description' => 'Gynaecology & Antenatal Consultation',
                'amount'      => $net,
                'date'        => date('Y-m-d', strtotime($gyn['created_at']))
            );
        }

        // 5. Query Payments & Transactions
        $payments = $this->db->where('patient_id', $patient_id)->get('transactions')->result_array();
        $total_paid = 0.0;
        $payment_records = array();
        foreach ($payments as $p) {
            $amt = floatval($p['amount']);
            if ($p['type'] === 'payment') {
                $total_paid += $amt;
            }
            $payment_records[] = array(
                'receipt_no'   => 'RCPT-' . $p['id'],
                'amount'       => $amt,
                'payment_mode' => $p['payment_mode'],
                'date'         => $p['payment_date'] ?: $p['created_at'],
                'type'         => $p['type']
            );
        }

        $balance = max(0, $total_billed - $total_paid);
        $status = 'unpaid';
        if ($total_billed > 0 && $balance == 0) {
            $status = 'paid';
        } elseif ($total_paid > 0 && $balance > 0) {
            $status = 'partially_paid';
        }

        $this->log_api_audit('PATIENT_BILLING_LEDGER_QUERY', $patient_id);

        $response_data = array(
            'resourceType'  => 'Claim',
            'facility_kmhfl'=> $this->get_facility_kmhfl(),
            'currency'      => 'KES',
            'patient'       => array(
                'id'           => $patient['id'],
                'name'         => $patient['patient_name'],
                'national_id'  => $patient['national_id'],
                'upi'          => $patient['upi'],
                'insurance_id' => $patient['insurance_id'],
                'sha_eligible' => !empty($patient['insurance_id'])
            ),
            'financialSummary' => array(
                'total_billed' => round($total_billed, 2),
                'total_paid'   => round($total_paid, 2),
                'balance'      => round($balance, 2),
                'status'       => $status
            ),
            'itemizedBills' => $line_items,
            'payments'      => $payment_records
        );

        $this->response_json($response_data, 200);
    }
}

