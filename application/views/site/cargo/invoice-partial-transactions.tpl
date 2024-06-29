
{strip}
    <table style="padding:5px 4px;">
        <tr>
            <td align="center" style="font-weight:bold;font-size: 12px;">
                Invoice
            </td>
        </tr>
        <tr>
            <td align="center" style="font-weight:bold;font-size: 12px;">
                {$namespace_name}
                {if $namespace == 'newlinetrans'}
                    {if (isset($details->organization->code) && $details->namespaceTax->gstin == '24AFWPB7880E2Z5') || (isset($stategst[$nsprofile->state->code]) && $stategst[$nsprofile->state->code]->gstin == '24AFWPB7880E2Z5')}
                        <br><span style="font-weight:400; font-size: 8px;">Survey No 333/3 Kataria estate near St.joseph school
                        <br>Vapi karvad road Vapi-396191
                        <br>Mobile No: 8155052015,9328022015,9375281007</span>
                    {elseif (isset($details->organization->code) && $details->namespaceTax->gstin == '33ASPPP1771N1Z4') || (isset($stategst[$nsprofile->state->code]) && $stategst[$nsprofile->state->code]->gstin == '33ASPPP1771N1Z4')}
                        <br><span style="font-weight:400; font-size: 8px;">94/1 Kanjampalayam Road, Ragavendra Dyeing Cross, Kanjampalayam,
                        <br>Near JV Tapes HO, TIRUPUR - 641607
                        <br>Mobile No: 9047084593,9487284593,6380026758</span>
                    {/if}
                {/if}
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 72%;" colspan="2">
                {foreach item=row from=$vendors}
                    {if $row->code == ($details->user->username|upper)}
                        {assign var="companyName" value=$row->companyName}
                        {assign var="gst" value=$row->gst}
                        {assign var="address1" value=$row->vendorAddress->address1}
                        {break}
                    {/if}
                {/foreach}
                <b>Bill To</b><br/>
                M/S&nbsp;&nbsp;{$companyName}<br/>
                {$address1}<br/>
                GST NO :&nbsp;{$gst}<br/>
            </td>
            <td align="left" style="width: 28%;">
                <b>Bill From</b><br/>
                {if isset($details->organization->code)}
                    {$details->organization->address1}, {if isNotNull($details->organization->address2)}{$details->organization->address2},{/if} {$details->organization->station->name},<br/>{$details->organization->station->state->name} - {$details->organization->pincode}.<br/>
                    GSTIN :&nbsp;{$details->namespaceTax->gstin}<br/>
                {else}
                    {$nsprofile->address},{$nsprofile->city},<br />{$nsprofile->state->name}-{$nsprofile->pincode}.<br />
                    {if $namespace == "ybmlogistics"}
                        GSTIN :&nbsp;33AAACY9745M1ZQ<br/>
                    {elseif $namespace == "nationalchn"}
                        GSTIN :&nbsp;33ANTPK9785A2ZJ<br/>
                    {elseif $namespace == "rktparcel"}
                        {if $summary->fromStation->code == 'STF3OEX206'}
                            GSTIN :&nbsp; 29AAZFR4180P1ZY<br/>
                        {else}
                            GSTIN :&nbsp;  33AAZFR4180P1Z9<br/>
                        {/if}
                    {elseif $namespace == "luckycargoes"}
                        GSTIN :&nbsp;  37AAECL1582H1ZF<br/>
                    {elseif isset($stategst[$nsprofile->state->code])}
                        GSTIN :&nbsp;  {$stategst[$nsprofile->state->code]->gstin}<br/>
                    {/if}
                {/if}
                {if isNotNull($details->userTaxDetails->panCardCode)}
                    PAN :&nbsp;{$details->userTaxDetails->panCardCode}<br/>
                {/if}
                <br/>
                {if $namespace == "rktparcel"}
                    Invoice #:&nbsp;{$details->code}<br/>
                    Invoice Date:&nbsp;{$details->transactionDate|date_format:$ns_date_format}<br/>
                    <br>
                    Accounts Office Ph.No:<br>7373011660 / 9047511660
                {else}
                    Invoice #:&nbsp;{$details->code}<br/>
                    Invoice Date:&nbsp;{$details->transactionDate|date_format:$ns_date_format}<br/>
                {/if}
            </td>

        </tr>
    </table>
{/strip}
<br/>
<br/>
<table style="padding:5px 4px;" align="center">
    <thead>
        <tr style="font-weight:bold; background-color: #E8E8E8;">
            <th align="center" style="border: 1px solid #000000;width: 18%;">{lang('lr')} No</th>
            <th align="center" style="border: 1px solid #000000;width: 11%;">Booked Date</th>
            <th align="center" style="border: 1px solid #000000;width: 20%;">{lang('booking_from_term')}</th>
            <th align="center" style="border: 1px solid #000000;width: 20%;">{lang('booking_to_label')}</th>
            <th align="center" style="border: 1px solid #000000;width: 16%;">User</th>
            <th align="center" style="border: 1px solid #000000;width: 5%;">Qty</th>
            <th align="center" style="border: 1px solid #000000;width: 10%;">Payable</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=total value=0}
        {assign var=total_lr value=0}
        {assign var=total_qty value=0}
        {foreach item=row key=k from=$result}
            <tr>
                <td align="left" style="border: 1px solid #000000;width: 18%;">{$row->cargo_code}</td>
                <td align="left" style="border: 1px solid #000000;width: 11%;">{$row->booked_at|date_format:$ns_date_format}</td>
                <td align="left" style="border: 1px solid #000000;width: 20%;">{$row->from_organization_name}</td>
                <td align="left" style="border: 1px solid #000000;width: 20%;">{$row->to_organization_name}</td>
                <td align="left" style="border: 1px solid #000000;width: 16%;">{$row->user_name}</td>
                <td align="center" style="border: 1px solid #000000;width: 5%;">{$row->total_item_count}</td>
                <td align="right" style="border: 1px solid #000000;width: 10%;">{round($row->transaction_amount-$row->commission_amount)|number_format:2}</td>
            </tr>
            {assign var=total value=$total+round($row->transaction_amount-$row->commission_amount)}
            {assign var=total_lr value=$k+1}
            {assign var=total_qty value=$total_qty+($row->total_item_count)}
        {foreachelse}
            <tr>
                <td colspan="7" align="center" style="border: 1px solid #000000;width: 100%;">No Records Found!</td>
            </tr>
        {/foreach}
        {* {if $result|count} *}
            <tr style="font-weight:bold;">
                <td align="right" style="border-left: 1px solid #000000;border-bottom: 1px solid #000000;">Total Consignment</td>
                <td align="left" style="border-bottom: 1px solid #000000;">{$total_lr}</td>
                <td align="right" style="border-bottom: 1px solid #000000;">Total Quantity</td>
                <td align="left" style="border-bottom: 1px solid #000000;">{$total_qty}</td>
                <td align="right" style="border-bottom: 1px solid #000000;">Total Amount (A)</td>
                <td align="left" colspan="2" style="border-bottom: 1px solid #000000;border-right: 1px solid #000000;">{$total|number_format:2}</td>
            </tr>
        {* {/if} *}

    </tbody>
