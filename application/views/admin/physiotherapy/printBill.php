<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
?>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><?php echo $this->lang->line('physiotherapy_bill'); ?></title>
        <style type="text/css">
            .printablea4{width: 100%;}
            .printablea4>tbody>tr>th,
            .printablea4>tbody>tr>td{padding:4px 6px; line-height: 1.42857143; vertical-align: top; font-size: 12px;}
            .divider { border-top: 1px solid #ccc; margin: 8px 0; }
            .bill-title { text-align: center; font-size: 16px; font-weight: bold; margin: 10px 0; }
            .table-charge { width: 100%; border-collapse: collapse; margin-top: 12px; }
            .table-charge th, .table-charge td { border: 1px solid #ddd; padding: 6px 8px; font-size: 12px; }
            .table-charge th { background-color: #f7f7f7; font-weight: bold; }
        </style>
    </head>
    <body>
        <div class="fixed-print-header">
            <?php if (!empty($print_setting[0]['print_header'])) { ?>
                <div>
                    <img src="<?php echo base_url() . $print_setting[0]['print_header'] . img_time(); ?>" class="img-responsive" style="height:100px; width: 100%;">
                </div>
            <?php } ?>
        </div>

        <table class="table-print-full" width="100%">
            <thead>
                <tr>
                    <td><div class="header-space">&nbsp;</div></td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="content-body">
                            <div id="html-2-pdfwrapper">
                                <div class="bill-title"><?php echo $this->lang->line('physiotherapy_bill'); ?></div>
                                <table width="100%" class="printablea4">
                                    <tr>
                                        <td class="text-left"><b><?php echo $this->lang->line('bill_no'); ?>:</b> <?php echo (!empty($result['bill_no'])) ? $result['bill_no'] : ($this->customlib->getSessionPrefixByType('physiotherapy_billing') . $result["id"]); ?></td>
                                        <td class="text-right"><b><?php echo $this->lang->line('session_date'); ?>:</b> <?php echo $result['session_date_formatted']; ?></td>
                                    </tr>
                                </table>
                                <div class="divider"></div>

                                <table class="printablea4" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <th width="20%"><?php echo $this->lang->line('patient_name'); ?></th>
                                        <td width="30%"><?php echo $result['patient_name'] . " (" . $result['pid'] . ")"; ?></td>
                                        <th width="20%"><?php echo $this->lang->line('physiotherapist'); ?></th>
                                        <td width="30%"><?php echo $result['physiotherapist_name']; ?></td>
                                    </tr>
                                    <tr>
                                        <th><?php echo $this->lang->line('gender'); ?> / <?php echo $this->lang->line('age'); ?></th>
                                        <td><?php echo $result['gender'] . " / " . $result['patient_age']; ?></td>
                                        <th><?php echo $this->lang->line('referring_doctor'); ?></th>
                                        <td><?php echo (!empty($result['referring_doctor'])) ? $result['referring_doctor'] : '-'; ?></td>
                                    </tr>
                                    <tr>
                                        <th><?php echo $this->lang->line('phone'); ?></th>
                                        <td><?php echo (!empty($result['mobileno'])) ? $result['mobileno'] : '-'; ?></td>
                                        <th><?php echo $this->lang->line('session_duration'); ?></th>
                                        <td><?php echo (!empty($result['session_duration'])) ? $result['session_duration'] : '-'; ?></td>
                                    </tr>
                                    <tr>
                                        <th><?php echo $this->lang->line('height'); ?> / <?php echo $this->lang->line('weight'); ?> / <?php echo $this->lang->line('bp'); ?></th>
                                        <td><?php echo "H: " . ($result['height'] ?: '-') . " | W: " . ($result['weight'] ?: '-') . " | BP: " . ($result['bp'] ?: '-'); ?></td>
                                        <th><?php echo $this->lang->line('pain_level_and_location'); ?></th>
                                        <td>Level <?php echo ($result['pain_level'] ?: '-'); ?> (<?php echo ($result['pain_location'] ?: '-'); ?>)</td>
                                    </tr>
                                    <tr>
                                        <th><?php echo $this->lang->line('diagnosis'); ?></th>
                                        <td colspan="3"><?php echo (!empty($result['diagnosis'])) ? $result['diagnosis'] : '-'; ?></td>
                                    </tr>
                                    <tr>
                                        <th><?php echo $this->lang->line('assessment_treatment'); ?></th>
                                        <td colspan="3"><?php echo (!empty($result['assessment_treatment'])) ? $result['assessment_treatment'] : '-'; ?></td>
                                    </tr>
                                    <?php if (!empty($result['physiotherapy_assessment'])) { ?>
                                    <tr>
                                        <th><?php echo $this->lang->line('physiotherapy_assessment'); ?></th>
                                        <td colspan="3"><?php echo nl2br($result['physiotherapy_assessment']); ?></td>
                                    </tr>
                                    <?php } ?>
                                    <?php if (!empty($result['treatment_exercise'])) { ?>
                                    <tr>
                                        <th><?php echo $this->lang->line('treatment_exercise'); ?></th>
                                        <td colspan="3"><?php echo nl2br($result['treatment_exercise']); ?></td>
                                    </tr>
                                    <?php } ?>
                                </table>

                                <!-- Charge Table -->
                                <table class="table-charge">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th><?php echo $this->lang->line('description'); ?></th>
                                            <th class="text-right"><?php echo $this->lang->line('standard_charge') . ' (' . $currency_symbol . ')'; ?></th>
                                            <th class="text-right"><?php echo $this->lang->line('applied_charge') . ' (' . $currency_symbol . ')'; ?></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td><?php echo (!empty($result['charge_name'])) ? $result['charge_name'] : $this->lang->line('physiotherapy'); ?></td>
                                            <td class="text-right"><?php echo number_format($result['standard_charge'], 2); ?></td>
                                            <td class="text-right"><b><?php echo number_format($result['apply_charge'], 2); ?></b></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="text-right"><b><?php echo $this->lang->line('total'); ?>:</b></td>
                                            <td class="text-right"><b><?php echo $currency_symbol . number_format($result['apply_charge'], 2); ?></b></td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="divider" style="margin-top: 30px;"></div>
                                <table width="100%" class="printablea4" style="margin-top: 20px;">
                                    <tr>
                                        <td width="50%" class="text-left">
                                            <b><?php echo $this->lang->line('collected_by'); ?>:</b> <?php echo $result['gen_name'] . ' ' . $result['gen_surname']; ?>
                                        </td>
                                        <td width="50%" class="text-right" style="padding-top: 40px;">
                                            _______________________<br/>
                                            <b><?php echo $this->lang->line('physiotherapist'); ?> Signature</b>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <?php if (!empty($print_setting[0]['print_footer'])) { ?>
            <div class="footer-space">&nbsp;</div>
            <div class="fixed-print-footer">
                <p><?php echo $print_setting[0]['print_footer']; ?></p>
            </div>
        <?php } ?>
    </body>
</html>
