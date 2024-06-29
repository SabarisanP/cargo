<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-27 17:25:05
  from 'E:\xampp\htdocs\cargo\application\views\site\template.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667d5319e00e48_40230438',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '9041ab65fecad67b8b7e5dd9afd388476fce6be0' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\template.tpl',
      1 => 1719486444,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:site/template/namespace-dialog.tpl' => 1,
    'file:site/template/print-ticket-dialog.tpl' => 1,
    'file:site/template/ep-print-dialog.tpl' => 1,
    'file:site/template/document-upload-dialog.tpl' => 1,
    'file:site/template/cargo-dialogs.tpl' => 1,
  ),
),false)) {
function content_667d5319e00e48_40230438 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
if ($_smarty_tpl->tpl_vars['is_logged_in']->value == 1) {?>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <base href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
 ">
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <title><?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
</title>
        <!--<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no">-->
        <meta name="description" content="">
        <meta name="author" content="">
        <?php echo '<script'; ?>
>
            var base_url = "<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
";
            var load_data = {};
            var base = "<?php echo $_smarty_tpl->tpl_vars['base']->value;?>
";
            var ns_name = "<?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
";
            var ns_branchname = "<?php echo $_smarty_tpl->tpl_vars['login_branch_name']->value;?>
";
            var ns_username = "<?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
";
            var dilg = new Array();
        <?php echo '</script'; ?>
>

        <link rel="shortcut icon" href="assets/img/login/favicon.png" />
        <!-- bootstrap framework -->
        <link href="assets/bootstrap/css/bootstrap.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">
        <link href="assets/css/non-responsive.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">

        <!-- font fakt -->
        <!--<link href="assets/css/fonts-fakt.css" rel="stylesheet" media="screen">-->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">

        <!-- custom icons -->
        <!-- font awesome icons -->
        <link href="assets/icons/font-awesome/css/font-awesome.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">
        <!-- ionicons -->
        <link href="assets/icons/ionicons/css/ionicons.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">

        <!-- nvd3 charts -->
        <link rel="stylesheet" href="assets/lib/novus-nvd3/nv.d3.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen">

        <!-- datepicker -->
        <link rel="stylesheet" href="assets/lib/bootstrap-daterangepicker/daterangepicker-bs3.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"
            media="screen">
        <link rel="stylesheet" href="assets/lib/bootstrap-datepicker/css/datepicker3.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen">
        <link rel="stylesheet" href="assets/lib/bootstrap-timepicker/css/bootstrap-timepicker.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"
            media="screen">


        <!-- multiselect, tagging -->
        <link rel="stylesheet" href="assets/lib/select2/select2.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen">
        <link rel="stylesheet" href="assets/css/bootstrap-select.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen">
        <link rel="stylesheet" href="assets/lib/bootstrap-switch/build/css/bootstrap3/bootstrap-switch.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"
            media="screen">
        <link rel="stylesheet" href="assets/lib/bootstrap-multiselect/css/bootstrap-multiselect.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"
            media="screen">

        <link rel="stylesheet" type="text/css" href="assets/lib/tabdrop/tabdrop.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen" />

        <!-- ion.rangeSlider -->
        <link rel="stylesheet" href="assets/lib/ion.rangeSlider/css/ion.rangeSlider.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen">
        <link rel="stylesheet" href="assets/css/screen.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen">

        <link rel="stylesheet" href="assets/lib/fullcalendar/fullcalendar/fullcalendar.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
">

        <link rel="stylesheet" href="assets/lib/DataTables/media/css/jquery.dataTables.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
">
        
        <link rel="stylesheet"
            href="assets/lib/DataTables/extensions/TableTools/css/dataTables.tableTools.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
">
        <link rel="stylesheet"
            href="assets/lib/DataTables/extensions/Scroller/css/dataTables.scroller.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
">
        <link rel="stylesheet"
            href="assets/lib/DataTables/extensions/FixedColumns/css/dataTables.fixedColumns.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
">
        <link rel="stylesheet"
            href="assets/lib/DataTables/extensions/FixedHeader/css/dataTables.fixedHeader.min.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
">

        <!-- main stylesheet -->
        <link href="assets/css/jquery-ui.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">
        <!--<link href="assets/css/ui.jqgrid.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">-->
        <link href="assets/css/jquery.multiselect.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">
        <link href="assets/css/sweet-alert.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">
        <link href="assets/css/nprogress.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">
        <link href="assets/css/style.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="screen">

        <link href="assets/css/print.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet" media="print">
        <link rel="stylesheet" href="assets/css/chat.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen">
        <link rel="stylesheet" type="text/css" href="assets/css/jquery.fancybox.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen" />
        <link rel="stylesheet" type="text/css" href="assets/css/jquery.fancybox-thumbs.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "sreekannathal") {?>
            <link rel="stylesheet" type="text/css" href="assets/css/theme-kannathal.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen" />
        <?php }?>

        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "rajeshexpress" || $_smarty_tpl->tpl_vars['namespace']->value == "rajeshcargo") {?>
            <link rel="stylesheet" type="text/css" href="assets/css/theme-rajeshcargo.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen" />
        <?php }?>

        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "varahi") {?>
            <link rel="stylesheet" type="text/css" href="assets/css/theme-varahi.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen" />
        <?php }?>

        <?php if (mb_strtolower($_smarty_tpl->tpl_vars['current_product_name']->value, 'UTF-8') != "bits") {?>
            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "tippusultan") {?>
                <link rel="stylesheet" type="text/css" href="assets/css/theme-tippusultancargo.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen" />
            <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == "tippusultantrans") {?>
                <link rel="stylesheet" type="text/css" href="assets/css/theme-tippusultantrans.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" media="screen" />
            <?php } else { ?>
                <link rel="stylesheet" type="text/css" href="assets/css/product-<?php echo mb_strtolower($_smarty_tpl->tpl_vars['current_product_name']->value, 'UTF-8');?>
.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"
                    media="screen" />
            <?php }?>
        <?php }?>

        <?php if ($_smarty_tpl->tpl_vars['environment']->value == 'PROD') {?>
            
                <?php echo '<script'; ?>
>
                    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q = i[r].q || []).push(arguments)
                    }, i[r].l = 1 * new Date();
                    a = s.createElement(o),
                        m = s.getElementsByTagName(o)[0];
                    a.async = 1;
                    a.src = g;
                    m.parentNode.insertBefore(a, m)
                    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
                    ga('create', 'UA-133864396-28', 'auto');
                    ga('send', 'pageview');
                <?php echo '</script'; ?>
