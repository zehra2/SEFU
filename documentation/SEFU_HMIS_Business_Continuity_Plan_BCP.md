# SEFU HMIS — Comprehensive Business Continuity Plan (BCP)
**Kenya Digital Health Agency (DHA) Certification Compliance Document**  
**Category:** Information Security Documentation — Section C: Business Continuity  
**System Classification:** Health Information System (HIS) & Electronic Medical Record (EMR)  
**Applicable Regulations:** Kenya Digital Health Act 2023, Kenya Data Protection Act 2019, ISO 22301 (Business Continuity Management), Kenya National e-Health Standards

---

## 📋 1. Executive Summary & Document Control

| Attribute | Specification |
| :--- | :--- |
| **Document Title** | Business Continuity Plan (BCP) & Clinical Downtime Operations Specification |
| **System Name** | SEFU Hospital Management Information System (SEFU HMIS) |
| **System Version** | Release 5.0 (Build 2026-Kenya-DHA) |
| **Document Version** | 1.0 (Production / Certification Ready) |
| **Document Owner** | Chief Technology Officer & Hospital Medical Superintendent |
| **Effective Date** | November 2026 |
| **Review Frequency** | Annually or following significant hospital operational restructuring |
| **Classification** | Confidential — Healthcare Operational Resilience Documentation |

---

## 🎯 2. Purpose, Scope & Objectives

### 2.1 Purpose
The purpose of this Business Continuity Plan (BCP) is to ensure that healthcare delivery, patient safety, and clinical workflows continue without interruption during planned or unplanned outages of the digital HMIS infrastructure. While the Disaster Recovery Plan (DRP) focuses on technical server and database restoration, the BCP focuses on **uninterrupted clinical care at the patient bedside**.

### 2.2 System Scope
This plan governs all hospital units operating SEFU HMIS:
- **Emergency Department & Trauma Unit**
- **Outpatient Clinics (OPD) & Specialty Services** (Pediatrics, Physiotherapy, Gynaecology)
- **Inpatient Care Units (IPD)** (ICU, Maternity, Pediatric, Male/Female Surgical & Medical Wards)
- **Diagnostic Facilities** (Pathology Laboratory, Radiology Imaging)
- **Hospital Pharmacy & Medical Consumables Store**
- **Cashier, Billing & Health Insurance Desk** (Social Health Authority / SHA & Private TPA)

---

## 📊 3. Business Impact Analysis (BIA) & Clinical Criticality

Healthcare workflows cannot tolerate prolonged system unavailability without threatening patient clinical outcomes. The following table identifies core hospital services and their Maximum Tolerable Outage (MTO):

| Critical Clinical Process | MTO (Maximum Tolerable Outage) | Clinical Risk if Interrupted | Fallback Continuity Procedure |
| :--- | :---: | :--- | :--- |
| **Emergency Triage & Resuscitation** | **0 Minutes (Immediate)** | Life-threatening delay in trauma / triage treatment. | Immediate switch to red-tagged manual paper emergency admission forms. |
| **Inpatient Medication Administration** | **15 Minutes** | Delayed or duplicate medication dispensing, missed doses. | Pre-printed paper Medication Administration Records (MAR) kept on ward trolleys. |
| **Diagnostic Lab & Radiology Reporting** | **30 Minutes** | Inability to access stat blood gas, cardiac markers, or imaging. | Verbal telephone / runner authorization followed by manual paper lab requisition. |
| **Operating Theatre Scheduling & Surgery** | **30 Minutes** | Surgical delay, anaesthetic record lapse. | Physical surgical whiteboards and paper operative logbooks. |
| **Outpatient Consultation & Intake** | **1 Hour** | Patient congestion, delayed consultations. | Paper OPD encounter slips; sequential manual queue tokens. |
| **Discharge Billing & Cashier Desk** | **2 Hours** | Delayed inpatient discharge, billing backlog. | Manual carbonized receipt books; deferred final insurance settlement. |

---

## 📝 4. Clinical Downtime Procedures (Paper-Based Contingency)

When SEFU HMIS is unavailable (due to network disruption, server maintenance, or hardware fault), hospital staff immediately activate the **Clinical Downtime Packets**.

### 4.1 Physical Downtime Stationery Boxes
Every nursing station, clinic, pharmacy, and cashier desk maintains a dedicated **Downtime Stationery Box** containing pre-printed, standardized paper forms:
1. **Form DT-01:** Emergency & OPD Patient Registration Intake Voucher.
2. **Form DT-02:** Clinical Consultation & Progress Notes Sheet.
3. **Form DT-03:** Medication Administration Record (MAR) & Prescription Voucher.
4. **Form DT-04:** Diagnostic Laboratory & Radiology Requisition Slip.
5. **Form DT-05:** Inpatient Nursing Kardex & Vitals Flowsheet.
6. **Form DT-06:** Manual Official Hospital Cashier Receipt (Triplicate).

