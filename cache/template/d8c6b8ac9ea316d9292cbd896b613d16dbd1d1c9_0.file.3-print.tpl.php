<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-29 10:57:48
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\3-print.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6656bcd4f11808_85173854',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'd8c6b8ac9ea316d9292cbd896b613d16dbd1d1c9' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\3-print.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6656bcd4f11808_85173854 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<html>
<head>
    <style>
        *, *:before, *:after {
            color: #000 !important;
            font-family: Verdana, Tahoma, Arial, sans-serif;
            text-shadow: none !important;
            font-weight: normal;
            background: transparent !important;
            -webkit-box-shadow: none !important;
            box-shadow: none !important;
        }
        .f10{ font-size: 10px;}
        .f11{ font-size: 11px;}
        .f12{ font-size: 12px;}
        .f13{ font-size: 13px;}
        .f14{ font-size: 14px;}
        .f15{ font-size: 15px;}
        .f19{ font-size: 19px;}
        .bold{ font-weight: bold;}
        .h-seperator { border-bottom: 1px dashed #666; height: 0px; padding-top: 0px; padding-bottom: 0px; }
        .i{ font-style: italic;}
    </style>
</head>   
<body>
    <table width="100%" cellpadding="3">   
        
        <tr>            
            <?php if ($_smarty_tpl->tpl_vars['logo_avail']->value == 1) {?>
                <td align="center">
                    <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/img/clientlogo/<?php echo $_smarty_tpl->tpl_vars['namespace']->value;?>
_3inch.png?1" max-width="200px;" >
                </td>
            <?php } else { ?>
                <td align="center" class="bold f17"><?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'tvlscargo') {?>THIRUPPATHI VENKATACHALAPATHI LORRY SERVICE CHENNAI PVT LTD<?php } else {
echo $_smarty_tpl->tpl_vars['namespace_name']->value;
}?></td>
            <?php }?>
        </tr>
        <tr>
            <td align="center" class="f13">
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1 != '') {?>
                    <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1;?>
, 
                <?php }?>
                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>
 

                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rktparcel") {?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromStation->code == 'STF3OEX206') {?>
                        GSTIN : 29AAZFR4180P1ZY
                    <?php } else { ?>    
                        GSTIN : 33AAZFR4180P1Z9
                    <?php }?>            
                <?php } elseif ($_smarty_tpl->tpl_vars['summary']->value->tax->gstin) {?>                
                    <br> GSTIN : <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>

                <?php }?>
            </td>
        </tr>
        
    </table>

    <table width="100%">
        <tr>
            <td align="right" class="f10 i">
                Printed By <?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['usr_login_name']->value,10);?>
 @ <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
&nbsp;&nbsp;
            </td>     
        </tr>
    </table> 

    <div class="h-seperator"></div>

    <table width="100%" cellpadding="3">
        <tr>
            <td align="center" width="100%" colspan="2" class="f14 bold">
                <span class="f15">L.R No</span> : <span class="f15 bold"><?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
</span>
            </td>        
        </tr> 
        <tr>
            <td align="left" width="60%">
                <span class="f14">Payment Type</span><br>
                <span class="f14 bold"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['payment_type_name']->value, 'UTF-8');?>
</span>
            </td> 
            <td align="center" width="40%" rowspan="3">
                <div class="f11">Scan & Track</div>
                <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
qr?data=<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
&size=10" width="100px" >
            </td>   
        </tr> 
        <tr>
            <td align="left" width="60%">
                <span class="f14">From</span><br>
                <span class="f14 bold"><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromStation->name;?>
</span>
            </td>
        </tr>  
        <tr>
            <td align="left" width="60%">
                <span class="f14">To</span><br>
                <span class="f14 bold"><?php echo $_smarty_tpl->tpl_vars['summary']->value->toStation->name;?>