>
            
        <?php } else { ?>
            
                <?php echo '<script'; ?>
>
                    function ga() {}
                <?php echo '</script'; ?>
>
            
        <?php }?>

        <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
user/actions"><?php echo '</script'; ?>
>
        <?php echo $_smarty_tpl->tpl_vars['js_script']->value;?>


        <?php echo '<script'; ?>
 src="assets/lib/highcharts/highcharts.js"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 src="assets/lib/highcharts/exporting.js"><?php echo '</script'; ?>
>
    </head>

    <body>
        <!-- HEADER -->

        <div id="navigation" class="navbar-fixed-top" data-spy="affix" data-offset-top="52">
            <div class="container-fluid">
                <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'rajeshcargo' || $_smarty_tpl->tpl_vars['namespace']->value == "rajeshexpress") {?>
                    <a id="brand" href="">
                        <img src="assets/img/rajeshexpress-header.png" alt="logo">
                        <span class="hide"><?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
</span>
                    </a>
                <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == 'varahi') {?>
                    <a id="brand" href="">
                        <img src="assets/img/varahi.png" alt="logo">
                        <span class="hide"><?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
</span>
                    </a>
                                <?php } else { ?>
                                        <a id="brand" href=""> <?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
</a>
                <?php }?>

                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['parent']->value, 'entry');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['entry']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['entry']->value['code'] == "USER-BAL-EXCD-CRDT-LIMT") {?>
                        <?php $_smarty_tpl->_assignInScope('Menuflag', true);?>
                    <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                <ul class="main-nav">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['parent']->value, 'entry');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['entry']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['entry']->value['link'] != 'hidden') {?>
                            <?php if ($_smarty_tpl->tpl_vars['Menuflag']->value) {?>
                                <li data-trigger="hover" style="pointer-events: none;">
                                <?php } else { ?>
                                <li data-trigger="hover">
                                <?php }?>

                                <a class="dropdown-toggle" data-toggle="dropdown"
                                    href="<?php if ($_smarty_tpl->tpl_vars['entry']->value['link'] != '#' || $_smarty_tpl->tpl_vars['entry']->value['link'] != '') {
echo $_smarty_tpl->tpl_vars['entry']->value['link'];
}?>">
                                    <?php if ($_smarty_tpl->tpl_vars['entry']->value['code'] == "USER-BAL-EXCD-CRDT-LIMT") {?>
                                    <?php } else { ?>
                                        <?php echo $_smarty_tpl->tpl_vars['entry']->value['name'];?>

                                    <?php }?>
                                    <?php if (is_array($_smarty_tpl->tpl_vars['submenu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']])) {?>
                                        <span class="caret"></span>
                                    <?php }?>
                                </a>

                                <?php if (is_array($_smarty_tpl->tpl_vars['submenu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']])) {?>
                                    <?php if ($_smarty_tpl->tpl_vars['entry']->value['code'] == 'MNFCR3311') {?>                                         <?php $_smarty_tpl->_assignInScope('partitions', partition_submenus($_smarty_tpl->tpl_vars['submenu']->value,$_smarty_tpl->tpl_vars['submenu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']],2));?>
                                        <?php $_smarty_tpl->_assignInScope('dropdownmiddle', (count($_smarty_tpl->tpl_vars['partitions']->value) > 2));?>
                                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "tippusultan") {?>
                                            <?php $_smarty_tpl->_assignInScope('dropdownmiddle', (count($_smarty_tpl->tpl_vars['partitions']->value) > 1));?>
                                        <?php }?>
                                    <?php }?>
                                    <ul role="menu"
                                        class="dropdown-menu <?php if ($_smarty_tpl->tpl_vars['entry']->value['code'] == 'MNFCR3311') {?>multi-column <?php if ($_smarty_tpl->tpl_vars['dropdownmiddle']->value) {?>dropdown-middle<?php }
}?>">
                                        <?php if ($_smarty_tpl->tpl_vars['entry']->value['code'] == 'MNFCR3311') {?>                                             <div class="d-flex">
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['partitions']->value, 'partition');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['partition']->value) {
?>
                                                    <ul class="multi-column-dropdown">
                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['partition']->value, 's1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['s1']->value) {
?>
                                                            <?php if (is_array($_smarty_tpl->tpl_vars['submenu']->value[$_smarty_tpl->tpl_vars['s1']->value['code']]) && count($_smarty_tpl->tpl_vars['submenu']->value[$_smarty_tpl->tpl_vars['s1']->value['code']]) > 0) {?>
                                                                <li class="dropdown-header"><?php echo $_smarty_tpl->tpl_vars['s1']->value['name'];?>
</li>
                                                            <?php } else { ?>
                                                                <li><a role="menuitem" title="<?php echo $_smarty_tpl->tpl_vars['s1']->value['name'];?>
"
                                                                        href="#<?php echo ltrim($_smarty_tpl->tpl_vars['s1']->value['link'],'#');?>
"><?php echo $_smarty_tpl->tpl_vars['s1']->value['name'];?>
</a></li>
                                                            <?php }?>
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                    </ul>
                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                            </div>
                                        <?php } else { ?>
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['submenu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']], 's1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['s1']->value) {
?>
                                                <?php if (is_array($_smarty_tpl->tpl_vars['submenu']->value[$_smarty_tpl->tpl_vars['s1']->value['code']])) {?>
                                                    <li class="dropdown-submenu" data-trigger="hover">
                                                        <a href="#"><?php echo $_smarty_tpl->tpl_vars['s1']->value['name'];?>
</a>
                                                        <ul class="dropdown-menu">
                                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['submenu']->value[$_smarty_tpl->tpl_vars['s1']->value['code']], 's2');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['s2']->value) {
?>
                                                                <li><a title="<?php echo $_smarty_tpl->tpl_vars['s2']->value['name'];?>
" href="#<?php echo ltrim($_smarty_tpl->tpl_vars['s2']->value['link'],'#');?>
"><?php echo $_smarty_tpl->tpl_vars['s2']->value['name'];?>
</a></li>
                                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                        </ul>
                                                    </li>
                                                <?php } else { ?>
                                                    <li><a role="menuitem" title="<?php echo $_smarty_tpl->tpl_vars['s1']->value['name'];?>
" href="#<?php echo ltrim($_smarty_tpl->tpl_vars['s1']->value['link'],'#');?>
"><?php echo $_smarty_tpl->tpl_vars['s1']->value['name'];?>
</a>
                                                    </li>
                                                <?php }?>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        <?php }?>
                                    </ul>
                                <?php }?>
                            </li>
                        <?php }?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </ul>

                <div class="user">
                    <!--<div class='nav-clock'>16-Oct-16 10:57 AM</div>-->
                    <?php if ($_smarty_tpl->tpl_vars['Menuflag']->value == false) {?>
                        <ul class="icon-nav">
                            <li class="dropdown" data-trigger="hover">
                                <a title="Quick Tools" data-toggle="dropdown" class="dropdown-toggle" href="#"> <i
                                        class="fa fa-cogs fa-fw" aria-hidden="true"></i></a>

                                <ul class="dropdown-menu pull-right">
                                    <?php if ($_smarty_tpl->tpl_vars['Menuflag']->value) {?>
                                        <li class="hide">
                                        <?php } else { ?>
                                        <li>
                                        <?php }?>
                                        <a href="javascript:;" onclick="showRecentBookings()"><i class="fa fa-history fa-fw"
                                                aria-hidden="true"></i> Recent Bookings</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ENABLE-SUBSCRIPTION'] == 1 && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                        <div class="subscription-menu">
                            <a href="#admin/subscription">Subscription</a>
                        </div>
                    <?php }?>

                    <ul class="icon-nav" id="ep-navbar-status" style="display: none;">
                        <li>
                            <a href="javascript:;" onclick="showEpPrintDialog()"><i
                                    class="fa fa-print ep-print-status"></i></a>
                        </li>
                    </ul>

                    <div class='ez-products'>
                        <a href="javascript:;" id="ez-apps" title="Ezee apps">
                            <i class="fa fa-th"></i>
                        </a>
                    </div>

                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-CREDIT'] > 0) {?>
                        <div class='usr_bal'>
                            <i class="fa fa-inr"></i>&nbsp;
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-CREDIT'] == 1) {?>
                                <span id="user_balance"><?php echo $_smarty_tpl->tpl_vars['balance']->value;?>
