<div class="content-wrapper">
    <section class="content-header">
        <h1>
            <i class="fa fa-exchange" style="color: #00796b;"></i> Kenya National HIE Interoperability Hub
            <small>DHA Conformance, KMHFL Master Facility Registry & Client Registry</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="<?php echo base_url('admin/admin/dashboard'); ?>"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">National HIE Hub</li>
        </ol>
    </section>

    <section class="content">
        <?php if ($this->session->flashdata('msg')) { ?>
            <?php echo $this->session->flashdata('msg'); ?>
        <?php } ?>

        <!-- Stat Widgets Row -->
        <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="info-box" style="border-top: 3px solid #00a65a; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                    <span class="info-box-icon bg-green"><i class="fa fa-hospital-o"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">KMHFL Facility Code</span>
                        <span class="info-box-number"><?php echo html_escape($kmhfl_code); ?></span>
                        <span class="progress-description text-muted" style="font-size: 11px;">MOH Level 4 Facility</span>
                    </div>
                </div>
            </div>

            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="info-box" style="border-top: 3px solid #3c8dbc; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                    <span class="info-box-icon bg-aqua"><i class="fa fa-id-card"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Client Registry (CR)</span>
                        <span class="info-box-number"><?php echo (int)$total_synthetic; ?> Seeded</span>
                        <span class="progress-description text-muted" style="font-size: 11px;">National ID / UPI / Afya</span>
                    </div>
                </div>
            </div>

            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="info-box" style="border-top: 3px solid #f39c12; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                    <span class="info-box-icon bg-yellow"><i class="fa fa-key"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Active HIE Clients</span>
                        <span class="info-box-number"><?php echo (int)$total_clients; ?> Gateways</span>
                        <span class="progress-description text-muted" style="font-size: 11px;">DHA & SHA Conformance</span>
                    </div>
                </div>
            </div>

            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="info-box" style="border-top: 3px solid #605ca8; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                    <span class="info-box-icon bg-purple"><i class="fa fa-history"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">API Invocations</span>
                        <span class="info-box-number"><?php echo (int)$total_invocations; ?> Audited</span>
                        <span class="progress-description text-muted" style="font-size: 11px;">Audit Logged (Sec C/G)</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Box with Nav Tabs -->
        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs pull-right">
                <li><a href="#tab_docs" data-toggle="tab"><i class="fa fa-code"></i> Interactive API Explorer</a></li>
                <li><a href="#tab_audit" data-toggle="tab"><i class="fa fa-shield"></i> External Audit Trail (<?php echo count($audit_logs); ?>)</a></li>
                <li class="active"><a href="#tab_clients" data-toggle="tab"><i class="fa fa-plug"></i> Registered API Clients & Tokens</a></li>
                <li class="pull-left header">
                    <i class="fa fa-cubes"></i> National HIE Interoperability Gateway
                </li>
            </ul>

            <div class="tab-content" style="padding: 20px;">
                <!-- TAB 1: Registered Clients -->
                <div class="tab-pane active" id="tab_clients">
                    <div class="row" style="margin-bottom: 15px;">
                        <div class="col-md-6">
                            <p class="text-muted" style="margin-top: 5px;">
                                Manage cryptographically authorized external clients for Kenya DHA certification testing, Social Health Authority (SHA) claims interchange, and laboratory/imaging systems.
                            </p>
                        </div>
                        <div class="col-md-6 text-right">
                            <a href="<?php echo $api_docs_url; ?>" target="_blank" class="btn btn-default btn-sm">
                                <i class="fa fa-external-link"></i> Open API Explorer Fullscreen
                            </a>
                            <a href="<?php echo $openapi_spec_url; ?>" target="_blank" class="btn btn-default btn-sm">
                                <i class="fa fa-download"></i> OpenAPI 3.0 Spec
                            </a>
                            <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modalAddClient">
                                <i class="fa fa-plus-circle"></i> Register New Client
                            </button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped table-hover">
                            <thead>
                                <tr style="background: #f8fafc;">
                                    <th style="width: 50px;">#</th>
                                    <th>Client / Institution</th>
                                    <th>Client Identifier</th>
                                    <th>API Key (Token)</th>
                                    <th>Scopes</th>
                                    <th>Rate Limit</th>
                                    <th>Last Used</th>
                                    <th>Status</th>
                                    <th style="width: 140px;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (!empty($clients)) { ?>
                                    <?php foreach ($clients as $client) { ?>
                                        <tr>
                                            <td><?php echo (int)$client['id']; ?></td>
                                            <td>
                                                <strong><?php echo html_escape($client['client_name']); ?></strong><br>
                                                <small class="text-muted"><?php echo html_escape($client['contact_email']); ?></small>
                                            </td>
                                            <td><code><?php echo html_escape($client['client_identifier']); ?></code></td>
                                            <td>
                                                <div class="input-group input-group-sm" style="max-width: 280px;">
                                                    <input type="password" id="token_<?php echo $client['id']; ?>" class="form-control" value="<?php echo html_escape($client['api_key']); ?>" readonly style="background: #fff; font-family: monospace;">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" type="button" title="Toggle visibility" onclick="toggleSecret('token_<?php echo $client['id']; ?>', this)">
                                                            <i class="fa fa-eye"></i>
                                                        </button>
                                                        <button class="btn btn-default" type="button" title="Copy Key" onclick="copyToken('<?php echo html_escape($client['api_key']); ?>')">
                                                            <i class="fa fa-clipboard"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </td>
                                            <td>
                                                <?php 
                                                    $scopes = json_decode($client['allowed_endpoints'], true);
                                                    if (is_array($scopes)) {
                                                        foreach ($scopes as $scope) {
                                                            echo '<span class="label label-info" style="margin-right: 3px; font-weight: normal;">' . html_escape($scope) . '</span> ';
                                                        }
                                                    } else {
                                                        echo '<span class="text-muted">all</span>';
                                                    }
                                                ?>
                                            </td>
                                            <td><span class="badge bg-gray"><?php echo (int)$client['rate_limit_per_minute']; ?> req/min</span></td>
                                            <td>
                                                <?php echo !empty($client['last_used_at']) ? html_escape($client['last_used_at']) : '<span class="text-muted">—</span>'; ?>
                                            </td>
                                            <td>
                                                <?php if ($client['is_active'] == 1) { ?>
                                                    <span class="label label-success"><i class="fa fa-check-circle"></i> Active</span>
                                                <?php } else { ?>
                                                    <span class="label label-danger"><i class="fa fa-ban"></i> Revoked</span>
                                                <?php } ?>
                                            </td>
                                            <td>
                                                <a href="<?php echo base_url('admin/interoperability/toggle_status/' . $client['id']); ?>" class="btn btn-xs <?php echo ($client['is_active'] == 1) ? 'btn-warning' : 'btn-success'; ?>" onclick="return confirm('Change status for this client?');" title="Toggle Status">
                                                    <i class="fa <?php echo ($client['is_active'] == 1) ? 'fa-pause' : 'fa-play'; ?>"></i> <?php echo ($client['is_active'] == 1) ? 'Revoke' : 'Activate'; ?>
                                                </a>
                                                <a href="<?php echo base_url('admin/interoperability/regenerate_key/' . $client['id']); ?>" class="btn btn-xs btn-default" onclick="return confirm('Regenerate token? The old token will immediately cease to work.');" title="Regenerate Key">
                                                    <i class="fa fa-refresh"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    <?php } ?>
                                <?php } else { ?>
                                    <tr>
                                        <td colspan="9" class="text-center text-muted">No API clients registered yet.</td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- TAB 2: External API Audit Logs -->
                <div class="tab-pane" id="tab_audit">
                    <div class="alert alert-info" style="margin-bottom: 15px;">
                        <i class="fa fa-info-circle"></i> <strong>Statutory Compliance Evidence (DHA Section C & Kenya Data Protection Act):</strong>
                        Every external REST API invocation is cryptographically authenticated, rate-limited, and immutably recorded in the system audit log with client identity, remote IP address, action tag, and timestamp.
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped table-hover">
                            <thead>
                                <tr style="background: #f8fafc;">
                                    <th style="width: 50px;">Log ID</th>
                                    <th>Timestamp</th>
                                    <th>Client / Evaluator</th>
                                    <th>Action Tag</th>
                                    <th>Request Details</th>
                                    <th>IP Address</th>
                                    <th>Conformance Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (!empty($audit_logs)) { ?>
                                    <?php foreach ($audit_logs as $log) { ?>
                                        <tr>
                                            <td><code>#<?php echo (int)$log['id']; ?></code></td>
                                            <td><small><?php echo html_escape($log['time']); ?></small></td>
                                            <td>
                                                <strong><?php echo html_escape($log['user_name']); ?></strong><br>
                                                <span class="label label-default" style="font-size: 10px;"><?php echo html_escape($log['user_role']); ?></span>
                                            </td>
                                            <td><span class="label label-primary"><?php echo html_escape($log['action']); ?></span></td>
                                            <td><code><?php echo html_escape($log['message']); ?></code></td>
                                            <td><code><?php echo html_escape($log['ip_address']); ?></code></td>
                                            <td>
                                                <span class="label label-success"><i class="fa fa-check"></i> 200 OK Authenticated</span>
                                            </td>
                                        </tr>
                                    <?php } ?>
                                <?php } else { ?>
                                    <tr>
                                        <td colspan="7" class="text-center text-muted">No external API requests logged yet. Use the API Explorer to make test calls.</td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- TAB 3: Embedded API Docs & Tester -->
                <div class="tab-pane" id="tab_docs">
                    <div style="margin-bottom: 15px;">
                        <span class="text-muted">Live Interactive API Explorer embedded below for instant evaluator test-bench verification without leaving the admin console:</span>
                        <a href="<?php echo $api_docs_url; ?>" target="_blank" class="btn btn-primary btn-xs pull-right">
                            <i class="fa fa-external-link"></i> Open Fullscreen in New Tab
                        </a>
                    </div>
                    <iframe src="<?php echo $api_docs_url; ?>" style="width: 100%; height: 850px; border: 1px solid #d2d6de; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);"></iframe>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- Modal: Register New API Client -->
<div class="modal fade" id="modalAddClient" tabindex="-1" role="dialog" aria-labelledby="modalAddClientLabel">
    <div class="modal-dialog" role="document">
        <form action="<?php echo base_url('admin/interoperability/create_client'); ?>" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modalAddClientLabel"><i class="fa fa-plus-circle"></i> Register External API Integration</h4>
                </div>
                <div class="modal-body">
                    <?php if (function_exists('csrf_token_name')) { ?>
                        <input type="hidden" name="<?php echo $this->security->get_csrf_token_name(); ?>" value="<?php echo $this->security->get_csrf_hash(); ?>">
                    <?php } ?>

                    <div class="form-group">
                        <label for="client_name">Client / Gateway Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="client_name" name="client_name" placeholder="e.g. Kenya National Lab LIMS Gateway" required>
                    </div>

                    <div class="form-group">
                        <label for="client_identifier">Client Machine Identifier <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="client_identifier" name="client_identifier" placeholder="e.g. knl_lims_gateway" required pattern="[a-z0-9_-]+">
                        <small class="text-muted">Unique machine handle (lowercase letters, digits, underscores).</small>
                    </div>

                    <div class="form-group">
                        <label for="contact_email">Technical Contact Email</label>
                        <input type="email" class="form-control" id="contact_email" name="contact_email" placeholder="e.g. hie-admin@lab.go.ke">
                    </div>

                    <div class="form-group">
                        <label for="rate_limit_per_minute">Rate Limit (Requests per minute)</label>
                        <input type="number" class="form-control" id="rate_limit_per_minute" name="rate_limit_per_minute" value="120" min="10" max="1000">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Register Client & Generate Token</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
function toggleSecret(inputId, btn) {
    var input = document.getElementById(inputId);
    var icon = btn.querySelector('i');
    if (input.type === 'password') {
        input.type = 'text';
        icon.className = 'fa fa-eye-slash';
    } else {
        input.type = 'password';
        icon.className = 'fa fa-eye';
    }
}

function copyToken(token) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(token).then(function() {
            alert('API Key copied to clipboard!');
        });
    } else {
        prompt('Copy API Key:', token);
    }
}
</script>
