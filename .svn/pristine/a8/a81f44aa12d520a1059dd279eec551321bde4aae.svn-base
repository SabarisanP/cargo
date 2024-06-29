<div class="brand_top">
    <h3>Income / Expense Report</h3>
    <div class="text-right noprint">
        <a href="{if $action_rights['EBL-IE-V2'] == 1}#payment/expense-v2{else}#payment/expense{/if}" class="btn btn-success pull-right"><i class="fa fa-plus"></i>&nbsp; Add Income / Expense</a>
        <div class="text-right noprint" id="exc-tr" style="display: none">
            <div class="btn-group btn-group-sm pull-right">
                <button class="btn btn-default" onclick="printManageExpense();"><i class="fa fa-print fa-lg"></i> Print</button>&emsp;
            </div>
            <div class="btn-group btn-group-sm pull-right">
                <button class="btn btn-default" onclick="exportExpensesExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            </div>
        </div>

    </div>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12"> <br>
                <!-- PAGE HEADER-->
                <div class="row noprint">
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-12">
                                    <div class="">
                                        <div id="search-panel">
                                            <form id='mytrans_form' name="trans_form" method="post" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label for="trns_rpt_date_from">Receipt From</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="manageexp_date_from" readonly placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="manageexp_date_to">Receipt To</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="manageexp_date_to" readonly placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="form-group col-md-6" id="manage_expense_branch">
                                                        <label for="manageexp_org">Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="manageexp_org" class="form-control" name="organizationCode" onchange="hideBranchUserFilter(this,'BRN')">
                                                                <option value="" >Select a Branch</option>
                                                                {foreach from=$organizations item=row}
                                                                    {* {if $action_rights['IE-BEHALF-BRACH'] != 1 || $row->code == $logged_in_usr_org_code} *}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    {* {if $action_rights['IE-BEHALF-BRACH'] == 1 || $action_rights['IE-BEHALF-ALL'] == 1} *}
                                                        <div class="form-group col-md-6" id="manage_expense_user">
                                                            <label for="trns_rpt_date_to">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="manageexp_user_code" name="user_code" class="form-control" onchange="hideBranchUserFilter(this,'USR')">
                                                                    <option  value="NA">All User</option>
                                                                    {foreach name=o item=grpusr from=$groupusers.groups}
                                                                        <optgroup label="{$grpusr->name}">
                                                                        {foreach name=o item=usr from=$groupusers.users} 
                                                                            {if $usr.groupcode == $grpusr->code && $usr.activeFlag == 1}
                                                                                {* {if $action_rights['IE-BEHALF-BRACH'] != 1 || $usr.orgcode == $logged_in_usr_org_code} *}
                                                                                <option  value="{$usr.code}">{$usr.name} {if isNotNull($usr.aliasCode)} - {$usr.aliasCode}{/if}</option>                                                      
                                                                            {/if}
                                                                        {/foreach}      
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    {* {/if} *}
                                                    {if $action_rights['IE-TAGS']>0} 
                                                        <div class="form-group col-md-6">
                                                            <label for="seat-sch-date">Tags</label>
                                                            <select id="manageexp_tags" class="form-control" name="tag_codes[]" multiple>
                                                                {foreach item=row from=$cargotags}
                                                                    {if $row->category->code == 'MGEXP'}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/if}
                                                                {/foreach} 
                                                            </select>
                                                        </div>
                                                    {/if}
                                                    <div class="form-group col-md-6">
                                                        <label for="manageexp_date_to">Group By</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="manageexp_group_by" name="group_by" class="form-control">
                                                                <option value="SUMMARY">Summary</option>
                                                                <option value="DETAILS">Details</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="manageexp_action_state"></div>

                                                    <div class="form-group col-md-6 w-auto pull-right">
                                                        <div class="input-group">
                                                            <input type="hidden" name="exportGroupBy" id="export-group-by" value="">
                                                            <input type="hidden" name="export" id="export" value=""><br>
                                                            <button class="btn btn-success" type="button" onclick="searchTransBooking()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearTransReport()">Clear</button>
                                                        </div>
                                                    </div>

                                                </div>
                                            </form>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-8">
                    <div class="panel panel-default hide" id="chart-pannel">
                        <div class="row">
                            <div class="col-sm-6">
                                <div id="donut-container" class="pull-left" style="min-width: 310px; width: 100%; height: 225px"></div>
                            </div>
                            <div class="col-sm-1">
                            </div>
                            <div class="col-sm-4">
                                <div class="text-center">
                                    <br><br><br>
                                    <small>Settlement amount to office</small>
                                    <div class="bg-info bold text-center"><br>
                                        <h3 id="settle-amt" class="bold" style="margin: 0">9,800</h3><br>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-1">
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    </div>

                </div>

                <div class="row hidden" id="manageexp-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="manageexp-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>