</span>
                            <?php }?>
                        </div>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CHAT-ENBLE'] > 0) {?>
                        <ul class="icon-nav">
                            <li class="dropdown">

                                <a <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CHAT-ENBLE'] == 1) {?> data-toggle="dropdown" class="dropdown-toggle" href="#"
                                    <?php }?>>
                                    <i class="ion-chatboxes"></i>
                                    <!--  <span class="label label-danger">4</span>-->
                                </a>
                                <ul class="dropdown-menu pull-right message-ul">
                                    <div id="scroll_chat"></div>
                                </ul>
                            </li>

                        </ul>
                    <?php }?>

                    <ul class="icon-nav">
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['BRCH-SWITCH'] > 0 && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                            <li class="dropdown" data-trigger="hover">
                                <a title="Switch Branch" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['BRCH-SWITCH'] == 1) {?> data-toggle="dropdown"
                                    class="dropdown-toggle" href="#" <?php }?> onclick="focusSearchBranch();"><i
                                        class="fa fa-map-marker"></i>&nbsp;</a>

                                <ul class="dropdown-menu pull-right" id="id_branches"
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['BRCH-SWITCH'] == '') {?>style="display:none" <?php }?>>
                                    <li onclick="stopProp(event);">
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="brch-input" autocomplete="off"
                                                placeholder="Search" maxlength="35" onkeyup="userBranchFilter(this);"
                                                onkeydown="toggleBranchSelction(event);">
                                            <div class="input-group-addon"><i class="fa fa-search"></i></div>
                                        </div>
                                    </li>
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['BRCH-SWITCH'] == 1) {?>
                                        <div id="b_name">
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['user_assigned_branches']->value, 'brch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brch']->value) {
?>
                                                <li class="brch-item brch_<?php echo $_smarty_tpl->tpl_vars['brch']->value->code;?>
">
                                                    <a class="name_scroll" href="javascript:;"
                                                        onclick="userBranchSwitch('<?php echo $_smarty_tpl->tpl_vars['brch']->value->code;?>
')" id="brch_<?php echo $_smarty_tpl->tpl_vars['brch']->value->code;?>
">
                                                        <?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['brch']->value->name,30,"...",true);?>

                                                    </a>
                                                </li>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        </div>
                                        <li id="lst_brch">
                                            <a class="more-messages" onclick="userBranchSwitch()" href="javascript:;">Switch to own
                                                Branch
                                                <i class="fa fa-arrow-right"></i>
                                            </a>
                                        </li>
                                    <?php }?>
                                </ul>
                            </li>
                        <?php }?>

                        <!--<li>  
                                <span class="label label-danger notification-badge" style="top: 4px; z-index: 999; position: absolute; margin-left: 23px;">14</span>
                                <a title="Notifications" id="ez-noti" href="javascript:;"><i class="fa fa-bell"></i></a>
                            </li>  -->

                    </ul>

                    <ul class="icon-nav">
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-SHOW'] > 0 && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                            <li class="dropdown" data-trigger="hover">
                                <a title="Switch Namespace" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-SHOW'] == 1) {?> data-toggle="dropdown"
                                    class="dropdown-toggle" href="#" <?php }?> onclick="focusSearch();"><i
                                        class="fa fa-bus"></i>&nbsp;</a>

                                <ul class="dropdown-menu pull-right" id="id_name_space"
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-NSCE-LIST'] == '' && $_smarty_tpl->tpl_vars['action_rights']->value['NSCE-ADD'] == '') {?>style="display:none"
                                    <?php }?>>
                                    <li onclick="stopProp(event);">
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="nasp-input" autocomplete="off"
                                                placeholder="Search" maxlength="35" onkeyup="namespaceFilter(this);"
                                                onkeydown="toggleNsSelction(event);">
                                            <div class="input-group-addon"><i class="fa fa-search"></i></div>
                                        </div>
                                    </li>
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SHOW-NSCE-LIST'] == 1) {?>
                                        <div id="s_name">
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['namespace_list']->value, 'np', false, NULL, 'nasp', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['np']->value) {
?>
                                                <?php if ($_smarty_tpl->tpl_vars['np']->value['code'] != '') {?>
                                                    <li class="nasp-item name_<?php echo $_smarty_tpl->tpl_vars['np']->value['code'];?>
">
                                                        <a class="name_scroll" href="javascript:;"
                                                            onclick="nameSpaceswitch('<?php echo $_smarty_tpl->tpl_vars['np']->value["code"];?>
')" id="nps_<?php echo $_smarty_tpl->tpl_vars['np']->value['code'];?>
">
                                                            <?php echo smarty_modifier_truncate($_smarty_tpl->tpl_vars['np']->value['name'],30,"...",true);?>

                                                        </a>
                                                    </li>
                                                <?php }?>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        </div>
                                    <?php }?>
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-ADD'] > 0) {?>
                                        <li id="lst_nsp">
                                            <a class="more-messages" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-ADD'] == 1) {?>onclick="editNamespace()"
                                                <?php }?> href="javascript:;">Add New Namespace
                                                <i class="fa fa-arrow-right"></i>
                                            </a>
                                        </li>
                                    <?php }?>
                                </ul>
                            </li>
                        <?php }?>

                        <!--<li>  
                                <span class="label label-danger notification-badge" style="top: 4px; z-index: 999; position: absolute; margin-left: 23px;">14</span>
                                <a title="Notifications" id="ez-noti" href="javascript:;"><i class="fa fa-bell"></i></a>
                            </li>  -->

                    </ul>

                    <ul class="icon-nav">
                        <li class="dropdown" data-trigger="hover">
                            <a title="Profile" data-toggle="dropdown" class="dropdown-toggle" href="#"
                                id="profile-user-info">
                                <i class="fa fa-user"></i>
                                <span class="pd_lt_10">
                                    <span><?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
