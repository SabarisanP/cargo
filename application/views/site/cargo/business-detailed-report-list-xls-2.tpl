<table border="1">
    <tr>
        <td colspan="6" align="center"><b>Business Detailed Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$username} </td>
    </tr>
</table>

<table class="table table-bordered" border="1">
    <thead>
        <tr style="background-color: #64b92a">
            <td align="left"><b>Booked Date</b></td>
            <td align="left"><b>{lang('cargo_code_term')}</b></td>
            <td align="left"><b>Vehicle No</b></td>
            <td align="left"><b>No. Of Articles</b></td>
            <td align="left"><b>Type Of Packaging</b></td>
            <td align="left"><b>{lang('booking_from_term')}</b></td>
            <td align="left"><b>User</b></td>
            <td align="left"><b>{lang('booking_to_label')}</b></td>
            <td align="left"><b>{lang('booking_sender_term')}</b></td>
            <td align="left"><b>{lang('booking_sender_term')} Contact Number</b></td>
            <td align="left"><b>{lang('booking_receiver_term')}</b></td>
            <td align="left"><b>{lang('booking_receiver_term')} Contact Number</b></td>
            <td align="left"><b>Payment Status</b></td>
            <td align="left"><b>Dispatch Status</b></td>
            <td align="left"><b>Cargo Status</b></td>
            <td align="left"><b>Net Payable</b></td>
            <td align="left"><b>Handling Charges </b></td>
            <td align="left"><b>Freight Amount </b></td>
            <td align="left"><b>GST </b></td>
            <td align="left"><b>Unloading Charges </b></td>
            <td align="left"><b>Pickup Charges </b></td>
            <td align="left"><b>Delivery Charges </b></td>
            <td align="left"><b>{lang('other_charges')} </b></td>
            <td align="left"><b>Commission</b></td>
            <td align="left"><b>Paid</b></td>
            <td align="left"><b>Topay</b></td>
        </tr>
    </thead>
    <tbody class="body_table">

        {assign var=tot_fare value=0}
        {assign var=tot_handling value=0}
        {assign var=tot_payable value=0}
        {assign var=tot_paid value=0}
        {assign var=tot_topay value=0}
        {assign var=tot_items value=0}
        {assign var=tot_commission value=0}

        {assign var=t_service_tax value=0}
        {assign var=t_total_handling_amount value=0}
        {assign var=t_total_unload_handling_amount value=0}
        {assign var=t_pickup_handling_amount value=0}
        {assign var=t_delivery_handling_amount value=0}
        {assign var=t_other_tot_amount value=0}


        {foreach item=row from=$result key=t}
            {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                <tr>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center">{$row->cargo_code}</td>
                    <td align="center">{$row->vehicle_registration_number}</td>
                    <td align="center">{$row->total_item_count}</td>
                    <td align="left">{$row->cargo_item_name}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name} </td>
                    <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name}</td>
                    <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>
                    <td align="center">
                        {if $row->cargo_status_code == "CL" || $row->cargo_status_code == "CUL" || $row->cargo_status_code == "CD"}
                            Yes
                        {elseif $row->cargo_status_code == "CB" || $row->cargo_status_code == "CUD" || $row->cargo_status_code == "CR" || $row->cargo_status_code == "CA"}
                            No
                        {/if}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]} </td>

                    <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->total_handling_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->service_tax}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->total_unload_handling_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->pickup_handling_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->delivery_handling_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->other_charges_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->commission_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">{$row->transaction_amount}</td>
                    <td align="right" data-format="{$xlformat['currency']}">
                        {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)-$row->transaction_amount}
                        {$rtopay}
                        {assign var="tot_topay" value=$tot_topay+$rtopay}
                    </td>
                </tr>

                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
                {assign var=tot_commission value=$tot_commission+$row->commission_amount}

                {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
                {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
                {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
                {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
                {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
                {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->other_charges_amount}

            {/if}
        {/foreach}
    </tbody>
    <tfoot>
        <tr class="active">
            <td align="right" colspan="15"><b>Total</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$tot_payable}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_total_handling_amount}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$tot_fare}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_service_tax}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_total_unload_handling_amount}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_pickup_handling_amount}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_delivery_handling_amount}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_other_tot_amount}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$tot_commission}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$tot_paid}</b></td>
            <td align="right" data-format="{$xlformat['currency']}"><b>{$tot_topay}</b></td>
        </tr>
    </tfoot>
</table>
