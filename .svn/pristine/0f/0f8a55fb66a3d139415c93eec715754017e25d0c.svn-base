<table border="1">
    <tr>
        <td colspan="6" align="center"><b>Transit Based Branch Collection Report</b>
    </tr>
    <tr>
        <td colspan="3">
            <b>Report Date : </b>{$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}
        </td>
        <td colspan="3" align="right"><b>Report At : </b>{$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">Status :{$status}</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$user_name}</td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b> Station : {if $filterCode == "NA"}ALL{else} {$stationStatus}{/if}</b></td>
        <td colspan="3" align="right"></td>
    </tr>
</table>
<br>

{if $status =="UNPAID"}
    {if $filterCode == "NA"}
        <div class="row">
            <div class="col-md-12"><br><br>
                <table id="transit_based_summary_unpaid" class="table table-bordered" width="100%" border="1">
                    <thead>
                        <tr style="background-color:#83e020; color: #000000fb; font-weight: bold;">
                            <td align="center" class="bold" nowrap width="20%">Station <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap width="20%">Net Payable <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap width="20%">Paid (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap width="20%">Balance (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap width="20%"> Last Payment Date</td>
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
                                    <td align="center">{$row['transaction_at']|date_format}</td>
                                </tr>
                                {assign var=t_payable value=$t_payable+$row['payable_amt']}
                                {assign var=t_paid value=$t_paid+$row['paid_amt']}
                                {assign var=t_bal value=$t_bal+$row['bal_amt']}
                            {/if}
                        {foreachelse}
                            <tr>
                                <td colspan="10" align="center">No data found</td>
                            </tr>
                        {/foreach}
                    </tbody>
                    {if count($summaryWise) > 0}
                        <tfoot>
                            <tr class="bold" style="background-color: #bbbbbb; color: #000; font-weight: bold;">
                                <td align="right">Total</td>
                                <td align="right">{$t_payable|number_format:2}</td>
                                <td align="right">{$t_paid|number_format:2}</td>
                                <td align="right">{$t_bal|number_format:2}</td>
                                <td></td>
                            </tr>
                        </tfoot>
                    {/if}
                </table>
            </div>
        </div>
    {/if}
{/if}