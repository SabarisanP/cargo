{if $reports|count<=0}
    <div class="alert alert-info text-center"> Sorry! No data found. </div>
{else}    
    <div class="table-responsive" id="adv-report-grid">
        <table id="dt_adv_booking_report_table" class="table table-bordered ">
            <thead>
                <tr class="success">
                    <th >#</th>
                    <th >PNR</th>
                    <th >Travel Date</th>
                    <th >Name</th>
                    <th >Email</th>
                    <th >Mobile</th>
                    <th >From Station</th>
                    <th >To Station</th>                     
                    <th >Booking Date</th> 
                    <th >Booked By</th>
                    <th >Seat Count</th> 
                    <th >Device Medium</th>
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach from=$reports item=row name=fetrans}                
                    <tr>
                        <td>{$smarty.foreach.fetrans.index+1}</td> 
                        <td>{$row->ticket_code}</td> 
                        <td>{$row->travel_date|date_format:$ns_date_format}</td> 
                        <td>{$row->passenger_name}</td> 
                        <td>{$row->email}</td> 
                        <td>{$row->mobile}</td>
                        <td>{$row->from_station_name}</td> 
                        <td>{$row->to_station_name}</td>                         
                        <td>{$row->booking_date|date_format:$ns_datetime_format}</td>
                        <td>{$row->user_name}</td>
                        <td> {$row->seat_count}</td>
                        <td>{$row->device_medium}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    {*<div class="text-right">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCustomerDetails()"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>  *}
{/if}

