# Physiotherapy Department Module — Implementation History & Reference
**Date:** November 8, 2026  
**System:** Smart Hospital v5.0 (CodeIgniter 3 + MariaDB/MySQL + Apache / XAMPP)  
**Database:** `sfu` on `localhost:3306`  
**Webroot / Junction:** `D:\xammp\htdocs\sfu` ➔ `d:\downloads\Smart Hospital v5.0 Nulled\Smart Hospital v5.0 Nulled\sfu`

---

## 📌 Executive Summary
A standalone, fully integrated **Physiotherapy** clinical department was built from the ground up, patterned after the architectural standard of the Operation Theatre (OT) and Laboratory modules in Smart Hospital.

It includes:
- Dedicated Left Sidebar menu with icon (`fas fa-walking`).
- Server-side DataTables with patient search, sort, and pagination.
- Modal split into:
  - **Left Panel (Vitals & Symptoms)**: Patient Select2 + New Patient trigger, Height, Weight, BP, Symptoms, Note.
  - **Right Panel (Clinical & Billing)**: Assessment & Treatment, Diagnosis, Referring Doctor, Pain Level (1–10) & Location, Physiotherapy Assessment, Treatment / Exercise, Physiotherapist (Staff dropdown), Session Date & Duration, Notes, TPA / Organisation, Charge Category, Code, Standard Charge (auto-populated), Applied Charge (editable).
- **Consultant Instructions modal** for session-by-session doctor instructions and progress logging.
- **Printable A4 Bill / Voucher** with hospital header image, clinical findings, itemized fees, signature blocks, and hospital footer.
- System-wide integrations across **Human Resources (Role, Department, Designation)**, **Roles & Permissions (RBAC)**, **Finance / Transactions**, **Print Header/Footer Setup**, **Reports**, **Admin Dashboard KPI widget**, **Custom Fields**, **Payroll**, and **Languages**.

---

## 🗄️ Database Changes & Schemas

