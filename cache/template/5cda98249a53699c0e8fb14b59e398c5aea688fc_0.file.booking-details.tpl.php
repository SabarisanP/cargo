<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-28 12:46:39
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\booking-details.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667e63578190e3_48110367',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '5cda98249a53699c0e8fb14b59e398c5aea688fc' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\booking-details.tpl',
      1 => 1719558737,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:site/cargo/label-printing.tpl' => 1,
    'file:site/cargo/delivery-file-webcam-store-component.tpl' => 1,
    'file:site/cargo/file-store-component.tpl' => 1,
  ),
),false)) {
function content_667e63578190e3_48110367 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="popup_top sticky-row-top">
    <div class="row">
    <?php $_smarty_tpl->_assignInScope('addition', array());?>
    <?php $_smarty_tpl->_assignInScope('additiondatas', array());?>
    <?php $_smarty_tpl->_assignInScope('is_expdl', 0);?>
    <?php $_smarty_tpl->_assignInScope('is_hdlwc', 0);?>
    <?php $_smarty_tpl->_assignInScope('expd_code', 'NA');?>
    <?php $_smarty_tpl->_assignInScope('hdlwc_code', 'NA');?>
        <?php $_smarty_tpl->_assignInScope('allow_partial', $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG != 1 || (!isset($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG) || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG == 0));?>

    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->cargoAddonsDetails, 'item', false, 'key', 'name', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['item']->value) {
?>
        <?php $_smarty_tpl->_assignInScope('addonTypeCode', $_smarty_tpl->tpl_vars['item']->value->addonsType->code);?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['addition']) ? $_smarty_tpl->tpl_vars['addition']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array['code'] = $_smarty_tpl->tpl_vars['item']->value->code;
$_smarty_tpl->_assignInScope('addition', $_tmp_array);?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['addition']) ? $_smarty_tpl->tpl_vars['addition']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array['name'] = $_smarty_tpl->tpl_vars['addonTypeCode']->value;
$_smarty_tpl->_assignInScope('addition', $_tmp_array);?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['addition']) ? $_smarty_tpl->tpl_vars['addition']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array['referenceCode'] = $_smarty_tpl->tpl_vars['item']->value->referenceCode;
$_smarty_tpl->_assignInScope('addition', $_tmp_array);?>
        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['additiondatas']) ? $_smarty_tpl->tpl_vars['additiondatas']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[] = $_smarty_tpl->tpl_vars['addition']->value;
$_smarty_tpl->_assignInScope('additiondatas', $_tmp_array);?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <div class="col-md-10 bold ft_14">
            <div class="row">
            <span style="margin-left:10px;">  Cargo Booking Details   :</span> <span class="badge cargo-round badge-warning font-17"><?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
</span>  
            <?php $_smarty_tpl->_assignInScope('cargo_additional', config_item('cargo_additional'));?>
            <?php $_smarty_tpl->_assignInScope('displayed_logos', array());?>
            
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['additiondatas']->value, 'addon', false, 'key', 'name', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['addon']->value) {
?>
                <?php if ($_smarty_tpl->tpl_vars['addon']->value['name'] == "EXPDL") {?>
                    <?php $_smarty_tpl->_assignInScope('is_expdl', 1);?>
                    <?php $_smarty_tpl->_assignInScope('expd_code', $_smarty_tpl->tpl_vars['addon']->value['code']);?>
                    <span class="indic indic-left cargo-round badge badge font-16 badge-<?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['EXPDL']['color'];?>
" title="Express Delivery"><?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['EXPDL']['name'];?>
</span> 
                <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['addon']->value['name'] == "HDLWC") {?>
                    <?php $_smarty_tpl->_assignInScope('is_hdlwc', 1);?>
                    <?php $_smarty_tpl->_assignInScope('hdlwc_code', $_smarty_tpl->tpl_vars['addon']->value['code']);?>
                    <span class="indic indic-right badge badge cargo-round font-16 badge-<?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['HDLWC']['color'];?>
" title="Handle With Care"><?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['HDLWC']['name'];?>
</span>
                <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['addon']->value['name'] == "EWBL" && !in_array('EWBL',$_smarty_tpl->tpl_vars['displayed_logos']->value)) {?>
                    <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/img/icons/invoice.svg" width="40px" loading="lazy">
                    <?php $_smarty_tpl->_assignInScope('displayed_logos', array_merge($_smarty_tpl->tpl_vars['displayed_logos']->value,array('EWBL')));?>
                <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['addon']->value['referenceCode'] != '' && !in_array('',$_smarty_tpl->tpl_vars['displayed_logos']->value)) {?>
                    <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/img/icons/eway.svg" width="40px" loading="lazy">
                    <?php $_smarty_tpl->_assignInScope('displayed_logos', array_merge($_smarty_tpl->tpl_vars['displayed_logos']->value,array('')));?>
                <?php }?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </div>
        </div>
        <div class="col-md-2"> 
            <a class="align-right" onclick="closeCargoDetailsDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<?php if (!empty($_smarty_tpl->tpl_vars['summary']->value)) {?>
    <div id="load-to-ogpl-panel" class="hide">
    </div>

    <table width="100%" cellpadding="5">
    <tr>
        <td width="59%" valign="top">
            <table width="100%" cellpadding="5" class="table table-bordered ">
                <tbody class="body_table" >
                <tr class="success">
                    <td align="left" width="50%">
                        <span class="bold"> <?php echo lang('booking_from_label');?>
</span> 
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT-BOOKED'] == 1) {?>
                            <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB")) || ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CUL' && $_smarty_tpl->tpl_vars['summary']->value->transitOrganization->code != $_smarty_tpl->tpl_vars['summary']->value->toOrganization->code)) {?>
                                <span class="align-right">                            
                                    <a href="javascript:;" class="btn btn-danger btn-xs" onclick="editSender();"> <i class="fa fa-pencil"></i> </a>
                                </span>
                            <?php }?>
                        <?php } elseif ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT'] == 1) {?>
                            <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB","CL","CUL"))) {?>
                                <span class="align-right">                            
                                    <a href="javascript:;" class="btn btn-danger btn-xs" onclick="editSender();"> <i class="fa fa-pencil"></i> </a>
                                </span>
                            <?php }?>
                        <?php }?>
                    </td>                
                    <td align="left" width="50%">
                        <span class="bold"><?php echo lang('booking_to_label');?>
</span>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT-BOOKED'] == 1) {?>
                            <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB")) || ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CUL' && $_smarty_tpl->tpl_vars['summary']->value->transitOrganization->code != $_smarty_tpl->tpl_vars['summary']->value->toOrganization->code)) {?>
                                <span class="align-right">                            
                                    <a href="javascript:;" class="btn btn-danger btn-xs" onclick="editReceiver();"> <i class="fa fa-pencil"></i> </a>
                                </span> 
                            <?php }?>
                        <?php } elseif ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT'] == 1) {?>
                            <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB","CL","CUL"))) {?>
                                <span class="align-right">                            
                                    <a href="javascript:;" class="btn btn-danger btn-xs" onclick="editReceiver();"> <i class="fa fa-pencil"></i> </a>
                                </span> 
                            <?php }?>
                        <?php }?>
                    </td>       	
                </tr>
                <tr>
                    <td align="left" width="50%">
                        <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name;?>

                        <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>

                    </td>                
                    <td align="left" width="50%" >
                        <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>

                        <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>

                    </td>       	
                </tr>
                <tr>
                    <td align="left" width="50%"  class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
</td>                
                    <td align="left" width="50%"  class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
</td>       	
                </tr>
                <?php if (!$_smarty_tpl->tpl_vars['cargo_setting']->value->custom->skipCustomerMobile) {?>
                    <tr>
                        <td align="left" width="50%"  class=""><?php if ($_REQUEST['onBooked']) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;
} else {
echo mask_mobileno($_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber);
}?></td>                
                        <td align="left" width="50%"  class=""><?php if ($_REQUEST['onBooked']) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;
} else {
echo mask_mobileno($_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber);
}?></td>         	
                    </tr>
                <?php }?>
                <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {?>
                    <tr>
                        <td align="left" width="50%" title="Pickup Address">
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code)) {?>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1;?>
,  <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark;?>
<br/>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode;?>

                            <?php } else { ?>-<?php }?>
                        </td>
                        <td align="left" width="50%" title="Delivery Address">
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {?>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1;?>
,  <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark;?>
<br/>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode;?>

                            <?php } else { ?>-<?php }?>
                        </td>         	
                    </tr>
                <?php }?>
                <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)) {?>
                    <tr>
                        <td align="left" width="50%" ><b>GSTIN :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                        <td align="left" width="50%" ><b>GSTIN :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    </tr>
                <?php }?>
                <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomer->companyName) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomer->companyName)) {?>
                    <tr>
                        <td align="left" width="50%" ><b>Company :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->fromCustomer->companyName)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                        <td align="left" width="50%" ><b>Company :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->toCustomer->companyName)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    </tr>
                <?php }?>
                </tbody>
            </table>
        </td>
        <td width="1%"></td>
        <td width="40%" valign="top">
            <table width="100%" cellpadding="5" class="table table-bordered ">
                <tbody class="body_table" >
                <tr>
                    <td align="left" width="15%"  class="bold">Booked Date</td>
                    <td align="left" width="35%" >
                        <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CB' && !isset($_smarty_tpl->tpl_vars['additional_status_list']->value['BKDT']) && date('Y-m-d',strtotime($_smarty_tpl->tpl_vars['summary']->value->bookedAt)) == date('Y-m-d') && $_smarty_tpl->tpl_vars['action_rights']->value['CGO-EDIT-BOOK-DATE'] == 1) {?>
                            <span class="align-right">
                                <a href="javascript:;" class="btn btn-danger btn-xs" onclick="editBookingDate();"> <i class="fa fa-pencil"></i> </a>
                            </span>
                        <?php }?>
                    </td>
                </tr>
                <tr>
                    <td align="left" width="15%" class="bold">No of Articles</td>
                    <td align="left" width="35%">
                        <?php $_smarty_tpl->_assignInScope('qty', 0);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'item');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['item']->value) {
?>
                            <?php $_smarty_tpl->_assignInScope('qty', $_smarty_tpl->tpl_vars['qty']->value+$_smarty_tpl->tpl_vars['item']->value->itemCount);?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        <?php echo count($_smarty_tpl->tpl_vars['summary']->value->itemDetails);?>
 (Qty - <?php echo $_smarty_tpl->tpl_vars['qty']->value;?>
)
                    </td>       	
                </tr>
                <tr>
                    <td align="left" width="15%" class="bold">Net Amount</td>
                    <td align="left" width="35%">                       
                        Rs <?php echo number_format(($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHDL']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHBL']->value)+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value),2);?>

                    </td>       	
                </tr>
                <tr>
                    <td align="left" width="15%" class="bold">Booked By</td>
                    <td align="left" width="35%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedUser->name;?>
</td>       	
                </tr>  
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveredUser->name != '') {?>
                <tr>
                    <td align="left" width="15%" class="bold">Delivered By</td>
                    <td align="left" width="35%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->deliveredUser->name;?>
</td>       	
                </tr>  
                <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->vendorUser->name != '') {?>
                <tr>
                    <td align="left" width="15%" class="bold">Vendor</td>
                    <td align="left" width="35%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->vendorUser->name;?>

                        <?php if (($_smarty_tpl->tpl_vars['summary']->value->paymentSettlementFlag == 0 && $_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT'] == 1) && ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG != 1 || (!isset($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG) || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG == 0))) {?>
                            <a href="javascript:;" class="btn btn-danger btn-xs" onclick="editVendor();"> <i class="fa fa-pencil"></i> </a>
                        <?php }?>
                    </td>       	
                </tr> 
                <?php }?>
                <tr>
                    <td align="left" width="15%" class="bold">Settlement</td>
                    <td align="left" width="35%"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentSettlementFlag == 0) {?>Not Completed<?php } else { ?>Completed<?php }?></td>       	
                </tr>

                <?php $_smarty_tpl->_assignInScope('bookeddate', explode(" ",$_smarty_tpl->tpl_vars['summary']->value->bookedAt));?>
                <?php $_smarty_tpl->_assignInScope('bookedtime', timeToMinutes($_smarty_tpl->tpl_vars['bookeddate']->value[1]));?>
                <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes) && $_smarty_tpl->tpl_vars['bookedtime']->value > $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes) {?>
                    <?php $_smarty_tpl->_assignInScope('transitCloseMinutes', $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes);?>
                    <?php if ($_smarty_tpl->tpl_vars['transitCloseMinutes']->value < 720) {
$_smarty_tpl->_assignInScope('transitCloseMinutes', $_smarty_tpl->tpl_vars['transitCloseMinutes']->value+720);
}?>
                <tr>
                    <td align="left" width="15%" class="bold">Next Day Booking</td>
                    <td align="left" width="35%"><?php echo addMinutesToDateTime($_smarty_tpl->tpl_vars['transitCloseMinutes']->value,$_smarty_tpl->tpl_vars['summary']->value->bookedAt,'d-m-Y');?>
</td>       	
                </tr>
                <?php }?>
                                <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_LOOKUP_CODE)) {?>
                    <tr>
                        <td align="left" width="15%" class="bold">Related <?php echo lang('lr');?>
</td>
                        <td align="left" width="35%">
                            <a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_LOOKUP_CODE;?>
")'><?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_LOOKUP_CODE;?>
</a>
                        </td>
                    </tr>
                <?php } elseif ((isset($_smarty_tpl->tpl_vars['additional_status_list']->value['CGRTN']) && !isNotNull($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_LOOKUP_CODE))) {?>
                    <tr>
                        <td align="left" width="15%" class="bold">Related <?php echo lang('lr');?>
</td>
                        <td align="left" width="35%">
                            <a href="#cargo/booking?referenceLR=<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
" title="Create Return <?php echo lang('lr');?>
" target="_blank">Create Return <?php echo lang('lr');?>
</a>
                        </td>
                    </tr>  
                <?php }?>
                </tbody>
            </table>  
            
        </td>
    </tr>
    </table>


<div id="lr-panel">
    <table width="100%">
        <tr>
            <td width="60%" valign="top" style="padding-right: 10px;">
                <table width="100%" cellpadding="5" class="table table-bordered ">
                <tr>
                    <td align="left" width="20%" class="bold">Payment Type</td>
                    <td align="left" width="30%">
                    <?php $_smarty_tpl->_assignInScope("summary->paymentType->code", 'INP');?>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php echo lang('INP');?>

                        <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php echo lang('OATP');?>

                        <?php } else { ?>
                            <?php echo $_smarty_tpl->tpl_vars['payment_type_name']->value;?>
    
                        <?php }?>

                        <?php if (!in_array($_smarty_tpl->tpl_vars['summary']->value->paymentType->code,array("FS")) && $_smarty_tpl->tpl_vars['action_rights']->value['CARGO-PAYTYPE-EDIT'] == 1 && !in_array($_smarty_tpl->tpl_vars['summary']->value->cargoType->code,array("PBO"))) {?>
                            <a href="javascript:;" class="btn btn-danger btn-xs pull-right" onclick="showEditPaymentType();"> <i class="fa fa-pencil"></i> </a>
                        <?php }?>
                    </td> 
                    <td align="left" width="20%" class="bold">Cargo Status</td>
                    <td align="left" width="30%" 
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CB") {?> class="active" 
                        <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CL") {?> class="info"
                        <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CUL") {?> class="warning"
                        <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CD") {?> class="success"
                        <?php } else { ?> class="danger"
                        <?php }?>
                    >
                        <?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->name;?>

                        <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['DRDLY'])) {?>
                            &nbsp;<span data-toggle="tooltip" title="<b>Handovered To:</b> <?php echo $_smarty_tpl->tpl_vars['addons_mapped']->value['DRDLY']->name;?>
<br/> <b>Status:</b> <?php echo $_smarty_tpl->tpl_vars['addons_mapped']->value['DRDLY']->value;?>
"><i class="fa fa-info-circle"></i></span>
                        <?php }?>
                    </td> 
                </tr>
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->transitOrganization->code != '') {?>
                    <tr>
                        <td align="left" width="20%" colspan="1" class="bold">Transit Branch</td>
                        <td align="left" width="50%" colspan="4"><?php echo $_smarty_tpl->tpl_vars['summary']->value->transitOrganization->name;?>
</td>
                    </tr>
                <?php }?>
                <?php if (count($_smarty_tpl->tpl_vars['summary']->value->additionalStatus)) {?>
                    <tr>
                        <td align="left" width="20%" class="bold">Additional Status</td>
                        <td align="left" width="80%" colspan="3">
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->additionalStatus, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                <span class="badge badge-warning"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</span>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </td>
                    </tr>
                <?php }?>
                </table>

                <table width="100%" cellpadding="5" class="table table-bordered ">
                    <tr class="success">
                        <td align="center" class="bold">S No</td>
                        <td align="center" class="bold"><?php echo lang('booking_article_label');?>
</td>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                        <td align="center" class="bold"><?php echo lang('booking_UOM_label');?>
 <?php if (lang('booking_UOM_label_info')) {?><i class="fa fa-info-circle" data-toggle="tooltip" data-title="<?php echo lang('booking_UOM_label_info');?>
"></i><?php }?></td>
                        <?php }?>
                        <td align="center" class="bold">Quantity</td>
                        <td align="center" class="bold">Rate</td>
                        <td align="center" class="bold">
                            <span>Freight</span>
                            
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['EDIT-FREIGHT'] == 1 && !in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CD")) && !in_array($_smarty_tpl->tpl_vars['summary']->value->cargoType->code,array("PBO"))) {?>
                                                            <span class="align-right">
                                    <a href="javascript:;" class="btn btn-danger btn-xs" onclick="editItems();"> <i class="fa fa-pencil"></i> </a>
                                </span>
                                                        <?php }?>
                        </td>
                    </tr>
                    <tbody class="body_table" id="items-tbody" >
                        <?php $_smarty_tpl->_assignInScope('subtotal', 0);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
  'index' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index']++;
?>
                            <tr data-itemcode="<?php echo $_smarty_tpl->tpl_vars['article']->value->code;?>
">
                                <td class="sno" align="center"><?php echo (isset($_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index'] : null)+1;?>
</td>
                                <td align="left">
                                    <?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->name;?>

                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['article']->value->cargoItem->description[0])) {?>
                                       <br/><div class="small text-muted text-truncate" style="max-width: 250px;"><?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->description[0];?>
</div>
                                    <?php }?>
                                </td>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                    <td align="center">
                                                                        <?php if ($_smarty_tpl->tpl_vars['article']->value->unitValue) {?>
                                        <?php echo $_smarty_tpl->tpl_vars['article']->value->unitValue;?>
 
                                    <?php }?>
                                    <?php echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code];?>

                                </td>
                                <?php }?>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td>
                                <td align="right">
                                    <?php if (in_array('FR',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                                    <?php echo $_smarty_tpl->tpl_vars['article']->value->fare;?>

                                </td>
                                <td align="right" data-gst="<?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'FRT') {
echo $_smarty_tpl->tpl_vars['article']->value->serviceTax;
} else {
echo $_smarty_tpl->tpl_vars['summary']->value->serviceTax;
}?>">
                                    <?php echo number_format($_smarty_tpl->tpl_vars['article']->value->computed->freight,2);?>

                                </td>
                            </tr>
                            <?php $_smarty_tpl->_assignInScope('subtotal', $_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['article']->value->computed->freight);?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?> 
                        <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'FRT') {?>
                            <tr>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                <td align="right" colspan="5">Sub Total</td>
                                <?php } else { ?>
                                <td align="right" colspan="4">Sub Total</td>
                                <?php }?>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['subtotal']->value,2);?>
</td>
                            </tr>
                        <?php } elseif ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>
                            <tr>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                <td align="right" colspan="5">Freight</td>
                                <?php } else { ?>
                                <td align="right" colspan="4">Freight</td>
                                <?php }?>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['subtotal']->value,2);?>
</td>
                            </tr>
                            <tr>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                <td align="right" colspan="5">Sub Total</td>
                                <?php } else { ?>
                                <td align="right" colspan="4">Sub Total</td>
                                <?php }?>
                                <td align="right"><?php echo number_format(($_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHDL']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHBL']->value)+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value),2);?>
</td>
                            </tr>
                        <?php }?>
                    </tbody>
                </table>
                <?php if (count($_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'])) {?>
                    <table width="100%" cellpadding="5" class="table table-bordered ">
                        <tr class="">
                            <td align="center" class="bold">E-Way Bill Number</td>
                            <td align="center" class="bold">Invoice Number</td>
                            <td align="center" class="bold">Invoice Amount</td>
                            <td align="center" class="bold">Invoice Date</td>
                        </tr>
                        <tbody class="body_table" >
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'], 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                <tr>
                                    <td align="center"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->referenceCode)===null||$tmp==='' ? '-' : $tmp);?>
</td>

                                    <?php $_smarty_tpl->_assignInScope('invoiceDetail', explode("|",$_smarty_tpl->tpl_vars['row']->value->value));?>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['invoiceDetail']->value[1];?>
</td>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['invoiceDetail']->value[0];?>
</td>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['invoiceDetail']->value[2];?>
</td>
                                </tr>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </tbody>
                    </table>
                <?php }?>
                <b>Remarks :</b>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->remarks, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <br/>
                    <div class="row m-t-5">
                        <div class="col-md-12" style="font-size: 13px;"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</div>
                        <div class="text-muted">
                            <div class="col-md-4"><b>By : </b><?php echo $_smarty_tpl->tpl_vars['row']->value->updatedBy->name;?>
 </div>
                            <div class="col-md-4"><b>At : </b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->updatedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</div>
                            <div class="col-md-4"><b>Activity : </b><?php echo $_smarty_tpl->tpl_vars['cargo_remarks_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargoStatusCode];?>
</div>
                        </div>
                    </div>
                <?php
}
} else {
?>
                    -
                <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <br/><br/>
            </td>
            <td width="40%" valign="top">
                <table width="100%" cellpadding="5" class="table table-bordered ">
                    <tr>
                    <td align="left" width="20%" class="bold">Vehicle</td> 
                    <td align="left" width="30%">
                            <?php if (isset($_smarty_tpl->tpl_vars['summary']->value->tripInfo->busVehicle->registationNumber) && $_smarty_tpl->tpl_vars['summary']->value->tripInfo->busVehicle->registationNumber != 'false') {?>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->tripInfo->busVehicle->registationNumber;?>

                            <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->transitVehicle->registationNumber != '' && $_smarty_tpl->tpl_vars['summary']->value->transitVehicle->registationNumber != 'false') {?>
                                <span title="OGPL"><?php echo $_smarty_tpl->tpl_vars['summary']->value->transitVehicle->registationNumber;?>
</span>
                                <span class="pull-right">
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->transitCargoDetails, 'transitCargoDetails', false, NULL, 'tcd', array (
  'last' => true,
  'iteration' => true,
  'total' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['transitCargoDetails']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_tcd']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_tcd']->value['last'] = $_smarty_tpl->tpl_vars['__smarty_foreach_tcd']->value['iteration'] === $_smarty_tpl->tpl_vars['__smarty_foreach_tcd']->value['total'];
?>
                                        <?php if ((isset($_smarty_tpl->tpl_vars['__smarty_foreach_tcd']->value['last']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_tcd']->value['last'] : null)) {?>
                                         <a href="javascript:;" onclick="print_cargo_ogpl_chart('<?php echo $_smarty_tpl->tpl_vars['transitCargoDetails']->value->code;?>
');">view <?php echo lang('ogpl');?>
</a>
                                        <?php }?>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </span>
                            <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->registerNumber != '' && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->registerNumber != 'false') {?>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->registerNumber;?>

                            <?php } else { ?>
                                -
                            <?php }?>
                    </td> 
                    </tr>
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-PVTNO'] == 1 && isNotNull($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->PRIVATE_MARK_NUMBER) && $_smarty_tpl->tpl_vars['namespace']->value == "ktwoklogistics") {?>
                        <tr>
                            <td align="left" width="20%" class="bold">Private Mark No &nbsp;&nbsp;&nbsp;&nbsp;
                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code !== "CD") {?> 
                                    <a title="Private Mark No" onclick="editPrivateMark('<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->PRIVATE_MARK_NUMBER;?>
');"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                                <?php }?>
                            </td>
                            <td align="left" width="30%">
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->PRIVATE_MARK_NUMBER;?>

                            </td> 
                        </tr>
                    <?php }?>
                    
                    
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ADD-PROOF-DOC'] == 1 && isNotNull($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_DOCUMENT_COUNT)) {?>
                        <tr>
                            <td align="left" width="20%" class="bold">Documents Attached</td>
                            <td align="left" width="30%" >
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_DOCUMENT_COUNT;?>


                                <span class="pull-right">
                                    <a href="javascript:;" onclick="proofDocumentGallery('<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
');">View Files</a>
                                </span>
                            </td> 
                        </tr>                        
                    <?php }?>
                </table>
                
                <?php if (count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList) > 0) {?>
                    <table width="100%" cellpadding="5" class="table table-bordered ">
                        <tr>
                            <th width="25%">Paid Amount</th>
                            <th width="25%" title="Transaction Mode">Mode</th>
                            <th width="25%">Collected By</th>
                            <th width="25%">Paid At
                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CD') {?>
                                    <i class="fa fa-print" onclick="printReceiptUsingPreferences()"></i>
                                    <i class="fa fa-list-ul" aria-hidden="true" onclick="showReceiptPrintPreferences()" title="More Prints"></i>
                                <?php }?>
                            </th>
                        </tr>                        
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList, 'cargoTransactionList');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['cargoTransactionList']->value) {
?>
                            <tr>
                                <td align="right" nowrap>
                                    <?php if ($_smarty_tpl->tpl_vars['cargoTransactionList']->value->transactionType->code == "CGCA") {?> - <?php } else { ?> + <?php }?>
                                    <?php echo number_format($_smarty_tpl->tpl_vars['cargoTransactionList']->value->transactionAmount,2);?>

                                </td> 
                                <td align="left" nowrap>
                                    <?php echo $_smarty_tpl->tpl_vars['transaction_mode']->value[$_smarty_tpl->tpl_vars['cargoTransactionList']->value->transactionMode->code];?>

                                    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->userAccountModel->code != 'TXRT' && $_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT'] == 1) {?>
                                        &nbsp;<a href="javascript:;" onclick="showEditPaymentMode('<?php echo $_smarty_tpl->tpl_vars['cargoTransactionList']->value->transactionMode->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['cargoTransactionList']->value->user->code;?>
');"><i class="fa fa-pencil"></i></a>
                                    <?php }?>
                                </td> 
                                <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargoTransactionList']->value->user->name;?>
</td> 
                                <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['cargoTransactionList']->value->transactionDate,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td> 
                            </tr>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </table>
                <?php }?>
                
                <table width="100%" cellpadding="5" class="table table-bordered ">
                    <tr>
                        <td align="right">Freight</td>
                        <td align="right">
                            <?php if (in_array('FR',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                            <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalAmount,2);?>

                        </td>
                    </tr>
                    <tr>
                        <td align="right">L Charges</td>
                        <td align="right">
                            <?php if (in_array('LC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                            <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount,2);?>

                        </td>
                    </tr>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount > 0 || in_array('DP',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
                    <tr>
                        <td align="right">Pickup Charges</td>
                        <td align="right">
                            <?php if (in_array('DP',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                            <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount,2);?>

                        </td>
                    </tr>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount > 0 || in_array('DD',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
                    <tr>
                        <td align="right">Delivery Charges</td>
                        <td align="right">
                            <?php if (in_array('DD',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                            <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount,2);?>

                        </td>
                    </tr>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount > 0) {?>
                    <tr>
                        <td align="right">Unloading Charges</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount,2);?>
</td>
                    </tr>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->serviceCharge > 0 || in_array('OC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
                    <tr>
                        <td align="right">Service Charges</td>
                        <td align="right">
                            <?php if (in_array('OC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                            <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceCharge,2);?>

                        </td>
                    </tr>
                    <?php }?>
                    
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge > 0 || in_array('HC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
                    <tr>
                        <td align="right">Hamali Charges</td>
                        <td align="right">
                            <?php if (in_array('HC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                            <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge,2);?>

                        </td>
                    </tr>
                    <?php }?>
                    
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->passCharge > 0) {?>
                    <tr>
                        <td align="right">Pass Charges</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->passCharge,2);?>
</td>
                    </tr>
                    <?php }?>
                    
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->docketCharge > 0 || in_array('DC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
                    <tr>
                        <td align="right">Docket Charges</td>
                        <td align="right">
                            <?php if (in_array('DC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                            <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->docketCharge,2);?>

                        </td>
                    </tr>
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH'])) {?>
                    <tr>
                        <td align="right">POD Charge</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value,2);?>
</td>       	
                    </tr>  
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['DYCH'])) {?>
                    <tr>
                        <td align="right">Delivery Charge</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['DYCH']->value,2);?>
</td>       	
                    </tr>  
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH'])) {?>
                    <tr>
                        <td align="right">Demurrage Charge</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value,2);?>
</td>       	
                    </tr>  
                    <?php }?>

                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH'])) {?>
                    <tr>
                        <td align="right">Connecting Charge</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value,2);?>
</td>       	
                    </tr>  
                    <?php }?>
                    
                    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'FRT' && isset($_smarty_tpl->tpl_vars['summary']->value->tax->code)) {?>
                        <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue != 0) {?>
                        <tr>
                            <td align="right">CGST</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue,2);?>
</td>
                        </tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue != 0) {?>
                        <tr>
                            <td align="right">SGST</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue,2);?>
</td>
                        </tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue != 0) {?>
                        <tr>
                            <td align="right">UGST</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue,2);?>
</td>
                        </tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue != 0) {?>
                        <tr>
                            <td align="right">IGST</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue,2);?>
</td>
                        </tr>
                        <?php }?>
                    <?php } elseif ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'FRT' && $_smarty_tpl->tpl_vars['summary']->value->serviceTax > 0) {?>
                        <tr>
                            <td align="right">GST</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceTax,2);?>
</td>
                        </tr>
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR'])) {?>
                    <tr>
                        <td align="right">Insurance Charge</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value,2);?>
</td>       	
                    </tr>  
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHBL']) || isset($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHDL']) || in_array('MC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
                    <tr>
                        <td align="right">Machine Handling Charges</td>
                        <td align="right">
                            <?php if (in_array('MC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                            <?php echo number_format(($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHBL']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHDL']->value),2);?>

                        </td>
                    </tr>  
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH'])) {?>
                        <tr>
                            <td align="right">Freight On Value Charges</td>
                            <td align="right">
                                <?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value,2);?>

                            </td>
                        </tr>  
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT'])) {?>
                    <tr>
                        <td align="right">Adjustment Amount</td>
                        <td align="right">
                            <?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value,2);?>

                            <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB","CL","CUL")) && $_smarty_tpl->tpl_vars['action_rights']->value['CGO-ADJSMT-AMT'] == 1 && is_null($_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT'])) {?>
                                &nbsp;<a href="javascript:;" onclick="editAdjustmentAmount();"><i class="fa fa-pencil"></i></a>
                            <?php }?>
                        </td>
                    </tr>
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF'])) {?>
                    <tr>
                        <td align="right">Round off</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value,2);?>
</td>
                    </tr>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>
                        <tr>
                            <td align="right" class="bold">Sub Total</td>
                            <td align="right" class="bold">
                                <?php echo number_format(($_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHDL']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHBL']->value)+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DYCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value),2);?>

                            </td>
                        </tr>
                    <?php }?>
                
                    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET' && $_smarty_tpl->tpl_vars['summary']->value->serviceTax > 0) {?>
                        <tr>
                            <td align="right">GST Amount</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceTax,2);?>
</td>
                        </tr>
                    <?php }?>

                    <tr class="active">
                        <td align="right" class="bold">Net Amount</td>
                        <td align="right" class="bold"><?php echo number_format(($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHDL']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHBL']->value)+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DYCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value),2);?>
</td>
                    </tr>

                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->computed->customerTdsTaxAmount > 0) {?>
                        <tr>
                            <td align="right">TDS Tax</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->computed->customerTdsTaxAmount,2);?>
</td>
                        </tr>
                    <?php }?>

                    <tr>
                        <td align="right">Amount Paid</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->paymentAmount,2);?>
