<div class="brand_top">
    <h3>Find / Delivery / Update Cargo Bookings</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
{*            <button class="btn btn-default" onclick="exportBookingsPdf();"><i class="fa fa-download fa-lg"></i>Pdf</button>*}
            <button class="btn btn-default" onclick="exportBookingsExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">                        
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">                                        
                                        <div class="">
                                            <div id="search-panel">                                         

                                                <form id='con_bk_rpt' method="post" name="con_bk_rpt" action="cargo/find-bookings-list" onsubmit="return false;">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="trns_rpt_date_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="trns_rpt_date_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="trns_rpt_date_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="trns_rpt_date_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div> 

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">Cargo Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_cargo_status" name="cargoStatus"  class="form-control" >
                                                                    <option value='NA' selected="">All Status</option>
                                                                    {foreach name=o item=statusname from=$cargo_status key=code}                                                                        
                                                                        <option  value="{$code}">{$statusname}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="cargo_pay_status">Cargo Payment Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_pay_status" name="payStatus"  class="form-control" >
                                                                    <option value='NA' selected="">All Status</option>
                                                                    {foreach name=o item=statusname from=$cargo_payment_status key=code}                                                                        
                                                                        <option  value="{$code}">{$statusname}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>         

                                                    </div>

                                                    <div class="row">                                                      

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_from_station" name="fromStation"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="trns_rpt_to_station" name="toStation"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div> 

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">From Branch</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="fromOrganizationCode" name="fromOrganizationCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Branch</option>
                                                                    {foreach item=branch from=$branches key=bcode}
                                                                        <option value="{$bcode}">{$branch}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">To Branch</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="toOrganizationCode" name="toOrganizationCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Branch</option>
                                                                    {foreach item=branch from=$branches key=bcode}
                                                                        <option value="{$bcode}">{$branch}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>


                                                    </div>

                                                    <div class="row">                                                      

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">From Customer Mobile</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" class="form-control" id="fromMobileNumber" name="fromMobileNumber" placeholder="{lang('booking_sender_term')} Mobile" value="" maxlength="10"/>     
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">To Customer Mobile</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" class="form-control" id="toMobileNumber" name="toMobileNumber" placeholder="{lang('booking_receiver_term')} Mobile" value="" maxlength="10"/>     
                                                            </div>
                                                        </div> 

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">{lang('cargo_code_term')}</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" class="form-control" id="cargoCode" name="cargoCode" placeholder="{lang('cargo_code_term')}" value="" style="text-transform:uppercase" />     
                                                            </div>
                                                        </div>

                                                        <div class="more-filters hide">
                                                            <div class="form-group col-md-2">
                                                                <label for="trns_rpt_vendor_users">Vendor</label>
                                                                <select id="trns_rpt_vendor_users" class="form-control">   
                                                                    <option value="NA">Select Vendor</option>
                                                                    {foreach item=vendor_usr from=$vendors} 
                                                                        <option value="{$vendor_usr->code}">{$vendor_usr->companyName}</option> 
                                                                    {/foreach}
                                                                </select>     
                                                            </div>                  

                                                            <br class="clear_fix_both">

                                                            <div class="form-group col-md-2">
                                                                <label  for="CustomerName">Customer Name</label>
                                                                <div class="input-group col-md-12">
                                                                    <input type="text" class="form-control" id="customerName" name="customerName" placeholder="Customer Name" value=""/>     
                                                                </div>
                                                            </div>
                                                        </div> 

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button" id="generate-report-btn" onclick="findCargoBooking();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearFindCargoBooking();">Clear</button>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </form> 
                                            </div>
                                            <a id="more-filter-btn" class="btn-link noprint" onclick="toggleFilterRows()">More Filters</a>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="find_cargo_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="find-cargo-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="find-cargo-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe> 

