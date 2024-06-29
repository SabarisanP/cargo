{if $filter_type == 'SUMMARY'}
    <table class="" width="99%">
        <tr>
            <td colspan="2" align="center"><span class="bold">Transit Based Branch Collection Report</span></td>
        </tr>
        <tr>
            <td width="50%">
                <span class="bold">From </span>{$smarty.request.fromDate|date_format:$ns_date_format} <span class="bold">To </span>{$smarty.request.toDate|date_format:$ns_date_format}
            </td>
            <td width="50%" align="right">
                <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
            </td>
        </tr>
    </table>
    <br>

    <table id="transit_based_branch_report_table" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center" rowspan="2">Date</td>
                <td align="center" colspan="3">Transit Details</td>
                <td align="center" colspan="3">Booking Details</td>
                <td align="center" nowrap rowspan="2">Receiving Branch</td>
                <td align="center" rowspan="2"> LR count</td>
                <td align="center" nowrap rowspan="2">Paid (Rs)</td>
                <td align="center" nowrap rowspan="2">toPay (Rs)</td>
                <td align="center" nowrap rowspan="2">RAC (Rs)</td>
            </tr>
            <tr class="success">
                <td align="center">{lang('ogpl')} No.</td>
                <td align="center">Vehicle No.</td>
                <td align="center">Route</td>

                <td align="center">Zone</td>
                <td align="center">Station</td>
                <td align="center" nowrap>Branch Name</td>
            </tr>
        </thead>
        {assign var=t_lr_count value=0}
        {assign var=t_topay_amount value=0}
        {assign var=t_paid_amount value=0}
        {assign var=t_onaccount_amount value=0}

        <tbody class="body_table">
            {foreach item=row from=$result}
                <tr>
                    <td nowrap>{$row->loaded_date|date_format:$ns_date_format}</td>
                    <td>
                        <span class="text-success">
                            <a title="Click to get OGPL Details" href="javascript:;" onclick="showTransitReportDialog('{$row->transit_code}','{$row->organization_code}','{$row->related_organization_code}');">{$row->transit_alias_code}</a>
                        </span>
                    </td>
                    <td>{$row->registration_number}</td>
                    <td nowrap> {($row->transit_from_station_name|cat:" to "|cat:$row->transit_to_station_name)|truncate:30}</td>
                    <td>{$row->zone_name|default:'-'}</td>
                    <td>{$row->station_name}</td>
                    <td>{$row->organization_name}</td>
                    <td>{$row->related_organization_name}</td>
                    <td align="center">{$row->cargo_count}</td>
                    <td align="right">{$row->paid_amount}</td>
                    <td align="right">{$row->topay_amount}</td>
                    <td align="right">{$row->onacc_amount}</td>
                </tr>
                {assign var=t_lr_count value=$t_lr_count+$row->cargo_count}
                {assign var=t_topay_amount value=$t_topay_amount+$row->topay_amount}
                {assign var=t_paid_amount value=$t_paid_amount+$row->paid_amount}
                {assign var=t_onaccount_amount value=$t_onaccount_amount+$row->onacc_amount}
            {foreachelse}
                <tr>
                    <td colspan="12" align="center">No data found</td>
                </tr>
            {/foreach}

        </tbody>
        {if $result|count}
            <tr class="info">
                <td class="bold" align='right' colspan="8">Total</td>
                <td class="bold" align='center'>{$t_lr_count}</td>
                <td class="bold" align='right'>{$t_paid_amount|inr_format}</td>
                <td class="bold" align='right'>{$t_topay_amount|inr_format}</td>
                <td class="bold" align='right'>{$t_onaccount_amount|inr_format}</td>
            </tr>
        {/if}
    </table>
{/if}

