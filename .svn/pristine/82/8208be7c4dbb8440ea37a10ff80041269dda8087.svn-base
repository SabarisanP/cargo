<div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 bold ft_14">
            Cargo Pre Booking Details   : <span class="badge badge-warning font-17">{$summary->code}</span>
        </div>
        <div class="col-md-2"> 
            
            <a class="align-right" onclick="closeCargoDetailsDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

{if !empty($summary)}      
    <div id="load-to-ogpl-panel" class="hide">
    </div>

    <table width="100%" cellpadding="5">
    <tr>
        <td width="59%" valign="top">
            <table width="100%" cellpadding="5" class="table table-bordered ">
                <tbody class="body_table" >
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
                    <td align="left" width="50%" >
                        {$summary->toOrganization->name}
                        <br>{$summary->toOrganization->contact}
                    </td>       	
                </tr>
                <tr>
                    <td align="left" width="50%"  class="">{$summary->fromCustomer->name}</td>                
                    <td align="left" width="50%"  class="">{$summary->toCustomer->name}</td>       	
                </tr>
                <tr>
                    <td align="left" width="50%"  class="">{if $smarty.request.onBooked}{$summary->fromCustomer->mobileNumber}{else}{$summary->fromCustomer->mobileNumber|mask_mobileno}{/if}</td>                
                    <td align="left" width="50%"  class="">{if $smarty.request.onBooked}{$summary->toCustomer->mobileNumber}{else}{$summary->toCustomer->mobileNumber|mask_mobileno}{/if}</td>         	
                </tr>
                {if isNotNull($summary->fromCustomerAddress->code) || isNotNull($summary->toCustomerAddress->code)}
                    <tr>
                        <td align="left" width="50%" title="Pickup Address">
                            {if isNotNull($summary->fromCustomerAddress->code)}
                                {$summary->fromCustomerAddress->address1},  {$summary->fromCustomerAddress->landmark}<br/>
                                {$summary->fromCustomerAddress->station->name} - {$summary->fromCustomerAddress->pincode}
                            {else}-{/if}
                        </td>
                        <td align="left" width="50%" title="Delivery Address">
                            {if isNotNull($summary->toCustomerAddress->code)}
                                {$summary->toCustomerAddress->address1},  {$summary->toCustomerAddress->landmark}<br/>
                                {$summary->toCustomerAddress->station->name} - {$summary->toCustomerAddress->pincode}
                            {else}-{/if}
                        </td>         	
                    </tr>
                {/if}
                {if $summary->fromCustomerGST !="" || $summary->toCustomerGST !=""}
                    <tr>
                        <td align="left" width="50%"  class="">GSTIN : {$summary->fromCustomerGST}</td>                
                        <td align="left" width="50%"  class="">GSTIN : {$summary->toCustomerGST}</td>         	
                    </tr>
                {/if}
                </tbody>
            </table>
        </td>
        <td width="1%"></td>
        <td width="40%" valign="top">
            <table width="100%" cellpadding="5" class="table table-bordered ">
                <tbody class="body_table" >
                <tr>
                    <td align="left" width="15%"  class="bold">Date</td>
                    <td align="left" width="35%" >{$summary->bookedAt|date_format:$ns_datetime_format}</td>
                </tr>
                <tr>
                    <td align="left" width="15%" class="bold">No of Articles</td>
                    <td align="left" width="35%">
                        {assign var=qty value=0}
                        {foreach from=$summary->itemDetails item=item}
                            {assign var=qty value=$qty + $item->itemCount}
                        {/foreach}
                        {$summary->itemDetails|count} (Qty - {$qty})
                    </td>       	
                </tr>
                <tr>
                    <td align="left" width="15%" class="bold">Net Amount</td>
                    <td align="left" width="35%">                       
                        Rs {($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)|number_format:2}
                    </td>       	
                </tr>
                {if $summary->deliveredUser->name != ''}
                <tr>
                    <td align="left" width="15%" class="bold">Delivered By</td>
                    <td align="left" width="35%">{$summary->deliveredUser->name}</td>       	
                </tr>  
                {/if}
                {if $summary->vendorUser->name!=''}
                <tr>
                    <td align="left" width="15%" class="bold">Vendor</td>
                    <td align="left" width="35%">{$summary->vendorUser->name}
                    </td>       	
                </tr> 
                {/if}
                <tr>
                    <td align="left" width="15%" class="bold">Settlement</td>
                    <td align="left" width="35%">{if $summary->paymentSettlementFlag == 0}Not Completed{else}Completed{/if}</td>       	
                </tr>
                {if isset($addons_mapped['EWBL'])}
                <tr>
                    <td align="left" width="15%" class="bold">E-Way Bill</td>
                    <td align="left" width="35%">
                        {$addons_mapped['EWBL']->value}
                    </td>       	
                </tr>  
                {/if}
                </tbody>
            </table>  
            
        </td>
    </tr>
    </table>


