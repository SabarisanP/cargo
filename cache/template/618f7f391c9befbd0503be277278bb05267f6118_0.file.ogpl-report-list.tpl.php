<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-24 12:31:43
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667919d75ed0b5_98334099',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '618f7f391c9befbd0503be277278bb05267f6118' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-report-list.tpl',
      1 => 1719203913,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667919d75ed0b5_98334099 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.replace.php','function'=>'smarty_modifier_replace',),2=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>
<link href="assets/lib/leaflet/leaflet.css" rel="stylesheet" type="text/css" media="screen">
<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Transit Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['fromDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['toDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> <?php echo $_smarty_tpl->tpl_vars['username']->value;?>
 </td>
    </tr>
</table>

<div class="clearfix"></div>
<h5><b>Summary</b></h5>
<table class="table table-bordered" style="width: 45%;">
    <thead>
        <tr class="success">
            <th class="text-center">Vechile Number</th>
            <th class="text-center">Route</th>
            <th class="text-center">Transit Code</th>
          
            <th class="text-center">KM</th>
            <th class="text-center" width="70">Total Lr</th>
        </tr>
    </thead>
    <tbody>
        <?php $_smarty_tpl->_assignInScope('totalKm', 0);?>
        <?php $_smarty_tpl->_assignInScope('totalodm', 0);?>
        <?php $_smarty_tpl->_assignInScope('totalLr', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['routewise']->value, 'singleCount', false, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value => $_smarty_tpl->tpl_vars['singleCount']->value) {
?>
            <?php $_smarty_tpl->_assignInScope('index', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['singleCount']->value['transitCode'], 'count', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['count']->value) {
?>  
                <?php $_smarty_tpl->_assignInScope('index', $_smarty_tpl->tpl_vars['index']->value+1);?>
                <?php $_smarty_tpl->_assignInScope('rowCount', count($_smarty_tpl->tpl_vars['singleCount']->value['transitCode']));?>
                <tr id="<?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['branch']->value,' ','');?>
">
                    <?php if ($_smarty_tpl->tpl_vars['index']->value == 1) {?>
                        <td align="left" rowspan="<?php echo $_smarty_tpl->tpl_vars['rowCount']->value;?>
"><a href="javascript:;" onclick="filterBranch('<?php echo trim($_smarty_tpl->tpl_vars['branch']->value);?>
')"><b><?php echo $_smarty_tpl->tpl_vars['branch']->value;?>
</b></a></td>
                    <?php }?>
                        <td align="left"><b><?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['count']->value->route,'-',' - ');?>
</b></td>
                        <td align="center" nowrap>
                            <span class="text-success">
                                <a title="Click to get OGPL Trip Chart" href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['count']->value->transit_code;?>
&date=<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['count']->value->trip_date,'Y-m-d');?>
" title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['count']->value->alias_code;?>
</a>
                            </span>
                        </td>
                        </td>
                    <?php if ($_smarty_tpl->tpl_vars['index']->value == 1) {?>
                        <?php $_smarty_tpl->_assignInScope('totalKm', $_smarty_tpl->tpl_vars['totalKm']->value+$_smarty_tpl->tpl_vars['singleCount']->value['totalKm']);?>
                        <td align="right" rowspan="<?php echo $_smarty_tpl->tpl_vars['rowCount']->value;?>
"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['singleCount']->value['totalKm'])===null||$tmp==='' ? 0 : $tmp);?>
</td>
                       
                    <?php }?>
                    <td align="right" nowrap>
                        <b><?php echo $_smarty_tpl->tpl_vars['count']->value->lr_count;?>
</b>
                    </td>
                    <?php $_smarty_tpl->_assignInScope('totalLr', $_smarty_tpl->tpl_vars['totalLr']->value+$_smarty_tpl->tpl_vars['count']->value->lr_count);?>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
    <tfoot>
        <tr>
            <td align="right" colspan="3"><b>Total </b></td>
            <td align="right"><b><?php echo $_smarty_tpl->tpl_vars['totalKm']->value;?>
</b></td>
            <td class="text-right"><b><?php echo $_smarty_tpl->tpl_vars['totalLr']->value;?>
</b></td>
        </tr>
    </tfoot>
</table>

<table class="hide" width="100">
<?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['routewise']->value, 'val', false, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
        <tr class="<?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['branch']->value,' ','');?>
 hide summary-to-branch">
            <td>
                <table class="table table-bordered " width="100%">
                    <thead>
                        <tr class="active">
                            <th class="text-center">Route</th>
                            <th class="text-center">Transite Code</th>
                            <th class="text-center">ODM</th>
                            <th class="text-center">KM</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                       <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['val']->value['transitCode'], 'innerval', false, 'transitCode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['transitCode']->value => $_smarty_tpl->tpl_vars['innerval']->value) {
?>
                            <tr>
                                <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['innerval']->value->route;?>
</b></td>
                                <td align="center" nowrap>
                                <span class="text-success">
                                <a title="Click to get OGPL Trip Chart"  href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['innerval']->value->transit_code;?>
&date=<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['innerval']->value->trip_date,"Y-m-d");?>
" title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['innerval']->value->alias_code;?>
</a>
                                </span> 
                                </td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['innerval']->value->km;?>
</td>
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


<div class="overflow-x-auto">   
    <table id="cargo_revenue_report_table" class="table table-bordered table-bordered-1" style="width: 99%;">
        <thead>
            <tr class="success">
                <td>Vehicle / Driver</td>
                <td><?php echo lang('ogpl');?>
 Number</td>
                <td>Route</td>
                <td>Via Stations</td>
                <td>Date of Created</td>
                <td>Total Odometer</td>
                <td>Number of <?php echo lang('lr');?>
 loaded</td>
                <td>Number Of <?php echo lang('lr');?>
 Unloaded</td>
                <td nowrap>Hub<br/>Loaded|<br/>Hub<br/>Unloaded</td>
                <td nowrap>E-way<br/>Bill A/B</td>
                <td align="center">Expenses</td>
                <td align="center" >Transit Amount</td>
                <td align="center">Fuel<br>LTR|AMT</td>
                <td>Unloaded By</td>
                <td>Status</td>
                <td>Remarks</td> 
            </tr>
        </thead>
        <tbody class="body_table" >

            <?php $_smarty_tpl->_assignInScope('t_load_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_cargo_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_unload_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_fuel_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_transit_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_hub_load_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_hub_unload_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_e_way_bill_A', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_e_way_bill_B', 0);?>

            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
              
                    <tr class = "message-box">
                        <td align="left">
                        <a href="javascript:;" title="Click to get Vehicle History" onclick="getTransitHistory('<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->alias_code;?>
', 'VEHICLE')"><?php echo $_smarty_tpl->tpl_vars['row']->value->registration_numer;?>
</a><br>
                        <span class="text-muted" title="Driver"><?php echo isNotNull($_smarty_tpl->tpl_vars['row']->value->driver_name) ? $_smarty_tpl->tpl_vars['row']->value->driver_name : '';?>
</span>
                        </br>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->transit_type == 'TRNT' && 'HBTRNT') {?><span class="badge badge-info">Out Station</span><?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transit_type == 'INTRNT' && 'OTFD') {?><span class="badge badge-secondary">Local</span><?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transit_type == 'OTFD') {?><span class="badge badge-danger">OF Delivery</span><?php }?>
                        </td>
                        <td align="left" >
                            <span class="text-success">
                                <a title="Click to get OGPL Trip Chart"  href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_code;?>
&date=<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->trip_date,"Y-m-d");?>
" title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value->alias_code;?>
</a>
                            </span> 
                            </br>
                            <span class="input-group-addon" title="Click to get Transit History" onclick="getTransitHistory('<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_code;?>
