<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-13 18:26:43
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\booking-report-summary.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666aec8bacd612_86254794',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'b16328ff2fcc4398157def5b9a6318fa8c720a97' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\booking-report-summary.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666aec8bacd612_86254794 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->smarty->ext->_tplFunction->registerTplFunctions($_smarty_tpl, array (
  'summarytable' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\b16328ff2fcc4398157def5b9a6318fa8c720a97_0.file.booking-report-summary.tpl.php',
    'uid' => 'b16328ff2fcc4398157def5b9a6318fa8c720a97',
    'call_name' => 'smarty_template_function_summarytable_1690161278666aec8b9aa800_20239220',
  ),
));
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.regex_replace.php','function'=>'smarty_modifier_regex_replace',),));
?>
<table class="" width="100%">
    <tr>
        <td colspan="2" align="center"><span class="bold"><?php echo iflang('Cargo Booking Report');?>
</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            <?php echo smarty_modifier_date_format($_REQUEST['fromDate'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to
            <?php echo smarty_modifier_date_format($_REQUEST['toDate'],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
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



<div>
    <h5><b>Branch wise Summary</b></h5>
    <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'summarytable', array('arr'=>$_smarty_tpl->tpl_vars['summary']->value,'type'=>'branch'), true);?>

</div>

<?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
    <div class="branch <?php echo mb_strtolower(smarty_modifier_regex_replace($_smarty_tpl->tpl_vars['branch']->value->name,'/[^\w]/',''), 'UTF-8');?>
 hide">
        <h5><b><?php echo $_smarty_tpl->tpl_vars['branch']->value->name;?>
 - Station wise Summary</b></h5>
        <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'summarytable', array('arr'=>$_smarty_tpl->tpl_vars['branch']->value->stations,'type'=>'station','branch'=>$_smarty_tpl->tpl_vars['branch']->value->name), true);?>

    </div>
<?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

<?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branch']->value->stations, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
        <div class="station <?php echo mb_strtolower(smarty_modifier_regex_replace($_smarty_tpl->tpl_vars['branch']->value->name,'/[^\w]/',''), 'UTF-8');?>
 <?php echo mb_strtolower(smarty_modifier_regex_replace($_smarty_tpl->tpl_vars['station']->value->name,'/[^\w]/',''), 'UTF-8');?>
 hide">
            <h5><b><?php echo $_smarty_tpl->tpl_vars['station']->value->name;?>
</b></h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="success bold">
                        <td>S.No</td>
                        <td><?php echo lang('lr');?>
 Number</td>
                        <td><?php echo lang('lr');?>
 Date</td>
                        <td><?php echo lang('booking_sender_term');?>
</td>
                        <td><?php echo lang('booking_receiver_term');?>
</td>
                        <td>Payment Type</td>
                        <td>Destination</td>
                        <td>Delivery Date</td>
                        <td>No.of Articles</td>
                                                <td>Freight</td>
                        <td>Other Charges</td>
                        <td>Total Amount</td>
                                            </tr>
                </thead>
                <tbody>
                    <?php $_smarty_tpl->_assignInScope('t_total_item_count', 0);?>
                    <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
                    <?php $_smarty_tpl->_assignInScope('t_other_charges_computed', 0);?>
                    <?php $_smarty_tpl->_assignInScope('t_net_amount_computed', 0);?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['station']->value->bookings, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <tr>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['i']->value+1;?>
</td>
                            <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                            <td align="left"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                            <td align="center"><?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->delivered_at ? (smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->delivered_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value)) : '-';?>
</td>
                            <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                                                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->other_charges_computed);?>
</td>
                            <td align="right"><?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->net_amount_computed));?>
</td>
                                                    </tr>
                        <?php $_smarty_tpl->_assignInScope('t_total_item_count', $_smarty_tpl->tpl_vars['t_total_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                        <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                        <?php $_smarty_tpl->_assignInScope('t_other_charges_computed', $_smarty_tpl->tpl_vars['t_other_charges_computed']->value+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                        <?php $_smarty_tpl->_assignInScope('t_net_amount_computed', $_smarty_tpl->tpl_vars['t_net_amount_computed']->value+$_smarty_tpl->tpl_vars['row']->value->net_amount_computed);?>
                    <?php
}
} else {
?>
                        <tr>
                            <td colspan="12" align="center">No Records Found</td>
                        </tr>
                    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                    <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                        <tr class="active bold">
                            <td align="right" colspan="8">Total</td>
                            <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_total_item_count']->value;?>
</td>
                                                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_total_amount']->value);?>
</td>
                            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_other_charges_computed']->value);?>
</td>
                            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_net_amount_computed']->value);?>
</td>
                        </tr>
                    <?php }?>
                </tbody>
            </table>
        </div>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

