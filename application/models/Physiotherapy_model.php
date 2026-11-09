<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Physiotherapy_model extends MY_Model
{
    public function __construct()
    {
        parent::__construct();
        $this->load->library('datatables');
    }

    public function getAllPhysiotherapyRecord()
    {
        $i = 1;
        $custom_fields = $this->customfield_model->get_custom_fields('physiotherapy', 1);
        $custom_field_column_array = array();
        $field_var_array = array();

        if (!empty($custom_fields)) {
            foreach ($custom_fields as $custom_fields_key => $custom_fields_value) {
                $tb_counter = "table_custom_" . $i;
                array_push($custom_field_column_array, 'table_custom_' . $i . '.field_value');
                array_push($field_var_array, 'table_custom_' . $i . '.field_value as ' . $custom_fields_value->name);
                $this->datatables->join('custom_field_values as ' . $tb_counter, 'physiotherapy.id = ' . $tb_counter . '.belong_table_id AND ' . $tb_counter . '.custom_field_id = ' . $custom_fields_value->id, 'left');
                $i++;
            }
        }

        $field_variable = (empty($field_var_array)) ? "" : "," . implode(',', $field_var_array);
        $custom_field_column = (empty($custom_field_column_array)) ? "" : "," . implode(',', $custom_field_column_array);

        $this->datatables
            ->select('physiotherapy.*,patients.id as pid,patients.patient_name,patients.gender,patients.mobileno,staff.id as staff_id,staff.name as staff_name,staff.surname as staff_surname,staff.employee_id,charges.name as charge_name,organisation.organisation_name' . $field_variable)
            ->join('patients', 'physiotherapy.patient_id = patients.id', 'inner')
            ->join('staff', 'staff.id = physiotherapy.physiotherapist_id', 'left')
            ->join('charges', 'physiotherapy.charge_id = charges.id', 'left')
            ->join('organisation', 'organisation.id = physiotherapy.organisation_id', 'left')
            ->searchable('physiotherapy.id,physiotherapy.bill_no,patients.patient_name,patients.id,patients.gender,patients.mobileno,physiotherapy.diagnosis,physiotherapy.pain_location,staff.name,staff.surname,physiotherapy.session_date,physiotherapy.apply_charge' . $custom_field_column)
            ->orderable('physiotherapy.id,patients.patient_name,patients.id,patients.gender,patients.mobileno,physiotherapy.diagnosis,physiotherapy.pain_location,staff.name,physiotherapy.session_date,physiotherapy.apply_charge' . $custom_field_column)
            ->sort('physiotherapy.id', 'desc')
            ->where('patients.is_active', 'yes')
            ->from('physiotherapy');

        return $this->datatables->generate('json');
    }

    public function getDetails($id)
    {
        $this->db->select('physiotherapy.*,patients.id as pid,patients.patient_name,patients.gender,patients.age,patients.month,patients.day,patients.guardian_name,patients.mobileno,patients.email,patients.address,patients.blood_group,staff.name as staff_name,staff.surname as staff_surname,staff.employee_id,charges.name as charge_name,charges.standard_charge as charge_std,organisation.organisation_name,gen_staff.name as gen_name,gen_staff.surname as gen_surname');
        $this->db->from('physiotherapy');
        $this->db->join('patients', 'physiotherapy.patient_id = patients.id', 'inner');
        $this->db->join('staff', 'staff.id = physiotherapy.physiotherapist_id', 'left');
        $this->db->join('staff as gen_staff', 'gen_staff.id = physiotherapy.generated_by', 'left');
        $this->db->join('charges', 'physiotherapy.charge_id = charges.id', 'left');
        $this->db->join('organisation', 'organisation.id = physiotherapy.organisation_id', 'left');
        $this->db->where('physiotherapy.id', $id);
        $query = $this->db->get();
        return $query->row_array();
    }

    public function add($data)
    {
        $this->db->insert('physiotherapy', $data);
        $insert_id = $this->db->insert_id();

        // Auto generate bill_no if not provided
        if (empty($data['bill_no'])) {
            $prefix = $this->customlib->getSessionPrefixByType('physiotherapy_billing');
            if (empty($prefix)) {
                $prefix = "PHYB";
            }
            $bill_no = $prefix . $insert_id;
            $this->db->where('id', $insert_id)->update('physiotherapy', array('bill_no' => $bill_no));
        }

        $message = INSERT_RECORD_CONSTANT . " On Physiotherapy id " . $insert_id;
        $this->log($message, $insert_id, 'Insert');

        return $insert_id;
    }

    public function update($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('physiotherapy', $data);

        $message = UPDATE_RECORD_CONSTANT . " On Physiotherapy id " . $id;
        $this->log($message, $id, 'Update');

        return true;
    }

    public function delete($id)
    {
        $this->db->where('id', $id);
        $this->db->delete('physiotherapy');

        // Delete associated instructions
        $this->db->where('physiotherapy_id', $id);
        $this->db->delete('physiotherapy_instructions');

        $message = DELETE_RECORD_CONSTANT . " On Physiotherapy id " . $id;
        $this->log($message, $id, 'Delete');

        return true;
    }

    public function getChargeCategory()
    {
        return $this->db->select('id, name')->from('charge_categories')->order_by('name', 'asc')->get()->result_array();
    }

    public function addInstruction($data)
    {
        $this->db->insert('physiotherapy_instructions', $data);
        return $this->db->insert_id();
    }

    public function getInstructions($physiotherapy_id)
    {
        $this->db->select('physiotherapy_instructions.*,staff.name as staff_name,staff.surname as staff_surname,staff.employee_id');
        $this->db->from('physiotherapy_instructions');
        $this->db->join('staff', 'staff.id = physiotherapy_instructions.consultant_doctor', 'left');
        $this->db->where('physiotherapy_instructions.physiotherapy_id', $physiotherapy_id);
        $this->db->order_by('physiotherapy_instructions.id', 'desc');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function deleteInstruction($id)
    {
        $this->db->where('id', $id);
        $this->db->delete('physiotherapy_instructions');
        return true;
    }
}
