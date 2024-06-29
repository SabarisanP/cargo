<h5>
    <div align="center" class="bl_trip">Trip List for {$smarty.request.tripDate|date_format:$ns_date_format}</div>
</h5>

{if $trips|count==0} 
    <div class="well well-large"> Sorry! No trips were found the requested date.</div>
{else}  
<table class="table info_table" id="mail_inbox">
    <tr>
        <th style="border-top:none">Name</th>
        <th style="border-top:none">Schedule / Trip Code</th>
        <th style="border-top:none">From Station</th>        
        <th style="border-top:none">To Station</th>
        <th style="border-top:none">Fare</th>
        <th style="border-top:none">Seats</th>
        <th style="border-top:none">Booked</th>
        <th style="border-top:none">Vacant</th>
        <th style="border-top:none">Occupancy</th>
        <th style="border-top:none">Action</th>
    </tr>
    {assign var="tot_seats" value=0}
    {assign var="tot_booked" value=0}
    {assign var="tot_vacant" value=0}
    
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
            <tr>
                <td  class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" data-stages="{count($row->stageList)}">
                    <span class="bold">{$row->schedule->name} </span>
                    <br>
                    {$row->busTypeName}                        
                </td>
                <td  class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" data-stages="{count($row->stageList)}">
                    <span class="txt_green">{$row->schedule->code}  <br>{$row->tripCode} </span>
                                           
                </td>
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}" >
                    <span class='txt_green'>
                        <i class="fa fa-level-up"></i>
                    </span>&nbsp;{$row->stageList[0]->fromStation->name}&nbsp;
                    <br>
                    <span class="text-muted">{$row->stageList[0]->fromStation->dateTime|date_format:'%I:%M %p'}</span>
                </td>                
                <td class="{if $smarty.foreach.inssch.index==0} noborder {/if}">
                    <span class='txt_green'>
                        <i class="fa fa-level-down"></i>
                    </span>&nbsp;{$row->stageList[0]->toStation->name}&nbsp;
                    <br>
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
                    <a class='btn btn-primary btn-xs' href="#tripchart/trip-chart-list?t={$str|md5}&tc={$row->tripCode}&date={$smarty.request.tripDate}" title="View Chart">View Chart</a>
                                        
                   {* {if $row->tripStatus->code !='TPY' || $row->tripStatus->code !=''}   
                        {if $action_rights['ACT-TRIP']>0}<input type="checkbox" id="act_sch"        {if $action_rights['ACT-TRIP']!=1} disabled="disabled" {/if} data-code="{$row->tripCode}" data-state="{$row->tripStatus->code}"  name="act_sch" class="bs_switch" data-size="small" {if $row->tripStatus->code == 'TPO'}checked='checked'{/if}>
                   {/if} {else}
                        Not Yet Opened
                    {/if} *}
                </td>
            </tr>
    {/foreach}    
    
    

        <input type="hidden" value="{$row->tripCode}" id="trips">
        {assign var="tot_seats" value=$tot_seats+$row->bus->totalSeatCount}
        {assign var="tot_booked" value=$tot_booked+$row->bookedSeatCount}
        {assign var="tot_vacant" value=$tot_vacant+($row->bus->totalSeatCount-$row->bookedSeatCount)}
    {/foreach} 
    </tbody>

</table>   
<script>
    $('.bs_switch').on('switchChange.bootstrapSwitch', function(e, data) {
        var $el = $(data.el), value = data.value; 
          if($(this).attr('id')=='act_sch') { //   trip status update    
             var state = 'TPC';
             if (value) {
                var state = 'TPO';
             } 
             code = $(this).attr('data-code');
             tripStatusUpdate(code, state);
         }
     });
    $('.bs_switch').bootstrapSwitch('size', 'mini');
    $('.bs_switch').bootstrapSwitch('onText', 'Open');
    $('.bs_switch').bootstrapSwitch('offText', 'Closed');
</script>        
{/if}