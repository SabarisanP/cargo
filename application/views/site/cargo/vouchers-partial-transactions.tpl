<div style="font-weight:bold;text-align: center;font-size: 12px;">{$namespace_name}</div>
<div style="font-weight:bold;text-align: center;font-size: 10px;">Payment Voucher</div>
<br/><br/>
<table style="padding:5px 4px;">
    <tr>
        <td align="left" style="border: 1px solid #000000;width: 17%;font-weight:bold;">Voucher Code</td>
        <td align="left" style="border: 1px solid #000000;width: 34%;">{$details->code}</td>
        <td align="left" style="border: 1px solid #000000;width: 18%;font-weight:bold;">Transaction Date</td>
        <td align="left" style="border: 1px solid #000000;width: 34%;">{$details->transactionDate|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td align="left" style="border: 1px solid #000000;width: 17%;font-weight:bold;">Amount</td>
        <td align="left" style="border: 1px solid #000000;width: 34%;">Rs. {$details->transactionAmount|number_format:2}</td>
        <td align="left" style="border: 1px solid #000000;width: 18%;font-weight:bold;">Transaction Mode</td>
        <td align="left" style="border: 1px solid #000000;width: 34%;">{$details->transactionMode->name}</td>
    </tr>
    <tr>
        <td align="left" style="border: 1px solid #000000;width: 17%;font-weight:bold;">Paid</td>
        <td align="left" style="border: 1px solid #000000;width: 34%;">Rs.
            {if $details->acknowledgeStatus->code == 'PAID'}
                {$details->transactionAmount|number_format:2}
            {else}
                {assign var=paid value=0}
                {foreach item=row from=$details->partialPaymentList}
                    {assign var=paid value=$paid + $row->transactionAmount}
                {/foreach}
                {$paid|number_format:2}
            {/if}
        </td>
        <td align="left" style="border: 1px solid #000000;width: 18%;font-weight:bold;">Amount Received on</td>
        <td align="left" style="border: 1px solid #000000;width: 34%;">{$details->amountReceivedDate|date_format:$ns_date_format}</td>
    </tr>
    <tr>
        <td align="left" style="border: 1px solid #000000;width: 17%;font-weight:bold;">Acknowledge Status</td>
        <td align="left" style="border: 1px solid #000000;width: 34%;">{$details->acknowledgeStatus->name}</td>
        <td align="left" style="border: 1px solid #000000;width: 18%;font-weight:bold;">Remarks</td>
        <td align="left" style="border: 1px solid #000000;width: 34%;">{$details->remarks}</td>
    </tr>
</table>
<br/>
<h3>Bookings</h3>
<table style="padding:5px 4px;">
    <thead>
        <tr style="font-weight:bold; background-color: #E8E8E8;">
            <th align="center" style="border: 1px solid #000000;width: 10%;">{lang('lr')} No</th>
            <th align="center" style="border: 1px solid #000000;width: 15%;">Booked Date</th>
            <th align="center" style="border: 1px solid #000000;width: 13%;">{lang('booking_from_term')}</th>
            <th align="center" style="border: 1px solid #000000;width: 13%;">{lang('booking_to_label')}</th>
            <th align="center" style="border: 1px solid #000000;width: 12%;">Cargo Status</th>
            <th align="center" style="border: 1px solid #000000;width: 13%;">Payment Status</th>
            <th align="center" style="border: 1px solid #000000;width: 12%;">User</th>
            <th align="center" style="border: 1px solid #000000;width: 5%;">Qty</th>
            <th align="center" style="border: 1px solid #000000;width: 10%;">Payable</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=total value=0}
        {foreach item=row from=$result}
            <tr>
                <td align="left" style="border: 1px solid #000000;width: 10%;">{$row->cargo_code}</td>
                <td align="left" style="border: 1px solid #000000;width: 15%;">{$row->booked_at|date_format:$ns_date_format}</td>
                <td align="left" style="border: 1px solid #000000;width: 13%;">{$row->from_organization_name}</td>
                <td align="left" style="border: 1px solid #000000;width: 13%;">{$row->to_organization_name}</td>
                <td align="left" style="border: 1px solid #000000;width: 12%;">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="left" style="border: 1px solid #000000;width: 13%;">{$cargo_payment_status[$row->payment_status_code]}</td>
                <td align="left" style="border: 1px solid #000000;width: 12%;">{$row->user_name}</td>
                <td align="center" style="border: 1px solid #000000;width: 5%;">{$row->total_item_count}</td>
                <td align="right" style="border: 1px solid #000000;width: 10%;">{($row->transaction_amount-$row->commission_amount)|number_format:2}</td>
            </tr>
            {assign var=total value=$total+($row->transaction_amount-$row->commission_amount)}
        {foreachelse}
            <tr>
                <td colspan="9" align="center" style="border: 1px solid #000000;width: 103%;">No Records Found!</td>
            </tr>
        {/foreach}
        {if $result|count}
            <tr style="font-weight:bold;">
                <td colspan="8" align="right" style="border: 1px solid #000000;">Total:</td>
                <td align="right" style="border: 1px solid #000000;">{$total|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>