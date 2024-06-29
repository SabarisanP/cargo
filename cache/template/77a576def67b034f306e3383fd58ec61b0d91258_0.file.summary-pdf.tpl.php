<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-12 11:02:51
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\summary-pdf.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66693303ead575_56593448',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '77a576def67b034f306e3383fd58ec61b0d91258' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\summary-pdf.tpl',
      1 => 1718170342,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66693303ead575_56593448 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.capitalize.php','function'=>'smarty_modifier_capitalize',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),2=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>
<style>
    .bordered td {
        border-right-width: 0.1px;
        border-top-width: 0.1px;
        border-left-width: 0.1px;
        border-bottom-width: 0.1px
    }

    .bordered .noborder {
        border: 1px solid #fff;
    }

    .bold {
        font-weight: bold;
    }

    .f12 {
        font-size: 10px;
    }

    .bordered-new td {
        border-top-width: 0.1px;
    }
    /* .badge{
       background-color:black;
       border: 1px solid rgb(25, 0, 255);
       border-radius: 50% !important;
       color: white;
       padding: 10px;
       font-weight: 600;
    } */
</style>

<table width="100%">
    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "praveencarriers") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/praveencarriers-header.jpg" alt="logo" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "thiruparcel") {?>
        <tr>
            <td width="85%" align="center">
                <img src="assets/img/clientlogo/thiruparcel-header.jpg" alt="logo" style="max-width: 100%;"><br>
            </td>
            <td align="center" width="15%">
                <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
qr?data=<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
&size=10" width="62px">
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "ragavendraparcel") {?>
        <tr>
            <td width="85%" align="center">
                <img src="assets/img/clientlogo/ragavendraparcel-header.jpg" alt="logo" style="max-width: 100%;"><br>
            </td>
            <td align="center" width="15%">
                <?php if (isNotNull($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->domainURL) && isNotNull($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG)) {?>
                    <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
qr?data=<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
&size=10" width="62px">
                <?php }?>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "srimaharaja") {?>
        <tr>
            <td width="85%" align="center">
                <img src="assets/img/clientlogo/srimaharaja-header.jpg" alt="logo" style="max-width: 100%;"><br>
            </td>
            <td align="center" width="15%">
                <?php if (isNotNull($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->domainURL) && isNotNull($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG)) {?>
                    <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
qr?data=<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
&size=10" width="62px">
                <?php }?>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "abexpress") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/abexpress-LR-Header.jpg" alt="Header" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "velavaparcel") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/velavaparcel-header.jpeg" alt="Header" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "gotour") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/gotour-header.jpg" alt="Header" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "appletravels") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/appletravels-header.jpg" alt="Header" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "mbttransport") {?>
        <table style="border: 1px solid #9a9a9a;">
            <tr>
                <td width="30%" align="left"><br><br>
                    <span><b>contact :</b> 9880186184 ,</span><br>
                    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8867786184</span>
                </td>
                <td width="45%" align="left">
                    <br> <br>
                    <img src="assets/img/mbttransport-logo.png" alt="logo" style="width: 150px;"><br>
                </td>
                <td width="25%" align="center"><br><br>
                    <span><b>Email : </b>mbttransport06@gmail.com</span> <br>
                    <span><b>Website :</b> www.mbttransport.in &nbsp; &nbsp; &nbsp; &nbsp;</span><br>
                </td>
            </tr>
            <tr>
                <td width="25%"></td>
                <td width="50%" align="left">
                    <?php echo smarty_modifier_capitalize($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1);?>
,
                    <?php echo smarty_modifier_capitalize($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2);?>
 &nbsp; <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>

                </td>
                <td width="25%"></td>
            </tr>
            <br>
        </table><br><br>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "applebus") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/applebus-header.jpg" alt="Header" style="max-width: 100%;"><br>
                </td>
            </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "jahantransport") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/jahan-transport-print-header.jpg" alt="Header" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "srisendhursps") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/srisendhursps-print-header.jpg" alt="Header" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "vijaytourist") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/vijaytourist-print-header.jpg" alt="Header" style="max-width: 100%;">
            </td>
        </tr>
        <tr>
            <td align="center" width="100%" style="font-weight: bold;font-size:11px;">Parcel Receipt</td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "kanjeeexpress") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/kanjeeexpress-header.jpg" alt="Header" style="max-width: 100%;">
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "srirajali") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/srirajali-print-header.jpg" alt="Header" style="max-width: 100%;">
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "tippusultantrans") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/tippusultantrans-header-2.jpg" alt="Header" style="max-width: 100%;">
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "sprtravels") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/sprtravels.jpg" alt="logo" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "jstcargo") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/jstcargo-header.jpg" alt="logo" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "rajeshcargo") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/rajesh-lr-header.jpg" alt="logo" style="max-width: 100%;"><br>
            </td>
        </tr>
    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "ksreeni") {?>
        <tr>
            <td width="100%" align="center">
                <img src="assets/img/clientlogo/kseerni-header.jpg" alt="logo" style="max-width: 100%;"><br>
            </td>
        </tr>
   
    <?php } else { ?>
        <tr>
            <td width="30%">
                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "psstransport") {?>
                    &nbsp;<img src="assets/img/pss-logo.png" alt="logo" height="60">
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "pkrsps") {?>
                    &nbsp;<img src="assets/img/pkr-logo.png" alt="logo" height="80">
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "tnparcel") {?>
                    &nbsp;<img src="assets/img/tnparcel-logo.png" alt="logo" height="60">
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "nsrirom") {?>
                    &nbsp;<img src="assets/img/nsrirom-logo.png" alt="logo" height="60">
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "atobparcel") {?>
                    &nbsp;<img src="assets/img/atobparcel-logo.png" alt="logo" height="60">
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "smroadlines") {?>
                    &nbsp;<img src="assets/img/smroadlines-logo.png" alt="logo" width="160">
                <?php }?>
            </td>
            <td width="45%">
                <table width="100%" cellpadding="3">
                    <tr>
                        <td align="center">
                            <span style="font-weight:bold; font-size: 13px;"><?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
