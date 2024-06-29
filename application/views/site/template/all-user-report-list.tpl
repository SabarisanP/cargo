
<div class="panel panel-default">
    <div class="table-responsive">
        <table id="dt_report_table" class="table">
            <thead>
                <tr>
                    <th>#&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th>Ref / PNR Number&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th>Transaction Date&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th>Username</th>
                    <th>Transaction Type&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th>Transaction Mode&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th align="right">Credit Amount&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th align="right">Debit Amount&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th align="right">TDS Amount&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th>Transaction Amount&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                    <th>Closing Balance&nbsp;&nbsp;<i class="fa fa-sort-desc"></i></th>
                </tr>
            </thead>
            <tbody class="body_table">

                {foreach item=row from=$reports key =k}
                    <tr>
                        <td >{$k+1}</td>
                        <td ><a href="javascript:;" data-pnr="{$row->refferenceCode}" data-type="{$row->transactionType->code}" class="pnr-popover">{$row->refferenceCode}</a></td>
                        <td >{$row->transactionDate|date_format:$ns_datetime_format}</td>
                        <td>{$row->user->name}</td>
                        <td >{$row->transactionType->name} </td>
                        <td >{$row->transactionMode->name} </td>
                        
                        <td  align="right">{$row->creditAmount|number_format:2}</td>
                        <td  align="right">{$row->debitAmount|number_format:2}</td>
                        <td  align="right">{$row->tdsTax|number_format:2}</td>
                        <td  align="right">{$row->transactionAmount|number_format:2}</td>
                        
                        <td  align="right">{$row->closingBalance|number_format:2}</td>
                        
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
            "sDom":
                    '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
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
        
        $('.pnr-popover').each( function(){
            $(this).popover({
                container:'body',
                content:loading_popup,
                html:true,
                placement:'right',
                trigger:'focus',
            });

            $(this).on('show.bs.popover', function () {
                var ele = this;
                var data = {};
                data.ticketpnrcode = $(this).attr('data-pnr');
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "report/get-ticket-details",
                    data: data,
                    success: function (response) {
                        $(ele).popover('destroy').popover({
                            container:'body',
                            content:response,
                            html:true,
                            placement:'right',
                            trigger:'focus',
                        }).popover('show');

                    }
                });
            })
        });

    });

</script>