<script type="text/html" id="link-load-lr-body">
    {assign var="total_lr" value=0}
    {assign var="total_art" value=0}
    {foreach from=$link_load_lr item=row key=k}
        <tr id="{$k}-to-branch">
            <td>{$row['name']}</td>
            <td>{$row['article']} <span class="link-loaded-art text-muted text-small"></span></td>
            <td>{$row['lr']} <span class="link-loaded-lr text-muted text-small"></span></td>
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
        <td>{$total_art} <span class="text-muted text-small" id="link-total-loaded-art" style="color: #fff;"></span></td>
        <td>{$total_lr} <span class="text-muted text-small" id="link-total-loaded-lr" style="color: #fff;"></span></td>
    </tr>
</script>

<div class="clearfix">&nbsp;</div>
<div id="linkAlphabetOrder">
    {foreach from=$alphabet_letters item=row}
        <button onclick="scrollingLink('{$row['alphabet']}', 'HULD');" data-letter="{$row['alphabet']}" class="box-button scroll-link">{$row['alphabet']}</button>
    {/foreach}
  
    <div class="pull-right d-flex"> 
        <div class="getLrs d-flex" style="margin-right:20px;">
            <label class="link-get-error text-danger"></label>
            <input type="text" class="form-control link-ogpl-load-cargocode" name="cargoCode" placeholder="Cargo Code" value="" style="text-transform:uppercase">     
            <button onclick="getCargoRow('link','{$body['queryCode']}','{$body['fromDate']}','{$body['toDate']}','{$body['fromStationCode']}','{$body['toStationCode']}','{$body['viaStationCodes']}','{$body['transitOrganizationCode']}','{$body['transitTypeCode']}')" class="btn btn-success get-lr-btn">Get LR</button>
        </div>
        <div>
            <a href="javascript:;" class="btn btn-success" onclick="loadLinkLoadLr()"> Load</a>
            <a href="javascript:;" class="btn load-lr-btn" onclick="ClearLinkLoadLr()"> Clear</a>
            <a title="close" href="javascript:;" class="btn-lg" onclick="closeLinkLoadLrLoadDialog()"> <i class="fa fa-times-circle fa-lg"></i> </a>
        </div>
    </div>
</div>

