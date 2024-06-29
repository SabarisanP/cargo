
<ul class="nav nav-tabs">
    <li  class="active"><a data-toggle="tab" href="#approved">Approved</a></li>
    <li><a data-toggle="tab" href="#pending"  onclick="getPendingIE();">Pending Approval</a></li>
</ul>

<div class="tab-content">

    <div id="approved" class="tab-pane fade in active">
        <br class="clear_fix_both">
        <div class="align-center alert alert-danger pull-left" style="display:none" id="ack_action_state"></div>
        <div id="approved-ie-list">

            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr class="bold success">
                            <th align="center">Income / Expense Head</th>
                            <th align="center">Income / Expense Date</th>
                            <th align="center">Transaction Mode</th>
                            <th align="center">Referrence Type</th>
                            <th align="center">Referrence Code</th>
                            <th align="center">Remarks</th>
                            <th align="right">Income / Expense Amount</th>
                            {if $action_rights['CGO-INEX-EDIT']>0}<th>Action</th>{/if}
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {assign var="tot_dr" value=0}
                        {foreach item=data from=$approved key=branch}
                            <tr>
                                <td class="active" colspan="{if $action_rights['CGO-INEX-EDIT']>0}8{else}7{/if}" align="center">{$org[$branch]}</td>
                            </tr>
                            {foreach item=row from=$data}
                                <tr>
                                    <td align="left">{$row->organizationCash->name}</td>
                                    <td align="left">{$row->transactionDate|date_format:$ns_date_format}</td>
                                    <td align="left">{$row->transactionMode->name}</td>
                                    <td align="left">{$row->referenceTypeCode}</td>
                                    <td align="left">{$row->referenceCode}</td>
                                    <td align="left">{$row->remarks}</td>
                                    <td align="right">{$row->amount|number_format:2}</td>
                                    {if $action_rights['CGO-INEX-EDIT']>0}
                                        <td width="12%" align="center">
                                            <div class="btn-group btn-group-xs">
                                                <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" id='ie_edt_{$row->transaction_code}' onclick='showInpExpDialog("Dr", {$row|@json_encode});'><i class="fa fa-pencil igreen"></i></a>
                                                <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick='deleteInpExp({$row|@json_encode});'><i class="fa fa-trash-o ired"></i></a>
                                            </div>
                                        </td>
                                    {/if}
                                </tr>
                                {assign var="tot_dr" value=$tot_dr + $row->amount}
                            {/foreach}
                        {foreachelse}
                            <tr>
                                <td colspan="{if $action_rights['CGO-INEX-EDIT']>0}8{else}7{/if}" align="center">No Records Found!</td>
                                {if $action_rights['CGO-INEX-EDIT']>0}<td></td>{/if}
                            </tr>
                        {/foreach}
                        {if $approved|count}
                            <tr class="active">
                                <td colspan="{if $action_rights['CGO-INEX-EDIT']>0}6{else}6{/if}" class="bold" align="right">Total</td>
                                <td align="right">{$tot_dr|number_format:2}</td>
                                {if $action_rights['CGO-INEX-EDIT']>0}<td></td>{/if}
                            </tr>
                        {/if}
                    </tbody>
                </table>
            </div>

        </div>
    </div>                
    <div id="pending" class="tab-pane fade in active">
        <div id="pending-panel">

        </div>
        <br class="clear_fix_both">
        <div class="align-center alert alert-danger pull-left" style="display:none" id="paid_action_state"></div>
        <div id="pending-ie-list"></div>
    </div>

</div>

<div id="approve-dialog" class="hide dialog-content-page">
    <form role="form" class="form-horizontal">
        <div class="col-sm-12 p_l_n">
            <label class="req" for="ie-app-remarks">Remarks</label>
            <input type="text" checked id="ie-app-remarks" class="form-control" >
        </div>
        <div class="clear_fix_both"></div><br/>
        <div class="alert col-lg-12 pull-left" id="ie-app-action"></div>
        <br/>
        <br/>
        <div class="align-right" id="app-buttons">
            <input type="hidden" id="hid-ie-pending-code" class="form-control">
            <button class="btn btn-success" type="button" onclick="ApproveIE();">Approve</button>
            <button class="btn btn-default" type="button" onclick="closeApproveDialog();">Close</button>
        </div>
    </form>

</div>

<script>

    function closeApproveDialog() {
        $('#approve-dialog').dialog('destroy');
        $('#approve-dialog').hide();
        $('#hid-ie-pending-code').val('');
        $('#ie-app-action').hide();
        $('#app-buttons').show();

    }

    function getPendingIE() {
        var data = {};
        data.fromDate = $('#inp-exp-from').val();
        data.toDate = $('#inp-exp-to').val();
        data.organizationCode = $('#inp-exp-branch').val();



        var err = 0;
        $('#inp_exp_form .inp_error').removeClass('inp_error');

        if (data.fromDate == '') {
            $('#inp-exp-from').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#inp-exp-to').addClass('inp_error');
            err++;
        }

        $('#pending-ie-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/get-income-expense-pending-transactions-list',
            data: data,
            success: function (response) {
                $('#pending-ie-list').html(response);
            }
        });

    }

    function ApproveIE() {
        var data = {};
        data.code = $('#hid-ie-pending-code').val();
        data.paymentAcknowledgeStatus = "PAID";
        data.remarks = $('#ie-app-remarks').val();

        console.log(data);


        $('#ie-app-action').removeClass('alert-success').removeClass('alert-danger');
        $('#ie-app-action').html(loading_popup).show();
        $('#app-buttons').hide();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/make-approval-income-expense',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#ie-app-action').addClass('alert-success');
                    $('#ie-app-action').html('Your request has been completed successfully');

                    window.setTimeout(function () {
                        closeApproveDialog();
                        getInpExp();
                    }, 2000);
                } else {
                    $('#ie-app-action').addClass('alert-danger');
                    $('#ie-app-action').html(response.errorDesc);
                    $('#app-buttons').show();
                }
            }
        });

    }

    function approveAcknowledgeDialog(code) {

        $('#ie-app-remarks').val('')
        $('#hid-ie-pending-code').val('');
        $('#approve-dialog').removeClass('hide');
        $('#approve-dialog').dialog({
            autoOpen: true,
            width: 500,
            height: 300,
            resizable: false,
            modal: true
        });
        $(".ui-dialog-titlebar").hide();

        if (code != '') {
            $('#hid-ie-pending-code').val(code);
        }
    }



</script>