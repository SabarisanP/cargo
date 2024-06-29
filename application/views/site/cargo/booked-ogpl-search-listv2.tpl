<div class="row">
    <div class="col-md-6">
        <h5><b>Transactions</b></h5>
    </div>
    <div class="col-md-6 text-right">
        <div class="btn-group btn-group-sm">
            {if in_array($namespaceCode, ["citycargo","cityparcel"])}
                <button class="btn btn-default" onclick="printDmLoadingSheet();"><i class="fa fa-print fa-lg"></i> DM print</button>&emsp;
            {/if}
            <button class="btn btn-default" onclick="printLoadingSheet();"><i class="fa fa-print fa-lg"></i> {lang('loading_sheet')}</button>&emsp;
        </div>
    </div>
</div>

<table id="new-lr-table" class="table table-bordered " style="width:99%">
    <thead>
        <tr class="success">
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
        {assign var="Tolrcount" value=0}
        {assign var="TopayableAmt" value=0}
        {assign var=load_branches value=array()}
        {foreach item=branch from=$branches}
            {foreach item=via from=$ogpl_via}
                {if $branch->organization->station->code == $via['code']}
                    {$load_branches[$branch->organization->code] = $branch->organization->name}
                {/if}
            {/foreach}
        {/foreach}

        {assign var="rows" value=0}

        {foreach item=list from=$result key=toorganization}
            {assign var="orglrcount" value=0}
            {assign var="sublrcount" value=0}
            {assign var="subpayableAmt" value=0}
            {foreach item=row from=$list key=t}
                {assign var="sublrcount" value=$sublrcount+$row->total_item_count}
                {assign var="subpayableAmt" value=$subpayableAmt+($row->total_booking_amount+$row->total_unload_handling_amount+$row->total_handing_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)}

                {assign var="Tolrcount" value=$Tolrcount+$row->total_item_count}
                {assign var="TopayableAmt" value=$TopayableAmt+($row->total_booking_amount+$row->total_unload_handling_amount+$row->total_handing_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)}

                {assign var="allowloadstatus" value=0}

                {if $row->cargo_status_code == 'CB' && $usr_org_code != $row->transit_organization_code}
                    {assign var="allowloadstatus" value=3}
                {elseif $row->cargo_status_code == 'CL' && $usr_org_code == $row->transit_organization_code}
                    {assign var="allowloadstatus" value=2}
                {elseif $usr_org_code == $row->transit_organization_code}
                    {assign var="allowloadstatus" value=1}
                {/if}

                {if $orglrcount == 0}
                    <tr>
                        <td colspan="12" align="center" class="active">{$toorganization}</td>
                    </tr>
                {/if}

                <tr class="{if $allowloadstatus == 1 || $action_rights['OGPL-HUB-LOAD'] == 1}bg-success{elseif $allowloadstatus == 2}bg-warning{elseif $allowloadstatus == 3}bg-danger{/if}">
                    <td align="center" nowrap>
                        <a href='javascript:;' {if $allowloadstatus == 2}class="badge badge-warning text-white" {elseif $allowloadstatus == 3}class="badge badge-danger text-white" {/if} title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>
                        {if in_array($namespace , ["citycargo","cityparcel"])}
                            <br>
                            {if isNotNull($row->eway_bill_no)}
                                <img src="{$base_url}assets/img/icons/eway.svg" width="30px" loading="lazy">
                            {/if}
                            {if isNotNull($row->invoice_number)}
                                <img src="{$base_url}assets/img/icons/invoice.svg" width="30px" loading="lazy">
                            {/if}
                        {/if}
                    </td>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                    <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                    <td align="left">{$row->from_customer_name}<br />{$row->from_customer_mobile}</td>
                    <td align="left">{$row->to_customer_name}<br />{$row->to_customer_mobile}</td>
                    <td align="center">
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="left">{$row->cargo_item_name}</td>
                    <td align="center">{$row->total_item_count}</td>
                    <td align="right">{($row->total_booking_amount+$row->total_unload_handling_amount+$row->total_handing_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax)|number_format:2}</td>

                    {*foreach item=branch from=$branches}
                        {if $branch->organization->station->code == {$row->to_station_code}}
                            {$load_branches[$branch->organization->code] = $branch->organization->name}
                        {/if}
                    {/foreach *}

                    {$rows = $rows + 1}
                    {$orglrcount = $orglrcount + 1}
                </tr>
            {/foreach}

            <tr>
                <td colspan="10" align="right" class="active">Sub Total</td>
                <td class="active" align="center">{$sublrcount}</td>
                <td class="active" align="right">{$subpayableAmt|number_format:2}</td>
            </tr>

        {/foreach}
        {if $rows > 0}
            <tr>
                <td colspan="10" align="right" class="active">Total</td>
                <td class="active" align="center">{$Tolrcount}</td>
                <td class="active" align="right">{$TopayableAmt|number_format:2}</td>
            </tr>
        {/if}
        {if $rows == 0}
            <tr>
                <td colspan="12" align="center">No Results Found!</td>
            </tr>
        {/if}

    </tbody>
</table>
