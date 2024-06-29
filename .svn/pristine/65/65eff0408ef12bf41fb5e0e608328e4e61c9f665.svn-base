<style>
    .bold {
        font-weight: bold;
    }
</style>
{if $api_error==1}
    Sorry! Error getting data. Please try again later.
{else}
    <table class="remove-border-top">
        <tr>
            <td width="100%" colspan='5'>
                <span class="bold">Trip</span> : &nbsp;
                {$trips->schedule->name}, {$category}, {$from_time|date_format:$ns_time_format}
                {if $trips->schedule->serviceNumber!=''}
                    &nbsp;<span class="badge badge-warning">{$trips->schedule->serviceNumber}</span>
                {/if}
            </td>
        </tr>
        <tr>
            <td width="10%"  colspan='2'><span class="bold">Vehicle</span>: &nbsp;{$vehicle_nunmber}</td>
            <td width="10%"><span class="bold">Trip Date</span>: &nbsp;{$from_time|date_format:$ns_date_format}</td>
            <td width="10%"><span class="bold">Trip Id</span>: &nbsp; {$tripCode}</td>
            <td width="10%"><span class="bold">Schedule Id</span>: &nbsp; {$trips->schedule->code}</td>
        </tr>
    </table>
{/if}
<br/>

<table border="1" class="table table-bordered noprint" width="100%">
    <tr class="info bold" style="background-color: #ccc;">
        <td rowspan="2" width="5%" align="center">Seat No</td>
        <td rowspan="2" width="10%" align="center">PNR </td>
        <td rowspan="2" width="10%" align="center">Date of booking</td>
        <td colspan="5" align="center">Passenger Details</td>
        <td rowspan="2" width="10%" align="center">From</td>
        <td rowspan="2" width="10%" align="center">To</td>
        <td rowspan="2" width="10%" align="center">Boarding Point</td>
        {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
            <td rowspan="2" width="10%" align="center">Booked by</td>
        {/if}
        <td rowspan="2" width="5%"  align="center">Booking Type</td>
    </tr>
    <tr class="info bold" style="background-color: #ccc;">
        <td wwidth="7%" align="left">Name</td>
        <td wwidth="3%" align="center">Age</td>
        <td wwidth="3%" align="center">G</td>
        <td wwidth="7%" align="center">Mobile</td>
        <td wwidth="7%" align="center">Fare</td>
    </tr>
    <tbody
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
                        {if $smarty.foreach.stage.index>0}
                        </tr>
                        <tr>
                        {/if}

                        {if $smarty.foreach.stage.index==0}
                            <td {if $tot_sp>1} rowspan="{$tot_sp}" {/if} align="center">{$trip->seatName}</td>
                        {/if}
                        <td align="center" {if $bk->remarks !=""} rowspan="2" {/if} >{$bk->ticketCode}</td>
                        <td align="center">{$bk->bookedDate|date_format:$ns_date_format}</td>

                        <td align="left">{$bk->passengerName}</td>
                        <td align="center">{$bk->passengerAge}</td>
                        <td align="center">{$bk->gender}</td>
                        <td align="center">{$bk->passengerMobile}</td>
                        <td align="right">
                            {if $bk->seatFare<=0} FT {else} {$bk->seatFare+$bk->acBusTax} {/if}
                        </td>


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


<h5>Seat Status</h5>
<table border="1" class="table table-bordered">
    <tr style="background-color: #ccc;">
        <td class="bold" align="center" nowrap>Total no of seats</td>
        <td class="bold" align="center">Total no of vacant</td>
        <td class="bold" align="center">Total no of booked seat</td>

    </tr>
    <tr>
        <td align="center">{$totalSeatCount}</td>
        <td align="center">{$seat}</td>
        <td align="center">{count($Booking)}</td>
    </tr>
    <tr>
        <td class="bold" align="center">Vacant Seats</td>
        <td class="" colspan="2">{$sts}</td>
    </tr>
    {if count($quotaSeatsList) > 0}
        <tr>
            <td class="bold" align="center">Quota Seats</td>
            <td class="" colspan="2">{$quotaSeatsList|implode:', '}</td>
        </tr>
    {/if}
</table>

<h5>Boarding Details</h5>
<table border="1" class="table table-bordered">
    <tr style="background-color: #ccc;">
        <td class="bold"  nowrap>Station</td>
        <td class="bold" >Station Point</td>
        <td class="bold" >Seat Name</td>
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
    {if $action_rights['tripChart.showSettlementFareOnly']!=1}
        <p class="text-right text-danger">* Payable - Exclusive of commissions</p>
    {/if}
    <table border="1" class="table table-bordered">
        <tr style="background-color: #ccc;">
            <td class="bold">User Name</td>
            <td class="bold">Seats</td>
            <td class="bold">Seat Count</td>
            {if $action_rights['tripChart.showSettlementFareOnly']==1}
                <td class="bold">Fare</td>
            {else}
                <td class="bold">GST</td>
                <td class="bold">Payable</td>
            {/if}
        </tr>
        {assign var="tot_bo_seats" value=0}
        {assign var="tot_ca_seats" value=0}
        {assign var="tot_bo_fare" value=0}
        {assign var="tot_bo_gst" value=0}
        {assign var="tot_payable" value=0}
        {foreach item=entity from=$settlement key=bookeduser}
            <tr>
                <td >{$bookeduser}</td>
                <td >{$entity['bo_seats_names']}</td>
                <td nowrap='nowrap' >
                    {$entity['bo_seats']|number_format:0} |
                    {$entity['ca_seats']|number_format:0}
                </td>
                {if $action_rights['tripChart.showSettlementFareOnly']==1}
                    <td align="right">{$entity['bo_fare']|number_format:2}</td>
                {else}
                    <td align="right">{$entity['bo_ac_tax']|number_format:2}</td>
                    <td align="right">{$entity['payable']|number_format:2}</td>
                {/if}
            </tr>
            {$tot_bo_seats = $tot_bo_seats + $entity['bo_seats']}
            {$tot_ca_seats = $tot_ca_seats + $entity['ca_seats']}
            {$tot_bo_fare = $tot_bo_fare + $entity['bo_fare']}
            {$tot_bo_gst = $tot_bo_gst + $entity['bo_ac_tax']}
            {$tot_payable = $tot_payable + $entity['payable']}
        {/foreach}
        <tr>
            <td align="right" colspan="2" class="bold">Total</td>
            <td nowrap='nowrap' class="bold">
                {$tot_bo_seats|number_format:0} |
                {$tot_ca_seats|number_format:0}
            </td>
            {if $action_rights['tripChart.showSettlementFareOnly']==1}
                <td align="right" class="bold">{$tot_bo_fare|number_format:2}</td>
            {else}
                <td align="right" class="bold">{$tot_bo_gst|number_format:2}</td>
                <td align="right" class="bold">{$tot_payable|number_format:2}</td>
            {/if}
        </tr>
    </table>
{/if}
{if $action_rights['TRP-VIEW-DROP-POINT']>0}
    <h5>Dropping Details</h5>
    <table border="1" class="table table-bordered">
        <tr style="background-color: #ccc;">
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
{/if}
