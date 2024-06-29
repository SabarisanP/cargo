<div class="well well-sm">
    <input type="text" class="form-control" placeholder="Find Station..." id="list_search" >
</div>  
<div class="user_list_action bt_36">
    <ul class="user_list " id="user_list_search">
        <ul class="user_list " id="user_list_search" style="border:none">


            {if count($stations) > 0}
                <div id="station_scroll">

                    <li class="hide st-db">
                        <div class="fl rt_8"><a href="javascript:;"></a></div>
                        <div class="fr fr_7">
                            {if $action_rights['S-DELETE-STATION']>0}
                            <a title="Delete" class="btn btn-default btn-xs" href="javascript:;" {if $action_rights['S-DELETE-STATION']!=2} onclick='deleteNamespaceMapping()' {/if}>
                                <i class="fa fa-trash-o"></i>
                            </a>
                             {/if}
                        </div>
                    </li>
                    {foreach key=statename item=stgrp from=$stations}
                        <li class="rt_8">
                            <div class="bold">
                                {$statename}
                            </div>
                        </li>
                        {foreach item=station from=$stgrp}
                        <li id="ns-{$station.code}" style="padding-left:10px;">
                        <div class="fl rt_8"><a href="javascript:;" onclick="getStationPointsList('{$station.code}', '{$station.name}', '{$station.shortCode}');" id="station-link-{$station.code}" data-obj="{$station|json_encode|escape}" data-shortcode="{$station.shortCode}" title="Click to view station points">{$station.name} {if $station.shortCode != '' && $station.shortCode != 'NA'}({$station.shortCode}){/if}</a></div>
                        <div class="fr fr_7">
                                {if $action_rights['S-DELETE-STATION']>0} 
                                    <a title="Delete" class="btn btn-default btn-xs" href="javascript:;" {if $action_rights['S-DELETE-STATION']!=2}onclick='deleteNamespaceMapping({$station|json_encode})'{/if}>
                                        <i class="fa fa-trash-o"></i>
                                    </a>
                                {/if}
                            </div>
                        </li>
                        {/foreach}
                        
                    {/foreach}

                </div>
            {else}
                <li class="er_msg"><div class="well well-large "> No station found!</div></li>
                {/if}    
        </ul>
    </ul>
</div>
<script>

    $(document).ready(function() {
        $('input#list_search').quicksearch('#user_list_search #station_scroll > li');
    });

    $("#station_scroll").css({
        'max-height': '350px',
    }).perfectScrollbar({
        wheelSpeed: 20,
        wheelPropagation: false
    });
    $('#list_search').focus();

</script>

