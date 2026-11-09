<div class="box-header with-border">
    <h3 class="box-title"><?php echo $this->lang->line('physiotherapy'); ?></h3>
</div>
<div class="box-body row">
    <ul class="reportlists">
        <?php if ($this->rbac->hasPrivilege('physiotherapy_patient', 'can_view')) { ?>
            <li class="col-lg-4 col-md-4 col-sm-6 <?php echo set_SubSubmenu('reports/physiotherapy/report'); ?>">
                <a href="<?php echo base_url(); ?>admin/physiotherapy"><i class="fa fa-file-text-o"></i> <?php echo $this->lang->line('physiotherapy_report'); ?></a>
            </li>
        <?php } ?>
    </ul>
</div>

