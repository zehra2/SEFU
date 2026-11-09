<div class="box-header with-border">
    <h3 class="box-title"><?php echo $this->lang->line('gynaecology'); ?></h3>
</div>
<div class="box-body row">
    <ul class="reportlists">
        <?php if ($this->rbac->hasPrivilege('gynaecology_patient', 'can_view')) { ?>
            <li class="col-lg-4 col-md-4 col-sm-6 <?php echo set_SubSubmenu('reports/gynaecology/report'); ?>">
                <a href="<?php echo base_url(); ?>admin/gynaecology"><i class="fa fa-file-text-o"></i> <?php echo $this->lang->line('gynaecology_report'); ?></a>
            </li>
        <?php } ?>
    </ul>
</div>

