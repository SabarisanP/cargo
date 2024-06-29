<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-28 11:11:41
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\cargo-settings.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667e4d15906199_53865311',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '281cc0184c11dd14cb6dea3f2252ff30538a5014' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\cargo-settings.tpl',
      1 => 1719464252,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667e4d15906199_53865311 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<style>
.radius-8{
    border-radius:8px;
}
.example-section{
    border-radius: 8px;
    background-color: rgba(255, 255, 255, 0.92);
    padding:20px;
}
</style>
<div class="brand_top"><h3> Cargo Settings</h3></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12" >
                    <br>
                    <div class="panel panel-default radius-8">
                        <div class="panel-body">
                            <div id="account_setting" class="tab-pane">
                                <form role="form" id="form1" class="form-horizontal p_l_15" onsubmit="return false;">
                                    <div class="well radius-8">
                                     <h5 class="b_b_d"><b>BOOKING</b></h5>
                                        <div class="row">
                                            
                                            <div class="col-md-6">
                                                <h4 class="heading_a">Booking Model</h4>
                                                <div class="btn-group btn-group-days bookingModelTag" data-toggle="buttons">
                                                    <label class="btn btn-success btn-xs chk-btn <?php if (in_array('RGL',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>active<?php }?>" title="Regular Booking">
                                                        <input type="checkbox" <?php if (in_array('RGL',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>checked="checked"<?php }?> name="booking_model_tag" value="RGL">Regular Booking
                                                    </label>
                                                    <label class="btn btn-success btn-xs chk-btn <?php if (in_array('FTL',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>active<?php }?>" title="Full Truck Load">
                                                        <input type="checkbox" <?php if (in_array('FTL',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>checked="checked"<?php }?> name="booking_model_tag" value="FTL">Full Truck Load
                                                    </label>
                                                    <label class="btn btn-success btn-xs chk-btn <?php if (in_array('PTL',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>active<?php }?>" title="Partial Truck Load">
                                                        <input type="checkbox" <?php if (in_array('PTL',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>checked="checked"<?php }?> name="booking_model_tag" value="PTL">Partial Truck Load
                                                    </label>
                                                </div> &emsp;
                                                <div class="btn-group btn-group-days bookingModelTag" data-toggle="buttons">
                                                    <label class="btn btn-success btn-xs chk-btn <?php if (in_array('OUT',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>active<?php }?>" title="Out Station">
                                                        <input type="checkbox" <?php if (in_array('OUT',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>checked="checked"<?php }?> name="booking_model_tag" value="OUT">Out Station
                                                    </label>
                                                    <label class="btn btn-success btn-xs chk-btn <?php if (in_array('LOC',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>active<?php }?>" title="Local">
                                                        <input type="checkbox" <?php if (in_array('LOC',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>checked="checked"<?php }?> name="booking_model_tag" value="LOC">Local
                                                    </label>
                                                </div> 
                                                <?php $_smarty_tpl->_assignInScope('cargo_additional', config_item('cargo_additional'));?>
                                                <div class="btn-group btn-group-days  bookingModelTag" data-toggle="buttons" style="margin-top: 25px;">
                                                    <label class="btn btn-success btn-xs chk-btn <?php if (in_array('EXPDL',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>active<?php }?>" title="Express Delivery">
                                                        <input type="checkbox" <?php if (in_array('EXPDL',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>checked="checked" <?php }?> name="booking_model_tag" value="EXPDL"><?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['EXPDL']['name'];?>

                                                    </label>
                                                    <label class="btn btn-success btn-xs chk-btn <?php if (in_array('HDLWC',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>active<?php }?>" title="Handle With Care">
                                                        <input type="checkbox"<?php if (in_array('HDLWC',$_smarty_tpl->tpl_vars['result']->value->bookingModelTag)) {?>checked="checked"<?php }?> name="booking_model_tag" value="HDLWC"><?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['HDLWC']['name'];?>

                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <h4 class="heading_a">UOM Model</h4>
                                                <select id="cargoUnitModel" class="form-control" multiple>
                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['article_unit']->value, 'name', false, 'code');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['code']->value => $_smarty_tpl->tpl_vars['name']->value) {
?>
                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['code']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['name']->value;?>
</option>
                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                </select>
                                            </div>
                                            <div class="col-sm-2">
                                                <h4 class="heading_a">Edit Booking Date Limit</h4>
                                                <input type="number" id="edit-booking-days-limit" class="form-control no-spin" placeholder="Value" value="<?php echo $_smarty_tpl->tpl_vars['result']->value->bookingDateEditDaysLimit;?>
" min="0" max="30">
                                            </div>
                                            <div class="clearfix"></div><br>

                                            <div class="col-sm-3 pb10">
                                                <h4 class="heading_a">Minimum Fright Amount to Levy GST</h4>
                                                <input type="text" style="width:60px"  value='<?php echo $_smarty_tpl->tpl_vars['result']->value->minServiceTax;?>
' class="he_25 form-control" id="minServiceTax">
                                            </div>

                                            <div class="col-sm-2 pb10">
                                                <h4 class="heading_a">Round off (Net Amount)</h4>
                                                <select class="form-control" id="rndOffreightAmt" style="width:60px">
                                                    <option value="-10" <?php if ($_smarty_tpl->tpl_vars['result']->value->totalFreightRoundOffValue == -10) {?>selected="selected"<?php }?>>-10</option>
                                                    <option value="-5" <?php if ($_smarty_tpl->tpl_vars['result']->value->totalFreightRoundOffValue == -5) {?>selected="selected"<?php }?>>-5</option>
                                                    <option value="-1" <?php if ($_smarty_tpl->tpl_vars['result']->value->totalFreightRoundOffValue == -1) {?>selected="selected"<?php }?>>-1</option>
                                                    <option value="0" <?php if ($_smarty_tpl->tpl_vars['result']->value->totalFreightRoundOffValue == 0) {?>selected="selected"<?php }?>>0</option>
                                                    <option value="1" <?php if ($_smarty_tpl->tpl_vars['result']->value->totalFreightRoundOffValue == 1) {?>selected="selected"<?php }?>>1</option>
                                                    <option value="5" <?php if ($_smarty_tpl->tpl_vars['result']->value->totalFreightRoundOffValue == 5) {?>selected="selected"<?php }?>>5</option>
                                                    <option value="10" <?php if ($_smarty_tpl->tpl_vars['result']->value->totalFreightRoundOffValue == 10) {?>selected="selected"<?php }?>>10</option>
                                                </select>
                                            </div> 

                                            <div class="col-sm-2 pb10">
                                                <h4 class="heading_a">Round off (Delivery)</h4>
                                                <select class="form-control" id="deliveryRoundOffValue" style="width:60px">
                                                    <option value="-10" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryRoundOffValue == -10) {?>selected="selected"<?php }?>>-10</option>
                                                    <option value="-5" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryRoundOffValue == -5) {?>selected="selected"<?php }?>>-5</option>
                                                    <option value="-1" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryRoundOffValue == -1) {?>selected="selected"<?php }?>>-1</option>
                                                    <option value="0" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryRoundOffValue == 0) {?>selected="selected"<?php }?>>0</option>
                                                    <option value="1" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryRoundOffValue == 1) {?>selected="selected"<?php }?>>1</option>
                                                    <option value="5" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryRoundOffValue == 5) {?>selected="selected"<?php }?>>5</option>
                                                    <option value="10" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryRoundOffValue == 10) {?>selected="selected"<?php }?>>10</option>
                                                </select>
                                            </div> 

                                            <div class="col-sm-1 pb10">
                                                <h4 class="heading_a">GST %</h4>
                                                <input type="text" style="width:60px" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->serviceTaxPercentage;?>
' class="he_25 form-control" id="serviceTaxPercentage" >
                                            </div>

                                            <div class="col-sm-1 pb10">
                                                <h4 class="heading_a">POD Charge</h4>
                                                <input type="text" style="width:60px" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->podCharge;?>
' class="he_25 form-control" id="podCharge">
                                            </div>

                                            <div class="col-sm-2 pb10">
                                                <h4 class="heading_a">Minimum  Billable Kg</h4>
                                                <input type="text" style="width:60px" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->billableKg;?>
' class="he_25 form-control" id="billableKg">
                                            </div> 
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h4 class="heading_a">Default Loading Charge</h4>
                                                <div class="form-group col-sm-5">
                                                    <input type="text" id="defaultLoadigCharge" class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['result']->value->defaultLoadigCharge;?>
