<?php
/**
 * Kenya DHA Conformance — ICD-10 National Terminology Registry Migration
 * Creates icd10_codes table and seeds standard Kenya MOH / WHO diagnostic codes.
 * Adds icd10_code columns to clinical encounter tables.
 */

$mysqli = new mysqli('localhost', 'root', '', 'sfu');
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error . "\n");
}
$mysqli->set_charset("utf8");

echo "Starting National Terminology (ICD-10) Registry Migration...\n";

// 1. Create icd10_codes table
$sqlTable = "CREATE TABLE IF NOT EXISTS icd10_codes (
    id INT(11) NOT NULL AUTO_INCREMENT,
    code VARCHAR(20) NOT NULL UNIQUE,
    description VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    moh_indicator VARCHAR(50) NULL,
    is_notifiable TINYINT(1) NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    INDEX idx_icd10_code (code),
    INDEX idx_icd10_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;";

if ($mysqli->query($sqlTable)) {
    echo "[1] Ensured icd10_codes table exists.\n";
} else {
    die("Error creating table: " . $mysqli->error . "\n");
}

// 2. Add icd10_code column to clinical tables if not present
$tables = ['visit_details', 'ipd_details', 'physiotherapy', 'pediatric', 'gynaecology'];
foreach ($tables as $tbl) {
    $cols = [];
    $res = $mysqli->query("SHOW COLUMNS FROM $tbl");
    while ($r = $res->fetch_assoc()) {
        $cols[] = $r['Field'];
    }
    if (!in_array('icd10_code', $cols)) {
        $after = in_array('diagnosis', $cols) ? "AFTER diagnosis" : "AFTER note";
        $mysqli->query("ALTER TABLE $tbl ADD COLUMN icd10_code VARCHAR(20) NULL $after");
        echo "[2] Added icd10_code to $tbl\n";
    } else {
        echo "[2] icd10_code already exists in $tbl\n";
    }
}