<div id="link-load-load-lr-list">
    <div>
        <table id="new-lr-table" class="table table-bordered " style="width:99%">
            <thead>
                <tr class="success">
                    <td align="center">
                        <input type="checkbox" onchange="selectAllLinkLoadLrs(this);" />
                    </td>
                    <td align="center" nowrap>{lang('lr')} No</td>
                    <td align="center" nowrap>Booked Date</td>
                    <td align="center" nowrap>Booked by</td>
                    <td align="center" nowrap>{lang('booking_from_term')}</td>
                    <td align="center" nowrap>{lang('booking_to_label')}</td>
                    <td align="center" nowrap>
                        Transit To Branch &nbsp;
                        <a class="badge badge-success" href="javascript:;" title="Fill first selected branch to all LR" onclick="setAllLinkLoadTransitBranch()"><i class="fa fa-files-o" aria-hidden="true"></i></a>
                    </td>
                    <td align="center" nowrap>{lang('booking_sender_term')}</td>
                    <td align="center" nowrap>{lang('booking_receiver_term')}</td>
                    <td align="center" nowrap>Payment Status</td>
                    <td align="center" nowrap>Status</td>
                    <td align="center" nowrap>Items</td>
                    <td align="center" nowrap>Qty</td>
                    <td align="center" nowrap>Payable</td>
                </tr>
            </thead>

            <tbody class="body_table" id="link-load-ogpl-list">
                {assign var="cargo_additional" value=config_item('cargo_additional')}
                {assign var=load_branches value=array()}
                {assign var=load_station_branches value=array()}
                {foreach item=branch from=$branches}
                    {foreach item=via from=$ogpl_via}
                        {if $branch->station->code == $via['code']}
                            {$load_branches[$branch->code] = $branch}
                            {$load_station_branches[$branch->station->code][$branch->code] = $branch}                    
                        {/if}
                    {/foreach}
                {/foreach}

                {assign var="branchCount" value=0}
                {assign var=tload_branches value=$load_branches}

                {assign var="rows" value=0}
                {foreach item=list from=$link_load_lr}
                    <tr>
                        <td colspan="14" align="left" class="active HULD_leter_tr_{$list['name']|substr:0:1|ucfirst}">
                            <div class="d-flex align-items-center">
                                <input type="checkbox" onchange="selectBranchLinkLoadTransitLrs(this, '{$list['name']}');checkHandleLink();" />
                                <span class="mr_l_1_em">{$list['name']}</span>
                                <select class="form-control linkBranchSelect1" data-list-name="{$list['name']}" style="max-width: 150px; margin:5px;">
                                    {if $tload_branches|count>0}
                                        <option value="">Select a branch</option>
                                    {/if}
                                    {foreach item=branch from=$tload_branches}
                                        <option value="{$branch->code}" data-station="{$branch->station->code}" {if $branchCount == 1}selected{/if}>{$branch->name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </td>
                    </tr>
                    {foreach item=row from=$list['data'] key=t}
                        {assign var="allowloadstatus" value=0}
                        {if in_array($row->load_type, ['FTL', 'PTL']) && $usr_station_code == $row->transit_station_code}
                            {assign var="allowloadstatus" value=1}
                        {elseif $row->cargo_status_code == 'CB' && $usr_org_code != $row->transit_organization_code}
                            {assign var="allowloadstatus" value=3}
                        {elseif $row->cargo_status_code == 'CL' && $usr_org_code == $row->transit_organization_code}
                            {assign var="allowloadstatus" value=2}
                        {elseif $usr_org_code == $row->transit_organization_code}
                            {assign var="allowloadstatus" value=1}
                        {/if}
                        {if $reporting_branch != null}
                            {if in_array($row->transit_organization_code,$reporting_branch)}
                                {assign var="allowloadstatus" value=1}
                            {/if}    
                        {/if}
                        <tr class="{if $allowloadstatus == 1}bg-success{elseif $allowloadstatus == 2}bg-warning{elseif $allowloadstatus == 3}bg-danger{/if}">
                            <td align="center">
                                {if $allowloadstatus == 1}
                                    <input type="checkbox" onclick="checkHandleLink();" class="ogpl-new-linkload-items" data-listname="{$list['name']}" data-tobranch="{$row->to_organization_code}" data-from="{$row->from_station_code}" data-to="{$row->to_station_code}" data-oldtransitorg="{$row->transit_organization_code}"  data-oldtransitstn="{$row->transit_station_code}" value="{$row->cargo_code}" />
                                {/if}
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
                            <td align="left">
                                {if $load_station_branches[$row->to_station_code]|count>0}
                                    {assign var=tload_branches value=$load_station_branches[$row->to_station_code]} 
                                {/if}
                                {assign var="branchCount" value = $tload_branches|count}
                                {if $allowloadstatus == 1}
                                    <select class="link-load-branch-sel form-control link-load-branch linkBranchSelect2" data-list-name="{$list['name']}">
                                        {if $tload_branches|count>0}
                                            <option value="">Select a branch</option>
                                        {/if}

                                        {foreach item=branch from=$tload_branches}
                                            <option value="{$branch->code}" data-fromstationname={$row->from_station_name} data-tostationname={$row->to_station_name} data-station="{$branch->station->code}" {if $branchCount==1}selected{/if}>{$branch->name}</option>
                                        {/foreach}
                                    </select>
                                {/if}
                            </td>
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
                        </tr>
                        {* LR-Split Section start *}
                        {if $action_rights['LR-SPLTUP']==1 && $cargo_setting->cargoPartitionFlag == 1} {* permision *}
                            {* loop this content Start*}
                            {assign var="artical" value=explode('|',$row->item_details)}
                            {if $row->cargo_type=="PBO"}
                                {assign var="artical_items" value=explode('|',$row->item_portion_details)}
                            {/if}
                                <tr class="splt-row row-{$row->cargo_code} row-link-{$row->cargo_code}">
                                    <td colspan="14">
                                        <div class="well well-sm custom-well" id="cargo-{$row->cargo_code}"> 
                                            <div class="custom-checkbox-group d-flex">
                                                {foreach from=$artical key=key item=art}
                                                    {assign var="carg_items" value=explode(',',$art) }
                                                    {assign var="art_id" value=$carg_items[0]}
                                                    {assign var="art_inside" value=explode('-',$carg_items[1]) }
                                                    {assign var="art_name" value=$art_inside[0]}
                                                    {assign var="art_qty" value=$art_inside[1]}
                                                
                                                    {if count($artical) ==1 && $art_qty==1}
                                                        <span class="text-muted">Application cannot be split due to single article and product in this LR.</span>
                                                    {else}
                                                
                                                        <div class="d-flex wrapDist artical-group artical{$art_id}">
                                                            <div class="d-flex wrapDist"> 
                                                            {if $row->cargo_type=="PBO"}
                                                                {assign var="partials" value=$artical_items}
                                                                {assign var="partial_items" value=$artical_items[$key]}
                                                                {assign var="each_items" value=explode(',',$partial_items)}
                                                                {foreach from=$each_items item=box key=key}
                                                                    <div class="custom-checkbox link-{$row->cargo_code}"> 
                                                                        <input type="checkbox" onclick="checkAllValidation({$row->total_item_count},'{$row->cargo_code}','link');" id="checkbox{$art_id}_{$box}-link" value="{$box}" data-value="{$art_id}" data-artname="{$art_name}" data-artqty="{$art_qty}" data-total="{$art_qty}" data-cargoid="{$row->cargo_code}" class="custom-control-input linkload" data-tobranch="{$row->to_organization_code}" data-from="{$row->from_station_code}" data-to="{$row->to_station_code}" data-oldtransitorg="{$row->transit_organization_code}" data-oldtransitstn="{$row->transit_station_code}">
                                                                        <label class="custom-control-label" for="checkbox{$art_id}_{$box}-link"> {$box}</label>
                                                                    </div>
                                                                {/foreach}
                                                            {else}
                                                                {for $box=1 to $art_qty}
                                                                    <div class="custom-checkbox link-{$row->cargo_code}"> 
                                                                        <input type="checkbox" onclick="checkAllValidation({$row->total_item_count},'{$row->cargo_code}','link');" id="checkbox{$art_id}_{$box}-link" value="{$box}" data-value="{$art_id}" data-artname="{$art_name}" data-artqty="{$art_qty}" data-total="{$art_qty}" data-cargoid="{$row->cargo_code}" class="custom-control-input linkload" data-tobranch="{$row->to_organization_code}" data-from="{$row->from_station_code}" data-to="{$row->to_station_code}" data-oldtransitorg="{$row->transit_organization_code}" data-oldtransitstn="{$row->transit_station_code}">
                                                                        <label class="custom-control-label" for="checkbox{$art_id}_{$box}-link"> {$box}</label>
                                                                    </div>
                                                                {/for}
                                                            {/if}
                                                        
                                                                </div>
                                                                <div class="text-center bg-light artical-container">
                                                                {$art_name}
                                                                </div>
                                                        </div>
                                                    {/if}
                                                
                                                {/foreach}
                                            </div>  
                                        </div>
                                    </td>
                                </tr>
                        {/if}
                        {*LR-Split Section end *}
                    {/foreach}
                {/foreach}
                {if $rows == 0}
                    <tr>
                        <td colspan="14" align="center">No Results Found!</td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
</div>