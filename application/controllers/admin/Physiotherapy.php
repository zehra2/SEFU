<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Physiotherapy extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->library('Customlib');
        $this->load->library('form_validation');
        $this->load->model('physiotherapy_model');
        $this->load->model('patient_model');
        $this->load->model('staff_model');
        $this->load->model('organisation_model');
        $this->load->model('charge_model');
        $this->load->model('customfield_model');
        $this->load->helper('customfield_helper');
        $this->time_format = $this->customlib->getHospitalTimeFormat();
    }

    public function unauthorized()
    {
        $data = array();
        $this->load->view('layout/header', $data);
        $this->load->view('unauthorized', $data);
        $this->load->view('layout/footer', $data);
    }

    public function index()
    {
        if (!$this->rbac->hasPrivilege('physiotherapy_patient', 'can_view')) {
            access_denied();
        }

        $this->session->set_userdata('top_menu', 'physiotherapy');
        $this->session->set_userdata('sub_menu', '');

        $physio_staff = $this->staff_model->getStaffbyrole(10); // Physiotherapists
        $doctor_staff = $this->staff_model->getStaffbyrole(3);  // Doctors
        $data['physiotherapists'] = array_merge($physio_staff, $doctor_staff);
        $data['charge_category']  = $this->physiotherapy_model->getChargeCategory();
        $data['organisation']     = $this->organisation_model->get();
        $data['fields']           = $this->customfield_model->get_custom_fields('physiotherapy', 1);

        $this->load->view('layout/header');
        $this->load->view('admin/physiotherapy/index', $data);
        $this->load->view('layout/footer');
    }

    public function getDatatable()
    {
        $dt_response = $this->physiotherapy_model->getAllPhysiotherapyRecord();
        $fields      = $this->customfield_model->get_custom_fields('physiotherapy', 1);
        $dt_response = json_decode($dt_response);
        $dt_data     = array();

        if (!empty($dt_response->data)) {
            foreach ($dt_response->data as $key => $value) {
                $row = array();

                // Action buttons
                $action = "<div class='rowoptionview'>";
                $action .= "<a href='#' onclick='add_instruction(" . $value->id . ", " . $value->pid . "); refreshmodal();' class='btn btn-default btn-xs' data-toggle='tooltip' title='" . $this->lang->line('consultant_instruction') . "'><i class='fa fa-user-md'></i></a>";
                $action .= "<a href='#' onclick='viewDetail(" . $value->id . ")' class='btn btn-default btn-xs' data-toggle='tooltip' title='" . $this->lang->line('show') . "'><i class='fa fa-reorder'></i></a>";
                $action .= "<a href='#' onclick='printBill(" . $value->id . ")' class='btn btn-default btn-xs' data-toggle='tooltip' title='" . $this->lang->line('print') . "'><i class='fa fa-print'></i></a>";

                if ($this->rbac->hasPrivilege('physiotherapy_patient', 'can_edit')) {
                    $action .= "<a href='#' onclick='getRecord(" . $value->id . ")' class='btn btn-default btn-xs' data-toggle='tooltip' title='" . $this->lang->line('edit') . "'><i class='fa fa-pencil'></i></a>";
                }

                if ($this->rbac->hasPrivilege('physiotherapy_patient', 'can_delete')) {
                    $action .= "<a href='#' onclick='delete_record(" . $value->id . ")' class='btn btn-default btn-xs' data-toggle='tooltip' title='" . $this->lang->line('delete') . "'><i class='fa fa-trash'></i></a>";
                }
                $action .= "</div>";

                $bill_display = (!empty($value->bill_no)) ? $value->bill_no : ($this->customlib->getSessionPrefixByType('physiotherapy_billing') . $value->id);
                $first_action = "<a href='#' onclick='viewDetail(" . $value->id . ")' data-toggle='tooltip' title='" . $this->lang->line('details') . "'>";

                // Table Columns:
                // 1. Bill No + Action
                $row[] = $bill_display . $action;
                // 2. Patient Name
                $row[] = $first_action . composePatientName($value->patient_name, $value->pid) . "</a>";
                // 3. Patient ID
                $row[] = $value->pid;
                // 4. Gender
                $row[] = $this->lang->line(strtolower($value->gender));
                // 5. Phone
                $row[] = $value->mobileno;
                // 6. Diagnosis
                $row[] = $value->diagnosis;
                // 7. Pain Level & Location
                $pain = (!empty($value->pain_level) ? "Level " . $value->pain_level : "") . (!empty($value->pain_location) ? " (" . $value->pain_location . ")" : "");
                $row[] = $pain;
                // 8. Physiotherapist
                $row[] = composeStaffNameByString($value->staff_name, $value->staff_surname, $value->employee_id);
                // 9. Session Date & Duration
                $date_display = $this->customlib->YYYYMMDDHisTodateFormat($value->session_date, $this->time_format);
                if (!empty($value->session_duration)) {
                    $date_display .= " (" . $value->session_duration . ")";
                }
                $row[] = $date_display;

                // Custom fields
                if (!empty($fields)) {
                    foreach ($fields as $fields_key => $fields_value) {
                        $display_field = $value->{"$fields_value->name"};
                        if ($fields_value->type == "link") {
                            $display_field = "<a href=" . $value->{"$fields_value->name"} . " target='_blank'>" . $value->{"$fields_value->name"} . "</a>";
                        }
                        $row[] = $display_field;
                    }
                }

                // 10. Applied Charge
                $row[] = number_format($value->apply_charge, 2);

                $dt_data[] = $row;
            }
        }

        $json_data = array(
            "draw"            => intval($dt_response->draw),
            "recordsTotal"    => intval($dt_response->recordsTotal),
            "recordsFiltered" => intval($dt_response->recordsFiltered),
            "data"            => $dt_data,
        );
        echo json_encode($json_data);
    }

    public function add()
    {
        if (!$this->rbac->hasPrivilege('physiotherapy_patient', 'can_add')) {
            access_denied();
        }

        $this->form_validation->set_rules('patient_id', $this->lang->line('patient'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('physiotherapist_id', $this->lang->line('physiotherapist'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('session_date', $this->lang->line('session_date'), 'trim|required|xss_clean');

        if ($this->form_validation->run() == false) {
            $msg = array(
                'patient_id'         => form_error('patient_id'),
                'physiotherapist_id' => form_error('physiotherapist_id'),
                'session_date'       => form_error('session_date'),
            );
            echo json_encode(array('status' => 'fail', 'error' => $msg, 'message' => ''));
            return;
        }

        $session_date = $this->input->post('session_date');
        $session_date_formatted = $this->customlib->dateFormatToYYYYMMDDHis($session_date, $this->time_format);

        $data = array(
            'patient_id'               => $this->input->post('patient_id'),
            'height'                   => $this->input->post('height'),
            'weight'                   => $this->input->post('weight'),
            'bp'                       => $this->input->post('bp'),
            'symptoms'                 => $this->input->post('symptoms'),
            'note'                     => $this->input->post('note'),
            'assessment_treatment'     => $this->input->post('assessment_treatment'),
            'diagnosis'                => $this->input->post('diagnosis'),
            'referring_doctor'         => $this->input->post('referring_doctor'),
            'pain_level'               => $this->input->post('pain_level'),
            'pain_location'            => $this->input->post('pain_location'),
            'physiotherapy_assessment' => $this->input->post('physiotherapy_assessment'),
            'treatment_exercise'       => $this->input->post('treatment_exercise'),
            'physiotherapist_id'       => $this->input->post('physiotherapist_id'),
            'session_date'             => $session_date_formatted,
            'session_duration'         => $this->input->post('session_duration'),
            'notes'                    => $this->input->post('notes'),
            'organisation_id'          => $this->input->post('organisation_id') ? $this->input->post('organisation_id') : null,
            'charge_id'                => $this->input->post('charge_id') ? $this->input->post('charge_id') : null,
            'standard_charge'          => $this->input->post('standard_charge') ? $this->input->post('standard_charge') : 0.00,
            'apply_charge'             => $this->input->post('apply_charge') ? $this->input->post('apply_charge') : 0.00,
            'generated_by'             => $this->customlib->getLoggedInUserID(),
        );

        $insert_id = $this->physiotherapy_model->add($data);

        // Custom fields
        $custom_field_post = $this->input->post("custom_fields[physiotherapy]");
        if (!empty($custom_field_post)) {
            $custom_value_array = array();
            foreach ($custom_field_post as $key => $value) {
                $check_field_type = $this->input->post("custom_fields[physiotherapy][" . $key . "]");
                $field_value      = is_array($check_field_type) ? implode(",", $check_field_type) : $check_field_type;
                $custom_value_array[] = array(
                    'belong_table_id' => 0,
                    'custom_field_id' => $key,
                    'field_value'     => $field_value,
                );
            }
            if (!empty($custom_value_array)) {
                $this->customfield_model->insertRecord($custom_value_array, $insert_id);
            }
        }

        echo json_encode(array(
            'status'  => 'success',
            'error'   => '',
            'message' => $this->lang->line('success_message'),
            'id'      => $insert_id,
        ));
    }

    public function getDetails()
    {
        $id     = $this->input->post("id");
        $result = $this->physiotherapy_model->getDetails($id);

        if ($result) {
            $result['session_date_formatted'] = $this->customlib->YYYYMMDDHisTodateFormat($result['session_date'], $this->time_format);
            $result['patient_age']            = $this->customlib->getPatientAge($result['age'], $result['month'], $result['day']);
            $result['physiotherapist_name']   = composeStaffNameByString($result['staff_name'], $result['staff_surname'], $result['employee_id']);
        }

        echo json_encode($result);
    }

    public function getRecord()
    {
        $id     = $this->input->post("id");
        $result = $this->physiotherapy_model->getDetails($id);
        if ($result) {
            $result['session_date'] = $this->customlib->YYYYMMDDHisTodateFormat($result['session_date'], $this->time_format);
        }
        echo json_encode($result);
    }

    public function update()
    {
        if (!$this->rbac->hasPrivilege('physiotherapy_patient', 'can_edit')) {
            access_denied();
        }

        $id = $this->input->post('id');
        $this->form_validation->set_rules('id', 'ID', 'trim|required');
        $this->form_validation->set_rules('physiotherapist_id', $this->lang->line('physiotherapist'), 'trim|required|xss_clean');
        $this->form_validation->set_rules('session_date', $this->lang->line('session_date'), 'trim|required|xss_clean');

        if ($this->form_validation->run() == false) {
            $msg = array(
                'physiotherapist_id' => form_error('physiotherapist_id'),
                'session_date'       => form_error('session_date'),
            );
            echo json_encode(array('status' => 'fail', 'error' => $msg, 'message' => ''));
            return;
        }

        $session_date = $this->input->post('session_date');
        $session_date_formatted = $this->customlib->dateFormatToYYYYMMDDHis($session_date, $this->time_format);

        $data = array(
            'height'                   => $this->input->post('height'),
            'weight'                   => $this->input->post('weight'),
            'bp'                       => $this->input->post('bp'),
            'symptoms'                 => $this->input->post('symptoms'),
            'note'                     => $this->input->post('note'),
            'assessment_treatment'     => $this->input->post('assessment_treatment'),
            'diagnosis'                => $this->input->post('diagnosis'),
            'referring_doctor'         => $this->input->post('referring_doctor'),
            'pain_level'               => $this->input->post('pain_level'),
            'pain_location'            => $this->input->post('pain_location'),
            'physiotherapy_assessment' => $this->input->post('physiotherapy_assessment'),
            'treatment_exercise'       => $this->input->post('treatment_exercise'),
            'physiotherapist_id'       => $this->input->post('physiotherapist_id'),
            'session_date'             => $session_date_formatted,
            'session_duration'         => $this->input->post('session_duration'),
            'notes'                    => $this->input->post('notes'),
            'organisation_id'          => $this->input->post('organisation_id') ? $this->input->post('organisation_id') : null,
            'charge_id'                => $this->input->post('charge_id') ? $this->input->post('charge_id') : null,
            'standard_charge'          => $this->input->post('standard_charge') ? $this->input->post('standard_charge') : 0.00,
            'apply_charge'             => $this->input->post('apply_charge') ? $this->input->post('apply_charge') : 0.00,
        );

        $this->physiotherapy_model->update($id, $data);

        // Custom fields update
        $custom_field_post = $this->input->post("custom_fields[physiotherapy]");
        if (!empty($custom_field_post)) {
            $custom_value_array = array();
            foreach ($custom_field_post as $key => $value) {
                $check_field_type = $this->input->post("custom_fields[physiotherapy][" . $key . "]");
                $field_value      = is_array($check_field_type) ? implode(",", $check_field_type) : $check_field_type;
                $custom_value_array[] = array(
                    'belong_table_id' => $id,
                    'custom_field_id' => $key,
                    'field_value'     => $field_value,
                );
            }
            if (!empty($custom_value_array)) {
                $this->customfield_model->updateRecord($custom_value_array, $id, 'physiotherapy');
            }
        }

        echo json_encode(array('status' => 'success', 'error' => '', 'message' => $this->lang->line('update_message')));
    }

    public function delete($id)
    {
        if (!$this->rbac->hasPrivilege('physiotherapy_patient', 'can_delete')) {
            access_denied();
        }

        $this->physiotherapy_model->delete($id);
        echo json_encode(array('status' => 'success', 'message' => $this->lang->line('delete_message')));
    }

    public function printBill($id)
    {
        $result = $this->physiotherapy_model->getDetails($id);
        $result['session_date_formatted'] = $this->customlib->YYYYMMDDHisTodateFormat($result['session_date'], $this->time_format);
        $result['patient_age']            = $this->customlib->getPatientAge($result['age'], $result['month'], $result['day']);
        $result['physiotherapist_name']   = composeStaffNameByString($result['staff_name'], $result['staff_surname'], $result['employee_id']);
        
        $print_setting = $this->setting_model->get('', 'physiotherapy');
        $data['print_setting'] = $print_setting;
        $data['result']        = $result;

        $page = $this->load->view('admin/physiotherapy/printBill', $data, true);
        echo json_encode(array('status' => 1, 'page' => $page));
    }

    public function addInstruction()
    {
        $this->form_validation->set_rules('physiotherapy_id', 'Physiotherapy ID', 'trim|required');
        $this->form_validation->set_rules('patient_id', 'Patient ID', 'trim|required');
        $this->form_validation->set_rules('consultant_doctor', $this->lang->line('consultant_doctor'), 'trim|required');
        $this->form_validation->set_rules('instruction', $this->lang->line('instruction'), 'trim|required');
        $this->form_validation->set_rules('date', $this->lang->line('date'), 'trim|required');

        if ($this->form_validation->run() == false) {
            $msg = array(
                'consultant_doctor' => form_error('consultant_doctor'),
                'instruction'       => form_error('instruction'),
                'date'              => form_error('date'),
            );
            echo json_encode(array('status' => 'fail', 'error' => $msg));
            return;
        }

        $date = $this->input->post('date');
        $date_formatted = $this->customlib->dateFormatToYYYYMMDDHis($date, $this->time_format);

        $data = array(
            'physiotherapy_id'  => $this->input->post('physiotherapy_id'),
            'patient_id'        => $this->input->post('patient_id'),
            'consultant_doctor' => $this->input->post('consultant_doctor'),
            'instruction'       => $this->input->post('instruction'),
            'instruction_date'  => $date_formatted,
        );

        $this->physiotherapy_model->addInstruction($data);
        echo json_encode(array('status' => 'success', 'message' => $this->lang->line('success_message')));
    }

    public function getInstructions()
    {
        $physiotherapy_id = $this->input->post('physiotherapy_id');
        $result = $this->physiotherapy_model->getInstructions($physiotherapy_id);
        echo json_encode($result);
    }

    public function deleteInstruction($id)
    {
        $this->physiotherapy_model->deleteInstruction($id);
        echo json_encode(array('status' => 'success', 'message' => $this->lang->line('delete_message')));
    }
}

