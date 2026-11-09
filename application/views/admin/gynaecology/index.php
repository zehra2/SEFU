<?php
$currency_symbol = $this->customlib->getHospitalCurrencyFormat();
$genderList      = $this->customlib->getGender();
?>
<style type="text/css">
    #myModaledit{overflow-y: scroll;}
    .multilinelist li { display: inline-block; margin-right: 15px; font-weight: normal; }
    .singlelist24bold { font-size: 16px; font-weight: bold; margin-bottom: 5px; }
    .row-eq { display: flex; flex-wrap: wrap; }
    .section-header-gynaecology { font-size: 14px; font-weight: bold; color: #3c8dbc; margin: 10px 0 8px 0; border-bottom: 1px solid #eee; padding-bottom: 4px; }
</style>
<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title titlefix"><?php echo $this->lang->line('gynaecology_patient'); ?></h3>
                        <div class="box-tools pull-right">
                            <?php if ($this->rbac->hasPrivilege('gynaecology_patient', 'can_add')) { ?>   
                                <a data-toggle="modal" onclick="holdModal('myModal')" class="btn btn-primary btn-sm addpatient"><i class="fa fa-plus"></i> <?php echo $this->lang->line('add_patient'); ?></a> 
                            <?php } ?>
                        </div>  
                    </div><!-- /.box-header -->                    
                    <div class="box-body">
                        <div class="download_label"><?php echo $this->lang->line('gynaecology_patient'); ?></div>
                        <table class="table table-striped table-bordered table-hover ajaxlist" cellspacing="0" width="100%" data-export-title="<?php echo $this->lang->line('gynaecology_patient'); ?>">
                            <thead>
                                <tr>
                                    <th><?php echo $this->lang->line('bill_no'); ?></th>
                                    <th><?php echo $this->lang->line('patient_name'); ?></th>
                                    <th><?php echo $this->lang->line('patient_id'); ?></th>
                                    <th><?php echo $this->lang->line('gender'); ?></th>
                                    <th><?php echo $this->lang->line('phone'); ?></th>
                                    <th><?php echo $this->lang->line('diagnosis'); ?></th>
                                    <th><?php echo $this->lang->line('pregnancy_status'); ?></th>
                                    <th><?php echo $this->lang->line('gynaecologist'); ?></th>
                                    <th><?php echo $this->lang->line('consultation_date'); ?></th>
                                    <?php 
                                    if (!empty($fields)) {
                                        foreach ($fields as $fields_key => $fields_value) {
                                            ?>
                                            <th><?php echo $fields_value->name; ?></th>
                                            <?php
                                        } 
                                    }
                                    ?>
                                    <th class="text-right"><?php echo $this->lang->line('applied_charge') . ' (' . $currency_symbol . ')'; ?></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- Add Gynaecology Modal -->
<div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document" style="width: 90%;">
        <div class="modal-content modal-media-content mx-2">
            <div class="modal-header modal-media-header">
                <button type="button" class="close pt4" data-dismiss="modal">&times;</button>
                <div class="row">
                    <div class="col-sm-6 col-xs-6">
                        <div class="form-group15">
                            <div>
                                <select class="form-control patient_list_ajax" form="formadd" id="addpatient_id" name='patient_id' style="width:100%">
                                </select>
                            </div>
                            <span class="text-danger"><?php echo form_error('patient_id'); ?></span>
                        </div>
                    </div>
                    <div class="col-sm-4 col-xs-4">
                        <?php if ($this->rbac->hasPrivilege('patient', 'can_add')) { ?>
                            <a data-toggle="modal" onclick="holdModal('myModalpa')" class="modalbtnpatient"><i class="fa fa-plus"></i> <span><?php echo $this->lang->line('new_patient'); ?></span></a> 
                        <?php } ?>
                    </div>
                </div>
            </div>
            <form id="formadd" accept-charset="utf-8" method="post" class="ptt10">
                <div class="modal-body pt0 pb0">
                    <div class="row row-eq">
                        <!-- LEFT PANEL: Demographics, Vitals, LMP & Pregnancy Status -->
                        <div class="col-lg-5 col-md-5 col-sm-12" style="border-right: 1px solid #eee;">
                            <div class="row ptt10" id="patientDetails" style="display:none">
                                <div class="col-md-12">
                                    <ul class="singlelist">
                                        <li class="singlelist24bold"><span id="listname"></span></li>
                                        <li><b>Guardian:</b> <span id="guardian"></span></li>
                                    </ul>   
                                    <ul class="multilinelist">   
                                        <li><b>Gender:</b> <span id="genders"></span></li>
                                        <li><b>Age:</b> <span id="age_display"></span></li>
                                        <li><b>Blood:</b> <span id="blood_group"></span></li>
                                    </ul>
                                    <hr style="margin: 8px 0;"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('height'); ?></label>
                                        <input type="text" name="height" id="height" placeholder="cm" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('weight'); ?></label>
                                        <input type="text" name="weight" id="weight" placeholder="kg" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('bp'); ?></label>
                                        <input type="text" name="bp" id="bp" placeholder="e.g. 120/80" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('lmp'); ?></label>
                                        <input type="text" name="lmp" id="lmp" class="form-control date" placeholder="LMP Date">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('pregnancy_status'); ?></label>
                                        <select name="pregnancy_status" id="pregnancy_status" class="form-control">
                                            <option value="">Select</option>
                                            <option value="Not Pregnant">Not Pregnant</option>
                                            <option value="Pregnant">Pregnant</option>
                                            <option value="Suspected">Suspected</option>
                                            <option value="Postpartum">Postpartum</option>
                                            <option value="Lactating">Lactating</option>
                                            <option value="Menopausal">Menopausal</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('chief_complaint'); ?></label>
                                        <textarea name="symptoms" id="symptoms" class="form-control" rows="3" placeholder="Symptoms / Chief Complaint"></textarea>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('note'); ?></label>
                                        <textarea name="note" id="note" class="form-control" rows="3" placeholder="Additional Notes"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- RIGHT PANEL: Consultation Details, Gynaecology Details, Billing -->
                        <div class="col-lg-7 col-md-7 col-sm-12">
                            <!-- Section: Consultation Details -->
                            <div class="section-header-gynaecology"><i class="fa fa-stethoscope"></i> <?php echo $this->lang->line('child_and_consultation_details'); ?></div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('gynaecologist'); ?></label> <small class="req">*</small>
                                        <select class="form-control select2" name="gynaecologist_id" style="width:100%">
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php foreach ($gynaecologists as $dkey => $dvalue) { ?>
                                                <option value="<?php echo $dvalue["id"]; ?>"><?php echo $dvalue["name"] . " " . $dvalue["surname"] . " (" . $dvalue["employee_id"] . ")"; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('consultation_date'); ?></label> <small class="req">*</small>
                                        <input type="text" name="consultation_date" class="form-control datetime">
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('diagnosis'); ?></label>
                                        <input type="text" name="diagnosis" class="form-control" placeholder="Clinical Diagnosis">
                                    </div>
                                </div>
                            </div>

                            <!-- Section: Gynaecology Details -->
                            <div class="section-header-gynaecology"><i class="fa fa-female"></i> <?php echo $this->lang->line('gynaecology_details'); ?></div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('pregnancy_history'); ?></label>
                                        <textarea name="pregnancy_history" class="form-control" rows="2" placeholder="e.g. Gravida, Para, Living, Abortions (G2P1L1A0), past delivery modes, complications"></textarea>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('clinical_notes'); ?></label>
                                        <textarea name="clinical_notes" class="form-control" rows="2" placeholder="Pelvic exam findings, speculum exam, ultrasound observations"></textarea>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('prescription_treatment'); ?></label>
                                        <textarea name="prescription_treatment" class="form-control" rows="2" placeholder="Prescribed medications, dosages, lab tests requested"></textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- Custom Fields -->
                            <div class="col-sm-12">
                                <?php echo display_custom_fields('gynaecology'); ?>
                            </div>

                            <!-- Billing Section (same as before) -->
                            <div class="section-header-gynaecology"><i class="fa fa-credit-card"></i> <?php echo $this->lang->line('gynaecology_billing'); ?></div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('tpa'); ?></label>
                                        <select class="form-control" name="organisation_id">
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php foreach ($organisation as $orgkey => $orgval) { ?>
                                                <option value="<?php echo $orgval["id"]; ?>"><?php echo $orgval["organisation_name"]; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('charge_category'); ?></label>
                                        <select class="form-control" name="charge_category_id" id="charge_category_id" onchange="getChargeCode(this.value)">
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                            <?php foreach ($charge_category as $cckey => $ccval) { ?>
                                                <option value="<?php echo $ccval["id"]; ?>"><?php echo $ccval["name"]; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('code'); ?></label>
                                        <select class="form-control" name="charge_id" id="charge_id" onchange="getChargeDetails(this.value)">
                                            <option value=""><?php echo $this->lang->line('select'); ?></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('standard_charge') . ' (' . $currency_symbol . ')'; ?></label>
                                        <input type="text" name="standard_charge" id="standard_charge" class="form-control" readonly="readonly">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label><?php echo $this->lang->line('applied_charge') . ' (' . $currency_symbol . ')'; ?></label> <small class="req">*</small>
                                        <input type="text" name="apply_charge" id="apply_charge" class="form-control" value="0.00">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-right">
                        <button type="submit" id="formaddbtn" data-loading-text="<?php echo $this->lang->line('processing'); ?>" class="btn btn-info"><i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                    </div>
                    <div class="pull-right mr-10">
                        <button type="button" id="saveprintbtn" data-loading-text="<?php echo $this->lang->line('processing'); ?>" class="btn btn-info printsavebtn"><i class="fa fa-print"></i> <?php echo $this->lang->line('save_print'); ?></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Gynaecology Modal -->
<div class="modal fade" id="myModaledit" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document" style="width: 85%;">
        <div class="modal-content modal-media-content mx-2">
            <div class="modal-header modal-media-header">
                <button type="button" class="close pt4" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('edit_gynaecology_patient'); ?></h4>
            </div>
            <form id="formedit" accept-charset="utf-8" method="post" class="ptt10">
                <input type="hidden" name="id" id="edit_id">
                <div class="modal-body pt0 pb0">
                    <div class="row">
                        <!-- Demographics & Vitals -->
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('height'); ?></label>
                                <input type="text" name="height" id="edit_height" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('weight'); ?></label>
                                <input type="text" name="weight" id="edit_weight" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('bp'); ?></label>
                                <input type="text" name="bp" id="edit_bp" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('lmp'); ?></label>
                                <input type="text" name="lmp" id="edit_lmp" class="form-control date">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('pregnancy_status'); ?></label>
                                <select name="pregnancy_status" id="edit_pregnancy_status" class="form-control">
                                    <option value="">Select</option>
                                    <option value="Not Pregnant">Not Pregnant</option>
                                    <option value="Pregnant">Pregnant</option>
                                    <option value="Suspected">Suspected</option>
                                    <option value="Postpartum">Postpartum</option>
                                    <option value="Lactating">Lactating</option>
                                    <option value="Menopausal">Menopausal</option>
                                </select>
                            </div>
                        </div>

                        <!-- Consultation Details -->
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('gynaecologist'); ?></label> <small class="req">*</small>
                                <select class="form-control select2" name="gynaecologist_id" id="edit_gynaecologist_id" style="width:100%">
                                    <option value=""><?php echo $this->lang->line('select'); ?></option>
                                    <?php foreach ($gynaecologists as $dkey => $dvalue) { ?>
                                        <option value="<?php echo $dvalue["id"]; ?>"><?php echo $dvalue["name"] . " " . $dvalue["surname"] . " (" . $dvalue["employee_id"] . ")"; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('consultation_date'); ?></label> <small class="req">*</small>
                                <input type="text" name="consultation_date" id="edit_consultation_date" class="form-control datetime">
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('diagnosis'); ?></label>
                                <input type="text" name="diagnosis" id="edit_diagnosis" class="form-control">
                            </div>
                        </div>

                        <!-- Symptoms & Gynaecology Details -->
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('chief_complaint'); ?></label>
                                <textarea name="symptoms" id="edit_symptoms" class="form-control" rows="2"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('pregnancy_history'); ?></label>
                                <textarea name="pregnancy_history" id="edit_pregnancy_history" class="form-control" rows="2"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('clinical_notes'); ?></label>
                                <textarea name="clinical_notes" id="edit_clinical_notes" class="form-control" rows="2"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('prescription_treatment'); ?></label>
                                <textarea name="prescription_treatment" id="edit_prescription_treatment" class="form-control" rows="2"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('note'); ?></label>
                                <textarea name="note" id="edit_note" class="form-control" rows="2"></textarea>
                            </div>
                        </div>

                        <!-- Billing Section -->
                        <div class="col-sm-12"><hr style="margin: 10px 0;"/></div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('tpa'); ?></label>
                                <select class="form-control" name="organisation_id" id="edit_organisation_id">
                                    <option value=""><?php echo $this->lang->line('select'); ?></option>
                                    <?php foreach ($organisation as $orgkey => $orgval) { ?>
                                        <option value="<?php echo $orgval["id"]; ?>"><?php echo $orgval["organisation_name"]; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('charge_category'); ?></label>
                                <select class="form-control" name="charge_category_id" id="edit_charge_category_id" onchange="getChargeCodeEdit(this.value)">
                                    <option value=""><?php echo $this->lang->line('select'); ?></option>
                                    <?php foreach ($charge_category as $cckey => $ccval) { ?>
                                        <option value="<?php echo $ccval["id"]; ?>"><?php echo $ccval["name"]; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('code'); ?></label>
                                <select class="form-control" name="charge_id" id="edit_charge_id" onchange="getChargeDetailsEdit(this.value)">
                                    <option value=""><?php echo $this->lang->line('select'); ?></option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('standard_charge') . ' (' . $currency_symbol . ')'; ?></label>
                                <input type="text" name="standard_charge" id="edit_standard_charge" class="form-control" readonly="readonly">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('applied_charge') . ' (' . $currency_symbol . ')'; ?></label> <small class="req">*</small>
                                <input type="text" name="apply_charge" id="edit_apply_charge" class="form-control">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="formeditbtn" data-loading-text="<?php echo $this->lang->line('processing'); ?>" class="btn btn-info pull-right"><i class="fa fa-check-circle"></i> <?php echo $this->lang->line('save'); ?></button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- View Gynaecology Modal -->
<div class="modal fade" id="viewModal" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document" style="width: 80%;">
        <div class="modal-content modal-media-content mx-2">
            <div class="modal-header modal-media-header">
                <button type="button" class="close pt4" data-dismiss="modal">&times;</button>
                <div class="modalicon">
                    <div id="edit_delete_action"></div>
                </div>
                <h4 class="modal-title"><?php echo $this->lang->line('gynaecology_details'); ?></h4>
            </div>
            <div class="modal-body pt0 pb0">
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-striped table-bordered mb0">
                            <tbody>
                                <tr>
                                    <th width="20%"><?php echo $this->lang->line('bill_no'); ?></th>
                                    <td width="30%"><span id="v_bill_no"></span></td>
                                    <th width="20%"><?php echo $this->lang->line('consultation_date'); ?></th>
                                    <td width="30%"><span id="v_consultation_date"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('patient_name'); ?></th>
                                    <td><span id="v_patient_name"></span></td>
                                    <th><?php echo $this->lang->line('patient_id'); ?></th>
                                    <td><span id="v_patient_id"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('gender'); ?> / <?php echo $this->lang->line('age'); ?></th>
                                    <td><span id="v_gender"></span> / <span id="v_age"></span></td>
                                    <th><?php echo $this->lang->line('guardian_name'); ?></th>
                                    <td><span id="v_guardian_name"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('phone'); ?></th>
                                    <td><span id="v_phone"></span></td>
                                    <th><?php echo $this->lang->line('blood_group'); ?></th>
                                    <td><span id="v_blood_group"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('gynaecologist'); ?></th>
                                    <td><span id="v_gynaecologist"></span></td>
                                    <th><?php echo $this->lang->line('lmp'); ?></th>
                                    <td><span id="v_lmp"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('height') . ' / ' . $this->lang->line('weight') . ' / ' . $this->lang->line('bp'); ?></th>
                                    <td><span id="v_vitals"></span></td>
                                    <th><?php echo $this->lang->line('pregnancy_status'); ?></th>
                                    <td><span id="v_pregnancy_status"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('chief_complaint'); ?></th>
                                    <td colspan="3"><span id="v_symptoms"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('diagnosis'); ?></th>
                                    <td colspan="3"><span id="v_diagnosis"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('pregnancy_history'); ?></th>
                                    <td colspan="3"><span id="v_pregnancy_history"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('clinical_notes'); ?></th>
                                    <td colspan="3"><span id="v_clinical_notes"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('prescription_treatment'); ?></th>
                                    <td colspan="3"><span id="v_prescription_treatment"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('note'); ?></th>
                                    <td colspan="3"><span id="v_note"></span></td>
                                </tr>
                                <tr>
                                    <th><?php echo $this->lang->line('applied_charge'); ?> (<?php echo $currency_symbol; ?>)</th>
                                    <td colspan="3"><b><span id="v_apply_charge"></span></b></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $this->lang->line('close'); ?></button>
            </div>
        </div>
    </div>
</div>

<!-- Consultant Instructions Modal -->
<div class="modal fade" id="consultantRegisterModal" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content modal-media-content mx-2">
            <div class="modal-header modal-media-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $this->lang->line('consultant_instruction'); ?></h4>
            </div>
            <div class="modal-body pt0 pb0">
                <form id="consultant_instruction_form" accept-charset="utf-8" method="post" class="ptt10">
                    <input type="hidden" name="gynaecology_id" id="ins_gynaecology_id">
                    <input type="hidden" name="patient_id" id="ins_patient_id">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('applied_date'); ?></label> <small class="req">*</small>
                                <input type="text" name="date" class="form-control datetime">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('consultant_doctor'); ?></label> <small class="req">*</small>
                                <select class="form-control select2" name="consultant_doctor" style="width:100%">
                                    <option value=""><?php echo $this->lang->line('select'); ?></option>
                                    <?php foreach ($gynaecologists as $dkey => $dvalue) { ?>
                                        <option value="<?php echo $dvalue["id"]; ?>"><?php echo $dvalue["name"] . " " . $dvalue["surname"] . " (" . $dvalue["employee_id"] . ")"; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label><?php echo $this->lang->line('instruction'); ?></label> <small class="req">*</small>
                                <textarea name="instruction" class="form-control" rows="1"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-12 text-right">
                            <button type="submit" id="consultantformbtn" class="btn btn-info btn-sm"><i class="fa fa-plus"></i> <?php echo $this->lang->line('add'); ?></button>
                        </div>
                    </div>
                </form>
                <hr/>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered" id="instruction_table">
                        <thead>
                            <tr>
                                <th><?php echo $this->lang->line('applied_date'); ?></th>
                                <th><?php echo $this->lang->line('consultant_doctor'); ?></th>
                                <th><?php echo $this->lang->line('instruction'); ?></th>
                                <th class="text-right"><?php echo $this->lang->line('action'); ?></th>
                            </tr>
                        </thead>
                        <tbody id="instruction_table_body">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $('.select2').select2();
    });

    function holdModal(modalId) {
        $('#' + modalId).modal({
            backdrop: 'static',
            keyboard: false,
            show: true
        });
    }

    // Datatable initialization
    (function ($) {
        'use strict';
        $(document).ready(function () {
            initDatatable('ajaxlist', 'admin/gynaecology/getDatatable', [], [], 100);
        });
    }(jQuery));

    // Patient AJAX Select2
    $('#addpatient_id').on('select2:select', function (e) {
        var data = e.params.data;
        $('#listname').html(data.text);
        $('#guardian').html(data.guardian_name || '-');
        $('#genders').html(data.gender || '-');
        $('#age_display').html(data.age || '-');
        $('#blood_group').html(data.blood_group || '-');
        $('#patientDetails').show();
    });

    // Charge Category onchange -> Load Charges
    function getChargeCode(charge_category_id) {
        $('#charge_id').html("<option value=''><?php echo $this->lang->line('loading'); ?></option>");
        if (charge_category_id) {
            $.ajax({
                url: '<?php echo base_url(); ?>admin/charges/getchargeDetails',
                type: 'POST',
                data: {charge_category_id: charge_category_id},
                dataType: 'json',
                success: function (res) {
                    var options = "<option value=''><?php echo $this->lang->line('select'); ?></option>";
                    $.each(res, function (index, value) {
                        options += "<option value='" + value.id + "'>" + value.name + " (" + value.code + ")</option>";
                    });
                    $('#charge_id').html(options);
                }
            });
        } else {
            $('#charge_id').html("<option value=''><?php echo $this->lang->line('select'); ?></option>");
        }
    }

    function getChargeCodeEdit(charge_category_id) {
        $('#edit_charge_id').html("<option value=''><?php echo $this->lang->line('loading'); ?></option>");
        if (charge_category_id) {
            $.ajax({
                url: '<?php echo base_url(); ?>admin/charges/getchargeDetails',
                type: 'POST',
                data: {charge_category_id: charge_category_id},
                dataType: 'json',
                success: function (res) {
                    var options = "<option value=''><?php echo $this->lang->line('select'); ?></option>";
                    $.each(res, function (index, value) {
                        options += "<option value='" + value.id + "'>" + value.name + " (" + value.code + ")</option>";
                    });
                    $('#edit_charge_id').html(options);
                }
            });
        } else {
            $('#edit_charge_id').html("<option value=''><?php echo $this->lang->line('select'); ?></option>");
        }
    }

    // Charge Code onchange -> Set Standard Charge
    function getChargeDetails(charge_id) {
        if (charge_id) {
            $.ajax({
                url: '<?php echo base_url(); ?>admin/charges/getChargeById',
                type: 'POST',
                data: {charge_id: charge_id},
                dataType: 'json',
                success: function (res) {
                    if (res) {
                        $('#standard_charge').val(res.standard_charge);
                        $('#apply_charge').val(res.standard_charge);
                    }
                }
            });
        }
    }

    function getChargeDetailsEdit(charge_id) {
        if (charge_id) {
            $.ajax({
                url: '<?php echo base_url(); ?>admin/charges/getChargeById',
                type: 'POST',
                data: {charge_id: charge_id},
                dataType: 'json',
                success: function (res) {
                    if (res) {
                        $('#edit_standard_charge').val(res.standard_charge);
                        $('#edit_apply_charge').val(res.standard_charge);
                    }
                }
            });
        }
    }

    // Form Add Submit
    var save_and_print = false;
    $('#saveprintbtn').click(function () {
        save_and_print = true;
        $('#formadd').submit();
    });

    $('#formadd').on('submit', function (e) {
        e.preventDefault();
        var btn = $('#formaddbtn');
        btn.button('loading');

        $.ajax({
            url: '<?php echo base_url(); ?>admin/gynaecology/add',
            type: 'POST',
            data: new FormData(this),
            dataType: 'json',
            contentType: false,
            cache: false,
            processData: false,
            success: function (data) {
                if (data.status == "fail") {
                    var message = "";
                    $.each(data.error, function (index, value) {
                        message += value + "<br/>";
                    });
                    errorMsg(message);
                } else {
                    successMsg(data.message);
                    $('#myModal').modal('hide');
                    $('#formadd')[0].reset();
                    $('#patientDetails').hide();
                    $('.ajaxlist').DataTable().ajax.reload();
                    if (save_and_print && data.id) {
                        printBill(data.id);
                    }
                    save_and_print = false;
                }
                btn.button('reset');
            },
            error: function () {
                btn.button('reset');
            }
        });
    });

    // View Details
    function viewDetail(id) {
        $.ajax({
            url: '<?php echo base_url(); ?>admin/gynaecology/getDetails',
            type: 'POST',
            data: {id: id},
            dataType: 'json',
            success: function (data) {
                if (data) {
                    $('#v_bill_no').text(data.bill_no || '-');
                    $('#v_consultation_date').text(data.consultation_date_formatted || '-');
                    $('#v_patient_name').text(data.patient_name || '-');
                    $('#v_patient_id').text(data.pid);
                    $('#v_gender').text(data.gender || '-');
                    $('#v_age').text(data.patient_age || '-');
                    $('#v_guardian_name').text(data.guardian_name || '-');
                    $('#v_phone').text(data.mobileno || '-');
                    $('#v_blood_group').text(data.blood_group || '-');
                    $('#v_gynaecologist').text(data.gynaecologist_name || '-');
                    $('#v_lmp').text(data.lmp_formatted || '-');
                    $('#v_vitals').text('H: ' + (data.height || '-') + ' | W: ' + (data.weight || '-') + ' | BP: ' + (data.bp || '-'));
                    $('#v_pregnancy_status').text(data.pregnancy_status || '-');
                    $('#v_symptoms').text(data.symptoms || '-');
                    $('#v_diagnosis').text(data.diagnosis || '-');
                    $('#v_pregnancy_history').text(data.pregnancy_history || '-');
                    $('#v_clinical_notes').text(data.clinical_notes || '-');
                    $('#v_prescription_treatment').text(data.prescription_treatment || '-');
                    $('#v_note').text(data.note || '-');
                    $('#v_apply_charge').text(parseFloat(data.apply_charge || 0).toFixed(2));

                    var action_html = "<a href='#' onclick='printBill(" + data.id + ")' data-toggle='tooltip' title='Print'><i class='fa fa-print'></i></a> ";
                    action_html += "<a href='#' onclick='getRecord(" + data.id + ")' data-toggle='tooltip' title='Edit'><i class='fa fa-pencil'></i></a> ";
                    action_html += "<a href='#' onclick='delete_record(" + data.id + ")' data-toggle='tooltip' title='Delete'><i class='fa fa-trash'></i></a>";
                    $('#edit_delete_action').html(action_html);

                    $('#viewModal').modal('show');
                }
            }
        });
    }

    // Get Record for Edit
    function getRecord(id) {
        $('#viewModal').modal('hide');
        $.ajax({
            url: '<?php echo base_url(); ?>admin/gynaecology/getRecord',
            type: 'POST',
            data: {id: id},
            dataType: 'json',
            success: function (data) {
                if (data) {
                    $('#edit_id').val(data.id);
                    $('#edit_height').val(data.height);
                    $('#edit_weight').val(data.weight);
                    $('#edit_bp').val(data.bp);
                    $('#edit_lmp').val(data.lmp);
                    $('#edit_pregnancy_status').val(data.pregnancy_status);
                    $('#edit_gynaecologist_id').val(data.gynaecologist_id).trigger('change');
                    $('#edit_consultation_date').val(data.consultation_date);
                    $('#edit_diagnosis').val(data.diagnosis);
                    $('#edit_symptoms').val(data.symptoms);
                    $('#edit_pregnancy_history').val(data.pregnancy_history);
                    $('#edit_clinical_notes').val(data.clinical_notes);
                    $('#edit_prescription_treatment').val(data.prescription_treatment);
                    $('#edit_note').val(data.note);
                    $('#edit_apply_charge').val(data.apply_charge);
                    $('#edit_standard_charge').val(data.standard_charge);
                    if (data.organisation_id) {
                        $('#edit_organisation_id').val(data.organisation_id);
                    }
                    $('#myModaledit').modal('show');
                }
            }
        });
    }

    // Form Edit Submit
    $('#formedit').on('submit', function (e) {
        e.preventDefault();
        var btn = $('#formeditbtn');
        btn.button('loading');
        $.ajax({
            url: '<?php echo base_url(); ?>admin/gynaecology/update',
            type: 'POST',
            data: new FormData(this),
            dataType: 'json',
            contentType: false,
            cache: false,
            processData: false,
            success: function (data) {
                if (data.status == "fail") {
                    var message = "";
                    $.each(data.error, function (index, value) {
                        message += value + "<br/>";
                    });
                    errorMsg(message);
                } else {
                    successMsg(data.message);
                    $('#myModaledit').modal('hide');
                    $('.ajaxlist').DataTable().ajax.reload();
                }
                btn.button('reset');
            },
            error: function () {
                btn.button('reset');
            }
        });
    });

    // Delete Record
    function delete_record(id) {
        if (confirm("<?php echo $this->lang->line('delete_confirm'); ?>")) {
            $.ajax({
                url: '<?php echo base_url(); ?>admin/gynaecology/delete/' + id,
                type: 'POST',
                dataType: 'json',
                success: function (res) {
                    if (res.status == 'success') {
                        $('#viewModal').modal('hide');
                        successMsg(res.message);
                        $('.ajaxlist').DataTable().ajax.reload();
                    }
                }
            });
        }
    }

    // Print Bill
    function printBill(id) {
        $.ajax({
            url: '<?php echo base_url(); ?>admin/gynaecology/printBill/' + id,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                if (data.page) {
                    popup(data.page);
                }
            }
        });
    }

    // Instructions
    function add_instruction(gynaecology_id, patient_id) {
        $('#ins_gynaecology_id').val(gynaecology_id);
        $('#ins_patient_id').val(patient_id);
        loadInstructions(gynaecology_id);
        $('#consultantRegisterModal').modal('show');
    }

    function loadInstructions(gynaecology_id) {
        $.ajax({
            url: '<?php echo base_url(); ?>admin/gynaecology/getInstructions',
            type: 'POST',
            data: {gynaecology_id: gynaecology_id},
            dataType: 'json',
            success: function (res) {
                var html = "";
                if (res && res.length > 0) {
                    $.each(res, function (i, item) {
                        html += "<tr>";
                        html += "<td>" + item.date + "</td>";
                        html += "<td>" + (item.staff_name ? item.staff_name + ' ' + (item.staff_surname || '') : '-') + "</td>";
                        html += "<td>" + item.instruction + "</td>";
                        html += "<td class='text-right'><a href='#' onclick='deleteInstruction(" + item.id + ", " + item.gynaecology_id + ")' class='btn btn-default btn-xs text-danger'><i class='fa fa-trash'></i></a></td>";
                        html += "</tr>";
                    });
                } else {
                    html = "<tr><td colspan='4' class='text-center text-muted'><?php echo $this->lang->line('no_records_found'); ?></td></tr>";
                }
                $('#instruction_table_body').html(html);
            }
        });
    }

    $('#consultant_instruction_form').on('submit', function (e) {
        e.preventDefault();
        $.ajax({
            url: '<?php echo base_url(); ?>admin/gynaecology/addInstruction',
            type: 'POST',
            data: $(this).serialize(),
            dataType: 'json',
            success: function (res) {
                if (res.status == 'success') {
                    successMsg(res.message);
                    $('#consultant_instruction_form')[0].reset();
                    loadInstructions($('#ins_gynaecology_id').val());
                } else {
                    errorMsg("<?php echo $this->lang->line('error_occurred_please_try_again'); ?>");
                }
            }
        });
    });

    function deleteInstruction(id, gynaecology_id) {
        if (confirm("<?php echo $this->lang->line('delete_confirm'); ?>")) {
            $.ajax({
                url: '<?php echo base_url(); ?>admin/gynaecology/deleteInstruction/' + id,
                type: 'POST',
                dataType: 'json',
                success: function (res) {
                    if (res.status == 'success') {
                        successMsg(res.message);
                        loadInstructions(gynaecology_id);
                    }
                }
            });
        }
    }

    function refreshmodal() {
        $('#consultant_instruction_form')[0].reset();
    }
</script>

<?php $this->load->view('admin/patient/patientaddmodal'); ?>

