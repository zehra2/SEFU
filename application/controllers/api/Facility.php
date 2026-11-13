<?php

defined('BASEPATH') or exit('No direct script access allowed');

/**
 * Kenya HIE Facility Info API Controller
 * Provides hospital KMHFL registry metadata, contact points, and active specialties.
 */
class Facility extends API_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * GET /api/v1/facility/info
     */
    public function info()
    {
        $setting = $this->db->get('sch_settings')->row_array();

        $data = array(
            'facility_name' => !empty($setting['name']) ? $setting['name'] : 'SEFU Health Hospital',
            'kmhfl_code' => !empty($setting['kmhfl_code']) ? $setting['kmhfl_code'] : '12345',
            'facility_level' => 'Level 4 / Level 5 Hospital',
            'system_name' => 'SEFU Health Management Information System (HMIS)',
            'system_version' => '5.0',
            'regulatory_compliance' => 'Kenya Digital Health Agency (DHA) Form HMIS 4 Certified',
            'data_protection_status' => 'ODPC Kenya Compliant (DPA 2019)',
            'currency' => !empty($setting['currency']) ? $setting['currency'] : 'KES',
            'timezone' => !empty($setting['timezone']) ? $setting['timezone'] : 'Africa/Nairobi',
            'contact' => array(
                'email' => !empty($setting['email']) ? $setting['email'] : 'care@rofam.africa',
                'phone' => !empty($setting['phone']) ? $setting['phone'] : '+254-700-000000',
                'address' => !empty($setting['address']) ? $setting['address'] : 'Nairobi, Kenya'
            ),
            'interoperability_capabilities' => array(
                'rest_api_version' => 'v1',
                'client_registry_upi' => true,
                'kmhfl_registry' => true,
                'sha_claims_format' => 'JSON / FHIR Claim compliant',
                'icd10_diagnosis_coding' => true,
                'supported_modules' => array(
                    'OPD' => 'Outpatient Department',
                    'IPD' => 'Inpatient Department',
                    'Emergency' => 'Emergency & Casualty',
                    'Physiotherapy' => 'Physical Therapy & Rehabilitation',
                    'Pediatric' => 'Pediatrics & Child Health',
                    'Gynaecology' => 'Obstetrics & Gynaecology',
                    'Pathology' => 'Laboratory Diagnostics',
                    'Radiology' => 'Medical Imaging',
                    'Pharmacy' => 'Pharmaceutical Dispensing & Stock',
                    'Billing' => 'Itemized Billing & Insurance / SHA'
                )
            )
        );

        $this->log_api_audit('FACILITY_INFO_QUERY');
        $this->response_json($data, 200);
    }
}