</span>
                        </td>
                    </tr>

                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?>
                        <tr>
                            <td align="center">
                                <span style="font-weight:bold; font-size: 8px;">Tourist Buses for Rent contact us - 9842411660</span>
                            </td>
                        </tr>
                    <?php }?>
                    <tr>
                        <td align="center" class="bold">Parcel Booking Receipt</td>
                    </tr>
                    <tr>
                        <td align="center">

                            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "nationalchn") {?>
                                <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,&nbsp;<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
, Mobile : <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->supportNumber;?>

                                <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->tax->gstin)) {?>
                                    <br>
                                    <b>GSTIN :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                                <?php }?>
                            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?>
                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromStation->code == 'STF3OEX206') {?>
                                    323/1, Hosur Main Road, Madiwala, Bengaluru, Karnataka - 560068
                                    <br>
                                    <span class="bold f12">GSTIN : 29AAZFR4180P1ZY </span>
                                <?php } else { ?>
                                    Annamalai Nagar Extension, (via) ABC Hospital Road, Konnakarai Road, Trichy - 620003
                                    <br>
                                    Ph No : 9626111660
                                    <br>
                                    <span class="bold f12">GSTIN : 33AAZFR4180P1Z9 </span>
                                <?php }?>
                            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "luckycargoes") {?>
                                <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,&nbsp;<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
<br>
                                <b>GSTIN :</b> 37AAECL1582H1ZF
                            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "viplogistics") {?>
                                <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,&nbsp;<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>

                            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "ashokalogistics") {?>
                                <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address != '' && $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address != 'NA') {?>
                                    <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,&nbsp;<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
<br>
                                <?php }?>
                                <b>GSTIN :</b> 29DKVPS6194F1Z3
                            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "pkrsps") {?>
                                <?php if (isNotNull($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address)) {?>
                                    <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,<br><?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
<br>
                                <?php }?>
                            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "tippusultan") {?>
                                <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->tax->gstin) && (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST))) {?>
                                    <b>GSTIN :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                                <?php }?>
                            <?php } else { ?>
                                <?php if (isNotNull($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address)) {?>
                                    <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,<br><?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
<br>
                                <?php }?>
                                <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->tax->gstin)) {?>
                                    <b>GSTIN :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "ksreeni") {?>
                                    <b>GSTIN :</b> 33GQDPS0463J1ZO
                                <?php }?>
                            <?php }?>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="25%"></td>
        </tr>
    <?php }?>
</table>
<?php $_smarty_tpl->_assignInScope('cargo_additional', config_item('cargo_additional'));?>
<table width="100%">
    <tr>
        <td width="65%">
            <table width="100%" cellpadding="1">
                <tbody class="body_table">
                    <br>
                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "ksreeni") {?>
                        <tr>
                           <td align="left" width="60%" ></td>
                           <td align="right" width="40%"><br />
                              <b>GSTIN:</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>
 
                           </td>
                       </tr>
                    <?php }?>
                    <tr>
                        <td align="left" width="60%" style="font-size:11px;">
                            <b><?php echo lang('lr');?>
 No : <?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
</b>
                            <?php if (count($_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'])) {?>
                                &nbsp;<img src="assets/img/icons/invoice-logo.png" alt="logo" width="25" height="11">
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoAddonsDetails !== '') {?>
                                <?php $_smarty_tpl->_assignInScope('displayed_logos', array());?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->cargoAddonsDetails, 'detail');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['detail']->value) {
?>
                                    <?php if ($_smarty_tpl->tpl_vars['detail']->value->addonsType->code == 'EWBL' && $_smarty_tpl->tpl_vars['detail']->value->referenceCode != '' && !in_array('EWBL',$_smarty_tpl->tpl_vars['displayed_logos']->value)) {?>
                                        &nbsp;<img src="assets/img/icons/eway-logo.png" alt="logo" width="25" height="11">
                                        <?php $_smarty_tpl->_assignInScope('displayed_logos', array_merge($_smarty_tpl->tpl_vars['displayed_logos']->value,array('EWBL')));?>
                                    <?php } elseif ($_smarty_tpl->tpl_vars['detail']->value->addonsType->code == 'HDLWC' && !in_array('HDLWC',$_smarty_tpl->tpl_vars['displayed_logos']->value)) {?>
                                        &nbsp;<img src="assets/img/icons/handle-logo.png" alt="logo" width="14" height="11">
                                        <?php $_smarty_tpl->_assignInScope('displayed_logos', array_merge($_smarty_tpl->tpl_vars['displayed_logos']->value,array('HDLWC')));?>
                                    <?php } elseif ($_smarty_tpl->tpl_vars['detail']->value->addonsType->code == 'EXPDL' && !in_array('EXPDL',$_smarty_tpl->tpl_vars['displayed_logos']->value)) {?>
                                        &nbsp;<img src="assets/img/icons/express-logo.png" alt="logo" width="14" height="11">
                                        <?php $_smarty_tpl->_assignInScope('displayed_logos', array_merge($_smarty_tpl->tpl_vars['displayed_logos']->value,array('EXPDL')));?>
                                    <?php }?>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php }?>
                        </td>
                        <td align="right" width="40%"><br />
                            Booked Date : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                        </td>
                    </tr>

                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != '-' || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != '-') {?>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != 'false' || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != 'false') {?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != '' || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != '') {?>
                                <tr>
                                    <td align="left" colspan="2" style="font-weight:normal; font-size:9px;">
                                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != 'false' && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != '') {?>
                                            <b>Driver Name:&nbsp;</b>&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName;?>
 &nbsp;
                                        <?php }?>
                                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != 'false' && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != '') {?>
                                            <b> Driver Mobile:&nbsp;</b>&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile;?>

                                        <?php }?>
                                    </td>
                                </tr>
                            <?php }?>
                        <?php }?>
                    <?php }?>
                </tbody>
            </table>
            <br><br>
            <?php if ($_smarty_tpl->tpl_vars['namespace']->value === 'mbttransport') {?>
                <table width="100%" cellpadding="2" class="table bordered" style="margin-top: 5px;">
                    <tbody class="body_table">
                      
                        <tr>
                            <td width="50%"><span class="bold font-10">Consignor: </span>&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
</td>
                            <td width="50%"><span class="bold font-10">Consignee: </span>&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
</td>
                        </tr>
                        <tr>
                            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
</td>
                            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
</td>
                        </tr>
                        <tr>
                            <td align="left" width="50%"class="bold font-10">From : &nbsp; <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name;?>
 - <span class="bold font-12"><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>
</span></td>
                            <td align="left" width="50%"class="bold font-10">To : &nbsp;  <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>
- <span class="bold font-12"><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>
</span></td>
                        </tr>
                        
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {?>
                            <tr><td align="left" width="50%" title="Pickup Address"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark;?>
<br /><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode;
} else { ?>-<?php }?></td><td align="left" width="50%" title="Delivery Address"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark;?>
<br /><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode;
} else { ?>-<?php }?></td></tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST != '' || $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST != '') {?>
                            <tr>
                                <td align="left" width="50%" class="">GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST;?>
</td>
                                <td align="left" width="50%" class="">GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST;?>
</td>
                            </tr>
                        <?php }?>
                    </tbody>
                </table>
                <br><br>
                <table width="100%" cellpadding="3" class="table bordered ">
                    <tr>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                            <td align="center" class="bold" width="10%">S No</td>
                            <td align="center" class="bold" width="30%">Article</td>
                            <td align="center" class="bold" width="12%">UOM</td>
                            <td align="center" class="bold" width="12%">Quantity</td>
                            <td align="center" class="bold" width="12%">Rate</td>
                            <td align="center" class="bold" width="12%">Handling</td>
                            <td align="center" class="bold" width="12%">Total</td>
                        <?php } else { ?>
                            <td align="center" class="bold" width="10%">S No</td>
                            <td align="center" class="bold" width="30%">Article</td>
                            <td align="center" class="bold" width="15%">Quantity</td>
                            <td align="center" class="bold" width="15%">Rate</td>
                            <td align="center" class="bold" width="15%">Handling</td>
                            <td align="center" class="bold" width="15%">Total</td>
                        <?php }?>
                    </tr>
                    <tbody class="body_table">
                        <?php $_smarty_tpl->_assignInScope('subtotal', 0);?>
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
                                <td align="left">
                                    <?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['article']->value->cargoItem->name,25);?>

                                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?><br>HSN Code : 996511<?php }?>
                                </td>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                    <td align="center">
                                        <?php echo $_smarty_tpl->tpl_vars['article']->value->unitValue;?>

                                        <?php echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code];?>

                                    </td>
                                <?php }?>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->fare;?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->handlingChargeAmount;?>
