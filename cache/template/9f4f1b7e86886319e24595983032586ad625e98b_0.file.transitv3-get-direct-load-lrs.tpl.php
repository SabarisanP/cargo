<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-12 17:26:56
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\transitv3-get-direct-load-lrs.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66698d082a4417_31163622',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '9f4f1b7e86886319e24595983032586ad625e98b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\transitv3-get-direct-load-lrs.tpl',
      1 => 1718168145,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66698d082a4417_31163622 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>

<?php echo '<script'; ?>
 type="text/html" id="direct-load-lr-body">
    <?php $_smarty_tpl->_assignInScope('total_lr', 0);?>
    <?php $_smarty_tpl->_assignInScope('total_art', 0);?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['direct_load_lr']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
        <tr id="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
-to-branch">
            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['name'];?>
</td>
            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['article'];?>
<span class="direct-loaded-art text-muted text-small"></span></td>
            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['lr'];?>
 <span class="direct-loaded-lr text-muted text-small"></span></td>
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
 <span class="text-muted text-small" id="direct-total-loaded-art" style="color: #fff;"></span></td>
        <td><?php echo $_smarty_tpl->tpl_vars['total_lr']->value;?>
 <span class="text-muted text-small" id="direct-total-loaded-lr" style="color: #fff;"></span></td>
    </tr>
<?php echo '</script'; ?>
>

<div class="clearfix">&nbsp;</div>
<div id="directAlphabetOrder">
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['alphabet_letters']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
        <button onclick="scrollingDirect('<?php echo $_smarty_tpl->tpl_vars['row']->value['alphabet'];?>
', 'DFLT');" data-letter="<?php echo $_smarty_tpl->tpl_vars['row']->value['alphabet'];?>
" class="box-button scroll-link"><?php echo $_smarty_tpl->tpl_vars['row']->value['alphabet'];?>
</button>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <div class="pull-right d-flex"> 
        <div class="getLrs d-flex" style="margin-right:20px;">
            <label class="direct-get-error text-danger"></label>
            <input type="text" class="form-control direct-ogpl-load-cargocode" name="cargoCode" placeholder="Cargo Code" value="" style="text-transform:uppercase">     
            <button onclick="getCargoRow('direct','<?php echo $_smarty_tpl->tpl_vars['body']->value['queryCode'];?>
','<?php echo $_smarty_tpl->tpl_vars['body']->value['fromDate'];?>
','<?php echo $_smarty_tpl->tpl_vars['body']->value['toDate'];?>
','<?php echo $_smarty_tpl->tpl_vars['body']->value['fromStationCode'];?>
','<?php echo $_smarty_tpl->tpl_vars['body']->value['toStationCode'];?>
','<?php echo $_smarty_tpl->tpl_vars['body']->value['viaStationCodes'];?>
','<?php echo $_smarty_tpl->tpl_vars['body']->value['transitOrganizationCode'];?>
','<?php echo $_smarty_tpl->tpl_vars['body']->value['transitTypeCode'];?>
',null)" class="btn btn-success get-lr-btn">Get LR</button>
        </div>
        <div>
            <a href="javascript:;" class="btn btn-success load-lr-btn" onclick="loadDirectLoadLr()"> Load</a>
            <a href="javascript:;" class="btn load-lr-btn" onclick="ClearDirectLoadLr()"> Clear</a>
            <a title="close" href="javascript:;" class="btn-lg" onclick="closeDirectLoadLrLoadDialog()"> <i class="fa fa-times-circle fa-lg"></i> </a>
        </div>
       
    </div>
</div>

<div id="direct-load-load-lr-list">
    <div>
        <table id="new-lr-table" class="table table-bordered " style="width:99%">
            <thead>
                <tr class="success">
                    <td align="center">
                        <input type="checkbox" onchange="selectAllDirectLoadLrs(this);" />
                    </td>
                    <td align="center" nowrap><?php echo lang('lr');?>
 No</td>
                    <td align="center" nowrap>Booked Date</td>
                    <td align="center" nowrap>Booked by</td>
                    <td align="center" nowrap><?php echo lang('booking_from_term');?>