</td>                    
                    </tr>
                    <tr>
                        <td align="right">Amount Balance</td>
                        <?php $_smarty_tpl->_assignInScope('balance_to_pay', round((($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHDL']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCHBL']->value)+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value-$_smarty_tpl->tpl_vars['summary']->value->computed->customerTdsTaxAmount)-$_smarty_tpl->tpl_vars['summary']->value->paymentAmount),2,PHP_ROUND_HALF_UP));?>
                        <td align="right" <?php if ($_smarty_tpl->tpl_vars['balance_to_pay']->value > 0) {?> class="danger" <?php }?>>
                            <?php echo number_format($_smarty_tpl->tpl_vars['balance_to_pay']->value,2);?>

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>


    <table width="100%" cellpadding="5" id="cd-action-panel" class="hidden">
    <tr>
        <td width="100%">
            <div id="cd-revert-panel" class="row hidden">
                <div class="col-md-offset-8 col-md-4">
                    <div class="form-group">
                        <label for="from_phone">Enter the amount want to revert</label>
                        <div class="input-group">
                            <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                            <input type="text" name="revert_amount" class="form-control" id="revert_amount" size="6"   style=" font-size: 14px; font-weight: bold;" />
                        </div>                                                            
                    </div>
                    <div class="form-group">
                        <label class="req">Remarks</label>
                        <textarea class="form-control" placeholder="Revert Remarks" id="revert-lr-remarks"></textarea>
                    </div>
                </div>  
                <div class="col-md-offset-8 col-md-4 text-right" id="cd-revert-panel-btn">
                    <button class="btn btn-success" type="button"  onclick="saveCargoRevertPayment('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Save</button> &nbsp;
                    <button type="button" class="btn btn-default" onclick="hideRevert()"> <i class="fa fa-arrow-left"></i> Back</button>
                </div>
            </div>
        </td>
    </tr>
    </table>    

    <table width="100%" cellpadding="5" id="cancel-action-panel" class="hidden">
    <tr>
        <td align="right" width="100%">
            <div id="lr-cancel-panel" class="row">
                <div class="col-md-offset-8 col-md-4">
                    <div class="form-group">
                        <textarea class="form-control" placeholder="Cancel Remarks" id="lr-cancel-remarks"></textarea>
                    </div>
                </div>  
                <div class="col-md-offset-8 col-md-4" id="lr-cancel-panel-btn">
                    <button class="btn btn-danger" type="button"  onclick="cancelCargo('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
', <?php echo $_smarty_tpl->tpl_vars['summary']->value->paymentAmount;?>
)"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentAmount > 0) {?>Revert Payment and <?php }?>Cancel</button> &nbsp;
                    <button type="button" class="btn btn-default" onclick="hideCancelRemarks()"> <i class="fa fa-arrow-left"></i> Back</button>
                </div>
            </div>
        </td>
    </tr>
    </table>

    <table width="100%" cellpadding="5" id="missing-action-panel" class="hidden">
    <tr>
        <td align="right" width="100%">
            <div id="lr-missing-panel" class="row">
                <div class="col-md-offset-8 col-md-4">
                    <div class="form-group">
                        <textarea class="form-control" placeholder="Cargo Missing Remarks" id="lr-missing-remarks"></textarea>
                    </div>
                </div>  
                <div class="col-md-offset-8 col-md-4" id="lr-missing-panel-btn">
                    <button class="btn btn-danger" type="button"  onclick="missingCargo('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
', <?php echo $_smarty_tpl->tpl_vars['summary']->value->paymentAmount;?>
)">Cargo Missing</button> &nbsp;
                    <button type="button" class="btn btn-default" onclick="hidemissingRemarks()"> <i class="fa fa-arrow-left"></i> Back</button>
                </div>
            </div>
        </td>
    </tr>
    </table>

    <div class="text-right" id="cd-action-state"></div>

    <div class="popup_bottom sticky-row-bottom">
    <table width="100%" cellpadding="5" id="cd-btn-panel">
        <tr>
            <td align="left" width="60%" nowrap>
                        <?php $_smarty_tpl->_assignInScope('allow_report_branch', 0);?>
            <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->transitOrganization->code,$_smarty_tpl->tpl_vars['reporting_branch']->value) || in_array($_smarty_tpl->tpl_vars['summary']->value->toOrganization->code,$_smarty_tpl->tpl_vars['reporting_branch']->value)) {?>
                <?php $_smarty_tpl->_assignInScope('allow_report_branch', 1);?>
            <?php }?>
                        <?php $_smarty_tpl->_assignInScope('hasReachedDestination', (($_smarty_tpl->tpl_vars['summary']->value->transitOrganization->code == $_smarty_tpl->tpl_vars['summary']->value->toOrganization->code) || ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->NEARBY_BRANCH_DELIVERY_FLAG == 1 && $_smarty_tpl->tpl_vars['summary']->value->transitOrganization->station->code == $_smarty_tpl->tpl_vars['summary']->value->toStation->code)));?>
            
                        <?php $_smarty_tpl->_assignInScope('allowDeliveryModel', 0);?>
            <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->deliveryModel->code == 'BOOKING') {?>
                <?php $_smarty_tpl->_assignInScope('allowDeliveryModel', 1);?>
            <?php } elseif ($_smarty_tpl->tpl_vars['cargo_setting']->value->deliveryModel->code == 'LOAD' && in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array('CL','CUL')) && $_smarty_tpl->tpl_vars['hasReachedDestination']->value) {?>
                <?php $_smarty_tpl->_assignInScope('allowDeliveryModel', 1);?>
            <?php } elseif ($_smarty_tpl->tpl_vars['cargo_setting']->value->deliveryModel->code == 'UNLOAD' && ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CUL' || ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CL' && isset($_smarty_tpl->tpl_vars['additional_status_list']->value['OFD']))) && $_smarty_tpl->tpl_vars['hasReachedDestination']->value) {?>
                <?php $_smarty_tpl->_assignInScope('allowDeliveryModel', 1);?>
            <?php } elseif ($_smarty_tpl->tpl_vars['cargo_setting']->value->deliveryModel->code == 'AFOFD') {?>
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'DYDO') {?>                     <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CL' && isset($_smarty_tpl->tpl_vars['additional_status_list']->value['OFD']) && $_smarty_tpl->tpl_vars['hasReachedDestination']->value) {?>
                        <?php $_smarty_tpl->_assignInScope('allowDeliveryModel', 1);?>
                    <?php }?>
                <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CUL' && $_smarty_tpl->tpl_vars['hasReachedDestination']->value) {?>
                    <?php $_smarty_tpl->_assignInScope('allowDeliveryModel', 1);?>
                <?php }?>
            <?php }?>
            
                        <?php $_smarty_tpl->_assignInScope('isAuthorizedForDelivery', ($_smarty_tpl->tpl_vars['action_rights']->value['ALW-DLRY-ANY-BRCH-LR'] == 1 || $_smarty_tpl->tpl_vars['summary']->value->toOrganization->code == $_smarty_tpl->tpl_vars['login_branch']->value || $_smarty_tpl->tpl_vars['allow_report_branch']->value));?>
            
            <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO" || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTIAL_STATUS_FLAG == 1) {?>
                                    <ul class="list-group">
                        <li class="list-group-item-success list-group-item-heading list-group-item flex justify-content-between align-items-center">
                            <b>Kindly use this parent <?php echo lang('lr');?>
 for make payment.</b>
                            <span class="badge badge-info badge-pill"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['parent_paymentType']->value->code];?>
</span>
                            <span class="badge badge-danger badge-pill" onclick="getCargoDetails('<?php echo $_smarty_tpl->tpl_vars['orgin_cargo']->value;?>
');"><?php echo $_smarty_tpl->tpl_vars['orgin_cargo']->value;?>
</span>
                        </li>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargoData']->value, 'cargoItems');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['cargoItems']->value) {
?>
                            <li class="list-group-item flex justify-content-between align-items-center">
                                <?php echo $_smarty_tpl->tpl_vars['cargoItems']->value['code'];?>

                                <span class="badge badge-primary badge-pill dinam-<?php echo $_smarty_tpl->tpl_vars['cargoItems']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['cargoItems']->value['cargoStatus']['code']];?>
</span>
                            </li>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </ul>
           
                    <?php if ($_smarty_tpl->tpl_vars['parent_cargoStatus']->value->code != "CD" && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTIAL_STATUS_FLAG != 1) {?> 
                        <div class="card">
                            <span>Please prioritize the delivery of the parent cargo before proceeding with the usual payment process.</span>
                            <span class="text-danger">*<span>  
                            <button class="btn btn-sm btn-danger" onclick="getCargoDetails('<?php echo $_smarty_tpl->tpl_vars['orgin_cargo']->value;?>
');">COLLECT</button>
                        </div>
                    <?php } else { ?>
                                                <?php if ($_smarty_tpl->tpl_vars['isAuthorizedForDelivery']->value && $_smarty_tpl->tpl_vars['allowDeliveryModel']->value && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != 'CD' && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != 'CA') {?>
                            <a class="btn btn-sm btn-success" onclick="showPaymentAndUnload()" href="javascript:;"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code != 'INP' && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code != 'OATP') {?>Payment & <?php }?>Delivery</a>&nbsp;
                        <?php }?>
                                            <?php }?>
                
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-UNLOD-ANY'] == 1 && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CL") {?>
                        <a class="btn btn-success btn-sm" onclick="changeCargoArticleStatus('CUL', '<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">UnLoad</a>&nbsp;
                    <?php }?>
                            <?php } else { ?>
                                <?php if ($_smarty_tpl->tpl_vars['isAuthorizedForDelivery']->value && $_smarty_tpl->tpl_vars['allowDeliveryModel']->value && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != 'CD' && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != 'CA') {?>
                    <a class="btn btn-sm btn-success" onclick="showPaymentAndUnload()" href="javascript:;"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code != 'INP' && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code != 'OATP') {?>Payment & <?php }?>Delivery</a>&nbsp;
                <?php }?>
            
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-UNLOD-ANY'] == 1 && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CL") {?>
                    <a class="btn btn-success btn-sm" onclick="changeCargoArticleStatus('CUL', '<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">UnLoad</a>&nbsp;
                <?php }?>
                            <?php }?>
                
                
                <?php if (($_smarty_tpl->tpl_vars['summary']->value->paymentAmount > 0) || ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CB" || $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CUL") || ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CUD") || ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != "CA")) {?>

                <div class="btn-group">
                    <div class="dropup">
                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                            More <span class="fa fa-caret-down"></span>
                        </button>                    
                        <ul class="dropdown-menu text-left">
                            <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->userAccountModel->code == 'TXRT' && $_smarty_tpl->tpl_vars['action_rights']->value['ALW-PART-PAYMENT'] == 1 && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code != "INP" && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code != "OATP" && in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB","CL","CUL")) && $_smarty_tpl->tpl_vars['balance_to_pay']->value > 0) {?>
                                <li> 
                                    <a href="javascript:;" onclick="showPaymentAndUnload('MAKE_PAYMENT')">Make Payment</a>
                                </li>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-ADJSMT-AMT'] == 1 && in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB","CL","CUL")) && is_null($_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT'])) {?>
                                <li> 
                                    <a href="javascript:;" onclick="editAdjustmentAmount()">Make Adjustment</a>
                                </li>
                            <?php }?>
                            <?php if (($_smarty_tpl->tpl_vars['action_rights']->value['ADD-PROOF-DOC'] == 1 && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != "CD")) {?>
                                <li> 
                                    <a href="javascript:;" onclick="showProofDialog('POB')">Update POB</a>
                                </li>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ADD-PROOF-DOC'] == 1 && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CD") {?>
                                <li> 
                                    <a href="javascript:;" onclick="showProofDialog('POD')">Update POD</a>
                                </li>
                            <?php }?>
                            <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB","CL","CUL")) && $_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT'] == 1) {?>
                                <li> 
                                    <a href="javascript:;" onclick="addGSTDialog()">Edit GST / Invoice</a>
                                </li>
                            <?php }?>
                            <?php if ((in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CL","CUL")) && $_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT'] == 1)) {?>
                                <li> 
                                    <a href="javascript:;" onclick="editTransitDialog()">Edit Transit Branch</a>
                                </li>
                            <?php }?>
                            <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CL")) && ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO" || ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "BO" && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG == 0))) {?>
                                <li> 
                                    <a href="javascript:;" onclick="removeOGPLDialog()">Remove From OGPL</a>
                                </li>
                            <?php }?>
                            <?php if ((in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CUL")) && $_smarty_tpl->tpl_vars['action_rights']->value['CARGO-EDIT'] == 1) && ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO" || ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "BO" && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG == 0))) {?>
                                <li>
                                    <a href="javascript:;" onclick="undoUnload('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Undo Unload</a>
                                </li>
                            <?php }?>
                            <?php if (($_smarty_tpl->tpl_vars['summary']->value->paymentAmount > 0 && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != "CD") && ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG != 1 || (!isset($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG) || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG == 0)) && ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-REVERT'] == 1)) {?>
                                <li> 
                                    <a onclick='revertCargoPayment("<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
");' href="javascript:;">Revert Payment</a>
                                </li>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNABLE-DELIVER'] == 1) {?>
                                <?php if (($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CB" || $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CUL") && ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO" || ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "BO" && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG == 0))) {?>
                                    <li> 
                                        <a href="javascript:;" onclick="changeCargoArticleStatus('CUD', '<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Unable to Deliver</a>
                                    </li>
                                <?php }?>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CUD") {?>
                                <li>  
                                    <a href="javascript:;" onclick="revertUnableDeliver('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Allow to Deliver</a>
                                </li>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['OGPL-UNL-CGOMISS'] == 1 && ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO" || ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "BO" && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG == 0))) {?>
                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != "CMS") {?>
                                    <li> 
                                        <a href="javascript:;" onclick="showmissingCargo()">Cargo Missing</a>
                                    </li>    
                                <?php }?>
                                
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CMS") {?>
                                <li> 
                                    <a href="javascript:;" onclick="showRevertMissingCargo('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Revert Cargo Missing</a>
                                </li>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CUD") {?>
                                <li>  
                                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->transitOrganization->code == $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->code) {?>
                                        <a href="javascript:;" onclick="changeCargoArticleStatus('CR', '<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Return</a> 
                                    <?php } else { ?>
                                        <a href="javascript:;" onclick="showReturnCargo('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Return</a> 
                                    <?php }?>
                                </li>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CUL' && $_smarty_tpl->tpl_vars['summary']->value->transitOrganization->code == $_smarty_tpl->tpl_vars['summary']->value->toOrganization->code) {?>
                                <li>
                                    <a href="javascript:;" onclick="showDeliveryFollowUp()">Delivery Follow Up</a> 
                                </li>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-DOOR-PICKUP'] > 0) {?>
                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CB') {?>
                                    <li>   
                                        <a onclick='showDoorPickup();' href="javascript:;">Update Door Pickup Address</a>
                                    </li>
                                <?php }?>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-DELIV-DDCHARGES'] != 1 && $_smarty_tpl->tpl_vars['action_rights']->value['CARGO-DOOR-DELIVERY'] > 0) {?>
                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != "CA" && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != "CD") {?>
                                    <li>   
                                        <a onclick='showDoorDelivery();' href="javascript:;">Update Door Delivery Address</a>
                                    </li>
                                <?php }?>                                
                            <?php }?>
                            <?php if (($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CD' && $_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'DYDO' && isset($_smarty_tpl->tpl_vars['additional_status_list']->value['OFD'])) || ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == 'CUL' && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->NEARBY_BRANCH_DELIVERY_FLAG == 1 && $_smarty_tpl->tpl_vars['summary']->value->transitOrganization->station->code == $_smarty_tpl->tpl_vars['summary']->value->toStation->code)) {?>
                                <li>
                                    <a href="javascript:;" onclick="editDDHandoverDialog('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Update Door Delivery Status</a> 
                                </li>
                            <?php }?>
                            <?php $_smarty_tpl->_assignInScope('has_instant_cancellation', ($_smarty_tpl->tpl_vars['login_station']->value == $_smarty_tpl->tpl_vars['summary']->value->fromStation->code && ((time()-strtotime($_smarty_tpl->tpl_vars['summary']->value->bookedAt))/60) < $_smarty_tpl->tpl_vars['instant_cancellation_minutes']->value));?>
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-CANCEL'] == 1 || $_smarty_tpl->tpl_vars['has_instant_cancellation']->value) {?>
                                <?php if (($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != "CA" && $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code != "CD") && ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO" || ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "BO" && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->CARGO_PARTITION_FLAG == 0))) {?>
                                    <li>   
                                        <a onclick='showCancelCargo("<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
");' href="javascript:;"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentAmount > 0) {?>Revert Payment and <?php }?>Cancel</a>
                                    </li>
                                <?php }?>
                            <?php }?>
                        </ul>                    
                    </div>
                </div>
                <?php }?>

                <a class="btn btn-primary btn-sm" href="cargo/whatsapp-share?lr=<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
&type=BOOK" target="_blank"><i class="fa fa-lg fa-whatsapp" aria-hidden="true"></i> Whatsapp Share</a>
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CD") {?>
                    <a class="btn btn-success btn-sm" href="cargo/print-delivery-receipt?code=<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
&count=4" target="_blank"><i class="fa fa-lg fa-print" aria-hidden="true"></i>Acknowledge Print</a>
                    <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CB" && smarty_modifier_date_format((time()-strtotime($_smarty_tpl->tpl_vars['summary']->value->bookedAt)),'%d') <= 3) {?>
                    <button type="button" class="btn btn-primary" onclick="resendCargoSMS()">Resend SMS</button>
                <?php }?>
            </td>

            <td align="right" width="40%" nowrap>

                <div class="btn-group print-btn-group">
                    <button type="button" class="btn btn-success" id="print-button" title="Print (Alt+P)" onclick="printUsingPreferences()"></button>
                    <button type="button" class="btn btn-success" id="print-preferences-button" onclick="showPrintPreferences()" title="Print Preferences (Alt+Shift+P)">
                        <i class="fa fa-ellipsis-v" aria-hidden="true"></i>
                    </button>
                </div>

                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "sbrscargo" && $_smarty_tpl->tpl_vars['balance_to_pay']->value == 0 && isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST) && isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)) {?>
                    <button type="button" class="btn btn-success" onclick="printCargoInvoice('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
');" data-type="GST Invoice">Print Invoice</button>
                <?php }?>

                <a class="btn btn-sm btn-default" onclick='getCargoHIstory("<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
");' href="javascript:;">History</a>  
                <a class="btn btn-sm btn-default" onclick='closeCargoDetailsDialog();' href="javascript:;">Close</a>&nbsp;  
            </td>
        </tr>
    </table>
    </div>
</div>
<?php } else { ?>
    <div class="alert alert-danger">Invalid <?php echo lang('lr');?>
 Code</div>   
<?php }?>

<div id="print-preferences-dialog" class="hide dialog-content-page">
    <div class="panel-body" id="print-preferences-panel">
        <form class="form-inline" onchange="printPreferencesChanged()" onsubmit="printUsingPreferences();hidePrintPreferences();return false;">
            <div class="row pb10">
                <div class="col-sm-10">
                    <div class=" bold ft_14">Printing Preferences</div>
                    <div class="text-muted">Choose your option and press alt + p to print</div>
                </div>
                <div class="col-sm-2">            
                    <a class="align-right" onclick="hidePrintPreferences()" href="javascript:;" title="click or press ESC to close" tabindex="-1"><i class="fa fa-times-circle ft_22"></i></a>            
                </div>
            </div>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-3IN-PRNT'] != 1) {?>
                <div class="row p-y-10">
                    <div class="col-md-4 bold">Thermal Printer</div>
                    <div class="col-md-8">
                        <div class="radio">
                            <label><input type="radio" name="print-pref-radio" value="3INCH" data-eventtype="3 Inch"> 3" Print</label>
                        </div>&emsp;
                        <div class="form-group">
                            <input type="number" class="form-control form-control-sm spin" id="thermal-print-copies" value="1" min="1" max="9" title="No. of Copies">
                        </div>&emsp;
                        <div class="checkbox">
                            <label><input type="checkbox" id="marking-token-cb"> Marking Token</label>
                        </div>
                    </div>
                </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-1CPY-PRNT'] != 1 || $_smarty_tpl->tpl_vars['action_rights']->value['HIDE-2CPY-PRNT'] != 1 || $_smarty_tpl->tpl_vars['action_rights']->value['HIDE-3CPY-PRNT'] != 1 || $_smarty_tpl->tpl_vars['action_rights']->value['HIDE-COLMN-PRNT'] != 1) {?>
                <div class="border_bottom"></div>
                <div class="row p-y-10">
                    <div class="col-md-4 bold">Laser Printer</div>
                    <div class="col-md-8">
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-1CPY-PRNT'] != 1) {?>
                            <div class="radio">
                                <label><input type="radio" name="print-pref-radio" value="1COPY" data-eventtype="1 Copy"> 1 print</label>
                            </div>&emsp;
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-2CPY-PRNT'] != 1) {?>
                            <div class="radio">
                                <label><input type="radio" name="print-pref-radio" value="2COPY" data-eventtype="2 Copy"> 2 print</label>
                            </div>&emsp;
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-3CPY-PRNT'] != 1) {?>
                            <div class="radio">
                                <label><input type="radio" name="print-pref-radio" value="3COPY" data-eventtype="3 Copy"> 3 print</label>
                            </div>&emsp;
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-COLMN-PRNT'] != 1) {?>
                            <div class="radio">
                                <label><input type="radio" name="print-pref-radio" value="2COLUMN" data-eventtype="Grid View"> 2 Column</label>
                            </div>
                        <?php }?>   
                    </div>
                </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-DM-PRINT'] == 1) {?>
                <div class="border_bottom"></div>
                <div class="row p-y-10">
                    <div class="col-md-4 bold">Dot Matrix Printer</div>
                    <div class="col-md-8">
                        <div class="radio">
                            <label><input type="radio" name="print-pref-radio" value="DOTMATRIX" data-eventtype="Dot Matrix"> DM Print</label>
                        </div>&emsp;
                        <div class="radio">
                             <label><input type="radio" name="print-pref-radio" value="Print"> None</label>
                        </div>&emsp;
                    </div>
                </div>
            <?php }?>
            <div class="border_bottom"></div>
            <div class="row p-y-10">
                <div class="col-md-4 bold">Label Printer</div>
                <div class="col-md-8">
                    <div class="checkbox">
                        <label><input type="checkbox" id="label-print-cb"> Label per Item</label>
                    </div>
                    <div class="print-pref-epstatus p_l_15"></div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-sm-12">
                    <button type="submit" class="btn btn-success col-sm-3 pull-right">Print</button>
                </div>
            </div>
        </form>
    </div>
</div>
<?php $_smarty_tpl->_subTemplateRender("file:site/cargo/label-printing.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

<div id="print-receipt-preferences-dialog" class="hide dialog-content-page">
    <div class="panel-body" id="print-receipt-preferences-panel">
        <form class="form-inline" onchange="receiptPrintPreferencesChanged()" onsubmit="printReceiptUsingPreferences();hideReceiptPrintPreferences();return false;">
            <div class="row pb10">
                <div class="col-sm-10">
                    <div class=" bold ft_14">Receipt Printing Preferences</div>
                    <div class="text-muted">Choose your option and press alt + p to print</div>
                </div>
                <div class="col-sm-2">            
                    <a class="align-right" onclick="hideReceiptPrintPreferences()" href="javascript:;" title="click or press ESC to close" tabindex="-1"><i class="fa fa-times-circle ft_22"></i></a>            
                </div>
            </div>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-3IN-PRNT'] != 1) {?>
                <div class="row p-y-10">
                    <div class="col-md-4 bold">Thermal Printer</div>
                    <div class="col-md-8">
                        <div class="radio">
                            <label><input type="radio" name="print-pref-radio" value="3INCH" data-eventtype="3 Inch"> 3" Print</label>
                        </div>
                    </div>
                </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-1CPY-PRNT'] != 1 || $_smarty_tpl->tpl_vars['action_rights']->value['HIDE-2CPY-PRNT'] != 1) {?>
                <div class="border_bottom"></div>
                <div class="row p-y-10">
                    <div class="col-md-4 bold">Laser Printer</div>
                    <div class="col-md-8">
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-1CPY-PRNT'] != 1) {?>
                            <div class="radio">
                                <label><input type="radio" name="print-pref-radio" value="1COPY" data-eventtype="1 Copy"> 1 print</label>
                            </div>&emsp;
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-2CPY-PRNT'] != 1) {?>
                            <div class="radio">
                                <label><input type="radio" name="print-pref-radio" value="2COPY" data-eventtype="2 Copy"> 2 print</label>
                            </div>&emsp;
                        <?php }?>
                      
                    </div>
                </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-DM-PRINT'] == 1) {?>
                <div class="border_bottom"></div>
                <div class="row p-y-10">
                    <div class="col-md-4 bold">Dot Matrix Printer</div>
                    <div class="col-md-8">
                        <div class="radio">
                            <label><input type="radio" name="print-pref-radio" value="DOTMATRIX" data-eventtype="Dot Matrix"> DM Print</label>
                        </div>
                    </div>
                </div>
            <?php }?>
            <br>
            <div class="row">
                <div class="col-sm-12">
                    <button type="submit" class="btn btn-success col-sm-3 pull-right">Print</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div id="unloading-panel" class="hide">
    <br>
    <span class="bold">Add Unloading Charges</span>
    
    <table width="100%" cellpadding="5" class="table table-striped">
        <thead>
        <tr>
            <th align="center" class="bold">S No</th>
            <th align="center" class="bold">Article</th>                                 
            <th align="center" class="bold">Quantity</th>
            <th align="center" class="bold">Unloading Charges</th>
        </tr>
        </thead>
        <tbody class="body_table" >
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
  'index' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index']++;
?>
                <tr>
                    <td align="center"><?php echo (isset($_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index'] : null)+1;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->name;?>
</td>                                 
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td>
                    <td align="right">
                        <div class="input-group">
                            <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                            <input type="text" data-code="<?php echo $_smarty_tpl->tpl_vars['article']->value->code;?>
" value="0" class="form-control unloadingarticle" onblur="calculateUnloadingAmounts();"  maxlength="4" style="width:50px" />
                        </div>                         
                    </td>
                </tr>                        
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?> 
                <tr>
                    <td align="right" class="bold" colspan="3">Total</td>
                    <td align="left">
                        <div class="input-group">
                            <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                            <input type="text" id="unloading-total" value="0.0" class="form-control bold" style="width:50px" />
                        </div> 
                    </td>
                </tr>
        </tbody>
    </table>
                
    <div class="row">      
        <div class="col-md-12 text-right">            
            <div class="" id="ul-action-state"></div>
            <div class="text-right" id="ul-buttons">
                <button class="btn btn-success" type="button"  onclick="saveCargoUnloadingCharge('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Save</button> &nbsp;
                <button type="button" class="btn btn-default" onclick="hideUnloading()"> <i class="fa fa-arrow-left"></i> Back</button>
            </div>
        </div>
    </div>

</div>
                
<div id="payment-unload-deliver-panel" style="padding-bottom: 150px;" class="hide">
    <div id="unload-deliver-content">
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-DELIV-ULCHARGES'] != 1 && ($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CB" || $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code == "CUL")) {?>
            <label class="bold d-inline-block" id="add-unload-cb-div">
                <input type="checkbox" id="add-unload-cb" onchange="toggleAddUnloading(this);calcDeliveryPayment();getAllDeliveryInputs();" <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO") {?> disabled <?php }?>> Add Unloading Charges
            </label>
        <?php }?>
       <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNLOADING-CHARGES'] == 1) {?>
            <table width="100%" cellpadding="5" class="table table-striped" id="add-unload-table" style="display: none;">
                <thead>
                    <tr>
                        <th align="center" class="bold">S No</th>
                        <th align="center" class="bold">Article</th>
                        <th align="center" class="bold">Quantity</th>
                        <th align="center" class="bold">Unloading Charges</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
  'index' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index']++;
?>
                        <tr>
                            <td align="center"><?php echo (isset($_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index'] : null)+1;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->name;?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td>
                            <td align="right">
                                <div class="input-group">
                                    <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                    <input type="text" data-code="<?php echo $_smarty_tpl->tpl_vars['article']->value->code;?>
" value="0" class="form-control payment-unloadingarticle" onblur="calcPaymentUnloadingAmounts();calcDeliveryPayment();" maxlength="4" style="width:50px" data-loadingcharge="<?php echo $_smarty_tpl->tpl_vars['article']->value->handlingChargeAmount;?>
" data-totalfreight="<?php echo $_smarty_tpl->tpl_vars['article']->value->computed->freight;?>
" />
                                </div>
                            </td>
                        </tr>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <tr>
                        <td align="right" class="bold" colspan="3">Total</td>
                        <td align="left">
                            <div class="input-group">
                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                <input type="text" id="payment-unloading-total" value="0.0" class="form-control bold" style="width:50px" />
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        <?php }?>
        <div class="clear_fix_both"></div>
        <label class="bold d-inline-block hide">
            <input type="checkbox" id="make-delivery-cb" onchange="calcDeliveryPayment();"> Make delivery
        </label>

        <div class="row pb10" id="make-delivery-div" style="display: none;">
            <div class="delivery-charges-row <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" || $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "OATP") {?>hide<?php }?>">
                <div class="col-md-2 <?php if ($_smarty_tpl->tpl_vars['balance_to_pay']->value == 0) {?>hide<?php }?>">
                    <label>Balance</label>
                    <input type="text" class="form-control hover-background" placeholder="Balance" maxlength="8" value="<?php echo $_smarty_tpl->tpl_vars['balance_to_pay']->value+0;?>
" disabled />
                </div>
                <div class="col-md-2 hide" id="now-paying-amount-div">
                    <label>Now Paying</label>
                    <input type="text" class="form-control" placeholder="Now Paying" id="now-paying-amount" value="<?php echo $_smarty_tpl->tpl_vars['balance_to_pay']->value+0;?>
" onblur="calcDeliveryPayment();" />
                </div>
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-DELIV-CHARGES'] == 1) {?>
                    <div class="col-md-2 pre-delivery-options">
                        <label>Delivery Charge</label>
                        <input type="text" class="form-control" placeholder="Delivery Charge" id="delivery-charge" maxlength="8" value="<?php echo $_smarty_tpl->tpl_vars['cargo_setting']->value->defaultDeliveryCharge*count($_smarty_tpl->tpl_vars['summary']->value->itemDetails);?>
" onblur="calcDeliveryPayment();" <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO") {?> disabled <?php }?>/>
                    </div>
                <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'DYDO') {?>
                    <div class="col-md-2 pre-delivery-options <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-DELIV-DDCHARGES'] == 1) {?>hidden<?php }?>">
                        <label>Door Delivery Charge</label>
                        <input type="text" class="form-control" placeholder="Door Delivery Charge" id="door-delivery-charge" maxlength="8" value="<?php echo $_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+0;?>
" data-min="<?php echo $_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+0;?>
" onblur="calcDeliveryPayment();" <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO") {?> disabled <?php }?>/>
                    </div>
                <?php }?>
                <div class="col-md-2 demurrage-charge-cont pre-delivery-options hide">
                    <label>Demurrage Charge</label>
                    <input type="text" class="form-control" placeholder="Demurrage Charge" id="demurrage-charge" maxlength="8" onblur="calcDeliveryPayment();" />
                </div>
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-TDS-TAX'] == 1) {?>
                    <div class="col-md-2 tds-tax-cont pre-delivery-options hide">
                        <label for="delivery_tds_percent">TDS</label>
                        <div class="row">
                            <div class="col-md-7 p_r_n">
                                <select class="form-control" id="delivery_tds_percent" onchange="calcDeliveryTDSPercent(this.value);getAllDeliveryInputs();"  <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code == "PBO") {?> disabled <?php }?>>
                                    <option value="0">Nil</option>
                                    <option value="2">2%</option>
                                                                    </select>
                            </div>
                            <div class="col-md-5 p_l_n">
                                <input type="text" class="form-control" id="delivery_tds_tax" value="0" data-mask="positivedecimal" onblur="calcDeliveryPayment(false);" disabled>
                            </div>
                        </div>
                    </div>
                <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-MACHINE-HANDLING'] == 1) {?>
                    <div class="col-md-2 p_l_n">
                        <label class="d-inline" for="machine-handling-charge">Machine Handling Cgs.</label>
                        <span data-toggle="popover" data-content="
                            <table class='table' width='300'>
                                <thead>
                                    <tr>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['machine_handling_tariff']->value, 'tariff');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['tariff']->value) {
?>
                                    <tr>
                                        <td><?php echo $_smarty_tpl->tpl_vars['tariff']->value->fromUnitValue;
echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['tariff']->value->unitCode];?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['tariff']->value->toUnitValue;
echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['tariff']->value->unitCode];?>
</td>
                                        <td align='left'><?php echo inr_format($_smarty_tpl->tpl_vars['tariff']->value->amount);?>
