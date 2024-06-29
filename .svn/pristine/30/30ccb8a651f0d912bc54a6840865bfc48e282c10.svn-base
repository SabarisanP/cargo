<br><br><table class="table table-design tab-wid-80" id='booking-schedules-list'>
    <tr>
        <th>Open From</th>
        <th>Close To</th>
        <th>Group</th>
        <th>Stage</th>
        <th>Booking</th>
        <th></th>
    </tr>
    {foreach item=bkg from=$booking}
        <tr class="sch-bk-{$bkg->code}">
            <td>{$bkg->openTime}</td>
            <td>{$bkg->CloseTime}</td>
            <td>{if $bkg->group->name!=""}{$bkg->group->name}{else} All Group{/if}</td>
            <td>
             {if $bkg->fromStation->name!=""}{$bkg->fromStation->name} - {$bkg->toStation->name}{else} All Stage{/if}   
            </td>
            <td>{if $bkg->allowBookingFlag=="1"}Open{else}Close{/if}</td>
            <td>
            </td>
        </tr>

        {if count($bkg->overrideList) > 0}
            <tr class="bok-sch-exp-{$bkg->code} bok-exp-ovr-lst-hide">
                <td colspan="5">
					<div class="pull-left"><span class="text-danger"> Exception List </span></div>
                    <table class="table remove-bottom">
                        {foreach key=key from=$bkg->overrideList item=bokexp}
                            {if $bokexp->openMinitues=='-1'}
                                <tr class="bk-eo-del-{$bokexp->code}">
                                    <td width="6%">{$bokexp->activeFrom}&nbsp;&nbsp;to&nbsp;&nbsp;{$bokexp->activeTo} </td>
                                    <td width="9%"></td>
                                    <td width="11%">{if $bokexp->dayOfWeek!=''}
                                        <div class="btn-group btn-group-days-display">
                                            {assign var=sxday value=$bokexp->dayOfWeek}        
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                                        </div> 
                                    {/if}   
                                </td>
                                <td width="13%">&nbsp;</td>
                                <td width="6%">
                                </td>
                            </tr>
                            {/if}   

                                {/foreach}
                                </table>
                            </td>
                        </tr>

                        <tr class="bok-sch-ove-{$bkg->code} bok-exp-ovr-lst-hide">
                            <td colspan="5">
								<div class="pull-left"><span class="text-danger"> Override List </span></div>
                                <table class="table">
                                    {foreach key=key from=$bkg->overrideList item=bokexp}

                                        {if $bokexp->openMinitues!='-1'}
                                            <tr class="bk-eo-del-{$bokexp->code}">
                                                <td  width="25%">{$bokexp->activeFrom}&nbsp;&nbsp;to&nbsp;&nbsp;{$bokexp->activeTo} </td>
                                                <td  width="12%">{if $bokexp->dayOfWeek!=''}
                                                    <div class="btn-group btn-group-days-display">
                                                        {assign var=sxday value=$bokexp->dayOfWeek}        
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                                                        <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                                                    </div> 
                                                {/if}   
                                            </td>
                                            <td  width="8%">{$bokexp->openTime}</td>
                                            <td  width="4%">{$bokexp->CloseTime}</td>
                                            <td  width="7%">&nbsp;
                                                <a class="delete pTip_top" title="Delete booking exception" href="javascript:;"  onclick="deleteBookingExpOvrSchedules('{$bokexp->code}', '{$bkg->code}')">
                                                    <i class="fa fa-trash-o"></i>
                                                </a>&nbsp;
                                            </td>
                                        </tr>
                                        {/if}   

                                            {/foreach}
                                            </table>
                                        </td>
                                    </tr>
                                    {/if}
                                        {/foreach}    
                                        </table>
                        
