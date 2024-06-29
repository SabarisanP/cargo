<div class="brand_top">
    <h3>Trip Chart</h3> 
    <span class="align-right">
        <a href="#report/trip-chart?date={$smarty.request.date}" class="btn btn-success  btn-sm"> <i class="fa fa-arrow-left"></i> Back</a>
    </span>
</div>

<div id="main-content">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div class="clear_fix_both"></div>
                <br />
                <div id="contents" class="col-lg-12">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-12">
                                    {if $api_error==1}
                                        Sorry! Error getting data. Please try again later.
                                    {else}
                                        <table class="remove-border-top">
                                            <tr>
                                                <td class="bold"  width="5%">Trip : &nbsp;</td>
                                                <td  width="50%">{$from} - {$to} {$trips->bus->name} {$category} {$from_time|date_format:$ns_time_format}  </td>
                                                <td class="bold">Trip Date : &nbsp;</td>
                                                <td width="8%">{$from_time|date_format:$ns_date_format}</td>
                                                <td  class="bold">Trip ID : &nbsp;</td>
                                                <td  width="10%">{$tripCode}</td>
                                                <td class="bold">Schedule ID : &nbsp;</td>
                                                <td width="10%" >{$trips->schedule->code}</td>
                                            </tr>
                                        </table>
                                        <div id="chart_meta_link" class="pull-right noprint">
                                            <a href="javascript:;" onclick="toggleChartMeta()">more info</a>
                                        </div>        
                                        <table class="table remove-border-top noprint" style="display: none" id="chart_meta_container">
                                            <tr>
                                                <td>
                                                    <div class="row">
                                                        <div class="col-lg-8">
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <!--<div class="form-group">
                                                                        <label for="bus-list">Bus</label>
                                                                        <select class="form-control" id="bus-list" name="bus-list">
                                                                            <option value=""> Select bus </option>
                                                                        </select>
                                                                    </div>-->
                                                                    <div class="form-group">
                                                                        <label for="driver-name">Driver Name</label>
                                                                        <input type="text" class="form-control" value="{$data->driverName}" id='driver-name' name='driver-name'>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="driver-name">Driver Phone</label>
                                                                        <input type="text" class="form-control" value="{$data->driverMobile}" id='driver-phone' name='driver-phone'>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6">
                                                                    <div class="form-group">
                                                                        <label for="remarks">Remarks</label>
                                                                        <textarea class="form-control rs_no"  id='remarks' name="remarks" rows="2" cols="10">{$data->remarks}</textarea>
                                                                    </div>
                                                                    
                                                                    <div class="form-group center">
                                                                        <div id="remarks_action"></div>
                                                                        <button class="btn btn-success pull-right" id="btn_save_remarks">Save</button>
                                                                    </div>                                                                    
                                                                    
                                                                </div>
                                                            </div>                                                            
                                                        </div>
                                                        <div class="col-lg-4">
                                                           <div class="form-group">
                                                                <label for="sms_content">SMS Message</label>
                                                                <textarea class="form-control rs_no"  id='sms_content' name="sms_content" rows="2" cols="10">{$data->smscontent}</textarea>
                                                            </div>
                                                            
                                                            <div class="form-group">
                                                                <div id="sms_action"></div>
                                                                <button class="btn btn-success pull-right" id="btn_send_sms">Send</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>        
                                        
                                        <table class="table table-bordered" width="100%">
                                            <tr class="info bold">
                                                <td rowspan="2" width="5%" align="center">Seat No</td>
                                                <td rowspan="2" width="10%" align="center">PNR </td>
                                                <td rowspan="2" width="10%" align="center">Date of booking</td>
                                                <td colspan="4" align="center">Passenger Details</td>
                                                <td rowspan="2" width="10%" align="center">From</td>
                                                <td rowspan="2" width="10%" align="center">To</td>
                                                <td rowspan="2" width="10%" align="center">Boarding Point</td>
                                                <td rowspan="2" width="10%" align="center">Booked by</td>
                                                <td rowspan="2" width="5%"  align="center">Booking Type</td>
                                            </tr>
                                            <tr class="info bold">
                                                <td wwidth="7%" align="left">Name</td>
                                                <td wwidth="3%" align="center">Age</td>
                                                <td wwidth="3%" align="center">G</td>
                                                <td wwidth="7%" align="center">Mobile</td>
                                            </tr>
                                            <tbody
                                            {assign var="sts" value=""}
                                            {assign var=seat value=0}
                                            {foreach item=trip from=$trips->bus->seatLayoutList}
                                                {assign var='stage_book_count' value=count($Booking[$trip->seatName])}
                                                <tr>
                                                
                                                    <td {if $stage_book_count>1}rowspan="{$stage_book_count}" {/if} align="center">{$trip->seatName}</td>

                                                    {if count($Booking[$trip->seatName]) > 0}

                                                        {foreach item=bk name=stage from=$Booking[$trip->seatName] }
                                                            <td align="center"> {$bk->ticketCode}</td>
                                                            <td align="center">{$bk->bookedDate|date_format:$ns_date_format}</td>
                                                            
                                                            <td align="left">{$bk->passengerName}</td>
                                                            <td align="center">{$bk->passengerAge}</td>
                                                            <td align="center">{$bk->gender}</td>
                                                            <td align="center">{$bk->passengerMobile}</td>
                                                                   

                                                            <td align="left">{$bk->fromStation->name}</td>
                                                            <td align="left">{$bk->toStation->name}</td>
                                                            <td align="left">{$bk->boardingPoint->name}</td>
                                                            <td align="left">{$bk->bookedBy->name}</td> 
                                                            <td align="left">{$bk->bookedType}</td> 
                                                            {if $stage_book_count>1}
                                                                {if $smarty.foreach.stage.index<$stage_book_count}
                                                                </tr>
                                                                <tr>
                                                                {/if}
                                                            {/if}    
                                                        {/foreach}
                                                    {else}
                                                        {assign var=seat value=$seat+1}
                                                        {if $sts==''}
                                                            {$sts="`$trip->seatName`"}
                                                        {else}
                                                            {$sts="`$sts` , `$trip->seatName`"}
                                                        {/if}
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        
                                                        <td >&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                    {/if}
                                                </tr>
                                            {/foreach}  
                                            </tbody>
                                        </table>
                                        
                                        
                                        <table class="table remove-border-top" width="100%">
                                            <tr>
                                                <td width="50%">
                                                    <h5>Seat Status</h5>
                                                    <table class="table table-bordered">
                                                        <tr>
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
                                                            <td class="bold" align="center">Vacant Seat Number</td>                                            
                                                            <td class="" colspan="2">{$sts}</td>
                                                        </tr>
                                                    </table>
                                                        
                                                    <h5>Boarding Details</h5>    
                                                    <table class="table table-bordered">
                                                        <tr>
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
                                                    
                                                    {if $action_rights['USR-BK']>0}
                                                    <h5>User Booking List</h5>
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <td class="bold">User Name</td>
                                                            <td class="bold">Seat Name</td>
                                                            <td class="bold">Total Amount</td>                                                            
                                                        </tr>
                                                        {foreach item=entity from=$bookinglist key=bookeduser}
                                                            <tr>
                                                                <td >{$bookeduser}</td>                                            
                                                                <td >
                                                                    {assign var="seatsTotal" value=0}
                                                                    {foreach item=seatsEntity from=$entity}
                                                                        {$seatsEntity['seatName']}, 
                                                                        {assign var="seatsTotal" value=$seatsTotal+$seatsEntity['seatFare']}
                                                                    {/foreach}
                                                                </td>
                                                                <td align="">Rs {$seatsTotal}</td>
                                                            </tr>
                                                        {/foreach}                                                        
                                                        
                                                    </table>
                                                    {/if}
                                                    
                                                </td>
                                                <td width="50%">
                                                    <h5>Bus Map</h5>
                                                    <table class="table remove-border-top" width="100%">
                                                        <tr>
                                                            <td>
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                                                                
                                        <div align='center' class="noprint">
                                            {if $data->trip->tripStatus->code=="TPO"}
                                            <a href="javascript:;" onclick="close_print_chart('{$tripCode}')" class='btn btn-success'>Close & Print</a>
                                            {/if}
                                            <a href="javascript:;" onclick="print_trip_chart('{$tripCode}');" class='btn btn-success'>Print</a>
                                            <a href="#report/trip-chart?date={$smarty.request.date}" class='btn btn-default'>Back</a>
                                        </div>
                                    {/if}    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{literal}
<script>
    var trip_code = "{/literal}{$tripCode}{literal}";
function _init_chart_page() {
    init_chart_actions();
}</script>
{/literal}
