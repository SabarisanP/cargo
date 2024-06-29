{header("Content-Type: application/xls")}
{header("Content-Disposition: attachment; filename=download.xls")}
<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>{iflang('OGPL Report')}</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}</td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$username}</td>
    </tr>
</table>

<table border='1'>
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <td>Date of Created</td>
            <td>Date of Departure</td>
            <td>Date of Arrival</td>
            <td>{lang('ogpl')} Number</td>
            <td>Route</td>
            <td>Via Stations</td>
            <td>Vehicle</td>
            <td>Driver</td>
            <td>Total Odometer</td>
            <td>Created By</td>
            <td>No. of {lang('lr')}</td>
            <td>No. Of {lang('lr')} Unloaded</td>
            <td>Hub Loaded</td>
            <td>Hub Unloaded</td>
            <td>E-way Bill A</td>
            <td>E-way Bill B</td>
            {* <td>Freight Amount</td> *}
            <td>Expenses</td>
            <td>Fuel Details</td>
            <td>Unloaded By</td>
            <td>Unloaded At</td>
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
        {assign var=t_hub_load_count value=0}
        {assign var=t_hub_unload_count value=0}

        {foreach item=row from=$result key=i}
            <tr>
                <td align="left">
                    {if isNotNull($row->audit_updated_at)}{$row->audit_updated_at|date_format:$ns_datetime_format}{else}-{/if}
                </td>
                <td align="left">
                    {if isNotNull($row->departure_at)}{$row->departure_at|date_format:$ns_datetime_format}{else}-{/if}
                </td>
                <td align="left">
                    {if isNotNull($row->arrival_at)}{$row->arrival_at|date_format:$ns_datetime_format}{else}-{/if}
                </td>
                <td align="left">
                    <span class="text-success">{$row->alias_code}</span>
                </td>
                <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                <td align="left">{$row->via_stations|replace:',':', '}</td>
                <td align="left">{$row->registration_numer}</td>
                <td align="left">{($row->driver_name) ? $row->driver_name : '-'}</td>
                <td align="left">
                {if $row->start_odometer && $row->end_odometer}
                    {assign var='distance' value=$row->end_odometer - $row->start_odometer}
                    {$distance} Km
                {else}
                    {if $row->start_odometer}
                        {assign var='endOdm' value=0}
                        {assign var='startOdm' value=$row->start_odometer}
                    {else if $row->end_odometer}
                        {assign var='endOdm' value=$row->end_odometer}
                        {assign var='startOdm' value=0}
                    {else}
                        {assign var='endOdm' value=0}
                        {assign var='startOdm' value=0}
                    {/if}
                    {assign var='distance' value=$endOdm - $startOdm}
                    {assign var='distance' value=abs($distance)|default:'-'}
                    {$distance} ODM
                {/if}
            </td>
                <td align="left">{$row->audit_user_name|default:'-'}</td>
                <td align="right">{$row->cargo_count}</td>
                <td align="right">{$row->unload_count}</td>
                <td align="right">{$row->hub_load_count}</td>
                <td align="right">{$row->hub_unload_count}</td>
                <td align="right">{$row->eway_bill_added_count|default:'0'}</td>
                <td align="right">{$row->eway_bill_part_b_updated_count|default:'0'}</td>
                {* <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td> *}
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_fuel_amount}</td>

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
                
                <td align="left">{$row->unloaded_user_name|default:'-'}</td>
                <td align="left">{$row->unloaded_at|date_format:$ns_datetime_format|default:'-'}</td>
                <td align="center">
                    {if $row->transit_activity_status_code == 'NEW'}
                        <span class="badge badge-success">New</span>
                    {elseif $row->transit_activity_status_code == 'INTRN'}
                        <span class="badge badge-warning">In-Transit</span>
                    {elseif $row->transit_activity_status_code == 'CMPLT'}
                        <span class="badge badge-danger">Completed</span>
                    {elseif $row->transit_activity_status_code == 'TRNSFR'}
                        <span class="badge badge-danger">Transferred</span>
                    {elseif $row->transit_activity_status_code == 'EMPLD'}
                        <span class="badge badge-warning">Empty Load</span>
                    {/if}
                </td>
                <td align="left">{($row->remarks) ? $row->remarks : '-'}</td>
            </tr>

            {assign var=t_load_count value=$t_load_count + $row->load_count}
            {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
            {assign var=t_unload_count value=$t_unload_count + $row->unload_count}
            {* {assign var=t_total_amount value=$t_total_amount + $row->total_amount} *}
            {assign var=t_fuel_amount value=$t_fuel_amount + $row->total_fuel_amount}
            {assign var=t_hub_load_count value=$t_hub_load_count + $row->hub_load_count}
            {assign var=t_hub_unload_count value=$t_hub_unload_count + $row->hub_unload_count}
        {/foreach}
        {if $result|count}
            <tfoot>
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="10" align="right">Total</td>
                <td align='right'>{($t_cargo_count)}</td>
                <td align='right'>{($t_unload_count)}</td>
                <td align='right'>{($t_hub_load_count)}</td>
                <td align='right'>{($t_hub_unload_count)}</td>
                {* <td align='right' data-format="{$xlformat['currency']}">{($t_total_amount)}</td> *}
                <td align='right' data-format="{$xlformat['currency']}">{($t_fuel_amount)}</td>
                <td colspan="5"></td>
            </tr>
            </tfoot>
        {else}
            <tfoot>
                <tr>
                    <td colspan="21" align="center">No Records Found</td>
                </tr>
            </tfoot>
        {/if}
    </tbody>
</table>

<table>
    <tr>
        <td colspan="2" align="left"><b>Unloading Complaints</b></td>
    </tr>
</table>
<table border="1">
    <thead>
        <tr>
            <td align="left">S.No</td>   
            <td align="left">LR No</td>
            <td align="left">No.of articles</td>
            <td>From</td>
            <td>To</td>
            <td>Remarks</td>
        </tr>
    </thead>
    <tbody>
        {assign var=t_item_count value=0}
        {foreach item=row from=$unload_complaint_lr key=i}
            <tr>
                <td align="left">{$i+1}</td>
                <td align="left">{$row->cargo_code}</td>
                <td align="left" width="13%">{$row->total_item_count}</td>

                <td align="left">
                    {$row->from_organization_name}
                </td>
                
                <td align="left">
                    {$row->to_organization_name}
                </td>
                <td align="left" width="20%">{$row->unloading_remarks}</td>
            </tr>
            {assign var=t_item_count value=$t_item_count + $row->total_item_count}
        {foreachelse}
            <tr>
                <td colspan="6" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
    {if $result|count}
        <tr>
            <td colspan="2" align="right">Total</td>
            <td align='left'>{($t_item_count)}</td>
            <td colspan="3"></td>
        </tr>
    {/if}
</table>
