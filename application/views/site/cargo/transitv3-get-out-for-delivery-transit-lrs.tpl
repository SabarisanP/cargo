<script type="text/html" id="out-for-delivery-lr-body">
    {assign var="total_lr" value=0}
    {assign var="total_art" value=0}
    {foreach from=$ofd_transit_load_lr item=row key=k}
        <tr id="{$k}-to-branch">
            <td>{$row['name']}</td>
            <td>{$row['article']} <span class="out-for-delivery-loaded-art text-muted text-small"></span></td>
            <td>{$row['lr']} <span class="out-for-delivery-loaded-lr text-muted text-small"></span></td>
        </tr>
        {assign var="total_lr" value=$total_lr+$row['lr']}
        {assign var="total_art" value=$total_art+$row['article']}
    {foreachelse}
        <tr>
            <td colspan="3" align="center">No Data Found!!</td>
        </tr>
    {/foreach}
    <tr class="active bold">
        <td>Total</td>
        <td>{$total_art} <span class="text-muted text-small" id="out-for-delivery-total-loaded-art" style="color: #fff;"></span></td>
        <td>{$total_lr} <span class="text-muted text-small" id="out-for-delivery-total-loaded-lr" style="color: #fff;"></span></td>
    </tr>
</script>

<div class="clearfix">&nbsp;</div>
<div id="outForDeliveryAlphabetOrder">
    {foreach from=$alphabet_letters item=row}
        <button onclick="scrollingOFD('{$row['alphabet']}', 'OFD');" data-letter="{$row['alphabet']}" class="box-button scroll-link">{$row['alphabet']}</button>
    {/foreach}
    <div class="pull-right">
        <a href="javascript:;" class="btn btn-success" onclick="loadOutForDeliveryTransitLr()"> Load</a>
        <a href="javascript:;" class="btn load-lr-btn" onclick="ClearOFDLoadLr()"> Clear</a>
        <a title="close" href="javascript:;" class="btn-lg" onclick="closeOutForDeliveryLrLoadDialog()"> <i class="fa fa-times-circle fa-lg"></i> </a>
    </div>
</div> 

<div id="out-for-delivery-load-lr-list">
    <div>
        <table id="new-lr-table" class="table table-bordered " style="width:99%">
            <thead>
                <tr class="success">
                    <td align="center">
                        <input type="checkbox" onchange="selectAllOutForDeliveryTransitLrs(this);" />
                    </td>
                    <td align="center" nowrap>{lang('lr')} No</td>
                    <td align="center" nowrap>Booked Date</td>
                    <td align="center" nowrap>Booked by</td>
                    <td align="center" nowrap>{lang('booking_from_term')}</td>
                    <td align="center" nowrap>{lang('booking_to_label')}</td>
                    <td align="center" nowrap>{lang('booking_sender_term')}</td>
                    <td align="center" nowrap>{lang('booking_receiver_term')}</td>
                    <td align="center" nowrap>Payment Status</td>
                    <td align="center" nowrap>Status</td>
                    <td align="center" nowrap>Items</td>
                    <td align="center" nowrap>Qty</td>
                    <td align="center" nowrap>Payable</td>
                </tr>
            </thead>

            <tbody class="body_table" id="out-for-delivery-ogpl-list">
                {assign var="cargo_additional" value=config_item('cargo_additional')}
                {assign var=load_branches value=array()}
                {assign var=load_station_branches value=array()}
                {assign var="rows" value=0}
                {foreach item=list from=$ofd_transit_load_lr}
                    <tr>
                        <td colspan="14" align="left" class="active OFD_leter_tr_{$list['name']|substr:0:1|ucfirst}"><input type="checkbox" onchange="selectBranchOutForDeliveryTransitLrs(this, '{$list['name']}');" /><span class="mr_l_1_em">{$list['name']}</span></td>
                    </tr>
                    {foreach item=row from=$list['data'] key=t}
                        {* {assign var="firstLetter" value=$row->to_station_name|substr:0:1} *}
                        {assign var="allowloadstatus" value=0}
                        {if in_array($row->load_type, ['FTL', 'PTL']) && $usr_station_code == $row->transit_station_code}
                            {assign var="allowloadstatus" value=1}
                        {elseif $row->cargo_status_code == 'CB' && $usr_org_code != $row->transit_organization_code}
                            {assign var="allowloadstatus" value=3}
                        {elseif $row->cargo_status_code == 'CL' && $usr_org_code == $row->transit_organization_code}
                            {assign var="allowloadstatus" value=2}
                        {elseif !in_array($row->load_type, ['RGL']) && $usr_org_code == $row->transit_organization_code}
                            {assign var="allowloadstatus" value=1}
                        {/if}
                        <tr class="{if $allowloadstatus == 1}bg-success{elseif $allowloadstatus == 2}bg-warning{elseif $allowloadstatus == 3}bg-danger{/if}">
                            <td align="center">
                                <input type="checkbox" class="ogpl-new-outfordelivery-items" data-listname="{$list['name']}" data-tobranch="{$row->to_organization_code}" data-from="{$row->from_station_code}" data-to="{$row->to_station_code}" data-toname="{$row->to_station_name}" data-oldtransitorg="{$row->transit_organization_code}" data-oldtransitstn="{$row->transit_station_code}" value="{$row->cargo_code}" onclick=""/>
                            </td>
                            <td align="center">
                                <a href='javascript:;' {if $allowloadstatus == 2}class="badge badge-warning text-white"{elseif $allowloadstatus == 3}class="badge badge-danger text-white"{/if} title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>
                                <br>
                                {if $row->additional_status_code !== 'null'}
                                    {assign var="asc_ar" value=explode(',', $row->additional_status_code)}
                                    {foreach from=$asc_ar item=code}
                                        {if $code == "EXPDL"}  
                                            <span class="ind ind-{$cargo_additional['EXPDL']['color']}" title="{$cargo_additional['EXPDL']['name']}">{$cargo_additional['EXPDL']['code']}</span>
                                        {/if}
                                        {if $code == "HDLWC"}
                                            <span class="ind ind-{$cargo_additional['HDLWC']['color']}" title="{$cargo_additional['HDLWC']['name']}">{$cargo_additional['HDLWC']['code']}</span>
                                        {/if}
                                    {/foreach}
                                {/if}
                            </td>
                            <td align="left" nowrap>{$row->booked_at|date_format:'d, M y g:i A'}</td>
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
                            {$rows = $rows + 1}
                            
                            {foreach item=branch from=$branches}
                                {if $branch->station->code == {$row->to_station_code}}
                                    {$load_branches[$branch->code] = $branch->name}
                                {/if}
                            {/foreach}
                        </tr>
                    {/foreach}
                {/foreach}
                {if $rows == 0}
                    <tr>
                        <td colspan="14" align="center">No Results Found!</td>
                    </tr>
                {/if}
            </tbody>
        </table>
        <div class="col-md-3 pull-right hide">
            <select id="out-for-delivery-branch" class="form-control load-branch">
                <option value="">Select Branch</option>
                {foreach item=branch key=code from=$load_branches}
                    <option value="{$code}">{$branch}</option>
                {/foreach}
            </select>
        </div>
    </div>
</div>