<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">{iflang('Local Transit Report')}</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<div class="overflow-x-auto">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success">
                <td>Date Of Created</td>
                <td>{lang('ogpl_local_transit')} Number</td>
                <td>From Branch</td>
                <td>To Branch</td>
                <td>Vehicle</td>
                <td>Driver</td>
                <td>No. of {lang('lr')}</td>
                <td>No. Of {lang('lr')} Unloaded</td>
                <td>Freight Amount</td>
                <td>Fuel Amount</td>
                <td>Status</td>
                <td>Remarks</td>
            </tr>
        </thead>
        <tbody class="body_table">

            {assign var=t_load_count value=0}
            {assign var=t_cargo_count value=0}
            {assign var=t_unload_count value=0}
            {assign var=t_total_amount value=0}
            {assign var=t_fuel_amount value=0}

            {foreach item=row from=$result key=i}
                <tr>
                    <td align="left">{$row->trip_date|date_format:$ns_datetime_format}</td>
                    <td align="left">
                        <span class="text-success">
                            {$row->alias_code}
                            <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('{$row->transit_code}', '{$row->alias_code}')"><i class="fa fa-history" aria-hidden="true"></i></a>
                        </span>
                    </td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->registration_numer}</td>
                    <td align="left">{($row->driver_name) ? $row->driver_name : '-'}</td>
                    <td align="right">{$row->cargo_count}</td>
                    <td align="right">{$row->unload_count}</td>
                    <td align="right">{$row->total_amount|inr_format}</td>

                    <td align="right" nowrap>
                        {$row->total_fuel_amount|inr_format}&nbsp;
                        
                        {assign var="transit_fuel_details" value="|"|explode:$row->transit_fuel_details}
                        {assign var="fuelDetails" value=''}
                        {foreach from=$transit_fuel_details item=fuel}
                            {assign var="fuelArray" value=","|explode:$fuel}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'<b>Fuel Vendor : '|cat:$fuelArray[3]|cat:'</b><br>'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Payment Mode : '|cat:$fuelArray[0]|cat:'<br>'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Litres : '|cat:$fuelArray[1]|cat:'<br>'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Amount : '|cat:$fuelArray[2]|cat:'<br>'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'<br>'}
                        {/foreach}
                        {if isNotNull($row->transit_fuel_details)}
                            <a href="javascript:;" data-toggle="popover" data-content="{$fuelDetails}" style="cursor:pointer;">
                                <i class="fa fa-info-circle" aria-hidden="true"></i>
                            </a>
                        {/if}
                    </td>

                    <td align="center">
                        {if $row->unload_count < $row->cargo_count}
                            <span class="badge badge-warning">In-Transit</span>
                        {elseif $row->unload_count >= $row->cargo_count}
                            <span class="badge badge-success">Unloaded</span>
                        {/if}
                    </td>
                    <td align="left" width="200">{($row->remarks) ? $row->remarks : '-'}</td>
                </tr>
                
                {assign var=t_load_count value=$t_load_count + $row->load_count}
                {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
                {assign var=t_unload_count value=$t_unload_count + $row->unload_count}
                {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
                {assign var=t_fuel_amount value=$t_fuel_amount + $row->total_fuel_amount}
            {foreachelse}
                <tr>
                    <td colspan="12" align="center">No Records Found</td>
                </tr>
            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr class="active bold">
                    <td colspan="6" align="right">Total</td>
                    <td align='right'>{($t_cargo_count)}</td>
                    <td align='right'>{($t_unload_count)}</td>
                    <td align='right'>{($t_total_amount)|inr_format}</td>
                    <td align='right'>{($t_fuel_amount)|inr_format}</td>
                    <td colspan="2"></td>
                </tr>
            </tfoot>
        {/if}
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportRevenueExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>

<script>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>