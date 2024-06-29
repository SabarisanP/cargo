<div class="row">
    <div class="col-md-12 bold">Initiate Trip Cancel</div>        
</div> 

<div class="row hide" id="tripcancel-status-warning">
    <div class="col-md-12 text-center">
        <div class="alert alert-danger">Please change trip status to "Trip Cancelled" before start updating any PNR.</div>
    </div>
</div>

<div class="row">        
    <div class="col-md-3 text-right">
        <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-filter"></i></span>
            <select class='form-control' id='filter'>
                <option value = ''>All Tickets</option>
                <option value="BO">Confirm Booked</option>
                <option value="TCAI">Trip Cancel Initiated</option>                    
                <option value="TCA">Trip Cancelled</option>
            </select>
        </div>
    </div>  
    <div class="col-md-1">                
        <button id="btnTripCancel" class="btn btn-success" onclick="tripCancelInitiate('{$trip_code}', 1, '');">Trip Cancel</button>            
    </div>
    <div class="col-md-6">                
        <div class="" id="tc-action-state"></div>           
    </div>
</div>
<table class="table table-hover" id='trip-user-list' style="margin-top:10px">
    <thead>
        <tr>
            <th><input type="checkbox" id="checkAll"></th>
            <th>PNR</th>           
            <th>Ticket status</th>
            <th>From - To</th>
            <th>Seats</th>
            <th>Booked by</th>
            <th>Passenger Name</th>
            <th>Passenger Mobile</th>
            <th>Booked At</th>
        </tr>
    </thead>
    <tbody id="list">           
        {foreach item=row from=$tripcancel->data}
            {if $row->ticket_status_code=='BO' || $row->ticket_status_code=='TCAI' || $row->ticket_status_code=='TCA'}
            <tr class="{$row->ticket_status_code}">
                <td>
                    {if $row->ticket_status_code=='BO'}
                    <input type="checkbox" name="ticket" class="tpnr" value="{$row->ticket_code}">
                    {/if}
                </td>
                <td>
                    {$row->ticket_code}
                    {if $is_super_namespace==1} 
                    <a href="javascript:;" title="Initiate trip cancel" class="btn-lg" onclick="tripCancelInitiate('{$trip_code}', 0, '{$row->ticket_code}');">
                        <i class="fa fa-eye-slash"></i>
                    </a>
                    {/if}
                </td>
                <td>
                    <span class="label {if $row->ticket_status_code=='BO'} label-success {elseif $row->ticket_status_code=='TCAI'} label-info {elseif $row->ticket_status_code=='TCA'} label-danger {/if}">
                        {if $row->ticket_status_code=='TCA'} 
                            Refund Issued
                        {elseif $row->ticket_status_code=='TCAI'} 
                            Waiting to issue refund
                        {elseif $row->ticket_status_code=='BO'} 
                            Confirm Booking
                        {/if}
                    </span>
                </td>                    
                <td>{$row->from_station_name} - {$row->to_station_name}</td>
                <td>{$row->seat_name}</td>
                <td>{$row->user_name}</td>
                <td>{$row->passenger_name}</td>
                <td>{$row->mobile_number}</td>
                <td>{$row->transaction_date|date_format:$ns_date_format}</td>
            </tr>
            {/if}
        {foreachelse}
            <tr>
                <td colspan="9">No Ticket Found !</td>
            </tr>
        {/foreach}
    </tbody>
</table>

<script>
    var tc_trip_code = "{$trip_code}";
    var tctickets = {$tripcancel->data|json_encode};
    $("#checkAll").change(function () {
        $("input:checkbox").prop('checked', $(this).prop("checked"));
        $('#tc-action-state').html('');
    });
    $('#filter').change(function() {
        $('#tc-action-state').html('');
        $('#list>tr').show();
        $('#list>tr').not('.'+$("#filter").val()).hide();
    });
    
    if($('#btn-state-'+tc_trip_code).attr('data-state') !=="TCA") {
        $('#tripcancel-status-warning').removeClass('hide');
    }
    
    function tripCancelInitiate(trip, tca_validate, pnr) {
        $('#tc-action-state').html('');
        var pnrs = [];
        
        if(tca_validate==1) {
            if($('#btn-state-'+tc_trip_code).attr('data-state') !=="TCA") {
                $('#tc-action-state').html('<div class="alert alert-danger">Please change trip status as "Trip Cancelled" to continue.</div>');
                return;
            }
            
            $('.tpnr:checked').each(function(){
                var t = $(this).val();
                var obj = _.find(tctickets, function(o) { return o.ticket_code == t; }); 
                pnrs.push(obj);
            });
        } else if(tca_validate==0) {    //  single pnr initiate
            var t = pnr;
            var obj = _.find(tctickets, function(o) { return o.ticket_code == t; }); 
            pnrs.push(obj);
        }
        
        if(pnrs.length<=0) {
            $('#tc-action-state').html('<div class="alert alert-danger">Please select atleast one PNR.</div>');
            return;
        }
        
        if( confirm('Do you want to mark trip cancel and issue refund for these PNR?') ) {
            var data = {};
            data.trip_code = trip;
            data.pnr = pnrs;
            $('#tc-action-state').html(loading_small);
            $('#btnTripCancel').hide();
            $.ajax({
                type: "POST",
                url: "schedules/trip-cancel-initiate",
                data: data,
                dataType: 'json',
                success: function (res) {
                    if (res.status == 1) {
                        $('#tc-action-state').html('<div class="alert alert-success">Trip cancel initiated, waiting for approval to issue refund.</div>');
                        window.setTimeout(function () {
                            $('#tc-action-state').html('');
                            $('#btnTripCancel').show();
                            tripcancel(trip);
                        }, 4000);
                    }
                    else {
                        $('#tc-action-state').html('<div class="alert alert-danger">' + res.errorDesc + '</div>');
                        $('#btnTripCancel').show();
                        window.setTimeout(function () {
                            $('#tc-action-state').html('');
                        }, 3000);
                    }
                }
            });
        }   
    }
</script>