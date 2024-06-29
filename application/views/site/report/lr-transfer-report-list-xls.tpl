<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><b>Lr Transfer Report</b></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Date :</span>{$fromDate|date_format:$ns_date_format} To {$toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
<br>
<table border="1">
    <thead>
        <tr style="background-color:#92d050; color: #0000; font-weight: bold;">
            <td align="center">S.No</td>
            <td align="center">GCN No</td>
            <td align="center">GCN Date</td>
            <td align="center">luggage List No</td>
            <td align="center">Consigner Name</td>
            <td align="center">Consignee Name</td>
            <td align="center">From Location</td>
            <td align="center">To Location</td>
            <td align="center">Mode Of Payment</td>
            <td align="center">No Of Packages</td>
            <td align="center">Amount</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=sno value=0}
        {assign var=t_lr_amt value=0}
        {assign var=t_item_count value=0}
        {foreach item=val from=$result}
            {assign var=t_lr_amt value=$t_lr_amt+$val->total_amount}
            {assign var=t_item_count value=$t_item_count+$val->total_item_count}
            {assign var=sno value=$sno+1}
            <tr>
                <td align="center">{$sno}</td>
                <td align="center">{$val->cargo_code}</td>
                <td align="center">{$val->booked_at|date_format:$ns_date_format}</td>
                <td align="center">{$val->alias_code}</td>
                <td align="center">{$val->cargo_from_customer_name}</td>
                <td align="center">{$val->cargo_to_customer_name}</td>
                <td align="center">{$val->cargo_from_organization_name}</td>
                <td align="center">{$val->cargo_to_organization_name}</td>
                <td align="center">{$cargo_payment_status[$val->payment_type_code]}</td>
                <td align="center">{$val->total_item_count}</td>
                <td align="center">{$val->total_amount|number_format:2}</td>
            </tr>
        {/foreach}
    </tbody>
    {if count($result) >0}
        <tr class="bold">
            <td align="right" colspan="9">Total</td>
            <td align="center">{$t_item_count}</td>
            <td align="center">{$t_lr_amt|number_format:2}</td>
        </tr>
    {/if}
</table>