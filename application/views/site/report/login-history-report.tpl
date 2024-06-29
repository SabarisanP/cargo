<div class="brand_top">
    <h3>Login History Report</h3> 
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
                                                
                                                <form id='brd_pnt' method="post" name="filter_form" action="report/login-history-report" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_to">Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="filter_type" name="filter_type" class="form-control sdate" onchange="setFilterOptions(this.value);">
                                                                    <option value="">Session type</option>
                                                                    <option value="ACT">Active Sessions</option>
                                                                    <option value="HIS">Login History</option>
                                                                    <option value="DUP">Dublicate Sessions</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to" class="sr-only">User Group</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="user_group" name="group_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Group/Roles</option>
                                                                    {foreach name=o item=row from=$groupusers.groups}                                                                    
                                                                        <option  value="{$row->code}">{$row->name}</option>                                                                    
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to" class="sr-only">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="user_code" name="user_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Users</option>
                                                                    {foreach name=o item=row from=$groupusers.users}                                                                        
                                                                        <option  value="{$row.code}">{$row.name}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>    

                                                        <div class="form-group col-md-3">        
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateHistoryReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                        </div>
                                                                
                                                    </div>
                                                    <div class="row">          
                                                        <div class="form-group col-md-2" id="div_from_date">
                                                            <label class="sr-only" for="date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from_date" class="form-control sdate" id="date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2" id="div_to_date">
                                                            <label class="sr-only" for="date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to_date" class="form-control sdate" id="date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
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

                    <div class="row hidden" id="login-history-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="login-history-list"></div>                                    
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
        
        function setFilterOptions(opt){
            $('#div_to_date, #div_from_date').removeClass('hidden');
            if(opt=='ACT') {
                $('#div_to_date, #div_from_date').addClass('hidden');
            }
        }
        
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
        
        $('#date_to').datepicker({
            startDate: '-3m',            
            endDate: "+3m",
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', e.date)
        });

        function generateHistoryReport() {
            $('#login-history-list').html('');
            var data = {};
            data.status = $('#filter_type').val();
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.group_code = $('#user_group').val();
            data.user_code = $('#user_code').val();

            if (data.status == "ACT") {
                data.from_date = "NA";
                data.to_date = "NA";
            }

            var err = 0;
            if (data.status == '') {
                $('#filter_type').addClass('inp_error');
                err++;
            } else {
                $('#filter_type').removeClass('inp_error');
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
            
            if (data.from_date != '' && data.to_date != '' && data.status != "ACT") {
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
            $('#login-history-list-container').removeClass('hidden');
            $('#login-history-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/login-history-report-list",
                data: data,
                success: function (response) {
                    $('#login-history-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            })
        }

        function clearReport() {
            $('#filter_type').val('');
            $('#date_from').val('');
            $('#date_to').val('');
            $('#user_group').val('');
            $('#user_code').val('');
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', end);
           
            $('#date_to').datepicker('setStartDate', start);
            $('#date_to').datepicker('setEndDate', end);

            $('#login-history-list-container').addClass('hidden');
            $('#login-history-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();

            $('#d_head_export_panel').addClass('hidden');
        }

    </script>
{/literal}