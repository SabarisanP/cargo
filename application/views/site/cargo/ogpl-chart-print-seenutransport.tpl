<html>

<head>
    <title>Transit Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .lr {
            font-size: 9pt;
        }

        .payment-status {
            font-size: 11pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .title {
            font-weight: bold;
            text-align: center;
            margin:0;
        }

        .bold {
            font-weight: bold;
        }

        .bolder {
            font-weight: 900;
        }

        /* table tr {
            page-break-inside: avoid;
            page-break-after: auto;
        } */

        .center-align {
            padding-left: 0px;
            padding-right: 182px;
        }

        .right-align {
            padding-left: 0px;
            padding-right: 100px;
        }

        footer {
            font-size: 9px;
            color: #f00;
            text-align: center;
        }

        .rounded-rectangle {
            width: 200px;
            height: 30px;
            border: 1px black solid;
        }

        .p-tag {
            margin: 0;
        }

        .page+.page {
            page-break-before: always;
        }

     .div1 {
                border: none;
                border-top: none;
                box-sizing: border-box;
                padding: 10px;
                width: 101.5%;
                display: block;
                position: relative;
                margin: 5px;
                left: -12px;
                top: 13.5rem;
            } 
        
            .header {
                position: fixed;
                width: 100%;
                left: 0;
                background: #fff !important;
                z-index: 1;
                height: 16%;
            }

            .print-header {
                text-align: center;
                font-size: 10px;
                color: #333;
            }


            .title {
            font-weight: bold;
            text-align: center;
            margin:0;
        }
            .top-header {
                text-align: center;
                font-size: 9px;
                color: #333;
            }

        .top-header h1 p {
                text-align: center;
                font-size: 9px;
                color: #333;
                margin:0%;
            }

        .innertable {
            position: relative;

        }

        .page-break {
            page-break-before: always;
        }

        .print-footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }


        body {
            width: unset;
        }

        table {
            border-collapse: collapse;
        }

        table thead th,
        table thead td {
            font-weight: bold;
        }

        table.bordered th,
        table.bordered td {
            border: .1px solid #000;
        }

        {if $bgimg}
            .background-image {
                position: absolute;
                background-image: url({$bgimg}) !important;
                background-repeat: repeat-y !important;
                background-position: center !important;
                height: 950px;
                width: 100%;
                top: 0;
                left: 0;
                z-index: -1;
            }
        {/if}

          .pagebreak-1{
        clear: both;
        page-break-after: always;
    }

 
    .div2 {
            border: 1px solid black;
            box-sizing: border-box;
            padding: 10px;
            height: 0%;
            width: 101%;
            display: block;
            position: relative;
            margin: 5px;
            left: -12px;
            top: 19.5rem;
        }
        div.print-border {
            position: fixed;
            bottom: 30px;
            left: 0px;
            border: 1px solid black;
            border-top:none;
            width: 100%;
            /* Set the height of the border as needed */
            background-color:black;
            /* Set the border color as needed */
        }

        div.print-border-left {
            position: fixed;
            top: 90px;
            height: 83%;
            width: 0;
            left:0;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }

        div.print-border-right{
            position: fixed;
            top: 90px;
            height: 83%;
            width: 0;
            left:99.8%;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }

    </style>

    <style type="text/css" media="print">
        @media print { 

            @page {
                size: A4 landscape;
                counter-increment: page;
            }

            .pageNumber:after {
                content: counter(page);
            }

            .lr {
            font-size: 9pt;
        }

        .payment-status {
            font-size: 11pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .title {
            font-weight: bold;
            text-align: center;
            margin:0;
        }

        .bold {
            font-weight: bold;
        }

        .bolder {
            font-weight: 900;
        }

        /* table tr {
            page-break-inside: avoid;
            page-break-after: auto;
        } */

        .center-align {
            padding-left: 0px;
            padding-right: 182px;
        }

        .right-align {
            padding-left: 0px;
            padding-right: 100px;
        }

        footer {
            font-size: 9px;
            color: #f00;
            text-align: center;
        }

        .rounded-rectangle {
            width: 200px;
            height: 30px;
            border: 1px black solid;
        }

        .p-tag {
            margin: 0;
        }

        .page+.page {
            page-break-before: always;
        }

        div.print-border {
            position: fixed;
            bottom: 30px;
            left: 0px;
            border: 1px solid black;
            border-top:none;
            width: 100%;
            /* Set the height of the border as needed */
            background-color:black;
            /* Set the border color as needed */
        }

        div.print-border-left {
            position: fixed;
            top: 90px;
            height: 83%;
            width: 0;
            left:0;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }

        div.print-border-right{
            position: fixed;
            top: 90px;
            height: 83%;
            width: 0;
            left:99.8%;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }
        
            .header {
                position: fixed;
                width: 100%;
                left: 0;
                background: #fff !important;
                z-index: 1;
                height: 16%;
            }

            .print-header {
                text-align: center;
                font-size: 10px;
                color: #333;
            }


            .title {
            font-weight: bold;
            text-align: center;
            margin:0;
        }
            .top-header {
                text-align: center;
                font-size: 9px;
                color: #333;
            }

        .top-header h1 p {
                text-align: center;
                font-size: 9px;
                color: #333;
                margin:0%;
            }

        .innertable {
            position: relative;

        }

        .page-break {
            page-break-before: always;
        }

        .print-footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }


        body {
            width: unset;
        }

        table {
            border-collapse: collapse;
        }

        table thead th,
        table thead td {
            font-weight: bold;
        }

        table.bordered th,
        table.bordered td {
            border: .1px solid #000;
        }

        {if $bgimg}
            .background-image {
                position: absolute;
                background-image: url({$bgimg}) !important;
                background-repeat: repeat-y !important;
                background-position: center !important;
                height: 950px;
                width: 100%;
                top: 0;
                left: 0;
                z-index: -1;
            }
        {/if}

          .pagebreak-1{
        clear: both;
        page-break-after: always;
    }

 
   

      
        }
    </style>

