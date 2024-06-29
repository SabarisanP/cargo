<div id="bus2" style="margin-top:20px;">
   <div class="col-md-6 p_l_n">
      <div class="scroller box_content" data-height="650px" data-always-visible="1" data-rail-visible="1">         
         <div class="clear_fix_both"></div>
         <ul class="list-unstyled trip-list">
            {foreach item=rows from=$busdetails}
				{assign var="category" value=$rows.category}
				{foreach item=rows1 from=$rows.details}					
					<li class="clearfix ticket-row" data-trip-stage="{$rows1->tripStageCode}" data-trip="{$rows1->tripCode}" data-tab="2">					   
					   <div class="col-xs-9 p_l_n">
						  <h5 class="pull-left"><span class="bold busName">{$rows1->bus->displayName}</span>&nbsp;</h5>
						  <i class="fa fa-list has-cancel-popover pull-left m-t-5" title="" data-toggle="tooltip" data-stagecode="{$rows1->tripStageCode}" data-tap="2" onclick="dialogTerms(this)" data-original-title="Cancel Policy"></i>
						  <span class="pull-left trip-status p_l_15">{$rows1->bus->tripStatus}</span>
						  <div class="clear_fix_both"></div>
						  <p class="busCategory col-xs-7 p_l_n">{$category}</p>
						  <p class="col-xs-5">
							 <span data-original-title="Pickup Points" data-toggle="popover" class="has-popover pp" data-station="{$rows1->fromStation->code}" data-tripcode="{$rows1->tripCode}" data-tap="2"><i class="fa fa-level-up"></i> <span class="bold ftime">{$rows1->fromStation->dateTime|date_format:"%H:%#M %p"}</span></span> &nbsp; 
							 <span data-original-title="Dropping Points" data-toggle="popover" class="has-popover dp" data-station="{$rows1->toStation->code}" data-tripcode="{$rows1->tripCode}" data-tap="2" data-tip="1"><i class="fa fa-level-down"></i> <span class="bold ttime">{$rows1->toStation->dateTime|date_format:"%H:%#M %p"}</span></span> &nbsp;
						  </p>
					   </div>
					   <div class="text-right pull-right">
						  <p>
							 <span title="Fare" class="fare"><i class="fa  fa-rupee"></i>&nbsp;{$rows1->stageFare[0]->fare}</span> &nbsp;                                                                                
						  </p>
						  <p class="lead"><span class="label label-success"><i class="fa fa-check"></i> <span class="seat-count">{$rows1->stageFare[0]->availableSeatCount}</span> seats</span></p>
					   </div>
					   <div class="clearfix"></div>
					</li>
				{/foreach}
			{/foreach}			
			
         </ul>
      </div>
   </div>
   <div id="busmap-2" class="col-md-6 box_content min_h_300">
      <div id="Def_txt">
         <div class="well well-large">Please select bus to know more details.</div>
      </div>
   </div>
</div>
<div class="cancel-terms" id="cancel-terms-dialog2"></div>

<script id="template-busmap-list" type="text/template">
    <div class="pull-right"> 
<a id="refresh" title="Refresh" data-toggle="tooltip" href="javascript:;">
    <i class="fa fa-repeat f17"></i>
</a>
<a id="close"  title="Clear" data-toggle="tooltip" href="javascript:;"><i class="fa fa-times f17"></i></a>
</div>
    <div class="busmap-list">
          
        <div align="center" class="busmap col-xs-12"> 
        <div class="seat-map-over col-xs-12">
            <div class="seat-map-over-all">
                <div class="col-xs-1 seat-map-driver-head">
                    <div class="seat-map-driver">&nbsp;
                    </div>
                    <div class="seat-map-selayer hide">
                        <p class="vertical-text">Lower</p>
                    </div>
                </div>
                <div class="col-xs-12 lower" style="width:auto;height: auto;">
 
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </div> 
        <div class="clear_fix_both"></div><br />
        <div class="seat-map-over upper-layer col-md-12 hide">
            <div class="seat-map-over-all">
                <div class="col-xs-1">
                    <div class="seat-map-upper">
                    </div>
                    <p class="vertical-text">Upper</p>
                </div>
                <div class="col-xs-12 upper" style="width:auto;height: auto;">
    
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </div>
       
        </div><!--
        <div class="col-xs-4">
                
            <div class="seat-available-gents seat-lay-details mrg-3 .AM">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AM">Available Male</div>
                <div class="clear_fix_both .AM"></div>
            <div class="seat-available-ladies seat-lay-details mrg-3 .AF">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AF">Available Ladies</div>
                <div class="clear_fix_both .AF"></div>
            <div class="seat-available-all seat-lay-details mrg-3 .AL">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AL">Allocated for all</div>
                <div class="clear_fix_both .AL"></div>
            <div class="seat-available-you seat-lay-details mrg-3 .AY">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AY">Allocated for You</div>
                <div class="clear_fix_both .AY"></div>
            <div class="seat-available-other seat-lay-details mrg-3 .AO">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AO">Allocated for Other</div>
                <div class="clear_fix_both .AO"></div>
            <div class="seat-booked-gents seat-lay-details mrg-3 .BM">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .BM">Booked for Male</div>
                <div class="clear_fix_both .BM"></div>
            <div class="seat-booked-ladies seat-lay-details mrg-3 .BF">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .BF">Booked for ladies</div>
                <div class="clear_fix_both .BF"></div>
            <div class="seat-booked-blocked seat-lay-details mrg-3 .TBL .BL">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .TBL .BL">Blocked Seat</div>
                <div class="clear_fix_both .TBL .BL"></div>
            <div class="seat-now-select seat-lay-details mrg-3">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf">Selected Seat</div>
                <div class="clear_fix_both"></div>
        
       </div>-->
      <div class="clear_fix_both"></div><br />

      <div id="bus-result-list-action" class="tempform"><div class="well well-large" align="center">Please select a seat to get more options.</div></div>
    
</div>
        
</script> 
