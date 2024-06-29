<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-31 16:47:15
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\branch-stock-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6659b1bb3428b2_11437284',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'b374687ffc3c6fa6d62d8201e2b09c46c73edcb4' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\branch-stock-report-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6659b1bb3428b2_11437284 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.replace.php','function'=>'smarty_modifier_replace',),));
?>
<style>
    .table .dataTable {
        margin-top: 0 !important;
    }

    .FixedHeader_Header {
        margin-top: -1px !important;
        z-index: 0 !important;
    }
</style>
<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Branch Stock Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['fromdate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['to_date']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span>
            <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> <?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
 </td>
    </tr>
</table>
<br />
<div class="clearfix"></div>
<h5><b>Summary</b></h5>
<table class="table table-bordered " style="width: 45%;">
    <thead>
        <tr class="success">
            <th></th>
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
            <th class="text-center" width="70">Total</th>
        </tr>
    </thead>
    <tbody>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'count', false, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value => $_smarty_tpl->tpl_vars['count']->value) {
?>
            <tr id="<?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['branch']->value,' ','');?>
" class="tr-hover" onclick="toggleToBranchHidRow('<?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['branch']->value,' ','');?>
')">
                <td align="left"><a href="javascript:;" onclick="filterBranch('<?php echo trim($_smarty_tpl->tpl_vars['branch']->value);?>
')"><b><?php echo $_smarty_tpl->tpl_vars['branch']->value;?>
</b></a></td>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['all_payment_status']->value, 'statuscount', false, 'statuscode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['statuscode']->value => $_smarty_tpl->tpl_vars['statuscount']->value) {
?>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['count']->value[$_smarty_tpl->tpl_vars['statuscode']->value]+0;?>
</td>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <td align="right" nowrap>
                    <b><?php echo $_smarty_tpl->tpl_vars['count']->value['total'];?>
</b>
                    <i class="fa fa-caret-down fa-fw pull-right" style="margin-top: 2px;"></i>
                </td>
            </tr>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
    <tfoot>
        <tr>
            <th align="left"><b>Total</b></th>
            <?php $_smarty_tpl->_assignInScope('tot', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['all_payment_status']->value, 'statuscount');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['statuscount']->value) {
?>
                <th class="text-right"><?php echo $_smarty_tpl->tpl_vars['statuscount']->value+0;?>
</th>
                <?php $_smarty_tpl->_assignInScope('tot', $_smarty_tpl->tpl_vars['tot']->value+$_smarty_tpl->tpl_vars['statuscount']->value);?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <td class="text-right"><b><?php echo $_smarty_tpl->tpl_vars['tot']->value;?>
</b></td>
        </tr>
    </tfoot>
</table>

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

<h5>
    <b>Transactions</b>
    <?php if ($_smarty_tpl->tpl_vars['cargoStatusCode']->value == 'CUL') {?>
        <button class="btn btn-default pull-right" onclick="print_branch_stock_delivary_report();"
            style="margin-bottom: 5px;"><i class="fa fa-print fa-lg"></i>Delivery Sheet</button>
    <?php }?>
</h5>

<table class="table-bordered" id="stock-report" width="100%">
    <thead>
        <tr class="tab-backgroud">
            <td align="center"><?php echo lang('cargo_code_term');?>
 <i class="fa fa-sort"></i></td>
            <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value != 'CB') {?>
                <td align="center">OGPL No <i class="fa fa-sort"></i></td>
            <?php }?>
            <td align="center">Booked Date <i class="fa fa-sort"></i></td>
            <td align="center" class="dt-filter" data-filterid="from-branch-filter" width="13%"><?php echo lang('booking_from_term');?>
 (Booking)<i class="fa fa-sort"></i></td>
            <td align="center" class="dt-filter" data-filterid="to-branch-filter" width="13%"><?php echo lang('booking_to_label');?>
 <i class="fa fa-sort"></i></td>
            <td align="center" class="dt-filter" data-filterid="transit-branch-filter" width="13%">Transit Branch <i class="fa fa-sort"></i></td>
            <td align="center" class="dt-filter" data-filterid="pay-status-filter">Payment Status <i class="fa fa-sort"></i></td>
            <td align="center">Cargo Status <i class="fa fa-sort"></i></td>
            <td align="center">Hub Activity <i class="fa fa-sort"></i></td>
            <td align="center">No. Of Articles <i class="fa fa-sort"></i></td>
            <td align="center">Qty <i class="fa fa-sort"></i></td>
            <td align="center">Freight <i class="fa fa-sort"></i></td>
            <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value == 'CMS') {?>
                <td align="center"><?php echo lang('ogpl');?>
 <i class="fa fa-sort"></i></td>
                <td align="center">Reg No. <i class="fa fa-sort"></i></td>
                <td align="center">Updated By <i class="fa fa-sort"></i></td>
                <td align="center">Updated At <i class="fa fa-sort"></i></td>
            <?php }?>
        </tr>
    </thead>
    <tbody class="body_table">
        <?php $_smarty_tpl->_assignInScope('t_item_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_total_item_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('demurrage_date', strtotime("-".((string)$_smarty_tpl->tpl_vars['cargo_setting']->value->demurrageDays)." days"));?>

        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr>
                <td align="left">
                    <a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a>

                    <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value == 'CUL' && $_smarty_tpl->tpl_vars['cargo_setting']->value->demurrageProcess->code != 'NOTAVL' && isNotNull($_smarty_tpl->tpl_vars['row']->value->unloaded_at)) {?>
                        <?php $_smarty_tpl->_assignInScope('unloadDate', strtotime($_smarty_tpl->tpl_vars['row']->value->unloaded_at));?>
                        <?php if ($_smarty_tpl->tpl_vars['unload_date']->value < $_smarty_tpl->tpl_vars['demurrage_date']->value) {?>
                            <span class="badge badge-warning">Demurrage</span>
                        <?php }?>
                    <?php }?>

                    <i class="fa fa-info-circle pull-right" data-toggle="popover" data-content='
                        <b><?php echo lang('booking_sender_term');?>
  :</b> <?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
 - <?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
