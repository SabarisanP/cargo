<h5>Namespace Contact</h5>
<table class="table table-hover" id="bank-details-table">
    <thead>
        <tr class="bold">
            <th>Name</th>
            <th>Credit/Debit</th>
            <th>Mobile No</th>
            <th>Address</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$contact item=row}
            <tr>
                <td width="20%">{$row->name}</td>
                
                <td>
                    {if $row->tagList[0] == 'CREDIT'}
                        <span class="badge badge-danger">Credit</span>
                    {elseif $row->tagList[0] == 'DEBIT'}
                        <span class="badge badge-success">Debit</span>
                    {else}
                        -
                    {/if}
                </td>

                <td width="20%">{$row->mobile}</td>
                <td width="30%" style="word-break: break-word;">{$row->contactAddress->address}</td>
                
                <td width="10%">
                    <span class="p_l_15">
                        <a href="javascript:;" title="Edit" onclick="editNamespace('{$row->code}');"><i class="fa fa fa-pencil fa-lg"></i></a>
                    </span>
                </td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="5" align="center">No Data Found</td>
            </tr>
        {/foreach}
    </tbody>
</table>
<hr style="border: 1px dashed #000;">
<h5>Namespace Bank</h5>
<table class="table table-hover" id="bank-details-table">
    <thead>
        <tr class="bold">
            <th width="15%">Account Name</th>
            <th width="14%">Account Number</th>
            <th width="13%">Account Type</th>
            <th width="14%">Bank Name</th>
            <th width="15%">Branch Location</th>
            <th width="10%">IFSC Code</th>
            <th width="10%">UPI Id</th>
            <th width="9%"></th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$bank_detail item=row}
            <tr>
                <td>{$row->name}</td>
                <td>{$row->accountNumber}</td>
                <td>{$row->accountType->name}</td>
                <td>{$row->bankName}</td>
                <td>{$row->branchLocation}</td>
                <td>{$row->ifscCode}</td>
                <td>{$row->upiId}</td>
                <td>
                    <span class="p_l_15">
                        <a href="javascript:;" title="Edit" onclick="addBankDetails({$row|json_encode|escape});"><i class="fa fa fa-pencil fa-lg"></i></a>
                    </span>
                    <span class="p_l_15">
                        <a href="javascript:;" title="Delete" onclick="deleteBankDetails({$row|json_encode|escape});"><i class="fa fa-trash-o fa-lg"></i></a>
                    </span>
                </td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="7" align="center">No Data Found</td>
            </tr>
        {/foreach}
    </tbody>
</table>

<script>
    var namespaceData = {$contact|json_encode}
</script>