</td>
                                <td align="center">
                                    <?php echo number_format($_smarty_tpl->tpl_vars['article']->value->computed->freight,2);?>

                                </td>
                            </tr>
                            <?php $_smarty_tpl->_assignInScope('subtotal', $_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['article']->value->computed->freight);?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                </table>
            <?php } else { ?>
                <table width="100%" cellpadding="2" class="table bordered ">
                    <tbody class="body_table">
                        <tr class="success" style="background-color:#64b92a;">
                            <td align="left" width="50%" class="bold">Booking Address</td>
                            <td align="left" width="50%" class="bold">Delivery Address</td>
                        </tr>
                        <tr>
                            <td align="left" width="50%" style="font-weight:bold;">
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name;?>

                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1 != '') {?>
                                    <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2;?>
<br>
                                <?php }?>
                                <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>

                            </td>
                            <td align="left" width="50%" style="font-weight:bold;">
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>

                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1 != '') {?>
                                    <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address2;?>
 <br>
                                <?php }?>
                                <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>

                            </td>
                        </tr>
                        <tr>
                            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
</td>
                            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
</td>
                        </tr>
                        <tr>
                            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
</td>
                            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
</td>
                        </tr>
                        
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {?>
                            <tr><td align="left" width="50%" title="Pickup Address"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark;?>
<br /><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode;
} else { ?>-<?php }?></td><td align="left" width="50%" title="Delivery Address"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark;?>
<br /><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode;
} else { ?>-<?php }?></td></tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST != '' || $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST != '') {?>
                            <tr>
                                <td align="left" width="50%" class="">GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST;?>
</td>
                                <td align="left" width="50%" class="">GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST;?>
</td>
                            </tr>
                        <?php }?>
                    </tbody>
                </table>
                <br><br>
                <table width="100%" cellpadding="3" class="table bordered ">
                    <tr class="success" style="background-color:#64b92a;">
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                            <td align="center" class="bold" width="10%">S No</td>
                            <td align="center" class="bold" width="30%">Article</td>
                            <td align="center" class="bold" width="12%">UOM</td>
                            <td align="center" class="bold" width="12%">Quantity</td>
                            <td align="center" class="bold" width="12%">Rate</td>
                            <td align="center" class="bold" width="12%">Handling</td>
                            <td align="center" class="bold" width="12%">Total</td>
                        <?php } else { ?>
                            <td align="center" class="bold" width="10%">S No</td>
                            <td align="center" class="bold" width="30%">Article</td>
                            <td align="center" class="bold" width="15%">Quantity</td>
                            <td align="center" class="bold" width="15%">Rate</td>
                            <td align="center" class="bold" width="15%">Handling</td>
                            <td align="center" class="bold" width="15%">Total</td>
                        <?php }?>
                    </tr>
                    <tbody class="body_table">
                        <?php $_smarty_tpl->_assignInScope('subtotal', 0);?>
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
                                <td align="left">
                                    <?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['article']->value->cargoItem->name,25);?>

                                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?><br>HSN Code : 996511<?php }?>
                                </td>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                    <td align="center">
                                        <?php echo $_smarty_tpl->tpl_vars['article']->value->unitValue;?>

                                        <?php echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code];?>

                                    </td>
                                <?php }?>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->fare;?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->handlingChargeAmount;?>
</td>
                                <td align="center">
                                    <?php echo number_format($_smarty_tpl->tpl_vars['article']->value->computed->freight,2);?>

                                </td>
                            </tr>
                            <?php $_smarty_tpl->_assignInScope('subtotal', $_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['article']->value->computed->freight);?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                </table>
            <?php }?>

            <br><br>

            <?php if (count($_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'])) {?>
                <br><br>
                <table width="100%" cellpadding="3" class="table bordered ">
                    <tr class="success">
                        <td align="center" class="bold" width="30%">E-Way Bill</td>
                        <td align="center" class="bold" width="30%">Invoice Number</td>
                        <td align="center" class="bold" width="20%">Invoice Amt</td>
                        <td align="center" class="bold" width="20%">Invoice Date</td>
                    </tr>
                    <tbody class="body_table">
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'], 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <tr>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->referenceCode;?>
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

                    </td>
        <td width="3%" valign="top"></td>
        <td width="32%" valign="top">
            
            <table align="left">
                <tr style="font-size:20px;font-weight: bold;">
                    <td align="center" colspan="2" class="bold" style="padding-bottom: 20px;"><?php echo strtoupper($_smarty_tpl->tpl_vars['payment_type_name']->value);?>
</td>
                </tr>
                <tr style="font-size:14px;font-weight: bold;">
                    <td align="center" colspan="2" class="bold" style="padding-bottom: 20px;">
                        <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['summary']->value->deliveryType->name, 'UTF-8');?>

                    </td>
                </tr>
            </table>

            <br /><br />

            <table align="">
                <tr style="font-size:10px;font-weight: bold;">
                    <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("appletravels","applebus"))) {?>
                        <td align="left" width="35%" class="bold">Delivery To :</td>
                        <td align="left" width="65%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>
</td>
                    <?php } else { ?>
                        <td align="left" width="35%" class="bold">Booked By :</td>
                        <td align="left" width="65%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedUser->name;?>
</td>
                    <?php }?>
                </tr>
            </table>
            <br /><br />

            <?php $_smarty_tpl->_assignInScope('hideCargoFreight', '');?>
            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->vendorUser) && isNotNull($_smarty_tpl->tpl_vars['summary']->value->vendorUser->code)) {?>
                <?php $_smarty_tpl->_assignInScope('hideCargoFreight', $_smarty_tpl->tpl_vars['summary']->value->vendorUser->hideCargoFreight);?>
            <?php }?>
            <table width="100%" cellpadding="3" class="table" style="border: 0.1px solid #000;">
                <tbody class="body_table">
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">No of Articles</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
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
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Freight</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalAmount,2);
}?></td>
                    </tr>
                    <tr>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">L Charges</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount,2);
}?></td>
                    </tr>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount > 0) {?>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pickup Charges</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount,2);
}?></td>
                        </tr>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount > 0) {?>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Delivery Charges</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount,2);
}?></td>
                        </tr>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge > 0) {?>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Hamali Charges</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge,2);
}?></td>
                        </tr>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->passCharge > 0) {?>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pass Charges</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->passCharge,2);
}?></td>
                        </tr>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->docketCharge > 0) {?>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Docket Charges</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->docketCharge,2);
}?></td>
                        </tr>
                    <?php }?>
                    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH'])) {?>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">POD Charges</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value,2);
}?></td>
                        </tr>
                    <?php }?>
                    

                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount > 0) {?>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Unloading Charges</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount,2);
}?></td>
                        </tr>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->serviceCharge > 0) {?>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Service Charges</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceCharge,2);
}?></td>
                        </tr>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "panindia") {?>
                        <tr <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'PAD') {?>class="bold" style="font-size: 9px;" <?php }?>>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo number_format(($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value),2);?>