<div id="lr-panel">
    <table width="100%">
        <tr>
            <td width="60%" valign="top" style="padding-right: 10px;">
                <table width="100%" cellpadding="5" class="table table-bordered">
                    <tr>
                        <td align="left" width="20%" class="bold">Payment Type</td>
                        <td align="left" width="30%">{$payment_type_name}</td> 
                        <td align="left" width="20%" class="bold">Cargo Status</td>
                        <td align="left" width="30%" 
                            {if $summary->status->code == 'REQST'} class="active"
                            {elseif $summary->status->code == 'ACPTD'} class="primary"
                            {elseif $summary->status->code == 'LOAD'} class="info"
                            {elseif $summary->status->code == 'UNLD'} class="warning"
                            {elseif $summary->status->code == 'CNVTD'} class="success"
                            {elseif $summary->status->code == 'CANCL'} class="danger"
                            {else} class="danger"
                            {/if}
                        >{$summary->status->name}</td> 
                    </tr>
                </table>

                <table width="100%" cellpadding="5" class="table table-bordered ">
                    <tr class="success">
                        <td align="center" class="bold">S No</td>
                        <td align="center" class="bold">{lang('booking_article_label')}</td>
                        <td align="center" class="bold">{lang('booking_UOM_label')} {if lang('booking_UOM_label_info')}<i class="fa fa-info-circle" data-toggle="tooltip" data-title="{lang('booking_UOM_label_info')}"></i>{/if}</td>
                        <td align="center" class="bold">Quantity</td>
                        <td align="center" class="bold">Rate</td>
                        <td align="center" class="bold">
                            Freight 
                                <a href="javascript:;" class="btn btn-danger btn-xs" onclick="editItems({$summary|json_encode|@escape});"> <i class="fa fa-pencil"></i> </a>
                        </td>
                    </tr>
                    <tbody class="body_table" id="items-tbody" >
                        {assign var=subtotal value=0}
                        {foreach from=$summary->itemDetails item=article name=carArt}
                            <tr data-itemcode="{$article->code}">
                                <td class="sno" align="center">{$smarty.foreach.carArt.index+1}</td>
                                <td align="left">
                                    {$article->cargoItem->name}
                                    {if isNotNull($article->cargoItem->description[0])}
                                       <br/><div class="small text-muted text-truncate" style="max-width: 250px;">{$article->cargoItem->description[0]}</div>
                                    {/if}
                                </td>
                                <td align="center">
                                    {$article->unitValue}
                                    {$article_unit[$article->unit->code]}
                                </td>
                                <td align="center">{$article->itemCount}</td>
                                <td align="right">{$article->fare}</td>
                                <td align="right" data-gst="{$article->serviceTax}">
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
                {if $summary->invoiceNumber !="" || $summary->invoiceAmount !="" || $summary->invoiceDate !=""}            
                <table width="100%" cellpadding="5" class="table table-bordered ">
                    <tr class="">
                        <td align="center" class="bold">Invoice Number</td>
                        <td align="center" class="bold">Invoice Amount</td>                                 
                        <td align="center" class="bold">Invoice Date</td>
                    </tr>
                    <tbody class="body_table" >
                        <tr>
                            <td align="center">{$summary->invoiceNumber}</td>
                            <td align="center">{$summary->invoiceAmount}</td>                                 
                            <td align="center">{$summary->invoiceDate}</td>
                        </tr>
                    </tbody>
                </table>
                {/if}
                <b>Remarks :</b> {$summary->remarks}
                <br/><br/>
            </td>
            <td width="40%" valign="top">
                <table width="100%" cellpadding="5" class="table table-bordered ">
                    <tr>
                        <td align="right">Freight</td>
                        <td align="right">{$summary->totalAmount|number_format:2}</td>
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
                        <td align="right">Door Delivery Charges</td>
                        <td align="right">{$summary->deliveryHandlingAmount|number_format:2}</td>
                    </tr>
                    {/if}
                    {if $summary->totalUnloadHandlingAmount > 0}
                    <tr>
                        <td align="right">Unloading Charges</td>
                        <td align="right">{$summary->totalUnloadHandlingAmount|number_format:2}</td>
                    </tr>
                    {/if}

                    {if $summary->serviceCharge > 0}
                    <tr>
                        <td align="right">Service Charges</td>
                        <td align="right">{$summary->serviceCharge|number_format:2}</td>
                    </tr>
                    {/if}
                    
                                        
                    {if isset($summary->tax->code)}
                        {if $tax_computed->cgstValue != 0}
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
                        {/if}
                    {elseif $summary->serviceTax > 0}
                        <tr>
                            <td align="right">GST</td>
                            <td align="right">{$summary->serviceTax|number_format:2}</td>
                        </tr>
                    {/if}

                    <tr class="active">
                        <td align="right" class="bold">Net Amount</td>
                        <td align="right" class="bold">{($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)|number_format:2}</td>
                    </tr>

                    {* <tr>
                        <td align="right">Amount Paid</td>
                        <td align="right">{$summary->paymentAmount|number_format:2}</td>                    
                    </tr> *}
                    <tr>
                        <td align="right">Amount Balance</td>
                        {assign var="balance_to_pay" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value)-$summary->paymentAmount}
                        <td align="right" {if $balance_to_pay>0} class="danger" {/if}>

                            {$balance_to_pay|number_format:2}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <div class="text-right" id="cd-action-state"></div>
    
    <div class="popup_bottom sticky-row-bottom">
    <table width="100%" cellpadding="5" id="cd-btn-panel">
        <tr>
            <td align="left" width="60%" nowrap>
                {if $summary->status->code == 'LOAD'}
                    <a class="btn btn-success btn-sm" onclick="changePrebookLRStatus('UNLD', '{$cargoCode}')">UnLoad</a>&nbsp;
                {/if} 
            </td>
            <td align="right" width="40%" nowrap>
                <a class="btn btn-sm btn-default" onclick='closeCargoDetailsDialog();' href="javascript:;">Close</a>&nbsp;  
            </td>
        </tr>
    </table>
    </div>
