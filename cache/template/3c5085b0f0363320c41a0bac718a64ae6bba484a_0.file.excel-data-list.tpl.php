<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 12:58:13
  from 'E:\xampp\htdocs\cargo\application\views\site\import\excel-data-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665d708d3ab923_23948501',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3c5085b0f0363320c41a0bac718a64ae6bba484a' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\import\\excel-data-list.tpl',
      1 => 1717399360,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665d708d3ab923_23948501 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="row d-flex align-items-center mb-10">
    <div class="col-md-3">
        <span><?php echo count($_smarty_tpl->tpl_vars['lrs']->value);?>
 LR(s) Found.</span>
    </div>
    <div class="col-md-9">
        <button onclick="importLrs();" class="btn btn-success pull-right">Import</button>
        <div class="alert pull-right mb-0" id="import-lr-action-state" style="margin-right: 5px;"></div>
    </div>
</div>
<table class="table table-bordered" width="98%" id="excel-lr-table">
    <thead>
        <tr class="success">
            <th>
                <?php if (count($_smarty_tpl->tpl_vars['lrs']->value)) {?>
                    <input type="checkbox" class="checkall-excel-lr">
                <?php }?>
            </th>
            <th align="left">LR No</th>
            <th align="left">LR Status</th>
            <th align="left">Booked Date</th>
            <th align="left">Unloaded Date</th>
            <th align="left">From</th>
            <th align="left">To</th>
            <th align="left">Sender</th>
            <th align="left">Receiver</th>
            <th align="right">No Of Article</th>
            <th align="right">Actual Weight</th>
            <th align="right">Amount</th>
            <th align="right">Payment Type</th>
            <th align="right">Invoice Value</th>
            <?php if ($_smarty_tpl->tpl_vars['userHeader']->value[14] !== "Remarks") {?>   
            <th align="right">Door Delivery</th>
            <th align="right">Door Delivery Charges</th>
            <th align="right">Door Pickup</th>
            <th align="right">Door Pickup Charges</th>
            <th align="right">Loading Charges</th>
            <?php }?>
            <th align ="left">Article</th>
            <th align ="left">Remarks</th>
        </tr>
    </thead>
    <tbody class="body_table">
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['lrs']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
            <tr class="lr-code-<?php echo $_smarty_tpl->tpl_vars['row']->value["v_lrno"];?>
">
                <td>
                    <input type="checkbox" value="<?php echo $_smarty_tpl->tpl_vars['row']->value["v_lrno"];?>
" class="excel-lr">
                </td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_lrno"];?>
<br>
                    <a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")' class="generated-lr hide"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a>
                </td>
                <td>
                    <span class="badge badge-secondary lr-status">Yet To Import</span>&nbsp;
                    <i class="fa fa-info-circle lr-status-message hide" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
                </td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_booked_date"];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_unloaded_date"];?>
</td>
                <td>
                    <label>Branch(excel) - <?php echo $_smarty_tpl->tpl_vars['row']->value["v_from_station"];?>
</label>
                    <div>
                        <select class="form-control imported-from-station">
                            <option value="">Select From Branch</option>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value["ed_from_branch"])) {?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value["ed_from_branch"], 'val', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                                    <option selected value="<?php echo $_smarty_tpl->tpl_vars['val']->value['code'];?>
" data-station="<?php echo $_smarty_tpl->tpl_vars['val']->value['station_code'];?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value['name'];?>
</option>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php } else { ?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organization']->value, 'org');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['org']->value) {
?>
                                    <option value="<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
" data-station="<?php echo $_smarty_tpl->tpl_vars['org']->value->station->code;?>
"><?php echo $_smarty_tpl->tpl_vars['org']->value->name;?>
</option>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php }?>
                        </select>
                    </div>
                </td>
                <td>
                    <label>Branch(excel) - <?php echo $_smarty_tpl->tpl_vars['row']->value["v_to_station"];?>
</label>
                    <div>
                        <select class="form-control imported-to-station">
                            <option value="">Select To Branch</option>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value["ed_to_branch"])) {?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value["ed_to_branch"], 'val', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                                    <option selected value="<?php echo $_smarty_tpl->tpl_vars['val']->value['code'];?>
" data-station="<?php echo $_smarty_tpl->tpl_vars['val']->value['station_code'];?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value['name'];?>
</option>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php } else { ?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organization']->value, 'org');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['org']->value) {
?>
                                    <option value="<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
" data-station="<?php echo $_smarty_tpl->tpl_vars['org']->value->station->code;?>
"><?php echo $_smarty_tpl->tpl_vars['org']->value->name;?>
</option>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php }?>
                        </select>
                    </div>
                </td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_sender_name"];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_receiver_name"];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_article_count"];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_actual_weight"];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_total_freight"];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_payment_type"];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_invoice_value"];?>
</td>
                <?php if ($_smarty_tpl->tpl_vars['userHeader']->value[14] !== "Remarks") {?>   
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_door_pickup"];?>
</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_door_pickup_charges"];?>
</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_door_delivery"];?>
</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_door_delivery_charges"];?>
</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_loading_charges"];?>
</td>
                <?php }?>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_articles"];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['row']->value["v_remarks"];?>
</td>
            </tr>
           
        <?php
}
} else {
?>
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
</table>

<?php echo '<script'; ?>
>
    var excelLrs = <?php echo json_encode($_smarty_tpl->tpl_vars['lrs']->value);?>

    $(document).ready(function() {
        $('.imported-from-station, .imported-to-station').select2();
        $('[data-toggle="tooltip"]').tooltip({
            placement: 'top',
            html: true,
            trigger: 'hover'
        });
        if ($('#excel-lr-table .excel-lr').length > 0) {
            var lrCodeArray = [];
            $('#excel-lr-table .excel-lr').each(function() {
                var code = $(this).val();
                if ($.inArray(code, lrCodeArray) == -1) {
                    lrCodeArray.push(code);
                } else {
                    $('.lr-code-'+code).find('.lr-status').addClass('badge-danger').text('Duplicate');
                    $('.lr-code-'+code).find('.lr-status-message').removeClass('hide')
                                                                .attr('title', code +' has duplicate LRs')
                                                                .tooltip('fixTitle');
                    $('.lr-code-'+code).find('select.imported-from-station, select.imported-to-station').prop('disabled', true);
                    $('.lr-code-'+code).find('.excel-lr').addClass('hide');
                }
            });
        }

        $('.checkall-excel-lr').on('change', function () {
            var $ele = $(this);
            $('.excel-lr:enabled').not('.hide')
                .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $ele.is(':checked'))
                .trigger('change');
        });
    });
<?php echo '</script'; ?>
>
<?php }
}