</table>
<br>
<h4>Other Income / Expense</h4>
<table style="padding:5px 4px;">
    <thead>
        <tr style="font-weight:bold; background-color: #E8E8E8;">
            <th style="border: 1px solid #000000;">Name</th>
            <th style="border: 1px solid #000000;">Income / Expense</th>
            <th style="border: 1px solid #000000;">Rate</th>
        </tr>
    </thead>
    <tbody>
        {assign var=extra_chrg_total value=0}
        {foreach from=$income_expense item=row}
            <tr>
                <td style="border: 1px solid #000000;">{$row->name}</td>
                <td style="border: 1px solid #000000;">
                    {if $row->transactionType == 'EX'}
                        Expense
                    {elseif $row->transactionType == 'IN'}
                        Income
                    {/if}
                </td>
                <td align="right" style="border: 1px solid #000000;">
                    {if $row->transactionType == 'EX'}
                        -{$row->value|number_format:2}
                    {elseif $row->transactionType == 'IN'}
                        {$row->value|number_format:2}
                    {/if}
                </td>
            </tr>
            
            {if $row->transactionType == 'EX'}
                {assign var=extra_chrg_total value=$extra_chrg_total-$row->value}
            {elseif $row->transactionType == 'IN'}
                {assign var=extra_chrg_total value=$extra_chrg_total+$row->value}
            {/if}
        {foreachelse}
            <tr>
                <td colspan="3" align="center" style="border: 1px solid #000000;">No Records Found!</td>
            </tr>
        {/foreach}
        {* {if $income_expense|count} *}
            <tr style="font-weight:bold;">
                <td align="right" colspan="2" style="border-bottom: 1px solid #000000;border-left: 1px solid #000000;">Total Amount (B)</td>
                <td align="right" style="border-bottom: 1px solid #000000;border-right: 1px solid #000000;">{$extra_chrg_total|number_format:2}</td>
            </tr>
        {* {/if} *}

        <tr style="font-weight:bold;">
            <td align="right" colspan="2" style="border-bottom: 1px solid #000000;border-left: 1px solid #000000;">Net Amount (A + B)</td>
            <td align="right" style="border-bottom: 1px solid #000000;border-right: 1px solid #000000;">{round($total+$extra_chrg_total)|number_format:2}</td>
        </tr>
    </tbody>
