<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Role {

    public function __construct() {
        $this->CI = & get_instance();
        $this->CI->student_login_prefix = "std";
        $this->CI->parent_login_prefix = "parent";
        $this->CI->teacher_login_prefix = "teacher";
        $this->CI->librarian_login_prefix = "librarian";
        $this->CI->accountant_login_prefix = "accountant";
    }

    public function get_random_password($chars_min = 8, $chars_max = 10, $use_upper_case = true, $include_numbers = true, $include_special_chars = true) {
        $chars_min = max(8, (int)$chars_min);
        $chars_max = max($chars_min, (int)$chars_max);
        $length = rand($chars_min, $chars_max);

        $lower_chars = 'abcdefghjkmnpqrstuvwxyz';
        $upper_chars = 'ABCDEFGHJKMNPQRSTUVWXYZ';
        $num_chars   = '23456789';
        $spec_chars  = '!@#$%*-_+';

        // Guarantee at least one of each required character class
        $chars = array();
        $chars[] = $lower_chars[rand(0, strlen($lower_chars) - 1)];
        $chars[] = $upper_chars[rand(0, strlen($upper_chars) - 1)];
        $chars[] = $num_chars[rand(0, strlen($num_chars) - 1)];
        $chars[] = $spec_chars[rand(0, strlen($spec_chars) - 1)];

        // Pool for remaining characters
        $all_pool = $lower_chars . $upper_chars . $num_chars . $spec_chars;
        $remaining = $length - count($chars);
        for ($i = 0; $i < $remaining; $i++) {
            $chars[] = $all_pool[rand(0, strlen($all_pool) - 1)];
        }

        // Shuffle securely
        shuffle($chars);
        return implode('', $chars);
    }

}