">
                                                </div>
                                                <div class="form-group col-sm-4">
                                                    <select id="loadingChargePercentageFlag" class="form-control">
                                                        <option value="0" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargePercentageFlag == false) {?>selected="selected"<?php }?>>Flat</option>
                                                        <option value="1" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargePercentageFlag == true) {?>selected="selected"<?php }?>>Percentage</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-sm-5">
                                                    <select id="loadingChargeEditFlag" class="form-control">
                                                        <option value="0" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeEditFlag == false) {?>selected="selected"<?php }?>>Editable</option>
                                                        <option value="1" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeEditFlag == true) {?>selected="selected"<?php }?>>Readonly</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-sm-2 pb10">
                                                <h4 class="heading_a">Round off (Loading Charge)</h4>
                                                <select class="form-control" id="rndOffLoadingCharge" style="width:60px">
                                                    <option value="-10" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeRoundOffValue == -10) {?>selected="selected"<?php }?>>-10</option>
                                                    <option value="-5" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeRoundOffValue == -5) {?>selected="selected"<?php }?>>-5</option>
                                                    <option value="-1" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeRoundOffValue == -1) {?>selected="selected"<?php }?>>-1</option>
                                                    <option value="0" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeRoundOffValue == 0) {?>selected="selected"<?php }?>>0</option>
                                                    <option value="1" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeRoundOffValue == 1) {?>selected="selected"<?php }?>>1</option>
                                                    <option value="5" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeRoundOffValue == 5) {?>selected="selected"<?php }?>>5</option>
                                                    <option value="10" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargeRoundOffValue == 10) {?>selected="selected"<?php }?>>10</option>
                                                </select>
                                            </div>

                                            <div class="col-sm-3">
                                                <h4 class="heading_a">Default Docket Charge</h4>
                                                <div class="form-group col-sm-5">
                                                    <input type="text" id="defaultDocketCharge" class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['result']->value->defaultDocketCharge;?>
">
                                                </div>
                                                <div class="form-group col-sm-4">
                                                    <select id="docketChargePercentageFlag" class="form-control" disabled>
                                                        <option value="0" <?php if ($_smarty_tpl->tpl_vars['result']->value->docketChargePercentageFlag == false) {?>selected="selected"<?php }?>>Flat</option>
                                                        <option value="1" <?php if ($_smarty_tpl->tpl_vars['result']->value->docketChargePercentageFlag == true) {?>selected="selected"<?php }?>>Percentage</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-sm-5">
                                                    <select id="docketChargeEditFlag" class="form-control">
                                                        <option value="0" <?php if ($_smarty_tpl->tpl_vars['result']->value->docketChargeEditFlag == false) {?>selected="selected"<?php }?>>Editable</option>
                                                        <option value="1" <?php if ($_smarty_tpl->tpl_vars['result']->value->docketChargeEditFlag == true) {?>selected="selected"<?php }?>>Readonly</option>
                                                    </select>
                                                </div>
                                            </div> 

                                            <div class="col-sm-2">
                                                <h4 class="heading_a">Min Total Freight Amount</h4>
                                                <input type="number" style="width:80px" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->minFreightAmount;?>
' class="he_25 form-control no-spin" id="minFreightAmount" >
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-5">
                                                <h4 class="heading_a">Default UnLoading Charge</h4>
                                                <div class="p_l_n col-sm-6">
                                                    <select id="unloadingcharge-type" class="form-control">
                                                        <option value="DFT">Default Rate</option>
                                                        <option value="SLC">Same as Loading charges</option>
                                                        <option value="PFA">Percentage of Freight Amount</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-sm-3">
                                                    <input type="number" id="unloadingcharge-value" class="form-control no-spin" placeholder="Value" value="0">
                                                </div>
                                                <div class="form-group col-sm-3">
                                                    <select id="unloadingcharge-editable" class="form-control">
                                                        <option value="1">Editable</option>
                                                        <option value="0">Readonly</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <h4 class="heading_a">GST Model</h4>
                                                <select id="lrGstTaxModel" class="form-control">
                                                    <option value="RCMGST" <?php if ($_smarty_tpl->tpl_vars['result']->value->lrGstTaxModel == "RCMGST") {?>selected="selected"<?php }?>>RCMGST (Both sender and receiver)</option>
                                                    <option value="RCMEOGST" <?php if ($_smarty_tpl->tpl_vars['result']->value->lrGstTaxModel == "RCMEOGST") {?>selected="selected"<?php }?>>RCMGST (Either sender or receiver)</option>
                                                    <option value="RCMPYGST" <?php if ($_smarty_tpl->tpl_vars['result']->value->lrGstTaxModel == "RCMPYGST") {?>selected="selected"<?php }?>>RCMGST (Payment User Based)</option>
                                                    <option value="GST" <?php if ($_smarty_tpl->tpl_vars['result']->value->lrGstTaxModel == "GST") {?>selected="selected"<?php }?>>GST</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-2">
                                                <h4 class="heading_a">GST Compute Type</h4>
                                                <select id="lrGstTaxComputeType" class="form-control">
                                                    <option value="FRT" <?php if ($_smarty_tpl->tpl_vars['result']->value->lrGstTaxComputeType == "FRT") {?>selected="selected"<?php }?>>Freight Amount</option>
                                                    <option value="NET" <?php if ($_smarty_tpl->tpl_vars['result']->value->lrGstTaxComputeType == "NET") {?>selected="selected"<?php }?>>Net Amount</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-2">
                                            <h4 class="heading_a">GST Compute Model</h4>
                                            <select id="gstTaxComputeModel" class="form-control">
                                                <option value="EXGST" <?php if ($_smarty_tpl->tpl_vars['result']->value->gstTaxComputeModel == "EXGST") {?>selected="selected"<?php }?>>Exclusive GST</option>
                                                <option value="INGST" <?php if ($_smarty_tpl->tpl_vars['result']->value->gstTaxComputeModel == "INGST") {?>selected="selected"<?php }?>>Inclusive GST</option>
                                            </select>
                                        </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h4 class="heading_a">Connecting Charge</h4>
                                                <div class="form-group col-sm-7">
                                                    <input type="number" id="connectingChargeValue" class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['result']->value->connectingChargeValue;?>
">
                                                </div>
                                                <div class="form-group col-sm-5">
                                                    <select id="connectingChargeType" class="form-control">
                                                        <option value="NA" <?php if ($_smarty_tpl->tpl_vars['result']->value->connectingChargeType == 'NA') {?>selected="selected"<?php }?>>Not Available</option>
                                                        <option value="FLT" <?php if ($_smarty_tpl->tpl_vars['result']->value->connectingChargeType == 'FLT') {?>selected="selected"<?php }?>>Flat</option>
                                                        <option value="QTY" <?php if ($_smarty_tpl->tpl_vars['result']->value->connectingChargeType == 'QTY') {?>selected="selected"<?php }?>>Quantity</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="showCustomerAddress" <?php if ($_smarty_tpl->tpl_vars['result']->value->showCustomerAddressFlag == 'true') {?>checked<?php }?>> Collect Customer Address
                                                </label>
                                            </div>
                                            
                                            <div class="col-sm-4 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="mandateAddressOnBooking" <?php if ($_smarty_tpl->tpl_vars['result']->value->mandateAddressOnBookingFlag == 'true') {?>checked<?php }?>> Mandate Customer Address, Pickup Charges & Delivery Charges
                                                </label>
                                            </div>

                                            <div class="col-sm-2">
                                                <h4 class="heading_a">Mobile Number Validation <a href="javascript:;" title="Remarks" data-toggle="popover" id="popup_msg" class="has-popover" data-content="Indian No: ^[6-9]\d&#123;9&#125;$ Or ^[06789]\d&#123;9&#125;$ <br>Repeated No: ^(?:(?!0000|1111|2222|3333|4444|5555|6666|7777|8888|9999).)*$ <br>Sequence No: ^(?:(?!12345|23456|34567|45678|56789|98765|87654|76543|654321).)*$"><i class="fa fa-info-circle" aria-hidden="true"></i></a> </h4>
                                                <input type="text" id="mobileNumberValidationRegex" class="form-control" value="<?php echo implode($_smarty_tpl->tpl_vars['result']->value->mobileNumberValidationRegex,',');?>
