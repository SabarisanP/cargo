{strip}
    <table style="padding:5px 4px;">
        <tr>
            <td align="center" style="font-weight:bold;font-size: 12px;">
                Consolidated E-Way Bill
            </td>
        </tr>
    </table>
{/strip}
<br/>
<hr style="border-bottom: 1px solid #4d4d4d;">
<h4>1. Consolidated E-Way Bill Details</h4>
<table style="padding:5px 4px;">
    <tbody>
        <tr>
            <td style="width: 70%;">
                <table width="100%" cellpadding="3">
                    <tr>
                        <td>Consolidated E-Way Bill No</td>
                        <td><b>{$consEwayBill->tripSheetNo}</b></td>
                    </tr>

                    <tr>
                        <td>Date</td>
                        <td><b>{$consEwayBill->transportDetails->documentDate|date_format:$ns_date_format}</b></td>
                    </tr>

                    <tr>
                        <td>Transporter ID</td>
                        <td><b>{$consEwayBill->transportDetails->gstin}</b></td>
                    </tr>

                    <tr>
                        <td>Vehicle No</td>
                        <td><b>{$consEwayBill->vehicle->registationNumber}</b></td>
                    </tr>

                    <tr>
                        <td>From</td>
                        <td><b>{$consEwayBill->fromStation->name} - {$consEwayBill->fromState->name}</b></td>
                    </tr>
                    
                    <tr>
                        <td>Mode</td>
                        <td><b>{$ewaybill_transportation_mode[$consEwayBill->transportDetails->transportMode|intval]}</b></td>
                    </tr>
                </table>
            </td>
            <td class="border-right" style="width: 30%;">
                <img src="{$base_url}qr?data={$consEwayBill->tripSheetNo}/{$consEwayBill->transportDetails->gstin}/{$consEwayBill->transportDetails->documentDate|date_format:$ns_date_format}&size=10" width="100px">
            </td>
        </tr>
    </tbody>
</table>
<br>
<hr style="border-bottom: 1px solid #4d4d4d;">
<h4>2. Item Details</h4>
<table style="padding:5px 4px;" align="center" width="100%">
    <thead>
        <tr style="font-weight:bold; background-color: #E8E8E8;">
            <th align="left" style="border: 1px solid #000000;width: 6%;">S.No.</th>
            <th align="left" style="border: 1px solid #000000;width: 20%;">E-WayBill No. & Date</th>
            <th align="left" style="border: 1px solid #000000;width: 20%;">E-WayBill By</th>
            <th align="left" style="border: 1px solid #000000;width: 20%;">Document No. & Date</th>
            <th align="left" style="border: 1px solid #000000;width: 14%;">Value</th>
            <th align="left" style="border: 1px solid #000000;width: 20%;">To</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row key=k from=$consEwayBill->ewayBillList}
            <tr>
                <td align="left" style="border: 1px solid #000000;width: 6%;">{$k+1}</td>
                <td align="left" style="border: 1px solid #000000;width: 20%;">{$row->ewayBillNo} - {$row->expiryDate|date_format:$ns_date_format}</td>
                <td align="left" style="border: 1px solid #000000;width: 20%;">{$row->fromTaxPayerDetails->tradeName}<br>{$row->fromTaxPayerDetails->gstin}</td>
                <td align="left" style="border: 1px solid #000000;width: 20%;">{$row->documentNo} - {$row->documentDate|date_format:$ns_date_format}</td>
                <td align="left" style="border: 1px solid #000000;width: 14%;">{$row->totalInvoiceValue|inr_format}</td>
                <td align="left" style="border: 1px solid #000000;width: 20%;">{$row->toTaxPayerDetails->tradeName}<br>{$row->toTaxPayerDetails->gstin}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="6" align="center" style="border: 1px solid #000000;width: 100%;">No Records Found!</td>
            </tr>
        {/foreach}
    </tbody>
</table>