</span>
                                    <br /><small class="branchname"><?php echo $_smarty_tpl->tpl_vars['login_branch_name']->value;?>
</small>
                                </span>
                            </a>

                            <ul class="dropdown-menu pull-right">
                                <?php if (($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-EDIT'] > 0 || $_smarty_tpl->tpl_vars['action_rights']->value['NSCE-SHOW'] > 0) && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                                    <li>
                                        <a href="#profile/edit"><i class="fa fa-bus"></i></i>&nbsp;&nbsp;Namespace</a>
                                    </li>
                                    <li>
                                        <a href="#cargo/cargo-settings"><i class="fa fa-gear"></i></i>&nbsp;&nbsp;Cargo
                                            Settings</a>
                                    </li>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['PRF-INTEGRAT'] > 0 && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                                    <li>
                                        <a href="#admin/integrations"><i
                                                class="fa fa-code-fork"></i></i>&nbsp;&nbsp;Integration</a>
                                    </li>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ALRT-SUBS'] > 0 && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                                    <li>
                                        <a href="#profile/alert-subscription"><i class="fa fa-bell"></i>&nbsp;&nbsp;Alert
                                            Subscription</a>
                                    </li>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-EDIT'] > 0 && $_smarty_tpl->tpl_vars['is_super_namespace']->value == 1 && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                                    <li>
                                        <a href="#admin/billing-configuration"><i class="fa fa-inr"></i>&nbsp;&nbsp;Billing
                                            Configuration</a>
                                    </li>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['PRINTR-CONFIG'] > 0 && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                                    <li>
                                        <a href="javascript:;" onclick="showEpPrintDialog()"><i
                                                class="fa fa-print"></i>&nbsp;&nbsp;Printers</a>
                                    </li>
                                <?php }?>
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['PRF-SHOW'] > 0 && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                                    <li>
                                        <a href="#profile/edit-profile"><i class="fa  fa-user"></i>&nbsp;&nbsp;Profile</a>
                                    </li>
                                <?php }?>
                                <li>
                                    <a href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