</head>

<body>
<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>
    <div class="container">
        <header class="header">
            <div class="top-header">
            <h1 class="title" style="font-size: 20px;">{$namespace_name} Pvt Ltd</h1>
                {* <h1 class="title" style="font-size: 20px;">{$namespace_name} Pvt Ltd</h1> *}
                <p>{$organizationDetails[0]->address1}{$organizationDetails[0]->station->name}-{$organizationDetails[0]->pincode} Phone: No: {$organizationDetails[0]->contact}</p>
                <h1 class="title" style="font-size: 15px;">LUGGAGE LIST REPORT</h1>
            </div>
            <div class="print-header">
                <table style="border: 2px solid;" cellpadding="3" width="100%">
                    <tr>
                        <td width="25%"><b>LUG : {$ogpl->aliasCode}</b></td>
                        <td class="center-align" width="30%"><b>Lugg List Date :
                                {$ogpl->tripDate|date_format:$ns_date_format}</b></td>
                                {foreach item=row1 from=$result key=t1}
                                    {foreach item=row from=$row1 key=t}
                                        {assign var="from_organization_branch" value=$row->transit_from_organization_code}
                                    <td class="text-right pr-1" width="15%"><b>From Branch: {$row->transit_from_organization_name}</b></td>
                                    {break}
                                    {/foreach}
                                {/foreach}
                    </tr>
                    <tr>
                        <td width="25%"><b>Truck No. : {$ogpl->busVehicle->registationNumber}</td>
                        <td class="center-align" width="30%"><b>Driver Name 1 : {$ogpl->vehicleDriver->name}</b></td>
                        {foreach item=row1 from=$result key=t1}
                            {foreach item=row from=$row1 key=t}
                                {assign var="to_organization_branch" value=$row->transit_to_organization_code}
                            <td class="text-right pr-1" width="15%"><b>To Branch: {$row->transit_to_organization_name}</b></td>
                            {break}
                            {/foreach}
                        {/foreach}
                    </tr>
                    <tr>
                        {foreach $transitcargoDetails as $row}
                            {if  $row->toOrganization->code == $to_organization_branch && $row->fromOrganization->code == $from_organization_branch}
                        <td  width="15%"><b>Loading Person : {$row->fromOrganizationContact->name|default:'-'}</b></td>
                        {break}
                            {/if}
                        {/foreach}
                        <td class="center-align" width="30%"><b>Driver Name 2 : {$ogpl->secondaryDriver->name}</b></td>
                        {foreach $transitcargoDetails as $row}
                            {if  $row->toOrganization->code == $to_organization_branch && $row->fromOrganization->code == $from_organization_branch}
                        <td class="text-right pr-1" width="15%"><b>Unloading Person : {$row->toOrganizationContact->name|default:'-'}</b></td>
                        {break}
                            {/if}
                        {/foreach}

                    </tr>
                    <tr>
                        <td width="25%"><b>Transfer Truck No: </b></td>
                        <td class="center-align" width="25%"></td>
                        {foreach $transitcargoDetails as $row}
                            {if  $row->toOrganization->code == $to_organization_branch && $row->fromOrganization->code == $from_organization_branch}
                        <td class="text-right pr-1" width="20%"><b>Unloading Time :
                                {if $row->unloadedAt != 'NA'}{($row->unloadedAt|date_format:"%d-%m-%y")|substr:0:10}{($row->unloadedAt|date_format:$ns_datetime_format)|substr:10:9}{else}-{/if}</b>
                        </td>
                        {break}
                    {/if}
                {/foreach}
                    </tr>
                </table>
                <br />
                <br />
                <br />
            </div>
        </header>
    </div>

    <div class="page newpage">
        <div class="container">
            <div class="div1">
                <table class="bordered innertable" cellpadding="" width="100%" style="table-layout:auto;">
                    <thead style="font-size: 5px;">
                        <tr class="bold">
                            <td align="center">S.No</td>
                            <td align="center">LR Date</td>
                            <td align="center">{lang('lr')} No</td>
                            <td align="center">Consignor</td>
                            <td align="center">Consignee</td>
                            <td align="center">Article</td>
                            <td align="center">Article <br>Weight</td>
                            <td align="center">FF</td>
                            <td align="center">HM</td>
                            <td align="center">DC</td>
                            <td align="center">DD</td>
                            <td align="center">Other<br>Charge</td>
                            <td align="center">{lang('docket_charge')}</td>
                            <td align="center"> Grand Total</td>
                            <td align="center">Mode Of Payment</td>
                            <td align="center">Remarks</td>
                        </tr>
                    </thead>
                    <tbody style="font-size: 5px;">
                        {assign var='o_qty' value=0}
                        {assign var='o_article_weight' value=0}
                        {assign var='sno' value=1}

                        {assign var='o_freight_tot_amount' value=0}
                        {assign var='o_tot_hamali_charge' value=0}
                        {assign var='o_tot_dc_charge' value=0}
                        {assign var='o_tot_dd_charge' value=0}
                        {assign var='o_tot_other_charge' value=0}
                        {assign var='o_tot_docket_charge' value=0}
                        {assign var='o_tot_grand_total' value=0}
                        {foreach item=row1 from=$result key=t1}
                            {foreach item=row from=$row1 key=t}
                                {assign var="addonDetails" value=","|explode:$row->fs_addon_value}
                                {if ($t+1) % 9 == 0 && ($t+1) !=1}
                                    <tr class="page-break"></tr>
                                {/if}
                                <tr>
                                    <td align="center">{$sno}</td>
                                    <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                                    <td align="left" class="lr">{$row->cargo_code}</td>
                                    <td width="auto">{$row->from_customer_name}</td>
                                    <td width="auto">{$row->to_customer_name}</td>
                                    <td>{$row->cargo_item_name}/{$row->total_item_count}
                                        {assign var='o_qty' value=$o_qty+$row->total_item_count}</td>

                                    {* <td align="center">
                                {$row->total_item_count}
                                {assign var='o_qty' value=$o_qty+$row->total_item_count}
                            </td> *}

                                    <td align="center">
                                        {$row->total_unit_value|round:2}
                                        {assign var='o_article_weight' value=$o_article_weight+($row->total_unit_value|round:2)}
                                    </td>

                                    <td align="right">
                                    {if "FR"|in_array:$addonDetails}
                                    FS
                                    {else}
                                        {$row->total_amount|round:2}
                                        {assign var='o_freight_tot_amount' value= $o_freight_tot_amount + ($row->total_amount|round:2)}
                                    {/if}
                                    </td>
                                    <td align="right">
                                        {if "LC"|in_array:$addonDetails}
                                         FS
                                        {else}
                                            {($row->total_handling_amount)|round:2}
                                         {assign var='o_tot_hamali_charge' value= $o_tot_hamali_charge + ($row->total_handling_amount|round:2)}
                                        {/if}
                                    </td>

                                    <td align="right">
                                       {if "DP"|in_array:$addonDetails}
                                        FS
                                       {else}
                                        {($row->pickup_handling_amount)|round:2}
                                        {assign var='o_tot_dc_charge' value= $o_tot_dc_charge +($row->pickup_handling_amount|round:2)}
                                       {/if}
                                    </td>

                                    <td align="right">
                                    {if "DD"|in_array:$addonDetails}
                                        FS
                                       {else}
                                        {($row->delivery_handling_amount)|round:2}
                                        {assign var='o_tot_dd_charge' value= $o_tot_dd_charge +($row->delivery_handling_amount|round:2)}
                                       {/if}
                                      
                                    </td>

                                    <td align="right">
                                    {(($row->other_charges_amount)-($row->pickup_handling_amount + $row->delivery_handling_amount + $row->hamali_charge + $row->docket_charge + $row->total_handling_amount))|round:2}
                                    {assign var='o_tot_other_charge' value= $o_tot_other_charge + ((($row->other_charges_amount)-($row->pickup_handling_amount + $row->delivery_handling_amount + $row->hamali_charge + $row->docket_charge + $row->total_handling_amount))|round:2)}
                                    </td>

                                    <td align="right">
                                    {if "DC"|in_array:$addonDetails}
                                        FS
                                       {else}
                                        {($row->docket_charge)|round:2}
                                        {assign var='o_tot_docket_charge' value= $o_tot_docket_charge + ($row->docket_charge|round:2)}
                                       {/if}
                                    </td>

                                    <td align="right">
                                        {($row->total_amount + $row->other_charges_amount)|round:2}
                                        {assign var='o_tot_grand_total' value=$o_tot_grand_total +(($row->total_amount + $row->other_charges_amount)|round:2)}
                                    </td>

                                    <td align="center">{$cargo_payment_status[$row->payment_status_code]|strtoupper}</td>
                                  
                                        <td align="center"></td>
                                   
                                </tr>
                                {assign var='sno' value=$sno+1}
                            {/foreach}
                            <tr class="bold">
                                <td align="right" colspan="5">Total</td>
                                <td align="center">{$o_qty}</td>
                                <td align="center">{$o_article_weight}</td>
                                <td align="right">{$o_freight_tot_amount|round:2}</td>
                                <td align="right">{$o_tot_hamali_charge|round:2}</td>
                                <td align="right">{$o_tot_dc_charge|round:2}</td>
                                <td align="right">{$o_tot_dd_charge|round:2}</td>
                                <td align="right">{$o_tot_other_charge|round:2}</td>
                                <td align="right">{$o_tot_docket_charge|round:2}</td>
                                <td align="right">{$o_tot_grand_total|round:2}</td>
                                <td colspan="2"></td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td align="center" colspan="17">Sorry! No cargo found</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                <br/>

                <table width="100%" class="innerTable">
                    <tr>
                        <td align="right">
                            <div class="center-align">
                                <p class="p-tag">Total Article Weight :</p>
                            </div>
                            <br>
                            <div class="right-align">
                                <div class="rounded-rectangle">
                                    <p align="center"><b>{$o_article_weight}</b></p>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="page-break"></div>
    <div class="page newpage">
        <div class="container">
            <div class="div1">
                <br />
                <br />
                <table width='100%' cellpadding="" class="innerTable">
                    <tr>
                        <td class="bolder">Payment Details :</td>
                        <td class="bolder">Delivery Details :</td>
                    </tr>
                    <tr>
                        <td>
                            <table width='96%' class="bordered" cellpadding="3">
                                <thead>
                                    <tr class="bold">
                                        <td align="center">Mode Of Payment</td>
                                        <td align="center">No.of {lang('lr')}s</td>
                                        <td align="center">Total Amount (Rs.)</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach item=val from=$paymentSummary key=key }
                                        <tr>
                                            <td align="center"><b>{$cargo_payment_status[$key]}</b></td>
                                            <td align="center">{$val['lr']}</td>
                                            <td align="center">{$val['amount']|string_format:"%d"}</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </td>
                        <td>
                            <table width='100%' class="bordered" cellpadding="3">
                                <thead>
                                    <tr class="bold">
                                        <td align="center">Delivery Type</td>
                                        <td align="center">No.of {lang('lr')}s</td>
                                        <td align="center">Total Amount (Rs.)</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach item=val from=$deliverySummary key=key}
                                        <tr>
                                            <td align="center"><b>{$delivery_type_codes[$key]}</b></td>
                                            <td align="center">{$val['lr']}</td>
                                            <td align="center">{$val['amount']|string_format:"%d"}</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </table>

                <br />
                <br />
                <div id="innertable"></div>
            </div>
        </div>
    </div>

    <div class="print-footer" id="print-footer">
        <table>
            <tr>
                <td width="35%">Printed On : {$smarty.now|date_format:$ns_datetime_format}</td>
                {foreach $transitcargoDetails as $row}
                    {if  $row->toOrganization->code == $to_organization_branch && $row->fromOrganization->code == $from_organization_branch}
                        {if isset($row->audit->user->name)}
                        <td width="25%">Booked By: {$row->audit->user->name|default:'-'} </td>
                        {/if}
                {break}
            {/if}
        {/foreach}
            {foreach item=row from=$odometer key=t}
                {if $row->fromOrganization->code ==  $from_organization_branch }
                    {if isset($row->departureAt)}
                        <td width="25%">Booked Date & Time : {$row->departureAt|date_format:$ns_datetime_format}</td>
                        {break}
                    {/if}
                {/if}
        {/foreach}
            </tr>
        </table>
    </div>
