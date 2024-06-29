<table class="table table-bordered table-hover" id="tariff-table">
    <thead>
        <tr>
            <th width="8%">From Station</th>
            <th width="8%">To Station</th>
            <th width="8%">From Branch</th>
            <th width="8%">To Branch</th>
            <th width="8%">Article</th>
            <th width="8%">{lang('booking_UOM_label')}</th>
            <th width="5%">Rate</th>
            <th width="5%">Min.Unit</th>
            <th width="7%">To Vendor</th>
            <th>Loading Ch</th>
            <th>Hamali Ch</th>
            <th>Docket Ch</th>
            <th>Door Pickup Ch</th>
            <th>Door Delivery Ch</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$mtch_tariff item=row key=key}
            <tr>
                {* Station *}
                {if $row->routeType->code == 'RTE'}
                    <td>
                        <a id="popup_msg" data-content='<ul class="p_l_15">
                            {foreach from=$row->fromStationList item=val}
                                <li>{$val->name|replace:"'":'"'}</li>
                            {/foreach}
                            </ul>'>
                            {if $row->fromStationList}
                                {foreach from=$row->fromStationList item=val}
                                    {$val->name}
                                    {break}
                                {/foreach}
                                {if ($row->fromStationList|@count) > 1}
                                    <span class="badge badge-info">{$row->fromStationList|@count}</span>
                                {/if}
                            {else}
                                All Station
                            {/if}
                        </a>
                    </td>
                    <td>
                        <a id="popup_msg" data-content='<ul class="p_l_15">
                            {foreach from=$row->toStationList item=val}
                                <li>{$val->name|replace:"'":'"'}</li>
                            {/foreach}
                            </ul>'>
                            {if $row->toStationList}
                                {foreach from=$row->toStationList item=val}
                                    {$val->name}
                                    {break}
                                {/foreach}
                                {if ($row->toStationList|@count) > 1}
                                    <span class="badge badge-info">{$row->toStationList|@count}</span>
                                {/if}
                            {else}
                                All Station
                            {/if}
                        </a>
                    </td>
                {else}
                    <td>-</td>
                    <td>-</td>
                {/if}

                {* Branch *}
                {if $row->routeType->code == 'BRTE'}
                    <td>
                        <a id="popup_msg" data-content='<ul class="p_l_15">
                            {foreach from=$row->fromOrganizationList item=val}
                                <li>{$val->name|replace:"'":'"'}</li>
                            {/foreach}
                            </ul>'>
                            {if $row->fromOrganizationList}
                                {foreach from=$row->fromOrganizationList item=val}
                                    {$val->name}
                                    {break}
                                {/foreach}
                                {if ($row->fromOrganizationList|@count) > 1}
                                    <span class="badge badge-info">{$row->fromOrganizationList|@count}</span>
                                {/if}
                            {else}
                                All Branch
                            {/if}
                        </a>
                    </td>
                    <td>
                        <a id="popup_msg" data-content='<ul class="p_l_15">
                            {foreach from=$row->toOrganizationList item=val}
                                <li>{$val->name|replace:"'":'"'}</li>
                            {/foreach}
                            </ul>'>
                            {if $row->toOrganizationList}
                                {foreach from=$row->toOrganizationList item=val}
                                    {$val->name}
                                    {break}
                                {/foreach}
                                {if ($row->toOrganizationList|@count) > 1}
                                    <span class="badge badge-info">{$row->toOrganizationList|@count}</span>
                                {/if}
                            {else}
                                All Branch
                            {/if}
                        </a>
                    </td>
                {else}
                    <td>-</td>
                    <td>-</td>
                {/if}

                <td>
                    <a id="popup_msg" data-content='<ul class="p_l_15">
                        {foreach from=$row->itemDetailList item=val}
                            {if $val->cargoItem->code == 'ALL'}
                                <li>All Articles</li>
                            {else}
                                <li>{$val->cargoItem->name|replace:"'":'"'} - {$cnt = $val->cargoItem->description|@count}
                                {foreach from=$val->cargoItem->description item=desc key=k}{$desc}{if $k< $cnt-1},{/if}{/foreach}</li>
                            {/if}
                        {/foreach}
                        </ul>'>
                        {foreach from=$row->itemDetailList item=val}
                            {if $val->cargoItem->code == 'ALL'}
                                All Articles
                            {else}
                                {$val->cargoItem->name}
                            {/if}
                            {break}
                        {/foreach}
                        {if ($row->itemDetailList|@count) > 1}
                            <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                        {/if}
                    </a>
                </td>

                <td>
                    <a id="popup_msg" data-content='<ul class="p_l_15">
                        {foreach from=$row->itemDetailList item=val}
                        <li>{$val->unit->name|replace:"'":'"'} - {if $val->cargoItem->code == 'ALL'}All Articles{else}{$val->cargoItem->name}{/if}</li>
                        {/foreach}
                        </ul>'>
                        {foreach from=$row->itemDetailList item=val}
                            {$val->unit->name}
                            {break}
                        {/foreach}
                        {if ($row->itemDetailList|@count) > 1}
                            <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                        {/if}
                    </a>
                </td>

                <td>
                    <a id="popup_msg" data-content='<ul class="p_l_15">
                        {foreach from=$row->itemDetailList item=val}
                        <li>{if $val->cargoItem->code == 'ALL'}All Articles{else}{$val->cargoItem->name|replace:"'":'"'}{/if} - {$val->amount}</li>
                        {/foreach}
                        </ul>'>
                        {foreach from=$row->itemDetailList item=val}
                            {$val->amount}
                            {break}
                        {/foreach}
                        {if ($row->itemDetailList|@count) > 1}
                            <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                        {/if}
                    </a>
                </td>

                <td>
                    <a id="popup_msg" data-content='<ul class="p_l_15">
                        {foreach from=$row->itemDetailList item=val}
                        <li>{if $val->cargoItem->code == 'ALL'}All Articles{else}{$val->cargoItem->name|replace:"'":'"'}{/if} - {$val->minUnitValue}</li>
                        {/foreach}
                        </ul>'>
                        {foreach from=$row->itemDetailList item=val}
                            {$val->minUnitValue}
                            {break}
                        {/foreach}
                        {if ($row->itemDetailList|@count) > 1}
                            <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                        {/if}
                    </a>
                </td>

                <td>
                    <a id="popup_msg" data-content='<ul class="p_l_15">
                        {foreach from=$row->toVendorList item=val}
                            <li>{$val->companyName|replace:"'":'"'}</li>
                        {/foreach}
                        </ul>'>
                        {if $row->toVendorList}
                            {foreach from=$row->toVendorList item=val}
                                {$val->companyName}
                                {break}
                            {/foreach}
                            {if ($row->toVendorList|@count) > 1}
                                <span class="badge badge-info">{$row->toVendorList|@count}</span>
                            {/if}
                        {else}
                            All Vendor
                        {/if}
                    </a>
                </td>

                <td>
                    {assign var="itemLoadingCharge" value=0}
                    <a id="popup_msg" data-content='<ul class="p_l_15">
                        {foreach from=$row->itemDetailList item=val}
                            {assign var="itemLoadingCharge" value=$itemLoadingCharge + $val->loadingCharge}
                            <li>{if $val->cargoItem->code == 'ALL'}All Articles{else}{$val->cargoItem->name|replace:"'":'"'}{/if} - {$val->loadingCharge|inr_format:2}</li>
                        {/foreach}
                        </ul>'>
                        {$itemLoadingCharge|inr_format:2}
                        {if $itemLoadingCharge > 0 && ($row->itemDetailList|@count) > 1}
                            <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                        {/if}
                    </a>
                </td>

                <td align="right">{$row->hamaliCharge|inr_format:2}</td>
                <td align="right">{$row->docketCharge|inr_format:2}</td>
                <td align="right">{$row->doorPickupCharge|inr_format:2}</td>
                <td align="right">{$row->doorDeliveryCharge|inr_format:2}</td>
                
                <td nowrap>
                    <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick='cargoTariffDialog("{$row->code}")'><i class="fa fa-pencil igreen"></i></a>
                    <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick='deleteTariff("{$row->code}")'><i class="fa fa-trash-o ired"></i></a>
                </td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="13" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
</table>

<script>
    var vendorTariffData = {$mtch_tariff|json_encode};
</script>