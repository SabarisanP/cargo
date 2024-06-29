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
                    {if $data->driverName!='' && $data->driverMobile!=''}  | Driver : {$data->driverName} {$data->driverMobile} {/if}
                    {if $trips->schedule->serviceNumber!=''}
                        , {$trips->schedule->serviceNumber}
                    {/if}
                </td>
            </tr>
        </table>

            <table class="table table-bordered-light" cellpadding="1" width="98%">
                <tr class="info bold">
                    <td rowspan="2" width="5%" align="center">Seat No</td>
                    <td rowspan="2" width="10%" align="center">PNR </td>
                    <td rowspan="2" width="10%" align="center">BookedDate</td>
                    <td colspan="4" align="center">Passenger Details</td>
                    <td rowspan="2" width="10%" align="center">From</td>
                    <td rowspan="2" width="10%" align="center">To</td>
                    <td rowspan="2" width="10%" align="center">Boarding Point</td>
                    {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
                    <td rowspan="2" width="10%" align="center">Booked by</td>
                    {/if}
                    <td rowspan="2" width="5%"  align="center">Booked Type</td>
                </tr>
                <tr class="info bold">
                    <td wwidth="7%" align="left">Name</td>
                    <td wwidth="3%" align="center">Age</td>
                    <td wwidth="3%" align="center">G</td>
                    <td wwidth="7%" align="center">Mobile</td>
                </tr>
                <tbody>
                    {assign var="sts" value=""}
                    {assign var=seat value=0}
                    {foreach item=trip from=$trips->bus->seatLayoutList}
                        {assign var='stage_book_count' value=count($Booking[$trip->seatName])}
                        
                        {assign var='pnr_remark' value=0}                                                    
                        {foreach item=bkt name=stage from=$Booking[$trip->seatName]}                                                        
                            {if $bkt->remarks !=''}
                                {assign var='pnr_remark' value=$pnr_remark+1}
                            {/if}    
                        {/foreach}   
                        {assign var='tot_sp' value=$stage_book_count+$pnr_remark}
                        
                        {if count($Booking[$trip->seatName]) > 0}                                                            
                            <tr>    
                            {foreach item=bk name=stage from=$Booking[$trip->seatName] }
                                {if $smarty.foreach.stage.index==0}
                                <td {if $tot_sp>1} rowspan="{$tot_sp}" {/if} align="center">{$trip->seatName}</td>
                                {/if}
                                <td align="center" {if $bk->remarks !=""} rowspan="2" {/if} >{$bk->ticketCode}</td>
                                <td align="center">{$bk->bookedDate|date_format:$ns_date_format}</td>

                                <td align="left">{$bk->passengerName}</td>
                                <td align="center">{$bk->passengerAge}</td>
                                <td align="center">{$bk->gender}</td>
                                <td align="center">{$bk->passengerMobile}</td>


                                <td align="left">{$bk->fromStation->name}</td>
                                <td align="left">{$bk->toStation->name}</td>
                                <td align="left">{$bk->boardingPoint->name}</td>
                                {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
                                <td align="left">{$bk->bookedBy->name}</td> 
                                {/if}
                                <td align="left">{$bk->bookedType}</td>

                                {if $bk->remarks !=""} 
                                </tr>
                                <tr>
                                    <td align="left" colspan="10">{$bk->remarks}</td>
                                </tr>
                                {/if}

                            {/foreach}
                            {if $bk->remarks ==""}
                            </tr>
                            {/if}
                            
                        {elseif $trip->seatName|in_array:$quotaSeatsList}
                            {foreach item=qs from=$quotaSeats}
                                {if $qs->quotaSeat->seatName == $trip->seatName}
                                    <tr>
                                        <td align="center">{$qs->quotaSeat->seatName}</td>
                                        <td align="center">Quota</td>
                                        <td align="center">&nbsp</td>

                                        <td align="left">&nbsp</td>
                                        <td align="center">&nbsp</td>
                                        <td align="center">{$qs->quotaSeat->passengerGendar}</td>
                                        <td align="center">&nbsp</td>

                                        <td align="left">{$qs->fromStation->name}</td>
                                        <td align="left">{$qs->toStation->name}</td>
                                        <td align="left">&nbsp</td>
                                        <td align="left">{$qs->user->name}</td>
                                        <td align="left">&nbsp</td> 
                                    </tr>
                                    {break}
                                {/if}
                            {/foreach}
                        {else}
                            {assign var=seat value=$seat+1}
                            {if $sts==''}
                                {$sts="`$trip->seatName`"}
                            {else}
                                {$sts="`$sts` , `$trip->seatName`"}
                            {/if}
                            <tr>
                            <td align="center" >{$trip->seatName}</td>
                            <td >&nbsp;</td>
                            <td >&nbsp;</td>

                            <td >&nbsp;</td>
                            <td >&nbsp;</td>
                            <td >&nbsp;</td>
                            <td >&nbsp;</td>

                            <td >&nbsp;</td>
                            <td>&nbsp;</td>
                            <td >&nbsp;</td>
                            {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
                            <td >&nbsp;</td>
                            {/if}
                            <td >&nbsp;</td>
                            </tr>
                        {/if}
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

            <table class="table remove-border-top" width="95%">
                <tr>
                    <td width='30%' valign='top' >
                        <b>Seat Status</b>
                        <table class="table table-bordered">
                            <tr>
                                <td class="bold" align="center" nowrap><b>Total no of seats</b></td>
                                <td class="bold" align="center"><b>Total no of vacant</b></td>
                                <td class="bold" align="center"><b>Total no of booked seat</b></td>

                            </tr>
                            <tr>
                                <td align="center">{$totalSeatCount}</td>                                            
                                <td align="center">{$seat}</td>
                                <td align="center">{count($Booking)}</td>
                            </tr>
                            <tr>
                                <td class="bold" align="center"><b>Vacant Seats</b></td>                                            
                                <td class="" colspan="2">{$sts}</td>
                            </tr>
                            {if count($quotaSeatsList) > 0}
                            <tr>
                                <td align="center"><b>Quota Seats</b></td>                                            
                                <td class="" colspan="2">{$quotaSeatsList|implode:', '}</td>
                            </tr>
                            {/if}
                        </table>
                    </td>
                    
                    <td width='60%' valign='top' >
                        <b>Boarding Details</b>    
                        <table class="table table-bordered" width="100%">
                            <tr>
                                <td class="bold"  nowrap><b>Station</b></td>
                                <td class="bold" ><b>Station Point</b></td>
                                <td class="bold" ><b>Seat Name</b></td>  
                            </tr>
                            {assign var="prestation" value=""}
                            {foreach item=station key=fromstation from=$ticketList name=bodet}                                                        
                                {foreach item=seats key=sp from=$station}
                                    <tr>                                                         
                                        <td>{if $prestation!=$fromstation} {$fromstation} {/if}</td>
                                        <td>{$sp}</td>  
                                        <td>
                                            {foreach item=seat key=sp from=$seats}
                                                {$seat}, 
                                            {/foreach} 
                                        </td>
                                    </tr> 
                                    {assign var="prestation" value=$fromstation}
                                {/foreach}                                                         
                            {/foreach}                                                        
                        </table>
                    </td>            
                </tr>
            </table>    
            
            <table class="table remove-border-top" width="95%">
                <tr>
                    {if $action_rights['TRC-USR-BOOK']>0}
                    <td width='30%' valign='top'>                        
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
                    
                    {if $action_rights['TRP-VIEW-DROP-POINT']>0}
                    <td width='65%' valign='top'>
                       <b>Dropping Details</b>    
                        <table class="table table-bordered">
                            <tr>
                                <td class="bold"  nowrap>Station</td>
                                <td class="bold" >Station Point</td>
                                <td class="bold" >Seat Name</td>                                                            
                            </tr>
                            {assign var="prestation" value=""}
                            {foreach item=station key=fromstation from=$ticketListDp name=bodet}                                                        
                                {foreach item=seat key=sp from=$station}
                                    <tr>                                                         
                                        <td>{if $prestation!=$fromstation} {$fromstation} {/if}</td>
                                        <td>{$sp}</td>  
                                        <td>
                                            {foreach item=seatdp key=sp from=$seat}
                                                {$seatdp}, 
                                            {/foreach} 
                                        </td>
                                    </tr> 
                                    {assign var="prestation" value=$fromstation}
                                {/foreach}                                                         
                            {/foreach}                                                        
                        </table>  
                    </td>
                    {/if}
                </tr>
            </table>             
        {/if}                

<script>
    window.print();
</script>    