<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 12:06:18
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\transitv3-get-out-for-delivery-transit-lrs.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66600762eeb180_87626173',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '5aa79f64ccff3286269d45395308f67be0410091' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\transitv3-get-out-for-delivery-transit-lrs.tpl',
      1 => 1716980854,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66600762eeb180_87626173 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
echo '<script'; ?>
 type="text/html" id="out-for-delivery-lr-body">
    <?php $_smarty_tpl->_assignInScope('total_lr', 0);?>
    <?php $_smarty_tpl->_assignInScope('total_art', 0);?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ofd_transit_load_lr']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
        <tr id="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
-to-branch">
            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['name'];?>
</td>
            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['article'];?>
 <span class="out-for-delivery-loaded-art text-muted text-small"></span></td>
            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['lr'];?>
 <span class="out-for-delivery-loaded-lr text-muted text-small"></span></td>
        </tr>
        <?php $_smarty_tpl->_assignInScope('total_lr', $_smarty_tpl->tpl_vars['total_lr']->value+$_smarty_tpl->tpl_vars['row']->value['lr']);?>
        <?php $_smarty_tpl->_assignInScope('total_art', $_smarty_tpl->tpl_vars['total_art']->value+$_smarty_tpl->tpl_vars['row']->value['article']);?>
    <?php
}
} else {
?>
        <tr>
            <td colspan="3" align="center">No Data Found!!</td>
        </tr>
    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <tr class="active bold">
        <td>Total</td>
        <td><?php echo $_smarty_tpl->tpl_vars['total_art']->value;?>
 <span class="text-muted text-small" id="out-for-delivery-total-loaded-art" style="color: #fff;"></span></td>
        <td><?php echo $_smarty_tpl->tpl_vars['total_lr']->value;?>
 <span class="text-muted text-small" id="out-for-delivery-total-loaded-lr" style="color: #fff;"></span></td>
    </tr>
<?php echo '</script'; ?>
>

<div class="clearfix">&nbsp;</div>
<div id="outForDeliveryAlphabetOrder">
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['alphabet_letters']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
        <button onclick="scrollingOFD('<?php echo $_smarty_tpl->tpl_vars['row']->value['alphabet'];?>
', 'OFD');" data-letter="<?php echo $_smarty_tpl->tpl_vars['row']->value['alphabet'];?>
" class="box-button scroll-link"><?php echo $_smarty_tpl->tpl_vars['row']->value['alphabet'];?>
</button>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <div class="pull-right">
        <a href="javascript:;" class="btn btn-success" onclick="loadOutForDeliveryTransitLr()"> Load</a>
        <a href="javascript:;" class="btn load-lr-btn" onclick="ClearOFDLoadLr()"> Clear</a>
        <a title="close" href="javascript:;" class="btn-lg" onclick="closeOutForDeliveryLrLoadDialog()"> <i class="fa fa-times-circle fa-lg"></i> </a>
    </div>
</div> 

<div id="out-for-delivery-load-lr-list">
    <div>
        <table id="new-lr-table" class="table table-bordered " style="width:99%">
            <thead>
                <tr class="success">
                    <td align="center">
                        <input type="checkbox" onchange="selectAllOutForDeliveryTransitLrs(this);" />
                    </td>
                    <td align="center" nowrap><?php echo lang('lr');?>
 No</td>
                    <td align="center" nowrap>Booked Date</td>
                    <td align="center" nowrap>Booked by</td>
                    <td align="center" nowrap><?php echo lang('booking_from_term');?>
</td>
                    <td align="center" nowrap><?php echo lang('booking_to_label');?>
</td>
                    <td align="center" nowrap><?php echo lang('booking_sender_term');?>
</td>
                    <td align="center" nowrap><?php echo lang('booking_receiver_term');?>
</td>
                    <td align="center" nowrap>Payment Status</td>
                    <td align="center" nowrap>Status</td>
                    <td align="center" nowrap>Items</td>
                    <td align="center" nowrap>Qty</td>
                    <td align="center" nowrap>Payable</td>
                </tr>
            </thead>

            <tbody class="body_table" id="out-for-delivery-ogpl-list">
                <?php $_smarty_tpl->_assignInScope('cargo_additional', config_item('cargo_additional'));?>
                <?php $_smarty_tpl->_assignInScope('load_branches', array());?>
                <?php $_smarty_tpl->_assignInScope('load_station_branches', array());?>
                <?php $_smarty_tpl->_assignInScope('rows', 0);?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ofd_transit_load_lr']->value, 'list');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['list']->value) {
?>
                    <tr>
                        <td colspan="14" align="left" class="active OFD_leter_tr_<?php echo ucfirst(substr($_smarty_tpl->tpl_vars['list']->value['name'],0,1));?>
"><input type="checkbox" onchange="selectBranchOutForDeliveryTransitLrs(this, '<?php echo $_smarty_tpl->tpl_vars['list']->value['name'];?>
');" /><span class="mr_l_1_em"><?php echo $_smarty_tpl->tpl_vars['list']->value['name'];?>
</span></td>
                    </tr>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['list']->value['data'], 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                <?php $_smarty_tpl->_assignInScope('allowloadstatus', 0);?>
                        <?php if (in_array($_smarty_tpl->tpl_vars['row']->value->load_type,array('FTL','PTL')) && $_smarty_tpl->tpl_vars['usr_station_code']->value == $_smarty_tpl->tpl_vars['row']->value->transit_station_code) {?>
                            <?php $_smarty_tpl->_assignInScope('allowloadstatus', 1);?>
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == 'CB' && $_smarty_tpl->tpl_vars['usr_org_code']->value != $_smarty_tpl->tpl_vars['row']->value->transit_organization_code) {?>
                            <?php $_smarty_tpl->_assignInScope('allowloadstatus', 3);?>
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == 'CL' && $_smarty_tpl->tpl_vars['usr_org_code']->value == $_smarty_tpl->tpl_vars['row']->value->transit_organization_code) {?>
                            <?php $_smarty_tpl->_assignInScope('allowloadstatus', 2);?>
                        <?php } elseif (!in_array($_smarty_tpl->tpl_vars['row']->value->load_type,array('RGL')) && $_smarty_tpl->tpl_vars['usr_org_code']->value == $_smarty_tpl->tpl_vars['row']->value->transit_organization_code) {?>
                            <?php $_smarty_tpl->_assignInScope('allowloadstatus', 1);?>
                        <?php }?>
                        <tr class="<?php if ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 1) {?>bg-success<?php } elseif ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 2) {?>bg-warning<?php } elseif ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 3) {?>bg-danger<?php }?>">
                            <td align="center">
                                <input type="checkbox" class="ogpl-new-outfordelivery-items" data-listname="<?php echo $_smarty_tpl->tpl_vars['list']->value['name'];?>
" data-tobranch="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_code;?>
" data-from="<?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_code;?>
" data-to="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_code;?>
" data-toname="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
" data-oldtransitorg="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_organization_code;?>
" data-oldtransitstn="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_station_code;?>
" value="<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
" onclick=""/>
                            </td>
                            <td align="center">
                                <a href='javascript:;' <?php if ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 2) {?>class="badge badge-warning text-white"<?php } elseif ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 3) {?>class="badge badge-danger text-white"<?php }?> title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a>
                                <br>
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->additional_status_code !== 'null') {?>
                                    <?php $_smarty_tpl->_assignInScope('asc_ar', explode(',',$_smarty_tpl->tpl_vars['row']->value->additional_status_code));?>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['asc_ar']->value, 'code');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['code']->value) {
?>
                                        <?php if ($_smarty_tpl->tpl_vars['code']->value == "EXPDL") {?>  
                                            <span class="ind ind-<?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['EXPDL']['color'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['EXPDL']['name'];?>
"><?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['EXPDL']['code'];?>
</span>
                                        <?php }?>
                                        <?php if ($_smarty_tpl->tpl_vars['code']->value == "HDLWC") {?>
                                            <span class="ind ind-<?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['HDLWC']['color'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['HDLWC']['name'];?>
"><?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['HDLWC']['code'];?>
</span>
                                        <?php }?>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <?php }?>
                            </td>
                            <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,'d, M y g:i A');?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
