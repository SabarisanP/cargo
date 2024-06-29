<style>                        
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px }
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
</style>

<table class="" width="100%" cellpadding="3">
    <tr>
        <td width="100%" align="center" style="font-weight:bold; font-size: 14px;">{$namespace_name}</td>                            
    </tr>
    <tr>
        <td  colspan="2" align="center"><span class="bold">Payment Voucher List</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span> 
            {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>


    <table id="dt_voucher_table" class="bordered" width="100%" cellpadding="3" >
        <thead>
            <tr style="background-color:#64b92a;">
                <td>Payment Code</td>
                <td>Transaction Date</td>
                <td>User</td>
                <td>Transaction Type</td>
                <td>Acknowledment Status</td>
                <td>Payment Date</td>
                <td>Transaction Mode</td>
                <td>Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {if $voucher|count ==0}
                <tr>
                    <td colspan="8" align="center"> Sorry! No data found</td>
                </tr>
            {else}
                {assign var=total_amt value=0}
                {foreach item=row from=$voucher key =k}
                    {assign var=total_amt value=$total_amt+$row->transaction_amount}
                    <tr>
                        <td nowrap="">{$row->transaction_code}<!--<a href="javascript:;" data-pnr="{$row->transaction_code}" class="pnr-popover">{$row->transaction_code}</a>--></td>
                        <td nowrap="">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <td nowrap="">{$row->user_name}</td>
                        <td nowrap="">{$f_t_type[$row->transaction_type]}</td>
                        <td nowrap="">{$f_a_status[$row->acknowledment_status]}</td>
                        <td nowrap="">{$row->received_date|date_format:$ns_date_format}</td>
                        <td nowrap="">{if $row->transaction_mode != ''}{$f_t_mode[$row->transaction_mode]}{else}NA{/if}</td>
                        <td nowrap="">{$row->transaction_amount|number_format:2}</td>
                    </tr>
                {/foreach} 
                <tr class="bold" style="background-color:#64b92a;">
                    <td colspan="7" align="right" >Total Amount</td>
                    <td >{$total_amt|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
