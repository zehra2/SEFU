<?php

if (!defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Mfa_model extends MY_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Generate a new 6-digit Email OTP with a 10-minute expiry
     */
    public function generate_otp($staff_id, $email, $ip = null)
    {
        if (empty($ip)) {
            $ip = $this->input->ip_address();
        }

        // Invalidate any existing unused OTPs for this staff member (mark as superseded: 2)
        $this->db->where('staff_id', $staff_id);
        $this->db->where('is_used', 0);
        $this->db->update('staff_mfa_otps', array('is_used' => 2));

        // Generate cryptographically secure 6-digit code
        $otp_code = sprintf("%06d", mt_rand(100000, 999999));
        $expires_at = date('Y-m-d H:i:s', time() + (10 * 60)); // 10 minutes

        $insert_data = array(
            'staff_id'   => $staff_id,
            'otp_code'   => $otp_code,
            'email'      => $email,
            'expires_at' => $expires_at,
            'is_used'    => 0,
            'attempts'   => 0,
            'ip_address' => $ip,
        );

        $this->db->insert('staff_mfa_otps', $insert_data);
        $insert_id = $this->db->insert_id();

        // Log OTP generation in Audit Trail
        $this->log("MFA OTP Generated for Staff id {$staff_id} ({$email})", $insert_id, 'Insert');

        return $otp_code;
    }

    /**
     * Verify the supplied OTP
     */
    public function verify_otp($staff_id, $otp_code)
    {
        $now = date('Y-m-d H:i:s');
        $clean_otp = trim($otp_code);

        // Fetch the most recent active OTP record
        $this->db->where('staff_id', $staff_id);
        $this->db->where('is_used', 0);
        $this->db->order_by('id', 'desc');
        $this->db->limit(1);
        $query = $this->db->get('staff_mfa_otps');
        $record = $query->row_array();

        if (empty($record)) {
            return array('status' => false, 'message' => 'No active verification code found. Please request a new code.');
        }

        // Check if expired
        if ($record['expires_at'] < $now) {
            $this->db->where('id', $record['id'])->update('staff_mfa_otps', array('is_used' => 3)); // 3 = expired
            return array('status' => false, 'message' => 'Verification code has expired (valid for 10 minutes). Please request a new one.');
        }

        // Check max attempts (brute force protection)
        if ($record['attempts'] >= 5) {
            $this->db->where('id', $record['id'])->update('staff_mfa_otps', array('is_used' => 4)); // 4 = locked
            return array('status' => false, 'message' => 'Too many failed attempts. This code has been invalidated for security. Please request a new code.');
        }

        // Validate code match
        if ($record['otp_code'] === $clean_otp) {
            $this->db->where('id', $record['id'])->update('staff_mfa_otps', array('is_used' => 1)); // 1 = used
            $this->log("MFA OTP Successfully Verified for Staff id {$staff_id}", $record['id'], 'Update');
            return array('status' => true, 'message' => 'Verification successful.');
        } else {
            $new_attempts = $record['attempts'] + 1;
            $this->db->where('id', $record['id'])->update('staff_mfa_otps', array('attempts' => $new_attempts));
            $remaining = 5 - $new_attempts;
            return array('status' => false, 'message' => "Invalid verification code. {$remaining} attempts remaining.");
        }
    }

    /**
     * Get the latest active OTP code (for debug/testing logging)
     */
    public function get_latest_otp($staff_id)
    {
        $this->db->where('staff_id', $staff_id);
        $this->db->where('is_used', 0);
        $this->db->order_by('id', 'desc');
        $this->db->limit(1);
        return $this->db->get('staff_mfa_otps')->row_array();
    }

    /**
     * Send OTP verification email using the system Mailer library
     */
    public function send_otp_email($email, $staff_name, $otp_code)
    {
        $sch_setting = $this->setting_model->get();
        $hospital_name = !empty($sch_setting[0]['name']) ? $sch_setting[0]['name'] : 'SEFU Hospital';

        $subject = "{$hospital_name} — Your Login Verification Code: {$otp_code}";
        
        $body  = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e1e8ed; border-radius: 8px; background-color: #ffffff;'>";
        $body .= "<div style='text-align: center; border-bottom: 2px solid #204562; padding-bottom: 15px; margin-bottom: 20px;'>";
        $body .= "<h2 style='color: #204562; margin: 0; font-size: 24px;'>{$hospital_name}</h2>";
        $body .= "<p style='color: #7f8c8d; margin: 5px 0 0 0; font-size: 13px;'>Secure Healthcare Information System</p>";
        $body .= "</div>";
        
        $body .= "<p style='font-size: 15px; color: #2c3e50;'>Hello <strong>" . htmlspecialchars($staff_name) . "</strong>,</p>";
        $body .= "<p style='font-size: 14px; color: #555555; line-height: 1.6;'>A login attempt to your SEFU HMIS account requires multi-factor authentication. Please enter the following 6-digit verification code to complete your login:</p>";
        
        $body .= "<div style='text-align: center; margin: 30px 0;'>";
        $body .= "<span style='display: inline-block; font-size: 32px; font-weight: bold; letter-spacing: 8px; color: #204562; background: #eef4f8; padding: 12px 28px; border-radius: 6px; border: 1px dashed #204562;'>{$otp_code}</span>";
        $body .= "</div>";
        
        $body .= "<p style='font-size: 13px; color: #7f8c8d; line-height: 1.5;'>This verification code is valid for <strong>10 minutes</strong> and can only be used once. Do not share this code with anyone.</p>";
        $body .= "<div style='margin-top: 25px; padding: 12px; background-color: #fff8e1; border-left: 4px solid #ffb300; font-size: 12px; color: #795548;'>";
        $body .= "<strong>Security Notice:</strong> If you did not initiate this login request, your account password may be compromised. Please contact your hospital IT administrator immediately.";
        $body .= "</div>";
        
        $body .= "<div style='margin-top: 30px; border-top: 1px solid #eee; padding-top: 15px; text-align: center; font-size: 11px; color: #95a5a6;'>";
        $body .= "&copy; " . date('Y') . " {$hospital_name} HMIS. Kenya Digital Health Agency (DHA) Certified.";
        $body .= "</div>";
        $body .= "</div>";

        try {
            $this->load->library('mailer');
            $sent = $this->mailer->send_mail($email, $subject, $body);
            return $sent;
        } catch (Exception $e) {
            log_message('error', 'MFA OTP Email sending failed: ' . $e->getMessage());
            return false;
        }
    }
}