</td>
                                    </tr>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </tbody>
                            </table>
                        "><i class="fa fa-info-circle"></i></span>
                        <div class="input-group">
                            <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                            <input type="text" class="form-control" onblur="calcDeliveryPayment();" id="machine-handling-charge" value="0" data-fs="MC" data-mask="inrcurrency">
                        </div>
                    </div>
                <?php }?>
                <div class="col-md-2">
                    <div class="">
                        <label for="from_phone">Payable Amount</label>
                        <div class="input-group">
                            <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                            <input type="text" name="payment_amount" class="form-control hover-background" id="payment_amount" size="6" maxlength="8" style=" font-size: 14px; font-weight: bold;" disabled/>
                        </div>
                    </div>
                </div>
                <?php if ($_smarty_tpl->tpl_vars['hamaliCharge']->value > 0) {?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoType->code != "PBO") {?>
                        <div class="col-md-2">
                            <div class="">
                                <label for="from_phone">hamali Charge</label>
                                <div class="input-group">
                                    <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                    <input type="text" name="hamaliCharge" class="form-control hover-background" id="hamaliCharge" value="<?php echo $_smarty_tpl->tpl_vars['hamaliCharge']->value;?>
" size="6" maxlength="8" style=" font-size: 14px; font-weight: bold;" disabled/>
                                </div>
                            </div>
                        </div>
                    <?php }?>
                    
                <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-MULTI-PAY-MODE'] != 1) {?>
                    <div class="col-md-2 hide" id="payment_transaction_mode_cont">
                        <div class="">
                            <label for="pay-transaction-mode-main" class="req">Transaction Mode</label>
                            <select id="pay-transaction-mode-main" class="form-control" onchange="setPaymentTransactionMode('main');getAllDeliveryInputs();">
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactions_details']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
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
                    </div>
                <?php }?>
            </div>
            
            <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'DYDO' && isset($_smarty_tpl->tpl_vars['additional_status_list']->value['OFD'])) {?>
                <div class="col-md-3">
                    <label class="req">Handover Person Name</label>
                    <input type="text" class="form-control" placeholder="Handover Person Name" id="dd-handover-person"/>
                </div>
                <div class="col-md-4">
                    <label class="req">Door Delivery Status</label>
                    <select class="form-control" id="dd-delivery-status">
                        <option value="">Select Status</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargoremarks']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->cargoStatus->code == 'DRDLY') {?>
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
            <?php }?>
            <div class="clear_fix_both"></div><br>

                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-MULTI-PAY-MODE'] == 1 && !in_array($_smarty_tpl->tpl_vars['summary']->value->paymentType->code,array("INP","OATP"))) {?>
                <div class="hide" id="payment_transaction_mode_cont">
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="pay-transaction-mode-main">Transaction Mode</label>
                                    <select id="pay-transaction-mode-main" class="form-control" onchange="setPaymentTransactionMode('main');getAllDeliveryInputs();">
                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactions_details']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
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
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="pay-amount-main">Amount</label>
                                    <div class="input-group">
                                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                        <input type="text" disabled maxlength="6" class="form-control" id="pay-amount-main" data-mask="positivedecimal" placeholder="0" style=" font-size: 14px; font-weight: bold;"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label>&nbsp;</label>
                                <a href="javascript:;" class="btn btn-sm btn-default" id="pay-add-transaction-mode-btn" title="Add Transaction Mode" onclick="addDeliveryTransactionMode()"> <i class="fa fa-plus"></i> Transaction Mode </a>
                            </div>
                        </div>
                            
                                                <div class="hide" id="pay-upi-mode-panel-main">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="pay-upi-orgbank-main">Organization Bank</label>
                                        <select class="form-control" id="pay-upi-orgbank-main">
                                            <option value="">Select Organization Bank</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="pay-upi-id-main">UPI ID</label>
                                        <input type="text" class="form-control" id="pay-upi-id-main" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="pay-upi-details-main">Ref. #</label>
                                        <input type="text" class="form-control" id="pay-upi-details-main" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="hide" id="pay-netbanking-mode-panel-main">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="pay-netbanking-orgbank-main">Organization Bank</label>
                                        <select class="form-control" id="pay-netbanking-orgbank-main">
                                            <option value="">Select Organization Bank</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="pay-netbanking-accholder-main">Account Holder Name</label>
                                        <input type="text" class="form-control" id="pay-netbanking-accholder-main" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="pay-netbanking-bankname-main">Bank Name</label>
                                        <input type="text" class="form-control" id="pay-netbanking-bankname-main" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="pay-netbanking-details-main">Ref. #</label>
                                        <input type="text" class="form-control" id="pay-netbanking-details-main" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="hide" id="pay-cheque-mode-panel-main">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="pay-cheque-payer-main">Payer Details</label>
                                        <input type="text" class="form-control" id="pay-cheque-payer-main" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="pay-cheque-no-main">Cheque No</label>
                                        <input type="text" class="form-control" id="pay-cheque-no-main" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="pay-cheque-date-main">Cheque Date</label>
                                        <input type="text" class="form-control" id="pay-cheque-date-main" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="pay-cheque-bankcity-main">Bank City</label>
                                        <input type="text" class="form-control" id="pay-cheque-bankcity-main" maxlength="90" placeholder="Bank City" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="pay-cheque-bankname-main">Bank Name</label>
                                        <input type="text" class="form-control" id="pay-cheque-bankname-main" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="pay-cheque-remarks-main">Remarks</label>
                                        <input type="text" class="form-control" placeholder="Remarks" id="pay-cheque-remarks-main" data-mask="englishonly"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="hide" id="pay-other-transaction-mode">
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="pay-transaction-mode-sub">Transaction Mode</label>
                                        <select id="pay-transaction-mode-sub" class="form-control" onchange="setPaymentTransactionMode('sub');getAllDeliveryInputs();">
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactions_details']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
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
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="pay-amount-sub">Amount</label>
                                        <div class="input-group">
                                            <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                            <input type="text" maxlength="6" class="form-control" id="pay-amount-sub" data-mask="positivedecimal" placeholder="0" style=" font-size: 14px; font-weight: bold;" oninput="calculateDeliverySplitup();"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <label>&nbsp;</label>
                                    <a href="javascript:;" class="btn btn-sm btn-danger" id="pay-remove-transaction-mode-btn" title="Remove Transaction Mode" onclick="removeDeliveryTransactionMode()"> <i class="fa fa-times"></i> Transaction Mode </a>
                                </div>
                            </div>

                                                        <div class="hide" id="pay-upi-mode-panel-sub">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="pay-upi-orgbank-sub">Organization Bank</label>
                                            <select class="form-control" id="pay-upi-orgbank-sub">
                                                <option value="">Select Organization Bank</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="pay-upi-id-sub">UPI ID</label>
                                            <input type="text" class="form-control" id="pay-upi-id-sub" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="pay-upi-details-sub">Ref. #</label>
                                            <input type="text" class="form-control" id="pay-upi-details-sub" placeholder="Ref. #" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="hide" id="pay-netbanking-mode-panel-sub">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="pay-netbanking-orgbank-sub">Organization Bank</label>
                                            <select class="form-control" id="pay-netbanking-orgbank-sub">
                                                <option value="">Select Organization Bank</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="pay-netbanking-accholder-sub">Account Holder Name</label>
                                            <input type="text" class="form-control" id="pay-netbanking-accholder-sub" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="pay-netbanking-bankname-sub">Bank Name</label>
                                            <input type="text" class="form-control" id="pay-netbanking-bankname-sub" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="pay-netbanking-details-sub">Ref. #</label>
                                            <input type="text" class="form-control" id="pay-netbanking-details-sub" placeholder="Ref. #" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="hide" id="pay-cheque-mode-panel-sub">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="pay-cheque-payer-sub">Payer Details</label>
                                            <input type="text" class="form-control" id="pay-cheque-payer-sub" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="pay-cheque-no-sub">Cheque No</label>
                                            <input type="text" class="form-control" id="pay-cheque-no-sub" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="pay-cheque-date-sub">Cheque Date</label>
                                            <input type="text" class="form-control" id="pay-cheque-date-sub" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="pay-cheque-bankcity-sub">Bank City</label>
                                            <input type="text" class="form-control" id="pay-cheque-bankcity-sub" maxlength="90" placeholder="Bank City" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="pay-cheque-bankname-sub">Bank Name</label>
                                            <input type="text" class="form-control" id="pay-cheque-bankname-sub" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="pay-cheque-remarks-sub">Remarks</label>
                                            <input type="text" class="form-control" placeholder="Remarks" id="pay-cheque-remarks-main" data-mask="englishonly"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <?php }?>
            <div class="clear_fix_both"></div>

            <div class="col-md-6">
                <label>Remarks</label>
                <textarea class="form-control" placeholder="Remarks" id="delivery-remarks"></textarea>
            </div>

            <div class="clear_fix_both"></div>
            <div class="pre-delivery-options">
                <div class="col-md-2 w-auto <?php if (!$_smarty_tpl->tpl_vars['cargo_setting']->value->otpValidateDeliveryFlag) {?>hide<?php }?>" id="send-delopt-cont">
                    <label>&nbsp;</label>
                                        <div class="btn-group">
                        <div class="dropdown">
                            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">Send OTP &nbsp;<span class="fa fa-caret-down"></span></button>
                            <ul class="dropdown-menu text-left">
                                <li>
                                    <a href="javascript:;" onclick="sendDeliveryOTP()">To Receiver</a>
                                </li>
                                <li>
                                    <a href="javascript:;" onclick="sendDeliveryOTP('FROMCUST')">To Sender</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 <?php if (!$_smarty_tpl->tpl_vars['cargo_setting']->value->otpValidateDeliveryFlag) {?>hide<?php }?>" id="enter-delopt-cont">
                    <label class="req">Delivery OTP</label>
                    <input type="text" class="form-control" placeholder="Delivery OTP" id="delivery-otp" maxlength="8" />
                </div>
                <div class="col-md-3 <?php if (!$_smarty_tpl->tpl_vars['cargo_setting']->value->otpValidateDeliveryFlag) {?>hide<?php }?>">
                    <label>&nbsp;</label>
                    <label class="bold <?php if (!$_smarty_tpl->tpl_vars['cargo_setting']->value->otpOverrideDeliveryFlag) {?>hide<?php }?>">
                        <input type="checkbox" id="deliver-without-otp-cb" onclick="toggleDeliverOTP(this)"> Deliver on my own risk without OTP.
                    </label>
                </div>
                <div class="clearfix"></div><br>
                <div <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ADD-PROOF-DOC'] != 1) {?>class="hide" <?php }?>>
                    <div class="col-md-2">
                        <label for="podproof-document-type" class="req">Document Type</label>
                        <select id="podproof-document-type" class="form-control">
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['proof_document_type']->value, 'name', false, 'code');
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
                    <div class="col-lg-2">
                        <label for="podproof-document-no">Document Number</label>
                        <input type="text" class="form-control" id="podproof-document-no" placeholder="Document Number" maxlength="25">
                    </div>
                    <div class="col-lg-2">
                        <label for="proof-mobile-no">Mobile Number</label>
                        <input type="text" class="form-control" id="podproof-mobile-no" placeholder="Mobile Number" maxlength="10" inputmode="decimal" data-mask="inrcurrency" oninput="validateNumberInput(this, 10)">
                    </div>

                    <div>
                        <?php $_smarty_tpl->_subTemplateRender("file:site/cargo/delivery-file-webcam-store-component.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('id'=>"pod-webcam-proof-fileupload",'axis'=>"horizontal"), 0, false);
?>
                    </div>
                    
                    <div class="col-md-12">
                        <?php $_smarty_tpl->_subTemplateRender("file:site/cargo/file-store-component.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('id'=>"pod-proof-fileupload",'axis'=>"horizontal"), 0, false);
?>
                    </div>
                </div>
                
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CUST-BAL-AMT'] == 1) {?>
                    <div id="dd-customer-calculation" class="hide">
                        <div class="col-md-2">
                            <label>Customer Amount</label>
                            <input type="number" class="form-control" id="dd-customer-amount" oninput="getBalanceReturnAmount(this);" placeholder="Customer Amount">
                        </div>

                        <div class="col-md-2">
                            <label>Balance Return</label>
                            <input type="number" class="form-control" disabled id="dd-balance-return-amount" placeholder="Balance Return">
                        </div>
                    </div>
                <?php }?>
            </div>

            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-MULTI-PAY-MODE'] != 1) {?>
                <div class="hide" id="pay-upi-mode-panel-main">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="pay-upi-orgbank-main">Organization Bank</label>
                            <select class="form-control" id="pay-upi-orgbank-main">
                                <option value="">Select Organization Bank</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="pay-upi-id-main">UPI ID</label>
                            <input type="text" class="form-control" id="pay-upi-id-main" maxlength="250" placeholder="UPI ID" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="pay-upi-details-main">Ref. #</label>
                            <input type="text" class="form-control" id="pay-upi-details-main" placeholder="Ref. #" autocomplete="off">
                        </div>
                    </div>
                </div>

                <div class="hide" id="pay-netbanking-mode-panel-main">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="pay-netbanking-orgbank-main">Organization Bank</label>
                            <select class="form-control" id="pay-netbanking-orgbank-main">
                                <option value="">Select Organization Bank</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="pay-netbanking-accholder-main">Account Holder Name</label>
                            <input type="text" class="form-control" id="pay-netbanking-accholder-main" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="pay-netbanking-bankname-main">Bank Name</label>
                            <input type="text" class="form-control" id="pay-netbanking-bankname-main" maxlength="120" placeholder="Bank Name" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="pay-netbanking-details-main">Ref. #</label>
                            <input type="text" class="form-control" id="pay-netbanking-details-main" placeholder="Ref. #" autocomplete="off">
                        </div>
                    </div>
                </div>

                <div class="hide" id="pay-cheque-mode-panel-main">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="pay-cheque-payer-main">Payer Details</label>
                            <input type="text" class="form-control" id="pay-cheque-payer-main" maxlength="250" placeholder="Payer Details" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="pay-cheque-no-main">Cheque No</label>
                            <input type="text" class="form-control" id="pay-cheque-no-main" maxlength="60" placeholder="Cheque No" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="pay-cheque-date-main">Cheque Date</label>
                            <input type="text" class="form-control" id="pay-cheque-date-main" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="pay-cheque-bankcity-main">Bank City</label>
                            <input type="text" class="form-control" id="pay-cheque-bankcity-main" maxlength="90" placeholder="Bank City" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="pay-cheque-bankname-main">Bank Name</label>
                            <input type="text" class="form-control" id="pay-cheque-bankname-main" maxlength="120" placeholder="Bank Name" autocomplete="off">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="pay-cheque-remarks-main">Remarks</label>
                            <input type="text" class="form-control" placeholder="Remarks" id="pay-cheque-remarks-main" data-mask="englishonly"/>
                        </div>
                    </div>
                </div>

                            <?php }?>
        </div>

        <div id="cd-payment-panel" class="row">
        </div>
    </div>

    <div id="post-delivery-content" class="hide">
        <span class="bold">Now Paying : </span> <span id="d-topay-amt"></span><br />
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-DELIV-CHARGES'] == 1) {?>
            <span class="bold">Delivery Charge : </span> <span id="d-deliv-amt"></span><br />
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'DYDO') {?>
            <span class="bold">Door Delivery Charge : </span> <span id="d-ddeliv-amt"></span><br />
        <?php }?>
        <span class="bold">Net Amount : </span> <span id="d-net-amt"></span><br />
        <br />
    </div>

    <div class="row">
        <div class="col-md-12 text-left">
            <div class="" id="pay-deliver-action-state"></div>

            <div class="hide text-center" id="post-delivery-options">
                <div class="col-md-6 text-right">
                    <div id="delivery-receipt-div">
                        <div class="btn-group print-btn-group">
                            <button type="button" class="btn btn-success" id="print-receipt-button" title="Print" onclick="printReceiptUsingPreferences()"><i class="fa fa-print"></i> Receipt</button>
                            <button type="button" class="btn btn-success" id="print-receipt-preferences-button" onclick="showReceiptPrintPreferences()" title="Print Preferences (Alt+Shift+P)">
                                <i class="fa fa-ellipsis-v" aria-hidden="true"></i>
                            </button>
                        </div>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ADD-PROOF-DOC'] == 1) {?>
                            <button class="btn btn-default" onclick="showProofDialog('POD')">Update POD</button>
                        <?php }?>
                    </div>
                </div>
                <div class="col-md-6 text-left">
                    <button class="btn btn-default" onclick="getCargoDetails('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')"><i class="fa fa-arrow-left"></i> Back</button>
                </div>
            </div>

            <div class="text-center" id="ul-buttons">
                <input type="hidden" id="delivery-action-hidden">
                <input type="hidden" id="delivery-roundoff-hidden">
                <button class="btn btn-success" type="button" id="mk-pay-save-btn" onclick="updateDeliveryDetails('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
')">Delivery</button> &nbsp;
                <button type="button" class="btn btn-default" onclick="hideUnloadAnddeliver()"> <i class="fa fa-arrow-left"></i> Back</button>
            </div>
        </div>
    </div>
</div>
                
<div id="dia-cargo-edit" class="hide dialog-content-page"></div>

<?php echo '<script'; ?>
 id="template-edit-sender" type="text/template">
    <form id='formEditSender' class="form-horizontal" method="post" name="formEditSender" action="" onsubmit="return false" role="form" autocomplete="off">
        <div class="col-lg-12 p_l_n">
            <label for="senderBranch" class="req">From Branch</label>
            <select id="senderBranch" name="senderBranch" class="form-control" >
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['toBranches']->value, 'branch', false, 'bcode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['bcode']->value => $_smarty_tpl->tpl_vars['branch']->value) {
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['bcode']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value;?>
</option>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </select>    
        </div>
        
        <div class="clear_fix_both"></div>
        <div class="col-lg-12 p_l_n <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->custom->skipCustomerMobile) {?>hide<?php }?>">
            <label for="senderMobile" class="req"><?php echo lang('booking_sender_term');?>
 Mobile</label>
            <input type="text" class="form-control" id="senderMobile" name="senderMobile" placeholder="Mobile of <?php echo lang('booking_sender_term');?>
" value="" maxlength="10">      
        </div>
        
        <div class="clear_fix_both"></div>
        
        <div class="col-lg-12 p_l_n">
            <label for="senderName" class="req"><?php echo lang('booking_sender_term');?>
 Name</label>
            <input type="text" class="form-control" id="senderName" name="senderName" placeholder="Name of <?php echo lang('booking_sender_term');?>
" value="" maxlength="100">      
        </div>

        <div class="clear_fix_both"></div>
        <div class="col-md-12 p_l_n">
            <label>Remarks</label>
            <textarea class="form-control" placeholder="Remarks" id="sender-remarks"></textarea>
        </div>
        
        <div class="clear_fix_both"></div>
    </form> 
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state-sender"></div>    
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveSender();">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 id="template-edit-receiver" type="text/template">
    <form id='formEditReceiver' class="form-horizontal" method="post" name="formEditReceiver" action="" onsubmit="return false" role="form" autocomplete="off">
        <div class="col-lg-12 p_l_n">
            <label for="receiverBranch" class="req">To Branch</label>
            <select id="receiverBranch" name="receiverBranch" class="form-control" >
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['toBranches']->value, 'branch', false, 'bcode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['bcode']->value => $_smarty_tpl->tpl_vars['branch']->value) {
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['bcode']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value;?>
</option>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </select>    
        </div>
        
        <div class="clear_fix_both"></div>
        <div class="col-lg-12 p_l_n <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->custom->skipCustomerMobile) {?>hide<?php }?>">
            <label for="receiverMobile" class="req"><?php echo lang('booking_receiver_term');?>
 Mobile</label>
            <input type="text" class="form-control" id="receiverMobile" name="receiverMobile" placeholder="Mobile of <?php echo lang('booking_receiver_term');?>
" value="" maxlength="10">      
        </div>
        
        <div class="clear_fix_both"></div>
        
        <div class="col-lg-12 p_l_n">
            <label for="receiverName" class="req"><?php echo lang('booking_receiver_term');?>
 Name</label>
            <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="Name of <?php echo lang('booking_receiver_term');?>
" value="" maxlength="100">      
        </div>
        
        <div class="clear_fix_both"></div>
        <div class="col-md-12 p_l_n">
            <label>Remarks</label>
            <textarea class="form-control" placeholder="Remarks" id="sender-remarks"></textarea>
        </div>

        <div class="clear_fix_both"></div>
    </form> 
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state-receiver"></div>   
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveReceiver();">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 id="template-edit-items" type="text/template">
    <form id='formEditItems' class="form-horizontal" method="post" name="formEditItems" action="" onsubmit="return false" role="form" autocomplete="off">
        <table width="100%" cellpadding="5" class="table table-bordered ">
            <tr class="success">
                <td align="center" class="bold">  <?php if (in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array("CB"))) {?> <button onclick="addArticleRowEdit();"><i class="fa fa-plus" style="color:#000;"></i> </button> <?php }?></td>
                <td align="center" width="20%" class="bold">Article</td>
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-DESCRIPTION'] != 1) {?>
                <td align="center" width="15%" class="bold">Description</td>
                <?php }?>
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                <td align="center" class="bold" width="20%"><?php echo lang('booking_UOM_label');?>
 <?php if (lang('booking_UOM_label_info')) {?><i class="fa fa-info-circle" data-toggle="tooltip" data-title="<?php echo lang('booking_UOM_label_info');?>
"></i><?php }?></td>
                <?php }?>
                <td align="center" class="bold">Quantity</td>
                <td align="center" class="bold">Rate</td>
                <td align="center" class="bold">
                    L.Charges 
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HANDLING-PER-UOMQTY'] == 1) {?>
                        Per <?php echo lang('booking_UOM_label');?>
 or Qty
                    <?php } elseif ($_smarty_tpl->tpl_vars['action_rights']->value['HANDLING-PER-QTY'] == 1) {?>
                        Per Qty
                    <?php } elseif ($_smarty_tpl->tpl_vars['action_rights']->value['HANDLING-PER-UOM'] == 1) {?>
                        Per <?php echo lang('booking_UOM_label');?>

                    <?php }?>
                </td>
                <td align="center" class="bold">UL.Charges</td>
                <td align="center" class="bold">Total</td>
            </tr>
            <tbody class="items_body_table" ></tbody>
        </table>
        <div class="row" id="edit-charges-panel">
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-HAMALI-CHARGES'] == 1) {?>
            <div class="col-md-2">
                <div>
                    <label for="from_phone">Hamali Charges</label>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" onblur="calculateTotal();" id="edit_hamali_charges" value="0" data-edit-fs="HC" data-mask="inrcurrency">
                    </div>
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-FS-ADDONS'] == 1) {?>
                        <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="edit-fs-addon-checkbox" tabindex="-1" title="Free Service" value="HC"> Free Service</label>
                    <?php }?>
                </div>
            </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-PASS-CHARGES'] == 1) {?>
            <div class="col-md-2">
                <div>
                    <label for="from_phone">Pass Charges</label>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" onblur="calculateTotal();" id="edit_pass_charges" data-mask="inrcurrency" value="0">
                    </div>
                </div>
            </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-DOCKET-CHARGES'] == 1) {?>
            <div class="col-md-2">
                <div>
                    <label for="from_phone">Docket Charges</label>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" onblur="calculateTotal();" id="edit_docket_charges" data-edit-fs="DC" data-mask="inrcurrency" value="0" <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->docketChargeEditFlag) {?>disabled<?php }?>>
                    </div>
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-FS-ADDONS'] == 1) {?>
                        <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="edit-fs-addon-checkbox" tabindex="-1" title="Free Service" value="DC"> Free Service</label>
                    <?php }?>
                </div>
            </div>
            <?php }?>
            <div class="col-md-2 <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-SERVICE-CHARGES'] != 1) {?> hide<?php }?>">
                <div id="service-charge-panel">
                    <label for="from_phone"><?php echo lang('other_charges');?>
</label>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" onblur="calculateTotal();" id="edit_service_charges" data-edit-fs="OC" data-mask="inrcurrency" value="0">
                    </div>
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-FS-ADDONS'] == 1) {?>
                        <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="edit-fs-addon-checkbox" tabindex="-1" title="Free Service" value="OC"> Free Service</label>
                    <?php }?>
                </div>
            </div>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-POD-CHARGES'] == 1) {?>
                <div class="col-md-2">
                    <label for="pod_charges_enable">POD Charges</label>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" onblur="calculateTotal();" id="edit_pod_charges" value="0" data-mask="inrcurrency">
                    </div>
                </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-INSURE-CHARGES'] == 1) {?>
                <div class="col-md-2">
                    <label for="insurance_charges">Insurance Charges</label>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" onblur="calculateTotal();" id="edit_insurance_charges" value="0" data-mask="inrcurrency">
                    </div>
                </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-MACHINE-HANDLING'] == 1) {?>
                <div class="col-md-3">
                    <label class="d-inline" for="machine_handling_charges">Machine Handling Cgs.</label>
                    <span data-toggle="popover" data-content="
                        <table class='table' width='300'>
                            <thead>
                                <tr>
                                    <th>From</th>
                                    <th>To</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['machine_handling_tariff']->value, 'tariff');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['tariff']->value) {
?>
                                <tr>
                                    <td><?php echo $_smarty_tpl->tpl_vars['tariff']->value->fromUnitValue;
echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['tariff']->value->unitCode];?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['tariff']->value->toUnitValue;
echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['tariff']->value->unitCode];?>
</td>
                                    <td align='left'><?php echo inr_format($_smarty_tpl->tpl_vars['tariff']->value->amount);?>
</td>
                                </tr>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </tbody>
                        </table>
                    "><i class="fa fa-info-circle"></i></span>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" onblur="calculateTotal();" id="edit_machine_handling_charges" value="0" data-edit-fs="MC" data-mask="inrcurrency">
                    </div>
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-FS-ADDONS'] == 1) {?>
                        <label class="checkbox font-weight-normal m-0"><input type="checkbox" class="edit-fs-addon-checkbox" tabindex="-1" title="Free Service" value="MC" onchange="calculateTotal()"> Free Service</label>
                    <?php }?>
                </div>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-FOV-CHARGE'] == 1) {?>
                <div class="col-md-2">
                    <label for="edit_fov_charges">FOV Charges</label>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" onblur="calculateTotal();" id="edit_fov_charges" value="0" data-mask="inrcurrency">
                    </div>
                </div>
            <?php }?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargo_setting']->value->bookingModelTag, 'setting', false, 'key', 'name', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['setting']->value) {
?>
                <div class="booking_addons">
                <input type="hidden" class="code-expdl" value="<?php echo $_smarty_tpl->tpl_vars['expd_code']->value;?>
">
                <input type="hidden" class="code-hdlwc" value="<?php echo $_smarty_tpl->tpl_vars['hdlwc_code']->value;?>
">
                    <?php if ($_smarty_tpl->tpl_vars['setting']->value == "EXPDL") {?>
                        <div class="col-md-2 expdl-sec">
                        <input for="slt-exp" type="checkbox" onChange="UpdateSpecialBooking();" class="addons" name="slt-exp" <?php if ($_smarty_tpl->tpl_vars['is_expdl']->value) {?>checked<?php }?> value="EXPDL"> 
                        <label style="display:inline-block" for="slt-exp"><?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['EXPDL']['name'];?>
</label>
                       
                            <div class="input-group">
                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                <input type="text" class="form-control" onblur="calculateTotal();" id="slt-expdl" value="0" data-mask="inrcurrency" disabled>
                            </div>
                        </div>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['setting']->value == "HDLWC") {?>
                        <div class="col-md-2">
                        <input for="slt-hdl" type="checkbox" onChange="UpdateSpecialBooking();" value="HDLWC" class="addons" name="slt-hdl" <?php if ($_smarty_tpl->tpl_vars['is_hdlwc']->value) {?>checked<?php }?>> 
                        <label style="display:inline-block" for="slt-hdl"><?php echo $_smarty_tpl->tpl_vars['cargo_additional']->value['HDLWC']['name'];?>
</label>
                        
                            <div class="input-group">
                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                <input type="text" class="form-control" onblur="calculateTotal();" id="slt-hdlwc" value="0" data-mask="inrcurrency" disabled>
                            </div>
                        </div>
                    <?php }?>
                </div>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </div>
        <div class="clear_fix_both"></div><br>
        <div class="row">
            <div class="col-md-12">
                <textarea class="form-control" placeholder="Remarks" id="items-edit-remarks"></textarea>
            </div>
        </div>
    </form>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state-edit"></div>   
        <div class="align-center alert alert-danger pull-left" style="display:none;" id="edit_article_action_state"></div>
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveItems();">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
<?php echo '</script'; ?>
>
    
<?php echo '<script'; ?>
 id="template-edit-gst" type="text/template">
    <h6 class="bold">Add / Edit GST Amount & Details</h6>    
    <div class="row">
        <div class="col-md-12">
        Check / UnCheck the checkbox for the article want to add / remove GST amount.
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-3">
            <div class="form-group">
                <label for="edit_sender_gstin"><?php echo lang('booking_sender_term');?>
 GSTIN</label>
                <input type="text" name="edit_sender_gstin" class="form-control" id="edit_sender_gstin" placeholder="Sender GST number" maxlength="30">
            </div>           
        </div>
        <div class="col-md-3">
            <div class="form-group">
                <label for="edit_receiver_gstin"><?php echo lang('booking_receiver_term');?>
 GST</label>
                <input type="text" name="edit_receiver_gstin" class="form-control" id="edit_receiver_gstin" placeholder="Receiver GST number" maxlength="30">
            </div>           
        </div>
            </div>  

    <table width="100%" cellpadding="5" class="table table-bordered ">
        <tr class="success">
            <td align="center" class="bold"></td>
            <td align="center" class="bold"><?php echo lang('booking_article_label');?>
</td>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
            <td align="center" class="bold"><?php echo lang('booking_UOM_label');?>
 <?php if (lang('booking_UOM_label_info')) {?><i class="fa fa-info-circle" data-toggle="tooltip" data-title="<?php echo lang('booking_UOM_label_info');?>
"></i><?php }?></td>
            <?php }?>
            <td align="center" class="bold">Quantity</td>
            <td align="center" class="bold">Rate</td>
            <td align="center" class="bold">Freight</td>
        </tr>
        <tbody id="gst_body_table" ></tbody>
        <tfoot>
            <tr>
                <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>
                    <td colspan="2"><label><input type="checkbox" class="add-item-gst" value="<?php echo $_smarty_tpl->tpl_vars['summary']->value->serviceTax;?>
">&nbsp;&nbsp;Include GST</label></td>
                    <td colspan="<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>3<?php } else { ?>2<?php }?>" align="right">GST</td>
                <?php } else { ?>
                    <td colspan="<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>5<?php } else { ?>4<?php }?>" align="right">GST</td>
                <?php }?>
                <td align="right" id="tot-gst-amt">0.00</td>
            </tr>
        </tfoot>
    </table>

    <h6 class="bold">Add / Edit Invoice Details</h6> 

    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th width="55"></th>
                    <th>E-Way Bill Number</th>
                    <th>Invoice Number</th>
                    <th>Invoice Amount</th>
                    <th>Invoice Date</th>
                </tr>
            </thead>
            <tbody id="edit-invoice-list"></tbody>
            <tfoot id="edit-invoice-row-tpl" class="hide">
                <tr class="edit-invoice-row">
                    <td width="55">
                        <a href="javascript:;" onclick="removeInvoiceEditRow(this);" class="btn btn-sm btn-default" title="Remove Invoice"><i class="fa fa-minus"></i></a>
                        <input type="hidden" class="edit-eway-bill-code">
                    </td>
                    <td>
                        <input type="text" class="form-control edit_eway_bill_number" placeholder="E-way bill number" maxlength="20" onchange="checkDuplicateEditEwayBill(this)"/>
                    </td>
                    <td>
                        <input type="text" class="form-control edit_inv_number" placeholder="Invoice numbers" maxlength="20" />
                    </td>
                    <td>
                        <input type="text" class="form-control edit_inv_amount" placeholder="Total Invoice Amount" onblur="calculateTotal()" maxlength="9" data-mask="inrcurrency" />
                    </td>
                    <td>
                        <input type="text" class="form-control edit_inv_date" placeholder="DD-MM-YYYY" readonly />
                    </td>
                </tr>
            </tfoot>
        </table>
        <a href="javascript:;" class="btn btn-sm btn-default" id="tr_add_invoice_btn" title="Add invoice details" onclick="addInvoiceEditRow()"> <i class="fa fa-upload"></i> Add Invoice (s)</a>
    </div>

    <div class="clear_fix_both"></div><br>
    
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state"></div>   
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveGST();">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 id="template-edit-item-row" type="text/template">
    <tr class="article_row">
        <td><a href="javascript:;" onclick="removeArticleRowEdit(this);" class="btn btn-sm btn-default tr_remove" title="Remove"><i class="fa fa-minus"></i></a></td>
        <td class="iarticle"><input type="text" maxlength="80" class="form-control iarticle-inp" placeholder="Select <?php echo lang('booking_article_label');?>
