<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 15:29:46
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\booked-ogpl-search-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6655ab12111702_90689297',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '8bcfe972e5e973b2bde0044e55bed6ac4df18f01' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\booked-ogpl-search-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6655ab12111702_90689297 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.replace.php','function'=>'smarty_modifier_replace',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="clearfix"></div>
<?php if (count($_smarty_tpl->tpl_vars['toBranchSummary']->value)) {?>
    <h5><b>Summary</b></h5>
    <table class="table table-bordered" style="width: 30%;">
        <thead>
            <tr class="success">
                <th class="text-center">To Branch</th>
                <th class="text-center">Total</th>
            </tr>
        </thead>
        <tbody>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['toBranchSummary']->value, 'count', false, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value => $_smarty_tpl->tpl_vars['count']->value) {
?>
                <tr>
                    <td align="left"><b><?php echo $_smarty_tpl->tpl_vars['branch']->value;?>
</b></td>
                    <td align="right"><b><?php echo sigma(($_smarty_tpl->tpl_vars['count']->value['total_count']+0),$_smarty_tpl->tpl_vars['total_to_brn_count']->value);?>
</b></td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <tfoot>
            <tr class="active">
                <th align="left"><b>Total</b></th>
                <td class="text-right"><b><?php echo $_smarty_tpl->tpl_vars['total_to_brn_count']->value;?>
</b></td>
            </tr>
        </tfoot>
    </table>
<?php }?>

<table class="hide">
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'count', false, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value => $_smarty_tpl->tpl_vars['count']->value) {
?>
        <tr class="<?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['branch']->value,' ','');?>
 hide summary-to-branch">
            <td>
                <table class="table table-bordered " width="100%">
                    <thead>
                        <tr class="active">
                            <th class="text-center">To Branch</th>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['all_payment_status']->value, 'statuscount', false, 'statuscode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['statuscode']->value => $_smarty_tpl->tpl_vars['statuscount']->value) {
?>
                                <th class="text-center"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['statuscode']->value];?>
</th>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <th class="text-center">Total</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        <?php $_smarty_tpl->_assignInScope('cnt', 1);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['count']->value['toOrganizationName'], 'val', false, 'toBranch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['toBranch']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                            <tr>
                                <td align="left"><b><?php echo $_smarty_tpl->tpl_vars['toBranch']->value;?>
</b></td>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['all_payment_status']->value, 'statuscount', false, 'statuscode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['statuscode']->value => $_smarty_tpl->tpl_vars['statuscount']->value) {
?>
                                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['val']->value[$_smarty_tpl->tpl_vars['statuscode']->value]+0;?>
</td>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <td align="right"><b><?php echo $_smarty_tpl->tpl_vars['val']->value['total'];?>
</b></td>
                            </tr>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                </table>
            </td>
        </tr>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
</table>
<div class="clearfix"></div>

<div class="row">
    <div class="col-md-6">
        <h5><b>Transactions</b></h5>
    </div>
    <div class="col-md-6 text-right">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="printLoadingSheet();"><i class="fa fa-print fa-lg"></i> Loading Sheet</button>&emsp;
        </div>
    </div>
</div>

<table id="new-lr-table" class="table table-bordered " style="width:99%">
    <thead>
        <tr class="success">
            <td align="center">
                <input type="checkbox" onchange="selectAllBookingOutstation(this);" />
            </td>
            <td align="center"><?php echo lang('lr');?>
 No</td>
            <td align="center">Booked Date</td>
            <td align="center">Booked by</td>
            <td align="center"><?php echo lang('booking_from_term');?>
</td>
            <td align="center"><?php echo lang('booking_to_label');?>
</td>
            <td align="center">
                Transit To Branch &nbsp;
                <a class="badge badge-success" href="javascript:;" title="Fill first selected branch to all LR" onclick="setAllTransitBranch()"><i class="fa fa-files-o" aria-hidden="true"></i></a>
            </td>
            <td align="center"><?php echo lang('booking_sender_term');?>
</td>
            <td align="center"><?php echo lang('booking_receiver_term');?>
</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Items</td>
            <td align="center">Qty</td>
            <td align="center">Payable</td>
        </tr>
    </thead>

    <tbody class="body_table" id="load-ogpl-list">
        <?php $_smarty_tpl->_assignInScope('cargo_additional', config_item('cargo_additional'));?>
        <?php $_smarty_tpl->_assignInScope('load_branches', array());?>
        <?php $_smarty_tpl->_assignInScope('load_station_branches', array());?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ogpl_via']->value, 'via');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['via']->value) {
?>
                <?php if ($_smarty_tpl->tpl_vars['branch']->value->organization->station->code == $_smarty_tpl->tpl_vars['via']->value['code']) {?>
                    <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['load_branches']) ? $_smarty_tpl->tpl_vars['load_branches']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['branch']->value->organization->code] = $_smarty_tpl->tpl_vars['branch']->value->organization;
