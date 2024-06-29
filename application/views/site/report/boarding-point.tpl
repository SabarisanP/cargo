<div class="brand_top">
    <h3>Boarding Point Report</h3> 

    <div class="text-right hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBoardingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print()"><i class="fa fa-print fa-lg"></i> Print</button>
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/boarding-point-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from_date" class="form-control sdate" id="date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to_date" class="form-control sdate" id="date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_to">From Station</label>
                                                            <div class="input-group">
                                                                <select id="station_id" name="staion" class="form-control sdate" onchange="stationPointbyStation();">
                                                                    <option value="">Select a station</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station->code}"> {$station->name} </option>
                                                                    {/foreach}    
                                                                </select>
                                                                <span class="input-group-addon"><i class="fa fa fa-level-up"></i></span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2 hide">
                                                            <label class="sr-only" for="date_to">From Station Point</label>
                                                            <select id="station_point_id" name="stationPoint" class="form-control sdate">
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="row">            
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only"  for="tag_filter">Tags</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="tag_filter" name="tagCode"  class="form-control" >                                                                    
                                                                    <option value="">Select Tags</option>
                                                                    {foreach from=$tags item=row}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-3">        
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="searchBoardingPointReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                        </div>
                                                    </div>            
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usr-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="boarding-point-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="boarding-point-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe id="irm_downloader" style="display: none"></iframe>                                            
{literal}
    <script>

        function exportBoardingExcel() {
            document.brd_pnt.target = "ifrm_boarding_downloader";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }

        $('#date_from').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
        });
        
        $('#date_to').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
        });

        $('#station_id').select2({
            placeholder: "Select a station",
            escapeMarkup: function (markup) {
                return markup;
            }
        });

        function searchBoardingPointReport() {
            $('#boarding-point-list').html('');
            var data = {};
            data.staionname = $('#station_id').find('option:selected').text();
            data.staion = $('#station_id').val();
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.stationPoint = $('#station_point_id').val();
            data.tagCode = $('#tag_filter').val();

            var err = 0;
            if (data.staion == '') {
                $('#station_id').addClass('inp_error');
                err++;
            } else {
                $('#station_id').removeClass('inp_error');
            }

            if (data.from_date == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }
            
            if (data.to_date == '') {
                $('#date_to').addClass('inp_error');
                err++;
            } else {
                $('#date_to').removeClass('inp_error');
            }
            
            if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);
                
                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#date_to').addClass('inp_error');
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#usr-action-state').html('Date range should be 31 days or less');
                    $('#usr-action-state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#usr-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#usr-action-state').show();
                return false;
            } else {
                $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#usr-action-state').html('');
                $('#usr-action-state').hide();
            }
            var html = "";
            
            $('#date_to').removeClass('inp_error');
            $('#boarding-point-list-container').removeClass('hidden');
            $('#boarding-point-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/boarding-point-list",
                data: data,
                success: function (response) {
                    $('#boarding-point-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            })
        }

        function clearReport() {
            $('#station_id').val('');
            $('#date_from').val('');
            $('#date_to').val('');
            $('#station_point_id').html('');
            $('#station_point_id').parent('.form-group').addClass('hide');
            $('#station_point_id').select2('destroy');
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', end);
           
            $('#date_to').datepicker('setStartDate', start);
            $('#date_to').datepicker('setEndDate', end);
            
            $('#station_id').select2('val', '');

            $('#boarding-point-list-container').addClass('hidden');
            $('#boarding-point-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();

            $('#d_head_export_panel').addClass('hidden');
        }

        function exportAdvancedBookingReport() {

        }


        /*
         $(window).load(function() {
         var loading_overlay = iosOverlay({
         text: "Loading",
         icon: "fa fa-spinner fa-spin"
         });
         });*/
    
        function stationPointbyStation(){
            var data = {};
            data.staionCode = $('#station_id').val();
            $('#station_point_id').parent('.form-group').removeClass('hide');
            $('#station_point_id').html($('<option>', {
                value: '',
                text: 'Loading...'
            }));
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "report/get-stationpoint-by-station",
                data: data,
                success: function (response) {
                    if(response.status == 1){
                        $('#station_point_id').html($('<option>', {
                            value: 'NA',
                            text: 'All Station Points'
                        }));
                        $.each(response.data, function(i,val){
                            $('#station_point_id').append($('<option>', {
                                value: val.code,
                                text: val.name
                            }));
                        });
                        $('#station_point_id').select2();
                    }
                }
            });
        }

    </script>
{/literal}