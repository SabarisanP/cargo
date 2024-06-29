<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th align="center">Voucher No</th>
                <th align="center">Transaction Date</th>
                <th align="center">Transaction Mode</th>
                <th align="center">User</th>
                <th align="center">Handled By</th>
                <th align="center">Remarks</th>
                <th align="center">Voucher Amount</th>
                <th align="center">Paid Amount</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="totalPaid" value=0}
            {foreach item=row from=$result}
                <tr>
                    <td align="left"><a href="javascript:;"  onclick="showVoucherPdfDialog('{$row->transaction_code}');">{$row->transaction_code}</a></td>
                    <td align="left">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                    <td align="left">{$transactionMode[$row->transaction_mode]}</td>
                    <td align="left">{$row->user_name}</td>
                    <td align="left">{$row->handled_user_name}</td>
                    <td align="left">{$row->remarks}</td>
                    <td align="right">{$row->transaction_amount|number_format:2}</td>
                    <td align="right">{$row->paid_amount|number_format:2} <a href="javascript:;" onclick="showPaidPartialInfo('{$row->transaction_code}');"><i class="fa fa-info-circle" aria-hidden="true"></i></a></td>
                </tr>
                {assign var="totalPaid" value=$totalPaid + $row->paid_amount}
            {foreachelse}
                <tr>
                    <td colspan="8" align="center">No Records Found!</td>
                </tr>
            {/foreach}
            
            {if $result|count}
                <tr class="bold">
                    <td colspan="7" align="right">Total:</td>
                    <td align="right">{$totalPaid|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>