', '<?php echo $_smarty_tpl->tpl_vars['row']->value->alias_code;?>
')"> <center><i class="fa fa-history" aria-hidden="true"></i></center></span>
                            <span class="input-group-addon"  title="Click to get Transit Odometer" > <center><svg onclick ="openRoutesModel('<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_code;?>
')" xmlns="http://www.w3.org/2000/svg" style="text-align:center;width:16px;color:blue" viewBox="0 0 512 512"><path d="M512 96c0 50.2-59.1 125.1-84.6 155c-3.8 4.4-9.4 6.1-14.5 5H320c-17.7 0-32 14.3-32 32s14.3 32 32 32h96c53 0 96 43 96 96s-43 96-96 96H139.6c8.7-9.9 19.3-22.6 30-36.8c6.3-8.4 12.8-17.6 19-27.2H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320c-53 0-96-43-96-96s43-96 96-96h39.8c-21-31.5-39.8-67.7-39.8-96c0-53 43-96 96-96s96 43 96 96zM117.1 489.1c-3.8 4.3-7.2 8.1-10.1 11.3l-1.8 2-.2-.2c-6 4.6-14.6 4-20-1.8C59.8 473 0 402.5 0 352c0-53 43-96 96-96s96 43 96 96c0 30-21.1 67-43.5 97.9c-10.7 14.7-21.7 28-30.8 38.5l-.6 .7zM128 352a32 32 0 1 0 -64 0 32 32 0 1 0 64 0zM416 128a32 32 0 1 0 0-64 32 32 0 1 0 0 64z"/></svg></center></span>

                        </td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
