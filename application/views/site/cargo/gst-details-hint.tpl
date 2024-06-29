{if $data->status != 1}
    <div class="text-danger small">{$data->errorDesc|default:'Unknown Exception'}</div>
{else}
    {$data = $data->data}
    <div title="Trade Name">{$data->tradeName}</div>

    {if $data->blockStatus == 'B'}
        <div class="label label-danger" title="Block Status">{$gstin_block_status[$data->blockStatus]}</div>
    {/if}

    {if $data->status == 'ACT'}
        <div class="label label-success" title="GST Status">{$gstin_status[$data->status]}</div>
    {elseif $data->status == 'CNL'}
        <div class="label label-danger" title="GST Status">{$gstin_status[$data->status]}</div>
    {elseif $data->status == 'INA'}
        <div class="label label-warning" title="GST Status">{$gstin_status[$data->status]}</div>
    {elseif $data->status == 'PRO'}
        <div class="label label-secondary" title="GST Status">{$gstin_status[$data->status]}</div>
    {else}
        <div class="label label-secondary" title="GST Status">{$gstin_status[$data->status]}</div>
    {/if}

    <div class="label label-info" title="Tax Payer Type">{$gstin_taxpayer_type[$data->taxPayerType]}</div>
{/if}