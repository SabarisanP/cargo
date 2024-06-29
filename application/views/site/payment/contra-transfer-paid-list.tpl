
<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
            <tr class="success">
                <th>Date</th>
                <th>From Account</th>
                <th>Account</th>
                <th>To Account</th>
                <th>Account</th>
                <th>Amount</th>
                <th>Status</th>
                <th width="15%">Remarks</th>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$result key=k}
                <tr>
                    <td>
                        {$row->transactionDate|date_format:$ns_date_format}
                    </td>
                    <td>
                        {$row->paymentContact->name}
                        {if $row->paymentContact->contactCategory->actionCode == 'BRCH'}
                            <br><span class="text-muted">{$row->paymentContactOrganization->name}</span>
                        {/if}
                    </td>

                    <td>
                        {$row->paymentContactBankDetails->name|default:'-'}<br>
                        <span class="text-muted">{$row->paymentContactBankDetails->accountNumber|default:'-'}</span>
                    </td>

                    <td>
                        {$row->vendorContact->name}
                        {if $row->vendorContact->contactCategory->actionCode == 'BRCH'}
                            <br><span class="text-muted">{$row->vendorContactOrganization->name}</span>
                        {/if}
                    </td>

                    <td>
                        {$row->vendorContactBankDetails->name|default:'-'}<br>
                        <span class="text-muted">{$row->vendorContactBankDetails->accountNumber|default:'-'}</span>
                    </td>

                    <td>{$row->amount|inr_format}</td>

                    <td>
                        <span class="badge badge-info">{$row->paymentStatus->name}</span>
                        {if isNotNull($row->updatedBy->code)}
                            <i class="fa fa-info-circle" data-toggle="popover" data-content="Updated By: {$row->updatedBy->name}<br>Updated Date: {$row->updatedAt|date_format:$ns_date_format}"></i>
                        {/if}
                    </td>

                    <td>{($row->remarks) ? $row->remarks : '-'}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td align="center" colspan="7">No data found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

<script>
$('[data-toggle="popover"]').popover({
    placement: 'top',
    html: true,
    trigger: 'hover'
});
</script>