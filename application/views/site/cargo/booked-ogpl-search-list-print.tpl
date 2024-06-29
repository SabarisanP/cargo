<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
        font-size: 11pt;
    }

    table {
        border-collapse: collapse;
        font-family: Arial, Helvetica, sans-serif;
        font-size: 11pt;
    }

    .bold,
    thead td {
        font-weight: bold;
        font-size: 11pt;
    }

    .hide {
        display: none;
    }

    .lr {
        font-size: 12pt;
        font-weight: bold;
        letter-spacing: 1.5px;
    }

    .date {
        font-size: 10pt;
    }
</style>

<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">{lang('loading_sheet')}</span></td>
    </tr>
    {if $namespace == 'skscargo'}
        <tr>
            <td colspan="2" align="center">
                {$nsprofile->namespaceProfile->address}, {$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                <b>Tel: </b> +91 080-42129000 <b>GSTIN : </b>29AEEPA2429K1ZL <br>
                For Hyderabad Luggage Delivery Contact No. : 9505137397 <br>
                <hr>
            </td>
        </tr>
    {/if}
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Vehicle No : </span> {$vehicle_no}</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br />

<table id="new-lr-table" class="table table-bordered " style="width:99%" border="1">
    <thead>
        <tr class="success">
            <td align="center">DOB</td>
            <td align="center">{lang('lr')}</td>
            {*<td align="center">Loading Status</td>*}
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">{if in_array($namespace , ["rathimeenaparcel","rmtcargo"])}To{else}{lang('booking_to_label')}{/if}</td>
            <td align="center">{lang('booking_article_label')}</td>
            {if in_array($namespace , ["rathimeenaparcel","rmtcargo"])}
                <td align="center">Select</td>
            {/if}
            <td align="center">{if in_array($namespace , ["rathimeenaparcel","rmtcargo"])}Art{else}# Art{/if}</td>

            {if !in_array($namespace , ["rathimeenaparcel","rmtcargo"])}
                <td align="center">Goods Desc</td>
                <td align="center">kg</td>
                <td align="center">Act<br>.kg</td>
                <td align="center">Remarks</td>
            {/if}
        </tr>
    </thead>

    <tbody class="body_table" id="load-ogpl-list">
        {assign var="rows" value=0}
        {assign var="t_total_item_count" value=0}
        {assign var="t_total_actual_unit_value" value=0}

        {foreach item=list from=$result key=toorganization}
            {assign var="orglrcount" value=0}
            {assign var="sublrcount" value=0}
            {foreach item=row from=$list key=t}
                {assign var="remarks_row" value= isNotNull($row->remarks)}
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
                        <td colspan="15" align="center" class="active bold">{$toorganization}</td>
                    </tr>
                {/if}
                <tr>
                    <td align="left" class="date" nowrap>{if in_array($namespace , ["rathimeenaparcel","rmtcargo"])}{$row->booked_at|date_format:'%d%b,%I:%M%p'}{else}{$row->booked_at|date_format:$ns_datetime_format}{/if}</td>
                    <td align="center" class="lr" nowrap>{$row->cargo_code}
                        {if in_array($namespace , ["citycargo","cityparcel"])}
                            <br>
                            {if isNotNull($row->eway_bill_no)}
                                <span style="border: 1px solid #000; font-size: 13px;"><b>EW</b></span> &nbsp;
                            {/if}
                            {if isNotNull($row->invoice_number)}
                                <span style="border: 1px solid #000;font-size: 13px;"><b>INV</b></span>
                            {/if}
                        {/if}
                    </td>
                    {*<td align="center">
                        {if $allowloadstatus == 1 || $action_rights['OGPL-HUB-LOAD'] == 1}
                            Available
                        {elseif $allowloadstatus == 2}
                            Not Ready
                        {elseif $allowloadstatus == 3}
                            Not Ready
                        {/if}
                    </td>*}
                    <td align="left">{$row->from_organization_short_code}</td>
                    <td align="left">{$row->to_organization_short_code}</td>
                    <td align="left">{$row->cargo_item_name}</td>
                    {if in_array($namespace , ["rathimeenaparcel","rmtcargo"])}
                        <td>
                            {assign var="totalItemCount" value=$row->total_item_count|intval}

                            {if  $totalItemCount >= 14}
                                -
                                {section name=checkbox loop=$totalItemCount}
                                    {assign var="currentIndex" value=$smarty.section.checkbox.index + 1}
                                    {if $currentIndex > 14}
                                        {assign var="showBalanceDetails" value=true}
                                    {/if}
                                {/section}
                            {else}
                                {section name=checkbox loop=$totalItemCount}
                                    {assign var="currentIndex" value=$smarty.section.checkbox.index + 1}
                                    <span class="checkbox-box" style="display: inline-block; border:1px solid #000; margin:2px -2px 2px 2px; width: 1em; height: 1em; padding:3px; font-size: 12px; text-align:center;">
                                        {$currentIndex}
                                    </span>
                                    {if $currentIndex > 14}
                                        {assign var="showBalanceDetails" value=true}
                                    {/if}
                                {/section}
                            {/if}
                        </td>
                    {/if}
                    <td align="center">{$row->total_item_count}</td>
                    {if !in_array($namespace , ["rathimeenaparcel","rmtcargo"])}
                        <td align="left">{$row->description|default:"-"}</td>
                        <td align="center">{$row->total_unit_value|default:"-"}</td>
                        <td align="center">{$row->total_actual_unit_value|default:"-"}</td>
                        <td align="left">{$row->remarks|default:"-"}</td>
                    {/if}

                    {$rows = $rows + 1}
                    {$orglrcount = $orglrcount + 1}
                    {assign var="sublrcount" value=$sublrcount + $row->total_item_count}
                    {assign var="t_total_item_count" value=$t_total_item_count + $row->total_item_count}
                    {assign var="t_total_actual_unit_value" value=$t_total_actual_unit_value + $row->total_actual_unit_value}
                </tr>
                {if in_array($namespace , ["rathimeenaparcel","rmtcargo"]) && isset($showBalanceDetails) && $showBalanceDetails && $totalItemCount >= 14}
                    <tr>
                        <td colspan="7">
                            {assign var="totalItemCount" value=$row->total_item_count|intval}
                            {section name=checkbox loop=$totalItemCount}
                                {assign var="currentIndex" value=$smarty.section.checkbox.index + 1}
                                <span class="checkbox-box" style="display: inline-block; border:1px solid #000; margin:2px -2px 2px 2px; width: 1em; height: 1em; padding:3px; font-size: 12px; text-align:center;">
                                    {$currentIndex}
                                </span>
                            {/section}
                        </td>
                    </tr>
                {/if}
                {if in_array($namespace , ["rathimeenaparcel","rmtcargo"]) && $remarks_row}
                    <tr>
                        <td colspan="7"><b>Remarks :</b> {$row->remarks}</td>
                    </tr>
                {/if}
            {/foreach}
            <tr>
                <td colspan="5" align="right" class="active">Sub Total</td>
                <td class="active" align="center">{$sublrcount}</td>
            </tr>
        {/foreach}

        {if $rows == 0}
            <tr>
                <td colspan="{if in_array($namespace , ["rathimeenaparcel","rmtcargo"])}13{else}14{/if}" align="center">No Results Found!</td>
            </tr>
        {else}
            <tr class="bold">
                <td colspan="{if in_array($namespace , ["rathimeenaparcel","rmtcargo"])}6{else}5{/if}" align="right">Total</td>
                <td align="center">{$t_total_item_count}</td>
                {if !in_array($namespace , ["rathimeenaparcel","rmtcargo"])}
                    <td align="right">-</td>
                    <td align="center">{$t_total_actual_unit_value}</td>
                    <td></td>
                {/if}
            </tr>
        {/if}
    </tbody>
</table>
<br />
<table style="width:99%" {if $hidesummary}class="noprint hide" {/if}>
    <tr>
        <td><b>Summary</b></td>
    </tr>
</table>
<table style="width:97%" border="1" {if $hidesummary}class="noprint hide" {/if}>
    <thead>
        <tr class="success">
            <td align="center">{lang('lr')} Type</td>
            <td align="center">No.of {lang('lr')}s</td>
            <td align="center">No.of {lang('booking_article_label')}</td>
            <td align="center">Freight</td>
            <td align="center">Loading Charges</td>
            <td align="center">Unloading Charges</td>
            <td align="center">Service Tax</td>
            <td align="center">Total</td>
        </tr>
        {assign var="total" value=0}
        {assign var="total_lr" value=0}
        {assign var="total_pkgs" value=0}
        {assign var="total_frieght" value=0}
        {assign var="total_loading" value=0}
        {assign var="total_unloading" value=0}
        {assign var="total_service_tax" value=0}
        {assign var="net_total" value=0}

    <tbody class="body_table">
        {foreach item=row from=$summary key=k }
            <tr>
                {assign var=total value=$row['freight']+$row['loading']+$row['unloading']+$row['service_tax']}
                <td align="center"><b>{$cargo_payment_status[$k]}</b></td>
                <td align="center">{$row['lr']}</td>
                <td align="center">{$row['packages']}</td>
                <td align="center">{$row['freight']|number_format:2}</td>
                <td align="center">{$row['loading']|number_format:2}</td>
                <td align="center">{$row['unloading']|number_format:2}</td>
                <td align="center">{$row['service_tax']|number_format:2}</td>
                <td align="center">{$total|number_format:2}</td>
            </tr>

            {assign var="total_lr" value=$total_lr+$row['lr']}
            {assign var="total_pkgs" value=$total_pkgs+$row['packages']}
            {assign var="total_frieght" value=$total_frieght+$row['freight']}
            {assign var="total_loading" value=$total_loading+$row['loading']}
            {assign var="total_unloading" value=$total_unloading+$row['unloading']}
            {assign var="total_service_tax" value=$total_service_tax+$row['service_tax']}
            {assign var="net_total" value=$net_total+$total}
        {/foreach}
    </tbody>
    <tfoot>
        <tr>
            <td align="center"><b>Total</b></td>
            <td align="center"><b>{$total_lr}</b></td>
            <td align="center"><b>{$total_pkgs}</b></td>
            <td align="center"><b>{$total_frieght|number_format:2}</b></td>
            <td align="center"><b>{$total_loading|number_format:2}</b></td>
            <td align="center"><b>{$total_unloading|number_format:2}</b></td>
            <td align="center"><b>{$total_service_tax|number_format:2}</b></td>
            <td align="center"><b>{$net_total|number_format:2}</b></td>
        </tr>
    </tfoot>

    </thead>
</table>