user/logout"><i class="fa fa-power-off"></i>&nbsp;&nbsp;Log out</a>
                                </li>
                            </ul>
                        </li>

                        <?php if ($_smarty_tpl->tpl_vars['referrer']->value != '' && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                            <li>
                                <a href="<?php echo $_smarty_tpl->tpl_vars['referrer']->value;?>
" target="_blank" title="Booking portal">
                                    &nbsp; <i class="fa fa-home"></i>&nbsp;&nbsp;
                                </a>
                            </li>
                        <?php }?>
                    </ul>

                    <?php if ($_smarty_tpl->tpl_vars['native_usr_login_id']->value != $_smarty_tpl->tpl_vars['usr_login_id']->value && ($_smarty_tpl->tpl_vars['Menuflag']->value == false)) {?>
                        <ul class="icon-nav hide">
                            <li>
                                <a title="Switch Back to <?php echo $_smarty_tpl->tpl_vars['native_usr_login_name']->value;?>
" data-toggle="dropdown"
                                    class="dropdown-toggle" href="#" onclick="switchBackToUser();"> <i
                                        class="fa fa-toggle-on"></i> </a>
                            </li>
                        </ul>
                    <?php }?>

                </div>
            </div>
        </div>
        <!-- PAGE -->
        <div id="main_page_content" class="clear_fix_both">
            <?php $_smarty_tpl->_subTemplateRender($_smarty_tpl->tpl_vars['page_body']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('title'=>'page_content'), 0, true);