"/></td>
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-DESCRIPTION'] != 1) {?>
        <td class="iarticle-desc"><input type="text" id="article-desc" class="form-control" placeholder="Select <?php echo lang('booking_article_description_label');?>
" data-mask="englishonly"/></td>
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
        <td>
            <div class="row">
                <div class="col-md-5 p_r_n">
                    <input type="text" class="form-control iunitval" value="1" onblur="calculateTotal();">
                </div>
                <div class="col-md-7 p_l_n">
                    <select class="form-control iunit" onchange="calculateTotal();">
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['article_unit']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?> 
                            <option value="<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value;?>
</option> 
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>
                </div>
            </div>
        </td>
        <?php }?>
        <td><input type="text" class="form-control iqty" name="quantity" value="" maxlength="3" onblur="calculateTotal();"> </td>
        <td><input type="text" class="form-control irate" name="rate" value="" maxlength="5" onblur="calculateTotal();"></td>
        <td><input type="text" class="form-control ilcharge" name="lcharges" value="" maxlength="5" onblur="calculateTotal();"></td>
        <td><input type="text" class="form-control iucharge" name="ulcharges" value="" maxlength="5" onblur="calculateTotal();"></td>
        <td><input type="text" class="form-control itotal" name="total" readonly="readonly" value="" maxlength="6" onblur="calculateTotal();">
        <input type="hidden" class="icode" name="code" value="">
        <input type="hidden" class="iicode" name="icode" value="">
        </td>
    </tr>
<?php echo '</script'; ?>
>        

<?php echo '<script'; ?>
 id="template-edit-booking-date" type="text/template">
    <form class="form-horizontal" onsubmit="return false" role="form">
        <div class="row">
            <div class="col-lg-12">
                <div class="form-group">
                    <label for="lr-booked-date" class="req">Booked Date</label>
                    <input type="text" class="form-control" id="lr-booked-date" maxlength="20" placeholder="Booked Date" autocomplete="off" readonly>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="form-group">
                    <label for="lr-bookeddate-remarks">Remarks</label>
                    <textarea class="form-control" placeholder="Remarks" id="lr-bookeddate-remarks" rows="3"></textarea>
                </div>
            </div>  
        </div>
        <div class="clear_fix_both"></div>
    </form> 
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state"></div>   
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveBookingDate();">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 id="template-edit-adjustment" type="text/template">
    <form class="form-horizontal" onsubmit="return false" role="form">
        <div class="row">
            <div class="col-lg-12">
                <div class="form-group">
                    <label for="lr-adjustment-amount" class="req">Adjustment Amount</label>
                    <div class="input-group">
                        <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                        <input type="text" class="form-control" id="lr-adjustment-amount" placeholder="Adjustment Amount" data-mask="allintegers">
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label for="lr-adjustment-remarks" class="req">Remarks</label>
                    <textarea class="form-control" placeholder="Remarks" id="lr-adjustment-remarks" style="resize: vertical;"></textarea>
                </div>
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </form> 
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state"></div>   
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveAdjustmentAmount();">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 id="template-edit-vendor" type="text/template">
    <form id='formEditVendor' class="form-horizontal" method="post" name="formEditVendor" action="" onsubmit="return false" role="form" autocomplete="off">
        <div class="col-lg-12 p_l_n">
            <label for="vendorName" class="req">Vendor</label>
            <select id="vendorName" name="vendorName" class="form-control" >
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vendors']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->companyName;?>
</option>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </select>    
        </div>
        <div class="clear_fix_both"></div>
    </form> 
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state"></div>   
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveVendor();">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
<?php echo '</script'; ?>
>                
<?php echo '<script'; ?>
 id="template-edit-ewaybill" type="text/template">
    <form id='formEditVendor' class="form-horizontal" method="post" name="formEditVendor" action="" onsubmit="return false" role="form" autocomplete="off">
        <div class="col-lg-12 p_l_n">
            <label for="eway_bill_edit" class="req">E-Way Bill</label>
            <input type="text" class="form-control" id="eway_bill_edit" placeholder="E-Way Bill" maxlength="20">
        </div>
        <div class="clear_fix_both"></div>
    </form> 
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state"></div>   
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveEwayBill()">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
<?php echo '</script'; ?>
>                

<div id="return-lr-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideReturnCargo();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="return-lr-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-12 bold pb10">
                Do you want to create new <?php echo lang('lr');?>
 for Return?
            </div>
            <div class="col-md-3 w-auto">
                <div class="form-group">
                    <input type="checkbox" id="return-newbook-cb" class="bsn_switch" data-on-text="Yes" data-off-text="No">
                </div>
            </div>
        </div>
        <div class="row" id="return-book-cont">
            <div class="col-md-12 bold pb10">
                Do you want to ship this <?php echo lang('lr');?>
 to another branch?
            </div>
            <div class="col-md-3 w-auto">
                <div class="form-group">
                    <input type="checkbox" id="return-book-cb" class="bsn_switch" data-on-text="Yes" data-off-text="No">
                </div>
            </div>
            <div class="col-md-7">
                <div class="form-group hide" id="return-lr-branch-cont">
                    <select id="return-lr-branch" class="form-control">
                        <option value="">To Branch</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchesGrouped']->value, 'branches', false, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value => $_smarty_tpl->tpl_vars['branches']->value) {
?>
                            <optgroup label="<?php echo $_smarty_tpl->tpl_vars['station']->value;?>
">
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branch']->value->tag, 'btag');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['btag']->value) {
?>
                                        <?php if (clean_string($_smarty_tpl->tpl_vars['btag']->value->name) == 'godown') {?>
                                            <option value="<?php echo $_smarty_tpl->tpl_vars['branch']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value->name;?>
</option>
                                            <?php break 1;?>
                                        <?php }?>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </optgroup>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>
                    <small class="text-muted"><i class="fa fa-info-circle"></i> Branch tagged with tag "GODOWN" will only be listed</small>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <label>Remarks</label>
                <textarea class="form-control" placeholder="Remarks" id="return-remarks" oninput="remarksLimitHint()" maxlength="120"></textarea>
                <span class="text-danger hide" id="return-remarks-info"><i class="fa fa-info-circle"></i> Remarks too short.</span>
            </div>
            <div class="clear_fix_both"></div><br>
            <div class="col-md-12">
                <div id="return-lr-action-state"></div>
            </div>

            <div class="col-md-12 text-right">
                <button type="button" class="btn btn-success" onclick="saveReturnCargo();">Return</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideReturnCargo();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>

<div id="revert-missing-dialog" style="display: none">
    <div id="revert-missing-panel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group" id="revert-missing-branch-cont">
                    <label for="revert-missing-branch" class="req">Transit branch</label>
                    <select id="revert-missing-branch" class="form-control">
                        <option value="">Select Transit branch</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchesGrouped']->value, 'branches', false, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value => $_smarty_tpl->tpl_vars['branches']->value) {
?>
                            <optgroup label="<?php echo $_smarty_tpl->tpl_vars['station']->value;?>
">
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                    <option value="<?php echo $_smarty_tpl->tpl_vars['branch']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value->name;?>
</option>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </optgroup>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>
                </div>
            </div>
            <div class="col-md-12 hide">
                <div class="form-group">
                    <label>Remarks</label>
                    <textarea class="form-control" placeholder="Remarks" id="revert-missing-remarks"></textarea>
                </div>
            </div>
            <div class="col-md-12">
                <div id="revert-missing-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="revert-missing-panel-btn">
                <button type="button" class="btn btn-success" onclick="saveRevertMissing();">Save</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideRevertMissingDialog();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>   

<div id="edit-transit-dialog" style="display: none">
    <div class="clearfix">
        <b>Change Transit Branch</b>
        <a href="javascript:;" class="pull-right" onclick="hideTransitBranchDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="edit-transit-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group" id="edit-transit-branch-cont">
                    <label for="edit-transit-branch" class="req">Choose new transit branch</label>
                    <select id="edit-transit-branch" class="form-control">
                        <option value="">Choose new transit branch</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchesGrouped']->value, 'branches', false, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value => $_smarty_tpl->tpl_vars['branches']->value) {
?>
                            <optgroup label="<?php echo $_smarty_tpl->tpl_vars['station']->value;?>
">
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                    <option value="<?php echo $_smarty_tpl->tpl_vars['branch']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value->name;?>
</option>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </optgroup>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group" id="edit-transit-branch-cont">
                    <label class="req">Remarks</label>
                    <input class="form-control" placeholder="Remarks" id="edit-transit-remarks"/>
                </div>
            </div>
            <div class="col-md-12">
                <div id="edit-transit-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="edit-transit-panel-btn">
                <button type="button" class="btn btn-success" onclick="saveTransitBranch();">Save</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideTransitBranchDialog();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>

<div id="remove-ogpl-dialog" style="display: none">
    <div class="clearfix">
        <b>Remove <?php echo lang('lr');?>
 from <?php echo lang('ogpl');?>
</b>
        <a href="javascript:;" class="pull-right" onclick="hideRemoveOGPLDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="remove-ogpl-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group" id="remove-ogpl-branch-cont">
                    <label class="req">Remarks</label>
                    <input class="form-control" placeholder="Remarks" id="remove-ogpl-remarks"/>
                </div>
            </div>
            <div class="col-md-12">
                <div id="remove-ogpl-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="remove-ogpl-panel-btn">
                <button type="button" class="btn btn-danger" onclick="saveRemoveOGPL();">Remove</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideRemoveOGPLDialog();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>

<div id="edit-paytype-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideEditPaymentType();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="edit-paytype-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="from_branch">Payment Type</label>
                    <div id="edit-paytype-radios" onchange="onchangePayType();">
                    </div>
                </div>
            </div>
            <div class="col-md-12 hide" id="edit-paytype-vendor-cont">
                <div class="form-group">
                    <label for="edit-paytype-vendor" class="req">Vendor</label>
                    <select id="edit-paytype-vendor" class="form-control" >
                        <option value="">Select Vendor</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vendors']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->companyName;?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>    
                </div>
            </div>
            <div class="col-md-12">
                <div id="edit-paytype-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="edit-paytype-panel-btn">
                <button type="button" class="btn btn-success" onclick="saveEditPaymentType();">Save</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideEditPaymentType();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>

<div id="edit-paymode-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideEditPaymentMode();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="edit-paymode-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="from_branch">Transaction Mode</label>
                    <div id="edit-paymode-radios">
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactions_details']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <span class="radio">
                                <label><input type="radio" name="edit_paymode_radio" value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" onchange="setTransactionModeEdit('detail');getAllInputsEdit();"> <?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</label>
                            </span>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </div>
                </div>
            </div>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CUST-BAL-AMT'] == 1) {?>
                <div class="col-md-12">
                <div id="edit-bk-customer-calculation" class="hide">
                    <div class="col-md-6">
                        <label>Customer Amount</label>
                        <input type="number" class="form-control" id="bk-customer-amount" oninput="getBookingBalanceReturnAmount(this);" placeholder="Customer Amount">
                    </div>
            
                    <div class="col-md-6">
                        <label>Balance Return</label>
                        <input type="number" class="form-control" disabled id="bk-balance-return-amount" placeholder="Balance Return">
                    </div>
                </div>
                </div>
            <?php }?>
            
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-MULTI-PAY-MODE'] != 1) {?>
                <div class="hide" id="edit-upi-mode-panel-detail">
                       <div class="col-md-4">
                                <div class="form-group">
                                    <label for="upi-orgbank-detail">Organization Bank</label>
                                    <select class="form-control" id="upi-orgbank-detail">
                                        <option value="">Select Organization Bank</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="upi-id-detail">UPI ID</label>
            <input type="text" class="form-control" id="upi-id-detail"  <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "UPI") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->upiId != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->upiId : '';?>
"<?php }?> maxlength="250" placeholder="UPI ID" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="upi-details-detail">Ref. #</label>
                                    <input type="text" class="form-control" id="upi-details-detail" <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "UPI") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->referenceCode != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->referenceCode : '';?>
"<?php }?>  placeholder="Ref. #" autocomplete="off">
                                </div>
                            </div>
                </div>
            
                <div class="hide" id="edit-netbanking-mode-panel-detail">
                 
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="netbanking-orgbank-detail">Organization Bank</label>
                                    <select class="form-control" id="netbanking-orgbank-detail">
                                        <option value="">Select Organization Bank</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="netbanking-accholder-detail">Account Holder Name</label>
                                    <input type="text" class="form-control" id="netbanking-accholder-detail" <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "NBK") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->name != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->name : '';?>
"<?php }?>  maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="netbanking-bankname-detail">Bank Name</label>
                                    <input type="text" class="form-control" id="netbanking-bankname-detail" <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "NBK") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->bankName != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->bankName : '';?>
"<?php }?> maxlength="120" placeholder="Bank Name" autocomplete="off">
                                </div>
                                <div id="netbanking-bankname-detail_2" ></div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="netbanking-details-detail">Ref. #</label>
                                    <input type="text" class="form-control" id="netbanking-details-detail" <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "NBK") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->referenceCode != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->bankDetails->referenceCode : '';?>
"<?php }?> placeholder="Ref. #" autocomplete="off">
                                </div>
                            </div>
                    
                </div>
            
                <div class="hide" id="edit-cheque-mode-panel-detail" style = "display: none;">
                  
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="cheque-payer-detail">Payer Details</label>
                                    <input type="text" class="form-control" id="cheque-payer-detail" <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "CHEQUE") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->payerDetails != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->payerDetails : '';?>
"<?php }?> maxlength="250" placeholder="Payer Details" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="cheque-no-detail">Cheque No</label>
                                    <input type="text" class="form-control" id="cheque-no-detail"  <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "CHEQUE") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->payerDetails != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->payerDetails : '';?>
"<?php }?> maxlength="60" placeholder="Cheque No" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="cheque-date-detail">Cheque Date</label>
                                    <input type="text" class="form-control" id="cheque-date-detail"  <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "CHEQUE") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->chequeDate != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->chequeDate : '';?>
"<?php }?> maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="cheque-bankcity-detail">Bank City</label>
                                    <input type="text" class="form-control" id="cheque-bankcity-detail"  <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "CHEQUE") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->bankCity != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->bankCity : '';?>
"<?php }?> maxlength="90" placeholder="Bank City" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="cheque-bankname-detail">Bank Name</label>
                                    <input type="text" class="form-control" id="cheque-bankname-detail"  <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "CHEQUE") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->bankDetails != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->bankDetails : '';?>
"<?php }?> maxlength="120" placeholder="Bank Name" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="cheque-remarks-detail">Remarks</label>
                                    <input type="text" class="form-control" placeholder="Remarks" id="cheque-remarks-detail"  <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->transactionMode->code == "CHEQUE") {?> value = "<?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->remarks != 'NA' ? $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[(count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList))-1]->chequeDetails->remarks : '';?>
"<?php }?> data-mask="englishonly"/>
                                </div>
                         
                    </div>
                </div>
            <?php }?>

            <div class="col-md-12">
                <div id="edit-paymode-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="edit-paymode-panel-btn">
                <input type="hidden" id="edit-paymode-hidden-usercode">
                <button type="button" class="btn btn-success" onclick="saveEditPaymentMode();">Save</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideEditPaymentMode();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>

<div id="dd-handover-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideDDHandoverDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="dd-handover-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="req">Handover Person Name</label>
                    <input type="text" class="form-control" placeholder="Handover Person Name" id="ddhandover-person"/>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="req">Door Delivery Status</label>
                    <select class="form-control" id="dddelivery-status">
                        <option value="">Select Status</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargoremarks']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->cargoStatus->code == 'DRDLY') {?>
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
            <div class="col-md-12">
                <div id="dd-handover-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="dd-handover-panel-btn">
                <button type="button" class="btn btn-success" onclick="saveDDHandover();">Save</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideDDHandoverDialog();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>

<div id="private-mark-dialog" style="display: none; overflow:hidden">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hidePrivateMarkDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <form method="post" action="cargo/edit-save-privatemark" onsubmit="return false">
        <div class="row">
            <div class="col-md-12">
                <label for="edit_private_mark_no" class="req">Private Mark No</label>
                <div class="input-group">
                    <input type="text" class="form-control" name="privatemark" id="edit_private_mark_no">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12"><br>
            <div class="alert fl" id="action-state"></div>
                <div class="align-center alert alert-danger pull-left" style="display:none" id="private_mark_action_state"></div><br>
            <div>
        </div>
        <div class="row">
            <div class="col-md-12 text-right" id="remove-ogpl-panel-btn"><br>
                <button type="button" class="btn btn-success" onclick="savePrivatemark('<?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
');">Save</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hidePrivateMarkDialog();">Cancel</button>&nbsp;
            </div>
        </div>
    </form>
</div>

<div id="lr-activity-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideLRActivityDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div class="clearfix" id="lr-activity" style="padding: 10px 5px;">
    </div>
</div>   


<style>
#edit-charges-panel > [class*="col-"] {
    min-height: 86px;
}
</style>

<?php echo '<script'; ?>
>
var lrdata = <?php echo json_encode($_smarty_tpl->tpl_vars['summary']->value);?>
;
var lr_paid_amount = <?php echo $_smarty_tpl->tpl_vars['summary']->value->paymentAmount;?>
;
var lr_balance = <?php echo $_smarty_tpl->tpl_vars['balance_to_pay']->value;?>
;
var old_service_tax = <?php echo $_smarty_tpl->tpl_vars['summary']->value->serviceTax;?>
;
var lr_handling = <?php echo $_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount;?>
;
var lr_unloading = <?php echo $_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount;?>
;
var cargoTransactionList = <?php echo json_encode($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList);?>
;
var cargoSetting = <?php echo json_encode($_smarty_tpl->tpl_vars['cargo_setting']->value);?>
;
var cargoRemarksList = <?php echo json_encode($_smarty_tpl->tpl_vars['cargoremarks']->value);?>
;
var tax_computed = <?php echo json_encode($_smarty_tpl->tpl_vars['tax_computed']->value);?>
;
var toBranchPaymentTypeList = <?php echo json_encode($_smarty_tpl->tpl_vars['toBranchPaymentTypeList']->value);?>
;
var payTypeConfig = <?php echo json_encode($_smarty_tpl->tpl_vars['pay_type']->value);?>
;
var itemsData = <?php echo json_encode($_smarty_tpl->tpl_vars['items']->value);?>
;
var namespaceCode = <?php echo json_encode($_smarty_tpl->tpl_vars['namespace']->value);?>
;
var bankNamesList = <?php echo json_encode($_smarty_tpl->tpl_vars['bank_names_list']->value);?>
; 
var additionalStatusList = <?php echo json_encode(((object) $_smarty_tpl->tpl_vars['additional_status_list']->value));?>
; 
var addonsMapped = <?php echo json_encode(((object) $_smarty_tpl->tpl_vars['addons_mapped']->value));?>
; 
var login_branch_code = <?php echo json_encode($_smarty_tpl->tpl_vars['login_branch']->value);?>
;
var userData = <?php echo json_encode($_smarty_tpl->tpl_vars['groupusers']->value['loginUser']);?>
;
var unload_flag =<?php echo json_encode($_smarty_tpl->tpl_vars['loading_chagers_setting']->value);?>


var bookingpage = <?php echo json_encode($_smarty_tpl->tpl_vars['onBooked']->value);?>
;
var subTransactionMode = $('#pay-transaction-mode-sub option');
var deliveryAmt = <?php echo $_smarty_tpl->tpl_vars['deliveryAmt']->value;?>
;
var podproofupload = new fileUpload('#pod-proof-fileupload');
if(!proofupload){
    var proofupload = new fileUpload('#proof-fileupload');
}

//languages
var lang = {};
lang.lr = '<?php echo lang('lr');?>
';
//languages end
var addonamount = 0;
$.each(addonsMapped || [], function(key, val) {
    if ($.inArray(key, ['PODCH', 'DMRCH', 'RNDF', 'INSUR', 'ADJSMT', 'MCNHCHBL', 'MCNHCHDL', 'FOVCH', 'CNCTCH']) != -1) {
        addonamount += Number(val['value']);
    }
});

var adhaarValue = $('#podproof-document-type option:selected').val();
if (adhaarValue == 'ADHR') {
    $('#podproof-document-no').attr('maxlength', '12');
} else {
    $('#podproof-document-no').attr('maxlength', '25');
}

$('#podproof-document-type').on('change', function() {
    var selectedValue = $('#podproof-document-type option:selected').val();
    if (selectedValue == 'ADHR') {
        $('#podproof-document-no').attr('maxlength', '12');
    } else {
        $('#podproof-document-no').attr('maxlength', '25');
    }
    $('#podproof-document-no').val('').trigger('change');
});

$('[data-toggle="popover"]').popover({
    placement: 'top',
    html: true,
    trigger: 'hover',
    template: '<div class="popover" style="max-width: max-content"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'
});
$('#cd-on-behalf-user, #delivery-on-behalf-user').select2();
$('[data-toggle="tooltip"]').tooltip({
    html: true
});
$('.bsn_switch').bootstrapSwitch();
$('#return-lr-branch').select2();
$('#edit-transit-branch').select2();
$('#revert-missing-branch').select2()
$('#dd-delivery-status').select2();

$('#delivery-remarks').autocomplete({
    minLength: 0,
    source: _.filter(cargoRemarksList || [], r => r.cargoStatus.code == 'CD').map(r => r.name)
}).focus(function(){
    $(this).autocomplete('search', '');
});

$('#edit-transit-remarks').autocomplete({
    minLength: 0,
    source: [
        'Mistakenly unloaded in branch',
        'Route plan change',
        'Mistakenly loaded',
    ],
    appendTo: '#edit-transit-pannel'
}).focus(function(){
    $(this).autocomplete('search', '');
});

$('#remove-ogpl-remarks').autocomplete({
    minLength: 0,
    source: [
        'Wrongly loaded',
        'Vehicle changed',
        'No vehicle available',
        'No space in vehicle',
    ],
    appendTo: '#remove-ogpl-dialog'
}).focus(function(){
    $(this).autocomplete('search', '');
});

$('#return-newbook-cb').on('switchChange.bootstrapSwitch', function () {
    $('#return-book-cont').toggleClass('hide', this.checked);
});

$('#return-book-cb').on('switchChange.bootstrapSwitch', function () {
    $('#return-lr-branch-cont').toggleClass('hide', !this.checked);
});

// Main
$('#pay-upi-orgbank-main').select2();
$('#pay-netbanking-orgbank-main').select2();
$('#pay-netbanking-bankname-main').autocomplete({
    minLength: 0,
    source: bankNamesList
}).focus(function(){
    $(this).autocomplete('search', '');
});

$('#pay-cheque-bankname-main').autocomplete({
    minLength: 0,
    source: bankNamesList
}).focus(function(){
    $(this).autocomplete('search', '');
});
$('#pay-cheque-date-main').datepicker({
    todayHighlight: true,
    format: 'dd-mm-yyyy',
    autoclose: true,
    changeMonth: true,
    startDate: '-1d',
    endDate:'0d'
});


//detail
$('#upi-orgbank-detail').select2();
    $('#netbanking-orgbank-detail').select2();
    $('#netbanking-bankname-detail').autocomplete({
        minLength: 0,
        source: bankNamesList,
        open: function() {
            $('.ui-autocomplete').css('z-index', 9999).appendTo('body');
        }
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#cheque-bankname-detail').autocomplete({
        minLength: 0,
        source: bankNamesList,
        open: function() {
            $('.ui-autocomplete').css('z-index', 9999).appendTo('body');
        }
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#cheque-date-detail').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-1d',
        endDate:'0d'
    });



// Sub
$('#pay-upi-orgbank-sub').select2();
$('#pay-netbanking-orgbank-sub').select2();
$('#pay-netbanking-bankname-sub').autocomplete({
    minLength: 0,
    source: bankNamesList
}).focus(function(){
    $(this).autocomplete('search', '');
});

$('#pay-cheque-bankname-sub').autocomplete({
    minLength: 0,
    source: bankNamesList
}).focus(function(){
    $(this).autocomplete('search', '');
});
$('#pay-cheque-date-sub').datepicker({
    todayHighlight: true,
    format: 'dd-mm-yyyy',
    autoclose: true,
    changeMonth: true,
    startDate: '-1d',
    endDate:'0d'
});

<?php if ($_REQUEST['onBooked'] == 1 && in_array($_smarty_tpl->tpl_vars['summary']->value->cargoStatus->code,array('CB')) && $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->hubFlag && $_smarty_tpl->tpl_vars['action_rights']->value['INSTANT-LOAD-OGPL'] == 1) {?>
    loadToOGPL();
<?php }?>

$('#pay-transaction-mode-main').on('change', function() {
    var mainMode = $(this).val();
    $('#pay-transaction-mode-sub').html(function () {
        return subTransactionMode.filter(function () {
            return $(this).val() != mainMode;
        });
    }).val($('#pay-transaction-mode-sub option:first').val()).trigger('change');
});

function editItems() {
    $('#dia-cargo-edit').removeClass('hide');
    $('#dia-cargo-edit').dialog({
        autoOpen: true,
        height: 500,
        width: 1100,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    var tmp = $('#template-edit-items').html();
    $('#dia-cargo-edit').html(tmp);
    
    $('#dia-cargo-edit').find('#items-edit-remarks').val('');

    $('#dia-cargo-edit [data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover',
        template: '<div class="popover" style="max-width: max-content"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'
    });
    
    var itmp = $('#template-edit-item-row').html();

    $(lrdata.itemDetails).each(function(k, item){
        var iitem = $(itmp).clone();
        $(iitem).attr('data-code', item.code);
        $(iitem).find('.iarticle').html(item.cargoItem.name);
        $(iitem).find('.iarticle-desc').html(item.cargoItem.description);
        $(iitem).find('.iqty').val(parseFloat(item.itemCount));
        //restrict partial LR edit 
        if(lrdata.additionalAttribute.CARGO_PARTITION_FLAG == 1){
            $(iitem).find('.iqty').prop('disabled', true);
            $(iitem).find('.iunitval').prop('disabled', true);
            $(iitem).find('.iunit').prop('disabled', true);
        }
        $(iitem).find('.irate').val(parseFloat(item.fare));
        $(iitem).find('.iunit').val(item.unit.code);
        $(iitem).find('.iunitval').val(parseFloat(item.unitValue));
        
        
        var uomOrQty = Number(item.unitValue); // UOM value or Qty
        if (isNaN(item.unitValue) || item.unit.code == 'NPPKG') {
            uomOrQty = Number(item.itemCount);
        }
        var loadingCharges = 0;
        var unloadingCharges = 0;
        if (menu_permission['HANDLING-PER-QTY']==1) {
            loadingCharges = parseFloat(item.handlingChargeAmount) / parseFloat(item.itemCount);
            unloadingCharges = parseFloat(item.unloadingChargeAmount) / parseFloat(item.itemCount);
        } else if (menu_permission['HANDLING-PER-UOM']==1) {
            loadingCharges = parseFloat(item.handlingChargeAmount) / parseFloat(item.unitValue);
            unloadingCharges = parseFloat(item.unloadingChargeAmount) / parseFloat(item.unitValue);
        } else if (menu_permission['HANDLING-PER-UOMQTY']==1) {
            loadingCharges = parseFloat(item.handlingChargeAmount) / parseFloat(uomOrQty);
            unloadingCharges = parseFloat(item.unloadingChargeAmount) / parseFloat(uomOrQty);
        } else {
            loadingCharges = parseFloat(item.handlingChargeAmount);
            unloadingCharges = parseFloat(item.unloadingChargeAmount);
        }
        
        $(iitem).find('.ilcharge').val(Number(loadingCharges).toFixed(2));
        $(iitem).find('.iucharge').val(Number(unloadingCharges).toFixed(2));
        $(iitem).find('.icode').val(item.code);
        //$(iitem).find('.iicode').html(item.cargoItem.code);
        
        $('.items_body_table').append(iitem);
    });

    $('#edit_hamali_charges').val(lrdata.hamaliCharge);
    $('#edit_pass_charges').val(lrdata.passCharge);
    $('#edit_docket_charges').val(lrdata.docketCharge);
    $('#edit_service_charges').val(lrdata.serviceCharge);

    $.each(lrdata.cargoAddonsDetails || [], function (i, addon) {
        if (addon.addonsType.code == 'FRECR') {
            var valueList = addonsMapped['FRECR'].valueList;
            $.each(valueList || [], function (i, value) {
                $('#dia-cargo-edit .edit-fs-addon-checkbox[value="' + value + '"]').prop('checked', true);
            });
            return;
        }
        if (addon.addonsType.code == 'PODCH') {
            $('#edit_pod_charges').val(addon.value);
            return;
        }
        if (addon.addonsType.code == 'INSUR') {
            $('#edit_insurance_charges').val(addon.value);
            return;
        }
        if (addon.addonsType.code == 'MCNHCHBL' || addon.addonsType.code == 'MCNHCHDL') {
            $('#edit_machine_handling_charges').val(addon.value);
            return;
        }
        if (addon.addonsType.code == 'FOVCH') {
            $('#edit_fov_charges').val(addon.value);
            return;
        }
    });
    
    if (lrdata.cargoStatus.code == 'CB') {
          addArticleRowEdit();
    }
    calculateTotal();

    $('#dia-cargo-edit .edit-fs-addon-checkbox').on('change', function (e) {
        $('#dia-cargo-edit [data-edit-fs="' + this.value + '"]').prop('disabled', this.checked).val(0).trigger('change');
        calculateTotal();
    });
}

function addArticleRowEdit() {
    var masterItems = [];
    $.each(itemsData || [], function(key, art) {
        var ti = {};
        ti.label = art.name;
        ti.value = key;
        ti.data = art;
        masterItems.push(ti);
    });

    var itmp = $('#template-edit-item-row').html();
    var iitem = $(itmp).clone();
    $('.items_body_table').append(iitem);
    $(iitem).find('.iarticle-inp').autocomplete({
        minLength: 0,
        source: masterItems,
        select: function(event, ui) {
            $(this).data('selectedIndex', ui.item.value);

            var data = ui.item.data;
            if (!data) return;

            var $article_row = $(this).closest('.article_row');
            $article_row.find('.iarticle-inp').val(data.name);
            $article_row.find('#article-desc').val('')
                .autocomplete({
                    minLength: 0,
                    source: data.description || []
                }).on('focus', function () {
                    $(this).autocomplete('search', '');
                });
            $article_row.find('#code').val(data.code);
            $article_row.find('.iqty').val(1);
            $article_row.find('.irate').val(data.defaultRate);
            $article_row.find('.iunit').val('NPPKG');
            $article_row.find('.iunitval').val(1);
            $article_row.find('.ilcharge').val(data.defaultHandlingRate);
            $article_row.find('.iucharge').val(0);
            calculateTotal();
            if ($article_row.is(':last-child')) {
                addArticleRowEdit();
            }
            return false;
        },
        change: function(event, ui) {
            var $article_row = $(this).closest('.article_row');
            if (!ui.item && !cargoSetting.allowNewArticle) {
                notice('new article is not allowed');
                $(this).val(''); 
                $(this).data('selectedIndex',"");
                $article_row.find('#article-desc').val('');
                $article_row.find('#code').val("");
                $article_row.find('.iqty').val(1);
                $article_row.find('.irate').val(0);
                $article_row.find('.iunit').val('NPPKG');
                $article_row.find('.iunitval').val(1);
                $article_row.find('.ilcharge').val(0);
                $article_row.find('.iucharge').val(0);
                $article_row.find('.itotal').val(0);

            }else{
                addArticleRowEdit();
            }
        }
    }).focus(function(){
        $(this).autocomplete('search', '');
    });
}

function removeArticleRowEdit(btn) {
    var count = $('#formEditItems .article_row:not([data-deleted=1])').length;
    if(count > 1){
        $(btn).closest('.article_row').attr('data-deleted', 1).hide();
    }
}

function calculateTotal() {
    $('#formEditItems .article_row:not([data-deleted=1])').each(function() {        
        var qty = $(this).find('.iqty').val() || 1;
        var price = $(this).find('.irate').val() || 0;
        var handling = $(this).find('.ilcharge').val() || 0;
        var unloading = $(this).find('.iucharge').val() || 0;
        
        var unitValue = $(this).find('.iunitval').val();
        var unit = $(this).find('.iunit').val();

        var uomOrQty = unitValue; // UOM value or Qty
        if (isNaN(unitValue) || unit == 'NPPKG') {
            unitValue = 1;
            uomOrQty = qty;
        }

        var freight = parseFloat(price) * parseFloat(uomOrQty);
        var loadingCharges = Math.ceil(parseFloat(handling));
        var unloadingCharges = Math.ceil(parseFloat(unloading));
        if (menu_permission['HANDLING-PER-UOMQTY'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseInt(uomOrQty));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(uomOrQty));
        } else if (menu_permission['HANDLING-PER-QTY'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseInt(qty));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(qty));
        } else if (menu_permission['HANDLING-PER-UOM'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseFloat(unitValue));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseFloat(unitValue));
        }

        var total = 0;
        if (parseInt(qty) > 0) {
            total = parseFloat(freight) + parseFloat(loadingCharges) + parseFloat(unloadingCharges);
        }
        $(this).find('.itotal').val(Number(total).toFixed(2));
    });
}

