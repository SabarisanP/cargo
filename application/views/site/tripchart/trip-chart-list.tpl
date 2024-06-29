<div class="brand_top">
    <h3>Trip Chart</h3> 
    <span class="align-right">
        <a href="#tripchart/trip-chart?date={$smarty.request.date}" class="btn btn-success  btn-sm"> <i class="fa fa-arrow-left"></i> Back</a>
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
                                                <td width="40%" >
                                                    <span class="bold">Trip</span> : &nbsp; 
                                                    {$trips->schedule->name}, {$category}, {$from_time|date_format:$ns_time_format}
                                                    {if $trips->schedule->serviceNumber!=''}
                                                        &nbsp;<span class="badge badge-warning">{$trips->schedule->serviceNumber}</span>
                                                    {/if}
                                                </td>
                                                <td width="10%"><span class="bold">Vehicle</span>: &nbsp;{$vehicle_nunmber}</td>
                                                <td width="10%"><span class="bold">Trip Date</span>: &nbsp;{$from_time|date_format:$ns_date_format}</td>
                                                <td width="10%"><span class="bold">Trip Id</span>: &nbsp; {$tripCode}</td>
                                                <td width="10%"><span class="bold">Schedule Id</span>: &nbsp; {$trips->schedule->code}</td>
                                            </tr>
                                        </table>
                                        {if $action_rights['SCH-TRIP-DRIVER-DETAILS']==1}      
                                        <div id="chart_meta_link" class="pull-right noprint tripchart-vehicle-link">
                                            <a href="javascript:;" onclick="toggleRemarks()"> <i class="fa fa-plus"></i> Add / Edit Notes</a> &nbsp;
                                            <a href="javascript:;" onclick="toggleChartMeta()"> <i class="fa fa-plus"></i> Add / Edit vehicle info</a>
                                        </div>
                                            
                                        <table class="table remove-border-top noprint" style="display: none" id="chart_notes_container">
                                            <tr id="notes-edit">
                                                <td>                                                   
                                                    <div class="well well-sm">
                                                        <div class="row">                                                   
                                                            <div class="col-sm-6">                                                           
                                                                <textarea class="form-control rs_no" placeholder="Service Notes, max 250 characters"  id='notes' name="notes" rows="5" cols="10">{$data->remarks}</textarea>
                                                            </div>                                                       
                                                            <div class="col-sm-6">  
                                                                <div class="alert" id="edit_notes_action">&nbsp;</div>
                                                                
                                                                <div class="">
                                                                    <button class="btn btn-success" id="btn_save_notes">Save</button>                                                            
                                                                </div>
                                                            </div>                      
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>                                           
                                        </table>

                                        <table class="table remove-border-top noprint" style="display: none" id="chart_meta_container">
                                            <tr id="edit-info">
                                                <td>
                                                    <div class="alert alert-danger text-center hide" id="info-update-warning">
                                                        Please update vehicle and driver details of this service to take print out.
                                                    </div>
                                                    
                                                    <div class="well well-sm">
                                                        <div class="row">                                                        
                                                            <div class="col-lg-3">
                                                                <div class="form-group">
                                                                    <label for="driver-name" >Driver 1 Name & Mobile</label>
                                                                    <select id="driver-name" class="form-control" onchange="getMobileNumber(this, '#driver-phone', drivers);">
                                                                        <option value="">Select Driver</option>
                                                                        {foreach from=$drivers item=row}
                                                                            <option value="{$row->code}" data-name="{$row->name}" {if $row->name == $data->driverName}selected{/if}>
                                                                                {$row->name|upper}
                                                                                {if $row->employeeCode!="" && $row->employeeCode!="NA"} | {$row->employeeCode} {/if}
                                                                                {if $row->mobileNumber!="" && $row->mobileNumber!="NA"} | {$row->mobileNumber} {/if}
                                                                            </option>
                                                                        {/foreach}
                                                                    </select>
                                                                    <p class="lic-status-info" style="display:none;position: absolute;" id="dri-action" class="form-control"></p>
                                                                </div>
                                                                <div class="form-group">                                                           
                                                                    <input type="text" class="form-control" placeholder="Driver 1 Phone"  value="{if $data->driverMobile != 'NA'}{$data->driverMobile}{/if}" id="driver-phone" name="driver-phone" placeholder="Driver Phone">
                                                                </div>
                                                            </div>                                                        
                                                            <div class="col-lg-3">
                                                                <div class="form-group">
                                                                    <label for="driver-name" >Driver 2 Name & Mobile</label>
                                                                    <select id="driver2-name" class="form-control" onchange="getMobileNumber(this, '#driver2-phone', drivers);">
                                                                        <option value="">Select Driver</option>
                                                                        {foreach from=$drivers item=row}
                                                                            <option value="{$row->code}" data-name="{$row->name}" {if $row->name == $data->driverName2}selected{/if}>
                                                                                {$row->name|upper}
                                                                                {if $row->employeeCode!="" && $row->employeeCode!="NA"} | {$row->employeeCode} {/if}
                                                                                {if $row->mobileNumber!="" && $row->mobileNumber!="NA"} | {$row->mobileNumber} {/if}
                                                                            </option>
                                                                        {/foreach}
                                                                    </select>
                                                                    <p class="lic-status-info" id="dri-action" style="display:none;position: absolute;" class="form-control"></p>                          
                                                                </div>
                                                                <div class="form-group">                                                           
                                                                    <input type="text" class="form-control" placeholder="Driver 2 Phone"  value="{if $data->driverMobile2 != 'NA'}{$data->driverMobile2}{/if}" id="driver2-phone" name="driver2-phone" placeholder="Driver2 Phone">                                                             
                                                                </div>
                                                            </div>                                                        
                                                            <div class="col-lg-3">
                                                                <div class="form-group">
                                                                <label for="driver-name">Attender Name & Mobile</label>
                                                                <select id="attender-name" class="form-control" onchange="getMobileNumber(this, '#attender-phone', attenders);">
                                                                    <option value="">Select Attender</option>
                                                                    {foreach from=$attenders item=row}
                                                                        <option value="{$row->code}" data-name="{$row->name}" {if $data->attenderName == $row->name}selected{/if}>{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                                </div>
                                                                <div class="form-group">                                                           
                                                                    <input type="text" class="form-control" placeholder="Attender Phone"  value="{if $data->attenderMobile != 'NA'}{$data->attenderMobile}{/if}" id="attender-phone" name="attender-phone" placeholder="Attender Phone">
                                                                </div>
                                                            </div>

                                                                                                                       
                                                            <div class="col-sm-3">
                                                                <div class="form-group"> 
                                                                    <label for="remarks" class="req">Vehicle</label>                                                           
                                                                    <select class="form-control" id="vehicle-id" name="bus-list">
                                                                        <option value=""> Select a vehicle </option>
                                                                        {foreach name=o item=row key=k from=$ns_vehicle}
                                                                            <option value="{$row->code}" {if $vehicle_info->busVehicle->code == $row->code}selected{/if}>
                                                                                {$row->registationNumber}
                                                                                {if $row->bus->name != ""} ( {$row->bus->name} ) {/if}
                                                                            </option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                                <div class="form-group">                                                            
                                                                    <button class="btn btn-success" id="btn_save_remarks">Save</button>                                                            
                                                                    <button class="btn btn-default" id="btn-cancel-remarks">Clear</button>
                                                                    <div id="remarks_action"></div>
                                                                </div>    
                                                            </div>
                                                            <div class="col-sm-2 hidden">                                                           
                                                                <textarea class="form-control rs_no" placeholder="Remarks"  id='remarks' name="remarks" rows="2" cols="10">{$data->remarks}</textarea>
                                                            </div> 
                                                        </div><br/>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="view-info">
                                                <td>
                                                    <div class="well well-sm" >
                                                        <div class="row" style="position:relative; top:8px">                                                        
                                                            <div class="col-sm-2">                                                                    
                                                                <b>Driver Name : </b><span id="dr-name">{$data->driverName}</span>
                                                            </div>

                                                            <div class="col-sm-2">                                                           
                                                                <b>Driver Phone :</b> <span id="dr-mob">{$data->driverMobile}</span>
                                                            </div>                                                           
                                                            <div class="col-sm-5">           
                                                                <select class="form-control" id="vehicle-ids" name="bus-list" style="display:none">
                                                                    <option value=""> Select a vehicle </option>
                                                                    {foreach name=o item=row key=k from=$ns_vehicle} 
                                                                        <option value="{$row->code}" {if $vehicle_info->busVehicle->code == $row->code}selected{/if}>{$row->name} - {$row->bus->name} - {$row->registationNumber} {if $row->gpsDeviceCode != ''}- {$row->gpsDeviceCode}{/if} </option>
                                                                    {/foreach}
                                                                </select>    
                                                                <b> Vehicle : </b><span id="veh-info"></span>
                                                                </select>                                                            
                                                            </div>
                                                            <div class="col-sm-2 hidden">                                                           
                                                                <textarea class="form-control rs_no" placeholder="Remarks"  id='remarks' name="remarks" rows="2" cols="10">{$data->remarks}</textarea>
                                                            </div> 
                                                            <div class="col-sm-1 fr" style="position:relative;bottom:10px">                                                            
                                                                <button class="btn btn-success btn-small edit" id="btn_save_remarks">Edit</button>                                                            
                                                            </div> 
                                                            <div class="col-sm-2">                                                           
                                                                <div id="remarks_action"></div>
                                                            </div>                                                         
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>        
                                        {/if}
                                        
                                        <table class="table table-bordered noprint" width="100%">
                                            <tr class="info bold">
                                                <td rowspan="2" width="5%" align="center">Seat No</td>
                                                <td rowspan="2" width="10%" align="center">PNR </td>
                                                <td rowspan="2" width="10%" align="center">Date of booking</td>
                                                <td colspan="4" align="center">Passenger Details</td>
                                                <td rowspan="2" width="10%" align="center">From</td>
                                                <td rowspan="2" width="10%" align="center">To</td>
                                                <td rowspan="2" width="10%" align="center">Boarding Point</td>
                                                {if $action_rights['BRD-HIDE-BOOKED-BY']!=1}
                                                <td rowspan="2" width="10%" align="center">Booked by</td>
                                                {/if}
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
                                                                <td align="center" {if $bk->remarks !=""} rowspan="2" {/if} ><a href="javascript:;" onclick="getTicketHistory('{$bk->ticketCode}')">{$bk->ticketCode}</a></td>
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

                                                    {if $action_rights['TRC-USR-BOOK']>0}
                                                        <h5>User Booking List</h5>
                                                        {if $action_rights['tripChart.showSettlementFareOnly']!=1}
                                                        <p class="text-right text-danger">* Payable - Exclusive of commissions</p>
                                                        {/if}
                                                        <table class="table table-bordered">
                                                            <tr>
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
                                                </td>
                                                {if $action_rights['TRC-VIEW-BUS-MAP']>0 || $action_rights['TRP-VIEW-DROP-POINT']>0}
                                                    <td width="5%"></td>
                                                    <td width="45%">
                                                        {if $action_rights['TRC-VIEW-BUS-MAP']>0}
                                                            <h5>Bus Map</h5>
                                                            {if $xmaxl2 > 0 && $xminl2 > 0}
                                                                <table border="1px solid #ddd">
                                                                    <tr>
                                                                        <td>
                                                                            <table>
                                                                                <tr>
                                                                                    <td rowspan="7" width="25" align="center">U<br>P<br>P<br>E<br>R</td>
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
                                                                                                <td class="seat-lay-visibility-info empty_book" style="border:none !important;">
                                                                                                </td>
                                                                                            {/if}
                                                                                        {/for}
                                                                                    </tr>
                                                                                {/for}
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>{/if}
                                                                <br/>

                                                                <table width="" border="1px solid #ddd">
                                                                    <tr>
                                                                        <td> 
                                                                            <table>
                                                                                <tr>
                                                                                    <td rowspan="7" width="25" align="center">{if $xmaxl2 > 0 && $xminl2 > 0} <div class="seat-map-driver"></div><br>L<br>O<br>W<br>E<br>R{else} <div class="seat-map-driver-info"></div> {/if}</td>
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
                                                                                                <td class="seat-lay-visibility-info empty_book" style="border:none !important;">
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
                                                                        <td class="seat-lay-visibility-info empty_book float-right" style="border:1px dotted black !important;"> </td> <td>&nbsp;&nbsp;- Available Seats&nbsp; </td>&nbsp;                                                                                          
                                                                        <td class="seat-lay-visibility-info male_book float-right" style="border:2px solid black !important;"></td><td>&nbsp;&nbsp;- Booked by Male&nbsp; </td>&nbsp;
                                                                        <td class="seat-lay-visibility-info female_book float-right" style="border:double 3px black !important;"></td><td>&nbsp;&nbsp;- Booked by Female &nbsp;</td>
                                                                    </tr>
                                                                </table>
                                                                <br>{/if}
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
                                                        {/if}
                                                    </tr>
                                                </table>

                                                <div align='right' class="noprint">
                                                    <a href="javascript:;" onclick="export_trip_chart('{$tripCode}');" class='btn btn-default btn-sm pull-left action-button'><i class="fa fa-download fa-lg"></i>Excel</a>
                                                    {if $data->trip->tripStatus->code=="TPO" && $action_rights['ACT-TRIP']>0}
                                                        <a href="javascript:;" onclick="close_print_chart('{$tripCode}')" class='btn btn-success btn-sm action-button'>Close & Print</a>
                                                    {/if}
                                                    <a href="javascript:;" onclick="print_trip_chart('{$tripCode}');" class='btn btn-success btn-sm action-button'>Print</a>
                                                    <a href="javascript:;" onclick="print_trip_chart_medium('{$tripCode}');" class='btn btn-success btn-sm action-button'>Single Page Print</a>
                                                    <a href="javascript:;" onclick="mini_print_trip_chart('{$tripCode}');" class='btn btn-success btn-sm action-button'>Mini Print</a>
                                                    <a href="#tripchart/trip-chart?date={$smarty.request.date}" class='btn btn-default btn-sm'>Back</a>
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
        <form id="frm-export" name="frm-export" method="post"></form>                                
        <iframe name="ifrm-export" style="display: none" > </iframe>
        
        {literal}
            <script>
                var trip_code = "{/literal}{$tripCode}{literal}";
                var tc_date = "{/literal}{$smarty.request.date}{literal}";
                function _init_chart_page() {
                    init_chart_actions();
                }
                $('#btn-cancel-remarks').hide();
                $('#veh-info').html($("#vehicle-ids option:selected").text());
                if ($("#vehicle-ids").val() != '') {
                    $('#edit-info').hide();
                    $('#btn-cancel-remarks').show();
                } else {
                    $('#view-info').hide();
                }
                $('.edit').click(function () {
                    $('#edit-info').show();
                    $('#view-info').hide();
                });
                $('#btn-cancel-remarks').click(function () {
                    $('#edit-info').hide();
                    $('#view-info').show();
                });
            </script>
        {/literal}
        
        {if  $minutesForFirstBoarding < 380 && $action_rights['tripChart.optionalVehicleAllocation']!=1 && $vehicle_info->busVehicle->code =="" }
            {literal}
            <script>
                $(function(){
                    window.setTimeout(function() {
                        $('#info-update-warning').removeClass('hide');
                        $('.action-button').hide();
                        $('#chart_meta_container').slideDown( "slow" );
                    }, 2000);
                });

            </script>
            {/literal}
        {/if}
<script>
    var drivers = {$drivers|json_encode};
    var attenders = {$attenders|json_encode};
    var tdate = {$current_date|json_encode};
    
    $('#driver-name').select2();
    $('#driver2-name').select2();
    $('#attender-name').select2();
    $('#vehicles').select2({
        placeholder: "Select vehicle",
        escapeMarkup: function(markup) {
            return markup;
        }
    });
    
    function getMobileNumber(select, inputId, list = []) {
        $(select).next('.lic-status-info').html('');
        var dcode = $(select).val();
        if(dcode == ''){
            return;
        }
        var option = _.find(list, function (o) {
            return o.code === dcode;
        });
        
        var days = expiryDate(option.licenseExpiryDate);
        
        if(days == 0 || days < 0){
            $(select).next('.lic-status-info').addClass('text-danger').removeClass('text-warning');
            $(select).next('.lic-status-info').html('Licence Expired');
        }else if(days <= 15){
            $(select).next('.lic-status-info').addClass('text-warning').removeClass('text-danger');
            $(select).next('.lic-status-info').html('Licence will be Expired in '+days+' days');
        }
            
        $(select).next('.lic-status-info').show();
        $(inputId).val(option.mobile || option.mobileNumber);
    }
    
    function expiryDate(date_string) {
        var expiration = moment(date_string).format("YYYY-MM-DD");
        var current_date = moment(tdate).format("YYYY-MM-DD");
        var days = moment(expiration).diff(current_date, 'days');
        return days;
    }
</script>