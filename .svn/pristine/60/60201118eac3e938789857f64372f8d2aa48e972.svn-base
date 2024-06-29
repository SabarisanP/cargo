<table border='1'>
    <tr>
        <td colspan="8" align="center"><b>Transactions For {$username}</b></td>
    </tr>
    <tr>
        <td colspan="4"><b>Report Date : </b> {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format}</td>
        <td align="right" colspan="4"><b>Report At : </b> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
        <td align="right" colspan="4"><b>Report By : </b> {$usr_login_name} </td>
    </tr>
</table>

<table border="1">
    <thead>
        <tr>
            <th colspan="2">Account Summary</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="2">Opening Balance (A)</td>
            {assign var="opening" value=$first_trans->closingBalance - $first_trans->creditAmount + $first_trans->debitAmount}
            <td align="right">{$opening|inr_format}</td>
        </tr>
        <tr>
            <td colspan="2">Credit Amount (B)</td>
            <td align="right">{$credit_amount|inr_format}</td>
        </tr>
        <tr>
            <td colspan="2">Debit Amount (C)</td>
            <td align="right">{$debit_amount|inr_format}</td>
        </tr>
        <tr>
            <td colspan="2">Closing Balance (D)</td>
            {assign var="closing" value=$last_trans->closingBalance}
            <td align="right">{$closing|inr_format}</td>
        </tr>
        <tr>
            <th colspan="2">Balance Due	 (D - A)</th>
            <td align="right">{($closing - $opening)|inr_format}</td>
        </tr>
    </tbody>
</table>

<table border="1">
    <thead>
        <tr>
            <th>#</th>
            <th>Transaction Date</th>
            <th>Details</th>
            <th>Credit Amount</th>
            <th>Debit Amount</th>
            <th>Closing Balance</th>
        </tr>
    </thead>
    <tbody>

        {foreach item=row from=$reports key =k}
            <tr>
                <td align="left">{$k+1}</td>
                <td align="left">{$row->transactionDate|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->description}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->creditAmount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->debitAmount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->closingBalance}</td>
            </tr>
        {/foreach}

    </tbody>
</table>
