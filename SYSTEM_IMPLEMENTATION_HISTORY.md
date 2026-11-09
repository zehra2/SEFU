# Smart Hospital v5.0 — System Implementation History & Technical Reference
**Last Updated:** November 9, 2026  
**System:** Smart Hospital v5.0 (CodeIgniter 3 + MariaDB/MySQL + Apache / XAMPP)  
**Database:** `sfu` on `localhost:3306`  
**Webroot / Junction:** `D:\xammp\htdocs\sfu` ➔ `d:\downloads\Smart Hospital v5.0 Nulled\Smart Hospital v5.0 Nulled\sfu`

---

## 📌 Executive Summary of Completed Work

This document maintains the complete, chronological record of all custom engineering and regulatory compliance work performed on the Smart Hospital platform:

1. **Physiotherapy Clinical Module** (Full independent department, clinical records, session notes, billing, A4 vouchers, reporting, RBAC).
2. **Pediatric Clinical Module** (Child growth monitoring, immunization details, clinical notes, pediatrician consultations, billing, RBAC).
3. **Gynaecology Clinical Module** (LMP, pregnancy status & history, vitals, gynaecologist consultations, clinical notes, billing, RBAC).
4. **Kenya Digital Health Agency (DHA) Certification Framework & Compliance Tracker** (7 workstreams, 25 audit items mapped).
5. **Strict Password Policy & Password Storage Controls (DHA-011)** (Minimum 8-character complexity, uppercase, lowercase, numbers, special symbols, global CI validation rule, Bcrypt password hashing, and auto-rehash migration for legacy accounts).
6. **Role-Based Access Control (RBAC) Architecture & Permission Mapping** (Roles 10, 11, 12, permission categories, and explanation of view-only vs CRUD features).

---

## 🏥 1. Physiotherapy Department Module

### Database Tables & Seed Data
- **Table `physiotherapy`**: Tracks `bill_no`, `patient_id`, vitals (`height`, `weight`, `bp`), `symptoms`, `note`, `assessment_treatment`, `diagnosis`, `referring_doctor`, `pain_level` (1–10), `pain_location`, `physiotherapy_assessment`, `treatment_exercise`, `physiotherapist_id`, `session_date`, `session_duration`, `organisation_id`, `charge_id`, `standard_charge`, `apply_charge`.
- **Table `physiotherapy_instructions`**: Tracks consultant instructions per session (`physiotherapy_id`, `patient_id`, `consultant_doctor`, `instruction`, `instruction_date`).
- **Billing Prefix**: `PHYB` in `prefixes`.
- **Print Setting**: Header & footer record in `print_setting`.
- **RBAC**: Permission Group ID 46 (`Physiotherapy`), Categories 420–423 (`physiotherapy_patient`, `physiotherapy_billing`, `physiotherapy_report`, `physiotherapy_print_header_footer`).
- **System Role**: Role ID 10 (`Physiotherapist`).

### Core Files
- Controller: [`application/controllers/admin/Physiotherapy.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/controllers/admin/Physiotherapy.php)
- Model: [`application/models/Physiotherapy_model.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/models/Physiotherapy_model.php)
- Views: [`application/views/admin/physiotherapy/index.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/physiotherapy/index.php), [`printBill.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/physiotherapy/printBill.php), [`printing/physiotherapyprinting.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/printing/physiotherapyprinting.php)

---

## 👶 2. Pediatric Clinical Module

### Database Tables & Seed Data
- **Table `pediatric`**: Tracks `bill_no`, `patient_id`, `dob`, `age`, vitals (`weight`, `height`, `temperature`), `symptoms`, `pediatrician_id` (staff dropdown), `diagnosis`, `clinical_notes`, `prescription_treatment`, `growth_monitoring` (weight-for-age, height-for-age percentiles, developmental milestones), `immunization_details` (vaccine history & schedule), `note`, billing fields (`organisation_id`, `charge_id`, `standard_charge`, `apply_charge`, `generated_by`).
- **Table `pediatric_instructions`**: Tracks session-by-session instructions (`pediatric_id`, `patient_id`, `consultant_doctor`, `instruction`, `instruction_date`).
- **Billing Prefix**: `PEDB` in `prefixes`.
- **Print Setting**: Header & footer record in `print_setting`.
- **RBAC**: Permission Group ID 47 (`Pediatric`), Categories 424–427 (`pediatric_patient`, `pediatric_billing`, `pediatric_report`, `pediatric_print_header_footer`).
- **System Role**: Role ID 11 (`Pediatrician`), Department ID 2 (`Pediatric`), Designation ID 2 (`Consultant Pediatrician`).

### Core Files
- Controller: [`application/controllers/admin/Pediatric.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/controllers/admin/Pediatric.php)
- Model: [`application/models/Pediatric_model.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/models/Pediatric_model.php)
- Views: [`application/views/admin/pediatric/index.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/pediatric/index.php), [`printBill.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/pediatric/printBill.php), [`printing/pediatricprinting.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/printing/pediatricprinting.php)

