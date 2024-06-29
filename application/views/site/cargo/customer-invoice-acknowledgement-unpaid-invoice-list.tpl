<table class="table table-bordered" id="invoice-ack-unpaid-inv-table">
    <thead>
        <tr class="success">
            <th></th>
            <th align="center">Invoice No</th>
            <th align="center">Vendor</th>
            <th align="center">Created Date</th>
            <th align="center">Created By</th>
            <th align="center">Invoice Peroid</th>
            <th align="center">Invoice Amount</th>
            <th align="center">Balance Amount</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$result}
            <tr id="vou_{$row->code|clean_string}">
                <td align="center">
                    <input type="checkbox" class="unpaid-inv-check" value="{$row->code}">
                </td>
                <td align="left">{$row->code}</td>
                <td align="left">{$row->user->name}</td>
                <td align="left">{$row->transactionDate|date_format:$ns_date_format}</td>
                <td align="left">{$row->paymentHandledBy->name}</td>
                <td align="left">
                    {if $row->transactionStartDate != '' || $row->transactionEndDate != ''}
                        {$row->transactionStartDate|date_format:$ns_date_format} to {$row->transactionEndDate|date_format:$ns_date_format}
                    {else}
                        -
                    {/if}
                </td>
                <td align="right">{$row->transactionAmount|inr_format}</td>
                <td align="right">{($row->transactionAmount-$row->partialTransactionAmount)|inr_format}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="8" align="center">No Records Found!</td>
            </tr>
        {/foreach}
    </tbody>
</table>