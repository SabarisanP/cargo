<div class="brand_top">
    <h3>Ledger Transaction Report</h3>
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
                                            <form id='ledger-form' name="ledger_rpt_form" method="post"  onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-2">
                                                        <label for="ledger-from-date">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="fromDate" class="form-control sdate" id="ledger-from-date" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="ledger-to-date">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="toDate" class="form-control sdate" id="ledger-to-date" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>           
                                                    
                                                    <div class="form-group col-md-2">
                                                        <label  for="ledger-users">Users</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="ledger-users" class="form-control">                                                                    
                                                                <option value="">Select User</option>
                                                               {foreach from=$users item=val}
                                                                    <option value="{$val->code}">{$val->name}</option>
                                                               {/foreach}
                                                            </select>     
                                                        </div>
                                                    </div>  

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <button class="btn btn-success" type="button"  onclick="searchLedgerReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearLedgerReport()">Clear</button>
                                                        </div>
                                                    </div>
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="ledger_rpt_action_state"></div>
                                                </div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                        
                <div class="hidden" id="ledger-list-container">
                    <br>
                    <div id="ledger-list"></div>
                </div>
                                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_ledger_downloader" id="ifrm_ledger_downloader" style="display:none"></iframe>

<div id="view-receipt-dialog" style="display: none">
    <div class="clearfix">
        <b>View Receipt Details</b>
        <a href="javascript:;" class="pull-right" onclick="hideLedgerDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="view-receipt-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group" id="view-receipt-cont">
                    <div class="table table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>To</th>
                                    <th>Transaction Type</th>
                                    <th>Paid Booking</th>
                                    <th>ToPay Delivery</th>
                                    <th>Income</th>
                                    <th>Expense</th>
                                    <th>Commissions</th>
                                    <th>Settlement Amount</th>
                                    <th>Payable</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="to_usr"></td>
                                    <td class="trans_tpe"></td>
                                    <td class="book_amt"></td>
                                    <td class="del_amt"></td>
                                    <td class="inc"></td>
                                    <td class="exp"></td>
                                    <td class="com_amt"></td>
                                    <td class="set_amt"></td>
                                    <td class="pen_set_amt"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-md-12 text-right" id="view-receipt-panel-btn">
                <button type="button" class="btn btn-default" onclick="hideLedgerDialog();">Close</button>&nbsp;
            </div>
        </div>
    </div>
</div>

{literal}
    <script>
        $('#ledger-from-date').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
        });
        $('#ledger-to-date').datepicker({
            todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
        });

        $('#ledger-users').select2();

        function searchLedgerReport() {
            $('#ledger-list').html('');
            var data = {};
            data.fromDate = $('#ledger-from-date').val();
            data.toDate = $('#ledger-to-date').val();
            data.userCode = $('#ledger-users').val();
            data.user = $('#ledger-users :selected').text();

            var err = 0;
            $('#ledger-from-date, #ledger-to-date').removeClass('inp_error');

            if (data.fromDate == '') {
                $('#ledger-from-date').addClass('inp_error');
                err++;
            }

            if (data.fromDate == '') {
                if (data.toDate == '') {
                    $('#ledger-to-date').addClass('inp_error');
                    err++;
                }
            }

            if (data.fromDate != '') {
                if (data.toDate == '') {
                    $('#ledger-to-date').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to = output;
                    $('#ledger-to-date').val(output);
                }
            }

            if (data.userCode == '') {
                $('#ledger-users').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#ledger_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#ledger_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#ledger_rpt_action_state').show();
                return false;
            } else {
                $('#ledger_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#ledger_rpt_action_state').html('');
                $('#ledger_rpt_action_state').hide();
            }
            var html = "";
            $('#ledger-to-date').removeClass('inp_error');
            $('#ledger-list-container').removeClass('hidden');
            $('#ledger-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/ledger-transaction-report-list",
                data: data,
                success: function (response) {
                    $('#ledger-list').html(response);
                }
            })
        }

        function clearLedgerReport() {
            $('#ledger-from-date').val('');
            $('#ledger-to-date').val('');
            $('#ledger-list-container').addClass('hidden');
            $('#ledger-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#ledger_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#ledger-users').val('').trigger('change');
        }

        function viewLedger(code){
            $('#view-receipt-dialog').show();
            $('#view-receipt-dialog').dialog({
                autoOpen: true,
                height: 250,
                width: 1200,
                modal: true,
                closeOnEscape:true,
                resizable: false
            });
            $(".ui-dialog-titlebar").hide();
        
            var data = {};
            data.receiptDetailsCode = code;

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "report/get-ledger-receipt",
                data: data,
                success: function (response) {
                    var res = response.data;
                    if(res){
                        $('.to_usr').text(res.toUser.name);
                        $('.trans_tpe').text(res.transactionType.name);
                        $('.book_amt').text(res.bookedAmount.toFixed(2));
                        $('.del_amt').text(res.deliveryAmount.toFixed(2));
                        $('.com_amt').text(res.commissionAmount.toFixed(2));
                        $('.inc').text(res.incomeAmount.toFixed(2));
                        $('.exp').text(res.expenseAmount.toFixed(2));
                        $('.set_amt').text(res.settlementAmount.toFixed(2));
                        $('.pen_set_amt').text(res.paidAmount.toFixed(2));
                    }else{
                        $('.to_usr, .trans_tpe, .book_amt, .del_amt, .com_amt, .inc, .exp, .set_amt, .pen_set_amt').text('');
                    }
                }
            })

        }

        function hideLedgerDialog() {
            $('#view-receipt-dialog').dialog('destroy');
            $('.to_usr, .trans_tpe, .book_amt, .del_amt, .com_amt, .inc, .exp, .set_amt, .pen_set_amt').text('');
            $('#view-receipt-dialog').hide();
        }

    </script>
{/literal}

