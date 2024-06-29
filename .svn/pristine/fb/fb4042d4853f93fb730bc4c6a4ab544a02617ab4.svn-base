<div class="brand_top">
    <h3>My Transaction Report</h3>
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTransactionExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                    <form name="my_transaction_report" id='test' method="post" action="cargo/my-transaction-report-list" onsubmit="return false;">
                                                        <div class="tabbable">
                                                        
                                                            {if $action_rights['CAR-MYTRANS-USR-FILTER']>0}  
                                                            <ul class="nav nav-tabs" id="mytrans-tab">
                                                                <li class="active">
                                                                    <a data-toggle="tab" href="#user_trans" data-tabid="USER">user</a>
                                                                </li>
                                                                <li>
                                                                    <a data-toggle="tab" href="#vendor_trans" data-tabid="VENDOR">vendor</a>
                                                                </li>
                                                            </ul>
                                                            {/if}
                                                            <div class="tab-content" id="tabs_content_a">
                                                                {if $action_rights['CAR-MYTRANS-USR-FILTER']>0}  
                                                                <div id="user_trans" class="tab-pane in active">
                                                                    <div class="col-md-3 tab-content">
                                                                        <div class="input-group col-xs-12">
                                                                            <select id="gru_users" name="user" class="form-control" name='users'>
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
                                                                </div>
                                                                <div id="vendor_trans" class="tab-pane">
                                                                    <div class="col-md-3 tab-content">
                                                                        <div class="input-group col-xs-12">
                                                                            <select id="gru_vendors" name="vendor" class="form-control col-md-6">
                                                                                <option value="">Select Vendors</option>
                                                                                {foreach item=vendor_usr from=$vendors}
                                                                                    {if $vendor_usr->activeFlag == 1}
                                                                                        <option value="{$vendor_usr->user->code}">{$vendor_usr->companyName}</option>
                                                                                    {/if}
                                                                                {/foreach}
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                {else}
                                                                    <input type="hidden" name="user" value="{$usr_login_id}" id="gru_users" />    
                                                                {/if}        
                                                            </div>
                                                            <div class="form-group col-md-3">
                                                                <label class="sr-only" for="date_from">From Date</label>
                                                                <div class="input-group">
                                                                    <input type="text" name="from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From">
                                                                    <label class="input-group-addon" for="date_from"><i class="fa fa-calendar"></i></label>
                                                                </div>
                                                            </div>
                                                            <div class="form-group col-md-3">
                                                                <label class="sr-only" for="date_to">To Date</label>
                                                                <div class="input-group">
                                                                    <input type="text" name="to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To">
                                                                    <label class="input-group-addon" for="date_to"><i class="fa fa-calendar"></i></label>
                                                                </div>
                                                            </div>
                                                            <input type="hidden" name="transactionType" id="transactionType">
                                                            <input type="hidden" name="username" id="username">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button"  onclick="searchReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                        </div>
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
        <iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

        {if $action_rights['CAR-MYTRANS-USR-FILTER']>0}
            <script>
                $('#gru_users, #gru_vendors').select2();
            </script>
        {/if}

    {literal}
        <script>
            $('#date_from').datepicker({
                //     todayHighlight: true,
                format: 'dd-mm-yyyy',
                autoclose: true,
                changeMonth: true,
            }).on('changeDate', function(e) {
                var fDate = new Date(e.date);
                var end = new Date(fDate.setDate(fDate.getDate() + 365));
                $('#date_to').datepicker('setStartDate', e.date);
                $("#date_to").datepicker("setEndDate", end)
            });
            $('#date_to').datepicker({
                todayHighlight: true,
                startDate: '-0m',
                format: 'dd-mm-yyyy',
                maxDate: "+365D",
                autoclose: true
            }).on('changeDate', function(e) {
                $('#date_from').datepicker('setEndDate', e.date)
            });
            
            function searchReport() {
                $('#rpt_lst').html('');
                $('.inp_error').removeClass('inp_error');

                var data = {};
                data.from = $('#date_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
                data.to = $('#date_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
                
                var err = 0;
                var tabid = $('#mytrans-tab > li.active > a').data('tabid');
                data.transactionType = tabid;

                if (tabid == 'USER') {
                    data.user = $('#gru_users').val();
                    data.username = $('#gru_users :selected').text();
                    if (data.user == '') {
                        $('#gru_users').addClass('inp_error');
                        err++;
                    }
                } else if  (tabid == 'VENDOR') {
                    data.user = $('#gru_vendors').val();
                    data.username = $('#gru_vendors :selected').text();
                    if (data.user == '') {
                        $('#gru_vendors').addClass('inp_error');
                        err++;
                    }
                } else {
                    data.user = $('#gru_users').val();
                }

                if (data.from == '') {
                    $('#date_from').addClass('inp_error');
                    err++;
                } else {
                    $('#date_from').removeClass('inp_error');
                }

                if (data.to == '') {
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
                $('#rpt_lst').html(loading_popup);
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "cargo/my-transaction-report-list",
                    data: data,
                    success: function(response) {
                        $('#rpt_lst').html(response);
                        $('#excl_cons').show();
                        $('#transactionType').val(tabid);
                        $('#username').val(data.username)
                    }
                })
            }

            function clearReport() {
                $('#gru_users').val('NA').trigger('change');
                $('#gru_vendors').val('NA').trigger('change');
                $('#date_from').val('');
                $('#date_to').val('');
                $('#rpt_lst').html('');
                $('.inp_error').removeClass('inp_error');
                $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#usr-action-state').html('');
                $('#usr-action-state').hide();
                $('#excl_cons').hide();
            }

            function exportTransactionExcel() {
                $('#export').val(1);
                document.my_transaction_report.target = "ifrm_downloader";
                document.my_transaction_report.submit();
                return;
            }
        </script>
    {/literal}
