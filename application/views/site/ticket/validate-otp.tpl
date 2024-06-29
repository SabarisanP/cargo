<div class="brand_top"><h3>Validate OTP</h3> </div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">

                                        <div id="search-panel" >                                         
                                            <div class="divide-10"></div>
                                            <form id="validate-otp-form" onsubmit="return false;">
                                                <div class="form-group col-md-2">
                                                    <label class="sr-only" for="mobile-no">Mobile Number</label>
                                                    <div class="input-group col-md-12">
                                                        <input type="text" name="mobile" class="form-control numeric" id="mobile-no" placeholder="Mobile Number" minlength="10" maxlength="10">
                                                    </div>
                                                </div>                                                    
                                                <button class="btn btn-success" type="button" onclick="searchTicketDetails();">Get Ticket</button>
                                                <button type="button" class="btn btn-default" onclick="clearTicket();">Clear</button>
                                            </form>
                                            <br>
                                            <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px;float:left" id="validate-otp-action-state"></div>
                                        </div>                                               
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="validate-otp-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="validate-otp-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div> 
                </div>                    
            </div>                
        </div>
    </div>        
</div>
    
<script>
    $('#mobile-no').focus();
    $(document).on("input", ".numeric", function() {
        this.value = this.value.replace(/\D/g,'');
    });
    
    function searchTicketDetails() {
        var data = {};
        data.mobile = $('#mobile-no').val();

        var err = 0;
        if (data.mobile == '') {
            $('#mobile-no').addClass('inp_error');
            err++;
        } else {
            $('#mobile-no').removeClass('inp_error');
        }
        if (err > 0) {
            $('#validate-otp-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#validate-otp-action-state').html('Please enter values to search');
            $('#validate-otp-action-state').show();
            return false;
        } else {
            $('#validate-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#validate-otp-action-state').html('');
            $('#validate-otp-action-state').hide();
        }

        $('#validate-otp-list-container').removeClass('hidden');
        $('#validate-otp-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "ticket/validate-otp-list",
            data: data,
            success: function (response) {
                if (response != '') {
                    $('#validate-otp-list').html(response);
                }
            }
        });
    }
    
    function clearTicket() {
        $('#validate-otp-action-state').html('');
        $('#validate-otp-action-state').hide();
        $('#mobile-no').val('');
        $('#validate-otp-list-container').addClass('hidden');
        $('#validate-otp-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#mobile-no').focus();
    }
    
    function sendPNROTP(pnr) {
        $('#validate-otp-dialog').removeClass('hide');
        $('#validate-otp-dialog').dialog({
            autoOpen: true,
            height: 250,
            width: 500,
            modal: true,
            resizable: false,
            close: function( event, ui ) {
                $('#check-otp-action-state').hide();
                $('form#validate-otp').addClass('hide');
                $('#valid-otp').removeClass('inp_error').val('');
                $('#down-mini-pdf').addClass('hide');
            }
        });
        $(".ui-dialog-titlebar").hide();
        
        $('#send-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#send-otp-action-state').addClass('text-center').html(loading_big);
        $('#send-otp-action-state').show();        
        $('#hid-validate-pnr').val(pnr);
        
        var data = {};
        data.pnr = pnr;
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "ticket/send-pnr-otp",
            data: data,
            success: function (response) {
                if(response.status == 1) {
                    $('#send-otp-action-state').addClass('alert-success').removeClass('alert-danger');
                    $('#send-otp-action-state').html('OTP sent successfully.');
                    window.setTimeout(function() {
                        $('#send-otp-action-state').hide();       
                        $('form#validate-otp').removeClass('hide');
                        $('#valid-otp').focus();
                    }, 2000);
                } else {
                    $('#send-otp-action-state').addClass('alert-danger').removeClass('alert-success');
                    $('#send-otp-action-state').html(response.errorDesc);
                    window.setTimeout(function() {
                        closeValidateOTPDialog();
                    }, 2000);
                }
            }
        });
    }
    
    function validatePNROTP(){
        var data = {};
        data.pnr = $('#hid-validate-pnr').val();
        data.otp = $('#valid-otp').val();
        
        var err = 0;
        if (data.otp == '') {
            $('#valid-otp').addClass('inp_error');
            err++;
        } else {
            $('#valid-otp').removeClass('inp_error');
        }
        if (err > 0) {
            $('#check-otp-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#check-otp-action-state').html('Please enter the values in the field that are marked in red');
            $('#check-otp-action-state').show();
            return false;
        }
        
        $('#check-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#check-otp-action-state').addClass('text-center').html(loading_small);
        $('#check-otp-action-state').show();
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "ticket/validate-pnr-otp",
            data: data,
            success: function (response) {
                if(response.status == 1) {
                    $('#check-otp-action-state').addClass('alert-success').removeClass('alert-danger');
                    $('#check-otp-action-state').html('OTP is Valid.');
                    $('form#validate-otp').addClass('hide');
                    $('#down-mini-pdf').removeClass('hide');
                    window.setTimeout(function() {
                        $('#check-otp-action-state').hide();
                    }, 2000);
                } else {
                    $('#check-otp-action-state').addClass('alert-danger').removeClass('alert-success');
                    $('#check-otp-action-state').html(response.errorDesc);
                }
            }
        });
    }
    
    function closeValidateOTPDialog(){
        $('#validate-otp-dialog').dialog('close');
        $('#validate-otp-dialog').hide();
    }
</script>