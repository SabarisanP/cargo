<link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
<link href="{$base_url}assets/css/print-medium.css?{$asset_ver}" rel="stylesheet">

{if $api_error==1}
    Sorry! Error getting data. Please try again later.
{else}

    <table class="remove-border-top" cellpadding="1"  width="98%">
        <tr>
            <td align="center"><b>{$namespace_name}</b></td>
        </tr>
        <tr>
            <td align="right" style="font-size:10px">Printed By {$usr_login_name} @ {date("d/m/Y h:i A")} </td>
        </tr>
        <tr>
            <td width="100%" align="center">
                {$trips->schedule->name},   {$category}, {$from_time|date_format:$ns_date_format} {$from_time|date_format:$ns_time_format}                
                {if $vehicle_nunmber!=''}  | Vehicle : {$vehicle_nunmber} {/if}
                {if $data->driverName!='' && $data->driverMobile!=''}  | Driver : {$data->driverName}, {$data->driverMobile} {/if}
                {if $trips->schedule->serviceNumber!=''}
                    , {$trips->schedule->serviceNumber}
                {/if}
            </td>
        </tr>
    </table>

    <table class="table table-bordered-light" cellpadding="1" width="98%">
        <tr class="info bold">
            <td rowspan="2" width="5%"  align="center">Seat No</td>
            <td rowspan="2" width="10%" align="center">PNR </td>
            <td rowspan="2" width="12%" align="center">BookedDate</td>
            <td width="25%" colspan="{if $action_rights['BRD-HIDE-FARE']!=1}5{else}4{/if}" align="center">Passenger Details</td>
            <td rowspan="2" width="10%" align="center">From</td>
            <td rowspan="2" width="10%" align="center">To</td>
            {if $medium!=1}
            <td rowspan="2" width="10%" align="center">Boarding Point</td>
            {/if}
            {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
            <td rowspan="2" width="10%" align="center">Booked by</td>
            {/if}
            <td rowspan="2" width="5%"  align="center">Booked Type</td>
        </tr>
        <tr class="info bold">
            <td width="7%" align="left">Name</td>
            <td width="3%" align="center">Age</td>
            <td width="3%" align="center">G</td>
            <td width="7%" align="center">Mobile</td>
            {if $action_rights['BRD-HIDE-FARE']!=1}
            <td wwidth="5%" align="center">Fare</td>
            {/if}
        </tr>
        <tbody
            {foreach item=point from=$points}
                {if $bp_books[$point['code']]|count > 0}
                    <tr>
                        <td colspan="13" align="center" class="bold">
                            <b>{$point['stageName']} - {$point['name']} - {$point['time']}
                                {if $point['landmark']!=''}
                                ; &nbsp;&nbsp; Landmark : {$point['landmark']}
                                {/if}
                            </b>
                        </td>  
                    </tr>
                    {foreach item=bk from=$bp_books[$point['code']]}
                        <tr>
                            <td align="center" {if $bk->remarks !=""} rowspan="2" {/if} > {$bk->seatName}</td>
                            <td align="center" {if $bk->remarks !=""} rowspan="2" {/if} class="bold">{$bk->ticketCode}</td>
                            <td align="center">{$bk->bookedDate|date_format:$ns_datetime_format}</td>

                            <td align="left">{$bk->passengerName|truncate:20}</td>
                            <td align="center">{$bk->passengerAge}</td>
                            <td align="center">{$bk->gender}</td>
                            <td align="center" >{$bk->passengerMobile}</td>
                            {if $action_rights['BRD-HIDE-FARE']!=1}
                            <td align="right">{if $bk->seatFare<=0} FT {else} {$bk->seatFare+$bk->acBusTax} {/if}</td>
                            {/if}

                            <td align="left">{$bk->fromStation->name}</td>
                            <td align="left">{$bk->toStation->name}</td>
                            {if $medium!=1}
                            <td align="left">{$bk->boardingPoint->name}</td>
                            {/if}
                            {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
                                <td align="left">{$bk->bookedBy->name}</td> 
                            {/if}
                            <td align="left">{$bk->bookedType}</td> 
                        </tr>
                        {if $bk->remarks !=""}
                            <tr>
                                <td align="left" colspan="11">{$bk->remarks}</td>
                            </tr>
                        {/if}
                    {/foreach}    
                {/if}
            {/foreach}
            
            {foreach item=qs from=$quotaSeats}
            <tr>
                <td align="center">{$qs->quotaSeat->seatName}</td>
                <td align="center"><b>Quota</b></td>
                <td align="center">&nbsp</td>

                <td align="left">&nbsp</td>
                <td align="center">&nbsp</td>
                <td align="center">{$qs->quotaSeat->passengerGendar}</td>
                <td align="center">&nbsp</td>
                <td align="right">&nbsp</td>

                <td align="left">{$qs->fromStation->name}</td>
                <td align="left">{$qs->toStation->name}</td>
                <td align="left">&nbsp</td>
                <td align="left">{$qs->user->name}</td>
            </tr>
            {/foreach}

            {foreach item=bk from=$unbookedlist}
                <tr >
                    <td align="center">{$bk['seatName']}</td>
                    <td align="center">&nbsp</td>
                    <td align="center">&nbsp</td>

                    <td align="left">&nbsp</td>
                    <td align="center">&nbsp</td>
                    <td align="center">&nbsp</td>
                    <td align="center">&nbsp</td>
                    {if $action_rights['BRD-HIDE-FARE']!=1}
                    <td align="right">&nbsp</td>
                    {/if}

                    <td align="left">&nbsp</td>
                    <td align="left">&nbsp</td>
                    {if $medium!=1}
                    <td align="left">&nbsp</td>
                    {/if}
                    {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
                        <td align="left">&nbsp</td> 
                    {/if}
                    <td align="left">&nbsp</td> 
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
                        <td class="bold" align="center"><b>Vacant Seats</b></td>                                            
                        <td class="" colspan="2">{$unbooked_seat_names}</td>
                    </tr>
                    {if count($quotaSeatsList) > 0}
                    <tr>
                        <td align="center"><b>Quota Seats</b></td>                                            
                        <td class="" colspan="2">{$quotaSeatsList|implode:', '}</td>
                    </tr>
                    {/if}
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
                            {assign var="tot_bo_seats" value=0}
                            {foreach item=entity from=$bookinglist key=bookeduser}
                                <tr>
                                    <td >{$bookeduser}</td>                                            
                                    <td >{$entity|count}</td>
                                </tr>
                                {$tot_bo_seats = $tot_bo_seats + $entity|count}
                            {/foreach}                                                        
                            <tr>
                                <td align="right"><b>Total</b></td>                                            
                                <td><b>{$tot_bo_seats}</b></td>
                            </tr>
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
                                <td class="bold" ><b>Seat Count</b></td>
                                <td class="bold" ><b>Seat Name</b></td>                                                            
                            </tr>
                            {assign var="prestation" value=""}
                            {foreach item=point from=$points_dp}
                                {if $dp_books[$point['code']]|count > 0}
                                    <tr>
                                        <td>{if $prestation!=$point['stageName']} {$point['stageName']} {/if}</td>
                                        <td >{$point['name']}</td> 
                                        <td >{$dp_books[$point['code']]|count}</td>
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
    <script>
        window.print();
    </script>    
