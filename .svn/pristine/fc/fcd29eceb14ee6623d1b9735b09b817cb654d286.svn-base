{assign var="qr_img" value=null}
{foreach from=$org_images item=row}
    {if $row->tag == 'QR'}
        {assign var="qr_img" value=$row}
        {break}
    {/if}
{/foreach}
{if count($org_details->bankDetails)>0 || $qr_img}
    {if count($org_details->bankDetails)>0}
        <h5><b>Bank Details</b></h5>
        <ol class="p_l_15">
            {foreach from=$org_details->bankDetails item=bank_details key=k}
                <li class="m-b-4"><b>{$bank_details->bankName}, {$bank_details->branchLocation}</b><br/> <b>UPI:</b> {$bank_details->upiId}</li>        
            {/foreach}
        </ol>
    {/if}
    {if $qr_img}
        <img src="{$dms_domain}/download/{$qr_img->imageUrlSlug}" width="100%">         
    {/if}
{else}
    <div class="well well-lg">No Bank details found for this branch!</div>
{/if}