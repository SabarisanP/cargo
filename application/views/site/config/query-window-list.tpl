{if $smarty.request.export == 1}
    <style>
        .success {
            font-weight: bold;
            background-color:#64b92a;
            color: #fff;
        }
    </style>
{/if}

{if $result->status != 1}
    <div class="alert alert-danger">{$result->errorDesc}</div>
{elseif count($result->data) == 0}
    <div class="alert alert-danger">No records Found</div>
{else}
    <div class="table-responsive">
        <table class="table table-bordered" id="query-list">
            <thead>
                <tr class="success">
                    {foreach from=$result->data[0] key=key item=value}
                        <th>{$key|replace:'_':' '|capitalize}</th>
                    {/foreach}
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach from=$result->data key=key item=value}
                    <tr>
                        {foreach from=$value item=row}
                            <td nowrap>{$row}</td>
                        {/foreach}
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>

    {if $smarty.request.export != 1}
        <script>
            $('#query-list').dataTable({
                pageLength: -1,
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, 'All']],
                sDom: '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"f>r>>' +
                      '<"overflow-x-auto"t>' +
                      '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>'
            });
        </script>
    {/if}
{/if}
