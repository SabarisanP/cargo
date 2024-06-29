<table class="table">
    <thead class="bold">
        <tr>
            <td class="sticky-row-top">User</td>
            <td class="sticky-row-top">Last Transaction Time</td>
            <td class="sticky-row-top" align="right">Balance</td>
        </tr>
    </thead>
    <tbody>
        {foreach from=$result item=row}
            <tr>
                <td>{$row->first_name}</td>
                <td title="{$row->last_transaction_date|date_format:$ns_datetime_format}">{$row->last_transaction_date|time_elapsed_string}</td>
                <td align="right">{$row->current_balance|sigma:$t_current_balance|inr_format}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="3" align="center">No details found</td>
            </tr>
        {/foreach}
        {if $result|count}
            <tr>
                <td class="sticky-row-bottom" align="left" colspan="2"><b>Total</b></td>
                <td class="sticky-row-bottom" align="right"><b>{$t_current_balance|inr_format}</b></td>
            </tr>
        {/if}
    </tbody>
</table>

<script>
    $('#userbal-last-updated-at').html('(As on {$as_on_time|date_format:$ns_time_format})');
</script>
