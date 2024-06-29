<div class="brand_top"><h3>Print Ticket</h3> </div>
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
                                        {if $action_rights['PRINT-TCK']>0}
                                            
                                            <div id="search-panel" class="well well-sm" >
                                                <form id='prt_tick' name="prt_tick" method="get" action="search/print-ticket" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="col-md-2">
                                                            <label class="sr-only" for="date_from">Enter PNR</label>
                                                            <div class="input-group">
                                                                <input type="text" name="pnr" class="form-control sdate input_capital" id="pnr" placeholder="Enter PNR">
                                                            </div>
                                                        </div> 
                                                        
                                                        <div class="col-md-10 text-center">
                                                            <div class="pull-left">
                                                                <button class="btn btn-success" type="button"  {if $action_rights['PRINT-TCK']==1} onclick="searchTicket();"{/if}>Get Ticket</button>
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTicket();">Clear</button>
                                                                <input type="hidden" id="export" name="export" value="" />
                                                            </div>
                                                                
                                                            <div id="ticket-status-label" class="d-inline-block"></div>
                                                            
                                                            <div id="notify-options" class="pull-right hide col-md-6">
                                                                <div class="row text-right">
                                                                    <div class="btn-group">
                                                                        <button type="button" id="action-btn-dd" class="btn btn-info">-Select-</button>
                                                                        <button type="button" style="height:36px;" class="btn btn-info dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                          <span class="sr-only">Toggle Dropdown</span>
                                                                          <span class="caret"></span>
                                                                        </button>
                                                                        <ul class="dropdown-menu text-left" id="send-details-dd">
                                                                            <li class="dropdown-header"><b><i class="fa fa-large fa-mobile" aria-hidden="true"></i>&emsp;SMS</b></li>
                                                                            <li><a href="javascript:;" id="tkt-sms-opt-1" onclick="getDetails('SMSTD',this);"><span class="hide">SMS : </span>Ticket Details</a></li>
                                                                            <li><a href="javascript:;" onclick="getDetails('RSNDGPSHJ',this);"><span class="hide">SMS : </span>Driver Contact / GPS Tracking</a></li>
                                                                            <li class="divider" role="seperator"></li>
                                                                            <li class="dropdown-header"><b><i class="fa fa-lg fa-whatsapp" aria-hidden="true"></i>&emsp;WhatsApp</b></li>
                                                                            <li><a href="javascript:;" onclick="getDetails('WATD', this);" data-notify-type="TICKET"><span class="hide">WhatsApp : </span>Ticket Details</a></li>
                                                                            <li><a href="javascript:;" onclick="getDetails('WADC', this);" data-notify-type="RSNDGPSHJ"><span class="hide">WhatsApp : </span>Driver Contact / GPS Tracking</a></li>
                                                                            <li class="divider" role="seperator"></li>
                                                                            <li class="dropdown-header"><b><i class="fa fa-md fa-envelope-o" aria-hidden="true"></i>&emsp;E-mail</b></li>
                                                                            <li><a href="javascript:;" onclick="getDetails('MAIL',this);"><span class="hide">E-mail : </span>Ticket Details</a></li>
                                                                            <li><a href="javascript:;" onclick="getDetails('MAILINVOICE',this);"><span class="hide">E-mail : </span>GST Invoice</a></li>
                                                                        </ul>
                                                                        <input type="text" class="form-control" style="width:200px;" id="toContact" name="toContact">
                                                                    </div>
                                                                    <button class="btn btn-success" type="button" id="tkt-sendDetails">Send</button>    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>                                                
                                            </div>
                                                            
                                            <div class="align-center alert alert-danger pull-right" style="display:none;margin-left:15px;float:left" id="prt-action-state"></div>
                                            
                                        {/if}
                                        <div id='load'></div><div id="rpt_lsts"></div>        
                                        <!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br/><br/><br/>                                    
    </div>
    <input type='hidden' value='{$smarty.get.v}' id='tck_val'>
    <iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>
    {literal}
        <script>
            $('#pnr').focus();
            
            if ($('#tck_val').val() != '') {
                $('#pnr').val($('#tck_val').val());
                searchTicket();
            }

            function searchTicket() {

                var pnr = $.trim($('#pnr').val());


                var data = {};
                data.ticketpnrcode = pnr;
                data.print = 1;
                var err = 0;
                if (data.ticketpnrcode.length < 6) {
                    $('#pnr').addClass('inp_error');
                    err++;
                } else {
                    $('#pnr').removeClass('inp_error');
                }
                if (err > 0) {
                    $('#prt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#prt-action-state').html('Please enter valid PNR code');
                    $('#prt-action-state').show();
                    return false;
                } else {
                    $('#prt-action-state').removeClass('alert-success').removeClass('alert-danger');
                    $('#prt-action-state').html('');
                    $('#prt-action-state').hide();
                }
                $('#notify-options').addClass('hide');
                $('#ticket-status-label').html('');

                $('#load').html(loading_popup);
                $('#rpt_lsts').html('');
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "search/print-ticket",
                    data: data,
                    success: function (response) {

                        if (response != '') {
                            $('#load').html('');
                            $('#rpt_lsts').html(response);

                        }
                    }
                })


            }
            $(".input_capital").bind("input", function (e) {
                this.value = this.value.toUpperCase();
            });

            function clearTicket() {

                $('#pnr').val('');
                $('#rpt_lsts').html('');
                $('.inp_error').removeClass('inp_error');
                $('#prt-action-state').hide();
                $('#pnr').focus();
                $('#notify-options').addClass('hide');
                $('#toContact').val('');
                $('#ticket-status-label').html('');
            }
            function GetPdf() {
                document.prt_tick.target = "ifrm_downloader";
                $('#export').val(1);
                document.prt_tick.submit();
                return;
            }
            
            function smsTicket(type) {
                var pnr = $.trim($('#pnr').val());
                var data = {};
                data.ticketpnrcode = pnr;
                data.mobile = $('#toContact').val();
                data.type = type;
                data.tripCode = $('#sms-trip-code').val();
                var err = 0;
                if(data.mobile == '' || !isValidPhonenumber(data.mobile)) {
                     $('#toContact').addClass('inp_error');
                     err++;
                } else {
                    $('#toContact').removeClass('inp_error');
                }
                
                if (data.ticketpnrcode.length < 6) {
                    $('#pnr').addClass('inp_error');
                    err++;
                } else {
                    $('#pnr').removeClass('inp_error');
                }
                if (err > 0) {
                    $('#prt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#prt-action-state').html('Please enter valid Mobile Number');
                    $('#prt-action-state').show();
                    return false;
                } else {
                    $('#prt-action-state').removeClass('alert-success').removeClass('alert-danger');
                    $('#prt-action-state').html('');
                    $('#prt-action-state').hide();
                }
                
                var eventaction = (type=='SMSTD') ? 'SMS Ticket': 'SMS Tracking';
                ga_track_event('Ticket', eventaction, "");
                
                $('#prt-action-state').show();
                $('#prt-action-state').html(loading_popup);
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "search/sms-ticket",
                    data: data,
                    success: function (res) {
                        if (res.status == 1) {
                            $('#prt-action-state').addClass('alert-success').removeClass('alert-danger');
                            $('#prt-action-state').html('SMS has been sent successfully');
                            setTimeout(function () {
                                $('#prt-action-state').html('');
                                $('#prt-action-state').hide();
                            }, 3000);
                        } else {
                            $('#prt-action-state').removeClass('alert-success').addClass('alert-danger');
                            $('#prt-action-state').html(res.errorDesc);
                            setTimeout(function () {
                                $('#prt-action-state').html('');
                                $('#prt-action-state').hide();
                            }, 3000);
                        }
                    }
                })
            }
            
            $('#prt_tick #pnr').on('keyup', function(event) {
                if (event.keyCode == 13) {
                    searchTicket();
                }
            });

        </script>
    {/literal}
