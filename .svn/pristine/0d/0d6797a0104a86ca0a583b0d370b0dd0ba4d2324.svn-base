<div class="overflow-x-auto" id="schedule-bus-popover">
    <table class="table info_table table-hover" width="100%">
        <thead>
            <tr>
                <th width="175">Name</th>
                <th width="100">Schedule ID</th>
                <th width="175">Date Range</th>
                <th width="75"></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$schedules item=row}
                <tr>   
                    <td>
                        <h6>{$row->name}</h6>
                    </td>   
                    <td>
                        <span class="txt_green">{$row->code}</span><br>
                        <span class="warning-text">{$row->serviceNumber}</span>
                    </td>   
                    <td>
                        {$row->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span>
                        {$row->activeTo|date_format:$ns_date_format}

                        {if $row->activeFlag == 1}
                            {if strtotime('today') <= strtotime($row->activeTo)}
                                <br>
                                {assign var=diffRange value=date_diff(date_create($row->activeFrom), date_create($row->activeTo))}
                                {assign var=daysDiff value=$diffRange->format('%a')}                        

                                {assign var=diffRange1 value=date_diff(date_create($row->activeFrom), date_create())}
                                {assign var=daysDiff1 value=$diffRange1->format('%a')}

                                {if $daysDiff1>3}
                                    {if $daysDiff<=7 && $row->dayOfWeek=="1111111"}
                                        <span class="label label-success">Special</span>
                                    {elseif $daysDiff>7 && $row->dayOfWeek=="1111111"}
                                        <span class="label label-default">Regular</span>
                                    {else}
                                        <span class="label label-info">Weekend</span>
                                    {/if}
                                {else if $daysDiff1<3}   
                                    {if $daysDiff<=7 && $row->dayOfWeek=="1111111"}
                                        <span class="label label-success">Special</span>
                                    {elseif $daysDiff>7 && $row->dayOfWeek=="1111111"}
                                        <span class="label label-danger">Ending soon</span>
                                    {else}
                                        <span class="label label-info">Weekend</span>
                                    {/if}
                                {/if}
                            {/if}
                        {/if}
                    </td>   
                    <td>
                        {if $row->activeFlag == 1}
                            {if strtotime('today') <= strtotime($row->activeTo)}
                                <span class="trip-status label label-success">Active</span>                            
                            {else}
                                <span class="trip-status label label-danger">Expired</span>
                            {/if}
                        {elseif $row->activeFlag == 0}
                            <span class="trip-status label label-default">Closed</span>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="4" align="center">No results Found</td>
                </tr>
            {/foreach}     
        </tbody>
    </table>
</div>