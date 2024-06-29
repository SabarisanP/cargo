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
                <th></th>
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
                        <span class="badge badge-primary">{$row->paymentStatus->name}</span>
                        {if isNotNull($row->updatedBy->code)}
                            <i class="fa fa-info-circle" data-toggle="popover" data-content="Updated By: {$row->updatedBy->name}<br>Updated Date: {$row->updatedAt|date_format:$ns_date_format}"></i>
                        {/if}
                    </td>

                    <td>{($row->remarks) ? $row->remarks : '-'}</td>

                    <td align="center">
                        {if $action_rights['CONTRA-ALLOW-ALL-BRANCH'] == 1 || (isNotNull($row->vendorContactOrganization->code) && $row->vendorContactOrganization->code == $loggedin_user_org)}
                            <button class="btn-app btn-success" type="button" onclick="updateContraStatus('{$row->code}', 'PAID');">Update Paid</button>
                            <button class="btn-app btn-danger" type="button" onclick="updateContraStatus('{$row->code}', 'REJ');">Reject</button>
                        {/if}
                        <button class="btn-app btn-primary" type="button" onclick="addContraTransfer('{$row->code}');">Edit</button>
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td align="center" colspan="8">No data found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

<script>
    var contraInitData = {$result|json_encode}

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>