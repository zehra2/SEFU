<?php

defined('BASEPATH') or exit('No direct script access allowed');

/**
 * Kenya HIE Patient REST API Controller
 * Provides standardized Patient Search, Retrieval, and Registration compliant with 
 * Kenya Client Registry (CR), Unique Patient Identifier (UPI/Afya ID), and National ID.
 */
class Patients extends API_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('patient_model');
    }

    /**
     * GET /api/v1/patients/search or /api/v1/patients
     */
    public function index()
    {
        $this->search();
    }

    /**
     * GET /api/v1/patients/search
     * Query parameters: upi, national_id, phone, name, id, page, limit
     */
    public function search()
    {
        $upi         = trim($this->input->get('upi', TRUE));
        $national_id = trim($this->input->get('national_id', TRUE));
        $phone       = trim($this->input->get('phone', TRUE));
        $name        = trim($this->input->get('name', TRUE));
        $id          = trim($this->input->get('id', TRUE));
        $page        = max(1, intval($this->input->get('page', TRUE)));
        $limit       = min(100, max(1, intval($this->input->get('limit', TRUE)) ?: 20));
        $offset      = ($page - 1) * $limit;

        $this->db->from('patients');

        if (!empty($upi)) {
            $this->db->where('upi', $upi);
        }
        if (!empty($national_id)) {
            $this->db->group_start()
                     ->where('national_id', $national_id)
                     ->or_where('identification_number', $national_id)
                     ->group_end();
        }
        if (!empty($phone)) {
            $this->db->like('mobileno', $phone);
        }
        if (!empty($name)) {
            $this->db->like('patient_name', $name);
        }
        if (!empty($id)) {
            $this->db->where('id', intval($id));
        }

        // Count total matching
        $count_db = clone $this->db;
        $total_count = $count_db->count_all_results();

        // Fetch paginated results
        $this->db->order_by('id', 'DESC')->limit($limit, $offset);
        $records = $this->db->get()->result_array();

        $fhir_patients = array();
        foreach ($records as $row) {
            $fhir_patients[] = $this->format_patient_resource($row);
        }

        $this->log_api_audit('PATIENT_SEARCH_QUERY');

        $this->response_json(array(
            'total_matches' => $total_count,
            'page'          => $page,
            'limit'         => $limit,
            'patients'      => $fhir_patients
        ), 200);
    }

    /**
     * GET /api/v1/patients/detail/$id or /api/v1/patients/$id
     */
    public function detail($id = null)
    {
        if (empty($id)) {
            $this->error_json("Missing patient identifier parameter.", 400);
        }

        // Lookup by ID, UPI, or National ID
        $this->db->from('patients');
        if (is_numeric($id)) {
            $this->db->group_start()
                     ->where('id', intval($id))
                     ->or_where('national_id', $id)
                     ->or_where('upi', $id)
                     ->group_end();
        } else {
            $this->db->group_start()
                     ->where('upi', $id)
                     ->or_where('national_id', $id)
                     ->or_where('identification_number', $id)
                     ->group_end();
        }

        $patient = $this->db->get()->row_array();

        if (!$patient) {
            $this->error_json("Patient not found matching identifier: " . htmlspecialchars($id), 404);
        }

        $this->log_api_audit('PATIENT_RECORD_VIEW', $patient['id']);
        $this->response_json($this->format_patient_resource($patient), 200);
    }

    /**
     * POST /api/v1/patients/create or /api/v1/patients
     */
    public function create()
    {
        $input = $this->get_json_input();

        // Validation
        if (empty($input['patient_name'])) {
            $this->error_json("Validation failed. 'patient_name' is a mandatory field.", 422, array('patient_name' => 'Name is required'));
        }
        if (empty($input['gender'])) {
            $this->error_json("Validation failed. 'gender' is a mandatory field (Male, Female, Other).", 422, array('gender' => 'Gender is required'));
        }

        $national_id = !empty($input['national_id']) ? trim($input['national_id']) : null;
        $upi         = !empty($input['upi']) ? trim($input['upi']) : null;

        // Check for duplicate National ID
        if ($national_id) {
            $exists = $this->db->where('national_id', $national_id)->or_where('identification_number', $national_id)->get('patients')->row_array();
            if ($exists) {
                $this->error_json("Duplicate patient record detected with National ID: " . $national_id . ". Record exists under Patient ID #" . $exists['id'], 409, array('patient_id' => $exists['id']));
            }
        }

        // Check for duplicate UPI
        if ($upi) {
            $exists_upi = $this->db->where('upi', $upi)->get('patients')->row_array();
            if ($exists_upi) {
                $this->error_json("Duplicate patient record detected with UPI: " . $upi . ". Record exists under Patient ID #" . $exists_upi['id'], 409, array('patient_id' => $exists_upi['id']));
            }
        }

        // If no UPI provided by caller, generate standard Kenya Afya UPI syntax
        if (empty($upi)) {
            $next_id_row = $this->db->select_max('id')->get('patients')->row_array();
            $next_num = intval($next_id_row['id']) + 1;
            $upi = 'AFYA-KE-' . date('Y') . '-' . str_pad($next_num, 6, '0', STR_PAD_LEFT);
        }

        $dob = !empty($input['dob']) ? date('Y-m-d', strtotime($input['dob'])) : null;
        $age = !empty($input['age']) ? intval($input['age']) : ($dob ? (date('Y') - date('Y', strtotime($dob))) : 0);

        $patient_data = array(
            'patient_name'          => trim($input['patient_name']),
            'gender'                => trim($input['gender']),
            'dob'                   => $dob,
            'age'                   => $age,
            'mobileno'              => !empty($input['mobileno']) ? trim($input['mobileno']) : (!empty($input['phone']) ? trim($input['phone']) : null),
            'email'                 => !empty($input['email']) ? trim($input['email']) : null,
            'address'               => !empty($input['address']) ? trim($input['address']) : null,
            'guardian_name'         => !empty($input['guardian_name']) ? trim($input['guardian_name']) : null,
            'identification_number' => $national_id ?: '',
            'national_id'           => $national_id,
            'upi'                   => $upi,
            'blood_group'           => !empty($input['blood_group']) ? trim($input['blood_group']) : '',
            'known_allergies'       => !empty($input['known_allergies']) ? trim($input['known_allergies']) : '',
            'marital_status'        => !empty($input['marital_status']) ? trim($input['marital_status']) : 'Single',
            'insurance_id'          => !empty($input['insurance_id']) ? trim($input['insurance_id']) : null,
            'insurance_validity'    => !empty($input['insurance_validity']) ? date('Y-m-d', strtotime($input['insurance_validity'])) : null,
            'is_active'             => 'yes',
            'created_at'            => date('Y-m-d H:i:s')
        );

        $this->db->insert('patients', $patient_data);
        $patient_id = $this->db->insert_id();

        $created = $this->db->where('id', $patient_id)->get('patients')->row_array();

        $this->log_api_audit('PATIENT_REGISTRATION', $patient_id);

        $this->response_json($this->format_patient_resource($created), 201);
    }

    /**
     * Formats database patient record into Kenya HIE / FHIR Patient Schema
     */
    private function format_patient_resource($row)
    {
        return array(
            'resourceType' => 'Patient',
            'id'           => intval($row['id']),
            'identifiers'  => array(
                array(
                    'system' => 'http://health.go.ke/identifiers/upi',
                    'type'   => 'Unique Patient Identifier (Afya ID)',
                    'value'  => !empty($row['upi']) ? $row['upi'] : null
                ),
                array(
                    'system' => 'http://health.go.ke/identifiers/national-id',
                    'type'   => 'National Identity Card',
                    'value'  => !empty($row['national_id']) ? $row['national_id'] : (!empty($row['identification_number']) ? $row['identification_number'] : null)
                )
            ),
            'name'         => $row['patient_name'],
            'gender'       => strtolower($row['gender']),
            'birthDate'    => $row['dob'],
            'age'          => intval($row['age']),
            'telecom'      => array(
                'phone' => !empty($row['mobileno']) ? $row['mobileno'] : null,
                'email' => !empty($row['email']) ? $row['email'] : null
            ),
            'address'      => !empty($row['address']) ? $row['address'] : null,
            'guardian'     => !empty($row['guardian_name']) ? $row['guardian_name'] : null,
            'maritalStatus'=> !empty($row['marital_status']) ? $row['marital_status'] : null,
            'bloodGroup'   => !empty($row['blood_group']) ? $row['blood_group'] : null,
            'allergies'    => !empty($row['known_allergies']) ? $row['known_allergies'] : null,
            'insurance'    => array(
                'insurance_id' => !empty($row['insurance_id']) ? $row['insurance_id'] : null,
                'validity'     => !empty($row['insurance_validity']) ? $row['insurance_validity'] : null
            ),
            'active'       => ($row['is_active'] === 'yes'),
            'createdAt'    => $row['created_at']
        );
    }
}

