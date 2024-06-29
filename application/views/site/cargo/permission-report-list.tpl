<div class="table-responsive">
    <table class="tree table table-hover w-auto">
        <thead>
            <tr>
                <th class="sticky-row-top valign-bottom" width="400">
                    <button class="btn btn-xs" onclick="toggleEventRows(this)" data-toggle="expand">Toggle Events</button><br><br>
                </th>
                {foreach $orgusers as $user}
                    <th class="sticky-row-top valign-bottom"><span class="text-vertical">{$user->name}</span></th>
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
                        <td {if $level==0}class="bold" {/if} nowrap>{$entry->name}</td>
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
</div>

<script>
    $('#permission-list table.tree').treegrid({
        expanderTemplate: '<span class="treegrid-expander valign-bottom pointer-events-none"></span>'
    });

    function toggleRowTree(tr) {
        $(tr).treegrid('toggle');
    }

    function toggleEventRows(btn) {
        var toggle = $(btn).data('toggle') == 'collapse' ? 'expand' : 'collapse';

        $('#permission-list table.tree').treegrid('getAllNodes').each(function() {
            if ($(this).treegrid('getDepth') == 1) {
                $(this).treegrid(toggle);
            }
        });

        $(btn).data('toggle', toggle);
    }
</script>
