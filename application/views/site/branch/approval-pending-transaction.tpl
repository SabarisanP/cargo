<table id="dt_adv_booking_report_table" class="table table-bordered " >
    <thead>
        <tr class="success">
            <td align="center" rowspan="2">Branch</td>
            <td align="center" rowspan="2">Pending Count</td>
            <td align="center" rowspan="2">Pending Amount</td>
            <td align="center" colspan="4">Last Closing Details</td>
        </tr>
        <tr class="success">
            <td align="center">Date</td>
            <td align="center">User</td>
            <td align="center">Settlement Amount</td>
            <td align="center">Paid Amount</td>
        </tr>

    </thead>
    <tbody class="body_table" >
        {foreach item=row from=$result key=t}
            <tr class="tr-hover" onclick="redirectBranchReceipt('{$row->organization->code}');">
                <td>{$row->organization->name}</td>
                <td align="center">{$row->pendingCount}</td>
                <td align="right">{$row->pendingAmount|inr_format}</td>

                <td align="center">
                    {if isNotNull($row->lastClosingDetails)}
                        {$row->lastClosingDetails->fromDate|date_format:$ns_datetime_format} - {$row->lastClosingDetails->toDate|date_format:$ns_datetime_format}
                    {else}
                        -
                    {/if}
                </td>
                
                <td>
                    {if isNotNull($row->lastClosingDetails)}
                        {$row->lastClosingDetails->user->name}
                    {else}
                        -
                    {/if}
                </td>

                <td align="right">
                    {if isNotNull($row->lastClosingDetails)}
                        {$row->lastClosingDetails->settlementAmount|inr_format}
                    {else}
                        -
                    {/if}
                </td>

                <td align="right">
                    {if isNotNull($row->lastClosingDetails)}
                        {$row->lastClosingDetails->paidAmount|inr_format}
                    {else}
                        -
                    {/if}
                </td>
        {foreachelse}
            <tr>
                <td colspan="7" align="center">No Records Found!</td>
            </tr>
        {/foreach}
    </tbody>
</table>

<script>
    function redirectBranchReceipt(orgCode) {
        var url = base_url + "#branch/branch-receipt?organization="+orgCode;
        var wo = window.open(url, "_blank");
    }
</script>