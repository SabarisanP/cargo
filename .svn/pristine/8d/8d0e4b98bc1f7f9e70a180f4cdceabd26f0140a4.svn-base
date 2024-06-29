<table class="table">
    <thead class="bold">
        <tr>
            <td class="sticky-row-top">Branch</td>
            <td class="sticky-row-top">Last Closed Time</td>
            <td class="sticky-row-top" align="right">Balance</td>
        </tr>
    </thead>
    <tbody>
        {foreach from=$result->data item=row}
            <tr>
                <td>{$row->user->organization->name}</td>
                <td>{$row->closingDateTime|time_elapsed_string}</td>
                <td align="right">{$row->currentBalance|sigma:$t_current_balance|inr_format}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="3" align="center">No details found</td>
            </tr>
        {/foreach}
        {if $result->data|count}
            <tr>
                <td class="sticky-row-bottom" align="left" colspan="2"><b>Total</b></td>
                <td class="sticky-row-bottom" align="right"><b>{$t_current_balance|inr_format}</b></td>
            </tr>
        {/if}
    </tbody>
</table>

<script>
    $('#branchbal-last-updated-at').html('(As on {$result->datetime|date_format:$ns_time_format})');
</script>
