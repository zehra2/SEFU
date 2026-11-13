<?php
/**
 * Kenya Digital Health Agency (DHA) - Section G & HIE Interoperability Conformance Test Suite
 * Validates REST API authentication, FHIR-compliant payloads, Client Registry UPI mapping,
 * KMHFL facility context, encounters, itemized billing, and audit trail generation.
 */

$baseUrl = "http://localhost/sfu/api/v1";
$validToken = "dha_live_test_key_8f3a2b9e4c1d6e7f8a9b0c1d2e3f4a5b";
$passed = 0;
$failed = 0;

echo "========================================================================\n";
echo "SEFU HMIS — KENYA HIE & REST API CONFORMANCE TEST SUITE\n";
echo "Target Regulation: Kenya DHA Certification Framework (Form HMIS 4, Section G)\n";
echo "========================================================================\n\n";

function make_request($method, $url, $headers = [], $body = null) {
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    if ($body) {
        curl_setopt($ch, CURLOPT_POSTFIELDS, $body);
    }
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    return ['code' => $httpCode, 'body' => $response, 'json' => json_decode($response, true)];
}

// TEST 1: Unauthenticated request should return 401
echo "[TEST 1] Testing Unauthenticated Request Rejection...\n";
$res1 = make_request("GET", "$baseUrl/facility/info");
if ($res1['code'] === 401 && isset($res1['json']['status']) && $res1['json']['status'] === 'error') {
    echo "  [PASS] Correctly rejected unauthenticated request with HTTP 401\n";
    $passed++;
} else {
    echo "  [FAIL] Expected 401, got " . $res1['code'] . "\n";
    $failed++;
}

// TEST 2: Invalid Bearer token should return 401
echo "[TEST 2] Testing Invalid Bearer Token Rejection...\n";
$res2 = make_request("GET", "$baseUrl/facility/info", ["Authorization: Bearer invalid_fake_token_123"]);
if ($res2['code'] === 401) {
    echo "  [PASS] Correctly rejected invalid token with HTTP 401\n";
    $passed++;
} else {
    echo "  [FAIL] Expected 401, got " . $res2['code'] . "\n";
    $failed++;
}

// TEST 3: Authenticated Facility Info with KMHFL Code
echo "[TEST 3] Testing Authenticated Facility Info & KMHFL Registry...\n";
$res3 = make_request("GET", "$baseUrl/facility/info", ["Authorization: Bearer $validToken"]);
if ($res3['code'] === 200 && !empty($res3['json']['facility_kmhfl']) && !empty($res3['json']['data']['facility_name'])) {
    echo "  [PASS] Facility metadata returned. KMHFL: " . $res3['json']['facility_kmhfl'] . " | Name: " . $res3['json']['data']['facility_name'] . "\n";
    $passed++;
} else {
    echo "  [FAIL] Facility metadata failed or KMHFL code missing.\n";
    $failed++;
}

// TEST 4: Patient Search by Kenya Client Registry UPI
echo "[TEST 4] Testing Kenya Client Registry (CR) Patient Search by UPI...\n";
$res4 = make_request("GET", "$baseUrl/patients/search?upi=AFYA-KE-2026-0001", ["Authorization: Bearer $validToken"]);
if ($res4['code'] === 200 && isset($res4['json']['data']['total_matches']) && $res4['json']['data']['total_matches'] >= 1) {
    $p = $res4['json']['data']['patients'][0];
    echo "  [PASS] Patient found by UPI (" . $p['identifiers'][0]['value'] . "). Name: " . $p['name'] . "\n";
    $passed++;
} else {
    echo "  [FAIL] Could not locate patient by UPI AFYA-KE-2026-0001\n";
    $failed++;
}

// TEST 5: Patient Search by Kenya National ID
echo "[TEST 5] Testing Patient Search by National ID...\n";
$res5 = make_request("GET", "$baseUrl/patients/search?national_id=28941725", ["Authorization: Bearer $validToken"]);
if ($res5['code'] === 200 && isset($res5['json']['data']['total_matches']) && $res5['json']['data']['total_matches'] >= 1) {
    $p = $res5['json']['data']['patients'][0];
    echo "  [PASS] Patient found by National ID (" . $p['identifiers'][1]['value'] . "). Name: " . $p['name'] . "\n";
    $passed++;
} else {
    echo "  [FAIL] Could not locate patient by National ID 28941725\n";
    $failed++;
}

// TEST 6: Patient Registration via JSON REST API
echo "[TEST 6] Testing New Patient Registration via API...\n";
$uniqueNatId = "NAT-" . time();
$newPatientPayload = json_encode([
    'patient_name' => 'Kipchoge Keino Omari',
    'gender'       => 'Male',
    'dob'          => '1988-04-12',
    'mobileno'     => '+254722' . rand(100000, 999999),
    'national_id'  => $uniqueNatId,
    'address'      => 'Eldoret / Nairobi, Kenya',
    'blood_group'  => 'B+',
    'insurance_id' => 'SHA-POL-' . rand(1000, 9999)
]);
$res6 = make_request("POST", "$baseUrl/patients/create", [
    "Authorization: Bearer $validToken",
    "Content-Type: application/json"
], $newPatientPayload);

