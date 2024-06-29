<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tax Invoice</title>

    <style>
        table {
            border-collapse: collapse;
        }
    </style>
</head>

<body>
    <table border="1" width="100%" cellpadding="5">
        <tbody>
            <tr>
                <td colspan="2" align="center"><h2 style="margin: 10px;">TAX INVOICE</h2></td>
            </tr>
            <tr>
                <td width="50%">
                    <b>{$nsprofile->name}</b><br>
                    {$nsprofile->namespaceProfile->address},&nbsp;{$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                </td>
                <td width="50%">
                    <b>DATE: </b> {$summary->bookedAt|date_format:$ns_date_format}<br>
                    <b>INVOICE NUMBER:</b> {$summary->code}<br><br><br>
                </td>
            </tr>
            <tr>
                {if in_array($payment_type_code, ['PAD', 'INP', 'OATP'])}
                    {assign var="payableby" value='CONSIGNOR'}
                    {assign var="client" value=$summary->fromCustomer}
                    {assign var="clientaddress" value=$summary->fromCustomerAddress}
                    {assign var="clientgst" value=$summary->fromCustomerGST}
                {elseif $payment_type_code == 'TOP'}
                    {assign var="payableby" value='CONSIGNEE'}
                    {assign var="client" value=$summary->toCustomer}
                    {assign var="clientaddress" value=$summary->toCustomerAddress}
                    {assign var="clientgst" value=$summary->toCustomerGST}
                {/if}
                <td width="50%">
                    <b>GSTIN:</b> {$summary->tax->gstin}<br>
                    <b>PAN:</b> AEGFS0975Q<br>
                    <b>SAC/HSN CODE:</b> 99651<br>
                    <b>TAX PAYABLE ON REVERSE CHARGE(YES/NO):</b> YES<br>
                    <b>TAX PAYABLE BY :</b> {$payableby}<br>
                </td>
                <td width="50%">
                    <b>CLIENT NAME:</b> {$client->name}<br>
                    <b>ADDRESS:</b> {$clientaddress->name|default:'-'}<br>
                    <b>STATE AND STATE CODE:</b> {$clientaddress->name|default:'-'}<br>
                    <b>GSTIN:</b> {$clientgst}<br><br><br>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">SERVICE CHARGES FROM {$summary->bookedAt|date_format:$ns_date_format} TO {$summary->bookedAt|date_format:$ns_date_format}</td>
            </tr>
            <tr>
                <td width="50%" align="center">DESCRIPTION</td>
                <td width="50%" align="center">BILLED AMOUNT</td>
            </tr>
            <tr>
                <td width="50%">CHARGES FOR TRANSPORTATION OF GOODS</td>
                {assign var="totalfreight" value=($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value)}
                <td width="50%" align="center">{$totalfreight|number_format:2}</td>
            </tr>
            <tr>
                <td width="50%"><b>TOTAL AMOUNT PAYABLE</b></td>
                <td width="50%" align="center">{$totalfreight|number_format:2}</td>
            </tr>
            <tr>
                <td width="50%">&nbsp;</td>
                <td width="50%" align="center"></td>
            </tr>
            <tr>
                <td width="50%"><i>TAX PAYABLE ON REVERSE CHARGE*</i></td>
                <td width="50%" align="center">{percentageOf(5, $summary->totalAmount)|inr_format}</td>
            </tr>
            <tr>
                <td width="50%">&nbsp;</td>
                <td width="50%" align="center"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <u><b>*NOTE:-</b></u> Tax payable on reverse charge is paid by the receiever of services directly while filing their GST returns on reverse charge mechanism,
                    Thus they need not pay us(SBRS EXPRESS CARGO) the tax amount. The liability of tax payable will be shown in their GST return.
                    <u><b>TAX PAID ON RCM IS AVAILABLE AS INPUT TAX CREDIT</b></u>
                </td>
            </tr>
            <tr>
                <td width="50%">
                    <b>Account Details:-</b><br>
                    <b>A/c No:-</b> 0432102000009584<br>
                    <b>A/c Name:-</b> SBRS EXPRESS CARGO<br>
                    <b>Bank name :-</b> IDBI BANK<br>
                    <b>Branch:-</b> GACHIBOWLI<br>
                    <b>IFSC:-</b> IBKL0000432<br>
                    Cheques Payable to SBRS EXPRESS CARGO
                </td>
                <td width="50%">
                    For SBRS EXPRESS CARGO<br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    Authorised Signatory
                </td>
            </tr>
        </tbody>
    </table>

    <script>
        print();
    </script>
</body>

</html>
