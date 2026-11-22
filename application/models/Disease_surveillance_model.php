<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

/**
 * Disease Surveillance & Kenya MOH 705/IDSR Aggregator Model
 * Conforms to Kenya Digital Health Agency (DHA) & Ministry of Health Guidelines:
 * - MOH 705A: Outpatient Summary for Under 5 Years
 * - MOH 705B: Outpatient Summary for Over 5 Years
 * - IDSR: Integrated Disease Surveillance & Response Epidemic Alert Engine
 */
class Disease_surveillance_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
    }

    /**
     * Builds the unified encounter query across OPD, IPD, and Specialty Clinics
     */
    private function _build_encounter_subquery($from_date = null, $to_date = null)
    {
        $date_filter_opd = "";
        $date_filter_ipd = "";
        $date_filter_ped = "";
        $date_filter_gyn = "";
        $date_filter_phy = "";

        if (!empty($from_date) && !empty($to_date)) {
            $from = $this->db->escape($from_date . ' 00:00:00');
            $to   = $this->db->escape($to_date . ' 23:59:59');

            $date_filter_opd = "AND v.appointment_date >= $from AND v.appointment_date <= $to";
            $date_filter_ipd = "AND i.date >= $from AND i.date <= $to";
            $date_filter_ped = "AND pd.consultation_date >= $from AND pd.consultation_date <= $to";
            $date_filter_gyn = "AND g.consultation_date >= $from AND g.consultation_date <= $to";
            $date_filter_phy = "AND pt.session_date >= $from AND pt.session_date <= $to";
        }

        $sql = "
        SELECT 
            'OPD' AS encounter_type,
            v.id AS encounter_id,
            v.appointment_date AS encounter_date,
            p.id AS patient_id,
            p.patient_name,
            p.gender,
            p.dob,
            p.mobileno,
            p.address,
            TIMESTAMPDIFF(YEAR, p.dob, v.appointment_date) AS age_years,
            v.icd10_code,
            c.description AS diagnosis_description,
            c.category AS diagnosis_category,
            c.moh_indicator,
            c.is_notifiable,
            v.symptoms AS clinical_notes
        FROM visit_details v
        JOIN opd_details o ON o.id = v.opd_details_id
        JOIN patients p ON p.id = o.patient_id
        LEFT JOIN icd10_codes c ON c.code = v.icd10_code
        WHERE v.icd10_code IS NOT NULL AND v.icd10_code != '' $date_filter_opd

        UNION ALL

        SELECT 
            'IPD' AS encounter_type,
            i.id AS encounter_id,
            i.date AS encounter_date,
            p.id AS patient_id,
            p.patient_name,
            p.gender,
            p.dob,
            p.mobileno,
            p.address,
            TIMESTAMPDIFF(YEAR, p.dob, i.date) AS age_years,
            i.icd10_code,
            c.description AS diagnosis_description,
            c.category AS diagnosis_category,
            c.moh_indicator,
            c.is_notifiable,
            i.symptoms AS clinical_notes
        FROM ipd_details i
        JOIN patients p ON p.id = i.patient_id
        LEFT JOIN icd10_codes c ON c.code = i.icd10_code
        WHERE i.icd10_code IS NOT NULL AND i.icd10_code != '' $date_filter_ipd

        UNION ALL

        SELECT 
            'Pediatric' AS encounter_type,
            pd.id AS encounter_id,
            pd.consultation_date AS encounter_date,
            p.id AS patient_id,
            p.patient_name,
            p.gender,
            p.dob,
            p.mobileno,
            p.address,
            TIMESTAMPDIFF(YEAR, p.dob, pd.consultation_date) AS age_years,
            pd.icd10_code,
            c.description AS diagnosis_description,
            c.category AS diagnosis_category,
            c.moh_indicator,
            c.is_notifiable,
            pd.diagnosis AS clinical_notes
        FROM pediatric pd
        JOIN patients p ON p.id = pd.patient_id
        LEFT JOIN icd10_codes c ON c.code = pd.icd10_code
        WHERE pd.icd10_code IS NOT NULL AND pd.icd10_code != '' $date_filter_ped

        UNION ALL

        SELECT 
            'Gynaecology' AS encounter_type,
            g.id AS encounter_id,
            g.consultation_date AS encounter_date,
            p.id AS patient_id,
            p.patient_name,
            p.gender,
            p.dob,
            p.mobileno,
            p.address,
            TIMESTAMPDIFF(YEAR, p.dob, g.consultation_date) AS age_years,
            g.icd10_code,
            c.description AS diagnosis_description,
            c.category AS diagnosis_category,
            c.moh_indicator,
            c.is_notifiable,
            g.diagnosis AS clinical_notes
        FROM gynaecology g
        JOIN patients p ON p.id = g.patient_id
        LEFT JOIN icd10_codes c ON c.code = g.icd10_code
        WHERE g.icd10_code IS NOT NULL AND g.icd10_code != '' $date_filter_gyn

        UNION ALL

        SELECT 
            'Physiotherapy' AS encounter_type,
            pt.id AS encounter_id,
            pt.session_date AS encounter_date,
            p.id AS patient_id,
            p.patient_name,
            p.gender,
            p.dob,
            p.mobileno,
            p.address,
            TIMESTAMPDIFF(YEAR, p.dob, pt.session_date) AS age_years,
            pt.icd10_code,
            c.description AS diagnosis_description,
            c.category AS diagnosis_category,
            c.moh_indicator,
            c.is_notifiable,
            pt.diagnosis AS clinical_notes
        FROM physiotherapy pt
        JOIN patients p ON p.id = pt.patient_id
        LEFT JOIN icd10_codes c ON c.code = pt.icd10_code
        WHERE pt.icd10_code IS NOT NULL AND pt.icd10_code != '' $date_filter_phy
        ";

        return $sql;
    }

    /**
     * MOH 705A: Under 5 Years Outpatient Morbidity Summary
     */
    public function get_moh705a($from_date = null, $to_date = null)
    {
        $sub = $this->_build_encounter_subquery($from_date, $to_date);

        $sql = "
        SELECT 
            e.icd10_code,
            COALESCE(e.diagnosis_description, 'Other Unspecified Condition') AS disease_name,
            COALESCE(e.diagnosis_category, 'General') AS category,
            e.is_notifiable,
            SUM(CASE WHEN LOWER(e.gender) = 'male' THEN 1 ELSE 0 END) AS male_count,
            SUM(CASE WHEN LOWER(e.gender) = 'female' THEN 1 ELSE 0 END) AS female_count,
            COUNT(*) AS total_cases
        FROM ($sub) e
        WHERE e.age_years < 5
        GROUP BY e.icd10_code, e.diagnosis_description, e.diagnosis_category, e.is_notifiable
        ORDER BY total_cases DESC, e.icd10_code ASC
        ";

        $query = $this->db->query($sql);
        $results = $query->result_array();

        // Calculate total cases for morbidity %
        $grand_total = 0;
        foreach ($results as $r) {
            $grand_total += (int)$r['total_cases'];
        }

        foreach ($results as &$r) {
            $r['morbidity_percent'] = $grand_total > 0 ? round(($r['total_cases'] / $grand_total) * 100, 1) : 0;
        }

        return [
            'records' => $results,
            'total_cases' => $grand_total,
            'total_diseases' => count($results)
        ];
    }

    /**
     * MOH 705B: Over 5 Years Outpatient Morbidity Summary
     */
    public function get_moh705b($from_date = null, $to_date = null)
    {
        $sub = $this->_build_encounter_subquery($from_date, $to_date);

        $sql = "
        SELECT 
            e.icd10_code,
            COALESCE(e.diagnosis_description, 'Other Unspecified Condition') AS disease_name,
            COALESCE(e.diagnosis_category, 'General') AS category,
            e.is_notifiable,
            SUM(CASE WHEN LOWER(e.gender) = 'male' THEN 1 ELSE 0 END) AS male_count,
            SUM(CASE WHEN LOWER(e.gender) = 'female' THEN 1 ELSE 0 END) AS female_count,
            COUNT(*) AS total_cases
        FROM ($sub) e
        WHERE e.age_years >= 5
        GROUP BY e.icd10_code, e.diagnosis_description, e.diagnosis_category, e.is_notifiable
        ORDER BY total_cases DESC, e.icd10_code ASC
        ";

        $query = $this->db->query($sql);
        $results = $query->result_array();

        $grand_total = 0;
        foreach ($results as $r) {
            $grand_total += (int)$r['total_cases'];
        }

        foreach ($results as &$r) {
            $r['morbidity_percent'] = $grand_total > 0 ? round(($r['total_cases'] / $grand_total) * 100, 1) : 0;
        }

        return [
            'records' => $results,
            'total_cases' => $grand_total,
            'total_diseases' => count($results)
        ];
    }

    /**
     * IDSR (Integrated Disease Surveillance & Response) Immediate Epidemic Alert Aggregator
     */
    public function get_idsr_alerts($from_date = null, $to_date = null)
    {
        $sub = $this->_build_encounter_subquery($from_date, $to_date);

        // Fetch all encounters flagged as notifiable or matching epidemic surveillance indicators
        $sql = "
        SELECT 
            e.*
        FROM ($sub) e
        WHERE e.is_notifiable = 1 
           OR e.icd10_code LIKE 'A00%' 
           OR e.icd10_code LIKE 'B05%' 
           OR e.icd10_code LIKE 'A01%' 
           OR e.icd10_code LIKE 'B50%' 
           OR e.icd10_code LIKE 'A15%' 
           OR e.icd10_code LIKE 'A22%' 
           OR e.icd10_code LIKE 'A39%'
        ORDER BY e.encounter_date DESC
        ";

        $query = $this->db->query($sql);
        $cases = $query->result_array();

        // Group into alert packages with statutory thresholds
        $grouped = [];
        foreach ($cases as $c) {
            $code = $c['icd10_code'];
            if (!isset($grouped[$code])) {
                // Determine severity and threshold
                $severity = 'WARNING';
                $threshold_text = 'Weekly Epidemic Monitoring Threshold';
                $action = 'Report to Sub-County Disease Surveillance Officer (SC-DSO) via IDSR Weekly Aggregate (MOH 505).';

                if (strpos($code, 'A00') === 0) { // Cholera
                    $severity = 'CRITICAL';
                    $threshold_text = 'Immediate Outbreak Alert (Threshold: >= 1 Case)';
                    $action = 'IMMEDIATE (Within 24 Hours): Send IDSR Form 002 to SC-DSO, isolate patient, initiate cholera treatment protocol.';
                } else if (strpos($code, 'B05') === 0) { // Measles
                    $severity = 'CRITICAL';
                    $threshold_text = 'Immediate Outbreak Alert (Threshold: >= 1 Case)';
                    $action = 'IMMEDIATE (Within 24 Hours): Isolate patient, collect serum/throat swab for lab confirmation, alert DSO.';
                } else if (strpos($code, 'A22') === 0) { // Anthrax
                    $severity = 'CRITICAL';
                    $threshold_text = 'Zoonotic Epidemic Alert (Threshold: >= 1 Case)';
                    $action = 'Notify veterinary & public health authorities immediately. Initiate contact tracing.';
                } else if (strpos($code, 'A39') === 0) { // Meningitis
                    $severity = 'CRITICAL';
                    $threshold_text = 'Epidemic Prone Threshold (>= 1 Case)';
                    $action = 'Lumbar puncture confirmation, chemoprophylaxis for close contacts, daily surveillance.';
                } else if (strpos($code, 'B50') === 0) { // Severe Malaria
                    $severity = 'WARNING';
                    $threshold_text = 'Malaria Surveillance Threshold';
                    $action = 'Review weekly malaria incidence against facility epidemic threshold channel. Ensure Artemisinin stocks.';
                } else if (strpos($code, 'A01') === 0) { // Typhoid
                    $severity = 'WARNING';
                    $threshold_text = 'Waterborne Disease Watch';
                    $action = 'Notify public health team for water source testing and sanitation inspection.';
                }

                $grouped[$code] = [
                    'icd10_code' => $code,
                    'disease_name' => $c['diagnosis_description'],
                    'category' => $c['diagnosis_category'],
                    'severity' => $severity,
                    'threshold_text' => $threshold_text,
                    'action_required' => $action,
                    'case_count' => 0,
                    'cases' => []
                ];
            }

            $grouped[$code]['case_count']++;
            $grouped[$code]['cases'][] = $c;
        }

        // Sort: CRITICAL first, then WARNING, then by case count DESC
        usort($grouped, function($a, $b) {
            if ($a['severity'] === 'CRITICAL' && $b['severity'] !== 'CRITICAL') return -1;
            if ($a['severity'] !== 'CRITICAL' && $b['severity'] === 'CRITICAL') return 1;
            return $b['case_count'] - $a['case_count'];
        });

        return [
            'alerts' => array_values($grouped),
            'total_notifiable_cases' => count($cases),
            'total_active_alerts' => count($grouped)
        ];
    }

    /**
     * Overall KPIs for Disease Surveillance Hub
     */
    public function get_kpis($from_date = null, $to_date = null)
    {
        $u5 = $this->get_moh705a($from_date, $to_date);
        $o5 = $this->get_moh705b($from_date, $to_date);
        $idsr = $this->get_idsr_alerts($from_date, $to_date);

        // Facility details from sch_settings
        $setting = $this->db->select('name, kmhfl_code, phone, email, address')->get('sch_settings')->row_array();

        // Count total encounters in system for coding rate
        $total_opd = $this->db->count_all('visit_details');
        $total_ipd = $this->db->count_all('ipd_details');
        $total_ped = $this->db->count_all('pediatric');
        $total_gyn = $this->db->count_all('gynaecology');
        $total_phy = $this->db->count_all('physiotherapy');
        $all_encounters = $total_opd + $total_ipd + $total_ped + $total_gyn + $total_phy;

        $coded_encounters = $u5['total_cases'] + $o5['total_cases'];
        $coding_rate = $all_encounters > 0 ? round(($coded_encounters / $all_encounters) * 100, 1) : 100;

        return [
            'facility_name' => !empty($setting['name']) ? $setting['name'] : 'SEFU Health Hospital',
            'kmhfl_code' => !empty($setting['kmhfl_code']) ? $setting['kmhfl_code'] : 'MFL-28491',
            'facility_phone' => !empty($setting['phone']) ? $setting['phone'] : '+254 700 000000',
            'facility_email' => !empty($setting['email']) ? $setting['email'] : 'info@sefu.health',
            'facility_address' => !empty($setting['address']) ? $setting['address'] : 'Nairobi, Kenya',
            'u5_total_cases' => $u5['total_cases'],
            'o5_total_cases' => $o5['total_cases'],
            'total_morbidity_cases' => $coded_encounters,
            'active_idsr_alerts' => $idsr['total_active_alerts'],
            'notifiable_cases' => $idsr['total_notifiable_cases'],
            'icd10_coding_rate' => $coding_rate
        ];
    }
}