</table>
<br>
<table style="padding:5px 0px;">
    <tr>
        <td width="9%"><b>SAC Code</b></td>
        <td align="left" width="10%">996511</td>
        <td width="14%" align="left"><b>Amount In Words</b></td>
        <td align="left" width="67%" nowrap>{($total+$extra_chrg_total)|amount_in_words|ucwords}</td>
    </tr>
</table>
{if $namespace == "dishashree"}
    <br><br>
    <table>
        <tr>
            <td align="center" width="40%">
                <table cellpadding="2">
                    <tr style="background-color: #E8E8E8; border: 1px solid #000000;">
                        <td align="center" class="bold" style="font-size: 10px; border: 1px solid #000000;">Bank Details</td>
                    </tr>
                    <tr>
                        <td align="left" style="border: 1px solid #000000;">
                            <b>Account Holder :</b>&nbsp;DISHA SHREE TRANSSPORTS
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="border: 1px solid #000000;">
                            <b>Account Number :</b>&nbsp;50200074509780
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="border: 1px solid #000000;">
                            <b>IFSC :</b>&nbsp;HDFC0005908
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="border: 1px solid #000000;">
                            <b>Bank Branch :</b>&nbsp;TD ROAD KOCHI
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="border: 1px solid #000000;">
                            <b>Account Type :</b>&nbsp;CURRENT
                        </td>
                    </tr>
                </table>
            </td>
            <td align="center">
                <p> Gst RCM and exemption rules.<br>
                    This is computer generated invoice signature not required.</p>
            </td>
        </tr>
    </table>
{else}
    <table>
        <tr>
            <td align="center">
                <p> Gst RCM and exemption rules.<br>
                    This is computer generated invoice signature not required.</p>
            </td>
        </tr>
    </table>
{/if}

{if $namespace == "rktparcel"}
    <br><br>
    <footer>
        <table width="100%">
            <tr>
                <td width="50%">
                    <table style="padding:5px 4px;" align="center" width="100%">
                        <thead>
                            <tr style="font-weight:bold; background-color: #E8E8E8;">
                                <th align="center" style="border: 1px solid #000000;" colspan="2">Bank Details</th>
                            </tr>
                        </thead>
                        <tbody class="body_table">
                            <tr>
                                <td align="center" style="border: 1px solid #000000;">Name</td>
                                <td align="center" style="border: 1px solid #000000;">RKT SPEED PARCEL SERVICES</td>
                            </tr>
                            <tr>
                                <td align="center" style="border: 1px solid #000000;">Current Ac. No</td>
                                <td align="center" style="border: 1px solid #000000;">510909010174793</td>
                            </tr>
                            <tr>
                                <td align="center" style="border: 1px solid #000000;">IFSC</td>
                                <td align="center" style="border: 1px solid #000000;">CIUB0000153</td>
                            </tr>
                            <tr>
                                <td align="center" style="border: 1px solid #000000;">Bank</td>
                                <td align="center" style="border: 1px solid #000000;">CITY UNION BANK</td>
                            </tr>
                            <tr>
                                <td align="center" style="border: 1px solid #000000;">Branch</td>
                                <td align="center" style="border: 1px solid #000000;">Tiruchirapalli Contonment Branch - 620001</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td width="5%"></td>
                <td width="20%">
                    <br><br>
                    <table style="padding:2px;" align="center" width="100%">
                        <tr>
                            <td align="center" class="border-right"><span style="font-size: 10px;">Scan and Pay</span><br>
                            <img src="{$base_url}qr?{http_build_query(['data' => $upiUrl])}" width="90px">
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="5%"></td>
                <td width="20%">
                    <br>
                    <h3>FOR BOOKING ENQUIRY </h3>
                    <br>
                    <h4 style="font-weight:normal;">Tirchy    -9092211660</h4>
                    <h4 style="font-weight:normal;">Bangalore -7825911660</h4>
                    <h4 style="font-weight:normal;">Chennai   -9750961353</h4>
                </td>
            </tr>
        </table>
    </footer>
{/if}