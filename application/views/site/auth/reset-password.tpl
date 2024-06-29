<!DOCTYPE html>
<html lang="en">

<head>
    <base href="{$base_url}">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>Ezeebus | Reset Password</title>
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
            <h1 class="login_heading">Reset Password</h1>
            <div class="form-group">
                <label for="l_domain" class="req">Old Password</label>
                <input type="password" data-parsley-required="true" class="form-control" id="users-old-password" value="">
            </div>
            <div class="form-group">
                <label for="l_domain" class="req">New Password</label>
                <input type="password" data-parsley-required="true" class="form-control" id="users-new-password" value="">
            </div>
            <div class="form-group">
                <label for="login_password" class="req">Confirm Password</label>
                <input type="password" data-parsley-type="User Name" class="form-control" id="users-confirm-password" value="">
            </div>
            <div id="user-state"></div>
            <div class="submit_section">
                <button class="btn btn-lg btn-success btn-block " id="btn-reset" onclick="updatePassword();">Update</button>
            </div>
        </form>
    </div>

    <!-- jQuery -->
    <script src="assets/js/jquery.min.js"></script>
    <!-- bootstrap js plugins -->
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    {literal}
        <script>
            function updatePassword() {
                var data = {};
                data.oldpassword = $('#users-old-password').val().trim();
                data.newpassword = $('#users-new-password').val().trim();

                $('#user-state').removeClass('alert').addClass('alert');
                $('#user-state').html('');
                $('#users-new-password, #users-confirm-password, #users-old-password').removeClass('inp_error');
                var err = 0;

                if ($('#users-old-password').val() == '') {
                    $('#users-old-password').addClass('inp_error');
                    err++;
                }

                if ($('#users-new-password').val() == '') {
                    $('#users-new-password').addClass('inp_error');
                    err++;
                }

                if ($('#users-confirm-password').val() == '') {
                    $('#users-confirm-password').addClass('inp_error');
                    err++;
                }

                if (err > 0) {
                    $('#user-state').removeClass('alert-success').addClass('alert-danger');
                    $('#user-state').html('Please fillout the necessary fields.');
                    return false;
                }

                if ($('#users-new-password').val() != $('#users-confirm-password').val()) {
                    $('#users-new-password, #users-confirm-password').addClass('inp_error');
                    $('#user-state').removeClass('alert-success').addClass('alert-danger');
                    $('#user-state').html('password mismatch');
                    return false;
                }

                $('#user-submit').addClass('disabled');
                $('#user-state').removeClass('alert-success').addClass('alert-danger');
                $('#user-state').html('Authenticating...');
                $('#user-state').show();
                $.ajax({
                    type: "POST",
                    url: base_url + "auth/update-user-password",
                    data: data,
                    dataType: "json",
                    success: function(res) {
                        if (res.status == 1) {
                            $('#user-state').addClass('alert-success').removeClass('alert-danger');
                            $('#user-state').html('Password Updated. ...');
                            window.setTimeout(function() {
                                $("#pwd-reset-modal").modal('hide');
                                window.location.href = base_url;
                                return;
                            }, 2000);
                        } else {
                            $('#user-state').removeClass('alert-success').addClass('alert-danger');
                            $('#user-state').html('Sorry! Password Updation Failed.');
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