</td>
                        </tr>
                        <tr>
                            <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                            <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceTax,2);?>
</td>
                        </tr>
                    <?php } else { ?>
                                                <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH'])) {?>
                            <?php $_smarty_tpl->_assignInScope('con_charge', $_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value);?>
                            <?php } else { ?>
                                <?php $_smarty_tpl->_assignInScope('con_charge', 0);?>
                            <?php }?>
                        <?php if (isset($_smarty_tpl->tpl_vars['summary']->value->tax->code)) {?>
                           
                           
                            <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue != 0) {?>
                                <tr>
                                    <td align="left" class="bold" style="border-right: 0.1px solid #000;">CGST</td>
                                    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue,2);
}?></td>
                                </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue != 0) {?>
                                <tr>
                                    <td align="left" class="bold" style="border-right: 0.1px solid #000;">SGST</td>
                                    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue,2);
}?></td>
                                </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue != 0) {?>
                                <tr>
                                    <td align="left" class="bold" style="border-right: 0.1px solid #000;">UGST</td>
                                    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue,2);
}?></td>
                                </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue != 0) {?>
                                <tr>
                                    <td align="left" class="bold" style="border-right: 0.1px solid #000;">IGST</td>
                                    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue,2);
}?></td>
                                </tr>
                            <?php }?>
                        <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->serviceTax > 0) {?>
                            <tr>
                                <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceTax,2);
}?></td>
                            </tr>
                        <?php }?>
                        <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH'])) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Connecting Charges</td>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value,2);?>
</td>
                            </tr>
                        <?php }?>
                        <tr <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'PAD') {?>class="bold" style="font-size: 9px;" <?php }?>>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                          
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format(($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['con_charge']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value),2);
}?></td>
                        </tr>
                    <?php }?>
                                        <tr <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'PAD') {?>class="bold" style="font-size: 9px;" <?php }?>>
                        <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Amount Paid</td>
                        <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->paymentAmount,2);
}?></td>
                    </tr>
                    <?php $_smarty_tpl->_assignInScope('balance_to_pay', ($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['con_charge']->value)-$_smarty_tpl->tpl_vars['summary']->value->paymentAmount+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value);?>
                    <?php if ($_smarty_tpl->tpl_vars['balance_to_pay']->value > 0) {?>
                        <tr style="font-size: 9px;" class="bordered-new">
                            <td align="left" width="50%" class="bold">Amount Balance</td>
                            <td align="left" width="50%">&nbsp;&nbsp;<b><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['balance_to_pay']->value,2);
}?></b></td>
                        </tr>
                    <?php }?>
                </tbody>
            </table>
        </td>
    </tr>
</table>

<!--<br><br>           
<table width="100%" cellpadding="5" class="table bordered ">
<tr>
    <td align="left" width="20%" class="bold">Payment Type</td>
    <td align="left" width="30%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->paymentType->name;?>
</td> 
    <td align="left" width="20%" class="bold">Cargo Status</td>
    <td align="left" width="30%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->name;?>
</td> 
</tr>
</table>-->

<br>
<?php if (count($_smarty_tpl->tpl_vars['summary']->value->remarks)) {?>
    <table cellpadding="1">
        <tbody class="body_table">
            <tr class="success">
                <td width="1%"></td>
                <td><b>Remarks : </b>
                    <?php $_smarty_tpl->_assignInScope('remarksarr', array());?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->remarks, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['remarksarr']) ? $_smarty_tpl->tpl_vars['remarksarr']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[] = $_smarty_tpl->tpl_vars['row']->value->name;
$_smarty_tpl->_assignInScope('remarksarr', $_tmp_array);?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <?php echo implode($_smarty_tpl->tpl_vars['remarksarr']->value,'<br/>');?>

                </td>
            </tr>
        </tbody>
    </table>
<?php }?>

<?php if (count($_smarty_tpl->tpl_vars['terms_list']->value) > 0) {?>
    <table width="100%" cellpadding="0">
        <tr class="success">
            <td><b>Terms & Conditions</b></td>
        </tr>
        <tbody class="body_table">
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['terms_list']->value, 'term', false, NULL, 'carterm', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['term']->value) {
?>
                <tr>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['term']->value->name;?>
</td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
<?php }?>

<?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?>
    <table width="100%" cellpadding="2" style="border: 1px solid #000;">
        <tr>
            <td class="bold" width="35%" style="border-bottom: 1px solid #000;">Name - RKT SPEED PARCEL SERVICES</td>
            <td class="bold" align="center" width="40%" style="border-bottom: 1px solid #000;">Current Ac. No – 510909010174793</td>
            <td class="bold" width="25%" style="border-bottom: 1px solid #000;">IFSC - CIUB0000153</td>
        </tr>
        <tr>
            <td class="bold" width="35%">Bank - CITY UNION BANK</td>
            <td class="bold" align="center" width="40%">Branch - Tiruchirapalli Contonment Branch - 620001</td>
            <td class="bold" width="25%">GST No - 29AAZFR4180P1ZY</td>
        </tr>
    </table>
<?php }
$_smarty_tpl->_assignInScope('rcmby', '');
if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "TPPAD" || $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "TOP") {?>
    <?php if ($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST != '') {?>
        <?php $_smarty_tpl->_assignInScope('rcmby', lang('booking_receiver_term'));?>
    <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST != '' && $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST == '') {?>
        <?php $_smarty_tpl->_assignInScope('rcmby', lang('booking_sender_term'));?>
    <?php }
} elseif ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST != '') {?>
    <?php $_smarty_tpl->_assignInScope('rcmby', lang('booking_sender_term'));
} elseif ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST == '' && $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST != '') {?>
    <?php $_smarty_tpl->_assignInScope('rcmby', lang('booking_receiver_term'));
}?>

<?php if ($_smarty_tpl->tpl_vars['namespace']->value == "ybmlogistics" || $_smarty_tpl->tpl_vars['namespace']->value == "sbrscargo") {?>
    <table width="100%" cellpadding="1">
        <tr class="success">
            <td align="center">
                <?php if ($_smarty_tpl->tpl_vars['rcmby']->value != '') {?>
                    GST is payable by <?php echo $_smarty_tpl->tpl_vars['rcmby']->value;?>
 (RCM)
                <?php } else { ?>
                    GST is exempted
                <?php }?>
            </td>
        </tr>
    </table>
<?php }?>

