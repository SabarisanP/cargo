<table class="table table-bordered" width="98%" id="delivery-ack-lr-table">
    <thead>
        <tr class="success">
            <td align="center" class="sticky-row-top"></td>
            <td align="center" class="sticky-row-top">{lang('cargo_code_term')}</td>
            <td align="center" class="sticky-row-top">Booked Date</td>
            <td align="center" class="sticky-row-top">{lang('booking_from_term')}</td>
            <td align="center" class="sticky-row-top">{lang('booking_to_label')}</td>
            {* <td align="center" class="sticky-row-top">Transit Branch</td> *}
            <td align="center" class="sticky-row-top">Payment Status</td>
            <td align="center" class="sticky-row-top">Cargo Status</td>
            {* <td align="center" class="sticky-row-top">No. Of Articles</td>
            <td align="center" class="sticky-row-top">Qty</td> *}
            <td align="center" class="sticky-row-top">Net Amount</td>
            {* <td align="center" class="sticky-row-top">Paid Amount</td> *}
            {* <td align="center" class="sticky-row-top">Balance Amount</td> *}
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$result key=key}
            {$addon_amount = 0}
            {foreach from=$row->cargoAddonsDetails item=val}
                {if !in_array($val->addonsType->code, ['EWBL', 'UNDL', 'MSNG', 'DLRMD', 'FRECR'])}
                {$addon_amount = $addon_amount + $val->value}
                {/if}
            {/foreach}
            <tr>
                <td align="center">
                    <input type="checkbox" class="lr-check" value="{$row->code}">
                </td>
                <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->code}")'>{$row->code}</a></td>
                <td align="left" nowrap>{$row->bookedAt|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->fromOrganization->name}</td>
                <td align="left">{$row->toOrganization->name}</td>
                {* <td align="left">{($row->transit_organization_name)? $row->transit_organization_name : '-'}</td> *}
                <td align="left">
                    {$row->paymentType->code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$row->cargoStatus->name}</td>
                {* <td align="right">{$row->item_count}</td>
                <td align="right">{$row->total_item_count}</td> *}
                {* {assign var="netamount" value=$row->totalAmount+$row->totalHandlingAmount+$row->totalUnloadHandlingAmount+$row->pickupHandlingAmount+$row->deliveryHandlingAmount+$row->serviceCharge+$row->serviceTax+$row->hamaliCharge+$row->passCharge+$row->docketCharge + $addons_mapped['PODCH']->value+ $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value} *}
                {assign var="netamount" value=$row->totalAmount+$row->totalHandlingAmount+$row->totalUnloadHandlingAmount+$row->pickupHandlingAmount+$row->deliveryHandlingAmount+$row->serviceCharge+$row->serviceTax+$row->hamaliCharge+$row->passCharge+$row->docketCharge+$addon_amount}
                <td align="right">{$netamount|inr_format}</td>
                {* <td align="right">{($row->paymentAmount)|inr_format}</td> *}
                {* <td align="right">{($row->totalAmount+$row->other_charges-$row->paymentAmount)|inr_format}</td> *}
            </tr>
        {foreachelse}
            <tr class="active">
                <td align="center" colspan="8">No data found !!!</td>
            </tr>
        {/foreach}
    </tbody>
</table>