<table width="100%" border="1">
    <tr>
        <td  colspan="8" align="center"><span style="font-weight:bold">{iflang('Pending GC Delivery Report')}</span></td>
    </tr>
    <tr>
        <td colspan="4">
            <span style="font-weight:bold">Report Date : </span> 
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="4" align="right"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="8" align="right"><span style="font-weight:bold">Report By : </span> {$username} </td>
    </tr>
</table> 
<br/>

<div class="col-md-4 p_l_n">
    <table width="300px" border="1">
        <thead>
            <tr style="background-color:#64b92a; color: #fff;">
                <td>Transit Branch Name</td>
                <td>No.of {lang('lr')}</td>
            </tr>
        </thead>
        <tbody>
            {assign var=t_total_org_count value=0}
            {foreach item=count from=$summary['booked_count'] key=org}
                <tr>
                    <td align="left">{$org}</td>
                    <td align="right">{$count}</td>
                    {assign var=t_total_org_count value=$t_total_org_count + $count}
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="2" align="center">No Records Found</td>
                </tr>
            {/foreach}

            {if $summary['booked_count']|count}
                <tr style="background-color: #bbbbbb; color: #fff;">
                    <td align="right">Total</td>
                    <td align='right'>{$t_total_org_count}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
<br/>

<table border="1">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td>S.No</td>
            <td>Date Of Unloading</td>
            <td>{lang('lr')} Number</td>
            <td>No. Of Articles</td>
            <td>{lang('booking_article_label')}</td>
            <td>{lang('booking_sender_term')} Name</td>
            <td>{lang('booking_sender_term')} Contact Number</td>
            <td>{lang('booking_receiver_term')} Name</td>
            <td>{lang('booking_receiver_term')} Contact Number</td>
            <td>Type Of Delivery</td>
            <td>Payment Mode</td>
            <td>Freight Amount</td>    
        </tr>
    </thead>
    <tbody>
        {assign var=t_total_amount value=0}

        {foreach item=row from=$result key=i}
            <tr>
                <td align="left">{$i + 1}</td>
                <td align="left">{if isNotNull($row->unloaded_at)}{$row->unloaded_at|date_format:$ns_datetime_format}{else}-{/if}</td>
                <td align="left">{$row->cargo_code}</td>
                <td align="left">{$row->item_count}</td>
                <td align="left">{$row->cargo_item_name}</td>
                <td align="left">{$row->from_customer_name}</td>
                <td align="left">{$row->from_customer_mobile}</td>
                <td align="left">{$row->to_customer_name}</td>
                <td align="left">{$row->to_customer_mobile}</td>
                <td align="left">{$delivery_type_codes[$row->delivery_type_code]}</td>
                <td align="left">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                <td align="right">{$row->total_amount|inr_format}</td>
            </tr>

            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
        {foreachelse}
            <tr>
                <td colspan="12" align="center">No Records Found</td>
            </tr>
        {/foreach}
        {if $result|count}
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="11" align="right">Total</td>
                <td align='right'>{($t_total_amount)|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>