</span>
            </td>
        </tr>   
        <?php $_smarty_tpl->_assignInScope('bookeddate', explode(" ",$_smarty_tpl->tpl_vars['summary']->value->bookedAt));?>
        <?php $_smarty_tpl->_assignInScope('bookedtime', timeToMinutes($_smarty_tpl->tpl_vars['bookeddate']->value[1]));?>
        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes) && $_smarty_tpl->tpl_vars['bookedtime']->value > $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes) {?>
            <?php $_smarty_tpl->_assignInScope('transitCloseMinutes', $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->transitCloseMinutes);?>
            <?php if ($_smarty_tpl->tpl_vars['transitCloseMinutes']->value < 720) {
$_smarty_tpl->_assignInScope('transitCloseMinutes', $_smarty_tpl->tpl_vars['transitCloseMinutes']->value+720);
}?>
        <tr>
            <td align="left" width="100%" colspan="2">
                <span class="f12">Next Day Booking : </span>
                <span class="f11 bold"><?php echo addMinutesToDateTime($_smarty_tpl->tpl_vars['transitCloseMinutes']->value,$_smarty_tpl->tpl_vars['summary']->value->bookedAt,'d-m-Y');?>
</span>  
            </td>     	
        </tr>
        <?php }?> 
        <tr>
            <td align="left" width="100%" colspan="2">
                <span class="f12">Booked Date : </span>
                <span class="f11 bold"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</span>
            </td>
        </tr>    
    </table>

    <div class="h-seperator"></div>

    <?php $_smarty_tpl->_assignInScope('articlename', '');?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
?>           
        <?php $_smarty_tpl->_assignInScope('articlename', ((string)$_smarty_tpl->tpl_vars['articlename']->value)." ".((string)$_smarty_tpl->tpl_vars['article']->value->cargoItem->name)."  ( ".((string)$_smarty_tpl->tpl_vars['article']->value->itemCount)."  ),");?>                                         
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>  

    <?php $_smarty_tpl->_assignInScope('tot_amount', 0);?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
?>
        <?php $_smarty_tpl->_assignInScope('tot_amount', $_smarty_tpl->tpl_vars['tot_amount']->value+$_smarty_tpl->tpl_vars['article']->value->computed->freight);?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>


    <table width="100%" cellpadding="3">
        <tr>
            <td align="left" class="f12" width="50%" valign="top" style="border-right: 1px dashed #666;" >
                <span class="bold"><?php echo lang('booking_sender_term');?>
</span> <br>
                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
<br><span class="bold"><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
</span>
            </td> 
            <td align="left" class="f12" width="50%" valign="top"> 
                <span class="bold"><?php echo lang('booking_receiver_term');?>
</span> <br>
                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
<br><span class="bold"><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
</span>
            </td> 
        </tr>    
    </table>

    <table width="100%" cellpadding="3" style="display:none;">
        <tr>
            <td align="left" class="bold f12" width="30%" valign="top" ><?php echo lang('booking_sender_term');?>
</td> 
            <td align="left" class="bold f12" width="1%" valign="top"> : </td>    
            <td align="left" class="bold f12"><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
<br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
</td>        
        </tr>
        <tr>
            <td align="left" class="bold f12" width="30%" valign="top"><?php echo lang('booking_receiver_term');?>
</td>
            <td align="left" class="bold f12" width="1%" valign="top"> : </td>    
            <td align="left" class="bold f12"><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
<br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
</td>
        </tr>    
    </table>

    <div class="h-seperator"></div>

    <table width="100%" cellpadding="3">
        <tr>
            <td align="left" class="f12" width="20%" valign="top" >Article</td> 
            <td align="left" class="f12" width="1%" valign="top"> : </td>    
            <td align="left" class="f12"><?php echo $_smarty_tpl->tpl_vars['articlename']->value;?>
</td>        
        </tr>
    </table>

    <div class="h-seperator"></div>

    <table width="98%" cellpadding="3">
        <tr>
            <td align="right" class="f12" width="60%" valign="top" >Freight</td> 
            <td align="left" class="f12" width="1%" valign="top"> : </td>    
            <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalAmount,2);?>
