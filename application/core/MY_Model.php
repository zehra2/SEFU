<?php
defined('BASEPATH') or exit('No direct script access allowed');
class MY_Model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->load->library('user_agent');

    }

    public function log($message = null, $record_id = null, $action = null)
    {
        $CI        = &get_instance();
        $user_id   = 0;
        $user_type = 'system';
        $user_role = 'System';
        $user_name = 'System / Automated';

        if ($CI->session->has_userdata('hospitaladmin')) {
            $admin     = $CI->session->userdata('hospitaladmin');
            $user_id   = isset($admin['id']) ? (int)$admin['id'] : 0;
            $user_type = 'staff';

            // Resolve role name
            $role_name = 'Staff';
            if (isset($admin['roles']) && is_array($admin['roles']) && !empty($admin['roles'])) {
                $role_name = (string)key($admin['roles']);
            }
            $user_role = $role_name;

            // Resolve staff display name
            $staff_name = isset($admin['username']) && trim($admin['username']) !== '' ? trim($admin['username']) : 'Staff #' . $user_id;
            $user_name  = $staff_name . ' [' . $role_name . ']';
        } elseif ($CI->session->has_userdata('patient')) {
            $patient   = $CI->session->userdata('patient');
            $user_id   = isset($patient['patient_id']) ? (int)$patient['patient_id'] : (isset($patient['id']) ? (int)$patient['id'] : 0);
            $user_type = 'patient';
            $user_role = 'Patient';

            $patient_name = isset($patient['name']) && trim($patient['name']) !== '' ? trim($patient['name']) : 'Patient';
            $user_name    = $patient_name . ' (Patient #' . $user_id . ')';
        }

        $ip = $CI->input->ip_address();

        if ($CI->agent->is_browser()) {
            $agent = $CI->agent->browser() . ' ' . $CI->agent->version();
        } elseif ($CI->agent->is_robot()) {
            $agent = $CI->agent->robot();
        } elseif ($CI->agent->is_mobile()) {
            $agent = $CI->agent->mobile();
        } else {
            $agent = 'Unidentified User Agent';
        }

        $platform = $CI->agent->platform();

        $insert = array(
            'message'    => $message,
            'user_id'    => $user_id,
            'user_type'  => $user_type,
            'user_role'  => $user_role,
            'user_name'  => $user_name,
            'record_id'  => $record_id,
            'ip_address' => $ip,
            'platform'   => $platform,
            'agent'      => $agent,
            'action'     => $action,
            'time'       => date('Y-m-d H:i:s'),
            'created_at' => date('Y-m-d'),
        );

        $this->db->insert('logs', $insert);
    }
}
