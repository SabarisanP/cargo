<div class="brand_top">
    <h3>Voucher Due Report</h3>
    <div class="text-right noprint" id="export-user-voucher-due" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportUserVoucherDue()"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                            <form id="user_voucher_due_form" name="user_voucher_due_form" method="post" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-2">
                                                        <label for="user_voucher_due_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="fromDate" class="form-control sdate" id="user_voucher_due_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="user_voucher_due_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="toDate" class="form-control sdate" id="user_voucher_due_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="user_voucher_due_date_to">Date Option</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="user_voucher_due_date_opt" name="travelDateFlag"  class="form-control" >
                                                                <option value="1">Travel Date</option>
                                                                <option value="0">Transaction Date</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">   
                                                    <div class="form-group col-md-2">
                                                        <label for="user_voucher_due_date_to">Users</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="user_voucher_due_user_code" name="userCode"  class="form-control" >
                                                                <option value='NA' selected="">All Users</option>
                                                                {foreach name=g item=group key=groupname from=$groupusers.groupusers}
                                                                    <optgroup label="{$groupname}">
                                                                        {foreach name=u item=usr from=$group}
                                                                            <option  value="{$usr.code}">{$usr.name}</option>
                                                                        {/foreach}
                                                                    </optgroup>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="getUserVoucherDueReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearUserVoucherDue()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="user_voucher_due_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="user-voucher-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="user-voucher-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<iframe name="user-voucher-due" id="user-voucher-due" style="display:none"></iframe>

<div id="user-voucher-dialog" class="dialog-content-page" style="display: none">
    <a href="javascript:;" class="pull-right close-btn" onclick="closeUserVoucherDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="user-voucher-cont"></div>
</div>

{literal}
    <script>
        $('#user_voucher_due_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#user_voucher_due_to').datepicker('setStartDate', e.date);
            $("#user_voucher_due_to").datepicker("setEndDate", end)
        });
        $('#user_voucher_due_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#user_voucher_due_from').datepicker('setStartDate', start);
            $('#user_voucher_due_from').datepicker('setEndDate', e.date)
        });

        function getUserVoucherDueReport() {
            $('#user-voucher-list').html('');
            var data = {};
            data.fromDate = $('#user_voucher_due_from').val();
            data.toDate = $('#user_voucher_due_to').val();
            data.travelDateFlag = $('#user_voucher_due_date_opt').val();
            data.userCode = $('#user_voucher_due_user_code').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.from == '') {
                $('#user_voucher_due_from').addClass('inp_error');
                err++;
            }

            if (data.to == '') {
                $('#user_voucher_due_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#user_voucher_due_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#user_voucher_due_state').html('Please enter/select the values in the field that are marked in red');
                $('#user_voucher_due_state').show();
                return false;
            } else {
                $('#user_voucher_due_state').removeClass('alert-success').removeClass('alert-danger');
                $('#user_voucher_due_state').html('');
                $('#user_voucher_due_state').hide();
            }
            $('#user-voucher-list-container').removeClass('hidden');
            $('#user-voucher-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/user-voucher-due-report-summary",
                data: data,
                success: function (response) {
                    $('#user-voucher-list').html(response);
                    $('#export-user-voucher-due').show();
                }
            });
        }

        function clearUserVoucherDue() {
            $('#user_voucher_due_from').val('');
            $('#user_voucher_due_to').val('');
            $('#user-voucher-list-container').addClass('hidden');
            $('#user-voucher-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#user_voucher_due_state').removeClass('alert-success').removeClass('alert-danger');
            $('#user_voucher_due_state').html('');
            $('#user_voucher_due_state').hide();
            $('#export-user-voucher-due').hide();
        }

        function exportUserVoucherDue() {
            document.user_voucher_due_form.action = "report/user-voucher-due-report-summary";
            document.user_voucher_due_form.target = "user-voucher-due";
            $('#export').val(1);
            document.user_voucher_due_form.submit();
            return;
        }
    </script>
{/literal}