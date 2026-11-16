<?php

defined('BASEPATH') or exit('No direct script access allowed');

/**
 * Kenya National HIE REST API Documentation & OpenAPI Specification Controller
 * Provides interactive Swagger-compliant API explorer and OpenAPI 3.0 specification.
 */
class Docs extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->helper('url');
        $this->load->database();
    }

    /**
     * GET /api/v1/docs or /api/docs
     * Renders the Interactive API Explorer & Tester
     */
    public function index()
    {
        // Retrieve active DHA test token from api_clients
        $dhaClient = $this->db->where('client_identifier', 'dha_conformance_tester')->get('api_clients')->row_array();
        $defaultToken = $dhaClient ? $dhaClient['api_key'] : 'dha_live_test_key_8f3a2b9e4c1d6e7f8a9b0c1d2e3f4a5b';
        
        $setting = $this->db->get('sch_settings')->row_array();
        $kmhflCode = !empty($setting['kmhfl_code']) ? $setting['kmhfl_code'] : '12345';
        $facilityName = !empty($setting['name']) ? $setting['name'] : 'SEFU Health Hospital';

        $data = array(
            'default_token' => $defaultToken,
            'kmhfl_code'    => $kmhflCode,
            'facility_name' => $facilityName,
            'base_api_url'  => base_url('api/v1/'),
            'openapi_url'   => base_url('api/v1/openapi.json')
        );

        $this->load->view('api/docs', $data);
    }

    /**
     * GET /api/v1/openapi.json
     * Outputs standard OpenAPI 3.0 JSON specification
     */
    public function openapi()
    {
        $setting = $this->db->get('sch_settings')->row_array();
        $kmhflCode = !empty($setting['kmhfl_code']) ? $setting['kmhfl_code'] : '12345';
        $facilityName = !empty($setting['name']) ? $setting['name'] : 'SEFU Health Hospital';

        $spec = array(
            'openapi' => '3.0.3',
            'info' => array(
                'title' => 'SEFU HMIS — Kenya National HIE Interoperability REST API',
                'description' => "Standardized HL7 FHIR and JSON REST API gateway supporting Kenya Client Registry (CR / Afya UPI), Master Health Facility List (KMHFL: {$kmhflCode}), Health Worker Registry, Clinical Encounters, and Social Health Authority (SHA) claims.",
                'version' => '1.0.0',
                'contact' => array(
                    'name' => 'SEFU Health Interoperability Team',
                    'email' => 'care@rofam.africa',
                    'url' => 'https://care.rofam.africa'
                ),
                'license' => array(
                    'name' => 'Kenya Digital Health Agency (DHA) Form HMIS 4 Certified',
                    'url' => 'https://dha.go.ke'
                )
            ),
            'servers' => array(
                array(
                    'url' => base_url('api/v1'),
                    'description' => 'Current Instance REST API v1'
                )
            ),
            'security' => array(
                array('BearerAuth' => array()),
                array('ApiKeyAuth' => array())
            ),
            'paths' => array(
                '/facility/info' => array(
                    'get' => array(
                        'summary' => 'Hospital & KMHFL Facility Metadata',
                        'description' => 'Returns hospital master identification, KMHFL code, accreditation status, contact details, and active clinical specialties.',
                        'tags' => array('Facility Registry'),
                        'responses' => array(
                            '200' => array('description' => 'Facility metadata returned successfully')
                        )
                    )
                ),
                '/patients/search' => array(
                    'get' => array(
                        'summary' => 'Kenya Client Registry (CR) Patient Search',
                        'description' => 'Searches registered patients by Unique Patient Identifier (UPI / Afya ID), National ID, phone number, or patient name conforming to FHIR Patient resource format.',
                        'tags' => array('Client Registry (CR)'),
                        'parameters' => array(
                            array('name' => 'upi', 'in' => 'query', 'description' => 'Kenya Unique Patient Identifier (e.g. AFYA-KE-2026-000010)', 'schema' => array('type' => 'string')),
                            array('name' => 'national_id', 'in' => 'query', 'description' => 'Kenya National Identity Number (7-8 digits)', 'schema' => array('type' => 'string')),
                            array('name' => 'phone', 'in' => 'query', 'description' => 'Phone number (+254...)', 'schema' => array('type' => 'string')),
                            array('name' => 'name', 'in' => 'query', 'description' => 'Patient name query', 'schema' => array('type' => 'string')),
                            array('name' => 'limit', 'in' => 'query', 'description' => 'Max records (default 20)', 'schema' => array('type' => 'integer'))
                        ),
                        'responses' => array(
                            '200' => array('description' => 'Matching patient profiles returned in FHIR format'),
                            '401' => array('description' => 'Unauthorized - Invalid or missing API token')
                        )
                    )
                ),
                '/patients/detail/{id}' => array(
                    'get' => array(
                        'summary' => 'Retrieve Patient Demographics',
                        'description' => 'Fetches a single patient profile by internal ID, Afya UPI, or National ID.',
                        'tags' => array('Client Registry (CR)'),
                        'parameters' => array(
                            array('name' => 'id', 'in' => 'path', 'required' => true, 'description' => 'Patient internal ID, UPI, or National ID', 'schema' => array('type' => 'string'))
                        ),
                        'responses' => array(
                            '200' => array('description' => 'Patient detail returned'),
                            '404' => array('description' => 'Patient not found')
                        )
                    )
                ),
                '/patients/create' => array(
                    'post' => array(
                        'summary' => 'Register New Patient (Duplicate Guard Enforced)',
                        'description' => 'Registers a new patient with Kenya Afya UPI generation and duplicate prevention on National ID.',
                        'tags' => array('Client Registry (CR)'),
                        'requestBody' => array(
                            'required' => true,
                            'content' => array(
                                'application/json' => array(
                                    'schema' => array(
                                        'type' => 'object',
                                        'required' => array('patient_name', 'gender'),
                                        'properties' => array(
                                            'patient_name' => array('type' => 'string', 'example' => 'Amina Wanjiku Mohamed'),
                                            'gender' => array('type' => 'string', 'example' => 'Female'),
                                            'dob' => array('type' => 'string', 'format' => 'date', 'example' => '1994-08-15'),
                                            'mobileno' => array('type' => 'string', 'example' => '+254712345678'),
                                            'national_id' => array('type' => 'string', 'example' => '33445566'),
                                            'upi' => array('type' => 'string', 'example' => 'AFYA-KE-2026-000050'),
                                            'address' => array('type' => 'string', 'example' => 'Nairobi, Kenya'),
                                            'blood_group' => array('type' => 'string', 'example' => 'O+'),
                                            'insurance_id' => array('type' => 'string', 'example' => 'SHA-POL-9988')
                                        )
                                    )
                                )
                            )
                        ),
                        'responses' => array(
                            '201' => array('description' => 'Patient successfully created'),
                            '409' => array('description' => 'Duplicate patient detected with National ID or UPI'),
                            '422' => array('description' => 'Validation error')
                        )
                    )
                ),
                '/encounters/search' => array(
                    'get' => array(
                        'summary' => 'Clinical Encounters & Consultations Query',
                        'description' => 'Queries clinical encounters across OPD, IPD, Physiotherapy, Pediatrics, and Gynaecology including vitals, attending practitioner license, and ICD-10 diagnosis.',
                        'tags' => array('Clinical Encounters'),
                        'parameters' => array(
                            array('name' => 'upi', 'in' => 'query', 'description' => 'Filter by Patient UPI (Afya ID)', 'schema' => array('type' => 'string')),
                            array('name' => 'national_id', 'in' => 'query', 'description' => 'Filter by National ID', 'schema' => array('type' => 'string')),
                            array('name' => 'type', 'in' => 'query', 'description' => 'Encounter type: OPD, IPD, PHYSIOTHERAPY, PEDIATRIC, GYNAECOLOGY', 'schema' => array('type' => 'string')),
                            array('name' => 'limit', 'in' => 'query', 'schema' => array('type' => 'integer'))
                        ),
                        'responses' => array(
                            '200' => array('description' => 'Encounters list returned in FHIR Encounter format')
                        )
                    )
                ),
                '/encounters/create' => array(
                    'post' => array(
                        'summary' => 'Ingest Clinical Encounter & Vitals',
                        'description' => 'Records a new outpatient encounter or clinical visit with vital signs and diagnostic notes.',
                        'tags' => array('Clinical Encounters'),
                        'requestBody' => array(
                            'required' => true,
                            'content' => array(
                                'application/json' => array(
                                    'schema' => array(
                                        'type' => 'object',
                                        'required' => array('patient_id'),
                                        'properties' => array(
                                            'patient_id' => array('type' => 'integer', 'example' => 10),
                                            'doctor_id' => array('type' => 'integer', 'example' => 2),
                                            'encounter_date' => array('type' => 'string', 'format' => 'date-time', 'example' => '2026-11-16 10:00:00'),
                                            'symptoms' => array('type' => 'string', 'example' => 'High fever, rigors, joint pain for 3 days'),
                                            'bp' => array('type' => 'string', 'example' => '120/80'),
                                            'height' => array('type' => 'string', 'example' => '170'),
                                            'weight' => array('type' => 'string', 'example' => '68'),
                                            'pulse' => array('type' => 'string', 'example' => '82'),
                                            'temperature' => array('type' => 'string', 'example' => '38.6'),
                                            'notes' => array('type' => 'string', 'example' => 'Artemether/Lumefantrine Coartem prescribed')
                                        )
                                    )
                                )
                            )
                        ),
                        'responses' => array(
                            '201' => array('description' => 'Encounter recorded successfully')
                        )
                    )
                ),
                '/billing/patient/{id}' => array(
                    'get' => array(
                        'summary' => 'Itemized Billing & SHA Claim Ledger',
                        'description' => 'Queries complete patient billing history across pharmacy, laboratory, radiology, consultations, and specialty modules with Social Health Authority (SHA) claim eligibility.',
                        'tags' => array('Billing & SHA Claims'),
                        'parameters' => array(
                            array('name' => 'id', 'in' => 'path', 'required' => true, 'description' => 'Patient internal ID, UPI, or National ID', 'schema' => array('type' => 'string'))
                        ),
                        'responses' => array(
                            '200' => array('description' => 'Claim ledger and itemized bill lines returned')
                        )
                    )
                ),
                '/terminology/icd10' => array(
                    'get' => array(
                        'summary' => 'WHO & Kenya MOH ICD-10 Diagnosis Search',
                        'description' => 'Search standardized diagnostic codes, Kenya MOH 705/706 indicators, and notifiable disease surveillance markers.',
                        'tags' => array('National Terminology (ICD-10)'),
                        'parameters' => array(
                            array('name' => 'search', 'in' => 'query', 'description' => 'Keyword search (e.g. malaria, pneumonia, hypertension)', 'schema' => array('type' => 'string')),
                            array('name' => 'code', 'in' => 'query', 'description' => 'ICD-10 code prefix (e.g. B50, J18, I10)', 'schema' => array('type' => 'string')),
                            array('name' => 'notifiable', 'in' => 'query', 'description' => 'Filter by notifiable status (1 or 0)', 'schema' => array('type' => 'integer'))
                        ),
                        'responses' => array(
                            '200' => array('description' => 'Matching ICD-10 diagnostic codes returned')
                        )
                    )
                )
            ),
            'components' => array(
                'securitySchemes' => array(
                    'BearerAuth' => array(
                        'type' => 'http',
                        'scheme' => 'bearer',
                        'description' => 'Pass API Token via Authorization: Bearer <TOKEN>'
                    ),
                    'ApiKeyAuth' => array(
                        'type' => 'apiKey',
                        'in' => 'header',
                        'name' => 'X-API-KEY',
                        'description' => 'Pass API Token via X-API-KEY header'
                    )
                )
            )
        );

        $this->output
            ->set_content_type('application/json', 'utf-8')
            ->set_output(json_encode($spec, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
    }
}
