{if $is_logged_in == 1}
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <base href="{$base_url} ">
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <title>{$namespace_name}</title>
        <!--<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no">-->
        <meta name="description" content="">
        <meta name="author" content="">
        <script>
            var base_url = "{$base_url}";
            var load_data = {};
            var base = "{$base}";
            var ns_name = "{$namespace_name}";
            var ns_branchname = "{$login_branch_name}";
            var ns_username = "{$usr_login_name}";
            var dilg = new Array();
        </script>

        <link rel="shortcut icon" href="assets/img/login/favicon.png" />
        <!-- bootstrap framework -->
        <link href="assets/bootstrap/css/bootstrap.min.css?{$asset_ver}" rel="stylesheet" media="screen">
        <link href="assets/css/non-responsive.css?{$asset_ver}" rel="stylesheet" media="screen">

        <!-- font fakt -->
        <!--<link href="assets/css/fonts-fakt.css" rel="stylesheet" media="screen">-->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">

        <!-- custom icons -->
        <!-- font awesome icons -->
        <link href="assets/icons/font-awesome/css/font-awesome.min.css?{$asset_ver}" rel="stylesheet" media="screen">
        <!-- ionicons -->
        <link href="assets/icons/ionicons/css/ionicons.min.css?{$asset_ver}" rel="stylesheet" media="screen">

        <!-- nvd3 charts -->
        <link rel="stylesheet" href="assets/lib/novus-nvd3/nv.d3.min.css?{$asset_ver}" media="screen">

        <!-- datepicker -->
        <link rel="stylesheet" href="assets/lib/bootstrap-daterangepicker/daterangepicker-bs3.css?{$asset_ver}"
            media="screen">
        <link rel="stylesheet" href="assets/lib/bootstrap-datepicker/css/datepicker3.css?{$asset_ver}" media="screen">
        <link rel="stylesheet" href="assets/lib/bootstrap-timepicker/css/bootstrap-timepicker.min.css?{$asset_ver}"
            media="screen">


        <!-- multiselect, tagging -->
        <link rel="stylesheet" href="assets/lib/select2/select2.css?{$asset_ver}" media="screen">
        <link rel="stylesheet" href="assets/css/bootstrap-select.css?{$asset_ver}" media="screen">
        <link rel="stylesheet" href="assets/lib/bootstrap-switch/build/css/bootstrap3/bootstrap-switch.css?{$asset_ver}"
            media="screen">
        <link rel="stylesheet" href="assets/lib/bootstrap-multiselect/css/bootstrap-multiselect.css?{$asset_ver}"
            media="screen">

        <link rel="stylesheet" type="text/css" href="assets/lib/tabdrop/tabdrop.css?{$asset_ver}" media="screen" />

        <!-- ion.rangeSlider -->
        <link rel="stylesheet" href="assets/lib/ion.rangeSlider/css/ion.rangeSlider.css?{$asset_ver}" media="screen">
        <link rel="stylesheet" href="assets/css/screen.css?{$asset_ver}" media="screen">

        <link rel="stylesheet" href="assets/lib/fullcalendar/fullcalendar/fullcalendar.css?{$asset_ver}">

        <link rel="stylesheet" href="assets/lib/DataTables/media/css/jquery.dataTables.min.css?{$asset_ver}">
        
        <link rel="stylesheet"
            href="assets/lib/DataTables/extensions/TableTools/css/dataTables.tableTools.min.css?{$asset_ver}">
        <link rel="stylesheet"
            href="assets/lib/DataTables/extensions/Scroller/css/dataTables.scroller.min.css?{$asset_ver}">
        <link rel="stylesheet"
            href="assets/lib/DataTables/extensions/FixedColumns/css/dataTables.fixedColumns.min.css?{$asset_ver}">
        <link rel="stylesheet"
            href="assets/lib/DataTables/extensions/FixedHeader/css/dataTables.fixedHeader.min.css?{$asset_ver}">

        <!-- main stylesheet -->
        <link href="assets/css/jquery-ui.css?{$asset_ver}" rel="stylesheet" media="screen">
        <!--<link href="assets/css/ui.jqgrid.css?{$asset_ver}" rel="stylesheet" media="screen">-->
        <link href="assets/css/jquery.multiselect.css?{$asset_ver}" rel="stylesheet" media="screen">
        <link href="assets/css/sweet-alert.css?{$asset_ver}" rel="stylesheet" media="screen">
        <link href="assets/css/nprogress.css?{$asset_ver}" rel="stylesheet" media="screen">
        <link href="assets/css/style.css?{$asset_ver}" rel="stylesheet" media="screen">

        <link href="assets/css/print.css?{$asset_ver}" rel="stylesheet" media="print">
        <link rel="stylesheet" href="assets/css/chat.css?{$asset_ver}" media="screen">
        <link rel="stylesheet" type="text/css" href="assets/css/jquery.fancybox.css?{$asset_ver}" media="screen" />
        <link rel="stylesheet" type="text/css" href="assets/css/jquery.fancybox-thumbs.css?{$asset_ver}" media="screen" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

        {if $namespace=="sreekannathal"}
            <link rel="stylesheet" type="text/css" href="assets/css/theme-kannathal.css?{$asset_ver}" media="screen" />
        {/if}

        {if $namespace=="rajeshexpress" || $namespace =="rajeshcargo"}
            <link rel="stylesheet" type="text/css" href="assets/css/theme-rajeshcargo.css?{$asset_ver}" media="screen" />
        {/if}

        {if $namespace=="varahi"}
            <link rel="stylesheet" type="text/css" href="assets/css/theme-varahi.css?{$asset_ver}" media="screen" />
        {/if}

        {if $current_product_name|lower !="bits" }
            {if $namespace=="tippusultan"}
                <link rel="stylesheet" type="text/css" href="assets/css/theme-tippusultancargo.css?{$asset_ver}" media="screen" />
            {elseif $namespace=="tippusultantrans"}
                <link rel="stylesheet" type="text/css" href="assets/css/theme-tippusultantrans.css?{$asset_ver}" media="screen" />
            {else}
                <link rel="stylesheet" type="text/css" href="assets/css/product-{$current_product_name|lower}.css?{$asset_ver}"
                    media="screen" />
            {/if}
        {/if}

        {if $environment=='PROD'}
            {literal}
                <script>
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
                </script>
            {/literal}
        {else}
            {literal}
                <script>
                    function ga() {}
                </script>
            {/literal}
        {/if}

        <script src="{$base_url}user/actions"></script>
        {$js_script}

        <script src="assets/lib/highcharts/highcharts.js"></script>
        <script src="assets/lib/highcharts/exporting.js"></script>
    </head>

    <body>
        <!-- HEADER -->

        <div id="navigation" class="navbar-fixed-top" data-spy="affix" data-offset-top="52">
            <div class="container-fluid">
                {if $namespace == 'rajeshcargo' || $namespace=="rajeshexpress"}
                    <a id="brand" href="">
                        <img src="assets/img/rajeshexpress-header.png" alt="logo">
                        <span class="hide">{$namespace_name}</span>
                    </a>
                {else if $namespace == 'varahi'}
                    <a id="brand" href="">
                        <img src="assets/img/varahi.png" alt="logo">
                        <span class="hide">{$namespace_name}</span>
                    </a>
                {* {else if $namespace == 'tippusultan'}
                                                                                        <a id="brand" href="">
                                                                                            <img src="assets/img/tippusultan.png" alt="logo">
                                                                                            <span class="hide">{$namespace_name}</span>
                                                                                        </a>




                {else if $namespace == 'tippusultantrans'}
                                                                                        <a id="brand" href="">
                                                                                            <img src="assets/img/tippusultantrans.png" alt="logo">
                                                                                            <span class="hide">{$namespace_name}</span>
                                                                                        </a> *}
                {else}
                    {* <span class="label-product">{$current_product_name}</span> *}
                    <a id="brand" href=""> {$namespace_name}</a>
                {/if}

                {foreach $parent as $entry}
                    {if $entry['code'] == "USER-BAL-EXCD-CRDT-LIMT"}
                        {assign var="Menuflag" value=true}
                    {/if}
                {/foreach}

                <ul class="main-nav">
                    {foreach $parent as $entry}
                        {if $entry['link']!='hidden'}
                            {if $Menuflag}
                                <li data-trigger="hover" style="pointer-events: none;">
                                {else}
                                <li data-trigger="hover">
                                {/if}

                                <a class="dropdown-toggle" data-toggle="dropdown"
                                    href="{if $entry['link']!='#' || $entry['link']!=''}{$entry['link']}{/if}">
                                    {if $entry['code'] == "USER-BAL-EXCD-CRDT-LIMT"}
                                    {else}
                                        {$entry['name']}
                                    {/if}
                                    {if is_array($submenu[$entry['code']])}
                                        <span class="caret"></span>
                                    {/if}
                                </a>

                                {if is_array($submenu[$entry['code']])}
                                    {if $entry['code']=='MNFCR3311'} {* Report Dropdown *}
                                        {assign var=partitions value=partition_submenus($submenu, $submenu[$entry['code']], 2)}
                                        {assign var=dropdownmiddle value=(count($partitions) > 2)}
                                        {if $namespace == "tippusultan"}
                                            {assign var=dropdownmiddle value=(count($partitions) > 1)}
                                        {/if}
                                    {/if}
                                    <ul role="menu"
                                        class="dropdown-menu {if $entry['code']=='MNFCR3311'}multi-column {if $dropdownmiddle}dropdown-middle{/if}{/if}">
                                        {if $entry['code']=='MNFCR3311'} {* Report Dropdown *}
                                            <div class="d-flex">
                                                {foreach $partitions as $partition}
                                                    <ul class="multi-column-dropdown">
                                                        {foreach $partition as $s1}
                                                            {if is_array($submenu[$s1['code']]) && count($submenu[$s1['code']])>0}
                                                                <li class="dropdown-header">{$s1['name']}</li>
                                                            {else}
                                                                <li><a role="menuitem" title="{$s1['name']}"
                                                                        href="#{$s1['link']|ltrim:'#'}">{$s1['name']}</a></li>
                                                            {/if}
                                                        {/foreach}
                                                    </ul>
                                                {/foreach}
                                            </div>
                                        {else}
                                            {foreach $submenu[$entry['code']] as $s1}
                                                {if is_array($submenu[$s1['code']])}
                                                    <li class="dropdown-submenu" data-trigger="hover">
                                                        <a href="#">{$s1['name']}</a>
                                                        <ul class="dropdown-menu">
                                                            {foreach $submenu[$s1['code']] as $s2}
                                                                <li><a title="{$s2['name']}" href="#{$s2['link']|ltrim:'#'}">{$s2['name']}</a></li>
                                                            {/foreach}
                                                        </ul>
                                                    </li>
                                                {else}
                                                    <li><a role="menuitem" title="{$s1['name']}" href="#{$s1['link']|ltrim:'#'}">{$s1['name']}</a>
                                                    </li>
                                                {/if}
                                            {/foreach}
                                        {/if}
                                    </ul>
                                {/if}
                            </li>
                        {/if}
                    {/foreach}
                </ul>

                <div class="user">
                    <!--<div class='nav-clock'>16-Oct-16 10:57 AM</div>-->
                    {if $Menuflag == false}
                        <ul class="icon-nav">
                            <li class="dropdown" data-trigger="hover">
                                <a title="Quick Tools" data-toggle="dropdown" class="dropdown-toggle" href="#"> <i
                                        class="fa fa-cogs fa-fw" aria-hidden="true"></i></a>

                                <ul class="dropdown-menu pull-right">
                                    {if $Menuflag}
                                        <li class="hide">
                                        {else}
                                        <li>
                                        {/if}
                                        <a href="javascript:;" onclick="showRecentBookings()"><i class="fa fa-history fa-fw"
                                                aria-hidden="true"></i> Recent Bookings</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    {/if}

                    {if $action_rights['ENABLE-SUBSCRIPTION']==1 && ($Menuflag == false)}
                        <div class="subscription-menu">
                            <a href="#admin/subscription">Subscription</a>
                        </div>
                    {/if}

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

                    {if $action_rights['SHOW-CREDIT']>0}
                        <div class='usr_bal'>
                            <i class="fa fa-inr"></i>&nbsp;
                            {if $action_rights['SHOW-CREDIT']==1}
                                <span id="user_balance">{$balance}</span>
                            {/if}
                        </div>
                    {/if}

                    {if $action_rights['CHAT-ENBLE']>0}
                        <ul class="icon-nav">
                            <li class="dropdown">

                                <a {if $action_rights['CHAT-ENBLE']==1} data-toggle="dropdown" class="dropdown-toggle" href="#"
                                    {/if}>
                                    <i class="ion-chatboxes"></i>
                                    <!--  <span class="label label-danger">4</span>-->
                                </a>
                                <ul class="dropdown-menu pull-right message-ul">
                                    <div id="scroll_chat"></div>
                                </ul>
                            </li>

                        </ul>
                    {/if}

                    <ul class="icon-nav">
                        {if $action_rights['BRCH-SWITCH']>0 && ($Menuflag == false)}
                            <li class="dropdown" data-trigger="hover">
                                <a title="Switch Branch" {if $action_rights['BRCH-SWITCH']==1} data-toggle="dropdown"
                                    class="dropdown-toggle" href="#" {/if} onclick="focusSearchBranch();"><i
                                        class="fa fa-map-marker"></i>&nbsp;</a>

                                <ul class="dropdown-menu pull-right" id="id_branches"
                                    {if $action_rights['BRCH-SWITCH']==''}style="display:none" {/if}>
                                    <li onclick="stopProp(event);">
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="brch-input" autocomplete="off"
                                                placeholder="Search" maxlength="35" onkeyup="userBranchFilter(this);"
                                                onkeydown="toggleBranchSelction(event);">
                                            <div class="input-group-addon"><i class="fa fa-search"></i></div>
                                        </div>
                                    </li>
                                    {if $action_rights['BRCH-SWITCH']==1}
                                        <div id="b_name">
                                            {foreach item="brch" from=$user_assigned_branches}
                                                <li class="brch-item brch_{$brch->code}">
                                                    <a class="name_scroll" href="javascript:;"
                                                        onclick="userBranchSwitch('{$brch->code}')" id="brch_{$brch->code}">
                                                        {$brch->name|truncate:30:"...":true}
                                                    </a>
                                                </li>
                                            {/foreach}
                                        </div>
                                        <li id="lst_brch">
                                            <a class="more-messages" onclick="userBranchSwitch()" href="javascript:;">Switch to own
                                                Branch
                                                <i class="fa fa-arrow-right"></i>
                                            </a>
                                        </li>
                                    {/if}
                                </ul>
                            </li>
                        {/if}

                        <!--<li>  
                                <span class="label label-danger notification-badge" style="top: 4px; z-index: 999; position: absolute; margin-left: 23px;">14</span>
                                <a title="Notifications" id="ez-noti" href="javascript:;"><i class="fa fa-bell"></i></a>
                            </li>  -->

                    </ul>

                    <ul class="icon-nav">
                        {if $action_rights['NSCE-SHOW']>0 && ($Menuflag == false)}
                            <li class="dropdown" data-trigger="hover">
                                <a title="Switch Namespace" {if $action_rights['NSCE-SHOW']==1} data-toggle="dropdown"
                                    class="dropdown-toggle" href="#" {/if} onclick="focusSearch();"><i
                                        class="fa fa-bus"></i>&nbsp;</a>

                                <ul class="dropdown-menu pull-right" id="id_name_space"
                                    {if $action_rights['SHOW-NSCE-LIST']=='' && $action_rights['NSCE-ADD']==''}style="display:none"
                                    {/if}>
                                    <li onclick="stopProp(event);">
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="nasp-input" autocomplete="off"
                                                placeholder="Search" maxlength="35" onkeyup="namespaceFilter(this);"
                                                onkeydown="toggleNsSelction(event);">
                                            <div class="input-group-addon"><i class="fa fa-search"></i></div>
                                        </div>
                                    </li>
                                    {if $action_rights['SHOW-NSCE-LIST']==1}
                                        <div id="s_name">
                                            {foreach name="nasp" item="np" from=$namespace_list}
                                                {if $np['code'] != ""}
                                                    <li class="nasp-item name_{$np['code']}">
                                                        <a class="name_scroll" href="javascript:;"
                                                            onclick="nameSpaceswitch('{$np["code"]}')" id="nps_{$np['code']}">
                                                            {$np['name']|truncate:30:"...":true}
                                                        </a>
                                                    </li>
                                                {/if}
                                            {/foreach}
                                        </div>
                                    {/if}
                                    {if $action_rights['NSCE-ADD']>0}
                                        <li id="lst_nsp">
                                            <a class="more-messages" {if $action_rights['NSCE-ADD']==1}onclick="editNamespace()"
                                                {/if} href="javascript:;">Add New Namespace
                                                <i class="fa fa-arrow-right"></i>
                                            </a>
                                        </li>
                                    {/if}
                                </ul>
                            </li>
                        {/if}

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
                                    <span>{$usr_login_name}</span>
                                    <br /><small class="branchname">{$login_branch_name}</small>
                                </span>
                            </a>

                            <ul class="dropdown-menu pull-right">
                                {if ($action_rights['NSCE-EDIT']>0 || $action_rights['NSCE-SHOW']>0) && ($Menuflag == false)}
                                    <li>
                                        <a href="#profile/edit"><i class="fa fa-bus"></i></i>&nbsp;&nbsp;Namespace</a>
                                    </li>
                                    <li>
                                        <a href="#cargo/cargo-settings"><i class="fa fa-gear"></i></i>&nbsp;&nbsp;Cargo
                                            Settings</a>
                                    </li>
                                {/if}
                                {if $action_rights['PRF-INTEGRAT']>0 && ($Menuflag == false)}
                                    <li>
                                        <a href="#admin/integrations"><i
                                                class="fa fa-code-fork"></i></i>&nbsp;&nbsp;Integration</a>
                                    </li>
                                {/if}
                                {if $action_rights['ALRT-SUBS']>0 && ($Menuflag == false)}
                                    <li>
                                        <a href="#profile/alert-subscription"><i class="fa fa-bell"></i>&nbsp;&nbsp;Alert
                                            Subscription</a>
                                    </li>
                                {/if}
                                {if $action_rights['NSCE-EDIT']>0 && $is_super_namespace==1 && ($Menuflag == false)}
                                    <li>
                                        <a href="#admin/billing-configuration"><i class="fa fa-inr"></i>&nbsp;&nbsp;Billing
                                            Configuration</a>
                                    </li>
                                {/if}
                                {if $action_rights['PRINTR-CONFIG']>0 && ($Menuflag == false)}
                                    <li>
                                        <a href="javascript:;" onclick="showEpPrintDialog()"><i
                                                class="fa fa-print"></i>&nbsp;&nbsp;Printers</a>
                                    </li>
                                {/if}
                                {if $action_rights['PRF-SHOW']>0 && ($Menuflag == false)}
                                    <li>
                                        <a href="#profile/edit-profile"><i class="fa  fa-user"></i>&nbsp;&nbsp;Profile</a>
                                    </li>
                                {/if}
                                <li>
                                    <a href="{$base_url}user/logout"><i class="fa fa-power-off"></i>&nbsp;&nbsp;Log out</a>
                                </li>
                            </ul>
                        </li>

                        {if $referrer != '' && ($Menuflag == false)}
                            <li>
                                <a href="{$referrer}" target="_blank" title="Booking portal">
                                    &nbsp; <i class="fa fa-home"></i>&nbsp;&nbsp;
                                </a>
                            </li>
                        {/if}
                    </ul>

                    {if $native_usr_login_id != $usr_login_id && ($Menuflag == false)}
                        <ul class="icon-nav hide">
                            <li>
                                <a title="Switch Back to {$native_usr_login_name}" data-toggle="dropdown"
                                    class="dropdown-toggle" href="#" onclick="switchBackToUser();"> <i
                                        class="fa fa-toggle-on"></i> </a>
                            </li>
                        </ul>
                    {/if}

                </div>
            </div>
        </div>
        <!-- PAGE -->
        <div id="main_page_content" class="clear_fix_both">
            {include file=$page_body title=page_content}
        </div>
        <!--/PAGE -->

        <div id="edt-tck-dialog" class="hide dialog-content-page"></div>

        <div id="slidebar" class="hidden">
            <div id="slidebar_content">

                <div class="row">
                    <div class="col-md-4 col-xs-12 text-center">
                        <a class="user_img_item" href="{$base_url}product/change?product=bits" target="_blank">
                            <img src="assets/img/bits.png?1" alt="" class="img-thumbnail">
                            <br>
                            BITS
                        </a>
                    </div>
                    <div class="col-md-4 col-xs-12 text-center">
                        <a class="user_img_item" href="{$base_url}product/change?product=cargo" target="_blank">
                            <img src="assets/img/cargo.png?1" alt="" class="img-thumbnail">
                            <br>
                            Cargo
                        </a>
                    </div>
                    <div class="col-md-4 col-xs-12 text-center">
                        <a class="user_img_item" href="{$base_url}product/change?product=gps" target="_blank">
                            <img src="assets/img/gps-logo.png?1" alt="" class="img-thumbnail">
                            <br>
                            Track Bus
                        </a>
                    </div>
                </div>
                <br />
                <div class="row">
                    {if $action_rights['CAN-SHOW-WALLET']>0}
                        <div class="col-md-4 col-xs-12 text-center">
                            <a class="user_img_item" href="{$base_url}product/wallet" target="_blank">
                                <img src="assets/img/analytics-logo.png" alt="" class="img-thumbnail">
                                <br>
                                Wallet
                            </a>
                        </div>
                    {/if}

                    {if $is_super_namespace==1}
                        <div class="col-md-4 col-xs-12 text-center">
                            <a class="user_img_item" href="{$base_url}product/change?product=analytics" target="_blank">
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
                    {/if}
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
            {if $namespace=="demo"}
                <div class="row">
                    <div class="text-center">
                        <a href="{$base_url}#content/contactus">contact</i></a>&nbsp;&nbsp;| &nbsp;&nbsp;
                        <a href="{$base_url}#content/about">about us</i></a>&nbsp;&nbsp;| &nbsp;&nbsp;
                        <a href="{$base_url}#content/terms">Terms & Conditions</i></a>&nbsp;&nbsp;| &nbsp;&nbsp;
                        <a href="{$base_url}#content/faq">Faq</a> &nbsp;&nbsp;| &nbsp;&nbsp;
                        <a href="{$base_url}#content/privacypolicy">Privacy Policy</a>
                    </div><br>
                </div>
            {/if}

            <div class="row">
                <div class="text-center">
                    &COPY; {date('Y')} All rights reserved. &nbsp;
                    Powered by <a href="http://www.ezeeinfosolutions.com" target="_blank">EzeeInfo Cloud Solutions Pvt
                        Ltd</a>
                </div> <br>
            </div>
        </footer>

        {include file='site/template/namespace-dialog.tpl'}
        <script type="text/template" id="nsp-li">
        <a href="javascript:;" onclick="nameSpaceswitch('')" id="nps_"></a>
            </script>

        {include file='site/template/print-ticket-dialog.tpl'}
        {include file='site/template/ep-print-dialog.tpl'}
        {include file='site/template/document-upload-dialog.tpl'}
        {include file='site/template/cargo-dialogs.tpl'}

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


        <script type="text/javascript">
            $(document).ready(function($) {
                var name_id = "{$namespace}";
                $('.name_' + name_id).addClass('active');
                var login_branch = "{$login_branch}";
                $('.brch_' + login_branch).addClass('active');
                checkURL(); //  auto load dashboard>
            });
        </script>
        {* JAVASCRIP CONFIGURATIONS *}
        <script src="assets/config.js" type="text/javascript"></script>
        
        <script src="assets/js/bootstrap-select.js?{$asset_ver}" type="text/javascript"></script>

        <script src="assets/js/bootstrap-select.js?{$asset_ver}" type="text/javascript"></script>
        <script type="text/javascript" src="assets/js/plupload.full.min.js?{$asset_ver}"></script>
        <script type="text/javascript" src="assets/js/jquery.fancybox.js?{$asset_ver}"></script>
        <script type="text/javascript" src="assets/js/jquery.fancybox-thumbs.js?{$asset_ver}"></script>

        <script type="text/javascript" src="assets/lib/hotkeys/hotkeys.min.js?{$asset_ver}"></script>

        <script type="text/javascript" src="assets/js/ep-app.js?{$asset_ver}"></script>
        <script type="text/javascript" src="assets/js/jsrsasign-all-min.js?{$asset_ver}"></script>
        <script type="text/javascript" src="assets/js/sign-message.js?{$asset_ver}"></script>
        <script type="text/javascript" src="assets/js/ezeeprint.js?{$asset_ver}"></script>
        <script type="text/javascript" src="assets/js/printDiv.js?{$asset_ver}"></script>
        <script type="text/javascript" src="assets/js/toastr.js?{$asset_ver}"></script>
        
        <!-- /debug function for commom usecase -->
        <script src="assets/js/common.js" type="text/javascript"></script>
        <script>
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
        </script>

         {literal}
            <script>               
                const settingsData = {/literal}{_namespace_nav_logo_change_()}{literal};
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
            </script>
        {/literal}

    </body>

    </html>
{else}
    {include file=$page_body title=page_content}
    {* <footer>
        <div class="">
            <div class="text-center">
                &COPY; {date('Y')} All rights reserved. &nbsp;
                Powered by  <a href="http://www.ezeeinfosolutions.com" target="_blank">Ezee Info Solutions</a></div>
        </div>
    </footer> *}
{/if}