function saveItems() { 
    var fdata = {}, err = 0;
    fdata.lr = $.extend(true, {}, lrdata);
    var totalFreightAmount = 0;
    var netAmount = 0;
    var totalHandlingAmount = 0;
    var totalUnloadHandlingAmount = 0;

    fdata.lr.itemDetails = _.keyBy(fdata.lr.itemDetails, 'code');
    var itemDetails = [];

    $('#formEditItems .article_row').each(function(i) {
        if( Number( $(this).find('.iqty').val() ) >0 ) {
            var code = $(this).data('code') || '';
            var item = fdata.lr.itemDetails[code] ? fdata.lr.itemDetails[code] : {};
            var description = $(this).find('#article-desc').val();
             var gstflg =false;
            if (code == '') {
                var autocomplete = $(this).find('.iarticle-inp').data('uiAutocomplete') || {};
                item.cargoItem = {};
                item.cargoItem.code = autocomplete.selectedItem ? autocomplete.selectedItem.data.code : '';
                item.cargoItem.name = $(this).find('.iarticle-inp').val();
                item.cargoItem.description = [ description ];
                item.actualUnitValue = 0;
                var gstDetails = _.find(itemsData, (o) => o.code == item.cargoItem.code) || {};
                gstflg =gstDetails.gstExemptedFlag;
            }
            item.serviceTax = 0;

            item.activeFlag = $(this).is('[data-deleted=1]') ? 0 : 1;
            item.code = code;
            item.fare = $(this).find('.irate').val() || 0;
            item.itemCount = $(this).find('.iqty').val() || 1;
            item.handlingChargeAmount = $(this).find('.ilcharge').val() || 0;
            item.unloadingChargeAmount = $(this).find('.iucharge').val() || 0;
            item.unit = {};
            item.unit.code = $(this).find('.iunit').val();
            item.unitValue = $(this).find('.iunitval').val();
            
            var uomOrQty = item.unitValue; // UOM value or Qty
            if (isNaN(item.unitValue) || item.unit.code == 'NPPKG') {
                item.unitValue = 1;
                uomOrQty = item.itemCount;
            }

            if (item.activeFlag) {
                if (menu_permission['HANDLING-PER-UOMQTY'] == 1) {
                    item.handlingChargeAmount = Math.ceil(parseFloat(item.handlingChargeAmount) * parseFloat(uomOrQty));
                    item.unloadingChargeAmount = Math.ceil(parseFloat(item.unloadingChargeAmount) * parseFloat(uomOrQty));
                } else if (menu_permission['HANDLING-PER-QTY'] == 1) {
                    item.handlingChargeAmount = Math.ceil(parseFloat(item.handlingChargeAmount) * parseInt(item.itemCount));
                    item.unloadingChargeAmount = Math.ceil(parseFloat(item.unloadingChargeAmount) * parseInt(item.itemCount));
                } else if (menu_permission['HANDLING-PER-UOM'] == 1) {
                    item.handlingChargeAmount = Math.ceil(parseFloat(item.handlingChargeAmount) * parseFloat(item.unitValue));
                    item.unloadingChargeAmount = Math.ceil(parseFloat(item.unloadingChargeAmount) * parseFloat(item.unitValue));
                }

                var freight = parseFloat(item.fare) * parseFloat(uomOrQty);
                totalFreightAmount += freight;
                totalHandlingAmount += Number(item.handlingChargeAmount);
                totalUnloadHandlingAmount += Number(item.unloadingChargeAmount);
                if(gstflg){
                    item.serviceTax = 0;
                }else{
                    var serviceTax = parseFloat(freight) * cargoSetting.serviceTaxPercentage / 100;
                    item.serviceTax = cargoSetting.lrGstTaxComputeType == 'FRT' ? Math.ceil(serviceTax) : 0;
                    
                }
                netAmount += freight+Number(item.handlingChargeAmount)+Number(item.unloadingChargeAmount);
            }
            itemDetails.push(item);
        }
    });

    $('.inp_error').removeClass('inp_error');
    var error = 0;

    $.each(itemDetails, function(index, obj) {

        var row = $('#formEditItems .article_row').eq(index);
        if (row.find('.iarticle-inp').val() == '') {
            row.find('.iarticle-inp').addClass('inp_error');
            error++;
        }else{
            row.find('.iarticle-inp').removeClass('inp_error');
        }

        if(row.find('#article-desc').val() ==''){
            row.find('#article-desc').addClass('inp_error');
            error++;
        }else{
            row.find('#article-desc').removeClass('inp_error');
        }

    });

    if (error > 0) {
        $('#edit_article_action_state').removeClass('alert-success hide').addClass('alert alert-danger');
        $('#edit_article_action_state').html('Please enter/select the values in the field that are marked in red');
        $('#edit_article_action_state').show();
        return false;
    } else {
        $('#edit_article_action_state').html('');
        $('#edit_article_action_state').hide();
    }

    fdata.lr.itemDetails = itemDetails;

    if (fdata.lr.itemDetails.length == 0) {
        $('#action-state').addClass('alert').addClass('alert-danger').html('Please add atleast one article');
        return false;
    }

    var hamaliCharge = $.trim($('#edit_hamali_charges').val());
    if (isNaN(hamaliCharge) || Number(lrdata.hamaliCharge) < 0) {
        $('#edit_hamali_charges').addClass('inp_error');
        err++;
    } else if(hamaliCharge != '' && Number(hamaliCharge) >= 0) {
        fdata.lr.hamaliCharge = hamaliCharge;
        netAmount += Number(hamaliCharge);
    }

    var passCharge = $.trim($('#edit_pass_charges').val());
    if (isNaN(passCharge) || Number(lrdata.passCharge) < 0) {
        $('#edit_pass_charges').addClass('inp_error');
        err++;
    } else if(passCharge != '' && Number(passCharge) >= 0) {
        fdata.lr.passCharge = passCharge;
        netAmount += Number(passCharge);
    }

    var docketCharge = $.trim($('#edit_docket_charges').val());
    if (isNaN(docketCharge) || Number(lrdata.docketCharge) < 0) {
        $('#edit_docket_charges').addClass('inp_error');
        err++;
    } else if(docketCharge != '' && Number(docketCharge) >= 0) {
        fdata.lr.docketCharge = docketCharge;
        netAmount += Number(docketCharge);
    }

    var serviceCharge = $.trim($('#edit_service_charges').val());
    if (isNaN(serviceCharge) || Number(lrdata.serviceCharge) < 0) {
        $('#edit_service_charges').addClass('inp_error');
        err++;
    } else if(serviceCharge != '' && Number(serviceCharge) >= 0) {
        fdata.lr.serviceCharge = serviceCharge;
        netAmount += Number(serviceCharge);
    }
    
    if (addonsMapped['EWBL']) {
        var ewaybill = addonsMapped['EWBL'];
        delete addonsMapped['EWBL'];
    }

    var cargoAddonsDetails = $.extend(true, {}, addonsMapped);

    var freeServiceAddon = $('.edit-fs-addon-checkbox:checked').map((i, cb) => cb.value).get();
    var valueList = addonsMapped['FRECR'] ? addonsMapped['FRECR'].valueList: [];
    valueList = _.union(valueList, freeServiceAddon);
    if (totalFreightAmount > 0) {
        valueList = _.filter(valueList, c => c != 'FR');
    }
    if (totalHandlingAmount > 0) {
        valueList = _.filter(valueList, c => c != 'LC');
    }
    if (valueList.length) {
        cargoAddonsDetails['FRECR'] = cargoAddonsDetails['FRECR'] || {};
        cargoAddonsDetails['FRECR'].addonsType = {};
        cargoAddonsDetails['FRECR'].addonsType.code = 'FRECR';
        cargoAddonsDetails['FRECR'].value = valueList.join(',');
    }

    var podCharge = $.trim($('#edit_pod_charges').val());
    if (isNaN(podCharge) || Number(podCharge) < 0) {
        $('#edit_pod_charges').addClass('inp_error');
        err++;
    } else if(podCharge != '' && Number(podCharge) >= 0) {
        cargoAddonsDetails['PODCH'] = cargoAddonsDetails['PODCH'] || {};
        cargoAddonsDetails['PODCH'].addonsType = {};
        cargoAddonsDetails['PODCH'].addonsType.code = 'PODCH';
        cargoAddonsDetails['PODCH'].value = podCharge;
        netAmount += Number(podCharge);
    }

    var insuranceCharges = $.trim($('#edit_insurance_charges').val());
    if (isNaN(insuranceCharges) || Number(insuranceCharges) < 0) {
        $('#edit_insurance_charges').addClass('inp_error');
        err++;
    } else if(insuranceCharges != '' && Number(insuranceCharges) >= 0) {
        cargoAddonsDetails['INSUR'] = cargoAddonsDetails['INSUR'] || {};
        cargoAddonsDetails['INSUR'].addonsType = {};
        cargoAddonsDetails['INSUR'].addonsType.code = 'INSUR';
        cargoAddonsDetails['INSUR'].value = insuranceCharges;
        netAmount += Number(insuranceCharges);
    }

    var machineHandlingCharges = $.trim($('#edit_machine_handling_charges').val());
    if (isNaN(machineHandlingCharges) || Number(machineHandlingCharges) < 0) {
        $('#edit_machine_handling_charges').addClass('inp_error');
        err++;
    } else if(machineHandlingCharges != '' && Number(machineHandlingCharges) >= 0) {
        cargoAddonsDetails['MCNHCHBL'] = cargoAddonsDetails['MCNHCHBL'] || {};
        cargoAddonsDetails['MCNHCHBL'].addonsType = {};
        cargoAddonsDetails['MCNHCHBL'].addonsType.code = 'MCNHCHBL';
        cargoAddonsDetails['MCNHCHBL'].value = machineHandlingCharges;
        netAmount += Number(machineHandlingCharges);
    }

    var fovCharges = $.trim($('#edit_fov_charges').val());
    if (isNaN(fovCharges) || Number(fovCharges) < 0) {
        $('#edit_fov_charges').addClass('inp_error');
        err++;
    } else if(fovCharges != '' && Number(fovCharges) >= 0) {
        cargoAddonsDetails['FOVCH'] = cargoAddonsDetails['FOVCH'] || {};
        cargoAddonsDetails['FOVCH'].addonsType = {};
        cargoAddonsDetails['FOVCH'].addonsType.code = 'FOVCH';
        cargoAddonsDetails['FOVCH'].value = fovCharges;
        netAmount += Number(fovCharges);
    }

    fdata.lr.cargoAddonsDetails = Object.values(cargoAddonsDetails);
    if (ewaybill) {
        $.merge(fdata.lr.cargoAddonsDetails, ewaybill);
    }

    netAmount += lrdata.pickupHandlingAmount+lrdata.deliveryHandlingAmount
    $.each(addonsMapped || [], function(key, val) {
        if ($.inArray(key, ['DMRCH', 'RNDF', 'ADJSMT']) != -1) {
            netAmount += Number(val['value']);
        }
    });
    
    var computeGST = cargoSetting.lrGstTaxComputeType == 'FRT' ? totalFreightAmount : netAmount;
    if(computeGST > cargoSetting.minServiceTax && !lrHasRCMBasedGST()) {
        var serviceTax =0;
        $.each(fdata.lr.itemDetails || [], function (i, item) {
          serviceTax += item.serviceTax;
        });
        fdata.lr.serviceTax = serviceTax;
    } else {
        fdata.lr.serviceTax = 0;
        $.each(fdata.lr.itemDetails || [], function (i, item) {
            item.serviceTax = 0;
        });
    }
    fdata.lr.remarks = [];

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#items-edit-remarks').val().trim();
    remarks.cargoStatusCode = 'CB';
    fdata.lr.remarks.push(remarks);
console.log(fdata);
    if (err) {
        $('#action-state-edit').removeClass('alert-success hide').addClass('alert alert-danger');
        $('#action-state-edit').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    
    $('#form-bttons').hide();
    $('#action-state-edit').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-save-cargo",
        data: fdata,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state-edit').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    cancelEditDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#action-state-edit').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
    ga_track_event(''+lang.lr+' Details', 'Edit Articles', '');
}


function editSender() {
    $('#dia-cargo-edit').removeClass('hide');
    $('#dia-cargo-edit').dialog({
        autoOpen: true,
        height: 400,
        width: 450,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    var tmp = $('#template-edit-sender').html();
    $('#dia-cargo-edit').html(tmp);    
    $('#senderBranch').val(lrdata.fromOrganization.code+'|'+lrdata.fromStation.code);
    $('#senderMobile').val(lrdata.fromCustomer.mobileNumber);
    $('#senderName').val(lrdata.fromCustomer.name);    
    $('#senderMobile').select();
}

function saveSender() {
    $('#senderMobile, #senderName').removeClass('inp_error');
    var data = {};
    data.fromBranch = $('#senderBranch').val();
    data.mobile = $.trim( $('#senderMobile').val() );
    data.name = $.trim( $('#senderName').val() );
    
    if(data.mobile=="") {
        $('#senderMobile').addClass('inp_error');
        $('#senderMobile').focus();
        return; 
    } else if(parseInt(data.mobile)<=0) {
        $('#senderMobile').addClass('inp_error');
        $('#senderMobile').focus();
        return; 
    } else if(isNaN(data.mobile)) {
        $('#senderMobile').addClass('inp_error');
        $('#senderMobile').focus();
        return; 
    }
    
    if(data.name=="") {
        $('#senderName').addClass('inp_error');
        $('#senderName').focus();
        return; 
    } 
    
    var fdata = {};
    fdata.lr = lrdata;
    fdata.lr.fromOrganization.code = data.fromBranch.split('|')[0];
    fdata.lr.fromStation.code = data.fromBranch.split('|')[1];
    fdata.lr.fromCustomer.mobileNumber = data.mobile;
    fdata.lr.fromCustomer.name = data.name;
    fdata.lr.fromCustomer.code = '';
    
    var remarks = {};
    remarks.code = '';
    remarks.name = $('#sender-remarks').val().trim();
    remarks.cargoStatusCode = 'CB';
    fdata.lr.remarks.push(remarks);

    $('#form-bttons').hide();
    $('#action-state-sender').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-save-cargo",
        data: fdata,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state-sender').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    cancelEditDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#action-state-sender').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
    ga_track_event(''+lang.lr+' Details', 'Edit Consignor', '');
}

function editReceiver() {
    $('#dia-cargo-edit').removeClass('hide');
    $('#dia-cargo-edit').dialog({
        autoOpen: true,
        height: 400,
        width: 450,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    var tmp = $('#template-edit-receiver').html();
    $('#dia-cargo-edit').html(tmp);    
    $('#receiverBranch').val(lrdata.toOrganization.code+'|'+lrdata.toStation.code);
    $('#receiverMobile').val(lrdata.toCustomer.mobileNumber);
    $('#receiverName').val(lrdata.toCustomer.name);    
    $('#receiverMobile').select();
}

function saveReceiver() {
    $('#receiverMobile, #receiverName').removeClass('inp_error');
    var data = {};
    
    data.receiverBranch= toData = $.trim( $('#receiverBranch').val() );
    receiverAria = $.trim($('#receiverBranch option:selected').text() );
    data.mobile = $.trim( $('#receiverMobile').val() );
    data.name = $.trim( $('#receiverName').val() );
    if(data.mobile=="") {
        $('#receiverMobile').addClass('inp_error');
        $('#receiverMobile').focus();
        return; 
    } else if(parseInt(data.mobile)<=0) {
        $('#receiverMobile').addClass('inp_error');
        $('#receiverMobile').focus();
        return; 
    } else if(isNaN(data.mobile)) {
        $('#receiverMobile').addClass('inp_error');
        $('#receiverMobile').focus();
        return; 
    }
    
    if(data.name=="") {
        $('#receiverName').addClass('inp_error');
        $('#receiverName').focus();
        return; 
    } 
    
    var fdata = {};
    fdata.lr = lrdata;
    fdata.lr.toOrganization.code = data.receiverBranch.split('|')[0];
    fdata.lr.toOrganization.name = receiverAria.split('-')[0];
    fdata.lr.toStation.code = data.receiverBranch.split('|')[1];
    fdata.lr.toStation.name = receiverAria.split('-')[1];
    fdata.lr.toCustomer.mobileNumber = data.mobile;
    fdata.lr.toCustomer.name = data.name;
    fdata.lr.toCustomer.code = '';
    
    // console.log(receiverAria);
    // console.log(data.receiverBranch); 
    var remarks = {};
    remarks.code = '';
    remarks.name = $('#sender-remarks').val().trim();
    remarks.cargoStatusCode = 'CB';
    fdata.lr.remarks.push(remarks);

    $('#form-bttons').hide();
    $('#action-state-receiver').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-save-cargo",
        data: fdata,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state-receiver').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    cancelEditDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#action-state-receiver').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
    ga_track_event(''+lang.lr+' Details', 'Edit Consignee', '');
}

function cancelEditDialog() {
    $('#dia-cargo-edit').dialog('destroy');
    $('#dia-cargo-edit').hide();
    $('#dia-cargo-edit').html('');
}

function addUnloadingCharges() {
    $('#lr-panel').addClass('hide');
    $('#unloading-panel').removeClass('hide');
}
function hideUnloading() {
    $('#lr-panel').removeClass('hide');
    $('#unloading-panel').addClass('hide');
}

function calculateUnloadingAmounts() {
    var ut = 0
    $('.unloadingarticle').each(function(){
        ut = ut + parseFloat( $(this).val() );
    });
    
    $('#unloading-total').val(parseFloat(ut));
}

function calcPaymentUnloadingAmounts() {
    var ut = 0
    $('.payment-unloadingarticle').each(function(){
        ut = ut + parseFloat( $(this).val() );
    });
    
    $('#payment-unloading-total').val(parseFloat(ut));
}

function saveCargoUnloadingCharge(code) {
    $('.unloadingarticle').removeClass('inp_error');
    
    var data = {};
    data.code = code;
    
    var articles = [];
    $('.unloadingarticle').each(function(){
        if(Number( $(this).val() ) > 0) {
            var article = {};
            article.code = $(this).attr('data-code');
            article.unloadingChargeAmount = $(this).val();
            
            articles.push(article);
        }        
    });
    data.itemDetails = articles;    
    
    if(articles.length<=0) {
        $('#ul-action-state').addClass('alert').addClass('alert-danger').html('Please enter the amount for atleaset one article');
        return; 
    } 
    
    $('#ul-buttons').hide();
    $('#ul-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-unloading-charges",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#ul-action-state').addClass('alert').addClass('alert-success').html('Unloading charges added successfully');
                window.setTimeout(function () {
                    getCargoDetails(code);
                }, 3000);
            } else {
                $('#ui-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#ul-buttons').show();
            }
        }
    });
    
    ga_track_event(''+lang.lr+' Details', 'Add Unloading Charges', '');
}

function savePaymentUnloadingCharge(code) {
    $('.payment-unloadingarticle').removeClass('inp_error');
    
    var data = {};
    data.code = code;
    
    var articles = [];
    $('.payment-unloadingarticle').each(function(){
        if(Number( $(this).val() ) > 0) {
            var article = {};
            article.code = $(this).attr('data-code');
            article.unloadingChargeAmount = $(this).val();
            
            articles.push(article);
        }        
    });
    data.itemDetails = articles;    
    
    if(articles.length<=0) {
        $('#ul-action-state').addClass('alert').addClass('alert-danger').html('Please enter the amount for atleaset one article');
        return; 
    } 
    
    $('#pay-deliver-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $('#mk-pay-save-btn').attr('disabled', true);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-unloading-charges",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#pay-deliver-action-state').addClass('alert').addClass('alert-success').html('Unloading charges added successfully');
            } else {
                $('#pay-deliver-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                return;
            }
            $('#mk-pay-save-btn').attr('disabled', false);
            if($('#make-delivery-cb').is(':checked')) {
                saveDeliveryStatus(code);
            } else {
                window.setTimeout(function () {
                    getCargoDetails(code);
                }, 3000);
            }
        }
    });  
    ga_track_event(''+lang.lr+' Details', 'Add Unloading Charges', '');  
}

function revertCargoPayment() {
    $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html('');
    $('#cd-btn-panel').hide();
    $('#cd-action-panel').removeClass('hidden');
    $('#cd-revert-panel').removeClass('hidden');
    $('#revert_amount').focus();
}

function hideRevert() {
    $('#cd-btn-panel').show();
    $('#cd-action-panel').addClass('hidden');
    $('#cd-revert-panel').addClass('hidden');
}

function hidePayment() {
    $('#cd-btn-panel').show();
    $('#cd-action-panel').addClass('hidden');
    $('#cd-payment-panel').addClass('hidden');
}

function saveCargoPayment(code) {
    $('#payment_amount, #pay-transaction-mode-main').removeClass('inp_error');
    var data = {};
    data.code = code;
    data.amount = $.trim( $('#payment_amount').val());
    data.offlineUserCode = $('#cd-on-behalf-user').val();
    data.transactionMode = {};
    data.transactionMode.code = $.trim( $('#pay-transaction-mode-main').val() );
    
    if(data.amount=="") {
       $('#payment_amount').addClass('inp_error');
       $('#payment_amount').focus();
       return; 
    } else if(Number(data.amount)<=0) {
        $('#payment_amount').addClass('inp_error');
        $('#payment_amount').focus();
        return; 
    } else if(isNaN(data.amount)) {
        $('#payment_amount').addClass('inp_error');
        $('#payment_amount').focus();
        return; 
    } else if(Number(data.amount) > Number(lr_balance)) {
        $('#payment_amount').addClass('inp_error');
        alert('Payment amount should not exceed balance amount');
        $('#payment_amount').select();
        return;
    }

    if (menu_permission['CGO-ONBEHF-PAY'] == 1) {
        if  (!data.offlineUserCode) {
            $('#cd-on-behalf-user').addClass('inp_error');
            return; 
        }
    }

    if (data.transactionMode.code == '') {
        $('#pay-transaction-mode-main').addClass('inp_error');
        $('#pay-transaction-mode-main').focus();
        return; 
    }

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#delivery-remarks').val().trim();
    remarks.cargoStatusCode = data.state;

    var otpNumber = $('#delivery-otp').removeClass('inp_error').val();

    var overrideOtp = $('#deliver-without-otp-cb').is(':checked');
    if (overrideOtp) {
        otpNumber = 'OVERRIDE';

        $('#delivery-remarks').removeClass('inp_error');
        if (!remarks.name) {
            $('#delivery-remarks').addClass('inp_error');
            $('#delivery-remarks').focus();
            return false;
        }
    }
    
    if ($('#make-delivery-cb').is(':checked') && cargoSetting.otpValidateDeliveryFlag && otpNumber == '') {
        $('#delivery-otp').addClass('inp_error');
        $('#delivery-otp').focus();
        return;
    }

    if ($('#make-delivery-cb').is(':checked')) {
        let deliveryOnbehalf = $('#delivery-on-behalf-user').val();
        if (menu_permission['CARGO-ONBEHALF-BOOKING'] == 1) {
            if  (!deliveryOnbehalf) {
                $('#delivery-on-behalf-user').addClass('inp_error');
                return false;
            }
        }
    }
    
    $('#pay-deliver-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $('#mk-pay-save-btn').attr('disabled', true);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/add-payment",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#pay-deliver-action-state').addClass('alert').addClass('alert-success').html('Your payment has been added');
            } else {
                $('#pay-deliver-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                return;
            }
            $('#mk-pay-save-btn').attr('disabled', false);
            if($('#add-unload-cb').is(':checked')) {
                savePaymentUnloadingCharge(code);
            } else if($('#make-delivery-cb').is(':checked')) {
                saveDeliveryStatus(code);
            } else {
                window.setTimeout(function () {
                    getCargoDetails(code);
                }, 3000);
            }
        }
    });
    ga_track_event(''+lang.lr+' Details', 'Make Payment', '');
}

function saveCargoRevertPayment(code) {
    $('#revert_amount').removeClass('inp_error');
    var data = {};
    data.code = code;
    data.amount = $.trim( $('#revert_amount').val() );
    data.remarks = $.trim( $('#revert-lr-remarks').val() );
    data.customerTdsTaxAmount = lrdata.computed.customerTdsTaxAmount;
    
    if(data.amount=="") {
        $('#revert_amount').addClass('inp_error');
        $('#revert_amount').focus();
        return; 
    } else if(parseInt(data.amount)<=0) {
        $('#revert_amount').addClass('inp_error');
        $('#revert_amount').focus();
        return; 
    } else if(isNaN(data.amount)) {
        $('#revert_amount').addClass('inp_error');
        $('#revert_amount').focus();
        return; 
    } else if(Number(data.amount) > Number(lr_paid_amount)) {
        $('#revert_amount').addClass('inp_error');
        alert('Revert amount should not exceed paid amount');
        $('#revert_amount').select();
        return;
    } else if (data.remarks == '') {
        $('#revert-lr-remarks').addClass('inp_error');
        $('#revert-lr-remarks').focus();
        return; 
    }
    
    $('#cd-revert-panel-btn').hide();
    $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/revert-payment",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#cd-action-state').addClass('alert').addClass('alert-success').html('Payment has been reverted');
                window.setTimeout(function () {
                    getCargoDetails(code);
                }, 3000);
            } else {
                $('#cd-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#cd-revert-panel-btn').show();
            }
        }
    });
    ga_track_event(''+lang.lr+' Details', 'Revert Payment', '');
}

function showCancelCargo(code, paid) {
    // if(Number(paid)>0 || Number(lr_paid_amount)>0) {
    //     $('#cd-action-state').addClass('alert').addClass('alert-danger').html('Please revert the paid amount to cancel.');
    //     return false;
    // }
    
    $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html('');
    $('#cd-btn-panel').hide();
    $('#cancel-action-panel').removeClass('hidden');
    $('#lr-cancel-panel-btn').removeClass('hidden');
    $('#lr-cancel-remarks').val('').focus();
}

function hideCancelRemarks() {
    $('#cd-btn-panel').show();
    $('#cancel-action-panel').addClass('hidden');
}

function cancelCargo(code, paid) {
    
    if(confirm('Are you sure, do you want to cancel this booking?')) {
        $('#cd-btn-panel').hide();
        $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
        var data = {};
        data.state = 'CA';
        data.code = code;
        data.remarks = [];
        data.bookedAt = lrdata.bookedAt;
        data.fromStationCode = lrdata.fromOrganization.station.code;
        data.revertAmount = paid;

        var remarks = {};
        remarks.code = '';
        remarks.name = $('#lr-cancel-remarks').val().trim();
        remarks.cargoStatusCode = data.state;
        data.remarks.push(remarks);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/cancel-cargo",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#cd-action-state').addClass('alert').addClass('alert-success').html('Cargo has been cancelled');
                    window.setTimeout(function () {
                        closeCargoDetailsDialog();
                    }, 3000);
                } else {
                    $('#cd-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#cd-btn-panel').show();
                }
            }
        });
        ga_track_event(''+lang.lr+' Details', 'Set Cancel', '');
    }
}

function showmissingCargo() {
    $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html('');
    $('#cd-btn-panel').hide();
    $('#missing-action-panel').removeClass('hidden');
    $('#lr-missing-panel-btn').removeClass('hidden');
    $('#lr-missing-remarks').val('').focus();
}

function hidemissingRemarks() {
    $('#cd-btn-panel').show();
    $('#missing-action-panel').addClass('hidden');
}

function missingCargo(code, paid) {
    
    if(confirm('Are you sure, do you want to change the status of this booking?')) {
        $('#cd-btn-panel').hide();
        $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
        var data = {};
        data.state = 'CMS';
        data.code = code;
        data.remarks = [];

        var remarks = {};
        remarks.code = '';
        remarks.name = $('#lr-missing-remarks').val().trim();
        remarks.cargoStatusCode = data.state;
        data.remarks.push(remarks);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/missing-cargo",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#cd-action-state').addClass('alert').addClass('alert-success').html('Cargo status changed to Missing');
                    window.setTimeout(function () {
                        hidemissingRemarks();
                        getCargoDetails(code);
                    }, 3000);
                } else {
                    $('#cd-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#cd-btn-panel').show();
                }
            }
        });
        ga_track_event(''+lang.lr+' Details', 'Set Missing', '');
    }
}

function changeCargoArticleStatus(state, code) {    
    var data = {};
    data.state = state;
    data.codes = code;
    //$('#btn-unload, #btn-delivered, #btn-undeliver, #btn-paid, #btn-return').hide();
    $('#cd-btn-panel').hide();
    $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-booking-status",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#cd-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    getCargoDetails(code);
                }, 3000);
            } else {
                $('#cd-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#cd-revert-panel-btn').show();
            }
        }
    })
}

function saveDeliveryStatus(code) {    
    var data = {};
    data.state = 'CD';
    data.codes = code;
    data.additionalAttribute = {};

    var delicharge = $.trim($('#delivery-charge').val());
    if (Number(delicharge) > 0) {
        data.additionalAttribute.DYCH = delicharge;
    }

    var demurragecharge = $.trim($('#demurrage-charge').val());
    if (Number(demurragecharge) > 0) {
        data.additionalAttribute.DMRCH = demurragecharge;
    }

    data.offlineUserCode = $('#delivery-on-behalf-user').val();

    if (menu_permission['CARGO-ONBEHALF-BOOKING'] == 1) {
        if  (!data.offlineUserCode) {
            $('#delivery-on-behalf-user').addClass('inp_error');
            return false;
        }
    }

    data.remarks = [];

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#delivery-remarks').val().trim();
    remarks.cargoStatusCode = data.state;
    data.remarks.push(remarks);

    data.otpNumber = $.trim( $('#delivery-otp').val() );

    var overrideOtp = $('#deliver-without-otp-cb').is(':checked');
    if (overrideOtp) {
        data.otpNumber = 'OVERRIDE';

        $('#delivery-remarks').removeClass('inp_error');
        if (!remarks.name) {
            $('#delivery-remarks').addClass('inp_error');
            $('#delivery-remarks').focus();
            return false;
        }
    }

    $('#delivery-otp').removeClass('inp_error');
    if (cargoSetting.otpValidateDeliveryFlag && data.otpNumber == '') {
        $('#delivery-otp').addClass('inp_error');
        $('#delivery-otp').focus();
        return false;
    }

    $('#pay-deliver-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $('#mk-pay-save-btn').attr('disabled', true);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-booking-status",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#pay-deliver-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                $('#mk-pay-save-btn').attr('disabled', false);
                window.setTimeout(function () {
                    getCargoDetails(code);
                }, 3000);
            } else {
                $('#pay-deliver-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#mk-pay-save-btn').attr('disabled', false);
            }
        }
    });
    ga_track_event(''+lang.lr+' Details', 'Set Delivery', '');
}


function showUnloadAnddeliver() {
    $('#lr-panel').addClass('hide');
    $('#unloading-panel').addClass('hide');
    // $('#cd-payment-panel').addClass('hide');
    $('#make-delivery-cb').prop('checked', true).trigger('change');
    $('#make-delivery-cb').parent('label').addClass('hide');
    $('#payment-unload-deliver-panel').removeClass('hide');
}

function hideUnloadAnddeliver() {
    $('#lr-panel').removeClass('hide');
    $('#unloading-panel').addClass('hide');
    $('#payment-unload-deliver-panel').addClass('hide');
}

function showPaymentAndUnload(deliveryAction = '') {
    $('#lr-panel').addClass('hide');
    $('#unloading-panel').addClass('hide');
    $('#dd-customer-calculation').addClass('hide');
    if (lrdata.paymentType.code == 'PAD' || lrdata.paymentType.code == 'TOP') {
        $('#dd-customer-calculation').removeClass('hide');
    }

    $('#payment_amount').val('');
    $('#delivery-remarks').val('');
    $('#pay-transaction-mode-main, #pay-transaction-mode-sub').val('CASH').trigger('change');
    $('#delivery-action-hidden').val(deliveryAction);
    $('#now-paying-amount').val(lr_balance);
    $('#add-unload-cb').prop('checked', false).trigger('change');

    $('#payment-unload-deliver-panel .inp_error').removeClass('inp_error');
    $('#pay-deliver-action-state').removeClass('alert-danger alert-success').html('');

    $('#make-delivery-div').hide();
    $('#now-paying-amount-div').addClass('hide');

    if (deliveryAction == 'MAKE_PAYMENT') {
        $('#payment-unload-deliver-panel .pre-delivery-options').addClass('hide');
        $('#delivery-charges-row .tds-tax-cont').removeClass('hide');
        $('#mk-pay-save-btn').html('Make Payment');
        $('#make-delivery-cb').prop('checked', false).trigger('change');
        $('#make-delivery-div').show();
        $('#add-unload-cb-div').addClass('hide');
        $('#delivery-receipt-div').addClass('hide');
        if (menu_permission['ALW-PART-PAYMENT'] == 1 || lr_balance > 0) {
            $('#now-paying-amount-div').removeClass('hide');
        }
    } else {
        $('#payment-unload-deliver-panel .pre-delivery-options').removeClass('hide');
        $('#mk-pay-save-btn').html('Delivery');
        $('#make-delivery-cb').prop('checked', true).trigger('change');
        $('#add-unload-cb-div').removeClass('hide');
        $('#delivery-receipt-div').removeClass('hide');
        getDemurrageAndDeliver(function () {
            $('#make-delivery-div').show();
        });
    }
    $('#payment-unload-deliver-panel').removeClass('hide');
    if (['citycargo', 'cityparcel'].includes(namespaceCode)) {
        $('#add-unload-cb').prop('checked', true).trigger('change');
    }
    if(unload_flag=="SLC" ||unload_flag=="DFT"){
        $('#add-unload-cb').prop('checked', true).trigger('change');
        $('#add-unload-cb-div').addClass('hide');
    }
    getAllDeliveryInputs();
}

