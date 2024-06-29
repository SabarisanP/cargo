
<div class="row" id='btnTripCancel'> 
    <div class="col-md-3">  
            {if $action_rights['TRIP-CANCEL-ACKNO']==1}            
            <button class="btn btn-default" onclick="tripCancelAcknowledge(2);">No Trip Cancel</button> &nbsp;&nbsp;&nbsp;&nbsp;
            <button class="btn btn-danger" onclick="tripCancelAcknowledge(1);">Issue Refund</button> 
            {/if}
    </div>
</div>
        
<div class="row hide" id='tripCancelProgressPane'> 
    <div class="col-md-12">                
        <div class="" id="tc-action-state"></div>
        <div id="action-info" class="text-center"></div>
        <div class="progress progress-striped">
            <div style="width:0%" role="progressbar" class="progress-bar"></div>
        </div>
    </div>
</div>    
        
<br>     
<div class="table-responsive">
    <table id="dt_bp_report_table" class="table table-hover ">
        <thead>
            <tr class="">
                <th><input type="checkbox" id="checkAll" onchange="chkAllPnr();"></th>
                <th>PNR</th>           
                <th>Ticket status</th>
                <th>Trip</th>
                <th>Travel Date</th>
                <th>Seats</th>
                <th>Booked by</th>
                <th>Passenger Name</th>
                <th>Amount</th>
                <th>Initiated / Approved By</th>
            </tr>
        </thead>
        <tbody id="list">           
        {foreach item=row from=$tickets}
            {if $row->ticket_status_code=='TCAI'}
            <tr class="{$row->ticket_status_code}" id="{$row->ticket_code}">
                <td>
                    {if $row->ticket_status_code=='TCAI'}
                    <input type="checkbox" name="ticket" class="tpnr" value="{$row->ticket_code}">
                    {/if}
                </td>
                <td>{$row->ticket_code}</td>
                <td>
                    <span class="label {if $row->ticket_status_code=='TCA'} label-success {elseif $row->ticket_status_code=='TCAI'} label-info {/if}">
                        {if $row->ticket_status_code=='TCA'} 
                            Refund Issued
                        {elseif $row->ticket_status_code=='TCAI'} 
                            Waiting to issue refund
                        {/if}
                    </span>
                </td>                    
                <td>
                    {$row->from_station_name} - {$row->to_station_name}
                    <br>
                    <span class="warning-text">{$row->service_number}</span> &nbsp;&nbsp;<span class="text-muted">{$row->trip_date_time|date_format:$ns_time_format}</span>
                </td>
                <td>{$row->trip_date_time|date_format:$ns_date_format}</td>
                <td>{$row->seat_name}</td>
                <td>
                    {$row->user_name}<br>
                    <span class="text-muted">{$row->user_group_name}</span>
                </td>
                <td>
                    {$row->passenger_name} <br>
                    <span class="text-muted">{$row->mobile_number}</span>
                </td>
                <td>{$row->ticket_amount}</td>
                <td>{$row->updated_user_name}</td>
            </tr>
            {/if}
        {foreachelse}
            <tr>
                <td colspan="9">No Ticket Found !</td>
            </tr>
        {/foreach}
        </tbody>
    </table>                
</div>
<script>
    var tctickets = {$tickets|json_encode};
</script>

     