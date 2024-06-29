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
                {$summary->fromOrganization->name}
                <br>{$summary->fromOrganization->contact}
            </td>
            <td align="left" width="50%">
                {$summary->toOrganization->name}
                <br>{$summary->toOrganization->contact}
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
        {if isNotNull($summary->fromCustomerGST) || isNotNull($summary->toCustomerGST)}
            <tr>
                <td align="left" width="50%" ><b>GSTIN :</b> {$summary->fromCustomerGST|default:'-'}</td>
                <td align="left" width="50%" ><b>GSTIN :</b> {$summary->toCustomerGST|default:'-'}</td>
            </tr>
        {/if}
        {if isNotNull($summary->fromCustomer->companyName) || isNotNull($summary->toCustomer->companyName)}
            <tr>
                <td align="left" width="50%" ><b>Company :</b> {$summary->fromCustomer->companyName|default:'-'}</td>                
                <td align="left" width="50%" ><b>Company :</b> {$summary->toCustomer->companyName|default:'-'}</td>         	
            </tr>
        {/if}
    </tbody>
</table>

<table width="100%" cellpadding="5" class="table table-bordered ">
    <tbody class="body_table">
        <tr>
            <td align="left" width="50%" class="bold">Payment Type</td>
            <td align="left" width="50%">{$summary->paymentType->name}</td>
        </tr>
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
        {if $action_rights['CARGO-UNITS']==1}
            <td align="center" class="bold">{lang('booking_UOM_label')} {if lang('booking_UOM_label_info')}<i class="fa fa-info-circle" data-toggle="tooltip" data-title="{lang('booking_UOM_label_info')}"></i>{/if}</td>
        {/if}
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
                {if $action_rights['CARGO-UNITS']==1}
                    <td align="center">
                        {$article->unitValue}
                        {$article_unit[$article->unit->code]}
                    </td>
                {/if}
                <td align="center">{$article->itemCount}</td>
                <td align="right">
                    {if in_array('FR', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
                    {$article->fare}
                </td>
                <td align="right">
                    {$article->computed->freight|number_format:2}
                </td>
            </tr>
            {assign var=subtotal value=$subtotal + $article->computed->freight}
        {/foreach}
        <tr>
            {if $action_rights['CARGO-UNITS']==1}
                <td align="right" colspan="5">Sub Total</td>
            {else}
                <td align="right" colspan="4">Sub Total</td>
            {/if}
            <td align="right">{$subtotal|number_format:2}</td>
        </tr>
    </tbody>
</table>

{assign var="customerTdsTaxAmount" value=0}
{if count($summary->cargoTransactionList) > 0}
    {foreach from=$summary->cargoTransactionList item=cargoTransactionList}
        {assign var="customerTdsTaxAmount" value=$customerTdsTaxAmount + $cargoTransactionList->customerTdsTaxAmount}
    {/foreach}
{/if}

<table width="100%" cellpadding="5" class="table table-bordered">
    <tr>
        <td align="right">Freight</td>
        <td align="right">
            {if in_array('FR', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
            {$subtotal|number_format:2}
        </td>
    </tr>
    <tr>
        <td align="right">L Charges</td>
        <td align="right">
            {if in_array('LC', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
            {$summary->totalHandlingAmount|number_format:2}
        </td>
    </tr>
    {if $summary->pickupHandlingAmount > 0 || in_array('DP', $addons_mapped['FRECR']->valueList)}
        <tr>
            <td align="right">Pickup Charges</td>
            <td align="right">
                {if in_array('DP', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
                {$summary->pickupHandlingAmount|number_format:2}
            </td>
        </tr>
    {/if}
    {if $summary->deliveryHandlingAmount > 0 || in_array('DD', $addons_mapped['FRECR']->valueList)}
        <tr>
            <td align="right">Delivery Charges</td>
            <td align="right">
                {if in_array('DD', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
                {$summary->deliveryHandlingAmount|number_format:2}
            </td>
        </tr>
    {/if}
    {if $summary->totalUnloadHandlingAmount > 0}
        <tr>
            <td align="right">Unloading Charges</td>
            <td align="right">{$summary->totalUnloadHandlingAmount|number_format:2}</td>
        </tr>
    {/if}

    {if $summary->serviceCharge > 0 || in_array('OC', $addons_mapped['FRECR']->valueList)}
        <tr>
            <td align="right">Service Charges</td>
            <td align="right">
                {if in_array('OC', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
                {$summary->serviceCharge|number_format:2}
            </td>
        </tr>
    {/if}

    {if $summary->hamaliCharge > 0 || in_array('HC', $addons_mapped['FRECR']->valueList)}
        <tr>
            <td align="right">Hamali Charges</td>
            <td align="right">
                {if in_array('HC', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
                {$summary->hamaliCharge|number_format:2}
            </td>
        </tr>
    {/if}

    {if $summary->passCharge > 0}
        <tr>
            <td align="right">Pass Charges</td>
            <td align="right">{$summary->passCharge|number_format:2}</td>
        </tr>
    {/if}

    {if $summary->docketCharge > 0 || in_array('DC', $addons_mapped['FRECR']->valueList)}
        <tr>
            <td align="right">Docket Charges</td>
            <td align="right">
                {if in_array('DC', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
                {$summary->docketCharge|number_format:2}
            </td>
        </tr>
    {/if}
    {if isset($addons_mapped['PODCH'])}
        <tr>
            <td align="right">POD Charge</td>
            <td align="right">{$addons_mapped['PODCH']->value|number_format:2}</td>
        </tr>
    {/if}
    {if isset($addons_mapped['DMRCH'])}
        <tr>
            <td align="right">Demurrage Charge</td>
            <td align="right">{$addons_mapped['DMRCH']->value|number_format:2}</td>       	
        </tr>  
    {/if}

    {if $cargo_setting->lrGstTaxComputeType == 'FRT' && $summary->serviceTax > 0}
        <tr>
            <td align="right">GST Amount</td>
            <td align="right">{$summary->serviceTax}</td>
        </tr>
    {/if}
    {if isset($addons_mapped['INSUR'])}
    <tr>
        <td align="right">Insurance Charge</td>
        <td align="right">{$addons_mapped['INSUR']->value|number_format:2}</td>       	
    </tr>  
    {/if}
    {if isset($addons_mapped['MCNHCH']) || in_array('MC', $addons_mapped['FRECR']->valueList)}
    <tr>
        <td align="right">Machine Handling Charges</td>
        <td align="right">
            {if in_array('MC', $addons_mapped['FRECR']->valueList)}<span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span>{/if}
            {$addons_mapped['MCNHCH']->value|number_format:2}
        </td>
    </tr>  
    {/if}
    {if isset($addons_mapped['FOVCH'])}
        <tr>
            <td align="right">Freight On Value Charges</td>
            <td align="right">
                {$addons_mapped['FOVCH']->value|number_format:2}
            </td>
        </tr>  
    {/if}
    {if isset($addons_mapped['RNDF'])}
    <tr>
        <td align="right">Round off</td>
        <td align="right">{$addons_mapped['RNDF']->value|number_format:2}</td>
    </tr>
    {/if}
    {* {if $tax_computed->cgstValue != 0}
    <tr>
        <td align="right">CGST</td>
        <td align="right">{$tax_computed->cgstValue|number_format:2}</td>
    </tr>
    {/if}
    {if $tax_computed->sgstValue != 0}
    <tr>
        <td align="right">SGST</td>
        <td align="right">{$tax_computed->sgstValue|number_format:2}</td>
    </tr>
    {/if}
    {if $tax_computed->ugstValue != 0}
    <tr>
        <td align="right">UGST</td>
        <td align="right">{$tax_computed->ugstValue|number_format:2}</td>
    </tr>
    {/if}
    {if $tax_computed->igstValue != 0}
    <tr>
        <td align="right">IGST</td>
        <td align="right">{$tax_computed->igstValue|number_format:2}</td>
    </tr>
    {/if} *}

    {if $cargo_setting->lrGstTaxComputeType == 'NET'}
        <tr>
            <td align="right" class="bold">Sub Total</td>
            <td align="right" class="bold">
                {($subtotal+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value + $addons_mapped['FOVCH']->value)|number_format:2}
            </td>
        </tr>
    {/if}

    {if $cargo_setting->lrGstTaxComputeType == 'NET' && $summary->serviceTax > 0}
        <tr>
            <td align="right">GST Amount</td>
            <td align="right">{$summary->serviceTax|number_format:2}</td>
        </tr>
    {/if}

    <tr class="active">
        <td align="right" class="bold">Net Amount</td>
        <td align="right" class="bold">{($subtotal+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value + $addons_mapped['FOVCH']->value)|number_format:2}</td>
    </tr>

    {if $customerTdsTaxAmount > 0}
        <tr>
            <td align="right">TDS Tax</td>
            <td align="right">{$customerTdsTaxAmount|number_format:2}</td>
        </tr>
    {/if}

    <tr>
        <td align="right">Amount Paid</td>
        <td align="right">{$summary->paymentAmount|number_format:2}</td>
    </tr>
    <tr>
        <td align="right">Amount Balance</td>
        {if $cargo_setting->gstTaxComputeModel == "INGST"}
            {* reduce Inclusive GST amount in  *}
            {assign var="balance_to_pay" value=($subtotal+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value + $addons_mapped['FOVCH']->value - $customerTdsTaxAmount)-$summary->paymentAmount}
        {else}
            {assign var="balance_to_pay" value=($subtotal+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value + $addons_mapped['FOVCH']->value - $customerTdsTaxAmount)-$summary->paymentAmount}
        {/if}
       
        <td align="right" {if $balance_to_pay>0} class="danger" {/if}>

            {$balance_to_pay|number_format:2}
        </td>
    </tr>
</table>

<b>Remarks :</b> 
{foreach from=$summary->remarks item=row}
    {$row->name}
{/foreach}
<br/><br/>

<div class="row">
    <div class="col-md-12 text-right">
        <button class="btn btn-primary" type="button" id="confirm-modify-btn" onclick="closeCargoPreviewDialog()">Modify</button>&nbsp;
        <button class="btn btn-success" type="button" id="confirm-booking-btn" onclick="closeCargoPreviewDialog();saveBooking()">Confirm</button>&nbsp;
    </div>
</div>

<script>
    $('[data-toggle="tooltip"]').tooltip();
</script>
