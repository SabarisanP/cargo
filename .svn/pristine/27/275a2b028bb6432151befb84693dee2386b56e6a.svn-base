<div class="brand_top">
    <h3>Additional Revenue Report</h3> 
    <div class="text-right noprint" id="export-additional-revenue" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportAdditionalRevenue();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div> 
</div>
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
                                            <form id="additional_revenue_form" name="additional_revenue_form" method="post" onsubmit="return false;">
                                            <div class="row">   
                                                <div class="form-group col-md-2">
                                                    <label for="additional_revenue_from">From Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="from" class="form-control sdate" id="additional_revenue_from" readonly="true" placeholder="Date From">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="additional_revenue_to">To Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="to" class="form-control sdate" id="additional_revenue_to" readonly="true" placeholder="Date To">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>  
                                                <div class="form-group col-md-2">
                                                    <label for="cons_rpt_date_to">Filter Option</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="additional_revenue_tkt_fil" name="ticket_filter"  class="form-control" >  
                                                            <option value="CANCELBOOK">Cancel Re-Booking</option>
                                                            <option value="TRAVELSTATUS">Not Travels Re-Booking</option>                                                                                                                     
                                                        </select>       
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="getAdditionalRevenue()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearAdditionalRevenue()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="additional_revenue_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="additional-revenue-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="additional-revenue-list"></div>                                    
                            </div>
                        </div>
                    </div>
                </div>

            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_trip_cancellation" id="ifrm_trip_cancellation" style="display:none"></iframe>           

{literal}
    <script>
        $('#additional_revenue_from').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#additional_revenue_to').datepicker('setStartDate', e.date);
            $("#additional_revenue_to").datepicker("setEndDate", end)
        });
        $('#additional_revenue_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#additional_revenue_from').datepicker('setStartDate', start);
            $('#additional_revenue_from').datepicker('setEndDate', e.date)
        });

        function getAdditionalRevenue() {
            $('#additional-revenue-list').html('');
            var data = {};
            data.from = $('#additional_revenue_from').val();
            data.to = $('#additional_revenue_to').val();
            data.ticket_filter = $('#additional_revenue_tkt_fil').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.from == '') {
                $('#additional_revenue_from').addClass('inp_error');
                err++;
            }
            
            if (data.to == '') {
                $('#additional_revenue_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#additional_revenue_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#additional_revenue_state').html('Please enter/select the values in the field that are marked in red');
                $('#additional_revenue_state').show();
                return false;
            } else {
                $('#additional_revenue_state').removeClass('alert-success').removeClass('alert-danger');
                $('#additional_revenue_state').html('');
                $('#additional_revenue_state').hide();
            }
            $('#additional-revenue-list-container').removeClass('hidden');
            $('#additional-revenue-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/additional-revenue-report-list",
                data: data,
                success: function (response) {
                    $('#additional-revenue-list').html(response);
                    $('#export-additional-revenue').show();
                }
            });
        }
        
        function clearAdditionalRevenue() {
            $('#additional_revenue_from').val('');
            $('#additional_revenue_to').val('');
            $('#additional_revenue_tkt_fil').val(1);
            $('#additional-revenue-list-container').addClass('hidden');
            $('#additional-revenue-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#additional_revenue_state').removeClass('alert-success').removeClass('alert-danger');
            $('#additional_revenue_state').html('');
            $('#additional_revenue_state').hide();
            $('#export-additional-revenue').hide();
        }

        function exportAdditionalRevenue() {    
            document.additional_revenue_form.action = "report/additional-revenue-report-list";
            document.additional_revenue_form.target = "ifrm_trip_cancellation";
            $('#export').val(1);
            document.additional_revenue_form.submit();
            return;
        }
    </script>
{/literal}