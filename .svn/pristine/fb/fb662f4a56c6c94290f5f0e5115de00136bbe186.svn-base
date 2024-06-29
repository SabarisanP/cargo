<h5 class="bold">Integrations - {$integrationTypeName}</h5>

{if count($integrations) == 0 || $integrationTypeCode == 'EWAYBILL'}
<a href="javascript:;" class="btn btn-success btn-xs pull-right" onclick="Integrations.edit();">Add New</a>
{/if}

<table class="table">
    <thead>
        <tr>
            <th>Account</th>
            <th>Access URL</th>
            <th>Access Token</th>
            {if $integrationTypeCode == 'EWAYBILL'}
                <th>State</th>
                <th>SECRET</th>
                <th>APPID</th>
                <th>GSTIN</th>
            {/if}
            <th></th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$integrations item=row}
            <tr>
                <td>{$row->account}</td>
                <td>{$row->accessUrl}</td>
                <td>{$row->accessToken}</td>
                {if $integrationTypeCode == 'EWAYBILL'}
                    <td>{(isNotNull($row->state->code)) ? $row->state->name : 'Default'}</td>
                    <td class="small">{$row->additionalAttribute->SECRET}</td>
                    <td class="small">{$row->additionalAttribute->APPID}</td>
                    <td class="small">{$row->additionalAttribute->GSTIN}</td>
                {/if}
                <td align="center" nowrap>
                    <a class="edit" title="Edit" href="javascript:;" onclick="Integrations.edit({$row|json_encode|escape})"><i class="fa fa-pencil fa-lg"></i></a>&nbsp;
                    <a class="delete" title="Delete" href="javascript:;" onclick="Integrations.delete({$row|json_encode|escape})"><i class="fa fa-trash-o fa-lg"></i></a>
                </td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Data Found</td>
            </tr>
        {/foreach}
    </tbody>
</table>
