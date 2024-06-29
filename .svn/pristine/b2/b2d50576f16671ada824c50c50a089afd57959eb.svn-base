<!DOCTYPE html>
<html lang="en">

<head>
    <base href="{$base_url}">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>Ezeebus | OTP Verification</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <script>
        var base_url = "{$base_url}";
    </script>
    <link rel="shortcut icon" href="assets/img/bits-favicon.png" />
    <!-- bootstrap framework -->
    <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- google webfonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <link href="assets/icons/font-awesome/css/font-awesome.min.css" rel="stylesheet" media="screen">

    <link href="assets/css/login.css?{$asset_ver}" rel="stylesheet">
    <script src="assets/js/jquery.min.js"></script>
    <!-- bootstrap js plugins -->
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>
    <div class="login_container">
        <form id="login_form" method="post" onsubmit="return false;">
            <h1 class="login_heading">Welcome {$temp_name}</h1>
            <div class="form-group">
                <span class='note text-muted'>We have just sent a verification code to <span id="mnotes">{$otp->data->MOBILE}, {$otp->data->EZBOT}</span>.</span>
                <br>
                <label for="otpNumber" class="req">Enter verification Code</label>
                <input type="text" class="form-control" id="otpNumber" value="">
                
            </div>
            <div id="user-state"></div>
            <div class="submit_section">
                <button class="btn btn-lg btn-success btn-block" id="btn-reset" onclick="verifyOtp();">Verify</button>
            </div>
        </form>
    </div>

    <!-- jQuery -->
    <script src="assets/js/jquery.min.js"></script>
    <!-- bootstrap js plugins -->
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script>
        var otp = {$otp|json_encode};

        $('#otpNumber, #btn-reset').prop('disabled', false);
        $('#user-state').removeClass('alert alert-danger').html('');
        
        if (otp.status != 1) {
            $('#otpNumber, #btn-reset').prop('disabled', true);
            $('#user-state').addClass('alert alert-danger').html(otp.errorDesc || '');
        }
    </script>
    {literal}
        <script>
            
            function verifyOtp() {
                var data = {};
                data.otpNumber = $('#otpNumber').val().trim();

                $('#user-state').removeClass('alert').addClass('alert');
                $('#user-state').html('');
                $('#otpNumber').removeClass('inp_error');
                var err = 0;

                if ($('#otpNumber').val() == '') {
                    $('#otpNumber').addClass('inp_error');
                    err++;
                }

                if (err > 0) {
                    $('#user-state').removeClass('alert-success').addClass('alert-danger');
                    $('#user-state').html('Please enter verification code.');
                    return false;
                }

                $('#user-submit').addClass('disabled');
                $('#user-state').removeClass('alert-success').addClass('alert-danger');
                $('#user-state').html('Authenticating...');
                $('#user-state').show();
                $.ajax({
                    type: "POST",
                    url: base_url + "auth/verify-otp-number",
                    data: data,
                    dataType: "json",
                    success: function(res) {
                        console.log(res)
                        if (res.status == 1) { // OTP success
                            $('#user-state').addClass('alert-success').removeClass('alert-danger');
                            $('#user-state').html('OTP verified. Please wait....');
                            window.setTimeout(function() {
                                window.location.href = base_url;
                                return;
                            }, 2000);
                            } 
                        else if(res.status == 9) {  // reset password
                            $('#user-state').addClass('alert-danger').removeClass('alert-success');
                            $('#user-state').html('Looks like your password is expired. Please update password.');
                            window.setTimeout(function() {
                                window.location.href = base_url + 'auth/reset-password';
                            }, 2000);
                        } else {
                            $('#user-state').removeClass('alert-success').addClass('alert-danger');
                            $('#user-state').html('Sorry! OTP Verification Failed.');
                            $('#user-submit').removeClass('disabled');
                        }
                    }
                });
            }
        </script>
    {/literal}
    <!-- /JAVASCRIPTS -->
</body>

</html>