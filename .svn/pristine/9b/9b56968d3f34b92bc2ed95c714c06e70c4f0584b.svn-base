<table border="1">
    <tr>
        <td colspan="11" align="center"><b>{lang('dash_panel_user_balance')} Report</b></td>
    </tr>
    <tr>
        <td colspan="6">
            <b>Report Date/Time :</b> {$smarty.now|date_format:$ns_datetime_format}
        </td>
        <td colspan="5" align="right">
            <b>Report By :</b> {$usr_login_name} 
        </td>
    </tr>
</table>

<br/>
<table border="1">
    <thead>
        <tr  style="background-color:#64b92a; color: #fff;">
            <th >Group Name</th>
            <th >Payment Type</th>
            <th >Name</th>
            <th >Mobile No</th>
            <th> Last Transaction Date</th>
            <th> Days till last txn</th>
            <th >Credit Limit</th>
            <th >Booking Commission</th>
            <th >Cancellation Share</th>
            <th >Current Balance</th>
            <th >Available Credit Limit</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach from=$reports item=row}
            {assign var=c_balance value=$row->current_balance}
            {assign var=a_c_limit value=$c_balance+$row->credit_limit}

            <tr>
                <td>{$row->user_group_name}</td>
                <td >{$row->payment_type_code}</td>
                <td>
                    {$row->first_name} </td>
                <td>
                    {$row->mobile_number}
                </td>
                <td>
                    {if $row->last_transaction_date!=""}
                        {date('d/m/Y g:i A',strtotime($row->last_transaction_date))}
                    {else}
                        -
                    {/if}
                </td>
                <td>
                    {if $row->last_transaction_date!=""}
                        {round( ($smarty.now - strtotime($row->last_transaction_date))/ (60 * 60 * 24) )}
                    {else}
                        -
                    {/if}
                </td>
                <td align="right">{$row->credit_limit|number_format:2}</td>
                <td align="right">{$row->booking_commission_value}</td>
                <td align="right">{$row->cancel_agent_share}</td>
                <td align="right">{$row->current_balance|number_format:2}</td>
                <td align="right">{$a_c_limit|number_format:2}</td>
            </tr>
        {/foreach}
    </tbody>
</table>
