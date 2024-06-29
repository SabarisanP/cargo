<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-15 13:10:58
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\delivery-receipt-3inch.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666d458a27b912_80231592',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'd96161911bb0e8b1bf1e0aa4427f4ba6792bbea5' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\delivery-receipt-3inch.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666d458a27b912_80231592 (Smarty_Internal_Template $_smarty_tpl) {
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

        body { max-width: 3in; }
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
                <td align="center" class="bold f17"><?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
</td>
            <?php }?>
        </tr>
        <tr>
            <td align="center" class="f13">
                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "ktwoklogistics") {?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1 != '') {?>
                        <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1;?>
, 
                    <?php }?>
                    <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>
 
                <?php } else { ?>
                    <?php if ($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1 != '') {?>
                        <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1;?>
, 
                    <?php }?>
                    <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>
 
                <?php }?>
                
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

    <table width="100%" cellpadding="4">
        <tr class="f12">
            <td class="bold" align="center">DELIVERY RECEIPT</td>
        </tr>
    </table> 

    <table width="100%" cellpadding="3">
        <tr>
            <td align="center" width="100%" colspan="2" class="f14 bold">
                <span class="f15">L.R No</span> : <span class="f15 bold"><?php echo $_smarty_tpl->tpl_vars['cargoCode']->value;?>
</span>
            </td>        
        </tr> 
        <tr>
            <td align="left" width="100%" colspan="2">
                <span class="f12">Delivery Date : </span>
                <span class="f11 bold"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->deliveredAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</span>
            </td>
        </tr>    
        <tr>
            <td align="left" width="60%">
                <span class="f14">Payment Type</span><br>
                <span class="f14 bold"><?php echo mb_strtoupper($_smarty_tpl->tpl_vars['payment_type_name']->value, 'UTF-8');?>
</span>
            </td> 
        </tr> 
        <tr>
            <td align="left" width="60%">
                <span class="f14">From</span><br>
                <span class="f14 bold"><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromStation->name;?>
</span>
            </td>
            <td align="left" width="60%">
                <span class="f14">To</span><br>
                <span class="f14 bold"><?php echo $_smarty_tpl->tpl_vars['summary']->value->toStation->name;?>
</span>
            </td>
        </tr>    
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
        <?php $_smarty_tpl->_assignInScope('transactionAmount', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
            <?php if ($_smarty_tpl->tpl_vars['row']->value->transactionType->code == 'CGCA') {?>
                <?php $_smarty_tpl->_assignInScope('transactionAmount', $_smarty_tpl->tpl_vars['transactionAmount']->value-$_smarty_tpl->tpl_vars['row']->value->transactionAmount);?>
            <?php } else { ?>
                <?php $_smarty_tpl->_assignInScope('transactionAmount', $_smarty_tpl->tpl_vars['transactionAmount']->value+$_smarty_tpl->tpl_vars['row']->value->transactionAmount);?>
            <?php }?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'PAD') {?>
            <?php $_smarty_tpl->_assignInScope('transactionAmount', $_smarty_tpl->tpl_vars['amountpaid']->value);?>
        <?php }?>
        <tr>
            <td align="right" class="f12" width="60%" valign="top">Amount Paid</td>
            <td align="left" class="f12" width="1%" valign="top"> : </td>
            <td align="right" class="f12 bold"><?php echo inr_format($_smarty_tpl->tpl_vars['transactionAmount']->value);?>
</td>
        </tr>
    </table>

    <div class="h-seperator"></div>
        
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

<?php echo '<script'; ?>
>
    // window.print();
    //window.close();
<?php echo '</script'; ?>
> <?php }
}