function toggleAddUnloading(ele) {
    $('#add-unload-table').toggle($(ele).is(':checked'));
    $('#add-unload-table .payment-unloadingarticle').val('0');

    if (isNotNull(cargoSetting.unloadingChargeConfig)) {
        var unloadingChargeConfig = JSON.parse(cargoSetting.unloadingChargeConfig);
        console.log(unloadingChargeConfig);
        if (isNotNull(unloadingChargeConfig.DFT)) {
            $('#add-unload-table .payment-unloadingarticle')
                .val(unloadingChargeConfig.DFT.value)
                .prop('readonly', unloadingChargeConfig.DFT.editable == 0);
        } else if (isNotNull(unloadingChargeConfig.SLC)) {
                    } else if (isNotNull(unloadingChargeConfig.PFA)) {
            $('#add-unload-table .payment-unloadingarticle').each(function () {
                var percentage = (unloadingChargeConfig.PFA.value * $(this).data('totalfreight')) / 100;
                $(this).val(Math.ceil(percentage));
                $(this).prop('readonly', unloadingChargeConfig.PFA.editable == 0);
            });
        }

        calcPaymentUnloadingAmounts();
        calcDeliveryPayment();
    }
}

function toggleMakeDelivery(ele) {
    $('#delivery-remarks').val('');
    if ($(ele).is(':checked')) {
        getDemurrageAndDeliver(function () {
            $('#make-delivery-div').show();
        });
    } else {
        $('#make-delivery-div').hide();
    }
}

function saveUnloadAndDeliver(code) {
    if(!$('#cd-payment-panel').hasClass('hide')) {
        saveCargoPayment(code);
    } else if($('#add-unload-cb').is(':checked')) {
        savePaymentUnloadingCharge(code);
    } else if($('#make-delivery-cb').is(':checked')) {
        saveDeliveryStatus(code);
    }
}

function calcDeliveryPayment(calcTDS = true) {
    $('#payment-unload-deliver-panel .inp_error').removeClass('inp_error');

    var unloadingCharges = 0;
    if ($('#add-unload-cb').is(':checked')) {
        $('#add-unload-table .payment-unloadingarticle').each(function () {
            unloadingCharges += Number($(this).val()) || 0;
        });
    }

    var deliveryCharges = Number($('#delivery-charge').val()) || 0;
    var doorDeliveryCharges = Number($('#door-delivery-charge').val()) || 0;
    var demurrageCharges = Number($('#demurrage-charge').val()) || 0;
    var machineHandlingCharges = Number($('#machine-handling-charge').val()) || 0;

    var minDoorDeliveryCharges = $('#door-delivery-charge').data('min');
    if (lrdata.paymentType.code == 'PAD' && doorDeliveryCharges < minDoorDeliveryCharges) {
        $('#door-delivery-charge').val(minDoorDeliveryCharges);
        doorDeliveryCharges = minDoorDeliveryCharges;
    }

    if (doorDeliveryCharges > 0) {
        doorDeliveryCharges = doorDeliveryCharges - lrdata.deliveryHandlingAmount;
    }

    var nowPaying = Number($('#now-paying-amount').val());
    if (menu_permission['ALW-PART-PAYMENT'] != 1) {
        nowPaying = lr_balance;
    }

    if (isNaN(nowPaying) || nowPaying < 0) {
        $('#now-paying-amount').addClass('inp_error');
        return;
    }

    unloadingCharges = (unloadingCharges > 0 ? unloadingCharges - lrdata.totalUnloadHandlingAmount : unloadingCharges);
    var netamount = nowPaying + unloadingCharges + deliveryCharges + doorDeliveryCharges + demurrageCharges + machineHandlingCharges;

    if (cargoSetting.deliveryRoundOffValue != 0) {
        var netPayableRound = roundUpOrDownValue(netamount, cargoSetting.deliveryRoundOffValue);
        var roundOffValue = netPayableRound - netamount;
        $('#delivery-roundoff-hidden').val(Number(roundOffValue).toFixed(2));
        netamount = netPayableRound;
    }

    let tdsPercentage = parseFloat($('#delivery_tds_percent').val());
    let tdsTax = Number($('#delivery_tds_tax')) || 0;
    if (calcTDS && tdsPercentage > 0) {
        tdsTax = Math.round(parseFloat(netamount) * tdsPercentage / 100);
        $('#delivery_tds_tax').val(tdsTax);
    }

    var total_net_amount = lrdata.totalAmount+lrdata.totalHandlingAmount+lrdata.totalUnloadHandlingAmount+lrdata.pickupHandlingAmount+lrdata.serviceCharge+lrdata.hamaliCharge+lrdata.passCharge+lrdata.docketCharge+addonamount;
    total_net_amount += deliveryCharges + demurrageCharges + machineHandlingCharges + doorDeliveryCharges;

    let new_service_tax = Math.ceil(parseFloat(total_net_amount) * cargoSetting.serviceTaxPercentage / 100);
    // let new_service_tax = total_net_amount * cargoSetting.serviceTaxPercentage / 100;
    var changed_service_tax = 0;
    if (cargoSetting.lrGstTaxComputeType == 'NET' && lrdata.serviceTax > 0 && lrdata.paymentType.code != 'PAD') {
        changed_service_tax = new_service_tax - old_service_tax;
    }

    var hamali = parseFloat($('#hamaliCharge').val()) || 0;
    let payable = netamount - tdsTax + changed_service_tax + hamali;
    $('#payment_amount').val((payable).toFixed(2)).trigger('blur');
    $('#pay-amount-main').val((payable).toFixed(2));

    if (payable <= 0) {
        $('#pay-transaction-mode-main').val('CASH').trigger('change');
        $('#payment_transaction_mode_cont').addClass('hide');
    } else {
        $('#payment_transaction_mode_cont').removeClass('hide');
    }
}

function validateNumberInput(input, maxLength) {
    input.val(input.val().replace(/[^0-9]/g, ''));

    if (input.val().length > maxLength) {
        input.val(input.val().slice(0, maxLength));
    }
}

function validatePodMobileNumberInput() {
    var input = $('#podproof-mobile-no');
    validateNumberInput(input, 10);
}




function updateDeliveryDetails(lrcode) {
    $('#podproof-mobile-no').removeClass('inp_error');

    var data = {};
    var err = 0;
    data.cargoCode = lrcode;
    data.paymentTypeCode = lrdata.paymentType.code;
   
    var addonamount = 0;
    $.each(addonsMapped || [], function(key, val) {
        if ($.inArray(key, ['PODCH','INSUR', 'ADJSMT', 'FOVCH', 'CNCTCH']) != -1) {
            addonamount += Number(val['value']);
        }
    });
    totalPayableAmount = lrdata.totalAmount+lrdata.totalHandlingAmount+lrdata.pickupHandlingAmount+lrdata.serviceCharge+lrdata.hamaliCharge+lrdata.passCharge+lrdata.docketCharge+addonamount;
    data.additionalAttribute = {};

    var deliveryAction = $.trim($('#delivery-action-hidden').val());
    if (deliveryAction) {
        data.additionalAttribute.DELIVERY_ACTION = deliveryAction;
    }

    $('#payment-unload-deliver-panel .inp_error').removeClass('inp_error');
    data.itemDetails = [];

    var totalHandlingAmount = 0;
    if ($('#add-unload-cb').is(':checked')) {
        $('#add-unload-table .payment-unloadingarticle').each(function () {
            var article = {};
            article.code = $(this).attr('data-code');
            article.unloadingChargeAmount = $.trim($(this).val());

            if (Number(article.unloadingChargeAmount) > 0) {
                totalHandlingAmount += Number(article.unloadingChargeAmount);
                data.itemDetails.push(article);
            }
        });
    }
    totalPayableAmount += (totalHandlingAmount > 0 ? totalHandlingAmount : lrdata.totalUnloadHandlingAmount);

    data.cargoAddonsDetails = [];

    var deliveryCharge = $.trim($('#delivery-charge').val());
    if (Number(deliveryCharge) > 0) {
        var addon = {};
        addon.addonsType = {};
        addon.addonsType.code = 'DYCH';
        addon.value = deliveryCharge;
        data.cargoAddonsDetails.push(addon);
        totalPayableAmount += Number(deliveryCharge);
    } else if (isNotNull(addonsMapped['DYCH']) && addonsMapped['DYCH'].value > 0) {
        totalPayableAmount += Number(addonsMapped['DYCH'].value);
    }

    var demurrageCharge = $.trim($('#demurrage-charge').val());
    if (Number(demurrageCharge) > 0) {
        var addon = {};
        addon.addonsType = {};
        addon.addonsType.code = 'DMRCH';
        addon.value = demurrageCharge;
        data.cargoAddonsDetails.push(addon);
        totalPayableAmount += Number(demurrageCharge);
    } else if (isNotNull(addonsMapped['DMRCH']) && addonsMapped['DMRCH'].value > 0) {
        totalPayableAmount += Number(addonsMapped['DMRCH'].value);
    }

    var machineHandlingCharge = Number($('#machine-handling-charge').val()) || 0;
    if (Number(machineHandlingCharge) > 0) {
        var addon = {};
        addon.addonsType = {};
        addon.addonsType.code = 'MCNHCHDL';
        addon.value = machineHandlingCharge;
        data.cargoAddonsDetails.push(addon);
        totalPayableAmount += Number(machineHandlingCharge);
    } else if (isNotNull(addonsMapped['MCNHCHDL']) && addonsMapped['MCNHCHDL'].value > 0) {
        totalPayableAmount += Number(addonsMapped['MCNHCHDL'].value);
    }

    var roundoff = Number($('#delivery-roundoff-hidden').val());
    if (!isNaN(roundoff) && roundoff != 0) {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'RNDF' },
            value: Number(roundoff).toFixed(2)
        });
        totalPayableAmount += Number(roundoff);
    } else if (isNotNull(addonsMapped['RNDF']) && addonsMapped['RNDF'].value > 0) {
        totalPayableAmount += Number(addonsMapped['RNDF'].value);
    }

    if (lrdata.deliveryType.code == 'DYDO' && additionalStatusList['OFD']) {
        var doorDeliveryperson = $.trim($('#dd-handover-person').val());
        var doorDeliveryStatus = $.trim($('#dd-delivery-status').val());
        if (isNull(doorDeliveryperson)) {
            $('#dd-handover-person').addClass('inp_error');
            err++;
        }
        if (isNull(doorDeliveryStatus)) {
            $('#dd-delivery-status').addClass('inp_error');
            err++;
        }
        if (isNotNull(doorDeliveryperson) && isNotNull(doorDeliveryStatus)) {
            var addon = {};
            addon.addonsType = {};
            addon.addonsType.code = 'DRDLY';
            addon.code = doorDeliveryStatus;
            addon.value = $('#dd-delivery-status :selected').text();
            addon.name = doorDeliveryperson;
            data.cargoAddonsDetails.push(addon);
        }
    }

    data.remarks = [];

    var deliveryremarks = {};
    deliveryremarks.code = '';
    deliveryremarks.name = $('#delivery-remarks').val().trim();
    deliveryremarks.cargoStatusCode = 'CD';
    data.remarks.push(deliveryremarks);

    if ($('#make-delivery-cb').is(':checked')) {
        data.otpNumber = $.trim($('#delivery-otp').val());

        var overrideOtp = $('#deliver-without-otp-cb').is(':checked');
        if (overrideOtp) {
            data.otpNumber = 'OVERRIDE';

            $('#delivery-remarks').removeClass('inp_error');
            if (!deliveryremarks.name) {
                $('#delivery-remarks').addClass('inp_error');
                err++;
            }
        }

        if (cargoSetting.otpValidateDeliveryFlag && data.otpNumber == '') {
            $('#delivery-otp').addClass('inp_error');
            err++;
        }
    }
    data.deliveryHandlingAmount = $.trim($('#door-delivery-charge').val());
    totalPayableAmount += Number(data.deliveryHandlingAmount);
    if (data.deliveryHandlingAmount <= 0) {
        totalPayableAmount += Number(lrdata.deliveryHandlingAmount);
    }

    if (lrdata.paymentType.code != 'INP' && lrdata.paymentType.code != 'OATP') {
        // Default
        var cargoTransaction = {};
        cargoTransaction.transactionMode = {};
        cargoTransaction.transactionMode.code = $.trim($('#pay-transaction-mode-main').val());
        cargoTransaction.transactionType = {};
        cargoTransaction.transactionType.code = 'CGBO';

        var nowPaying = Number($('#now-paying-amount').val());
        if (menu_permission['ALW-PART-PAYMENT'] != 1) {
            nowPaying = lr_balance;
        }

        if (isNaN(nowPaying) || nowPaying < 0) {
            $('#now-paying-amount').addClass('inp_error');
            err++;
        }

        var customerTdsTaxAmount = Number($('#delivery_tds_tax').val()) || 0;
        var machineHandlingCharges = Number($('#machine-handling-charge').val()) || 0;
        // var roundoffAmount = Number($('#delivery-roundoff-hidden').val()) || 0;

        var new_service_tax = Math.ceil(parseFloat(totalPayableAmount) * cargoSetting.serviceTaxPercentage / 100);
        var changed_service_tax = 0;
        if (cargoSetting.lrGstTaxComputeType == 'NET' && lrdata.serviceTax > 0 && lrdata.paymentType.code != 'PAD') {
            changed_service_tax = new_service_tax - old_service_tax;
        }
        var hamali = parseFloat($('#hamaliCharge').val()) || 0;
        var netamount = Number(nowPaying) - Number(lrdata.deliveryHandlingAmount) + Number(data.deliveryHandlingAmount) + machineHandlingCharges - customerTdsTaxAmount + changed_service_tax+hamali;
        cargoTransaction.transactionAmount = +Number(netamount).toFixed(2);
        cargoTransaction.customerTdsTaxAmount = customerTdsTaxAmount;

        data.transactionMode = cargoTransaction.transactionMode.code;
        if($('#payment_amount').val() != 0 ){
            if (cargoTransaction.transactionMode.code == '') {
                $('#pay-transaction-mode-main').addClass('inp_error');
                err++;
            }
        }
        if (cargoTransaction.transactionMode.code == 'UPI') {
            cargoTransaction.bankDetails = {};
            cargoTransaction.bankDetails.code = $('#pay-upi-orgbank-main').val();
            cargoTransaction.additionalAttribute = {};
            cargoTransaction.additionalAttribute.UPI_ID = $.trim($('#pay-upi-id-main').val());
            cargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#pay-upi-details-main').val());
            
            if (isNull(cargoTransaction.bankDetails.code)) {
                $('#pay-upi-orgbank-main').addClass('inp_error');
                err++;
            }
            if (isNull(cargoTransaction.additionalAttribute.UPI_ID)) {
                $('#pay-upi-id-main').addClass('inp_error');
                err++;
            }

            if (isNull(cargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                $('#pay-upi-details-main').addClass('inp_error');
                err++;
            }
        } else if (cargoTransaction.transactionMode.code == 'NBK') {
            cargoTransaction.bankDetails = {};
            cargoTransaction.bankDetails.code = $('#pay-netbanking-orgbank-main').val();
            cargoTransaction.additionalAttribute = {};
            cargoTransaction.additionalAttribute.ACC_HOLDER_NAME = $.trim($('#pay-netbanking-accholder-main').val());
            cargoTransaction.additionalAttribute.BANK_NAME = $.trim($('#pay-netbanking-bankname-main').val());
            cargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#pay-netbanking-details-main').val());
            
            if (isNull(cargoTransaction.bankDetails.code)) {
                $('#pay-netbanking-orgbank-main').addClass('inp_error');
                err++;
            }

            if (isNull(cargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                $('#pay-netbanking-details-main').addClass('inp_error');
                err++;
            }
        } else if (cargoTransaction.transactionMode.code == 'CHEQUE') {
            var chequeDetails = {};
            chequeDetails.activeFlag = 1;
            chequeDetails.organization = {};
            chequeDetails.organization.code = login_branch_code;
            chequeDetails.bankDetails = $.trim($('#pay-cheque-bankname-main').val());
            chequeDetails.payerDetails = $.trim($('#pay-cheque-payer-main').val());
            chequeDetails.chequeDate = moment($('#pay-cheque-date-main').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
            chequeDetails.chequeNo = $.trim($('#pay-cheque-no-main').val());
            chequeDetails.bankCity = $.trim($('#pay-cheque-bankcity-main').val());
            chequeDetails.chequeStatus = {};
            chequeDetails.chequeStatus.code = 'NEW';
            chequeDetails.remarks = $.trim($('#pay-cheque-remarks-main').val());

            if (isNull(chequeDetails.payerDetails)) {
                $('#pay-cheque-payer-main').addClass('inp_error');
                err++;
            }
            if (isNull(chequeDetails.chequeNo)) {
                $('#pay-cheque-no-main').addClass('inp_error');
                err++;
            }
            if (!moment($('#pay-cheque-date-main').val(), 'DD-MM-YYYY').isValid()) {
                $('#pay-cheque-date-main').addClass('inp_error');
                err++;
            }
            if (isNull(chequeDetails.bankCity)) {
                $('#pay-cheque-bankcity-main').addClass('inp_error');
                err++;
            }
            if (isNull(chequeDetails.bankDetails)) {
                $('#pay-cheque-bankname-main').addClass('inp_error');
                err++;
            }
            cargoTransaction.chequeDetails = chequeDetails;
        }

        data.cargoTransactionList = [];
        if (cargoTransaction.transactionAmount >= 0) {
            data.cargoTransactionList.push(cargoTransaction);
        }

        if ($('#pay-amount-sub').val() > 0) {
            // Main
            var mainCargoTransaction = {};
            mainCargoTransaction.name = 'PAYMENT_MODE_TRANSACTION';
            mainCargoTransaction.transactionMode = {};
            mainCargoTransaction.transactionMode.code = $.trim($('#pay-transaction-mode-main').val());
            mainCargoTransaction.transactionType = {};
            mainCargoTransaction.transactionType.code = 'CGBO';

            var nowPaying = Number($('#pay-amount-main').val());
            // if (menu_permission['ALW-PART-PAYMENT'] != 1) {
            //     nowPaying = lr_balance;
            // }

            if (isNaN(nowPaying) || nowPaying < 0) {
                $('#pay-amount-main').addClass('inp_error');
                err++;
            }

            // var customerTdsTaxAmount = Number($('#delivery_tds_tax').val()) || 0;
            // var machineHandlingCharges = Number($('#machine-handling-charge').val()) || 0;
            // var roundoffAmount = Number($('#delivery-roundoff-hidden').val()) || 0;

            // var new_service_tax = Math.ceil(parseFloat(totalPayableAmount) * cargoSetting.serviceTaxPercentage / 100);
            // var changed_service_tax = 0;
            // if (cargoSetting.lrGstTaxComputeType == 'NET' && lrdata.serviceTax > 0 && lrdata.paymentType.code != 'PAD') {
            //     changed_service_tax = new_service_tax - old_service_tax;
            // }
            
            // var netamount = Number(nowPaying) - customerTdsTaxAmount + changed_service_tax ;
            mainCargoTransaction.transactionAmount = +Number(nowPaying).toFixed(2);
            mainCargoTransaction.customerTdsTaxAmount = customerTdsTaxAmount;

            // data.transactionMode = mainCargoTransaction.transactionMode.code;
            if (mainCargoTransaction.transactionMode.code == '') {
                $('#pay-transaction-mode-main').addClass('inp_error');
                err++;
            }

            if (mainCargoTransaction.transactionMode.code == 'UPI') {
                mainCargoTransaction.bankDetails = {};
                mainCargoTransaction.bankDetails.code = $('#pay-upi-orgbank-main').val();
                mainCargoTransaction.additionalAttribute = {};
                mainCargoTransaction.additionalAttribute.UPI_ID = $.trim($('#pay-upi-id-main').val());
                mainCargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#pay-upi-details-main').val());
                
                if (isNull(mainCargoTransaction.bankDetails.code)) {
                    $('#pay-upi-orgbank-main').addClass('inp_error');
                    err++;
                }
                if (isNull(mainCargoTransaction.additionalAttribute.UPI_ID)) {
                    $('#pay-upi-id-main').addClass('inp_error');
                    err++;
                }

                if (isNull(mainCargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#pay-upi-details-main').addClass('inp_error');
                    err++;
                }
            } else if (mainCargoTransaction.transactionMode.code == 'NBK') {
                mainCargoTransaction.bankDetails = {};
                mainCargoTransaction.bankDetails.code = $('#pay-netbanking-orgbank-main').val();
                mainCargoTransaction.additionalAttribute = {};
                mainCargoTransaction.additionalAttribute.ACC_HOLDER_NAME = $.trim($('#pay-netbanking-accholder-main').val());
                mainCargoTransaction.additionalAttribute.BANK_NAME = $.trim($('#pay-netbanking-bankname-main').val());
                mainCargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#pay-netbanking-details-main').val());
                
                if (isNull(mainCargoTransaction.bankDetails.code)) {
                    $('#pay-netbanking-orgbank-main').addClass('inp_error');
                    err++;
                }

                if (isNull(mainCargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#pay-netbanking-details-main').addClass('inp_error');
                    err++;
                }
            } else if (mainCargoTransaction.transactionMode.code == 'CHEQUE') {
                var chequeDetails = {};
                chequeDetails.activeFlag = 1;
                chequeDetails.organization = {};
                chequeDetails.organization.code = login_branch_code;
                chequeDetails.bankDetails = $.trim($('#pay-cheque-bankname-main').val());
                chequeDetails.payerDetails = $.trim($('#pay-cheque-payer-main').val());
                chequeDetails.chequeDate = moment($('#pay-cheque-date-main').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                chequeDetails.chequeNo = $.trim($('#pay-cheque-no-main').val());
                chequeDetails.bankCity = $.trim($('#pay-cheque-bankcity-main').val());
                chequeDetails.chequeStatus = {};
                chequeDetails.chequeStatus.code = 'NEW';
                chequeDetails.remarks = $.trim($('#pay-cheque-remarks-main').val());

                if (isNull(chequeDetails.payerDetails)) {
                    $('#pay-cheque-payer-main').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.chequeNo)) {
                    $('#pay-cheque-no-main').addClass('inp_error');
                    err++;
                }
                if (!moment($('#pay-cheque-date-main').val(), 'DD-MM-YYYY').isValid()) {
                    $('#pay-cheque-date-main').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.bankCity)) {
                    $('#pay-cheque-bankcity-main').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.bankDetails)) {
                    $('#pay-cheque-bankname-main').addClass('inp_error');
                    err++;
                }
                mainCargoTransaction.chequeDetails = chequeDetails;
            }
            
            data.cargoTransactionList.push(mainCargoTransaction);

            // Sub
            var subCargoTransaction = {};
            subCargoTransaction.name = 'PAYMENT_MODE_TRANSACTION';
            subCargoTransaction.transactionMode = {};
            subCargoTransaction.transactionMode.code = $.trim($('#pay-transaction-mode-sub').val());
            subCargoTransaction.transactionType = {};
            subCargoTransaction.transactionType.code = 'CGBO';

            var nowPaying = Number($('#pay-amount-sub').val());
            // if (menu_permission['ALW-PART-PAYMENT'] != 1) {
            //     nowPaying = lr_balance;
            // }

            if (isNaN(nowPaying) || nowPaying < 0) {
                $('#pay-amount-sub').addClass('inp_error');
                err++;
            }

            // var customerTdsTaxAmount = Number($('#delivery_tds_tax').val()) || 0;
            // var machineHandlingCharges = Number($('#machine-handling-charge').val()) || 0;
            // var roundoffAmount = Number($('#delivery-roundoff-hidden').val()) || 0;

            // var new_service_tax = Math.ceil(parseFloat(totalPayableAmount) * cargoSetting.serviceTaxPercentage / 100);
            // var changed_service_tax = 0;
            // if (cargoSetting.lrGstTaxComputeType == 'NET' && lrdata.serviceTax > 0 && lrdata.paymentType.code != 'PAD') {
            //     changed_service_tax = new_service_tax - old_service_tax;
            // }
            
            // var netamount = Number(nowPaying) - customerTdsTaxAmount + changed_service_tax ;
            subCargoTransaction.transactionAmount = +Number(nowPaying).toFixed(2);
            subCargoTransaction.customerTdsTaxAmount = customerTdsTaxAmount;

            // data.transactionMode = subCargoTransaction.transactionMode.code;
            if (subCargoTransaction.transactionMode.code == '') {
                $('#pay-transaction-mode-sub').addClass('inp_error');
                err++;
            }

            if (subCargoTransaction.transactionMode.code == 'UPI') {
                subCargoTransaction.bankDetails = {};
                subCargoTransaction.bankDetails.code = $('#pay-upi-orgbank-sub').val();
                subCargoTransaction.additionalAttribute = {};
                subCargoTransaction.additionalAttribute.UPI_ID = $.trim($('#pay-upi-id-sub').val());
                subCargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#pay-upi-details-sub').val());
                
                if (isNull(subCargoTransaction.bankDetails.code)) {
                    $('#pay-upi-orgbank-sub').addClass('inp_error');
                    err++;
                }
                if (isNull(subCargoTransaction.additionalAttribute.UPI_ID)) {
                    $('#pay-upi-id-sub').addClass('inp_error');
                    err++;
                }

                if (isNull(subCargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#pay-upi-details-sub').addClass('inp_error');
                    err++;
                }
            } else if (subCargoTransaction.transactionMode.code == 'NBK') {
                subCargoTransaction.bankDetails = {};
                subCargoTransaction.bankDetails.code = $('#pay-netbanking-orgbank-sub').val();
                subCargoTransaction.additionalAttribute = {};
                subCargoTransaction.additionalAttribute.ACC_HOLDER_NAME = $.trim($('#pay-netbanking-accholder-sub').val());
                subCargoTransaction.additionalAttribute.BANK_NAME = $.trim($('#pay-netbanking-bankname-sub').val());
                subCargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#pay-netbanking-details-sub').val());
                
                if (isNull(subCargoTransaction.bankDetails.code)) {
                    $('#pay-netbanking-orgbank-sub').addClass('inp_error');
                    err++;
                }

                if (isNull(subCargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#pay-netbanking-details-sub').addClass('inp_error');
                    err++;
                }
            } else if (subCargoTransaction.transactionMode.code == 'CHEQUE') {
                var chequeDetails = {};
                chequeDetails.activeFlag = 1;
                chequeDetails.organization = {};
                chequeDetails.organization.code = login_branch_code;
                chequeDetails.bankDetails = $.trim($('#pay-cheque-bankname-sub').val());
                chequeDetails.payerDetails = $.trim($('#pay-cheque-payer-sub').val());
                chequeDetails.chequeDate = moment($('#pay-cheque-date-sub').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                chequeDetails.chequeNo = $.trim($('#pay-cheque-no-sub').val());
                chequeDetails.bankCity = $.trim($('#pay-cheque-bankcity-sub').val());
                chequeDetails.chequeStatus = {};
                chequeDetails.chequeStatus.code = 'NEW';
                chequeDetails.remarks = $.trim($('#pay-cheque-remarks-sub').val());

                if (isNull(chequeDetails.payerDetails)) {
                    $('#pay-cheque-payer-sub').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.chequeNo)) {
                    $('#pay-cheque-no-sub').addClass('inp_error');
                    err++;
                }
                if (!moment($('#pay-cheque-date-sub').val(), 'DD-MM-YYYY').isValid()) {
                    $('#pay-cheque-date-sub').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.bankCity)) {
                    $('#pay-cheque-bankcity-sub').addClass('inp_error');
                    err++;
                }
                if (isNull(chequeDetails.bankDetails)) {
                    $('#pay-cheque-bankname-sub').addClass('inp_error');
                    err++;
                }
                subCargoTransaction.chequeDetails = chequeDetails;
            }
            
            data.cargoTransactionList.push(subCargoTransaction);
        }
    }

    if (addonsMapped['FRECR'] && Array.isArray(addonsMapped['FRECR'].valueList)) {
        var valueList = addonsMapped['FRECR'].valueList;

        if (Number(data.deliveryHandlingAmount) > 0) {
            valueList = _.filter(valueList, c => c != 'DD');
        }
        
        data.cargoAddonsDetails.push({
            addonsType: { code: 'FRECR' },
            value: valueList.join(',')
        });
    }

    if (cargoSetting.lrGstTaxComputeType == 'NET' && lrdata.serviceTax > 0) {
        data.lrGSTEdit = {}
        data.lrGSTEdit.code = lrdata.code;
        data.lrGSTEdit.serviceTax = new_service_tax;

        data.lrGSTEdit.itemDetails = [];
        $(lrdata.itemDetails).each(function(k, item){
            var lrGSTItemDetails = {};
            lrGSTItemDetails.code = item.code;
            lrGSTItemDetails.serviceTax = item.serviceTax;
            lrGSTItemDetails.unit = {};
            lrGSTItemDetails.unit.code = item.unit.code;
            data.lrGSTEdit.itemDetails.push(lrGSTItemDetails);
        });

        data.serviceTaxEditFlag = 1;
    }

    data.imageCategoryCode = 'PODDELIVERY';
    data.cargoCode = lrdata.code;
    data.documentCategory = {};
    data.documentCategory.code = 'POD';
    data.documentType = {};
    data.documentType.code = $.trim( $('#podproof-document-type').val() );
    data.documentNumber = $.trim( $('#podproof-document-no').val() );
    data.mobileNumber = $.trim( $('#podproof-mobile-no').val() );
    data.hamaliCharge =$('#hamaliCharge').val();

    if (!data.documentType.code) {
        $('#podproof-document-type').addClass('inp_error');
        err++;
    }
    if(data.mobileNumber !=''){
        if (data.mobileNumber.length !== 10) {
            $('#podproof-mobile-no').addClass('inp_error');
            console.log(41);
            err++;
        }
    }
    if (err) {
        $('#pay-deliver-action-state').removeClass('alert-success hide').addClass('alert alert-danger');
        $('#pay-deliver-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }

    if ($('#make-delivery-cb').is(':checked') && menu_permission['ADD-PROOF-DOC'] == 1 && cargoSetting.podValidateDeliveryFlag) {
        var galleryFiles = $('.file-input-gallery .file-upload-file', '#pod-proof-fileupload');
        if (galleryFiles.length == 0) {
            $('#pay-deliver-action-state').removeClass('alert-success hide').addClass('alert alert-danger');
            $('#pay-deliver-action-state').html('Please select a POD proof');
            return;
        }
    }

    $('#pay-deliver-action-state').removeClass('alert alert-danger alert-success').html(loading_popup);
    $('#mk-pay-save-btn').attr('disabled', true);
    $('#payment-unload-deliver-panel #ul-buttons').hide();
    
    // #config/save-image-details
    podproofupload.startUpload({
        data: data,
        onComplete: function (response) {

            data.imageDetails = [];

            $('.file-input-gallery .file-upload-file', '#pod-proof-fileupload').each(function() {
                var slug = $(this).data('slug');

                if (slug) {
                    data.imageDetails.push({ imageUrlSlug: slug });
                }
            });

            if (data.imageDetails.length > 0) {
                data.additionalAttribute.POD_UPDATED_FLAG = '1';
            }

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-delivery-payment",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#del_captured_image img').each(function() {
                            var data_uri = $(this).attr('src');
                            if (isNotNull(data_uri)) {
                                var url = "config/store-webcam-files";
                                Webcam.upload(data_uri, url, data);
                            }
                        });
                        
                        $('#pay-deliver-action-state').addClass('alert alert-success').html('Your request processed successfully');

                        $('#unload-deliver-content').addClass('hide');
                        $('#post-delivery-options').removeClass('hide');

                        $('#d-topay-amt').html($('#now-paying-amount').val());
                        $('#d-deliv-amt').html(deliveryCharge).toggleClass('hide', Number(deliveryCharge) <= 0)
                        $('#d-ddeliv-amt').html(data.deliveryHandlingAmount).toggleClass('hide', Number(data.deliveryHandlingAmount) > 0)
                        $('#d-net-amt').html($('#payment_amount').val());
                        $('#post-delivery-content').removeClass('hide');
                        
                        delCloseWebcam();
                        del_clear_snapshot();
                    } else {
                        $('#pay-deliver-action-state').addClass('alert alert-danger').html(response.errorDesc || 'Unknown Exception');
                        $('#mk-pay-save-btn').attr('disabled', false);
                        $('#payment-unload-deliver-panel #ul-buttons').show();
                    }
                }
            });
        }
    });
}