</div>
{else}
    <div class="alert alert-danger">Invalid {lang('lr')} Code</div>   
{/if}
                
<div id="dia-cargo-edit" class="hide dialog-content-page"></div>

<script id="template-edit-items" type="text/template">
    <form id='formEditItems' class="form-horizontal" method="post" name="formEditItems" action="" onsubmit="return false" role="form" autocomplete="off">
        <table width="100%" cellpadding="5" class="table table-bordered ">
            <tr class="success">
                <td align="center" class="bold"></td>
                <td align="center" width="25%" class="bold">Article</td>
                <td align="center" class="bold" width="20%">{lang('booking_UOM_label')} {if lang('booking_UOM_label_info')}<i class="fa fa-info-circle" data-toggle="tooltip" data-title="{lang('booking_UOM_label_info')}"></i>{/if}</td>
                <td align="center" class="bold">Quantity</td>
                <td align="center" class="bold">Rate</td>
                <td align="center" class="bold">
                    L.Charges 
                    {if $action_rights['PB-HANDLING-PER-UOMQTY']==1}
                        Per {lang('booking_UOM_label')} or Qty
                    {else if $action_rights['PB-HANDLING-PER-QTY']==1}
                        Per Qty
                    {else if $action_rights['PB-HANDLING-PER-UOM']==1}
                        Per {lang('booking_UOM_label')}
                    {/if}
                </td>
                <td align="center" class="bold">UL.Charges</td>
                <td align="center" class="bold">Total</td>
            </tr>
            <tbody class="items_body_table" ></tbody>
        </table>
        <div class="row">
            <div class="col-md-12">
                <textarea class="form-control" placeholder="Remarks" id="items-edit-remarks"></textarea>
            </div>
        </div>
    </form>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl" id="action-state"></div>   
        <div class="align-right" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveItems({$summary|json_encode|@escape});">Update</button>
            <button class="btn btn-default" type="button" onclick="cancelEditDialog();">Cancel</button>
        </div>
    </div>
</script>

