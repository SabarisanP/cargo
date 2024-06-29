<div class="brand_top">
    <h3>Pre Booking History</h3>
    <div class="text-right noprint" id="" style="">
        <div class="btn-group btn-group">
            <a href="#prebooking/pre-booking" class="btn btn-success btn-sm" target="_blank">Pre Book</a>
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="collection-rpt-list">
                                         <table id="pre_booking_history_table" class="table table-bordered " width="100%">
                                            <thead>
                                                <tr class="success">
                                                    <th>S.No</th>
                                                    <th>Prebooking / Cargo Code</th>
                                                    <th>Booked Date & Time</th>
                                                    <th>From Branch</th>
                                                    <th>To Branch</th>
                                                    <th>Sender</th>
                                                    <th>Contact</th>
                                                    <th>Receiver</th>
                                                    <th>Contact</th>
                                                    <th align="center">No.of Articles</th>
                                                    <th>Expected Handover</th>
                                                    <th>Booking Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach from=$prebooking key=key item=val}
                                                    {$itm_cnt = 0}
                                                    {foreach from=$val->itemDetails item=row}
                                                        {$itm_cnt = $itm_cnt+1}
                                                    {/foreach}
                                                    <tr>
                                                        <td>{$key+1}</td>
                                                        <td>
                                                            <a href="javascript:;" id="view-pre-booking" onclick=" getPreBookingDetails('{$val->code}');">{$val->code}</a>
                                                            {if $val->cargoCode != 'NA'}
                                                                / {$val->cargoCode}
                                                            {/if}
                                                        </td>
                                                        <td>{$val->bookedAt|date_format:$ns_datetime_format}</td>
                                                        <td>{$val->fromOrganization->name}</td>
                                                        <td>{$val->toOrganization->name}</td>
                                                        <td>{$val->fromCustomer->name}</td>
                                                        <td>{$val->fromCustomer->mobileNumber}</td>
                                                        <td>{$val->toCustomer->name}</td>
                                                        <td>{$val->toCustomer->mobileNumber}</td>
                                                        <td align="center">{$itm_cnt}</td>
                                                        <td>{$val->handoverAt|date_format:$ns_date_format}</td>

                                                        <td align="center">
                                                            {if $val->status->code == 'REQST'}
                                                                <span class="badge badge-secondary">{$val->status->name}</span>
                                                            {elseif $val->status->code == 'LOAD'}
                                                                <span class="badge badge-info">{$val->status->name}</span>
                                                            {elseif $val->status->code == 'ACPTD'}
                                                                <span class="badge badge-success">{$val->status->name}</span>
                                                            {elseif $val->status->code == 'UNLD'}
                                                                <span class="badge badge-warning">{$val->status->name}</span>
                                                            {elseif $val->status->code == 'CANCL'}
                                                                <span class="badge badge-danger">{$val->status->name}</span>
                                                            {else}
                                                                <span class="badge badge-secondary">{$val->status->name}</span>
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                {foreachelse}
                                                    <tr>
                                                        <td align="center" colspan="12">No Prebookings Found !!</td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                         </table>               
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<script>
    var lrdata = {$prebooking|json_encode};
    var items = {$items|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};

    if(isNotNull(lrdata)){
        $('#pre_booking_history_table').dataTable({
            "pageLength": 50
        });
    }

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
            if (menu_permission['HANDLING-PER-QTY']==1) {
                loadingCharges = parseFloat(item.loadingChargeAmount) / parseFloat(item.itemCount);
                unloadingCharges = parseFloat(item.unloadingChargeAmount) / parseFloat(item.itemCount);
            } else if (menu_permission['HANDLING-PER-UOM']==1) {
                loadingCharges = parseFloat(item.loadingChargeAmount) / parseFloat(item.unitValue);
                unloadingCharges = parseFloat(item.unloadingChargeAmount) / parseFloat(item.unitValue);
            } else if (menu_permission['HANDLING-PER-UOMQTY']==1) {
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
            if (menu_permission['HANDLING-PER-UOMQTY'] == 1) {
                loadingCharges = Math.ceil(parseFloat(handling) * parseInt(uomOrQty));
                unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(uomOrQty));
            } else if (menu_permission['HANDLING-PER-QTY'] == 1) {
                loadingCharges = Math.ceil(parseFloat(handling) * parseInt(qty));
                unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(qty));
            } else if (menu_permission['HANDLING-PER-UOM'] == 1) {
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
                    if (menu_permission['HANDLING-PER-UOMQTY'] == 1) {
                        item.loadingChargeAmount = Math.ceil(parseFloat(item.loadingChargeAmount) * parseFloat(uomOrQty));
                        item.unloadingChargeAmount = Math.ceil(parseFloat(item.unloadingChargeAmount) * parseFloat(uomOrQty));
                    } else if (menu_permission['HANDLING-PER-QTY'] == 1) {
                        item.loadingChargeAmount = Math.ceil(parseFloat(item.loadingChargeAmount) * parseInt(item.itemCount));
                        item.unloadingChargeAmount = Math.ceil(parseFloat(item.unloadingChargeAmount) * parseInt(item.itemCount));
                    } else if (menu_permission['HANDLING-PER-UOM'] == 1) {
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
</script>