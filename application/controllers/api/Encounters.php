<?php

defined('BASEPATH') or exit('No direct script access allowed');

/**
 * Kenya HIE Encounter REST API Controller
 * Provides standardized Clinical Encounter query, retrieval, and registration
 * across OPD, IPD, and clinical specialties (Physiotherapy, Pediatric, Gynaecology)
 * with practitioner license numbers and KMHFL facility context.
 */
class Encounters extends API_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * GET /api/v1/encounters
     */
    public function index()
    {
        $this->search();
    }

    /**
     * GET /api/v1/encounters/search
     * Query params: patient_id, national_id, upi, type, from_date, to_date, page, limit
     */
    public function search()
    {
        $patient_id  = trim($this->input->get('patient_id', TRUE));
        $national_id = trim($this->input->get('national_id', TRUE));
        $upi         = trim($this->input->get('upi', TRUE));
        $type        = strtoupper(trim($this->input->get('type', TRUE)));
        $from_date   = trim($this->input->get('from_date', TRUE));
        $to_date     = trim($this->input->get('to_date', TRUE));
        $limit       = min(100, max(1, intval($this->input->get('limit', TRUE)) ?: 25));

        // Resolve target patient ID if national_id or upi provided
        $resolved_patient_ids = array();
        if (!empty($patient_id)) {
            $resolved_patient_ids[] = intval($patient_id);
        } elseif (!empty($national_id) || !empty($upi)) {
            $this->db->select('id')->from('patients');
            if (!empty($national_id)) {
                $this->db->group_start()->where('national_id', $national_id)->or_where('identification_number', $national_id)->group_end();
            }
            if (!empty($upi)) {
                $this->db->where('upi', $upi);
            }
            $p_rows = $this->db->get()->result_array();
            foreach ($p_rows as $pr) {
                $resolved_patient_ids[] = intval($pr['id']);
            }
            if (empty($resolved_patient_ids)) {
                $this->response_json(array('total_matches' => 0, 'encounters' => array()), 200);
                return;
            }
        }

        $all_encounters = array();

        // 1. Fetch OPD Encounters (visit_details + opd_details)
        if (empty($type) || $type === 'OPD') {
            $this->db->select('v.*, o.patient_id, p.patient_name, p.national_id, p.upi, p.gender, s.name as doctor_name, s.surname as doctor_surname, s.council_registration_no as doctor_license');
            $this->db->from('visit_details v');
            $this->db->join('opd_details o', 'o.id = v.opd_details_id');
            $this->db->join('patients p', 'p.id = o.patient_id');
            $this->db->join('staff s', 's.id = v.cons_doctor', 'left');

            if (!empty($resolved_patient_ids)) {
                $this->db->where_in('o.patient_id', $resolved_patient_ids);
            }
            if (!empty($from_date)) {
                $this->db->where('v.appointment_date >=', date('Y-m-d 00:00:00', strtotime($from_date)));
            }
            if (!empty($to_date)) {
                $this->db->where('v.appointment_date <=', date('Y-m-d 23:59:59', strtotime($to_date)));
            }
            $this->db->order_by('v.id', 'DESC')->limit($limit);
            $opd_rows = $this->db->get()->result_array();

            foreach ($opd_rows as $row) {
                $all_encounters[] = $this->format_opd_encounter($row);
            }
        }

        // 2. Fetch Physiotherapy Encounters
        if (empty($type) || $type === 'PHYSIOTHERAPY' || $type === 'PHYSIO') {
            $this->db->select('pt.*, p.patient_name, p.national_id, p.upi, p.gender, s.name as doctor_name, s.surname as doctor_surname, s.council_registration_no as doctor_license');
            $this->db->from('physiotherapy pt');
            $this->db->join('patients p', 'p.id = pt.patient_id');
            $this->db->join('staff s', 's.id = pt.physiotherapist_id', 'left');

            if (!empty($resolved_patient_ids)) {
                $this->db->where_in('pt.patient_id', $resolved_patient_ids);
            }
            if (!empty($from_date)) {
                $this->db->where('pt.session_date >=', date('Y-m-d', strtotime($from_date)));
            }
            if (!empty($to_date)) {
                $this->db->where('pt.session_date <=', date('Y-m-d', strtotime($to_date)));
            }
            $this->db->order_by('pt.id', 'DESC')->limit($limit);
            $pt_rows = $this->db->get()->result_array();

            foreach ($pt_rows as $row) {
                $all_encounters[] = $this->format_physio_encounter($row);
            }
        }

        // 3. Fetch Pediatric Encounters
        if (empty($type) || $type === 'PEDIATRIC' || $type === 'PEDIATRICS') {
            $this->db->select('ped.*, p.patient_name, p.national_id, p.upi, p.gender, s.name as doctor_name, s.surname as doctor_surname, s.council_registration_no as doctor_license');
            $this->db->from('pediatric ped');
            $this->db->join('patients p', 'p.id = ped.patient_id');
            $this->db->join('staff s', 's.id = ped.pediatrician_id', 'left');

            if (!empty($resolved_patient_ids)) {
                $this->db->where_in('ped.patient_id', $resolved_patient_ids);
            }
            if (!empty($from_date)) {
                $this->db->where('ped.created_at >=', date('Y-m-d 00:00:00', strtotime($from_date)));
            }
            if (!empty($to_date)) {
                $this->db->where('ped.created_at <=', date('Y-m-d 23:59:59', strtotime($to_date)));
            }
            $this->db->order_by('ped.id', 'DESC')->limit($limit);
            $ped_rows = $this->db->get()->result_array();

            foreach ($ped_rows as $row) {
                $all_encounters[] = $this->format_pediatric_encounter($row);
            }
        }

        // 4. Fetch Gynaecology Encounters
        if (empty($type) || $type === 'GYNAECOLOGY' || $type === 'GYNAE') {
            $this->db->select('gyn.*, p.patient_name, p.national_id, p.upi, p.gender, s.name as doctor_name, s.surname as doctor_surname, s.council_registration_no as doctor_license');
            $this->db->from('gynaecology gyn');
            $this->db->join('patients p', 'p.id = gyn.patient_id');
            $this->db->join('staff s', 's.id = gyn.gynaecologist_id', 'left');

            if (!empty($resolved_patient_ids)) {
                $this->db->where_in('gyn.patient_id', $resolved_patient_ids);
            }
            if (!empty($from_date)) {
                $this->db->where('gyn.created_at >=', date('Y-m-d 00:00:00', strtotime($from_date)));
            }
            if (!empty($to_date)) {
                $this->db->where('gyn.created_at <=', date('Y-m-d 23:59:59', strtotime($to_date)));
            }
            $this->db->order_by('gyn.id', 'DESC')->limit($limit);
            $gyn_rows = $this->db->get()->result_array();

            foreach ($gyn_rows as $row) {
                $all_encounters[] = $this->format_gynae_encounter($row);
            }
        }

        $this->log_api_audit('ENCOUNTER_SEARCH_QUERY');

        $this->response_json(array(
            'total_matches' => count($all_encounters),
            'encounters'    => $all_encounters
        ), 200);
    }

    /**
     * POST /api/v1/encounters/create
     */
    public function create()
    {
        $input = $this->get_json_input();

        if (empty($input['patient_id'])) {
            $this->error_json("Validation error: 'patient_id' is required.", 422);
        }

        $patient = $this->db->where('id', intval($input['patient_id']))->get('patients')->row_array();
        if (!$patient) {
            $this->error_json("Patient ID #" . intval($input['patient_id']) . " not found.", 404);
        }

        // Create OPD entry
        $opd_data = array(
            'patient_id'   => $patient['id'],
            'generated_by' => 1,
            'discharged'   => 'no',
            'created_at'   => date('Y-m-d H:i:s')
        );
        $this->db->insert('opd_details', $opd_data);
        $opd_id = $this->db->insert_id();

        // Create visit_details record
        $visit_data = array(
            'opd_details_id'   => $opd_id,
            'cons_doctor'      => !empty($input['doctor_id']) ? intval($input['doctor_id']) : 1,
            'appointment_date' => !empty($input['encounter_date']) ? date('Y-m-d H:i:s', strtotime($input['encounter_date'])) : date('Y-m-d H:i:s'),
            'symptoms'         => !empty($input['symptoms']) ? trim($input['symptoms']) : '',
            'bp'               => !empty($input['bp']) ? trim($input['bp']) : null,
            'height'           => !empty($input['height']) ? trim($input['height']) : null,
            'weight'           => !empty($input['weight']) ? trim($input['weight']) : null,
            'pulse'            => !empty($input['pulse']) ? trim($input['pulse']) : null,
            'temperature'      => !empty($input['temperature']) ? trim($input['temperature']) : null,
            'note'             => !empty($input['notes']) ? trim($input['notes']) : 'Created via Kenya HIE REST API',
            'payment_mode'     => !empty($input['payment_mode']) ? trim($input['payment_mode']) : 'Cash',
            'generated_by'     => 1,
            'created_at'       => date('Y-m-d H:i:s')
        );
        $this->db->insert('visit_details', $visit_data);
        $visit_id = $this->db->insert_id();

        $this->log_api_audit('ENCOUNTER_CREATION', $visit_id);

        $created = array(
            'encounter_reference' => 'OPD-ENC-' . $visit_id,
            'opd_id'              => $opd_id,
            'visit_id'            => $visit_id,
            'patient_id'          => $patient['id'],
            'patient_name'        => $patient['patient_name'],
            'upi'                 => $patient['upi'],
            'national_id'         => $patient['national_id'],
            'created_at'          => date('c')
        );

        $this->response_json($created, 201);
    }

    private function format_opd_encounter($row)
    {
        return array(
            'resourceType' => 'Encounter',
            'id'           => 'OPD-' . $row['id'],
            'type'         => 'OPD',
            'department'   => 'Outpatient Department',
            'date'         => $row['appointment_date'] ?: $row['created_at'],
            'patient'      => array(
                'id'          => intval($row['patient_id']),
                'name'        => $row['patient_name'],
                'national_id' => $row['national_id'],
                'upi'         => $row['upi']
            ),
            'practitioner' => array(
                'name'        => trim($row['doctor_name'] . ' ' . $row['doctor_surname']),
                'license_no'  => !empty($row['doctor_license']) ? $row['doctor_license'] : 'KMPDC-REG-ACTIVE'
            ),
            'vitals'       => array(
                'bp'          => $row['bp'],
                'height'      => $row['height'],
                'weight'      => $row['weight'],
                'pulse'       => $row['pulse'],
                'temperature' => $row['temperature']
            ),
            'symptoms'     => $row['symptoms'],
            'clinicalNote' => $row['note']
        );
    }

    private function format_physio_encounter($row)
    {
        return array(
            'resourceType' => 'Encounter',
            'id'           => 'PHY-' . $row['id'],
            'type'         => 'Physiotherapy',
            'department'   => 'Physical Therapy & Rehabilitation',
            'date'         => $row['session_date'] ?: $row['created_at'],
            'patient'      => array(
                'id'          => intval($row['patient_id']),
                'name'        => $row['patient_name'],
                'national_id' => $row['national_id'],
                'upi'         => $row['upi']
            ),
            'practitioner' => array(
                'name'        => trim($row['doctor_name'] . ' ' . $row['doctor_surname']),
                'license_no'  => !empty($row['doctor_license']) ? $row['doctor_license'] : 'KMPDC-REG-PHYSIO'
            ),
            'painScore'    => intval($row['pain_level']),
            'painLocation' => $row['pain_location'],
            'sessionDurationMinutes' => intval($row['session_duration']),
            'assessment'   => $row['physiotherapy_assessment'],
            'treatment'    => $row['treatment_exercise']
        );
    }

    private function format_pediatric_encounter($row)
    {
        return array(
            'resourceType' => 'Encounter',
            'id'           => 'PED-' . $row['id'],
            'type'         => 'Pediatric',
            'department'   => 'Pediatrics & Child Health',
            'date'         => $row['created_at'],
            'patient'      => array(
                'id'          => intval($row['patient_id']),
                'name'        => $row['patient_name'],
                'national_id' => $row['national_id'],
                'upi'         => $row['upi']
            ),
            'practitioner' => array(
                'name'        => trim($row['doctor_name'] . ' ' . $row['doctor_surname']),
                'license_no'  => !empty($row['doctor_license']) ? $row['doctor_license'] : 'KMPDC-REG-PED'
            ),
            'vitals'       => array(
                'height'      => $row['height'],
                'weight'      => $row['weight'],
                'temperature' => $row['temperature']
            ),
            'growthMonitoring'    => $row['growth_monitoring'],
            'immunizationDetails' => $row['immunization_details'],
            'diagnosis'           => $row['diagnosis'],
            'prescription'        => $row['prescription_treatment']
        );
    }

    private function format_gynae_encounter($row)
    {
        return array(
            'resourceType' => 'Encounter',
            'id'           => 'GYN-' . $row['id'],
            'type'         => 'Gynaecology',
            'department'   => 'Obstetrics & Gynaecology',
            'date'         => $row['created_at'],
            'patient'      => array(
                'id'          => intval($row['patient_id']),
                'name'        => $row['patient_name'],
                'national_id' => $row['national_id'],
                'upi'         => $row['upi']
            ),
            'practitioner' => array(
                'name'        => trim($row['doctor_name'] . ' ' . $row['doctor_surname']),
                'license_no'  => !empty($row['doctor_license']) ? $row['doctor_license'] : 'KMPDC-REG-GYN'
            ),
            'lmp'              => $row['lmp'],
            'pregnancyStatus'  => $row['pregnancy_status'],
            'pregnancyHistory' => $row['pregnancy_history'],
            'clinicalNotes'    => $row['clinical_notes'],
            'diagnosis'        => $row['diagnosis'],
            'prescription'     => $row['prescription_treatment']
        );
    }
}
