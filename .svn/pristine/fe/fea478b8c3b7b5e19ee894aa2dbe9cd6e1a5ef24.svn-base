{function name="journalTable" data=[]}
    {if $acknowledgeStatus == 'INIT'}
        <div class="form-group">
            <button class="btn-app btn-success" type="button" onclick="journalStatusDialog('APRD');">Acknowledge</button>
            <button class="btn-app btn-danger" type="button" onclick="journalStatusDialog('REJT');">Reject</button>
        </div>
    {/if}
    <div class="table-responsive" id="jornal-transaction-table">
        <table class="table table-bordered">
            <thead>
                <tr class="success">
                    {if $acknowledgeStatus == 'INIT'}
                        <th class="text-center">
                            <input type="checkbox" id="jornal-transaction-cb-all">
                        </th>
                    {/if}
                    <th align="center">Journal Code</th>
                    <th align="center">Journal Date</th>
                    <th align="center">Debit Ledger</th>
                    <th align="center">Credit Ledger</th>
                    <th align="center">Vehicle / Branch</th>
                    <th align="center">Voucher Date</th>
                    <th align="center">Ref. No</th>
                    <th align="center">Amount</th>
                    <th align="center">TDS</th>
                    <th class="noprint">Att.</th>
                    <th class="noprint"></th>
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach item=row from=$data key=t}
                    <tr id="row-{$row->code}">
                        {if $acknowledgeStatus == 'INIT'}
                            <td align="center">
                                <input type="checkbox" class="jornal-transaction-cb" value="{$row->code}">
                            </td>
                        {/if}
                        <td align="left">{$row->code}</td>
                        <td align="left" nowrap>{$row->transactionDate|date_format:$ns_date_format}</td>
                        <td align="left">
                            {if isNotNull($row->paymentContact->contactCategory->code) && in_array('EXPLGR', $row->paymentContact->contactCategory->tag)}
                                {$row->paymentContact->contactCategory->name}
                            {else}
                                {$row->paymentContact->name}
                            {/if}
                        </td>
                        <td align="left">
                            {if isNotNull($row->vendorContact->contactCategory->code) && in_array('EXPLGR', $row->vendorContact->contactCategory->tag)}
                                {$row->vendorContact->contactCategory->name}
                            {else}
                                {$row->vendorContact->name}
                            {/if}
                        </td>
                        <td align="left">
                            {if $row->cashbookCategory->code == 'VEH'}
                                {$row->busVehicle->registationNumber}
                            {elseif $row->cashbookCategory->code == 'BRN'}
                                {$row->organization->name}
                            {/if}<br>
                            <small class="text-muted">{$row->cashbookCategory->name}</small>
                        </td>
                        <td align="left">{$row->paymentDate|date_format:$ns_date_format}</td>
                        <td align="left">{$row->referenceNumber}</td>
                        <td align="right">{$row->transactionAmount|sigma:$t_transaction_amount|inr_format}</td>
                        <td align="right">{$row->tdsAmount|sigma:$t_tds_amount|inr_format}</td>
                        <td class="noprint text-center no-wrap">
                            {* {if $row->image} *}
                                <div class="btn-group btn-group-xs">
                                    <button class="btn btn-default btn-sm" type="button" onclick="showJournalGallery('{$row->code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                                </div>
                            {* {/if} *}
                        </td>
                        <td class="noprint text-center no-wrap">
                            {if $row->remarks}
                                &emsp;<a href="javascript:;" title="Remarks" data-toggle="popover" class="has-popover" data-content="{$row->remarks}"><i class="fa fa-info-circle" aria-hidden="true"></i></a>&emsp;
                            {/if}

                            {if $acknowledgeStatus == 'INIT'}
                                <div class="btn-group btn-group-xs">
                                    <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" onclick="addJournalTransaction('{$row->code}')"><i class="fa fa-pencil igreen"></i></a>
                                    <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"  onclick="deleteJournalTransaction('{$row->code}')"><i class="fa fa-trash-o ired"></i></a>
                                </div>
                            {/if}
                        </td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td colspan="100%" align="center">No Records Found!</td>
                    </tr>
                {/foreach}

                {if $result|count}
                    <tr class="bold">
                        <td colspan="{if $acknowledgeStatus == 'INIT'}8{else}7{/if}" align="right">Total:</td>
                        <td align="right">{$t_transaction_amount|inr_format}</td>
                        <td align="right">{$t_tds_amount|inr_format}</td>
                        <td align="right"></td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
{/function}

{call journalTable data=$result acknowledgeStatus=$acknowledgeStatus}

{if $acknowledgeStatus == 'INIT'}
    {if $reject|count}
        <div class="row">
            <p class="bold col-md-5">Rejected List</p>
        </div>
        {call journalTable data=$reject acknowledgeStatus='RJECT'}
    {/if}
{/if}

<script>
    var journalTransactionData = {$result|json_encode};
    $('[data-toggle="tooltip"]').tooltip();

    $(".has-popover").popover({
        trigger: 'hover',
        placement : 'top',
        html: true
    });

    $('#jornal-transaction-cb-all').on('change', function () {
        $('#jornal-transaction-table .jornal-transaction-cb').prop('checked', this.checked);
    });

    function journalStatusDialog(status) {
        var journalCodes = [];
        $('#jornal-transaction-table .jornal-transaction-cb:checked').each(function () {
            journalCodes.push(this.value);
        });

        var data = {};
        data.code = journalCodes.join(',');
        data.acknowledgeStatus = {};
        data.acknowledgeStatus.code = status;

        if (!journalCodes.length) {
            alert('Please select atleast one Journal Transaction.');
            return;
        }

        if (!confirm('Do you want to change the selected journal transactions?')) {
            return;
        }

        var loading_overlay = iosOverlay({
            text: "Updating...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/update-journal-status",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        generateJournalReport();
                    }, 2000);
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            }
        });
    }
</script>