<table width="100%" cellpadding="1">
    <tr class="success">
        <?php $_smarty_tpl->_assignInScope('bookeddate', explode(" ",$_smarty_tpl->tpl_vars['summary']->value->bookedAt));?>
        <?php $_smarty_tpl->_assignInScope('bookedtime', timeToMinutes($_smarty_tpl->tpl_vars['bookeddate']->value[1]));?>
        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes) && $_smarty_tpl->tpl_vars['bookedtime']->value > $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes) {?>
            <?php $_smarty_tpl->_assignInScope('transitCloseMinutes', $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes);?>
            <?php if ($_smarty_tpl->tpl_vars['transitCloseMinutes']->value < 720) {
$_smarty_tpl->_assignInScope('transitCloseMinutes', $_smarty_tpl->tpl_vars['transitCloseMinutes']->value+720);
}?>
            <td align="left"><b>Next Day Booking :</b> <?php echo addMinutesToDateTime($_smarty_tpl->tpl_vars['transitCloseMinutes']->value,$_smarty_tpl->tpl_vars['summary']->value->bookedAt,'d-m-Y');?>
</td>
        <?php }?>
        <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
    </tr>
</table>

<?php if ($_REQUEST['count'] == 2) {?>
    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?>
        <div></div>
    <?php } else { ?>
        <div>
            <hr />
        </div>
        <br /><br /><br />
    <?php }?>
    <table width="100%">
        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "praveencarriers") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/praveencarriers-header.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "thiruparcel") {?>
            <tr>
                <td width="85%" align="center">
                    <img src="assets/img/clientlogo/thiruparcel-header.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
                <td align="center" width="15%">
                    <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
qr?data=<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
&size=10" width="62px">
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "ragavendraparcel") {?>
            <tr>
                <td width="85%" align="center">
                    <img src="assets/img/clientlogo/ragavendraparcel-header.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
                <td align="center" width="15%">
                    <?php if (isNotNull($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->domainURL) && isNotNull($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG)) {?>
                        <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
qr?data=<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
&size=10" width="62px">
                    <?php }?>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "srimaharaja") {?>
            <tr>
                <td width="85%" align="center">
                    <img src="assets/img/clientlogo/srimaharaja-header.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
                <td align="center" width="15%">
                    <?php if (isNotNull($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->domainURL) && isNotNull($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG)) {?>
                        <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
qr?data=<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
&size=10" width="62px">
                    <?php }?>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "abexpress") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/abexpress-LR-Header.jpg" alt="Header" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "velavaparcel") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/velavaparcel-header.jpeg" alt="Header" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "gotour") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/gotour-header.jpg" alt="Header" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "appletravels") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/appletravels-header.jpg" alt="Header" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "mbttransport") {?>
            <table style="border: 1px solid #9a9a9a;">
                <tr>
                    <td width="30%" align="left"><br><br>
                        <span><b>contact :</b> 9880186184 ,</span><br>
                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8867786184</span>
                    </td>
                    <td width="45%" align="left">
                        <br> <br>
                        <img src="assets/img/mbttransport-logo.png" alt="logo" style="width: 150px;"><br>
                    </td>
                    <td width="25%" align="center"><br><br>
                        <span><b>Email : </b>mbttransport06@gmail.com</span> <br>
                        <span><b>Website :</b> www.mbttransport.in &nbsp; &nbsp; &nbsp; &nbsp;</span><br>
                    </td>
                </tr>
                <tr>
                    <td width="25%"></td>
                    <td width="50%" align="left">
                        <?php echo smarty_modifier_capitalize($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1);?>
,
                        <?php echo smarty_modifier_capitalize($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2);?>
 &nbsp; <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>

                    </td>
                    <td width="25%"></td>
                </tr>
                <br>
            </table><br><br>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "applebus") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/applebus-header.jpg" alt="Header" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "jahantransport") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/jahan-transport-print-header.jpg" alt="Header" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "srisendhursps") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/srisendhursps-print-header.jpg" alt="Header" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "vijaytourist") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/vijaytourist-print-header.jpg" alt="Header" style="max-width: 100%;">
                </td>
            </tr>
            <tr>
                <td align="center" width="100%" style="font-weight: bold;font-size:11px;">Parcel Receipt</td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "kanjeeexpress") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/kanjeeexpress-header.jpg" alt="Header" style="max-width: 100%;">
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "srirajali") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/srirajali-print-header.jpg" alt="Header" style="max-width: 100%;">
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "tippusultantrans") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/tippusultantrans-header-2.jpg" alt="Header" style="max-width: 100%;">
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "sprtravels") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/sprtravels.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "jstcargo") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/jstcargo-header.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "rajeshcargo") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/rajesh-lr-header.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "ksreeni") {?>
            <tr>
                <td width="100%" align="center">
                    <img src="assets/img/clientlogo/kseerni-header.jpg" alt="logo" style="max-width: 100%;"><br>
                </td>
            </tr>
        <?php } else { ?>
            <tr>
                <td width="30%">
                    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "psstransport") {?>
                        &nbsp;<img src="assets/img/pss-logo.png" alt="logo" height="60">
                    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "pkrsps") {?>
                        &nbsp;<img src="assets/img/pkr-logo.png" alt="logo" height="80">
                    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "tnparcel") {?>
                        &nbsp;<img src="assets/img/tnparcel-logo.png" alt="logo" height="60">
                    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "nsrirom") {?>
                        &nbsp;<img src="assets/img/nsrirom-logo.png" alt="logo" height="60">
                    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "atobparcel") {?>
                        &nbsp;<img src="assets/img/atobparcel-logo.png" alt="logo" height="60">
                    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "smroadlines") {?>
                        &nbsp;<img src="assets/img/smroadlines-logo.png" alt="logo" width="160">
                    <?php }?>
                </td>
                <td width="45%">
                    <table width="100%" cellpadding="3">
                        <tr>
                            <td align="center">
                                <span style="font-weight:bold; font-size: 13px;"><?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
</span>
                            </td>
                        </tr>
                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?>
                            <tr>
                                <td align="center">
                                    <span style="font-weight:bold; font-size: 8px;">Tourist Buses for Rent contact us - 9842411660</span>
                                </td>
                            </tr>
                        <?php }?>
                        <tr>
                            <td align="center" class="bold">Parcel Booking Receipt</td>
                        </tr>
                        <tr>
                            <td align="center">
                                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "nationalchn") {?>
                                    <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,&nbsp;<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
, Mobile : <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->supportNumber;?>

                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->tax->gstin)) {?>
                                        <br>
                                        <b>GSTIN :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                                    <?php }?>
                                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?>
                                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromStation->code == 'STF3OEX206') {?>
                                        323/1, Hosur Main Road, Madiwala, Bengaluru, Karnataka - 560068
                                        <br>
                                        <span class="bold f12">GSTIN : 29AAZFR4180P1ZY </span>
                                    <?php } else { ?>
                                        6, RKT Speed Parcel Service, Palaniappa Complex, Karur Bye Pass Road, Trichy - 620002
                                        <br>
                                        <span class="bold f12">GSTIN : 33AAZFR4180P1Z9 </span>
                                    <?php }?>
                                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "viplogistics") {?>
                                    <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,&nbsp;<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>

                                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "ashokalogistics") {?>
                                    <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address != '' && $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address != 'NA') {?>
                                        <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,&nbsp;<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
<br>
                                    <?php }?>
                                    <b>GSTIN :</b> 29DKVPS6194F1Z3
                                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "pkrsps") {?>
                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address)) {?>
                                        <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,<br><?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
<br>
                                    <?php }?>
                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->tax->gstin)) {?>
                                        <b>GSTIN :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                                    <?php }?>
                                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "tippusultan") {?>
                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->tax->gstin) && (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST))) {?>
                                        <b>GSTIN :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                                    <?php }?>
                                <?php } else { ?>
                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address)) {?>
                                        <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
,<br><?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
 - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
<br>
                                    <?php }?>
                                    <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->tax->gstin)) {?>
                                        <b>GSTIN :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                                    <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "ksreeni") {?>
                                        <b>GSTIN :</b> 33GQDPS0463J1ZO
                                    <?php }?>
                                <?php }?>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="25%"></td>
            </tr>
        <?php }?>
    </table>

    <table width="100%">
        <tr>
            <td width="65%">
                <table width="100%" cellpadding="1">
                    <tbody class="body_table">
                        <br>
                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "ksreeni") {?>
                            <tr>
                                <td align="left" width="60%" ></td>
                                <td align="right" width="40%"><br />
                                    <b>GSTIN:</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                                </td>
                            </tr>
                        <?php }?>
                        <tr>
                           <td align="left" width="60%" style="font-size:11px;">
                                <b><?php echo lang('lr');?>
 No : <?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