?>
        </div>
        <!--/PAGE -->

        <div id="edt-tck-dialog" class="hide dialog-content-page"></div>

        <div id="slidebar" class="hidden">
            <div id="slidebar_content">

                <div class="row">
                    <div class="col-md-4 col-xs-12 text-center">
                        <a class="user_img_item" href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
product/change?product=bits" target="_blank">
                            <img src="assets/img/bits.png?1" alt="" class="img-thumbnail">
                            <br>
                            BITS
                        </a>
                    </div>
                    <div class="col-md-4 col-xs-12 text-center">
                        <a class="user_img_item" href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
product/change?product=cargo" target="_blank">
                            <img src="assets/img/cargo.png?1" alt="" class="img-thumbnail">
                            <br>
                            Cargo
                        </a>
                    </div>
                    <div class="col-md-4 col-xs-12 text-center">
                        <a class="user_img_item" href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
product/change?product=gps" target="_blank">
                            <img src="assets/img/gps-logo.png?1" alt="" class="img-thumbnail">
                            <br>
                            Track Bus
                        </a>
                    </div>
                </div>
                <br />
                <div class="row">
                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CAN-SHOW-WALLET'] > 0) {?>
                        <div class="col-md-4 col-xs-12 text-center">
                            <a class="user_img_item" href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