</td>        
        </tr>  
        <tr>
            <td align="right" class="f12" width="60%" valign="top" >L Charges</td> 
            <td align="left" class="f12" width="1%" valign="top"> : </td>    
            <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount,2);?>
</td>        
        </tr>   
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount > 0) {?>
        <tr>
            <td align="right" class="f12" width="60%" valign="top" >Pickup Charges</td> 
            <td align="left" class="f12" width="1%" valign="top"> : </td>    
            <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount,2);?>
</td>        
        </tr> 
        <?php }?>  
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount > 0) {?>
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Delivery Charges</td> 
                <td align="left" class="f12" width="1%" valign="top"> : </td>    
                <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount,2);?>
</td>        
            </tr> 
        <?php }?>  
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge > 0) {?>
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Hamali Charges</td> 
                <td align="left" class="f12" width="1%" valign="top"> : </td>    
                <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge,2);?>
</td>        
            </tr> 
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->passCharge > 0) {?>
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Pass Charges</td> 
                <td align="left" class="f12" width="1%" valign="top"> : </td>    
                <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->passCharge,2);?>
</td>        
            </tr> 
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->docketCharge > 0) {?>
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Docket Charges</td> 
                <td align="left" class="f12" width="1%" valign="top"> : </td>    
                <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->docketCharge,2);?>
</td>        
            </tr> 
        <?php }?>
        <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH'])) {?>
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >POD Charges</td>
                <td align="left" class="f12" width="1%" valign="top"> : </td>
                <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value,2);?>
</td>
            </tr>
        <?php }?>

        <?php if ($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount > 0) {?>
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Unloading Charges</td>
                <td align="left" class="f12" width="1%" valign="top"> : </td>
                <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount,2);?>
</td>
            </tr>
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->serviceCharge > 0) {?>
            <tr>
                <td align="right" class="f12" width="60%" valign="top" >Service Charges</td>
                <td align="left" class="f12" width="1%" valign="top"> : </td>
                <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceCharge,2);?>
</td>
            </tr>
        <?php }?>

        <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue != 0) {?>
        <tr>
            <td align="right" class="f12" width="60%" valign="top">CGST</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue,2);?>
</td>
        </tr>
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue != 0) {?>
        <tr>
            <td align="right" class="f12" width="60%" valign="top">SGST</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue,2);?>
</td>
        </tr>
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue != 0) {?>
        <tr>
            <td align="right" class="f12" width="60%" valign="top">UGST</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue,2);?>
</td>
        </tr>
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue != 0) {?>
        <tr>
            <td align="right" class="f12" width="60%" valign="top">IGST</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue,2);?>
</td>
        </tr>
        <?php }?>
        <tr>
            <td align="right" class="f12" width="60%" valign="top">Net Amount</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12 bold"><?php echo number_format(($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value),2);?>
</td>
        </tr>

        <tr>
            <td align="right" class="f12" width="60%" valign="top">Amount Paid</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12 bold"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->paymentAmount,2);?>