<?php echo '<script'; ?>
>
    function toggleSummaryDetails(type, station, branch) {
        if (type == 'branch') {
            $('.branch').addClass('hide');
        }
        $('.station').addClass('hide');

        var $table = $();
        if (branch) {
            $table = $('.' + type + '.' + station + '.' + branch);
        } else {
            $table = $('.' + type + '.' + station);
        }

        $table.removeClass('hide');
        $("html, body").animate({
            scrollTop: $table.offset().top - 35
        }, 1500);
    }
<?php echo '</script'; ?>
><?php }
/* smarty_template_function_summarytable_1690161278666aec8b9aa800_20239220 */
if (!function_exists('smarty_template_function_summarytable_1690161278666aec8b9aa800_20239220')) {
function smarty_template_function_summarytable_1690161278666aec8b9aa800_20239220(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('arr'=>array(),'type'=>'','branch'=>''), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.regex_replace.php','function'=>'smarty_modifier_regex_replace',),));
?>

    <table class="table table-bordered">
        <thead>
            <tr class="success bold">
                <td>Branch</td>
                <td>No of <?php echo iflang('lr');?>
</td>
                <td>No.of Articles</td>
                <td>Freight</td>
                <td>Other Charges</td>
                <td><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['PAD'];?>
 Amount</td>
                <td><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['TOP'];?>
 Amount</td>
                <td><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['INP'];?>
 Amount</td>
                <td>Total Amount</td>
            </tr>
        </thead>
        <tbody>
            <?php $_smarty_tpl->_assignInScope('t_total_lr_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_total_item_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_total_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_other_charges_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_topay_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_paid_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_topay_amount', 0);?>
            <?php $_smarty_tpl->_assignInScope('t_onaccount_amount', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['arr']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="left"><a href="javascript:;" title="more details" onclick="toggleSummaryDetails('<?php echo $_smarty_tpl->tpl_vars['type']->value;?>
', '<?php echo mb_strtolower(smarty_modifier_regex_replace($_smarty_tpl->tpl_vars['row']->value->name,'/[^\w]/',''), 'UTF-8');?>
', '<?php echo mb_strtolower(smarty_modifier_regex_replace($_smarty_tpl->tpl_vars['branch']->value,'/[^\w]/',''), 'UTF-8');?>
')"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</a></td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_lr_count;?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->paid_amount);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->topay_amount);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->onaccount_amount);?>
</td>
                    <td align="right"><?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->paid_amount+$_smarty_tpl->tpl_vars['row']->value->topay_amount+$_smarty_tpl->tpl_vars['row']->value->onaccount_amount));?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('t_total_lr_count', $_smarty_tpl->tpl_vars['t_total_lr_count']->value+$_smarty_tpl->tpl_vars['row']->value->total_lr_count);?>
                <?php $_smarty_tpl->_assignInScope('t_total_item_count', $_smarty_tpl->tpl_vars['t_total_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                <?php $_smarty_tpl->_assignInScope('t_total_amount', $_smarty_tpl->tpl_vars['t_total_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                <?php $_smarty_tpl->_assignInScope('t_other_charges_amount', $_smarty_tpl->tpl_vars['t_other_charges_amount']->value+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                <?php $_smarty_tpl->_assignInScope('t_paid_amount', $_smarty_tpl->tpl_vars['t_paid_amount']->value+$_smarty_tpl->tpl_vars['row']->value->paid_amount);?>
                <?php $_smarty_tpl->_assignInScope('t_topay_amount', $_smarty_tpl->tpl_vars['t_topay_amount']->value+$_smarty_tpl->tpl_vars['row']->value->topay_amount);?>
                <?php $_smarty_tpl->_assignInScope('t_onaccount_amount', $_smarty_tpl->tpl_vars['t_onaccount_amount']->value+$_smarty_tpl->tpl_vars['row']->value->onaccount_amount);?>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="9" align="center">No Records Found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

            <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
                <tr class="active bold">
                    <td align="right">Total</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_total_lr_count']->value;?>
</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['t_total_item_count']->value;?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_total_amount']->value);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_other_charges_amount']->value);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_paid_amount']->value);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_topay_amount']->value);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['t_onaccount_amount']->value);?>
</td>
                    <td align="right"><?php echo inr_format(($_smarty_tpl->tpl_vars['t_paid_amount']->value+$_smarty_tpl->tpl_vars['t_topay_amount']->value+$_smarty_tpl->tpl_vars['t_onaccount_amount']->value));?>
</td>
                </tr>
            <?php }?>
        </tbody>
    </table>
<?php
}}
/*/ smarty_template_function_summarytable_1690161278666aec8b9aa800_20239220 */
}
