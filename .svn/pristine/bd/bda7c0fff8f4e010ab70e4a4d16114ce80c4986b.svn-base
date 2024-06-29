<table class="table remove-border-top" width="100%">
    <tr>
        <td width="25%" class="valign-top" >
            <h5>Occupancy Details</h5>
            {if $xmaxl2 > 0 && $xminl2 > 0}
                <div align="center" class="busmap">
                    <div class="seat-map-over upper-layer col-md-12">
                        <div class="seat-map-over-all">
                            <div class="col-xs-1  seat-map-driver-head">
                                <div class="seat-map-upper"> </div>
                                <p class="vertical-text">Upper</p>
                            </div>
                            <div class="col-xs-11 upper" style="width:auto;height: auto;">
                                {for $r=1 to $name['2']|@array_keys|@max}
                                    {for $c=1 to $name['2'][$r]|@array_keys|@max}
                                        {if $name['2'][$r][$c] != ''}
                                            {assign var="gen_class" value="available-for-all"}
                                            {assign var="seat_class" value=""}

                                            {if $bookedGender[$name['2'][$r][$c]] == 'F'}
                                                {assign var="gen_class" value="seat-booked-ladies"}
                                            {/if}  

                                            {if $bookedGender[$name['2'][$r][$c]] == 'M'}
                                                {assign var="gen_class" value="seat-booked-gents"}
                                            {/if}  

                                            {if $seatcode['2'][$r][$c] == 'LSL' || $seatcode['2'][$r][$c] == 'USL' || $seatcode['2'][$r][$c] == 'SL' || $seatcode['2'][$r][$c] == 'SLSL' || $seatcode['2'][$r][$c] == 'SUSL'}
                                                {assign var="seat_class" value="sleeper-lay-search"}
                                            {/if}

                                            {if $seatcode['2'][$r][$c] == 'ST' || $seatcode['2'][$r][$c] == 'SS' || $seatcode['2'][$r][$c] == 'PB'}
                                                {assign var="seat_class" value="seat-lay-search"}
                                            {/if}

                                            {if $name['2'][$r][$c]|in_array:$quotaSeatsList}
                                                {assign var="gen_class" value="seat-quota-blocked"}
                                            {/if}

                                            {if $seatcode['2'][$r][$c] != 'RRM' && $seatcode['2'][$r][$c] != 'FRS'}
                                                <div class="seat-lay-out seat-select-visibility {$gen_class} {$seat_class}">
                                                {$name['2'][$r][$c]}
                                                </div>
                                            {else}
                                               <div class="seat-lay-out restroom-sleeper-filer">x</div>
                                            {/if} 
                                        {else}
                                            {assign var="seat_class" value=""}
                                            {if $seatcode['2'][$r]|@max == 'USL' || $seatcode['2'][$r]|@max == 'LSL' || $seatcode['2'][$r]|@max == 'SL'}
                                                {assign var="seat_class" value="sleeper-lay-search"}
                                            {else}
                                                {assign var="seat_class" value="seat-lay-search"}
                                            {/if}
                                            <div class="seat-lay-out {$seat_class}">&nbsp;</div>
                                        {/if}
                                        {forelse}
                                        <div class="seat-lay-out seat-lay-search">&nbsp;</div>
                                    {/for}
                                    <div class="clear_fix_both"></div>
                                {/for}
                            </div>
                        </div>
                        <div class="clear_fix_both"></div>
                    </div>
                    <div class="clear_fix_both"></div>
                {/if}
                <div class="seat-map-over col-xs-12">
                    <div class="seat-map-over-all">
                        <div class="col-xs-1 seat-map-driver-head">
                            <div class="seat-map-driver">&nbsp; </div>
                            <div class="seat-map-selayer">
                                <p class="vertical-text">Lower</p>
                            </div>
                        </div>
                        <div class="col-xs-12 lower" style="width:auto;height: auto;">
                            {for $r=1 to $name['1']|@array_keys|@max}
                                {for $c=1 to $name['1'][$r]|@array_keys|@max}
                                    {if $name['1'][$r][$c] != ''}
                                        {assign var="gen_class" value="available-for-all"}

                                        {if $bookedGender[$name['1'][$r][$c]] == 'F'}
                                            {assign var="gen_class" value="seat-booked-ladies"}
                                        {/if}  

                                        {if $bookedGender[$name['1'][$r][$c]] == 'M'}
                                            {assign var="gen_class" value="seat-booked-gents"}
                                        {/if}  

                                        {if $seatcode['1'][$r][$c] == 'LSL' || $seatcode['1'][$r][$c] == 'USL' || $seatcode['1'][$r][$c] == 'SL' || $seatcode['1'][$r][$c] == 'SLSL' || $seatcode['1'][$r][$c] == 'SUSL'}
                                            {assign var="seat_class" value="sleeper-lay-search"}
                                        {/if}

                                        {if $seatcode['1'][$r][$c] == 'ST' || $seatcode['1'][$r][$c] == 'SS' || $seatcode['1'][$r][$c] == 'PB'}
                                            {assign var="seat_class" value="seat-lay-search"}
                                        {/if}

                                        {if $name['1'][$r][$c]|in_array:$quotaSeatsList}
                                            {assign var="gen_class" value="seat-quota-blocked"}
                                        {/if}

                                        {if $seatcode['1'][$r][$c] != 'RRM' && $seatcode['1'][$r][$c] != 'FRS'}
                                            <div class="seat-lay-out seat-select-visibility {$gen_class} {$seat_class}">
                                                {$name['1'][$r][$c]}
                                            </div>
                                        {else}
                                            <div class="seat-lay-out restroom-sleeper-filer">x</div>
                                        {/if}
                                    {else}
                                        {assign var="seat_class" value=""}
                                        {if $seatcode['1'][$r]|@max == 'USL' || $seatcode['1'][$r]|@max == 'LSL' || $seatcode['1'][$r]|@max == 'SL'}
                                            {assign var="seat_class" value="sleeper-lay-search"}
                                        {else}
                                            {assign var="seat_class" value="seat-lay-search"}
                                        {/if}
                                        <div class="seat-lay-out {$seat_class}">&nbsp;</div>
                                    {/if}
                                    {forelse}
                                    <div class="seat-lay-out seat-lay-search">&nbsp;</div>
                                {/for}
                                <div class="clear_fix_both"></div>
                            {/for}
                        </div>
                    </div>
                    <div class="clear_fix_both"></div>
                </div>
            </div>
            <br/>
            <br>
            <div class="clear_fix_both"></div>
            {if $action_rights['TRP-SHOW-TRL-STATUS']>0}
            <table width="100%">
                <tr class="valign-top">
                    <td width="100%">
                        <div class="row">
                            {assign var="travelStatusCode" value=[]}
                            {foreach item=row from=$data->ticketDetailsList}
                                {$travelStatusCode[$row->travelStatusCode] = $travelStatusCode[$row->travelStatusCode]+1}
                            {/foreach}
                            {foreach item=val key=k from=$travelStatusCode}
                                <div class="col-md-3 bold">{$travel_status[$k]} - {$val}</div>
                            {/foreach}
                        </div>
                    </td>
                </tr>
            </table>
            {/if}            
            <table width="100%">
                <tr class="valign-top">
                    <td width="100%">
                        <h5>Route Details</h5>
                        <table class="table table-bordered">
                            <tr>
                                <th class="bold" align="left" nowrap>Route</th>
                                <th align="center">Seats</th>
                            </tr>
                            {foreach item=row key=k from=$route_seat_count}
                                <tr>
                                    <td align="left" nowrap>{$k}</td>
                                    <td align="center">{$row}</td>
                                </tr>
                            {/foreach}
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td width="35%" class="valign-top">
            <h5>Boarding Details</h5>    
            <table class="table table-bordered">
                <tr>
                    <td class="bold" nowrap>Station</td>
                    <td class="bold" >Station Point</td>
                    <td class="bold" >Seats</td>
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

            {if $action_rights['TRP-VIEW-USR-BOOK']>0}
                <h5>User Booking List</h5>                
                <table class="table table-bordered">
                    <tr>
                        <td class="bold" nowrap="nowrap">Booked By</td>
                        <td class="bold">Seats</td>
                        <td class="bold" nowrap="nowrap">Seat Count <br>
                            BO | PBL | CA
                        </td>
                        {if $action_rights['tripChart.showSettlementFareOnly']==1}
                            <td class="bold" nowrap="nowrap">Fare</td>
                        {else}
                            <td class="bold" nowrap="nowrap">Fare</td>
                            <td class="bold" nowrap="nowrap">GST</td>
                            <td class="bold" nowrap="nowrap">Commi</td>
                            <td class="bold" nowrap="nowrap">C.Charges</td>
                            <td class="bold" nowrap="nowrap">Payable</td>  
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
                            <td nowrap="nowrap">{$bookeduser}</td>                                            
                            <td>{$entity['bo_seats_names']}</td>
                            <td nowrap='nowrap' >
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
                        <td colspan="2" align="right" class="bold">Total</td>
                        <td nowrap='nowrap' class="bold">
                            {$tot_bo_seats|number_format:0} |
                            {$tot_pbl_seats|number_format:0} |
                            {$tot_ca_seats|number_format:0}
                        </td>
                        {if $action_rights['tripChart.showSettlementFareOnly']==1}
                        <td align="right" class="bold">{$tot_bo_fare|number_format:2}</td>
                        {else}
                        <td align="right" class="bold">{$tot_bo_fare|number_format:2}</td>
                        <td align="right" class="bold">{$tot_bo_gst|number_format:2}</td>
                        <td align="right" class="bold">{$tot_bo_comission|number_format:2}</td>
                        <td align="right" class="bold">{$tot_ca_charges|number_format:2}</td>
                        <td align="right" class="bold">{$tot_payable|number_format:2}</td>
                        {/if}
                    </tr>
                </table>
                {if $action_rights['tripChart.showSettlementFareOnly']!=1}
                    <p class="text-left text-danger col-md-6">* Payable - Exclusive of commissions</p>
                {else}
                    <p class="col-md-6">&nbsp;</p>
                {/if}
                <p class="text-right text-danger col-md-6">BO : Confirm Booked, PBL : Phonebook, CA : Cancelled</p>
            {/if}

            {if $quotaSeats|count > 0}
                <br/><br/>
                <h5>Quota Details </h5>
                <table class="table table-bordered">
                    <tr>
                        <th class="bold" >Quota to</th>
                        <th class="bold" >Seats</th>
                        <th class="bold" >Seat Count</th>
                    </tr>
                    <tr>
                        {assign var="quotaUser" value=[]}
                        {foreach item=row from=$quotaSeats}
                            {$quotaUser[$row->user->name][] = $row}
                        {/foreach}

                        {foreach item=row key=key from=$quotaUser}
                            <td align="left">{$key}</td>
                            <td align="left">
                            {foreach item=st from=$row name=st}
                                {$st->quotaSeat->seatName}
                                {if !$smarty.foreach.st.last},{/if}
                            {/foreach}
                            </td>
                            <td align="left">{$row|count}</td>
                        {/foreach}
                    </tr>
                    <tr>
                        <th class="bold text-right" colspan="2">Total</th>
                        <th class="bold" >{$quotaSeatsList|count}</th>
                    </tr>
                </table>
            {/if} 
        </td>
    </tr>
</table>