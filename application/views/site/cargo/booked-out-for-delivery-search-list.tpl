<h5><b>Transactions</b></h5>
<table id="new-lr-table" class="table table-bordered " style="width:99%" >
    <thead>
        <tr class="success">
            <td align="center">
                <input type="checkbox" onchange="selectAllBooking(this);"/>
            </td>
            <td align="center">{lang('lr')} No</td>
            <td align="center">Booked Date</td>
            <td align="center">Booked by</td>
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">{lang('booking_sender_term')}</td>
            <td align="center">{lang('booking_receiver_term')}</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Items</td>
            <td align="center">Qty</td>
            <td align="center">Payable</td>
        </tr>
    </thead>

    <tbody class="body_table" id="load-ogpl-list">

        {assign var=load_branches value=array()}
        {foreach item=row from=$result key=t}
            <tr>
                <td align="center">
                    <input type="checkbox" class="ogpl-new-items" data-loadtype="{$row->load_type}" data-transitstation="{$row->transit_station_code}" data-transitbranch="{$row->transit_organization_code}" data-from="{$row->from_station_code}" data-to="{$row->to_station_code}" value="{$row->cargo_code}" />
                </td>
                <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->user_first_name}</td>
                <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                <td align="center">
                    {$row->payment_status_code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="left">{$row->cargo_item_name}</td>
                <td align="center">{$row->total_item_count}</td>
                <td align="right">{($row->total_booking_amount+$row->total_unload_handling_amount+$row->total_handing_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)|number_format:2}</td>

                {foreach item=branch from=$branches}
                    {if $branch->station->code == {$row->to_station_code}}
                        {$load_branches[$branch->code] = $branch->name}
                    {/if}
                {/foreach}
            </tr>
        {/foreach}

    </tbody>
</table>

<h5><b>Prebooking</b></h5>
<table id="prebook-lr-table" class="table table-bordered " style="width:99%" >
    <thead>
        <tr class="success">
            <td align="center">
                <input type="checkbox" onchange="selectAllPreBooking(this);"/>
            </td>
            <td align="center">{lang('lr')} No</td>
            <td align="center">Booked Date</td>
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">{lang('booking_sender_term')}</td>
            <td align="center">{lang('booking_receiver_term')}</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Items</td>
            <td align="center">Qty</td>
            <td align="center">Payable</td>
        </tr>
    </thead>

    <tbody class="body_table" id="prebook-ogpl-list">

        {* {assign var=load_branches value=array()} *}
        {foreach item=row from=$prebook key=t}
            <tr>
                <td align="center">
                    <input type="checkbox" class="prebook-ogpl-items" data-from="{$row->fromStation->code}" data-to="{$row->toStation->code}" value="{$row->code}" />
                </td>
                <td align="center"><a href='javascript:;' title="more details" onclick='getPreBookingDetails("{$row->code}")'>{$row->code}</a></td>
                <td align="left" nowrap>{$row->bookedAt|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->fromOrganization->name} - {$row->fromOrganization->station->name}</td>
                <td align="left">{$row->toOrganization->name} - {$row->toOrganization->station->name}</td>
                <td align="left">{$row->fromCustomer->name} - {$row->fromCustomer->mobileNumber}</td>
                <td align="left">{$row->toCustomer->name} - {$row->toCustomer->mobileNumber}</td>
                <td align="center">
                    {$row->paymentType->code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$row->status->name}</td>
                <td align="left">
                    {assign var=$itemNames value=[]}
                    {assign var=$itemQty value=0}
                    {foreach from=$row->itemDetails item=item}
                        {$itemNames[] = $item->cargoItem->name}
                        {$itemQty = $itemQty + $item->itemCount}
                    {/foreach}
                    {$itemNames|implode:', '}
                </td>
                <td align="center">{$itemQty}</td>
                <td align="right">{($row->totalAmount+$row->totalUnloadHandlingAmount+$row->totalHandlingAmount+$row->deliveryHandlingAmount+$row->pickupHandlingAmount)|number_format:2}</td>

                {foreach item=branch from=$branches}
                    {if $branch->station->code == $row->toOrganization->station->code}
                        {$load_branches[$branch->code] = $branch->name}
                    {/if}
                {/foreach}
            </tr>
        {/foreach}

    </tbody>
</table>

<div class="clearfix_both"></div><br/>
<div class="row">
    <div class="col-md-12 text-right">
        <div class="col-md-8 pull-right">
            <div class="alert pull-right" id="load-ogpl-action-state" style="display: none"></div>
        </div>
        <div class="col-md-8 pull-right text-right">
            {if isset($odoDetails) && $odoDetails->startOdometer == 0}
                <button class="btn btn-warning" id="start-odometer-btn" type="button" onclick="showStartTripDialog();">Start Trip</button>&nbsp;
            {/if}
            <button class="btn btn-success pull-right" type="button" onclick="loadOGPL();">Load</button>
            <div class="col-md-3 pull-right hide">
                <select id="load-branch-sel" class="form-control load-branch">
                    <option value="">Select Branch</option>
                    {foreach item=branch key=code from=$load_branches}
                        <option value="{$code}">{$branch}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-md-2 pull-right hide">
                <label><input type="checkbox" id="ogpl-load-hub"/>&nbsp; Load to Hub</label>
            </div>
        </div>
    </div>
</div>