### 1. `physiotherapy` Table
```sql
CREATE TABLE IF NOT EXISTS `physiotherapy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `height` varchar(50) DEFAULT NULL,
  `weight` varchar(50) DEFAULT NULL,
  `bp` varchar(50) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `assessment_treatment` varchar(255) DEFAULT NULL,
  `diagnosis` varchar(255) DEFAULT NULL,
  `referring_doctor` varchar(255) DEFAULT NULL,
  `pain_level` varchar(20) DEFAULT NULL,
  `pain_location` varchar(255) DEFAULT NULL,
  `physiotherapy_assessment` text DEFAULT NULL,
  `treatment_exercise` text DEFAULT NULL,
  `physiotherapist_id` int(11) NOT NULL,
  `session_date` datetime NOT NULL,
  `session_duration` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` decimal(10,2) NOT NULL DEFAULT 0.00,
  `apply_charge` decimal(10,2) NOT NULL DEFAULT 0.00,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `physiotherapist_id` (`physiotherapist_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `charge_id` (`charge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
```

### 2. `physiotherapy_instructions` Table
```sql
CREATE TABLE IF NOT EXISTS `physiotherapy_instructions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `physiotherapy_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `consultant_doctor` int(11) NOT NULL,
  `instruction` text NOT NULL,
  `instruction_date` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `physiotherapy_id` (`physiotherapy_id`),
  KEY `patient_id` (`patient_id`),
  KEY `consultant_doctor` (`consultant_doctor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
```

### 3. Seed Data & Role Configurations
```sql
-- Prefix for Physiotherapy Billing
INSERT INTO `prefixes` (`type`, `prefix`) VALUES ('physiotherapy_billing', 'PHYB');

-- Print Settings header/footer entry
INSERT INTO `print_setting` (`setting_for`, `print_header`, `print_footer`, `is_active`) 
VALUES ('physiotherapy', '', '<p>Thank you for choosing our hospital physiotherapy department.</p>', 'yes');

-- Permission Group (ID 46)
INSERT INTO `permission_group` (`name`, `short_code`, `is_active`, `system`, `sort_order`) 
VALUES ('Physiotherapy', 'physiotherapy', 1, 0, 28.00);

-- Permission Categories
INSERT INTO `permission_category` (`perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`) 
VALUES 
  (46, 'Physiotherapy Patient', 'physiotherapy_patient', 1, 1, 1, 1),
  (46, 'Physiotherapy Bill', 'physiotherapy_billing', 1, 1, 1, 1),
  (46, 'Physiotherapy Report', 'physiotherapy_report', 1, 0, 0, 0),
  (46, 'Physiotherapy Print Header Footer', 'physiotherapy_print_header_footer', 1, 0, 1, 0);

-- Role (ID 10) Modeled After Radiologist
INSERT INTO `roles` (`name`, `slug`, `is_active`, `is_system`, `is_superadmin`) 
VALUES ('Physiotherapist', NULL, 0, 1, 0);

-- Department & Designation in Human Resources
INSERT INTO `department` (`department_name`, `is_active`) VALUES ('Physiotherapy', 'yes');
INSERT INTO `staff_designation` (`designation`, `is_active`) VALUES ('Physiotherapist', 'yes');
```

---

## 👥 Roles, Human Resources & Permissions Architecture

### 1. The `Physiotherapist` Role (ID 10)
- Registered as a `System` role (`is_system = 1`) just like `Radiologist` (ID 6) and `Pathologist` (ID 5).
- Appears automatically in:
  - **Human Resources ➔ Staff Directory / Add Staff**: Accessible under the **Role \*** dropdown.
  - **Human Resources ➔ Department**: Available as **Physiotherapy**.
  - **Human Resources ➔ Designation**: Available as **Physiotherapist**.
  - **Setup ➔ Roles Permissions (`admin/roles`)**: Displayed with **Assign Permission** action.

### 2. Permissions Assigned to `Physiotherapist` (Role 10)
Modeled directly after `Radiologist` (Role 6):
- **Physiotherapy Patient**: View, Add, Edit, Delete (`can_view=1, can_add=1, can_edit=1, can_delete=1`)
- **Physiotherapy Bill**: View, Add, Edit, Delete (`can_view=1, can_add=1, can_edit=1, can_delete=1`)
- **Physiotherapy Report**: View (`can_view=1`)
- **Physiotherapy Print Header Footer**: View, Edit (`can_view=1, can_edit=1`)
- **Clinical Staff Features**: Patient view, Hospital Charges, Calendar To Do List, Notice Board, Staff view, Apply Leave, Language Switcher, Chat.

### 3. Permissions for `Admin` Role (Role 1)
- Full View, Add, Edit, Delete permissions granted for all Physiotherapy operations.

### 4. Why Checkboxes Differ on the Permission Grid (`admin/roles/permission`)
In Smart Hospital, checkboxes are rendered based on the capability flags in `permission_category`:
- **Transactional Records** (e.g. *Physiotherapy Patient*, *Physiotherapy Bill*, *OPD Patient*):
  Have `enable_view=1`, `enable_add=1`, `enable_edit=1`, `enable_delete=1` ➔ **All 4 checkboxes (View, Add, Edit, Delete) are displayed**.
- **Action Triggers & Reports** (e.g. *Physiotherapy Report*, *Move Patient in IPD*, *Manual Prescription*):
  Only have `enable_view=1` ➔ The system hides Add, Edit, and Delete checkboxes because there is no concept of creating or editing a report or action.
- **Dashboard Widgets** (e.g. *Pathology Income Widget*, *IPD Income Widget*):
  Only have `enable_view=1` ➔ Only the View checkbox appears, allowing administrators to grant or hide widget visibility on a user's dashboard.
- **Print Settings** (e.g. *Physiotherapy Print Header Footer*):
  Has `enable_view=1` and `enable_edit=1` ➔ Allows administrators to view and edit/save print headers/footers.

---

## 📁 Files Created

| File Path | Description |
|---|---|
| `application/controllers/admin/Physiotherapy.php` | Controller managing list, getDatatable, add, update, delete, viewDetail, printBill, and consultant instructions. |
| `application/models/Physiotherapy_model.php` | Model providing server-side DataTables query, joins with patients & staff, CRUD operations, auto-bill number prefixing, and instructions. |
| `application/views/admin/physiotherapy/index.php` | Main interface: DataTables list, Add Modal (vitals on left, clinical & billing on right), Edit Modal, View Modal, Consultant Instructions Modal. |
| `application/views/admin/physiotherapy/printBill.php` | Printable hospital voucher layout with header image, demographics, assessment table, fee summary, and footer. |
| `application/views/admin/report/physiotherapy.php` | Reports container view for Physiotherapy. |
| `application/views/admin/report/_physiotherapy.php` | Submenu list view for Physiotherapy reporting. |
| `application/views/admin/printing/physiotherapyprinting.php` | Setup interface to upload header banner image and configure custom HTML footer for physiotherapy bills. |

---

## 🛠️ Files Modified & Integration Points

1. **`application/views/layout/sidebar.php` (Line 152)**
   - Added Physiotherapy menu item with `fas fa-walking` icon.
   - Added Physiotherapy link under Reports submenu.
   - Added `physiotherapy_print_header_footer` to print settings visibility checks.
2. **`application/controllers/admin/Printing.php` (Line 179)**
   - Added `physiotherapyprinting()` method and redirect handlers for Setup ➔ Print Header & Footer.
3. **`application/views/admin/printing/sidebar.php` (Line 56)**
   - Added Physiotherapy tab link in printing settings sidebar.
4. **`application/controllers/admin/Report.php` (Line 136)**
   - Added `physiotherapy()` report controller action.
5. **`application/controllers/admin/Admin.php` (Line 758)**
   - Added monthly revenue aggregation for Physiotherapy on the dashboard.
6. **`application/views/admin/dashboard.php` (Line 192)**
   - Added KPI card widget displaying monthly revenue for Physiotherapy.
7. **`application/controllers/admin/Income.php` (Line 527)**
   - Integrated `physiotherapy` filter into the All Transaction Report.
8. **`application/models/Transaction_model.php` (Line 1664)**
   - Implemented `physiotherapyRecord()` for financial reporting.
9. **`application/libraries/Customlib.php` (Line 1558)**
   - Added `'physiotherapy'` to `get_modules()`.
10. **`application/config/payroll.php` (Line 21)**
    - Added `'physiotherapy' => lang('physiotherapy')`.
11. **`application/config/custom_filed-config.php` (Line 37)**
    - Enabled custom fields for `"physiotherapy"`.
12. **`application/language/English/app_files/system_lang.php` (Line 2446)**
    - Added 20 English language translation strings for all labels.
13. **`application/controllers/admin/Physiotherapy.php` (Line 41)**
    - Enhanced Physiotherapist staff dropdown to query staff from both Role 10 (`Physiotherapist`) and Role 3 (`Doctor`).

---

## 🐛 Issues Identified & Resolved During Setup

1. **Unknown column `patients.patient_unique_id`:**
   - *Discovery:* The `patients` table schema uses `patients.id` (not `patient_unique_id`).
   - *Fix:* Updated `Physiotherapy_model.php` and `printBill.php` to reference `patients.id as pid`.
2. **HTTP 500 Fatal Error (Duplicate Method):**
   - *Discovery:* An automated find-and-replace during transaction model integration duplicated `physiotherapyRecord()` in `Transaction_model.php`.
   - *Fix:* Cleaned duplicate fragments, verified with `php -l`, and confirmed HTTP 200 OK status on `http://localhost/sfu/`.
3. **Unstyled HTML / Missing CSS on Page Load:**
   - *Discovery:* In `Physiotherapy.php`, `$this->load->helper('customfield_helper');` was not loaded in `__construct()`. When the view called `display_custom_fields('physiotherapy')`, it threw a fatal error mid-render, halting the response before the header/footer and CSS stylesheets could be sent.
   - *Fix:* Added `$this->load->helper('customfield_helper');` to [`Physiotherapy.php`](file:///d:/downloads/Smart%20Hospital%20v5.0%20Nulled/Smart%20Hospital%20v5.0%20Nulled/sfu/application/controllers/admin/Physiotherapy.php#L20). The page now outputs full HTML with all CSS themes, skins, sidebars, and scripts (HTTP 200 OK).
4. **Missing Role in Staff Directory & Role List:**
   - *Discovery:* Role 10 (`Physiotherapist`), Department 1 (`Physiotherapy`), and Designation 1 (`Physiotherapist`) were missing from the system dropdowns.
   - *Fix:* Created Role ID 10 (`Physiotherapist`) in table `roles`, added Department ID 1 in `department`, added Designation ID 1 in `staff_designation`, and seeded 29 cloned system permissions from Radiologist (Role 6) plus full Physiotherapy CRUD access.
5. **Checkbox Visibility in `admin/roles/permission`:**
   - *Discovery:* In `admin/roles/permission/[id]`, certain modules (like Dashboard & Widgets or Reports) only display the "View" checkbox without "Add", "Edit", or "Delete" columns.
   - *Explanation:* The view `allotmodule.php` dynamically inspects `permission_category` table flags (`enable_view`, `enable_add`, `enable_edit`, `enable_delete`). A feature like "Monthly Income Chart" or "Staff Role Count Widget" only can be viewed, so the system suppresses meaningless Add/Delete checkboxes. In contrast, records like `Physiotherapy Patient` (category 420) and `Physiotherapy Bill` (category 421) have all 4 flags set to `1` and render the complete set of View, Add, Edit, and Delete checkboxes just like OPD/IPD.

---

## 🌐 Quick Access & Credentials (Local Environment)

- **Admin Login URL:** `http://localhost/sfu/site/login`
- **Username / Email:** `admin@sfu.com`
- **Password:** `admin`
- **Physiotherapy Module:** `http://localhost/sfu/admin/physiotherapy`
- **Physiotherapy Reports:** `http://localhost/sfu/admin/report/physiotherapy`
- **Roles & Permissions Setup:** `http://localhost/sfu/admin/roles`
- **Physiotherapist Permissions:** `http://localhost/sfu/admin/roles/permission/10`
- **Human Resources (Staff Directory):** `http://localhost/sfu/admin/staff`
- **Print Settings (Header / Footer):** `http://localhost/sfu/admin/printing/physiotherapyprinting`
- **Finance (All Transaction Report):** `http://localhost/sfu/admin/income/alltransactionreport` *(Select Module: Physiotherapy)*