<script id="template-edit-item-row" type="text/template">
    <tr class="article_row">
        <td><a href="javascript:;" onclick="removeArticleRowEdit(this);" class="btn btn-sm btn-default tr_remove" title="Remove"><i class="fa fa-minus"></i></a></td>
        <td class="iarticle"><input type="text" class="form-control iarticle-inp" placeholder="Select {lang('booking_article_label')}"/></td>
        <td>
            <div class="row">
                <div class="col-md-5 p_r_n">
                    <input type="text" class="form-control iunitval" value="1" onblur="calculateTotal();">
                </div>
                <div class="col-md-7 p_l_n">
                    <select class="form-control iunit" onchange="calculateTotal();">
                        {foreach item=value key=key from=$article_unit} 
                            <option value="{$key}">{$value}</option> 
                        {/foreach}
                    </select>
                </div>
            </div>
        </td>
        <td><input type="text" class="form-control iqty" name="quantity" value="" maxlength="3" onblur="calculateTotal();"> </td>
        <td><input type="text" class="form-control irate" disabled name="rate" value="" maxlength="5" onblur="calculateTotal();"></td>
        <td><input type="text" class="form-control ilcharge" name="lcharges" value="" maxlength="5" onblur="calculateTotal();"></td>
        <td><input type="text" class="form-control iucharge" name="ulcharges" value="" maxlength="5" onblur="calculateTotal();"></td>
        <td><input type="text" class="form-control itotal" name="total" readonly="readonly" value="" maxlength="6" onblur="calculateTotal();">
        <input type="hidden" class="icode" name="code" value="">
        <input type="hidden" class="iicode" name="icode" value="">
        </td>
    </tr>
</script>

<div id="lr-activity-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideLRActivityDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div class="clearfix" id="lr-activity" style="padding: 10px 5px;">
    </div>
</div>   

