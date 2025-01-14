<h5>Summary</h5>
<div class="table-responsive col-md-5 p_l_n">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Vendor</th>
                <th align="center">Branch</th>
                <th align="center">Invoice Amount</th>
                <th align="center">Paid Amount</th>
                <th align="center">Balance Amount</th>
            </tr>
        </thead>
        <tbody>
            {assign var="transactionAmount" value=0}
            {assign var="partialPaymentAmount" value=0}
            {assign var="balanceAmountTotal" value=0}
            {assign var="balanceAmount" value=0}

            {foreach item=row from=$summary key=key}
                {assign var="balanceAmount" value=$row['transactionAmount'] - $row['partialPaymentAmount']}
                <tr>
                    <td class="bold">{$key}</td>
                    <td>{$row['branch']}</td>
                    <td align="right">{$row['transactionAmount']|number_format:2}</td>
                    <td align="right">{$row['partialPaymentAmount']|number_format:2}</td>
                    <td align="right">{$balanceAmount|number_format:2}</td>
                </tr>
                {assign var="transactionAmount" value=$transactionAmount + $row['transactionAmount']}
                {assign var="partialPaymentAmount" value=$partialPaymentAmount + $row['partialPaymentAmount']}
                {assign var="balanceAmountTotal" value=$balanceAmountTotal + $balanceAmount}
            {foreachelse}
                <tr>
                    <td colspan="5" align="center">No Records Found!</td>
                </tr>
            {/foreach}

            {if $summary|count}
                <tr class="bold">
                    <td align="right" colspan="2">Total</td>
                    <td align="right">{$transactionAmount|number_format:2}</td>
                    <td align="right">{$partialPaymentAmount|number_format:2}</td>
                    <td align="right">{$balanceAmountTotal|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
<br/>
<div class="clearfix"></div>
<h5>Invoices</h5>
<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Invoice No</th>
                <th align="center">Vendor</th>
                <th align="center">Branch</th>
                <th align="center">Created Date</th>
                <th align="center">Created By</th>
                <th align="center">Invoice Peroid</th>
                {* <th align="center">Transaction Mode</th> *}
                <th align="center">Invoice Amount</th>
                {* <th align="center">Paid Amount</th> *}
                <th align="center">Balance Amount</th>
                <th align="center">Remarks</th>
                <th align="center"></th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=branch from=$result key=key}
                <tr class="bold active">
                    <td colspan="10" align="center">{$key}</td>
                </tr>
                {foreach item=row from=$branch}
                    <tr id="vou_{$row->code|clean_string}">
                        <td align="left">
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
                        <td align="left">{$row->user->organization->name}</td>
                        <td align="left">{$row->transactionDate|date_format:$ns_date_format}</td>
                        <td align="left">{$row->paymentHandledBy->name}</td>
                        <td align="left">
                            {if $row->transactionStartDate != '' || $row->transactionEndDate != ''}
                                {$row->transactionStartDate|date_format:$ns_date_format} to {$row->transactionEndDate|date_format:$ns_date_format}
                            {else}
                                -
                            {/if}
                        </td>
                        {* <td align="left">{$row->transactionMode->name}</td> *}
                        <td align="right">{$row->transactionAmount|number_format:2}</td>
                        {* <td align="right">{$row->partialTransactionAmount|number_format:2} {if $row->acknowledgeStatus->code == 'PAPAID'}<a href="javascript:;" onclick='showUnpaidPartialInfo(`{$row->partialPaymentList|json_encode}`);'><i class="fa fa-info-circle" aria-hidden="true"></i></a>{/if}</td> *}
                        <td align="right">{($row->transactionAmount-$row->partialTransactionAmount)|number_format:2}</td>
                        <td align="left">{$row->remarks}</td>
                        <td align="right">
                            {if $cargo_setting->userAccountModel->code == 'TXRT'}
                                {if $row->additionalAttributes->CUSTOMER_INVOICE_ACK_STATUS == 1}
                                    <button class="btn-app btn-success" type="button" onclick="payInvoice('{$row->code}');">Update Paid</button>
                                {else}
                                    <a href="javascript:;" data-toggle="popover" data-content="<b>Invoice Acknowledgement Pending<b>" style="cursor:pointer;"><i class="fa fa-info-circle" aria-hidden="true"></i></a>&nbsp;
                                {/if}
                            {else}
                                <button class="btn-app btn-success" type="button" onclick="payInvoice('{$row->code}');">Update Paid</button>
                            {/if}
                            <button class="btn-app btn-danger" type="button" onclick="rejectInvoice('{$row->code}');">Reject</button>
                        </td>
                    </tr>
                {/foreach}
            {foreachelse}
                <tr>
                    <td colspan="10" align="center">No Records Found!</td>
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