</td>
                        <td align="left"><?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['row']->value->via_stations,',',', ');?>
</td>

                    
                        <td align="left" nowrap>
                        <span >
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->audit_updated_at)) {?>
                        <?php $_smarty_tpl->_assignInScope('formatted_date', smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->audit_updated_at,"%d-%m-%Y"));?>
                        <?php $_smarty_tpl->_assignInScope('formatted_time', smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->audit_updated_at,"%I:%M %p"));?>
                        <?php echo $_smarty_tpl->tpl_vars['formatted_date']->value;?>
<br/><?php echo $_smarty_tpl->tpl_vars['formatted_time']->value;?>

                        <?php }?>
                    </span>
                    </br>
                            <span class="text-muted" title="Created By"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->audit_user_name)===null||$tmp==='' ? '-' : $tmp);?>
</span>
                        </td>
                        <td align="left">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->start_odometer && $_smarty_tpl->tpl_vars['row']->value->end_odometer) {?>
                            <?php $_smarty_tpl->_assignInScope('distance', $_smarty_tpl->tpl_vars['row']->value->end_odometer-$_smarty_tpl->tpl_vars['row']->value->start_odometer);?>
                            <?php echo $_smarty_tpl->tpl_vars['distance']->value;?>
 Km
                        <?php } else { ?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->start_odometer) {?>
                                <?php $_smarty_tpl->_assignInScope('endOdm', 0);?>
                                <?php $_smarty_tpl->_assignInScope('startOdm', $_smarty_tpl->tpl_vars['row']->value->start_odometer);?>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->end_odometer) {?>
                                <?php $_smarty_tpl->_assignInScope('endOdm', $_smarty_tpl->tpl_vars['row']->value->end_odometer);?>
                                <?php $_smarty_tpl->_assignInScope('startOdm', 0);?>
                            <?php } else { ?>
                                <?php $_smarty_tpl->_assignInScope('endOdm', 0);?>
                                <?php $_smarty_tpl->_assignInScope('startOdm', 0);?>
                            <?php }?>
                            <?php $_smarty_tpl->_assignInScope('distance', $_smarty_tpl->tpl_vars['endOdm']->value-$_smarty_tpl->tpl_vars['startOdm']->value);?>
                            <?php $_smarty_tpl->_assignInScope('distance', (($tmp = @abs($_smarty_tpl->tpl_vars['distance']->value))===null||$tmp==='' ? '-' : $tmp));?>
                            <?php echo $_smarty_tpl->tpl_vars['distance']->value;?>
 ODM
                        <?php }?>
                        </td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_count;?>
 </td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->unload_count;?>
</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->hub_load_count;?>
 | <?php echo $_smarty_tpl->tpl_vars['row']->value->hub_unload_count;?>
</td>
                        <td align="right"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->eway_bill_added_count)===null||$tmp==='' ? '0' : $tmp);?>
 / <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->eway_bill_part_b_updated_count)===null||$tmp==='' ? '0' : $tmp);?>
