<div class="print-border-top"></div>
<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>
<table border="1" class="bordered main-table" cellpadding="2" width="101.1%" style="border-top:none; position:relative; top:4px">
    <thead class="table-head">
        <tr class="table-column">
            <td align="center" colspan="2" style="border:white">
                &nbsp;<img src="{$base_url}/assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" colspan="9" style="border:white">
                <h2 style="margin:0;">Seenu Transports Pvt Ltd</h2>
                {if $organizationDetails}
                    <p style="margin:0;font-weight:300">{$organizationDetails[0]->address1}{$organizationDetails[0]->station->name}-{$organizationDetails[0]->pincode} Phone: No: {$organizationDetails[0]->contact}</p>
                {else}
                    <span style="margin:0; font-family:100;">Regd.off : NO: 10, Transport city Main road, Sonia Gandhi
                        nagar,
                        Mettupalayam,
                        Pondicherry-605 009.
                        Ph: 0413
                        2274540 / 9380279070.</span>
                {/if}
                <h3 style="margin:0;">Truck Unloading Report</h3>
            </td>
            <td colspan="3" style="border:white">
                <table width="100%" style="line-height: 20px;" class="loadedByTable">
                    <tr style="border: none;">
                        <td align="left" class="bold" nowrap>From Date</td>
                        <td nowrap>&nbsp;<b>:</b>{$fromDate|date_format:$ns_date_format}</td>
                    </tr>
                    <tr>
                        <td align="left" class="bold" nowrap>To Date</td>
                        <td nowrap>&nbsp;<b>:</b>{$toDate|date_format:$ns_date_format}</td>
                    </tr>
                    <tr>
                        <td align="left" class="bold" nowrap>Branch</td>
                        <td nowrap>&nbsp;<b>:</b> {$organizationName}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" style="font-weight:400; font-size:14px">S.No</td>
            <td align="center" style="font-weight:400; font-size:14px">Dept dt</td>
            <td align="center" style="font-weight:400; font-size:14px">Arri dt</td>
            <td align="center" style="font-weight:400; font-size:14px"> veh no</td>
            <td align="center" style="font-weight:400; font-size:14px">dep time</td>
            <td align="center" style="font-weight:400; font-size:14px">arr time</td>
            <td align="center" style="font-weight:400; font-size:14px">Vechicle Running Time</td>
            <td align="center" style="font-weight:400; font-size:14px">unloading time </td>
            <td align="center" style="font-weight:400; font-size:14px">from </td>
            <td align="center" style="font-weight:400; font-size:14px">via </td>
            <td align="center" style="font-weight:400; font-size:14px">to</td>
            <td align="center" style="font-weight:400; font-size:14px">reports</td>
            <td align="center" style="font-weight:400; font-size:14px">unloading by </td>
            <td align="center" style="font-weight:400; font-size:14px">amount</td>
        </tr>
    </thead>
    <tbody>

        {assign var=t_load_count value=0}
        {assign var=t_cargo_count value=0}
        {assign var=t_unload_count value=0}
        {assign var=t_total_amount value=0}
        {assign var=t_hub_load_count value=0}
        {assign var=t_hub_unload_count value=0}
        {assign var=index value= 1}
      
        {foreach item=row from=$result key=i}
            {if $index % 8 == 0}
                <tr class="page-break"></tr>
            {/if}
            <tr>
                <td align="center" style="font-size: 14px;">{$i+1}</td>
                <td align="center" style="font-size: 14px;" nowrap>
                    {if isNotNull($row->departure_at)}{($row->departure_at|date_format:"%d-%m-%Y")|substr:0:10}{else}-{/if}
                </td>
                <td align="center" style="font-size: 14px;" nowrap>
                    {if isNotNull($row->arrival_at)}{($row->arrival_at|date_format:"%d-%m-%Y")|substr:0:10}{else}-{/if}</td>
                {* <td align="left" nowrap>{$row->alias_code}</td> *}
                <td align="left" style="font-size: 14px;">{$row->registration_numer|default:'-'}</td>
                <td align="center" style="font-size: 14px;">
                    {if isNotNull($row->departure_at)}{($row->departure_at|date_format:$ns_datetime_format)|substr:10:9}{else}-{/if}
                </td>
                <td align="center" style="font-size: 14px;">
                    {if isNotNull($row->arrival_at)}{($row->arrival_at|date_format:$ns_datetime_format)|substr:10:9}{else}-{/if}
                </td>
                <td align="center" style="font-size: 14px;">
                    {if isNotNull($row->arrival_at) && isNotNull($row->departure_at)}
                        {($row->arrival_at|date_format:$ns_datetime_format|hoursBetween: ($row->departure_at|date_format:$ns_datetime_format))}
                        Hrs
                    {else}
                        -
                    {/if}
                </td>
                {assign var="via" value=($row->via_organization_short_code|replace:$row->from_organization_short_code:''|replace:$row->to_organization_short_code:'')}
                {assign var = "via" value = $via|replace:',':' '}
                <td align="left" style="font-size: 12px;">{$row->unloaded_at|date_format:"%d-%b-%Y %I:%M %p"}</td>
                <td align="left" style="font-size: 14px;">{$row->from_organization_short_code|default:'-'}</td>
                <td align="center" style="font-size: 14px;" nowrap>{($via|trim) ? $via :'-'}</td>
                <td align="left" style="font-size: 14px;">{$row->to_organization_short_code|default:'-'}</td>
                <td align="center" style="font-size: 14px;">{($row->remarks) ? $row->remarks : 'OK'}</td>
                <td align="center" style="font-size: 14px;">{$row->supervisor_name|default:'-'}</td>
                <td align="center" style="font-size: 14px;">{$row->total_transit_amount|inr_format}</td>
            </tr>
            {assign var=index value= $index+1 }
            {assign var=t_load_count value=$t_load_count + $row->load_count}
            {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
            {assign var=t_unload_count value=$t_unload_count + $row->unload_count}
            {assign var=t_total_amount value=$t_total_amount + $row->total_transit_amount}
            {assign var=t_hub_load_count value=$t_hub_load_count + $row->hub_load_count}
            {assign var=t_hub_unload_count value=$t_hub_unload_count + $row->hub_unload_count}
        {foreachelse}
            <tr>
                <td colspan="16" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
    {if $result|count}
        <tr class="bold">
            <td colspan="13" align="right" style="font-size: 14px;">Total</td>
            <td align='center' style="font-size: 14px;">{($t_total_amount)|inr_format}</td>
        </tr>
    {/if}
</table>
<br>
<table width="100%">
    <tr>
        <td colspan="12" align="center"><b>All the {count($result)} Vehicles unloaded in good condition without any shortage and damage</b></td>
    </tr>
    <tr>
        <td colspan="12" align="center"><b>{count($unload_complaint_lr)} VEHICLE COMPLAINT SHOWN BELOW</b></td>
    </tr>
</table>

<div class="page-break"></div>
<br>
<table cellpadding="2" width="100%">
    <tr>
        <td colspan="2" align="left"><b>Unloading Complaints</b></td>
    </tr>
</table>
<table class="bordered" cellpadding="2" width="100.8%">
    <thead>
        <tr>
            <td align="center">S.No</td>
            <td align="center">Veh.no</td>
            <td align="center">LR Date</td>
            <td align="center">LR No</td>
            <td align="center">No.of articles</td>
            <td align="center">Reports</td>
            <td align="center">From</td>
            <td align="center">To</td>
            <td align="center">Remarks</td>
        </tr>
    </thead>
    <tbody>
        {assign var=t_item_count value=0}
        {foreach item=row from=$unload_complaint_lr key=i}
            <tr>
                <td align="center">{$i+1}</td>
                <td align="left">{$row->vechileNumber}</td>
                <td align="left">{$row->arrival_at|date_format:"%d-%m-%Y"}</td>
                <td align="left">{$row->cargo_code}</td>
                <td align="center" width="13%">{$row->total_item_count}</td>
                <td align="left">{$row->cargo_item_name}</td>
                <td align="left">
                    {$row->from_organization_name}
                </td>

                <td align="left">
                    {$row->to_organization_name}
                </td>
                <td align="left" width="20%">{$row->unloading_remarks}</td>
            </tr>
            {assign var=t_item_count value=$t_item_count + $row->total_item_count}
        {foreachelse}
            <tr>
                <td colspan="6" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
    {if $result|count}
        <tr>
            <td colspan="4" align="right">Total</td>
            <td align='center'>{($t_item_count)}</td>
            <td colspan="4"></td>
        </tr>
    {/if}
</table>
<table class="no-bordered" width="100%">
    <br>
    <br>
    <br>
    <tr>
        <td colspan="3" align="center" width="25%"><b>Prepared By</b></td>
        <td colspan="3" align="center" width="25%"><b>Checked By</b></td>
        <td colspan="3" align="center" width="25%"><b>For Seenu Transport Pvt Ltd</b></td>
        <td colspan="3" align="center" width="25%"><b>Manager</b></td>
    </tr>
</table>
{foreach from=$bookedBy item=name}
    {assign var="name" value=$name}
{/foreach}

<table class="print-footer" cellpadding="3" width="100%">
    <tr>
        <td align="left" width="25%" class="bold">Printed on : {$smarty.now|date_format:$ns_datetime_format}</td>
        <td align="center" width="20%" class="bold">Printed By : {$usr_login_name}</td>
        <td width="15%"></td>
        <td width="15%"></td>
        {* <td align="right" width="15%" class="bold">Printed By : {$usr_login_name}</td> *}
        {* <td align="left" width="20%" class="bold">Booked At : {$ogpl->tripDate|date_format:$ns_datetime_format}</td> *}
    </tr>
</table>

<style>
    .bold {
        font-weight: bold;
    }

    table {
        border-collapse: collapse;
    }

    table thead th,
    table thead td {
        font-weight: bold;
        font-family: sans-serif;
    }

    table thead td span {
        font-weight: 500;
        font-size: 13px;
        font-family: sans-serif;
    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
        font-family: sans-serif;
    }

    .table-head td {
        height: 9px;
        line-height: 20px;
        font-family: sans-serif;
    }

    .table-column {
        border: none;
    }

    .loadedByTable td {
        border: white !important;
        font-family: sans-serif;
    }
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }

        .table-head td {
            height: 15px;
            line-height: 25px;
        }

        .loadedByTable td {
            border: white !important;
        }

        div.print-border {
            position: fixed;
            bottom: 28px;
            left: 7px;
            width: 100%;
            height: 1px;
            /* Set the height of the border as needed */
            background-color: #000;
            /* Set the border color as needed */
        }

        .print-border-top {
            position: fixed;
            top: 4px;
            width: 100%;
            height: 1px;
            /* Set the height of the border as needed */
            background-color: #000;
        }

        div.print-border-left,
        div.print-border-right {
            position: fixed;
            top: 6px;
            height: 96%;
            width: 1px;
            /* Set the width of the borders as needed */
            background-color: #000;
            /* Set the border color as needed */
            z-index: 1;
            /* Move the borders behind the content */
        }

        div.print-border-left {
            left: 7px;

        }

        div.print-border-right {
            right: 0px;

        }

        .print-footer {
            position: fixed;
            bottom: 0;
        }

        .main-table {
            position: static;
            top: 0;
        }

        .page-break {
            page-break-before: always;
        }


    }

    @page {
        size: A4 landscape;
    }
</style>

<script>
    window.print();
</script> 