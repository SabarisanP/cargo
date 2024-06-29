<table class="" width="95%">
    <tr>
        <td colspan="6" align="center"><b>Pending & Current Door Delivery Report</b>
    </tr>
    <tr>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="left"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<table border="2">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td>S.No</td>
            <td>NAME</td>
            <td>FROM PLACE</td>
            <td>LR DATE</td>
            <td>ARTICLES</td>
            <td>LR NO</td>
            <td>MODE OF PAYMENT</td>
            <td>TAKEN BY VEHICLENO</td>
            <td>BILLCOLLECTION</td>
            <td>AMOUNT</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=t_total_amount value=0}
        {foreach item=row from=$details key=i}
            <tr>
                <td align="left">{$i + 1}</td>
                <td align="center">{$row->from_customer_name}</td>
                <td align="center">{$row->from_station_name}</td>
                <td align="center">{$row->booked_at|date_format:$ns_date_format}</td>
                <td align="center">{$row->articles}</td>
                <td align="center">{$row->cargo_code}</td>
                <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                <td align="center">{$row->registration_number}</td>
                <td align="center">{$row->bill_collection}</td>
                <td align="right">{$row->total_amount|inr_format}</td>
            </tr>
            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
        {foreachelse}
            <tr>
                <td colspan="12" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
    <tfoot>
        <tr class="active bold">
            <td colspan="9" align="right">Total</td>
            <td align='right'>{$t_total_amount|inr_format}</td>
        </tr>
    </tfoot>
</table>