</td>
                    <td align="center" nowrap><?php echo lang('booking_to_label');?>
</td>
                    <td align="center" nowrap>
                        Transit To Branch &nbsp;
                        <a class="badge badge-success" href="javascript:;" title="Fill first selected branch to all LR" onclick="setAllDirectLoadTransitBranch()"><i class="fa fa-files-o" aria-hidden="true"></i></a>
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

            <tbody class="body_table" id="direct-load-ogpl-list">
                <?php $_smarty_tpl->_assignInScope('cargo_additional', config_item('cargo_additional'));?>
                <?php $_smarty_tpl->_assignInScope('load_branches', array());?>
                <?php $_smarty_tpl->_assignInScope('load_station_branches', array());?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                    <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['load_branches']) ? $_smarty_tpl->tpl_vars['load_branches']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['branch']->value->code] = $_smarty_tpl->tpl_vars['branch']->value;
$_smarty_tpl->_assignInScope('load_branches', $_tmp_array);?>
                    <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['load_station_branches']) ? $_smarty_tpl->tpl_vars['load_station_branches']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['branch']->value->station->code][$_smarty_tpl->tpl_vars['branch']->value->code] = $_smarty_tpl->tpl_vars['branch']->value;
$_smarty_tpl->_assignInScope('load_station_branches', $_tmp_array);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                <?php $_smarty_tpl->_assignInScope('rows', 0);?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['direct_load_lr']->value, 'list');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['list']->value) {
?>
                    <tr>
                        <td colspan="14" align="left" class="active DFLT_leter_tr_<?php echo ucfirst(substr($_smarty_tpl->tpl_vars['list']->value['name'],0,1));?>
">
                            <div class="d-flex align-items-center">
                                <input type="checkbox" onchange="selectBranchDirectLoadTransitLrs(this, '<?php echo $_smarty_tpl->tpl_vars['list']->value['name'];?>
');checkHandle();" />
                                <span class="mr_l_1_em"><?php echo ucfirst($_smarty_tpl->tpl_vars['list']->value['name']);?>
</span>
                            </div>
                        </td>
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
                        <?php } elseif ($_smarty_tpl->tpl_vars['usr_org_code']->value == $_smarty_tpl->tpl_vars['row']->value->transit_organization_code) {?>
                            <?php $_smarty_tpl->_assignInScope('allowloadstatus', 1);?>  
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['reporting_branch']->value != null) {?>
                            <?php if (in_array($_smarty_tpl->tpl_vars['row']->value->transit_organization_code,$_smarty_tpl->tpl_vars['reporting_branch']->value)) {?>
                                <?php $_smarty_tpl->_assignInScope('allowloadstatus', 1);?>
                            <?php }?>    
                        <?php }?>
                        <tr class="<?php if ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 1) {?>bg-success<?php } elseif ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 2) {?>bg-warning<?php } elseif ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 3) {?>bg-danger<?php }?>">
                            <td align="center">
                                <?php if ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 1) {?>
                                    <input type="checkbox"  class="ogpl-new-directload-items"  data-listname="<?php echo $_smarty_tpl->tpl_vars['list']->value['name'];?>
" data-tobranch="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_code;?>
" data-from="<?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_code;?>
" data-to="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_code;?>
" data-oldtransitorg="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_organization_code;?>
" data-oldtransitstn="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_station_code;?>
" value="<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
" onclick="directHandling(),checkHandle();"/>
                                <?php }?>
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
                            <td align="left">
                                <?php $_smarty_tpl->_assignInScope('tload_branches', $_smarty_tpl->tpl_vars['load_branches']->value);?>  
                                <?php if (count($_smarty_tpl->tpl_vars['load_station_branches']->value[$_smarty_tpl->tpl_vars['row']->value->to_station_code]) > 0) {?>
                                    <?php $_smarty_tpl->_assignInScope('tload_branches', $_smarty_tpl->tpl_vars['load_station_branches']->value[$_smarty_tpl->tpl_vars['row']->value->to_station_code]);?> 
                                <?php }?>    
                                <?php if ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 1) {?>
                                    <select class="direct-load-branch-sel form-control direct-load-branch" >
                                        <?php if (count($_smarty_tpl->tpl_vars['tload_branches']->value) > 0) {?>
                                            <option value="">Select a branch</option>
                                        <?php }?>

                                        <?php if (in_array($_smarty_tpl->tpl_vars['row']->value->load_type,array('FTL','PTL'))) {?>
                                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_code;?>
" data-fromstationname=<?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
 data-tostationname=<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
 data-station="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_code;?>
" selected><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</option>
                                        <?php }?>
                    
                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['tload_branches']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                            <option value="<?php echo $_smarty_tpl->tpl_vars['branch']->value->code;?>
" data-fromstationname=<?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
 data-tostationname=<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
 data-station="<?php echo $_smarty_tpl->tpl_vars['branch']->value->station->code;?>
" <?php if ($_smarty_tpl->tpl_vars['branch']->value->code == $_smarty_tpl->tpl_vars['row']->value->to_organization_code) {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['branch']->value->name;?>
</option>
                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                    </select>
                                <?php }?>
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
                        </tr>
                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['LR-SPLTUP'] == 1 && $_smarty_tpl->tpl_vars['cargo_setting']->value->cargoPartitionFlag == 1) {?>                                                         <?php $_smarty_tpl->_assignInScope('artical', explode('|',$_smarty_tpl->tpl_vars['row']->value->item_details));?> 
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_type == "PBO") {?>
                                <?php $_smarty_tpl->_assignInScope('artical_items', explode('|',$_smarty_tpl->tpl_vars['row']->value->item_portion_details));?>
                            <?php }?>
                                <tr class="splt-row row-<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
 row-direct-<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
