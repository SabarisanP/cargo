<div class="brand_top">
    <h3>Occupancy & Income Report</h3> 
    <div class="text-right noprint hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportSalesRevenueExcel()"><i class="fa fa-download fa-lg"></i>Download</button>
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/sales-revenue-report-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from_date" class="form-control sdate" id="date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to_date" class="form-control sdate" id="date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="groupby">Group by</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="groupby" name="groupby" class="form-control">
                                                                    <option value="1">Date</option>
                                                                    <option value="2">Schedule</option>        
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="orvehicle" name="vehicle" class="form-control sdate">
                                                                    <option value='ALL' selected="">All Vehicles</option>
                                                                    <option value=''>Un Assigned</option>
                                                                    {foreach from=$vehicles item=vehicle}
                                                                        <option value="{$vehicle->registationNumber}">{$vehicle->registationNumber}</option>
                                                                    {/foreach}       
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

                                                        <div class="form-group col-md-3"> 
                                                            <label for="date_to">&nbsp;</label>
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <input type="hidden" name="revenue_type" id="revenue-type" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateSalesRevenueReport();" >Generate</button>
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

                    <div class="row hidden" id="sales-revenue-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="sales-revenue-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe id="ifrm_downloader" name="ifrm_downloader" style="display: none"></iframe>                                            
{literal}
    <script>
        function exportSalesRevenueExcel(revenueType = '') {
            document.brd_pnt.target = "ifrm_downloader";
            $('#export').val(1);
            $('#revenue-type').val(revenueType);
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

        function generateSalesRevenueReport() {
            $('#sales-revenue-list').html('');
            var data = {};
            data.groupby = $('#groupby').val();
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.vehicle = $('#orvehicle').val();
            data.tagCode = $('#tag_filter').val();

            var err = 0;
            if (data.groupby == '') {
                $('#groupby').addClass('inp_error');
                err++;
            } else {
                $('#groupby').removeClass('inp_error');
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
            $('#sales-revenue-list-container').removeClass('hidden');
            $('#sales-revenue-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/sales-revenue-report-list",
                data: data,
                success: function (response) {
                    $('#sales-revenue-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            })
        }

        function clearReport() {
            $('#groupby').val(1);
            $('#date_from').val('');
            $('#date_to').val('');
            $('#orvehicle').val('ALL');
            $('#tag_filter').val('');
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', end);
           
            $('#date_to').datepicker('setStartDate', start);
            $('#date_to').datepicker('setEndDate', end);

            $('#sales-revenue-list-container').addClass('hidden');
            $('#sales-revenue-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();

            $('#d_head_export_panel').addClass('hidden');
        }
    </script>
{/literal}