<br/>
                        <b><?php echo lang('booking_receiver_term');?>
 :</b> <?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
 - <?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
<br/>
                    '></i>
                </td>
                <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value != 'CB') {?>
                    <td align="left">
                        <a href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_code;?>
&date=<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->trip_date,"Y-m-d");?>
" title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value->alias_code;?>
</a>
                    </td>
                <?php }?>
                <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,'%d %b, %I:%M %p');?>
</td>
                <td align="left"><?php echo trim($_smarty_tpl->tpl_vars['row']->value->from_organization_name);?>
</td>
                <td align="left"><?php echo trim($_smarty_tpl->tpl_vars['row']->value->to_organization_name);?>
</td>
                <td align="left"><?php echo trim($_smarty_tpl->tpl_vars['row']->value->transit_organization_name);?>
</td>
                <td align="left">
                    <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_type_code);?>

                </td>
                <td align="left">
                    <?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>

                </td>
                <td align="center">
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->hub_transit_tag) {?>
                        <?php $_smarty_tpl->_assignInScope('hubflags', comma_split($_smarty_tpl->tpl_vars['row']->value->hub_transit_tag));?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['hubflags']->value, 'flag');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['flag']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['flag']->value == 'HL') {?>
                                <span class="badge badge-secondary">Hub.L</span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['flag']->value == 'HU') {?>
                                <span class="badge badge-secondary">Hub.UL</span>
                            <?php }?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <?php } else { ?>
                        -
                    <?php }?>
                </td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->item_count;?>
</td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value == 'CMS') {?>
                    <td align="left"><?php echo isNotNull($_smarty_tpl->tpl_vars['row']->value->alias_code) ? $_smarty_tpl->tpl_vars['row']->value->alias_code : '-';?>
</td>
                    <td align="left"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->registration_number)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    <td align="left"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->status_updated_user_name)===null||$tmp==='' ? '-' : $tmp);?>
 <br /><small class="text-muted" title="Branch"><?php echo $_smarty_tpl->tpl_vars['row']->value->status_updated_organization_name;?>
