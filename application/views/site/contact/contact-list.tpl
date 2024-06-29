{if $entity_type == 'EXP'}
    <table class="table table-hover" id="con-usr-table">
        <thead>
            <tr class="bold">
                <th>Name</th>
                <th>Contact</th>
                <th>Credit/Debit</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$contact item=row}
                <tr>
                    <td>{$row->name}</td>
                    <td>{$row->contactName}</td>
                    <td>
                        {if $row->tagList[0] == 'CREDIT'}
                            <span class="badge badge-danger">Credit</span>
                        {elseif $row->tagList[0] == 'DEBIT'}
                            <span class="badge badge-success">Debit</span>
                        {else}
                            -
                        {/if}
                    </td>
                    <td width="10%">
                        <span class="p_l_15">
                            <a href="javascript:;" title="Edit" onclick="addExpense('{$row->code}');"><i class="fa fa fa-pencil fa-lg"></i></a>
                        </span>
                        <span class="p_l_15">
                            <a href="javascript:;" title="Delete" onclick="deleteExpense('{$row->code}');"><i class="fa fa-trash-o fa-lg"></i></a>
                        </span>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{elseif $type == 'OTHERS'}
    <table class="table table-hover" id="con-usr-table">
        <thead>
            <tr class="bold">
                <th>Name</th>
                <th>Contact</th>
                <th>Credit/Debit</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$contact item=row}
                <tr>
                    <td>{$row->name}</td>
                    <td>{$row->contactName}</td>
                    <td>
                        {if $row->tagList[0] == 'CREDIT'}
                            <span class="badge badge-danger">Credit</span>
                        {elseif $row->tagList[0] == 'DEBIT'}
                            <span class="badge badge-success">Debit</span>
                        {else}
                            -
                        {/if}
                    </td>
                    <td width="10%">
                        <span class="p_l_15">
                            <a href="javascript:;" title="Edit" onclick="addOtherContacts('{$row->code}');"><i class="fa fa fa-pencil fa-lg"></i></a>
                        </span>
                        <span class="p_l_15">
                            <a href="javascript:;" title="Delete" onclick="deleteOtherContacts('{$row->code}');"><i class="fa fa-trash-o fa-lg"></i></a>
                        </span>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{else}
    <table class="table table-hover" id="con-usr-table">
        <thead>
            <tr class="bold">
                <th>Name</th>
                {if $entity_type != 'BRCH'}<th>Trade Name</th>{/if}
                <th>Credit/Debit</th>
                <th>Mobile No</th>
                <th>Address</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$contact item=row}
                <tr id="con-usr-{$row->code}" {if $entity_type != 'BRCH'}class="point_cur" onclick="view({$row|json_encode|escape})"{/if}>
                    <td {if $entity_type == 'BRCH'}width="30%"{else}width="20%"{/if}>{$row->name}</td>

                    {if $entity_type != 'BRCH'}
                        <td width="17%">{$row->tradeName}</td>
                    {/if}

                    <td>
                        {if $row->tagList[0] == 'CREDIT'}
                            <span class="badge badge-danger">Credit</span>
                        {elseif $row->tagList[0] == 'DEBIT'}
                            <span class="badge badge-success">Debit</span>
                        {else}
                            -
                        {/if}
                    </td>

                    <td {if $entity_type == 'BRCH'}width="25%"{else}width="10%"{/if}>{$row->mobile}</td>

                    <td {if $entity_type == 'BRCH'}width="45%"{else}width="33%"{/if} style="word-break: break-word;">{$row->contactAddress->address}</td>
                    {if $entity_type != 'BRCH'}
                        <td width="10%">
                            <span class="p_l_15">
                                <a href="javascript:;" title="Edit" onclick="showAddNew({$row|json_encode|escape});"><i class="fa fa fa-pencil fa-lg"></i></a>
                            </span>
                            <span class="p_l_15">
                                <a href="javascript:;" title="Delete" onclick="deleteContact({$row|json_encode|escape});"><i class="fa fa-trash-o fa-lg"></i></a>
                            </span>
                        </td>
                    {elseif $entity_type == 'BRCH'}
                        <td width="10%">
                            <span class="p_l_15">
                                <a href="javascript:;" title="Edit" onclick="addBranch('{$row->code}');"><i class="fa fa fa-pencil fa-lg"></i></a>
                            </span>
                        </td>
                    {/if}
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="5" align="center">No Data Found</td>
                </tr>
            {/foreach}
        </tbody>
        <tfoot>
            <tr class=" none p_t_n" id="con-usr-details">
                <td colspan="6">
                    <div class="table table-responsive">
                        <table class="table table-borderless" style="border: 1px solid #ddd;" id="con-usr-det-table">
                            <tbody>
                                <tr id="basic-dtl">
                                    <th>Name</th>
                                    <td class="name" width="15%" style="vertical-align: baseline;"></td>
                                    <th>Trade Name</th>
                                    <td class="trd-name" style="width: 20%;word-break: break-word;vertical-align: baseline"></td>
                                    <th>GSTIN</th>
                                    <td class="gstin" style="vertical-align: baseline;"></td>
                                </tr>

                                <tr id="basic-dtl">
                                    <th>Contact Name</th>
                                    <td class="con-name"></td>
                                    <th>Mobile</th>
                                    <td class="mob" style="vertical-align: baseline;"></td>
                                    <th>Email</th>
                                    <td class="email" style="vertical-align: baseline;"></td>
                                </tr>
                                <tr id="basic-dtl">
                                    <th class="own-tpe">Tag</th>
                                    <td class="own own-tpe" style="vertical-align: baseline;"></td>
                                    <th>Address</th>
                                    <td class="address" colspan="3" style="width: 45%;word-break: break-word;"></td>
                                </tr>
                                <tr id="basic-dtl">
                                    <th>ACC Holder Name</th>
                                    <td class="acc-hld-name"></td>
                                    <th>Acc Number</th>
                                    <td class="acc-num"></td>
                                    <th>Acc Type</th>
                                    <td class="acc-tpe"></td>
                                </tr>
                                <tr id="basic-dtl">
                                    <th>Bank Name</th>
                                    <td class="bnk-name"></td>
                                    <th>Branch</th>
                                    <td class="brn"></td>
                                    <th>IFSC Code</th>
                                    <td class="ifsc"></td>
                                </tr>
                                <tr id="basic-dtl">
                                    <th>UPI ID</th>
                                    <td class="upi"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-default none btn-sm" id="cancel-view" type="button" onclick="cancelView();">Close</button>
                    </div>
                </td>
            </tr>
        </tfoot>
    </table>
{/if}

<script>
    var contactData = {$contact|json_encode}
</script>