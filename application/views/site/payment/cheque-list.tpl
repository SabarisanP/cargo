<div class="table-responsive">
    <table class="table table-bordered-light">
        <thead>
            <tr>                    
                <th>Cheque Sequence</th>
                <th>Cheque No</th>
                <th>Cheque Date</th>
                <th>Status</th>
                <th>LR / Invoice</th>
                <th>Branch</th>
                <th>Organization Bank</th>

                <th>Payer Details</th>
                <th>Bank Details</th>
                <th>Bank City</th>

                <th>Amount</th>
                <th>Deposit Date</th>
                <th>Credit Date</th> 
                <th>Remarks</th>
                <td></td>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$result}
                <tr>                        
                    <td align='left' nowrap>
                        {$row->code}&nbsp;
                        <a href="javascript:;" title="Cheque History" onclick="chequeHistoryDialog('{$row->code}');"><i class="fa fa-history"></i></a>
                    </td>

                    <td align='left'>{$row->chequeNo}</td>
                    <td align='left' nowrap>{$row->chequeDate|date_format:$ns_date_format|default:'-'}</td>
                    <td align='left'>
                        {if $row->chequeStatus->code == 'NEW'}
                            <span class="badge badge-primary">{$cheque_status[$row->chequeStatus->code]}</span>
                        {elseif $row->chequeStatus->code == 'DPST'}
                            <span class="badge badge-info">{$cheque_status[$row->chequeStatus->code]}</span>
                        {elseif $row->chequeStatus->code == 'CRDT'}
                            <span class="badge badge-success">{$cheque_status[$row->chequeStatus->code]}</span>
                        {elseif $row->chequeStatus->code == 'HOLD' || $row->chequeStatus->code == 'REPST'}
                            <span class="badge badge-warning">{$cheque_status[$row->chequeStatus->code]}</span>
                        {elseif $row->chequeStatus->code == 'BNCE'}
                            <span class="badge badge-danger">{$cheque_status[$row->chequeStatus->code]}</span>
                        {else}
                            <span class="badge badge-secondary">{$cheque_status[$row->chequeStatus->code]}</span>
                        {/if}
                        {if isNotNull($row->additionalAttr->TRANSACTION_RECEIPT_CODE)}
                            <span data-content="<span class='badge badge-success'>Payment Received</span><br>Transaction Receipt Code : {$row->additionalAttr->TRANSACTION_RECEIPT_CODE}" data-toggle="popover"><i class="fa fa-info-circle"></i></span>
                        {/if}
                    </td>
                    <td align='left'>
                        {if $row->referenceType->code == 'LR'}
                            <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->referenceCode}")'>{$row->referenceCode}</a><br>
                            <span class="small text-muted">LR</span>
                        {elseif $row->referenceType->code == 'INV'}
                            <a href="javascript:;"  onclick="showInvoicePdfDialog('{$row->referenceCode}');">{$row->referenceCode}</a><br>
                            <span class="small text-muted">Invoice</span>
                        {elseif $row->referenceType->code == 'TRT'}
                            {$row->referenceCode}<br>
                            <span class="small text-muted">Receipt</span>
                        {/if}
                    </td>
                    <td align='left'>{$row->organization->name}</td>
                    <td align='left'>
                        {if isNotNull($row->namespaceBank->code)}
                            {$row->namespaceBank->name} <br>
                            <span class="text-muted">{$row->namespaceBank->accountNumber}</span>
                        {/if}
                    </td>

                    <td align='left'>{$row->payerDetails}</td>
                    <td align='left'>{(isNotNull($row->bankDetails)) ? $row->bankDetails : '-'}</td>
                    <td align='left'>{$row->bankCity}</td>

                    <td align='left'>{$row->amount|number_format:2}</td>
                    <td align='center'>{$row->chequeDepositDate|date_format:$ns_date_format|default:'-'}</td>
                    <td align='center'>{$row->chequeRealizeDate|date_format:$ns_date_format|default:'-'}</td>

                    <td align='left'>{if $row->remarks == ''}-{else}{$row->remarks}{/if}</td>
                    
                    <td align='center'>
                        {if !in_array($row->chequeStatus->code, ['CRDT']) && !$row->additionalAttr->TRANSACTION_RECEIPT_CODE}
                            <a href="javascript:;" class="" title="Edit Status" onclick="editStatusDialog('{$row->code}')"><i class="fa fa-check-square-o fa-lg "></i></a>
                        {/if}
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
<script>
    var chequeData = {$result|json_encode}
    
    $('[data-toggle="popover"]').popover({
        container:'body',
        html:true,
        placement:'right',
        trigger:'manual',
    }).on("mouseenter", function() {
        var _this = this;
        $(this).popover("show");
        $(".popover").on("mouseleave", function() {
            $(_this).popover('hide');
        });
    }).on("mouseleave", function() {
        var _this = this;
        setTimeout(function() {
            if (!$(".popover:hover").length) {
                $(_this).popover("hide");
            }
        }, 300);
    }); 
</script>
