<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Cargo Collection Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<h5>Summary</h5>
<div class="table-responsive col-md-6 p_l_n">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Branch</th>
                <th align="center">Total Collection</th>
                <th align="center">By Paid Booking</th>
                <th align="center">By ToPay Delivery / {$cargo_payment_status['TPPAD']}</th>                
            </tr>
        </thead>
        <tbody>
            {assign var="tot_netpay" value=0}            
            {assign var="tot_paid" value=0}
            {assign var="tot_topaypaid" value=0}
            {assign var="tot_topay" value=0}
            {assign var="tot_handling" value=0}

            {foreach item=row from=$summary key=key}
                <tr>
                    <td class="bold">{$key}</td>
                    <td align="right">{$row['netPayable']|number_format:2}</td>
                    <td align="right">{$row['paid']|number_format:2}</td>
                    <td align="right">{$row['topaypaid']|number_format:2}</td>                    
                </tr>
                {assign var="tot_netpay" value=$tot_netpay + $row['netPayable']}
                {assign var="tot_topaypaid" value=$tot_topaypaid + $row['topaypaid']}
                {assign var="tot_paid" value=$tot_paid + $row['paid']}
                {assign var="tot_topay" value=$tot_topay + $row['toPay']}
                {assign var="tot_handling" value=$tot_handling + $row['handlingCharges']}
            {foreachelse}
                <tr>
                    <td colspan="4" align="center">No Records Found!</td>
                </tr>
            {/foreach}

            {if $summary|count}
                <tr class="bold">
                    <td align="right">Total</td>
                    <td align="right">{$tot_netpay|number_format:2}</td>                    
                    <td align="right">{$tot_paid|number_format:2}</td>
                    <td align="right">{$tot_topaypaid|number_format:2}</td>                    
                </tr>
            {/if}
        </tbody>
    </table>
</div>
<br/>
<div class="clearfix"></div>
<h5>Transactions</h5>
<table class="table table-bordered" width="99%">
    <thead>
        <tr class="success">
            <td align="center">{lang('cargo_code_term')}</td>
            <td align="center">Booked Date</td>
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">User</td>
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">{lang('booking_sender_term')}</td>
            <td align="center">{lang('booking_receiver_term')}</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Qty</td>
            <td align="center">Net Payable</td>
            <td align="center">Handling Charges</td>
            <td align="center">{lang('other_charges')} </td>
            <td align="center">Received</td>
            <td align="center">Balance</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=tot_items value=0}
        {assign var=tot_transaction_amount value=0}
        {assign var=tot_other_charges_amount value=0}

        {foreach item=value from=$result key=key}
            <tr class="active">
                <td colspan="15" align="center">{$key}</td>
            </tr>
            {foreach item=row from=$value key=t}
                <tr>
                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="center" id="pay_state_{$row->cargo_code}">
                    {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="center">{$row->total_item_count}</td>

                    <td align="right">{$row->net_payable}</td>
                    <td align="right">{$row->total_handling_amount}</td>
                    <td align="right" nowrap>
                        {$row->other_charges_amount|inr_format}

                        {if $row->other_charges_amount != 0}
                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                <table>
                                    {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                        {if $cv == 0}
                                            {continue}
                                        {/if}
                                        <tr>
                                            <td><b>{$ck|_camelcase_to_titlecase}</b></td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                        </tr>
                                    {/foreach}
                                </table>
                            '></i>
                        {else}
                            <i class="fa fa-info-circle fa-inverse"></i>
                        {/if}
                    </td>
                    <td align="right">{$row->transaction_amount}</td>
                    <td align="right">{$row->topay}
                    </td>
                </tr>
                {assign var=tot_transaction_amount value=$tot_transaction_amount+$row->transaction_amount}
                {assign var=tot_other_charges_amount value=$tot_other_charges_amount+$row->other_charges_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
            {/foreach}
        {foreachelse}
            <tr>
                <td colspan="15" align="center">No Records Found!</td>
            </tr>
        {/foreach}
        {if $result|count}
        <tr class="active">
            <td align="right" colspan="2" class="bold"></td> 
            <td align="center" colspan="2" class="bold">{$cargo_payment_status['PAD']} : {$total['paid']|inr_format}</td> 
            <td align="center" colspan="2" class="bold">{$cargo_payment_status['TPPAD']} : {$total['topaypaid']|inr_format}</td> 
            <td align="right" colspan="3" class="bold">Total</td>
            <td align="center" class="bold">{$tot_items}</td>
            <td align="right" class="bold">{$tot_netpay|number_format:2}</td>
            <td align="right" class="bold">{$tot_handling|number_format:2}</td>
            <td align="right" class="bold">{$tot_other_charges_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_transaction_amount|number_format:2}</td>
            <td align="right" class="bold">{$tot_topay|number_format:2}</td>
        </tr>
        {/if}
    </tbody>
</table>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>

<script>
$('[data-toggle="popover"]').popover({
    placement: 'top',
    html: true,
    trigger: 'hover'
});
</script>