</b>
                                <?php if (count($_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'])) {?>
                                    &nbsp;<img src="assets/img/icons/invoice-logo.png" alt="logo" width="25" height="11">
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->cargoAddonsDetails !== '') {?>
                                    <?php $_smarty_tpl->_assignInScope('displayed_logos', array());?>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->cargoAddonsDetails, 'detail');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['detail']->value) {
?>
                                        <?php if ($_smarty_tpl->tpl_vars['detail']->value->addonsType->code == 'EWBL' && $_smarty_tpl->tpl_vars['detail']->value->referenceCode != '' && !in_array('EWBL',$_smarty_tpl->tpl_vars['displayed_logos']->value)) {?>
                                            &nbsp;<img src="assets/img/icons/eway-logo.png" alt="logo" width="25" height="11">
                                            <?php $_smarty_tpl->_assignInScope('displayed_logos', array_merge($_smarty_tpl->tpl_vars['displayed_logos']->value,array('EWBL')));?>
                                        <?php } elseif ($_smarty_tpl->tpl_vars['detail']->value->addonsType->code == 'HDLWC' && !in_array('HDLWC',$_smarty_tpl->tpl_vars['displayed_logos']->value)) {?>
                                            &nbsp;<img src="assets/img/icons/handle-logo.png" alt="logo" width="14" height="11">
                                            <?php $_smarty_tpl->_assignInScope('displayed_logos', array_merge($_smarty_tpl->tpl_vars['displayed_logos']->value,array('HDLWC')));?>
                                        <?php } elseif ($_smarty_tpl->tpl_vars['detail']->value->addonsType->code == 'EXPDL' && !in_array('EXPDL',$_smarty_tpl->tpl_vars['displayed_logos']->value)) {?>
                                            &nbsp;<img src="assets/img/icons/express-logo.png" alt="logo" width="14" height="11">
                                            <?php $_smarty_tpl->_assignInScope('displayed_logos', array_merge($_smarty_tpl->tpl_vars['displayed_logos']->value,array('EXPDL')));?>
                                        <?php }?>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <?php }?>
                            </td>
                            <td align="right" width="40%"><br />
                                Booked Date : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                            </td>
                        </tr>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != '-' || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != '-') {?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != 'false' || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != 'false') {?>
                                <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != '' || $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != '') {?>
                                    <tr>
                                        <td align="left" colspan="2" style="font-weight:normal; font-size:9px;">
                                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != 'false' && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName != '') {?>
                                                <b>Driver Name:&nbsp;</b>&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverName;?>
 &nbsp;
                                            <?php }?>
                                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != 'false' && $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile != '') {?>
                                                <b> Driver Mobile:&nbsp;</b>&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->driverMobile;?>

                                            <?php }?>
                                        </td>
                                    </tr>
                                <?php }?>
                            <?php }?>
                        <?php }?>
                    </tbody>
                </table>
                <br><br>
                <?php if ($_smarty_tpl->tpl_vars['namespace']->value === 'mbttransport') {?>
                    <table width="100%" cellpadding="2" class="table bordered" style="margin-top: 5px;">
                        <tbody class="body_table">
                            <tr>
                                <td width="50%"><span class="bold font-10">Consignor: </span>&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
</td>
                                <td width="50%"><span class="bold font-10">Consignee: </span>&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
</td>
                            </tr>
                            <tr>
                                <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
</td>
                                <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
</td>
                            </tr>
                            <tr>
                                <td align="left" width="50%"class="bold font-10">From : &nbsp; <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name;?>
 - <span class="bold font-12"><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>
</span></td>
                                <td align="left" width="50%"class="bold font-10">To : &nbsp;  <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>
- <span class="bold font-12"><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>
</span></td>
                            </tr>
                            
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {?>
                                <tr><td align="left" width="50%" title="Pickup Address"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark;?>
<br /><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode;
} else { ?>-<?php }?></td><td align="left" width="50%" title="Delivery Address"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark;?>
<br /><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode;
} else { ?>-<?php }?></td></tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST != '' || $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST != '') {?>
                                <tr>
                                    <td align="left" width="50%" class="">GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST;?>
</td>
                                    <td align="left" width="50%" class="">GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST;?>
</td>
                                </tr>
                            <?php }?>
                        </tbody>
                    </table>
                    <br><br>
                    <table width="100%" cellpadding="3" class="table bordered ">
                        <tr>
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                <td align="center" class="bold" width="10%">S No</td>
                                <td align="center" class="bold" width="30%">Article</td>
                                <td align="center" class="bold" width="12%">UOM</td>
                                <td align="center" class="bold" width="12%">Quantity</td>
                                <td align="center" class="bold" width="12%">Rate</td>
                                <td align="center" class="bold" width="12%">Handling</td>
                                <td align="center" class="bold" width="12%">Total</td>
                            <?php } else { ?>
                                <td align="center" class="bold" width="10%">S No</td>
                                <td align="center" class="bold" width="30%">Article</td>
                                <td align="center" class="bold" width="15%">Quantity</td>
                                <td align="center" class="bold" width="15%">Rate</td>
                                <td align="center" class="bold" width="15%">Handling</td>
                                <td align="center" class="bold" width="15%">Total</td>
                            <?php }?>
                        </tr>
                        <tbody class="body_table">
                            <?php $_smarty_tpl->_assignInScope('subtotal', 0);?>
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
                                    <td align="left">
                                        <?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['article']->value->cargoItem->name,25);?>

                                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?><br>HSN Code : 996511<?php }?>
                                    </td>
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                        <td align="center">
                                            <?php echo $_smarty_tpl->tpl_vars['article']->value->unitValue;?>

                                            <?php echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code];?>

                                        </td>
                                    <?php }?>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->fare;?>
