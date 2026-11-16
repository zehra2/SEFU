<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

/**
 * Kenya National Health Information Exchange (HIE) Hub Admin Controller
 * Manages API clients, cryptographic tokens, KMHFL/CR registry context,
 * and live external integration audit logs for DHA / SHA certification.
 */
class Interoperability extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        $this->load->helper('url');
        $this->load->library('session');
    }

    /**
     * Dashboard: Displays registry status, active clients, and audit trail
     */
    public function index()
    {
        $this->session->set_userdata('top_menu', 'interoperability');
        $this->session->set_userdata('sub_menu', 'admin/interoperability');
        $this->session->set_userdata('subsub_menu', '');

        // 1. Facility & Registry Settings
        $setting = $this->db->get('sch_settings')->row_array();
        $kmhflCode = !empty($setting['kmhfl_code']) ? $setting['kmhfl_code'] : '12345';
        $facilityName = !empty($setting['name']) ? $setting['name'] : 'SEFU Health Hospital';

        // 2. Metrics & Counts
        $totalSyntheticPatients = $this->db->where('is_synthetic_conformance_data', 1)->count_all_results('patients');
        $totalActiveClients = $this->db->where('is_active', 1)->count_all_results('api_clients');
        $totalApiInvocations = $this->db->where('user_type', 'API_CLIENT')->count_all_results('logs');
        $totalIcdCodes = $this->db->count_all('terminology_icd10');

        // 3. API Clients list
        $clients = $this->db->order_by('id', 'ASC')->get('api_clients')->result_array();

        // 4. Recent API Audit Logs (last 50)
        $auditLogs = $this->db->where('user_type', 'API_CLIENT')
            ->order_by('id', 'DESC')
            ->limit(50)
            ->get('logs')
            ->result_array();

        $data = array(
            'title'                  => 'Kenya National HIE Interoperability Hub',
            'facility_name'          => $facilityName,
            'kmhfl_code'             => $kmhflCode,
            'total_synthetic'        => $totalSyntheticPatients,
            'total_clients'          => $totalActiveClients,
            'total_invocations'      => $totalApiInvocations,
            'total_icd'              => $totalIcdCodes,
            'clients'                => $clients,
            'audit_logs'             => $auditLogs,
            'api_docs_url'           => base_url('api/v1/docs'),
            'openapi_spec_url'       => base_url('api/v1/openapi.json')
        );

        $this->load->view('layout/header', $data);
        $this->load->view('admin/interoperability/index', $data);
        $this->load->view('layout/footer', $data);
    }

    /**
     * AJAX/POST: Register a new external client
     */
    public function create_client()
    {
        if ($this->input->server('REQUEST_METHOD') !== 'POST') {
            redirect('admin/interoperability');
            return;
        }

        $clientName = trim($this->input->post('client_name'));
        $clientIdentifier = trim($this->input->post('client_identifier'));
        $contactEmail = trim($this->input->post('contact_email'));
        $rateLimit = (int) $this->input->post('rate_limit_per_minute');
        if ($rateLimit <= 0) {
            $rateLimit = 120;
        }

        if (empty($clientName) || empty($clientIdentifier)) {
            $this->session->set_flashdata('msg', '<div class="alert alert-danger">Client name and identifier are required.</div>');
            redirect('admin/interoperability');
            return;
        }

        // Generate cryptographic token (48 chars hex)
        $newApiKey = 'hie_' . bin2hex(random_bytes(20));

        $allowedEndpoints = array("patients:read", "encounters:read", "billing:read", "facility:read");

        $data = array(
            'client_name'           => $clientName,
            'client_identifier'     => $clientIdentifier,
            'api_key'               => $newApiKey,
            'allowed_endpoints'     => json_encode($allowedEndpoints),
            'rate_limit_per_minute' => $rateLimit,
            'is_active'             => 1,
            'contact_email'         => $contactEmail,
            'created_at'            => date('Y-m-d H:i:s')
        );

        $this->db->insert('api_clients', $data);

        $this->session->set_flashdata('msg', '<div class="alert alert-success">External API Client successfully registered with active token.</div>');
        redirect('admin/interoperability');
    }

    /**
     * AJAX/POST: Toggle client status (Active / Revoked)
     */
    public function toggle_status($id)
    {
        $id = (int)$id;
        $client = $this->db->where('id', $id)->get('api_clients')->row_array();
        if ($client) {
            $newStatus = ($client['is_active'] == 1) ? 0 : 1;
            $this->db->where('id', $id)->update('api_clients', array('is_active' => $newStatus));
            $this->session->set_flashdata('msg', '<div class="alert alert-info">Client status updated successfully.</div>');
        }
        redirect('admin/interoperability');
    }

    /**
     * AJAX/POST: Regenerate API Key
     */
    public function regenerate_key($id)
    {
        $id = (int)$id;
        $client = $this->db->where('id', $id)->get('api_clients')->row_array();
        if ($client) {
            $newApiKey = 'hie_' . bin2hex(random_bytes(20));
            $this->db->where('id', $id)->update('api_clients', array('api_key' => $newApiKey));
            $this->session->set_flashdata('msg', '<div class="alert alert-success">API Token regenerated successfully. Please update the integration gateway.</div>');
        }
        redirect('admin/interoperability');
    }
}
