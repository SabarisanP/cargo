<br><br>
<table class="table table-design tab-wid-95">
    <tbody class="routes-add">
        {foreach item=route from=$routes}
            <tr class="del-all-remo-{$route['from']}-{$route['to']}">
                <th class="bold">
                    {$route['name']}
                </th>
                <th class="txt-a-r">
                </th>
            </tr>
            <tr class="del-all-remo-{$route['from']}-{$route['to']}">
                <td colspan="2">
                    <table class="table" >
                        {foreach item=row from=$route['fare']}
                            <tr id="fare-{$row['code']}" >
                                <td width="10%" class="routes-seat-exit-{$route['from']}-{$route['to']}" data-seat='{$row['busSeatType']->code}' data-group='{$row['group']->code}' data-code="{$row['code']}">{$row['busSeatType']->name}</td>
                                <td width="20%"><i class="fa fa-users"></i> &nbsp;{if $row['group']->name != ''} {$row['group']->name} {else}All Group {/if}</td>
                                <td width="20%">
                                    {if $row['activeFrom']!='' &&  $row['activeTo']!=''}
                                        {$row['activeFrom']}&nbsp;&nbsp;to&nbsp;&nbsp;{$row['activeTo']}
                                    {/if}   
                                </td>
                                <td width="20%">
                                    {if $row['dayOfWeek'] =='0000000'}
                                        <div class="btn-group btn-group-days-display">
                                            {assign var=rday value=$row['dayOfWeek']}        
                                            <label class="btn btn-success-list btn-xs chk-btn">S</label>
                                            <label class="btn btn-success-list btn-xs chk-btn">M</label>
                                            <label class="btn btn-success-list btn-xs chk-btn">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn">W</label>
                                            <label class="btn btn-success-list btn-xs chk-btn">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn">F</label>
                                            <label class="btn btn-success-list btn-xs chk-btn">S</label>
                                        </div>
                                    {else if $row['dayOfWeek']!=''}
                                        <div class="btn-group btn-group-days-display">
                                            {assign var=rday value=$row['dayOfWeek']}        
                                            <label class="btn btn-success-list btn-xs chk-btn {if $rday|substr:0:1==1}active{/if}">S</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $rday|substr:1:1==1}active{/if}">M</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $rday|substr:2:1==1}active{/if}">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $rday|substr:3:1==1}active{/if}">W</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $rday|substr:4:1==1}active{/if}">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $rday|substr:5:1==1}active{/if}">F</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $rday|substr:6 ==1}active{/if}">S</label>
                                        </div> 
                                    {/if}   
                                </td>
                                <td width="5%"><i class="fa fa-rupee"></i> {$row['fare']}</td>
                                <td width="20%">
                                </td>
                            </tr>
                            {counter start=0 skip=1 assign="countexp"}
                            {if count($row['overrideList']) > 0}
                                <tr class="routes-sch-exp-{$row['code']} rou-exp-ovr-lst-hide">
                                    <td  colspan="2">
                                        <div class="pull-left" id="exp-{$row['code']}">
                                            <span class="text-danger" style="padding-left:175px"> Exception List </span>
                                        </div></td>
                                        {foreach key=key from=$row['overrideList'] item=rouexp}
                                            {if $rouexp->fare=='-1'}
                                                {counter}
                                        <div class="st-eo-del-{$rouexp->code}">
                                            <td width="10%">{$rouexp->activeFrom}&nbsp;&nbsp;to&nbsp;&nbsp;{$rouexp->activeTo} </td>
                                            <td width="20%">{if $rouexp->dayOfWeek!=''}
                                                <div class="btn-group btn-group-days-display" >
                                                    {assign var=sxday value=$rouexp->dayOfWeek}        
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
                                        <td width="5%"></td>
                                        <td width="20%">

                                        </td>
                                    </div>
                                    {/if}   

                                        {/foreach}
                                            {if $countexp == 0}
                                                {literal}
                                                    <script>
                                                        var val = "{/literal}{$row['code']}{literal}";
                                                        $("#exp-" + val).hide();
                                                    </script>
                                                {/literal}
                                            {/if}                                          
                                </tr>
                                {counter start=0 skip=1 assign="countover"}
                                <tr class="routes-sch-ove-{$row['code']} rou-exp-ovr-lst-hide" >
                                    <td colspan="2"  >
                                        <div class="pull-left" style="padding-left:175px" id="over-{$row['code']}">
                                            <span class="text-danger" > Override List </span></div>
                                    </td>
                                    {foreach key=key from=$row['overrideList'] item=rouexp}

                                        {if $rouexp->fare!='-1'}
                                            {counter}
                                    <div class="st-eo-del-{$rouexp->code}" >
                                        <td width="20%"> {$rouexp->activeFrom}&nbsp;&nbsp;to&nbsp;&nbsp;{$rouexp->activeTo} </td>
                                        <td width="20%">{if $rouexp->dayOfWeek!=''}
                                            <div class="btn-group btn-group-days-display" >
                                                {assign var=sxday value=$rouexp->dayOfWeek}        
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
                                    <td width="5%"> <i class="fa fa-rupee"></i>{$rouexp->fare}</td>
                                    <td width="20%">
                                        
                                    </td>

                                    </tr>
                                </div>
                                {/if}   

                                    {/foreach}
                                        {if $countover == 0}
                                            {literal}
                                                <script>
                                                    var val = "{/literal}{$row['code']}{literal}";
                                                    $("#over-" + val).hide();
                                                </script>
                                            {/literal}
                                        {/if} 
                                    </tr>
                                    {/if}
                                        {/foreach}   
                                        </table>
                                    </td>
                                </tr>
                                {/foreach}   
                                </tbody>
                            </table>
                        </script>