<?php
$pdo = new PDO('mysql:host=127.0.0.1;dbname=sfu', 'root', '');

// Check if Measles case exists
$check2 = $pdo->query("SELECT id FROM visit_details WHERE icd10_code = 'B05.9'");
if ($check2 && $check2->rowCount() == 0) {
    // Check if patient 21 has opd_details
    $stmt2 = $pdo->query("SELECT id FROM opd_details WHERE patient_id = 21 LIMIT 1");
    $opd2 = $stmt2->fetch(PDO::FETCH_ASSOC);
    if (!$opd2) {
        $pdo->exec("INSERT INTO case_references () VALUES ()");
        $case_id = $pdo->lastInsertId();
        $pdo->exec("INSERT INTO opd_details (patient_id, case_reference_id) VALUES (21, $case_id)");
        $opd_id2 = $pdo->lastInsertId();
    } else {
        $opd_id2 = $opd2['id'];
    }
    $pdo->exec("INSERT INTO visit_details (opd_details_id, cons_doctor, appointment_date, symptoms, bp, height, weight, pulse, temperature, note, payment_mode, generated_by, icd10_code, created_at)
                VALUES ($opd_id2, 3, '2026-11-14 09:40:00', 'High fever 39.5C, generalized maculopapular rash, Koplik spots on buccal mucosa, conjunctivitis, barking cough', '95/65', '85', '12', '120', '39.5', 'Measles case isolated. Vitamin A administered.', 'Cash', 1, 'B05.9', '2026-11-14 09:40:00')");
    echo "Added Measles test encounter (ICD-10: B05.9)\n";
}
