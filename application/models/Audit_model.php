<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Audit_model extends MY_Model
{

    public function __construct()
    {
        parent::__construct();

    }

    public function get($limit = null, $offset = null)
    {
        $this->db->select("logs.*, COALESCE(NULLIF(logs.user_name, ''), IF(logs.user_id = 0 OR staff.id IS NULL, 'System / Administrator', CONCAT_WS(' ', staff.name, staff.surname, CONCAT('(', staff.employee_id, ')')))) as name")->from('logs');
        $this->db->join('staff', 'staff.id = logs.user_id', 'left');
        $this->db->order_by('logs.id', 'asc');
        $this->db->limit($limit, $offset);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function getAllRecord($start_date = null, $end_date = null)
    {
        $query = "date_format(logs.created_at, '%Y-%m-%d') >= '" . $start_date . "' AND date_format(logs.created_at, '%Y-%m-%d') <= '" . $end_date . "'";
        $this->datatables
            ->select("logs.*, COALESCE(NULLIF(logs.user_name, ''), IF(logs.user_id = 0 OR staff.id IS NULL, 'System / Administrator', CONCAT_WS(' ', staff.name, staff.surname, CONCAT('(', staff.employee_id, ')')))) as name")
            ->join('staff', 'staff.id = logs.user_id', 'left')           
            ->where($query)
            ->searchable('logs.message, logs.user_name, logs.user_role, logs.ip_address, logs.action, logs.platform, logs.agent')
            ->orderable('logs.message, logs.user_name, logs.ip_address, logs.action, logs.platform, logs.agent')            
            ->sort('logs.id', 'desc')
            ->from('logs');
            
        return $this->datatables->generate('json');
    }

    public function count()
    {
        $query = $this->db->select('count(*) as total')->get('logs')->row_array();
        return $query['total'];
    }

    public function delete($id = null)
    {
        if ($id == null) {
            $this->db->empty_table('logs');
        } else {
            $this->db->where('id', $id)->delete('logs');
        }
    }

}
