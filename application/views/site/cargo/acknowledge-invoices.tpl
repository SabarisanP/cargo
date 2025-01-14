<h5>Summary</h5>
<div class="table-responsive col-md-8 p_l_n">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Vendor</th>
                <th align="center">Invoice Amount (A)</th>
                <th align="center">Paid Amount (B)</th>
                <th align="center">TDS Amount (C)</th>
                <th align="center">Adjustment Amount (D)</th>
                <th align="center">Total Paid Amount (E=B+C+D)</th>
                <th align="center">Balance Amount (A-E)</th>
            </tr>
        </thead>
        <tbody>
            {assign var="transactionAmount" value=0}
            {assign var="partialPaymentAmount" value=0}
            {assign var="partialTransactionTDSAmount" value=0}
            {assign var="partialTransactionAdjustmentAmount" value=0}
            {assign var="partialTransactionTotalAmount" value=0}
            {assign var="balanceAmountTotal" value=0}
            {assign var="balanceAmount" value=0}

            {foreach item=row from=$summary key=key}
                {assign var="balanceAmount" value=$row['transactionAmount'] - $row['partialTransactionTotalAmount']}
                <tr>
                    <td class="bold">{$key}</td>
                    <td align="right">{$row['transactionAmount']|number_format:2}</td>
                    <td align="right">{$row['partialPaymentAmount']|number_format:2}</td>
                    <td align="right">{$row['partialTransactionTDSAmount']|number_format:2}</td>
                    <td align="right">{$row['partialTransactionAdjustmentAmount']|number_format:2}</td>
                    <td align="right">{$row['partialTransactionTotalAmount']|number_format:2}</td>
                    <td align="right">{$balanceAmount|number_format:2}</td>
                </tr>
                {assign var="transactionAmount" value=$transactionAmount + $row['transactionAmount']}
                {assign var="partialPaymentAmount" value=$partialPaymentAmount + $row['partialPaymentAmount']}
                {assign var="partialTransactionTDSAmount" value=$partialTransactionTDSAmount + $row['partialTransactionTDSAmount']}
                {assign var="partialTransactionAdjustmentAmount" value=$partialTransactionAdjustmentAmount + $row['partialTransactionAdjustmentAmount']}
                {assign var="partialTransactionTotalAmount" value=$partialTransactionTotalAmount + $row['partialTransactionTotalAmount']}
                {assign var="balanceAmountTotal" value=$balanceAmountTotal + $balanceAmount}
            {foreachelse}
                <tr>
                    <td colspan="4" align="center">No Records Found!</td>
                </tr>
            {/foreach}

            {if $summary|count}
                <tr class="bold">
                    <td align="right">Total</td>
                    <td align="right">{$transactionAmount|number_format:2}</td>
                    <td align="right">{$partialPaymentAmount|number_format:2}</td>
                    <td align="right">{$partialTransactionTDSAmount|number_format:2}</td>
                    <td align="right">{$partialTransactionAdjustmentAmount|number_format:2}</td>
                    <td align="right">{$partialTransactionTotalAmount|number_format:2}</td>
                    <td align="right">{$balanceAmountTotal|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
<br/>
<div class="clearfix"></div>
<h5>Invoices</h5>
<div class="table-responsive" style="overflow: auto;">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Invoice No</th>
                <th align="center">Vendor</th>
                <th align="center">Created Date</th>
                <th align="center">Created By</th>
                <th align="center">Invoice Peroid</th>
                <th align="center">Transaction Mode</th>
                <th align="center">Invoice Amount (A)</th>
                <th align="center" width="8%">Paid Amount (B)</th>
                <th align="center" width="8%">TDS Amount (C)</th>
                <th align="center" width="8%">Adjustment Amount (D)</th>
                <th align="center" width="8%">Total Paid Amount (E=B+CD)</th>
                <th align="center" width="6%">Balance Amount (A-E)</th>
                <th align="center">Remarks</th>
                <th align="center"></th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=branch from=$result key=key}
                <tr class="bold active">
                    <td colspan="14" align="center">{$key}</td>
                </tr>
                {foreach item=row from=$branch}
                    <tr id="vou_{$row->code|clean_string}">
                        <td align="left" nowrap>
                            {if $namespace =="seenutransports"}
                                <a href="javascript:;" onclick="view_option_invioce('{$row->code}');">{$row->code}</a>
                            {else}
                                <a href="javascript:;" onclick="showInvoicePdfDialog('{$row->code}');">{$row->code}</a>
                            {/if}
                            {if $row->additionalAttributes->CUSTOMER_INVOICE_ACK_STATUS == 1}
                                <span class="badge badge-success" data-toggle="popover" data-content="<b>Invoice Acknowledgement Completed<b>" style="font-size: 9px;cursor:pointer;">C</span>
                            {/if}
                        </td>
                        <td align="left">{$row->user->name}</td>
                        <td align="left" nowrap>{$row->transactionDate|date_format:$ns_date_format}</td>
                        <td align="left">{$row->paymentHandledBy->name}</td>
                        <td align="left" nowrap>
                            {if $row->transactionStartDate != '' || $row->transactionEndDate != ''}
                                {$row->transactionStartDate|date_format:$ns_date_format} to {$row->transactionEndDate|date_format:$ns_date_format}
                            {else}
                                -
                            {/if}
                        </td>
                        <td align="left">{$row->transactionMode->name}</td>
                        <td align="right">{$row->transactionAmount|number_format:2}</td>
                        <td align="right">{$row->partialTransactionAmount|number_format:2}</td>
                        <td align="right">{$row->partialTransactionTDSAmount|number_format:2}</td>
                        <td align="right">{$row->partialTransactionAdjustmentAmount|number_format:2}</td>
                        <td align="right">{$row->partialTransactionTotalAmount|number_format:2} {if $row->acknowledgeStatus->code == 'PAPAID'}<a href="javascript:;" onclick='showUnpaidPartialInfo(`{$row->partialPaymentList|json_encode}`);'><i class="fa fa-info-circle" aria-hidden="true"></i></a>{/if}</td>
                        <td align="right">{($row->transactionAmount-$row->partialTransactionTotalAmount)|number_format:2}</td>
                        <td align="left">{$row->remarks}</td>
                        <td align="center" nowrap>
                            <button class="btn-app btn-success" type="button" onclick="makePaymentDialog({$row|json_encode|@escape});">Make Payment</button>
                        </td>
                    </tr>
                {/foreach}
            {foreachelse}
                <tr>
                    <td colspan="14" align="center">No Records Found!</td>
                </tr>
            {/foreach}
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