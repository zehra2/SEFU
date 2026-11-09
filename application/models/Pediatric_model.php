<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Pediatric_model extends MY_Model
{
    public function __construct()
    {
        parent::__construct();
        $this->load->library('datatables');
    }

    public function getAllPediatricRecord()
    {
        $i = 1;
        $custom_fields = $this->customfield_model->get_custom_fields('pediatric', 1);
        $custom_field_column_array = array();
        $field_var_array = array();

        if (!empty($custom_fields)) {
            foreach ($custom_fields as $custom_fields_key => $custom_fields_value) {
                $tb_counter = "table_custom_" . $i;
                array_push($custom_field_column_array, 'table_custom_' . $i . '.field_value');
                array_push($field_var_array, 'table_custom_' . $i . '.field_value as ' . $custom_fields_value->name);
                $this->datatables->join('custom_field_values as ' . $tb_counter, 'pediatric.id = ' . $tb_counter . '.belong_table_id AND ' . $tb_counter . '.custom_field_id = ' . $custom_fields_value->id, 'left');
                $i++;
            }
        }

        $field_variable = (empty($field_var_array)) ? "" : "," . implode(',', $field_var_array);
        $custom_field_column = (empty($custom_field_column_array)) ? "" : "," . implode(',', $custom_field_column_array);

        $this->datatables
            ->select('pediatric.*,patients.id as pid,patients.patient_name,patients.gender,patients.mobileno,staff.id as staff_id,staff.name as staff_name,staff.surname as staff_surname,staff.employee_id,charges.name as charge_name,organisation.organisation_name' . $field_variable)
            ->join('patients', 'pediatric.patient_id = patients.id', 'inner')
            ->join('staff', 'staff.id = pediatric.pediatrician_id', 'left')
            ->join('charges', 'pediatric.charge_id = charges.id', 'left')
            ->join('organisation', 'organisation.id = pediatric.organisation_id', 'left')
            ->searchable('pediatric.id,pediatric.bill_no,patients.patient_name,patients.id,patients.gender,patients.mobileno,pediatric.diagnosis,staff.name,staff.surname,pediatric.consultation_date,pediatric.apply_charge' . $custom_field_column)
            ->orderable('pediatric.id,patients.patient_name,patients.id,patients.gender,patients.mobileno,pediatric.diagnosis,staff.name,pediatric.consultation_date,pediatric.apply_charge' . $custom_field_column)
            ->sort('pediatric.id', 'desc')
            ->where('patients.is_active', 'yes')
            ->from('pediatric');

        return $this->datatables->generate('json');
    }

    public function getDetails($id)
    {
        $this->db->select('pediatric.*,patients.id as pid,patients.patient_name,patients.gender,patients.age as pt_age,patients.month as pt_month,patients.day as pt_day,patients.guardian_name,patients.mobileno,patients.email,patients.address,patients.blood_group,staff.name as staff_name,staff.surname as staff_surname,staff.employee_id,charges.name as charge_name,charges.standard_charge as charge_std,organisation.organisation_name,gen_staff.name as gen_name,gen_staff.surname as gen_surname');
        $this->db->from('pediatric');
        $this->db->join('patients', 'pediatric.patient_id = patients.id', 'inner');
        $this->db->join('staff', 'staff.id = pediatric.pediatrician_id', 'left');
        $this->db->join('staff as gen_staff', 'gen_staff.id = pediatric.generated_by', 'left');
        $this->db->join('charges', 'pediatric.charge_id = charges.id', 'left');
        $this->db->join('organisation', 'organisation.id = pediatric.organisation_id', 'left');
        $this->db->where('pediatric.id', $id);
        $query = $this->db->get();
        return $query->row_array();
    }

    public function add($data)
    {
        $this->db->insert('pediatric', $data);
        $insert_id = $this->db->insert_id();

        // Auto generate bill_no if not provided
        if (empty($data['bill_no'])) {
            $prefix = $this->customlib->getSessionPrefixByType('pediatric_billing');
            if (empty($prefix)) {
                $prefix = "PEDB";
            }
            $bill_no = $prefix . $insert_id;
            $this->db->where('id', $insert_id)->update('pediatric', array('bill_no' => $bill_no));
        }

        $message = INSERT_RECORD_CONSTANT . " On Pediatric id " . $insert_id;
        $this->log($message, $insert_id, 'Insert');

        return $insert_id;
    }

    public function update($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('pediatric', $data);

        $message = UPDATE_RECORD_CONSTANT . " On Pediatric id " . $id;
        $this->log($message, $id, 'Update');

        return true;
    }

    public function delete($id)
    {
        $this->db->where('id', $id);
        $this->db->delete('pediatric');

        // Delete associated instructions
        $this->db->where('pediatric_id', $id);
        $this->db->delete('pediatric_instructions');

        $message = DELETE_RECORD_CONSTANT . " On Pediatric id " . $id;
        $this->log($message, $id, 'Delete');

        return true;
    }

    public function getChargeCategory()
    {
        return $this->db->select('id, name')->from('charge_categories')->order_by('name', 'asc')->get()->result_array();
    }

    public function addInstruction($data)
    {
        $this->db->insert('pediatric_instructions', $data);
        return $this->db->insert_id();
    }

    public function getInstructions($pediatric_id)
    {
        $this->db->select('pediatric_instructions.*,staff.name as staff_name,staff.surname as staff_surname,staff.employee_id');
        $this->db->from('pediatric_instructions');
        $this->db->join('staff', 'staff.id = pediatric_instructions.doctor_id', 'left');
        $this->db->where('pediatric_instructions.pediatric_id', $pediatric_id);
        $this->db->order_by('pediatric_instructions.id', 'desc');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function deleteInstruction($id)
    {
        $this->db->where('id', $id);
        $this->db->delete('pediatric_instructions');
        return true;
    }
}

