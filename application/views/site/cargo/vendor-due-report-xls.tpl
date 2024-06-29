<table width="100%" border="1">
    <tr>
        <td colspan="5" align="center"><b>{iflang('Vendor Due Report')}</b></td>
    </tr>
    <tr>
        <td colspan="5" align="left"><b>Report By :</b>&nbsp; {$usr_login_name}</td>
    </tr>
</table>

<table border="1">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <th>Name</th>
            <th>Last Transaction Date</th>
            <th>Invoice Due</th>
            <th>Running / UnInvoiced Due</th>
            <th>Total Due</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach from=$result item=row}
            {if $row->user_role_code == 'CGCUST'}
                <tr>
                    <td>{$row->first_name}</td>
                    <td>{$row->last_transaction_date|date_format:$ns_datetime_format|default:'-'}</td>
                    <td align="right">{$row->current_balance|sigma:$t_current_balance|inr_format}</td>
                    <td align="right">{$row->running_balance|sigma:$t_running_balance|inr_format}</td>
                    <td align="right">{($row->current_balance + $row->running_balance)|sigma:$t_total_balance|inr_format}</td>
                </tr>
            {/if}
        {/foreach}
    </tbody>
    <tfoot>
        <tr class="bold">
            <td align="right" colspan="2">Total</td>
            <td align="right">{$t_current_balance|inr_format}</td>
            <td align="right">{$t_running_balance|inr_format}</td>
            <td align="right">{$t_total_balance|inr_format}</td>
        </tr>
    </tfoot>
</table>
