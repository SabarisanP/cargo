<div class="brand_top">
    <h3>Trip Cancellation Report</h3> 
    <div class="text-right noprint" id="export-trip-cancellation" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTripCancellation();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                            <form id="trip_cancellation_form" name="trip_cancellation_form" method="post" onsubmit="return false;">
                                            <div class="row">   
                                                <div class="form-group col-md-2">
                                                    <label for="trip_cancellation_from">From Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="from" class="form-control sdate" id="trip_cancellation_from" readonly="true" placeholder="Date From">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="trip_cancellation_to">To Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="to" class="form-control sdate" id="trip_cancellation_to" readonly="true" placeholder="Date To">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>  
                                                <div class="form-group col-md-2">
                                                    <label for="cons_rpt_date_to">Date Option</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="trip_cancellation_date_opt" name="date_option"  class="form-control" >  
                                                            <option value="2">Cancelled Date</option>
                                                            <option value="1">Travel Date</option>                                                             
                                                            <option value="0">Booked Date</option>                                                                                                                                    
                                                        </select>       
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label  for="tag_filter">Tags</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="tag_filter" name="tagCode"  class="form-control" >                                                                    
                                                                <option value="">Select Tags</option>
                                                                {foreach from=$tags item=row}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                        </select>       
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="getTripCancellation()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearTripCancellation()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="trip_cancellation_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="trip-cancel-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="trip-cancel-list"></div>                                    
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
        $('#trip_cancellation_from').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#trip_cancellation_to').datepicker('setStartDate', e.date);
            $("#trip_cancellation_to").datepicker("setEndDate", end)
        });
        $('#trip_cancellation_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#trip_cancellation_from').datepicker('setStartDate', start);
            $('#trip_cancellation_from').datepicker('setEndDate', e.date)
        });

        function getTripCancellation() {
            $('#trip-cancel-list').html('');
            var data = {};
            data.from = $('#trip_cancellation_from').val();
            data.to = $('#trip_cancellation_to').val();
            data.date_option = $('#trip_cancellation_date_opt').val();
            data.tagCode = $('#tag_filter').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.from == '') {
                $('#trip_cancellation_from').addClass('inp_error');
                err++;
            }
            
            if (data.to == '') {
                $('#trip_cancellation_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#trip_cancellation_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#trip_cancellation_state').html('Please enter/select the values in the field that are marked in red');
                $('#trip_cancellation_state').show();
                return false;
            } else {
                $('#trip_cancellation_state').removeClass('alert-success').removeClass('alert-danger');
                $('#trip_cancellation_state').html('');
                $('#trip_cancellation_state').hide();
            }
            $('#trip-cancel-list-container').removeClass('hidden');
            $('#trip-cancel-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/trip-cancellation-report-list",
                data: data,
                success: function (response) {
                    $('#trip-cancel-list').html(response);
                    $('#export-trip-cancellation').show();
                }
            });
        }
        
        function clearTripCancellation() {
            $('#trip_cancellation_from').val('');
            $('#trip_cancellation_to').val('');
            $('#trip_cancellation_date_opt').val(1);
            $('#trip-cancel-list-container').addClass('hidden');
            $('#trip-cancel-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#trip_cancellation_state').removeClass('alert-success').removeClass('alert-danger');
            $('#trip_cancellation_state').html('');
            $('#trip_cancellation_state').hide();
            $('#export-trip-cancellation').hide();
        }

        function exportTripCancellation() {    
            document.trip_cancellation_form.action = "report/trip-cancellation-report-list";
            document.trip_cancellation_form.target = "ifrm_trip_cancellation";
            $('#export').val(1);
            document.trip_cancellation_form.submit();
            return;
        }
    </script>
{/literal}