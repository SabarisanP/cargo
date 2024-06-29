<div class="brand_top">
    <h3>{lang('dash_panel_user_balance')} Report</h3> 
    
    <div class="text-right hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportUserBalanceExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                    <div class="divide-10"></div>
                                                    <form name='usr_bal_report' method="post" action="payment/userbalance-list" onsubmit="return false;">
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="trans-date">Transaction Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from" class="form-control sdate" id="trans-date" readonly="true" placeholder="Transaction date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <button class="btn btn-success" type="button"    onclick="getUserBalance();" >Generate</button>
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                        <input type="hidden" name="export" id="export" value="">
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
                        <div class="row hidden" id="user-balance-list-container">
                            <br>
                            <div class="col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div id="user-balance-list"></div>                                    
                                    </div>
                                </div>
                            </div>
                        </div>
                                            
                    </div>                        
                </div>                    
            </div>
       </div>            
    </div>
    <iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe>                                            
    {literal}
        <script>
            $('#trans-date').datepicker({
                todayHighlight: true,
                format: 'yyyy-mm-dd',
                autoclose: true,
                startDate: '-3m',
                changeMonth: true,
                endDate :'today',
                    });
            $('#trans-date').datepicker('setDate', 'today');
            

            function getUserBalance() {
                $('#user-balance-list').html('');
                var data = {};
                data.from = $('#trans-date').val();

                
                var html = "";
                $('#user-balance-list-container').removeClass('hidden');
                $('#user-balance-list').html(loading_popup);
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "payment/userbalance-list",
                    data: data,
                    success: function(response) {
                        $('#user-balance-list').html(response);
                         $('#d_head_export_panel').removeClass('hidden');
                         
                    }
                });
            }

            function clearReport() {
                $('#gru_users').val('');
                $('#trans-date').datepicker('setDate', 'today');
                $('#user-balance-list-container').addClass('hidden');
                $('#user-balance-list').html('');
                $('.inp_error').removeClass('inp_error');
                $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#usr-action-state').html('');
                $('#usr-action-state').hide();
                $('#export').val('');
                
                $('#d_head_export_panel').addClass('hidden');
            }
            
            function exportUserBalanceExcel() {
                document.usr_bal_report.target = "irm_downloader";
                $('#export').val(1);
                document.usr_bal_report.submit();
                return;
            }
            
        </script>
    {/literal}