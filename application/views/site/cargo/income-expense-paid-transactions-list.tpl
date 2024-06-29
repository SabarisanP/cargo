<div class="table-responsive">
    {if $action_rights['CGO-INEX-APPR']>0}
    <div id="app-rej-btns" class="hide">
        <button class="btn btn-success" type="button" onclick='approveAcknowledgeDialog();'>Approve</button>
        <button class="btn btn-danger" type="button" onclick='rejectAcknowledgeDialog();'>Reject</button>
    </div>
    {/if}    
    <div class="clear_fix_both"></div><br />
    <table class="table table-bordered">
        <thead>
            <tr class="bold success">
                <th align="center">
                    {if $action_rights['CGO-INEX-APPR']>0}
                    <input type="checkbox" class=="selectAllbox" onchange="selectAllBooking(this);" />
                    {/if}
                </th>
                <th align="center">Income /Expense code</th>
                <th align="center">Income /Expense Head</th>
                <th align="center">Income /Expense Date</th>
                <th align="center">Transaction Mode</th>
                {* <th align="center">Referrence Type</th> *}
                <th align="center">{lang('lr')} No / Vehicle No / Other</th>
                <th align="center">Remarks</th>
                <th align="right">Income / Expense Amount</th>
                {assign var="actioncol" value=($action_rights['CGO-INEX-EDIT']>0 || $action_rights['CGO-INEX-APPR']>0)}
                {if $actioncol}<th></th>{/if}
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="tot_dr" value=0}
            {foreach item=data from=$pending key=branch}
                <tr>
                    <td class="active" colspan="{if $actioncol}9{else}8{/if}" align="center">{$org[$branch]}</td>
                </tr>
                {foreach item=row from=$data}
                    <tr>
                        <td align="center">
                        {if $action_rights['CGO-INEX-APPR']>0}
                            <input type="checkbox" class="inc-exp-items" value="{$row->code}" />
                        {/if}
                        </td>
                        <td align="left">{$row->code}</td>
                        <td align="left">{$row->organizationCash->name}</td>
                        <td align="left">{$row->transactionDate|date_format:$ns_date_format}</td>
                        <td align="left">{$row->transactionMode->name}</td>
                        {* <td align="left">{(isNotNull($row->referenceTypeCode)) ? ucfirst($row->referenceTypeCode) : '-'}</td> *}
                        <td align="left">
                            {if $row->referenceTypeCode == 'VEHICLE'}
                                {$vehicle_mapped[$row->referenceCode]->registationNumber}
                            {elseif $row->referenceTypeCode == 'LR'}
                                <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->referenceCode}")'>{$row->referenceCode}</a>
                            {else}
                                -
                            {/if}
                        <td align="left">{(isNotNull($row->remarks)) ? $row->remarks : '-'}</td>
                        <td align="right">{$row->amount|number_format:2}</td>
                        {if $actioncol}
                            <td width="15%" align="right">
                                {if $row->image}
                                    <div class="btn-group btn-group-xs">
                                    <button class="btn btn-default btn-sm" type="button" title="{$row->image} files" onclick="showIEGallery('{$row->code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                                    </div>
                                {/if}
                                {if $action_rights['CGO-INEX-EDIT']>0}
                                    <div class="btn-group btn-group-xs">
                                        <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" id='ie_edt_{$row->transaction_code}' onclick='showInpExpDialog("Dr", {$row|@json_encode});'><i class="fa fa-pencil igreen"></i></a>
                                        <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick='deleteInpExp({$row|@json_encode});'><i class="fa fa-trash-o ired"></i></a>
                                    </div>
                                {/if}
                                {if $action_rights['CGO-INEX-APPR']>0}
                                    <button class="btn-app btn-success approve-btn" type="button" onclick='approveAcknowledgeDialog("{$row->code}");'>Approve</button>
                                    <button class="btn-app btn-danger reject-btn" type="button" onclick='rejectAcknowledgeDialog("{$row->code}");'>Reject</button>
                                {/if}
                            </td>
                        {/if}
                    </tr>
                    {assign var="tot_dr" value=$tot_dr + $row->amount}
                {/foreach}
            {foreachelse}
                <tr>
                    <td colspan="{if $actioncol}9{else}8{/if}" align="center">No Records Found!</td>
                    {if $actioncol}<td></td>{/if}
                </tr>
            {/foreach}
            {if $pending|count}
                <tr class="active">
                    <td colspan="7" class="bold" align="right">Total</td>
                    <td align="right">{$tot_dr|number_format:2}</td>
                    {if $actioncol}<td></td>{/if}
                </tr>
            {/if}
        </tbody>
    </table>
