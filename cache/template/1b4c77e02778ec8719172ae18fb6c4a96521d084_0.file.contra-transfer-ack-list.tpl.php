<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-11 11:28:08
  from 'E:\xampp\htdocs\cargo\application\views\site\payment\contra-transfer-ack-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6667e770c46386_77822279',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '1b4c77e02778ec8719172ae18fb6c4a96521d084' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\payment\\contra-transfer-ack-list.tpl',
      1 => 1716451515,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6667e770c46386_77822279 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>

<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th>Date</th>
                <th>From Account</th>
                <th>Account</th>
                <th>To Account</th>
                <th>Account</th>
                <th>Amount</th>
                <th>Status</th>
                <th width="15%">Remarks</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td>
                        <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

                    </td>
                    <td>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->paymentContact->name;?>

                        <?php if ($_smarty_tpl->tpl_vars['row']->value->paymentContact->contactCategory->actionCode == 'BRCH') {?>
                            <br><span class="text-muted"><?php echo $_smarty_tpl->tpl_vars['row']->value->paymentContactOrganization->name;?>
</span>
                        <?php }?>
                    </td>

                    <td>
                        <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->paymentContactBankDetails->name)===null||$tmp==='' ? '-' : $tmp);?>
<br>
                        <span class="text-muted"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->paymentContactBankDetails->accountNumber)===null||$tmp==='' ? '-' : $tmp);?>
</span>
                    </td>

                    <td>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->vendorContact->name;?>

                        <?php if ($_smarty_tpl->tpl_vars['row']->value->vendorContact->contactCategory->actionCode == 'BRCH') {?>
                            <br><span class="text-muted"><?php echo $_smarty_tpl->tpl_vars['row']->value->vendorContactOrganization->name;?>
</span>
                        <?php }?>
                    </td>

                    <td>
                        <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->vendorContactBankDetails->name)===null||$tmp==='' ? '-' : $tmp);?>
<br>
                        <span class="text-muted"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->vendorContactBankDetails->accountNumber)===null||$tmp==='' ? '-' : $tmp);?>
</span>
                    </td>
                    
                    <td><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->amount);?>
</td>

                    <td>
                        <span class="badge badge-success"><?php echo $_smarty_tpl->tpl_vars['row']->value->paymentStatus->name;?>
</span>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->updatedBy->code)) {?>
                            <i class="fa fa-info-circle" data-toggle="popover" data-content="Updated By: <?php echo $_smarty_tpl->tpl_vars['row']->value->updatedBy->name;?>
<br>Updated Date: <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->updatedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
"></i>
                        <?php }?>
                    </td>

                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->remarks ? $_smarty_tpl->tpl_vars['row']->value->remarks : '-';?>
</td>

                    <td align="center">
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CONTRA-ALLOW-ALL-BRANCH'] == 1 || (isNotNull($_smarty_tpl->tpl_vars['row']->value->vendorContactOrganization->code) && $_smarty_tpl->tpl_vars['row']->value->vendorContactOrganization->code == $_smarty_tpl->tpl_vars['loggedin_user_org']->value)) {?>
                            <button class="btn-app btn-success" type="button" onclick="updateContraStatus('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', 'ACK');">Acknowledge</button>
                        <?php }?>
                    </td>
                </tr>
            <?php
}
} else {
?>
                <tr>
                    <td align="center" colspan="8">No data found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
</div>

<?php echo '<script'; ?>
>
    var contraAckData = <?php echo json_encode($_smarty_tpl->tpl_vars['result']->value);?>


    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
<?php echo '</script'; ?>
><?php }
}