### 4.2 Offline Patient Identification Protocol
To avoid identity confusion during digital downtime:
- Temporary downtime patient IDs follow the format: `DT-[YYYYMMDD]-[WARD]-[SEQ]` (e.g., `DT-20261114-EMR-001`).
- Physical wristbands bearing the temporary downtime number and full patient name are placed on all admitted patients.

---

## ⚡ 5. Physical Infrastructure & Redundancy Safeguards

### 5.1 Power Resilience (Tier 1 Hospital Power Grid)
- **Uninterruptible Power Supplies (UPS):** All central server racks, nurse station terminals, and network switches are connected to enterprise online double-conversion UPS units providing a minimum of **45 minutes** battery runtime.
- **Automated Diesel Generator:** The hospital facility is backed by dual automated backup generators with an automatic transfer switch (ATS) activating within **12 seconds** of utility power failure.
- **Fuel Reserves:** On-site diesel storage guaranteed for a minimum of **7 days** continuous operation.

### 5.2 Network & Internet Redundancy
- **Dual ISP Routing:** Primary high-speed Dedicated Optical Fiber supplemented by automated failover to an enterprise 5G / LTE cellular gateway.
- **Local LAN Survivability:** Internal hospital switches and local Wi-Fi routing remain fully operational even if external internet connection to the cloud or ISP is severed, allowing local server communication.

---

## 🔄 6. Digital Post-Downtime Data Reconciliation (The "Catch-Up" Runbook)

Once SEFU HMIS digital services are fully restored, paper records accumulated during the outage must be systematically transcribed into the database to restore unified digital records:

```
[System Restored] ──► [Audit System Clock & DB Sync] ──► [Initiate Reconciliation Window]
                                                                     │
       ┌────────────────────────┬────────────────────────────────────┴────────────────────────┐
       ▼                        ▼                                                             ▼
[Phase 1: Patient IDs]    [Phase 2: Clinical Data]                                     [Phase 3: Billing & Meds]
Create permanent ID       Transcribe doctor notes, diagnoses,                          Enter pharmacy batches,
and link downtime number  lab results, and operative reports                           receipts, and TPA claims
```

### Step-by-Step Catch-up Protocol:
1. **Declare Service Normalization:** The Lead Incident Commander officially broadcasts that SEFU HMIS is online.
2. **Phase 1 — Master Patient Index (MPI) Reconciliation:**
   - Registration clerks search SEFU HMIS for existing patient files matching the paper name/phone.
   - If new, create the patient record and append the downtime identifier in the medical records notes field.
3. **Phase 2 — Clinical Notes & Prescriptions Entry:**
   - Attending medical officers and clinical transcribers input all Form DT-02 consultation notes, vital signs, and diagnoses.
   - Laboratory technicians enter test parameter outcomes into `admin/pathology` and `admin/radiology`.
4. **Phase 3 — Financial & Pharmacy Stock Settlement:**
   - Pharmacy reconciles physical medicine batch balances dispensed with digital inventory in `admin/pharmacy`.
   - Cashier reconciles physical cash collected against manual receipts and enters official transaction vouchers.
5. **Verification & Audit Signoff:**
   - Nurse in Charge and Medical Superintendent cross-check all physical forms against digital dashboard entries and file physical sheets in the physical hospital medical archive.

---

## 👥 7. Business Continuity Command Structure

| Role | Person Responsible | Core Continuity Duties |
| :--- | :--- | :--- |
| **BCP Director** | Chief Executive Officer (CEO) / COO | Authorizes downtime declaration, interfaces with Ministry of Health & Media. |
| **Clinical Operations Commander** | Medical Superintendent | Coordinates physicians, ensures patient clinical safety, monitors bed capacity. |
| **Nursing Continuity Coordinator** | Chief Nursing Officer (CNO) | Mobilizes ward downtime stationery, ensures manual MAR enforcement. |
| **IT Continuity Lead** | CTO / Lead Systems Administrator | Executes technical recovery, coordinates ISP/power engineers, leads reconciliation. |
| **Communications & Legal Officer** | Hospital PR / Data Protection Officer | Coordinates staff broadcasts, ensures patient data protection compliance. |

---

## 🏃 8. Training, Drills & Maintenance Schedule

- **Staff Onboarding:** Every new clinical and administrative employee receives mandatory training on physical downtime packets.
- **Semi-Annual Tabletop Drills:** Every 6 months, hospital units conduct a simulated 2-hour digital blackout drill to test paper charting, triage speed, and reconciliation accuracy.
- **Annual BCP Audit:** Review of stationery supplies, UPS battery degradation tests, and revision of clinical contact directories.

---

**Approved by:**  
*Hospital Medical Superintendent & Chief Technology Officer*  
*SEFU Health Systems — Kenya Digital Health Agency (DHA) Compliance*

