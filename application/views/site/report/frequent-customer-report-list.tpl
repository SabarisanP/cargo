<table width="95%">
    <tr>
        <td  colspan="10" align="center">Customer List</td>
    </tr>
    <tr>
        <td width="50%">
            DOJ From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}
        </td>
    </tr>
</table>
   
        
<div class="table-responsive">
    <table class="table table-bordered widthed" id="dt_ftc_report_table">
        <thead>
            <tr class="success">
                <td align="center">#</td>
                <td align="center">Mobile <i class="fa fa-sort"></i></td>
                <td align="center">Email <i class="fa fa-sort"></i></td>
                <td align="center"># Time Travellled <i class="fa fa-sort"></i></td>
                <td align="center">Last Travelled Date <i class="fa fa-sort"></i></td>
            </tr>
            
        </thead>
        <tbody class="body_table">               
            {foreach item=pax from=$customers key=t name=cus}
                <tr> 
                    <td>{$smarty.foreach.cus.index+1}</td>
                    <td>{$pax->mobile_number}</td>
                    <td>{$pax->email_id}</td>
                    <td>{$pax->traveled_count}</td>
                    <td>{$pax->last_traveled_date|date_format:$ns_date_format}</td>
                </tr>   
            {foreachelse}
                <tr>                    
                    <td colspan="5" align="center">No data found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>                
</div>
                
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCancellationExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>
<script>
    {if $customers|count}
    $(document).ready(function() {
        $('#dt_ftc_report_table').dataTable({            
            "sDom": '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
                    't' +
                    '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
            pageLength : 50
        });
        $('#ToolTables_dt_ftc_report_table_0').hide();
        $('#ToolTables_dt_ftc_report_table_1').hide();
        $('#ToolTables_dt_ftc_report_table_2').hide();
        $('#ToolTables_dt_ftc_report_table_3').hide();
    });
    {/if}
</script>   
