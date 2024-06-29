<div id="unpaid-invoice-list">
    {foreach item=vendor from=$result key=vendorkey}
        <div id="vendor-{$vendor['vendor_code']}">
            <div class="row bg-info">
                <div class="col-md-6">
                    <div class="col-md-4"><h5><b>{$vendorkey}</b></h5></div>
                    <div class="col-md-3 p-y-10 bold text-center">Rs. <span id="{$vendor['vendor_code']}">{round($vendor['total'])|number_format:2:'.':''}</span></div>
                    <div class="col-md-5 m-t-4">
                        <button type="button" class="btn btn-success pull-right btn-sm" onclick="invoicePopup('{$vendor['vendor_code']}');">Generate Invoice</button>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div><br/>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr class="bold">
                            <th class="text-center"><input type="checkbox" class="gen_invoice_checkall {$vendor['vendor_code']}" data-vendor="{$vendor['vendor_code']}" tabindex="-1" checked></th>
                            <th align="center">{lang('lr')} No</th>
                            <th align="center">Booked Date</th>
                            <th align="center">Booked by</th>
                            <th align="center">{lang('booking_from_term')}</th>
                            <th align="center">{lang('booking_to_label')}</th>
                            <th align="center">Payment Status</th>
                            <th align="center">Cargo Status</th>
                            <th align="center">Qty</th>
                            <th align="center">{lang('booking_UOM_label')}</th>
                            <th align="center">Freight <br/>Per Qty/Unit</th>
                            <th align="center">Handling</th>
                            <th align="center">Door Pickup</th>
                            <th align="center">Door Delivery</th>
                            <th align="center">Total</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {foreach item=row from=$vendor['data']}
                            <tr>
                                <td align="center"><input type="checkbox" class="gen_invoice_check {$vendor['vendor_code']}" value="{$row->code}" data-vendor="{$vendor['vendor_code']}" data-payable="{round($row->totalAmount + $row->totalHandlingAmount)}" tabindex="-1" checked></td>
                                <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->code}");' tabindex="-1">{$row->code}</a></td>
                                <td align="left" nowrap>{$row->bookedAt|date_format:$ns_datetime_format}</td>
                                <td align="left" nowrap>{$row->bookedUser->name}</td>
                                <td align="left">{$row->fromOrganization->name} - {$row->fromStation->name}</td>
                                <td align="left">{$row->toOrganization->name} - {$row->toStation->name}</td>
                                <td align="left">
                                    {$row->paymentType->code|_cargo_payment_status_badge}
                                </td>
                                <td align="left">{$cargo_status[$row->cargoStatus->code]}</td>
                                <td align="center">{$row->totalItemCount}</td>
                                {assign var=article value=null}
                                {assign var=uomOrQty value=null}
                                {foreach from=$row->itemDetails item=item}
                                    {$article = $item}
                                    {$uomOrQty = $item->unitValue}
                                    {if $item->unit->code == '' || $item->unit->code == 'NPPKG'}
                                        {$uomOrQty = $item->itemCount}
                                    {/if}
                                    {break}
                                {/foreach}
                                <td align="center">{$article->unitValue} {$article_unit[$article->unit->code]}</td>
                                <td width="120" align="right">
                                    <input type="text" class="form-control freight-inp" placeholder="Freight" value="{$article->fare}">
                                </td>
                                <td width="120" align="right">
                                    <input type="text" class="form-control loading-inp" placeholder="L. Charges" value="{$article->handlingChargeAmount}">
                                </td>
                                <td width="120" align="right">
                                    <input type="text" class="form-control doorpickup-inp" placeholder="Pickup Charges" value="{$row->pickupHandlingAmount}">
                                </td>
                                <td width="120" align="right">
                                    <input type="text" class="form-control doordelivery-inp" placeholder="Delivery Charges" value="{$row->deliveryHandlingAmount}">
                                </td>
                                <td width="120" align="right">
                                    <input type="text" class="form-control total-inp" placeholder="Total" value="{round($row->totalAmount + $row->totalHandlingAmount)}" disabled>
                                    <input type="hidden" class="form-control qty-inp" placeholder="Total" value="{$uomOrQty}">
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {foreachelse}
        <div class="well well-large"> No Transactions found.</div>
    {/foreach}
</div>

<script>
    var invoiceData = {$lrresult|json_encode};

    $('.gen_invoice_check').on('change', function () {
        var $ele = $(this);
        var vendor = $ele.data('vendor');

        var payable = 0;
        $('#vendor-' + vendor).find('.gen_invoice_check:checked').each(function () {
            payable += parseFloat($(this).data('payable'));
        });

        $('#' + vendor).html((payable).toFixed(2));
    });
    
    $('.gen_invoice_checkall').on('change', function () {
        var $ele = $(this);
        
        $('.gen_invoice_check.' + $ele.data('vendor'))
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });

    $('#unpaid-invoice-list').on('change', '.freight-inp, .loading-inp, .doorpickup-inp, .doordelivery-inp', function () {
        var $tr = $(this).closest('tr');
        var freight = $.trim($tr.find('.freight-inp').val());
        var uomOrQty = $.trim($tr.find('.qty-inp').val());
        var loading = $.trim($tr.find('.loading-inp').val());
        var doorpickup = $.trim($tr.find('.doorpickup-inp').val());
        var doordelivery = $.trim($tr.find('.doordelivery-inp').val());

        if (freight == '' || isNaN(freight)) {
            return
        }
        if (loading == '' || isNaN(loading)) {
            return
        }
        if (doorpickup == '' || isNaN(doorpickup)) {
            return
        }
        if (doordelivery == '' || isNaN(doordelivery)) {
            return
        }

        var total = Number(freight) * Number(uomOrQty) + Number(loading) + Number(doorpickup) + Number(doordelivery);
        total = Math.round(total)
        $tr.find('.total-inp').val(total);
        $tr.find('.gen_invoice_check').data('payable', total).trigger('change');
    });
</script>