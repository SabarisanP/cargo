<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Branch Due Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <b>From</b>  {$smarty.request.from|date_format:$ns_date_format}  <b>To</b> {$smarty.request.to|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>

<h5><b>Summary</b></h5>
<table class="table table-bordered" style="width:30%;">
    <tr>
        <th align="center">Branch</th>
        <th align="center">Items</th>
        <th align="center">Net Payable</th>
        <th align="center">Paid</th>
        <th align="center">To Pay</th>
    </tr>
    {assign var=t_i value=0}
    {assign var=t_np value=0}
    {assign var=t_tp value=0}
    {assign var=t_p value=0}
    {foreach item=row key=branch from=$summary}
        <tr>
            <td align="left">{$branch}</td>
            <td align="right">{$row['items']}</td>
            <td align="right">{$row['netPayable']|number_format:2}</td>
            <td align="right">{$row['paid']|number_format:2}</td>
            <td align="right">{$row['toPay']|number_format:2}</td>
        </tr>
        {assign var=t_i value=$t_i + $row['items']}
        {assign var=t_np value=$t_np + $row['netPayable']}
        {assign var=t_tp value=$t_tp + $row['toPay']}
        {assign var=t_p value=$t_p + $row['paid']}
    {/foreach}
    {if $result|count}
        <tr class="bold">
            <td align="right">Total</td>
            <td align="right">{$t_i}</td>
            <td align="right">{$t_np|number_format:2}</td>
            <td align="right">{$t_p|number_format:2}</td>
            <td align="right">{$t_tp|number_format:2}</td>
        </tr>
    {/if}
</table>    
<h5><b>Transactions</b></h5>
<table id="branch_due_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center">{lang('cargo_code_term')}</th>
            <th align="center">Booked Date</th>
            <th align="center">From Station</th>
            <th align="center">To Station</th>
            <th align="center">From Customer</th>
            <th align="center">To Customer</th>
            <th align="center">User</th>
            <th align="center">Organization</th>
            <th align="center">Payment Status</th>
            <th align="center">Cargo Status</th>
            <th align="center">Delivered By</th>
            <th align="center">Delivered At</th>
            <th align="center">Qty</th>
            <th align="center">Net Payable</th>
            <th align="center">Paid</th>
            <th align="center">To Pay</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_total_item_count value=0}
        {assign var=t_service_charge value=0}
        {assign var=t_service_tax value=0}
        {assign var=t_delivery_handling_amount value=0}
        {assign var=t_total_handling_amount value=0}
        {assign var=t_total_unload_handling_amount value=0}
        {assign var=t_pickup_handling_amount value=0}
        {assign var=t_total_amount_paid value=0}
        {assign var=t_total_amount value=0}

        {foreach item=lr key=branch from=$result}
            <tr class="active bold">
                <td colspan="16" align="center">{$branch}</td>
            </tr>
            {foreach item=row from=$lr}
                <tr>
                    <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->from_station_name}</td>
                    <td align="left">{$row->to_station_name}</td>
                    <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->organization_name}</td>
                    <td align="center">
                        {$row->payment_status|_cargo_payment_status_badge}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="left">{if $row->delivered_user_name}{$row->delivered_user_name}{else} - {/if}</td>
                    <td align="left" nowrap>{if $row->delivered_at}{$row->delivered_at|date_format:$ns_datetime_format}{else} - {/if}</td>
                    <td align="right">{$row->total_item_count}</td>
                    <td align="right">{($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)|number_format:2}</td>
                    <td align="right">{$row->total_amount_paid|number_format:2}</td>
                    <td align="right">
                        {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)-$row->total_amount_paid}
                        {$rtopay|number_format:2}
                    </td>
                </tr>

                {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
                {assign var=t_total_amount_paid value=$t_total_amount_paid + $row->total_amount_paid}
                {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
                {assign var=t_payable value=$t_payable+$row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}
                {assign var=t_paid value=$t_paid+$row->total_amount_paid}
                {assign var=t_topay value=$t_topay+$rtopay}
            {/foreach}
            {if $result|count > 1}
                <tr class="bold">
                    <td colspan="12" align="right">Total</td>
                    <td align='right'>{$summary[$branch]['items']}</td>
                    <td align='right'>{$summary[$branch]['netPayable']|number_format:2}</td>
                    <td align='right'>{$summary[$branch]['paid']|number_format:2}</td>
                    <td align='right'>{$summary[$branch]['toPay']|number_format:2}</td>
                </tr>
            {/if}
        {/foreach}

        {if $result|count}
            <tr class="active bold">
                <td colspan="12" align="right">Total</td>
                <td align='right'>{$t_total_item_count}</td>
                <td align='right'>{$t_payable|number_format:2}</td>
                <td align='right'>{$t_paid|number_format:2}</td>
                <td align='right'>{$t_topay|number_format:2}</td>
            </tr>
        {else}
            <tr class="bold">
                <td colspan="16" align="center">No Records Found</td>
            </tr>
        {/if}
    </tbody>
</table>
