<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>Collection Report (Transaction Based)</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
    </tr>
</table>

<table border="1">
    <thead>
        <tr style="background-color: #64b92a;">
            <th align="left">Branch</th>
            {foreach item=amount from=$paytypesummary key=paytype}
                <th>{$cargo_payment_status[$paytype]}</th>
            {/foreach}
            <th align="right">Commission</th>
            <th align="right">Payable Amount (P+TPD-C)</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_transaction_amount value=0}
        {assign var=t_commission_amount value=0}
        {assign var=t_handling_commission_amount value=0}

        {foreach item=row from=$branchwise key=branchcode}
            <tr>
                <td align="left">{$row['payment_organization_name']}</td>
                {assign var="toal_amount" value=0}
                {foreach item=amount from=$paytypesummary key=paytype}
                    <td align="right" data-format="{$xlformat['currency']}">{($row['paytypewise'][$paytype]['transaction_amount'] + 0)}</td>
                    {assign var="toal_amount" value=$toal_amount + ($row['paytypewise'][$paytype]['transaction_amount'] + 0)}
                {/foreach}
                <td align="right" data-format="{$xlformat['currency']}">{$row['commission_amount']}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($toal_amount - $row['commission_amount'])}</td>
            </tr>

            {assign var=t_transaction_amount value=$t_transaction_amount + $row['transaction_amount']}
            {assign var=t_commission_amount value=$t_commission_amount + $row['commission_amount']}
            {assign var=t_handling_commission_amount value=$t_handling_commission_amount + $row['handling_commission_amount']}
        {/foreach}
    </tbody>
    {if $branchwise|count}
        <tfoot>
            <tr style="background-color:#bbbbbb; color: #fff;">
                <td colspan="1" align="right">Total</td>
                {assign var="toal_amount" value=0}
                {foreach item=amount from=$paytypesummary key=paytype}
                    <td align="right" data-format="{$xlformat['currency']}">{($amount + 0)}</td>
                    {assign var="toal_amount" value=$toal_amount + ($amount + 0)}
                {/foreach}
                <td align='right' data-format="{$xlformat['currency']}">{$t_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($toal_amount - $t_commission_amount)}</td>
            </tr>
        </tfoot>
    {/if}
</table>