<div id="manage-expense-pdf-dialog" class="hide">
    <a href="javascript:;" class="pull-right" onclick="closePrintManageExpense();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="manage-expense-iframe-alert"></div>
    <div id="manage-expense-iframe" style="height:90%;width:100%;"></div>
</div>

<div class="hide">
{include file="site/cargo/file-upload-component.tpl" id="ie-fileupload" axis="horizontal"}
</div>

<div id="reject-dialog" class="hide noprint">
    <form role="form" class="form-horizontal">
        <br>
        <div class="col-lg-12 p_l_n p_r_n">
            {* <label for="reject_remarks">Remarks</label>
            <textarea id="reject_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="120"></textarea> *}
            <label for="reject_remarks">Do you want to change the status of this receipt?</label>
        </div>
        <div class="col-lg-12">
            <div class="form-group">
                <label for="reject_remarks">Remarks</label>
                <textarea id="reject_remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="120"></textarea>
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </form>
    <br/>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="reject_action_state"></div>
        <div class="align-right">
            <input type="hidden" id="hid_reject_code"/>
            <input type="hidden" id="hid_reject_status"/>
            <button class="btn btn-success" type="button" id="confirm-pay" onclick="confirmRejectStatus();">Confirm</button>
            <button class="btn btn-default" type="button" onclick="cancelRejectStatusDialog();">Cancel</button>
        </div>
    </div>
</div>
<script>
    $('#manageexp_date_from').datepicker({
        // todayHighlight: true,
        format: 'yyyy-mm-dd',
        autoclose: true,
        startDate: '-20m',
        endDate: '+3m',
        changeMonth: true,
    }).on('changeDate', function(e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 31));
        $('#manageexp_date_to').datepicker('setStartDate', e.date);
        $("#manageexp_date_to").datepicker("setEndDate", end)
    });
    $('#manageexp_date_to').datepicker({
        todayHighlight: true,
        startDate: '-20m',
        endDate: '+3m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function(e) {
        var fDate = new Date(e.date);
        var start = new Date(fDate.setDate(fDate.getDate() - 31));
        $('#manageexp_date_from').datepicker('setStartDate', start);
        $('#manageexp_date_from').datepicker('setEndDate', e.date)
    });
    $('#manageexp_user_code, #manageexp_org').select2()

    $('#manageexp_tags').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default manageexp_tags',
        nonSelectedText: 'All Tags'
    });

    var fileupload = new fileUpload('#ie-fileupload');
    {literal}
        function hideBranchUserFilter(ele,type) {
            $('#manage_expense_branch, #manage_expense_user').removeClass('hide');
            var filterValue = $(ele).val();
            if (type == 'BRN' && isNotNull(filterValue)) {
                $('#manage_expense_user').addClass('hide');
            } else if (type == 'USR' && isNotNull(filterValue)) {
                $('#manage_expense_branch').addClass('hide');
            }
        }

        function searchTransBooking() {
            $('#manageexp-list').html('');
            $('#exc-tr').hide();
            var data = {};
            data.from = $('#manageexp_date_from').val();
            data.to = $('#manageexp_date_to').val();
            data.user_code = $('#manageexp_user_code').val();
            data.group_by = $('#manageexp_group_by').val();
            data.tag_codes = $('#manageexp_tags').val() || [];
            data.organizationCode = $('#manageexp_org').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.from == '') {
                $('#manageexp_date_from').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                if (data.to == '') {
                    $('#manageexp_date_to').addClass('inp_error');
                    err++;
                }
            }

            if (data.from != '' && data.to != '') {
                var f = data.from.split('-');
                var a = moment([f[0], f[1], f[2]]);

                var e = data.to.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if (t > 31) {
                    $('#manageexp_date_to').addClass('inp_error');
                    $('#manageexp_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#manageexp_action_state').html('Date range should be 31 days or less');
                    $('#manageexp_action_state').show();
                    err++;
                    return false;
                }
            }

            if (data.from != '') {
                if (data.to == '') {
                    $('#manageexp_date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                        (('' + month).length < 2 ? '0' : '') + month + '-' +
                        (('' + day).length < 2 ? '0' : '') + day;

                    data.to = output;
                    $('#manageexp_date_to').val(output);
                }
            }

            if (err > 0) {
                $('#manageexp_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#manageexp_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#manageexp_action_state').show();
                return false;
            } else {
                $('#manageexp_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#manageexp_action_state').html('');
                $('#manageexp_action_state').hide();
            }
            var html = "";
            $('#manageexp_date_to').removeClass('inp_error');
            $('#manageexp-list-container').removeClass('hidden');
            $('#manageexp-list').html(loading_popup);
            $('#chart-pannel').addClass('hide');
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "payment/manage-expense-report-list",
                data: data,
                success: function(response) {
                    $('#manageexp-list').html(response);
                    $('#exc-tr').show();
                    if (!window.device) return;
                    renderChart('trans-report-graph-1', 'Channel Wise Summary', device);
                }
            })
        }

        function clearTransReport() {
            $('#manageexp_date_from').val('');
            $('#manageexp_date_to').val('');
            $('#manageexp-list-container').addClass('hidden');
            $('#manageexp-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#manageexp_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#manageexp_action_state').html('');
            $('#manageexp_action_state').hide();
            $('#manageexp_schedule').val('NA');
            $('#manageexp_org').val('').trigger('chnage');
            $('#manageexp_user_code').val('NA').trigger('chnage');
            $('#trns_rpt_pbl_flag').prop('checked', true);
            $('#manageexp_group_by_2').val('');
            $('#manageexp_tags').multiselect('clearSelection');
            $('#chart-pannel').addClass('hide');
            $('#exc-tr').hide();
        }

        function renderChart(div, title, data) {
            var obj = [];
            $.each(data, function(i, val) {
                obj.push({
                    name: i,
                    y: val
                });
            });
            Highcharts.chart(div, {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: title,
                    style: {
                        fontSize: "16px",
                        fontWeight: 'bold'
                    }
                },
                exporting: {
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    shared: false,
                    useHTML: true,
                    headerFormat:"<b>{point.key}</b><table>",
                    pointFormat:" : {point.percentage:.2f}%, {point.y} seats",
                    footerFormat: "</table>",
                    percentageDecimals: 1
                },
                colors: ["#FF6040", "#A05030", "#D0B090", "#6600FF", "#64E572", "#FF9655", "#FFF263", "#6AF9C4"],
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: false,
                        },
                        showInLegend: false
                    }
                },
                series: [{
                    name: '',
                    colorByPoint: true,
                    data: obj
                }]
            });
        }

        function showPRGallery (code) {
            fileupload.showGalleryDialog({
                referenceCode: code,
                imageCategoryCode: 'CSHBO'
            });
        }

        function exportExpensesExcel() {    
            document.trans_form.action = "payment/manage-expense-report-list";
            document.trans_form.target = "ifrm_trans_downloader";
            $('#export').val(1);
            document.trans_form.submit();
            return;
        }

        function printManageExpense() {
            $('#manage-expense-iframe').html('');
            $('#manage-expense-pdf-dialog').css('background', '#fff');
            $('#manage-expense-pdf-dialog').removeClass('hide');
            $('#manage-expense-pdf-dialog').dialog({
                autoOpen: true,
                height: 700,
                width: 1100,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });
            $('.ui-dialog-titlebar').hide();

            var data = {};
            data.from = $('#manageexp_date_from').val();
            data.to = $('#manageexp_date_to').val();
            data.user_code = $('#manageexp_user_code').val();
            data.group_by = $('#manageexp_group_by').val();
            data.tag_codes = $('#manageexp_tags').val() || [];
            data.organizationCode = $('#manageexp_org').val();
            data.print = 1;

            var $iframe = $('<iframe />');
            $iframe.attr('src', base_url + 'payment/manage-expense-report-list?'+$.param(data));
            $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
            $('#manage-expense-iframe').html($iframe);
        }

        function closePrintManageExpense() {
            $('#manage-expense-iframe').html('');
            $('#manage-expense-pdf-dialog').dialog('destroy');
            $('#manage-expense-pdf-dialog').hide();
        }
        function rejectStatusDialog(code, status) {
            $('#hid_reject_code').val(code);
            $('#hid_reject_status').val(status);
            $('#reject_remarks').val('');

            $('.inp_error').removeClass('inp_error');
            $('#reject_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#reject_action_state').html('').hide();
            
            

            $('#reject-dialog').css('background', '#fff');
            $('#reject-dialog').removeClass('hide');
            $('#reject-dialog').dialog({
                autoOpen: true,
                height: 325,
                width: 450,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });
            $('.ui-dialog-titlebar').hide();
        }

        function cancelRejectStatusDialog() {
            $('#confirm-pay').attr('disabled', false);
            $('#reject-dialog').dialog('destroy');
            $('#reject-dialog').hide();
        }

        function confirmRejectStatus() {
            var code = $('#hid_reject_code').val();
            var status = $('#hid_reject_status').val();

            var data = {};
            if(code == 'chkd-data'){
                var checked = [];
                $.each($('#manage-expense-checkbox:checked'), function(){
                    checked.push($(this).val());
                });
                if(checked.length >0){
                    data.code = checked.join(',');
                }else{
                    return;
                }
            }else{
                data.code = code;
            }

            data.acknowledgeStatus = {};
            data.acknowledgeStatus.code = status;
            data.remarks = $.trim($('#reject_remarks').val());

            var err = 0;


            if (data.remarks == '') {
                $('#reject_remarks').addClass('inp_error');
                err++;
            }


            if (err > 0) {
                $('#reject_action_state').removeClass('alert-success').addClass('alert-danger');
                $('#reject_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#reject_action_state').show();
                return false;
            } else {
                $('#reject_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#reject_action_state').hide();
            }

            $('#reject_action_state').removeClass('alert-danger').removeClass('alert-success');
            $('#reject_action_state').html(loading_popup);
            $('#reject_action_state').show();
            $('#confirm-pay').attr('disabled', true);

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "payment/update-payment-expense-status",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#form-bttons').hide();
                        $('#reject_action_state').removeClass('alert-danger');
                        $('#reject_action_state').addClass('alert-success');
                        $('#reject_action_state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            cancelRejectStatusDialog();
                            searchTransBooking();
                        }, 3000);
                    } else {
                        $('#reject_action_state').addClass('alert-danger');
                        $('#reject_action_state').html(response.errorDesc);
                        $('#confirm-pay').attr('disabled', false);
                    }
                }
            })
        }
    {/literal}
</script>