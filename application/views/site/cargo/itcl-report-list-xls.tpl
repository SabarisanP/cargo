<table class="" width="99%" border='1'>
    <tr>
        <td colspan="8" align="center"><span style="font-weight:bold">{iflang('Local Transit Report')}</span></td>
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
            <tr style="background-color: #64b92a; color: #fff;">
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
                <td>Fuel Details</td>
                <td>Status</td>
                <td>Remarks</td>
            </tr>
        </thead>
        <tbody>

            {assign var=t_load_count value=0}
            {assign var=t_cargo_count value=0}
            {assign var=t_unload_count value=0}
            {assign var=t_total_amount value=0}
            {assign var=t_fuel_amount value=0}

            {foreach item=row from=$result key=i}
                <tr>
                    <td align="left">{$row->trip_date|date_format:$ns_datetime_format}</td>
                    <td align="left"><span class="text-success">{$row->alias_code}</span></td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->registration_numer}</td>
                    <td align="left">{($row->driver_name) ? $row->driver_name : '-'}</td>
                    <td align="right">{$row->cargo_count}</td>
                    <td align="right">{$row->unload_count}</td>
                    <td align="right">{$row->total_amount|inr_format}</td>
                    <td align="right">{$row->total_fuel_amount|inr_format}</td>

                    <td>
                        {assign var="transit_fuel_details" value="|"|explode:$row->transit_fuel_details}
                        {assign var="fuelDetails" value=''}
                        {foreach from=$transit_fuel_details item=fuel}
                            {assign var="fuelArray" value=","|explode:$fuel}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'<br>Fuel Vendor : '|cat:$fuelArray[3]|cat:' ,'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Payment Mode : '|cat:$fuelArray[0]|cat:' ,'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Litres : '|cat:$fuelArray[1]|cat:' ,'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Amount : '|cat:$fuelArray[2]}
                        {/foreach}
                        {if isNotNull($row->transit_fuel_details)}
                            {$fuelDetails}
                        {else}
                            -
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
                    <td colspan="13" align="center">No Records Found</td>
                </tr>
            {/foreach}
            {if $result|count}
                <tr style="background-color: #bbbbbb; color: #fff;">
                    <td colspan="6" align="right">Total</td>
                    <td align='right'>{($t_cargo_count)}</td>
                    <td align='right'>{($t_unload_count)}</td>
                    <td align='right'>{($t_total_amount)|inr_format}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{($t_fuel_amount)}</td>
                    <td colspan="3"></td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>