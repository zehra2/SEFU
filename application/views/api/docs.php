<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SEFU HMIS — Kenya National HIE REST API Explorer & Swagger UI</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/5.11.0/swagger-ui.min.css">
    <style>
        :root {
            --primary: #0F3E6D;
            --primary-dark: #0A2B4C;
            --accent: #008080;
            --success: #28a745;
            --info: #17a2b8;
            --warning: #ffc107;
            --danger: #dc3545;
            --bg-light: #F4F7FA;
            --text-dark: #2C3E50;
            --border-color: #E2E8F0;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.5;
        }
        .navbar-custom {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand-title {
            font-size: 20px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .badge-dha {
            background: #28a745;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .badge-kmhfl {
            background: #17a2b8;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 15px;
            font-size: 13px;
            font-weight: 500;
            padding: 8px 14px;
            border-radius: 6px;
            background: rgba(255,255,255,0.1);
            transition: all 0.2s;
        }
        .nav-links a:hover {
            background: rgba(255,255,255,0.25);
        }
        .container {
            max-width: 1400px;
            margin: 25px auto;
            padding: 0 20px;
        }
        .auth-bar {
            background: white;
            border-radius: 8px;
            padding: 18px 24px;
            margin-bottom: 25px;
            border: 1px solid var(--border-color);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }
        .auth-input-group {
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
            min-width: 320px;
        }
        .auth-input-group label {
            font-weight: 600;
            font-size: 13px;
            color: #4A5568;
            white-space: nowrap;
        }
        .auth-input-group input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #CBD5E0;
            border-radius: 6px;
            font-family: monospace;
            font-size: 13px;
            color: #2D3748;
        }
        .btn {
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-primary { background: var(--primary); color: white; }
        .btn-primary:hover { background: var(--primary-dark); }
        .btn-outline-danger { background: transparent; border: 1px solid var(--danger); color: var(--danger); }
        .btn-outline-danger:hover { background: var(--danger); color: white; }
        .btn-outline-secondary { background: transparent; border: 1px solid #CBD5E0; color: #4A5568; }
        .btn-outline-secondary:hover { background: #EDF2F7; }
        
        /* Tab Navigation */
        .tab-nav {
            display: flex;
            gap: 5px;
            border-bottom: 2px solid #E2E8F0;
            margin-bottom: 20px;
        }
        .tab-btn {
            padding: 12px 24px;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            font-size: 14px;
            font-weight: 600;
            color: #718096;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .tab-btn.active {
            color: var(--primary);
            border-bottom-color: var(--primary);
            background: white;
            border-radius: 6px 6px 0 0;
        }
        
        /* Grid layout for interactive explorer */
        .explorer-grid {
            display: grid;
            grid-template-columns: 420px 1fr;
            gap: 20px;
        }
        @media (max-width: 992px) {
            .explorer-grid { grid-template-columns: 1fr; }
        }
        .endpoint-list {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            padding: 15px;
            max-height: calc(100vh - 250px);
            overflow-y: auto;
        }
        .endpoint-card {
            padding: 12px 14px;
            border-radius: 6px;
            border: 1px solid #EDF2F7;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.2s;
            background: #FAFCFE;
        }
        .endpoint-card:hover, .endpoint-card.active {
            border-color: var(--primary);
            background: #EDF5FD;
            box-shadow: 0 2px 4px rgba(15, 62, 109, 0.08);
        }
        .endpoint-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 4px;
        }
        .method-badge {
            font-size: 11px;
            font-weight: 700;
            padding: 2px 6px;
            border-radius: 4px;
            text-transform: uppercase;
        }
        .method-get { background: #E1F0FF; color: #0066CC; border: 1px solid #B8DCFF; }
        .method-post { background: #E6F8F0; color: #107C41; border: 1px solid #B7EBCE; }
        .endpoint-path {
            font-family: monospace;
            font-size: 12px;
            font-weight: 600;
            color: #2D3748;
            word-break: break-all;
        }
        .endpoint-desc {
            font-size: 11.5px;
            color: #718096;
            margin-top: 2px;
        }

        /* Tester Panel */
        .tester-panel {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .panel-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .panel-desc {
            font-size: 13px;
            color: #4A5568;
            margin-bottom: 20px;
        }
        .form-section {
            margin-bottom: 18px;
        }
        .form-section-title {
            font-size: 13px;
            font-weight: 700;
            color: #2D3748;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .param-row {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
            align-items: center;
        }
        .param-name {
            width: 140px;
            font-family: monospace;
            font-size: 12.5px;
            font-weight: 600;
            color: #4A5568;
        }
        .param-input {
            flex: 1;
            padding: 7px 10px;
            border: 1px solid #CBD5E0;
            border-radius: 5px;
            font-size: 12.5px;
        }
        textarea.body-input {
            width: 100%;
            height: 160px;
            font-family: monospace;
            font-size: 12.5px;
            padding: 10px;
            border: 1px solid #CBD5E0;
            border-radius: 6px;
            background: #FAFCFE;
            resize: vertical;
        }
        .response-container {
            margin-top: 25px;
            border-top: 2px dashed #E2E8F0;
            padding-top: 20px;
        }
        .response-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .status-pill {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
        }
        .status-200, .status-201 { background: #D1E7DD; color: #0F5132; }
        .status-400, .status-422 { background: #FFF3CD; color: #664D03; }
        .status-401, .status-404, .status-409, .status-500 { background: #F8D7DA; color: #842029; }
        pre.response-box {
            background: #1E293B;
            color: #F8FAFC;
            padding: 16px;
            border-radius: 6px;
            font-family: "Courier New", Courier, monospace;
            font-size: 12px;
            max-height: 420px;
            overflow: auto;
            white-space: pre-wrap;
            word-break: break-all;
        }
        .quick-presets {
            margin-bottom: 15px;
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        .btn-preset {
            font-size: 11px;
            padding: 4px 8px;
            border-radius: 4px;
            background: #EDF2F7;
            border: 1px solid #CBD5E0;
            cursor: pointer;
        }
        .btn-preset:hover { background: #E2E8F0; }
        #swagger-ui { background: white; border-radius: 8px; padding: 20px; }
    </style>
</head>
<body>

    <header class="navbar-custom">
        <div class="navbar-brand-title">
            <i class="fas fa-hospital-alt"></i>
            <span><?php echo htmlspecialchars($facility_name); ?> — National HIE REST API Explorer</span>
            <span class="badge-dha">DHA Form HMIS 4</span>
            <span class="badge-kmhfl">KMHFL: <?php echo htmlspecialchars($kmhfl_code); ?></span>
        </div>
        <div class="nav-links">
            <a href="<?php echo $openapi_url; ?>" target="_blank"><i class="fas fa-file-code"></i> OpenAPI 3.0 JSON</a>
            <a href="<?php echo base_url('admin/interoperability'); ?>"><i class="fas fa-cog"></i> Admin HIE Hub</a>
            <a href="<?php echo base_url('admin/admin/dashboard'); ?>"><i class="fas fa-columns"></i> Hospital Dashboard</a>
        </div>
    </header>

    <div class="container">

        <!-- Global Auth Bar -->
        <div class="auth-bar">
            <div class="auth-input-group">
                <label><i class="fas fa-key text-warning"></i> Active Bearer Token / API Key:</label>
                <input type="text" id="globalApiKey" value="<?php echo htmlspecialchars($default_token); ?>" placeholder="Enter API Token">
            </div>
            <div style="display: flex; gap: 8px;">
                <button class="btn btn-outline-secondary" onclick="resetValidToken()"><i class="fas fa-sync-alt"></i> Reset Valid Key</button>
                <button class="btn btn-outline-danger" onclick="testInvalidToken()"><i class="fas fa-ban"></i> Test 401 Rejection</button>
            </div>
        </div>

        <!-- Navigation Tabs -->
        <div class="tab-nav">
            <button class="tab-btn active" id="tabExplorerBtn" onclick="switchTab('explorer')">
                <i class="fas fa-bolt"></i> Interactive Fast-Tester
            </button>
            <button class="tab-btn" id="tabSwaggerBtn" onclick="switchTab('swagger')">
                <i class="fas fa-book-open"></i> Full Swagger UI (OpenAPI 3.0)
            </button>
        </div>

        <!-- TAB 1: INTERACTIVE EXPLORER -->
        <div id="explorerTabContent">
            <div class="explorer-grid">
                
                <!-- Left: Endpoint Selector -->
                <div class="endpoint-list">
                    <div style="font-size: 11px; font-weight: 700; color: #A0AEC0; margin-bottom: 8px; text-transform: uppercase;">
                        Available API Endpoints
                    </div>
                    
                    <div class="endpoint-card active" onclick="loadEndpoint(0)">
                        <div class="endpoint-header">
                            <span class="method-badge method-get">GET</span>
                            <span class="endpoint-path">/facility/info</span>
                        </div>
                        <div class="endpoint-desc">Hospital metadata, KMHFL code, and clinical specialties.</div>
                    </div>

                    <div class="endpoint-card" onclick="loadEndpoint(1)">
                        <div class="endpoint-header">
                            <span class="method-badge method-get">GET</span>
                            <span class="endpoint-path">/patients/search</span>
                        </div>
                        <div class="endpoint-desc">Kenya Client Registry (CR) search by UPI (Afya ID) or National ID.</div>
                    </div>

                    <div class="endpoint-card" onclick="loadEndpoint(2)">
                        <div class="endpoint-header">
                            <span class="method-badge method-get">GET</span>
                            <span class="endpoint-path">/patients/detail/{id}</span>
                        </div>
                        <div class="endpoint-desc">Retrieve single patient demographic record.</div>
                    </div>

                    <div class="endpoint-card" onclick="loadEndpoint(3)">
                        <div class="endpoint-header">
                            <span class="method-badge method-post">POST</span>
                            <span class="endpoint-path">/patients/create</span>
                        </div>
                        <div class="endpoint-desc">Register new patient with auto-UPI & duplicate prevention.</div>
                    </div>

                    <div class="endpoint-card" onclick="loadEndpoint(4)">
                        <div class="endpoint-header">
                            <span class="method-badge method-get">GET</span>
                            <span class="endpoint-path">/encounters/search</span>
                        </div>
                        <div class="endpoint-desc">Query clinical visits (OPD, Physio, Pediatric, Gynae) with vitals.</div>
                    </div>

                    <div class="endpoint-card" onclick="loadEndpoint(5)">
                        <div class="endpoint-header">
                            <span class="method-badge method-post">POST</span>
                            <span class="endpoint-path">/encounters/create</span>
                        </div>
                        <div class="endpoint-desc">Ingest clinical consultation, vitals, and notes.</div>
                    </div>

                    <div class="endpoint-card" onclick="loadEndpoint(6)">
                        <div class="endpoint-header">
                            <span class="method-badge method-get">GET</span>
                            <span class="endpoint-path">/billing/patient/{id}</span>
                        </div>
                        <div class="endpoint-desc">Itemized invoice ledger & Social Health Authority (SHA) claim check.</div>
                    </div>

                    <div class="endpoint-card" onclick="loadEndpoint(7)">
                        <div class="endpoint-header">
                            <span class="method-badge method-get">GET</span>
                            <span class="endpoint-path">/terminology/icd10</span>
                        </div>
                        <div class="endpoint-desc">WHO & Kenya MOH ICD-10 diagnostic coding search.</div>
                    </div>
                </div>

                <!-- Right: Active Endpoint Execution Panel -->
                <div class="tester-panel">
                    <div class="panel-title" id="epTitle">
                        <span class="method-badge method-get" id="epMethodBadge">GET</span>
                        <span id="epPathText">/facility/info</span>
                    </div>
                    <div class="panel-desc" id="epDescText">Returns hospital master identification, KMHFL code, and specialties.</div>

                    <!-- Query Parameters -->
                    <div class="form-section" id="paramsSection">
                        <div class="form-section-title">Query Parameters</div>
                        <div class="quick-presets" id="presetsArea"></div>
                        <div id="paramsInputs"></div>
                    </div>

                    <!-- JSON Body (POST only) -->
                    <div class="form-section" id="bodySection" style="display: none;">
                        <div class="form-section-title">JSON Request Body</div>
                        <textarea class="body-input" id="reqBodyInput"></textarea>
                    </div>

                    <!-- Execution Buttons -->
                    <div style="display: flex; gap: 10px; align-items: center; margin-top: 15px;">
                        <button class="btn btn-primary" onclick="executeApiCall()" id="btnExecute">
                            <i class="fas fa-play"></i> Try It Out / Execute
                        </button>
                        <span id="loadingSpinner" style="display: none; font-size: 13px; color: #718096;">
                            <i class="fas fa-spinner fa-spin"></i> Executing request...
                        </span>
                    </div>

                    <!-- Live Response Box -->
                    <div class="response-container" id="responseArea" style="display: none;">
                        <div class="response-meta">
                            <div>
                                <strong>Response:</strong> &nbsp;
                                <span class="status-pill status-200" id="resStatusBadge">200 OK</span>
                                <span style="font-size: 12px; color: #718096; margin-left: 10px;" id="resTimeText">24 ms</span>
                            </div>
                            <button class="btn btn-outline-secondary" style="padding: 4px 10px; font-size: 11px;" onclick="copyResponseJson()">
                                <i class="fas fa-copy"></i> Copy JSON
                            </button>
                        </div>
                        <pre class="response-box" id="resJsonBox"></pre>
                    </div>
                </div>

            </div>
        </div>

        <!-- TAB 2: SWAGGER UI -->
        <div id="swaggerTabContent" style="display: none;">
            <div id="swagger-ui"></div>
        </div>

    </div>

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/5.11.0/swagger-ui-bundle.min.js"></script>
    <script>
        const BASE_API = "<?php echo $base_api_url; ?>";
        const DEFAULT_TOKEN = "<?php echo $default_token; ?>";

        const endpoints = [
            {
                method: "GET",
                path: "facility/info",
                title: "Hospital & KMHFL Facility Metadata",
                desc: "Returns hospital master identification, KMHFL code (12345), system version, and active clinical specialties.",
                params: []
            },
            {
                method: "GET",
                path: "patients/search",
                title: "Kenya Client Registry (CR) Patient Search",
                desc: "Searches patients by Unique Patient Identifier (UPI / Afya ID), National ID, Phone, or Name.",
                params: [
                    { name: "upi", placeholder: "e.g. AFYA-KE-2026-000010" },
                    { name: "national_id", placeholder: "e.g. 28941725 or 22334455" },
                    { name: "phone", placeholder: "e.g. +254722" },
                    { name: "name", placeholder: "e.g. Beatrice or Juma" }
                ],
                presets: [
                    { label: "Search by UPI (Juma)", field: "upi", value: "AFYA-KE-2026-000010" },
                    { label: "Search by NatID (Beatrice)", field: "national_id", value: "22334455" },
                    { label: "Search all (List 20)", field: "limit", value: "20" }
                ]
            },
            {
                method: "GET",
                path: "patients/detail/{id}",
                title: "Retrieve Patient Demographics",
                desc: "Fetches a single patient profile by internal ID, Afya UPI, or National ID.",
                params: [
                    { name: "{id}", placeholder: "Patient ID, UPI, or National ID (e.g. 10 or AFYA-KE-2026-000010)" }
                ]
            },
            {
                method: "POST",
                path: "patients/create",
                title: "Register New Patient (Duplicate Guard Enforced)",
                desc: "Registers a patient with Kenya Afya UPI generation. If duplicate National ID is sent, returns 409 Conflict.",
                params: [],
                body: JSON.stringify({
                    "patient_name": "Kipchoge Keino Omari",
                    "gender": "Male",
                    "dob": "1988-04-12",
                    "mobileno": "+254722998877",
                    "national_id": "NAT-" + Math.floor(10000000 + Math.random() * 90000000),
                    "address": "Eldoret, Uasin Gishu, Kenya",
                    "blood_group": "B+",
                    "insurance_id": "SHA-POL-7766"
                }, null, 2)
            },
            {
                method: "GET",
                path: "encounters/search",
                title: "Clinical Encounters & Consultations Query",
                desc: "Queries clinical encounters across OPD, IPD, Physiotherapy, Pediatrics, and Gynaecology with vitals and ICD-10 diagnosis.",
                params: [
                    { name: "upi", placeholder: "e.g. AFYA-KE-2026-000011 (Beatrice / Malaria)" },
                    { name: "national_id", placeholder: "e.g. 22334455" },
                    { name: "type", placeholder: "OPD, PHYSIOTHERAPY, PEDIATRIC, GYNAECOLOGY" }
                ],
                presets: [
                    { label: "Malaria Encounter (Beatrice)", field: "upi", value: "AFYA-KE-2026-000011" },
                    { label: "Physio Case (Dennis)", field: "upi", value: "AFYA-KE-2026-000032" },
                    { label: "Pediatric Case (Brian)", field: "upi", value: "AFYA-KE-2026-000020" }
                ]
            },
            {
                method: "POST",
                path: "encounters/create",
                title: "Ingest Clinical Encounter & Vitals",
                desc: "Records a new outpatient encounter or consultation with vital signs.",
                params: [],
                body: JSON.stringify({
                    "patient_id": 10,
                    "doctor_id": 2,
                    "encounter_date": "2026-11-16 11:30:00",
                    "symptoms": "Occipital headache and elevated blood pressure",
                    "bp": "150/95",
                    "height": "175",
                    "weight": "82",
                    "pulse": "80",
                    "temperature": "36.7",
                    "notes": "Essential hypertension follow-up. Enalapril adjusted."
                }, null, 2)
            },
            {
                method: "GET",
                path: "billing/patient/{id}",
                title: "Itemized Billing & SHA Claim Ledger",
                desc: "Queries full patient itemized invoices and Social Health Authority (SHA) claim status.",
                params: [
                    { name: "{id}", placeholder: "Patient ID or UPI (e.g. 10 or 11 or 32)" }
                ],
                presets: [
                    { label: "Patient 10 (Juma)", field: "{id}", value: "10" },
                    { label: "Patient 32 (Physio Case)", field: "{id}", value: "32" }
                ]
            },
            {
                method: "GET",
                path: "terminology/icd10",
                title: "WHO & Kenya MOH ICD-10 Diagnosis Search",
                desc: "Searches 51 standardized Kenya MOH 705/706 diagnostic classifications and notifiable disease indicators.",
                params: [
                    { name: "search", placeholder: "e.g. malaria, pneumonia, hypertension, fracture" },
                    { name: "code", placeholder: "e.g. B50, J18, I10" },
                    { name: "notifiable", placeholder: "1 or 0" }
                ],
                presets: [
                    { label: "Search 'Malaria'", field: "search", value: "malaria" },
                    { label: "Search 'Pneumonia'", field: "search", value: "pneumonia" },
                    { label: "Notifiable Only (1)", field: "notifiable", value: "1" }
                ]
            }
        ];

        let currentEpIdx = 0;

        function loadEndpoint(idx) {
            currentEpIdx = idx;
            const ep = endpoints[idx];
            
            // Highlight card
            document.querySelectorAll(".endpoint-card").forEach((c, i) => {
                c.classList.toggle("active", i === idx);
            });

            document.getElementById("epTitle").innerHTML = `
                <span class="method-badge method-${ep.method.toLowerCase()}">${ep.method}</span>
                <span>/${ep.path}</span>
            `;
            document.getElementById("epDescText").innerText = ep.desc;

            // Handle Params
            const paramsSec = document.getElementById("paramsSection");
            const paramsInputs = document.getElementById("paramsInputs");
            const presetsArea = document.getElementById("presetsArea");
            presetsArea.innerHTML = "";
            paramsInputs.innerHTML = "";

            if (ep.params && ep.params.length > 0) {
                paramsSec.style.display = "block";
                ep.params.forEach(p => {
                    const row = document.createElement("div");
                    row.className = "param-row";
                    row.innerHTML = `
                        <div class="param-name">${p.name}</div>
                        <input type="text" class="param-input" id="param_${p.name}" placeholder="${p.placeholder}">
                    `;
                    paramsInputs.appendChild(row);
                });

                if (ep.presets) {
                    ep.presets.forEach(pr => {
                        const btn = document.createElement("button");
                        btn.className = "btn-preset";
                        btn.innerText = pr.label;
                        btn.onclick = () => {
                            const inp = document.getElementById(`param_${pr.field}`);
                            if (inp) inp.value = pr.value;
                        };
                        presetsArea.appendChild(btn);
                    });
                }
            } else {
                paramsSec.style.display = "none";
            }

            // Handle Body
            const bodySec = document.getElementById("bodySection");
            const bodyInput = document.getElementById("reqBodyInput");
            if (ep.method === "POST") {
                bodySec.style.display = "block";
                bodyInput.value = ep.body || "{}";
            } else {
                bodySec.style.display = "none";
            }

            // Reset Response
            document.getElementById("responseArea").style.display = "none";
        }

        async function executeApiCall() {
            const ep = endpoints[currentEpIdx];
            const token = document.getElementById("globalApiKey").value.trim();
            const spinner = document.getElementById("loadingSpinner");
            const btn = document.getElementById("btnExecute");

            spinner.style.display = "inline";
            btn.disabled = true;

            let resolvedPath = ep.path;
            let queryParams = [];

            // Replace path variables e.g. {id}
            if (ep.params) {
                ep.params.forEach(p => {
                    const input = document.getElementById(`param_${p.name}`);
                    const val = input ? input.value.trim() : "";
                    if (p.name.startsWith("{") && p.name.endsWith("}")) {
                        const cleanKey = p.name.slice(1, -1);
                        resolvedPath = resolvedPath.replace(p.name, encodeURIComponent(val || "10"));
                    } else if (val) {
                        queryParams.push(`${encodeURIComponent(p.name)}=${encodeURIComponent(val)}`);
                    }
                });
            }

            let fullUrl = BASE_API + resolvedPath;
            if (queryParams.length > 0) {
                fullUrl += "?" + queryParams.join("&");
            }

            const headers = {
                "Accept": "application/json"
            };
            if (token) {
                headers["Authorization"] = `Bearer ${token}`;
            }

            let options = {
                method: ep.method,
                headers: headers
            };

            if (ep.method === "POST") {
                headers["Content-Type"] = "application/json";
                options.body = document.getElementById("reqBodyInput").value;
            }

            const startTime = performance.now();
            try {
                const res = await fetch(fullUrl, options);
                const duration = Math.round(performance.now() - startTime);
                const json = await res.json();

                renderResponse(res.status, res.statusText, duration, json);
            } catch (err) {
                const duration = Math.round(performance.now() - startTime);
                renderResponse(0, "Network / Fetch Error", duration, { error: err.message, note: "Check if local Apache server is running." });
            } finally {
                spinner.style.display = "none";
                btn.disabled = false;
            }
        }

        function renderResponse(status, statusText, duration, data) {
            const resArea = document.getElementById("responseArea");
            const badge = document.getElementById("resStatusBadge");
            const timeText = document.getElementById("resTimeText");
            const jsonBox = document.getElementById("resJsonBox");

            badge.className = `status-pill status-${status}`;
            badge.innerText = `${status} ${statusText}`;
            timeText.innerText = `${duration} ms`;
            jsonBox.innerText = JSON.stringify(data, null, 2);

            resArea.style.display = "block";
            resArea.scrollIntoView({ behavior: "smooth", block: "nearest" });
        }

        function copyResponseJson() {
            const text = document.getElementById("resJsonBox").innerText;
            navigator.clipboard.writeText(text).then(() => {
                alert("JSON response copied to clipboard!");
            });
        }

        function resetValidToken() {
            document.getElementById("globalApiKey").value = DEFAULT_TOKEN;
        }

        function testInvalidToken() {
            document.getElementById("globalApiKey").value = "invalid_fake_evaluator_key_000";
            alert("API token set to an invalid key. Click 'Execute' on any endpoint to test HTTP 401 Unauthorized rejection!");
        }

        function switchTab(tab) {
            document.getElementById("tabExplorerBtn").classList.toggle("active", tab === "explorer");
            document.getElementById("tabSwaggerBtn").classList.toggle("active", tab === "swagger");
            document.getElementById("explorerTabContent").style.display = (tab === "explorer") ? "block" : "none";
            document.getElementById("swaggerTabContent").style.display = (tab === "swagger") ? "block" : "none";

            if (tab === "swagger" && !window.swaggerUiLoaded) {
                SwaggerUIBundle({
                    url: "<?php echo $openapi_url; ?>",
                    dom_id: "#swagger-ui",
                    deepLinking: true,
                    presets: [SwaggerUIBundle.presets.apis],
                    layout: "BaseLayout"
                });
                window.swaggerUiLoaded = true;
            }
        }

        // Initialize on page load
        window.onload = function() {
            loadEndpoint(0);
        };
    </script>
</body>
</html>
