# SEFU HMIS — Comprehensive User & Administrator Manual
**Kenya Digital Health Agency (DHA) Certification Compliance Document**  
**Category:** System Documentation — Section D: User & Administrator Manuals  
**System Classification:** Health Information System (HIS) & Electronic Medical Record (EMR)  
**Applicable Regulations:** Kenya Health Information Management Procedures Regulations 2025 (Statutory Requirement)

---

## 📋 1. Manual Scope & Overview

This manual provides operational guidance for clinical healthcare workers, departmental technicians, cashiers, and system administrators operating the **SEFU Hospital Management Information System (SEFU HMIS)**.

---

## 🛠️ PART I: ADMINISTRATOR MANUAL

### 1.1 Initial Hospital Configuration (`/schsettings`)
1. Log in as an Administrator (`admin@sfu.com`).
2. Navigate to **System Settings > General Settings**.
3. Configure core hospital parameters:
   - **Hospital Name & Code:** Enter facility registered name (e.g., `SEFU Hospital`).
   - **Currency & Timezone:** Ensure currency is set to Kenya Shillings (`KES`) and timezone to `Africa/Nairobi` (EAT).
   - **Two-Factor Authentication (MFA):** Set to **Enabled (DHA Required)** to enforce email OTP verification for all staff.
   - **Branding & Logos:** Upload official hospital header logo and small icon.
4. Click **Save** to update system-wide defaults.

### 1.2 Staff Onboarding & Specialty Role Assignment (`/admin/staff`)
1. Navigate to **Human Resource > Staff Directory > Add Staff**.
2. Input staff profile: Employee ID, Full Name, Department, Designation, Email, Gender, and Mobile.
3. Assign the appropriate clinical or administrative role:
   - E.g., `Doctor`, `Nurse`, `Pharmacist`, `Pathologist`, `Radiologist`, `Physiotherapist`, `Pediatrician`, `Gynaecologist`, `Human Resource`, or `Accountant`.
4. The system automatically creates their login credentials and dispatches an onboarding confirmation.

### 1.3 Role-Based Access Control (RBAC) Management (`/admin/roles`)
1. Navigate to **System Settings > Roles & Permissions**.
2. Click **Assign Permission** next to any role (e.g., **Human Resource** or **Accountant**).
3. Review the permissions grid divided across clinical, financial, and administrative tabs:
   - Check or uncheck **View**, **Add**, **Edit**, or **Delete** permissions for each module.
   - To delegate log inspection privileges (e.g., to Human Resources), navigate to the **Reports** tab and check **View** for **Audit Trail Report** and **User Log**.
4. Click **Save** to immediately enforce updated privileges.

