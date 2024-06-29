<div class="table-responsive">
    <table id="cargo_user_branches_table" class="table table-striped">
        <thead>
            <tr>
                <th>Branch</th>
                <th></th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach from=$branches item=row}
                <tr>
                    <td>{$row->name}</td>
                    <td align="center">
                        <a title="Remove Branch" href="javascript:;" class="btn btn-default btn-xs" onclick="removeUserBranch('{$row->code}')"><i class="fa fa-times"></i></a>
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="100%" align="center">No records Found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>