</td>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->handlingChargeAmount;?>
</td>
                                    <td align="center">
                                        <?php echo number_format($_smarty_tpl->tpl_vars['article']->value->computed->freight,2);?>

                                    </td>
                                </tr>
                                <?php $_smarty_tpl->_assignInScope('subtotal', $_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['article']->value->computed->freight);?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </tbody>
                    </table>
                <?php } else { ?>
                    <table width="100%" cellpadding="2" class="table bordered ">
                        <tbody class="body_table">
                            <tr class="success" style="background-color:#64b92a;">
                                <td align="left" width="50%" class="bold">Booking Address</td>
                                <td align="left" width="50%" class="bold">Delivery Address</td>
                            </tr>
                            <tr>
                                <td align="left" width="50%" style="font-weight:bold;">
                                    <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name;?>

                                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1 != '') {?>
                                        <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2;?>
<br>
                                    <?php }?>
                                    <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>

                                </td>
                                <td align="left" width="50%" style="font-weight:bold;">
                                    <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>

                                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1 != '') {?>
                                        <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address2;?>
 <br>
                                    <?php }?>
                                    <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>

                                </td>
                            </tr>
                            <tr>
                                <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
</td>
                                <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
</td>
                            </tr>
                            <tr>
                                <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
</td>
                                <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
</td>
                            </tr>
                            
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {?>
                                <tr><td align="left" width="50%" title="Pickup Address"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark;?>
<br /><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode;
} else { ?>-<?php }?></td><td align="left" width="50%" title="Delivery Address"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark;?>
<br /><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode;
} else { ?>-<?php }?></td></tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST != '' || $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST != '') {?>
                                <tr>
                                    <td align="left" width="50%" class="">GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST;?>
</td>
                                    <td align="left" width="50%" class="">GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST;?>
</td>
                                </tr>
                            <?php }?>
                        </tbody>
                    </table>
                    <br><br>
                    <table width="100%" cellpadding="3" class="table bordered ">
                        <tr class="success" style="background-color:#64b92a;">
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                <td align="center" class="bold" width="10%">S No</td>
                                <td align="center" class="bold" width="30%">Article</td>
                                <td align="center" class="bold" width="12%">UOM</td>
                                <td align="center" class="bold" width="12%">Quantity</td>
                                <td align="center" class="bold" width="12%">Rate</td>
                                <td align="center" class="bold" width="12%">Handling</td>
                                <td align="center" class="bold" width="12%">Total</td>
                            <?php } else { ?>
                                <td align="center" class="bold" width="10%">S No</td>
                                <td align="center" class="bold" width="30%">Article</td>
                                <td align="center" class="bold" width="15%">Quantity</td>
                                <td align="center" class="bold" width="15%">Rate</td>
                                <td align="center" class="bold" width="15%">Handling</td>
                                <td align="center" class="bold" width="15%">Total</td>
                            <?php }?>
                        </tr>
                        <tbody class="body_table">
                            <?php $_smarty_tpl->_assignInScope('subtotal', 0);?>
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
                                    <td align="left">
                                        <?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['article']->value->cargoItem->name,25);?>

                                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?><br>HSN Code : 996511<?php }?>
                                    </td>
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                                        <td align="center">
                                            <?php echo $_smarty_tpl->tpl_vars['article']->value->unitValue;?>

                                            <?php echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code];?>

                                        </td>
                                    <?php }?>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->fare;?>
</td>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->handlingChargeAmount;?>
</td>
                                    <td align="center">
                                        <?php echo number_format($_smarty_tpl->tpl_vars['article']->value->computed->freight,2);?>

                                    </td>
                                </tr>
                                <?php $_smarty_tpl->_assignInScope('subtotal', $_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['article']->value->computed->freight);?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </tbody>
                    </table>
                <?php }?>
                <br><br>
                <?php if (count($_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'])) {?>
                    <br><br>
                    <table width="100%" cellpadding="3" class="table bordered ">
                        <tr class="success">
                            <td align="center" class="bold" width="30%">E-Way Bill</td>
                            <td align="center" class="bold" width="30%">Invoice Number</td>
                            <td align="center" class="bold" width="20%">Invoice Amt</td>
                            <td align="center" class="bold" width="20%">Invoice Date</td>
                        </tr>
                        <tbody class="body_table">
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'], 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                <tr>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->referenceCode;?>
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

                
            </td>
            <td width="3%" valign="top"></td>
            <td width="32%" valign="top">

                <table align="left">
                    <tr style="font-size:20px;font-weight: bold;">
                        <td align="center" colspan="2" class="bold" style="padding-bottom: 20px;"><?php echo strtoupper($_smarty_tpl->tpl_vars['payment_type_name']->value);?>
</td>
                    </tr>
                    <tr style="font-size:14px;font-weight: bold;">
                        <td align="center" colspan="2" class="bold" style="padding-bottom: 20px;">
                            <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['summary']->value->deliveryType->name, 'UTF-8');?>

                        </td>
                    </tr>

                </table>
                <br /><br />
                <table align="">
                    <tr style="font-size:10px;font-weight: bold;">
                        <?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("appletravels","applebus"))) {?>
                            <td align="left" width="35%" class="bold">Delivery To :</td>
                            <td align="left" width="65%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>
</td>
                        <?php } else { ?>
                            <td align="left" width="35%" class="bold">Booked By :</td>
                            <td align="left" width="65%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedUser->name;?>
</td>
                        <?php }?>
                    </tr>
                </table>
                <br /><br />

                <table width="100%" cellpadding="3" class="table" style="border: 0.1px solid #000;">
                    <tbody class="body_table">
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">No of Articles</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;
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
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Freight</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalAmount,2);
}?></td>
                        </tr>
                        <tr>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">L Charges</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount,2);
}?></td>
                        </tr>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount > 0) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pickup Charges</td>
                                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount,2);
}?></td>
                            </tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount > 0) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Delivery Charges</td>
                                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount,2);
}?></td>
                            </tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge > 0) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Hamali Charges</td>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge,2);
}?></td>
                            </tr>
                        <?php }?>

                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->passCharge > 0) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Pass Charges</td>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->passCharge,2);
}?></td>
                            </tr>
                        <?php }?>

                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->docketCharge > 0) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Docket Charges</td>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->docketCharge,2);
}?></td>
                            </tr>
                        <?php }?>
                        <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH'])) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">POD Charges</td>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value,2);
}?></td>
                            </tr>
                        <?php }?>
                        <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH'])) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Demurrage Charge</td>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value,2);
}?></td>
                            </tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount > 0) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Unloading Charges</td>
                                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount,2);
}?></td>
                            </tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['summary']->value->serviceCharge > 0) {?>
                            <tr>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Service Charges</td>
                                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceCharge,2);
}?></td>
                            </tr>
                        <?php }?>
                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "panindia") {?>
                            <tr <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'PAD') {?>class="bold" style="font-size: 9px;" <?php }?>>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo number_format(($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value),2);?>
</td>
                            </tr>
                            <tr>
                                <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                                <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceTax,2);?>
