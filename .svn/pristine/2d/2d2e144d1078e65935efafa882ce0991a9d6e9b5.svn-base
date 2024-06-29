<div class="brand_top">
    <h3>{iflang('Vendor Due Report')}</h3>
    <div class="text-right noprint" id="vehrev_rpt_excel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportVendorDue();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the pending invoice amount and running balance amount based on Vendor.
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">
                                        <div class="">
                                            <div class="table-responsive">
                                                <table id="vendor_due_table" class="table table-bordered" width="98%">
                                                    <thead>
                                                        <tr class="info">
                                                            <th>Name<i class="fa fa-sort fa-fw pull-right"></i></th>
                                                            <th>Last Transaction Date<i class="fa fa-sort fa-fw pull-right"></i></th>
                                                            <th>Invoice Due<i class="fa fa-sort fa-fw pull-right"></i></th>
                                                            <th>Running / UnInvoiced Due<i class="fa fa-sort fa-fw pull-right"></i></th>
                                                            <th>Total Due<i class="fa fa-sort fa-fw pull-right"></i></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="body_table">
                                                        {foreach from=$result item=row}
                                                            {if $row->user_role_code == 'CGCUST'}
                                                                {$transaction_date  = strtotime($row->last_transaction_date)}
                                                                {$inv_due_day  = $row->invoice_due_days}
                                                                {$settle_due_day  = $row->settlement_due_days}
                                                                {$current_date = $smarty.now}
                                                                {$diff = 0}
                                                                {$inv = ''}
                                                                {$stle = ''}
                                                                {if $transaction_date > 0}
                                                                    {if $current_date >= $transaction_date}
                                                                        {$diff = ($current_date|date_format:$ns_date_format|daysBetween: ($row->last_transaction_date|date_format:$ns_date_format))}
                                                                        
                                                                        {if ($inv_due_day - $diff)>0}
                                                                            {$inv = 'Invoice due '|cat:($inv_due_day - $diff)|cat:' days to go'}
                                                                        {else}
                                                                            {$inv = 'Invoice Overdue'}
                                                                        {/if}

                                                                        {if ($settle_due_day - $diff)>0}
                                                                            {if $row->ack_status_id == 1}
                                                                                {$stle = 'Settlement due '|cat:($settle_due_day - $diff)|cat:' days to go'}
                                                                            {/if}
                                                                        {else}
                                                                            {if $row->ack_status_id == 1}
                                                                                {$stle = 'Settlement Overdue'}
                                                                            {/if}
                                                                        {/if}

                                                                    {elseif $current_date < $transaction_date}
                                                                        {$inv = 'Invoice Overdue'}

                                                                        {if $row->ack_status_id == 1}
                                                                            {$stle = 'Settlement Overdue'}
                                                                        {/if}
                                                                    {/if}
                                                                {/if}
                                                                
                                                                <tr title="Credit Limit : {$row->credit_limit}&#013{$inv}&#013{if $stle}{$stle}{/if}" style="cursor: pointer;">
                                                                    <td>{$row->first_name}</td>
                                                                    <td>{$row->last_transaction_date|date_format:$ns_datetime_format|default:'-'}</td>
                                                                    <td align="right">{$row->current_balance|sigma:$t_current_balance|inr_format}</td>
                                                                    <td align="right">{$row->running_balance|sigma:$t_running_balance|inr_format}</td>
                                                                    <td align="right">{($row->current_balance + $row->running_balance)|sigma:$t_total_balance|inr_format}</td>
                                                                </tr>
                                                            {/if}
                                                        {/foreach}
                                                    </tbody>
                                                    <tfoot>
                                                        <tr class="bold">
                                                            <td align="right" colspan="2">Total</td>
                                                            <td align="right">{$t_current_balance|inr_format}</td>
                                                            <td align="right">{$t_running_balance|inr_format}</td>
                                                            <td align="right">{$t_total_balance|inr_format}</td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<form id="vendor_due" method="post" name="vendor_due" action="cargo/vendor_due_report" onsubmit="return false;" class="hidden">
    <input type="hidden" name="export" id="export" value="1">
</form>
    
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<script>
    $('#vendor_due_table').DataTable({
        paging:false
    });
    
    function exportVendorDue() {
        document.vendor_due.target = "ifrm_downloader";
        document.vendor_due.submit();
        return;
    }
</script>