// 3. Seed Standard Kenya MOH & WHO ICD-10 Classifications
$icdSeed = [
    // Infectious & Parasitic (MOH 705 Notifiable)
    ['B50.9', 'Plasmodium falciparum malaria, unspecified', 'Infectious Diseases', 'MOH 705A/B', 1],
    ['B54', 'Unspecified malaria', 'Infectious Diseases', 'MOH 705A/B', 1],
    ['A09.0', 'Other and unspecified gastroenteritis and colitis of infectious origin', 'Infectious Diseases', 'MOH 705A', 0],
    ['A01.0', 'Typhoid fever (Salmonella typhi)', 'Infectious Diseases', 'MOH 705A', 1],
    ['A00.9', 'Cholera, unspecified', 'Infectious Diseases', 'MOH 705A', 1],
    ['A08.0', 'Rotaviral enteritis', 'Infectious Diseases', 'MOH 705A', 0],
    ['A15.0', 'Tuberculosis of lung, confirmed by sputum microscopy', 'Infectious Diseases', 'MOH 705A/B', 1],
    ['B20', 'Human immunodeficiency virus [HIV] disease', 'Infectious Diseases', 'MOH 706', 0],
    ['B05.9', 'Measles without complication', 'Infectious Diseases', 'MOH 705A', 1],

    // Respiratory Diseases
    ['J18.9', 'Pneumonia, unspecified organism', 'Respiratory Diseases', 'MOH 705A/B', 0],
    ['J18.1', 'Lobar pneumonia, unspecified', 'Respiratory Diseases', 'MOH 705A/B', 0],
    ['J00', 'Acute nasopharyngitis [common cold]', 'Respiratory Diseases', 'MOH 705A', 0],
    ['J03.9', 'Acute tonsillitis, unspecified', 'Respiratory Diseases', 'MOH 705A', 0],
    ['J20.9', 'Acute bronchitis, unspecified', 'Respiratory Diseases', 'MOH 705A', 0],
    ['J45.9', 'Asthma, unspecified', 'Respiratory Diseases', 'MOH 706', 0],
    ['J44.9', 'Chronic obstructive pulmonary disease, unspecified', 'Respiratory Diseases', 'MOH 706', 0],

    // Cardiovascular Diseases
    ['I10', 'Essential (primary) hypertension', 'Circulatory Diseases', 'MOH 706', 0],
    ['I25.9', 'Chronic ischemic heart disease, unspecified', 'Circulatory Diseases', 'MOH 706', 0],
    ['I50.9', 'Heart failure, unspecified', 'Circulatory Diseases', 'MOH 706', 0],
    ['I64', 'Stroke, not specified as haemorrhage or infarction', 'Circulatory Diseases', 'MOH 706', 0],

    // Endocrine, Nutritional & Metabolic
    ['E11.9', 'Type 2 diabetes mellitus without complications', 'Endocrine & Metabolic', 'MOH 706', 0],
    ['E10.9', 'Type 1 diabetes mellitus without complications', 'Endocrine & Metabolic', 'MOH 706', 0],
    ['E40', 'Kwashiorkor (Severe acute malnutrition)', 'Nutritional Deficiency', 'MOH 705A', 0],
    ['E41', 'Nutritional marasmus', 'Nutritional Deficiency', 'MOH 705A', 0],
    ['E44.0', 'Moderate protein-energy malnutrition (MAM)', 'Nutritional Deficiency', 'MOH 705A', 0],
    ['D50.9', 'Iron deficiency anaemia, unspecified', 'Haematological', 'MOH 705A/B', 0],

    // Digestive Diseases
    ['K27.9', 'Peptic ulcer, unspecified as acute or chronic', 'Digestive Diseases', 'MOH 706', 0],
    ['K29.7', 'Gastritis, unspecified', 'Digestive Diseases', 'MOH 706', 0],
    ['K35.8', 'Other and unspecified acute appendicitis', 'Digestive Diseases', 'MOH 706', 0],
    ['K40.9', 'Unilateral inguinal hernia, without obstruction or gangrene', 'Digestive Diseases', 'MOH 706', 0],

    // Maternal, Obstetric & Gynaecological
    ['O80.0', 'Spontaneous vertex delivery (Normal delivery)', 'Pregnancy & Childbirth', 'MOH 711', 0],
    ['O21.0', 'Mild hyperemesis gravidarum', 'Pregnancy & Childbirth', 'MOH 711', 0],
    ['O14.9', 'Pre-eclampsia, unspecified', 'Pregnancy & Childbirth', 'MOH 711', 1],
    ['O03.9', 'Complete or unspecified spontaneous abortion', 'Pregnancy & Childbirth', 'MOH 711', 0],
    ['N73.9', 'Female pelvic inflammatory disease, unspecified', 'Genitourinary Diseases', 'MOH 706', 0],
    ['D25.9', 'Leiomyoma of uterus, unspecified (Fibroids)', 'Neoplasms / Benign', 'MOH 706', 0],
    ['N76.0', 'Acute vaginitis', 'Genitourinary Diseases', 'MOH 706', 0],
    ['Z34.0', 'Supervision of normal first pregnancy (Antenatal)', 'Health Encounters', 'MOH 710', 0],
    ['Z30.0', 'General counseling and advice on contraception', 'Health Encounters', 'MOH 710', 0],

    // Musculoskeletal & Rehabilitation
    ['M54.5', 'Low back pain (Lumbago)', 'Musculoskeletal', 'MOH 706', 0],
    ['M51.2', 'Other specified intervertebral disc displacement', 'Musculoskeletal', 'MOH 706', 0],
    ['M17.9', 'Osteoarthritis of knee, unspecified', 'Musculoskeletal', 'MOH 706', 0],
    ['M75.0', 'Adhesive capsulitis of shoulder (Frozen shoulder)', 'Musculoskeletal', 'MOH 706', 0],
    ['M47.8', 'Other spondylosis (Cervical spondylosis)', 'Musculoskeletal', 'MOH 706', 0],
    ['G81.9', 'Hemiplegia, unspecified (Post-stroke rehabilitation)', 'Nervous System', 'MOH 706', 0],

    // Injuries, Trauma & Poisonings
    ['S72.0', 'Fracture of neck of femur', 'Injury & Trauma', 'MOH 706', 0],
    ['S72.3', 'Fracture of shaft of femur', 'Injury & Trauma', 'MOH 706', 0],
    ['S83.5', 'Sprain and strain involving anterior cruciate ligament (ACL)', 'Injury & Trauma', 'MOH 706', 0],
    ['T14.0', 'Superficial injury of unspecified body region', 'Injury & Trauma', 'MOH 705A/B', 0],
    ['T14.1', 'Open wound of unspecified body region', 'Injury & Trauma', 'MOH 705A/B', 0],
    ['T30.0', 'Burn of unspecified body region, unspecified degree', 'Injury & Trauma', 'MOH 705A/B', 0]
];