$_smarty_tpl->_assignInScope('load_branches', $_tmp_array);?>
                    <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['load_station_branches']) ? $_smarty_tpl->tpl_vars['load_station_branches']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['branch']->value->organization->station->code][$_smarty_tpl->tpl_vars['branch']->value->organization->code] = $_smarty_tpl->tpl_vars['branch']->value->organization;
$_smarty_tpl->_assignInScope('load_station_branches', $_tmp_array);?>                    
                <?php }?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

        <?php $_smarty_tpl->_assignInScope('rows', 0);?>

        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'list', false, 'toorganization');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['toorganization']->value => $_smarty_tpl->tpl_vars['list']->value) {
?>
            <tr>
                <td colspan="14" align="center" class="active"><?php echo $_smarty_tpl->tpl_vars['toorganization']->value;?>
</td>
            </tr>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['list']->value, 'row', false, 't');
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
                <tr class="<?php if ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 1 || $_smarty_tpl->tpl_vars['action_rights']->value['OGPL-HUB-LOAD'] == 1) {?>bg-success<?php } elseif ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 2) {?>bg-warning<?php } elseif ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 3) {?>bg-danger<?php }?>">
                    <td align="center">
                        <?php if ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 1 || $_smarty_tpl->tpl_vars['action_rights']->value['OGPL-HUB-LOAD'] == 1) {?>
                            <input type="checkbox" class="ogpl-new-items" data-tobranch="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_code;?>
" data-from="<?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_code;?>
" data-to="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_code;?>
" data-oldtransitorg="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_organization_code;?>
" data-oldtransitstn="<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_station_code;?>
" value="<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
" />
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
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['asc_ar']->value, 'code', false, 'key', 'name', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['code']->value) {
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
                    <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
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
                        <?php if ($_smarty_tpl->tpl_vars['allowloadstatus']->value == 1 || $_smarty_tpl->tpl_vars['action_rights']->value['OGPL-HUB-LOAD'] == 1) {?>
                            <select class="load-branch-sel form-control load-branch" >
                                <?php if (count($_smarty_tpl->tpl_vars['tload_branches']->value) > 0) {?>
                                    <option value="">Select a branch</option>
                                <?php }?>

                                <?php if (in_array($_smarty_tpl->tpl_vars['row']->value->load_type,array('FTL','PTL'))) {?>
                                    <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_code;?>
" data-station="<?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_code;?>
" selected><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</option>
                                <?php }?>
            
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['tload_branches']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                    <option value="<?php echo $_smarty_tpl->tpl_vars['branch']->value->code;?>
" data-station="<?php echo $_smarty_tpl->tpl_vars['branch']->value->station->code;?>
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

<div class="clearfix_both"></div><br />
<div class="row">
    <div class="col-md-12 text-right">
        <div class="row">
            <div class="col-md-8 pull-right">
                <div class="alert pull-right" id="load-ogpl-action-state" style="display: none"></div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <?php if ($_smarty_tpl->tpl_vars['transitCode']->value) {?>
                    <a href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['transitCode']->value;?>
&date=<?php echo $_smarty_tpl->tpl_vars['tripDate']->value;?>
" id="ogpl-view-chart-shortcut" class="btn btn-primary pull-left">View Chart</a>
                <?php }?>
            </div>
            <div class="col-md-8 pull-right">

                <div class="row text-right">
                    <div class="col-md-4 col-md-offset-4">
                        <label class="hidden">
                            <input type="checkbox" id="ogpl-load-hub" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['OGPL-HUB-LOAD'] == 1) {?>checked<?php }?> />&nbsp; Load to Hub
                        </label>
                    </div>
                    <div class="col-md-4">
                        <?php if ((!isset($_smarty_tpl->tpl_vars['odoDetails']->value) && (in_array('FULL-TRK-LOAD',$_smarty_tpl->tpl_vars['ogpl']->value->activity) || in_array('PART-TRK-LOAD',$_smarty_tpl->tpl_vars['ogpl']->value->activity))) || (isset($_smarty_tpl->tpl_vars['odoDetails']->value) && $_smarty_tpl->tpl_vars['odoDetails']->value->startOdometer == 0)) {?>
                            <button class="btn btn-warning" id="start-odometer-btn" type="button" onclick="showStartTripDialog();">Start Trip</button>
                        <?php }?>
                        
                        <?php if ($_smarty_tpl->tpl_vars['show_end_odo']->value == 1) {?>
                            <button class="btn btn-warning" id="end-odometer-btn" type="button" onclick="showOGPLEndTripDialog();">End Trip</button>&nbsp;
                        <?php }?>
                        <button class="btn btn-success" type="button" id="load-to-ogpl-btn" onclick="loadOGPL();">Load</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo '<script'; ?>
>
    var ogplDetailsData = <?php echo json_encode($_smarty_tpl->tpl_vars['ogpl']->value);?>
;
<?php echo '</script'; ?>
>
<?php }
}
