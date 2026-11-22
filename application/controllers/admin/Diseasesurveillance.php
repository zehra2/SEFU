<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Diseasesurveillance extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('disease_surveillance_model');
        $this->load->library('customlib');
        $this->config->load('image_valid');
    }

    /**
     * Kenya MOH 705A/B & IDSR Disease Surveillance Dashboard
     */
    public function index()
    {
        $this->session->set_userdata('top_menu', 'Reports');
        $this->session->set_userdata('sub_menu', 'reports/diseasesurveillance');
        $this->session->set_userdata('subsub_menu', '');

        $search_type = $this->input->post('search_type');
        if (empty($search_type)) {
            $search_type = $this->input->get('search_type');
        }
        if (empty($search_type)) {
            $search_type = 'this_month';
        }

        $from_date = null;
        $to_date = null;

        if ($search_type === 'all_time') {
            $from_date = null;
            $to_date = null;
        } else if ($search_type === 'period') {
            $date_from_raw = $this->input->post('date_from') ?: $this->input->get('date_from');
            $date_to_raw   = $this->input->post('date_to') ?: $this->input->get('date_to');

            if (!empty($date_from_raw) && !empty($date_to_raw)) {
                $from_date = date('Y-m-d', $this->customlib->datetostrtotime($date_from_raw));
                $to_date   = date('Y-m-d', $this->customlib->datetostrtotime($date_to_raw));
            } else {
                $dates = $this->customlib->get_betweendate('this_month');
                $from_date = $dates['from_date'];
                $to_date   = $dates['to_date'];
            }
        } else {
            $dates = $this->customlib->get_betweendate($search_type);
            $from_date = isset($dates['from_date']) ? $dates['from_date'] : null;
            $to_date   = isset($dates['to_date']) ? $dates['to_date'] : null;
        }

        $data['searchlist']   = $this->customlib->get_searchtype();
        // Add 'All Time' option if not present
        if (!isset($data['searchlist']['all_time'])) {
            $data['searchlist']['all_time'] = 'All Time';
        }

        $data['search_type']  = $search_type;
        $data['from_date']    = $from_date;
        $data['to_date']      = $to_date;

        // Fetch Surveillance Data
        $data['kpis']         = $this->disease_surveillance_model->get_kpis($from_date, $to_date);
        $data['moh705a']      = $this->disease_surveillance_model->get_moh705a($from_date, $to_date);
        $data['moh705b']      = $this->disease_surveillance_model->get_moh705b($from_date, $to_date);
        $data['idsr']         = $this->disease_surveillance_model->get_idsr_alerts($from_date, $to_date);

        $this->load->view('layout/header');
        $this->load->view('admin/report/diseasesurveillance', $data);
        $this->load->view('layout/footer');
    }

    /**
     * Statutory CSV Export for Kenya MOH Reporting
     */
    public function export($type = 'moh705a')
    {
        $search_type = $this->input->get('search_type') ?: 'all_time';
        $from_date = null;
        $to_date = null;

        if ($search_type !== 'all_time') {
            $dates = $this->customlib->get_betweendate($search_type);
            $from_date = isset($dates['from_date']) ? $dates['from_date'] : null;
            $to_date   = isset($dates['to_date']) ? $dates['to_date'] : null;
        }

        $kpis = $this->disease_surveillance_model->get_kpis($from_date, $to_date);
        $filename = "Kenya_MOH_" . strtoupper($type) . "_" . date('Ymd_His') . ".csv";

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename=' . $filename);

        $output = fopen('php://output', 'w');

        // Statutory Kenya Ministry of Health Header
        fputcsv($output, ['REPUBLIC OF KENYA - MINISTRY OF HEALTH']);
        fputcsv($output, ['HEALTH INFORMATION SYSTEM - STATUTORY REPORTING']);
        fputcsv($output, ['Facility Name:', $kpis['facility_name'], 'KMHFL Facility Code:', $kpis['kmhfl_code']]);
        fputcsv($output, ['Reporting Period:', ($from_date ? "$from_date to $to_date" : "All Time Records")]);
        fputcsv($output, ['Generated Date:', date('Y-m-d H:i:s')]);
        fputcsv($output, []); // Blank separator line

        if ($type === 'moh705a') {
            fputcsv($output, ['FORM MOH 705A: OUTPATIENT SUMMARY FOR UNDER 5 YEARS (CHILDREN)']);
            fputcsv($output, ['ICD-10 Code', 'Disease / Condition Name', 'Clinical Category', 'Male (<5 yrs)', 'Female (<5 yrs)', 'Total Cases', 'Morbidity %', 'IDSR Notifiable']);

            $data = $this->disease_surveillance_model->get_moh705a($from_date, $to_date);
            foreach ($data['records'] as $r) {
                fputcsv($output, [
                    $r['icd10_code'],
                    $r['disease_name'],
                    $r['category'],
                    $r['male_count'],
                    $r['female_count'],
                    $r['total_cases'],
                    $r['morbidity_percent'] . '%',
                    $r['is_notifiable'] ? 'YES' : 'NO'
                ]);
            }
            fputcsv($output, ['TOTAL', '', '', '', '', $data['total_cases'], '100%', '']);

        } else if ($type === 'moh705b') {
            fputcsv($output, ['FORM MOH 705B: OUTPATIENT SUMMARY FOR OVER 5 YEARS (ADULTS & OLDER CHILDREN)']);
            fputcsv($output, ['ICD-10 Code', 'Disease / Condition Name', 'Clinical Category', 'Male (>=5 yrs)', 'Female (>=5 yrs)', 'Total Cases', 'Morbidity %', 'IDSR Notifiable']);

            $data = $this->disease_surveillance_model->get_moh705b($from_date, $to_date);
            foreach ($data['records'] as $r) {
                fputcsv($output, [
                    $r['icd10_code'],
                    $r['disease_name'],
                    $r['category'],
                    $r['male_count'],
                    $r['female_count'],
                    $r['total_cases'],
                    $r['morbidity_percent'] . '%',
                    $r['is_notifiable'] ? 'YES' : 'NO'
                ]);
            }
            fputcsv($output, ['TOTAL', '', '', '', '', $data['total_cases'], '100%', '']);

        } else if ($type === 'idsr') {
            fputcsv($output, ['INTEGRATED DISEASE SURVEILLANCE & RESPONSE (IDSR) - NOTIFIABLE EPIDEMIC ALERTS']);
            fputcsv($output, ['Alert Level', 'ICD-10 Code', 'Disease Condition', 'Clinical Category', 'Incident Cases', 'Epidemic Threshold', 'Mandated Statutory Action']);

            $data = $this->disease_surveillance_model->get_idsr_alerts($from_date, $to_date);
            foreach ($data['alerts'] as $a) {
                fputcsv($output, [
                    $a['severity'],
                    $a['icd10_code'],
                    $a['disease_name'],
                    $a['category'],
                    $a['case_count'],
                    $a['threshold_text'],
                    $a['action_required']
                ]);
            }
        }

        fclose($output);
        exit;
    }
}
