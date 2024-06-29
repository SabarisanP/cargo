<table class="table table-hover none" id="bank-details-table">
    <thead>
        <tr class="bold">
            <th>Acc Holder Name</th>
            <th>Account No</th>
            <th>IFSC Code</th>
            <th>Bank Name</th>
            <th>Branch location</th>
            <th>Acc Type</th>
            <th>UPI ID</th>
        </tr>
    </thead>
    <tbody>
    {foreach item=row from=$bank_detail}
        <tr>
            <td>{$row->name} {$row->lastName}</td>
            <td>{$row->accountNumber}</td>
            <td>{$row->ifscCode}</td>
            <td>{$row->bankName}</td>
            <td>{$row->branchLocation}</td>
            <td>{$row->accountType->name}</td>
            <td>{$row->upiId}</td>
            <td>
                <span class="p_l_15">
                    <a href="javascript:;" title="Edit" onclick="showBankDialog('{$row|json_encode|escape}');"><i class="fa fa fa-pencil fa-lg"></i></a>
                </span>
                <span class="p_l_15">
                    <a href="javascript:;" title="Delete" onclick="deleteBankDetail('{$row|json_encode|escape}');"><i class="fa fa-trash-o fa-lg"></i></a>
                </span>
            </td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="7" align="center" class="bold">No Record Found</td>
        </tr>
    {/foreach}
    </tbody>
</table>