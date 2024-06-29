<?php
$CI =& get_instance();
$CI->load->library('session');
$is_logged_in = ( $CI->session->userdata('admin_id')>0 ) ? 1 : 0;
if(empty($mainmenu)) $mainmenu = $CI->uri->segment(2);
if(empty($submenu)) $submenu = $CI->uri->segment(3);
?>

<?php if($is_logged_in) : ?>
<!DOCTYPE html>
<html>
    <head><base href="<?= base_url(); ?>">
        <title>Caribbean / Admin Control Panel</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta content='text/html;charset=utf-8' http-equiv='content-type'>
        <meta content='' name='description'>
        <link href='assets/images/meta_icons/favicon.ico' rel='shortcut icon' type='image/x-icon'>
        <link href='assets/images/meta_icons/apple-touch-icon.png' rel='apple-touch-icon-precomposed'>
        <link href='assets/images/meta_icons/apple-touch-icon-57x57.png' rel='apple-touch-icon-precomposed' sizes='57x57'>
        <link href='assets/images/meta_icons/apple-touch-icon-72x72.png' rel='apple-touch-icon-precomposed' sizes='72x72'>
        <link href='assets/images/meta_icons/apple-touch-icon-114x114.png' rel='apple-touch-icon-precomposed' sizes='114x114'>
        <link href='assets/images/meta_icons/apple-touch-icon-144x144.png' rel='apple-touch-icon-precomposed' sizes='144x144'>
        <!-- / START - page related stylesheets [optional] -->
        <link href="assets/stylesheets/plugins/bootstrap_daterangepicker/bootstrap-daterangepicker.css" media="all" rel="stylesheet" type="text/css" />
        <link href="assets/stylesheets/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.min.css" media="all" rel="stylesheet" type="text/css" />
        <link href="assets/stylesheets/plugins/common/bootstrap-wysihtml5.css" media="all" rel="stylesheet" type="text/css" />
        <link href="assets/stylesheets/jquery/jquery_ui.css" media="all" rel="stylesheet" type="text/css" />
        <link href="assets/stylesheets/plugins/tabdrop/tabdrop.css" media="all" rel="stylesheet" type="text/css" />
        <link href="assets/stylesheets/plugins/fuelux/wizard.css" media="all" rel="stylesheet" type="text/css" />
        <!-- / END - page related stylesheets [optional] -->
        <!-- / bootstrap [required] -->
        <link href="assets/stylesheets/bootstrap/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
        <!-- / theme file [required] -->
        <link href="assets/stylesheets/light-theme.css" media="all" id="color-settings-body-color" rel="stylesheet" type="text/css" />
        <!-- / coloring file [optional] (if you are going to use custom contrast color) -->
        <link href="assets/stylesheets/theme-colors.css" media="all" rel="stylesheet" type="text/css" />
        <!-- / demo file [not required!] -->
        <link href="assets/stylesheets/demo.css" media="all" rel="stylesheet" type="text/css" />
        <link href="assets/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet" type="text/css" />
        <!--[if lt IE 9]>
          <script src="assets/javascripts/ie/html5shiv.js" type="text/javascript"></script>
          <script src="assets/javascripts/ie/respond.min.js" type="text/javascript"></script>
          
        <![endif]-->
        <script>
            var base_url = "<?= base_url(); ?>";
        </script>
            <!-- / jquery [required] -->
        <script src="assets/javascripts/jquery/jquery.min.js" type="text/javascript"></script>
        <!-- / jquery mobile (for touch events) -->
        <script src="assets/javascripts/jquery/jquery.mobile.custom.min.js" type="text/javascript"></script>
        <!-- / jquery migrate (for compatibility with new jquery) [required] -->
        <script src="assets/javascripts/jquery/jquery-migrate.min.js" type="text/javascript"></script>
        <!-- / jquery ui -->
        <script src="assets/javascripts/jquery/jquery-ui.min.js" type="text/javascript"></script>
        <!-- / jQuery UI Touch Punch -->
        <script src="assets/javascripts/plugins/jquery_ui_touch_punch/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
        <!-- / bootstrap [required] -->
        <script src="assets/javascripts/bootstrap/bootstrap.js" type="text/javascript"></script>
        <!-- / modernizr -->
        <script src="assets/javascripts/plugins/modernizr/modernizr.min.js" type="text/javascript"></script>
        <!-- / retina -->
        <script src="assets/javascripts/plugins/retina/retina.js" type="text/javascript"></script>
        
        <!-- / START - page related files and scripts [optional] -->
        <script src="assets/javascripts/plugins/flot/excanvas.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/flot/flot.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/flot/flot.resize.js" type="text/javascript"></script>

        <script src="assets/javascripts/plugins/common/moment.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/timeago/jquery.timeago.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/datatables/dataTables.overrides.js" type="text/javascript"></script>   
        <script src="assets/javascripts/plugins/fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/select2/select2.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/bootstrap_colorpicker/bootstrap-colorpicker.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/bootstrap_daterangepicker/bootstrap-daterangepicker.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/common/moment.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/input_mask/bootstrap-inputmask.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/bootstrap_maxlength/bootstrap-maxlength.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/charCount/charCount.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/autosize/jquery.autosize-min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/bootstrap_switch/bootstrapSwitch.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/naked_password/naked_password-0.2.4.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/mention/mention.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/typeahead/typeahead.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/common/wysihtml5.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/common/bootstrap-wysihtml5.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/pwstrength/pwstrength.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/tabdrop/bootstrap-tabdrop.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/validate/additional-methods.js" type="text/javascript"></script>
        <script src="assets/javascripts/plugins/fuelux/wizard.js" type="text/javascript"></script>
        <!-- / END - page related files and scripts [optional] -->
        
        <!-- / theme file [required] -->
        <script src="assets/javascripts/theme.js" type="text/javascript"></script>
        <!-- / demo file [not required!] -->
        <script src="assets/javascripts/demo.js" type="text/javascript"></script>      
    
    </head>
    <body class='contrast-dark'>
        <header>
            <nav class='navbar navbar-default'>
                <a class='navbar-brand' href='<?= base_url(); ?>admin'>
                    <img width="100" class="logo" alt="Caribbean" src="assets/images/logo_lg.png" />
                </a>
                <a class='toggle-nav btn pull-left' href='javascript:;'>
                    <i class='icon-reorder'></i>
                </a>
                <ul class='nav'>
                    
                    <li class='dropdown medium only-icon widget'>
                    <li class='dropdown dark user-menu'>
                        <a class='dropdown-toggle' data-toggle='dropdown' href=''>
                          <!-- <img width="23" height="23" alt="Mila Kunis" src="assets/images/avatar.jpg" /> -->
                            <span class='user-name'><?= $this->session->userdata('admin_firstname') ?></span>
                            <b class='caret'></b>
                        </a>
                        <ul class='dropdown-menu'>
                            <li>
                                    <a href='admin/admin/change-password'>
                                        <i class='icon-cog'></i>
                                        Change Password
                                    </a>
                            </li>
                            <li class='divider'></li>
                            <li>
                                <a href='admin/admin/logout'>
                                    <i class='icon-signout'></i>
                                    Sign out
                                </a>
                            </li>
                            
                        </ul>
                    </li>
                </ul>
            </nav>
        </header>
        <div id='wrapper'>
            <div id='main-nav-bg'></div>
            <nav id='main-nav'>
                <div class='navigation'>
                    <ul class='nav nav-stacked'>                       
                        <li id="m_index" >
                            <a href='admin/index'>
                                <i class='icon-dashboard'></i>
                                <span>Dashboard</span>                               
                            </a>
                        </li>                       
                        <?php if( has_admin_permissions(9) ) : ?>
                        <li id="m_cms">
                            <a href='admin/cms'>
                                <i class='icon-edit '></i>
                                <span>Content Management</span>
                            </a>
                        </li>
                        <?php endif ?>
                        <?php if( has_admin_permissions(10) ) : ?>
                        <li id="m_announcements">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-bullhorn'></i>
                                <span>Announcements</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_announcements" class=''>
                                    <a href='admin/announcements'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Announcements</span>
                                    </a>
                                </li>
                                <li id="s_type" class=''>
                                    <a href='admin/announcements/type'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Announcement Type</span>
                                    </a>
                                </li>
                                
                            </ul>
                        </li>
                        <?php endif ?>
                        <?php if( has_admin_permissions(11) ) : ?>
                        <li id="m_facilities">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-calendar'></i>
                                <span>Facilities</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_rules" class=''>
                                    <a href='admin/facilities/rules'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Rules</span>
                                    </a>
                                </li>
                                <li id="s_facilities" class=''>
                                    <a href='admin/facilities'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Facilities</span>
                                    </a>
                                </li>
                                <li id="s_bookings" class=''>
                                    <a href='admin/facilities/bookings'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Bookings</span>
                                    </a>
                                </li>
                                <li id="s_transactions" class=''>
                                    <a href='admin/facilities/transactions'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Transactions</span>
                                    </a>
                                </li>
                            </ul>
                        </li> 
                        <?php endif ?>
                        <?php if( has_admin_permissions(12) ) : ?>                        
                        <li id="m_servicerequests">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-comments-alt '></i>
                                <span>Service Requests</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_servicerequests" class=''>
                                    <a href='admin/servicerequests'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Feedbacks and <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Service Requests</span>
                                    </a>
                                </li>
                                <li id="s_types" class=''>
                                    <a href='admin/servicerequests/types'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Feedback Types</span>
                                    </a>
                                </li>
                                <li id="s_feedback-search" class=''>
                                    <a href='admin/servicerequests/feedback-search'>
                                        <i class="icon-caret-right"></i>
                                        <span>Feedback Search</span>
                                    </a>
                                </li>
                                
                            </ul>
                        </li>
                        <?php endif ?>
                        <?php if( has_admin_permissions(13) ) : ?>
                        <li id="m_forms">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-folder-close'></i>
                                <span>Application Forms</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_forms" class=''>
                                    <a href='admin/forms'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Application Forms</span>
                                    </a>
                                </li>
                                <li id="s_category" class=''>
                                    <a href='admin/forms/category'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Form Types</span>
                                    </a>
                                </li>
                               <!-- <li class=''>
                                    <a href='admin/forms/applications'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Applications</span>
                                    </a>
                                </li>-->
                            </ul>
                        </li>
                        <?php endif ?>
                        <?php if( has_admin_permissions(14) ) : ?>
                        <li id="m_community">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-group '></i>
                                <span>Community</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_cctv" class=''>
                                    <a href='admin/community/cctv'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage CCTV</span>
                                    </a>
                                </li>
                                <li id="s_advertisements" class=''>
                                    <a href='admin/community/advertisements'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Advertisements</span>
                                    </a>
                                </li>
                                <li id="s_advertisements-types" class=''>
                                    <a href='admin/community/advertisements-types'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Advertisement Types</span>
                                    </a>
                                </li>
                                <li id="s_contacts" class=''>
                                    <a href='admin/community/contacts'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Contacts</span>
                                    </a>
                                </li>
                                <li id="s_contacts-types" class=''>
                                    <a href='admin/community/contacts-types'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Contacts Types</span>
                                    </a>
                                </li>
                                
                                <li id="s_links" class=''>
                                    <a href='admin/community/links'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Links</span>
                                    </a>
                                </li>
                                
                                <li id="s_links-types" class=''>
                                    <a href='admin/community/links-types'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Links Types</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <?php endif ?>
                        <?php if( has_admin_permissions(15) ) : ?>
                        <li id="m_reports">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-bar-chart'></i>
                                <span>Reports</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_portal-usage" class=''>
                                    <a href='admin/reports/portal-usage'>
                                        <i class="icon-caret-right"></i>
                                        <span>Portal Usage</span>
                                    </a>
                                </li>
                                <li id="s_facility-usage" class=''>
                                    <a href='admin/reports/facility-usage'>
                                        <i class="icon-caret-right"></i>
                                        <span>Facility Usage</span>
                                    </a>
                                </li>
                                
                                <li id="s_feedback-service" class=''>
                                    <a href='admin/reports/feedback-service'>
                                        <i class="icon-caret-right"></i>
                                        <span>Feedback and Service Request</span>
                                    </a>
                                </li>
                                
                            </ul>
                        </li>
                        <?php endif ?>
                        <?php if( has_admin_permissions(16) ) : ?>                                      
                        <li id="m_resident">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-user'></i>
                                <span>Residents</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_users" class=''>
                                    <a href='admin/resident/users'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Residents</span>
                                    </a>
                                </li>                        
                               
                                <li id="s_roles" class=''>
                                    <a href='admin/resident/roles'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Roles</span>
                                    </a>
                                </li>
                                
                                <li id="s_transactions" class=''>
                                    <a href='admin/resident/transactions'>
                                        <i class="icon-caret-right"></i>
                                        <span>Balance and Transactions</span>
                                    </a>

                                </li>
                                <li id="s_top-up" class=''>
                                    <a href='admin/resident/top-up'>
                                        <i class="icon-caret-right"></i>
                                        <span>Top Up Balance</span>
                                    </a>

                                </li>
                            </ul>
                        </li>
                        <?php endif ?>
                        <?php if( has_admin_permissions(17) ) : ?>
                        <li id="m_admin">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-group'></i>
                                <span>Administrators</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_users" class=''>
                                    <a href='admin/admin/users'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Administrators</span>
                                    </a>
                                </li>
                                <li id="s_roles" class=''>
                                    <a href='admin/admin/roles'>
                                        <i class="icon-caret-right"></i>
                                        <span>Manage Roles</span>
                                    </a>
                                </li>
                                
                            </ul>
                        </li>
                        <?php endif ?>
                        <?php if( has_admin_permissions(18) ) : ?>
                        <li id="m_settings">
                            <a class='dropdown-collapse ' href='javascript:;'>
                                <i class='icon-gear '></i>
                                <span>Settings</span>
                                <i class='icon-angle-down angle-down'></i>
                            </a>
                            <ul class='nav nav-stacked'>
                                <li id="s_system" class=''>
                                    <a href='admin/settings/system'>
                                        <i class="icon-caret-right"></i>
                                        <span>System Settings</span>
                                    </a>
                                </li>
                                <li id="s_smtp" class=''>
                                    <a href='admin/settings/smtp'>
                                        <i class="icon-caret-right"></i>
                                        <span>Email Settings</span>
                                    </a>
                                </li>

                            </ul>
                        </li>
                        <?php endif ?>                      
                </div>
            </nav>
            
        <?php endif; ?>       
            
        <?php echo $content; ?>
        
        <?php if($is_logged_in) : ?>
        </div>
    

    <section name="menu" main="<?php echo $mainmenu; ?>" sub="<?php echo $submenu; ?>" ></section>
    </body>
    
    <script>
       $(function() {
           var mainmenu = $('section[name="menu"]').attr('main');
           var submenu = $('section[name="menu"]').attr('sub');

           $('#m_'+mainmenu).find('.nav-stacked').show(); 
           $('#m_'+mainmenu).first().addClass('active');
           $('#m_'+mainmenu).parent().addClass('in');
           
           $('#m_'+mainmenu).find('#s_'+submenu).addClass('active');                
           $('#m_'+mainmenu).find('#s_'+submenu).parent().addClass('in');    
           
       });
      
      $.validator.addMethod("buga", (function(value) {
        return value === "buga";
      }), "Please enter \"buga\"!");
      
      $.validator.methods.equal = function(value, element, param) {
        return value === param;
      };
   
    </script>
   
</html>
<?php endif; ?> 
