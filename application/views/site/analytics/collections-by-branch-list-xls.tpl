<table class="" width="99%" border='1'>
    <tr>
        <td colspan="8" align="center"><span style="font-weight:bold">{iflang('Collections By Branch')}</span></td>
    </tr>
    <tr>
        <td width="50%"  colspan="4">
            <span style="font-weight:bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%" colspan="4">&nbsp;</td>
        <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>

<table class="table table-bordered" border='1'>
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <th align="left">Organization</th>
            <th align="left">No.of {lang('lr')}</th>
            <th align="right">{lang('other_charges')}</th>
            <th align="right">Paid Amount</th>
            <th align="right">Topay Amount</th>
            <th align="right">OnAccount Amount</th>
            <th align="right">Total Amount</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_cargo_count value=0}
        {assign var=t_total_item_count value=0}
        {assign var=t_hamali_charge value=0}
        {assign var=t_pass_charge value=0}
        {assign var=t_docket_charge value=0}
        {assign var=t_pod_charge value=0}
        {assign var=t_service_charge value=0}
        {assign var=t_service_tax value=0}
        {assign var=t_pickup_handling_amount value=0}
        {assign var=t_delivery_handling_amount value=0}
        {assign var=t_total_handling_amount value=0}
        {assign var=t_total_unload_handling_amount value=0}
        {assign var=t_other_charges_amount value=0}
        {assign var=t_booking_commission_amount value=0}
        {assign var=t_delivery_commission_amount value=0}
        {assign var=t_total_paid_amount value=0}
        {assign var=t_total_topay_amount value=0}
        {assign var=t_total_on_account_amount value=0}
        {assign var=t_t_total_other_charges value=0}
    
        {foreach item=row from=$summary}
            <tr>
                <td align="left">{$row->organization_name}</td>
                <td align="right">{$row->cargo_count}</td>
                <td align="right">{$row->total_other_charges|inr_format}</td>
                <td align="right">{$row->total_paid_amount|inr_format}</td>
                <td align="right">{$row->total_topay_amount|inr_format}</td>
                <td align="right">{$row->total_on_account_amount|inr_format}</td>
                <td align="right">{($row->total_other_charges + $row->total_paid_amount + $row->total_topay_amount + $row->total_on_account_amount)|inr_format}</td>
            </tr>
    
            {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
            {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
            {assign var=t_hamali_charge value=$t_hamali_charge + $row->hamali_charge}
            {assign var=t_pass_charge value=$t_pass_charge + $row->pass_charge}
            {assign var=t_docket_charge value=$t_docket_charge + $row->docket_charge}
            {assign var=t_pod_charge value=$t_pod_charge + $row->pod_charge}
            {assign var=t_service_charge value=$t_service_charge + $row->service_charge}
            {assign var=t_service_tax value=$t_service_tax + $row->service_tax}
            {assign var=t_pickup_handling_amount value=$t_pickup_handling_amount + $row->pickup_handling_amount}
            {assign var=t_delivery_handling_amount value=$t_delivery_handling_amount + $row->delivery_handling_amount}
            {assign var=t_total_handling_amount value=$t_total_handling_amount + $row->total_handling_amount}
            {assign var=t_total_unload_handling_amount value=$t_total_unload_handling_amount + $row->total_unload_handling_amount}
            {assign var=t_other_charges_amount value=$t_other_charges_amount + $row->other_charges_amount}
            {assign var=t_booking_commission_amount value=$t_booking_commission_amount + $row->booking_commission_amount}
            {assign var=t_delivery_commission_amount value=$t_delivery_commission_amount + $row->delivery_commission_amount}
            {assign var=t_total_paid_amount value=$t_total_paid_amount + $row->total_paid_amount}
            {assign var=t_total_topay_amount value=$t_total_topay_amount + $row->total_topay_amount}
            {assign var=t_total_on_account_amount value=$t_total_on_account_amount + $row->total_on_account_amount}
            {assign var=t_total_other_charges value=$t_total_other_charges + $row->total_other_charges}
        {foreachelse}
            <tr>
                <td colspan="7" align="center">No Records Found</td>
            </tr>
        {/foreach}
    
        {if $summary|count}
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td align="right">Total</td>
                <td align='right'>{$t_cargo_count}</td>
                <td align="right">{$t_total_other_charges|inr_format}</td>
                <td align='right'>{$t_total_paid_amount|inr_format}</td>
                <td align='right'>{$t_total_topay_amount|inr_format}</td>
                <td align='right'>{$t_total_on_account_amount|inr_format}</td>
                <td align="right">{($t_total_other_charges + $t_total_paid_amount + $t_total_topay_amount + $t_total_on_account_amount)|inr_format}</td>
            </tr>
        {/if}
    </tbody>
</table>