">
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="organizationBookingControlFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->organizationBookingControlFlag == 'true') {?>checked<?php }?>> Branch Booking Control
                                                </label>
                                            </div>
                                            
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="loadingChargePerQuantity" <?php if ($_smarty_tpl->tpl_vars['result']->value->loadingChargePerQuantity == 'true') {?>checked<?php }?>> Calculate Loading Charge Per Quantity
                                                </label>
                                            </div>
                                            
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="bookingPreviewFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->bookingPreviewFlag == 'true') {?>checked<?php }?>> Show Preview Popup Before Create Booking
                                                </label>
                                            </div>

                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="mandateInvoiceAmountFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->mandateInvoiceAmountFlag == 'true') {?>checked<?php }?>> Mandatory to Collect Invoice Details
                                                </label>
                                            </div>
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="allowNewArticle" <?php if ($_smarty_tpl->tpl_vars['result']->value->allowNewArticle == 'true') {?>checked<?php }?>> Allow New Article
                                                </label>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <?php if (isNotNull($_smarty_tpl->tpl_vars['result']->value->dayOfHour)) {?>
                                                <div class="col-sm-3 form-check-inline pb10">
                                                    <br/>
                                                    <label title="<?php echo $_smarty_tpl->tpl_vars['result']->value->dayOfHour;?>
">
                                                        <?php $_smarty_tpl->_assignInScope('dayofhourmin', ($_smarty_tpl->tpl_vars['result']->value->dayOfHour).(' minutes'));?>
                                                        Day Of Hour - <?php echo smarty_modifier_date_format(strtotime($_smarty_tpl->tpl_vars['dayofhourmin']->value,strtotime('today')),$_smarty_tpl->tpl_vars['ns_time_format']->value);?>

                                                    </label>
                                                </div>
                                            <?php }?>
                                        </div>
                                    </div>
                                                                        <hr>
                                    
                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>ACCOUNTS</b></h5>
                                    <div class="row">
                                                                                <div class="col-sm-2">
                                            <h4 class="heading_a">User Account Model</h4>
                                            <select class="he_25 form-control" name="userAccountModel" id="userAccountModel">
                                                <option value="VCHR" <?php if ($_smarty_tpl->tpl_vars['result']->value->userAccountModel->code == "VCHR") {?>selected="selected"<?php }?>>Voucher</option>
                                                <option value="RCPT" <?php if ($_smarty_tpl->tpl_vars['result']->value->userAccountModel->code == "RCPT") {?>selected="selected"<?php }?>>Individual GC</option>
                                                <option value="DINV" <?php if ($_smarty_tpl->tpl_vars['result']->value->userAccountModel->code == "DINV") {?>selected="selected"<?php }?>>Dedicated Invoice</option>
                                                <option value="BRN" <?php if ($_smarty_tpl->tpl_vars['result']->value->userAccountModel->code == "BRN") {?>selected="selected"<?php }?>>Branch</option>
                                                <option value="TXRT" <?php if ($_smarty_tpl->tpl_vars['result']->value->userAccountModel->code == "TXRT") {?>selected="selected"<?php }?>>Transaction Receipt</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">RAC Account Model</h4>
                                            <select class="he_25 form-control" name="racAccountModel" id="racAccountModel">
                                                <option value="INV" <?php if ($_smarty_tpl->tpl_vars['result']->value->racAccountModel->code == "INV") {?>selected="selected"<?php }?>>Invoice</option>
                                                <option value="GC" <?php if ($_smarty_tpl->tpl_vars['result']->value->racAccountModel->code == "GC") {?>selected="selected"<?php }?>>Individual GC</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Transaction User Based On</h4>
                                            <select class="he_25 form-control" name="transactionUserType" id="transactionUserType">
                                                <option value="1" <?php if ($_smarty_tpl->tpl_vars['result']->value->transactionUserType == "1") {?>selected="selected"<?php }?>>Delivery Branch Primary User</option>
                                                <option value="2" <?php if ($_smarty_tpl->tpl_vars['result']->value->transactionUserType == "2") {?>selected="selected"<?php }?>>Session User</option>                                                
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Paid Booking User Model</h4>
                                            <select class="he_25 form-control" name="paidBookingUserModel" id="paidBookingUserModel">
                                                <option value="BKUSR" <?php if ($_smarty_tpl->tpl_vars['result']->value->paidBookingUserModel->code == "BKUSR") {?>selected="selected"<?php }?>>Booked User</option>
                                                <option value="DLUSR" <?php if ($_smarty_tpl->tpl_vars['result']->value->paidBookingUserModel->code == "DLUSR") {?>selected="selected"<?php }?>>Delivery User</option>                                                
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-3 w-auto form-check-inline">
                                            <br/>
                                            <label>
                                                <input type="checkbox"  class="he_25 form-check-input" id="paymentReceiptAcknowledgeProcess" <?php if ($_smarty_tpl->tpl_vars['result']->value->paymentReceiptAcknowledgeProcess == 1) {?>checked<?php }?>> Enable Payment Receipt Acknowledge Flow
                                            </label>
                                        </div>

                                        <div class="col-sm-3 w-auto form-check-inline">
                                            <br/>
                                            <label>
                                                <input type="checkbox"  class="he_25 form-check-input" id="creditLimitValidateFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->creditLimitValidateFlag == 'true') {?>checked<?php }?>> Credit Limit Validation On Booking
                                            </label>
                                        </div>

                                        <div class="col-sm-3 w-auto form-check-inline">
                                            <br/>
                                            <label>
                                                <input type="checkbox"  class="he_25 form-check-input" id="captureStateWiseCommissionFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->captureStateWiseCommissionFlag == 'true') {?>checked<?php }?>> Capture State Wise Commission
                                            </label>
                                        </div>

                                        <div class="col-sm-3 w-auto form-check-inline">
                                            <br/>
                                            <label>
                                                <input type="checkbox"  class="he_25 form-check-input" id="stateWiseEwayBillIntegrationFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->stateWiseEwayBillIntegrationFlag == 'true') {?>checked<?php }?>> State Wise Eway Bill Integration
                                            </label>
                                        </div>
                                        
                                            <div class="col-sm-3 w-auto form-check-inline">
                                                <br/>
                                                <label class="d-inline">Ledger -</label> <span class="d-inline"><?php if ($_smarty_tpl->tpl_vars['result']->value->allowLedger) {?>Enabled<?php } else { ?>disabled <?php }?></span>
                                            </div>
                                        
                                        
                                    </div>
                                    <br/>
                                    <div class="row">                                    
                                        <div class="col-sm-12">
                                            <table id="account-model-setup-table" class="table table-hover" width="100%">
                                                <thead>
                                                    <tr>
                                                        <td style="display: flex;justify-content: space-between;align-items: end;">
                                                            <span class="heading_a">Accounts Setup</span>
                                                            <a href="javascript:;" class="btn btn-sm btn-primary pull-right" onclick="addAccountModel()"> <i class="fa fa-plus"></i> Add Other Account Models</a>
                                                        </td>
                                                    </tr>
                                                </thead>
                                                <tbody id="account-model-rows">
                                                    <?php if (count($_smarty_tpl->tpl_vars['paymentModel']->value) == 0) {?>
                                                        <tr class="account-model-row">
                                                            <td>
                                                                <table class="account-model-list" width="100%">
                                                                    <tr class="account-model-edit">
                                                                        <td colspan="4">
                                                                            <div class="row">
                                                                                <div class="col-sm-3">
                                                                                                                                                                            <label for="account-model-group" class="req">Group</label>
                                                                                        <select class="form-control account-model-group" >
                                                                                            <option value='NA'>Default</option>
                                                                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
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
                                                                                <div class="col-sm-9">
                                                                                    <label>&nbsp;</label>
                                                                                    <a href="javascript:;" class="btn btn-sm btn-danger pull-right" onclick="removeAccountModel(this)"> <i class="fa fa-times"></i> Remove</a>
                                                                                </div>
                                                                            </div>
                                                                            <br>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="account-model-edit">
                                                                        <!-- ON BOOKING -->
                                                                        <td width="25%">
                                                                            <table class="table table-bordered">
                                                                                <thead class="bold">
                                                                                    <tr>
                                                                                        <td>Events</td>
                                                                                        <td colspan="3" align="center">On Booking</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Booking Type</td>
                                                                                        <td>Branch / Vendor Due</td>
                                                                                        <td>Booking Commission</td>
                                                                                        <td>Delivery Commission</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>Paid</td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>ToPay</td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td nowrap>On Account</td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>

                                                                        <!-- ON LOAD TABLE -->
                                                                        <td width="25%">
                                                                            <table class="table table-bordered">
                                                                                <thead class="bold">
                                                                                    <tr>
                                                                                        <td colspan="3" align="center">On Load</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Branch / Vendor Due</td>
                                                                                        <td>Booking Commission</td>
                                                                                        <td>Delivery Commission</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                                <tfoot></tfoot>
                                                                            </table>
                                                                        </td>

                                                                        <!-- ON UN LOAD TABLE -->
                                                                        <td width="25%">
                                                                            <table class="table table-bordered">
                                                                                <thead class="bold">
                                                                                    <tr>
                                                                                        <td colspan="3" align="center">On Unloading</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Branch / Vendor Due</td>
                                                                                        <td>Booking Commission</td>
                                                                                        <td>Delivery Commission</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                                <tfoot></tfoot>
                                                                            </table>
                                                                        </td>

                                                                        <!-- ON DELIVEY TABLE -->
                                                                        <td width="25%">
                                                                            <table class="table table-bordered">
                                                                                <thead class="bold">
                                                                                    <tr>
                                                                                        <td colspan="3" align="center">On Delivery</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Branch / Vendor Due</td>
                                                                                        <td>Booking Commission</td>
                                                                                        <td>Delivery Commission</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" ame="pd_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                                <tfoot></tfoot>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    <?php }?>

                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['paymentModel']->value, 'payment_model', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['payment_model']->value) {
?>
                                                        <tr class="account-model-row">
                                                            <td>
                                                                <table class="account-model-list" width="100%">
                                                                    <tbody>
                                                                        <?php if ($_smarty_tpl->tpl_vars['payment_model']->value->paidModel == '') {?>
                                                                            <?php $_smarty_tpl->_assignInScope('paid', '000000000000');?>
                                                                        <?php } else { ?>
                                                                            <?php $_smarty_tpl->_assignInScope('paid', $_smarty_tpl->tpl_vars['payment_model']->value->paidModel);?>
                                                                        <?php }?>
                                                                        <?php if ($_smarty_tpl->tpl_vars['payment_model']->value->toPayModel == '') {?>
                                                                            <?php $_smarty_tpl->_assignInScope('topay', '000000000000');?>
                                                                        <?php } else { ?>
                                                                            <?php $_smarty_tpl->_assignInScope('topay', $_smarty_tpl->tpl_vars['payment_model']->value->toPayModel);?>
                                                                        <?php }?>
                                                                        <?php if ($_smarty_tpl->tpl_vars['payment_model']->value->onAccountModel == '') {?>
                                                                            <?php $_smarty_tpl->_assignInScope('onaccount', '000000000000');?>
                                                                        <?php } else { ?>
                                                                            <?php $_smarty_tpl->_assignInScope('onaccount', $_smarty_tpl->tpl_vars['payment_model']->value->onAccountModel);?>
                                                                        <?php }?>
                                                                        <!-- View -->
                                                                        <tr class="account-model-view account-model-view-list point_cur" onclick="viewAccountModel(this);">
                                                                            <td colspan="3" class="bold">
                                                                                <?php if (isNotNull($_smarty_tpl->tpl_vars['payment_model']->value->group->code)) {?>
                                                                                    <?php echo $_smarty_tpl->tpl_vars['payment_model']->value->group->name;?>

                                                                                <?php } else { ?>
                                                                                    Default
                                                                                <?php }?>
                                                                            </td>
                                                                            <td>
                                                                                <?php if ($_smarty_tpl->tpl_vars['payment_model']->value->group->code != 'NA') {?>
                                                                                    <a href="javascript:;" class="btn btn-sm btn-danger pull-right" onclick="deleteAccountModel('<?php echo $_smarty_tpl->tpl_vars['payment_model']->value->group->code;?>
')"> <i class="fa fa-times"></i> Delete</a>
                                                                                <?php }?>
                                                                                <a href="javascript:;" class="btn btn-sm btn-light pull-right" onclick="editAccountModel(this)"> <i class="fa fa-pencil"></i> Edit</a>
                                                                                <br><br>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="account-model-view hide">
                                                                            <!-- ON BOOKING -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td>Events</td>
                                                                                            <td colspan="3" align="center">On Booking</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Booking Type</td>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>Paid</td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,0,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,1,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,2,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>ToPay</td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,0,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,1,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,2,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td nowrap>On Account</td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,0,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,1,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,2,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON LOAD TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Load</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,3,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,4,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,5,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,3,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,4,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,5,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,3,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,4,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,5,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON UN LOAD TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Unloading</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,6,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,7,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,8,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,6,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,7,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,8,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,6,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,7,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,8,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON DELIVEY TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Delivery</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,9,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,10,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,11,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,9,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,10,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,11,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,9,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,10,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,11,1) == 1) {?><span class="badge badge-success">ON</span><?php } else { ?><span class="badge badge-danger">OFF</span><?php }?>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>
                                                                        </tr>

                                                                        <!-- Edit -->
                                                                        <tr class="account-model-edit hide">
                                                                            <td colspan="4">
                                                                                <div class="row">
                                                                                    <div class="col-sm-3">
                                                                                                                                                                                    <label for="account-model-group" class="req">Group</label>
                                                                                            <select class="form-control account-model-group"  id="account-model-group-id" data-group="<?php echo $_smarty_tpl->tpl_vars['payment_model']->value->group->code;?>
