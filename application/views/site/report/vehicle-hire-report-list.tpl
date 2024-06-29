<table width="95%">
    <tr>
        <td colspan="10" align="center"><span class="bold">Vehicle Hire Report</td>
    </tr>
    <tr>
        <td width="50%">
            From  {$smarty.request.fromDate|date_format:$ns_date_format}  To {$smarty.request.toDate|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("d-m-Y h:i:s A")}
        </td>
    </tr>
</table>
        
{assign var=tot_hire_amt value=0}
{assign var=tot_adv_amt value=0}
{assign var=tot_fuel_amt value=0}
<div class="table-responsive">
    <table class="table table-bordered widthed">
        <thead>
            <tr class="success">                
                <td>Trip Date</td>
                <td>Trip Code</td>
                <td>Station</td>
                <td>Reg No</td>
                <td>Via Station</td>
                <td>Driver Details</td>
                <td>Sec. Driver Details</td>
                <td>Hiring Amount</td>
                <td>Advance Amount</td>
                <td>Fuel Amount</td> 
                <td>Remarks</td>                
            </tr>
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$result key=t}
                <tr>                    
                    <td align="center">{$row->trip_date|date_format:$ns_date_format}</td>
                    <td>{$row->alias_code}</td>
                    <td>{$row->from_station_name} - {$row->to_station_name}</td>
                    <td>{$row->registration_numer}</td>
                    <td>{if isNotNull($row->via_stations)}{$row->via_stations}{else}-{/if}</td>

                    <td>
                        {if isNotNull($row->driver_name) || isNotNull($row->driver_mobile)}
                            {$row->driver_name}<br>
                            <span class="text-muted">{$row->driver_mobile}</span>
                        {else}
                            -
                        {/if}
                    </td>

                    <td>
                        {if isNotNull($row->secondary_driver_name) || isNotNull($row->secondary_driver_mobile)}
                            {$row->secondary_driver_name}<br>
                            <span class="text-muted">{$row->secondary_driver_mobile}</span>
                        {else}
                            -
                        {/if}
                    </td>
                    
                    <td align="right">{$row->hiring_amount|inr_format:2}</td>
                    <td align="right">{$row->advance_amount|inr_format:2}</td>
                    <td align="right">{$row->fuel_amount|inr_format:2}</td>
                    <td>{$row->remarks|default: '-'}</td>
                </tr>

                {assign var=tot_hire_amt value=$tot_hire_amt+$row->hiring_amount}
                {assign var=tot_adv_amt value=$tot_adv_amt+$row->advance_amount}
                {assign var=tot_fuel_amt value=$tot_fuel_amt+$row->fuel_amount}
                {foreachelse}
                    <tr>
                        <td align="center" colspan="11">No data found !!!!</td>
                    </tr>
            {/foreach}
        </tbody>
        <tfoot>
            <tr class="active">                    
                <td colspan="7" align="right">Grand Total</td>
                <td align="right">{$tot_hire_amt|inr_format:2}</td>  
                <td align="right">{$tot_adv_amt|inr_format:2}</td>
                <td align="right">{$tot_fuel_amt|inr_format:2}</td>
                <td></td>
            </tr>
        </tfoot>
    </table>                
</div>
<script>

</script>    
