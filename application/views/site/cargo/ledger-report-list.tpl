
<style>
#searchledger::placeholder {
  font-size: 16px;
  padding-left: 1px;

}
#searchledger {
  border-radius: 6px;
  border: 1px solid #D9D9D9 !important;
  background: #FFF;
  width: 250px;
  height: 35px;
  flex-shrink: 0;
}
#searchledger:focus-visible {
  outline: none;
  border: none;
}
</style>

<div class="row">
    <div class="col-lg-6">
        <div class="panel panel-default">
            <div class="panel-body">
                <h5 class="element-header">Ledger Statement For {$user}<span class="pull-right">From {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}</span></h5>
                <table class="table table-lightborder" id="ledger-summary-table" width="50%">
                    <thead class="thead-light">
                        <tr class="">
                            <th>Account Summary</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Opening Balance</td>
                            <td class="text-right">{$openingBalanceAmount|inr_format}</td>
                        </tr>
                        <tr>
                            <td>Credited Amount</td>
                            <td class="text-right">{$totalCreditAmount|inr_format}</td>
                        </tr>
                        <tr>
                            <td>Debited Amount</td>
                            <td class="text-right">{$totalDebitAmount|inr_format}</td>
                        </tr>
                        <tr>
                            <th>Balance Due</th>
                            <th class="text-right">{$closingBalanceAmount|inr_format}</th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<br>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="row d-flex search-row justify-content-end altrow">
                        <div class="col-md-4 book-group book-group-border d-conts">
                            <div class="search-icon-outter">
                                <input type="text" id="searchledger" placeholder="Search">
                                <div class="search-icon-inner" title="Search"></div>
                            </div>
                        </div>
                    </div>                                    
                </div>
                <br>
                <div class="table-responsive">
                    <table class="table table-lightborder" id="user-transaction-table" width="100%">
                        <thead>
                            <tr>
                                <th class="text-left" align="left">Date</th>
                                <th class="text-left" align="left">Account Name</th>
                                <th class="text-left" align="left">Details</th>
                                    {if $remarks_required == 1}
                                        <th class="text-left" align="left">Remarks</th>
                                    {/if}
                                <th class="text-left" align="left">Voucher Number</th>
                                <th class="text-left" align="left">Voucher Type</th>
                                <th class="text-right" align="right">Debit Amount</th>
                                <th class="text-right" align="right">Credit Amount</th>
                                <th class="text-right" align="right">Balance</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="search-box">
                                <td align="left">{$createdAt|date_format:$ns_datetime_format}</td>
                                <td>-</td>
                                <td align="left">Opening Balance</td>
                                {if $remarks_required == 1}
                                    <td>-</td>
                                {/if}
                                <td>-</td>
                                <td>-</td>
                                <td align="right">-</td>
                                <td align="right">-</td>
                                <td align="right">
                                    {$openingBalanceAmount|inr_format}
                                    {if isNotNull($contactType) && $openingBalanceAmount > 0}
                                        {if $contactType == 'CREDIT'}
                                            <span class="badge badge-danger">Cr</span>
                                        {elseif $contactType == 'DEBIT'}
                                            <span class="badge badge-success">Dr</span>
                                        {/if}
                                    {/if}
                                </td>
                            </tr>
                            {foreach item=row from=$result}
                                {if $row->activeFlag == 5}
                                    {continue}
                                {/if}
                                <tr class="search-box">
                                    <td align="left">{$row->createdAt|date_format:$ns_datetime_format}</td>
                                    <td align="left">{$row->toContact->name|default:'-'}</td>
                                    <td align="left"nowrap>{$row->description}</td>
                                    {if $remarks_required == 1}
                                        <td align="left"><span title="{$row->remarks}">{$row->remarks|truncate:30:"...":true}</span></td>
                                    {/if}
                                    <td align="left">{$row->voucherNumber|default:'-'}</td>
                                    <td align="left">{$row->ledgerType->name|default:'-'}</td>
                                    <td align="right">{$row->debitAmount|inr_format}</td>
                                    <td align="right">{$row->creditAmount|inr_format}</td>
                                    <td align="right">{$row->closingBalanceAmount|ltrim:'-'|inr_format}
                                        {if $contactType == 'CREDIT'}
                                            {if $row->closingBalanceAmount > 0}
                                            &nbsp;&nbsp;&nbsp;<span class="badge badge-danger">Cr</span>
                                            {else}
                                                &nbsp;&nbsp;&nbsp;<span class="badge badge-success">Dr</span>
                                            {/if}
                                        {elseif $contactType == 'DEBIT'}
                                            {if $row->closingBalanceAmount < 0}
                                            &nbsp;&nbsp;&nbsp;<span class="badge badge-danger">Cr</span>
                                            {else}
                                            &nbsp;&nbsp;&nbsp;<span class="badge badge-success">Dr</span>
                                            {/if}
                                        {/if}
                                    </td>
                                </tr>
                            {foreachelse}
                                <tr>
                                    <td colspan="{if $remarks_required == 1}8{else}9{/if}" align="center">No data found</td>
                                </tr>
                            {/foreach}
                        </tbody>
                        {if $result|count}
                            <tfoot>
                                <tr class="bold">
                                    <td colspan="{if $remarks_required == 1}8{else}7{/if}" align="right" class="text-danger">Balance Due</td>
                                    <td align='right'>{$closingBalanceAmount|ltrim:'-'|inr_format}
                                        {if $contactType == 'CREDIT'}
                                            {if $closingBalanceAmount > 0}
                                                &nbsp;&nbsp;&nbsp;<span class="badge badge-danger">Cr</span>
                                            {else}
                                                &nbsp;&nbsp;&nbsp;<span class="badge badge-success">Dr</span>
                                            {/if}
                                        {elseif $contactType == 'DEBIT'}
                                            {if $closingBalanceAmount < 0}
                                                &nbsp;&nbsp;&nbsp;<span class="badge badge-danger">Cr</span>
                                            {else}
                                                &nbsp;&nbsp;&nbsp;<span class="badge badge-success">Dr</span>
                                            {/if}
                                        {/if}
                                    </td>
                                </tr>
                            </tfoot>
                        {/if}
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
  $("#searchledger").on("input", function () {
        $(this).css('border', '');
        var searchTerm = $(this).val().toLowerCase();
        $(".search-box").each(function () {
            var isVisible = $(this).text().toLowerCase().includes(searchTerm);
            $(this).closest('tr').toggle(isVisible);
        });
    });
</script>