<script>
    var lrdata = {$summary|json_encode};
    var items = {$items|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};

    function editItems(lrcode) {
        $('#dia-cargo-edit').removeClass('hide');
        $('#dia-cargo-edit').dialog({
            autoOpen: true,
            height: 450,
            width: 950,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();  
        
        var tmp = $('#template-edit-items').html();
        $('#dia-cargo-edit').html(tmp);
        
        $('#dia-cargo-edit').find('#items-edit-remarks').val('');
        
        var itmp = $('#template-edit-item-row').html();

        $(lrcode.itemDetails).each(function(k, item){
            var iitem = $(itmp).clone();
            $(iitem).attr('data-code', item.code);
            $(iitem).find('.iarticle').html(item.cargoItem.name);
            $(iitem).find('.iqty').val(parseFloat(item.itemCount));
            $(iitem).find('.irate').val(parseFloat(item.fare));
            $(iitem).find('.iunit').val(item.unit.code);
            $(iitem).find('.iunitval').val(parseFloat(item.unitValue));
            var uomOrQty = Number(item.unitValue); // UOM value or Qty
            if (isNaN(item.unitValue) || item.unit.code == 'NPPKG') {
                uomOrQty = Number(item.itemCount);
            }
            var loadingCharges = 0;
            var unloadingCharges = 0;
            if (menu_permission['PB-HANDLING-PER-QTY']==1) {
                loadingCharges = parseFloat(item.loadingChargeAmount) / parseFloat(item.itemCount);
                unloadingCharges = parseFloat(item.unloadingChargeAmount) / parseFloat(item.itemCount);
            } else if (menu_permission['PB-HANDLING-PER-UOM']==1) {
                loadingCharges = parseFloat(item.loadingChargeAmount) / parseFloat(item.unitValue);
                unloadingCharges = parseFloat(item.unloadingChargeAmount) / parseFloat(item.unitValue);
            } else if (menu_permission['PB-HANDLING-PER-UOMQTY']==1) {
                loadingCharges = parseFloat(item.loadingChargeAmount) / parseFloat(uomOrQty);
                unloadingCharges = parseFloat(item.unloadingChargeAmount) / parseFloat(uomOrQty);
            } else {
                loadingCharges = parseFloat(item.loadingChargeAmount);
                unloadingCharges = parseFloat(item.unloadingChargeAmount);
            }
            
            $(iitem).find('.ilcharge').val(Number(loadingCharges).toFixed(2));
            $(iitem).find('.iucharge').val(Number(unloadingCharges).toFixed(2));
            $(iitem).find('.icode').val(item.code);
            //$(iitem).find('.iicode').html(item.cargoItem.code);
            
            $('.items_body_table').append(iitem);
        });
        
        $('#items-edit-remarks').val(lrcode.remarks);
        
        addArticleRowEdit();
        calculateTotal();
    }

    function removeArticleRowEdit(btn) {
        $(btn).closest('.article_row').attr('data-deleted', 1).hide();
    }

    function cancelEditDialog() {
        $('#dia-cargo-edit').dialog('destroy');
        $('#dia-cargo-edit').hide();
        $('#dia-cargo-edit').html('');
    }

    function calculateTotal() {
        $('#formEditItems .article_row:not([data-deleted=1])').each(function() {        
            var qty = $(this).find('.iqty').val() || 1;
            var price = $(this).find('.irate').val() || 0;
            var handling = $(this).find('.ilcharge').val() || 0;
            var unloading = $(this).find('.iucharge').val() || 0;
            
            var unitValue = $(this).find('.iunitval').val();
            var unit = $(this).find('.iunit').val();

            var uomOrQty = unitValue; // UOM value or Qty
            if (isNaN(unitValue) || unit == 'NPPKG') {
                unitValue = 1;
                uomOrQty = qty;
            }

            var freight = parseFloat(price) * parseFloat(uomOrQty);
            var loadingCharges = Math.ceil(parseFloat(handling));
            var unloadingCharges = Math.ceil(parseFloat(unloading));
            if (menu_permission['PB-HANDLING-PER-UOMQTY'] == 1) {
                loadingCharges = Math.ceil(parseFloat(handling) * parseInt(uomOrQty));
                unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(uomOrQty));
            } else if (menu_permission['PB-HANDLING-PER-QTY'] == 1) {
                loadingCharges = Math.ceil(parseFloat(handling) * parseInt(qty));
                unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(qty));
            } else if (menu_permission['PB-HANDLING-PER-UOM'] == 1) {
                loadingCharges = Math.ceil(parseFloat(handling) * parseFloat(unitValue));
                unloadingCharges = Math.ceil(parseFloat(unloading) * parseFloat(unitValue));
            }

            var total = 0;
            if (parseInt(qty) > 0) {
                total = parseFloat(freight) + parseFloat(loadingCharges) + parseFloat(unloadingCharges);
            }
            $(this).find('.itotal').val(Number(total).toFixed(2));
        });
    }

    function addArticleRowEdit() {
        var masterItems = [];
        $.each(items || [], function(key, art) {
            var ti = {};
            ti.label = art.name;
            ti.value = key;
            ti.data = art;
            
            masterItems.push(ti);
        });  
        
        var itmp = $('#template-edit-item-row').html();
        var iitem = $(itmp).clone();
        $('.items_body_table').append(iitem);
        $(iitem).find('.iarticle-inp').autocomplete({
            minLength: 0,
            source: masterItems,
            select: function( event, ui ) {
                $(this).data('selectedIndex', ui.item.value);
    
                var data = ui.item.data;
                if (!data) return;
    
                var $article_row = $(this).closest('.article_row');
                $article_row.find('.iarticle-inp').val(data.name);
                $article_row.find('#code').val(data.code);
                $article_row.find('.iqty').val(1);
                $article_row.find('.irate').val(data.defaultRate);
                $article_row.find('.iunit').val('NPPKG');
                $article_row.find('.iunitval').val(1);
                $article_row.find('.ilcharge').val(data.defaultHandlingRate);
                $article_row.find('.iucharge').val(0);
                calculateTotal();
                if ($article_row.is(':last-child')) {
                    addArticleRowEdit();
                }
                return false;
            }
        }).focus(function(){
            $(this).autocomplete('search', '');
        });
    }

    function saveItems(lr_data) { 
        var fdata = {};
        fdata.lr = lr_data;
        var total_pay = 0;
        var total_freight = 0;

        fdata.lr.itemDetails = _.keyBy(fdata.lr.itemDetails, 'code');
        var itemDetails = [];

        $('#formEditItems .article_row').each(function(i) {
            if( Number( $(this).find('.iqty').val() ) >0 ) {
                var code = $(this).data('code') || '';
                var item = fdata.lr.itemDetails[code] ? fdata.lr.itemDetails[code] : {};

                if (code == '') {
                    var autocomplete = $(this).find('.iarticle-inp').data('uiAutocomplete') || {};
                    item.cargoItem = {};
                    item.cargoItem.code = autocomplete.selectedItem ? autocomplete.selectedItem.data.code : '';
                    item.cargoItem.name = $(this).find('.iarticle-inp').val();
                    item.actualUnitValue = 0;
                }
                item.serviceTax = 0;

                item.activeFlag = $(this).is('[data-deleted=1]') ? 2 : 1;
                item.code = code;
                item.fare = $(this).find('.irate').val() || 0;
                item.itemCount = $(this).find('.iqty').val() || 1;
                item.loadingChargeAmount = $(this).find('.ilcharge').val() || 0;
                item.unloadingChargeAmount = $(this).find('.iucharge').val() || 0;
                item.unit = {};
                item.unit.code = $(this).find('.iunit').val();
                item.unitValue = $(this).find('.iunitval').val();
                
                var uomOrQty = item.unitValue; // UOM value or Qty
                if (isNaN(item.unitValue) || item.unit.code == 'NPPKG') {
                    item.unitValue = 1;
                    uomOrQty = item.itemCount;
                }

                if (item.activeFlag) {
                    if (menu_permission['PB-HANDLING-PER-UOMQTY'] == 1) {
                        item.loadingChargeAmount = Math.ceil(parseFloat(item.loadingChargeAmount) * parseFloat(uomOrQty));
                        item.unloadingChargeAmount = Math.ceil(parseFloat(item.unloadingChargeAmount) * parseFloat(uomOrQty));
                    } else if (menu_permission['PB-HANDLING-PER-QTY'] == 1) {
                        item.loadingChargeAmount = Math.ceil(parseFloat(item.loadingChargeAmount) * parseInt(item.itemCount));
                        item.unloadingChargeAmount = Math.ceil(parseFloat(item.unloadingChargeAmount) * parseInt(item.itemCount));
                    } else if (menu_permission['PB-HANDLING-PER-UOM'] == 1) {
                        item.loadingChargeAmount = Math.ceil(parseFloat(item.loadingChargeAmount) * parseFloat(item.unitValue));
                        item.unloadingChargeAmount = Math.ceil(parseFloat(item.unloadingChargeAmount) * parseFloat(item.unitValue));
                    }

                    var freight = parseFloat(item.fare) * parseFloat(uomOrQty);
                    total_freight += freight;

                    var serviceTax = parseFloat(freight) * cargoSetting.serviceTaxPercentage / 100;
                    item.serviceTax = Number(serviceTax).toFixed(2);
                }
                itemDetails.push(item);
            }
        });
        fdata.lr.itemDetails = itemDetails;

        if (fdata.lr.itemDetails.length == 0) {
            $('#action-state').addClass('alert').addClass('alert-danger').html('Please add atleast one article');
            return false;
        }

        if(total_freight > cargoSetting.minServiceTax) {
            fdata.lr.serviceTax = parseFloat(total_freight) * cargoSetting.serviceTaxPercentage / 100;
            fdata.lr.serviceTax = Math.ceil(fdata.lr.serviceTax);
        } else {
            $.each(fdata.lr.itemDetails || [], function (i, item) {
                item.serviceTax = 0;
            });
        }
        
        fdata.lr.remarks = $('#items-edit-remarks').val();
        
        $('#form-bttons').hide();
        $('#action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "prebooking/edit-save-prebooking",
            data: fdata,
            success: function (response) {
                if (response.status == 1) {                
                    $('#action-state').addClass('alert').addClass('alert-success').html('Details updated successfully');
                    window.setTimeout(function () {
                        cancelEditDialog();
                        getPreBookingDetails(lr_data.code);
                    }, 3000);
                } else {
                    $('#action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
        ga_track_event('LR Details', 'Edit Articles', '');
    }

    function changePrebookLRStatus(state, code) {    
        var data = {};

        var lastTransit = lrdata.transitCargoDetails[lrdata.transitCargoDetails.length - 1];
        data.transitCode = lastTransit ? lastTransit.code : '';
    
        data.cargoList = [];

        var lr = {};
        lr.code = code;
        lr.cargoStatus = {};
        lr.cargoStatus.code = state;

        data.cargoList.push(lr);

        $('#cd-btn-panel').hide();
        $('#cd-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "prebooking/update-booking-status",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#cd-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        getPreBookingDetails(code);
                    }, 3000);
                } else {
                    $('#cd-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc || 'Unknown Exception');
                    $('#cd-revert-panel-btn').show();
                }
            }
        })
    }
</script>