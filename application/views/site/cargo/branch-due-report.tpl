<div class="brand_top">
    <h3>Branch Due Report</h3>
    <div class="text-right noprint" id="export-branch-due" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBranchDue()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Showing the details of particular branch Paid Booking and Topay Delivery details                 
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
                                            <form id="branch_due_form" name="branch_due_form" method="post" onsubmit="return false;">
                                                <div class="row">
                                                    <div class="form-group col-md-2">
                                                        <label for="branch_due_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="branch_due_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="branch_due_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="branch_due_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="branch_due_paystatus">Payment Status</label>
                                                        <div class="input-group col-md-11">
                                                            <select id="branch_due_paystatus" name="paystatus" class="form-control">
                                                                <option value="NA">All Status</option>
                                                                {foreach item=name key=code from=$paystatus}
                                                                    <option value="{$code}">{$name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    {if $action_rights['CGO-BR-DUE-ALL-BRAH']>0}
                                                    <div class="form-group col-md-2">
                                                        <label for="branch_due_organization">Branch</label>
                                                        <div class="input-group col-md-11">
                                                            <select id="branch_due_organization" name="organizationCode" class="form-control">
                                                                <option value="NA">All Branch</option>
                                                                {foreach item=row from=$branches}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    {/if}
                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button"  onclick="searchBranchDue()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBranchDue()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="branch_due_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="branch-due-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="branch-due-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_branch_due" id="ifrm_branch_due" style="display:none"></iframe>

{literal}
    <script>
        $('#branch_due_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#branch_due_to').datepicker('setStartDate', e.date);
            $("#branch_due_to").datepicker("setEndDate", end)
        });
        $('#branch_due_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#branch_due_from').datepicker('setStartDate', start);
            $('#branch_due_from').datepicker('setEndDate', e.date)
        });

        function searchBranchDue() {
            $('#branch-due-list').html('');
            var data = {};
            data.from = $('#branch_due_from').val();
            data.to = $('#branch_due_to').val();            
            data.paystatus = $('#branch_due_paystatus').val();
            data.organizationCode = $('#branch_due_organization').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (err > 0) {
                $('#branch_due_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#branch_due_state').html('Please enter/select the values in the field that are marked in red');
                $('#branch_due_state').show();
                return false;
            } else {
                $('#branch_due_state').removeClass('alert-success').removeClass('alert-danger');
                $('#branch_due_state').html('');
                $('#branch_due_state').hide();
            }
            $('#branch-due-list-container').removeClass('hidden');
            $('#branch-due-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/branch-due-report-list",
                data: data,
                success: function (response) {
                    $('#branch-due-list').html(response);
                    $('#export-branch-due').show();
                }
            });
        }

        function clearBranchDue() {
            $('#branch_due_from').val('');
            $('#branch_due_to').val('');
            $('#branch_due_paystatus').val('NA');
            $('#branch-due-list-container').addClass('hidden');
            $('#branch-due-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#branch_due_state').removeClass('alert-success').removeClass('alert-danger');
            $('#branch_due_state').html('');
            $('#branch_due_state').hide();
            $('#export-branch-due').hide();
        }

        function exportBranchDue() {
            document.branch_due_form.action = "cargo/branch-due-report-list";
            document.branch_due_form.target = "ifrm_branch_due";
            document.branch_due_form.submit();
            return;
        }
    </script>
{/literal}