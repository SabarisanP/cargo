<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 15:40:40
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\start-transit-odometer.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6655ada042aa80_57452677',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '9b86e7bcc25c6fcb6268ea0ab55782b4d491ef24' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\start-transit-odometer.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6655ada042aa80_57452677 (Smarty_Internal_Template $_smarty_tpl) {
?><form onsubmit="return false;">
    <div class="row">
        <div class="col-md-4 text-center">
            <img src="assets/img/start-trip.png" width="40%">
        </div>
        <div class="col-md-4 text-center">
            <h4 class="bold">Departure Time</h4>
            <h5><?php echo date('d M Y g:i A');?>
</h4>
        </div>
        <div class="col-md-4 text-center">
            <h5 class="bold">Last odometer Reading</h5>
            <h5><span id="start-transit-last-odometer" data-odometer="<?php echo $_smarty_tpl->tpl_vars['vehicle']->value->lastOdometer+0;?>
"><?php echo $_smarty_tpl->tpl_vars['vehicle']->value->lastOdometer;?>
</span> Km</h5>
        </div>
        <div class="clearfix"></div>

        <div class="col-md-12">
            <label class="h5">Fill The Following Details To Start Trip</label>
            <h6 class="bold">Odometer</h6>
            <div class="row">
                <div class="col-md-4">
                    <label class="control-label req" for="">Odometer</label>
                    <input type="number" id="start-transit-odo" class="form-control no-spin" placeholder="Odometer">
                </div>
                <div class="col-md-4 p_l_n">
                    <div class="input-group col-md-12">
                        <label class="control-label" for="">Supervisor</label>
                        <select id="start-transit-supervisor" class="form-control">
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
            </div>

            <div id="start-transit-expense" <?php if (isset($_smarty_tpl->tpl_vars['odoDetails']->value) && $_smarty_tpl->tpl_vars['odoDetails']->value->startOdometer != 0) {?>class="hide"<?php }?>>
                <h6 class="bold">Payments</h6>
                <div class="row">
                    <?php if (($_smarty_tpl->tpl_vars['namespace']->value == 'seenutransport' && $_smarty_tpl->tpl_vars['vehicle']->value->ownershipType->code == 'HIRE') || $_smarty_tpl->tpl_vars['namespace']->value != 'seenutransport') {?>
                        <div class="col-md-4">
                            <label class="control-label" for="">Hiring Amount</label>
                            <input type="number" class="form-control" id="start-transit-hire-amount" placeholder="Hiring Amount" step="any">
                        </div>
                        <div class="clearfix"></div><br>
                    <?php }?>
                    <div class="col-md-4">
                        <label class="control-label" for="">Advance Amount</label>
                        <input type="number" id="start-transit-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                    </div>
                    <div class="col-md-4">
                        <div class="input-group col-md-12">
                            <label class="control-label" for="">Payment Mode</label>
                            <select id="start-transit-adv-paymode" class="form-control">
                                <option value="" selected>Payment Mode</option>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['f_t_mode']->value, 'name', false, 'k', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['name']->value) {
?>
                                    <option value="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['name']->value;?>
</option>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 p_l_n">
                        <label class="control-label" for="">Payment By</label>
                        <select id="start-transit-adv-payby" class="form-control">
                            <option value="" selected>Payment By</option>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['contact']->value, 'con', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['con']->value) {
?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['con']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                                    <?php if ($_smarty_tpl->tpl_vars['val']->value->contactCategory->actionCode == 'BRCH') {?>
                                        <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
</option>
                                    <?php }?>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </select>
                    </div>
                </div>

                <h6 class="bold">Fuel Expense</h6>
                <div class="row">
                    <div class="col-md-3">
                        <label class="control-label" for="">Fuel Litres</label>
                        <input type="number" id="start-transit-fuel-litres" class="form-control no-spin" placeholder="Fuel Litres">
                    </div>
                    <div class="col-md-3">
                        <label class="control-label" for="">Fuel Rate / Liter</label>
                        <input type="number" class="form-control" id="start-transit-fuel-rate" placeholder="Fuel Rate / Liter" step="any">
                    </div>
                    <div class="col-md-3 p_l_n">
                        <div class="input-group col-md-12">
                            <label class="control-label" for="">Vendor</label>
                            <select id="start-transit-fuel-vendor" class="form-control">
                                <option value="" selected>Select Vendor</option>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vendors']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                    <?php if ($_smarty_tpl->tpl_vars['row']->value->contactCategory->actionCode == 'RAC') {?>
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
                    <div class="col-md-3">
                        <label class="control-label" for="">Fuel Coupon</label>
                        <input type="text" class="form-control" id="start-transit-fuel-coupon" placeholder="Fuel Coupon">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 text-center"><br>
            <div id="start-transit-action-state"></div>
            <input type="hidden" id="start-transit-transitcode" value="<?php echo $_smarty_tpl->tpl_vars['transit_code']->value;?>
">
            <input type="hidden" id="start-transit-organization" value="<?php echo $_smarty_tpl->tpl_vars['login_branch']->value;?>
">
            <input type="hidden" id="start-transit-user" value="<?php echo $_smarty_tpl->tpl_vars['usr_login_id']->value;?>
">
            <input type="hidden" id="start-transit-vehicle" value="<?php echo $_smarty_tpl->tpl_vars['vehicle_code']->value;?>
">
            <input type="hidden" id="namespace_code" value="<?php echo $_smarty_tpl->tpl_vars['namespace']->value;?>
">
            <input type="hidden" id="emptyload_vehicle_owntype" value="<?php echo $_smarty_tpl->tpl_vars['vehicle']->value->ownershipType->code;?>
">
            <button type="submit" class="btn btn-warning col-md-3" id="start-transit-btn" onclick="startTransitTrip();" style="float: none;">Start Trip</button>
        </div>
    </div>
</form>

<?php echo '<script'; ?>
>
    var startTransitOdoDetails = <?php echo json_encode($_smarty_tpl->tpl_vars['odoDetails']->value);?>
;

    $('#start-transit-supervisor').select2();
    $('#start-transit-fuel-vendor').select2();
    $('#start-transit-adv-payby').select2();
<?php echo '</script'; ?>
><?php }
}