">    
                                    <td colspan="14">
                                        <div class="well well-sm custom-well" id="cargo-<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
"> 
                                            <div class="custom-checkbox-group d-flex">

                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['artical']->value, 'art', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['art']->value) {
?>
                                                    <?php $_smarty_tpl->_assignInScope('carg_items', explode(',',$_smarty_tpl->tpl_vars['art']->value));?>
                                                    <?php $_smarty_tpl->_assignInScope('art_id', $_smarty_tpl->tpl_vars['carg_items']->value[0]);?>
                                                    <?php $_smarty_tpl->_assignInScope('art_inside', explode('-',$_smarty_tpl->tpl_vars['carg_items']->value[1]));?>
                                                    <?php $_smarty_tpl->_assignInScope('art_name', $_smarty_tpl->tpl_vars['art_inside']->value[0]);?>
                                                    <?php $_smarty_tpl->_assignInScope('art_qty', $_smarty_tpl->tpl_vars['art_inside']->value[1]);?>

                                                    <?php if (count($_smarty_tpl->tpl_vars['artical']->value) == 1 && $_smarty_tpl->tpl_vars['art_qty']->value == 1) {?>
                                                        <span class="text-muted">Application cannot be split due to single article and product in this LR.</span>
                                                    <?php } else { ?>
                                                        <div class="d-flex wrapDist artical-group artical<?php echo $_smarty_tpl->tpl_vars['art_id']->value;?>
">
                                                            <div class="d-flex wrapDist"> 
                                                            <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_type == "PBO") {?>
                                                                <?php $_smarty_tpl->_assignInScope('partials', $_smarty_tpl->tpl_vars['artical_items']->value);?>
                                                                <?php $_smarty_tpl->_assignInScope('partial_items', $_smarty_tpl->tpl_vars['artical_items']->value[$_smarty_tpl->tpl_vars['key']->value]);?>
                                                                <?php $_smarty_tpl->_assignInScope('each_items', explode(',',$_smarty_tpl->tpl_vars['partial_items']->value));?>
                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['each_items']->value, 'box', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['box']->value) {
?>
                                                                    <div class="custom-checkbox direct-<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
">
                                                                        <input type="checkbox" onclick="checkAllValidation(<?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
,'<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
','direct');" id="checkbox<?php echo $_smarty_tpl->tpl_vars['art_id']->value;?>
_<?php echo $_smarty_tpl->tpl_vars['box']->value;?>
-direct" value="<?php echo $_smarty_tpl->tpl_vars['box']->value;?>
" data-value="<?php echo $_smarty_tpl->tpl_vars['art_id']->value;?>
" data-artname="<?php echo $_smarty_tpl->tpl_vars['art_name']->value;?>
" data-artqty="<?php echo $_smarty_tpl->tpl_vars['art_qty']->value;?>
" data-total="<?php echo $_smarty_tpl->tpl_vars['art_qty']->value;?>
" data-cargoid="<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
" class="custom-control-input directbox" data-tobranch="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_code;?>
" data-from="<?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_code;?>
" data-to="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_code;?>
" data-oldtransitorg="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_organization_code;?>
" data-oldtransitstn="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_station_code;?>
">
                                                                        <label class="custom-control-label" for="checkbox<?php echo $_smarty_tpl->tpl_vars['art_id']->value;?>
_<?php echo $_smarty_tpl->tpl_vars['box']->value;?>
-direct"> <?php echo $_smarty_tpl->tpl_vars['box']->value;?>
</label>
                                                                    </div>
                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                            <?php } else { ?>
                                                                <?php
$_smarty_tpl->tpl_vars['box'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['box']->step = 1;$_smarty_tpl->tpl_vars['box']->total = (int) ceil(($_smarty_tpl->tpl_vars['box']->step > 0 ? $_smarty_tpl->tpl_vars['art_qty']->value+1 - (1) : 1-($_smarty_tpl->tpl_vars['art_qty']->value)+1)/abs($_smarty_tpl->tpl_vars['box']->step));
if ($_smarty_tpl->tpl_vars['box']->total > 0) {
for ($_smarty_tpl->tpl_vars['box']->value = 1, $_smarty_tpl->tpl_vars['box']->iteration = 1;$_smarty_tpl->tpl_vars['box']->iteration <= $_smarty_tpl->tpl_vars['box']->total;$_smarty_tpl->tpl_vars['box']->value += $_smarty_tpl->tpl_vars['box']->step, $_smarty_tpl->tpl_vars['box']->iteration++) {
$_smarty_tpl->tpl_vars['box']->first = $_smarty_tpl->tpl_vars['box']->iteration === 1;$_smarty_tpl->tpl_vars['box']->last = $_smarty_tpl->tpl_vars['box']->iteration === $_smarty_tpl->tpl_vars['box']->total;?>
                                                                    <div class="custom-checkbox direct-<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
">
                                                                        <input type="checkbox" onclick="checkAllValidation(<?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
,'<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
','direct');" id="checkbox<?php echo $_smarty_tpl->tpl_vars['art_id']->value;?>
_<?php echo $_smarty_tpl->tpl_vars['box']->value;?>
-direct" value="<?php echo $_smarty_tpl->tpl_vars['box']->value;?>
" data-value="<?php echo $_smarty_tpl->tpl_vars['art_id']->value;?>
" data-artname="<?php echo $_smarty_tpl->tpl_vars['art_name']->value;?>
" data-artqty="<?php echo $_smarty_tpl->tpl_vars['art_qty']->value;?>
" data-total="<?php echo $_smarty_tpl->tpl_vars['art_qty']->value;?>
" data-cargoid="<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
" class="custom-control-input directbox" data-tobranch="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_code;?>
" data-from="<?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_code;?>
" data-to="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_code;?>
" data-oldtransitorg="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_organization_code;?>
" data-oldtransitstn="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_station_code;?>
">
                                                                        <label class="custom-control-label" for="checkbox<?php echo $_smarty_tpl->tpl_vars['art_id']->value;?>
_<?php echo $_smarty_tpl->tpl_vars['box']->value;?>
-direct"> <?php echo $_smarty_tpl->tpl_vars['box']->value;?>
</label>
                                                                    </div>
                                                                <?php }
}
?>
                                                            <?php }?>
                                                           
                                                            </div>
                                                            <div class="text-center bg-light artical-container">
                                                                <?php echo $_smarty_tpl->tpl_vars['art_name']->value;?>

                                                            </div>
                                                        </div>
                                                    <?php }?>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            </div>  
                                        </div>
                                    </td>
                                </tr>
                        <?php }?>
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
    </div>
</div>

  

<?php }
}
