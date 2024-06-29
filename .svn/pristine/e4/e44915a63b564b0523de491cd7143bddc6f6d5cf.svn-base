<html>
    <head>
        <title>Trip Chart</title>
        <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    </head>
    <body>

        {if $api_error==1}
            Sorry! Error getting data. Please try again later.
        {else}

            <table class="remove-border-top" cellpadding="5"  width="98%">
        
                <tr>
                    <td align="center">
                        <img src="{$base_url}public/{$namespace}/trip_chart_logo.jpg" >
                    </td>
                </tr>
                <tr>
                    <td align="right" style="font-size:10px">Printed By {$usr_login_name} @ {date("d/m/Y h:i A")} </td>
                </tr>
                <tr>
                    <td width="100%" colspan="2">
                        <table width="100%">
                            <tr>
                                <td width="40%">
                                    <b>Scheduel Name :</b> {$trips->schedule->name}<br>  
                                    <b>Bus Type :</b> {$category}, {$from_time|date_format:$ns_time_format}<br>
                                    <b>Driver Name :</b> {$data->driverName}
                                </td>
                                <td width="40%" >
                                    <b>Trip Id : </b>  {$tripCode}<br>
                                    <b>Travel Date: </b>{$from_time|date_format:$ns_date_format}<br>
                                    <b>Mobile :</b> {$data->driverMobile}
                                </td>
                                <td width="20%"> 
                                    {if $trips->schedule->serviceNumber!=''}
                                    <span style="border:1px solid #aaa; padding: 5px;"><b>{$trips->schedule->serviceNumber}</b></span> <br><br>
                                    {/if}
                                    <b>Vehicle : </b>  {$vehicle_nunmber}  
                                </td>
                            </tr>
                        </table> 
                    </td>
                </tr>
            </table>

            <table class="table table-bordered" cellpadding="5" width="98%">
                <tr class="info bold">
                    <th rowspan="2" width="5%" align="center">Seat No</th>
                    <th rowspan="2" width="10%" align="center">PNR </th>
                    <th rowspan="2" width="10%" align="center">BookedDate</th>
                    <th colspan="4" align="center">Passenger Details</th>
                    <th rowspan="2" width="10%" align="center">From</th>
                    <th rowspan="2" width="10%" align="center">To</th>
                    <th rowspan="2" width="10%" align="center">Boarding Point</th>
                    {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
                    <th rowspan="2" width="10%" align="center">Booked by</th>
                    {/if}
                    <th rowspan="2" width="5%"  align="center">Booked Type</th>
                </tr>
                <tr class="info bold">
                    <th wwidth="7%" align="left">Name</th>
                    <th wwidth="3%" align="center">Age</th>
                    <th wwidth="3%" align="center">G</th>
                    <th wwidth="7%" align="center">Mobile</th>
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
                                <td align="center" {if $bk->remarks !=""} rowspan="2" {/if} ><b>{$bk->ticketCode}</b></td>
                                <td align="center">{$bk->bookedDate|date_format:$ns_date_format}</td>

                                <td align="left"><b>{$bk->passengerName}</b></td>
                                <td align="center">{$bk->passengerAge}</td>
                                <td align="center">{$bk->gender}</td>
                                <td align="center"><b>{$bk->passengerMobile}</b></td>


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
            
            <table class="table remove-border-top" width="100%">
                <tr>
                    <td width="40%" valign="top" >
                        <h5>Boarding Details</h5>    
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

                        {if $action_rights['TRC-USR-BOOK']>0}
                            <h5>User Booking List</h5>
                            <table class="table table-bordered" width="100%">
                                <tr>
                                    <td class="bold"><b>User</b></td>
                                    <td class="bold"><b>Seats</b></td>
                                    <td class="bold"><b>Seat Count</b></td>
                                    {if $action_rights['tripChart.showSettlementFareOnly']==1}
                                    <td class="bold"><b>Fare</b></td>
                                    {else}
                                    <td class="bold"><b>Payable</b></td>  
                                    {/if}                                                         
                                </tr>
                                {assign var="tot_bo_seats" value=0}
                                {assign var="tot_ca_seats" value=0}
                                {assign var="tot_bo_fare" value=0}
                                {assign var="tot_payable" value=0}
                                {foreach item=entity from=$settlement key=bookeduser}
                                    <tr>
                                        <td >{$bookeduser}</td>                                            
                                        <td >{$entity['bo_seats_names']}</td>
                                        <td >
                                            {$entity['bo_seats']|number_format:0} |
                                            {$entity['ca_seats']|number_format:0}
                                        </td>
                                        {if $action_rights['tripChart.showSettlementFareOnly']==1}
                                        <td align="right">{$entity['bo_fare']|number_format:2}</td>
                                        {else}
                                        <td align="right">{$entity['payable']|number_format:2}</td>  
                                        {/if}
                                    </tr>
                                    {$tot_bo_seats = $tot_bo_seats + $entity['bo_seats']}
                                    {$tot_ca_seats = $tot_ca_seats + $entity['ca_seats']}
                                    {$tot_bo_fare = $tot_bo_fare + $entity['bo_fare']}
                                    {$tot_payable = $tot_payable + $entity['payable']}
                                {/foreach}
                                 <tr>
                                     <td align="right" colspan="2"><b>Total</b></td>
                                    <td nowrap='nowrap'><b>
                                        {$tot_bo_seats|number_format:0} |
                                        {$tot_ca_seats|number_format:0}</b>
                                    </td>
                                    {if $action_rights['tripChart.showSettlementFareOnly']==1}
                                    <td align="right"><b>{$tot_bo_fare|number_format:2}</b></td>
                                    {else}
                                    <td align="right"><b>{$tot_payable|number_format:2}</b></td>
                                    {/if}
                                </tr>  
                            </table>
                        {/if}
                    </td>
                    <td width="1%" ></td>
                    <td width="50%" valign="top" > 
                        <h5>Seat Status</h5>
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
                        </table>
                            
                        {if $action_rights['TRP-VIEW-DROP-POINT']>0}
                        <h5>Dropping Details</h5>    
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
        
        

    </body>
</html> 

<script>
    window.print();
</script>    