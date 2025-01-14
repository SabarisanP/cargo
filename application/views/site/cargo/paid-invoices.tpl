<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Invoice No</th>
                <th align="center">Created Date</th>
                <th align="center">Invoice Peroid</th>
                <th align="center">Transaction Mode</th>
                <th align="center">User</th>
                <th align="center">Remarks</th>
                <th align="center">Invoice Amount</th>
                <th align="center">Paid Amount (A)</th>
                <th align="center">TDS Amount (B)</th>
                <th align="center">Adjustment Amount (C)</th>
                <th align="center">Total Paid Amount (A+B+C)</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="totalInvoice" value=0}
            {assign var="totalPaid" value=0}
            {assign var="totalTDS" value=0}
            {assign var="totalAdjustment" value=0}
            {assign var="totalTotalPaid" value=0}
            {foreach item=row from=$result}
                <tr>
                    <td align="left"> 
                        {if $namespace =="seenutransports"}
                            <a href="javascript:;" onclick="view_option_invioce('{$row->transaction_code}');">{$row->transaction_code}</a>
                        {else}
                            <a href="javascript:;" onclick="showInvoicePdfDialog('{$row->transaction_code}');">{$row->transaction_code}</a>
                        {/if}
                        {if $row->invoice_ack_status == 'INA'}
                            <span class="badge badge-success" data-toggle="popover" data-content="<b>Invoice Acknowledgement Completed<b>" style="font-size: 9px;cursor:pointer;">C</span>
                        {/if}
                    </td>
                    <td align="left">{$row->transaction_date|date_format:$ns_date_format}</td>
                    <td align="left">
                        {if $row->transaction_start_date != '' || $row->transaction_end_date != ''}
                            {$row->transaction_start_date|date_format:$ns_date_format} to {$row->transaction_end_date|date_format:$ns_date_format}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="left">
                        {if $row->transaction_mode == 'ADV'}
                            Advance Payment
                        {else}
                            {$transactionMode[$row->transaction_mode]}
                        {/if}
                    </td>
                    <td align="left">{$row->user_name}</td>
                    <td align="left">{$row->remarks}</td>
                    <td align="right">{($row->transaction_amount + $row->tds_tax_amount + $row->adjustment_amount)|number_format:2}</td>

                    <td align="right">{($row->paid_amount)|number_format:2}</td>
                    <td align="right">{($row->tds_tax_amount)|number_format:2}</td>
                    <td align="right">{($row->adjustment_amount)|number_format:2}</td>
                    <td align="right">{($row->paid_amount + $row->tds_tax_amount + $row->adjustment_amount)|number_format:2} <a href="javascript:;" onclick="showPaidPartialInfo('{$row->transaction_code}');"><i class="fa fa-info-circle" aria-hidden="true"></i></a></td>
                </tr>
                {assign var="totalInvoice" value=$totalInvoice + ($row->transaction_amount + $row->tds_tax_amount + $row->adjustment_amount)}
                {assign var="totalPaid" value=$totalPaid + $row->paid_amount}
                {assign var="totalTDS" value=$totalTDS + $row->tds_tax_amount}
                {assign var="totalAdjustment" value=$totalAdjustment + $row->adjustment_amount}
                {assign var="totalTotalPaid" value=$totalTotalPaid + $row->paid_amount + $row->tds_tax_amount + $row->adjustment_amount}
            {foreachelse}
                <tr>
                    <td colspan="11" align="center">No Records Found!</td>
                </tr>
            {/foreach}

            {if $result|count}
                <tr class="bold">
                    <td colspan="6" align="right">Total:</td>
                    <td align="right">{$totalInvoice|number_format:2}</td>
                    <td align="right">{$totalPaid|number_format:2}</td>
                    <td align="right">{$totalTDS|number_format:2}</td>
                    <td align="right">{$totalAdjustment|number_format:2}</td>
                    <td align="right">{$totalTotalPaid|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>

<script>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>