<div class="brand_top">
    <h3>Door Pickup and Delivery Trip Chart</h3>
    <span class="align-right">
        <a href="#cargo/out-for-delivery?fill=1" class="btn btn-success  btn-sm"> <i class="fa fa-arrow-left"></i> Back</a>
    </span>
</div>

<div id="main-content">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div class="clear_fix_both"></div>
                <br />
                <div id="contents" class="col-lg-12">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <table width="100%">
                                    <tr>
                                        <td width="100%" colspan="2"><b>Trip Number:</b> {$ogpl->aliasCode}</td>
                                    </tr>
                                    <tr>
                                        <td width="60%"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>
                                        <td width="40%"><b>Vehicle :</b> {$ogpl->busVehicle->registationNumber}</td>
                                    </tr>
                                    <tr>
                                        <td width="60%"><b>Route:</b> {$ogpl->fromOrganization->name} to {$ogpl->toOrganization->name}</td>
                                        <td width="40%"><b>Driver :</b> {$ogpl->vehicleDriver->name}, {$ogpl->vehicleDriver->mobileNumber}</td>
                                    </tr>
                                    {if count($ogpl->transitReference)}
                                    <tr>
                                        <td width="60%" colspan="2">
                                            <b>Related Transit(s):</b>
                                            {foreach from=$ogpl->transitReference item=row}
                                                {if $row->cargoActivityType->code == 'TRNT'}
                                                    <a href="#cargo/ogpl-chart-details?transitCode={$row->code}" title="Related OGPL" target="_blank">{$row->name} ({$row->aliasCode})</a><br>
                                                {elseif $row->cargoActivityType->code == 'INTRNT'}
                                                    <a href="#cargo/local-transit-chart-details?transitCode={$row->code}" title="Related Local Transit" target="_blank">{$row->name} ({$row->aliasCode})</a><br>
                                                {elseif $row->cargoActivityType->code == 'OTFD'}
                                                    <a href="#cargo/out-for-delivery-chart-details?transitCode={$row->code}" title="Related Door pickup & Door Delivery" target="_blank">{$row->name} ({$row->aliasCode})</a><br>
                                                {/if}
                                            {/foreach}
                                        </td>
                                    </tr>
                                    {/if}
                                    {if $ogpl->remarks}
                                    <tr>
                                        <td width="60%" colspan="2"><b>Remarks:</b> {$ogpl->remarks}</td>
                                    </tr>
                                    {/if}
                                </table>

                                <br>
                                <h5><b>Door Delivery</b></h5>
                                <table id="dt_adv_booking_report_table" class="table table-bordered" >
                                    <thead>
                                        <tr class="info bold">
                                            <td align="center" rowspan="2">S.No</td>
                                            <td align="center" rowspan="2">{lang('lr')}</td>
                                            <td align="center" rowspan="2">Qty</td>
                                            <td align="center" rowspan="2">{lang('booking_sender_term')} Name</td>
                                            <td align="center" rowspan="2">{lang('booking_sender_term')} Mobile</td>
                                            <td align="center" rowspan="2">{lang('booking_receiver_term')} Name</td>
                                            <td align="center" rowspan="2">{lang('booking_receiver_term')} Mobile</td>
                                            <td align="center" rowspan="2">Payment Status</td>
                                            <td align="center" rowspan="2">To Pay</td>
                                            <td align="center" rowspan="2">Address</td>
                                            <td align="center" rowspan="2">Signature</td>
                                        </tr>
                                    </thead>
                                    <tbody class="body_table" >
                                        {assign var='o_qty' value=0}
                                        {assign var='sno' value=1}

                                        {assign var='o_freight_tot_amount' value=0}
                                        {assign var='o_handling_tot_amount' value=0}

                                        {assign var='o_pd_tot_amount' value=0}
                                        {assign var='o_pb_tot_amount' value=0}

                                        {foreach item=row1 from=$result key=t1 }
                                            {foreach item=row from=$row1 key=t }

                                                {assign var='o_qty' value=$o_qty + $row->total_item_count}

                                                <tr>
                                                    <td align="center">{$sno}</td>
                                                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                                                    <td align="center">{$row->total_item_count}</td>
                                                    <td align="left">{$row->from_customer_name}</td>
                                                    <td align="center">{$row->from_customer_mobile}</td>
                                                    <td align="left">{$row->to_customer_name}</td>
                                                    <td align="center">{$row->to_customer_mobile}</td>
                                                    <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                                                    <td align="right" >
                                                        {if $row->payment_status_code == 'TOP'}
                                                            {assign var="topay" value=($row->total_amount +$row->handling +$row->total_handling_amount +$row->total_unload_handling_amount +$row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax)-$row->total_amount_paid}
                                                            {$topay|number_format:2}
                                                            {assign var='o_pb_tot_amount' value=$topay+$o_pb_tot_amount}
                                                        {else}
                                                            0.00
                                                        {/if}
                                                    </td>
                                                    <td align="center"></td>
                                                    <td align="center"></td>
                                                </tr>
                                                {assign var='sno' value=$sno+1}
                                            {/foreach}
                                            <tr>
                                                <td align="center"></td>
                                                <td align="center"></td>
                                                <td align="center" class="bold">{$o_qty}</td>
                                                <td colspan="5">&nbsp;</td>
                                                <td align="right" class="bold">{$o_pb_tot_amount|number_format:2}</td>
                                                <td align="center"></td>
                                                <td align="center"></td>
                                            </tr>
                                        {foreachelse}
                                            <tr>
                                                <td align="center" colspan="16">Sorry! No cargo found</td>
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>

                                <h5><b>Door Pickup</b></h5>
                                <table id="dt_adv_booking_report_table" class="table table-bordered" >
                                    <thead>
                                        <tr class="info bold">
                                            <td align="center" rowspan="2">S.No</td>
                                            <td align="center" rowspan="2">{lang('lr')}</td>
                                            <td align="center" rowspan="2">Qty</td>
                                            <td align="center" rowspan="2">{lang('booking_sender_term')} Name</td>
                                            <td align="center" rowspan="2">{lang('booking_sender_term')} Mobile</td>
                                            <td align="center" rowspan="2">{lang('booking_receiver_term')} Name</td>
                                            <td align="center" rowspan="2">{lang('booking_receiver_term')} Mobile</td>
                                            <td align="center" rowspan="2">Payment Status</td>
                                            <td align="center" rowspan="2">To Pay</td>
                                            <td align="center" rowspan="2">Address</td>
                                            <td align="center" rowspan="2">Signature</td>
                                        </tr>
                                    </thead>
                                    <tbody class="body_table" >
                                        {assign var='o_qty' value=0}
                                        {assign var='sno' value=1}

                                        {assign var='o_freight_tot_amount' value=0}
                                        {assign var='o_handling_tot_amount' value=0}

                                        {assign var='o_pd_tot_amount' value=0}
                                        {assign var='o_pb_tot_amount' value=0}

                                        {foreach item=row1 from=$prebook key=t1 }
                                            {foreach item=row from=$row1 key=t }

                                                {assign var='o_qty' value=$o_qty + $row->total_item_count}

                                                <tr>
                                                    <td align="center">{$sno}</td>
                                                    <td align="center"><a href='javascript:;' title="more details" onclick='getPreBookingDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                                                    <td align="center">{$row->total_item_count}</td>
                                                    <td align="left">{$row->from_customer_name}</td>
                                                    <td align="center">{$row->from_customer_mobile}</td>
                                                    <td align="left">{$row->to_customer_name}</td>
                                                    <td align="center">{$row->to_customer_mobile}</td>
                                                    <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                                                    <td align="right" >
                                                        {if $row->payment_status_code == 'TOP'}
                                                            {assign var="topay" value=($row->total_amount +$row->handling +$row->total_handling_amount +$row->total_unload_handling_amount +$row->pickup_handling_amount + $row->delivery_handling_amount + $row->service_charge + $row->service_tax)-$row->total_amount_paid}
                                                            {$topay|number_format:2}
                                                            {assign var='o_pb_tot_amount' value=$topay+$o_pb_tot_amount}
                                                        {else}
                                                            0.00
                                                        {/if}
                                                    </td>
                                                    <td align="center"></td>
                                                    <td align="center"></td>
                                                </tr>
                                                {assign var='sno' value=$sno+1}
                                            {/foreach}
                                            <tr>
                                                <td align="center"></td>
                                                <td align="center"></td>
                                                <td align="center" class="bold">{$o_qty}</td>
                                                <td colspan="5">&nbsp;</td>
                                                <td align="right" class="bold">{$o_pb_tot_amount|number_format:2}</td>
                                                <td align="center"></td>
                                                <td align="center"></td>
                                            </tr>
                                        {foreachelse}
                                            <tr>
                                                <td align="center" colspan="16">Sorry! No cargo found</td>
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>

                                <div class="text-right">
                                    <div class="col-md-2 pull-right p_r_n">
                                        <div class="input-group">
                                            <select id="ofd-chart-print" class="form-control hide">
                                                <option value="" selected="">All Routes</option>
                                                {foreach item=row from=$result key=t1}
                                                    <option value="{$t1}">{$t1}</option>
                                                {/foreach}
                                            </select>
                                            <span class="input-group-btn">
                                                <button class="btn btn-success" type="button" onclick="print_out_for_del_chart('{$smarty.request.transitCode}')">Print</button>
                                            </span>
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
</div>

<script>
    function print_out_for_del_chart(code) {
        var route = encodeURIComponent($('#ofd-chart-print').val());
        var url = base_url + "cargo/out-for-delivery-chart-details-print?transitCode=" + code + "&route=" + route;
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }
</script>