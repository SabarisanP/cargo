<div class="table-responsive">
    <table class="table table-bordered-light" id="contra-transfer-table">
        <thead>
            <tr>
                <th>#</th>
                <th>Category</th>
                <th>Expense Ledger A/C</th>
                <th>Sub-Ledger A/c</th>
                <th>Voucher Number</th>
                <th>Amount</th>
                <th>Payment Mode</th>
                <th>Status</th>
                <th>Remarks</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$result key=k}
                <tr id="tr-{$row->code}">
                    <td> {$k+1} </td>
                    <td>
                        {$row->cashbookCategory->name}
                        {if $row->cashbookCategory->code == 'BRN'}
                            <br><span class="text-muted">{$row->organization->name}</span>
                        {elseif $row->cashbookCategory->code == 'VEH'}
                            <br><span class="text-muted">{$row->busVehicle->registationNumber}</span>
                        {/if}
                    </td>
                    <td nowrap>{$row->cashbookVendor->contactCategory->name|default:'-'}</td>
                    <td nowrap>{$row->cashbookVendor->name|default:'-'}</td>
                    <td nowrap>{$row->voucherNumber|default:'-'}</td>
                    <td>
                        {$row->amount|inr_format}
                        {if $row->cashbookTransactionDetails && $row->transactionType == 'Dr'}
                            <span data-toggle="popover" data-placement="top" data-content='<ul class="p_l_15">
                                {foreach from=$row->cashbookTransactionDetails item=staff}
                                    <li><b>{$staff->organizationContact->name} - {$staff->amount|inr_format}</b></li>
                                {/foreach}
                            </ul>'><i class="fa fa-info-circle"></i></span>
                        {/if}
                    </td>

                    <td>
                        {$row->transactionMode->name}<br>
                        <span class="text-muted">
                            {if isNotNull($row->addAttr1) || isNotNull($row->addAttr2) || isNotNull($row->addAttr3)}
                                {$row->addAttr1|default:'-'}, {$row->addAttr2|default:'-'}, {$row->addAttr3|default:'-'}<br>
                            {/if}

                            {if $row->bankDetails->code}
                                {$row->bankDetails->bankName}, {$row->bankDetails->branchLocation}
                            {elseif $row->chequeDetails->code}
                                {$row->chequeDetails->chequeNo}, {$row->chequeDetails->payerDetails}, {$row->chequeDetails->chequeDate|date_format:$ns_date_format}
                            {/if}
                        </span>
                    </td>

                    <td>
                        {if $row->acknowledgeStatus->code == 'INIT'}
                            <span class='label label-sm label-primary'>Initiated</span>
                        {elseif $row->acknowledgeStatus->code == 'APRD'}
                            <span class='label label-sm label-success'>Approved</span>
                        {elseif $row->acknowledgeStatus->code == 'REJT'}
                            <span class='label label-sm label-danger'>Rejected</span>
                        {/if}
                    </td>

                    <td width="20%">{$row->remarks|default:'-'}</td>

                    <td align="right" width="100" nowrap>
                        <span class="pull-left" data-toggle="tooltip" data-placement="top" title="{$row->user->name}<br/>{$row->transactionDate|date_format:$ns_datetime_format}"><i class="fa fa-info-circle" title="Updated By & Date"></i></span>&nbsp;
                        {if $row->acknowledgeStatus->code == 'INIT'}
                            <button class="btn-app btn-success" type="button"
                                onclick="updateExpenseLedgerStatus('{$row->code}', 'APRD');">Approve</button>&nbsp;
                            <button class="btn-app btn-danger" type="button"
                                onclick="updateExpenseLedgerStatus('{$row->code}', 'REJT');">Reject</button>
                            <a href="javascript:;" class="btn btn-default btn-sm-not edat" title="Edit"
                                onclick="addExpenseLedger('{$row->code}');"><i class="fa fa-pencil igreen"></i></a>
                                <button class="btn-app btn-primary" type="button"
                                onclick="printExpensesLedgerStatus('{$row->code}');">Print</button>

                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td align="center" colspan="9">No data found</td>
                </tr>
            {/foreach}
            <div>
                    <input name="print" id="print" class="hidden">1</input>
                    <input name="fromDate" id="fromDate" class="hidden">{$fromDate}</input>
                    <input name="toDate" id="toDate" class="hidden">{$toDate}</input>
                    <input name="organizationCode" id="organizationCode" class="hidden">{$organizationCode}</input>
                    <input name="organizationReceiptCode" id="organizationReceiptCode"
                        class="hidden">{$organizationReceiptCode}</input>
                    <input name="entryTypeCode" id="entryTypeCode" class="hidden">{$entryTypeCode}</input>
            </div>
        </tbody>
    </table>
</div>
                 
<script>
    var expenseLedgerData = {$result|json_encode};
    var fromDate ={$fromDate|json_encode};
    var toDate = {$toDate|json_encode};
    var organizationCode = {$organizationCode|json_encode};
    var organizationReceiptCode= {$organizationReceiptCode|json_encode};
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });


    function printExpensesLedgerStatus(code) {
        var data = {
            print: '1',
            fromDate: fromDate,
            toDate: toDate,
            organizationCode: organizationCode,
            organizationReceiptCode: organizationReceiptCode,
            entryTypeCode: "EXLGR",
            transitCode : code,
            summaryPrint :0
        };

        $.ajax({
            type: 'POST',
            url: 'payment/get-expense-ledger-list', // Replace 'your_php_script.php' with the path to your PHP script
            data: data,
            success: function(response) {
            // Create a hidden iframe and set its content to the response
            var iframe = $('<iframe>', {
                id: 'printFrame',
                width: '1px',
                height: '1px',
                css: {
                    position: 'absolute',
                    left: '-9999px',
                    top: '-9999px'
                }
            }).appendTo('body');

            var doc = iframe[0].contentWindow.document;
            doc.open();
            doc.write(response);
            doc.close();

            // Call the print function after the iframe content has loaded
            iframe.ready(function() {
                iframe[0].contentWindow.print();
            });
        },
        error: function(xhr, status, error) {
            // Handle errors here
            console.error(error); // Log the error to the console
        }
        });
    }
</script>