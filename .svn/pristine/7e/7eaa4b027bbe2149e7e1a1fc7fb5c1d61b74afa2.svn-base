<table border="1">
    <tr>
        <td  colspan="16" align="center"><b>Branch Consolidation Report</b></td>
    </tr>
    <tr>
        <td colspan="8"><b>Date :</b> {$from_date|date_format:$ns_datetime_format} to {$to_date|date_format:$ns_datetime_format}</td>
        <td colspan="8" align="right"><b>Report Date/Time :</b> {date("d-m-Y h:i A")}</td>
    </tr>
</table>
        
<table border="1">
    <thead>
        <tr>
            <th align="center" rowspan="3">#</th>
            <th align="center" rowspan="3">Lr No</th>
            <th align="center" rowspan="3">Payment Type</th>
            <th align="center" rowspan="3">Branch</th>

            <th align="center" colspan="25">Booking</th>
            <th align="center" colspan="25">Delivery</th>

            <th align="center" rowspan="3">Collection Freight</th>
            <th align="center" rowspan="3">Collection Charges</th>
            <th align="center" rowspan="3">Collection GST</th>
            <th align="center" rowspan="3">Service Fee</th>
            <th align="center" rowspan="3">TDS</th>
            <th align="center" rowspan="3">Charges Share</th>
            <th align="center" rowspan="3">Net Payable</th>
        </tr>
        <tr>
            <th align="center" colspan="8">Paid</th>
            <th align="center" colspan="8">To Pay</th>
            <th align="center" colspan="8">On Account</th>
            <th rowspan="2">Charges Share</th>

            <th align="center" colspan="8">Paid</th>
            <th align="center" colspan="8">To Pay</th>
            <th align="center" colspan="8">On Account</th>
            <th rowspan="2">Charges Share</th>
        </tr>
        <tr>
            {* booking *}
            <th>Freight Amount</th>
            <th>Loading Charge</th>
            <th>Unloading Charge</th>
            <th>Pickup Charge</th>
            <th>Delivery Charge</th>
            <th>Service Fee</th>
            <th>GST</th>
            <th>Other Charges</th>

            <th>Freight Amount</th>
            <th>Loading Charge</th>
            <th>Unloading Charge</th>
            <th>Pickup Charge</th>
            <th>Delivery Charge</th>
            <th>Service Fee</th>
            <th>GST</th>
            <th>Other Charges</th>

            <th>Freight Amount</th>
            <th>Loading Charge</th>
            <th>Unloading Charge</th>
            <th>Pickup Charge</th>
            <th>Delivery Charge</th>
            <th>Service Fee</th>
            <th>GST</th>
            <th>Other Charges</th>

            {* delivery *}
            <th>Freight Amount</th>
            <th>Loading Charge</th>
            <th>Unloading Charge</th>
            <th>Pickup Charge</th>
            <th>Delivery Charge</th>
            <th>Service Fee</th>
            <th>GST</th>
            <th>Other Charges</th>

            <th>Freight Amount</th>
            <th>Loading Charge</th>
            <th>Unloading Charge</th>
            <th>Pickup Charge</th>
            <th>Delivery Charge</th>
            <th>Service Fee</th>
            <th>GST</th>
            <th>Other Charges</th>

            <th>Freight Amount</th>
            <th>Loading Charge</th>
            <th>Unloading Charge</th>
            <th>Pickup Charge</th>
            <th>Delivery Charge</th>
            <th>Service Fee</th>
            <th>GST</th>
            <th>Other Charges</th>
        </tr>
    </thead>
    <tbody class="body_table">               
        {foreach item=row from=$result key=k}
            <tr> 
                <td>{$k+1}</td>
                <td>{$row->cargo_code}</td>
                <td>{$cargo_payment_status[$row->payment_status_code]}</td>
                <td>{$row->organization_name|ucwords}</td>

                {* booking *}
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_booking_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_loading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_unloading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_booking_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_service_tax}</td>
                
                <td align="right" data-format="{$xlformat['currency']}">
                    {$row->paid_service_charge + $row->paid_hamali_charge + $row->paid_pass_charge+
                    $row->paid_docket_charge + $row->paid_pod_charge + $row->paid_demurrage_charge + $row->paid_round_off_value}
                </td>
                
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_booking_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_loading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_unloading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_booking_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_service_tax}</td>

                <td align="right" data-format="{$xlformat['currency']}">
                    {$row->topay_service_charge + $row->topay_hamali_charge + $row->topay_pass_charge+
                    $row->topay_docket_charge + $row->topay_pod_charge + $row->topay_demurrage_charge + $row->topay_round_off_value}
                </td>
                
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_booking_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_loading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_unloading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_booking_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_service_tax}</td>

                <td align="right" data-format="{$xlformat['currency']}">
                    {$row->onacc_service_charge + $row->onacc_hamali_charge + $row->onacc_pass_charge+
                    $row->onacc_docket_charge + $row->onacc_pod_charge + $row->onacc_demurrage_charge + $row->onacc_round_off_value}
                </td>

                <td align="right" data-format="{$xlformat['currency']}">{($row->paid_loading_commission_amount + $row->topay_loading_commission_amount + $row->onacc_loading_commission_amount)}</td>

                {* delivery *}
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_delivery_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_delivery_loading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_delivery_unloading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_delivery_pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_delivery_delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_delivery_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->paid_delivery_service_tax}</td>
 
                <td align="right" data-format="{$xlformat['currency']}">
                    {$row->paid_delivery_service_charge + $row->paid_delivery_hamali_charge + $row->paid_delivery_pass_charge+
                    $row->paid_delivery_docket_charge + $row->paid_delivery_pod_charge + $row->paid_delivery_demurrage_charge + $row->paid_delivery_round_off_value}
                </td>
                
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_delivery_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_delivery_loading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_delivery_unloading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_delivery_pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_delivery_delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_delivery_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->topay_delivery_service_tax}</td>
 
                <td align="right" data-format="{$xlformat['currency']}">
                    {$row->topay_delivery_service_charge + $row->topay_delivery_hamali_charge + $row->topay_delivery_pass_charge+
                    $row->topay_delivery_docket_charge + $row->topay_delivery_pod_charge + $row->topay_delivery_demurrage_charge + $row->topay_delivery_round_off_value}
                </td>
                
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_delivery_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_delivery_loading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_delivery_unloading_charge_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_delivery_pickup_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_delivery_delivery_handling_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_delivery_commission_amount}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->onacc_delivery_service_tax}</td>
 
                <td align="right" data-format="{$xlformat['currency']}">
                    {$row->onacc_delivery_service_charge + $row->onacc_delivery_hamali_charge + $row->onacc_delivery_pass_charge+
                    $row->onacc_delivery_docket_charge + $row->onacc_delivery_pod_charge + $row->onacc_delivery_demurrage_charge + $row->onacc_delivery_round_off_value}
                </td>

                <td align="right" data-format="{$xlformat['currency']}">{($row->paid_unloading_commission_amount + $row->topay_unloading_commission_amount + $row->onacc_unloading_commission_amount)}</td>

                <td align="right" data-format="{$xlformat['currency']}">{($row->paid_booking_amount+$row->topay_delivery_amount)}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($row->paid_other_charges_amount + $row->paid_pickup_handling_amount+$row->topay_delivery_other_charges_amount + $row->topay_delivery_handling_amount)}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($row->paid_service_tax + $row->topay_delivery_service_tax)}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($row->paid_booking_commission_amount + $row->topay_booking_commission_amount + $row->onacc_booking_commission_amount+$row->paid_delivery_commission_amount+$row->topay_delivery_commission_amount+$row->onacc_delivery_commission_amount)}</td>
                <td align="right" data-format="{$xlformat['currency']}">{($row->paid_booking_tds_commission_amount + $row->topay_booking_tds_commission_amount + $row->onacc_booking_tds_commission_amount+$row->paid_delivery_tds_commission_amount+$row->topay_delivery_tds_commission_amount+$row->topay_delivery_tds_commission_amount)}</td>
                
                <td align="right" data-format="{$xlformat['currency']}">
                    {($row->paid_loading_commission_amount + $row->topay_loading_commission_amount + $row->onacc_loading_commission_amount+
                    $row->paid_unloading_commission_amount + $row->topay_unloading_commission_amount + $row->onacc_unloading_commission_amount)}
                </td>
                
                <td align="right" data-format="{$xlformat['currency']}">
                    {(($row->paid_booking_amount+$row->topay_delivery_amount+
                    $row->paid_other_charges_amount + $row->paid_pickup_handling_amount+$row->topay_delivery_other_charges_amount +
                    $row->topay_delivery_handling_amount)-(($row->paid_booking_commission_amount +
                    $row->topay_booking_commission_amount + $row->onacc_booking_commission_amount+$row->paid_delivery_commission_amount+
                    $row->topay_delivery_commission_amount+$row->onacc_delivery_commission_amount)-($row->paid_booking_tds_commission_amount +
                    $row->topay_booking_tds_commission_amount + $row->onacc_booking_tds_commission_amount+$row->paid_delivery_tds_commission_amount+
                    $row->topay_delivery_tds_commission_amount+$row->topay_delivery_tds_commission_amount)+($row->paid_loading_commission_amount + 
                    $row->topay_loading_commission_amount + $row->onacc_loading_commission_amount+$row->paid_unloading_commission_amount + 
                    $row->topay_unloading_commission_amount + $row->onacc_unloading_commission_amount)))}
                </td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="61" align="center">No data found</td>
            </tr>
        {/foreach}
    </tbody>
</table>                

 
