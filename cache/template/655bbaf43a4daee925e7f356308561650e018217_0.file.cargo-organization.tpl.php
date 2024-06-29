<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-24 11:11:08
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\cargo-organization.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667906f404bb73_08359759',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '655bbaf43a4daee925e7f356308561650e018217' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\cargo-organization.tpl',
      1 => 1717736240,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667906f404bb73_08359759 (Smarty_Internal_Template $_smarty_tpl) {
?><style>
.brancheslist,
 {
	margin: 0;
	padding: 0;
}

.brancheslist li {
	display: inline-block;
	color: #222;
	padding: 0 0;
	letter-spacing: 0px;
}
.fonta-disable{
    color:#64b92a;
    position: relative;
    max-width: 10%;
    
}
.fonta-able{
    color:#db1313;
    position: relative;
    max-width: 10%;
    
}
.empty-space {
    width: 10px; 
    display: inline-block;
}
.able-disable h5{
   margin-bottom:35px;
}

</style>
<div class="brand_top">
    <h3>Cargo Branch</h3> 
</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <div class="row">
                                            <div class="col-lg-3 form-group">
                                                <label>Branch</label>
                                                <select id="branch-filter" class="form-control">
                                                    <option value="All">All Branch</option>
                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                </select>
                                            </div>
                                            <div class="col-lg-4 form-group">
                                                <label>&nbsp;</label>
                                                <button type="button" class="btn btn-default btn-clear" onclick="showAllBranch();">Clear</button>
                                            </div>
                                            <div class="col-lg-3"></div>
                                            <div class="col-lg-2">
                                                <label>&nbsp;</label>
                                                <h5> Enable <span class="fonta-disable"><i class="fa fa-location-arrow"></i></span>
                                                &nbsp;&nbsp;  Disable <span class="fonta-able"><i class="fa fa-location-arrow"></i></span></h5>
                                            </div>
                                        </div>
                                        <table id="organizations_table" class="table table-bordered">
                                        <thead>
                                            <tr class="success">
                                                <th>Branch Name</th>
                                                <th>Delivery from specific branch?</th> 
                                            </tr>
                                        </thead>
                                        <tbody class="body_table">
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                <?php $_smarty_tpl->_assignInScope('code', $_smarty_tpl->tpl_vars['row']->value->code);?>
                                                <tr id="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
">
                                                    <td style="vertical-align:top;" class="brancheslist" valign="top"><li><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</li></td>
                                                    <td>
                                                        <div class="row">
                                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'drow', false, 'dr');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['dr']->value => $_smarty_tpl->tpl_vars['drow']->value) {
?>
                                                                <?php if ($_smarty_tpl->tpl_vars['drow']->value->code != $_smarty_tpl->tpl_vars['row']->value->code) {?>
                                                                    <div class="col-md-2 brancheslist"> 
                                                                        <li type="text" class="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
-dlvr">
                                                                            <?php if (in_array($_smarty_tpl->tpl_vars['drow']->value->code,$_smarty_tpl->tpl_vars['delivery_branches']->value[$_smarty_tpl->tpl_vars['row']->value->code])) {?>
                                                                                <span class="fonta-disable"><i class="fa fa-location-arrow"></i></span>
                                                                            <?php } else { ?>
                                                                                <span class="fonta-able"> <i class="fa fa-location-arrow"></i></span>
                                                                            <?php }?> 
                                                                            <?php echo $_smarty_tpl->tpl_vars['drow']->value->name;?>

                                                                        </li>
                                                                    </div>
                                                                <?php }?>
                                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                        </div>
                                                    </td>
                                                </tr>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        </tbody>
                                    </table>
                                    
                                    </div>
                                </div>
                                
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>


<?php echo '<script'; ?>
>
$( document ).ready(function() {
    $('#branch-filter').select2();
    
    $('#branch-filter').on('change', function() {
        $('.body_table tr').addClass('hide');
      $('#'+this.value).removeClass("hide");

      if(this.value == "All"){
          showAllBranch();
        }
    });
});

function showAllBranch(){
    $('.body_table tr').removeClass('hide');
}

function toggleDlryBranch(code) {
    var chked = $('#'+code+'-toggle').is(':checked');
    $('input.' + code +'-dlvr').prop('checked', chked);
}
function togglePay(code) {
    var chked = $('#'+code+'-pay-toggle').is(':checked');
    $('input.pay-type-' + code).prop('checked', chked);
}
    
function updateOrganizationFlag(code,flag){  
    var data = {};
    data.code = code;
    if($('#' + code +'-bkg').is(":checked")){
        data.bookingFlag = '1';
    } else {
        data.bookingFlag = '0';
    }
    if($('#' + code +'-dlv').is(":checked")){
        data.deliveryFlag = '1';
    } else {
        data.deliveryFlag = '0';
    }
    data.bookingDeliveryFlag = data.bookingFlag+data.deliveryFlag;
    
    data.deliveryBranchList = [];
    $('input.' + code +'-dlvr:checkbox:checked').each(function () {
        data.deliveryBranchList.push( $(this).val() );
    });
    
    // data.payType = [];
    // $('input.pay-type-' + code +':checkbox:checked').each(function () {
    //     var val = $(this).val();
    //     data.payType.push({ code : val });
    // });
        
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-organization",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                 loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
            } else {
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Sorry!"
                });
            }
            window.setTimeout(function() {
                loading_overlay.hide();
            }, 2000);
        }
    });    
}    
<?php echo '</script'; ?>
>    <?php }
}