$stmt = $mysqli->prepare("INSERT INTO icd10_codes (code, description, category, moh_indicator, is_notifiable) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE description=VALUES(description), category=VALUES(category), moh_indicator=VALUES(moh_indicator), is_notifiable=VALUES(is_notifiable)");

foreach ($icdSeed as $row) {
    $code = $row[0];
    $desc = $row[1];
    $cat = $row[2];
    $moh = $row[3];
    $notif = $row[4];
    $stmt->bind_param('ssssi', $code, $desc, $cat, $moh, $notif);
    $stmt->execute();
}
echo "[3] Seeded " . count($icdSeed) . " standardized WHO & Kenya MOH ICD-10 diagnostic classifications.\n";

// 4. Update existing seeded clinical encounters with exact ICD-10 codes
echo "[4] Mapping ICD-10 codes to existing clinical encounters...\n";

// Update visit_details
$mysqli->query("UPDATE visit_details SET icd10_code = 'I10' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 10)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'B50.9' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 11)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'K27.9' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 12)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'M17.9' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 13)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'J18.1' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 14)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'A09.0' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 15)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'I10' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 16)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'A01.0' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 17)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'S72.3' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 18)");
$mysqli->query("UPDATE visit_details SET icd10_code = 'E11.9' WHERE opd_details_id IN (SELECT id FROM opd_details WHERE patient_id = 19)");

// Update IPD details
$mysqli->query("UPDATE ipd_details SET icd10_code = 'J18.1' WHERE patient_id = 14");
$mysqli->query("UPDATE ipd_details SET icd10_code = 'A09.0' WHERE patient_id = 15");
$mysqli->query("UPDATE ipd_details SET icd10_code = 'S72.3' WHERE patient_id = 18");
$mysqli->query("UPDATE ipd_details SET icd10_code = 'B50.9' WHERE patient_id = 24");

// Update Physiotherapy
$mysqli->query("UPDATE physiotherapy SET icd10_code = 'M51.2' WHERE patient_id = 32");
$mysqli->query("UPDATE physiotherapy SET icd10_code = 'G81.9' WHERE patient_id = 33");
$mysqli->query("UPDATE physiotherapy SET icd10_code = 'S83.5' WHERE patient_id = 34");
$mysqli->query("UPDATE physiotherapy SET icd10_code = 'M47.8' WHERE patient_id = 35");
$mysqli->query("UPDATE physiotherapy SET icd10_code = 'M75.0' WHERE patient_id = 36");
$mysqli->query("UPDATE physiotherapy SET icd10_code = 'M17.9' WHERE patient_id = 37");

// Update Pediatrics
$mysqli->query("UPDATE pediatric SET icd10_code = 'A08.0' WHERE patient_id = 20");
$mysqli->query("UPDATE pediatric SET icd10_code = 'J03.9' WHERE patient_id = 21");
$mysqli->query("UPDATE pediatric SET icd10_code = 'J45.9' WHERE patient_id = 22");
$mysqli->query("UPDATE pediatric SET icd10_code = 'Z34.0' WHERE patient_id = 23");
$mysqli->query("UPDATE pediatric SET icd10_code = 'B50.9' WHERE patient_id = 24");
$mysqli->query("UPDATE pediatric SET icd10_code = 'E44.0' WHERE patient_id = 25");

// Update Gynaecology
$mysqli->query("UPDATE gynaecology SET icd10_code = 'Z34.0' WHERE patient_id = 26");
$mysqli->query("UPDATE gynaecology SET icd10_code = 'O80.0' WHERE patient_id = 27");
$mysqli->query("UPDATE gynaecology SET icd10_code = 'N73.9' WHERE patient_id = 28");
$mysqli->query("UPDATE gynaecology SET icd10_code = 'D25.9' WHERE patient_id = 29");
$mysqli->query("UPDATE gynaecology SET icd10_code = 'O21.0' WHERE patient_id = 30");
$mysqli->query("UPDATE gynaecology SET icd10_code = 'Z30.0' WHERE patient_id = 31");

echo "  -> Encounters linked with standardized ICD-10 diagnostic codes.\n";
echo "Migration finished successfully.\n";