</body>

<script>
var filter = {$filter|json_encode};
    var addBranches = {$newBranchSummary|json_encode};
    var m = 0;
    var total_amount = 0;
    var total_article = 0;
    var total_lr = 0;
    var total_weight = 0;
    var total_ff = 0;
    var total_hm = 0;
    var total_dc = 0;
    var total_dd = 0;
    var total_other = 0;
    var total_stc = 0;

    var tablesContainer = document.getElementById('innertable');
    var h1 = document.createElement('h1');
    h1.textContent = "Add Branches:-";
    tablesContainer.appendChild(h1);
    var table = document.createElement('table');
    table.setAttribute('cellpadding', '3');
    table.setAttribute('border', '2px')
    table.setAttribute('width', '100%');

    var thead = document.createElement('thead');
    var tr = document.createElement('tr');
    var entries = Object.entries(addBranches);
    var lastValue = entries.length;
    var th = document.createElement('th');
    th.textContent = "SI NO";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "FROM";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "TO";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "No.of.LR";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "NO OF ARTICLES";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "ARTICLES WEIGHT";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "FF";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "HM";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "DC";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "DD";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "OtherCharge";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "STC";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "Total Amount";
    tr.appendChild(th);

    thead.appendChild(tr);
    table.appendChild(thead);

    var tbody1 = document.createElement('tbody');
    table.appendChild(tbody1);
    var rowIndex = 0;
    var j = 1;
    for (var [key, value] of entries) {
  
        var row = document.createElement('tr');
        var keys = Object.keys(value);
        var td1 = document.createElement('td');
        td1.setAttribute('align', 'center');
        td1.textContent = j++;
        row.appendChild(td1);

        for (var k = 0; k < keys.length-1; k++) {
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            var presentAddonDetails = [].concat(...value[keys[keys.length - 1]]);
            console.log(keys[k],value[keys[k]]);
            td.textContent = (keys[k] == 'ff' && value[keys[k]] <= 0 && presentAddonDetails.includes("FR")) ? "FS" :
                   (keys[k] == 'hm' && value[keys[k]] <= 0 && presentAddonDetails.includes("LC")) ? "FS" :
                   (keys[k] == 'stc' && value[keys[k]] <= 0 && presentAddonDetails.includes("DC")) ? "FS" :
                   (keys[k] == 'dc' && value[keys[k]] <= 0 && presentAddonDetails.includes("DP")) ? "FS" :
                   (keys[k] == 'dd' && value[keys[k]] <= 0 && presentAddonDetails.includes("DD")) ? "FS" :
                   value[keys[k]];
            if (keys[k] == 'lr') {
                total_lr += value[keys[k]];
            } else if (keys[k] == 'article') {
                total_article += value[keys[k]];
            } else if (keys[k] == 'articleWeight') {
                total_weight += value[keys[k]];
            } else if (keys[k] == 'ff') {
                total_ff += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'dc') {
                total_dc += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'hm') {
                total_hm += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'dd') {
                total_dd += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'otherCharges') {
                total_other += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'amount') {
                total_amount += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'stc') {
                total_stc += parseFloat(value[keys[k]].toFixed(2));
            }

            row.appendChild(td);
            tbody1.appendChild(row);
        }

        if (j > lastValue) {
            var row = document.createElement('tr');
            var td = document.createElement('td');
            var b = document.createElement("B");
            td.setAttribute("colspan", "3")
            td.setAttribute('align', 'right');
            td.classList.add("bold");
            td.textContent = "Total";
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = total_lr;
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = total_article;
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = total_weight;
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_ff.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent =  parseFloat(total_hm.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_dc.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_dd.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_other.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_stc.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_amount.toFixed(2));
            row.appendChild(td);
            tbody1.appendChild(row);
            table.appendChild(tbody1);
            tablesContainer.appendChild(table);
            br = document.createElement('br');
            tablesContainer.appendChild(br);

            var table3 = document.createElement('table');
            table3.setAttribute("width", "100%");
            table3.classList.add("DriverSign");
            br2 = document.createElement('br');
            table3.appendChild(br2);
            br3 = document.createElement('br');
            table3.appendChild(br3);
            br4 = document.createElement('br');
            table3.appendChild(br4);
            tr3 = document.createElement('tr');
            td3 = document.createElement('td');
            td3.setAttribute("align", "right");
            innerDiv = document.createElement('div');
            innerDiv.classList.add("center-align");
            p = document.createElement('p');
            p.classList.add('p-tag');
            p.textContent = "Driver-Sign";
            innerDiv.appendChild(p);
            td3.appendChild(innerDiv);
            tr3.appendChild(td3);
            table3.appendChild(tr3);
            tablesContainer.appendChild(table3);
            break;
        }

        if (j % 5 == 0) {
            tablesContainer.appendChild(table);
            entries_new = entries.slice(j - 1);
            if (entries_new.length > 0) {
                j = createtable(j, entries, entries_new);
                if (j > lastValue) {
                    break;
                }
            } else {
                break;
            }
        }
    }

    function createtable(j, entries, entries_new) {
        var page = document.createElement('div');
        page.classList.add("page");
        page.classList.add("newpage");
        var container = document.createElement('div');
        container.classList.add("container");
        var div1 = document.createElement('div');
        div1.classList.add("div1");
        var tablecontainer2 = document.createElement('div');
        var table2 = document.createElement('table');
        table2.setAttribute('cellpadding', '3');
        table2.setAttribute('border', '2px')
        table2.setAttribute('width', '100%');
        var thead = document.createElement('thead');
        var tr = document.createElement('tr');
        var th = document.createElement('th');
        th.textContent = "SI NO";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "FROM";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "TO";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "No.of.LR";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "NO OF ARTICLES";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "ARTICLES WEIGHT";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "FF";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "HM";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "DC";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "DD";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "OtherCharge";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "STC";
        tr.appendChild(th)
        var th = document.createElement('th');
        th.textContent = "Total Amount";
        tr.appendChild(th);
        thead.appendChild(tr);
        table2.appendChild(thead);
        var tbody = document.createElement('tbody');
        table.appendChild(tbody);
        console.log(entries_new);
        for (var [key, value] of entries_new) {
            var row = document.createElement('tr');
            var keys = Object.keys(value);
            var td1 = document.createElement('td');
            td1.setAttribute('align', 'center');
            td1.textContent = j++;
            row.appendChild(td1);
            for (var k = 0; k < keys.length-1; k++) {
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                if (keys[k] == 'lr') {
                    total_lr += value[keys[k]];
                } else if (keys[k] == 'article') {
                    total_article += value[keys[k]];
                } else if (keys[k] == 'articleWeight') {
                    total_weight += value[keys[k]];
                } else if (keys[k] == 'ff') {
                    total_ff += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'dc') {
                    total_dc += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'hm') {
                    total_hm += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'dd') {
                    total_dd += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'otherCharges') {
                    total_other += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'amount') {
                    total_amount += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'stc') {
                    total_stc += parseFloat(value[keys[k]].toFixed(2));
                }
                var presentAddonDetails = [].concat(...value[keys[keys.length - 1]]);
                td.textContent = (keys[k] == 'ff' && value[keys[k]] <= 0 && presentAddonDetails.includes("FR")) ? "FS" :
                   (keys[k] == 'hm' && value[keys[k]] <= 0 && presentAddonDetails.includes("LC")) ? "FS" :
                   (keys[k] == 'stc' && value[keys[k]] <= 0 && presentAddonDetails.includes("DC")) ? "FS" :
                   (keys[k] == 'dc' && value[keys[k]] <= 0 && presentAddonDetails.includes("DP")) ? "FS" :
                   (keys[k] == 'dd' && value[keys[k]] <= 0 && presentAddonDetails.includes("DD")) ? "FS" :
                   value[keys[k]];
                row.appendChild(td);
            }

            tbody.appendChild(row);

            if (j > lastValue) {
                var row = document.createElement('tr');
                var td = document.createElement('td');
                td.setAttribute("colspan", "3")
                td.setAttribute('align', 'right');
                td.classList.add("bold");
                td.textContent = "Total";
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = total_lr;
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = total_article;
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = total_weight;
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_ff.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_hm.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_dc.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_dd.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_other.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_stc.toFixed(2));
                row.appendChild(td);

                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_amount.toFixed(2));
                row.appendChild(td);
                tbody.appendChild(row);
                table2.appendChild(tbody);
                tablecontainer2.appendChild(table2);
                div1.appendChild(tablecontainer2);
                container.appendChild(div1);
                br = document.createElement('br');
                container.appendChild(br);
                var table3 = document.createElement('table');
                table3.setAttribute("width", "100%");
                table3.classList.add("DriverSign");
                br2 = document.createElement('br');
                table3.appendChild(br2);
                br3 = document.createElement('br');
                table3.appendChild(br3);
                br4 = document.createElement('br');
                table3.appendChild(br4);
                tr3 = document.createElement('tr');
                td3 = document.createElement('td');
                td3.setAttribute("align", "right");
                innerDiv = document.createElement('div');
                innerDiv.classList.add("center-align");
                p = document.createElement('p');
                p.classList.add('p-tag');
                p.textContent = "Driver-Sign";
                innerDiv.appendChild(p);
                td3.appendChild(innerDiv);
                tr3.appendChild(td3);
                table3.appendChild(tr3);
                div1.appendChild(table3);
                container.appendChild(div1);
                page.appendChild(container);
                var referenceNode = document.getElementById("print-footer");
                referenceNode.parentNode.insertBefore(page, referenceNode);
                return j;
            }

            if (j % 5 == 0) {
                table2.appendChild(tbody);
                tablecontainer2.appendChild(table2);
                div1.appendChild(tablecontainer2);
                container.appendChild(div1);
                page.appendChild(container);
                // page.appendChild( br());
                // page.appendChild( br());
                // page.appendChild(table());
                var referenceNode = document.getElementById("print-footer");
                referenceNode.parentNode.insertBefore(page, referenceNode);
                entries_new = entries.slice(j - 1)
                if (entries_new.length > 0) {
                    j = createtable(j, entries, entries_new);
                    if (j > lastValue) {
                        return j;
                    }
                }
            }
        }
        return j;
    }

    function table() {
        br = document.createElement('br')
        br = document.createElement('br')
        var table3 = document.createElement('table');
        table3.setAttribute("width", "100%");
        table3.classList.add("DriverSign");
        tr3 = document.createElement('tr');
        td3 = document.createElement('td');
        td3.setAttribute("align", "right");
        innerDiv = document.createElement('div');
        innerDiv.classList.add("center-align");
        p = document.createElement('p');
        p.classList.add('p-tag');
        p.textContent = "Driver-Sign";
        innerDiv.appendChild(p);
        td3.appendChild(innerDiv);
        tr3.appendChild(td3);
        table3.appendChild(tr3);
        return table3
    }
</script>

</html>