<table class="tree table table-hover w-auto" border="1">
    <thead>
        <tr>
            <th class="sticky-row-top" width="400"></th>
            {foreach $orgusers as $user}
                <th class="sticky-row-top valign-bottom" style="mso-rotate:90;"><span class="text-vertical">{$user->name}</span></th>
            {/foreach}
        </tr>
    </thead>
    <tbody>
        {function name=menu_list level=0}
            {foreach $data as $entry}
                {if !$entry->enabledFlag || !count($entry->userCodes)}
                    {continue}
                {/if}
                <tr class="point_cur treegrid-{$entry->code} {if $parentcode}treegrid-parent-{$parentcode}{/if}" onclick="toggleRowTree(this)">
                    <td nowrap>{if $level==0}<b>{$entry->name}</b>{else}{str_repeat('&emsp;', $level)}{$entry->name}{/if}</td>
                    {foreach $orgusers as $user}
                        <td align="center">{if $entry->userCodes[$user->code]}&#10004;{/if}</td>
                    {/foreach}
                </tr>

                {if $entry->eventList|count}
                    {menu_list data=$entry->eventList parentcode=$entry->code level=$level+1}
                {/if}

                {if isset($childmenu[$entry->code])}
                    {menu_list data=$childmenu[$entry->code] parentcode=$entry->code level=$level+1}
                {/if}
            {/foreach}
        {/function}
        {menu_list data=$parentmenu}
    </tbody>
</table>