<br /><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_mobile;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
<br /><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_mobile;?>
</td>
                            <td align="center">
                                <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>

                            </td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                            <td align="right"><?php echo number_format(($_smarty_tpl->tpl_vars['row']->value->total_booking_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_handing_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax),2);?>
</td>
                            <?php $_smarty_tpl->_assignInScope('rows', $_smarty_tpl->tpl_vars['rows']->value+1);?>
                            
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                <?php ob_start();
echo $_smarty_tpl->tpl_vars['row']->value->to_station_code;
$_prefixVariable1 = ob_get_clean();
if ($_smarty_tpl->tpl_vars['branch']->value->station->code == $_prefixVariable1) {?>
                                    <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['load_branches']) ? $_smarty_tpl->tpl_vars['load_branches']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['branch']->value->code] = $_smarty_tpl->tpl_vars['branch']->value->name;
$_smarty_tpl->_assignInScope('load_branches', $_tmp_array);?>
                                <?php }?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </tr>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php if ($_smarty_tpl->tpl_vars['rows']->value == 0) {?>
                    <tr>
                        <td colspan="14" align="center">No Results Found!</td>
                    </tr>
                <?php }?>
            </tbody>
        </table>
        <div class="col-md-3 pull-right hide">
            <select id="out-for-delivery-branch" class="form-control load-branch">
                <option value="">Select Branch</option>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['load_branches']->value, 'branch', false, 'code');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['code']->value => $_smarty_tpl->tpl_vars['branch']->value) {
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['code']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value;?>
</option>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </select>
        </div>
    </div>
</div><?php }
}
