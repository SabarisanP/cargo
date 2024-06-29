<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Boarding Point Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Station :</span> {$smarty.request.staionname} &nbsp; <span class="bold">Trip Date :</span> {$smarty.request.from_date|date_format:$ns_date_format} - {$smarty.request.to_date|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:sa")}</td>
    </tr>

</table>
<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="center">PNR</th>
                <th>Route</th>
                <th>Travel Date</th>
                <th>Name</th>
                <th>Phone</th>  
                <th>Seat Name (Gender)</th>
                <th>Booked By</th>                
                <th>Booked Type</th> 
                <th>Remarks</th>
            </tr>
        </thead>
        <tbody class="body_table">            
            {foreach item=trip from=$tickets key=t}
                <tr class="active">
                    <td colspan="9" class="bold" align="center">
                        {$t} - {$seat_count[$t]} seats
                    </td>
                </tr>

                
                {foreach item=bp from=$trip key=b}
                    <tr>
                        <td colspan="4" class="bold" align="left">
                            {$bp[0]->schedule_name}, {$bp[0]->vechile_number}, {$bp[0]->driver_name}, {$bp[0]->driver_number}
                        </td>
                        <td colspan="5" class="bold" align="left">
                            {$bp[0]->boarding_time}
                        </td>
                    </tr>
                    {foreach item=row from=$bp key=r}
                        <tr>                    
                            <td>{$row->ticket_code}</td>
                            <td>{$row->from_station_name} - {$row->to_station_name}</td>
                            <td>{$row->travel_date|date_format:$ns_date_format}</td>
                            <td>{$row->passenger_name}</td>
                            <td>{$row->mobile_number}</td> 
                            <td>{$row->seat_name}</td> 
                            <td>{$row->user_name}</td> 
                            <td>{$row->ticket_status}</td> 
                            <td>{$row->remarks}</td> 
                        </tr>   
                    {/foreach}    
                                 
               {/foreach}                
                
            {/foreach}  

        </tbody>
    </table>                
</div>
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportBoardingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>   
<iframe name="ifrm_boarding_downloader" id="ifrm_boarding_downloader" style="display:none" ></iframe>   

     