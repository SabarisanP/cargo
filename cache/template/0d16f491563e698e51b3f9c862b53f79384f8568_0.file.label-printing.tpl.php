<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-27 14:51:01
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\label-printing.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667d2efd818f43_37808081',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '0d16f491563e698e51b3f9c862b53f79384f8568' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\label-printing.tpl',
      1 => 1719464252,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667d2efd818f43_37808081 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
 <div id="label-printing-commands">
    <?php $_smarty_tpl->_assignInScope('itemIndex', 1);?>
    <?php $_smarty_tpl->_assignInScope('totQty', 0);?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'item', false, 'itemkey');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['itemkey']->value => $_smarty_tpl->tpl_vars['item']->value) {
?>
        <?php $_smarty_tpl->_assignInScope('totQty', $_smarty_tpl->tpl_vars['totQty']->value+$_smarty_tpl->tpl_vars['item']->value->itemCount);?>        
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'item', false, 'itemkey');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['itemkey']->value => $_smarty_tpl->tpl_vars['item']->value) {
?>
        <?php $_smarty_tpl->_assignInScope('itemCount', $_smarty_tpl->tpl_vars['cargo_setting']->value->maxLabelPrintCount);?>
        <?php if ($_smarty_tpl->tpl_vars['item']->value->itemCount <= $_smarty_tpl->tpl_vars['cargo_setting']->value->maxLabelPrintCount) {?>
            <?php $_smarty_tpl->_assignInScope('itemCount', $_smarty_tpl->tpl_vars['item']->value->itemCount);?>
        <?php }?>

        <?php $_smarty_tpl->_assignInScope('item_Count', $_smarty_tpl->tpl_vars['itemkey']->value+1);?>
        <?php
$_smarty_tpl->tpl_vars['qtyIndex'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['qtyIndex']->step = 1;$_smarty_tpl->tpl_vars['qtyIndex']->total = (int) ceil(($_smarty_tpl->tpl_vars['qtyIndex']->step > 0 ? $_smarty_tpl->tpl_vars['itemCount']->value+1 - (1) : 1-($_smarty_tpl->tpl_vars['itemCount']->value)+1)/abs($_smarty_tpl->tpl_vars['qtyIndex']->step));
if ($_smarty_tpl->tpl_vars['qtyIndex']->total > 0) {
for ($_smarty_tpl->tpl_vars['qtyIndex']->value = 1, $_smarty_tpl->tpl_vars['qtyIndex']->iteration = 1;$_smarty_tpl->tpl_vars['qtyIndex']->iteration <= $_smarty_tpl->tpl_vars['qtyIndex']->total;$_smarty_tpl->tpl_vars['qtyIndex']->value += $_smarty_tpl->tpl_vars['qtyIndex']->step, $_smarty_tpl->tpl_vars['qtyIndex']->iteration++) {
$_smarty_tpl->tpl_vars['qtyIndex']->first = $_smarty_tpl->tpl_vars['qtyIndex']->iteration === 1;$_smarty_tpl->tpl_vars['qtyIndex']->last = $_smarty_tpl->tpl_vars['qtyIndex']->iteration === $_smarty_tpl->tpl_vars['qtyIndex']->total;?>
            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "arthitravels") {?>
                <?php echo '<script'; ?>
 type="text/template">^XA^MMT^PW639^LL0280^LS0^FT9,240^BQN,2,7^FH^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT225,75^A0N,68,67^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT225,135^A0N,51,50^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode;?>
-<?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode;?>
^FS^FT223,200^A0N,34,36^FH^FD<?php echo $_smarty_tpl->tpl_vars['item']->value->cargoItem->name;?>
^FS^FT18,259^A0N,23,20^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedAt;?>
^FS^FT418,215^A0N,51,50^FB190,1,0,C^FH^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO410,160^GB208,69,3^FS^FT225,265^A0N,30,40^FH^FDwww.arthitransports.com^FS^PQ1,0,1,Y^XZ<?php echo '</script'; ?>
>
            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "sssparcel") {?>
                <?php echo '<script'; ?>
 type="text/template">^XA^MMT^PW639^LL0280^LS0^FT9,240^BQN,2,7^FH^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT225,75^A0N,68,67^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT225,135^A0N,51,50^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode;?>
-<?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode;?>
^FS^FT223,200^A0N,34,36^FH^FD<?php echo $_smarty_tpl->tpl_vars['item']->value->cargoItem->name;?>
^FS^FT18,259^A0N,23,20^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedAt;?>
^FS^FT418,215^A0N,51,50^FB190,1,0,C^FH^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO410,160^GB208,69,3^FS^FT220,265^A0N,30,38^FH^FDwww.sssparcelservice.com^FS^PQ1,0,1,Y^XZ<?php echo '</script'; ?>
>
            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "rajeshexpress") {?>
                <?php $_smarty_tpl->_assignInScope('cargo_code', explode('-',$_smarty_tpl->tpl_vars['summary']->value->code));?>
                <?php echo '<script'; ?>
 type="text/template">^XA^MMT^PW639^LL0280^LS0^FT9,249^BQN,2,7^FH\^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT225,84^A0N,68,67^FH\^FD<?php echo end($_smarty_tpl->tpl_vars['cargo_code']->value);?>
^FS^FT225,145^A0N,51,50^FH\^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode;?>
-<?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode;?>
^FS^FT223,208^A0N,34,36^FH\^FD<?php echo $_smarty_tpl->tpl_vars['item']->value->cargoItem->name;?>
^FS^FT19,269^A0N,23,19^FH\^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedAt;?>
^FS^FT418,223^A0N,51,50^FB190,1,0,C^FH\^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO410,167^GB208,69,3^FS^PQ1,0,1,Y^XZ<?php echo '</script'; ?>
>
            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "cityparcel") {?>
                <?php $_smarty_tpl->_assignInScope('cargo_code', explode('-',$_smarty_tpl->tpl_vars['summary']->value->code));?>
                <?php echo '<script'; ?>
 type="text/template">^XA^MMT^PW780^LL0110^LS0^FT300,38^A0N,45,47^FH^FDCity Express Parcel^FS^FT12,235^BQN,2,7^FH\^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT235,90^A0N,40,42^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT235,135^A0N,30,30^FH^FD<?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name));?>
 - <?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->toOrganization->name));?>
