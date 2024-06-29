{if $schedulesactive|count==0} 
    <div class="well well-large"> Sorry! No schedule(s) available.</div>

{else}  
    <div class="table-responsive">
        <table class="table info_table table-hover" id="act-sch-tbl">
            <thead>
                <tr>
                    <th>Schedule and Bus Type</th>
                    <th>Date Range</th>
                    <th>From Station </th>
                    <th>To Station</th>                    
                    <th>Fare</th>
            </tr>
            </thead>
            <tbody>
                {foreach from=$schedulesactive item=row}
                    <tr id="sch-{$row['code']}" name="schedules">
                        <td>
                            <div class="pull-left">
                                <span class="bold">{$row['name']}</span> <br>
                                <span class="text-muted">{$row['BusType']}</span>
                            </div>

                        </td>
                        <td>
                            <div class="pull-left">
                                {$row['activeFrom']} <span class="glyphicon glyphicon-resize-horizontal"></span>
                                {$row['activeTo']} 
                            </div>
                        </td>
                        <td>
                            <div class="pull-left">
                                {if $row['startStation']==''}
                                    -
                                {else}
                                    <span class='txt_green'>
                                        <i class="fa fa-level-up"></i>
                                    </span>
                                    &nbsp;
                                {$row['startStation']}
                                {/if}
                                <br>
                                <span class="text-muted">
                                    {if $row['fromStationTime']!=''}
                                        {$row['fromStationTime']}
                                    {else}
                                        -
                                    {/if}
                                </span>
                            </div> 
                        </td>
                        <td>
                            <div class="pull-left">
                                {if $row['endStation']==''}
                                    -
                                {else}
                                    <span class='txt_green'>
                                        <i class="fa fa-level-down"></i></span>&nbsp;
                                        {$row['endStation']}
                                {/if}
                                <br>
                                <span class="text-muted">
                                    {if $row['toStationTime']!=''}
                                        {$row['toStationTime']}
                                    {else}
                                        -
                                    {/if}
                                </span>
                            </div> 
                        </td>
                        <td> 
                            <div class="pull-left"> 
                                {if $row['faremin']!=''}
                                    <span class='txt_green'><i class="fa fa-rupee"></i></span>&nbsp;{$row['faremin']}
                                {/if}
                                {if  $row['faremax']!=''}
                                , <span class='txt_green'><i class="fa fa-rupee"></i></span>&nbsp;{$row['faremax']}
                                {/if}   
                            </div>
                        </td>
                    </tr>

                {/foreach}                
            </tbody>
        </table>  

    </div>
{/if}    
