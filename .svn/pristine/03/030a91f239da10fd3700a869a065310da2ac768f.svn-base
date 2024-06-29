<link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
{if $medium==1}
    <link href="{$base_url}assets/css/print-medium.css?{$asset_ver}" rel="stylesheet">
{else}
    <link href="{$base_url}assets/css/print-large.css?{$asset_ver}" rel="stylesheet">
{/if}
{if $api_error==1}
    Sorry! Error getting data. Please try again later.
{else}
    <body style="width: auto;">
    <table class="remove-border-top" cellpadding="5"  width="98%">

        <tr>
            <td align="center">
                <img src="{$web_cdn_url}/bits/print/{$namespace}/trip_chart_logo.jpg" >
            </td>
        <tr>
            <td align="right" style="font-size:10px">Printed By {$usr_login_name} @ {date("d/m/Y h:i A")} </td>
        </tr>
    </tr>
    <tr>
        <td width="98%" colspan="2">
            <table width="100%">
                <tr>
                    <td width="40%">
                        <b>Schedule Name :</b> {$trips->schedule->name}<br>  
                        <b>Bus Type :</b> {$category}, {$from_time|date_format:$ns_time_format}<br>
                        <b>Driver Name :</b> {$data->driverName}
                        {if $data->driverName2 != 'NA'}<br><b>Driver2 Name :</b> {$data->driverName2}{/if}
                        {if $data->attenderName != 'NA'}<br><b>Attender Name :</b> {$data->attenderName}{/if}
                    </td>
                    <td width="40%" >
                        <b>Trip Id : </b>  {$tripCode}<br>
                        <b>Travel Date: </b>{$from_time|date_format:$ns_date_format}<br>
                        <b>Driver Mobile :</b> {$data->driverMobile}
                        {if $data->driverMobile2 != 'NA'}<br><b>Driver2 Mobile :</b> {$data->driverMobile2}{/if}
                        {if $data->attenderMobile != 'NA'}<br><b>Attender Mobile :</b> {$data->attenderMobile}{/if}
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
    <tr class="info bold" >
        <th rowspan="2" width="5%"  align="center"><b>Seat No</b></th>
        <th rowspan="2" width="10%" align="center"><b>PNR </b></th>
        <th rowspan="2" width="10%" align="center"><b>BookedDate</b></th>
        <th colspan="{if $action_rights['BRD-HIDE-FARE']!=1}5{else}4{/if}" align="center"><b>Passenger Details</b></th>
        <th rowspan="2" width="10%" align="center"><b>From</b></th>
        <th rowspan="2" width="10%" align="center"><b>To</b></th>
            {if $medium!=1}
            <th rowspan="2" width="10%" align="center"><b>Boarding Point</b></th>
            {/if}
            {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
            <th rowspan="2" width="10%" align="center"><b>Booked by</b></th>
            {/if}
        <th rowspan="2" width="5%"  align="center"><b>Booked Type</b></th>
    </tr>
    <tr class="info bold">
        <th width="7%" align="left"><b>Name</b></th>
        <th width="3%" align="center"><b>Age</b></th>
        <th width="3%" align="center"><b>G</b></th>
        <th width="7%" align="center"><b>Mobile</b></th>
            {if $action_rights['BRD-HIDE-FARE']!=1}
            <th wwidth="7%" align="center"><b>Fare</b></th>
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
                    <tr  height="35">
                        <td align="center" {if $bk->remarks !=""} rowspan="2" {/if}> {$bk->seatName}</td>
                        <td align="center" class="bold" {if $bk->remarks !=""} rowspan="2" {/if}><b>{$bk->ticketCode}</b></td>
                        <td align="center">{$bk->bookedDate|date_format:$ns_datetime_format}</td>

                        <td align="left">{$bk->passengerName}</td>
                        <td align="center">{$bk->passengerAge}</td>
                        <td align="center">{$bk->gender}</td>
                        <td align="center" ><b>{$bk->passengerMobile}</b></td>
                                {if $action_rights['BRD-HIDE-FARE']!=1}
                            <td align="right">
                                {if $bk->seatFare<=0} FT {else} {$bk->seatFare+$bk->acBusTax} {/if}
                            </td>
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
                <td align="left">&nbsp</td> 
            </tr>
        {/foreach}

        {foreach item=bk from=$unbookedlist}
            <tr height="40">
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
<table class="table remove-border-top" width="98%">
    <tr>
        <td width="50%"> <br>
            <h5>Seat Status</h5>
            <table class="table table-bordered" width="98%" >
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
    <br>{/if}<br>
    {if $action_rights['TRP-VIEW-BUS-MAP']>0}
        <td width="50%" valign="top" >
            {if $action_rights['TRP-VIEW-BUS-MAP']>0}
                &nbsp;
                <h5>Bus Map</h5>
                {if $xmaxl2 > 0 && $xminl2 > 0}
                    <table width="100%" border="1px solid #ddd;">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td rowspan="7" width="2" align="center">U<br>P<br>P<br>E<br>R</td>
                                    </tr>
                                    {for $r=$xminl2 to $xmaxl2}
                                        <tr>
                                            {for $c=$yminl2 to $ymaxl2}
                                                {if $name['2'][$r][$c] != ''}

                                                    {assign var="style" value="border:1px dotted black !important;"}
                                                    {assign var="gen_class" value="empty_book"}

                                                    {if $bookedGender[$name['2'][$r][$c]] == 'F'}
                                                        {assign var="style" value="border:double 3px black !important;"}
                                                        {assign var="gen_class" value="female_book"}
                                                    {/if}  

                                                    {if $bookedGender[$name['2'][$r][$c]] == 'M'}
                                                        {assign var="style" value="border:2px solid black !important;"}
                                                        {assign var="gen_class" value="male_book"}
                                                    {/if}  

                                                    {if $seatcode['2'][$r][$c] != 'RRM' && $seatcode['2'][$r][$c] != 'FRS'}
                                                        <td class="seat-lay-visibility-info {$gen_class}" style="{$style}">
                                                            {$name['2'][$r][$c]}
                                                        </td> 
                                                    {else}
                                                        <td class="seat-lay-visibility-info empty_book" style="border:none !important;">x</td>
                                                    {/if} 
                                                {else}
                                                    <td class="seat-lay-visibility-info-lay empty_book" style="border:none !important;">
                                                    </td>
                                                {/if}
                                            {/for}
                                        </tr>
                                    {/for}
                                </table>
                            </td>
                        </tr>
                    </table> 
                    <br> 
                {/if}
                <table width="100%" border="1px solid #ddd">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td rowspan="7" width="2" align="center">{if $xmaxl2 > 0 && $xminl2 > 0} <div class="seat-map-driver"></div><br>L<br>O<br>W<br>E<br>R{else} <div class="seat-map-driver-info"></div> {/if}</td>
                                </tr>
                                {for $r=$xminl1 to $xmaxl1}
                                    <tr>
                                        {for $c=$yminl1 to $ymaxl1}
                                            {if $name['1'][$r][$c] != ''}
                                                {assign var="style" value="border:1px dotted black !important;"}
                                                {assign var="gen_class" value="empty_book"}

                                                {if $bookedGender[$name['1'][$r][$c]] == 'F'}
                                                    {assign var="style" value="border:double 3px black !important;"}
                                                    {assign var="gen_class" value="female_book"}
                                                {/if}  

                                                {if $bookedGender[$name['1'][$r][$c]] == 'M'}
                                                    {assign var="style" value="border:2px solid black !important;"}
                                                    {assign var="gen_class" value="male_book"}
                                                {/if}  


                                                {if $seatcode['1'][$r][$c] != 'RRM' && $seatcode['1'][$r][$c] != 'FRS'}
                                                    <td class="seat-lay-visibility-info {$gen_class}" style="{$style}">
                                                        {$name['1'][$r][$c]}
                                                    </td> 
                                                {else}
                                                    <td class="seat-lay-visibility-info empty_book" style="border:none !important;">x</td>
                                                {/if}      
                                            {else}
                                                <td class="seat-lay-visibility-info-lay empty_book" style="border:none !important;">
                                                </td>
                                            {/if}
                                        {/for}
                                    </tr>
                                {/for}
                            </table>
                        </td>
                    </tr>
                </table>
                <br/>
                <table>
                    <tr class="float-right">
                        <td class="seat-lay-visibility-info-lay empty_book " style="border:1px dotted black !important;">&nbsp;</td> <td>&nbsp;&nbsp;- Available</td>                                                                                         
                        <td class="seat-lay-visibility-info-lay male_book" style="border:2px solid black !important;">&nbsp;</td><td>&nbsp;&nbsp;- Male </td>
                        <td class="seat-lay-visibility-info-lay female_book" style="border:double 3px black !important;">&nbsp;</td><td>&nbsp;&nbsp;- Female</td>
                    </tr>
                </table>
            </td>
        </tr>
    {/if}
</table>
{/if}        
<h5>Boarding Details</h5>    
<table class="table table-bordered" width="98%">
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
{if $action_rights['BRD-VIEW-DROP-DETAILS']>0}
    <h5>Dropping Details</h5>    
    <table class="table table-bordered" width="98%">
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
{/if}
{if $action_rights['TRP-VIEW-USR-BOOK']>0}
    <h5>User Booking List</h5>
    <table class="table table-bordered" width="98%">
        <tr>
            <td class="bold"><b>User</b></td>
            <td class="bold"><b>Seats</b></td>
            <td class="bold">
                <b>
                    Seat Count<br>
                    BO | PBL | CA
                </b>
            </td>
            {if $action_rights['tripChart.showSettlementFareOnly']==1}
                <td class="bold" nowrap="nowrap"><b>Fare</b></td>
            {else}
                <td class="bold" nowrap="nowrap"><b>Fare</b></td>
                <td class="bold" nowrap="nowrap"><b>GST</b></td>
                <td class="bold" nowrap="nowrap"><b>Commi</b></td>
                <td class="bold" nowrap="nowrap"><b>C.Charges</b></td>
                <td class="bold" nowrap="nowrap"><b>Payable</b></td>  
            {/if}
        </tr>
        {assign var="tot_bo_seats" value=0}
        {assign var="tot_pbl_seats" value=0}
        {assign var="tot_ca_seats" value=0}
        {assign var="tot_bo_fare" value=0}
        {assign var="tot_bo_gst" value=0}
        {assign var="tot_bo_comission" value=0}
        {assign var="tot_ca_charges" value=0}
        {assign var="tot_payable" value=0}
        {foreach item=entity from=$settlement key=bookeduser}
            <tr>
                <td >{$bookeduser}</td>                                            
                <td >{$entity['bo_seats_names']}</td>
                <td >
                    {$entity['bo_seats']|number_format:0} |
                    {$entity['pbl_seats']|number_format:0} |
                    {$entity['ca_seats']|number_format:0}
                </td>
                {if $action_rights['tripChart.showSettlementFareOnly']==1}
                    <td align="right">{($entity['bo_fare']+$entity['bo_ac_tax']-$entity['bo_discount'])|number_format:2}</td>
                {else}
                    <td align="right">{($entity['bo_fare']-$entity['bo_discount'])|number_format:2}</td>
                    <td align="right">{$entity['bo_ac_tax']|number_format:2}</td>
                    <td align="right">{$entity['bo_comission']|number_format:2}</td>
                    <td align="right">{($entity['ca_charges']-$entity['ca_share'])|number_format:2}</td>
                    <td align="right">{$entity['payable']|number_format:2}</td>
                {/if}
            </tr>
            {$tot_bo_seats = $tot_bo_seats + $entity['bo_seats']}
            {$tot_pbl_seats = $tot_pbl_seats + $entity['pbl_seats']}
            {$tot_ca_seats = $tot_ca_seats + $entity['ca_seats']}
            {$tot_bo_fare = $tot_bo_fare + ($entity['bo_fare']-$entity['bo_discount'])}
            {$tot_bo_gst = $tot_bo_gst + $entity['bo_ac_tax']}
            {$tot_bo_comission = $tot_bo_comission + $entity['bo_comission']}
            {$tot_ca_charges = $tot_ca_charges + ($entity['ca_charges']-$entity['ca_share'])}
            {$tot_payable = $tot_payable + $entity['payable']}
        {/foreach}
        <tr>
            <td colspan="2" align="right"><b>Total</b></td>
            <td nowrap='nowrap' ><b>
                    {$tot_bo_seats|number_format:0} |
                    {$tot_pbl_seats|number_format:0} |
                    {$tot_ca_seats|number_format:0}
                </b>
            </td>
            {if $action_rights['tripChart.showSettlementFareOnly']==1}
                <td align="right"><b>{$tot_bo_fare|number_format:2}</b></td>
                    {else}
                <td align="right"><b>{$tot_bo_fare|number_format:2}</b></td>
                <td align="right"><b>{$tot_bo_gst|number_format:2}</b></td>
                <td align="right"><b>{$tot_bo_comission|number_format:2}</b></td>
                <td align="right"><b>{$tot_ca_charges|number_format:2}</b></td>
                <td align="right"><b>{$tot_payable|number_format:2}</b></td>
                    {/if}
        </tr>
    </table>
    <br/><br/>
{/if}


<script>
    window.print();
</script>    
    </body>