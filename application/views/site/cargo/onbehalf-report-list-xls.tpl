<table class="" width="99%" border='1'>
    <tr>
        <td colspan="8" align="center"><span style="font-weight:bold">On Behalf Of Booking and delivery Report</span></td>
    </tr>
    <tr>
        <td width="50%"  colspan="4">
            <span style="font-weight:bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%" colspan="4">&nbsp;</td>
        <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<div class="table-responsive col-md-5 p_l_n">
    <table border='1'>
        <thead>
            <tr style="background-color: #64b92a">
                <td align="center">{lang('cargo_code_term')}</td>
                <td align="center">Booked Date</td>
                <td align="center">{lang('booking_from_term')}</td>
                <td align="center">{lang('booking_to_label')}</td>
                {if $filterType == 'BOOKING'}
                    <td align="center">Booked By</td>
                    <td align="center">Booked Onbehalf User</td>
                    <td align="center">Delivered Onbehalf User</td>
                {else}
                    <td align="center">Onbehalf User</td>
                    <td align="center">Onbehalf Updated By</td>
                {/if}
                <td align="center">{lang('booking_sender_term')}</td>
                <td align="center">{lang('booking_receiver_term')}</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>
                <td align="center">Qty</td>
                <td align="center">Freight</td>
            </tr>

        </thead>
        <tbody class="body_table" >

            {assign var=tot_fare value=0}
            {assign var=tot_items value=0}

            {foreach item=row from=$result key=t}
                <tr>
                    <td align="center">{$row->cargo_code}</td>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    {if $filterType == 'BOOKING'}
                        <td align="left">{$row->booked_user_name}</td>
                        <td align="left">{$row->booked_offline_user_name|default:'-'}</td>
                        <td align="left">{$row->delivered_offline_user_name|default:'-'}</td>
                    {else}
                        <td align="left">{$row->payment_offline_user_name|default:'-'}</td>
                        <td align="left">{$row->payment_user_name|default:'-'}</td>
                    {/if}
                    <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="center">
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="center">{$row->total_item_count}</td>
                    <td align="right">{$row->total_amount|number_format:2}</td>
                </tr>

                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
            {/foreach}

            <tr class="active">
                <td align="right" colspan="{if $filterType == 'BOOKING'}11{else}10{/if}" class="bold">Total</td>
                <td align="center" class="bold">{$tot_items}</td>
                <td align="right" class="bold">{$tot_fare|number_format:2}</td>
            </tr>  

        </tbody>
    </table>
</div>