^FS^FT235,210^A0N,40,42^FB190,1,0,C^FH^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO235,160^GB208,69,3^FS^FT450,185^A0N,30,32^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
^FS^FT450,225^A0N,30,32^FH^FD<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
^FS^PQ1,0,1,Y^XZ<?php echo '</script'; ?>
>
            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "cargodemo") {?>
                <?php $_smarty_tpl->_assignInScope('cargo_code', explode('-',$_smarty_tpl->tpl_vars['summary']->value->code));?>
                <?php echo '<script'; ?>
 type="text/template">^XA^MMT^PW780^LL0110^LS0^FT300,38^A0N,45,47^FH^FDDemo Transports^FS^FT12,235^BQN,2,7^FH\^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT235,90^A0N,40,42^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT235,135^A0N,30,30^FH^FD<?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name));?>
 - <?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->toOrganization->name));?>
^FS^FT235,210^A0N,40,42^FB190,1,0,C^FH^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO235,160^GB208,69,3^FS^FT450,185^A0N,30,32^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
^FS^FT450,225^A0N,30,32^FH^FD<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
^FS^FT20,260^A0N,30,38^FH^FDwww.demologistics.com^FS^PQ1,0,1,Y^XZ<?php echo '</script'; ?>
>
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "kkexpress") {?>
                  <?php $_smarty_tpl->_assignInScope('cargo_code', explode('-',$_smarty_tpl->tpl_vars['summary']->value->code));?>
                <?php echo '<script'; ?>
 type="text/template">^XA^LL812^PW812^FO250,50^A0,45^FDKK Express Cargo^FS^FO25,25^GB780,750,2^FS^FO280,100^A0,30^FDwww.kkexcargo.com^FS^FO25,130^GB780,3,3^FS^FT100,180^A0N,40,35^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT600,180^A0N,40,35^FH^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO25,195^GB780,3,3^FS^FT330,410^BQN,2,6^FH^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FO25,410^GB780,3,3^FS^FO500,440^A25,25,20^FD<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
^FS^FO25,480^GB780,3,3^FS^FO25,650^GB780,3,3^FS^FO60,680^A0,28^FDMobile :^FS^FO180,680^A0,28^FD8554224444^FS^FO60,720^A0,28^FDWebsite :^FS^FO180,720^A0,28^FDkkex.in^FS^FO250,510^BY1,3.0,75^B3N,N,100,Y,N^FD>:ezcg.in/tR/9j9h/4/6^FS^FO70,435^A0,35^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode;?>
-<?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode;?>
^XZ<?php echo '</script'; ?>
>
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "rajeshcargo") {?>
                  <?php $_smarty_tpl->_assignInScope('cargo_code', explode('-',$_smarty_tpl->tpl_vars['summary']->value->code));?>
                <?php echo '<script'; ?>
 type="text/template">^XA^MMT^PW780^LL0110^LS0^FT300,38^A0N,45,47^FH^FDRajesh Transports^FS^FT12,235^BQN,2,7^FH\^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT235,90^A0N,40,42^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT235,135^A0N,30,30^FH^FD<?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name));?>
 - <?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->toOrganization->name));?>