">
                                                                                                <option value='NA'>Default</option>
                                                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" <?php if ($_smarty_tpl->tpl_vars['payment_model']->value->group->code == $_smarty_tpl->tpl_vars['row']->value->code) {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                                            </select>
                                                                                                                                                                            </div>
                                                                                    <div class="col-sm-9">
                                                                                        <label>&nbsp;</label>
                                                                                        <a href="javascript:;" class="btn btn-sm btn-light pull-right" onclick="closeEditAccountModel(this)"> <i class="fa fa-times"></i> Close</a>
                                                                                    </div>
                                                                                </div>
                                                                                <br>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="account-model-edit hide">
                                                                            <!-- ON BOOKING -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td>Events</td>
                                                                                            <td colspan="3" align="center">On Booking</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Booking Type</td>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>Paid</td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,0,1) == 1) {?>checked="checked"<?php }?> name="pd_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,1,1) == 1) {?>checked="checked"<?php }?> name="pd_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,2,1) == 1) {?>checked="checked"<?php }?>  name="pd_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>ToPay</td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,0,1) == 1) {?>checked="checked"<?php }?> name="tp_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,1,1) == 1) {?>checked="checked"<?php }?> name="tp_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,2,1) == 1) {?>checked="checked"<?php }?>  name="tp_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td nowrap>On Account</td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,0,1) == 1) {?>checked="checked"<?php }?> name="oa_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,1,1) == 1) {?>checked="checked"<?php }?> name="oa_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,2,1) == 1) {?>checked="checked"<?php }?>  name="oa_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                    <tfoot></tfoot>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON LOAD TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Load</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,3,1) == 1) {?>checked="checked"<?php }?> name="pd_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,4,1) == 1) {?>checked="checked"<?php }?> name="pd_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,5,1) == 1) {?>checked="checked"<?php }?>  name="pd_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,3,1) == 1) {?>checked="checked"<?php }?> name="tp_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,4,1) == 1) {?>checked="checked"<?php }?> name="tp_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,5,1) == 1) {?>checked="checked"<?php }?>  name="tp_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,3,1) == 1) {?>checked="checked"<?php }?> name="oa_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,4,1) == 1) {?>checked="checked"<?php }?> name="oa_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,5,1) == 1) {?>checked="checked"<?php }?>  name="oa_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                    <tfoot></tfoot>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON UN LOAD TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Unloading</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,6,1) == 1) {?>checked="checked"<?php }?> name="pd_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,7,1) == 1) {?>checked="checked"<?php }?> name="pd_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,8,1) == 1) {?>checked="checked"<?php }?>  name="pd_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,6,1) == 1) {?>checked="checked"<?php }?> name="tp_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,7,1) == 1) {?>checked="checked"<?php }?> name="tp_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,8,1) == 1) {?>checked="checked"<?php }?>  name="tp_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,6,1) == 1) {?>checked="checked"<?php }?> name="oa_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,7,1) == 1) {?>checked="checked"<?php }?> name="oa_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,8,1) == 1) {?>checked="checked"<?php }?>  name="oa_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                    <tfoot></tfoot>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON DELIVEY TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Delivery</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,9,1) == 1) {?>checked="checked"<?php }?> name="pd_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,10,1) == 1) {?>checked="checked"<?php }?> name="pd_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" <?php if (substr($_smarty_tpl->tpl_vars['paid']->value,11,1) == 1) {?>checked="checked"<?php }?>  name="pd_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,9,1) == 1) {?>checked="checked"<?php }?> name="tp_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,10,1) == 1) {?>checked="checked"<?php }?> name="tp_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" <?php if (substr($_smarty_tpl->tpl_vars['topay']->value,11,1) == 1) {?>checked="checked"<?php }?>  name="tp_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,9,1) == 1) {?>checked="checked"<?php }?> name="oa_branch_vendor_due<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,10,1) == 1) {?>checked="checked"<?php }?> name="oa_book_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" <?php if (substr($_smarty_tpl->tpl_vars['onaccount']->value,11,1) == 1) {?>checked="checked"<?php }?>  name="oa_del_comm<?php echo $_smarty_tpl->tpl_vars['key']->value+1;?>
" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                    <tfoot></tfoot>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td>
                                                            <div class="align-center alert alert-danger" style="display:none" id="account-madel-action-state"></div>
                                                            <a href="javascript:;" class="btn btn-sm btn-success pull-right" id="account-model-save-btn" onclick="saveAccountModel()"> Save</a>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                    </div>
                                    <hr>

                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>DELIVERY</b></h5>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Account Type</h4>
                                            <select class="he_25 form-control" name="userAccountableType" id="userAccountableType">
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['user_accountable_type']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
" <?php if ($_smarty_tpl->tpl_vars['result']->value->userAccountableType->code == $_smarty_tpl->tpl_vars['key']->value) {?>selected="selected"<?php }?>><?php echo $_smarty_tpl->tpl_vars['row']->value;?>
</option>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            </select>
                                        </div>

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Delivery Model</h4>
                                            <select class="he_25 form-control" name="deliveryModel" id="deliveryModel">
                                                <option value="BOOKING" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryModel->code == "BOOKING") {?>selected="selected"<?php }?>>After Booking</option>
                                                <option value="LOAD" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryModel->code == "LOAD") {?>selected="selected"<?php }?>>After Load</option>
                                                <option value="UNLOAD" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryModel->code == "UNLOAD") {?>selected="selected"<?php }?>>After Unload</option>
                                                <option value="AFOFD" <?php if ($_smarty_tpl->tpl_vars['result']->value->deliveryModel->code == "AFOFD") {?>selected="selected"<?php }?>>After Out For Delivery</option>
                                            </select>
                                        </div>
                                            
                                        

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Default Delivery Charges</h4>
                                            <input type="text" style="width:60px" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->defaultDeliveryCharge;?>
