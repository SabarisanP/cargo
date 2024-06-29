<h5>
    <div align="center" class="bl_trip">Boarding Point Trip List for {$smarty.request.tripDate|date_format:$ns_date_format}</div>
</h5>

{if $trips|count==0} 
    <div class="well well-large"> Sorry! No trips were found the requested date.</div>
{else}  
<table class="table info_table remove-bottom" id="trip-list-table">
    <thead>
        <tr>
            <th style="border-top:none">Name</th>
            <th style="border-top:none">Vehicle</th>
            <th style="border-top:none">Schedule / Trip Code</th>            
            <th style="border-top:none">Route</th>   
            <th style="border-top:none">Fare</th>
            <th style="border-top:none">Seats</th>
            <th style="border-top:none">Booked</th>
            <th style="border-top:none">Vacant</th>
            {if $action_rights['SCH-FARE-OVERRIDE']==1}
            <th style="border-top:none">Revenue</th>
            {/if}
            <th style="border-top:none">Occupancy</th>
            <th style="border-top:none">Action</th>
        </tr>
    </thead>
    <tbody>
    {assign var="tot_seats" value=0}
    {assign var="tot_booked" value=0}
    {assign var="tot_vacant" value=0}
    {assign var="tot_revenue" value=0}
    
    {foreach from=$trips item=tcate key=tcatekey }
        {if $tcatekey!=""}
        <tr class="noborder">
            <td colspan="11" class="noborder">
                <div class="schedule-tag">
                    <h5 class="txt_orange">{$tcatekey}</h5>
                </div>
            </td> 
        </tr>   
        {/if}
       
    
        {foreach from=$tcate item=row key=new name=inssch}
            {assign var="stages_count" value=count($row->stageList)-1}
            <tr id="trip-row-{$row->tripCode}">

                <td  class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" data-stages="{count($row->stageList)}">
                    <span class="bold">{$row->schedule->name} </span>
                    <br>
                    {$row->busTypeName}
                </td>
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}">
                   {if $row->tripInfo->busVehicle->registationNumber !=''}
                       {$row->tripInfo->busVehicle->registationNumber}
                       <br>
                       <span class="text-muted">
                           {$row->tripInfo->driverMobile}
                           {if $row->tripInfo->driverName!=''}
                               , {$row->tripInfo->driverName}
                           {/if}
                           {if $row->tripInfo->driverName2 != 'NA' ||  $row->tripInfo->attenderName != 'NA'}
                               &nbsp;<i class="fa fa-info-circle driver-popover" data-content="<div class='text-dark'>
                                {if $row->tripInfo->driverName2 != 'NA'}<b>Driver2 :</b> {$row->tripInfo->driverName2}, {$row->tripInfo->driverMobile2}{/if}
                                {if $row->tripInfo->attenderName != 'NA'}<br><b>Attender :</b> {$row->tripInfo->attenderName}, {$row->tripInfo->attenderMobile}{/if}     
                                </div>"></i>
                           {/if}
                       </span>
                   {else}
                       -
                   {/if}
                </td>
                <td  class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" data-stages="{count($row->stageList)}">
                    <span class='txt_green'>
                        {if $is_super_namespace==0 } {$row->schedule->code}  <br> {/if} {$row->tripCode}
                    </span>  
                    {if $row->schedule->serviceNumber!=''}
                        <br>
                        <span class="warning-text">{$row->schedule->serviceNumber}</span>
                    {else}
                        <br>
                        <span title="service number not available">-</span>
                    {/if}                   
                </td>                
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}" >
                    {$row->stageList[0]->fromStation->name} to {$row->stageList[0]->toStation->name}                    
                    <br>
                    <span class='txt_green'>
                        <i class="fa fa-level-up"></i>
                    </span>
                    <span class="text-muted">{$row->stageList[0]->fromStation->dateTime|date_format:'%I:%M %p'}</span> 
                    &nbsp;
                    <span class='txt_green'>
                        <i class="fa fa-level-down"></i>
                    </span>&nbsp;
                    <span class="text-muted">{$row->stageList[0]->toStation->dateTime|date_format:'%I:%M %p'}
                    {if $row->stageList[0]->fromStation->dateTime|date_format:'%d' != $row->stageList[0]->toStation->dateTime|date_format:'%d'}
                        Next Day
                    {/if}
                    </span>
                </td>                
                
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}">

                    {foreach from=$row->stageList key=key item=stp}
                        {foreach from=$stp->stageFare item=stf key=iter}
                            {if $key==0 }
                                {assign var="fare" value=$stf->fare} 
                            {else}    
                            {assign var="fare" value=$fare|cat:','|cat:$stf->fare}                               
                            {/if}
                        {/foreach}
                    {/foreach}
                     {if $stf->fare>0}
                        {assign var="fares" value=","|explode:$fare}  
                        <span class='txt_green'>
                            <i class="fa fa-rupee"></i>
                        </span>&nbsp;{$fares[0]}
                     {/if}<br />
                </td>
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}">{$row->bus->totalSeatCount}</td>
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}">{$row->bookedSeatCount}</td>
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}">{$row->bus->totalSeatCount-$row->bookedSeatCount}</td>
                
                {if $action_rights['SCH-FARE-OVERRIDE']==1}
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}">   
                    {if $row->totalBookedAmount>0} 
                    <i class="txt_green fa fa-rupee"></i> 
                    <span class="dotted-underline" title="{($row->totalBookedAmount/$row->bus->totalSeatCount)|ceil} per seat">
                        {$row->totalBookedAmount} 
                    </span>
                    {else} 
                        -
                    {/if}
                </td> 
                {/if}
                
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}">
                    {if $row->bookedSeatCount>0}
                    {assign var="t" value=$row->bookedSeatCount/$row->bus->totalSeatCount}
                    {assign var="t" value=$t*100}
                    {else}
                      {assign var="t" value=0}  
                    {/if}
                    {assign var="vacant" value={$row->bus->totalSeatCount-$row->bookedSeatCount}}
                    <div class="trip-pie" id="trip-pie-{$row->tripCode}" data-percent="{$t}" data-seats="{$row->bus->totalSeatCount}" data-booked="{$row->bookedSeatCount}" data-vacant="{$vacant}" style="height:50px;width:50px" ></div>
                </td>                
                <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" data-stages="{count($row->stageList)}">
                    <span id="btn-state-{$row->tripCode}" >
                    {if $row->tripStatus->code =='TPY'}                                   
                        <label class="badge badge-default">Not Yet Opened</label>
                    {else if $row->tripStatus->code == 'TPO'}
                        <label class="badge badge-success">Booking Open</label>
                    {else if $row->tripStatus->code == 'TPC'}
                        <label class="badge badge-danger">Booking Closed</label>
                    {else if $row->tripStatus->code == 'TCA'}                                    
                        <label class="badge badge-warning">Trip Cancelled</label>
                    {/if} 
                    </span>

                    &nbsp;&nbsp;&nbsp;

                    {assign var=str value=10|mt_rand:2000}
                    <a class='btn btn-primary btn-xs' href="#boardingtripchart/boarding-trip-chart-list?t={$str|md5}&tc={$row->tripCode}&date={$smarty.request.tripDate}" title="View Chart">View Chart</a>
                    <a id="{$row->tripCode}" title="More Options" class="btn btn-default btn-xs" onclick="viewmore('{$row->tripCode}')">
                        <i class="fa fa-arrow-down"></i>
                    </a>
                </td>
            </tr>

            <input type="hidden" value="{$row->tripCode}" id="trips">
            {assign var="tot_seats" value=$tot_seats+$row->bus->totalSeatCount}
            {assign var="tot_booked" value=$tot_booked+$row->bookedSeatCount}
            {assign var="tot_vacant" value=$tot_vacant+($row->bus->totalSeatCount-$row->bookedSeatCount)}
            {assign var="tot_revenue" value=$tot_revenue+$row->totalBookedAmount}
        {/foreach} 
    {/foreach} 
    </tbody>
    {if $tcatekey|count}
        <tfoot>
            <tr class="bold text-danger">
                <td colspan="5"></td>
                <td class="v-a-c">{$tot_seats}</td>
                <td class="v-a-c">{$tot_booked}</td>
                <td class="v-a-c">{$tot_vacant}</td>
                {if $action_rights['SCH-FARE-OVERRIDE']==1}
                <td class="v-a-c">
                    {if $tot_revenue > 0}
                        <i class="txt_green fa fa-rupee"></i>
                        {$tot_revenue}
                    {else}
                        -
                    {/if}
                </td>
                {/if}
                <td class="v-a-c">
                    {if $tot_booked > 0}
                        {assign var="t" value=($tot_booked/$tot_seats) * 100}
                    {else}
                        {assign var="t" value=0}
                    {/if}
                    {assign var="vacant" value=$tot_seats-$tot_vacant}
                    <div class="trip-pie" id="tot-pie" data-percent="{$t}" data-seats="{$tot_seats}" data-booked="{$tot_booked}" data-vacant="{$tot_vacant}" style="height:50px;width:50px" ></div>
                </td>
                <td colspan="1"></td>
            </tr>
        </tfoot>
    {/if}