</div>


<div id="approve-dialog" class="hide dialog-content-page">
    <form role="form" class="form-horizontal">
        <div class="col-sm-12 p_l_n">
            <label class="req" for="ie-app-remarks">Remarks</label>
            <textarea id="ie-app-remarks" class="form-control" maxlength="200"></textarea>
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
        
<div id="reject-dialog" class="hide reject-dialog-content-page">
    <form role="form" class="form-horizontal">
        <div class="col-sm-12 p_l_n">
            <label class="req" for="ie-rej-remarks">Remarks</label>
            <textarea id="ie-rej-remarks" class="form-control" maxlength="200"></textarea>
        </div>
        <div class="clear_fix_both"></div><br/>
        <div class="alert col-lg-12 pull-left" id="ie-rej-action"></div>
        <br/>
        <br/>
        <div class="align-right" id="rej-buttons">
            <input type="hidden" id="hid-ie-rej-pending-code" class="form-control">
            <button class="btn btn-danger" type="button" onclick="rejectIE();">Reject</button>
            <button class="btn btn-default" type="button" onclick="closeRejectDialog();">Close</button>
        </div>
    </form>
</div>

<script>
    function selectAllBooking(cb) {
        var $cb = $(cb);

        $('.inc-exp-items')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked'))
                .trigger('change');      
        
    }

    $(".inc-exp-items, .selectAllbox").change(function(ele) {
        if(this.checked) {
            $('#app-rej-btns').removeClass('hide');
            $('.approve-btn, .reject-btn').attr('disabled', 'disabled');
        }

        if($('.inc-exp-items:checked').length == 0 && !($('.selectAllbox').is(':checked'))){
            $('#app-rej-btns').addClass('hide');
            $('.approve-btn, .reject-btn').prop('disabled', false);
        }
    });

    function closeApproveDialog() {
        $('#approve-dialog').dialog('destroy');
        $('#approve-dialog').hide();
        $('#hid-ie-pending-code').val('');
        $('#ie-app-action').hide();
        $('#app-buttons').show();
    }
    
    function closeRejectDialog() {
        $('#reject-dialog').dialog('destroy');
        $('#reject-dialog').hide();
        $('#hid-ie-rej-pending-code').val('');
        $('#ie-rej-action').hide();
        $('#rej-buttons').show();
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
        data.paymentAcknowledgeStatus = "ACKED";
        data.remarks = $('#ie-app-remarks').val();
        data.multipleCode =  [];
        
        if($('#hid-ie-pending-code').val() != ''){
            data.multipleCode.push($('#hid-ie-pending-code').val());
        }        

        $('.inc-exp-items:checked').each(function (i, cb) { 
            data.multipleCode.push($(this).val());
        });

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
                        getInpExpPen();
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
    
    function rejectAcknowledgeDialog(code) {
        $('#ie-rej-remarks').val('')
        $('#hid-ie-rej-pending-code').val('');
        $('#reject-dialog').removeClass('hide');
        $('#reject-dialog').dialog({
            autoOpen: true,
            width: 500,
            height: 300,
            resizable: false,
            modal: true
        });
        $(".ui-dialog-titlebar").hide();

        if (code != '') {
            $('#hid-ie-rej-pending-code').val(code);
        }
    }
    
    
    function rejectIE() {
        var data = {};        
        data.paymentAcknowledgeStatus = "RJECT";
        data.remarks = $('#ie-rej-remarks').val();
        data.multipleCode =  [];

        if($('#hid-ie-pending-code').val() != ''){
            data.multipleCode.push($('#hid-ie-pending-code').val());
        }        

        $('.inc-exp-items:checked').each(function (i, cb) { 
            data.multipleCode.push($(this).val());
        });

        $('#ie-rej-action').removeClass('alert-success').removeClass('alert-danger');
        $('#ie-rej-action').html(loading_popup).show();
        $('#rej-buttons').hide();
        
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/make-approval-income-expense',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#ie-rej-action').addClass('alert-success');
                    $('#ie-rej-action').html('Your request has been completed successfully');

                    window.setTimeout(function () {
                        closeRejectDialog();
                        getInpExpPen();
                    }, 2000);
                } else {
                    $('#ie-rej-action').addClass('alert-danger');
                    $('#ie-rej-action').html(response.errorDesc);
                    $('#rej-buttons').show();
                }
            }
        });

    }

</script>