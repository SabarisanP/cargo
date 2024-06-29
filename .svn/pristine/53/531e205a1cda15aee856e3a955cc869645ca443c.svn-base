<html>

<head>
    <title></title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .title {
            font-weight: bold;
            text-align: center;
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
    </style>
</head>

{$balance = 0}
<div class="print-border-left"></div>
<div class="print-border-right"></div>
<body style="overflow: hidden;">
    <table class="border-outline" width="100.7%" cellpadding="5">
        <tr class="bold">
            <td width="25%">
                &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" colspan="2" style="font-size: 20px;">
                Seenu Transports Pvt.Ltd.<br>
                <p>{$Payment_Branch->address1}</p>
                <span style="font-size: 18px;">Hire Challan</span>
            </td>
            <td width="25%"></td>
        </tr>
    </table>
    <table class="border-outline" cellpadding="5" width="100.7%">
        <tr>
            <td class="bold">Date</td>
            <td align="left" width="10%" colspan="2"><b> : </b>{$ogpl->tripDate|date_format:$ns_date_format}</td>
            <td align="right" class="bold" width="25%">Vehicle Category</td>
            <td align="left" class="bold"> : {$vehicle->ownershipType->name}</td>
            <td align="right" class="bold">HIRE CHALLAN NO</td>
            <td align="left" width="20%" class="bold" colspan="2">: {$ogpl->aliasCode}</td>
        </tr>
    </table>
    <table class="border-outline" style="border-bottom: 0;line-height: 25px;" cellpadding="5" width="100%"  height = "70%">
        <tr>
            <td class="bold" width="15%" nowrap>FROM BRANCH</td>
            <td align="left" width="15%" nowrap><b> : </b>{$ogpl->fromOrganization->name}</td>
            <td align="right" class="bold" width="15%" nowrap>TO BRANCH</td>
            <td width="15%" nowrap><b> : </b>{$ogpl->toOrganization->name}</td>
            <td width="20%"></td>
            <td width="15%"></td>
            <td width="5%"></td>
        </tr>
        <tr>
            <td class="bold" width="15%" align="left" nowrap>VIA FROM LOCATION</td>
            <td align="left" width="15%" nowrap><b> : </b>
                {foreach from=$ogpl->fromViaOrganization item=val key=k}
                    {$val->shortCode} {if $k < ($ogpl->fromViaOrganization|count)-1}, {/if}
                {/foreach}
            </td>
            <td class="bold" align="right" width="15%" nowrap>VIA TO LOCATION</td>
            <td align="left" width="15%" nowrap><b> : </b>
                {foreach from=$ogpl->toViaOrganization item=val key=k}
                    {$val->shortCode} {if $k < ($ogpl->toViaOrganization|count)-1}, {/if}
                {/foreach}
            </td>
            <td width="20%"></td>
            <td width="15%"></td>
            <td width="5%"></td>
        </tr>
        <tr>
            <td class="bold">TRUCK NO.</td>
            <td align="left"><b> : </b>{$vehicle->registationNumber}</td>
            <td align="right" class="bold">TON</td>
            <td align="left"><b> : </b>{$vehicle->loadCapacity}</td>
            <td align="right" class="bold">TOTAL HIRE</td>
            <td align="left" nowrap><b> : </b>{$incomeexpense['HiringAmount']['amount']|inr_format}</td>
            <td></td>
        </tr>
        <tr>
            <td class="bold" nowrap>DRIVER NAME 1</td>
            <td align="left" nowrap><b> : </b>{$ogpl->vehicleDriver->name} -
                <b>{$ogpl->vehicleDriver->mobileNumber|default:'NIL'}</b>
            </td>
            <td></td>
            <td align="right" class="bold" nowrap colspan="2">1. OFFICE ADVANCE BY CASH</td>
            <td align="left" class="border-bottom" nowrap><b> :
                </b>{$incomeexpense['AdvanceAmount']['amount']|inr_format}</td>
            <td></td>
        </tr>
        <tr>
            <td class="bold" nowrap>DRIVER NAME 2</td>
            <td align="left" colspan="2"><b> : </b>{$ogpl->secondaryDriver->name|default:'NIL'} -
                <b>{$ogpl->secondaryDriver->mobileNumber|default:'NIL'}</b>
            </td>
            <td></td>
            <td align="right" class="bold">BALANCE</td>
            {$balance = $balance + ($incomeexpense['HiringAmount']['amount'] - $incomeexpense['AdvanceAmount']['amount'])}
            <td align="left" class="bold"> :
                {if ($incomeexpense['HiringAmount']['amount'] - $incomeexpense['AdvanceAmount']['amount']) >0 }{($incomeexpense['HiringAmount']['amount'] - $incomeexpense['AdvanceAmount']['amount'])|inr_format}{else}{/if}
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td align="right" colspan="2" class="bold" nowrap>2. OFFICE ADVANCE BY DIESEL</td>
            <td align="left" colspan="2"><b> : </b></td>
        </tr>
        <tr>
            <td class="bold" nowrap>D.L No.</td>
            <td align="left" nowrap><b> : </b>{$ogpl->vehicleDriver->licenseNumber|default:'NIL'}</td>
            <td colspan="2"></td>
            <td align="right">
                <table class="bordered" cellpadding="3" width="{if count($fuelexpense) == 1}95%{else}65%{/if}">
                    {foreach $fuelexpense as $fuelData}
                    <tr class="bold">
                        <td noerap>LTR</td>
                        <td align="right" nowrap>{$fuelData['litres']|inr_format}</td>
                        <td nowrap>Rate Per LTR</td>
                        <td align="right" nowrap>{$fuelData['pricePerLitre']|inr_format}</td>
                    </tr>
                    {/foreach}
                </table>
            </td>
            <td colspan="1" class="bold border-bottom" nowrap>
                {foreach $fuelexpense as $fuelData}
                    {foreach $fuelData['totalAmount'] as $amount}
                        {$amount|inr_format}<br>
                    {/foreach}
                {/foreach}
            </td>
        </tr>
        <tr>
            <td class="bold" nowrap>OWNER NAME</td>
            <td align="left" nowrap><b> : </b>{$vehicle->transporterContact->name|default:'NIL'}</td>
            <td colspan="2"></td>
            <td align="right" class="bold" nowrap>TOTAL BALANCE</td>
            <td align="left" class="bold border-top" nowrap>

            {if !empty($fuelexpense)}
                    {if count($fuelexpense) > 1}
                        {abs($balance - ($fuelexpense[0]['totalAmount'] + $fuelexpense[1]['totalAmount']))|inr_format}
                    {else}
                        {abs($balance - $fuelexpense[0]['totalAmount'])|inr_format}
                    {/if}
                {else}
                    N/A
                {/if}
            </td>
        </tr>
        <tr>
            <td class="bold" nowrap>DELIVERY DETAILS</td>
            <td align="left" class="bold border-bottom"> :</td>
            <td colspan="2"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr style = "line-height: 10px;">
            <td class="bold" nowrap>DEPARTURE DATE & TIME</td>
            <td align="left" nowrap><b> : </b>
                {* {assign var="departure" value='+'|cat:$ogpl->departureMinutes|cat:' minutes'}
                {strtotime($departure, strtotime($ogpl->tripDate))|date_format:'d-m-Y H:i A'} *}
                {foreach $odometer as $singleOdometer}
                  {if $singleOdometer->departureAt}
                    {$singleOdometer->departureAt|date_format:$ns_datetime_format}
                    {break}
                    {/if}
                {/foreach}
            </td>
            <td colspan="1"></td>
            <td align="left" class="bold" nowrap>Petrol Pump Vendor Name</td>
            <td align="left" nowrap><b> : </b>
                {foreach $fuelexpense as $key => $fuelData}
                    {if $key != 0}, {/if}{$fuelData['vendor']}
                {/foreach}
            </td>
            <td></td>
        </tr>
        <tr style = "line-height: 10px;">
            <td colspan="3"></td>
            <td align="left" class="bold" nowrap>Petrol Pump Coupon No.</td>
            <td align="left" nowrap><b> : </b>
                {foreach $fuelexpense as $key => $fuelData}
                    {if $key != 0}, {/if}{$fuelData['coupon']}
                {/foreach}
            </td>
            <td></td>
        </tr>
    </table>
    <table class="border-outline print-footer-top" cellpadding="3" width="100.7%">
<tr >
<td class="bold"  width = "40%" align = "left">C.C SIGN WITH SEAL  :</td>
<td class="bold"  width = "55%" align = "left">DRIVER SIGN   :</td>
</tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr>
<td class="bold" colspan="4" nowrap>Note:No Halting Charges on Sunday and other Festival Holidays</td>
<td colspan="3"></td>
</tr>
</table>
<table class="print-Footer border-outline" cellpadding="3" width="100.7%">
<tr>
   {foreach $ogpl->transitRoutes as $row}
       {if isset($row->createdAt)}
           <td align="left" width="25%" class="bold">Booked Date & Time : {$row->createdAt|date_format:$ns_datetime_format}</td>
           {break}
       {/if}
   {/foreach}
   <td align="center" width="20%" class="bold">Booked By: {$ogpl->audit->user->name|default:'-'} </td>
   <td align="right" width="15%" class="bold">Printed By : {$usr_login_name}</td>
   <td align="right" width="25%" class="bold">Printed At : {$smarty.now|date_format:$ns_datetime_format}</td>
</tr>
</table>
</body>




     
<style>
    body {
        width: unset;
    }
    div{
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

        .title {
            display: none;
        }

        /* .print-Footer{
            position:fixed;
            bottom: 0px;
        } */

        .print-footer-top {
            border-top: none !important;
        }

        /* .print-footer-top{
            position:fixed;
            bottom: 20px;
        } */

        /* .print-border-left,
        .print-border-right {
            position: fixed;
            top: 6px;
            height: 96%;
            width: 1px;
            background-color: #000;
            z-index: 1;
        }

        .print-border-left {
            left: 7px;

        }

        .print-border-right {
            right: 0px;

        }
         */
    }

    @page {
        size: A4 landscape;
    }
</style>

</html>