---

## 🤰 3. Gynaecology Clinical Module

### Database Tables & Seed Data
- **Table `gynaecology`**: Tracks `bill_no`, `patient_id`, vitals (`height`, `weight`, `bp`), `symptoms`, `gynaecologist_id` (staff dropdown), `diagnosis`, `lmp` (Last Menstrual Period), `pregnancy_status` (Pregnant / Not Pregnant / Suspected), `pregnancy_history` (Gravida, Para, Abortions, Living Children - GPAL), `clinical_notes`, `prescription_treatment`, `note`, billing fields (`organisation_id`, `charge_id`, `standard_charge`, `apply_charge`, `generated_by`).
- **Table `gynaecology_instructions`**: Session instructions (`gynaecology_id`, `patient_id`, `consultant_doctor`, `instruction`, `instruction_date`).
- **Billing Prefix**: `GYNB` in `prefixes`.
- **Print Setting**: Header & footer record in `print_setting`.
- **RBAC**: Permission Group ID 48 (`Gynaecology`), Categories 428–431 (`gynaecology_patient`, `gynaecology_billing`, `gynaecology_report`, `gynaecology_print_header_footer`).
- **System Role**: Role ID 12 (`Gynaecologist`), Department ID 3 (`Gynaecology`), Designation ID 3 (`Consultant Gynaecologist`).

