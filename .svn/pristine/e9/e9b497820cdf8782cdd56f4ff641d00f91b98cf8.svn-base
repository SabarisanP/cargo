<table class="" width="99%" border='1'>
    <tr>
        <td colspan="10" align="center"><span style="font-weight:bold">Cargo Sales Summary Report</span></td>
    </tr>
    <tr>
        <td colspan="5">
            <span style="font-weight:bold">Report Date : </span>
            {$fromDate|date_format:$ns_date_format}  to {$toDate|date_format:$ns_date_format} </td>
        <td colspan="5" align="right"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td colspan="5" align="right"><span style="font-weight:bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<table border='1' width="99%">
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <th align="center">User</th>
            <th align="center">Freight</th>
            <th align="center">Delivery Charges</th>
            <th align="center">Loading Charges</th>
            <th align="center">Unloading Charges</th>
            <th align="center">Pickup Charges</th>
            <th align="center">Service Charges</th>
            <th align="center">Service Tax</th>
            <th align="center">Amount Paid</th>
            
            <th align="center">Sub Total</th>
            <th align="center">Commission</th>
            <th align="center">Net Payable</th>
        </tr>
    </thead>
    <tbody>
        {assign var=delivery_handling_amount value=0}
        {assign var=transaction_amount value=0}
        {assign var=total_handling_amount value=0}
        {assign var=total_unload_handling_amount value=0}
        {assign var=pickup_handling_amount value=0}
        {assign var=service_charge value=0}
        {assign var=service_tax value=0}
        {assign var=total_amount_paid value=0}
        {assign var=total_amount value=0}
        {assign var=total_commission value=0}
        {assign var=net_payable value=0}

        {foreach item=row from=$result}
            <tr>
                <td align="left">{$row->user_first_name}</td>
                <td align="right">{$row->total_amount|number_format:2}</td>
                <td align="right">{$row->delivery_handling_amount|number_format:2}</td>
                <td align="right">{$row->total_handling_amount|number_format:2}</td>
                <td align="right">{$row->total_unload_handling_amount|number_format:2}</td>
                <td align="right">{$row->pickup_handling_amount|number_format:2}</td>
                <td align="right">{$row->service_charge|number_format:2}</td>
                <td align="right">{$row->service_tax|number_format:2}</td>
                <td align="right">{$row->total_amount_paid|number_format:2}</td>
                
                <td align="right">{$row->transaction_amount|number_format:2}</td>
                <td align="right">{($row->commission_amount+$row->handling_commission_amount)|number_format:2}</td>
                <td align="right">{($row->total_amount-$row->commission_amount-$row->handling_commission_amount)|number_format:2}</td>
            </tr>
            {assign var=transaction_amount value=$transaction_amount + $row->transaction_amount}
            {assign var=delivery_handling_amount value=$delivery_handling_amount + $row->delivery_handling_amount}
            {assign var=total_handling_amount value=$total_handling_amount + $row->total_handling_amount}
            {assign var=total_unload_handling_amount value=$total_unload_handling_amount + $row->total_unload_handling_amount}
            {assign var=pickup_handling_amount value=$pickup_handling_amount + $row->pickup_handling_amount}
            {assign var=service_charge value=$service_charge + $row->service_charge}
            {assign var=service_tax value=$service_tax + $row->service_tax}
            {assign var=total_amount_paid value=$total_amount_paid + $row->total_amount_paid}
            {assign var=total_amount value=$total_amount + $row->total_amount}
            {assign var=total_commission value=$total_commission+$row->commission_amount+$row->handling_commission_amount}
            {assign var=net_payable value=$net_payable+$row->total_amount-$row->commission_amount-$row->handling_commission_amount}
        {foreachelse}
            <tr>
                <td colspan="10" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if $result|count}
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td align="right" colspan="1" class="bold">Total</td>
                <td align="right">{$total_amount|number_format:2}</td>
                <td align="right">{$delivery_handling_amount|number_format:2}</td>
                <td align="right">{$total_handling_amount|number_format:2}</td>
                <td align="right">{$total_unload_handling_amount|number_format:2}</td>
                <td align="right">{$pickup_handling_amount|number_format:2}</td>
                <td align="right">{$service_charge|number_format:2}</td>
                <td align="right">{$service_tax|number_format:2}</td>
                <td align="right">{$total_amount_paid|number_format:2}</td>
                <td align="right">{$transaction_amount|number_format:2}</td>
                <td align="right">{$total_commission|number_format:2}</td>
                <td align="right">{$net_payable|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>