$('#podproof-mobile-no').on('input', validatePodMobileNumberInput);

function print_cargo_ogpl_chart(code) { 
    var data={};
    data.transitDetailsCodes=code;
    $.ajax({
    type: "POST",
    dataType: 'json',
    url: base_url + "cargo/get-ogpl-code",
    data: data,
    success: function (response) {
        if(response){
            var url = base_url + "#cargo/ogpl-chart-details?transitCode="+response.transitCargo.code;
            window.open(url, "_blank");
        }
    }
    }); 
 
}
function getCargoHIstory(code){
    getCargoHistory(code);
}

function editVendor() {
    $('#dia-cargo-edit').removeClass('hide');
    $('#dia-cargo-edit').dialog({
        autoOpen: true,
        height: 250,
        width: 450,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    var tmp = $('#template-edit-vendor').html();
    $('#dia-cargo-edit').html(tmp);    
    $('#vendorName').val(lrdata.vendorUser.code);                                                                                                                                                                                                                                                
}

function saveVendor() {
    $('#vendorName').removeClass('inp_error');
    var data = {};
    data.code = $('#vendorName').val();
    data.name = $("#vendorName option:selected").text();
    data.activeFlag = 1;
    if(data.code=="") {
        $('#vendorName').addClass('inp_error');
        $('#vendorName').focus();
        return; 
    }
    
    
    var fdata = {};
    fdata.lr = lrdata;
    fdata.lr.vendorUser.code = data.code;
    fdata.lr.vendorUser.name = data.name;
    fdata.lr.vendorUser.activeFlag = data.activeFlag;

    $('#form-bttons').hide();
    $('#action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-save-cargo",
        data: fdata,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    cancelEditDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
    ga_track_event(''+lang.lr+' Details', 'Edit Vendor', '');
}


function editEwayBill() {
    $('#dia-cargo-edit').removeClass('hide');
    $('#dia-cargo-edit').dialog({
        autoOpen: true,
        height: 250,
        width: 450,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    var tmp = $('#template-edit-ewaybill').html();
    $('#dia-cargo-edit').html(tmp);    
    
    $('#eway_bill_edit').val('');
    $.each(lrdata.cargoAddonsDetails || [], function (i, addon) {
        if (addon.addonsType.code == 'EWBL') {
            $('#eway_bill_edit').val(addon.value);
            return false;
        }
    });
}

function saveEwayBill() {
    $('#eway_bill_edit').removeClass('inp_error');
    var data = {};
    data.bill = $('#eway_bill_edit').val();
    if(data.bill=="") {
        $('#eway_bill_edit').addClass('inp_error');
        $('#eway_bill_edit').focus();
        return; 
    }
        
    var fdata = {};
    fdata.lr = lrdata;    
    $.each(fdata.lr.cargoAddonsDetails || [], function (i, addon) {
        if (addon.addonsType.code == 'EWBL') {
            addon.value = data.bill;
            return false;
        }
    });
    $('#form-bttons').hide();
    $('#action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-save-cargo",
        data: fdata,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    cancelEditDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
    ga_track_event(''+lang.lr+' Details', 'Edit EWay Bill', '');
}


function sendDeliveryOTP(otpCustomerType = 'NA') {
    var data = {};
    data.code = lrdata.code;
    data.otpCustomerType = otpCustomerType;

    var otpto = otpCustomerType == 'FROMCUST' ? 'Sender' : 'Receiver';
    if (!confirm('Do you want to send OTP to ' + otpto + '?')) {
        return;
    }

    var loading_overlay = iosOverlay({
        text: "Sending OTP",
        icon: "fa fa-spinner fa-spin"
    });

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/send-delivery-otp",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "OTP Sent!"
                });
            } else {
                alert(response.errorDesc);
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "send OTP Failed!"
                });
            }
            window.setTimeout(function () {
                loading_overlay.hide();
            }, 2000);
        }
    });
    ga_track_event('LR Details', 'Send Delivery OTP', '');
}

function loadToOGPL() {
    // $('#lr-panel').addClass('hide');
    $('#load-to-ogpl-panel').html(loading_popup).removeClass('hide');

    var data = {};
    data.cargoCode = lrdata.code;

    $.ajax({
        type: 'POST',
        dataType: 'html',
        url: base_url + 'cargo/get-lr-related-ogpl',
        data: data,
        success: function (response) {
            $('#load-to-ogpl-panel').html(response);
        }
    });
}

function hideloadToOGPL() {
    $('#load-to-ogpl-panel').html('').addClass('hide');
    $('#lr-panel').removeClass('hide');
}

function loadLRToOGPL(transitCode) {
    var data = {};
    data.toStation = lrdata.toStation.code;
    data.fromStation = lrdata.fromStation.code;
    data.fromOrganization = lrdata.fromOrganization.code;
    data.toOrganization = lrdata.toOrganization.code;
    data.transitCargo = transitCode;
    data.transitOrganization = lrdata.toOrganization.code;
    data.cargoList = [];
    data.cargoList.push({ code: lrdata.code });

    $('#popup-load-ogpl-action').removeClass('hide alert-danger alert-success').html(loading_popup);

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'cargo/load-ogpl-lr',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#popup-load-ogpl-action').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    getCargoDetails(lrdata.code);
                }, 2000);
            } else {
                $('#popup-load-ogpl-action').addClass('alert-danger').html(response.errorDesc);
            }
        }
    });
}

function loadLRToOGPLAdd() {
    var err = 0;
    var tplcode = $('#load-ogpl-tpl').val();
    var vehiclecode = $('#load-ogpl-vehicle').val();
    var drivercode = $('#load-ogpl-driver-name').val();

    $('.inp_error').removeClass('inp_error');
    if (!tplcode) {
        $('#load-ogpl-tpl').addClass('inp_error');
        err++;
    }
    if (!vehiclecode) {
        $('#load-ogpl-vehicle').addClass('inp_error');
        err++;
    }
    if (!drivercode) {
        $('#load-ogpl-driver-name').addClass('inp_error');
        err++;
    }
    if(err) {
        $('#popup-load-ogpl-action').removeClass('alert-success hide').addClass('alert-danger');
        $('#popup-load-ogpl-action').html('Please enter/select the values in the field that are marked in red');
        return;
    }

    var tpl = _.find(ogplTemplates, i => i.code == tplcode);
    
    var data = {};
    data.activeFlag = 1;
    data.code = '';
    data.name = tpl.fromStation.name + ' to ' + tpl.toStation.name;
    data.fromStation = tpl.fromStation;
    data.toStation = tpl.toStation;
    data.fromOrganization = tpl.fromOrganization;
    data.toOrganization = tpl.toOrganization;
    data.viaStations = tpl.viaStations;
    data.tripDate = moment().format('YYYY-MM-DD');
    data.busVehicle = {};
    data.busVehicle.code = vehiclecode;
    data.vehicleDriver = {};
    data.vehicleDriver.code = drivercode;
    data.cargoActivityType = {};
    data.cargoActivityType.code = 'TRNT';
    data.remarks = '';
    data.arrivalMinutes = tpl.arrivalMinutes;
    data.departureMinutes = tpl.departureMinutes;

    data.loadList = [];

    var obj = {};
    obj.to = lrdata.toStation.code;
    obj.from = lrdata.fromStation.code;
    obj.oldTransitOrg = lrdata.fromOrganization.code;
    obj.transitOrganization = lrdata.toOrganization.code;
    obj.cargoList = [];
    obj.cargoList.push(lrdata.code);
    data.loadList.push(obj);

    $('#popup-load-ogpl-action').removeClass('hide alert-danger alert-success').html(loading_popup);

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'cargo/load-ogpl-list',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#popup-load-ogpl-action').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    getCargoDetails(lrdata.code);
                }, 2000);
            } else {
                $('#popup-load-ogpl-action').addClass('alert-danger').html(response.errorDesc);
            }
        }
    });
    ga_track_event('LR Details', 'Load LR to OGPL', '');
}

function resendCargoSMS() {
    var data = {};
    data.cargoCode = lrdata.code;

    var loading_overlay = iosOverlay({
        text: "Sending SMS",
        icon: "fa fa-spinner fa-spin"
    });

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/resend-cargo-sms",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "SMS Sent!"
                });
            } else {
                alert(response.errorDesc);
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Send SMS Failed!"
                });
            }
            window.setTimeout(function () {
                loading_overlay.hide();
            }, 2000);
        }
    });
    ga_track_event('LR Details', 'Resend SMS', '');
}

function addGSTDialog() {
    $('#dia-cargo-edit').removeClass('hide');
    $('#dia-cargo-edit').dialog({
        autoOpen: true,
        height: 600,
        width: 900,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    
    var tmp = $('#template-edit-gst').html();
    
    $('#dia-cargo-edit').html(tmp);

    $('#edit_sender_gstin').val(lrdata.fromCustomerGST || '');
    $('#edit_receiver_gstin').val(lrdata.toCustomerGST || '');

    $('#edit-invoice-list').html('');
    $.each(lrdata.cargoAddonsDetails || [], function (i, addon) {
        if (addon.addonsType.code == 'EWBL') {
            var $tpl = addInvoiceEditRow();
            $tpl.find('.edit-eway-bill-code').val(addon.code);
            $tpl.find('.edit_eway_bill_number').val(addon.referenceCode || '');

            var invoiceDetails = addon.value.split('|');
            $tpl.find('.edit_inv_number').val(invoiceDetails[1] || '');
            $tpl.find('.edit_inv_amount').val(invoiceDetails[0] || '');
            $tpl.find('.edit_inv_date').val(moment(invoiceDetails[2], 'YYYY-MM-DD').format('DD-MM-YYYY'));
        }
    });
    addInvoiceEditRow();
    
    var $items = $('#items-tbody').clone().find('tr')
    if (cargoSetting.lrGstTaxComputeType == 'FRT') {
        $items.each(function () {
            var gst = $(this).find('[data-gst]').data('gst');
            $(this).find('.sno').html('<label><input type="checkbox" class="add-item-gst" ' + (gst && 'checked') + '></label>');
        });
        $items.find('.add-item-gst').on('click', calcItemGst);
    } else {
        var gst = $items.eq(0).find('[data-gst]').data('gst');
        if (gst > 0) {
            $('.add-item-gst').prop('checked', true).trigger('change');
        }
        $('.add-item-gst').on('click', calcItemGst);
    }

    $('#edit_sender_gstin, #edit_receiver_gstin').on('blur', calcItemGst);

    $('#gst_body_table').html($items)

    $('#edit_inv_date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-30d',
        endDate:'0d'
    });

    calcItemGst()
}

function calcItemGst() {
    var total_amount = 0;
    if (cargoSetting.lrGstTaxComputeType == 'FRT') {
        $(lrdata.itemDetails).each(function(k, item) {
            var checked = $('#gst_body_table [data-itemcode="' + item.code + '"] .add-item-gst').is(':checked')
            if (checked && !item.cargoItem.gstExemptedFlag) {
                total_amount += item.computed.freight;
            }
        });
    } else if ($('.add-item-gst').is(':checked')) {
        total_amount = lrdata.totalAmount+lrdata.totalHandlingAmount+lrdata.totalUnloadHandlingAmount+lrdata.pickupHandlingAmount+lrdata.deliveryHandlingAmount+lrdata.serviceCharge+lrdata.hamaliCharge+lrdata.passCharge+lrdata.docketCharge+addonamount;
    }

    var st = 0;
    var computeGST = total_amount;
    if (computeGST > cargoSetting.minServiceTax && !lrHasRCMBasedGST(true)) {
        var st = parseFloat(computeGST) * cargoSetting.serviceTaxPercentage / 100;
        st = Math.ceil(st);
    }
    $('#tot-gst-amt').html(parseFloat(st).toFixed(2));
}

function saveGST() {
    var err = 0;
    var data = {};
    data.code = lrdata.code;
    data.itemDetails = [];
    data.serviceTax = 0;

    data.fromCustomerGST = $('#edit_sender_gstin').val().trim();
    data.toCustomerGST = $('#edit_receiver_gstin').val().trim();

    data.additionalAttribute = {}
    if (lrdata.additionalAttribute && lrdata.additionalAttribute.fromCustomerGstType) {
        data.additionalAttribute.fromCustomerGstType = lrdata.additionalAttribute.fromCustomerGstType;
    }

    if (lrdata.additionalAttribute && lrdata.additionalAttribute.toCustomerGstType) {
        data.additionalAttribute.toCustomerGstType = lrdata.additionalAttribute.toCustomerGstType;
    }

    var cargoAddonsDetails = [];
    var editedAddonDetails = [];
    $('#edit-invoice-list .edit-invoice-row').each(function () {
        var invoice = {};

        invoice.code = $(this).find('.edit-eway-bill-code').val();
        invoice.activeFlag = 1;
        invoice.addonsType = {};
        invoice.addonsType.code = 'EWBL';

        var invoiceNumber = $.trim($(this).find('.edit_inv_number').val());
        var invoiceAmount = $.trim($(this).find('.edit_inv_amount').val());

        var invoice_date = $(this).find('.edit_inv_date').val();
        var invoiceDate =moment(invoice_date, 'DD-MM-YYYY').format('YYYY-MM-DD');

        invoice.value = invoiceAmount+'|'+invoiceNumber+'|'+invoiceDate;
        invoice.referenceCode = $.trim($(this).find('.edit_eway_bill_number').val());

        if (cargoSetting.mandateInvoiceAmountFlag || invoiceNumber != '') {
            if (invoiceNumber == '') {
                $('#action-state').html('Please enter invoice number');
                $(this).find('.edit_inv_number').focus();
                err++;
                return false;
            } else if (invoiceAmount == '') {
                $('#action-state').html('Please enter invoice amount');
                $(this).find('.edit_inv_amount').focus();
                err++;
                return false;
            } else if (isNaN(invoiceAmount)) {
                $('#action-state').html('Please enter valid invoice amount');
                $(this).find('.edit_inv_amount').focus();
                err++;
                return false;
            } else if ($(this).find('.edit_inv_date').val() == '') {
                $('#action-state').html('Please enter invoice date');
                $(this).find('.edit_inv_date').focus();
                err++;
                return false;
            }

            cargoAddonsDetails.push(invoice);
            editedAddonDetails.push(invoice.code);
        }
    });

    $.each(lrdata.cargoAddonsDetails, function(k, addon) {
        if ($.inArray(addon.code, editedAddonDetails) == -1) {
            var invoice = addon;
            invoice.activeFlag = 0;
            cargoAddonsDetails.push(invoice);
        }
    });
    data.cargoAddonsDetails = cargoAddonsDetails;

    var totalFreightAmount = 0;
    var netAmount = 0;
    $(lrdata.itemDetails).each(function(k, item) {
        var itm = {}
        itm.activeFlag = item.activeFlag;
        itm.code = item.code;
        itm.unit = item.unit;
        itm.unitValue = item.unitValue;
        itm.fare = item.fare;
        itm.serviceTax = 0;

        if (cargoSetting.lrGstTaxComputeType == 'FRT') {
            if ($('#gst_body_table [data-itemcode="' + itm.code + '"] .add-item-gst').is(':checked')) {
                var st = parseFloat(item.fare) * cargoSetting.serviceTaxPercentage / 100;
                itm.serviceTax = Math.ceil(st);
                if (!item.cargoItem.gstExemptedFlag) {
                    totalFreightAmount += item.computed.freight;
                }
            }
        }

        data.itemDetails.push(itm);
    });
    
    if (cargoSetting.lrGstTaxComputeType == 'NET' && $('.add-item-gst').is(':checked')) {
        netAmount = lrdata.totalAmount+lrdata.totalHandlingAmount+lrdata.totalUnloadHandlingAmount+lrdata.pickupHandlingAmount+lrdata.deliveryHandlingAmount+lrdata.serviceCharge+lrdata.hamaliCharge+lrdata.passCharge+lrdata.docketCharge+addonamount;
    }
    var computeGST = cargoSetting.lrGstTaxComputeType == 'FRT' ? totalFreightAmount : netAmount;
    if (computeGST > cargoSetting.minServiceTax && !lrHasRCMBasedGST(true)) {
        var st = parseFloat(computeGST) * cargoSetting.serviceTaxPercentage / 100;
        data.serviceTax = Math.ceil(st);
    } else {
        data.serviceTax = 0;
        $.each(data.itemDetails || [], function (i, item) {
            item.serviceTax = 0;
        });
    }

    if (err) {
        return;
    }

    $('#form-bttons').hide();
    $('#action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-gst-cargo",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    cancelEditDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });

    ga_track_event('LR Details', 'Edit GST / Invoice', '');
}

function showReturnCargo(lr) {
    $('#return-lr-dialog').removeClass('hide');
    $('#return-lr-dialog').dialog({
        autoOpen: true,
        height: 375,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#return-lr-branch').val(lrdata.fromOrganization.code).trigger('change');
    $('#return-remarks').val('');
}

function hideReturnCargo() {
    $('#return-lr-dialog').dialog('destroy');
    $('#return-lr-dialog').hide();
}

function saveReturnCargo() {
    var bookreturn = $('#return-book-cb').is(':checked');

    var data = {};
    data.cargoCode = lrdata.code;
    data.toOrganization = {};
    
    if (bookreturn) {
        data.toOrganization.code = $('#return-lr-branch').val();
    } else {
        data.toOrganization.code = lrdata.fromOrganization.code;
    }

    data.additionalAttribute = {};
    data.additionalAttribute.CREATE_RETURN_LR_FLAG = +$('#return-newbook-cb').is(':checked');

    data.remarks = [];

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#return-remarks').val().trim();
    remarks.cargoStatusCode = 'CR';
    data.remarks.push(remarks);

    $('#return-lr-branch').removeClass('inp_error');
    if (!data.toOrganization.code) {
        $('#return-lr-branch').addClass('inp_error');
        return;
    }
    $('#return-lr-panel-btn').hide();
    $('#return-lr-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-return-booking",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#return-lr-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    if (data.additionalAttribute.CREATE_RETURN_LR_FLAG == 1) {
                        window.open('#cargo/booking?referenceLR=' + data.cargoCode, '_blank');
                    }
                    hideReturnCargo();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#return-lr-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#return-lr-panel-btn').show();
            }
        }
    })
}

function editTransitDialog(lr) {
    $('#edit-transit-dialog').removeClass('hide');
    $('#edit-transit-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
}

function hideTransitBranchDialog() {
    $('#edit-transit-dialog').dialog('destroy');
    $('#edit-transit-dialog').hide();
}

function saveTransitBranch() {
    var data = {}, err = 0;
    data.lr = lrdata || {};
    data.lr.transitOrganization = {};
    data.lr.transitOrganization.code = $('#edit-transit-branch').val();
    data.lr.remarks = [];

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#edit-transit-remarks').val().trim();
    remarks.cargoStatusCode = 'CL';
    data.lr.remarks.push(remarks);

    $('.inp_error').removeClass('inp_error');
    if (!data.lr.transitOrganization.code) {
        $('#edit-transit-branch').addClass('inp_error');
        err++;
    }
    if (!remarks.name) {
        $('#edit-transit-remarks').addClass('inp_error');
        $('#edit-transit-remarks').focus();
        err++;
    }
    if(err) {
        $('#edit-transit-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#edit-transit-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    $('#edit-transit-panel-btn').hide();
    $('#edit-transit-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-save-cargo",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#edit-transit-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    hideTransitBranchDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#edit-transit-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#edit-transit-panel-btn').show();
            }
        }
    })
}

function removeOGPLDialog(lr) {
    $('#remove-ogpl-dialog').removeClass('hide');
    $('#remove-ogpl-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
}

function hideRemoveOGPLDialog() {
    $('#remove-ogpl-dialog').dialog('destroy');
    $('#remove-ogpl-dialog').hide();
}

function saveRemoveOGPL() {
    var data = {}, err = 0;

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#remove-ogpl-remarks').val().trim();
    remarks.cargoStatusCode = 'CL';

    data = remarks;
    data.cargoCode = lrdata.code;

    $.each(lrdata.transitCargoDetails.reverse() || [], function (i, row) {
        data.transitDetailsCode = row.code;
        return false;
    });
    $('.inp_error').removeClass('inp_error');
    if (!remarks.name) {
        $('#remove-ogpl-remarks').addClass('inp_error');
        $('#remove-ogpl-remarks').focus();
        err++;
    }
    if(err) {
        $('#remove-ogpl-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#remove-ogpl-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    
    if (!confirm('Do you want to remove this '+lang.lr+' from <?php echo lang('ogpl');?>
?')) {
        return;
    }

    $('#remove-ogpl-panel-btn').hide();
    $('#remove-ogpl-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/ogpl-remove-lr",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#remove-ogpl-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    hideRemoveOGPLDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#remove-ogpl-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#remove-ogpl-panel-btn').show();
            }
        }
    })
}

function toggleDeliverOTP(cb) {
    $('#send-delopt-cont, #enter-delopt-cont').toggleClass('hide', cb.checked);
}



function showEditPaymentType(lr) {
    $('#edit-paytype-dialog').removeClass('hide');
    $('#edit-paytype-dialog').dialog({
        autoOpen: true,
        height: 550,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    var paymentHtml = '';
    data = {};
    data.fromOrganization =lrdata.fromOrganization.code;
    data.toOrganization = lrdata.toOrganization.code;
    var isPaymentCode = lrdata.paymentType.code;
    $('#edit-paytype-radios').html(loading_small);
    // work
    $.ajax({
        type: "post",
        url: "cargo/payment-type",
        data: data,
        dataType: "json",
        success: function (response) {
         
             paymentHtml = '';
            if(response.status == 0){
                alert('error');
                return;
            }
        var fromBookingTypes = response.data.fromOrganization[0];  //booking payment types
        var bookingArray = [];
        var bookingPaymentTypes = {};
        $.each(fromBookingTypes.bookingPaymentTypes || [], function(i, e) {
            bookingPaymentTypes[e.code] = data.fromOrganization;
            bookingArray.push(e);
        });

        var toBookingTypes = response.data.toOrganization[0]; //delivery payment types
        var deliveryArray = [];
        var deliveryPaymentTypeList = {};
        $.each(toBookingTypes.deliveryPaymentTypes || [], function(i, e) {
            deliveryPaymentTypeList[e.code] = data.toOrganization;
            deliveryArray.push(e);
        });
        var result = findIntersection(bookingArray,deliveryArray);
        if (deliveryArray.length == 0) {
            $.each(bookingArray || [], function(i, val) {
                if(val.code == "INP"){
                    val.name = '<?php echo lang('INP');?>
';
                }
                if(val.code == "OATP"){
                    val.name = '<?php echo lang('OATP');?>
';
                }
                paymentHtml += '<span class="radio">' +
                        '<label>' +
                            '<input type="radio" class="' + val.code + '" name="edit_pay_type_radio" value="' + val.code + '">' + val.name +
                        '</label>' +
                    '</span>';
            });
        }else{
            $.each(result || [], function(i, val) {
            if(val.code == "INP"){
                val.name = '<?php echo lang('INP');?>
';
            }
            if(val.code == "OATP"){
                val.name = '<?php echo lang('OATP');?>
';
            }
            paymentHtml += '<span class="radio">' +
                        '<label>' +
                            '<input type="radio" class="' + val.code + '" name="edit_pay_type_radio" value="' + val.code + '">' + val.name +
                        '</label>' +
                    '</span>';
        });
        }
       
            $('#edit-paytype-radios').html(paymentHtml);
            $('.'+isPaymentCode+'').prop('checked', true).trigger('change');
        }
    });
    return;
    
}

function hideEditPaymentType() {
    $('#edit-paytype-dialog').dialog('destroy');
    $('#edit-paytype-dialog').hide();
}

function onchangePayType() {
    var paytype = $('[name="edit_pay_type_radio"]:checked').val() || '';
    $('#edit-paytype-vendor-cont').val('').addClass('hide');
    if (paytype == 'INP' || paytype == 'OATP') {
        $('#edit-paytype-vendor-cont').removeClass('hide');
    }
}

function saveEditPaymentType() {
    var data = {}, err = 0;
    data.code = lrdata.code;
    data.paymentType = {};
    data.paymentType.code = $('[name="edit_pay_type_radio"]:checked').val();

    $('.inp_error').removeClass('inp_error');
    if (!data.paymentType.code) {
        $('[name="edit_pay_type_radio"]').addClass('inp_error');
        err++;
    }
    if (data.paymentType.code == 'INP' || data.paymentType.code == 'OATP') {
        data.vendorUser = {};
        data.vendorUser.code = $('#edit-paytype-vendor').val();

        if (!data.vendorUser.code) {
            $('#edit-paytype-vendor').addClass('inp_error');
            err++;
        }
    }

    if(err) {
        $('#edit-paytype-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#edit-paytype-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    
    if (!confirm('Do you want to change payment type for this '+lang.lr+'?')) {
        return;
    }

    $('#edit-paytype-panel-btn').hide();
    $('#edit-paytype-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-paytype-lr",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#edit-paytype-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    hideEditPaymentType();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#edit-paytype-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#edit-paytype-panel-btn').show();
            }
        }
    });
}

function showEditPaymentMode(mode, userCode) {
    $('#edit-paymode-dialog').removeClass('hide');
    $('#edit-paymode-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#edit-paymode-radios [name="edit_paymode_radio"][value="' + mode + '"]').prop('checked', true).trigger('change');
    $('#edit-paymode-hidden-usercode').val(userCode);
    $('#edit-paymode-action-state').removeClass('alert alert-danger alert-success').html('');
    $('#edit-paymode-panel-btn').show();
}

function hideEditPaymentMode() {
    $('#edit-paymode-dialog').dialog('destroy');
    $('#edit-paymode-dialog').hide();
}


function saveEditPaymentMode() {
    var data = {}, err = 0;
    data.cargoCode = lrdata.code;
    data.code = cargoTransactionList[cargoTransactionList.length-1].code;
    data.user = {};
    data.user.code = $('#edit-paymode-hidden-usercode').val();
    data.transactionMode = {};
    data.transactionMode.code = $('[name="edit_paymode_radio"]:checked').val();

    $('.inp_error').removeClass('inp_error');
    if (!data.transactionMode.code) {
        $('[name="edit_paymode_radio"]').addClass('inp_error');
        err++;
    }

    if (data.transactionMode.code == 'UPI') {
                data.bankDetails = {};
                data.bankDetails.code = $('#upi-orgbank-detail').val();
                data.additionalAttribute = {};
                data.additionalAttribute.UPI_ID = $.trim($('#upi-id-detail').val());
                data.additionalAttribute.REFERENCE_DETAILS = $.trim($('#upi-details-detail').val());
                
                if (isNull(data.bankDetails.code)) {
                    $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please select Organization Bank').show();
                    $('#upi-orgbank-detail').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(data.additionalAttribute.UPI_ID)) {
                    $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please enter a valid UPI ID').show();
                    $('#upi-id-detail').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(data.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please enter a valid UPI Ref. #').show();
                    $('#upi-details-detail').addClass('inp_error').focus();
                    return;
                }
            } else if (data.transactionMode.code == 'NBK') {
                data.bankDetails = {};
                data.bankDetails.code = $('#netbanking-orgbank-detail').val();
                data.additionalAttribute = {};
                data.additionalAttribute.ACC_HOLDER_NAME = $.trim($('#netbanking-accholder-detail').val());
                data.additionalAttribute.BANK_NAME = $.trim($('#netbanking-bankname-detail').val());
                data.additionalAttribute.REFERENCE_DETAILS = $.trim($('#netbanking-details-detail').val());
                
                if (isNull(data.bankDetails.code)) {
                    $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please select Organization Bank').show();
                    $('#netbanking-orgbank-detail').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(data.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please enter a valid Netbanking / Bank Transfer Ref. #').show();
                    $('#netbanking-details-detail').addClass('inp_error').focus();
                    return;
                }
               }     
            // } else if (data.transactionMode.code == 'CHEQUE') {
            //     var chequeDetails = {};
            //     chequeDetails.organization = {};
            //     chequeDetails.organization.code = login_branch_code;
            //     chequeDetails.bankDetails = $.trim($('#cheque-bankname-detail').val());
            //     chequeDetails.payerDetails = $.trim($('#cheque-payer-detail').val());
            //     chequeDetails.chequeDate = moment($('#cheque-date-detail').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
            //     chequeDetails.chequeNo = $.trim($('#cheque-no-detail').val());
            //     chequeDetails.bankCity = $.trim($('#cheque-bankcity-detail').val());
            //     chequeDetails.chequeStatus = {};
            //     chequeDetails.chequeStatus.code = 'NEW';
            //     chequeDetails.remarks = $.trim($('#cheque-remarks-detail').val());
    
            //     if (isNull(chequeDetails.payerDetails)) {
            //         $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please enter valid payer details').show();
            //         $('#cheque-payer-detail').addClass('inp_error').focus();
            //         return;
            //     }
            //     if (isNull(chequeDetails.chequeNo)) {
            //         $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please enter valid cheque no').show();
            //         $('#cheque-no-detail').addClass('inp_error').focus();
            //         return;
            //     }
            //     // if (!moment($('#cheque-date').val(), 'DD-MM-YYYY').isValid()) {
            //     //     $('#edit-paymode-action-state').html('Please enter valid cheque date').show();
            //     //     $('#cheque-date-detail').addClass('inp_error').focus();
            //     //     return;
            //     // }
            //     if (isNull(chequeDetails.bankCity)) {
            //         $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please enter valid bank city').show();
            //         $('#cheque-bankcity-detail').addClass('inp_error').focus();
            //         return;
            //     }
            //     if (isNull(chequeDetails.bankDetails)) {
            //         $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').html('Please enter valid Organization Bank').show();
            //         $('#cheque-bankname-detail').addClass('inp_error').focus();
            //         return;
            //     }
            //     data.chequeDetails = chequeDetails;
            // }


    if(err) {
        $('#edit-paymode-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#edit-paymode-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    
    if (!confirm('Do you want to change transaction mode for this User?')) {
        return;
    }

    $('#edit-paymode-panel-btn').hide();
    $('#edit-paymode-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-paymode-lr",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#edit-paymode-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    hideEditPaymentMode();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#edit-paymode-action-state').addClass('alert').addClass('alert-danger').html("unable to Update The Details");
                $('#edit-paymode-panel-btn').show();
            }
        }
    });
}

function undoUnload(code) {
    var data = {};
    data.code = code;
    $('#cd-btn-panel').hide();
    $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/undo-unload-lr",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#cd-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    getCargoDetails(code);
                }, 3000);
            } else {
                $('#cd-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#cd-btn-panel').show();
            }
        }
    })
}

function getDemurrageAndDeliver(callback) {
    $('#demurrage-charge').val('');
    $('#demurrage-charge').closest('.demurrage-charge-cont').addClass('hide');

    if (lrdata.paymentType.code == 'INP' || lrdata.paymentType.code == 'OATP' || !cargoSetting.demurrageTerms || !cargoSetting.demurrageTerms.length) {
        callback();
        return;
    }

    var data = {};
    data.cargoCode = lrdata.code;
    
    var loading_overlay = iosOverlay({
        text: "Calculating Demurrage",
        icon: "fa fa-spinner fa-spin"
    });

    $('#mk-pay-save-btn').prop('disabled', true);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/check-demurrage-charge",
        data: data,
        success: function (response) {
            $('#mk-pay-save-btn').prop('disabled', false);
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Done!"
                });
                if (Number(response.data.daysCount) > 0) {
                    $('#demurrage-charge').closest('.demurrage-charge-cont').removeClass('hide');
                    $('#demurrage-charge').val(Number(response.data.demurrageCharge)).trigger('blur');
                }
            } else {
                alert(response.errorDesc);
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Failed!"
                });
            }
            callback();
            window.setTimeout(function () {
                loading_overlay.hide();
            }, 1000);
        }
    });
}

function showPrintPreferences() {
    $('#print-preferences-dialog').removeClass('hide');
    $('#print-preferences-dialog').dialog({
        autoOpen: true,
        height: 365,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });

    var $option = $('#print-preferences-panel [name="print-pref-radio"]:checked');
    if ($option.length) {
        $option.get(0).focus();
    }
}