^FS^FT235,210^A0N,40,42^FB190,1,0,C^FH^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO235,160^GB208,69,3^FS^FT450,185^A0N,30,32^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
^FS^FT450,225^A0N,30,32^FH^FD<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
^FS^FT20,260^A0N,30,38^FH^FDwww.rajeshtransports.com^FS^FT430,260^A0N,28,36^FH^FDcall us: 7353117777^FS^PQ1,0,1,Y^XZ<?php echo '</script'; ?>
>
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "challengexpress") {?>
                  <?php $_smarty_tpl->_assignInScope('cargo_code', explode('-',$_smarty_tpl->tpl_vars['summary']->value->code));?>
                <?php echo '<script'; ?>
 type="text/template">^XA^MMT^PW780^LL0110^LS0^FT300,38^A0N,40,40^FH^FDChallenge Xpress^FS^FT3,280^BQN,2,8^FH\^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT245,90^A0N,40,42^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT245,140^A0N,35,35^FH^FD<?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name));?>
 - <?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->toOrganization->name));?>
^FS^FT245,220^A0N,42,42^FB190,1,0,C^FH^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO245,165^GB180,69,3^FS^FT435,190^A0N,30,32^FH^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
^FS^FT435,230^A0N,30,32^FH^FD<?php echo $_smarty_tpl->tpl_vars['item']->value->cargoItem->name;?>
^FS^FT650,40^A0N,25,20^FH^FD<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
^FS^FT285,265^A0N,30,40^FH^FDwww.challengexpress.in^FS^PQ1,0,1,Y^XZ<?php echo '</script'; ?>
>
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "seenutransports") {?>
                  <?php $_smarty_tpl->_assignInScope('cargo_code', explode('-',$_smarty_tpl->tpl_vars['summary']->value->code));?>
                <?php echo '<script'; ?>
 type="text/template">^XA^POI^CI0^FO14,16^GB777,577,6^FS^FT100,380^AAR,28^FD<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
^FS^FO570,40^GFA,16560,16560,30,,:::::::::::::::::::gH0FC,g03IFE,Y01KFC,Y0MF,X03MFC,X0NFE,W03OF8,W07OFCP0JF8,V01PFEO07KF,V03QFN01LFC,V0RF8M07MF,U01RF8L01NFC,U03RFCL03NFE,U07RFEL07OF,U0SFEK01PFC,T01TFK03PFE,T03TF8J07QF,T07TF8J07QF,T0MF801KF8J0RF8,T0LFCI07JFCI01RFC,S01KFEJ01JFCI03RFE,S03KF8K0JFEI07SF,S03KFL07IFEI07SF,S07JFCL03IFEI0TF8,S0KF8L03JFI0TF8,S0KFM01JF001TFC,R01JFEM01JF003TFC,R01JFCN0JF003TFE,R03JF8N0JF807TFE,R03JF8N07IF807UF,R07JFO07IF807UF,R07IFEO07IF80VF,R0JFEO07IF80VF8,R0JFCO03IF81VF8,Q01JF8J07CI03IF81VF8,Q01JF8I03FF8003IF81VFC,Q03JFJ0IFE007IF83VFC,Q03JFI01JF007IF83VFC,Q03JFI03JF807IF83VFC,Q07IFEI07JFC0JF87VFC,Q07IFEI0LF1JF87VFC,Q07IFC001LFDJF87OF03KFC,Q0JFC001QF8OFC01KFE,Q0JFC003QF8OF800KFE,Q0JFC007QF1OFI07JFE,Q0JF8007QF1NFEI03JFE,P01JF8007QF1NFCI03JFE,P01JF800RF3NF8I01JFE,P01JF800QFE3NF8I01JFE,P01JF800QFE3NFK0JFE,P03JFI0QFE7NFK0JFE,P03JFI0QFC7MFEK07IFC,:P03JFI0QFCNFEK07IFC,P03JFI0QF8NFCK07IFC,:P07JFI0QF1NF8K07IFC,P07JFI07PF1NF8K07IFC,P07JFI07OFE3NF8K07IF8,P07JFI07OFC3NFL07IF8,P07JFI03OFC3NFL07IF8,P07JFI03OF87NFL07IF8,P07JFI01OF07MFEL0JF,:P07JFJ0NFE0NFCK01JF,P07JFJ07MFC0NFCK01IFE,P07JFJ03MF80NFCK03IFE,P07JFJ01MF01NF8K03IFE,P07JF8J0LFC01NF8K07IFC,P07JF8J03KF803NF8K07IFC,P07JF8J01JFE003NFL0JFC,P07JF8K03IFI03NFK01JF8,P07JFCL01EJ07NFK03JF8,P07JFCR07MFEK03JF8,P03JFCR07MFEK07JF,P03JFER0NFCK0KF,P03JFER0NFCJ01JFE,P03JFEQ01NFCJ03JFE,P03KFQ01NF8J07KF,P03KFQ03NF8J07KF,P03KF8P07NF8J0LF8,P01KF8P07NFJ01LFC,P01KFCP0OFJ03LFE,P01KFCO01NFEJ07LFE,P01KFEO03NFEJ0NF,Q0LFO07NFEI01NF8,Q0LF8N0OFCI01NFC,Q0LFCM01OFCI03NFC,Q0LFEM03OFCI07NFC,Q07LFM0PF8I0OF8,Q07LF8K01PF8001OF,Q07LFCK07PFI01NFE,Q03MFJ01QFI03NFE,Q03MFCI07PFEI07NFC,Q03NFC03QFEI0OF8,Q01gHFC001NFE,Q01gHFC001NF,Q01gHF8003MFC,R0gHFI03MF,R0gHFI03LF8,R07gFEI03KFC,R07gFEI01KF,R03gFCJ0JF8,R03gF8J07FFC,R01gFK03FE,R01gFL0F,S0YFE,S0YFC,S07XF8,S03XF,S03WFE,S01WFC,T0WF8,T07VF,T03UFC,T01UF8,U0UF,U07SFC,U01SF,V0RFE,V03QF8,V01PFC,W07OF,X0NF8,X03LFC,Y03JF8,,:::::gN0FFE,gL07KF8,gK07MF8,gJ03OF,gI01PFC,gI07PFE,gH01RF8,gH07RFC,gH0SFE,gG03TF,gG07TF8,gG0UFC,g01UFE,g03VF,g07VF8,g0WF8,Y01WFC,:Y03WFE,Y07XF,:Y0YF,Y0YF8,X01YF8,X01YFC,X03YFC,X03LFE07PFC,X07KFE007IF0LFE,X07KF8007IF01KFE,X07JFEI07IF007JFE,X0KFCI07IF001JFE,X0KF8I07IFI0KF,X0KFJ07IFI07JF,X0KFJ07IFI03JF,W01JFEJ07IFI01JF,:W01JFCJ07IFI01JF,:::W01JF8J07IFI01JF,W01JFCJ07IFI01JF,:W01JFCJ07IFI03JF,W01JFCJ07IFI07JF,W01JFEJ07IFI0KF,W01KFJ07IF003KF,W01KF8I07IF00LF,W01KFCI07IF0LFE,W01KFEI07PFE,W01LFI07PFE,W01LFC007PFE,X0LFE007PFE,X0MF807PFC,X0MFC07PFC,:X07LFC07PF8,::X03LFC07PF,:X01LFC07OFE,:Y0LFC07OFC,:Y07KFC07OF8,Y03KFC07OF,Y03KFC07NFE,Y01KFC07NFE,g0KFC07NFC,g07JFC07NF8,g03JFC07MFE,g01JFC07MFC,gG0JFC07MF8,gG07IFC07LFE,gG01IFC07LF8,gH0IFC07KFE,gH03FFC07KF,gI07FC00IFE,,::::::::::::gL07JFC,gK0MFE,gJ07NFC,gI03PF8,gI0QFE,gH03RF8,gH07RFC,gG01SFE,gG03TF8,gG07TFC,gG0UFE,g01UFE,g03VF,g07VF8,g0WFC,Y01WFC,Y03WFE,:Y07XF,Y0YF,:X01YF8,:X03YFC,:X03LFC03IFC3KFC,X07KFE003IFC0KFE,X07KF8003IFC03JFE,X07JFEI03IFC01JFE,X07JFCI03IFC007IFE,X0KF8I03IFC007IFE,X0KFJ03IFC003JF,X0KFJ03IFC001JF,X0JFEJ03IFC001JF,X0JFCJ03IFC001JF,X0JFCJ03IFCI0JF,W01JFCJ03IFCI0JF,::W01JFCJ03IFCI0JF8,W01JFCJ03IFC001JF8,X0JFCJ03IFC001JF,X0JFEJ03IFC003JF,:X0KFJ03IFC007JF,X0KF8I03IFC01KF,X0KFCI03IFC07KF,X0KFEI01IFC3LF,X07KFI01QF,X07KF8001PFE,X07KFE001PFE,X07LF001PFE,X03LFC01PFE,X03LFE01PFC,:X01LFE01PF8,:Y0LFE01PF8,Y0LFE01PF,Y07KFE01PF,Y07KFE01OFE,Y03KFE01OFC,Y01KFE01OFC,Y01KFE01OF8,g0KFE01OF,g07JFE01OF,g03JFE01NFE,g03KF01NFC,g01KF01NF8,gG07JF00NF,gG03JF00MFE,gG01JF00MFC,gH07IF00MF,gH03IF00LFE,gI07FF00LF8,gJ0FF00KFE,gK0300KF8,gN01IF,,:::::::Y07E,Y0FF8R03F,Y0FFER07FC,Y0IF8P01FFE,Y0IFEP03IF,Y0JF8O07IF8,Y0JFEO0JFC,X01KF807PFC,X01XFE,X01YF,:X01YF8,:X01YFC,:X01YFE,::X01gF,::X01gF8,::X01gFC,:::X01gFE,::Y0gFE,::Y0MF007PF8,Y0KFN03LF,Y0JFP0KFE,Y0IF8P07JF8,Y0FF8Q03JF,Y0FCR01IFE,Y04S01JF,gT0JF,:gT07IF,gT07IF8,gT0JF8,:gS01JFC,gS03JFC,gS0KFC,T01MFEO07KFC,S01gJFC,S07gJFC,R01gKFC,R07gKFE,R0gLFE,Q03gLFE,Q07gLFE,Q0gMFE,P01gMFC,:P03gMFC,P07gMFC,:P0gNF8,O01gNF8I0F,O01gNF800IF8,O01gNF003IFE,O01gNF007JF8,O01gMFE00KFE,O01gMFE00LF,O01gMFC01LFC,O01gMF801LFE,O01gMF003MF,O01gLFE003MF8,O01gLFC003MFC,O01gLF8003MFE,O01KFEI07UFEI03MFE,O01KFN01QF8I03NF,O01JFCR01LF8J01NF8,O01JFgK01NF8,O01IFEgL0NFC,O01JFgL07MFC,O01JF8gK03MFE,O01JFCgL0MFE,P0KFgL01MF,P0KF8gM0LF,P07JFCgM01KF8,P07KFgN0KF8,P03LFgM07JF8,P01LFCgL03JF8,P01MFgL01JFC,Q0MF8gK01JFC,Q07LFCgL0JFC,Q03LFEgL0JFC,Q01LFEgK01JFC,:R0MFI01SFN07JFC,R07LFI0gMFC,R03LF003gMFC,S0KFE007gMFC,S07JFE00gNFC,S03JFE01gNFC,T0JFC03gNFC,T03IFC07gNFC,U0IF00gOF8,V0FE00gOF8,Y01gOF8,Y03gOF,:Y03gNFE,Y07gNFE,Y07gNFC,:Y07gNF8,Y07gNF,Y07gMFE,Y07gMFC,Y0gNF8,Y07gMF,Y07gLFC,Y07gLF,Y07KFCJ01TFC,Y07JFEQ07MFC,Y07JF8,Y03IFE,Y03IF8,Y03IF,Y03IF8,Y01IFC,Y01IFES0E,Y01JFR03F8,g0JF8Q07FC,g0JFCQ0FFE,g0KFP01IF,Y03KF8O03IF,Y07LFO07IF8,X01MFCN0JF8,X01NFEL01JF8,X03gF8,X07gF8,:::X07gF,::X03gF,::X01gF,:Y0gF,:Y07YF8,:Y03YF8,:Y01YF8,:g0YF8,:g07XF8,g03JFM03LF8,g03IFEN03KF,g01IFEO07JF,gG0IFCO01JF,gG0IF8P07FFE,gG07FFQ01FFE,gG03FER07FC,gH0F8R01FC,gW0F8,gW03,,hI0F,hH0IF,hG03IFC,hG07C03E,hG0FI0F,h01EI078,h03CI03C,h038I01C,h073IF8E,h073IFCE,h063IFC6,h0E3IFC7,h0E00E1C7,h0E00C1C7,h0E00E1C7,h0E01E1C7,h0E07F787,h063IF86,h063FBF86,h073F3F0E,h03800C1C,h038I01C,h01CI038,hG0FI0F,hG07801E,hG03IFC,hH0IF,hH03FC,,:::::::::::::::::::^FS^FO480,16^GB4,575,4^FS^FO78,16^GB4,575,4^FS^FO600,16^GB4,575,4^FS^FO355,16^GB4,575,4^FS^FO380,280^GB80,4,4^FS^FO110,335^GB220,4,4^FS^FO15,590^GB775,4,4^FS^FT570,224^A0R,28^FDGC NUMBER^FS^FT300,410^A0R,28^FDART No.^FS^FT510,30^AUR,39^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT200,360^AVR,39^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FT450,112^A0R,28^FDORGIN^FS^FT450,353^A0R,28^FDDESTINATION^FS^FT394,20^AUR,33,99^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode;?>
^FS^FT394,323^AUR,33,99^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode;?>
^FS^FT108,325^BQN,2,8^FH^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT40,20^A0R,32^FD 044 26532772^FS^FT40,243^A0R,32^FDwww.seenutransports.com^FS^XZ<?php echo '</script'; ?>
>
            <?php } else { ?>
                <?php echo '<script'; ?>
 type="text/template">^XA^MMT^PW639^LL0280^LS0^FT9,249^BQN,2,7^FH\^FDHA,<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
/<?php echo $_smarty_tpl->tpl_vars['item_Count']->value;?>
/<?php echo $_smarty_tpl->tpl_vars['qtyIndex']->value;?>
^FS^FT225,84^A0N,68,67^FH\^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
^FS^FT225,145^A0N,51,50^FH\^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode;?>
-<?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode;?>
^FS^FT223,208^A0N,34,36^FH\^FD<?php echo $_smarty_tpl->tpl_vars['item']->value->cargoItem->name;?>
^FS^FT19,269^A0N,23,19^FH\^FD<?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedAt;?>
^FS^FT418,223^A0N,51,50^FB190,1,0,C^FH\^FD<?php echo $_smarty_tpl->tpl_vars['itemIndex']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['totQty']->value;?>
^FS^FO410,167^GB208,69,3^FS^PQ1,0,1,Y^XZ<?php echo '</script'; ?>
>
            <?php }?>

            <?php $_smarty_tpl->_assignInScope('itemIndex', $_smarty_tpl->tpl_vars['itemIndex']->value+1);?>
        <?php }
}
?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
</div>
<?php }
}
