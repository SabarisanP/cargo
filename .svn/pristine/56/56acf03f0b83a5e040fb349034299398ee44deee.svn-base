{if $address|count > 0}        
    <div class="row">
        {foreach name=o item=row from=$address}             
            <div class="col-md-4">
                <div class="well well-sm">                        
                    <div class="bold">{$row->name}</div>                       
                    <div>{$row->address1}{if $row->address2}, {$row->address2}{/if}</div>
                    <div>{$row->landmark}</div>
                    <div>{$row->station->name} - {$row->pincode}</div>
                    <div class="text-right">
                        <a href="javascript:;" title="Edit" onclick='vendorAddressDialog("{$row->code}")'><i class="fa fa-pencil"></i></a>
                        <a href="javascript:;" title="Delete" onclick='deleteVendorAddress("{$row->code}")'><i class="fa fa-trash"></i></a>
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
{else}
    <div>
        <div class="well well-large "> No address details available.</div>
    </div>
{/if}

<script>
    var vendorAddressData = {$address|json_encode};
</script>