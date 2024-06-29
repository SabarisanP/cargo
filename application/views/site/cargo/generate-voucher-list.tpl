{foreach item=org from=$result key=orgkey}
    <div class="row bg-info">
        <div class="col-md-6 p_l_n">
            <div class="col-md-4"><h5><b>{$orgkey}</b></h5></div>
            <div class="col-md-3 p-y-10 bold text-center">Rs. <span id="amount-{$org['from_organization_code']}">{$org['total']|number_format:2:'.':''}</span></div>
            <div class="col-md-5 m-t-4">
                <button type="button" class="btn btn-success pull-right btn-sm" onclick="voucherPopup('{$org['from_organization_code']}', '', '{$orgkey}');">Generate Voucher</button>
            </div>
        </div>
    </div>
    {foreach item=usr from=$org['data'] key=usrkey}
        <div class="row hover-background">
            <div class="col-md-7 p_l_n">
                <div class="col-md-4"><h6><b>{$usrkey}</b></h6></div>
                <div class="col-md-4 p-y-10 bold text-center">Total LRs - <span id="count-{$org['from_organization_code']}-{$usr['user_code']}">{$usr['count']}</span></div>
                <div class="col-md-4 p-y-10 bold text-center">Total Qty - <span id="items-{$org['from_organization_code']}-{$usr['user_code']}">{$usr['items']}</span></div>
            </div>
            <div class="col-md-5 p_r_n">
                <div class="col-md-6 p-y-10 bold text-center">Rs. <span id="amount-{$org['from_organization_code']}-{$usr['user_code']}">{$usr['total']|number_format:2:'.':''}</span></div>
                <div class="col-md-6 m-t-5">
                    <button type="button" class="btn btn-success pull-right btn-xs" onclick="voucherPopup('{$org['from_organization_code']}', '{$usr['user_code']}', '{$usrkey}');">Generate Voucher</button>
                </div>
            </div>
        </div><br/>
        <div class="clearfix"></div>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr class="bold">
                        <th class="text-center"><input type="checkbox" class="gen_voucher_checkall {$org['from_organization_code']} {$usr['user_code']}" data-user="{$usr['user_code']}" data-org="{$org['from_organization_code']}" checked></th>
                        <th align="center">{lang('lr')} No</th>
                        <th align="center">Booked Date</th>
                        <th align="center">Collected by</th>
                        <th align="center">{lang('booking_from_term')}</th>
                        <th align="center">{lang('booking_to_label')}</th>
                        <th align="center">Payment Status</th>
                        <th align="center">Cargo Status</th>
                        <th align="center">Qty</th>
                        <th align="center">Net Amount</th>
                        <th align="center">Commission</th>
                        <th align="center">Payable</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$usr['data']}
                        <tr>
                            <td align="center"><input type="checkbox" class="gen_voucher_check {$org['from_organization_code']} {$usr['user_code']}" value="{$row->transaction_code}" data-user="{$usr['user_code']}" data-org="{$org['from_organization_code']}" data-payable="{$row->total_amount}" data-qty="{$row->total_item_count}" checked></td>
                            <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}");'>{$row->cargo_code}</a></td>
                            <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                            <td align="left">{$row->user_first_name}</td>
                            <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                            <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                            <td align="left">
                                {$row->payment_status_code|_cargo_payment_status_badge}
                            </td>
                            <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                            <td align="center">{$row->total_item_count}</td>
                            <td align="right">{$row->transaction_amount|number_format:2}</td>
                            <td align="right">{$row->commission_amount|number_format:2}</td>
                            <td align="right">{$row->total_amount|number_format:2}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    {/foreach}
{foreachelse}
    <div class="well well-large"> No Transactions found.</div>
{/foreach}

<script>
    var voucherUserCode = '{$userCode}';
    var voucherOrganizationCode = '{$organizationCode}';
    
    $('.gen_voucher_check').on('change', function () {
        var $ele = $(this);
        var org = {};
        org.amount = $('#amount-' + $ele.data('org'));
        
        var user = {}
        user.count = $('#count-' + $ele.data('org') + '-' + $ele.data('user'));
        user.items = $('#items-' + $ele.data('org') + '-' + $ele.data('user'));
        user.amount = $('#amount-' + $ele.data('org') + '-' + $ele.data('user'));

        var pble = parseFloat($ele.data('payable'));
        var qty = parseFloat($ele.data('qty'));
        
        if ($(this).is(':checked')) {
            user.amount.html((parseFloat(user.amount.html()) + pble).toFixed(2));
            org.amount.html((parseFloat(org.amount.html()) + pble).toFixed(2));
            user.items.html(parseFloat(user.items.html()) + qty);
            user.count.html(parseFloat(user.count.html()) + 1);
        } else {
            user.amount.html((parseFloat(user.amount.html()) - pble).toFixed(2));
            org.amount.html((parseFloat(org.amount.html()) - pble).toFixed(2));
            user.items.html(parseFloat(user.items.html()) - qty);
            user.count.html(parseFloat(user.count.html()) - 1);
        }
    });
    
    $('.gen_voucher_checkall').on('change', function () {
        var $ele = $(this);
        
        $('.gen_voucher_check.' + $ele.data('org') + '.' + $ele.data('user'))
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });
</script>