$createdPatientId = null;
$createdUpi = null;
if ($res6['code'] === 201 && !empty($res6['json']['data']['id'])) {
    $createdPatientId = $res6['json']['data']['id'];
    $createdUpi = $res6['json']['data']['identifiers'][0]['value'];
    echo "  [PASS] Registered patient via API. ID: #$createdPatientId | UPI: $createdUpi | Nat ID: $uniqueNatId\n";
    $passed++;
} else {
    echo "  [FAIL] Registration failed. Code: " . $res6['code'] . " - " . $res6['body'] . "\n";
    $failed++;
}

// TEST 7: Duplicate Prevention on National ID
echo "[TEST 7] Testing Duplicate Prevention on National ID...\n";
$res7 = make_request("POST", "$baseUrl/patients/create", [
    "Authorization: Bearer $validToken",
    "Content-Type: application/json"
], $newPatientPayload);
if ($res7['code'] === 409) {
    echo "  [PASS] Duplicate National ID blocked with HTTP 409 Conflict\n";
    $passed++;
} else {
    echo "  [FAIL] Expected 409 Conflict on duplicate National ID, got " . $res7['code'] . "\n";
    $failed++;
}

// TEST 8: Clinical Encounter Creation via API
echo "[TEST 8] Testing Clinical Encounter Creation via API...\n";
if ($createdPatientId) {
    $encPayload = json_encode([
        'patient_id'     => $createdPatientId,
        'doctor_id'      => 1,
        'encounter_date' => date('Y-m-d H:i:s'),
        'symptoms'       => 'Joint pain, stiffness after training',
        'bp'             => '118/76',
        'height'         => '172',
        'weight'         => '65',
        'pulse'          => '62',
        'temperature'    => '36.8',
        'notes'          => 'Physiotherapy rehabilitation prescribed. Cold compression 20 mins.'
    ]);
    $res8 = make_request("POST", "$baseUrl/encounters/create", [
        "Authorization: Bearer $validToken",
        "Content-Type: application/json"
    ], $encPayload);
    if ($res8['code'] === 201 && !empty($res8['json']['data']['encounter_reference'])) {
        echo "  [PASS] Encounter created. Ref: " . $res8['json']['data']['encounter_reference'] . "\n";
        $passed++;
    } else {
        echo "  [FAIL] Encounter creation failed. Code: " . $res8['code'] . "\n";
        $failed++;
    }
}

// TEST 9: Encounter Query by Patient UPI
echo "[TEST 9] Testing Clinical Encounter Retrieval by UPI...\n";
if ($createdUpi) {
    $res9 = make_request("GET", "$baseUrl/encounters/search?upi=$createdUpi", ["Authorization: Bearer $validToken"]);
    if ($res9['code'] === 200 && count($res9['json']['data']['encounters']) >= 1) {
        $enc = $res9['json']['data']['encounters'][0];
        echo "  [PASS] Encounters queried by UPI. Found " . count($res9['json']['data']['encounters']) . " record(s). Type: " . $enc['type'] . "\n";
        $passed++;
    } else {
        echo "  [FAIL] Encounter query by UPI failed.\n";
        $failed++;
    }
}

// TEST 10: Itemized Billing & SHA Claim Ledger Retrieval
echo "[TEST 10] Testing Itemized Billing & SHA Claim Ledger Retrieval...\n";
$res10 = make_request("GET", "$baseUrl/billing/patient/2", ["Authorization: Bearer $validToken"]);
if ($res10['code'] === 200 && isset($res10['json']['data']['resourceType']) && $res10['json']['data']['resourceType'] === 'Claim') {
    $b = $res10['json']['data'];
    echo "  [PASS] Claim ledger retrieved. Facility: " . $b['facility_kmhfl'] . " | Currency: " . $b['currency'] . " | SHA Eligible: " . ($b['patient']['sha_eligible'] ? 'YES' : 'NO') . "\n";
    $passed++;
} else {
    echo "  [FAIL] Billing ledger query failed.\n";
    $failed++;
}

// TEST 11: Audit Trail Verification for API Operations
echo "[TEST 11] Verifying System Audit Trail for API Invocations...\n";
$mysqli = new mysqli('localhost', 'root', '', 'sfu');
$auditCheck = $mysqli->query("SELECT id, message, user_name, user_role, ip_address FROM logs WHERE user_type = 'API_CLIENT' ORDER BY id DESC LIMIT 1");
if ($auditCheck && $auditCheck->num_rows > 0) {
    $logRow = $auditCheck->fetch_assoc();
    echo "  [PASS] Verified API audit log: #" . $logRow['id'] . " | " . $logRow['message'] . " | Role: " . $logRow['user_role'] . "\n";
    $passed++;
} else {
    echo "  [FAIL] No API_CLIENT entries found in logs table.\n";
    $failed++;
}

echo "\n========================================================================\n";
echo "CONFORMANCE TEST SUMMARY: $passed PASSED | $failed FAILED\n";
echo "RESULT: " . ($failed === 0 ? "100% PASS - READY FOR DHA SECTION G EVALUATION" : "FAIL") . "\n";
echo "========================================================================\n";