</table>
<div class="hide" id="trip-chart-more-container">
    <div class="pull-right">
        <a href="javascript:;" title="Close options" id="close" class="btn-lg" onclick="closemore()">
            <i class="fa fa-times-circle"></i>
        </a>
    </div>
    <div id="trip-chart-content"></div>
</div>
<script>
    $('.driver-popover').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    $('.bs_switch').on('switchChange.bootstrapSwitch', function(e, data) {
        var $el = $(data.el), value = data.value; 
          if($(this).attr('id')=='act_sch') { //   trip status update    
             var state = 'TPC';
             if (value) {
                var state = 'TPO';
             } 
             code = $(this).attr('data-code');
             boarding_tripStatusUpdate(code, state);
         }
     });
    $('.bs_switch').bootstrapSwitch('size', 'mini');
    $('.bs_switch').bootstrapSwitch('onText', 'Open');
    $('.bs_switch').bootstrapSwitch('offText', 'Closed');
    
    function viewmore(tripCode) {
        $('#trip-list-table tbody tr').not('#trip-row-'+tripCode).addClass("hide");
        $('.last-active').removeClass('last-active border-bottom-dash');
        $('#trip-row-'+tripCode).addClass('last-active border-bottom-dash');
        $('#trip-chart-more-container').removeClass('hide');
        var data = {};
        data.tc = tripCode;
        data.more = 1;
        $('#trip-chart-content').html(loading_popup);
        $.ajax({
            type: "GET",
            dataType: 'html',
            url: base_url + "boardingtripchart/boarding-trip-chart-list",
            data: data,
            success: function (res) {
                $('#trip-chart-content').html(res);
            }
        });
    }
    
    function closemore() {
        $('#trip-chart-more-container').addClass('hide');
        $('#trip-list-table tbody tr').removeClass("hide");
        var lastactive = '#'+$('.last-active').attr('id');
        $('html, body').animate({
            scrollTop: $(lastactive).offset().top-120
        }, 1500);
    }
</script>        
{/if}