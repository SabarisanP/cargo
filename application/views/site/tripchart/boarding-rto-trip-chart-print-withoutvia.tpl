<link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">

{if $api_error==1}
    Sorry! Error getting data. Please try again later.
{else}
    <button class="print-btn-default d-print-none" onclick="window.print()">Print</button>
    
    <table class="remove-border-top" cellpadding="1"  width="98%">
        <tr>
            <td colspan="3" align="center"><b>{$namespace_name}</b></td>
        </tr>
        <tr>
            <td align="left">
                <b>Trip :</b>{$trips->schedule->name},   {$category}, {$from_time|date_format:$ns_datetime_format}</br>
                {if $vehicle_nunmber!=''}  <b>Vehicle :</b> {$vehicle_nunmber} {/if}
            </td>
            <td align="left">
                {if $data->driverName!='' && $data->driverName!='NA'} <b>Driver 1 :</b> {$data->driverName} {/if}</br>
                {if $data->driverName2!='' && $data->driverName2!='NA'} <b>Driver 2 :</b> {$data->driverName2} {/if}
            </td>
            <td align="left">
                {if $data->attenderName!='' && $data->attenderName!='NA'} <b>Attender :</b> {$data->attenderName} {/if}                
            </td>
        </tr>
    </table>

    <table class="table table-bordered-light" cellpadding="1" width="98%">
        <thead>
            <tr class="info bold" style="font-weight: bold;">
                <th width="5%"  align="center">Seat No</th>
                <th width="10%" align="center">PNR </th>
                <th width="12%"  align="left">Name</th>
                <th width="5%"  align="left">Age</th>
                <th width="5%"  align="left">Gender</th>
                <th width="10%"  align="center">Mobile</th>
                <th width="10%" align="center">From</th>
                <th width="10%" align="center">To</th>
                {if $rto->manual_fare >0}
                <th width="10%" align="center">Fare</th>
                {/if}
            </tr>
        </thead>
        <tbody data={$bp_books|json_encode}>
            {foreach item=point from=$points}
                {if $bp_books[$point['code']]|count > 0}
                    {foreach item=bk from=$bp_books[$point['code']]}
                        <tr>
                            <td align="center">{$bk->seatName}</td>
                            <td align="center">{$bk->ticketCode}</td>
                            <td align="left">{$bk->passengerName}</td>
                            <td align="left">{$bk->passengerAge}</td>
                            <td align="left">{$bk->gender}</td>
                            <td align="center">{$bk->passengerMobile}</td>
                            <td align="left">{$from}</td>
                            <td align="left">{$last_station_data->name}</td>
                            {if $rto->manual_fare >0}
                            <td align="right"><input type="text" class="print-input-as-text" value="{$rto->manual_fare}"/></td>
                            {/if}
                        </tr>
                    {/foreach}
                {/if}
            {/foreach}

            {foreach item=bk from=$unbookedlist}
                <tr>
                    <td align="center">{$bk['seatName']}</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    {if $rto->manual_fare >0}
                    <td>&nbsp;</td>
                    {/if}
                </tr>
            {/foreach}
        </tbody>
    </table>
{/if}