product/wallet" target="_blank">
                                <img src="assets/img/analytics-logo.png" alt="" class="img-thumbnail">
                                <br>
                                Wallet
                            </a>
                        </div>
                    <?php }?>

                    <?php if ($_smarty_tpl->tpl_vars['is_super_namespace']->value == 1) {?>
                        <div class="col-md-4 col-xs-12 text-center">
                            <a class="user_img_item" href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
product/change?product=analytics" target="_blank">
                                <img src="assets/img/analytics-logo.png" alt="" class="img-thumbnail">
                                <br>
                                Analytics
                            </a>
                        </div>
                        <div class="col-md-4 col-xs-12 text-center">
                            <a class="user_img_item" href="http://admin.portal.ezeebits.com" target="_blank">
                                <img src="assets/img/portal-service-logo.png" alt="" class="img-thumbnail">
                                <br>
                                Portal Service
                            </a>
                        </div>
                    <?php }?>
                </div>

                <hr>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="text-center helpdesk-heading">Helpdesk</div>
                        <div class="text-center helpdesk-items">
                            <div><i class="glyphicon glyphicon-phone"></i>&nbsp; 9500007529</div>
                            <div><i class="glyphicon glyphicon-phone-alt"></i>&nbsp; 044-42866353</div>
                            <div><i class="fa fa-envelope"></i>&nbsp; support@ezeeinfo.in</div>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <br><br>
                        <a href="https://anydesk.com/en/downloads" title="Download AnyDesk" target="_blank"
                            rel="noopener noreferrer">
                            <img src="assets/img/anydesk-logo.svg" alt="anydesk-logo">
                        </a>
                    </div>
                </div>

            </div>
        </div>

        <!-- right notification panel -->
        <div id="notification-panel" class="hidden noprint">
            <div id="notification_content">
                <div class="input-group">
                    <input type="text" class="form-control input-sm" placeholder="Search...">
                    <span class="input-group-btn">
                        <button class="btn btn-default btn-sm" type="button"><i class="fa fa-search"></i></button>
                    </span>
                </div>
                <hr>

                <div class="sepH_a">
                    <div class="progress">
                        <div style="width: 60%;" role="progressbar" class="progress-bar">
                            60%
                        </div>
                    </div>
                    <span class="help-block">CPU Usage</span>
                </div>
                <div class="sepH_a">
                    <div class="progress">
                        <div style="width: 28%;" class="progress-bar progress-bar-success">
                            28%
                        </div>
                    </div>
                    <span class="help-block">Disk Usage</span>
                </div>
                <div class="progress">
                    <div style="width: 82%;" class="progress-bar progress-bar-danger">
                        0.2GB/20GB
                    </div>
                </div>
                <span class="help-block">Monthly Transfer</span>
                <hr>
            </div>
        </div>

        <footer>
            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "demo") {?>
                <div class="row">
                    <div class="text-center">
                        <a href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
#content/contactus">contact</i></a>&nbsp;&nbsp;| &nbsp;&nbsp;
                        <a href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
#content/about">about us</i></a>&nbsp;&nbsp;| &nbsp;&nbsp;
                        <a href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
#content/terms">Terms & Conditions</i></a>&nbsp;&nbsp;| &nbsp;&nbsp;
                        <a href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
#content/faq">Faq</a> &nbsp;&nbsp;| &nbsp;&nbsp;
                        <a href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
#content/privacypolicy">Privacy Policy</a>
                    </div><br>
                </div>
            <?php }?>

            <div class="row">
                <div class="text-center">
                    &COPY; <?php echo date('Y');?>
 All rights reserved. &nbsp;
                    Powered by <a href="http://www.ezeeinfosolutions.com" target="_blank">EzeeInfo Cloud Solutions Pvt
                        Ltd</a>
                </div> <br>
            </div>
        </footer>

        <?php $_smarty_tpl->_subTemplateRender('file:site/template/namespace-dialog.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>
        <?php echo '<script'; ?>
 type="text/template" id="nsp-li">
        <a href="javascript:;" onclick="nameSpaceswitch('')" id="nps_"></a>
            <?php echo '</script'; ?>
>

        <?php $_smarty_tpl->_subTemplateRender('file:site/template/print-ticket-dialog.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>
        <?php $_smarty_tpl->_subTemplateRender('file:site/template/ep-print-dialog.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>
        <?php $_smarty_tpl->_subTemplateRender('file:site/template/document-upload-dialog.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>
        <?php $_smarty_tpl->_subTemplateRender('file:site/template/cargo-dialogs.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

        <div id="cargo-invoice-pdf-dialog" class="hide">
            <a href="javascript:;" class="pull-right" onclick="closeInvoicePdfDialog();"><i
                    class="fa fa-times-circle fa-2x"></i></a>
            <div id="cargo-invoice-iframe-alert"></div>
            <div id="cargo-invoice-iframe" style="height:90%;width:100%;"></div>
        </div>

        <div id='track_fleet_container' style="background-color: #fff;" class="hide noprint dialog-content-page">
            <div class="">
                <div class="pull-right">
                    <a title="close" href="javascript:;" class="btn-lg" onclick="closeLiveTrackPopup()"> <i
                            class="fa fa-times-circle fa-lg"></i> </a>
                </div>
                <div class="pull-left bold" id="trip-setting-head">
                    Live Tracking
                </div>
            </div>
            <div class="clearfix">&nbsp;</div> <br>
            <div id="track_map_canvas"></div>
        </div>


        <?php echo '<script'; ?>
 type="text/javascript">
            $(document).ready(function($) {
                var name_id = "<?php echo $_smarty_tpl->tpl_vars['namespace']->value;?>
";
                $('.name_' + name_id).addClass('active');
                var login_branch = "<?php echo $_smarty_tpl->tpl_vars['login_branch']->value;?>
";
                $('.brch_' + login_branch).addClass('active');
                checkURL(); //  auto load dashboard>
            });
        <?php echo '</script'; ?>
>
                <?php echo '<script'; ?>
 src="assets/config.js" type="text/javascript"><?php echo '</script'; ?>
>
        
        <?php echo '<script'; ?>
 src="assets/js/bootstrap-select.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" type="text/javascript"><?php echo '</script'; ?>
>

        <?php echo '<script'; ?>
 src="assets/js/bootstrap-select.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" type="text/javascript"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/plupload.full.min.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/jquery.fancybox.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/jquery.fancybox-thumbs.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>

        <?php echo '<script'; ?>
 type="text/javascript" src="assets/lib/hotkeys/hotkeys.min.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>

        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/ep-app.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/jsrsasign-all-min.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/sign-message.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/ezeeprint.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/printDiv.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
 type="text/javascript" src="assets/js/toastr.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
        
        <!-- /debug function for commom usecase -->
        <?php echo '<script'; ?>
 src="assets/js/common.js" type="text/javascript"><?php echo '</script'; ?>
>
        <?php echo '<script'; ?>
>
            toastr.options.timeOut = 3000;

            function success(message) {
                toastr.success('Success', message);
            }

            function error(message) { //#advaceError
                toastr.error('Error', message);
            }

            function warning(message) {
                toastr.warning('Warning', message);
            }

            function info(message) {
                toastr.info('Info', message);
            }
            function notice(msg){
                var options = {
                    closeButton: false,
                    debug: false,
                    newestOnTop: true,
                    progressBar: false,
                    positionClass: 'toast-top-center',
                    preventDuplicates: true,
                    onclick: null,
                    showDuration: '300',
                    hideDuration: '300',
                    timeOut: '2000',
                    extendedTimeOut: '1000',
                    showEasing: 'swing',
                    hideEasing: 'linear',
                    showMethod: 'fadeIn',
                    hideMethod: 'fadeOut'
                };
                toastr.options = options;
                toastr.info(msg);
            }
        <?php echo '</script'; ?>
>

         
            <?php echo '<script'; ?>
>               
                const settingsData = <?php echo _namespace_nav_logo_change_();?>
;
                let nameSpace = settingsData.nameSpace;
                let primaryColor = settingsData.primaryColor == 'NA' ? '#FA9008' : settingsData.primaryColor;
                let secondaryColor = settingsData.secondaryColor == 'NA' ? '#FA9008' : settingsData.secondaryColor;
                let fontSize = settingsData.fontSize + "px";
                let logo_url=`https://${settingsData.domainURL}/assets/images/mini-logo.png`;

                $('#primaryColorPicker, #primaryColorText').val(primaryColor);
                $('#secondaryColorPicker, #secondaryColorText').val(secondaryColor);
                $('#font-size').val(settingsData.fontSize);
                $("#navigation  .container-fluid").css({"background-color": primaryColor});
                var logo = $('<img />', {
                    id: 'namespaceLogo',
                    src: logo_url,
                    alt: nameSpace,
                    width: '160px',//'160px',
                    height: '30px',
                })
                logo.on('load', function() {
                    $('#navigation #brand').html(logo.css({'background': '#fff',
                        'height':'50px',
                        'width' :'100%',
                        'object-fit':'cover;'
                    })).css({'padding': '1px 1px 1px 2px','border-radius':'6px'});
                  
                }).on('error', function() {
                    $('#navigation #brand').html(nameSpace)
                });

                var color = primaryColor;
                var opacity = 1;
                var rgbaColor = hexToRGBA(color, opacity);

                $('#navigation .main-nav > li > a, #navigation .user .dropdown > a , #navigation .user .icon-nav > li > a').hover(function() {$(this).css('background-color', rgbaColor)}, function() {$(this).css('background-color', primaryColor)});
                $('.multi-column-dropdown li a , #navigation .dropdown-menu > li > a , .name_scroll').hover(function() {$(this).css('background-color', primaryColor).css("opacity","0.79")}, function() {$(this).css({'background-color': '#fff','color':'#000'})});
            <?php echo '</script'; ?>
>
        

    </body>

    </html>
<?php } else { ?>
    <?php $_smarty_tpl->_subTemplateRender($_smarty_tpl->tpl_vars['page_body']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('title'=>'page_content'), 0, true);
?>
    <?php }
}
}
