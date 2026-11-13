<?php
$mysqli = new mysqli('localhost', 'root', '', 'sfu');
if ($mysqli->connect_error) {
    die("Connect error: " . $mysqli->connect_error . "\n");
}

echo "Starting Kenya HIE & REST API Schema Migration...\n";

// 1. Add national_id and upi to patients if not exist
$cols = [];
$res = $mysqli->query("SHOW COLUMNS FROM patients");
while ($row = $res->fetch_assoc()) {
    $cols[] = $row['Field'];
}

if (!in_array('national_id', $cols)) {
    $mysqli->query("ALTER TABLE patients ADD COLUMN national_id VARCHAR(100) NULL AFTER identification_number, ADD INDEX idx_patients_national_id (national_id)");
    echo "[1] Added national_id to patients\n";
} else {
    echo "[1] national_id already exists in patients\n";
}

if (!in_array('upi', $cols)) {
    $mysqli->query("ALTER TABLE patients ADD COLUMN upi VARCHAR(100) NULL AFTER national_id, ADD INDEX idx_patients_upi (upi)");
    echo "[2] Added upi to patients\n";
} else {
    echo "[2] upi already exists in patients\n";
}

// 2. Add kmhfl_code to sch_settings if not exist
$s_cols = [];
$res2 = $mysqli->query("SHOW COLUMNS FROM sch_settings");
while ($row = $res2->fetch_assoc()) {
    $s_cols[] = $row['Field'];
}

if (!in_array('kmhfl_code', $s_cols)) {
    $mysqli->query("ALTER TABLE sch_settings ADD COLUMN kmhfl_code VARCHAR(50) NULL DEFAULT '12345' AFTER dise_code");
    echo "[3] Added kmhfl_code to sch_settings\n";
} else {
    echo "[3] kmhfl_code already exists in sch_settings\n";
}

// 3. Add council_registration_no to staff if not exist
$st_cols = [];
$res3 = $mysqli->query("SHOW COLUMNS FROM staff");
while ($row = $res3->fetch_assoc()) {
    $st_cols[] = $row['Field'];
}

if (!in_array('council_registration_no', $st_cols)) {
    $mysqli->query("ALTER TABLE staff ADD COLUMN council_registration_no VARCHAR(100) NULL AFTER specialist");
    echo "[4] Added council_registration_no to staff\n";
} else {
    echo "[4] council_registration_no already exists in staff\n";
}

// 4. Create api_clients table
$table_sql = "CREATE TABLE IF NOT EXISTS api_clients (
    id INT(11) NOT NULL AUTO_INCREMENT,
    client_name VARCHAR(150) NOT NULL,
    client_identifier VARCHAR(100) NOT NULL UNIQUE,
    api_key VARCHAR(255) NOT NULL UNIQUE,
    allowed_endpoints TEXT NULL,
    rate_limit_per_minute INT(11) NOT NULL DEFAULT 120,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    contact_email VARCHAR(150) NULL,
    last_used_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;";

if ($mysqli->query($table_sql)) {
    echo "[5] Ensured api_clients table exists\n";
} else {
    echo "[5] Error creating api_clients: " . $mysqli->error . "\n";
}

// 5. Seed default DHA test API key
$check = $mysqli->query("SELECT id FROM api_clients WHERE client_identifier = 'dha_conformance_tester'");
if ($check && $check->num_rows == 0) {
    $stmt = $mysqli->prepare("INSERT INTO api_clients (client_name, client_identifier, api_key, allowed_endpoints, is_active, contact_email) VALUES (?, ?, ?, ?, ?, ?)");
    $name = 'Kenya Digital Health Agency (DHA) Conformance Test Suite';
    $ident = 'dha_conformance_tester';
    $key = 'dha_live_test_key_8f3a2b9e4c1d6e7f8a9b0c1d2e3f4a5b';
    $endpoints = '["patients:read","patients:write","encounters:read","encounters:write","billing:read","facility:read"]';
    $active = 1;
    $email = 'interoperability@dha.go.ke';
    $stmt->bind_param('ssssis', $name, $ident, $key, $endpoints, $active, $email);
    $stmt->execute();
    echo "[6] Seeded DHA conformance test API key\n";
} else {
    echo "[6] DHA API client already present\n";
}

// 6. Seed SHA claims gateway key
$check_sha = $mysqli->query("SELECT id FROM api_clients WHERE client_identifier = 'sha_claims_gateway'");
if ($check_sha && $check_sha->num_rows == 0) {
    $stmt = $mysqli->prepare("INSERT INTO api_clients (client_name, client_identifier, api_key, allowed_endpoints, is_active, contact_email) VALUES (?, ?, ?, ?, ?, ?)");
    $name = 'Social Health Authority (SHA) Claims Gateway';
    $ident = 'sha_claims_gateway';
    $key = 'sha_claims_live_key_9941a3bc7e2f50d88190c4e126ab78f0';
    $endpoints = '["patients:read","encounters:read","billing:read"]';
    $active = 1;
    $email = 'claims@sha.go.ke';
    $stmt->bind_param('ssssis', $name, $ident, $key, $endpoints, $active, $email);
    $stmt->execute();
    echo "[7] Seeded SHA claims gateway API key\n";
} else {
    echo "[7] SHA API client already present\n";
}

echo "Migration finished successfully.\n";
