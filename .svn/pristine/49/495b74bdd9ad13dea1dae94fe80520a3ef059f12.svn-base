<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Branch Date Wise Transaction Report</span></td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> {$from_date|date_format:$ns_date_format} to {$to_date|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>
</table>
<br/>
<div class="tabbable">
    <ul class="nav nav-tabs hide" id="rpt_tabs">
        <li class="active">
            <a data-toggle="tab" href="#tab_table" title="Table View"><i class="fa fa-lg fa-table"></i></a>
        </li>
    </ul>
    <div class="tab-content" id="rpt_tabs_cont">
        <div id="tab_table" class="tab-pane fade in active">
            <div class="table-responsive" id="bdwt-table-grid">
                <table id="dt_ss_report_table" class="table table-bordered no-wrap">
                    <thead>
                        <tr class="success">
                            <td rowspan="3">S No <i class="fa fa-sort"></i></td>
                            <td rowspan="3">Branch <i class="fa fa-sort"></i></td>

                            {foreach item=dte from=$date_range}
                                <td colspan="6" align="center" nowrap>{date("d-m-Y", strtotime($dte))}</td>
                            {/foreach}
                        </tr>
                        <tr class="success">
                            {foreach item=dte from=$date_range}
                                <td align="center" colspan="2">Paid</td>
                                <td align="center" colspan="2">Topay</td>
                                <td align="center" colspan="2">On Account</td>
                            {/foreach}
                        </tr>
                        <tr class="success">
                            {foreach item=dte from=$date_range}
                                <td>Freight Amount <i class="fa fa-sort"></i></td>
                                <td>Other Charges <i class="fa fa-sort"></i></td>
                                <td>Freight Amount <i class="fa fa-sort"></i></td>
                                <td>Other Charges <i class="fa fa-sort"></i></td>
                                <td>Freight Amount <i class="fa fa-sort"></i></td>
                                <td>Other Charges <i class="fa fa-sort"></i></td>
                            {/foreach}
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {$key = 1}
                        {foreach item=row from=$list_data key=t}
                            <tr id="{$t}" class="tr-hover">
                                <td>{$key}</td>
                                <td>{$row['org_name']|ucwords}</td>

                                {foreach item=dte from=$date_range}
                                    <td align='right'>{$row[$dte]['paid']|inr_format}</td>
                                    <td align='right'>{$row[$dte]['paid_other']|inr_format}</td>
                                    
                                    <td align='right'>{$row[$dte]['topay']|inr_format}</td>
                                    <td align='right'>{$row[$dte]['topay_other']|inr_format}</td>
                                    
                                    <td align='right'>{$row[$dte]['onacc']|inr_format}</td>
                                    <td align='right'>{$row[$dte]['onacc_other']|inr_format}</td>
                                {/foreach}
                            </tr>
                            {$key = $key+1}
                        {foreachelse}
                            <tr>
                                <td colspan="2" align="center">No data found</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>

            <div class="text-right noprint">
                <div class="btn-group btn-group-sm">
                    <button class="btn btn-default" onclick="exportBrnDateWiseTrnsExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    {if $list_data|count}
        $(document).ready(function () {
            $('#dt_ss_report_table').dataTable({
                "sDom": '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
                        '<"overflow-x-auto"t>' +
                        '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
                pageLength: 50,
            });
            $('#ToolTables_dt_ss_report_table_0').hide();
            $('#ToolTables_dt_ss_report_table_1').hide();
            $('#ToolTables_dt_ss_report_table_2').hide();
            $('#ToolTables_dt_ss_report_table_3').hide();
        });
    {/if}
</script>
