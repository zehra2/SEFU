<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <!-- Header Box -->
                <div class="box box-primary border0 mb10">
                    <div class="box-header with-border">
                        <div class="row">
                            <div class="col-md-8 col-sm-7">
                                <h3 class="box-title" style="font-weight: 700; font-size: 20px;">
                                    <i class="fa fa-stethoscope text-blue"></i> Kenya MOH 705 &amp; IDSR Disease Surveillance Hub
                                </h3>
                                <div style="margin-top: 5px;">
                                    <span class="label label-success" style="font-size: 11px; padding: 3px 8px;">
                                        <i class="fa fa-shield"></i> DHA CONFORMANT (DHA-025)
                                    </span>
                                    <span class="text-muted" style="margin-left: 10px; font-size: 12px;">
                                        <i class="fa fa-hospital-o"></i> <strong><?php echo htmlspecialchars($kpis['facility_name']); ?></strong> 
                                        &bull; KMHFL MFL Code: <span class="label label-default"><?php echo htmlspecialchars($kpis['kmhfl_code']); ?></span>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-5 text-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fa fa-download"></i> Export Statutory CSV <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li><a href="<?php echo base_url('admin/diseasesurveillance/export/moh705a?search_type=' . urlencode($search_type)); ?>"><i class="fa fa-file-excel-o text-green"></i> MOH 705A (Under 5 Years)</a></li>
                                        <li><a href="<?php echo base_url('admin/diseasesurveillance/export/moh705b?search_type=' . urlencode($search_type)); ?>"><i class="fa fa-file-excel-o text-green"></i> MOH 705B (Over 5 Years)</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="<?php echo base_url('admin/diseasesurveillance/export/idsr?search_type=' . urlencode($search_type)); ?>"><i class="fa fa-bullhorn text-red"></i> IDSR Epidemic Alerts</a></li>
                                    </ul>
                                </div>
                                <button type="button" class="btn btn-primary btn-sm" onclick="window.print();" style="margin-left: 5px;">
                                    <i class="fa fa-print"></i> Print Statutory Dossier
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Filter Bar -->
                    <div class="box-body" style="background: #fdfdfd; border-bottom: 1px solid #f0f0f0;">
                        <form role="form" action="<?php echo site_url('admin/diseasesurveillance'); ?>" method="post" class="form-inline">
                            <?php echo $this->customlib->getCSRF(); ?>
                            <div class="form-group" style="margin-right: 15px;">
                                <label for="search_type" style="margin-right: 8px;"><i class="fa fa-calendar"></i> Surveillance Period:</label>
                                <select class="form-control input-sm" name="search_type" id="search_type" onchange="togglePeriodFields(this.value)">
                                    <?php foreach ($searchlist as $key => $searchtext) { ?>
                                        <option value="<?php echo $key ?>" <?php echo ($search_type == $key) ? 'selected' : ''; ?>><?php echo $searchtext ?></option>
                                    <?php } ?>
                                </select>
                            </div>

                            <div id="period_dates" style="display: <?php echo ($search_type == 'period') ? 'inline-block' : 'none'; ?>; margin-right: 15px;">
                                <div class="form-group" style="margin-right: 10px;">
                                    <label style="margin-right: 5px;">From:</label>
                                    <input type="date" name="date_from" value="<?php echo htmlspecialchars($from_date); ?>" class="form-control input-sm">
                                </div>
                                <div class="form-group" style="margin-right: 10px;">
                                    <label style="margin-right: 5px;">To:</label>
                                    <input type="date" name="date_to" value="<?php echo htmlspecialchars($to_date); ?>" class="form-control input-sm">
                                </div>
                            </div>

                            <button type="submit" name="search" class="btn btn-sm btn-info">
                                <i class="fa fa-filter"></i> Apply Filter
                            </button>
                            <?php if ($from_date || $to_date) { ?>
                                <span class="text-muted" style="margin-left: 15px; font-size: 12px;">
                                    Active Filter: <strong><?php echo $from_date ? $from_date : 'Start'; ?></strong> to <strong><?php echo $to_date ? $to_date : 'End'; ?></strong>
                                </span>
                            <?php } else { ?>
                                <span class="text-muted" style="margin-left: 15px; font-size: 12px;">
                                    Active Filter: <strong>All Time Records</strong>
                                </span>
                            <?php } ?>
                        </form>
                    </div>
                </div>

                <!-- KPI Metric Cards -->
                <div class="row">
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="info-box" style="box-shadow: 0 1px 3px rgba(0,0,0,0.1); border-radius: 4px;">
                            <span class="info-box-icon bg-aqua" style="border-radius: 4px 0 0 4px;"><i class="fa fa-child"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text" style="font-weight: 600;">MOH 705A (Under 5)</span>
                                <span class="info-box-number" style="font-size: 24px; color: #00c0ef;"><?php echo number_format($kpis['u5_total_cases']); ?> <small>cases</small></span>
                                <div class="progress" style="height: 3px; margin: 5px 0;">
                                    <div class="progress-bar bg-aqua" style="width: 100%"></div>
                                </div>
                                <span class="progress-description text-muted" style="font-size: 11px;">
                                    <?php echo $moh705a['total_diseases']; ?> distinct diagnostic clusters
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="info-box" style="box-shadow: 0 1px 3px rgba(0,0,0,0.1); border-radius: 4px;">
                            <span class="info-box-icon bg-green" style="border-radius: 4px 0 0 4px;"><i class="fa fa-users"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text" style="font-weight: 600;">MOH 705B (Over 5)</span>
                                <span class="info-box-number" style="font-size: 24px; color: #00a65a;"><?php echo number_format($kpis['o5_total_cases']); ?> <small>cases</small></span>
                                <div class="progress" style="height: 3px; margin: 5px 0;">
                                    <div class="progress-bar bg-green" style="width: 100%"></div>
                                </div>
                                <span class="progress-description text-muted" style="font-size: 11px;">
                                    <?php echo $moh705b['total_diseases']; ?> distinct diagnostic clusters
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="info-box" style="box-shadow: 0 1px 3px rgba(0,0,0,0.1); border-radius: 4px;">
                            <span class="info-box-icon <?php echo ($kpis['active_idsr_alerts'] > 0) ? 'bg-red' : 'bg-gray'; ?>" style="border-radius: 4px 0 0 4px;">
                                <i class="fa fa-bullhorn <?php echo ($kpis['active_idsr_alerts'] > 0) ? 'fa-beat' : ''; ?>"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text" style="font-weight: 600;">IDSR Epidemic Alerts</span>
                                <span class="info-box-number" style="font-size: 24px; color: <?php echo ($kpis['active_idsr_alerts'] > 0) ? '#dd4b39' : '#777'; ?>;">
                                    <?php echo number_format($kpis['active_idsr_alerts']); ?> <small>triggers</small>
                                </span>
                                <div class="progress" style="height: 3px; margin: 5px 0;">
                                    <div class="progress-bar bg-red" style="width: 100%"></div>
                                </div>
                                <span class="progress-description text-muted" style="font-size: 11px;">
                                    <?php echo number_format($kpis['notifiable_cases']); ?> statutory notifiable cases
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="info-box" style="box-shadow: 0 1px 3px rgba(0,0,0,0.1); border-radius: 4px;">
                            <span class="info-box-icon bg-purple" style="border-radius: 4px 0 0 4px;"><i class="fa fa-barcode"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text" style="font-weight: 600;">ICD-10 Coded Rate</span>
                                <span class="info-box-number" style="font-size: 24px; color: #605ca8;">
                                    <?php echo $kpis['icd10_coding_rate']; ?><small>%</small>
                                </span>
                                <div class="progress" style="height: 3px; margin: 5px 0;">
                                    <div class="progress-bar bg-purple" style="width: <?php echo min(100, $kpis['icd10_coding_rate']); ?>%"></div>
                                </div>
                                <span class="progress-description text-muted" style="font-size: 11px;">
                                    <?php echo number_format($kpis['total_morbidity_cases']); ?> standardized diagnoses
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tabbed Reporting Navigation -->
                <div class="nav-tabs-custom" style="box-shadow: 0 1px 3px rgba(0,0,0,0.1); border-radius: 4px;">
                    <ul class="nav nav-tabs" style="font-weight: 600; font-size: 14px;">
                        <li class="active">
                            <a href="#tab_moh705a" data-toggle="tab">
                                <i class="fa fa-child text-aqua"></i> MOH 705A: Under 5 Years
                                <span class="label label-info" style="margin-left: 5px;"><?php echo $moh705a['total_cases']; ?></span>
                            </a>
                        </li>
                        <li>
                            <a href="#tab_moh705b" data-toggle="tab">
                                <i class="fa fa-users text-green"></i> MOH 705B: Over 5 Years
                                <span class="label label-success" style="margin-left: 5px;"><?php echo $moh705b['total_cases']; ?></span>
                            </a>
                        </li>
                        <li>
                            <a href="#tab_idsr" data-toggle="tab">
                                <i class="fa fa-bullhorn text-red"></i> IDSR Epidemic Alerts &amp; Case Registry
                                <?php if ($kpis['active_idsr_alerts'] > 0) { ?>
                                    <span class="label label-danger" style="margin-left: 5px;"><?php echo $kpis['active_idsr_alerts']; ?> ACTIVE</span>
                                <?php } ?>
                            </a>
                        </li>
                        <li class="pull-right header" style="padding-top: 10px;">
                            <span class="text-muted" style="font-size: 12px;">
                                <i class="fa fa-clock-o"></i> Synced with KHIS/DHIS2 Indicators
                            </span>
                        </li>
                    </ul>

                    <div class="tab-content" style="padding: 20px;">
                        <!-- TAB 1: MOH 705A (UNDER 5 YEARS) -->
                        <div class="tab-pane active" id="tab_moh705a">
                            <div class="alert alert-info" style="background-color: #f4f8fb !important; border-left: 4px solid #00c0ef; color: #31708f;">
                                <h4><i class="fa fa-info-circle"></i> Kenya MOH Form 705A &mdash; Under 5 Years Outpatient Summary</h4>
                                <p style="margin-bottom: 0; font-size: 12px;">
                                    Statutory reporting aggregate mandated by the Kenya Ministry of Health for tracking infant and under-five morbidity, mortality causes, malnutrition, and childhood vaccine-preventable diseases. Grouped by standardized WHO/Kenya ICD-10 diagnostic classifications.
                                </p>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr style="background: #f7f9fa; color: #333;">
                                            <th style="width: 50px;" class="text-center">#</th>
                                            <th style="width: 100px;">ICD-10 Code</th>
                                            <th>Disease / Morbidity Condition</th>
                                            <th>Diagnostic Category</th>
                                            <th style="width: 90px;" class="text-center">Male (<5)</th>
                                            <th style="width: 90px;" class="text-center">Female (<5)</th>
                                            <th style="width: 90px;" class="text-center">Total</th>
                                            <th style="width: 140px;">% Morbidity</th>
                                            <th style="width: 100px;" class="text-center">IDSR Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (!empty($moh705a['records'])) { 
                                            $i = 1;
                                            foreach ($moh705a['records'] as $r) { ?>
                                                <tr>
                                                    <td class="text-center text-muted"><?php echo $i++; ?></td>
                                                    <td>
                                                        <span class="label label-primary" style="font-family: monospace; font-size: 11px;">
                                                            <?php echo htmlspecialchars($r['icd10_code']); ?>
                                                        </span>
                                                    </td>
                                                    <td style="font-weight: 600; color: #222;">
                                                        <?php echo htmlspecialchars($r['disease_name']); ?>
                                                    </td>
                                                    <td>
                                                        <span class="text-muted" style="font-size: 12px;">
                                                            <?php echo htmlspecialchars($r['category']); ?>
                                                        </span>
                                                    </td>
                                                    <td class="text-center"><?php echo $r['male_count']; ?></td>
                                                    <td class="text-center"><?php echo $r['female_count']; ?></td>
                                                    <td class="text-center" style="font-weight: 700; color: #00c0ef;">
                                                        <?php echo $r['total_cases']; ?>
                                                    </td>
                                                    <td>
                                                        <div style="display: flex; align-items: center;">
                                                            <div class="progress" style="width: 65px; height: 10px; margin-bottom: 0; margin-right: 8px;">
                                                                <div class="progress-bar progress-bar-aqua" style="width: <?php echo min(100, $r['morbidity_percent']); ?>%"></div>
                                                            </div>
                                                            <span style="font-size: 12px; font-weight: 600;"><?php echo $r['morbidity_percent']; ?>%</span>
                                                        </div>
                                                    </td>
                                                    <td class="text-center">
                                                        <?php if ($r['is_notifiable'] == 1) { ?>
                                                            <span class="label label-danger" style="font-size: 10px;">
                                                                <i class="fa fa-exclamation-triangle"></i> NOTIFIABLE
                                                            </span>
                                                        <?php } else { ?>
                                                            <span class="label label-default" style="font-size: 10px; color: #777;">Routine</span>
                                                        <?php } ?>
                                                    </td>
                                                </tr>
                                            <?php } ?>
                                            <tr style="background: #f0f7fd; font-weight: 700;">
                                                <td colspan="4" class="text-right">SUB-TOTAL (UNDER 5 YEARS):</td>
                                                <td class="text-center">
                                                    <?php 
                                                        $male_u5 = array_sum(array_column($moh705a['records'], 'male_count'));
                                                        echo $male_u5;
                                                    ?>
                                                </td>
                                                <td class="text-center">
                                                    <?php 
                                                        $female_u5 = array_sum(array_column($moh705a['records'], 'female_count'));
                                                        echo $female_u5;
                                                    ?>
                                                </td>
                                                <td class="text-center" style="color: #00c0ef; font-size: 15px;">
                                                    <?php echo $moh705a['total_cases']; ?>
                                                </td>
                                                <td>100.0%</td>
                                                <td></td>
                                            </tr>
                                        <?php } else { ?>
                                            <tr>
                                                <td colspan="9" class="text-center text-muted" style="padding: 30px;">
                                                    <i class="fa fa-folder-open-o fa-2x"></i><br>
                                                    No Under 5 consultation records found for the selected period.
                                                </td>
                                            </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- TAB 2: MOH 705B (OVER 5 YEARS) -->
                        <div class="tab-pane" id="tab_moh705b">
                            <div class="alert alert-success" style="background-color: #f4faf6 !important; border-left: 4px solid #00a65a; color: #3c763d;">
                                <h4><i class="fa fa-info-circle"></i> Kenya MOH Form 705B &mdash; Over 5 Years Outpatient Summary</h4>
                                <p style="margin-bottom: 0; font-size: 12px;">
                                    Statutory reporting aggregate mandated by the Kenya Ministry of Health for tracking adult and adolescent outpatient morbidity, non-communicable diseases (hypertension, diabetes), communicable infections, maternal conditions, and injuries. Grouped by standardized WHO/Kenya ICD-10 diagnostic classifications.
                                </p>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr style="background: #f7f9fa; color: #333;">
                                            <th style="width: 50px;" class="text-center">#</th>
                                            <th style="width: 100px;">ICD-10 Code</th>
                                            <th>Disease / Morbidity Condition</th>
                                            <th>Diagnostic Category</th>
                                            <th style="width: 90px;" class="text-center">Male (>=5)</th>
                                            <th style="width: 90px;" class="text-center">Female (>=5)</th>
                                            <th style="width: 90px;" class="text-center">Total</th>
                                            <th style="width: 140px;">% Morbidity</th>
                                            <th style="width: 100px;" class="text-center">IDSR Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (!empty($moh705b['records'])) { 
                                            $i = 1;
                                            foreach ($moh705b['records'] as $r) { ?>
                                                <tr>
                                                    <td class="text-center text-muted"><?php echo $i++; ?></td>
                                                    <td>
                                                        <span class="label label-primary" style="font-family: monospace; font-size: 11px;">
                                                            <?php echo htmlspecialchars($r['icd10_code']); ?>
                                                        </span>
                                                    </td>
                                                    <td style="font-weight: 600; color: #222;">
                                                        <?php echo htmlspecialchars($r['disease_name']); ?>
                                                    </td>
                                                    <td>
                                                        <span class="text-muted" style="font-size: 12px;">
                                                            <?php echo htmlspecialchars($r['category']); ?>
                                                        </span>
                                                    </td>
                                                    <td class="text-center"><?php echo $r['male_count']; ?></td>
                                                    <td class="text-center"><?php echo $r['female_count']; ?></td>
                                                    <td class="text-center" style="font-weight: 700; color: #00a65a;">
                                                        <?php echo $r['total_cases']; ?>
                                                    </td>
                                                    <td>
                                                        <div style="display: flex; align-items: center;">
                                                            <div class="progress" style="width: 65px; height: 10px; margin-bottom: 0; margin-right: 8px;">
                                                                <div class="progress-bar progress-bar-success" style="width: <?php echo min(100, $r['morbidity_percent']); ?>%"></div>
                                                            </div>
                                                            <span style="font-size: 12px; font-weight: 600;"><?php echo $r['morbidity_percent']; ?>%</span>
                                                        </div>
                                                    </td>
                                                    <td class="text-center">
                                                        <?php if ($r['is_notifiable'] == 1) { ?>
                                                            <span class="label label-danger" style="font-size: 10px;">
                                                                <i class="fa fa-exclamation-triangle"></i> NOTIFIABLE
                                                            </span>
                                                        <?php } else { ?>
                                                            <span class="label label-default" style="font-size: 10px; color: #777;">Routine</span>
                                                        <?php } ?>
                                                    </td>
                                                </tr>
                                            <?php } ?>
                                            <tr style="background: #f4faf6; font-weight: 700;">
                                                <td colspan="4" class="text-right">SUB-TOTAL (OVER 5 YEARS):</td>
                                                <td class="text-center">
                                                    <?php 
                                                        $male_o5 = array_sum(array_column($moh705b['records'], 'male_count'));
                                                        echo $male_o5;
                                                    ?>
                                                </td>
                                                <td class="text-center">
                                                    <?php 
                                                        $female_o5 = array_sum(array_column($moh705b['records'], 'female_count'));
                                                        echo $female_o5;
                                                    ?>
                                                </td>
                                                <td class="text-center" style="color: #00a65a; font-size: 15px;">
                                                    <?php echo $moh705b['total_cases']; ?>
                                                </td>
                                                <td>100.0%</td>
                                                <td></td>
                                            </tr>
                                        <?php } else { ?>
                                            <tr>
                                                <td colspan="9" class="text-center text-muted" style="padding: 30px;">
                                                    <i class="fa fa-folder-open-o fa-2x"></i><br>
                                                    No Over 5 consultation records found for the selected period.
                                                </td>
                                            </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- TAB 3: IDSR EPIDEMIC ALERTS & SURVEILLANCE REGISTRY -->
                        <div class="tab-pane" id="tab_idsr">
                            <div class="alert alert-warning" style="background-color: #fffaf2 !important; border-left: 4px solid #f39c12; color: #8a6d3b;">
                                <h4><i class="fa fa-shield"></i> Kenya National IDSR Protocol &mdash; Epidemic Early Warning &amp; Response</h4>
                                <p style="margin-bottom: 0; font-size: 12px;">
                                    In accordance with Kenya Ministry of Health Integrated Disease Surveillance and Response (IDSR 3rd Edition) guidelines, any encounter matching a notifiable condition triggers an immediate alert. A single case of Cholera, Measles, Anthrax, or Meningitis mandates notification to the Sub-County Disease Surveillance Officer (SC-DSO) within 24 hours via Form MOH 502.
                                </p>
                            </div>

                            <?php if (!empty($idsr['alerts'])) { ?>
                                <?php foreach ($idsr['alerts'] as $idx => $alert) { 
                                    $is_crit = ($alert['severity'] === 'CRITICAL');
                                    $card_border = $is_crit ? '#dd4b39' : '#f39c12';
                                    $card_bg = $is_crit ? '#fff8f8' : '#fffdf9';
                                    $badge_class = $is_crit ? 'label-danger' : 'label-warning';
                                ?>
                                    <div class="box" style="border-top: 3px solid <?php echo $card_border; ?>; background: <?php echo $card_bg; ?>; margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.08);">
                                        <div class="box-header with-border">
                                            <div class="row">
                                                <div class="col-md-8 col-sm-7">
                                                    <h3 class="box-title" style="font-weight: 700; font-size: 16px;">
                                                        <span class="label <?php echo $badge_class; ?>" style="font-size: 12px; padding: 4px 8px; margin-right: 8px;">
                                                            <i class="fa fa-bullhorn"></i> <?php echo $alert['severity']; ?> ALERT
                                                        </span>
                                                        <?php echo htmlspecialchars($alert['disease_name']); ?>
                                                        <span class="label label-primary" style="font-family: monospace; font-size: 12px; margin-left: 8px;">
                                                            ICD-10: <?php echo htmlspecialchars($alert['icd10_code']); ?>
                                                        </span>
                                                    </h3>
                                                    <div style="margin-top: 6px; font-size: 12px; color: #666;">
                                                        <i class="fa fa-tag"></i> Category: <strong><?php echo htmlspecialchars($alert['category']); ?></strong>
                                                        &bull; <i class="fa fa-crosshairs"></i> Threshold: <span class="text-danger"><strong><?php echo htmlspecialchars($alert['threshold_text']); ?></strong></span>
                                                    </div>
                                                </div>
                                                <div class="col-md-4 col-sm-5 text-right">
                                                    <span style="font-size: 26px; font-weight: 700; color: <?php echo $card_border; ?>; vertical-align: middle;">
                                                        <?php echo $alert['case_count']; ?>
                                                    </span>
                                                    <span class="text-muted" style="font-size: 12px; margin-right: 15px;">case(s) flagged</span>
                                                    <button type="button" class="btn btn-xs btn-default" data-toggle="collapse" data-target="#case_table_<?php echo $idx; ?>">
                                                        <i class="fa fa-bars"></i> View Cases
                                                    </button>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="box-body">
                                            <div class="callout" style="background: #fff; border-left: 4px solid <?php echo $card_border; ?>; padding: 8px 12px; margin-bottom: 12px;">
                                                <strong style="color: <?php echo $card_border; ?>;"><i class="fa fa-ambulance"></i> Mandated Statutory Action:</strong>
                                                <span style="font-size: 12px; margin-left: 8px; color: #333;">
                                                    <?php echo htmlspecialchars($alert['action_required']); ?>
                                                </span>
                                            </div>

                                            <div id="case_table_<?php echo $idx; ?>" class="collapse in">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-condensed table-striped" style="background: #fff; font-size: 12px;">
                                                        <thead>
                                                            <tr style="background: #f5f5f5;">
                                                                <th style="width: 40px;" class="text-center">#</th>
                                                                <th>Patient Name &amp; ID</th>
                                                                <th style="width: 80px;">Age / Sex</th>
                                                                <th style="width: 110px;">Contact</th>
                                                                <th style="width: 100px;">Encounter</th>
                                                                <th style="width: 140px;">Encounter Date</th>
                                                                <th>Clinical Notes / Presentation</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <?php foreach ($alert['cases'] as $cidx => $case) { ?>
                                                                <tr>
                                                                    <td class="text-center text-muted"><?php echo $cidx + 1; ?></td>
                                                                    <td>
                                                                        <strong style="color: #337ab7;"><?php echo htmlspecialchars($case['patient_name']); ?></strong>
                                                                        <br><small class="text-muted">PID: #<?php echo $case['patient_id']; ?></small>
                                                                    </td>
                                                                    <td>
                                                                        <?php echo $case['age_years']; ?> yrs / <?php echo substr($case['gender'], 0, 1); ?>
                                                                    </td>
                                                                    <td>
                                                                        <small><?php echo htmlspecialchars($case['mobileno'] ?: 'N/A'); ?></small><br>
                                                                        <small class="text-muted"><?php echo htmlspecialchars($case['address'] ?: 'N/A'); ?></small>
                                                                    </td>
                                                                    <td>
                                                                        <span class="label label-info"><?php echo $case['encounter_type']; ?></span>
                                                                    </td>
                                                                    <td>
                                                                        <i class="fa fa-calendar-check-o text-muted"></i> 
                                                                        <?php echo date('d M Y, H:i', strtotime($case['encounter_date'])); ?>
                                                                    </td>
                                                                    <td style="color: #444;">
                                                                        <?php echo htmlspecialchars($case['clinical_notes'] ?: 'No symptoms recorded'); ?>
                                                                    </td>
                                                                </tr>
                                                            <?php } ?>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <?php } ?>
                            <?php } else { ?>
                                <div class="text-center" style="padding: 40px; background: #fff; border-radius: 4px; border: 1px dashed #ddd;">
                                    <i class="fa fa-check-circle text-green fa-3x"></i>
                                    <h4 style="font-weight: 600; margin-top: 15px; color: #2e6da4;">Zero Epidemic Alerts Detected</h4>
                                    <p class="text-muted" style="max-width: 500px; margin: 0 auto;">
                                        No active cases matching notifiable or outbreak thresholds were identified in the selected reporting window. Facility disease surveillance remains within baseline normal channels.
                                    </p>
                                </div>
                            <?php } ?>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</div>

<!-- Print Stylesheet -->
<style>
@media print {
    .main-header, .main-sidebar, .content-header, .box-header .btn-group, .box-header button, .form-inline, .nav-tabs, .info-box, .btn {
        display: none !important;
    }
    .content-wrapper {
        margin-left: 0 !important;
        padding: 0 !important;
    }
    .box {
        border: none !important;
        box-shadow: none !important;
    }
    .tab-content > .tab-pane {
        display: block !important;
        visibility: visible !important;
        page-break-after: always;
    }
    .table-responsive {
        overflow: visible !important;
    }
}
</style>

<script>
function togglePeriodFields(val) {
    var periodBox = document.getElementById('period_dates');
    if (periodBox) {
        if (val === 'period') {
            periodBox.style.display = 'inline-block';
        } else {
            periodBox.style.display = 'none';
        }
    }
}
</script>
