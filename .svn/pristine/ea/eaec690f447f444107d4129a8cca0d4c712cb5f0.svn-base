<div class="table-responsive">
    <table id="dt_phone_booking_list" class="table table-bordered">
        <thead>
            <tr class="success">
                <th>PNR</th>
                <th>From - To</th>
                <th>Travel Date</th> 
                <th>Passenger Name</th>
                <th>Passenger Mobile</th>
                <th>Seat Numbers</th>
                <th>Ticket Fare</th>
                <th>Transaction Date</th>
                <th>Phone Book By</th>
                <th>Release At</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {if $pb_list|count==0}
                <tr>
                    <td colspan="11" align="center">Sorry! No data found</td>
                </tr>
            {else}    
                {foreach item=trip from=$pb_list['trip'] key=t}                
                    <tr>
                        <td colspan="10" class="bold">{$trip[0]->scheduleName} - {$trip[0]->tripName} - {$trip[0]->tripTime|date_format:$ns_time_format}</td>
                    </tr>
                    {foreach item=row from=$trip key=k}
                        <tr>
                            <td>{$row->code}</td>
                            <td>{$row->fromStation->name} - {$row->toStation->name}</td>
                            <td>{$row->travelDate|date_format:$ns_date_format}</td> 
                            <td>{$row->passengerName}</td>
                            <td>{$row->passegerMobleNo}</td>
                            <td>{$row->seatNames}</td>
                            <td>{$row->seatFares}</td>
                            <td>{$row->transactionDate|date_format:$ns_datetime_format}</td>
                            <td>{$row->user->name}</td>
                            <td>
                                {if $row->ticketExtra->releaseAt}
                                    {$row->ticketExtra->releaseAt|date_format:$ns_datetime_format}
                                {else}
                                    -
                                {/if}
                            </td>
                            <td>                        
                                <button class="btn-app btn-success" type="button" onclick="bookCancelPB('{$row->code}');">Confirm / Cancel</button>                            
                            </td>
                        </tr>
                    {/foreach}
                {/foreach}   
            {/if}
        </tbody>
    </table>
 </div>

