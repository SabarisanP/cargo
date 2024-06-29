<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>Cargo Edit Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
    </tr>
</table>
<br/>

<div class="table-responsive">
    <table border='1'>
        <thead>
            <tr style="background-color: #64b92a; color: #fff;">
                <th align="left">{lang('cargo_code_term')}</th>
                <th align="left">From - To Station</th>
                <th align="left">Booked At</th>
                <th align="left">Payment Status</th>
                <th align="left">Cargo Status</th>
                <th align="right">Total Item Count</th>
                <th align="right">Total Amount</th>
                <th align="left">Edited At</th>
                <th align="left">Booked By</th>
                <th align="left">Edited By</th>
                <th align="left">Edited Event</th>
            </tr>
        </thead>
        <tbody>
            {assign var=t_total_item_count value=0}
            {assign var=t_total_amount value=0}

            {foreach item=row from=$result}
                <tr>
                    <td align="left">{$row->cargo_code}</td>
                    <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                    <td align="center">{$cargo_status[$row->cargo_status_code]}</td> 
                    <td align="right">{$row->total_item_count}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                    <td align="left">{$row->edited_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->edited_user_first_name}</td>
                    <td align="left">{$row->event}</td>
                </tr>

                {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
                {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr style="background-color: #bbbbbb; color: #fff;">
                    <td colspan="5" align="right">Total</td>
                    <td align='right'>{$t_total_item_count}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_amount}</td>
                    <td colspan="4" align="right"></td>
                </tr>
            </tfoot>
        {else}
            <tfoot>
                <tr>
                    <td colspan="11" align="center">No Records Found</td>
                </tr>
            </tfoot>
        {/if}
    </table>
</div>