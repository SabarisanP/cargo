<div class="clearfix"></div>
{if $toBranchSummary|count}
    <h5><b>Summary</b></h5>
    <table class="table table-bordered" style="width: 30%;">
        <thead>
            <tr class="success">
                <th class="text-center">To Branch</th>
                <th class="text-center">Total</th>
            </tr>
        </thead>
        <tbody>
            {foreach item=count from=$toBranchSummary key=branch}
                <tr>
                    <td align="left"><b>{$branch}</b></td>
                    <td align="right"><b>{($count['total_count']+0)|sigma:$total_to_brn_count}</b></td>
                </tr>
            {/foreach}
        </tbody>
        <tfoot>
            <tr class="active">
                <th align="left"><b>Total</b></th>
                <td class="text-right"><b>{$total_to_brn_count}</b></td>
            </tr>
        </tfoot>
    </table>
{/if}

<table class="hide">
    {foreach item=count from=$summary key=branch}
        <tr class="{$branch|replace:' ':''} hide summary-to-branch">
            <td>
                <table class="table table-bordered " width="100%">
                    <thead>
                        <tr class="active">
                            <th class="text-center">To Branch</th>
                            {foreach item=statuscount key=statuscode from=$all_payment_status}
                                <th class="text-center">{$cargo_payment_status[$statuscode]}</th>
                            {/foreach}
                            <th class="text-center">Total</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {$cnt = 1}
                        {foreach item=val from=$count['toOrganizationName'] key=toBranch}
                            <tr>
                                <td align="left"><b>{$toBranch}</b></td>
                                {foreach item=statuscount key=statuscode from=$all_payment_status}
                                    <td align="right">{$val[$statuscode] + 0}</td>
                                {/foreach}
                                <td align="right"><b>{$val['total']}</b></td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </td>
        </tr>
    {/foreach}
</table>
<div class="clearfix"></div>

<div class="row">
    <div class="col-md-6">
        <h5><b>Transactions</b></h5>
    </div>
    <div class="col-md-6 text-right">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="printLoadingSheet();"><i class="fa fa-print fa-lg"></i> Loading Sheet</button>&emsp;
        </div>
    </div>
</div>

