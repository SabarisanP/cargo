{if $filter_type == 'SUMMARY'}
    {if $filterCode == "NA"}
    <div class="col-md-12">
        <div class="text-right noprint">
            <div class="btn-group btn-group-sm">
                <button class="btn btn-default" onclick="excelTab()"><i class="fa fa-download fa-lg"></i>Excel</button>
                <button class="btn btn-default notpaytypeprint" onclick="printTab()"><i class="fa fa-print fa-lg"></i>
                    Print</button>
            </div>
        </div>
        <ul class="nav nav-tabs" id="report-tabs">
            <li class="active"> <a data-toggle="tab" href="#UNPAID">UNPAID</a></li>
        </ul>
        <div class="tab-content">
            <div id="UNPAID" class="tab-pane fade in active">
                {call summaryWiseTopayUnpaid data=$summaryWise}
            </div>
        </div>
    </div>
    {else}
        <table>
        <tr>
            <td colspan="12" align="center">No data found</td>
        </tr>
        </table>
    {/if}
{/if}
{function name="summaryWiseTopayUnpaid" data=[]}
    {if $filterCode == "NA"}
        <div class="row">
            <div class="col-md-12"><br><br>
                <table id="transit_based_summary_unpaid" class="table table-bordered" width="100%">
                    <thead>
                        <tr class="success">
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
                        {foreach item=row from=$data}
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
                            <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
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
    {else}
        <table>
        <tr>
            <td colspan="10" align="center">No data found</td>
        </tr>
        </table>
    {/if}
{/function}
<script>
    var lrdata ={$stationWise|json_encode}

    if (isNotNull(lrdata)) {
        $('#transit_based_summary_unpaid,#transit_based_summary_paid,#transit_based_summary_all').dataTable({
            "bPaginate": false,
            "info": false,
            "dom": 'lrt',
            "aaSorting": [
                [0, "asc"]
            ]
        });
    }
    if (isNotNull(lrdata)) {
        $('.transit-based-unpaid,.transit-based-paid ,.transit-based-all').DataTable({
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

    var namespaceCode = {$namespaceCode|json_encode};
    $('[data-toggle="popover"]').popover({
        placement: 'bottom',
        html: true,
        trigger: 'hover'
    });

    $('#transit_based_branch_report_table input').keypress(function(event) {
        if (event.keyCode == 13) {
            updateTransitTopayPayment($(this).attr('id'));
            remarkAdd($(this).attr('id'));
        }
    });

    function toggleTopayBranch(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();

        var $trows = $('.branch-drill-down').filter('.' + code);
        $('#' + code).after('<tr class="branchlist ' + code +
            '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">' +
            $trows.html() + '</table></div></td></tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function toggleTopayPaid(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();

        var $trows = $('.paid-drill-down').filter('.' + code);

        $('#' + code).after('<tr class="branchlist ' + code +
            '"> <td colspan = "100%" ><div class = "slide"style = "display: none;" ><table width = "100%" > ' +
            $trows.html() + '</table> </div> </td> </tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function toggleTopayUnPaid(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();
        var $trows = $('.un-paid-drill-down').filter('.' + code);
        $('#' + code).after('<tr class="branchlist ' + code +
            '"><td colspan="100%"> <div class="slide" style="display: none;"> <table width = "100%" > ' +
            $trows.html() + '</table></div></td></tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function excelTab() {
        var activeTab = $("#report-tabs li.active a").attr("href");
        if (activeTab === "#ALL") {
            exportTransitUnPaidExcel("ALL");
        } else if (activeTab === "#PAID") {
            exportTransitUnPaidExcel("PAID");
        } else if (activeTab === "#UNPAID") {
            exportTransitToPayExcel("UNPAID");
        }
    }

    function printTab() {
        var activeTab = $("#report-tabs li.active a").attr("href");
        if (activeTab === "#ALL") {
            printTransitToPay("ALL");
        } else if (activeTab === "#PAID") {
            printTransitToPay("PAID");
        } else if (activeTab === "#UNPAID") {
            printTransitToPay("UNPAID");
        }
    }
</script>