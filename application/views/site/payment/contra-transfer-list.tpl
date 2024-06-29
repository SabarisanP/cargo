
<div class="table-responsive">
    <table class="table table-bordered-light" id="contra-transfer-table">
        <thead>
            <tr>
                <th>#</th>
                <th>Date</th>
                <th>Payment from</th>
                <th>Account</th>
                <th>Payment to</th>
                <th>Account</th>
                <th>Remarks</th>
                <th>Amount</th>
                <th>By</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$result key=k}
                <tr id="tr-{$row->code}">
                    <td> {$k+1} </td>
                    <td nowrap>{$row->updatedAt|date_format:$ns_date_format}</td>
                    <td nowrap>{$row->fromOrganization->name}</td>
                    <td nowrap>{$row->fromAccount->name}</td>
                    <td nowrap>{$row->toOrganization->name}</td>
                    <td nowrap>{$row->toAccount->name}</td>
                    <td nowrap>{($row->remarks) ? $row->remarks : '-'}</td>
                    <td data-order="{$row->amount}" nowrap>{$row->amount|inr_format}</td>
                    <td nowrap>{$row->updatedBy->name}</td>
                    <td width="350" class="pl-1" nowrap>
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group mb-0">
                                    <select class="form-control contra-transfer-status" {if $row->paymentStatus->code == 'PAID'}disabled{/if}>
                                        <option value="">Select Status</option>
                                        {foreach from=$branch_trans_status item=val key=key}
                                            <option value="{$key}" {if $key == $row->paymentStatus->code}selected{/if}>{$val}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            {if $row->paymentStatus->code != 'PAID'}
                                <div class="col-sm-5">
                                    <textarea class="form-control contra-transfer-remarks" placeholder="Remarks" rows="1" maxlength="128"></textarea>
                                </div>
                                <div class="col-auto">
                                    <button class="btn btn-sm btn-primary" onclick="ContraTransfer.updateStatus('{$row->code}')"> Update</button>
                                </div>
                            {/if}
                        </div>
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td align="center" colspan="10">No data found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
                    