<table id="new-lr-table" class="table table-bordered " style="width:99%">
    <thead>
        <tr class="success">
            <td align="center">
                <input type="checkbox" onchange="selectAllBookingOutstation(this);" />
            </td>
            <td align="center">{lang('lr')} No</td>
            <td align="center">Booked Date</td>
            <td align="center">Booked by</td>
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">
                Transit To Branch &nbsp;
                <a class="badge badge-success" href="javascript:;" title="Fill first selected branch to all LR" onclick="setAllTransitBranch()"><i class="fa fa-files-o" aria-hidden="true"></i></a>
            </td>
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

        {assign var="rows" value=0}

        {foreach item=list from=$result key=toorganization}
            <tr>
                <td colspan="14" align="center" class="active">{$toorganization}</td>
            </tr>
            {foreach item=row from=$list key=t}
        
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
                <tr class="{if $allowloadstatus == 1 || $action_rights['OGPL-HUB-LOAD'] == 1}bg-success{elseif $allowloadstatus == 2}bg-warning{elseif $allowloadstatus == 3}bg-danger{/if}">
                    <td align="center">
                        {if $allowloadstatus == 1 || $action_rights['OGPL-HUB-LOAD'] == 1}
                            <input type="checkbox" class="ogpl-new-items" data-tobranch="{$row->to_organization_code}" data-from="{$row->from_station_code}" data-to="{$row->to_station_code}" data-oldtransitorg="{$row->transit_organization_code}" data-oldtransitstn="{$row->transit_station_code}" value="{$row->cargo_code}" />
                        {/if}
                    </td>
                    <td align="center">
                        <a href='javascript:;' {if $allowloadstatus == 2}class="badge badge-warning text-white"{elseif $allowloadstatus == 3}class="badge badge-danger text-white"{/if} title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>
                        <br>
                        {if $row->additional_status_code !== 'null'}
                            {assign var="asc_ar" value=explode(',', $row->additional_status_code)}
                            {foreach from=$asc_ar item=code key=key name=name}
                                {if $code eq "EXPDL"}  
                                    <span class="ind ind-{$cargo_additional['EXPDL']['color']}" title="{$cargo_additional['EXPDL']['name']}">{$cargo_additional['EXPDL']['code']}</span>
                                {/if}
                                {if $code eq "HDLWC"}
                                    <span class="ind ind-{$cargo_additional['HDLWC']['color']}" title="{$cargo_additional['HDLWC']['name']}">{$cargo_additional['HDLWC']['code']}</span>
                                {/if}
                            {/foreach}
                        {/if}
                    </td>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>
                    <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                    <td align="left">
                        {assign var=tload_branches value=$load_branches}  
                        {if $load_station_branches[$row->to_station_code]|count>0}
                            {assign var=tload_branches value=$load_station_branches[$row->to_station_code]} 
                        {/if}    
                        {if $allowloadstatus == 1 || $action_rights['OGPL-HUB-LOAD'] == 1}
                            <select class="load-branch-sel form-control load-branch" >
                                {if $tload_branches|count>0}
                                    <option value="">Select a branch</option>
                                {/if}

                                {if in_array($row->load_type, ['FTL', 'PTL'])}
                                    <option value="{$row->to_organization_code}" data-station="{$row->to_station_code}" selected>{$row->to_organization_name}</option>
                                {/if}
            
                                {foreach item=branch from=$tload_branches}
                                    <option value="{$branch->code}" data-station="{$branch->station->code}" {if $branch->code==$row->to_organization_code}selected{/if}>{$branch->name}</option>
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
        
                    {*foreach item=branch from=$branches}
                        {if $branch->organization->station->code == {$row->to_station_code}}
                            {$load_branches[$branch->organization->code] = $branch->organization->name}
                        {/if}
                    {/foreach *}
        
                    {$rows = $rows + 1}
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

<div class="clearfix_both"></div><br />
<div class="row">
    <div class="col-md-12 text-right">
        <div class="row">
            <div class="col-md-8 pull-right">
                <div class="alert pull-right" id="load-ogpl-action-state" style="display: none"></div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                {if $transitCode}
                    <a href="#cargo/ogpl-chart-details?transitCode={$transitCode}&date={$tripDate}" id="ogpl-view-chart-shortcut" class="btn btn-primary pull-left">View Chart</a>
                {/if}
            </div>
            <div class="col-md-8 pull-right">

                <div class="row text-right">
                    <div class="col-md-4 col-md-offset-4">
                        <label class="hidden">
                            <input type="checkbox" id="ogpl-load-hub" {if $action_rights['OGPL-HUB-LOAD']==1}checked{/if} />&nbsp; Load to Hub
                        </label>
                    </div>
                    <div class="col-md-4">
                        {if (!isset($odoDetails) && (in_array('FULL-TRK-LOAD', $ogpl->activity) || in_array('PART-TRK-LOAD', $ogpl->activity))) || (isset($odoDetails) && $odoDetails->startOdometer == 0)}
                            <button class="btn btn-warning" id="start-odometer-btn" type="button" onclick="showStartTripDialog();">Start Trip</button>
                        {/if}
                        {* {if $cargo_setting->ogplModelCode == 'VER2'}
                            <button class="btn btn-primary" type="button" onclick="proceedOGPL('EMPTY_LOAD')">Empty Load</button>
                        {/if} *}

                        {if $show_end_odo == 1}
                            <button class="btn btn-warning" id="end-odometer-btn" type="button" onclick="showOGPLEndTripDialog();">End Trip</button>&nbsp;
                        {/if}
                        <button class="btn btn-success" type="button" id="load-to-ogpl-btn" onclick="loadOGPL();">Load</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var ogplDetailsData = {$ogpl|json_encode};
</script>