### 1.4 Backup & Disaster Recovery Administration (`/admin/admin/backup`)
1. Navigate to **System Settings > Backup / Restore**.
2. **On-Demand Database Backup:** Click **Create Backup**. The system generates a complete MySQL dump in `./backup/database_backup/` and enables one-click download.
3. **Database Restoration:** To restore from an uncorrupted snapshot, select the file under **Upload Backup** and click **Restore**.
4. **Automated Verification Drill:** Systems engineers can run the automated verification tool from the command line:
   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts\drp_backup_verify.ps1
   ```
   This generates a timestamped backup, computes an immutable SHA-256 checksum, and verifies table completeness.

### 1.5 System Audit Trail & Login History Inspection (`/admin/audit`)
1. Navigate to **Reports > Log > Audit Trail Report**.
2. View real-time activity across all hospital modules:
   - **Columns:** Action message, User Name and assigned Role (e.g. `Ahmed Zara [Doctor]`), IP address, Action type (Insert/Update/Delete), Platform, and Date/Time.
   - **Search Filter:** Type any role (e.g. `Doctor`, `Human Resource`, `Patient`) into the search bar to filter activities instantly.
3. To view staff and patient authentication logs, navigate to **Reports > Log > User Log** (`/admin/userlog`).

---

## 🩺 PART II: CLINICAL & DEPARTMENTAL USER MANUAL

### 2.1 Front Office & Patient Registration (`/admin/patient`)
1. **Patient Search:** Check if the patient already exists by typing their Name, Phone, or National ID.
2. **New Patient Intake:** Click **+ Add Patient**.
   - Input legal name, national ID / alien ID number, date of birth / age, gender, blood group, next of kin, and phone number.
   - Click **Save**. The system generates a unique permanent **Patient ID**.
3. **Appointment Scheduling:** Navigate to **Appointment > Add Appointment** to book consultations with specific doctors and time slots.

### 2.2 Outpatient Department (OPD) Consultations (`/admin/patient`)
1. Open the patient profile and click **+ Add OPD**.
2. Select the consulting physician and record vital signs:
   - Blood Pressure (systolic/diastolic), Pulse rate, Temperature (°C), Respiratory rate, Height (cm), Weight (kg), and calculated BMI.
3. **Clinical Consultation Notes:**
   - Input presenting clinical symptoms, examination findings, and clinical diagnosis.
4. **Electronic Prescriptions (e-Rx):**
   - Click **Prescription > Add Prescription**.
   - Select medication from the hospital pharmacy formulary, input dosage (e.g. `1 tablet`), frequency (e.g. `TDS - 3 times daily`), duration, and special instructions.
   - Click **Save & Print** to issue the digital prescription voucher.

### 2.3 Specialty Clinical Modules

#### Physiotherapy Module (`/admin/physiotherapy`)
1. Click **Physiotherapy** on the main sidebar navigation.
2. Click **+ Add Physiotherapy Session**.
3. Select patient, consulting physiotherapist, session date, diagnosis, anatomical pain location, and **Pain Scale** rating (1 to 10).
4. Specify session duration in minutes, equipment utilized, and clinical therapy plan.
5. Save the session to automatically generate an official Physiotherapy Voucher (`PHYB#`).

#### Pediatric Module (`/admin/pediatric`)
1. Click **Pediatric** on the main sidebar navigation.
2. Click **+ Add Pediatric Record**.
3. Select infant/child patient; the system automatically displays age in exact years, months, and days.
4. Record birth weight, current presentation weight, height/length, and head circumference.
5. Document immunization history, growth milestones, and pediatric notes. Save to generate Pediatric Voucher (`PEDB#`).

#### Gynaecology & Obstetrics Module (`/admin/gynaecology`)
1. Click **Gynaecology** on the main sidebar navigation.
2. Click **+ Add Gynaecology Record**.
3. Record women's health parameters: Last Menstrual Period (**LMP**), Expected Delivery Date (**EDD**), and obstetric history: Gravida (total pregnancies), Para (viable deliveries), and Abortions.
4. Enter antenatal examination notes and ultrasound observations. Save to generate Gynaecology Voucher (`GYNB#`).

### 2.4 Laboratory Diagnostics (Pathology) (`/admin/pathology`)
1. Navigate to **Pathology > Test Order**.
2. Order required laboratory investigations (e.g. Full Blood Count, Liver Function Tests, Urinalysis).
3. **Sample Collection & Result Entry:**
   - Input barcode sample tube ID.
   - Laboratory technicians enter test parameter values. The system automatically highlights values falling outside normal biological reference ranges.
4. Pathologist signs off and releases digital test reports.

### 2.5 Pharmacy Inventory & Dispensing (`/admin/pharmacy`)
1. Navigate to **Pharmacy > Medicines**.
2. View real-time medicine stock balances, batch numbers, and automated expiry alerts (color-coded red/yellow).
3. **Dispensing Medicines:**
   - Open patient electronic prescription or create a direct pharmacy bill.
   - Select medicine batch; the system automatically deducts stock and calculates line-item prices.
   - Click **Generate Bill** to issue official medication receipt.

### 2.6 Cashier Desk, Invoicing & Insurance (`/admin/bill`)
1. Cashier opens patient file to view consolidated unbilled charges (OPD visit, lab tests, medications, bed days).
2. Apply eligible discounts or map approved **TPA / SHA Health Insurance** policies.
3. Click **Add Payment**, select payment mode (Cash, M-Pesa, Card, Bank Transfer), and enter transaction reference.
4. Issue official hospital receipt with Kenya Shillings (`KES`) currency formatting.

---

**Approved by:**  
*Chief Technology Officer & Lead Solutions Architect*  
*SEFU Health Systems — Kenya Digital Health Agency (DHA) Compliance*