</small></td>
                    <td align="left" nowrap>
                        <?php echo isNotNull($_smarty_tpl->tpl_vars['row']->value->status_updated_at) ? (smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->status_updated_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value)) : '-';?>

                    </td>
                <?php }?>
            </tr>
            <?php $_smarty_tpl->_assignInScope('t_item_count', $_smarty_tpl->tpl_vars['t_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->item_count);?>
            <?php $_smarty_tpl->_assignInScope('t_total_item_count', $_smarty_tpl->tpl_vars['t_total_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
            <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
    <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
        <tfoot>
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="<?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value != 'CB') {?>8<?php } else { ?>7<?php }?>" align="center">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['paytype_summary']->value, 'amt', false, 'paytype');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['paytype']->value => $_smarty_tpl->tpl_vars['amt']->value) {
?>
                        <b><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['paytype']->value];?>
 : </b> <?php echo inr_format($_smarty_tpl->tpl_vars['amt']->value);?>
&emsp;&emsp;&emsp;
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </td>
                <td colspan="1" align="right"><b>Total</b></td>
                <td align='right'><?php echo $_smarty_tpl->tpl_vars['t_item_count']->value;?>
</td>
                <td align='right'><?php echo $_smarty_tpl->tpl_vars['t_total_item_count']->value;?>
</td>
                <td align='right'><?php echo inr_format($_smarty_tpl->tpl_vars['t_total_amount']->value);?>
</td>
                <?php if ($_smarty_tpl->tpl_vars['cargo_status_code']->value == 'CMS') {?>
                    <td colspan="4"></td>
                <?php }?>
            </tr>
        </tfoot>
    <?php }?>
</table>



<div class="table table-responsive print-branch-stock-delivary hide">
    <table class="table table-bordered">
                <tr>
            <td colspan="11" align="center"><b><?php echo $_smarty_tpl->tpl_vars['operatorName']->value;?>
</b></td>
        </tr>
        <tr>
            <td colspan="4" align="left"><b>Report Date :</b>&nbsp;
                <?php echo smarty_modifier_date_format($_REQUEST['fromDate'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to
                <?php echo smarty_modifier_date_format($_REQUEST['toDate'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 </td>
            <td align="left" colspan="2">Paid - <?php echo $_smarty_tpl->tpl_vars['all_payment_status']->value['PAD'];?>
 &nbsp;&nbsp;&nbsp;ToPay -
                <?php echo $_smarty_tpl->tpl_vars['all_payment_status']->value['TOP'];?>
</td>
            <td colspan="5" align="right"><?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
 @ <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
        </tr>
        <tr>
            <th align="left">Booked</th>
            <th align="left">LR</th>
            <th align="left">Receiver</th>
            <th align="left">Mobile</th>
            <th align="left">Items</th>
            <th align="left">Qty</th>
            <th align="right">Paid</th>
            <th align="right">To Pay</th>
            <th align="left">UL&nbsp;&nbsp;</th>
            <th align="left">Total</th>
            <th>Sign&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        </tr>
                <tbody class="body_table">
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="left"><?php echo date('d-M',strtotime($_smarty_tpl->tpl_vars['row']->value->booked_at));?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>

                    <?php $_smarty_tpl->_assignInScope('rcv', ucfirst(strtolower($_smarty_tpl->tpl_vars['row']->value->to_customer_name)));?>
                    <?php if (strlen($_smarty_tpl->tpl_vars['rcv']->value) > 30) {?>
                        <td align="left"><?php echo substr_replace($_smarty_tpl->tpl_vars['rcv']->value,"...",30);?>
</td>
                    <?php } else { ?>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['rcv']->value;?>
</td>
                    <?php }?>

                    <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                    <td align="left" wrap><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == 'PAD') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->total_amount;?>

                        <?php } else { ?>
                            0.00
                        <?php }?>
                    </td>
                    <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
">
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == 'TOP') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->total_amount;?>

                        <?php } else { ?>
                            0.00
                        <?php }?>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
</div>

<?php echo '<script'; ?>
>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });

    // working
    let table = $('#stock-report').DataTable({

        pageLength: 250,
        lengthMenu: [
            [50, 100, 250, 500, -1],
            [50, 100, 250, 500, "All"]
        ],
        initComplete: function() {
            var datatable = this.api();
            datatable.columns().iterator('column', function(context, index) {
                var column = datatable.column(index);
                var columnData = column.data().unique();
                if (!columnData.length || !$(column.header()).hasClass('dt-filter')) return;

                var select = $(
                        '<select class="form-control text-left"><option value="">Select</option></select>'
                    )
                    .attr('id', column.header().dataset.filterid)
                    .appendTo(column.header())
                    .on('click change', function(e) {
                        if ($(this).val() == '') {
                            column.search($(this).val(), false, false).draw();
                            return false;
                        }
                        column.search("^" + $(this).val() + "$", true, false, true).draw();
                        return false;
                    });

                $(select).select2({ width: '100%' })

                columnData.sort().each(function(d) {
                    select.append(new Option($('<div/>').html(d).text()))
                });
            });
        }
    });
    new $.fn.dataTable.FixedHeader(table);




    function filterBranch(branch) {
        var groupby = '<?php echo $_smarty_tpl->tpl_vars['summary_group_by']->value;?>
';

        if (groupby == 'transit_organization_name') {
            $('#transit-branch-filter').val(branch).trigger('change');
        } else if (groupby == 'from_organization_name') {
            $('#from-branch-filter').val(branch).trigger('change');
        }

        $('html, body').animate({
            scrollTop: $('#stock-report').offset().top - 35
        }, 'slow');
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

    function hideElements() {
        $('.FixedHeader_Cloned.fixedHeader.FixedHeader_Header').hide();
        $('#stock-report thead').removeClass("dataTable");
    }

    $('a').click(function(e) {
        var hrefValue = $(this).attr('href');
        if (hrefValue && hrefValue !== "javascript:;" && hrefValue !== "#top") {
            hideElements();
        }
    });
<?php echo '</script'; ?>
><?php }
}