{literal}
    <script>
        $('#trns_rpt_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#trns_rpt_date_to').datepicker('setStartDate', e.date);
            $("#trns_rpt_date_to").datepicker("setEndDate", end)
        });
        $('#trns_rpt_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#trns_rpt_date_from').datepicker('setEndDate', e.date)
        });
        
        function findCargoBooking() {
            $('#find-cargo-list').html('');
            var data = {};
            data.fromDate = $('#trns_rpt_date_from').val();
            data.toDate = $('#trns_rpt_date_to').val();
            data.cargoStatus = $('#trns_rpt_cargo_status').val();
            data.payStatus = $('#trns_rpt_pay_status').val();
            data.fromStation = $('#trns_rpt_from_station').val();
            data.toStation = $('#trns_rpt_to_station').val();
            data.fromOrganizationCode = $('#fromOrganizationCode').val();
            data.toOrganizationCode = $('#toOrganizationCode').val();
            data.fromMobileNumber = $('#fromMobileNumber').val();
            data.toMobileNumber = $('#toMobileNumber').val();
            data.cargoCode = $('#cargoCode').val();
            data.vendorUserCode = $('#trns_rpt_vendor_users').val();
            data.customerName = $.trim($('#customerName').val());

            var err = 0;
            $('#trns_rpt_date_from, #trns_rpt_date_to').removeClass('inp_error');

            if (!data.cargoCode) {
                var valid = 0;
                $.each(data, function (i, val) {
                    if (isNotNull(val)) valid++;
                });

                if (valid < 1) {
                    $('#find_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#find_cargo_action_state').html('Please enter/select any one of the filter');
                    $('#find_cargo_action_state').show();
                    return false;
                }
            }

            if (data.customerName != '' && data.customerName.length < 3) {
                $('#customerName').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#find_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#find_cargo_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#find_cargo_action_state').show();
                return false;
            } else {
                $('#find_cargo_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#find_cargo_action_state').html('');
                $('#find_cargo_action_state').hide();
            }
            var html = "";
            $('#trns_rpt_date_to').removeClass('inp_error');
            $('#find-cargo-list-container ').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#find-cargo-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/find-bookings-list",
                data: data,
                success: function (response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#find-cargo-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#find-cargo-list-container ').offset().top - 35
                    }, "slow");
                }
            })
        }


        function clearFindCargoBooking() {
            $('#trns_rpt_date_from').val('').trigger('change');
            $('#trns_rpt_date_to').val('').trigger('change');
            $('#find-cargo-list-container ').addClass('hidden');
            $('#find-cargo-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#find_cargo_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#find_cargo_action_state').html('');
            $('#find_cargo_action_state').hide();

            $('#trns_rpt_from_station').val('NA');
            $('#trns_rpt_to_station').val('NA');
            $('#trns_rpt_pay_status').val('NA');
            $('#trns_rpt_cargo_status').val('NA');
            $('#fromOrganizationCode').val('NA');
            $('#toOrganizationCode').val('NA');
            $('#fromMobileNumber').val('');
            $('#toMobileNumber').val('');
            $('#cargoCode').val('');
            $('#trns_rpt_vendor_users').val('NA');
            $('#customerName').val('');

            $('#excl_cons').hide();
        }

        function selectFindItmes(st) {
            $('input[type=checkbox]').each(function() {
                $(this).prop('checked', false);
            });

            $('input[class='+st+']').each(function() {
                $(this).prop('checked', true);
            });
            activateActionButtons();
        }

        function activateActionButtons() {
            $('#state-action').html('');
            var pst = '';
            var cst = '';
            var diff = false;
            $('#btn-unload, #btn-delivered, #btn-undeliver, #btn-paid, #btn-return').hide();
            if( $('input[type=checkbox]:checked').length > 0 ) {                
                $('input[type=checkbox]:checked').each( function() {
                    cst = $(this).attr('class');
                    if(pst!='' && cst!=pst && !diff) diff = true;                    
                    pst = cst;
                } );
            }
            if(!diff){
                if(pst=='CB') {
                    $('#btn-delivered, #btn-undeliver').show();
                } else if(pst=='CL') {
                    $('#btn-unload').show();
                } else if(pst=='CUL') {
                    $('#btn-delivered, #btn-undeliver').show();
                } else if(pst=='CUD') {
                    $('#btn-return').show();
                }
            }
        }
        function changeArticleStatus(state) {
            $('#state-action').html('');
            var lrcode = [];
            $('input[type=checkbox]:checked').each( function() {
                lrcode.push( $(this).val() );
            } );
            if(lrcode.length<=0) {
                $('#state-action').html('<span class="alert alert-danger">Please select atleast 1 item to proceed</span>');
                return false;
            }

            var data = {};
            data.state = state;
            data.codes = lrcode;
            //$('#btn-unload, #btn-delivered, #btn-undeliver, #btn-paid, #btn-return').hide();
            $('#state-action').html(loading_small);
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-booking-status",
                data: data,
                success: function (res) {
                    if(res.status==1) {
                        $('#state-action').html('<span class="alert alert-success">Your request processed successfully</span>');
                       window.setTimeout(function() {
                            $('#state-action').html('');
                            findCargoBooking();
                        }, 2000);
                    } else {
                        $('#state-action').html('<span class="alert alert-danger">'+res.errorDesc+'</span>');
                    }
                }
            })
        }

        function chagePaymentStatus(code) {
            if(confirm('Do you want to change the status to "paid"')) {
                var data = {};
                data.codes = code;
                $('#pay_state_'+code).html(loading_small);
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "cargo/update-payment-status",
                    data: data,
                    success: function (res) {
                        if(res.status==1) {
                           $('#pay_state_'+code).html('Paid');                           
                        } else {
                            alert(res.errorDesc);
                        }
                    }
                });
            }
        }

        function exportBookingsExcel() {
            $('#export').val(1);
            document.con_bk_rpt.target = "ifrm_downloader";
            document.con_bk_rpt.submit();
            return;
        }
        /*function exportBookingsPdf() {
            //document.pays_form.target = "ifrm_pays_downloader";
            document.con_bk_rpt.action = "cargo/find-bookings-list?r="+Math.random();
        $('#pdf').val('');    
        $('#export').val('');
            $('#pdf').val(2);
            document.con_bk_rpt.submit();
            return;
        }*/

        function toggleFilterRows() {
            $('.more-filters').toggleClass('hide');
            $('#more-filter-btn').hide();
        }

        $('#con_bk_rpt input').keypress(function (event) {
            if (event.keyCode == 13) {
                findCargoBooking();
            }
        });
    </script>
{/literal}
