<?php

defined('BASEPATH') or exit('No direct script access allowed');

/**
 * Kenya National Health Terminology & ICD-10 Registry REST API Controller
 * Provides standardized diagnostic coding lookups aligned with WHO ICD-10,
 * Kenya Ministry of Health surveillance indicators (MOH 705A/B, MOH 706),
 * and notifiable disease alerts.
 */
class Terminology extends API_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * GET /api/v1/terminology/icd10
     * Query parameters: q / search, code, category, notifiable, limit
     */
    public function icd10()
    {
        $search     = trim($this->input->get('q', TRUE) ?: $this->input->get('search', TRUE));
        $code       = trim($this->input->get('code', TRUE));
        $category   = trim($this->input->get('category', TRUE));
        $notifiable = $this->input->get('notifiable', TRUE);
        $limit      = min(100, max(1, intval($this->input->get('limit', TRUE)) ?: 50));

        $this->db->from('icd10_codes');
        $this->db->where('is_active', 1);

        if (!empty($code)) {
            $this->db->like('code', $code, 'after');
        }
        if (!empty($search)) {
            $this->db->group_start()
                     ->like('description', $search)
                     ->or_like('code', $search)
                     ->group_end();
        }
        if (!empty($category)) {
            $this->db->like('category', $category);
        }
        if ($notifiable !== null && $notifiable !== '') {
            $this->db->where('is_notifiable', intval($notifiable));
        }

        $this->db->order_by('code', 'ASC')->limit($limit);
        $records = $this->db->get()->result_array();

        $formatted = array();
        foreach ($records as $r) {
            $formatted[] = array(
                'code'          => $r['code'],
                'description'   => $r['description'],
                'category'      => $r['category'],
                'system'        => 'http://hl7.org/fhir/sid/icd-10',
                'moh_indicator' => $r['moh_indicator'],
                'is_notifiable' => (bool)$r['is_notifiable']
            );
        }

        $this->log_api_audit('TERMINOLOGY_ICD10_QUERY');

        $this->response_json(array(
            'total_matches' => count($formatted),
            'terminology'   => 'WHO ICD-10 / Kenya MOH HMIS Registry',
            'codes'         => $formatted
        ), 200);
    }
}
