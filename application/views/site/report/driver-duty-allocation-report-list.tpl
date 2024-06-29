{if $reports|count<=0}
    <div class="alert alert-info text-center"> Sorry! No data found. </div>
{else}    
    <table class="" width="95%">
        <tr>
            <td  colspan="2" align="center"><b>Driver Duty Allocation Report</b></td>
        </tr>
        <tr>
            <td width="50%">
                <span class="bold">Report Date : </span> 
                {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format}  </td>
            <td width="50%" align="right"><span class="bold">Report At : </span>  {$smarty.now|date_format:$ns_datetime_format}</td>
        </tr>
        <tr>
            <td width="50%"></td>
            <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
        </tr>
    </table>
    
    <div class="table-responsive" id="adv-report-grid">
        <table id="dt_adv_booking_report_table" class="table table-bordered ">
            <thead>
                <tr class="success">
                    <th >Trip Date</th>
                    <th >Schedule Name</th>
                    <th >Service Number</th>
                    <th >Vehicle Number</th> 
                    <th >Driver 1</th>                    
                    <th >Driver 2</th>
                    <th >Assigned at</th>
                    <th >Start Time</th>
                    <th >Trip Status</th>
                    <th >Occupancy</th>
                    <th >Total Seats</th> 
                    <th >Booked Amount</th>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=total_booked_amount value=0}
                    {foreach from=$reports item=row name=fetrans}
                        <tr>
                            <td>{$row->trip_date|date_format:$ns_date_format}</td>
                            <td>{$row->schedule_name}</td>
                            <td><span class="warning-text">{$row->service_number}</span></td> 
                            <td>{($row->registration_number)? ($row->registration_number) : '-'}</td>                           
                            <td>{$row->driver_name}</td>
                            <td>{$row->co_driver_name}</td>
                            <td>{$row->trip_allocated_time|date_format:$ns_datetime_format}</td> 
                            <td>{$row->trip_start_time|date_format:$ns_datetime_format}</td> 
                            <td>
                                {if $row->trip_status == "TPC"}
                                <span class="badge badge-danger">Closed</span>
                                {elseif $row->trip_status == "TPO"}
                                <span class="badge badge-success">Open</span>    
                                {elseif $row->trip_status == "TPY"}
                                <span class="badge badge-default">Yet To Open</span> 
                                {elseif $row->trip_status == "TCA"}
                                <span class="badge badge-warning">Cancelled</span>
                                {/if}
                            </td>
                            <td>{$row->occupancy_count}</td>
                            <td>{$row->total_seat_count}</td>
                            <td align="right"> {$row->booked_amount|inr_format}</td>
                            {assign var="total_booked_amount" value=$total_booked_amount+$row->booked_amount}
                        </tr>
                    {/foreach}
                    <tr class="active">
                        <td  colspan="11" align='right'>Total</td>
                        <td align='right'>{$total_booked_amount|inr_format}</td>
                    </tr>
            </tbody>
        </table>
    </div>
    {*<div class="text-right">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCustomerDetails()"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>  *}
{/if}

