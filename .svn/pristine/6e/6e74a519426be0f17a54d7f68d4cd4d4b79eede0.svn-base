<div class="popup_top">
    <div class="row">
        <div class="col-md-4 ft_14">
            <span class="bold">{if $smarty.request.transactionType == 'Cr'}Income{elseif $smarty.request.transactionType == 'Dr'}Expenses{/if}</span>
        </div>
        <div class="col-md-6">
            {if $totalInitiated > 0}
                <span class="badge badge-warning">Total Initiated - <b>{$totalInitiated}</b></span>
            {/if}

            {if $totalApproved > 0}
                <span class="badge badge-success">Total Approved - <b>{$totalApproved}</b></span>
            {/if}
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeLRdetails()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>
</div>

<table class="table table-bordered table-hover" id="expenses-table">
    <thead>
        <tr class="success">
            <th>Date</th>
            <th>Income / Expense For</th>
            <th>Details</th>
            <th>Income / Expense Type </th>
            <th>Payment Mode </th>
            <th>Vendor/receiver Inc. </th>
            <th>Staff Details</th>
            <th>Amount</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=amount value=0}
        {foreach item=row from=$result}
            {if $row->acknowledgeStatus->code == "REJT"}
                {continue}
            {/if}
            {assign var="additionalDetails" value="|"|explode:$row->additionalDetails}
            <tr>
                <td align="left">{$row->receiptDate|date_format:$ns_date_format}</td>
                <td align="left">
                    {$row->cashbookCategory->name}
                </td>
                <td align="left">
                    {if $row->cashbookCategory->code == 'VEH'}
                        {$row->busVehicle->registationNumber}
                    {elseif $row->cashbookCategory->code == 'BRN'}
                        {$row->organization->name}
                    {else}
                        {$row->referenceCode}
                    {/if}
                </td>
                <td align="left">{$row->cashbookType->name}</td>
                <td align="left">{$row->transactionMode->name}</td>
                <td align="left">{$row->cashbookVendor->name|default:$row->cashbookVendor->code|default:'-'}</td>
                <td>
                    {if $row->cashbookTransactionDetails|@count > 0}
                        {foreach from=$row->cashbookTransactionDetails item=val}
                            {if $val->driver->name|is_string}
                                {$val->driver->name} - {$val->amount|inr_format}<strong>&nbsp;(Driver)</strong><br>
                            {else}
                                {$val->organizationContact->name} - {$val->amount|inr_format}<br>
                            {/if}
                        {/foreach}
                    {elseif $row->cashbookCategory->code == 'OT' && isNotNull($additionalDetails[0])}
                        {$additionalDetails[0]} - {$row->amount|default:'-'}
                    {else}
                        -
                    {/if}
                </td>
                <td align="right">{$row->amount|inr_format}</td>
                <td>
                    {if $row->acknowledgeStatus->code == 'INIT'}
                        <i class="fa fa-exclamation-circle fa-lg text-warning"></i> Initiated
                    {elseif $row->acknowledgeStatus->code == 'APRD'}
                        <i class="fa fa-check-circle fa-lg text-primary"></i> Approved
                    {elseif $row->acknowledgeStatus->code == 'REJT'}
                        <i class="fa fa-times-circle fa-lg text-danger"></i> Rejected
                    {/if}
                </td>
            </tr>
            {assign var=amount value=$amount+$row->amount}
        {foreachelse}
            <tr>
                <td colspan="9" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if count($result)}
            <tr class="active">
                <td align="right" colspan="7" class="bold">Total</td>
                <td align="right" class="bold">{$amount|inr_format}</td>
                <td></td>
            </tr>
        {/if}
    </tbody>
</table>

<script>
    $('a[id=popup_msg]').attr('data-toggle', 'popover');
    $('[data-toggle="popover"]').popover({
        placement: 'left',
        html: true,
        trigger: 'hover'
    });
</script>