<style>
    .bold {
        font-weight: bold;
    }

    .bordered,
    .bordered tr th,
    .bordered tr td {
        border: 1px solid #000000;
    }

    .tax-invoice {
        text-align: center;

    }

    .print-footer {
        position: fixed;
        bottom: 0;
        text-align: center;
        border-top: 1px solid #000000;
    }

    .spanE {
        position: fixed;
        right: 0;
    }

    .headerImage {
        width: 200px;
        height: 50px;
    }
   
    .hide {
        display: none;
    }

</style>

{strip}
    <table class="bordered">
        <tr>
            <td align="center" colspan="8">
                <br><br><img src="assets/img/rajeshcargo-logo.png" alt="Header Image" class="headerImage">
            </td>
        </tr>
    </table>
{/strip}

<div class="tax-invoice">
    <h3>TAX INVOICE</h3>
    <table class="bordered">
        <tr>
            <td colspan="2" style="border:none;" align="right">Reverse Charge:</td>
            <td colspan="5" style="border:none;" align="left"><b>No</b></td>
            <td colspan="1" style="border:none;"></td>
            <td colspan="2" align="center"></td>
            <td colspan="2" align="left">Original</td>
        </tr>
        <tr>
            <td colspan="2" style="border:none;" align="right">Invoice No :</td>
            <td colspan="5" style="border:none;" align="left"><b>{$details->code}</b></td>
            <td colspan="1" style="border:none;"></td>
            <td colspan="2" align="center"><b></b></td>
            <td colspan="2" align="left">Duplicte</td>
        </tr>
        <tr>
            <td colspan="2" style="border:none;" align="right">Invoice Date :</td>
            <td colspan="5" style="border:none;" align="left"><b>{$details->transactionDate|date_format:"%d-%b-%Y %I:%M %p"}</b></td>
            <td colspan="1" style="border:none;"></td>
            <td colspan="2" align="center"></td>
            <td colspan="2" align="left">Triplicate</td>
        </tr>
        <tr>
            <td colspan="2" style="border:none;" align="right">State Name :</td>
            <td colspan="5" style="border:none;" align="left"><b>{$nsprofile->state->name|trim}</b></td>
            <td colspan="5" style="border:none;"></td>
        </tr>
        <tr>
            <td colspan="2" style="border:none;" align="right">State Code :</td>
            <td colspan="5" style="border:none;" align="left"><b>{$nsprofile->pincode|trim}</b></td>
            <td colspan="5" style="border:none;"></td>
        </tr>
    </table>
    <h3 align="left">Billed to:</h3>
    <table class="bordered">
        {foreach item=row from=$vendors}
            {if $row->code == ($details->user->username|upper)}
                {assign var="companyName" value=$row->companyName}
                {assign var="gst" value=$row->gst}
                {assign var="address1" value=$row->vendorAddress->address1}
                {assign var="stateName" value=$row->vendorAddress->station->name}
                {assign var="pinCode" value=$row->vendorAddress->pincode}
                {break}
            {/if}
        {/foreach}
        <tr>
            <td colspan="2" style="border:none;" align="right">Name :</td>
            <td colspan="3" style="border:none;" align="left"><b>{$companyName|trim}</b></td>
            <td colspan="7" style="border:none;"></td>
        </tr>
        <tr>
            <td colspan="2" style="border:none;" align="right">Address :</td>
            <td colspan="5" style="border:none;" align="left"><b>{$address1|trim}</b></td>
            <td colspan="5" style="border:none;"></td>
        </tr>
        <tr>
            <td colspan="2" style="border:none;" align="right">GSTIN / Pan No :</td>
            <td colspan="3" style="border:none;" align="left"><b>{$gst|trim}</b></td>
            <td colspan="7" style="border:none;"></td>
        </tr>
        <tr>
            <td colspan="2" style="border:none;" align="right">State Name :</td>
            <td colspan="3" style="border:none;" align="left"><b>{$stateName|trim}</b></td>
            <td colspan="7" style="border:none;"></td>
        </tr>
        <tr>
            <td colspan="2" style="border:none;" align="right">State Code :</td>
            <td colspan="4" style="border:none;" align="left"><b>{$pinCode|trim}</b></td>
            <td colspan="6" style="border:none;"></td>
        </tr>
        <tr class="hide">
            <td colspan="2" style="border:none;"></td>
            <td colspan="4" style="border:none;"></td>
            <td colspan="6" style="border:none;"></td>
        </tr>
        <tr class="hide">
            <td colspan="2" style="border:none;"></td>
            <td colspan="4" style="border:none;"></td>
            <td colspan="6" style="border:none;"></td>
        </tr>
        <tr class="hide">
            <td colspan="2"style="border:none;"></td>
            <td colspan="4"style="border:none;"></td>
            <td colspan="6"style="border:none;"></td>
        </tr>
    </table>
    <br><br>
    <table class="bordered">
        <thead>
            <tr class="bold">
                <td>SI No</td>
                <td colspan="2" align="center">Date</td>
                <td colspan="2" align="center">LR Number</td>
                <td colspan="2" align="center">SOURCE</td>
                <td colspan="2" align="center">DESTINATION</td>
                <td>ARTICLES</td>
                <td colspan="2" align="center">Taxable</td>
            </tr>
        </thead>
        <tbody>
            {assign var="counter" value=1}
            {foreach item=row key=k from=$result}
                <tr>
                    <td align="center">{$counter}</td>
                    <td colspan="2" align="center">{$row->booked_at|date_format:$ns_date_format}</td>
                    <td colspan="2" align="center">{$row->cargo_code}</td>
                    <td colspan="2" align="center">{$row->from_organization_name}</td>
                    <td colspan="2" align="center">{$row->to_organization_name}</td>
                    <td>{$row->total_item_count}</td>
                    <td colspan="2" align="center">{round($row->transaction_amount-$row->commission_amount)|number_format:2}
                    </td>
                </tr>
                {assign var="counter" value=$counter+1}
            {/foreach}
        </tbody>
    </table>
    <br><br>
    <table class="bordered">
        {assign var="totalAmount" value=($cgstAmount + $sgstAmount + $igstAmount + $total)|round:0}
        {assign var="totalAmountInWords" value=$totalAmount|amount_in_words|ucwords}
        <tr>
            <td rowspan="2" colspan="6" align="left"><b>Total Amount in Words :</b>{$totalAmountInWords}</td>
            <td colspan="4" align="right">Taxable Amount</td>
            <td colspan="2" align="left">{$totalAmount}</td>
        </tr>
        <tr>
            <td colspan="4" align="right">Add : CGST @ 2.5%</td>
            <td colspan="2" align="left">{$cgstAmount}</td>
        </tr>
        <tr>
           <td colspan="6" align="left"><b>Bank Accounts Details:</b></td>
            <td colspan="4" align="right">Add : CGST @ 2.5%</td>
            <td colspan="2" align="left">{$sgstAmount}</td>
        </tr>
        <tr>
            <td colspan="2">Bank Account Name :</td>
            <td colspan="4" align="left">RAJESH TRANSPORTS</td>
            <td colspan="4" align="right">Add : IGST @ 5%</td>
            <td colspan="2" align="left">{$igstAmount}</td>
        </tr>
        <tr>
            <td colspan="2">Bank Account Number :</td>
            <td colspan="4" align="left">1302135000005555</td>
            <td colspan="4" align="right">Total Tax Amount</td>
            <td colspan="2" align="left">{$cgstAmount+$sgstAmount+$igstAmount}</td>
        </tr>
        <tr>
            <td colspan="2">Bank Name :</td>
            <td colspan="4" align="left">KARUR VYSYA BANK</td>
            <td colspan="4" align="right">Total Amount</td>
            <td colspan="2" align="left">{$cgstAmount + $sgstAmount + $igstAmount + $total}</td>
        </tr>
        <tr>
            <td colspan="2">Branch Name :</td>
            <td colspan="4" align="left">J C ROAD</td>
            <td colspan="4" align="right">Rounded Off</td>
            <td colspan="2" align="left">{round($cgstAmount + $sgstAmount + $igstAmount + $total)|number_format:2} </td>
        </tr>
        <tr>
            <td colspan="2"> IFSC Code :</td>
            <td colspan="4" align="left">KVBL0001302</td>
            <td colspan="4" align="right">Discount</td>
            <td colspan="2" align="left"> - </td>
        </tr>
        <tr>
            <td colspan="6">SAC Code :</td>
            <td colspan="4" align="right">Net Payable</td>
            <td colspan="2" align="left">{round($cgstAmount + $sgstAmount + $igstAmount + $total)|number_format:2}</td>
        </tr>
        <tr>
            <td rowspan="3" colspan="6">
                <table width="100%">
                    <tr>
                        <td align="left">Notes :-</td>
                    </tr>
                </table>
                <ol>
                    <li>Cheque or draft drawn in favour of " RAJESH TRANSPORTS "</li>
                    <li>TDS should be deductable 1 % on Basic Value under Section 194C </li>
                    <li>Payment Term: Wire Transferee </li>
                </ol>
            </td>
            <td rowspan="3" colspan="6" align="center">
                <span>FOR, RAJESH TRANSPORTS</span>
                <br>
                <br>
                <br>
                <br>
                <br>
                <span>(Authorized Signatory)</span>
            </td>
        </tr>
        <tr></tr>
        <tr></tr>
    </table>
    <p>Thanking you for the opportunity given us for your business requirements</p>
</div>
<table width="100%">
    <tr>
        <td align="right">[E&OE]</td>
    </tr>
</table>

<div class="print-footer">
    <h2>NO. 19, Basement Floor, A V Road, Kalasipalya, Bengaluru Urban, Karnataka, 560002</h2>
    <h2>Pan No :- AAVFR9980R, GSTIN No :- 29AAVFR9980R1ZG</h2>
    <h2>Mobile No :- +91 7353117777, E-mail ID :- info@rajeshtransports.in</h2>
</div>