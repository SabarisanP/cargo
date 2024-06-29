    <!-- Start footer section -->
    <footer class="footer-section section-bg-1" id="contact-section">
        <div class="footer-top">
            <div class="container">
                <div class="row">
                    <div class="col-lg">
                        <img src="assets/img/login/logo.png" alt="Logo" class="img-fluid">
                        <h3>Increase the <span class="text-clr-1">business growth</span> with Ezeeinfo today</h3>
                        <p>We are one of India's leading technology providers for the Transportation Industry since 2011. Providing Next Generation Cloud based Business Solutions for Travel, Logistics & IOT Products with years of expertise in Mobile/Cloud /API based services. Accelerating the Industries dynamic & continuous digital transformation</p>
                    </div>
                    <div class="col-lg-auto">&nbsp;</div>
                    <div class="col col-lg">
                        <h5>Our Features</h5>
                        <ul class="footer-list">
                            <li><a href="reports">Reports</a></li>
                            <li><a href="ezeeprint">EzeePrint</a></li>
                            <li><a href="qrcode">Why QR Code</a></li>
                            <li><a href="#e-waybill">E-Way Bill</a></li>
                            <li><a href="#login-solution">Login Solutions</a></li>
                        </ul>

                        <h5>Our Products</h5>
                        <ul class="footer-list">
                            <li><a href="https://www.ezeeinfocloudsolutions.com/bus-operator-software" target="_blank">EzeeBits</a></li>
                            <li><a href="https://www.ezeeinfocloudsolutions.com/cargo-logistics-software" target="_blank">EzeeCargo</a></li>
                            <li><a href="https://www.trackbus.in/" target="_blank">Track Bus</a></li>
                            <li><a href="https://www.ezeeinfocloudsolutions.com/busbuddy" target="_blank">BusBuddy</a></li>
                            <li><a href="https://www.ezeeinfocloudsolutions.com/ezeebot" target="_blank">EzeeBot</a></li>
                        </ul>
                    </div>
                    <div class="col col-lg">
                        <h5>Company</h5>
                        <ul class="footer-list">
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Terms of Use</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="#">Affiliate Program</a></li>
                        </ul>

                        <h5>Our locations</h5>
                        <ul class="footer-list">
                            <li><a href="https://goo.gl/maps/7nMGZEJagB15QzS78" target="_blank">Chennai</a></li>
                            <li><a href="https://goo.gl/maps/7nMGZEJagB15QzS78" target="_blank">Bengaluru</a></li>
                            <li><a href="https://goo.gl/maps/7nMGZEJagB15QzS78" target="_blank">Hyderabad</a></li>
                            <li><a href="https://goo.gl/maps/7nMGZEJagB15QzS78" target="_blank">Coimbatore</a></li>
                        </ul>
                    </div>
                    <div class="col-lg">
                        <h5>HELP & SUPPORT</h5>
                        <ul class="footer-list">
                            <li><span>Call or Whatsapp us</span> <br>
                                <a href="tel:+919500007529">+91 9500007529</a> <br>
                                <a href="tel:+919500005963">+91 9500005963</a>
                            </li>
                            <li><a href="mailto:contact@ezeeinfo.in">contact@ezeeinfo.in</a></li>
                        </ul>

                        <h5>FIND US ONLINE</h5>
                        <ul id="social">
                            <li><a target="_blank" href="https://www.facebook.com/ezeeinfosolutions"><i class="fa fa-facebook"></i></a></li>
                            <li><a target="_blank" href="https://www.linkedin.com/company/ezeeinfo"><i class="fa fa-linkedin"></i></a></li>
                            <li><a target="_blank" href="https://twitter.com/EzeeinfoS"><i class="fa fa-twitter"></i></a> </li>
                            <li><a target="_blank" href="https://www.instagram.com/ezeeinfo.cloudsolutions/"><i class="fa fa-youtube-play"></i></a></li>
                            <li><a target="_blank" href="https://www.youtube.com/channel/UCF7tBubWWa7yf_fpqk0QCvg"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                        </ul>

                        <img src="assets/img/login/ezee-iso-1.png" alt="ISO" class="img-fluid">
                        <img src="assets/img/login/ezee-iso-2.png" alt="ISO" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom text-center">
            <div class="container">
                <p class="copyright-text">&copy; A product <i class="fa fa-cloud" aria-hidden="true"></i> of
                    <a href="https://www.ezeeinfocloudsolutions.com" target="_blank">Ezeeinfo Cloud Solutions Private Limited</a>
                </p>
            </div>
        </div>
    </footer>
    <!-- End footer section -->

    <div class="scroll-top">
        <i class="ti-angle-up"></i>
    </div>

    <!-- JS ============================================= -->
    <script src="assets/js/login/vendor/jquery-2.2.4.min.js"></script>
    <script src="assets/js/login/vendor/popper.min.js"></script>
    <script src="assets/js/login/jquery.easing.1.3.js"></script>
    <script src="assets/js/login/vendor/bootstrap.min.js"></script>
    <script src="assets/js/login/jquery.parallax-scroll.js"></script>
    <script src="assets/js/login/dopeNav.js"></script>
    <script src="assets/js/login/owl.carousel.min.js"></script>
    <script src="assets/js/login/jquery.stellar.min.js"></script>
    <script src="assets/js/login/jquery.counterup.min.js"></script>
    <script src="assets/js/login/waypoints.min.js"></script>
    <script src="assets/js/login/main.js?{$asset_ver}"></script>

    <script>
        $(function() {
            $('#btn-login').click(loginAction);
            $('#opcode').focus();
            $('#login_form  input').keypress(function(event) {
                if (event.which == 13) {
                    event.preventDefault();
                    loginAction();
                }
            });

            // var op_code = $.trim($('#opcode').val());
            // if (op_code) {
            //     verifyOperatorCode();
            // }
        })

        function verifyOperatorCode() {
            var data = {};
            data.op_code = $.trim($('#opcode').val());

            $('#verify-state').hide();

            if (data.op_code == "") {
                $('#verify-state').html('<div style="" class="alert alert-danger" >Please enter Account Id</div>');
                $('#verify-state').show();
                $('#opcode').focus();
                return false;
            }
            $('#btn-signin').addClass('disabled');
            $('#verify-state').html('<div style="" class="alert alert-danger" >Authenticating...</dvi>');
            $('#verify-state').show();
            $.ajax({
                type: "POST",
                url: 'user/verify-operator-code',
                data: data,
                dataType: "json",
                success: function(res) {
                    if (res.status == 1) {
                        $('#verify-state').html('<div style="" class="alert alert-success" >Please Wait...</div>');
                        window.setTimeout(function() {
                            $('#l_domain').val(data.op_code);
                            $('#op_name').text(res.data.name);
                            $('#signin-panel').addClass('d-none');
                            $('#login-panel').removeClass('d-none');
                            $('#l_email').focus();
                        }, 1000);
                    } else {
                        $('#verify-state').html('<div style="" class="alert alert-danger" >Sorry! Account Id doesnt exists.</div>');
                        $('#btn-signin').removeClass('disabled');
                    }
                }
            });
        }

        function loginAction() {
            var data = {};
            data.l_email = $.trim($('#l_email').val());
            data.l_password = $.trim($('#l_password').val());
            data.l_domain = $.trim($('#l_domain').val());
            data.l_remember = +$('#l_remember').is(':checked');
            $('#login-state').hide();
            if (data.l_domain == "") {
                $('#login-state').html('<div style="" class="alert alert-danger" >Please enter domain name</div>');
                $('#login-state').show();
                $('#l_domain').focus();
                return false;
            } else if (data.l_email == "") {
                $('#login-state').html('<div style="" class="alert alert-danger" >Please enter username/email address</div>');
                $('#login-state').show();
                $('#l_email').focus();
                return false;
            }
            else if (data.l_password == "") {
                $('#login-state').html('<div style="" class="alert alert-danger" >Please enter password</div>');
                $('#login-state').show();
                $('#l_password').focus();
                return false;
            } else if (data.l_password.length < 6) {
                $('#login-state').html('<div style="" class="alert alert-danger" >Password should be minimum 6 characters</div>');
                $('#login-state').show();
                $('#l_password').focus();
                return false;
            }
            $('#btn-login').addClass('disabled');
            $('#login-state').html('<div style="" class="alert alert-danger" >Authenticating...</dvi>');
            $('#login-state').show();
            $.ajax({
                type: "POST",
                url: base_url + "user/verify-login",
                data: data,
                dataType: "json",
                success: function(res) {
                    if (res.status == 1) {
                        $('#login-state').html('<div style="" class="alert alert-success" >Login success. Redirecting...</div>');
                        window.setTimeout(function() {
                            if (/^#cargo\/verify-vendor-email/.test(location.hash)) {
                                location.reload();
                                return;
                            }
                            //window.location.href = base_url+'user/dashboard';
                            window.location.href = base_url; //+ res.redirectUrl;
                        }, 1000);
                    } else if(res.status == 2) { //Otp Verify
                        $('#login-state').html('<div class="alert alert-success" >Login success. Redirecting to OTP Verification...</div>');
                        window.setTimeout(function() {
                            window.location.href = base_url +'auth/otp-verification';
                        }, 2000);
                    }  else if(res.status == 9) { //reset password
                        $('#login-state').html('<div class="alert alert-danger" >Sorry! Please update your password.</div>');
                        window.setTimeout(function() {
                            window.location.href = base_url +'auth/reset-password';
                        }, 2000);
                    } else {
                        if (res.status == 1001) {
                            $('#login-state').html('<div style="" class="alert alert-danger" >Sorry! Access Denied.</div>');
                            $('#btn-login').removeClass('disabled');
                        } else {
                            $('#login-state').html('<div style="" class="alert alert-danger" >Sorry! Invalid username or password.</div>');
                            $('#btn-login').removeClass('disabled');
                        }
                    }
                }
            });

            return false;
        }

        $(function() {
            $('#btn-login').click(function() {
                loginAction()
            });

            $("#l_domain, #l_email, #l_password").keypress(function(event) {
                if (event.which == 13) {
                    event.preventDefault();
                    loginAction();
                }
            });

            $("#opcode").keypress(function(event) {
                if (event.which == 13) {
                    event.preventDefault();
                    verifyOperatorCode();
                }
            });
        });

        function signInBack() {
            $('#l_domain').val('');
            $('#op_name').text('');
            $('#signin-panel').removeClass('d-none');
            $('#login-panel').addClass('d-none');
            $('#verify-state').html('');
            $('#btn-signin').removeClass('disabled');
            $('#opcode').focus();
        }

    </script>

</body>

</html>