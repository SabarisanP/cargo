<div class="row">
    <div class="col-lg-6">
        <div class="panel panel-default">
            <div class="row">
                <div class="col-md-12">
                    <h5 class="element-header">Transactions For {$username}<span class="pull-right">From {$smarty.request.from|date_format:$ns_date_format} to {$smarty.request.to|date_format:$ns_date_format}</span></h5>
                    <table class="table">
                        <thead>
                            <tr class="">
                                <th>Account Summary</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Opening Balance (A)</td>
                                {assign var="opening" value=$first_trans->closingBalance - $first_trans->creditAmount + $first_trans->debitAmount}
                                <td align="right">{$opening|inr_format}</td>
                            </tr>
                            <tr>
                                <td>Credit Amount (B)</td>
                                <td align="right">{$credit_amount|inr_format}</td>
                            </tr>
                            <tr>
                                <td>Debit Amount (C)</td>
                                <td align="right">{$debit_amount|inr_format}</td>
                            </tr>
                            <tr>
                                <td>Closing Balance (D)</td>
                                {assign var="closing" value=$last_trans->closingBalance}
                                <td align="right">{$closing|inr_format}</td>
                            </tr>
                            <tr>
                                <th>Balance Due	 (D - A)</th>
                                <td align="right">{($closing - $opening)|inr_format}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="clearfix"></div><br>

<div class="panel panel-default">
    <div class="table-responsive">
        <table id="dt_report_table" class="table">
            <thead>
                <tr>
                    <th style='width: 50px;'>#&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th style='width: 120px;'>Transaction Date&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th style='width: 120px;'>Details&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th class="text-right" style='width: 90px;'>Credit Amount&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th class="text-right" style='width: 90px;'>Debit Amount&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th class="text-right" style='width: 100px;'>Closing Balance&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                </tr>
            </thead>
            <tbody class="body_table">

                {foreach item=row from=$reports key =k}
                    <tr>
                        <td>{$k+1}</td>
                        <td data-order="{$row->transactionDate|strtotime}">{$row->transactionDate|date_format:$ns_datetime_format}</td>
                        <td nowrap>{$row->description}</td>
                        <td align="right" data-order="{$row->creditAmount}"><i class="fa fa-inr"></i>&nbsp;{$row->creditAmount|number_format:2}</td>
                        <td align="right" data-order="{$row->debitAmount}"><i class="fa fa-inr"></i>&nbsp;{$row->debitAmount|number_format:2}</td>
                        <td align="right" data-order="{$row->closingBalance}"><i class="fa fa-inr"></i>&nbsp;{$row->closingBalance|number_format:2}</td>
                    </tr>
                {/foreach}

            </tbody>
        </table>
    </div>
</div>

<script>
    $(document).ready(function() {

        $('#dt_report_table').dataTable({
            //scrollY: 500,
            "sDom": '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
                't' +
                '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
            //tableTools: {
            //"sSwfPath": "assets/lib/DataTables/extensions/TableTools/swf/copy_csv_xls_pdf.swf"
            //}

        });
        $('#ToolTables_dt_report_table_0').hide();
        $('#ToolTables_dt_report_table_1').hide();
        $('#ToolTables_dt_report_table_2').hide();
        $('#ToolTables_dt_report_table_3').hide();
        $("select[name=dt_report_table_length]").val("50").change();

    });
</script>