### Core Files
- Controller: [`application/controllers/admin/Gynaecology.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/controllers/admin/Gynaecology.php)
- Model: [`application/models/Gynaecology_model.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/models/Gynaecology_model.php)
- Views: [`application/views/admin/gynaecology/index.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/gynaecology/index.php), [`printBill.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/gynaecology/printBill.php), [`printing/gynaecologyprinting.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/printing/gynaecologyprinting.php)

---

## 🇰🇪 4. Kenya Digital Health Agency (DHA) HMIS Compliance Tracker

- **Source Document:** `D:\xammp\htdocs\sfu\Detailed process for certifying an HMIS through the Kenya Digital Health Agency (DHA) portal (1).docx`
- **Deliverables Generated:**
  - [`DHA_HMIS_Developer_Compliance_Tracker.md`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/DHA_HMIS_Developer_Compliance_Tracker.md): Complete audit documentation broken down across all 7 workstreams.
  - [`DHA_HMIS_Developer_Compliance_Tracker.csv`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/DHA_HMIS_Developer_Compliance_Tracker.csv): Spreadsheet checklist for developer tracking.

---

## 🔒 5. Strict Password Policy & Storage Controls (DHA-011)

### Requirements & Compliance Scope
- **Rule Enforced:** Passwords must be at least **8 characters** long and contain a combination of **uppercase letters (`A-Z`)**, **lowercase letters (`a-z`)**, **numbers (`0-9`)**, and **special characters / symbols (`!@#$%^&*()_+-=[]{}:"|,.<>/?~`)**.
- **Coverage:** All user types and roles (Super Admin, Admin, Doctors, Staff, Receptionists, Patients/Users).

### Technical Implementation

1. **Global Custom Form Validation Rule (`valid_password`)**:
   - Implemented in [`application/libraries/MY_Form_validation.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/libraries/MY_Form_validation.php#L39-L55):
   ```php
   public function valid_password($str) {
       $pattern = '/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_\-+=\[\]{};\':"\\\\|,.<>\/?~`]).{8,}$/';
       if (!preg_match($pattern, $str)) {
           $msg = $this->CI->lang->line('strong_password_policy_error');
           if (empty($msg)) {
               $msg = '{field} must be at least 8 characters long and contain a mix of uppercase letters, lowercase letters, numbers, and symbols/signs (e.g. Ab%6790X).';
           }
           $this->CI->form_validation->set_message('valid_password', $msg);
           return FALSE;
       }
       return TRUE;
   }
   ```

2. **Controllers Enforcing Password Complexity**:
   - **Admin/Staff Self-Service**: [`application/controllers/admin/Admin.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/controllers/admin/Admin.php#L223) (`changepass()`).
   - **HR Staff Management**: [`application/controllers/admin/Staff.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/controllers/admin/Staff.php#L1215) (`change_password($id)` modal).
   - **Patient Portal**: [`application/controllers/user/User.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/controllers/user/User.php#L32) (`changepass()`).
   - **Password Reset / Forgot Password**: [`application/controllers/Site.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/controllers/Site.php#L202) (`admin_resetpassword()` and `resetpassword()`).

3. **Cryptographically Secure Random Password Generator**:
   - Enhanced [`application/libraries/Role.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/libraries/Role.php#L17) (`get_random_password()`) to guarantee a minimum length of 8 and guaranteed inclusion of uppercase, lowercase, numbers, and symbols whenever auto-generating credentials during staff/patient registration.

4. **Database Storage Upgrade & Bcrypt Hashing**:
   - **Schema Migration**: Modified `users.password` from `VARCHAR(50)` to `VARCHAR(255)` so 60-character Bcrypt hashes (`$2y$10$...`) are not truncated.
   - **One-Way Bcrypt Hashing**: Updated `User.php`, `Site.php`, `Patient.php`, and `Welcome.php` to store passwords using `password_hash($pwd, PASSWORD_DEFAULT)`.
   - **Zero-Downtime Legacy Account Migration**: In [`application/models/User_model.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/models/User_model.php#L51) (`checkLogin()`), the system verifies passwords with `password_verify()`. If an existing user has a legacy plaintext password, the system authenticates them and immediately rehashes their password to Bcrypt on the fly.

5. **User Interface Guidance & Form Hints**:
   - Added user-facing hints (`strong_password_hint`) in:
     - [`application/views/admin/change_password.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/change_password.php#L29)
     - [`application/views/admin/staff/staffprofile.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/staff/staffprofile.php#L1139)
     - [`application/views/user/change_password.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/user/change_password.php#L50)
     - [`application/views/admin/admin_resetpassword.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/admin/admin_resetpassword.php#L111)
     - [`application/views/resetpassword.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/views/resetpassword.php#L145)

### Verification Test Summary
```
=== PASSWORD REGEX VALIDATION TESTS ===
[PASS] Password: '1234' (len 4) -> Expected: REJECT, Got: REJECT
[PASS] Password: 'password' (len 8) -> Expected: REJECT, Got: REJECT
[PASS] Password: '12345678' (len 8) -> Expected: REJECT, Got: REJECT
[PASS] Password: 'AdminAdmin' (len 10) -> Expected: REJECT, Got: REJECT
[PASS] Password: 'Admin12345' (len 10) -> Expected: REJECT, Got: REJECT
[PASS] Password: 'Admin@' (len 6) -> Expected: REJECT, Got: REJECT
[PASS] Password: 'Ab%6790' (len 7) -> Expected: REJECT, Got: REJECT
[PASS] Password: 'Ab%6790X' (len 8) -> Expected: ALLOW, Got: ALLOW
[PASS] Password: 'Smart@2026' (len 10) -> Expected: ALLOW, Got: ALLOW
[PASS] Password: 'K@enya#2026' (len 11) -> Expected: ALLOW, Got: ALLOW

=== BCRYPT MIGRATION & REHASH VERIFICATION ===
Step 1: Stored password is '8crwa0' (plaintext)
Step 2: Saved hash in DB: $2y$10$uMfZ9vn5jywqiyMCvAakxu4flInj.SM7dFrAJwlFRLG13.RAs.DvC (len: 60)
Step 3: Subsequent password_verify check: SUCCESSFUL (TRUE)
```

---

## 👥 6. Role-Based Access Control (RBAC) Architecture

### Permissions Matrix & Checkbox Logic
In `application/views/admin/roles/allotmodule.php`, checkboxes are rendered based on the database flags `enable_view`, `enable_add`, `enable_edit`, `enable_delete` in the `permission_category` table:
- **Full CRUD Entities** (e.g. OPD Patient, Physiotherapy, Pediatric, Gynaecology): have `enable_view=1, enable_add=1, enable_edit=1, enable_delete=1`, showing all 4 checkboxes.
- **Informational Dashboard Widgets & Analytical Charts** (e.g. Staff Role Count Widget, IPD Income Widget, Monthly Income Chart): have `enable_view=1` but `enable_add=0, enable_edit=0, enable_delete=0`. Users can only be granted permission to View or Hide the widget.
- **Sub-Actions** (e.g. Move Patient in IPD, Manual Prescription): have `enable_view=1` only, acting as functional permission toggles.

### Specialty Clinical Roles in System
| Role ID | Role Name | Slug | Purpose |
| :---: | :--- | :--- | :--- |
| **6** | **Radiologist** | *system* | Assigned to radiology imaging staff |
| **10** | **Physiotherapist** | *system* | Assigned to physical therapy specialists |
| **11** | **Pediatrician** | *system* | Assigned to child health / pediatric specialists |
| **12** | **Gynaecologist** | *system* | Assigned to women's health / obstetrics specialists |
| **13** | **Human Resource** | *system* | Assigned to HR personnel; has staff, attendance, and log auditing privileges |

---

## 📜 7. Audit Trails & Activity Logging System (Kenya DHA-015 Compliance)

### Overview
In compliance with Kenya Digital Health Agency (DHA) certification requirements for **Information Security & Audit Trails**, the HMIS maintains comprehensive, tamper-evident logs of all user actions (database inserts, updates, deletes) and system authentication events.

### Core Enhancements & Bug Fixes
1. **Resolved Staff ID Wiping Bug (`application/core/MY_Model.php`):**
   - The legacy `log()` function previously cleared the active user ID (`if ($user_id) { $user_id = ""; }`), causing every audit record in the `logs` table to be saved with `user_id = 0`.
   - Corrected to dynamically capture `$this->customlib->getStaffID()` so every record modification is attributed to the exact staff member who executed it.
2. **Robust Name Resolution in `Audit_model.php`:**
   - Switched from an `INNER JOIN` on `staff` to a `LEFT JOIN`.
   - Added automated fallback: `IF(logs.user_id = 0 OR staff.id IS NULL, 'System / Administrator', CONCAT_WS(' ', staff.name, staff.surname, CONCAT('(', staff.employee_id, ')'))) AS name`, ensuring anonymous/system operations and historical records remain fully visible in the Audit Trail report.
3. **Role-Based Access Control (RBAC) Protection:**
   - Enforced `$this->rbac->hasPrivilege('audit_trail_report', 'can_view')` on `Audit::index` and `Audit::getDatatable`.
   - Enforced `$this->rbac->hasPrivilege('user_log', 'can_view')` on `Userlog::index` and `Userlog::userlogreports`.
   - Strictly protected `deleteall()` actions in both `Audit.php` and `Userlog.php`, requiring explicit `can_delete` privileges.
   - Conditionally hid the "Delete All" button in views `admin/audit/index.php` and `admin/userlog/userlogList.php` so non-delete roles cannot view or trigger deletion.
4. **Log Delegation to Custom Roles (e.g., "Human Resource"):**
   - Seeded **Role ID 13 (`Human Resource`)**, Department ID 4 (`Human Resource`), and Staff Designation ID 4 (`HR Manager`).
   - Configured default permissions giving Role 13 view access to `Audit Trail Report` (`audit_trail_report`, id 370), `User Log` (`user_log`, id 187), and `Email / SMS Log` (`email_sms_log`, id 189).
   - Any administrator can delegate or revoke log access for ANY role at `admin/roles/permission/{role_id}` under the "Reports" permission tab.
5. **Full Audit Logging for Clinical Specialty Modules:**
   - Added `$this->log()` hooks to `Physiotherapy_model.php`, `Pediatric_model.php`, and `Gynaecology_model.php` for `add`, `update`, and `delete` operations, guaranteeing complete traceability across all hospital clinical departments.

---

## 🌐 Quick Access URLs (Local Environment)

- **Admin Login:** `http://localhost/sfu/site/login`
- **Audit Trail Report:** `http://localhost/sfu/admin/audit`
- **User Activity Log:** `http://localhost/sfu/admin/userlog`
- **Reports & Logs Hub:** `http://localhost/sfu/admin/report/log`
- **Roles & Permissions:** `http://localhost/sfu/admin/roles`
- **HR Role Permissions:** `http://localhost/sfu/admin/roles/permission/13`
- **Physiotherapy Module:** `http://localhost/sfu/admin/physiotherapy`
- **Pediatric Module:** `http://localhost/sfu/admin/pediatric`
- **Gynaecology Module:** `http://localhost/sfu/admin/gynaecology`
- **Staff Directory:** `http://localhost/sfu/admin/staff`
- **Change Password (Admin):** `http://localhost/sfu/admin/admin/changepass`
- **Patient Login:** `http://localhost/sfu/site/userlogin`
- **Compliance Tracker:** `http://localhost/sfu/DHA_HMIS_Developer_Compliance_Tracker.md`

