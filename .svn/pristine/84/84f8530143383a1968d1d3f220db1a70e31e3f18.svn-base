<div class="brand_top"><h3>My Transaction Report</h3> <div class="text-right hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTransactionDetails()"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>    
</div>
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
                                            <div id="search-panel">                                         
                                                <div class="divide-10"></div>
                                                <form id='test' name='my_trans_report' method="post" action="report/get-all-user-report" onsubmit="return false;">
                                                    {if $action_rights['USR-FILTER-TRANS']>0}  
                                                        <div class="form-group col-md-3">
                                                            <div class="input-group col-xs-12">
                                                                <select id="gru_users" class="form-control" name='user'>
                                                                    <option value="">Select User</option>
                                                                    {foreach name=o item=row from=$entity}
                                                                        <optgroup label="{$row['name']}">
                                                                            {foreach name=o item=usr from=$row["userlist"]}
                                                                                <option value='{$usr->code}'>{$usr->name}</option>
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    {else}
                                                        <input type="hidden" value="{$usr_login_id}" id="gru_users" />    
                                                    {/if}        
                                                    <div class="form-group col-md-3">
                                                        <label class="sr-only" for="date_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-3">
                                                        <label class="sr-only" for="date_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <button class="btn btn-success" type="button"  onclick="searchReport();" >Generate</button>
                                                    <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                    <input type="hidden" name="export" id="export" value="">
                                                    <input type="hidden" name="selectedUser" id="selectedUser" value="">
                                                </form>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usr-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div></div></div>
    </div></div>
<div id="rpt_lst"></div>
<iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe>                                            
{if $action_rights['USR-FILTER-TRANS']>0}
    <script>
        $('#gru_users').select2();
    </script>
{/if}
{literal}
    <script>

        $('#date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
            }).on('changeDate', function(e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#date_to').datepicker('setStartDate', e.date);
            $("#date_to").datepicker("setEndDate", end)
        });
        $('#date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
            }).on('changeDate', function(e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', e.date)
        });

        function searchReport() {
            $('#rpt_lst').html('');
            var data = {};
            data.user = $('#gru_users').val();
            data.from = $('#date_from').val();
            data.to = $('#date_to').val();

            var err = 0;
            if (data.user == '') {
                $('#gru_users').addClass('inp_error');
                err++;
            } else {
                $('#gru_users').removeClass('inp_error');
            }
            if (data.from == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }

            if (data.from == '') {
                if (data.to == '') {
                    $('#date_to').addClass('inp_error');
                    err++;

                } else {
                    $('#date_to').removeClass('inp_error');
                }
            }

            if (data.from != '') {
                if (data.to == '') {
                    $('#date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to = output;
                    $('#date_to').val(output);
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
            $('#rpt_lst').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/get-all-user-report",
                data: data,
                    success: function(response) {
                    $('#rpt_lst').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            })
        }

        function clearReport() {
            $('#gru_users').val('');
            $('#date_from').val('');
            $('#date_to').val('');
            $('#rpt_lst').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
            $('#d_head_export_panel').addClass('hidden');
        }
        function exportTransactionDetails() {
            document.my_trans_report.target = "irm_downloader";
            $('#export').val(1);
            $('#selectedUser').val($('#gru_users option:selected').text());
            document.my_trans_report.submit();
            return;
        }

    </script>
{/literal}
