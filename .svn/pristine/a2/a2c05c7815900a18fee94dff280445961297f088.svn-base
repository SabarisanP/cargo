<div class="table-responsive">

    {if $trips|count==0} 
        <div class="well well-large"> Sorry! No trips were found.</div>
    {else}    

        <table class="table table-hover" id="mail_inbox">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>From Station</th>        
                    <th>To Station</th>
                    <th>Fare</th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$trips item=row key=new}
                    {assign var="stages_count" value=count($row->stageList)-1}
                    <tr>

                        <td  class="v-a-c" data-stages="{count($row->stageList)}">
                            <span class="bold">{$row->schedule->name} </span>
                            <br>
                            <span class="text-muted">{formatBusCategory cate_code=$row->bus->categoryCode}</span>
                        </td>
                        <td >
                            <span class='txt_green'>
                                <i class="fa fa-level-up"></i>
                            </span>&nbsp;{$row->stageList[0]->fromStation->name}&nbsp;
                            <br>
                            <span class="text-muted">{$row->stageList[0]->fromStation->dateTime|date_format:'%I:%M %p'}</span>
                        </td>                
                        <td>
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
                        <td>

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


                    </tr>

                {/foreach} 
            </tbody>

        </table>
    {/if}
</div>
