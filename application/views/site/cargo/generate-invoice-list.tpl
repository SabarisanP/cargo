{foreach item=vendor from=$result key=vendorkey}
    <div class="row bg-info">
        <div class="col-md-8">
            <div class="col-md-4"><h5><b>{$vendorkey}</b></h5></div>
            <div class="col-md-3 p-y-10 bold text-center" title="Total {$vendor['data']|count} LR"><span id="{$vendor['vendor_code']}-lr-count">{$vendor['data']|count}</span> Selected</div>
            <div class="col-md-3 p-y-10 bold text-center">Rs. <span id="{$vendor['vendor_code']}">{$vendor['total']|number_format:2:'.':''}</span></div>
            <div class="col-md-2 m-t-4">
                <button type="button" class="btn btn-success pull-right btn-sm" onclick="invoicePopup('{$vendor['vendor_code']}', '{$vendorkey}');">Generate Invoice</button>
            </div>
        </div>
    </div>
    <div class="clearfix"></div><br/>
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr class="bold">
                    <th class="text-center"><input type="checkbox" class="gen_invoice_checkall {$vendor['vendor_code']}" data-vendor="{$vendor['vendor_code']}" checked></th>
                    <th align="center">{lang('lr')} No</th>
                    <th align="center">Booked Date</th>
                    <th align="center">Booked by</th>
                    <th align="center">{lang('booking_from_term')}</th>
                    <th align="center">{lang('booking_to_label')}</th>
                    <th align="center">Payment Status</th>
                    <th align="center">Cargo Status</th>
                    <th align="center">Qty</th>
                    <th align="center">Payable</th>
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach item=row from=$vendor['data']}
                    <tr>
                        <td align="center"><input type="checkbox" class="gen_invoice_check {$vendor['vendor_code']}" value="{$row->transaction_code}" data-vendor="{$vendor['vendor_code']}" data-payable="{$row->total_amount}" checked></td>
                        <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}");'>{$row->cargo_code}</a></td>
                        <td align="left">{$row->booked_at|date_format:$ns_date_format}</td>
                        <td align="left">{$row->user_first_name}</td>
                        <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                        <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                        <td align="left">
                            {$row->payment_status_code|_cargo_payment_status_badge}
                        </td>
                        <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                        <td align="center">{$row->total_item_count}</td>
                        <td align="right">{$row->total_amount|number_format:2}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
{foreachelse}
    <div class="well well-large"> No Transactions found.</div>
{/foreach}

<script>
    $('.gen_invoice_check').on('change', function () {
        var $ele = $(this);
        var vendor = $('#' + $ele.data('vendor'));
        var pble = parseFloat($ele.data('payable'));

        if ($(this).is(':checked')) {
            vendor.html((parseFloat(vendor.html()) + pble).toFixed(2));
        } else {
            vendor.html((parseFloat(vendor.html()) - pble).toFixed(2));
        }
        
        $('#' + $ele.data('vendor') + '-lr-count').html($('.gen_invoice_check.' + $ele.data('vendor') + ':checked').length);
    });
    
    $('.gen_invoice_checkall').on('change', function () {
        var $ele = $(this);
        
        $('.gen_invoice_check.' + $ele.data('vendor'))
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });
</script>