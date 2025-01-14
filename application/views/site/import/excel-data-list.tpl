<div class="row d-flex align-items-center mb-10">
    <div class="col-md-3">
        <span>{$lrs|count} LR(s) Found.</span>
    </div>
    <div class="col-md-9">
        <button onclick="importLrs();" class="btn btn-success pull-right">Import</button>
        <div class="alert pull-right mb-0" id="import-lr-action-state" style="margin-right: 5px;"></div>
    </div>
</div>
<table class="table table-bordered" width="98%" id="excel-lr-table">
    <thead>
        <tr class="success">
            <th>
                {if $lrs|count}
                    <input type="checkbox" class="checkall-excel-lr">
                {/if}
            </th>
            <th align="left">LR No</th>
            <th align="left">LR Status</th>
            <th align="left">Booked Date</th>
            <th align="left">Unloaded Date</th>
            <th align="left">From</th>
            <th align="left">To</th>
            <th align="left">Sender</th>
            <th align="left">Receiver</th>
            <th align="right">No Of Article</th>
            
            <th align="right">Actual Weight</th>
            <th align="right">Amount</th>
            <th align="right">Payment Type</th>
            <th align="right">Invoice Value</th>
            {if $userHeader[14] !=="Remarks"}   
            <th align="right">Door Delivery</th>
            <th align="right">Door Delivery Charges</th>
            <th align="right">Door Pickup</th>
            <th align="right">Door Pickup Charges</th>
            <th align="right">Loading Charges</th>
            {/if}
            <th align ="left">Article</th>
            <th align ="left">Remarks</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$lrs}
            <tr class="lr-code-{$row["v_lrno"]}">
                <td>
                    <input type="checkbox" value="{$row["v_lrno"]}" class="excel-lr">
                </td>
                <td>{$row["v_lrno"]}<br>
                    <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")' class="generated-lr hide">{$row->cargo_code}</a>
                </td>
                <td>
                    <span class="badge badge-secondary lr-status">Yet To Import</span>&nbsp;
                    <i class="fa fa-info-circle lr-status-message hide" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
                </td>
                <td>{$row["v_booked_date"]}</td>
                <td>{$row["v_unloaded_date"]}</td>
                <td>
                    <label>Branch(excel) - {$row["v_from_station"]}</label>
                    <div>
                        <select class="form-control imported-from-station">
                            <option value="">Select From Branch</option>
                            {if isNotNull($row["ed_from_branch"])}
                                {foreach from=$row["ed_from_branch"] item=$val key=$k}
                                    <option selected value="{$val['code']}" data-station="{$val['station_code']}">{$val['name']}</option>
                                {/foreach}
                            {else}
                                {foreach from=$organization item=$org}
                                    <option value="{$org->code}" data-station="{$org->station->code}">{$org->name}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </td>
                <td>
                    <label>Branch(excel) - {$row["v_to_station"]}</label>
                    <div>
                        <select class="form-control imported-to-station">
                            <option value="">Select To Branch</option>
                            {if isNotNull($row["ed_to_branch"])}
                                {foreach from=$row["ed_to_branch"] item=$val key=$k}
                                    <option selected value="{$val['code']}" data-station="{$val['station_code']}">{$val['name']}</option>
                                {/foreach}
                            {else}
                                {foreach from=$organization item=$org}
                                    <option value="{$org->code}" data-station="{$org->station->code}">{$org->name}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </td>
                <td>{$row["v_sender_name"]}</td>
                <td>{$row["v_receiver_name"]}</td>
                <td>{$row["v_article_count"]}</td>
                <td>{$row["v_actual_weight"]}</td>
                <td>{$row["v_total_freight"]}</td>
                <td>{$row["v_payment_type"]}</td>
                <td>{$row["v_invoice_value"]}</td>
                {if $userHeader[14] !=="Remarks"}   
                    <td>{$row["v_door_pickup"]}</td>
                    <td>{$row["v_door_pickup_charges"]}</td>
                    <td>{$row["v_door_delivery"]}</td>
                    <td>{$row["v_door_delivery_charges"]}</td>
                    <td>{$row["v_loading_charges"]}</td>
                {/if}
                <td>{$row["v_articles"]}</td>
                <td>{$row["v_remarks"]}</td>
            </tr>
           
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/foreach}
    </tbody>
</table>

<script>
    var excelLrs = {$lrs|json_encode}
    $(document).ready(function() {
        $('.imported-from-station, .imported-to-station').select2();
        $('[data-toggle="tooltip"]').tooltip({
            placement: 'top',
            html: true,
            trigger: 'hover'
        });
        if ($('#excel-lr-table .excel-lr').length > 0) {
            var lrCodeArray = [];
            $('#excel-lr-table .excel-lr').each(function() {
                var code = $(this).val();
                if ($.inArray(code, lrCodeArray) == -1) {
                    lrCodeArray.push(code);
                } else {
                    $('.lr-code-'+code).find('.lr-status').addClass('badge-danger').text('Duplicate');
                    $('.lr-code-'+code).find('.lr-status-message').removeClass('hide')
                                                                .attr('title', code +' has duplicate LRs')
                                                                .tooltip('fixTitle');
                    $('.lr-code-'+code).find('select.imported-from-station, select.imported-to-station').prop('disabled', true);
                    $('.lr-code-'+code).find('.excel-lr').addClass('hide');
                }
            });
        }

        $('.checkall-excel-lr').on('change', function () {
            var $ele = $(this);
            $('.excel-lr:enabled').not('.hide')
                .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $ele.is(':checked'))
                .trigger('change');
        });
    });
</script>