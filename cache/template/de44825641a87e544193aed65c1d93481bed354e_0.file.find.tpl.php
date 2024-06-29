<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-01 10:54:46
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\find.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665ab09e307ac2_92393999',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'de44825641a87e544193aed65c1d93481bed354e' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\find.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665ab09e307ac2_92393999 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top"><h3>Find <?php echo lang('lr');?>
</h3> </div>
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
                                            
                                            <div id="search-panel" class="well well-sm" >
                                                <form id='findLR' name="find_lr" method="get" action="" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="col-md-2">
                                                            <label class="sr-only">Enter <?php echo lang('lr');?>
</label>
                                                            <div class="position-relative"> 
                                                                <input type="text" name="LR" class="form-control sdate input_capital" id="lr"  placeholder="Enter <?php echo lang('lr');?>
">
                                                                <span class="qr-scan-addon css-tooltip" onclick="scanQRCode('#lr')" data-tooltip="Scan QR Code"><i class="fa fa-qrcode fa-2x"></i></span>
                                                            </div>
                                                        </div> 
                                                        
                                                        <div class="col-md-10">
                                                            <button class="btn btn-success" type="button" onclick="getLRDetails();">Get Details</button>
                                                            <button class="btn btn-success" type="button" onclick="smsLRDetails();">Send SMS</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearLR();">Clear</button>
                                                        </div>
                                                    </div>
                                                </form>                                                
                                            </div>
                                                            
                                            <div class="align-center alert alert-danger pull-left" style="display:none;float:left" id="lr-action-state"></div>
                                            
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
        <?php echo '<script'; ?>
>
            $(document).ready(function() {
                $('#lr').focus();
            });
            $(".input_capital").bind("input", function (e) {
                this.value = this.value.replace(/[^0-9a-zA-Z-]+/g, '').toUpperCase();
            });
            function clearLR() {
                $('#lr').val('');
                $('#rpt_lsts').html('');
                $('.inp_error').removeClass('inp_error');
                $('#lr-action-state').hide();
                $('#lr').focus();
            }
            function getLRDetails() {
                var err = 0;
                if ($.trim($('#lr').val()) == '') {
                    $('#lr').addClass('inp_error');
                    err++;
                } else {
                    $('#lr').removeClass('inp_error');
                }
                if (err > 0) {
                    $('#lr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#lr-action-state').html('Please enter valid LR code');
                    $('#lr-action-state').show();
                    return false;
                } else {
                    $('#lr-action-state').removeClass('alert-success').removeClass('alert-danger');
                    $('#lr-action-state').html('');
                    $('#lr-action-state').hide();
                }
                getCargoDetails($('#lr').val());
            }
            function smsLRDetails(){
                var data = {};
                data.cargoCode = $.trim($('#lr').val());
                var err = 0;
                if (data.cargoCode == '') {
                    $('#lr').addClass('inp_error');
                    err++;
                } else {
                    $('#lr').removeClass('inp_error');
                }
                if (err > 0) {
                    $('#lr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#lr-action-state').html('Please enter valid LR code');
                    $('#lr-action-state').show();
                    return false;
                } else {
                    $('#lr-action-state').removeClass('alert-success').removeClass('alert-danger');
                    $('#lr-action-state').html('');
                    $('#lr-action-state').hide();
                }
                $.ajax({
                    type: "POST",
                    url: base_url+"cargo/sms-lr-details",
                    data: data,
                    dataType: 'json',
                    success: function(response) {
                        if(response.status == 1){
                            $('#lr-action-state').addClass('alert-success').removeClass('alert-danger');
                            $('#lr-action-state').html('SMS sent sucessfully');
                            $('#lr-action-state').show();
                        } else {
                            $('#lr-action-state').removeClass('alert-success').addClass('alert-danger');
                            $('#lr-action-state').html(response.errorDesc);
                            $('#lr-action-state').show();
                        }
                        window.setTimeout(function () { 
                            if(response.status == 1){
                                $('#lr').val('');
                            }
                            $('#lr-action-state').hide();
                        }, 3000);
                    }
                });
            }
            $('#findLR #lr').keypress(function(event) {
                if (event.keyCode == 13) {
                    getLRDetails();
                }
            });
        <?php echo '</script'; ?>
>
    
<?php }
}