</td>
                        <?php $_smarty_tpl->_assignInScope('totalFuelLtr', 0);?>
                        <?php $_smarty_tpl->_assignInScope('totalFuelAmount', 0);?>
                        <td align="right" nowrap>
                        <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_fuel_amount);?>
&nbsp;
                        
                        <?php $_smarty_tpl->_assignInScope('transit_fuel_details', explode("|",$_smarty_tpl->tpl_vars['row']->value->transit_fuel_details));?>
                        <?php $_smarty_tpl->_assignInScope('fuelDetails', '');?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transit_fuel_details']->value, 'fuel');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['fuel']->value) {
?>
                            <?php $_smarty_tpl->_assignInScope('fuelArray', explode(",",$_smarty_tpl->tpl_vars['fuel']->value));?>
                            <?php $_smarty_tpl->_assignInScope('fuelDetails', ((($_smarty_tpl->tpl_vars['fuelDetails']->value).('<b>Fuel Vendor : ')).($_smarty_tpl->tpl_vars['fuelArray']->value[3])).('</b><br>'));?>
                            <?php $_smarty_tpl->_assignInScope('fuelDetails', ((($_smarty_tpl->tpl_vars['fuelDetails']->value).('Payment Mode : ')).($_smarty_tpl->tpl_vars['fuelArray']->value[0])).('<br>'));?>
                            <?php $_smarty_tpl->_assignInScope('fuelDetails', ((($_smarty_tpl->tpl_vars['fuelDetails']->value).('Litres : ')).($_smarty_tpl->tpl_vars['fuelArray']->value[1])).('<br>'));?>
                            <?php $_smarty_tpl->_assignInScope('totalFuelLtr', $_smarty_tpl->tpl_vars['totalFuelLtr']->value+$_smarty_tpl->tpl_vars['fuelArray']->value[1]);?>
                            <?php $_smarty_tpl->_assignInScope('fuelDetails', ((($_smarty_tpl->tpl_vars['fuelDetails']->value).('Amount : ')).($_smarty_tpl->tpl_vars['fuelArray']->value[2])).('<br>'));?>
                            <?php $_smarty_tpl->_assignInScope('totalFuelAmount', $_smarty_tpl->tpl_vars['totalFuelAmount']->value+$_smarty_tpl->tpl_vars['fuelArray']->value[2]);?>
                            <?php $_smarty_tpl->_assignInScope('fuelDetails', ($_smarty_tpl->tpl_vars['fuelDetails']->value).('<br>'));?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->transit_fuel_details)) {?>
                            <a href="javascript:;" data-toggle="popover" data-content="<?php echo $_smarty_tpl->tpl_vars['fuelDetails']->value;?>
" style="cursor:pointer;">
                                <i class="fa fa-info-circle" aria-hidden="true"></i>
                            </a>
                        <?php }?>
                        </td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_transit_amount);?>
</td>
                        <td align="right"><?php ob_start();
echo ($_smarty_tpl->tpl_vars['totalFuelLtr']->value).(' L|');
$_prefixVariable1 = ob_get_clean();
echo $_prefixVariable1;?>
<br/><?php ob_start();
echo (inr_format($_smarty_tpl->tpl_vars['totalFuelAmount']->value));
$_prefixVariable2 = ob_get_clean();
echo $_prefixVariable2;?>
</td>
                                                <td align="left" nowrap>
                            <span title="<?php echo $_smarty_tpl->tpl_vars['row']->value->unloaded_user_name;?>
"><?php echo (($tmp = @smarty_modifier_truncate($_smarty_tpl->tpl_vars['row']->value->unloaded_user_name,20))===null||$tmp==='' ? '-' : $tmp);?>
</span><br>
                                                                                    <span class="text-muted" title="Unloaded At">
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->unloaded_at) {?>
                            <?php $_smarty_tpl->_assignInScope('formatted_date', smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloaded_at,"%d-%m-%Y"));?>
                            <?php $_smarty_tpl->_assignInScope('formatted_time', smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloaded_at,"%I:%M %p"));?>
                            <?php echo $_smarty_tpl->tpl_vars['formatted_date']->value;?>