' class="he_25 form-control" id="defaultDeliveryCharge">
                                        </div>

                                        <div class="col-sm-12 form-check-inline">
                                            <br/>
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="otpValidateDeliveryFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->otpValidateDeliveryFlag == 1) {?>checked<?php }?>> Mandate OTP while delivery
                                            </label>&emsp;
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="otpOverrideDeliveryFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->otpOverrideDeliveryFlag == 1) {?>checked<?php }?>> Override OTP while delivery
                                            </label>&emsp;
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="podValidateDeliveryFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->podValidateDeliveryFlag == 1) {?>checked<?php }?>> Mandate POD while delivery
                                            </label>
                                        </div>
                                    </div>
                                    </div>
                                    <hr>

                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>TRANSIT</b></h5>
                                    <div class="row">

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Transit Model</h4>
                                            <select class="he_25 form-control" name="ogplModelCode" id="ogplModelCode">
                                                <option value="DFLT" <?php if ($_smarty_tpl->tpl_vars['result']->value->ogplModelCode == "DFLT") {?>selected="selected"<?php }?>>Default</option>
                                                <option value="VER2" <?php if ($_smarty_tpl->tpl_vars['result']->value->ogplModelCode == "VER2") {?>selected="selected"<?php }?>>Version 2.0</option>
												<option value="VER3" <?php if ($_smarty_tpl->tpl_vars['result']->value->ogplModelCode == "VER3") {?>selected="selected"<?php }?>>Version 3.0</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Transit Location Mode</h4>
                                            <select class="he_25 form-control" name="transitLocationModelCode" id="transitLocationModelCode">
                                                <option value="STN" <?php if ($_smarty_tpl->tpl_vars['result']->value->transitLocationModelCode == "STN") {?>selected="selected"<?php }?>>Station</option>
                                                <option value="BRCH" <?php if ($_smarty_tpl->tpl_vars['result']->value->transitLocationModelCode == "BRCH") {?>selected="selected"<?php }?>>Branch</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-5">
                                            <h4 class="heading_a">Transit Mode</h4>
                                            <?php if ($_smarty_tpl->tpl_vars['result']->value->transitMode == '') {?>
                                                <?php $_smarty_tpl->_assignInScope('day', '00000');?>
                                            <?php } else { ?>
                                                <?php $_smarty_tpl->_assignInScope('day', $_smarty_tpl->tpl_vars['result']->value->transitMode);?>
                                            <?php }?>
                                            <div class="btn-group btn-group-days transitMode" data-toggle="buttons">
                                                <label class="btn btn-success btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['day']->value,0,1) == 1) {?>active<?php }?>" title="Available Vehicle">
                                                    <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,0,1) == 1) {?>checked="checked"<?php }?> name="transit_mode_tag" value="1">Available Vehicle
                                                </label>
                                                <label class="btn btn-success btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['day']->value,1,1) == 1) {?>active<?php }?>" title="Direct Load">
                                                    <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,1,1) == 1) {?>checked="checked"<?php }?> name="transit_mode_tag" value="1">Direct Load
                                                </label>
                                                <label class="btn btn-success btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['day']->value,2,1) == 1) {?>active<?php }?>" title="Link Load">
                                                    <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,2,1) == 1) {?>checked="checked"<?php }?> name="transit_mode_tag" value="1">Link Load
                                                </label>
                                                <label class="btn btn-success btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['day']->value,3,1) == 1) {?>active<?php }?>" title="Local Load">
                                                    <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,3,1) == 1) {?>checked="checked"<?php }?> name="transit_mode_tag" value="1">Local Load
                                                </label>
                                                <label class="btn btn-success btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['day']->value,4,1) == 1) {?>active<?php }?>" title="Out For Delivery">
                                                    <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,4,1) == 1) {?>checked="checked"<?php }?> name="transit_mode_tag" value="1">Out For Delivery
                                                </label>
                                            </div>
                                        </div>

                                                                                <div class="col-sm-1 form-check-inline"><br>
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="cargoPartitionFlag" <?php if ($_smarty_tpl->tpl_vars['result']->value->cargoPartitionFlag == 1) {?>checked<?php }?>> Split LR
                                            </label>&emsp;
                                        </div>
                                                                            <div class="col-sm-3 form-check-inline"><br>
                                        <label class="d-inline">Transit Odometer Model:</label>&emsp;
                                            <select class="form-control" id="transitOdometerModelCode">
                                            <option value="NA" <?php if ($_smarty_tpl->tpl_vars['result']->value->transitOdometerModelCode === 'NA') {?>selected<?php }?>>Not Available</option>
                                            <option value="RTEBSD" <?php if ($_smarty_tpl->tpl_vars['result']->value->transitOdometerModelCode === 'RTEBSD') {?>selected<?php }?>>Route Based Odometer / Unload</option>
                                            <option value="ORGDTN" <?php if ($_smarty_tpl->tpl_vars['result']->value->transitOdometerModelCode === 'ORGDTN') {?>selected<?php }?>>Origin - Destn. Odometer</option>
                                            </select>
                                      </div>
                                    </div>
                                    </div>
                                    <hr>
                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>DEMURRAGE</b></h5>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <table class="table m-0">
                                                <thead>
                                                    <tr>
                                                        <th>Demurrage Days</th>
                                                        <th>Demurrage Charges</th>
                                                        <th>Demurrage Process</th>
                                                        <th>Calculate Based On</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody id="demurrage-terms-list">
                                                </tbody>
                                            </table>
                                            &ensp;<button class="btn btn-xs btn-primary m-t-5" onclick="addDemurrageTermRow()"><i class="fa fa-plus"></i> Add</button>
                                        </div>
                                        <div class="clearfix"></div><br>
                                    </div>
                                    </div>
                                    <hr>
                                                                        <div class="well radius-8">
                                    <h5 class="b_b_d"><b>SEQUENCE PATTERNS</b></h5>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <details>
                                                <summary class="point_cur" style="display: list-item;"><b>Example</b></summary>
                                                <p>
                                                    
                                                        <div class="example-section">
                                                            {fromOrg}-{toOrg}-{PayType:1|2|3|4}-{DATE1:YYYY-MMM-DD}--{DATE2:WWWW}-{SEQ:fromOrg-toOrg#4}<br/>
                                                            {fromOrg}-{toOrg}-{PayType:P|TP|C|F}-{DATE1:YY}-{SEQ:fromStation-toOrg} --ERROR}<br/>
                                                            {fromOrg}-{PayType:P|TP|C|F}-{SEQ:fromOrg-toOrg#4}}<br/>
                                                            {fromOrg}{SEQ:fromStation#4} ---> ABC0012}<br/>
                                                            REC{SEQ:fromStation-toStation#4}---> REC0012<br/>
                                                            {DATE1:YY}{PayType:P|TP|C|F}{SEQ:fromOrg-toOrg}<br/>
                                                            RAC{PayType:1|2|3|4}-{SEQ:fromStation-toStation}<br/>
                                                            {fromOrg}{toOrg}{SEQ:fromStation-toStation}<br/>
                                                            {fromOrg}-{toOrg}-{PayType:P|TP|C|F}-{DATE1:YY}-{SEQ:fromStation-toStation}<br/>
                                                            {shortCode}{fromOrg}{SEQ:fromOrg#4} ---> ABCMHR0213<br/>
                                                            {shortCode}{SEQ:namespace#4} ---> ABC0213<br/>
                                                            {shortCode}{vendorShortCode}{SEQ:vendor#3}<br/>
                                                            {manualCargoCode}<br/>
                                                            {sessionOrg}{SEQ:organization#3}<br/>
                                                            <br/>
                                                            <b>Cheque :</b><br/>
                                                            {shortCode}{SEQ:namespace#4}<br/>
                                                            {chequeOrg}{SEQ:namespace#3}<br/>
                                                            {chequeStn}{SEQ:namespace#3}<br/>
                                                            <br/>
                                                            <b>Delivery Acknowledgement :</b><br/>
                                                            {fromOrg}{toOrg}{SEQ:fromOrg#3}<br/>
                                                            {fromStation}{toStation}{SEQ:fromStation#4}<br/>
                                                            {shortCode}{SEQ:namespace#4}<br/>
                                                            <br/>
                                                            <b>Vendor Alias :</b><br/>
                                                            {categoryCode}{vendorOrg}{SEQ:namespace#0}<br/>
                                                        </div>
                                                    
                                                </p>
                                            </details>
                                            <br>
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a"><?php echo lang('lr');?>
 Number</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->cargoCodeTemplate;?>
' class="he_25 form-control" id="cargoCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Manual <?php echo lang('lr');?>
 Number</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->manualCargoCodeTemplate;?>
' class="he_25 form-control" id="manualCargoCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Vendor LR Number</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->vendorCargoCodeTemplate;?>
' class="he_25 form-control" id="vendorCargoCodeTemplate">
                                        </div>
                                        
                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Vendor Invoice Number</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->invoiceCodeTemplate;?>
' class="he_25 form-control" id="invoiceCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a"><?php echo lang('ogpl');?>
</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->ogclCodeTemplate;?>
' class="he_25 form-control" id="ogclCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a"><?php echo lang('ogpl_local_transit');?>
</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->itclCodeTemplate;?>
' class="he_25 form-control" id="itclCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">OFDY</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->ofdyCodeTemplate;?>
' class="he_25 form-control" id="ofdyCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Transaction Receipt</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->transactionReceiptTemplate;?>
' class="he_25 form-control" id="transactionReceiptTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Cheque</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->chequeCodeTemplate;?>
' class="he_25 form-control" id="chequeCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Delivery Acknowledgement</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->deliveryAckCodeTemplate;?>
' class="he_25 form-control" id="deliveryAckCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Full Truck Load</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->ftlCodeTemplate;?>
' class="he_25 form-control" id="ftlCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Partial Truck Load</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->ptlCodeTemplate;?>
' class="he_25 form-control" id="ptlCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Vendor Alias</h4>
                                            <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['result']->value->vendorAliasCodeTemplate;?>
' class="he_25 form-control" id="vendorAliasCodeTemplate">
                                        </div>

                                    </div>
                                    </div>
                                    <br><br>
                                    <div class="row radius-8">
                                        <div id="ur-org-loading"></div>
                                        <div class="col-md-6">
                                            <div class="align-center alert alert-danger" style="display:none" id="usr-org-state"></div>
                                        </div>
                                    
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['EDIT-CGO-SETTINGS'] == 1) {?>
                                            <div class="col-md-12 btn-align" style="display:flex;justify-content:flex-end" id="form-org-bttons">
                                                <button type="button" id="btn-save" class="btn btn-success" onclick="saveCargoSettings()">Save</button>
                                            </div>
                                        <?php }?>

                                    </div>
                                    </div>
                                    
                                </form>
                            </div>
                        </div><!--panel Body end-->
                    </div><!--panel end-->
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo '<script'; ?>
 type="text/html" id="demurrage-terms-tpl">
    <tr class="border-0 demurrage-term-row">
        <td width="25%">
            <input type="number" class=" form-control no-spin demurrage-days" placeholder="Days" min="0">
        </td>
        <td width="40%">
            <div class="d-flex">
                <div class="input-group">
                    <span class="input-group-addon "><i class="fa fa-inr"></i></span>
                    <input type="number" class="form-control no-spin demurrage-charge" placeholder="Charges">
                </div>
                <select class="form-control demurrage-chargetype w-auto">
                    <option value="FLT">Flat</option>
                    <option value="PER">Percentage</option>
                    <option value="FLTPD">Flat Per Day</option>
                    <option value="PERPD">Percentage Per Day</option>
                </select>
            </div>
        </td>
        <td>
            <select class="form-control demurrage-process">
                <option value="ARTCL">Article</option>
                <option value="FRGT">Freight</option>
                <option value="NETAM">Net Amount</option>
            </select>
        </td>
        <td>
            <select class="form-control demurrage-date-type">
                <option value="2">Unloaded Date</option>
                <option value="1">Booked Date</option>
                <option value="3">Demurrage Date</option>
            </select>
        </td>
        <td>
            <button class="btn btn-xs" onclick="removeDemurrageTermRow(this)"><i class="fa fa-times"></i></button>
        </td>
    </tr>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 type="text/html" id="add-account-model-tpl">
    <tr class="account-model-row">
        <td>
            <table class="account-model-list" width="100%">
                <tr class="account-model-edit">
                    <td colspan="4">
                        <div class="row">
                            <div class="col-sm-3">
                                                                    <label for="account-model-group" class="req">Group</label>
                                    <select class="form-control account-model-group">
                                        <option value='NA' disabled>Default</option>
                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                    </select>
                                    <br>
                                                            </div>
                            <div class="col-sm-9">
                                <label>&nbsp;</label>
                                <a href="javascript:;" class="btn btn-sm btn-danger pull-right" onclick="removeAccountModel(this)"> <i class="fa fa-times"></i> Remove</a>
                            </div>
                        </div>
                        <br>
                    </td>
                </tr>
                <tr class="account-model-edit">
                    <!-- ON BOOKING -->
                    <td width="25%">
                        <table class="table table-bordered">
                            <thead class="bold">
                                <tr>
                                    <td>Events</td>
                                    <td colspan="3" align="center">On Booking</td>
                                </tr>
                                <tr>
                                    <td>Booking Type</td>
                                    <td>Branch / Vendor Due</td>
                                    <td>Booking Commission</td>
                                    <td>Delivery Commission</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Paid</td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>ToPay</td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap>On Account</td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_del_comm" value="1">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>

                    <!-- ON LOAD TABLE -->
                    <td width="25%">
                        <table class="table table-bordered">
                            <thead class="bold">
                                <tr>
                                    <td colspan="3" align="center">On Load</td>
                                </tr>
                                <tr>
                                    <td>Branch / Vendor Due</td>
                                    <td>Booking Commission</td>
                                    <td>Delivery Commission</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_del_comm" value="1">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>

                    <!-- ON UN LOAD TABLE -->
                    <td width="25%">
                        <table class="table table-bordered">
                            <thead class="bold">
                                <tr>
                                    <td colspan="3" align="center">On Unloading</td>
                                </tr>
                                <tr>
                                    <td>Branch / Vendor Due</td>
                                    <td>Booking Commission</td>
                                    <td>Delivery Commission</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_del_comm" value="1">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>

                    <!-- ON DELIVEY TABLE -->
                    <td width="25%">
                        <table class="table table-bordered">
                            <thead class="bold">
                                <tr>
                                    <td colspan="3" align="center">On Delivery</td>
                                </tr>
                                <tr>
                                    <td>Branch / Vendor Due</td>
                                    <td>Booking Commission</td>
                                    <td>Delivery Commission</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" ame="pd_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_del_comm" value="1">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
>
    var cargoSettingData = <?php echo json_encode($_smarty_tpl->tpl_vars['result']->value);?>
;
    var paymentModelData = <?php echo json_encode($_smarty_tpl->tpl_vars['paymentModel']->value);?>
;
    var paymentModelGroups = <?php echo json_encode($_smarty_tpl->tpl_vars['paymentModelGroups']->value);?>
 || [];

    $(document).ready(function () {
        $('.bsn_switch').bootstrapSwitch('size', 'mini');
        $('.account-model-group').select2();
        $('#cargoUnitModel').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '200px',
            dropLeft: true,
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            includeSelectAllOption: true,
            selectAllText: 'Select All',
            buttonClass: 'btn btn-default cargoUnitModel',
            templates: {
                ul: '<ul class="multiselect-container dropdown-menu" style="max-height: 200px; min-width: 100%; overflow: hidden auto;"></ul>',
            }
        });

        $('#edit-booking-days-limit').on('change', function() {
            let value = parseInt($(this).val());
            let min = parseInt($(this).attr('min'));
            let max = parseInt($(this).attr('max'));
            
            $(this).val(value);
            if (value < min) $(this).val(min);
            if (value > max) $(this).val(max);
        });

        if(menu_permission['EDIT-CGO-SETTINGS'] != 1) {
            $('#account_setting :input').attr('disabled', true);
        }

        $('#unloadingcharge-type').on('change', function () {
            if (this.value == 'SLC') {
                $('#unloadingcharge-value').prop('disabled', true).val('');
                return;
            }
            $('#unloadingcharge-value').prop('disabled', false);
        }).trigger('change');

        if (isNotNull(cargoSettingData) && isNotNull(cargoSettingData.unloadingChargeConfig)) {
            var unloadingChargeConfig = JSON.parse(cargoSettingData.unloadingChargeConfig);

            $.each(unloadingChargeConfig || {}, function (key, val) {
                $('#unloadingcharge-type').val(key);
                $('#unloadingcharge-editable').val(val.editable);
                $('#unloadingcharge-value').val(val.value);

                return false;
            });
        }

        $('#userAccountModel').on('change', function () {
            $('#racAccountModel [value="GC"]').prop('disabled', this.value == 'DINV');
        }).trigger('change');

        
        if (isNotNull(cargoSettingData) && isNotNull(cargoSettingData.demurrageTerms)) {
            $.each(cargoSettingData.demurrageTerms || [], function (i, term) {
                var $row = addDemurrageTermRow();

                $row.find('.demurrage-date-type').val(term.computeDateType);
                $row.find('.demurrage-process').val(term.demurrageProcess.code);
                $row.find('.demurrage-chargetype').val(term.demurrageChargeType);
                $row.find('.demurrage-charge').val(term.demurrageCharge);
                $row.find('.demurrage-days').val(term.demurrageDays);
            });
        }

        if (isNotNull(cargoSettingData) && Array.isArray(cargoSettingData.cargoUnitModel)) {
            $('#cargoUnitModel').val(cargoSettingData.cargoUnitModel).multiselect('refresh');
        }

        if (!$('#demurrage-terms-list .demurrage-term-row').length) {
            addDemurrageTermRow();
        }

		
		$('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');
		$('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'click');
		$('[data-toggle=popover]').popover({
			container: "body",
			html: true
		});

        $('#connectingChargeType').on('change', function () {
            if (this.value == 'NA') {
                $('#connectingChargeValue').prop('disabled', true).val('');
                return;
            }
            $('#connectingChargeValue').prop('disabled', false);
        }).trigger('change');
        // $('#account-model-group').select2();
    });
    
    function saveCargoSettings() {
        var err = 0;
        var data = {};
        data.activeFlag = 1;
        data.serviceTaxPercentage = $('#serviceTaxPercentage').val();
        data.billableKg = $('#billableKg').val();
        data.minServiceTax = $('#minServiceTax').val();
        data.defaultLoadigCharge = $('#defaultLoadigCharge').val();
        data.loadingChargePercentageFlag = $('#loadingChargePercentageFlag').val();
        data.loadingChargeEditFlag = $('#loadingChargeEditFlag').val();
        data.defaultDocketCharge = $('#defaultDocketCharge').val();
        data.docketChargePercentageFlag = $('#docketChargePercentageFlag').val();
        data.docketChargeEditFlag = $('#docketChargeEditFlag').val();
        data.loadingChargePerQuantity = $('#loadingChargePerQuantity').is(':checked');
        data.userAccountableType = $('#userAccountableType').val();
        data.paymentReceiptAcknowledgeProcess = +$('#paymentReceiptAcknowledgeProcess').is(':checked');
        data.showCustomerAddressFlag = $('#showCustomerAddress').is(':checked');
        data.mandateAddressOnBookingFlag = $('#mandateAddressOnBooking').is(':checked');
        data.bookingPreviewFlag = $('#bookingPreviewFlag').is(':checked');
        data.otpValidateDeliveryFlag = $('#otpValidateDeliveryFlag').is(':checked');
        data.otpOverrideDeliveryFlag = $('#otpOverrideDeliveryFlag').is(':checked');
        data.podValidateDeliveryFlag = $('#podValidateDeliveryFlag').is(':checked');
        data.defaultDeliveryCharge = $('#defaultDeliveryCharge').val();
        data.mandateInvoiceAmountFlag = $('#mandateInvoiceAmountFlag').is(':checked');
        data.allowNewArticle = $('#allowNewArticle').is(':checked');
        data.organizationBookingControlFlag = $('#organizationBookingControlFlag').is(':checked');
        data.ogplModelCode = $('#ogplModelCode').val();
        data.transitLocationModelCode = $('#transitLocationModelCode').val();
        // data.mandateRouteWiseUnloadFlag = $('#mandateRouteWiseUnloadFlag').is(':checked');
        data.transitOdometerModelCode = $('#transitOdometerModelCode').val();
        data.cargoPartitionFlag = $('#cargoPartitionFlag').is(':checked');
        data.cargoCodeTemplate = $('#cargoCodeTemplate').val();
        data.vendorCargoCodeTemplate = $('#vendorCargoCodeTemplate').val();
        data.invoiceCodeTemplate = $('#invoiceCodeTemplate').val();
        data.manualCargoCodeTemplate = $('#manualCargoCodeTemplate').val();
        data.ogclCodeTemplate = $('#ogclCodeTemplate').val();
        data.itclCodeTemplate = $('#itclCodeTemplate').val();
        data.ofdyCodeTemplate = $('#ofdyCodeTemplate').val();
        data.transactionReceiptTemplate = $('#transactionReceiptTemplate').val();
        data.chequeCodeTemplate = $('#chequeCodeTemplate').val();
        data.deliveryAckCodeTemplate = $('#deliveryAckCodeTemplate').val();
        data.ftlCodeTemplate = $('#ftlCodeTemplate').val();
        data.ptlCodeTemplate = $('#ptlCodeTemplate').val();
        data.vendorAliasCodeTemplate = $('#vendorAliasCodeTemplate').val();
        data.transactionUserType = $('#transactionUserType').val();
        data.podCharge = $('#podCharge').val();
        data.mobileNumberValidationRegex = $('#mobileNumberValidationRegex').val().split(',');
        data.deliveryModel = {};
        data.deliveryModel.code = $('#deliveryModel').val();
        data.paidBookingUserModel = {};
        data.paidBookingUserModel.code = $('#paidBookingUserModel').val();
        data.creditLimitValidateFlag = $('#creditLimitValidateFlag').is(':checked');
        data.captureStateWiseCommissionFlag = $('#captureStateWiseCommissionFlag').is(':checked');
        data.stateWiseEwayBillIntegrationFlag = $('#stateWiseEwayBillIntegrationFlag').is(':checked');
        data.minFreightAmount = $('#minFreightAmount').val();

        data.bookingDateEditDaysLimit = Number($('#edit-booking-days-limit').val());
        var bookingDateEditMin = Number($('#edit-booking-days-limit').attr('min'));
        var bookingDateEditMax = Number($('#edit-booking-days-limit').attr('max'));
        if (data.bookingDateEditDaysLimit < bookingDateEditMin || data.bookingDateEditDaysLimit > bookingDateEditMax) {
            $('#edit-booking-days-limit').addClass('inp_error');
            $('#usr-org-state').removeClass('alert-success hide').addClass('alert-danger').show();
            $('#usr-org-state').html('Edit Booking Days Limit should be between 0 1nd 10 only');
            return;
        }

        data.demurrageTerms = [];
        $('#demurrage-terms-list .demurrage-term-row').each(function(i, row) {
            var $row = $(row);
        
            var term = {};
            term.demurrageProcess = {};
            term.demurrageProcess.code = $row.find('.demurrage-process').val();
            term.demurrageChargeType = $row.find('.demurrage-chargetype').val();
            term.demurrageCharge = Number($row.find('.demurrage-charge').val()) || 0;
            term.demurrageDays = Number($row.find('.demurrage-days').val()) || 0;
            term.computeDateType = $row.find('.demurrage-date-type').val();

            if (!term.demurrageCharge && !term.demurrageDays) {
                return;
            }

            if (term.demurrageCharge <= 0) {
                $row.find('.demurrage-charge').addClass('inp_error');
                err++;
            } 
            if (term.demurrageDays <= 0) {
                $row.find('.demurrage-days').addClass('inp_error');
                err++;
            }

            if (term.demurrageCharge && term.demurrageDays) {
                data.demurrageTerms.push(term);
            }
        });

        data.totalFreightRoundOffValue = $('#rndOffreightAmt').val();
        data.loadingChargeRoundOffValue = $('#rndOffLoadingCharge').val();
        data.deliveryRoundOffValue = $('#deliveryRoundOffValue').val();

        data.lrGstTaxModel = $('#lrGstTaxModel').val();
        data.lrGstTaxComputeType = $('#lrGstTaxComputeType').val();
        data.gstTaxComputeModel = $('#gstTaxComputeModel').val();

        data.userAccountModel = {};
        data.userAccountModel.code = $.trim($('#userAccountModel').val());
        
        data.racAccountModel = {};
        data.racAccountModel.code = $.trim($('#racAccountModel').val());

        var unloadingChargeType = $.trim($('#unloadingcharge-type').val());
        data.unloadingChargeConfig = {};
        if (isNotNull(unloadingChargeType)) {
            data.unloadingChargeConfig[unloadingChargeType] = {};
            data.unloadingChargeConfig[unloadingChargeType].editable = +$('#unloadingcharge-editable').val();
            
            if (unloadingChargeType != 'SLC') {
                var unloadingChargeValue = +$('#unloadingcharge-value').val();
                data.unloadingChargeConfig[unloadingChargeType].value = unloadingChargeValue;

                if (isNaN(data.unloadingChargeConfig[unloadingChargeType].value) || unloadingChargeValue < 0) {
                    $('#unloadingcharge-value').addClass('inp_error');
                    err++;
                }
            }
        }
        data.unloadingChargeConfig = JSON.stringify(data.unloadingChargeConfig);

        data.connectingChargeType = $('#connectingChargeType').val();
        if (data.connectingChargeType != 'NA') {
            data.connectingChargeValue = $.trim($('#connectingChargeValue').val());
            if (isNull(data.connectingChargeValue) || isNaN(data.connectingChargeValue) || data.connectingChargeValue < 0) {
                $('#connectingChargeValue').addClass('inp_error');
                err++;
            }
        } else {
            data.connectingChargeValue = 0;
        }

        if (data.userAccountModel.code == '') {
            $('#userAccountModel').addClass('inp_error');
            err++;
        }
        if (data.racAccountModel.code == '') {
            $('#racAccountModel').addClass('inp_error');
            err++;
        }

        if (data.userAccountModel.code == 'DINV' && data.racAccountModel.code == 'GC') {
            $('#racAccountModel').addClass('inp_error');
            err++;
        }

        data.bookingModelTag = $('.bookingModelTag :checked').map(function () {
            return $(this).val();
        }).get();

        data.transitMode = $(".transitMode label").map(function () {
        return +($(this).hasClass("active"));
        }).get();

        data.cargoUnitModel = $('#cargoUnitModel').val() || [];

        if (data.cargoUnitModel.length == 0) {
            $('.cargoUnitModel').addClass('inp_error');
            err++;
        }
        
        if (err) {
            $('#usr-org-state').removeClass('alert-success hide').addClass('alert-danger').show();
            $('#usr-org-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }

        $('.inp_error').removeClass('inp_error');
        $('#usr-org-state').removeClass('alert-danger alert-success').html('').hide();
        $('#ur-org-loading').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/update-cargo-settings",
            data: data,
            dataType: "json",
            success: function (response) {
                if (response.status == 1) {
                    $('#ur-org-loading').html('');
                    $('#usr-org-state').show();
                    $('#usr-org-state').removeClass('alert-danger');
                    $('#usr-org-state').addClass('alert-success');
                    $('#usr-org-state').html('Your request has been completed successfully');
                    // $('#form-org-bttons').html('');
                    window.setTimeout(function () {
                        $('#usr-org-state').hide();
                    }, 3000);
                } else {
                    $('#ur-org-loading').html('');
                    $('#usr-org-state').show();
                    $('#usr-org-state').removeClass('alert-success');
                    $('#usr-org-state').addClass('alert-danger');
                    $('#usr-org-state').html(response.errorDesc);
                }
            }
        });

    }

    function addDemurrageTermRow() {
        if ($('#demurrage-terms-list .demurrage-term-row').length >= 3) {
            alert('Allowed only maximum of 3 demurrage terms');
            return;
        }
        var partnersRow = $('#demurrage-terms-tpl').html();
        var $tpl = $(partnersRow);

        return $tpl.appendTo('#demurrage-terms-list');
    }

    function removeDemurrageTermRow(btn) {
        $(btn).closest('.demurrage-term-row').remove();
    }

    var tr_cnt = paymentModelData.length;
    function addAccountModel() {
        tr_cnt += 1
        var $accountModelRow = $('#add-account-model-tpl').html();
        var $tpl = $($accountModelRow);
        $tpl.find('.account-model-group').select2();
        $tpl.find('.bsn_switch').bootstrapSwitch('size', 'mini');

        // Paid
        $tpl.find('[name="pd_branch_vendor_due"]').attr('name', 'pd_branch_vendor_due'+tr_cnt);
        $tpl.find('[name="pd_book_comm"]').attr('name', 'pd_book_comm'+tr_cnt);
        $tpl.find('[name="pd_del_comm"]').attr('name', 'pd_del_comm'+tr_cnt);
        
        // To Pay
        $tpl.find('[name="tp_branch_vendor_due"]').attr('name', 'tp_branch_vendor_due'+tr_cnt);
        $tpl.find('[name="tp_book_comm"]').attr('name', 'tp_book_comm'+tr_cnt);
        $tpl.find('[name="tp_del_comm"]').attr('name', 'tp_del_comm'+tr_cnt);

        // On Account
        $tpl.find('[name="oa_branch_vendor_due"]').attr('name', 'oa_branch_vendor_due'+tr_cnt);
        $tpl.find('[name="oa_book_comm"]').attr('name', 'oa_book_comm'+tr_cnt);
        $tpl.find('[name="oa_del_comm"]').attr('name', 'oa_del_comm'+tr_cnt);

        $('#account-model-setup-table #account-model-rows').append($tpl);
        hideAccountsModelSaveBtn();
    }

    function removeAccountModel(btn) {
        $(btn).closest('tr.account-model-row').remove();
        hideAccountsModelSaveBtn();
    }

    function viewAccountModel(ele) {
        $(ele).closest('.account-model-list').find('.account-model-edit').addClass('hide');
        $(ele).next('.account-model-view').toggleClass('hide');
        hideAccountsModelSaveBtn();
    }

    function closeEditAccountModel(ele) {
        event && event.stopPropagation();
        $(ele).closest('.account-model-list').find('.account-model-view-list').toggleClass('hide');
        $(ele).closest('.account-model-list').find('.account-model-edit').toggleClass('hide');
        hideAccountsModelSaveBtn();
    }

    function editAccountModel(ele) {
        event && event.stopPropagation();
        $(ele).closest('.account-model-list').find('.account-model-view').addClass('hide');
        $(ele).closest('.account-model-list').find('.account-model-edit').toggleClass('hide');
        var group_d = $(ele).closest('.account-model-list').find('#account-model-group-id').val();
        if(group_d == 'NA'){
            $(ele).closest('.account-model-list').find('#account-model-group-id').prop('disabled', true);
        }
        hideAccountsModelSaveBtn();
    }

    function deleteAccountModel(groupCode) {
        event && event.stopPropagation();
        var data = {};
        data.accountModel = [];

        var accountModel = {};
        accountModel.activeFlag = 2;

        accountModel.group = {};
        accountModel.group.code = groupCode;

        data.accountModel.push(accountModel);

        if (isNull(groupCode)) {
            $('#account-madel-action-state').removeClass('alert-success hide').addClass('alert-danger').show();
            $('#account-madel-action-state').html('Please select a valid group');
            window.setTimeout(function () {
                $('#account-madel-action-state').removeClass('alert-danger alert-success').html('').hide();
            }, 3000);
            return false;
        }

        $('#account-madel-action-state').removeClass('alert-danger alert-success').html('').show();
        $('#account-madel-action-state').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/update-account-model",
            data: data,
            dataType: "json",
            success: function (response) {
                if (response.status == 1) {
                    $('#account-madel-action-state').show();
                    $('#account-madel-action-state').removeClass('alert-danger');
                    $('#account-madel-action-state').addClass('alert-success');
                    $('#account-madel-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        $('#account-madel-action-state').hide();
                        checkURL();
                    }, 3000);
                } else {
                    $('#account-madel-action-state').show();
                    $('#account-madel-action-state').removeClass('alert-success');
                    $('#account-madel-action-state').addClass('alert-danger');
                    $('#account-madel-action-state').html(response.errorDesc);
                }
            }
        });
    }

    hideAccountsModelSaveBtn();
    function hideAccountsModelSaveBtn() {
        var show = 0;
        $('#account-model-save-btn').addClass('hide');
        $('#account-model-setup-table .account-model-row').each(function() {
            if ($(this).find('.account-model-edit').hasClass('hide')) {
                return;
            }
            show += 1;
        });
        if (show > 0) {
            $('#account-model-save-btn').removeClass('hide');
        }
    }

    function saveAccountModel() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');
        var data = {};
        data.accountModel = [];
        var group = $.merge([], paymentModelGroups);
        $('#account-model-setup-table .account-model-row').each(function() {
            if ($(this).find('.account-model-edit').hasClass('hide')) {
                return;
            }
            var accountModel = {};
            accountModel.activeFlag = 1;

            var paidModel = $(this).find(".paid").map(function () {
                return +($(this).is(":checked"));
            }).get();

            var toPayModel = $(this).find(".topay").map(function () {
                return +($(this).is(":checked"));
            }).get();

            var onAccountModel = $(this).find(".onaccount").map(function () {
                return +($(this).is(":checked"));
            }).get();

            accountModel.paidModel = paidModel.join('');
            accountModel.toPayModel = toPayModel.join('');
            accountModel.onAccountModel = onAccountModel.join('');

            accountModel.group = {};
            accountModel.group.code = $(this).find('select.account-model-group').val();
            var oldGroup = $(this).find('select.account-model-group').data('group');
            
            if (($.inArray(accountModel.group.code, group) != -1 && isNull(oldGroup) && accountModel.group.code !='NA' || (isNotNull(oldGroup) && oldGroup != accountModel.group.code))) {
                $(this).find('select.account-model-group').addClass('inp_error');
                err++;
            }

            group.push(accountModel.group.code);
            data.accountModel.push(accountModel);
        });

        if (err > 0) {
            $('#account-madel-action-state').removeClass('alert-success hide').addClass('alert-danger').show();
            $('#account-madel-action-state').html('Please select a different group');

            window.setTimeout(function () {
                $('.inp_error').removeClass('inp_error');
                $('#account-madel-action-state').removeClass('alert-danger alert-success').html('').hide();
            }, 3000);
            return false;
        }

        $('#account-madel-action-state').removeClass('alert-danger alert-success').html('').show();
        $('#account-madel-action-state').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/update-account-model",
            data: data,
            dataType: "json",
            success: function (response) {
                if (response.status == 1) {
                    $('#account-madel-action-state').show();
                    $('#account-madel-action-state').removeClass('alert-danger');
                    $('#account-madel-action-state').addClass('alert-success');
                    $('#account-madel-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        $('#account-madel-action-state').hide();
                        checkURL();
                    }, 3000);
                } else {
                    $('#account-madel-action-state').show();
                    $('#account-madel-action-state').removeClass('alert-success');
                    $('#account-madel-action-state').addClass('alert-danger');
                    $('#account-madel-action-state').html(response.errorDesc);
                }
            }
        });
    }
<?php echo '</script'; ?>
><?php }
}