function hidePrintPreferences() {
    $('#print-preferences-dialog').dialog('destroy');
    $('#print-preferences-dialog').hide();
}

function printUsingPreferences() {
    var $option = $('#print-preferences-panel [name="print-pref-radio"]:checked');

    var print = $option.val();
    var params = {};
    params.code = lrdata.code;

    switch (print) {
        case '3INCH':
            params.type = '3';
            params.markingtoken = +$('#marking-token-cb').is(':checked');
            params.copies = +$('#thermal-print-copies').val() || 1;
            break;
        case 'DOTMATRIX':
            params.type = 'dotmatrix';
            if (['citycargo', 'cityparcel'].includes(namespaceCode) && bookingpage == 1) {
                params.printType = bookingpage;
            }
            break;
        case '2COLUMN':
            params.type = 'grid';
            break;
        case '1COPY':
            params.count = 1;
            if (['citycargo', 'cityparcel'].includes(namespaceCode) && bookingpage == 1) {
                params.printType = bookingpage;
            }
            break;
        case '2COPY':
            params.count = 2;
            break;
        case '3COPY':
            params.count = 3;
            break;
        case 'Print':
            break;
        default:
            alert('Please select a print option');
            return;
    }

    if (print == 'Print') {
        if ($('#label-print-cb').is(':checked')) {
            var commandsList = [];
            $('#label-printing-commands > script').each(function() {
                commandsList.push($(this).html().trim());
            });
            epPrintCommands(commandsList, 'LABEL');
        }
        savePrintPreferences(print);
        return;
    }

    var url = base_url + 'cargo/print-cargo-summary?' + $.param(params);
    if (epIsActive()) {
        if (print == 'DOTMATRIX' && ['rmtcargo', 'rathimeenaparcel', 'kntlogistics', 'citycargo', 'cityparcel'].includes(namespaceCode)) {
            epPrintUrlCommands(url);
        } else if (print == '3INCH') {
            epPrintUrlHtml(url, { copies: params.copies });
        } else {
            epFetchAndPrint(url);
        }

        if ($('#label-print-cb').is(':checked')) {
            var commandsList = [];
            $('#label-printing-commands > script').each(function () {
                commandsList.push($(this).html().trim());
            });

            epPrintCommands(commandsList, 'LABEL');
        }
    } else if (print == '3INCH') {
        window.open(url, '_blank', 'toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=288, height=550');
    } else {
        window.open(url, '_blank');
    }

    savePrintPreferences(print);

    var event = $option.data('eventtype');
    ga_track_event(''+lang.lr+' Print', event, '');
}

function savePrintPreferences(print) {
    var preferences = {};
    preferences.print = print;
    preferences.mark = $('#marking-token-cb').is(':checked');
    preferences.label = $('#label-print-cb').is(':checked');
    preferences.copies = +$('#thermal-print-copies').val();

    applyPrintPreferences(preferences);
    localStorage.setItem('lr-print-preferences', JSON.stringify(preferences));
}

function applyPrintPreferences(preferences) {
    if (!preferences) {
        preferences = JSON.parse(localStorage.getItem('lr-print-preferences')) || {};
    }
    if(localStorage.getItem('label')){
        alert('lebel selected');
    }
    preferences.print = preferences.print;

    var $option = $('#print-preferences-panel [name="print-pref-radio"][value="' + preferences.print + '"]');

    if (!$option.length) {
        $option = $('#print-preferences-panel [name="print-pref-radio"]:first');
    }

    $option.prop('checked', true);

    var epActive = epIsActive();  //is connect with ezee print application (boolean)
    if($option.closest('label').text().trim()=="None"){
        $('#print-button').html("Print");
    }else{
        $('#print-button').html($option.closest('label').text().trim());
    }
    
    $('#marking-token-cb').prop('checked', Boolean(preferences.mark));
    $('#label-print-cb').prop('checked', Boolean(preferences.label)).prop('disabled', !epActive);

    $('#thermal-print-copies').val(preferences.copies || 1);

    if (epActive) {
        $('#print-preferences-panel .print-pref-epstatus').removeClass('text-danger').html('');
    } else {
        $('#print-preferences-panel .print-pref-epstatus').addClass('text-danger').html('Ezeeprint not active');
    }
}
applyPrintPreferences();

function printPreferencesChanged() {
    var $option = $('#print-preferences-panel [name="print-pref-radio"]:checked');
    var print = $option.val();

    $('#marking-token-cb').prop('disabled', print != '3INCH');
}

function showRevertMissingCargo() {
    $('#revert-missing-dialog').removeClass('hide');
    $('#revert-missing-dialog').dialog({
        autoOpen: true,
        height: 300,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#revert-missing-branch').val(lrdata.transitOrganization.code).trigger('change');
}

function hideRevertMissingDialog() {
    $('#revert-missing-dialog').dialog('destroy');
    $('#revert-missing-dialog').hide();
}

function saveRevertMissing() {
    var data = {}, err = 0;
    data.code = lrdata.code;
    data.transitOrganization = {};
    data.transitOrganization.code = $('#revert-missing-branch').val();

    data.statusCode = (data.transitOrganization.code == lrdata.fromOrganization.code) ? 'CB' : 'CUL';

    data.remarks = [];

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#edit-transit-remarks').val().trim();
    remarks.cargoStatusCode = data.statusCode;
    data.remarks.push(remarks);

    $('.inp_error').removeClass('inp_error');
    if (!data.transitOrganization.code) {
        $('#revert-missing-branch').addClass('inp_error');
        err++;
    }
    if(err) {
        $('#revert-missing-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#revert-missing-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    $('#revert-missing-panel-btn').hide();
    $('#revert-missing-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/revert-cargo-missing",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#revert-missing-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    hideRevertMissingDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#revert-missing-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#revert-missing-panel-btn').show();
            }
        }
    })
}

function showProofDialog(category) {
    $('#proof-document-title').html('Proof of ' + (category == 'POB' ? 'Booking' : 'Delivery'));
    $('#proof-document-dialog').removeClass('hide');
    $('#proof-document-dialog').dialog({
        autoOpen: true,
        maxHeight: 600,
        width: 600,
        modal: true,
        closeOnEscape:true,
        resizable: false,
        position: { my: 'top', at: 'top', of: '#dia-cargo-details' }
    });
    $(".ui-dialog-titlebar").hide();

    $('.inp_error').removeClass('inp_error');
    $('#proof-document-category').val(category);
    $('#proof-document-type').prop('selectedIndex', 0);
    $('#proof-document-no').val('');
    $('#proof-mobile-no').val('');
    $('#proof-document-action-state').hide();
    proofupload.clearFiles();
}

function hideProofDialog() {
    closeWebcam();
    clear_snapshot();
    $('#proof-document-dialog').dialog('destroy');
    $('#proof-document-dialog').hide();
}

function validateNumberInput(input, maxLength) {
    input.val(input.val().replace(/[^0-9]/g, ''));

    if (input.val().length > maxLength) {
        input.val(input.val().slice(0, maxLength));
    }
}

function validateMobileNumberInput() {
    var input = $('#proof-mobile-no');
    validateNumberInput(input, 10);
}

function saveProofDocument() {
    var data = {}, err = 0;
    data.imageCategoryCode = 'LRPROOF';
    data.cargoCode = lrdata.code;
    data.documentCategory = {};
    data.documentCategory.code = $.trim($('#proof-document-category').val());
    data.documentType = {};
    data.documentType.code = $.trim($('#proof-document-type').val());
    data.documentNumber = $.trim($('#proof-document-no').val());
    data.mobileNumber = $.trim($('#proof-mobile-no').val());

    $('.inp_error').removeClass('inp_error');

    //mobile number
    if(data.mobileNumber !=''){
        if (data.mobileNumber.length !== 10) {
            $('#proof-mobile-no').addClass('inp_error');
            err++;
        }
    }
       // Validate document type
       if (!data.documentType.code) {
        $('#proof-document-type').addClass('inp_error');
        err++;
    }


    if (err) {
        $('#proof-document-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#proof-document-action-state').html('Please enter/select the values in the fields that are marked in red');
        return;
    } else {
        $('#proof-document-action-state').removeClass('alert alert-danger').addClass('alert-success hide').hide();
    }

    $('#captured_image img').each(function() {
        var data_uri = $(this).attr('src');
        if (isNotNull(data_uri)) {
            var url = "config/store-webcam-files";
            Webcam.upload(data_uri, url, data);
        }
    });

    proofupload.startUpload({
        data: data,
        onComplete: function () {
            hideProofDialog();
            // getCargoDetails(lrdata.code);
        }
    });
}

$('#proof-mobile-no').on('input', validateMobileNumberInput);



function remarksLimitHint() {
    var remarks = $('#return-remarks').val() || '';
    $('#return-remarks-info').toggleClass('hide', remarks.trim().length > 20);
}

function revertUnableDeliver() {
    var data = {};
    data.cargoCode = lrdata.code;
    data.cargoStatusCode = lrdata.cargoStatus.code;

    var loading_overlay = iosOverlay({
        text: "Please Wait...",
        icon: "fa fa-spinner fa-spin"
    });

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/revert-unable-deliver",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
                window.setTimeout(function () {
                    loading_overlay.hide();
                    getCargoDetails(lrdata.code);
                }, 2000);
            } else {
                alert(response.errorDesc);
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Failed!"
                });
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        }
    });
}

function printReceiptUsingPreferences() {
   
    var params = {};
    params.code = lrdata.code;

    var url = base_url + 'cargo/print-delivery-receipt?' + $.param(params);
    if (epIsActive()) {
        epFetchAndPrint(url);
    } else {
        window.open(url, '_blank');
    }

    ga_track_event(''+lang.lr+' Print', 'Delivery Receipt', '');
}

function showReceiptPrintPreferences() {
    $('#print-receipt-preferences-dialog').removeClass('hide');
    $('#print-receipt-preferences-dialog').dialog({
        autoOpen: true,
        height: 360,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });

    var $option = $('#print-receipt-preferences-panel [name="print-pref-radio"]:checked');
    if ($option.length) {
        $option.get(0).focus();
    }
}

function hideReceiptPrintPreferences() {
    $('#print-receipt-preferences-dialog').dialog('destroy');
    $('#print-receipt-preferences-dialog').hide();
}

function printReceiptUsingPreferences() {
    var $option = $('#print-receipt-preferences-panel [name="print-pref-radio"]:checked');
    var netamount = $('#payment_amount').val();

    if(netamount ==''){
        netamount=deliveryAmt;
    }

    var print = $option.val();
    var params = {};
    params.code = lrdata.code;

    switch (print) {
        case '3INCH':
            params.type = '3';
            params.amountpaid = netamount;
            // params.markingtoken = +$('#marking-token-cb').is(':checked');
            break;
        case 'DOTMATRIX':
            params.type = 'dotmatrix';
            params.amountpaid = netamount;
            break;
        case '2COLUMN':
            params.type = 'grid';
            break;
        case '1COPY':
            params.count = 1;
            params.amountpaid = netamount;
            break;
        case '2COPY':
            params.count = 2;
            params.amountpaid = netamount;
            break;
        case '3COPY':
            params.count = 3;
            break;
        case 'Print':
            break;
        default:
            alert('Please select a print option');
            return;
    }
       if (print == 'Print') {
            if ($('#label-print-cb').is(':checked')) {
                var commandsList = [];
                $('#label-printing-commands > script').each(function() {
                    commandsList.push($(this).html().trim());
                });
                epPrintCommands(commandsList, 'LABEL');
            }
            savePrintPreferences(print);
            return;
        }
    var url = base_url + 'cargo/print-delivery-receipt?' + $.param(params);
    if (epIsActive()) {
        if (print == 'DOTMATRIX' && ['rmtcargo', 'rathimeenaparcel', 'citycargo', 'cityparcel'].includes(namespaceCode)) {
            epPrintUrlCommands(url);
        } else if (print == '3INCH') {
            epPrintUrlHtml(url);
        } else {
            epFetchAndPrint(url);
        }

        if ($('#label-print-cb').is(':checked')) {
            var commandsList = [];
            $('#label-printing-commands > script').each(function () {
                commandsList.push($(this).html().trim());
            });

            epPrintCommands(commandsList, 'LABEL');
        }
    } else if (print == '3INCH') {
        window.open(url, '_blank', 'toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=288, height=550');
    } else {
        window.open(url, '_blank');
    }

    saveReceiptPrintPreferences(print);

    var event = $option.data('eventtype');
    ga_track_event('Delivery Receipt Print', event, '');
}

function saveReceiptPrintPreferences(print) {
    var preferences = {};
    preferences.print = print;
    // preferences.mark = $('#marking-token-cb').is(':checked');
    // preferences.label = $('#label-print-cb').is(':checked');

    applyReceiptPrintPreferences(preferences);
    localStorage.setItem('delivery-receipt-print-preferences', JSON.stringify(preferences));
}

function applyReceiptPrintPreferences(preferences) {
    if (!preferences) {
        preferences = JSON.parse(localStorage.getItem('delivery-receipt-print-preferences')) || {};
    }
    preferences.print = preferences.print;

    var $option = $('#print-receipt-preferences-panel [name="print-pref-radio"][value="' + preferences.print + '"]');

    if (!$option.length) {
        $option = $('#print-receipt-preferences-panel [name="print-pref-radio"]:first');
    }

    $option.prop('checked', true);

    var epActive = epIsActive();

    // $('#print-receipt-button').html($option.closest('label').text().trim());
    // $('#marking-token-cb').prop('checked', Boolean(preferences.mark));
    // $('#label-print-cb').prop('checked', Boolean(preferences.label)).prop('disabled', !epActive);

    if (epActive) {
        $('#print-receipt-preferences-panel .print-pref-epstatus').removeClass('text-danger').html('');
    } else {
        $('#print-receipt-preferences-panel .print-pref-epstatus').addClass('text-danger').html('Ezeeprint not active');
    }
}
applyReceiptPrintPreferences();

function receiptPrintPreferencesChanged() {
    var $option = $('#print-receipt-preferences-panel [name="print-pref-radio"]:checked');
    var print = $option.val();
   $('#marking-token-cb').prop('disabled', print != '3INCH');
}

function hideLRActivityDialog() {
    $('#lr-activity-dialog').dialog('destroy');
    $('#lr-activity-dialog').hide();
}

function showDoorDelivery() {
    $('#lr-activity-dialog').removeClass('hide');
    $('#lr-activity-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 700,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });

    var data = {};
    data.customerCode = lrdata.toCustomer.code;
    data.vendorUserCode = lrdata.vendorUser.code;
    data.paymentTypeCode = lrdata.paymentType.code;
    data.toStationCode = lrdata.toStation.code;
    $('#lr-activity').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/edit-door-delivery",
        data: data,
        success: function (response) {
            $('#lr-activity').html(response);
        }
    });
}

function showDoorPickup() {
    $('#lr-activity-dialog').removeClass('hide');
    $('#lr-activity-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 700,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });

    var data = {};
    data.customerCode = lrdata.fromCustomer.code;
    data.vendorUserCode = lrdata.vendorUser.code;
    data.paymentTypeCode = lrdata.paymentType.code;
    data.toStationCode = lrdata.toStation.code;
    data.fromStation = lrdata.fromStation.code;
    $('#lr-activity').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/edit-door-pickup",
        data: data,
        success: function (response) {
            $('#lr-activity').html(response);
        }
    });
}

function lrHasRCMBasedGST(form = false) {
    var senderGST = form ? $.trim($('#edit_sender_gstin').val()) : lrdata.fromCustomerGST;
    var receiverGST = form ? $.trim($('#edit_receiver_gstin').val()) : lrdata.toCustomerGST;
    var payment_type = lrdata.paymentType.code;

    if (cargoSetting.lrGstTaxModel == 'RCMGST') {
        return isValidGstin(senderGST) && isValidGstin(receiverGST);
    }
    if (cargoSetting.lrGstTaxModel == 'RCMEOGST') {
        return isValidGstin(senderGST) || isValidGstin(receiverGST);
    }

    if (cargoSetting.lrGstTaxModel == 'RCMPYGST') {
        if (payment_type == 'PAD') {
            return isValidGstin(senderGST);
        }
        if (payment_type == 'TOP') {
            return isValidGstin(receiverGST);
        }
    }

    return false;
}

function checkDuplicateEditEwayBill(ele) {
    var ewayBill = $(ele).val();
    var curentRow = $(ele).closest("tr").index();

    var ewayBillNumberArray = [];
    $('#edit-invoice-list .edit-invoice-row').each(function(index, val) {
        var ewayBill = $.trim($(val).find('.edit_eway_bill_number').val());
        if (index != curentRow) {
            ewayBillNumberArray.push(ewayBill);
        }
    })
    
    if ($.inArray(ewayBill, ewayBillNumberArray) != -1) {
        $(ele).val('');
    }
}

function addInvoiceEditRow() {
    var totalInvocie = $('#edit-invoice-list .edit-invoice-row').length;
    if (totalInvocie > 4) {
        return;
    }

    var $tpl = $('#edit-invoice-row-tpl .edit-invoice-row').clone();
    $('#edit-invoice-list').append($tpl);

    $tpl.find('[data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });

    $tpl.find('.edit_inv_date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-1d',
        endDate:'0d'
    });

    $('#edit-invoice-table-panel').removeClass('hide');
    return $tpl;
}

function removeInvoiceEditRow(btn) {
    $(btn).closest('.edit-invoice-row').remove();

    if (!$('#edit-invoice-list .edit-invoice-row').length) {
        addInvoiceRow();
    }
}

function setPaymentTransactionMode(type) {
    var mode = $('#pay-transaction-mode-'+type).val();

    $('#pay-cheque-mode-panel-'+type).addClass('hide');
    $('#pay-netbanking-mode-panel-'+type).addClass('hide');
    $('#pay-upi-mode-panel-'+type).addClass('hide');


    if (mode == 'CHEQUE') {
        $('#pay-cheque-mode-panel-'+type).removeClass('hide');
    } else if (mode == 'NBK') {
        $('#pay-netbanking-mode-panel-'+type).removeClass('hide');

        $('#pay-netbanking-orgbank-'+type).html(new Option('Loading...', '', true, true)).select2().html('');
    } else if (mode == 'UPI') {
        $('#pay-upi-mode-panel-'+type).removeClass('hide');
        
        $('#pay-upi-orgbank-'+type).html(new Option('Loading...', '', true, true)).select2().html('');
    }

    var data = {};
    data.organizationcode = lrdata.toOrganization.code;

    if (!data.organizationcode) {
        return;
    }

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'cargo/get-organization-other-details',
        data: data,
        success: function (res) {
            if (res.status == 1) {
                res.data.bankDetails = res.data.bankDetails || [];
                if (mode == 'NBK') {
                    $('#pay-netbanking-orgbank-'+type).html('').prop('disabled', false);
                    if (res.data.bankDetails.length > 1) {
                        $('#pay-netbanking-orgbank-'+type).html(new Option('Select Organization Bank', ''));
                    }
                    if (res.status == 1) {
                        $.each(res.data.bankDetails || [], function (i, bank) {
                            if (bank.accountType.code != 'CASH') {
                                $('#pay-netbanking-orgbank-'+type).append(new Option(bank.name + ' - ' + bank.accountNumber, bank.code));
                            }
                        });
                    }
                    $('#pay-netbanking-orgbank-'+type).select2();
                } else if (mode == 'UPI') {
                    $('#pay-upi-orgbank-'+type).html('').prop('disabled', false);
                    if (res.data.bankDetails.length > 1) {
                        $('#pay-upi-orgbank-'+type).html(new Option('Select Organization Bank', ''));
                    }
                    if (res.status == 1) {
                        $.each(res.data.bankDetails || [], function (i, bank) {
                            if (bank.accountType.code != 'CASH') {
                                $('#pay-upi-orgbank-'+type).append(new Option(bank.name + ' - ' + bank.accountNumber, bank.code));
                            }
                        });
                    }
                    $('#pay-upi-orgbank-'+type).select2();
                }
            }
        }
    });
}

function editBookingDate() {
    $('#dia-cargo-edit').removeClass('hide');
    $('#dia-cargo-edit').dialog({
        autoOpen: true,
        height: 325,
        width: 450,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    var tmp = $('#template-edit-booking-date').html();
    $('#dia-cargo-edit').html(tmp);

    maxbookingDateEditable = cargoSetting.bookingDateEditDaysLimit;
    $('#lr-booked-date').daterangepicker({
        singleDatePicker: true,
        timePicker: true,
        timePickerIncrement: 1,
        format: 'DD-MM-YYYY hh:mm A',
        minDate: moment().subtract(maxbookingDateEditable, 'd').startOf('d'),
        maxDate: moment(),
        autoApply: false,
        showDropdowns: false,
    }).on('hide.daterangepicker', function(ev, picker) {
        picker.updateInputText();
    });

    var picker = $('#lr-booked-date').data('daterangepicker');
    picker.setStartDate(moment(lrdata.bookedAt));
    picker.updateInputText();
}

function saveBookingDate() {
    $('#vendorName').removeClass('inp_error');
    var data = {};
    data.code = lrdata.code;
    data.bookedAt = $('#lr-booked-date').data('daterangepicker').startDate.format('YYYY-MM-DD HH:mm:ss');
    data.remarks = [];

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#lr-bookeddate-remarks').val().trim();
    remarks.cargoStatusCode = 'CB';
    data.remarks.push(remarks);

    if (!$('#lr-booked-date').data('daterangepicker').startDate.isValid()) {
        $('#lr-booked-date').addClass('inp_error');
        return; 
    }

    $('#form-bttons').hide();
    $('#action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-lr-booked-date",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    cancelEditDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
}

function editAdjustmentAmount() {
    $('#dia-cargo-edit').removeClass('hide');
    $('#dia-cargo-edit').dialog({
        autoOpen: true,
        height: 350,
        width: 450,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    var tmp = $('#template-edit-adjustment').html();
    $('#dia-cargo-edit').html(tmp);
    
    $('#lr-adjustment-remarks').autocomplete({
        minLength: 0,
        source: _.filter(cargoRemarksList || [], r => r.cargoStatus.code == 'ADJST').map(r => r.name),
        appendTo: '#dia-cargo-edit'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });
    
    $('#dia-cargo-edit').find('[data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });
    // $('#lr-adjustment-amount').val();
}

function saveAdjustmentAmount() {
    $('#dia-cargo-edit .inp_error').removeClass('inp_error');
    var data = {};
    data.code = lrdata.code;
    data.additionalAttribute = {};
    data.additionalAttribute.ADJSMT = $.trim($('#lr-adjustment-amount').val());

    data.remarks = [];

    var adjustmentRemarks = {};
    adjustmentRemarks.code = '';
    adjustmentRemarks.name = $('#lr-adjustment-remarks').val().trim();
    adjustmentRemarks.cargoStatusCode = 'ADJST';
    data.remarks.push(adjustmentRemarks);

    var err = 0
    if (data.additionalAttribute.ADJSMT == '' || isNaN(data.additionalAttribute.ADJSMT)) {
        $('#lr-adjustment-amount').addClass('inp_error');
        err++;
    }
    if (adjustmentRemarks.name == '') {
        $('#lr-adjustment-remarks').addClass('inp_error');
        err++;
    }
    if (err) {
        return;
    }

    $('#form-bttons').hide();
    $('#action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-cargo-charges",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    cancelEditDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
}

function calcDeliveryTDSPercent(percent) {
    $('#delivery_tds_tax').val('0').prop('disabled', percent == 0);
    calcDeliveryPayment();
}

function showDeliveryFollowUp() {
    $('#lr-activity-dialog').removeClass('hide');
    $('#lr-activity-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 700,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });

    getFollowUpDetails();
}

function getFollowUpDetails() {
    var data = {};
    data.cargoCode = lrdata.code;
    
    $('#lr-activity').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/delivery-follow-up",
        data: data,
        success: function (response) {
            $('#lr-activity').html(response);
        }
    });
}

function editDDHandoverDialog(lr) {
    $('#dd-handover-dialog').removeClass('hide');
    $('#dd-handover-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
}

function editPrivateMark(PmarkNo) {
    $('#private-mark-dialog').removeClass('hide');
    $('#private-mark-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 550,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#edit_private_mark_no').val(PmarkNo);
}

function savePrivatemark(code){
    data = {};
    data.code =code;
    data.privatemark = $('#edit_private_mark_no').val();
    var err = 0;
    $('#edit_private_mark_no').removeClass('inp_error');
    if(data.privatemark == ''){
        err++;
        $('#edit_private_mark_no').addClass('inp_error');
    }

    if (err > 0) {
        $('#private_mark_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#private_mark_action_state').html('Please enter/select the values in the field that are marked in red');
        $('#private_mark_action_state').show();
        return false;
    } else {
        $('#private_mark_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#private_mark_action_state').html('');
        $('#private_mark_action_state').hide();
    }
    $('#action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-save-privatemark",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#action-state').addClass('alert').addClass('alert-success').html('Details updated successfully');
                window.setTimeout(function () {
                    hidePrivateMarkDialog();
                    getCargoDetails(code);
                }, 3000);
            } else {
                $('#action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
            }
        }
    });
}

function hidePrivateMarkDialog() {
    $('#private-mark-dialog').dialog('destroy');
    $('#private-mark-dialog').hide();
    $('#edit_private_mark_no').removeClass('inp_error');
    $('#private_mark_action_state').hide();
}

function hideDDHandoverDialog() {
    $('#dd-handover-dialog').dialog('destroy');
    $('#dd-handover-dialog').hide();
}

function saveDDHandover() {
    var data = {}, err = 0;

    var doorDeliveryperson = $.trim($('#ddhandover-person').val());
    var doorDeliveryStatus = $.trim($('#dddelivery-status').val());

    data.code = lrdata.code;
    data.additionalAttribute = {};
    data.additionalAttribute['DRDLY'] = doorDeliveryStatus + '|' + doorDeliveryperson + '|' + $('#dddelivery-status :selected').text();


    $('.inp_error').removeClass('inp_error');
    if (isNull(doorDeliveryperson)) {
        $('#ddhandover-person').addClass('inp_error');
        err++;
    }
    if (isNull(doorDeliveryStatus)) {
        $('#dddelivery-status').addClass('inp_error');
        err++;
    }
    if(err) {
        $('#dd-handover-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#dd-handover-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }

    $('#dd-handover-panel-btn').hide();
    $('#dd-handover-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-cargo-charges",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#dd-handover-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    hideDDHandoverDialog();
                    getCargoDetails(lrdata.code);
                }, 3000);
            } else {
                $('#dd-handover-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#dd-handover-panel-btn').show();
            }
        }
    })
}

function getBalanceReturnAmount(ele) {
    var customerAmount = Number($(ele).val());
    var payableAmount = Number($('#payment_amount').val());

    var balanceReturnAmount = 0;
    if (isNotNull(customerAmount) && isNotNull(payableAmount)) {
        balanceReturnAmount = customerAmount - payableAmount;
    }
    $('#dd-balance-return-amount').val(balanceReturnAmount);
}

var deliveryInputs = $('#payment-unload-deliver-panel').find('input,select, a').filter(':visible:not([readonly]):not([type="hidden"]):not([disabled])');
function getAllDeliveryInputs() {
    deliveryInputs = $('#payment-unload-deliver-panel').find('input,select, a').filter(':visible:not([readonly]):not([type="hidden"]):not([disabled])');
}

$('#payment-unload-deliver-panel').on('keypress', 'input,select ,a', function (e) {
    if (e.which == 13) {
        const currInput = document.activeElement;
        const currInputIndex = deliveryInputs.index(currInput);
        const nextinputIndex = (currInputIndex + 1) % deliveryInputs.length;
        const input = deliveryInputs[nextinputIndex];
        input.focus();
    }
});

function calculateDeliverySplitup() {
    var subAmount = Number($('#pay-amount-sub').val()) || 0;
    var mainAmount = Number($('#pay-amount-main').val()) || 0;
    var netAmount = Number($('#payment_amount').val()) || 0;
    if (netAmount > 0 && subAmount > 0 && subAmount < netAmount) {
        $('#pay-amount-main').val(netAmount-subAmount);
    } else {
        $('#pay-amount-main').val(netAmount);
        $('#pay-amount-sub').val(0);
    }
}

function addDeliveryTransactionMode() {
    $('#pay-other-transaction-mode').removeClass('hide');
    $('#pay-add-transaction-mode-btn').addClass('hide');
    $('#pay-remove-transaction-mode-btn').removeClass('hide');
}

function removeDeliveryTransactionMode() {
    $('#pay-transaction-mode-sub').val('CASH').trigger('change');
    $('#pay-amount-sub').val(0).trigger('input');
    $('#pay-other-transaction-mode').addClass('hide');
    $('#pay-remove-transaction-mode-btn').addClass('hide');
    $('#pay-add-transaction-mode-btn').removeClass('hide');
}

function UpdateSpecialBooking() {
    let cargoCode="<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
";
    let cargoAddonsDetails={};
    let spBData = $('.booking_addons').find(':checked').map(function() {
        return $(this).val();
    }).get();

    let sendParams = [];

    const addonsToCheck = ["EXPDL", "HDLWC"];
    
    addonsToCheck.forEach(addon => {
        const isActive = spBData.includes(addon);
        sendParams.push({
            "code":$(".code-"+addon.toLowerCase()).val(),
            "addonsType": {
                "code": addon
            },
            "value": isActive ? $("#slt-"+addon.toLowerCase()).val() : "0",
            "activeFlag": isActive ? 1 : 0
        });
    });

    const payload = {
        "code": cargoCode,
        "additionalAttribute": cargoAddonsDetails,
        "cargoAddonsDetails": sendParams
    };
    const jsonString = JSON.stringify(payload);

    $.ajax({
        type: "POST",
        url: "cargo/update-specialbooking",
        dataType:'json',
        data:jsonString,
        success: function(response) {
            if(response){
                // getCargoDetails(cargoCode);
            }
        },
        error: function(error) {
            console.error("Error:", error);
        }
    });
}

function getEditPaymentType() {
        return $('[name="edit_paymode_radio"]:checked').val() || '';
    }

    function getAllInputsEdit() {
        inputs = $(document).find('input,select').filter(':visible:not([readonly]):not([type="hidden"]):not([disabled])');
    }

function setTransactionModeEdit(type) {
        var mode =  $("input[name='edit_paymode_radio']:checked").val();
        var payment_type = getEditPaymentType();

        $('#edit-cheque-mode-panel-'+type).addClass('hide');
        $('#edit-netbanking-mode-panel-'+type).addClass('hide');
        $('#edit-upi-mode-panel-'+type).addClass('hide');
        $('#edit-bk-customer-calculation').addClass('hide');

        if (mode == 'CASH') {
            if (payment_type == 'PAD') {
                $('#edit-bk-customer-calculation').removeClass('hide');
            }
        }

        if (mode == 'CHEQUE') {
            $('#edit-cheque-mode-panel-'+type).removeClass('hide');
        } else if (mode == 'NBK') {
            $('#edit-netbanking-mode-panel-'+type).removeClass('hide');

            $('#edit-netbanking-orgbank-'+type).html(new Option('Loading...', '', true, true)).select2().html('');
        } else if (mode == 'UPI') {
            $('#edit-upi-mode-panel-'+type).removeClass('hide');
            
            $('#upi-orgbank-'+type).html(new Option('Loading...', '', true, true)).select2().html('');
        }

        var data = {};
        data.organizationcode = lrdata.fromOrganization.code;

        if (!data.organizationcode) {
            return;
        }

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-organization-other-details',
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    res.data.bankDetails = res.data.bankDetails || [];
                    if (mode == 'NBK') {
                        $('#edit-netbanking-orgbank-'+type).html('');
                        if (res.data.bankDetails.length > 1) {
                            $('#edit-netbanking-orgbank-'+type).html(new Option('Select Organization Bank', ''));
                        }
                        $.each(res.data.bankDetails, function (i, bank) {
                            if (bank.accountType.code != 'CASH' && bank.accountType.code !== undefined) {
                                $('#edit-netbanking-orgbank-'+type).append(new Option(bank.name + ' - ' + bank.accountNumber, bank.code));
                            }
                        });
                        $('#edit-netbanking-orgbank-'+type).select2();
                    } else if (mode == 'UPI') {
                        $('#upi-orgbank-'+type).html('');
                        if (res.data.bankDetails.length > 1) {
                            $('#upi-orgbank-'+type).html(new Option('Select Organization Bank', ''));
                        }
                        $.each(res.data.bankDetails, function (i, bank) {
                            if (bank.accountType.code != 'CASH' && bank.accountType.code !== undefined) {
                                $('#upi-orgbank-'+type).append(new Option(bank.name + ' - ' + bank.accountNumber, bank.code));
                            }
                        });
                        $('#upi-orgbank-'+type).select2();
                    }
                }
            }
        });
}
<?php echo '</script'; ?>
><?php }
}
