<div class="slider-content station-details">
    <ul>
    {foreach item=alpha from=$atoz}

        <li id="{$alpha|lower}"><a name="{$alpha|lower}" class="title">{$alpha|upper}</a>
        <ul>
        {foreach item=station from=$stations[$alpha]}
            <li id="st-{$station.code}" >
                <div class="tools">
                    <a title="Add" href="javascript:;"  onclick='addNamespaceMapping({$station|json_encode})'><i class="fa fa-plus igreen"></i></a>

                </div>
                <div  class="fl">{$station.name}</div>
            </li>
        {/foreach}
        </ul>

    {/foreach}
    </ul>
</div>
