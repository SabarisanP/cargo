<div class="brand_top">
    <h3>Agent Boarding Report</h3> 
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
                                                {if $bps|count > 0}
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/agent-boarding-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_from">Travel Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from_date" class="form-control sdate" id="date_from" readonly="true" placeholder="Travel Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_to">From Station</label>
                                                            <div class="input-group">
                                                                <select id="station_id" name="staion" class="form-control sdate">
                                                                    {foreach item=bp from=$bps key=bpcode}
                                                                        <option value="{$bpcode}"> {$bp} </option>
                                                                    {/foreach}    
                                                                </select>
                                                                <span class="input-group-addon"><i class="fa fa fa-level-up"></i></span>
                                                            </div>
                                                        </div>
                                                                
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
                                                {else} 
                                                    <div class="row">
                                                        <div class="form-group col-md-offset-3 col-md-6 text-center">
                                                            <div class="alert alert-danger">Sorry! No boarding point assigned.</div>
                                                        </div>
                                                    </div>
                                                {/if}    
                                                
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
            startDate: '-3m',
            endDate: "+3m",
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#date_to').datepicker('setStartDate', e.date);
            $("#date_to").datepicker("setEndDate", end)
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
            data.tagCode = $('#tag_filter').val();
            //data.to_date = $('#date_to').val();


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
                url: base_url + "report/agent-boarding-list",
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
            //$('#date_to').val('');
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#date_from').datepicker('setStartDate', start);
            //$('#date_from').datepicker('setEndDate', end);
           
            $('#date_to').datepicker('setStartDate', start);
            //$('#date_to').datepicker('setEndDate', end);
            
            $('#station_id').select2('val', '');
            $('#station_id').select2('data', '');

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

    </script>
{/literal}