<div class="brand_top"><h3>Cancel Ticket</h3> </div>
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
                                            <div>
                                                <div id="search-panel" >                                         
                                                    <div class="divide-10"></div>
                                                    <form id='test' onsubmit="return false;">

                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_from">Enter PNR</label>
                                                            <div class="input-group">
                                                                <input type="text" name="pnr" class="form-control sdate input_capital" id="pnr"  placeholder="Enter PNR">

                                                            </div>
                                                        </div>

                                                        <button class="btn btn-success cn_tck" type="button" onclick="searchTicket();">Get Details</button>
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearTicket();">Clear</button>

                                                    </form>
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px;float:left" id="prt-action-state"></div>
                                                </div>
                                            </div>   
                                        <input type="hidden" id="type" value="CAN">
                                        <input type='hidden' value='{$smarty.get.v}' id='tck_val'>
                                        <div id='load'></div><div id="rpt_lsts"></div>        
                                        <!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div></div></div>
    </div>

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
                data.type = $('#type').val();

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

                $('#load').html(loading_popup);
                $('#rpt_lsts').html('');
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "search/cancel-ticket",
                    data: data,
                    success: function (response) {

                        if (response != '') {
                            $('#load').html('');
                            $('#rpt_lsts').html(response);
                            $('#cancel_flg').bootstrapSwitch('size', 'mini');
                            $('#amount').focus();

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
            }

            $('#test #pnr').on('keyup',function(event) {
                if (event.keyCode == 13) {
                    searchTicket();
                }
            });


        </script>
    {/literal}
