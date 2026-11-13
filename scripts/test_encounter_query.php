<?php
$m = new mysqli('localhost', 'root', '', 'sfu');
if ($m->connect_error) die($m->connect_error);

echo "1. Testing OPD join query...\n";
$sql = "SELECT v.*, o.patient_id, p.patient_name, p.national_id, p.upi, p.gender, s.name as doctor_name, s.surname as doctor_surname, s.council_registration_no as doctor_license FROM visit_details v JOIN opd_details o ON o.id = v.opd_details_id JOIN patients p ON p.id = o.patient_id LEFT JOIN staff s ON s.id = v.cons_doctor WHERE o.patient_id IN (2)";
$res = $m->query($sql);
if (!$res) echo "OPD Error: " . $m->error . "\n";
else echo "OPD Rows: " . $res->num_rows . "\n";

echo "2. Testing Physio query...\n";
$sql2 = "SELECT pt.*, p.patient_name, p.national_id, p.upi, p.gender, s.name as doctor_name, s.surname as doctor_surname, s.council_registration_no as doctor_license FROM physiotherapy pt JOIN patients p ON p.id = pt.patient_id LEFT JOIN staff s ON s.id = pt.physiotherapist_id WHERE pt.patient_id IN (2)";
$res2 = $m->query($sql2);
if (!$res2) echo "Physio Error: " . $m->error . "\n";
else echo "Physio Rows: " . $res2->num_rows . "\n";

echo "3. Testing Pediatric query...\n";
$sql3 = "SELECT ped.*, p.patient_name, p.national_id, p.upi, p.gender, s.name as doctor_name, s.surname as doctor_surname, s.council_registration_no as doctor_license FROM pediatric ped JOIN patients p ON p.id = ped.patient_id LEFT JOIN staff s ON s.id = ped.pediatrician_id WHERE ped.patient_id IN (2)";
$res3 = $m->query($sql3);
if (!$res3) echo "Pediatric Error: " . $m->error . "\n";
else echo "Pediatric Rows: " . $res3->num_rows . "\n";

echo "4. Testing Gynae query...\n";
$sql4 = "SELECT gyn.*, p.patient_name, p.national_id, p.upi, p.gender, s.name as doctor_name, s.surname as doctor_surname, s.council_registration_no as doctor_license FROM gynaecology gyn JOIN patients p ON p.id = gyn.patient_id LEFT JOIN staff s ON s.id = gyn.consultant_doctor_id WHERE gyn.patient_id IN (2)";
$res4 = $m->query($sql4);
if (!$res4) echo "Gynae Error: " . $m->error . "\n";
else echo "Gynae Rows: " . $res4->num_rows . "\n";

