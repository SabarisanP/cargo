<html>

<head>
    <title>Out For Delivery Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .title { font-weight:bold; text-align: center; }
        .bold { font-weight:bold; }
        .bolder { font-weight: 900; }
        .border-bottom { border-bottom: 2px solid #000;}
        .border-outline { border: 1px solid #000;}
    </style>
</head>

<body style="overflow: hidden;" class="border-outline">
    <table class="border-outline" width="100%" cellpadding="5" style="border-bottom: none;">
        <tr class="bold">
            <td width="25%">
                &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" colspan="2" style="font-size: 20px;">
                Seenu Transports Pvt.Ltd.<br>
                    {foreach $organizationDetails as $detail}
                    {if $ogpl->fromOrganization->code == $detail->code}
                      <p style = "margin-top:3px; margin-bottom:3px; font-size:16px; font-weight: normal;">{$detail->address1}{$detail->address2}{$detail->station->name}&nbsp;{$detail->pincode}&nbsp;Phone: No:{$detail->contact}</p>
                        {break}
                    {/if}
                    {/foreach}
            </td>
            <td width="25%"></td>
        </tr>
    </table>
    <table class="border-outline" cellpadding="5" width="100%" style="border-top: none;">
        <tr>
            <td colspan="3" align="center" class="bold" style="font-size: 18px;">Local Lorry Hire Slip Report</td>
        </tr>
        <tr>
            <td><b>Date : {$ogpl->tripDate|date_format:$ns_date_format}</b></td>
            <td><b>Vechile No : {$ogpl->busVehicle->registationNumber} / {$ogpl->busVehicle->ownershipType->name}</b></td>
        </tr>
        <tr>
            <td><b>HIRE CHALLAN NO : {$ogpl->aliasCode} </b></td>
            <td><b>Location Area : {$ogpl->fromOrganization->name} </b></td>
        </tr>
        <tr>
            <td><b>Driver Name : {$ogpl->vehicleDriver->name}</b></td>
            <td><b>Driver Mobile :{$ogpl->vehicleDriver->mobileNumber}</b></td>
        </tr>
    </table>
    <br>
    {foreach from=$odoDetails['OTFD'] item=val key=key}
        <table class="bordered" cellpadding="3" width="100%">
            <thead>
                <tr>
                    <td align="left" class="title" colspan="6">{$key}</td>
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
                <tr>
                    <td align="center">DEP:STARTING.Km</td>
                    <td>{$val->fromOrganization->name}</td>
                    <td align="center">{$val->startOdometer}</td>
                    <td align="center" nowrap>
                        {if isNotNull($val->departureAt)}
                            {$val->departureAt|date_format:'d-m-Y H:i A'}
                        {else}
                            -
                        {/if}
                    </td>
                    <td></td>
                    <td rowspan="3"></td>
                </tr>
                <tr>
                    <td align="center">ARRI:CLOSING.Km</td>
                    <td>{$val->toOrganization->name}</td>
                    <td align="center">{$val->endOdometer}</td>
                    <td align="center">
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
                            {$val->endOdometer - $val->startOdometer}
                        {else}
                            0
                        {/if}
                    </td>
                    <td align="center">
                        {if isNotNull($val->departureAt) && isNotNull($val->arrivalAt)}
                            {($val->arrivalAt|date_format:$ns_datetime_format|hoursBetween: ($val->departureAt|date_format:$ns_datetime_format))}
                        {else}
                            -
                        {/if}
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <br />
    {/foreach}

    <h1 style="text-align: center;">Local DC and DD</h1>
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
                        {assign var="dd_t_pickamount" value=0}
                        {foreach from=$result->data item=item key=key}
                            {if $item->door_delivery_flag ==1}
                                {assign var="dd_t_pickamount" value=$dd_t_pickamount+$item->delivery_handling_amount}
                                {assign var="dd_sno" value=$dd_sno+1}
                                <tr>
                                    <td align="center">{$dd_sno}</td>
                                    <td>{$item->to_customer_name}</td>
                                    <td>{$item->delivery_handling_amount}</td>
                                </tr>
                            {/if}
                        {/foreach}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td align="center"></td>
                            <td align="left">Total - DD - {$dd_sno} </td>
                            <td align="left">{$dd_t_pickamount}</td>
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
                        {foreach from=$result item=item key=key}
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
    <br>

    <table width="100%" cellpadding="2">
        <tr>
            <td width="50%">
                <table cellpadding="2">
                    <tr class="bold">
                        <td colspan="2">TOTAL:</td>
                    </tr>
                    <tr>
                        <td class="bold" width="70%">Total-DD</td>
                        <td class="bold">: {$dd_sno}</td>
                    </tr>
                    <tr>
                        <td class="bold" width="70%">Total-DC</td>
                        <td class="bold">: {$dp_sno}</td>
                    </tr>
                    <tr>
                        <td class="bold" width="70%">Total-DD and DC</td>
                        <td class="bold">: {$dd_sno + $dp_sno}</td>
                    </tr>
                </table>
            </td>
            <td width="50%">
                <table cellpadding="2" width="100%">
                    <tr class="bold">
                        <td>Total Lorry Hire</td>
                        <td class="bold">: {$incomeexpense['HiringAmount']['amount']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Advance</td>
                        <td class="bold">: {$incomeexpense['AdvanceAmount']['amount']|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Balance</td>
                        <td class="bold">: {abs($incomeexpense['HiringAmount']['amount'] - $incomeexpense['AdvanceAmount']['amount'])|inr_format}</td>
                    </tr>
                    <tr>
                        <td class="bold">Driver Beta</td>
                        <td class="bold">: </td>
                    </tr>
                    <tr>
                        <td class="bold">Others</td>
                        <td class="bold">: 
                            {assign var="othercharges" value=0}
                            {foreach from=$incomeexpense item=row key=k}
                                {if !in_array($k, ['HiringAmount', 'AdvanceAmount'])}
                                    {assign var="othercharges" value=$othercharges+$row['amount']}
                                {/if}
                            {/foreach}
                            {$othercharges|inr_format}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <div class="print-footer">
        <table class="border-outline" cellpadding="3" width="100%">
            <tr>
                <td align="" width="33%" class="bold">Printed On : {$smarty.now|date_format:$ns_datetime_format}</td>
                <td align=" " width="35%" class="bold">Booked by : {$usr_login_name}</td>
                <td align="" width="32%" class="bold">Booked Date & Time: {$ogpl->tripDate|date_format:"%d-%b-%Y"}</td>
            </tr>
        </table>
    </div>
</body>
<style>
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

        @page {
            @bottom-center {
                content: element(footer);
            }
        }

        .print-footer {
            position: fixed;
            bottom: 10px;
            width: 97.5%;
            text-align: center;
            font-size: 10px;
            color: #333;
        }
    }

    @page {
        size: A4 portrait;
    }
</style>

</html>
