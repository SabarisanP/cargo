

    <div class="table-responsive">
        <table id="dt_report_table" class="table table-bordered widthed">
            <thead>
                <tr class="success">
                    <td>#</td>
                    <td>TXN Id</td>
                    <td>TXN Date</td>
                    <td>User</td>
                    <td>Handled By</td>
                    <td>TXN Type</td>
                    <td>Ack Status</td>
                    <td>Payment Received</td>
                    <td>TXN Mode</td>                    
                    <td>Amount</td>
                    <td>Paid</td>
                    <td>Balance</td>
                    <td>Remarks</td>
                </tr>
            </thead>
            <tbody class="body_table">
                {if $recharge|count ==0}
                    <tr>
                        <td colspan="11" align="center"> Sorry! No data found</td>
                    </tr>
                {else}
                    {assign var=total_amt value=0}
                    {assign var=paid_amt value=0}                    
                    {foreach item=row from=$recharge key =k}
                        
                        {if $row->transaction_type != "RVREPT" && $row->acknowledment_status == "ACKED"} 
                            {assign var=total_amt value=$total_amt+$row->transaction_amount}
                            {assign var=paid_amt value=$paid_amt+$row->partial_paid_amount}                            
                        {/if}
                        
                        <tr>
                            <td >{$k+1}</td>
                            <td >{$row->transaction_code}</td>
                            <td >{$row->transaction_date|date_format:$ns_datetime_format}</td>
                            <td >{$row->user_name}</td>
                            <td >{$row->handled_user_name}</td>
                            <td >{$f_t_type[$row->transaction_type]}</td>
                            <td >{$f_a_status[$row->acknowledment_status]}</td>
                            <td >{$row->received_date|date_format:$ns_date_format}</td>
                            <td >{if $row->transaction_mode != ''}{$f_t_mode[$row->transaction_mode]}{else}NA{/if}</td>                            
                            <td align="right">{$row->transaction_amount|number_format:2}</td>
                            <td align="right">{$row->partial_paid_amount|number_format:2}</td>
                            <td align="right">{($row->transaction_amount-$row->partial_paid_amount)|number_format:2}</td>
                            <td >{$row->remarks}</td>
                        </tr>
                    {/foreach} 
                    <tr class="success bold">
                        <td colspan="9" align="right" >Total Amount</td>
                        <td align="right">{$total_amt|number_format:2}</td>
                        <td align="right">{$paid_amt|number_format:2}</td>
                        <td align="right">{($total_amt-$paid_amt)|number_format:2}</td>
                        <td ></td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
