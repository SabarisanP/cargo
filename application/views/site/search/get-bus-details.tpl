<div class="col-md-6">
         {if count($busdetails) > 0}
            <div class="scroller box_content" data-height="650px" data-always-visible="1" data-rail-visible="1">
                <ul class="list-unstyled user_list trip-list">
                        {foreach from=$busdetails item=bs}
                            
                           <li class="clearfix ticket-row" data-stagecode='{$bs->tripStageCode}' data-tripcode='{$bs->tripCode}'>
                                <div class="pull-left">
                                    <h5><span class="bold">{if $bs->bus->displayName!=''}{$bs->bus->displayName} {else if $bs->bus->name!=''} {$bs->bus->name} {/if} </span><i class="fa fa-info-circle has-popover" data-content="Content goes here" data-toggle="popover" data-original-title="Cancellation Terms"></i></h5>
                                    <p>
                                        {assign var=ct value="|"|explode:$bs->bus->categoryCode}
                                        {if $categoryList['Layout'][$ct.0]!='' && $categoryList['ClimateControl'][$ct.1] && $categoryList['Chasis'][$ct.2] && $categoryList['Make'][$ct.3] && $categoryList['Seattype'][$ct.4]}
                                                                          {$categoryList['Layout'][$ct.0]} {$categoryList['Seattype'][$ct.4]}  {$categoryList['ClimateControl'][$ct.1]} {$categoryList['Make'][$ct.3]}   {$categoryList['Chasis'][$ct.2]}
                                        {/if}
                                    </p>
                                    <p> <span class="has-popover"  data-toggle="popover" data-original-title="Pickup Points" data-tripcode='{$bs->tripCode}' data-station="{$bs->fromStation->code}"><i class="fa fa-level-up" ></i> <strong>{$bs->fromStation->dateTime|date_format:'%I:%M %p'}</strong></span> &nbsp; 
                                        <span class="has-popover"  data-toggle="popover" data-original-title="Dropping Points"  data-tripcode='{$bs->tripCode}' data-station="{$bs->toStation->code}"><i class="fa fa-level-down " ></i> <strong>{$bs->toStation->dateTime|date_format:'%I:%M %p'}</strong></span> &nbsp;
                                    </p>
                                </div>
                                <div class="text-right pull-right">

                                    <p>
                                        {assign var="farev" value=""}
                     
                                        {foreach from=$bs->stageFare item=fre} 
                                            {if $farev!=''}  {$farev="`$farev`,`,`"} {/if}
                                            {$farev="<i class='fa  fa-rupee'></i> `$fre->fare`"}
                                        {/foreach}
                                         {$farev}
                                        <span title="Fare" class="fare"></span> &nbsp;                                                                                
                                    </p>
                                    {*<p><span title="Commission" class="commision"><i class="fa fa-money"></i> 5%</span></p>*}
                                    <p><span class="label label-success"><i class="fa fa-check"></i> {$bs->bus->totalSeatCount} seats</span></p>

                                </div>
                                <div class="clearfix"></div>                                                                       
                          </li>
                       {/foreach}    
                </ul>
                </div>
                {else}
                     <div class="well well-large"> Sorry! No bus available.</div>
                {/if}
   
</div>
<div class="col-md-6" id="book-panel" >    
        <div class="box_content booking-pre-info" align="center">
                    <div class="text-danger"> Please select a bus to book tickets.</div>                                                            
        </div>
</div>
<script>
    var bus_trip = {$busdetails|json_encode}
</script>