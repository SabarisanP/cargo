<table class="" width="95%">
    <tr>
        <td  colspan="6" align="center"><h5><b>Trip Payment Sheet</b></h5></td>
    </tr>
    <tr>
        <td align="left" class="bold">Trip</td>
        <td width="1%"align="center" class="bold">:</td>
        <td align="left">{$smarty.request.trip_name}</td>
        <td align="left" class="bold">Agent Name</td>
        <td width="1%" align="center" class="bold">:</td>
        <td align="left">{$user}</td>
    </tr>
    <tr>
        <td align="left" class="bold">Travel Date</td>
        <td width="1%" align="center" class="bold">:</td>
        <td align="left">{$smarty.request.travel_date|date_format:$ns_date_format}</td>
        <td align="left" class="bold">Vehicle & Driver</td>
        <td width="1%" align="center" class="bold">:</td>
        <td align="left">{$info->busVehicle->registationNumber}, {$info->driverName}</td>
        
    </tr>
    <tr>
        <td align="left" class="bold">Booked Seats</td>
        <td width="1%" align="center" class="bold">:</td>
        <td align="left">{$Booking|count}</td>
        <td align="left" class="bold">Report Date/Time</td>
        <td width="1%" align="center" class="bold">:</td>
        <td align="left">{$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>

</table>

<div align="left"   class="table table-responsive" id="adv-report-grid">
   
    <table class="table table-bordered" cellpadding="5" width="98%">
        <tr class="success bold">
            <th width="5%" align="center">Seat No</th>
            <th width="10%" align="center">PNR </th>
            <th width="10%" align="center">BookedDate</th>
            <th width="10%" align="center">Passenger Name</th>
            <th width="5%" align="center">Gender</th>
            <th width="10%" align="center">Mobile</th>
            <th width="10%" align="center">From</th>
            <th width="10%" align="center">To</th>
            <th width="10%" align="center">Boarding Point</th>
            <th width="10%" align="center">Fare</th>
        </tr>
        <tbody>
            {assign var="sts" value=""}
            {assign var=seat value=0}
            {assign var="totalfare" value=0}
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
                        <td align="center">{$bk->gender}</td>
                        <td align="center">{$bk->passengerMobile}</td>
                        
                        <td align="left">{$bk->fromStation->name}</td>
                        <td align="left">{$bk->toStation->name}</td>
                        <td align="left">{$bk->boardingPoint->name}</td>
                        <td align="right">{$bk->seatFare+$bk->acBusTax}</td>
                        {assign var="totalfare" value=$totalfare+$bk->seatFare+$bk->acBusTax}
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

                {/if}

            {/foreach} 
            <tr class="bold">
                <td colspan="9" align="right">Total Fare</td>
                <td align="right">{$totalfare|number_format:2}</td>
            </tr>
        </tbody>
    </table>
    <br>
    <table class="table table-bordered" style="width:60%;">
        <tr>
            <td colspan="2"  class="bold text-center" >Booking</td>
            <td colspan="2" class="bold text-center" >Cancellation</td>
        </tr>
        <tr>
            <td class="bold" >Fare (B1)</td>
            <td align='right'>{$settlement['bo_fare']|number_format:2}</td>
            <td class="bold">Fare With GST (C1)</td>                                                            
            <td align='right'>{($settlement['ca_fare']+$settlement['ca_ac_tax'])|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Discount (B2)</td>
            <td align='right'>{$settlement['bo_discount']|number_format:2}</td>
            <td class="bold" >Discount (C2)</td>
            <td align='right'>{$settlement['ca_discount']|number_format:2}</td>            
        </tr>
        <tr>
            <td class="bold" >A/C GST (B3)</td>
            <td align='right'>{$settlement['bo_ac_tax']|number_format:2}</td>
            <td class="bold">Charges (C3)</td>                                                            
            <td align='right'>{$settlement['ca_charges']|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Commission (B4)</td>
            <td align='right'>{$settlement['bo_comission']|number_format:2}</td>
            <td class="bold">Agent Share (C4)</td>                                                            
            <td align='right'>{$settlement['ca_share']|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Sub Total (A=B1-B2+B3-B4)</td>
            <td align='right'>{$settlement['bo_payable']|number_format:2}</td>
            <td class="bold">Refund (C5 = C1-C2-C3)</td>                                                            
            <td align='right'>{$settlement['ca_refund']|number_format:2}</td>            
        </tr>
        <tr>
            <td class="bold" ></td>
            <td align='right'></td>
            <td class="bold">Cancellation Revenue (B=C3-C4)</td>                                                            
            <td align='right'>
                {$stot = $settlement['ca_charges']-$settlement['ca_share']}
                {$stot|number_format:2}
            </td>
        </tr>        
        <tr>
            <td class="bold" colspan="3" align='right' >Net Payable (A+B)</td>                                                                                           
            <td class="bold" align='right'>
                {$settlement['payable']|number_format:2}
            </td>
        </tr>
    </table>  
            
    <h6><b>Boarding Details</b></h6>        
    <table class="table table-bordered">
        <tr>
            <td class="bold" nowrap>Station</td>
            <td class="bold" >Station Point</td>
            <td class="bold" >Seats Count</td>
            <td class="bold" >Seat Name</td>                                                            
        </tr>
        {assign var="prestation" value=""}                                                        

        {foreach item=point from=$points}            
            {if $bp_books[$point['code']]|count > 0}
                <tr>
                    <td>{if $prestation!=$point['stageName']} {$point['stageName']} {/if}</td>
                    <td >{$point['name']} - {$point['time']}</td>  
                    <td>{$bp_books[$point['code']]|count}</td>
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
    
    <h6><b>Dropping Details</b></h6>        
    <table class="table table-bordered">
        <tr class="float-right">
            <td class="bold" nowrap>Station</td>
            <td class="bold" >Station Point</td>
            <td class="bold" >Seats Count</td>
            <td class="bold" >Seat Name</td>                                                            
        </tr>
        {assign var="prestation" value=""}                                                        

        {foreach item=point from=$points_dp}
            {if $dp_books[$point['code']]|count > 0}
                <tr>
                    <td>{if $prestation!=$point['stageName']} {$point['stageName']} {/if}</td>
                    <td >{$point['name']}</td>
                    <td>{$dp_books[$point['code']]|count}</td>
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
            
</div>

<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <!--<button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button> -->
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>       

