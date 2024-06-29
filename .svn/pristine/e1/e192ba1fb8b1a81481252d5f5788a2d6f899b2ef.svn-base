<div class="slider-content station-details">
     {if $stationspoint|count==0}
        <div> Sorry! No Points Avaialble </div>
    {/if}
    <ul>
    {foreach item=alpha from=$atoz}

        <li id="{$alpha|lower}"><a name="{$alpha|lower}" class="title">{$alpha|upper}</a>
        <ul>
        {foreach item=stationpoint from=$stationspoint[$alpha]}
            <li id="st-{$stationpoint.code}" >
                <div class="tools">
                    <a title="Add to my station points" href="javascript:;"  onclick='addNamespaceStationPointMapping({$stationpoint|json_encode})'><i class="fa fa-plus igreen"></i></a>

                </div>
                <div  class="fl">{$stationpoint.name}</div>
            </li>
        {/foreach}
        </ul>

    {/foreach}
    </ul>
</div>
