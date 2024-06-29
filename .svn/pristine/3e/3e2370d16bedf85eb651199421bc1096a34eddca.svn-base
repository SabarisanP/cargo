<div class="slider-content namespace station-details stationPoints">
    {if $stationspoints|count==0}
        <div> Sorry! No points added </div>
    {/if}
    <ul class="list-unstyled">
    {foreach item=alpha from=$atoz}
        {if $stationspoints[$alpha]|count>0}    
        <li id="{$alpha|lower}"><a name="{$alpha|lower}" class="title">{$alpha|upper}</a>
        <ul class="list-unstyled">
        {foreach item=station from=$stationspoints[$alpha]}
            <li id="ns-{$station.code}" >
                <div class="tools">
                    <a title="Delete from my station points" href="javascript:;" onclick='deleteStationPointNamespaceMapping({$station|json_encode})'><i class="fa fa-trash-o ired"></i></a>

                </div>
                <div class="fl">{$station.name}</div>
            </li>
        {/foreach}
        </ul>
        {/if}
    {/foreach}
    </ul>
</div>
