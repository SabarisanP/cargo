<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-27 18:50:04
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\transit-history.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66548884df22d2_20261575',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '46b33674fee607823d2ca4ec172fde43e34949e9' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\transit-history.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66548884df22d2_20261575 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">
            <?php if ($_smarty_tpl->tpl_vars['filterType']->value == 'VEHICLE') {?>
                Transit Vehicle History - <?php echo $_smarty_tpl->tpl_vars['transitCode']->value;?>

            <?php } elseif ($_smarty_tpl->tpl_vars['filterType']->value == 'TRANSIT') {?>
                Transit Load / Unload History - <?php echo $_smarty_tpl->tpl_vars['transitCode']->value;?>

            <?php } else { ?>
                Cargo Transit History - <?php echo $_smarty_tpl->tpl_vars['transitCode']->value;?>

            <?php }?>
        </div>
        <div class="col-md-2">            
            <a class="align-right" onclick="closeCargoTransitHistoryDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<div class="">
    <div class="ticket-history-list">
        
        <?php if (count($_smarty_tpl->tpl_vars['transactions']->value) <= 0) {?>
            <br><br><div class="text-center bold">Sorry! No history available.</div>
        <?php } else { ?>
            <div class="vertical-container dark-timeline" id="vertical-timeline">
                <?php $_smarty_tpl->_assignInScope('whitelisted', array());?>
                <?php if ($_smarty_tpl->tpl_vars['filterType']->value == 'VEHICLE') {?>
                    <?php $_smarty_tpl->_assignInScope('whitelisted', array('CREATED','UPDATED'));?>
                <?php } elseif ($_smarty_tpl->tpl_vars['filterType']->value == 'TRANSIT') {?>
                    <?php $_smarty_tpl->_assignInScope('whitelisted', array('LOADED','UNLOADED','REMOVED'));?>
                <?php }?>

                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactions']->value, 'trans');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['trans']->value) {
?>
                    <?php $_smarty_tpl->_assignInScope('eventCode', strtoupper(clean_string(strrchr($_smarty_tpl->tpl_vars['trans']->value->event,' '))));?>
                    <?php if (isNotNull($_smarty_tpl->tpl_vars['filterType']->value) && !in_array($_smarty_tpl->tpl_vars['eventCode']->value,$_smarty_tpl->tpl_vars['whitelisted']->value)) {?>
                        <?php continue 1;?>
                    <?php }?>
                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon btn-primary">
                            <i class="fa fa-truck"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <div class="bold"><?php echo ucfirst($_smarty_tpl->tpl_vars['trans']->value->event);?>
</div>
                            <p>
                                By : <?php echo ucfirst($_smarty_tpl->tpl_vars['trans']->value->user_first_name);?>
, <?php echo $_smarty_tpl->tpl_vars['trans']->value->details;?>

                            </p>                    
                            <span class="vertical-date">
                                At : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['trans']->value->updated_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
, <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['trans']->value->updated_at,'%I:%M:%S %p');?>
                         
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
</div>        


<?php }
}
