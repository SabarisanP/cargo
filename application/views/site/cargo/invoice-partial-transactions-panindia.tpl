<style>
    .border { border-top: 1px solid #666; border-right: 1px solid #666; border-bottom: 1px solid #666; border-left: 1px solid #666;}
    .border-top { border-top: 1px solid #666; }
    .border-right { border-right: 1px solid #666; }
    .border-bottom { border-bottom: 1px solid #666; }
    .border-left { border-left: 1px solid #666; }
    .font-10 { font-size: 10px;}
    .heading { font-size: 11px; text-decoration: underline;}
    .bold { font-weight: bold;}
</style>

{strip}
    <table  class="border" width="100%" cellpadding="2">
        <tr>
            <td colspan="3" rowspan="3"><img src="assets/img/panindia.jpeg" alt="Header Image" style="max-width: 100%;"></td>
            <td class="bold heading" align="center" colspan="9"><br><br>PAN INDIA LOGISTICS</td>
        </tr><br>
        <tr>
            <td align="right" colspan="9"><b>Registered Office :</b> New No.75, Old No.56B, Perumal Agaram, Thiruverkadu, Chennai - 600077.</td>
        </tr>
        <tr>
            <td align="right" colspan="9">Mob# 9840303640, Web# www.panindialogistics.com, Email# accounts@panindialogistics.com.</td>
        </tr>
        <tr>
            <td class="border-top" align="center" colspan="12">INVOICE</td>
        </tr>
        <tr>
            <td colspan="8" class="border-top">Customer Address</td>
            <td colspan="4" rowspan="2" class="border-left border-top">
                <table cellpadding="2">
                    <tr>
                        <td class="border-right border-bottom"><br><br>Invoice Number</td>
                        <td class="border-bottom"><br><br>{$details->code}</td>
                    </tr>
                    <tr>
                        <td class="border-right"><br><br>Inv Date</td>
                        <td><br><br>{$details->transactionDate|date_format:$ns_date_format}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="8">
            {foreach item=row from=$vendors}
                {if $row->code == ($details->user->username|upper)}
                    {assign var="companyName" value=$row->companyName}
                    {assign var="gst" value=$row->gst}
                    {assign var="address1" value=$row->vendorAddress->address1}
                    {break}
                {/if}
            {/foreach}
                <b>{$companyName}</b><br>
                {$address1}<br>
                <b>GST NO:&nbsp;{$gst}</b>
            </td>
        </tr>
        <tr>
            <td colspan="12" class="border-top">
                <table cellpadding="1" width="100%">
                    <thead>
                        <tr>
                            <td class="border-right" align="center" width="3%">Sl no</td>
                            <td class="border-right" align="center" width="8%">Docket No</td>
                            <td class="border-right" align="center" width="8%">Booking Date</td>
                            <td class="border-right" align="center" width="13%">Bkg Stn</td>
                            <td class="border-right" align="center" width="13%">Dly Stn</td>
                            <td class="border-right" align="center" width="5%">Rate per Kg</td>
                            <td class="border-right" align="center" width="5%">No of Art</td>
                            <td class="border-right" align="center" width="5%">Charged Weight</td>
                            <td class="border-right" align="center" width="5%">Freight Amt</td>
                            <td class="border-right" align="center" width="5%">Docket Ch</td>
                            <td class="border-right" align="center" width="5%">FOV Ch</td>
                            <td class="border-right" align="center" width="5%">FSC Ch</td>
                            <td class="border-right" align="center" width="5%">Delivery Ch</td>
                            <td class="border-right" align="center" width="5%">Handling Ch</td>
                            <td class="border-right" align="center" width="5%">Door Collection Ch</td>
                            <td class="" align="center" width="5%">Total Ch</td>
                        </tr>
                    </thead>
                    <tbody>
                        {assign var=total value=0}
                        {assign var=grand_total value=0}
                        {assign var=service_tax value=0}
                        {assign var=round_off value=0}
                        {foreach item=row key=k from=$result}
                            <tr>
                                <td align="center" class="border-top border-right" width="3%">{$k+1}</td>
                                <td align="center" class="border-top border-right" width="8%">{$row->cargo_code}</td>
                                <td align="center" class="border-top border-right" width="8%">{$row->booked_at|date_format:$ns_date_format}</td>
                                <td align="center" class="border-top border-right" width="13%">{$row->from_station_name}</td>
                                <td align="center" class="border-top border-right" width="13%">{$row->to_station_name}</td>
                                <td align="center" class="border-top border-right" width="5%">
                                    {if ($row->unit_code == "KG")}
                                        {$row->item_freight|inr_format}
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="center" class="border-top border-right" width="5%">{$row->total_item_count}</td>
                                <td align="center" class="border-top border-right" width="5%">{$row->total_unit_value}</td>
                                <td align="center" class="border-top border-right" width="5%">{$row->total_amount|inr_format}</td>
                                <td align="center" class="border-top border-right" width="5%">{$row->docket_charge|inr_format}</td>
                                <td align="center" class="border-top border-right" width="5%">{$row->fov_charge|inr_format}</td>
                                <td align="center" class="border-top border-right" width="5%">{$row->fsc_charge|inr_format}</td>
                                <td align="center" class="border-top border-right" width="5%">{$row->delivery_handling_amount|inr_format}</td>
                                <td align="center" class="border-top border-right" width="5%">{$row->total_handling_amount|inr_format}</td>
                                <td align="center" class="border-top border-right" width="5%">{$row->pickup_handling_amount}</td>
                                <td align="center" class="border-top">{($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->fsc_charge+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge+$row->demurrage_charge+$row->insurance_amount+$row->adjustment_amount+$row->machine_handling_charge+$row->fov_charge)|inr_format}</td>
                            </tr>
                            {assign var=service_tax value=$service_tax+$row->service_tax}
                            {assign var=round_off value=$round_off+$row->round_off_value}
                            {assign var=total value=$total+($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->fsc_charge+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge+$row->demurrage_charge+$row->insurance_amount+$row->adjustment_amount+$row->machine_handling_charge+$row->fov_charge)}
                            {assign var=grand_total value=$grand_total+($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->fsc_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge+$row->demurrage_charge+$row->round_off_value+$row->insurance_amount+$row->adjustment_amount+$row->machine_handling_charge+$row->fov_charge)}
                        {foreachelse}
                            <tr>
                                <td colspan="16" align="center" class="border-top">No Records Found!</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="8" class="bold border-top">Remark</td>
            <td colspan="4" rowspan="2" class="border-left border-top">
                <table cellpadding="2">
                    <tr>
                        <td align="center" class="bold border-right border-bottom">Total</td>
                        <td align="right" class="bold border-bottom">{$total|inr_format}</td>
                    </tr>
                    <tr>
                        <td align="left" class="border-right border-bottom">IGST Output 18%</td>
                        <td align="right" class="border-bottom">{$service_tax|inr_format}</td>
                    </tr>
                    <tr>
                        <td align="left" class="border-right border-bottom">Round Off</td>
                        <td align="right" class="border-bottom">{$round_off|inr_format}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="8"></td>
        </tr>
        <tr>
            <td class="border-right border-top border-bottom" colspan="2"><span class="bold">Amounts In Words</span> </td>
            <td class="border-right border-top border-bottom" colspan="6">{if strlen($total|amount_in_words) > 65}{else}{/if}{if $total}{$total|amount_in_words} Only{/if}</td>
            <td align="left" class="bold border-right border-bottom" colspan="2">Grand Total</td>
            <td align="right" class="bold border-bottom" colspan="2">{$grand_total|inr_format}</td>
        </tr>
        <tr>
            <td class="border-top border-right border-bottom" colspan="8"><b>Terms and Conditions:</b><br>
                <b>1.</b>All Payments to be made only through Account payee Cheque or DD in favor of Pan India Logistics<br>
                <b>2.</b>Interest @ 2% per month or part thereof will be charged if the bill is not paid on due date.</td>
            <td class="bold border-top" colspan="4">For PAN INDIA LOGISTICS</td>
        </tr>
        <tr>
            <td class="border-top border-right border-bottom" colspan="8"><b>RTGS BANK DETAILS : PAN INDIA LOGISTIC</b><br>
                Bank : AXIS BANK LTD / Branch : SENNEERKUPPAM<br>
                Account No : 919020057835337<br>
                IFSC Code   : UTIB0004171</td>
            <td class="bold border-bottom" colspan="4"><br><br><br><br>Authorized Signatory</td>
        </tr>
        
        <tr>
            <td class="bold border-top border-bottom" colspan="8">PAN No: AQKPM4799G / GST NO: 33AQKPM4799G2ZC</td>
            <td align="right" class="bold border-bottom" colspan="4">SAC CODE - 996791</td>
        </tr>
    </table>
{/strip}