<!DOCTYPE html>
<html lang="en">
    <head>
        <base href="{$base_url}">
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <title>Ezeebus | Authentication</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
        <meta name="description" content="">
        <meta name="author" content="">
        {literal}
        <style>
            #loader{
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: #333;
                z-index: 9999999999;
            }
            #loader h4{
                text-align: center;
                color:#fff;
                font-size: 16px;
            }
            .spinner {
                width: 40px;
                height: 40px;

                position: relative;
                margin: 200px auto;
            }

            .double-bounce1, .double-bounce2 {
                width: 100%;
                height: 100%;
                border-radius: 50%;
                background-color: #fff;
                opacity: 0.6;
                position: absolute;
                top: 0;
                left: 0;

                -webkit-animation: sk-bounce 2.0s infinite ease-in-out;
                animation: sk-bounce 2.0s infinite ease-in-out;
            }

            .double-bounce2 {
                -webkit-animation-delay: -1.0s;
                animation-delay: -1.0s;
            }

            @-webkit-keyframes sk-bounce {
                0%, 100% { -webkit-transform: scale(0.0) }
                50% { -webkit-transform: scale(1.0) }
            }

            @keyframes sk-bounce {
                0%, 100% { 
                  transform: scale(0.0);
                  -webkit-transform: scale(0.0);
                } 50% { 
                  transform: scale(1.0);
                  -webkit-transform: scale(1.0);
                }
            }
        </style>
        {/literal}
        <script>
            var base_url = "{$base_url}";
        </script>
        <!-- bootstrap framework -->
        <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- google webfonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">

        <link href="assets/css/login.css" rel="stylesheet">
        <!-- STYLESHEETS --><!--[if lt IE 9]><script src="{$base_url}assets/js/flot/excanvas.min.js"></script><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script><![endif]-->
        <!-- jQuery -->
        <script src="assets/js/jquery.min.js"></script>
        <!-- bootstrap js plugins -->
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body>
        
        <div class="login_container" style="margin-top: 150px;"> 
            {if $invalid==1}
                <h4>Your session has been expired.</h4> <br><br><br><br>
            {else}
                
                
            <form id="register_form" method="post" onsubmit="return false">
                <h1 class="login_heading">Welcome, {$loginname|truncate:15}...</h1>
                <div class="form-group">
                    <p>Re-Confirm your password</p>
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" id="sa-password" placeholder="Enter your password">
                </div>
                <div id="login-state"></div>
                <div class="submit_section">
                    <button type="button" class="btn btn-lg btn-success btn-block" id="btn-verify">Verify</button>
                </div>
            </form>
            {/if}    
        </div>
        <br>
        
        {if $invalid !=1 }  
            {if $smarty.request.opt==1} 
                <div id="loader">
                    <div class="spinner">
                      <div class="double-bounce1"></div>
                      <div class="double-bounce2"></div>
                    </div>
                    <h4 id="nostate">Please "Allow" or "Allow Location Access" to continue login...</h4>
                    <h4 id="blocked" class="hide">Please turn on location to continue login...</h4>
                </div>
            {/if}
        {/if}
        
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        {literal}
            <script>
            var lat = '', lang = '';    
            $(function() {
                
                $('#btn-verify').click(function() {                   
                    var data = {};
                    data.password = $('#sa-password').val();                    
                    data.lat = lat;
                    data.lang = lang;
                    
                    if(data.password=="") {
                        $('#login-state').html('<div style="" class="alert alert-danger" >Please enter your password</div>');
                        $('#login-state').show();
                        $('#sa-password').focus();
                        return false;
                    }
                    
                    //$('#btn-verify').addClass('disabled');
                    $('#login-state').html('<div style="" class="alert alert-danger" >Authenticating...</dvi>');
                    $('#login-state').show();
                    
                    $.ajax({
                        type: "POST",
                        url: base_url + "auth/verify-password",
                        dataType: 'json',
                        data:data,
                        success: function(result) {
                            if (result.status == 1) {
                                $('#login-state').html('<div style="" class="alert alert-success" >Login success. Redirecting...</div>');
                                    window.setTimeout(function() {
                                        window.location.href = base_url+'user/auto-login?smart=1';
                                    }, 1000);
                            } else {
                                $('#login-state').html('<div style="" class="alert alert-danger" >Sorry! Invalid password.</div>');
                                $('#btn-verify').removeClass('disabled');
                            }
                        }
                    });
                   
                });
                
                $("#sa-password").keypress(function(event) {
                    if (event.which == 13) {
                        event.preventDefault();
                        $('#btn-verify').trigger('click');
                    }
                });

                
                $('#register_email').focus();
                var options = {
                    enableHighAccuracy: true,
                    timeout: 5000,
                    maximumAge: 0
                };

                function success(pos) {
                    $('#loader').addClass('hide');
                    $('#sa-password').focus();
                    var crd = pos.coords;
                    lat = crd.latitude;
                    lang = crd.longitude; 
                };

                function error(err) {
                    $('#nostate').addClass('hide');
                    $('#blocked').removeClass('hide');
                    console.log(err.message);
                };
                navigator.geolocation.getCurrentPosition(success, error, options);
            })
            </script>
        {/literal}
    </body>
</html>