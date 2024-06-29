<div class="brand_top">
    <h3>Frequent Customer Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportFrequentCustomerExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
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

                                                <form id='cancel_rpt' method="post" name="cancel_rpt" action="report/frequent-customer-report-list" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="fcr_date_from">DOJ From</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from" class="form-control sdate" id="fcr_date_from" readonly="true" placeholder="DOJ From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="fcr_date_to">DOJ To</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to" class="form-control sdate" id="fcr_date_to" readonly="true" placeholder="DOJ To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>   

                                                        <div class="form-group col-md-2">
                                                            <label  for="fcr_customer_type">Customer type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="fcr_customer_type" name="customerType"  class="form-control" onchange="countBox();">
                                                                    <option value='NEWCUST' selected="">New</option>
                                                                    <option value="FREQCUST">Frequent</option>
                                                                </select>       
                                                            </div>
                                                        </div>

                                                    </div>


                                                    <div class="row">          

                                                        <div class="form-group col-md-2 hidden" id="fcr_count_div">
                                                            <label  for="fcr_date_to"># More Time Travelled</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="number" id="fcr_count" name="count"  class="form-control" />                                                                      
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label  for="fcr_from_station">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="fcr_from_station" name="from_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="fcr_to_station">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="fcr_to_station" name="to_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>


                                                        <div class="form-group col-md-2">
                                                            <label>&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="searchFrequentCustomers();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearFrequentCustomers();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="frc_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="fcr-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="fcr-customer-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_frqcust_downloader" id="ifrm_frqcust_downloader" style="display:none"></iframe>  


{literal}
    <script>
        $('#fcr_date_from').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 93));
            $('#fcr_date_to').datepicker('setStartDate', e.date);
            $("#fcr_date_to").datepicker("setEndDate", end)
        });
        $('#fcr_date_to').datepicker({
            todayHighlight: true,
            startDate: '-3m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            $('#fcr_date_from').datepicker('setStartDate', start);
            $('#fcr_date_from').datepicker('setEndDate', e.date)
        });

        function countBox() {
            if ($('#fcr_customer_type').val() == 'NEWCUST') {
                $('#fcr_count_div').addClass('hidden');
                $('#fcr_count').val('');

            } else {
                $('#fcr_count_div').removeClass('hidden');
            }
        }

//
        function exportFrequentCustomerExcel() {
            document.cancel_rpt.target = "ifrm_frqcust_downloader";
            $('#export').val(1);
            document.cancel_rpt.submit();
            return;
        }

        function searchFrequentCustomers() {
            $('#fcr-customer-list').html('');
            var data = {};
            data.from = $('#fcr_date_from').val();
            data.to = $('#fcr_date_to').val();
            data.from_code = $('#fcr_from_station').val();
            data.to_code = $('#fcr_to_station').val();
            data.count = $('#fcr_count').val();
            data.customerType = $('#fcr_customer_type').val();

            var err = 0;
            $('#fcr_date_from, #fcr_date_to, #fcr_count, #fcr_customer_type').removeClass('inp_error');

            if (data.from == '') {
                $('#fcr_date_from').addClass('inp_error');
                err++;
            }

            if (data.customerType == '') {
                $('#fcr_customer_type').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                if (data.to == '') {
                    $('#fcr_date_to').addClass('inp_error');
                    err++;
                }
            }

            if ($('#fcr_customer_type').val() == 'FREQCUST') {
                if (isNaN(data.count)) {
                    $('#fcr_count').addClass('inp_error');
                    err++;
                } else if (Number(data.count) <= 1) {
                    $('#fcr_count').addClass('inp_error');
                    err++;
                }
            }
            else{
                data.count = "";
                $('#fcr_count').val('');
            }
            if (data.from != '') {
                if (data.to == '') {
                    $('#fcr_date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to = output;
                    $('#fcr_date_to').val(output);
                }
            }

            if (err > 0) {
                $('#frc_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#frc_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#frc_rpt_action_state').show();
                return false;
            } else {
                $('#frc_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#frc_rpt_action_state').html('');
                $('#frc_rpt_action_state').hide();
            }
            var html = "";
            $('#fcr_date_to').removeClass('inp_error');
            $('#fcr-list-container').removeClass('hidden');
            $('#fcr-customer-list').html(loading_popup);
            $('#cancel-booking-graph1').html('')
            $('#fcr-customer-list-graph').addClass('hidden');
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/frequent-customer-report-list",
                data: data,
                success: function (response) {
                    $('#fcr-customer-list').html(response);
                    $('#excl_cons').show();
                }
            })
        }

        function clearFrequentCustomers() {
            $('#fcr_date_from').val('');
            $('#fcr_date_to').val('');
            $('#fcr-list-container').addClass('hidden');
            $('#fcr-customer-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#frc_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#frc_rpt_action_state').html('');
            $('#frc_rpt_action_state').hide();
            $('#cancel_rpt_schedule').val('NA');
            $('#fcr_from_station').val('NA');
            $('#fcr_to_station').val('NA');
            $('#fcr_count').val('');
            $('#cancel_rpt_date_opt').val(2);
            $('#excl_cons').hide();
            $('#fcr_customer_type').val('');
        }
    </script>
{/literal}
