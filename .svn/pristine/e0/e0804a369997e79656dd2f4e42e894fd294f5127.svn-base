<div>
    <table width="100%">
        <tr>
            <td align="right">
                <span style="font-weight:bold; font-size: 20px; align-items: center;">
                    {$namespace_name}
                </span>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <b>Report Date : </b>{$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}
            </td>
            <td colspan="3" align="right"><b>Report At : </b>{$smarty.now|date_format:$ns_datetime_format}</td>
        </tr>
        <tr>
            <td colspan="3" align="left">Status :{$printStatus}</td>
            <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$user_name}</td>
        </tr>
        <tr>
            <td colspan="3" align="left"><b> Station : {if $filterCode == "NA"} ALL STATION{else}{$stationStatus} {/if}</b></td>
            <td colspan="3" align="right"></td>
        </tr>
    </table>
    <br>

    {if $printStatus =="ALL"}
        {if $filterCode == "NA"}
            <div class="row">
                <div class="col-md-4"><br><br>
                    <table id="transit_based_summary_all" class="table table-bordered" border="1">
                        <thead>
                            <tr style="background-color:#83e020; color: #000000fb; font-weight: bold;">
                                <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                            </tr>
                        </thead>
                        <tbody class="body_table">
                            {assign var=t_payable value=0}
                            {assign var=t_paid value=0}
                            {assign var=t_bal value=0}
                            {foreach item=row from=$summaryWiseall}
                                {if $row['name'] =="ALL"}
                                    <tr>
                                        <td>{$row['to_station_name']}</td>
                                        <td align="right">{$row['payable_amt']|number_format:2}</td>
                                        <td align="right">{$row['paid_amt']|number_format:2}</td>
                                        <td align="right">{$row['bal_amt']}</td>
                                    </tr>
                                    {assign var=t_payable value=$t_payable+$row['payable_amt']}
                                    {assign var=t_paid value=$t_paid+$row['paid_amt']}
                                    {assign var=t_bal value=$t_bal+$row['bal_amt']}
                                {/if}
                            {foreachelse}
                                <tr>
                                    <td colspan="4" align="center">No data found</td>
                                </tr>
                            {/foreach}
                        </tbody>
                        {if count($summaryWiseall) > 0}
                            <tr class="bold" style="background-color: #bbbbbb; color: #000;  font-weight: bold;">
                                <td align="right">Total</td>
                                <td align="right">{$t_payable|number_format:2}</td>
                                <td align="right">{$t_paid|number_format:2}</td>
                                <td align="right">{$t_bal|number_format:2}</td>
                            </tr>
                        {/if}
                    </table>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-4"></div>
            </div>
        {/if}

        <br><br>
        <table id="transit_based_report_ogpl_all" class="table table-bordered" border="1" width="100%">
            <thead>
                <tr style="background-color:#83e020; color: #000000fb; font-weight: bold;">
                    <td align="center">Date <i class="fa fa-sort"></td>
                    <td align="center">{lang('ogpl')} No. <i class="fa fa-sort"></td>
                    <td align="center">Vehicle No. <i class="fa fa-sort"></td>
                    {* <td align="center">Route <i class="fa fa-sort"></td>
                    <td align="center">From Station <i class="fa fa-sort"></td> *}
                    <td align="center"> To Station <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center">Remarks <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=t_payableAmt value=0}
                {assign var=t_paidAmt value=0}
                {assign var=t_balAmt value=0}
                {foreach item=rows from=$stationWise}
                    {foreach item=row from=$rows}
                        {assign var=paid_amount value=0}
                        {assign var="paid_amount" value=($row['payable_amt']- $row['paid_amt'])}

                        {assign var="rtopay" value=($row['payable_amt']- $row['paid_amt'])}
                        {assign var=t_payableAmt value=$t_payableAmt+$row['payable_amt']}
                        {assign var=t_paidAmt value=$t_paidAmt + $row['paid_amt']}
                        {assign var=t_balAmt value=$t_balAmt + $rtopay}
                        <tr>
                            <td nowrap>{$row['load_date']}</td>
                            <td>{$row['ogpl_no']}</td>
                            <td>{$row['vehicle']}</td>
                            {* <td nowrap> {($row['from_station_name']|cat:" to "|cat:$row['to_station_name'])|truncate:30}</td>
                        <td>{$row['from_station_name']}</td> *}
                            <td>{$row['to_station_name']}</td>
                            <td align="right">{$row['payable_amt']|number_format:2}</td>
                            <td align="right">{$row['paid_amt']|number_format:2} &nbsp;&nbsp;&nbsp; <a title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true" onclick="getTransitAllTransaction('{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}')"></i> </a></td>
                            <td align="right">{$rtopay|inr_format}</td>
                            <td align="center">{$row['remark']|trim:', '}</td>
                        </tr>
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="10" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>
            {if count($stationWise) > 0}
                <tr style=" font-weight: bold;">
                    <td colspan="4" align="right">Total</td>
                    <td align="right">{$t_payableAmt|number_format:2}</td>
                    <td align="right">{$t_paidAmt|number_format:2}</td>
                    <td align="right">{$t_balAmt|number_format:2}</td>
                    <td align="right"></td>
                </tr>
            {/if}
        </table>
    {/if}

    {if $printStatus =="PAID"}
        {if $filterCode == "NA"}
            <div class="row">
                <div class="col-md-4"><br><br>
                    <table id="transit_based_summary_paid" class="table table-bordered" border="1">
                        <thead>
                            <tr style="background-color:#83e020; color: #000000fb; font-weight: bold;">
                                <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                            </tr>
                        </thead>
                        <tbody class="body_table">
                            {assign var=t_payable value=0}
                            {assign var=t_paid value=0}
                            {assign var=t_bal value=0}
                            {foreach item=row from=$summaryWisePaid}
                                {if $row['name'] =="PAID"}
                                    <tr>
                                        <td>{$row['to_station_name']}</td>
                                        <td align="right">{$row['payable_amt']|number_format:2}</td>
                                        <td align="right">{$row['paid_amt']|number_format:2}</td>
                                        <td align="right">{$row['bal_amt']}</td>
                                    </tr>
                                    {assign var=t_payable value=$t_payable+$row['payable_amt']}
                                    {assign var=t_paid value=$t_paid+$row['paid_amt']}
                                    {assign var=t_bal value=$t_bal+$row['bal_amt']}
                                {/if}
                            {foreachelse}
                                <tr>
                                    <td colspan="4" align="center">No data found</td>
                                </tr>
                            {/foreach}
                        </tbody>
                        {if count($summaryWisePaid) > 0}
                            <tr class="bold" style="background-color: #bbbbbb; color: #000; font-weight: bold;">
                                <td align="right">Total</td>
                                <td align="right">{$t_payable|number_format:2}</td>
                                <td align="right">{$t_paid|number_format:2}</td>
                                <td align="right">{$t_bal|number_format:2}</td>
                            </tr>
                        {/if}
                    </table>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-4"></div>
            </div>
        {/if}
        <br><br>
        <table id="transit_based_report_ogpl_paid" class="table table-bordered" border="1" width="100%">
            <thead>
                <tr style="background-color:#83e020; color: #000000fb; font-weight: bold;">
                    <td align="center">Date <i class="fa fa-sort"></td>
                    <td align="center">{lang('ogpl')} No. <i class="fa fa-sort"></td>
                    <td align="center">Vehicle No. <i class="fa fa-sort"></td>
                    {* <td align="center">Route <i class="fa fa-sort"></td>
                    <td align="center">From Station <i class="fa fa-sort"></td> *}
                    <td align="center"> To Station <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center">Remarks <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=t_payableAmt value=0}
                {assign var=t_paidAmt value=0}
                {assign var=t_balAmt value=0}
                {foreach item=rows from=$stationWise}
                    {foreach item=row from=$rows}
                        {assign var=paid_amount value=0}
                        {assign var="paid_amount" value=($row['payable_amt']- $row['paid_amt'])}

                        {if $paid_amount <= 0}
                            {assign var="rtopay" value=($row['payable_amt']- $row['paid_amt'])}
                            {assign var=t_payableAmt value=$t_payableAmt+$row['payable_amt']}
                            {assign var=t_paidAmt value=$t_paidAmt + $row['paid_amt']}
                            {assign var=t_balAmt value=$t_balAmt + $rtopay}
                            <tr id="brn-{$row['ogpl_no']}-{$row['code']}" class="tr-hover" onclick="toggleTopayPaid('brn-{$row['ogpl_no']}-{$row['code']}');">
                                <td nowrap>{$row['load_date']}</td>
                                <td>{$row['ogpl_no']}</td>
                                <td>{$row['vehicle']}</td>
                                {* <td nowrap> {($row['from_station_name']|cat:" to "|cat:$row['to_station_name'])|truncate:30}</td> *}
                                {* <td>{$row['from_station_name']}</td> *}
                                <td>{$row['to_station_name']}</td>
                                <td align="right">{$row['payable_amt']|number_format:2}</td>
                                <td align="right">{$row['paid_amt']|number_format:2} &nbsp;&nbsp;&nbsp; <a title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true" onclick="getTransitAllTransaction('{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}')"></i> </a></td>
                                <td align="right">{$rtopay|inr_format}</td>
                                <td align="center">{$row['remark']|trim:', '}</td>

                            </tr>
                        {/if}
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="10" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>
            {if count($stationWise) > 0}
                <tr style=" font-weight: bold;">
                    <td colspan="4" align="right">Total</td>
                    <td align="right">{$t_payableAmt|number_format:2}</td>
                    <td align="right">{$t_paidAmt|number_format:2}</td>
                    <td align="right">{$t_balAmt|number_format:2}</td>
                    <td align="right"></td>
                </tr>
            {/if}
        </table>
    {/if}

    {if $printStatus =="UNPAID"}
        {if $filterCode == "NA"}
            <div class="row">
                <div class="col-md-4"><br><br>
                    <table id="transit_based_summary_unpaid" class="table table-bordered" border="1">
                        <thead>
                            <tr style="background-color:#83e020; color: #000000fb; font-weight: bold;">
                                <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                                <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                            </tr>
                        </thead>
                        <tbody class="body_table">

                            {assign var=t_payable value=0}
                            {assign var=t_paid value=0}
                            {assign var=t_bal value=0}
                            {foreach item=row from=$summaryWise}
                                {if $row['name'] =="UNPAID"}
                                    <tr>
                                        <td>{$row['to_station_name']}</td>
                                        <td align="right">{$row['payable_amt']|number_format:2}</td>
                                        <td align="right">{$row['paid_amt']|number_format:2}</td>
                                        <td align="right">{$row['bal_amt']}</td>
                                    </tr>
                                    {assign var=t_payable value=$t_payable+$row['payable_amt']}
                                    {assign var=t_paid value=$t_paid+$row['paid_amt']}
                                    {assign var=t_bal value=$t_bal+$row['bal_amt']}
                                {/if}
                            {foreachelse}
                                <tr>
                                    <td colspan="4" align="center">No data found</td>
                                </tr>
                            {/foreach}
                        </tbody>
                        {if count($summaryWise) > 0}
                            <tr class="bold" style="background-color: #bbbbbb; color: #000; font-weight: bold;">
                                <td align="right">Total</td>
                                <td align="right">{$t_payable|number_format:2}</td>
                                <td align="right">{$t_paid|number_format:2}</td>
                                <td align="right">{$t_bal|number_format:2}</td>
                            </tr>
                        {/if}
                    </table>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-4"></div>
            </div>
        {/if}
        <br><br>
        <table id="transit_based_report_ogpl_Un_paid" class="table table-bordered" border="1" width="100%">
            <thead>
                <tr style="background-color:#83e020; color: #000000fb; font-weight: bold;">
                    <td align="center">Date <i class="fa fa-sort"></td>
                    <td align="center">{lang('ogpl')} No. <i class="fa fa-sort"></td>
                    <td align="center">Vehicle No. <i class="fa fa-sort"></td>
                    {* <td align="center">Route <i class="fa fa-sort"></td> *}
                    {* <td align="center">From Station <i class="fa fa-sort"></td> *}
                    <td align="center"> To Station <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center">Remarks <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=t_payableAmt value=0}
                {assign var=t_paidAmt value=0}
                {assign var=t_balAmt value=0}
                {foreach item=rows from=$stationWise}
                    {foreach item=row from=$rows}
                        {assign var=paid_amount value=0}
                        {assign var="paid_amount" value=($row['payable_amt']- $row['paid_amt'])}
                        {if $paid_amount > 0}
                            {assign var="rtopay" value=($row['payable_amt']- $row['paid_amt'])}
                            {assign var=t_payableAmt value=$t_payableAmt+$row['payable_amt']}
                            {assign var=t_paidAmt value=$t_paidAmt + $row['paid_amt']}
                            {assign var=t_balAmt value=$t_balAmt + $rtopay}
                            <tr id="brn-{$row['ogpl_no']}-{$row['code']}" class="tr-hover" onclick="toggleTopayPaid('brn-{$row['ogpl_no']}-{$row['code']}');">
                                <td nowrap>{$row['load_date']}</td>
                                <td>{$row['ogpl_no']}</td>
                                <td>{$row['vehicle']}</td>
                                {* <td nowrap> {($row['from_station_name']|cat:" to "|cat:$row['to_station_name'])|truncate:30}</td> *}
                                {* <td>{$row['from_station_name']}</td> *}
                                <td>{$row['to_station_name']}</td>
                                <td align="right">{$row['payable_amt']|number_format:2}</td>
                                <td align="right">{$row['paid_amt']|number_format:2} &nbsp;&nbsp;&nbsp; <a title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true" onclick="getTransitAllTransaction('{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}')"></i> </a></td>
                                <td align="right">{$rtopay|inr_format}</td>
                                <td align="center">{$row['remark']|trim:', '}</td>
                            </tr>
                        {/if}
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="10" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>
            {if count($stationWise) > 0}

                <tr style=" font-weight: bold;">
                    <th colspan="4" align="right">Total</th>
                    <th align="right">{$t_payableAmt|number_format:2}</th>
                    <th align="right">{$t_paidAmt|number_format:2}</th>
                    <th align="right">{$t_balAmt|number_format:2}</th>
                    <th align="right"></th>
                </tr>

            {/if}
        </table>
    {/if}
</div>

<script>
    window.print();
</script>

<style>
    .bold {
        /* font-weight: bold; */
        font-family: Arial, Helvetica, sans-serif;
        font-weight: normal;
        font-size: 0.9em;
        margin: 1px;
        padding: 0;
    }

    table {
        border-collapse: collapse;

    }

    table thead th,
    table thead td {
        font-weight: bold;
    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
    }
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }
    }

    @page {
        size: A4 landscape;
    }
</style>

<script>
    var lrdata ={$stationWise|json_encode}
    if (isNotNull(lrdata)) {
        $('#transit_based_report_ogpl_all,#transit_based_report_ogpl_paid,#transit_based_report_ogpl_Un_paid').DataTable({
            info: false,
            searching: true,
            paging: false,
            order: [
                [0, 'asc']
            ],
            columnDefs: [{
                targets: 'no-sort',
                orderable: false,
            }]
        });
    }
</script>