{if $filter_type == 'DETAILS'}
    <div>
        <div class="row">
            <div class="col-md-10 bold ft_14">

            </div>
            <div class="col-md-2">
                <a class="align-right" onclick="closeTransitDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
            </div>
        </div>
        <br>
        <table id="transit_branch_report_table_1" class="table table-bordered">
            <thead>
                <tr class="success">
                    <td align="center">S.No</td>
                    <td align="center">Cargo Code</td>
                    <td align="center">Booked Date</td>
                    <td align="center">From</td>
                    <td align="center">To (Delivery)</td>
                    <td align="center">Payment Status</td>
                    <td align="center">Cargo Status</td>
                    <td align="center">Qty</td>
                    <td align="center">Freight</td>
                    <td align="center">Other Charges</td>
                    <td align="center">Total Amount</td>
                </tr>
            </thead>
            {assign var=t_qty value=0}
            {assign var=t_other_charges value=0}
            {assign var=t_freight value=0}
            {assign var=t_total_amount value=0}
            <tbody class="body_table">
                {foreach item=row from=$results key=i}
                    <tr>
                        <td align="left">{$i + 1}</td>
                        <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                        <td>{$row->booked_at}</td>
                        <td align="center">{$row->from_organization_name}</td>
                        <td align="center">{$row->to_organization_name}</td>
                        <td align="center">
                            {$row->payment_status_code|_cargo_payment_status_badge}
                        </td>
                        <td align="center">{$cargo_status[$row->cargo_status_code]}</td>
                        <td align="right">{$row->total_item_count}</td>
                        <td align="right">{$row->total_amount|inr_format}</td>
                        <td align="right">
                            {($row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)|inr_format}
                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                <table>
                                    {if $row->other_charges_amount != 0}
                                        {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                            {if $cv == 0}
                                                {continue}
                                            {/if}
                                            <tr>
                                                <td>{$ck|_snakecase_to_titlecase}</td>
                                                <td>&ensp;:&ensp;</td>
                                                <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                            </tr>
                                        {/foreach}
                                    {/if}
                                    {if $row->total_handling_amount != 0.00 }
                                        <tr>
                                            <td>Handling Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->total_handling_amount|inr_format}</td>
                                        </tr>
                                    {/if}
                                    {if $row->service_t != 0.00 }
                                        <tr>
                                            <td>GST</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->service_tax|inr_format}</td>
                                        </tr>
                                    {/if}
                                    {if $row->total_unload_handling_amount != 0.00 }
                                        <tr>
                                            <td>Unloading Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->total_unload_handling_amount|inr_format}</td>
                                        </tr>
                                    {/if}
                                    {if $row->pickup_handling_amount != 0.00 }
                                        <tr>
                                            <td>Pickup Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->pickup_handling_amount|inr_format}</td>
                                        </tr>
                                    {/if}  
                                    {if $row->delivery_handling_amount != 0.00 } 
                                        <tr>
                                            <td>Delivery Charges</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->delivery_handling_amount|inr_format}</td>
                                        </tr>
                                    {/if}
                                    {if $row->connecting_charges != 0.00 } 
                                        <tr>
                                            <td>Connecting Charge</td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$row->connecting_charges|inr_format}</td>
                                        </tr>
                                    {/if}
                                </table> '>
                            </i>
                        </td>
                        <td align="right">{(($row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)+($row->total_amount))|inr_format}</td>
                    </tr>
                    {assign var=t_qty value=$t_qty+$row->total_item_count}
                    {assign var=t_other_charges value=$t_other_charges+($row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)}
                    {assign var=t_freight value=$t_freight+$row->total_amount}
                    {assign var=t_total_amount value=$t_total_amount+(($row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->other_charges_amount+$row->connecting_charge)+($row->total_amount))}
                {foreachelse}
                    <tr>
                        <td colspan="11" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>
            {if $results|count}
                <tr class="info bold">
                    <td class="bold" align='right' colspan="7">Total</td>
                    <td class="bold" align='right'>{$t_qty}</td>
                    <td class="bold" align='right'>{$t_freight|inr_format}</td>
                    <td class="bold" align='right'>{$t_other_charges|inr_format}</td>
                    <td class="bold" align='right'>{$t_total_amount|inr_format}</td>
                </tr>
            {/if}
        </table>
    </div>
{/if}
<script>
    var namespaceCode = {$namespaceCode|json_encode};
    $('[data-toggle="popover"]').popover({
        placement: 'bottom',
        html: true,
        trigger: 'hover'
    });
</script>