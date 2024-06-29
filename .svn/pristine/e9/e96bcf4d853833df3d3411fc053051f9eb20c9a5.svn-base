<div class="brand_top">
    <h3>Tripwise Agent Payment</h3> 
    <div class="text-right noprint" id="exc-tr" style="display: none">
        <div class="btn-group btn-group-sm">
            <!--<button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>-->
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
                                                <form id='mytrans_form' name="trans_form" method="post"  onsubmit="return false">
                                                    <div class="row">   
                                                        <div class="form-group col-md-2">
                                                            <label for="tsr_travel_date">Travel Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="tsr_travel_date" class="form-control sdate" id="tsr_travel_date" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-3">
                                                            <label  for="tsr_trip_code">Trips</label>
                                                            <div class="input-group col-md-12" id="tsr_trip_cintainer">
                                                                <select id="tsr_trip_code" name="tsr_trip_code"  class="form-control" >
                                                                    <option value='' selected="">Select a trip</option>
                                                                    {foreach item=schedule from=$active_schedules}
                                                                        <option value="{$schedule.code}">{$schedule.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="tsr_group_code" name="tsr_group_code"  class="form-control" >
                                                                    {foreach name=o item=row from=$groups}
                                                                        <option value='{$row->code}'>{$row->name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>        
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="searchTransBooking()">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTransReport()">Clear</button>
                                                            </div>
                                                        </div>        
                                                        <br>
                                                        <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="cons_rpt_action_state"></div>
                                                    </div>
                                                </form>
                                            </div><!--row end-->
                                        </div><!--content end-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                                                            
                    <div class="row hidden" id="cons-booking-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="cons-booking-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                                           
                </div>                    
            </div>
        </div>            
    </div>
    <iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>                                                         
    {literal}
        <script>
            $('#tsr_travel_date').datepicker({
                todayHighlight: true,
                format: 'dd-mm-yyyy',
                autoclose: true,
                startDate: '-3m',
                endDate: '+3m',
                changeMonth: true,
            }).on('changeDate', function (e) {
                getAllTrips();
            });
            $("#tsr_travel_date").datepicker("setDate", new Date());
            
            function getAllTrips() {
                $('#tsr_trip_cintainer').html(loading_popup);
                    
                var data = {};
                data.travel_date = $('#tsr_travel_date').val();
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "trips/get-trip-list",
                    data: data,
                    success: function (response) {
                        if(response.status==1) {
                            var html = '<select id="tsr_trip_code" name="tsr_trip_code"  class="form-control" >';
                            html += '<option value="">Select a trip</option>';
                            $.each(response.data, function(catkey, trips) {
                                html += ' <optgroup label="'+catkey+'">';
                                $.each(trips, function(key, trip) {                                
                                    html += '<option value='+trip.code+' >'+trip.name+' | '+trip.serviceNumber+' | '+trip.tripTime+'</option>';
                                });
                                html += ' </optgroup>';
                            });
                            html += '</select>';
                            $('#tsr_trip_cintainer').html(html);                            
                        } else {
                           $('#tsr_trip_cintainer').html('Sorry! No Trips Found'); 
                        }
                    }
                })
            }

            function searchTransBooking() {
                $('#cons-booking-list').html('');
                var data = {};
                data.travel_date = $('#tsr_travel_date').val();
                data.trip_code = $('#tsr_trip_code').val();
                data.group_code = $('#tsr_group_code').val();
                
                data.trip_name = $("#tsr_trip_code option:selected").text();

                var err = 0;
                $('.inp_error').removeClass('inp_error');

                if (data.travel_date == '') {
                    $('#tsr_travel_date').addClass('inp_error');
                    err++;
                }
                
                if (data.trip_code == '') {
                    $('#tsr_trip_code').addClass('inp_error');
                    err++;
                }
                
                if (err > 0) {
                    $('#cons_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#cons_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                    $('#cons_rpt_action_state').show();
                    return false;
                } else {
                    $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                    $('#cons_rpt_action_state').html('');
                    $('#cons_rpt_action_state').hide();
                }
                var html = "";
                $('#cons_rpt_date_to').removeClass('inp_error');
                $('#cons-booking-list-container').removeClass('hidden');
                $('#cons-booking-list').html(loading_popup);
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "report/tripwise-agent-payment-list",
                    data: data,
                    success: function (response) {
                        $('#cons-booking-list').html(response);
                        $('#exc-tr').show();
                    }
                })
            }

            function clearTransReport() {
                $('#cons_rpt_date_from').val('');
                $('#cons_rpt_date_to').val('');
                $('#cons-booking-list-container').addClass('hidden');
                $('#cons-booking-list').html('');
                $('.inp_error').removeClass('inp_error');
                $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#cons_rpt_action_state').html('');
                $('#cons_rpt_action_state').hide();
                $('#cons_trns_rpt_schedule').val('NA');
                $('#cons_trns_rpt_from_station').val('NA');
                $('#cons_trns_rpt_to_station').val('NA');
                $('#cons_trns_rpt_user_group').val('NA');
                $('#cons_trns_rpt_user_code').val('NA');
                $('#cons_rpt_group_by_2').val('');
                $('#exc-tr').hide();
            }
            
            function exportTransExcel() {
                document.trans_form.action = "report/trip-sales-report-list";
                document.trans_form.target = "ifrm_trans_downloader";
                $('#export').val(1);
                document.trans_form.submit();
                return;
            }

        </script>
    {/literal}

