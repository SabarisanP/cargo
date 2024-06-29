<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-12 10:48:26
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\end-transit-odometer.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66692fa28ec2d6_91595805',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '9e4c3d2326690136c167c5a1ecb35e0ef8e5f5c9' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\end-transit-odometer.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66692fa28ec2d6_91595805 (Smarty_Internal_Template $_smarty_tpl) {
?><form onsubmit="return false;">
    <div class="row">
        <div class="col-md-6 text-center">
            <img src="assets/img/start-trip.png" width="80%">
        </div>
        <div class="col-md-6 text-right">
            <h4 class="bold">Arrival Time</h4>
            <h4><?php echo date('d M Y g:i A');?>
</h4>
            <div class="clearfix"></div>
            <h5 class="bold">Last odometer Reading</h5>
            <h4><span id="end-transit-last-odometer" data-odometer="<?php echo $_smarty_tpl->tpl_vars['vehicle']->value->lastOdometer+0;?>
"><?php echo $_smarty_tpl->tpl_vars['vehicle']->value->lastOdometer;?>
</span> Km</h4>
        </div>
        <div class="col-md-12">
            <label class="req h5">Enter odometer reading to End Trip</label>
            <div class="row">
                <div class="col-md-4">
                    <input type="number" id="end-transit-odo" class="form-control no-spin" placeholder="Odometer">
                </div>
                <div class="col-md-4 p_l_n">
                    <div class="input-group col-md-12">
                        <select id="end-transit-supervisor" class="form-control">
                            <option value="" selected>Select Supervisor</option>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchContact']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->category->code == 'SPVSR') {?>
                                    <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                <?php }?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </select>
                    </div>
                </div>
                <input type="hidden" id="end-transit-transitcode" value="<?php echo $_smarty_tpl->tpl_vars['transit_code']->value;?>
">
                <input type="hidden" id="end-transit-organization" value="<?php echo $_smarty_tpl->tpl_vars['login_branch']->value;?>
">
                <input type="hidden" id="end-transit-user" value="<?php echo $_smarty_tpl->tpl_vars['usr_login_id']->value;?>
">
                <input type="hidden" id="end-transit-vehicle" value="<?php echo $_smarty_tpl->tpl_vars['vehicle_code']->value;?>
">
                <button type="submit" class="btn btn-warning col-md-3" id="end-transit-btn" onclick="endTransitTrip();"><?php if ($_smarty_tpl->tpl_vars['transit_to_organization']->value == $_smarty_tpl->tpl_vars['login_branch']->value) {?>End<?php } else { ?>Arrival<?php }?> Trip</button>
            </div>
        </div>
        <div class="col-md-12"><br>
            <div id="end-transit-action-state"></div>
        </div>
    </div>
</form><?php }
}