<br/><?php echo $_smarty_tpl->tpl_vars['formatted_time']->value;?>

                            <?php }?>
                        </span>
                        
                        </td>

                        <td align="center">
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->transit_activity_status_code == 'NEW') {?>
                                <span class="badge badge-success">New</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transit_activity_status_code == 'INTRN') {?>
                                <span class="badge badge-warning">In-Transit</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transit_activity_status_code == 'CMPLT') {?>
                                <span class="badge badge-success">Completed</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transit_activity_status_code == 'TRNSFR') {?>
                                <span class="badge badge-danger">Transferred</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->transit_activity_status_code == 'EMPLD') {?>
                                <span class="badge badge-danger">Empty Load</span>
                            <?php }?>
                        </td>
                        
                        <td align="left" colspan="15"><?php echo $_smarty_tpl->tpl_vars['row']->value->remarks ? $_smarty_tpl->tpl_vars['row']->value->remarks : '-';?>
</td>
                    </tr>
              
                <?php $_smarty_tpl->_assignInScope('t_load_count', $_smarty_tpl->tpl_vars['t_load_count']->value+$_smarty_tpl->tpl_vars['row']->value->load_count);?>
                <?php $_smarty_tpl->_assignInScope('t_cargo_count', $_smarty_tpl->tpl_vars['t_cargo_count']->value+$_smarty_tpl->tpl_vars['row']->value->cargo_count);?>
                <?php $_smarty_tpl->_assignInScope('t_unload_count', $_smarty_tpl->tpl_vars['t_unload_count']->value+$_smarty_tpl->tpl_vars['row']->value->unload_count);?>
                <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                <?php $_smarty_tpl->_assignInScope('t_fuel_amount', $_smarty_tpl->tpl_vars['t_fuel_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_fuel_amount);?>
                <?php $_smarty_tpl->_assignInScope('t_transit_amount', $_smarty_tpl->tpl_vars['t_transit_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_transit_amount);?>
                <?php $_smarty_tpl->_assignInScope('t_hub_load_count', $_smarty_tpl->tpl_vars['t_hub_load_count']->value+$_smarty_tpl->tpl_vars['row']->value->hub_load_count);?>
                <?php $_smarty_tpl->_assignInScope('t_hub_unload_count', $_smarty_tpl->tpl_vars['t_hub_unload_count']->value+$_smarty_tpl->tpl_vars['row']->value->hub_unload_count);?>
                <?php $_smarty_tpl->_assignInScope('t_e_way_bill_A', $_smarty_tpl->tpl_vars['t_e_way_bill_A']->value+$_smarty_tpl->tpl_vars['row']->value->eway_bill_added_count);?>
                <?php $_smarty_tpl->_assignInScope('t_e_way_bill_B', $_smarty_tpl->tpl_vars['t_e_way_bill_B']->value+$_smarty_tpl->tpl_vars['row']->value->eway_bill_part_b_updated_count);?>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="14" align="center">No Records Found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
            <tfoot>
                <tr class="active bold">
                    <td colspan="6" align="right">Total</td>
                    <td align='right'><?php echo ($_smarty_tpl->tpl_vars['t_cargo_count']->value);?>
</td>
                    <td align='right'><?php echo ($_smarty_tpl->tpl_vars['t_unload_count']->value);?>
</td>
                    <td align='right'><?php echo ($_smarty_tpl->tpl_vars['t_hub_load_count']->value);?>
 / <?php echo ($_smarty_tpl->tpl_vars['t_hub_unload_count']->value);?>
</td>
                    <td align='right'><?php echo (($tmp = @($_smarty_tpl->tpl_vars['t_e_way_bill_A']->value))===null||$tmp==='' ? '0' : $tmp);?>
 / <?php echo (($tmp = @($_smarty_tpl->tpl_vars['t_e_way_bill_B']->value))===null||$tmp==='' ? '0' : $tmp);?>
</td>
                    <td align='right'><?php echo inr_format(($_smarty_tpl->tpl_vars['t_fuel_amount']->value));?>
</td>
                    <td align='right'><?php echo inr_format(($_smarty_tpl->tpl_vars['t_transit_amount']->value));?>
</td>
                    <td colspan="5"></td>
                </tr>
            </tfoot>
        <?php }?>
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportRevenueExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="<?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("rmtcargo","seenutransport","seenutrans"))) {?>printOgplReport()<?php } else { ?>window.print()<?php }?>"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>
<div id="route-dialog" class="flex d-flex justify-content-center justify-center align-center align-item-center hide">
    <div id="route-dialog-container" style="width: 100%;">
        <div id="route-dialog-header" style="height: 30px;"> 
        <div class="pull-right"> 
          <a title="close" href="javascript:;" class="btn-lg" onclick="closeRoutesModel()"> <i class="fa fa-times-circle fa-lg"></i> </a>
        </div>
        </div>
        <div id="route-dialog-content">
                   </div>
    </div>
</div>
<?php echo '<script'; ?>
 type="text/javascript" src="assets/lib/leaflet/leaflet.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
>
    var loading_spinner = "<div class='text-center'><img src='<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
/assets/img/loaders/20.gif' /></div>"
var result = <?php echo json_encode($_smarty_tpl->tpl_vars['result']->value);?>


        //  $("#search").on("input", function () {
        //     $(this).css('border', '');
        //     var searchTerm = $(this).val().toLowerCase();

        //     $(".message-box").each(function () {
        //         var isVisible = $(this).text().toLowerCase().includes(searchTerm);
        //         $(this).closest('tr').toggle(isVisible);
        //     });
        // });


// let table = $('#cargo_revenue_report_table').DataTable({

//         pageLength: 250,
//         lengthMenu: [
//             [50, 100, 250, 500, -1],
//             [50, 100, 250, 500, "All"]
//         ],
//         initComplete: function() {
//             var datatable = this.api();
//             datatable.columns().iterator('column', function(context, index) {
//                 var column = datatable.column(index);
//                 var columnData = column.data().unique();
//                 if (!columnData.length || !$(column.header()).hasClass('dt-filter')) return;

//                 var select = $(
//                         '<select class="form-control text-left"><option value="">Select</option></select>'
//                     )
//                     .attr('id', column.header().dataset.filterid)
//                     .appendTo(column.header())
//                     .on('click change', function(e) {
//                         if ($(this).val() == '') {
//                             column.search($(this).val(), false, false).draw();
//                             return false;
//                         }
//                         column.search("^" + $(this).val() + "$", true, false, true).draw();
//                         return false;
//                     });

//                 $(select).select2({ width: '100%' })

//                 columnData.sort().each(function(d) {
//                     select.append(new Option($('<div/>').html(d).text()))
//                 });
//             });
//         }
// });

$('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    function openRoutesModel(transitCode){
        $('#route-dialog').removeClass('hide');
            $('#route-dialog').dialog({
                autoOpen: true,
                height: $(window).height() - 30,
                width: $(window).width() - 100,
                modal: true,
                resizable: false,
                closeOnEscape: true
        });

        var data = {};
        data.transitCode = transitCode;
        $('#route-dialog-content').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-odometer-report',
            data: data,
            success: function(res) {
                $('#route-dialog-content').html(res);
                $('.demo').html(res);
            }
        });
    }
    function closeRoutesModel() {
            $('#route-dialog').addClass('hide');
            $('#route-dialog').dialog('destroy');
        }

        function toggleToBranchHidRow(code) {
        if ($('.saleusrlist').hasClass(code)) {
            $('.saleusrlist .slide').slideToggle('linear', function() {
                $('.saleusrlist').remove();
            });
            return;
        }
        $('.saleusrlist').remove();
        var $trows = $('.summary-to-branch').filter('.' + code);
        $('#' + code).after('<tr class="saleusrlist ' + code +
            '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">' +
            $trows.html() + '</table></div></td></tr>');
        $('.saleusrlist .slide').slideToggle('linear');
    }

    function filterBranch(branch) {
        var searchTerm = branch.toLowerCase();
        $(".message-box").each(function () {
            console.log($(this));
        var isVisible = $(this).text().toLowerCase().includes(searchTerm);
        $(this).closest('tr').toggle(isVisible);
        });
        $('html, body').animate({
            scrollTop: $('#cargo_revenue_report_table').offset().top - 35
        }, 'slow');
    }

<?php echo '</script'; ?>
><?php }
}