</td>
                            </tr>
                        <?php } else { ?>
                                                        <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH'])) {?>
                                <?php $_smarty_tpl->_assignInScope('con_charge', $_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value);?>
                                <?php } else { ?>
                                    <?php $_smarty_tpl->_assignInScope('con_charge', 0);?>
                            <?php }?>
                            <?php if (isset($_smarty_tpl->tpl_vars['summary']->value->tax->code)) {?>
                               
                                <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue != 0) {?>
                                    <tr>
                                        <td align="left" class="bold" style="border-right: 0.1px solid #000;">CGST</td>
                                        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue,2);
}?></td>
                                    </tr>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue != 0) {?>
                                    <tr>
                                        <td align="left" class="bold" style="border-right: 0.1px solid #000;">SGST</td>
                                        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue,2);
}?></td>
                                    </tr>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue != 0) {?>
                                    <tr>
                                        <td align="left" class="bold" style="border-right: 0.1px solid #000;">UGST</td>
                                        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue,2);
}?></td>
                                    </tr>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue != 0) {?>
                                    <tr>
                                        <td align="left" class="bold" style="border-right: 0.1px solid #000;">IGST</td>
                                        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue,2);
}?></td>
                                    </tr>
                                <?php }?>
                            <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->serviceTax > 0) {?>
                                <tr>
                                    <td align="left" class="bold" style="border-right: 0.1px solid #000;">GST</td>
                                    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceTax,2);
}?></td>
                                </tr>
                            <?php }?>
                            <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH'])) {?>
                                <tr>
                                    <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Connecting Charges</td>
                                    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['CNCTCH']->value,2);?>
</td>
                                </tr>
                            <?php }?>
                            <tr <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'PAD') {?>class="bold" style="font-size: 9px;" <?php }?>>
                                <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Net Amount</td>
                                <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format(($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['con_charge']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value),2);
}?></td>
                            </tr>
                        <?php }?>
                        <tr <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'PAD') {?>class="bold" style="font-size: 9px;" <?php }?>>
                            <td align="left" width="50%" class="bold" style="border-right: 0.1px solid #000;">Amount Paid</td>
                            <td align="left" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->paymentAmount,2);
}?></td>
                        </tr>
                                                <?php $_smarty_tpl->_assignInScope('balance_to_pay', ($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['con_charge']->value)-$_smarty_tpl->tpl_vars['summary']->value->paymentAmount+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value);?>
                        <?php if ($_smarty_tpl->tpl_vars['balance_to_pay']->value > 0) {?>
                            <tr style="font-size: 9px;" class="bordered-new">
                                <td align="left" width="50%" class="bold">Amount Balance</td>
                                <td align="left" width="50%">&nbsp;&nbsp;<b><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['balance_to_pay']->value,2);
}?></b></td>
                            </tr>
                        <?php }?>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>

    <!--<br><br>           
    <table width="100%" cellpadding="5" class="table bordered ">
    <tr>
        <td align="left" width="20%" class="bold">Payment Type</td>
        <td align="left" width="30%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->paymentType->name;?>
</td> 
        <td align="left" width="20%" class="bold">Cargo Status</td>
        <td align="left" width="30%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoStatus->name;?>
</td> 
    </tr>
    </table>-->

    <br>
    <?php if (count($_smarty_tpl->tpl_vars['summary']->value->remarks)) {?>
        <table cellpadding="1">
            <tbody class="body_table">
                <tr class="success">
                    <td width="1%"></td>
                    <td><b>Remarks : </b>
                        <?php $_smarty_tpl->_assignInScope('remarksarr', array());?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->remarks, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['remarksarr']) ? $_smarty_tpl->tpl_vars['remarksarr']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[] = $_smarty_tpl->tpl_vars['row']->value->name;
$_smarty_tpl->_assignInScope('remarksarr', $_tmp_array);?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        <?php echo implode($_smarty_tpl->tpl_vars['remarksarr']->value,'<br/>');?>

                    </td>
                </tr>
            </tbody>
        </table>
    <?php }?>

    <?php if (count($_smarty_tpl->tpl_vars['terms_list']->value) > 0) {?>
        <table width="100%" cellpadding="0">
            <tr class="success">
                <td><b>Terms & Conditions</b></td>
            </tr>
            <tbody class="body_table">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['terms_list']->value, 'term', false, NULL, 'carterm', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['term']->value) {
?>
                    <tr>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['term']->value->name;?>
</td>
                    </tr>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
        </table>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?>
        <table width="100%" cellpadding="2" style="border: 1px solid #000;">
            <tr>
                <td class="bold" width="35%" style="border-bottom: 1px solid #000;">Name - RKT SPEED PARCEL SERVICES</td>
                <td class="bold" align="center" width="40%" style="border-bottom: 1px solid #000;">Current Ac. No – 510909010174793</td>
                <td class="bold" width="25%" style="border-bottom: 1px solid #000;">IFSC - CIUB0000153</td>
            </tr>
            <tr>
                <td class="bold" width="35%">Bank - CITY UNION BANK</td>
                <td class="bold" align="center" width="40%">Branch - Tiruchirapalli Contonment Branch - 620001</td>
                <td class="bold" width="25%">GST No - 29AAZFR4180P1ZY</td>
            </tr>
        </table>
    <?php }?>

    <?php $_smarty_tpl->_assignInScope('rcmby', '');?>
    <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "TPPAD" || $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "TOP") {?>
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST != '') {?>
            <?php $_smarty_tpl->_assignInScope('rcmby', "RECEIVER");?>
        <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST != '' && $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST == '') {?>
            <?php $_smarty_tpl->_assignInScope('rcmby', "SENDER");?>
        <?php }?>
    <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST != '') {?>
        <?php $_smarty_tpl->_assignInScope('rcmby', "SENDER");?>
    <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST == '' && $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST != '') {?>
        <?php $_smarty_tpl->_assignInScope('rcmby', "RECEIVER");?>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "ybmlogistics") {?>
        <table width="100%" cellpadding="1">
            <tr class="success">
                <td align="center">
                    <?php if ($_smarty_tpl->tpl_vars['rcmby']->value != '') {?>
                        GST is payable by <?php echo $_smarty_tpl->tpl_vars['rcmby']->value;?>
 (RCM)
                    <?php } else { ?>
                        GST is exempted
                    <?php }?>
                </td>
            </tr>
        </table>
    <?php }?>

    <table width="100%" cellpadding="1">
        <tr class="success">
            <?php $_smarty_tpl->_assignInScope('bookeddate', explode(" ",$_smarty_tpl->tpl_vars['summary']->value->bookedAt));?>
            <?php $_smarty_tpl->_assignInScope('bookedtime', timeToMinutes($_smarty_tpl->tpl_vars['bookeddate']->value[1]));?>
            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes) && $_smarty_tpl->tpl_vars['bookedtime']->value > $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes) {?>
                <?php $_smarty_tpl->_assignInScope('transitCloseMinutes', $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes);?>
                <?php if ($_smarty_tpl->tpl_vars['transitCloseMinutes']->value < 720) {
$_smarty_tpl->_assignInScope('transitCloseMinutes', $_smarty_tpl->tpl_vars['transitCloseMinutes']->value+720);
}?>
                <td align="left"><b>Next Day Booking :</b> <?php echo addMinutesToDateTime($_smarty_tpl->tpl_vars['transitCloseMinutes']->value,$_smarty_tpl->tpl_vars['summary']->value->bookedAt,'d-m-Y');?>
</td>
            <?php }?>
            <td align="right" style="font-size:7px;">This is computer generated receipt no signature required</td>
        </tr>
    </table>

<?php }
}
}
