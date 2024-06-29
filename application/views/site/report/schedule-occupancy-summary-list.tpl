<table width="100%">
    <tr>
        <td colspan="5" align="center"><span class="bold">Schedule Occupancy Summary</span></td>
    </tr>
    <tr>
        <td colspan="2">
            <span class="bold">Report Date : </span> 
            {$smarty.request.from_date|date_format:$ns_date_format}  to {$smarty.request.to_date|date_format:$ns_date_format}  DOJ </td>
        <td align="right" colspan="3"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>
<table id="sos_report_table" class="table table-bordered">
    <thead>
        <tr class="success">
            <th>Schedule Name <i class="fa fa-sort"></i></th>
            <th>Toatal Seat <i class="fa fa-sort"></i></th>
            <th>Booked Seat <i class="fa fa-sort"></i></th>  
            <th>Occupancy (%) <i class="fa fa-sort"></i></th>
        </tr>
    </thead>
    {assign var="tot_seats" value=0}
    {assign var="bo_counnt" value=0}
    <tbody class="body_table">      
        {foreach item=row from=$data key=t}
            <tr id="{$row->schedule_code}" class="tr-hover" onclick="toggleSos('{$row->schedule_code}');">
                <td>{if !empty($row->service_number)} <span class="warning-text">{$row->service_number}</span> - {/if} {$row->trip_name} - {$row->trip_date|date_format:$ns_time_format}</td>
                <td>{$row->total_seats_count}</td>
                <td>{$row->booked_count}</td>
                <td>
                    {(($row->booked_count / $row->total_seats_count)*100 )|number_format:2}
                    <i class="fa fa-caret-down fa-fw pull-right" aria-hidden="true"></i>
                </td>
            </tr>
            {assign var="tot_seats" value=$tot_seats + $row->total_seats_count}
            {assign var="bo_counnt" value=$bo_counnt + $row->booked_count}
        {/foreach}
    </tbody>
    <tfoot>
        <tr class="bold">
            <td align="right">Total</td>
            <td>{$tot_seats}</td>
            <td>{$bo_counnt}</td>
            <td>{(($bo_counnt / $tot_seats)*100 )|number_format:2}</td>
        </tr>
    </tfoot>
</table>    
<div class="panel-body text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportBookingRatioExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>
<script id="sos-more-tpl" type="text/template">
    <tr id="sos_more">
        <td colspan="4">
            <div class="row slide" style="display: none;">
                <div class="col-md-6">
                    <table class="table table-bordered">
                        <thead>
                            <tr class="active">
                                <th>Route</th>
                                <th>Booked Seat</th>  
                                <th>Occupancy (%)</th>
                            </tr>
                        </thead>
                        <tbody class="body_table" id="sos_stage_table">
                        </tbody>
                    </table>
                </div>
                <div class="col-md-6">
                    <table class="table table-bordered">
                        <thead>
                            <tr class="active">
                                <th>User Name</th>
                                <th>Booked Seat</th>  
                                <th>Occupancy (%)</th>
                            </tr>
                        </thead>
                        <tbody class="body_table" id="sos_user_table">
                        </tbody>
                    </table>
                </div>
            </div>
        </td>
    </tr>    
</script>
<script>
    var sos_data = {$data|json_encode};
    var sos_stage = {$stage|json_encode};
    var sos_users = {$users|json_encode};
    $(document).ready(function () {
        $('#sos_report_table').dataTable({
            "sDom":'<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
                    't' +
                    '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',
            columnDefs: [{
                targets: -1,
                bSearchable: false
            }]
        });
        $('#ToolTables_sos_report_table_0').hide();
        $('#ToolTables_sos_report_table_1').hide();
        $('#ToolTables_sos_report_table_2').hide();
        $('#ToolTables_sos_report_table_3').hide();
        $("select[name=sos_report_table_length]").val("100").change();
        $('#sos_report_table_filter input').on('input', function(){
            var val = this.value.trim();
            $('#sos_report_table tfoot')[val ? 'hide' : 'show']();
        });
    });
    
    function toggleSos(code) {
        if($('#sos_more').hasClass(code)) {
            $('#sos_more .slide').slideToggle('linear', function() {
                $('#sos_more').remove();
            });
            return;
        }
        
        var $tpl = $($('#sos-more-tpl').html());
        $tpl.addClass(code);
        
        var bo_count = 0;
        var to_count = 0;
        _.each(sos_stage[code], function(val, i){
            bo_count += val.booked_count;
            to_count += val.total_seats_count;
            $tpl.find('#sos_stage_table').append('<tr>\n\
                <td>'+ i +'</td>\n\
                <td>'+ val.booked_count +'</td>\n\
                <td>'+ ((val.booked_count == 0) ? '0.00' : ((val.booked_count / sos_data[code].booked_count) * 100).toFixed(2)) +'</td>\n\
            </tr>');
        });
        $tpl.find('#sos_stage_table').append('<tr class="bold">\n\
            <td align="right">Total</td>\n\
            <td>'+ bo_count +'</td>\n\
            <td></td>\n\
        </tr>');
        
        var bo_count = 0;
        _.each(sos_users[code], function(val, i){
            bo_count += val.booked_count;
            $tpl.find('#sos_user_table').append('<tr>\n\
                <td>'+ i +'</td>\n\
                <td>'+ val.booked_count +'</td>\n\
                <td>'+ ((val.booked_count == 0) ? '0.00' : ((val.booked_count / sos_data[code].booked_count) * 100).toFixed(2)) +'</td>\n\
            </tr>');
        });
        $tpl.find('#sos_user_table').append('<tr class="bold">\n\
                <td align="right">Total</td>\n\
                <td>'+ bo_count +'</td>\n\
                <td></td>\n\
            </tr>');
        
        $('#sos_more').remove();
        $('#'+code).after($tpl);
        $('#sos_more .slide').slideToggle('linear');
    }
</script>    
