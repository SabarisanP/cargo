<table border="1">
    <tr style="font-weight: bold">
        <td  colspan="10" align="center">Voucher Due Report</td>
    </tr>
    <tr style="font-weight: bold">
        <td colspan="3">From  {$smarty.request.fromDate|date_format:$ns_date_format}  To {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="4" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>
<br>

<table border='1'>
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <th rowspan="2">Group</th>
            <th rowspan="2">User</th>

            <th colspan="6" align='center'>Booking</th>
            <th colspan="9" align='center'>Cancellation</th>

            <th rowspan="2">Net Payable</th>
        </tr>
        <tr style="background-color:#64b92a; color: #fff;">
            <th>Seats</th>
            <th>Fare</th>
            <th>Discount</th>
            <th>GST</th>
            <th>Commission</th>
            <th>Gross Amount</th>

            <th>Seats</th>
            <th>Fare</th>
            <th>Discount</th>
            <th>GST</th>
            <th>Revoke</th>
            <th>Cancel Charges</th>
            <th>Agent Share</th>
            <th>Refund</th>
            <th>Revenue</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=b_seat_count value=0}
        {assign var=b_fare value=0}
        {assign var=b_discount value=0}
        {assign var=b_gst value=0}
        {assign var=b_commission value=0}
        {assign var=b_crossamount value=0}

        {assign var=c_seat_count value=0}
        {assign var=c_fare value=0}
        {assign var=c_discount value=0}
        {assign var=c_gst value=0}
        {assign var=c_revoke value=0}
        {assign var=c_cancellation_charges value=0}
        {assign var=c_agent_share value=0}
        {assign var=c_refund value=0}
        {assign var=c_revenue value=0}
        {assign var=c_payable value=0}
        {foreach item=row from=$bookings key=t}
            <tr>
                <td>{$row['group']}</td>
                <td>{$row['name']}</td>

                <td align='right'>{$row['booking']['seats']}</td>
                <td align='right'>{$row['booking']['fare']|inr_format}</td>
                <td align='right'>{$row['booking']['discount']|inr_format}</td>
                <td align='right'>{$row['booking']['gst']|inr_format}</td>
                <td align='right'>{$row['booking']['commission']|inr_format}</td>
                <td align='right'>{$row['booking']['crossamount']|inr_format}</td>

                <td align='right'>{$row['cancel']['seats']}</td>
                <td align='right'>{$row['cancel']['fare']|inr_format}</td>
                <td align='right'>{$row['cancel']['discount']|inr_format}</td>
                <td align='right'>{$row['cancel']['gst']|inr_format}</td>
                <td align='right'>{$row['cancel']['revoke']|inr_format}</td>
                <td align='right'>{$row['cancel']['cancellation_charges']|inr_format}</td>
                <td align='right'>{$row['cancel']['agent_share']|inr_format}</td>
                <td align='right'>{$row['cancel']['refund']|inr_format}</td>
                <td align='right'>{$row['cancel']['revenue']|inr_format}</td>

                {assign var="cancels" value=$row['cancel']['fare']-$row['cancel']['discount']+$row['cancel']['gst']-$row['cancel']['revoke']}
                <td align='right'>{($row['booking']['crossamount']-$cancels+$row['cancel']['revenue'])|inr_format}</td>

                {assign var=b_seat_count value=$b_seat_count+$row['booking']['seats']}
                {assign var=b_fare value=$b_fare+$row['booking']['fare']}
                {assign var=b_discount value=$b_discount+$row['booking']['discount']}
                {assign var=b_gst value=$b_gst+$row['booking']['gst']}
                {assign var=b_commission value=$b_commission+$row['booking']['commission']}
                {assign var=b_crossamount value=$b_crossamount+$row['booking']['crossamount']}

                {assign var=c_seat_count value=$c_seat_count+$row['cancel']['seats']}
                {assign var=c_fare value=$c_fare+$row['cancel']['fare']}
                {assign var=c_discount value=$c_discount+$row['cancel']['discount']}
                {assign var=c_gst value=$c_gst+$row['cancel']['gst']}
                {assign var=c_revoke value=$c_revoke+$row['cancel']['revoke']}
                {assign var=c_cancellation_charges value=$c_cancellation_charges+$row['cancel']['cancellation_charges']}
                {assign var=c_agent_share value=$c_agent_share+$row['cancel']['agent_share']}
                {assign var=c_refund value=$c_refund+$row['cancel']['refund']}
                {assign var=c_revenue value=$c_revenue+$row['cancel']['revenue']}
                {assign var=c_payable value=$c_payable+($row['booking']['crossamount']-$cancels+$row['cancel']['revenue'])}
            </tr>
        {foreachelse}
            <tr>
                <td colspan="17" align="center">No data found</td>
            </tr>
        {/foreach}
        <tr>
            <td align='right' colspan="2" style="font-weight: bold;">Total</td>
            <td align='right' style="font-weight: bold;">{$b_seat_count}</td>
            <td align='right' style="font-weight: bold;">{$b_fare|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$b_discount|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$b_gst|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$b_commission|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$b_crossamount|inr_format}</td>

            <td align='right' style="font-weight: bold;">{$c_seat_count}</td>
            <td align='right' style="font-weight: bold;">{$c_fare|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$c_discount|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$c_gst|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$c_revoke|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$c_cancellation_charges|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$c_agent_share|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$c_refund|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$c_revenue|inr_format}</td>
            <td align='right' style="font-weight: bold;">{$c_payable|inr_format}</td>
        </tr>
    </tbody>
</table>