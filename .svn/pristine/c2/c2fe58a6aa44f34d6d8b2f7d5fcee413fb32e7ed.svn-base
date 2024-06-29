<table class="" width="95%">
    <tr>
        <td  colspan="6" align="center"><h5><b>Tripwise Agent Payment Sheet</b></h5></td>
    </tr>
    <tr>
        <td align="left" class="bold">Trip</td>
        <td width="1%"align="center" class="bold">:</td>
        <td align="left">{$smarty.request.trip_name}</td>
        <td align="left" class="bold">Report Date/Time</td>
        <td width="1%" align="center" class="bold">:</td>
        <td align="left">{$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td align="left" class="bold">Travel Date</td>
        <td width="1%" align="center" class="bold">:</td>
        <td align="left">{$smarty.request.travel_date|date_format:$ns_date_format}</td>
        <td align="left" class="bold">Vehicle & Driver</td>
        <td width="1%" align="center" class="bold">:</td>
        <td align="left">{$info->busVehicle->registationNumber}, {$info->driverName}</td>
        
    </tr>
    
</table>
<br><br>
<div align="left"   class="table table-responsive" id="adv-report-grid">
   
    {foreach item=username key=usercode from=$users}
        {if count($ticketList[$usercode]) > 0}
            <br>
            <div class="bold">{$username}</div>
            <br>
            <table class="table table-bordered" cellpadding="5" width="98%">
                <tr class="success bold">
                    <th width="5%" align="center">Seat</th>
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
                {foreach item=bk from=$ticketList[$usercode] }
                    <tr>  
                        <td align="center">{$bk->seatName}</td>
                        <td align="left">{$bk->ticketCode}</td>
                        <td align="left">{$bk->bookedDate|date_format:$ns_date_format}</td>

                        <td align="left">{$bk->passengerName}</td>
                        <td align="center">{$bk->gender}</td>
                        <td align="center">{$bk->passengerMobile}</td>

                        <td align="left">{$bk->fromStation->name}</td>
                        <td align="left">{$bk->toStation->name}</td>
                        <td align="left">{$bk->boardingPoint->name}</td>
                        <td align="right">{$bk->seatFare+$bk->acBusTax}</td>
                    </tr>
                {/foreach}                
                </tbody>
            </table>
            <br>    
            <table class="table table-bordered" cellpadding="5" style="width:70%;">
                <tr>                    
                    <td>
                        <b>Payable Fare</b> <br>
                        (Fare+GST-Discount-Commission)
                    </td>
                    <td>
                        {assign var="bookamt" value=$settlement[$usercode]['bo_fare'] + $settlement[$usercode]['bo_ac_tax'] - $settlement[$usercode]['bo_discount'] - $settlement[$usercode]['bo_comission']}
                        {$bookamt}
                    </td>                    
                    <td><b>Cancel Charges</b></td>
                    <td>
                        {assign var="cancelcharges" value=$settlement[$usercode]['ca_charges'] - $settlement[$usercode]['ca_share']}
                        {$cancelcharges}
                    </td>                    
                    <td><b>Net Payable</b></td>
                    <td>{$bookamt+$cancelcharges}</td>
                </tr>
            </table>    
        {/if}
    {/foreach} 
</div>

<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>       

