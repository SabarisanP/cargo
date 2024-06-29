<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:37:00
  from 'E:\xampp\htdocs\cargo\application\views\site\widgets\dashboard-branch-tiles.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e274728490_03278427',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '211ca23d92e776b849fec96df0aba7e73bcef599' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\widgets\\dashboard-branch-tiles.tpl',
      1 => 1716451522,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e274728490_03278427 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div>
    <table class="table" id="dash-dayclosing-panel-table" data-last-updated="(As on <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['dayclosing_summary']->value->datetime,$_smarty_tpl->tpl_vars['ns_time_format']->value);?>
)">
        <thead class="bold">
            <tr>
                <td class="sticky-row-top">Branch</td>
                <td class="sticky-row-top" align="right">Last Closed Range</td>
                <td class="sticky-row-top" align="right">Last Closed At</td>
                <td class="sticky-row-top" align="right">Pending Approval</td>
                <td class="sticky-row-top" align="right">Settlement Amount</td>
            </tr>
        </thead>
        <tbody>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['dayclosing_summary']->value->data, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->organization->name;?>
</td>
                    <td align="right" title="From <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->lastClosingDetails->fromDate,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->lastClosingDetails->toDate,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
">
                        <?php $_smarty_tpl->_assignInScope('lastcloseddays', daysBetween($_smarty_tpl->tpl_vars['row']->value->lastClosingDetails->fromDate,$_smarty_tpl->tpl_vars['row']->value->lastClosingDetails->toDate));?>
                        <?php if ($_smarty_tpl->tpl_vars['lastcloseddays']->value == 0) {?>
                            Same Day
                        <?php } elseif ($_smarty_tpl->tpl_vars['lastcloseddays']->value == 1) {?>
                            1 Day
                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['lastcloseddays']->value;?>
 Days
                        <?php }?>
                    </td>
                    <td align="right" title="By: <?php echo $_smarty_tpl->tpl_vars['row']->value->lastClosingDetails->user->name;?>
"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->lastClosingDetails->toDate,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                    <td align="right"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value->pendingCount,$_smarty_tpl->tpl_vars['d_pending']->value);?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value->pendingAmount,$_smarty_tpl->tpl_vars['d_amount']->value));?>
</td>
                </tr>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="5" align="center">No details found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
    </table>

    <table class="table" id="dash-expense-panel-table" data-last-updated="(As on <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['expense_summary']->value->datetime,$_smarty_tpl->tpl_vars['ns_time_format']->value);?>
)">
        <thead class="bold">
            <tr>
                <td class="sticky-row-top">Branch</td>
                <td class="sticky-row-top" align="right">Pending Approval</td>
                <td class="sticky-row-top" align="right">Income</td>
                <td class="sticky-row-top" align="right">Expense</td>
            </tr>
        </thead>
        <tbody>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['expense_summary']->value->data, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->organization->name;?>
</td>
                    <td align="right"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value->pendingCount,$_smarty_tpl->tpl_vars['t_pending']->value);?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value->incomeAmount,$_smarty_tpl->tpl_vars['t_income']->value));?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value->expenseAmount,$_smarty_tpl->tpl_vars['t_expense']->value));?>
</td>
                </tr>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="4" align="center">No details found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
    </table>
</div>
<?php }
}
