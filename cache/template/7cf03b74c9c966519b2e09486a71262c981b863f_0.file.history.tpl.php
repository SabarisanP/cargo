<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-24 19:39:09
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\history.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66797e05710b26_54878303',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '7cf03b74c9c966519b2e09486a71262c981b863f' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\history.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66797e05710b26_54878303 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Cargo History - <?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
</div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeCargoHistoryDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>
</div>

<div class="row">
    <div class="ticket-history-list">

        <?php if (count($_smarty_tpl->tpl_vars['transactions']->value) <= 0) {?>
            <br><br>
            <div class="text-center bold">Sorry! No history available.</div>
        <?php } else { ?>
            <div class="vertical-container dark-timeline" id="vertical-timeline">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactions']->value, 'trans');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['trans']->value) {
?>
                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon btn-info">
                            <i class="fa fa-history"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <div class="bold"><?php echo ucfirst($_smarty_tpl->tpl_vars['trans']->value->event);?>
</div>
                            <p>
                                By : <?php echo ucfirst($_smarty_tpl->tpl_vars['trans']->value->user_first_name);?>
, <?php echo $_smarty_tpl->tpl_vars['trans']->value->details;?>

                            </p>
                            <p>Device medium : <?php echo $_smarty_tpl->tpl_vars['trans']->value->device_medium;?>
</p>
                            <span class="vertical-date">
                                At : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['trans']->value->transaction_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
, <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['trans']->value->transaction_at,'%I:%M:%S %p');?>

                            </span>
                        </div>
                    </div>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </div>
        <?php }?>
    </div>
</div><?php }
}
