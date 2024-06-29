<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Cargo Booking Preview
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeCargoPreviewDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>
</div>

<table width="100%" cellpadding="5" class="table table-bordered ">
    <tbody class="body_table">
        <tr class="success">
            <td align="left" width="50%">
                <span class="bold"> {lang('booking_from_label')}</span>
            </td>
            <td align="left" width="50%">
                <span class="bold">{lang('booking_to_label')}</span>
            </td>
        </tr>
        <tr>
            <td align="left" width="50%">
                {if ($pickup == 1) || ($del == 1) || $summary->lrLoadType == 'PTL' || $summary->lrLoadType == 'FTL'}
                    {$summary->fromStation->name}, {$summary->fromOrganization->name}
                    <br>{$summary->fromOrganization->contact}
                {else}
                    {$summary->fromOrganization->name}
                    <br>{$summary->fromOrganization->contact}
                {/if}
            </td>
            <td align="left" width="50%">
                {if ($pickup == 1) || ($del == 1) || $summary->lrLoadType == 'PTL' || $summary->lrLoadType == 'FTL'}
                    {$summary->toStation->name}, {$summary->toOrganization->name}
                    <br>{$summary->toOrganization->contact}
                {else}
                    {$summary->toOrganization->name}
                    <br>{$summary->toOrganization->contact}
                {/if}
            </td>
        </tr>
        <tr>
            <td align="left" width="50%" class="">{$summary->fromCustomer->name}</td>
            <td align="left" width="50%" class="">{$summary->toCustomer->name}</td>
        </tr>
        <tr>
            <td align="left" width="50%" class="">{$summary->fromCustomer->mobileNumber}</td>
            <td align="left" width="50%" class="">{$summary->toCustomer->mobileNumber}</td>
        </tr>
        {if $summary->fromCustomerGST !="" || $summary->toCustomerGST !=""}
            <tr>
                <td align="left" width="50%" class="">GSTIN : {$summary->fromCustomerGST}</td>
                <td align="left" width="50%" class="">GSTIN : {$summary->toCustomerGST}</td>
            </tr>
        {/if}
    </tbody>
</table>

<table width="100%" cellpadding="5" class="table table-bordered ">
    <tbody class="body_table">
        {if $summary->vendorUser->code}
            <tr>
                <td align="left" width="50%" class="bold">Vendor</td>
                <td align="left" width="50%">{$summary->vendorUser->name}</td>
            </tr>
        {/if}
    </tbody>
</table>

<table width="100%" cellpadding="5" class="table table-bordered ">
    <tr class="success">
        <td align="center" class="bold">S No</td>
        <td align="center" class="bold">{lang('booking_article_label')}</td>
        <td align="center" class="bold">{lang('booking_UOM_label')} {if lang('booking_UOM_label_info')}<i class="fa fa-info-circle" data-toggle="tooltip" data-title="{lang('booking_UOM_label_info')}"></i>{/if}</td>
        <td align="center" class="bold">Quantity</td>
        <td align="center" class="bold">Rate</td>
        <td align="center" class="bold">Freight</td>
    </tr>
    <tbody class="body_table">
        {assign var=subtotal value=0}
        {foreach from=$summary->itemDetails item=article name=carArt}
            <tr>
                <td align="center">{$smarty.foreach.carArt.index+1}</td>
                <td align="left">
                    {$article->cargoItem->name}
                    {if isNotNull($article->cargoItem->description[0])}
                    <br/><small class="text-muted">{$article->cargoItem->description[0]}</small>
                    {/if}
                </td>
                <td align="center">
                    {$article->unitValue}
                    {$article_unit[$article->unit->code]}
                </td>
                <td align="center">{$article->itemCount}</td>
                <td align="right">{$article->fare}</td>
                <td align="right">
                    {$article->computed->freight|number_format:2}
                </td>
            </tr>
            {assign var=subtotal value=$subtotal + $article->computed->freight}
        {/foreach}
        <tr>
            <td align="right" colspan="5">Sub Total</td>
            <td align="right">{$subtotal|number_format:2}</td>
        </tr>
    </tbody>
</table>

<table width="100%" cellpadding="5" class="table table-bordered">
    <tr>
        <td align="right">Freight</td>
        <td align="right">{$subtotal|number_format:2}</td>
    </tr>
    <tr>
        <td align="right">L Charges</td>
        <td align="right">{$summary->totalHandlingAmount|number_format:2}</td>
    </tr>
    {if $summary->pickupHandlingAmount > 0}
        <tr>
            <td align="right">Pickup Charges</td>
            <td align="right">{$summary->pickupHandlingAmount|number_format:2}</td>
        </tr>
    {/if}
    {if $summary->deliveryHandlingAmount > 0}
        <tr>
            <td align="right">Delivery Charges</td>
            <td align="right">{$summary->deliveryHandlingAmount|number_format:2}</td>
        </tr>
    {/if}
    {if $summary->totalUnloadHandlingAmount > 0}
        <tr>
            <td align="right">Unloading Charges</td>
            <td align="right">{$summary->totalUnloadHandlingAmount|number_format:2}</td>
        </tr>
    {/if}
</table>

<b>Remarks :</b> {$summary->remarks}
<br/><br/>

<div class="row">
    <div class="col-md-12 text-right">
        <button class="btn btn-primary" type="button" id="confirm-modify-btn" onclick="closeCargoPreviewDialog()">Modify</button>&nbsp;
        <button class="btn btn-success" type="button" id="confirm-booking-btn" onclick="closeCargoPreviewDialog();savePreBooking()">Confirm</button>&nbsp;
    </div>
</div>

<script>
    $('[data-toggle="tooltip"]').tooltip();
</script>
