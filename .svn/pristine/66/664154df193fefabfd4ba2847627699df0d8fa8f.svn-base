<link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
{if $rto->print_size==1}
<link href="{$base_url}assets/css/print-medium.css?{$asset_ver}" rel="stylesheet">
{/if}

{if $api_error==1}
    Sorry! Error getting data. Please try again later.
{else}
    
    <button class="print-btn-default d-print-none" onclick="window.print()">Print</button>

    <table class="remove-border-top" cellpadding="1"  width="98%">
        <tr>
            <td align="center"><b>{$namespace_name}</b></td>
        </tr>
        <tr>
            <td width="100%" align="center">
                {$trips->schedule->name},   {$category}, {$from_time|date_format:$ns_date_format} {$from_time|date_format:$ns_time_format}
                {if $vehicle_nunmber!=''}  | Vehicle : {$vehicle_nunmber} {/if}
                {if $data->driverName!='' && $data->driverMobile!=''}  | Driver : {$data->driverName} {$data->driverMobile} {/if}
                {if $trips->schedule->serviceNumber!=''}
                    , {$trips->schedule->serviceNumber}
                {/if}
            </td>
        </tr>
    </table>

    <table class="table table-bordered-light" cellpadding="1" width="98%">
        <tr class="info bold">
            <td width="5%"  align="center">Seat No</td>
            <td width="10%" align="center">PNR </td>
            {if $rto->booked_at==1}<td width="10%" align="center">BookedDate</td>{/if}
            {if $rto->pass_name==1}<td width="7%" align="left">Name</td>{/if}
            {if $rto->pass_age==1}<td width="3%" align="center">Age</td>{/if}
            {if $rto->pass_gender==1}<td width="3%" align="center">G</td>{/if}
            {if $rto->pass_contact==1}<td width="7%" align="center">Mobile</td>{/if}
            {if $action_rights['BRD-HIDE-FARE']!=1 && $rto->fare==2}
            <td width="7%" align="center">Fare</td>
            {/if}
            {if $rto->from_station==1}<td width="10%" align="center">From</td>{/if}
            {if $rto->to_station==1}<td width="10%" align="center">To</td>{/if}
            {if $medium!=1 && $rto->boarding_pt==1}
            <td width="10%" align="center">Boarding Point</td>
            {/if}
            {if $rto->booked_by==1}<td width="10%" align="center">Booked by</td>{/if}
            {if $rto->booked_type==1}<td width="5%"  align="center">Booked Type</td>{/if}
        </tr>
        <tbody
            {foreach item=point from=$points}
                {if $bp_books[$point['code']]|count > 0}
                    
                    {if $rto->boarding_pt==1}
                    <tr>
                        <td colspan="{$col_count}" align="center" class="bold">
                            <b>{$point['stageName']} - {$point['name']} - {$point['time']}
                                {if $point['landmark']!=''}
                                ; &nbsp;&nbsp; Landmark : {$point['landmark']}
                                {/if}
                            </b>
                        </td>  
                    </tr>
                    {/if}
                    
                    {foreach item=bk from=$bp_books[$point['code']]}
                        <tr>
                            <td align="center" {if $bk->remarks !=""} rowspan="2" {/if} > {$bk->seatName}</td>
                            <td align="center" {if $bk->remarks !=""} rowspan="2" {/if} class="bold">{$bk->ticketCode}</td>
                            {if $rto->booked_at==1}<td align="center">{$bk->bookedDate|date_format:$ns_date_format}</td>{/if}

                            {if $rto->pass_name==1}<td align="left">{$bk->passengerName}</td>{/if}
                            {if $rto->pass_age==1}<td align="center">{$bk->passengerAge}</td>{/if}
                            {if $rto->pass_gender==1}<td align="center">{$bk->gender}</td>{/if}
                            {if $rto->pass_contact==1}<td align="center" >{$bk->passengerMobile}</td>{/if}
                            {if $action_rights['BRD-HIDE-FARE']!=1 && $rto->fare==2}                                
                            <td align="right"><input type="text" class="print-input-as-text" value="{$rto->manual_fare}"/></td>                            
                            {/if}

                            {if $rto->from_station==1}<td align="left">{$bk->fromStation->name}</td>{/if}
                            {if $rto->to_station==1}<td align="left">{$bk->toStation->name}</td>{/if}
                            {if $medium!=1 && $rto->boarding_pt==1}
                            <td align="left">{$bk->boardingPoint->name}</td>
                            {/if}
                            {if $rto->booked_by==1}<td align="left">{$bk->bookedBy->name}</td>{/if}
                            {if $rto->booked_type==1}<td align="left">{$bk->bookedType}</td>{/if}
                        </tr>
                        {if $bk->remarks !=""}
                            <tr>
                                <td align="left" colspan="{$col_count-2}">{$bk->remarks}</td>
                            </tr>
                        {/if}
                    {/foreach}    
                {/if}
            {/foreach}

            {foreach item=bk from=$unbookedlist}
                <tr >
                    <td align="center">{$bk['seatName']}</td>
                    <td align="center">&nbsp</td>
                    {if $rto->booked_at==1}<td align="center">&nbsp</td>{/if}

                    {if $rto->pass_name==1}<td align="left">&nbsp</td>{/if}
                    {if $rto->pass_age==1}<td align="center">&nbsp</td>{/if}
                    {if $rto->pass_gender==1}<td align="center">&nbsp</td>{/if}
                    {if $rto->pass_contact==1}<td align="center">&nbsp</td>{/if}
                    {if $action_rights['BRD-HIDE-FARE']!=1 && $rto->fare==2}
                    <td align="right">&nbsp</td>
                    {/if}

                    {if $rto->from_station==1}<td align="left">&nbsp</td>{/if}
                    {if $rto->to_station==1}<td align="left">&nbsp</td>{/if}
                    {if $medium!=1 && $rto->boarding_pt==1}
                    <td align="left">&nbsp</td>
                    {/if}
                    {if $rto->booked_by==1}<td align="left">&nbsp</td>{/if}
                    {if $rto->booked_type==1}<td align="left">&nbsp</td>{/if} 
                </tr>
            {/foreach}   

        </tbody>
    </table>
    {if $data->remarks != ''}  
    <br/>    
    <table align='left'>
        <tr>
            <td>
                <h5>Notes</h5>
                {$data->remarks|nl2br}
            </td>
        </tr>
    </table>
    {/if}
    <br/>
    <table class="table remove-border-top" width="95%">
        <tr>
            <td width="30%" valign="top">
                <b>Seat Status</b>
                <table class="table table-bordered" width="100%" >
                    <tr>
                        <td class="bold" align="center" nowrap><b>Total no of seats</b></td>
                        <td class="bold" align="center"><b>Total no of vacant</b></td>
                        <td class="bold" align="center"><b>Total no of booked seat</b></td>

                    </tr>
                    <tr>
                        <td align="center">{$totalSeatCount}</td>                                            
                        <td align="center">{count($unbookedlist)}</td>
                        <td align="center">{$totalBookedCount}</td>
                    </tr>
                    <tr>
                        <td class="bold" align="center"><b>Vacant Seat Number</b></td>                                            
                        <td class="" colspan="2">{$unbooked_seat_names}</td>
                    </tr>
                </table>
            </td>
         
            <td width="60%" valign="top">
                <b>Boarding Details</b>    
                <table class="table table-bordered" width="100%">
                    <tr>
                        <td class="bold"  nowrap><b>Station</b></td>
                        <td class="bold" ><b>Station Point</b></td>
                        <td class="bold" ><b>Seats</b></td>
                        <td class="bold" ><b>Seat Name</b></td>                                                            
                    </tr>
                    {assign var="prestation" value=""}
                    {foreach item=point from=$points}
                        {if $bp_books[$point['code']]|count > 0}
                            <tr>
                                <td>{if $prestation!=$point['stageName']} {$point['stageName']} {/if}</td>
                                <td >{$point['name']} - {$point['time']}</td> 
                                <td >{$bp_books[$point['code']]|count}</td> 
                                <td> 
                                    {foreach item=bk from=$bp_books[$point['code']]}
                                        {$bk->seatName}, 
                                    {/foreach} 
                                </td>
                            </tr>    
                            {assign var="prestation" value=$point['stageName']}
                        {/if}                                                            
                    {/foreach}                                                       
                </table>

            </td>
            
            </tr>
        </table>
         
        {if $action_rights['TRP-VIEW-USR-BOOK']>0 || $action_rights['BRD-VIEW-DROP-DETAILS']>0}
        <table class="table remove-border-top" width="95%">
            <tr>
                {if $action_rights['TRP-VIEW-USR-BOOK']>0}
                    <td width="40%" valign="top">                    
                        <b>User Booking List</b>
                        <table class="table table-bordered" width="100%">
                            <tr>
                                <td class="bold"><b>User Name</b></td>
                                <td class="bold"><b>Seat Count</b></td>
                            </tr>
                            {foreach item=entity from=$bookinglist key=bookeduser}
                                <tr>
                                    <td >{$bookeduser}</td>                                            
                                    <td >{$entity|count}</td>
                                </tr>
                            {/foreach}                                                        

                        </table>                   
                    </td>
                {/if}
                
                {if $action_rights['BRD-VIEW-DROP-DETAILS']>0}
                    <td width="40%" valign="top">                    
                        <b>Dropping Details</b>    
                        <table class="table table-bordered" width="100%">
                            <tr>
                                <td class="bold"  nowrap><b>Station</b></td>
                                <td class="bold" ><b>Station Point</b></td>
                                <td class="bold" ><b>Seat Name</b></td>                                                            
                            </tr>
                            {assign var="prestation" value=""}
                            {foreach item=point from=$points_dp}
                                {if $dp_books[$point['code']]|count > 0}
                                    <tr>
                                        <td>{if $prestation!=$point['stageName']} {$point['stageName']} {/if}</td>
                                        <td >{$point['name']}</td> 
                                        <td> 
                                            {foreach item=dk from=$dp_books[$point['code']]}
                                                {$dk->seatName}, 
                                            {/foreach} 
                                        </td>
                                    </tr>    
                                    {assign var="prestation" value=$point['stageName']}
                                {/if}                                                            
                            {/foreach}                                                       
                        </table>                    
                    </td>
                {/if}
            </tr>
        </table>         
        {/if}         
    {/if}    
