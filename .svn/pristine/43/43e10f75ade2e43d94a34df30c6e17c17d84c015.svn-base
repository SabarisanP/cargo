<table width="100%" border="1">
    <tr>
        <td  colspan="8" align="center"><span style="font-weight:bold">{iflang('Pending GC Dispatch Report')}</span></td>
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

{function name="summtable" data=[]}
    <table width="500px" border="1">
        <thead>
            <tr style="background-color:#64b92a; color: #fff;">
                <td>Branch</td>
                <td>No.of {lang('lr')}</td>
                <td>No. Of Articles</td>
                <td>Paid Booking</td>
                <td>ToPay Booking</td>
                <td>OnAccount Booking</td>
                <td>Freight (A)</td>
                <td>{lang('other_charges')} (B)</td>
                <td>Net Amount (A+B)</td>
            </tr>
        </thead>
        <tbody>
            
            {assign var=total_gc value=0}
            {assign var=total_article value=0}
            {assign var=total_freight value=0}
            {assign var=total_other_charges value=0}
            {assign var=total_paid value=0}
            {assign var=total_topay value=0}
            {assign var=total_onaccount value=0}
            {assign var=total_net_amount value=0}

            {foreach item=row from=$data key=org}
                <tr>
                    <td align="left">{$org}</td>
                    <td align="center">{$row['booked_count']}</td>
                    <td align="center">{$row['article_count']}</td>
                    <td align="right">{$row['paid']|number_format:2}</td>
                    <td align="right">{$row['topay']|number_format:2}</td>
                    <td align="right">{$row['invoicepay']|number_format:2}</td>
                    <td align="right">{$row['freight']|number_format:2}</td>
                    <td align="right">{$row['other_charges']|number_format:2}</td>
                    <td align="right">{($row['other_charges'] + $row['freight'])|number_format:2}</td>
                    {assign var=t_total_org_count value=$t_total_org_count + $count}
                    
                    {assign var=total_freight value=$total_freight+$row['freight']}
                    {assign var=total_article value=$total_article+$row['article_count']}
                    {assign var=total_other_charges value=$total_other_charges+$row['other_charges']}
                    {assign var=total_paid value=$total_paid+$row['paid']}
                    {assign var=total_topay value=$total_topay+$row['topay']}
                    {assign var=total_onaccount value=$total_onaccount+$row['invoicepay']}
                    {assign var=total_net_amount value=$total_net_amount+$row['other_charges']+$row['freight']}
                    {assign var=total_gc value=$total_gc+$row['booked_count']}
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="9" align="center">No Records Found</td>
                </tr>
            {/foreach}

            {if $summary|count}
                <tr style="background-color: #bbbbbb; color: #fff;">
                    <td align="right">Total</td>
                    <td align='center'>{$total_gc}</td>
                    <td align='center'>{$total_article}</td>
                    <td align='right'>{$total_paid|number_format:2}</td>
                    <td align='right'>{$total_topay|number_format:2}</td>
                    <td align='right'>{$total_onaccount|number_format:2}</td>
                    <td align='right'>{$total_freight|number_format:2}</td>
                    <td align='right'>{$total_other_charges|number_format:2}</td>
                    <td align='right'>{$total_net_amount|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
    <br/>
{/function}

<div class="col-md-9 p_l_n">
    {summtable data=$summary}
</div>
<br/>

<table>
    {foreach item=station from=$summary key=t}
        <tr class="{$station['stationcode']} drilldowndata">
            <td>
                {summtable data=$station['branches']}
            </td>
        </tr>
    {/foreach}
</table>
<br/>

<table border="1">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <td>S.No</td>
            <td>Date Of Booking</td>
            <td>{lang('lr')} Number</td>
            <td>No. Of Articles</td>
            <td>{lang('booking_article_label')}</td>
            <td>{lang('booking_sender_term')} Name</td>
            <td>{lang('booking_sender_term')} Contact Number</td>
            <td>{lang('booking_receiver_term')} Name</td>
            <td>{lang('booking_receiver_term')} Contact Number</td>
            <td>Payment Mode</td>
            <td>Net Amount</td>
        </tr>
    </thead>
    <tbody>
        {assign var=t_total_amount value=0}

        {foreach item=row from=$result key=i}
            <tr>
                <td align="left">{$i + 1}</td>
                <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->cargo_code}</td>
                <td align="left">{$row->item_count}</td>
                <td align="left">{$row->cargo_item_name}</td>
                <td align="left">{$row->from_customer_name}</td>
                <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                <td align="left">{$row->to_customer_name}</td>
                <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                <td align="left">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                <td align="right">{($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)|inr_format}</td>
            </tr>

            {assign var=t_total_amount value=$t_total_amount + $row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
        {foreachelse}
            <tr>
                <td colspan="11" align="center">No Records Found</td>
            </tr>
        {/foreach}
        {if $result|count}
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="10" align="right">Total</td>
                <td align='right'>{($t_total_amount)|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>