</td>
        </tr>
        <?php $_smarty_tpl->_assignInScope('balance_to_pay', ($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value)-$_smarty_tpl->tpl_vars['summary']->value->paymentAmount);?>
        <?php if ($_smarty_tpl->tpl_vars['balance_to_pay']->value > 0) {?>
            <tr>
                <td align="right" class="f12" width="60%" valign="top">TOTAL</td>
                <td align="left" class="f12" width="1%" valign="top"> : </td>
                <td align="right" class="f14 bold"><?php echo number_format($_smarty_tpl->tpl_vars['balance_to_pay']->value,2);?>
</td>
            </tr>
        <?php }?>
    </table>

    <div class="h-seperator"></div>
    <table width="100%" cellpadding="3">    
        <tr>
            <td align="left" class="f12">
                <span class="bold"> Delivery Address : </span> <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>
                 
                <?php if ($_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1 != '') {?>
                    <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1;?>
 , 
                <?php }?>
                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>

            </td>
        </tr>   
    </table>
    <div class="h-seperator"></div>
        
    <?php if (count($_smarty_tpl->tpl_vars['terms_list']->value) > 0) {?>  
    <table width="100%">
        <tr>
            <td align="left" width="100%" class="f13 bold">Terms & Conditions</td>
        </tr>
        
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['terms_list']->value, 'term', false, NULL, 'carterm', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['term']->value) {
?>
        <tr>
            <td align="left" width="100%" class="f11">
                <?php echo $_smarty_tpl->tpl_vars['term']->value->name;?>
 
            </td>
        </tr> 
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        
    </table>
    <div class="h-seperator"></div>
    <?php }?>

    <table width="100%">
        <tr>
            <td align="center" class="f12 bold">
                Unloading / Service charges paid by party at the time of delivery
            </td>     
        </tr>
    </table>    

    <table width="100%">    
        <tr>
            <td align="center" class="f12">Thank You  -   <?php echo $_smarty_tpl->tpl_vars['user_profile']->value->namespace->namespaceProfile->domainURL;?>
</td>        
        </tr>    
    </table>
    <div class="h-seperator"></div>
    <table width="100%">    
        <tr>
            <td align="center" class="f11 i">Powered By www.ezeecargo.com</td>        
        </tr>    
    </table>

    <br/>
  
</body> 
</html>

<?php if ($_REQUEST['markingtoken'] == 1) {?>
    <!-- TOKEN -->
    <html>
    <head> 
    <style>
            *, *:before, *:after {
                color: #000 !important;
                font-family: Verdana, Tahoma, Arial, sans-serif;
                text-shadow: none !important;
                font-weight: normal;
                background: transparent !important;
                -webkit-box-shadow: none !important;
                box-shadow: none !important;
            }
            .f10{ font-size: 10px;}
            .f11{ font-size: 11px;}
            .f12{ font-size: 12px;}
            .f13{ font-size: 13px;}
            .f14{ font-size: 14px;}
            .f15{ font-size: 15px;}
            .f21{ font-size: 21px;}
            .bold{ font-weight: bold;}
            .boxed{ border:1px dashed #000; padding: 3px; margin: 3px; }
            .h-seperator { border-bottom: 1px dashed #666; height: 0px; padding-top: 0px; padding-bottom: 0px; }
            .i{ font-style: italic;}
        </style>
    </head>
    <body>
        <br/>
        <table width="100%" cellpadding="2">
            <tr>
                <td align="center" width="100%" colspan="3" class="f21 bold boxed"><?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
</td>        
            </tr> 
            <tr>
                <td align="center" class="f14 bold" width="48%">                
                    <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromStation->name;?>
 
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode != '') {?>
                        <br>
                        ( <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode;?>
 )
                    <?php }?>
                </td>            
            
                <td align="center" class="f13 bold" > => </td>
            
                <td align="center" class="f14 bold" width="48%">
                    <?php echo $_smarty_tpl->tpl_vars['summary']->value->toStation->name;?>
 
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode != '') {?>
                        <br>
                        ( <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode;?>
 )
                    <?php }?>
                </td>
            </tr>
        </table>
        <div class="h-seperator"></div>
        <table width="100%" cellpadding="2">
            <tr>
            <td align="left">
                <?php echo $_smarty_tpl->tpl_vars['articlename']->value;?>

            </td>
            </tr>
        </table>
        <div class="h-seperator"></div>
        <br/>
        
    </body> 
    </html>
    <?php }?>
    
    <?php echo '<script'; ?>
>
        window.print();
        //window.close();
    <?php echo '</script'; ?>
> <?php }
}
