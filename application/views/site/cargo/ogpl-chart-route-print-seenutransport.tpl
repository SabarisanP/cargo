<html>

<head>
    <title>OGPL Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .title {
            font-weight: bold;
            font-size: 15px;
        }

        .bold {
            font-weight: bold;
        }

        .bolder {
            font-weight: 900;
        }

        .border-bottom {
            border-bottom: 2px solid #000;
        }

        .border-outline {
            border: 1px solid #000;
        }

        table tr {
            page-break-inside: avoid;
            page-break-after: auto;
        }
    </style>
</head>

<body class="border-outline" style="padding: 2px;">
    <table width="100%" cellpadding="5">
        <tr class="bold">
            <td width="25%">
                &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" colspan="2" style="font-size: 20px;">
                Seenu Transports Pvt.Ltd.<br>
                <p>{$loadBranchDetails[0]->address1} {$loadBranchDetails[0]->address2} Ph:{$loadBranchDetails[0]->contact}</p>
                <span style="font-size: 15px;">Route-wise Report</span>
            </td>
            <td width="25%"></td>
        </tr>
    </table>
    <table class="border-outline" cellpadding="3" width="100%">
        <tr>
            <td class="bold">FROM BRANCH</td>
            <td><b> : </b>{$ogpl->fromOrganization->name}</td>
            <td class="bold">TO BRANCH</td>
            <td><b> : </b>{$ogpl->toOrganization->name}</td>
            <td class="bold">Date</td>
            <td><b> : </b>{$ogpl->tripDate|date_format:$ns_date_format}</td>
        </tr>
        <tr>
            <td class="bold">HIRE CHALLAN NO</td>
            <td>: {$ogpl->aliasCode}</td>
            <td class="bold">TRUCKNO</td>
            <td> : {$vehicle->registationNumber}</td>
            <td class="bold">Vehicle Category</td>
            <td><b> : </b>{$vehicle->ownershipType->name}</td>
        </tr>
        <tr>
            <td class="bold">DRIVER NAME</td>
            <td>: 1. {$ogpl->vehicleDriver->name}</td>
            <td class="bold">C.C.SIGN BY</td>
            <td> : {$usr_login_name}</td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td></td>
            <td>: 2. {$ogpl->secondaryDriver->name|default:'-'}</td>
            <td class="bold">TIME CHART NO.</td>
            <td>: {$ogpl->aliasCode}</td>
        </tr>
    </table>
    <br>
    {assign var="totalLocalKm" value=0}
    {foreach from=$odoDetails item=vals key=keyss}
        {foreach from=$vals item=data key=key}
            {if $key == 'TRNT'}
                Trip
            {elseif $key == 'INTRNT'}
                Local Transit
            {elseif $key == 'OTFD'}
                Door Pickup and Delivery
            {/if}
            <table class="bordered" cellpadding="3" width="100%">
                <thead>
                    <tr>
                        <td align="left" class="title" colspan="6">{$keyss}</td>
                    </tr>
                    <tr>
                        <td align="center" class="bold" nowrap>Departure & Arrival</td>
                        <td align="center" class="bold" width="20%">Location</td>
                        <td align="center" class="bold" width="15%">Km</td>
                        <td align="center" class="bold" width="20%">Date & Time</td>
                        <td align="center" class="bold" width="15%">Remark</td>
                        <td align="center" class="bold" nowrap>C.C.Sign with Date</td>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$data item=val}
                        <tr>
                            <td align="center">Dep. Starting Km</td>
                            <td align="center">{$val->fromOrganization->name}</td>
                            <td align="center">{$val->startOdometer}</td>
                            <td align="center" nowrap>
                                {if isNotNull($val->departureAt)}
                                    {$val->departureAt|date_format:'d-m-Y H:i A'}
                                {else}
                                    -
                                {/if}
                            </td>
                            <td></td>
                            <td rowspan="4"></td>
                        </tr>
                        <tr>
                            <td align="center">Arri. Closing Km</td>
                            <td align="center">{$val->toOrganization->name}</td>
                            <td align="center">{$val->endOdometer}</td>
                            <td align="center" nowrap>
                                {if isNotNull($val->arrivalAt)}
                                    {$val->arrivalAt|date_format:'d-m-Y H:i A'}
                                {else}
                                    -
                                {/if}
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td align="right" class="bold" colspan="2">Total Km</td>
                            <td align="center">
                                {if isNotNull($val->endOdometer) && isNotNull($val->startOdometer)}
                                    {assign var="totalLocalKm" value=$totalLocalKm + ($val->endOdometer - $val->startOdometer)}
                                    {$val->endOdometer - $val->startOdometer}
                                {else}
                                    0
                                {/if}
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td align="right" class="bold" colspan="3">Running Time</td>
                            <td align="center">
                                {if isNotNull($val->departureAt) && isNotNull($val->arrivalAt)}
                                    {($val->arrivalAt|date_format:$ns_datetime_format|hoursBetween: ($val->departureAt|date_format:$ns_datetime_format))} Hrs
                                {else}
                                    -
                                {/if}
                            </td>
                            <td></td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
            <br>
        {/foreach}
    {/foreach}

    <h1>Drivers Sign</h1>
    <table cellpadding="3" width="50%">
        <tr>
            <td width="40%">1. {$ogpl->vehicleDriver->name}</td>
            <td class="border-bottom"></td>
        </tr>
        <tr>
            <td width="40%">2. {$ogpl->secondaryDriver->name}</td>
            <td class="border-bottom"></td>
        </tr>
    </table>

    <br />
    <table cellpadding="3" width="100%">
        <tr>
            {assign var="totalKm" value=0}
            {assign var="totalKm_local" value=0}
            {assign var="totalHr" value=0}
            {foreach from=$odoDetails item=vals key=keyss}
                {foreach from=$vals['TRNT'] item=val key=key}
                    {if isNotNull($val->endOdometer) && isNotNull($val->startOdometer)}
                        {assign var="totalKm" value=$totalKm + ($val->endOdometer - $val->startOdometer)}
                    {/if}
                    {if isNotNull($val->departureAt) && isNotNull($val->arrivalAt)}
                        {assign var="hours" value=($val->arrivalAt|date_format:$ns_datetime_format|hoursBetween: ($val->departureAt|date_format:$ns_datetime_format))}
                    {/if}
                {/foreach}
                {foreach from=$vals['INTRNT'] item=val key=key}
                    {if isNotNull($val->endOdometer) && isNotNull($val->startOdometer)}
                        {assign var="totalKm_local" value=$totalKm_local + ($val->endOdometer - $val->startOdometer)}
                    {/if}
                {/foreach}
            {/foreach}

            <td width="45%">
                <h1>Summary :</h1>
                <table class="bordered" cellpadding="3" width="100%">
                    <thead>
                        <tr>
                            <td></td>
                            <td align="center">Total Km</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td align="center">Trip</td>
                            <td align="center">{$totalKm}</td>
                        </tr>
                        <tr>
                            <td align="center">Local</td>
                            <td align="center">{$totalKm_local}</td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="bold">
                            <td align="center">Total</td>
                            <td align="center">{$totalKm+$totalKm_local}</td>
                        </tr>
                    </tfoot>
                </table>
            </td>
            <td width="55%"></td>
        </tr>
    </table>
    <br />
    <h1 style="text-align: center;">Based On Local DC and DD</h1>
    <table width="100%">
        <tr>
            <td width="45%">
                <table class="bordered" cellpadding="3" width="100%">
                    <thead>
                        <tr>
                            <td align="center" width="5%">S.No</td>
                            <td align="center">Door Delivery</td>
                            <td align="center">Amount</td>
                        </tr>
                    </thead>
                    <tbody>
                        {assign var="dd_sno" value=0}
                        {assign var="dp_t_pickamount" value=0}
                        {foreach from=$result->data item=item key=key}
                            {if $item->door_delivery_flag ==1}
                                {assign var="dp_t_pickamount" value=$dp_t_pickamount+$item->pickup_handling_amount}
                                {assign var="dd_sno" value=$dd_sno+1}
                                <tr>
                                    <td align="center">{$dd_sno}</td>
                                    <td>{$item->to_customer_name}</td>
                                    <td>{$item->pickup_handling_amount}</td>
                                </tr>
                            {/if}
                        {/foreach}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td align="center"></td>
                            <td align="left">Total - DD - {$dd_sno} </td>
                            <td align="left">{$dp_t_pickamount}</td>
                        </tr>
                    </tfoot>
                </table>
            </td>
            <td></td>
            <td align="right" width="45%">
                <table class="bordered" cellpadding="3" width="100%">
                    <thead>
                        <tr>
                            <td align="center" width="5%">S.No</th>
                            <td align="center">Door Collection</td>
                            <td align="center">Amount</td>
                        </tr>
                    </thead>
                    <tbody>
                        {assign var="dp_sno" value=0}
                        {assign var="dp_t_pickamount" value=0}
                        {foreach from=$result->data item=item key=key}
                            {if $item->door_collection_flag ==1}
                                {assign var="dp_t_pickamount" value=$dp_t_pickamount+$item->pickup_handling_amount}
                                {assign var="dp_sno" value=$dp_sno+1}
                                <tr>
                                    <td align="center">{$dp_sno}</td>
                                    <td>{$item->to_customer_name}</td>
                                    <td>{$item->pickup_handling_amount}</td>
                                </tr>
                            {/if}

                        {/foreach}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td align="center"></td>
                            <td align="left">Total - DC - {$dp_sno} </td>
                            <td align="left">{$dp_t_pickamount}</td>
                        </tr>
                    </tfoot>
                </table>
            </td>
        </tr>
    </table>

    <br />
    <h1>Local DC and DD summary</h1>
    <table class="bordered" cellpadding="3" width="20%">
        <thead>
            <tr>
                <td></td>
                <td align="center">Total</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>DD</td>
                <td align="center">{$dd_sno}</td>
            </tr>
            <tr>
                <td>DC</td>
                <td align="center">{$dp_sno}</td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td>Total</td>
                <td align="center">{$dd_sno + $dp_sno}</td>
            </tr>
        </tfoot>
    </table>
    <br />
    {* <table cellpadding="3" width="100%">
        <tr>
            {foreach from=$bookedBy item=name}
                <td align="center" width="20%" class="bold">Booked By : {$name}</td>
                {break}
            {/foreach}
            <td align="right" width="40%" class="bold">Printed By : {$usr_login_name}</td>
            <td align="right" width="35%" class="bold">Printed At : {$smarty.now|date_format:$ns_datetime_format}</td>
        </tr>
    </table> *}
    <div class="print-footer" id="print-footer">
        <table>
            <tr>
                <td width="35%">Printed On : {$smarty.now|date_format:$ns_datetime_format}</td>
                <td width="25%">Printed By: {$usr_login_name} </td>
            </tr>
        </table>
    </div>
</body>
<style>

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
        border: 1px solid #000;
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
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }
    }

    @page {
        size: A4 portrait;
        margin: 0;
    }
</style>

</html>