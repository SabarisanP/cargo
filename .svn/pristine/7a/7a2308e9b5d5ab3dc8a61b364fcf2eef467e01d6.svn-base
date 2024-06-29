<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Travel Status Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Status :</span> {$smarty.request.status} &nbsp; <span class="bold">Trip Date :</span> {$smarty.request.from_date|date_format:$ns_date_format} to {$smarty.request.to_date|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>

</table>
<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="center">PNR</th>
                <th>Route</th>
                <th>Status</th>
                <th>Seat Name</th>
                <th>Contact</th>                
                <th>Booked By</th>                
                <th>Boarding Point</th> 
                <th>Boarding Time</th>
            </tr>
        </thead>
        <tbody class="body_table">            
            {foreach item=trdate from=$tickets key=t}
                <tr class="active">
                    <td colspan="8" class="bold" align="center">
                        {$t|date_format:$ns_date_format}
                    </td>
                </tr>

                
                {foreach item=trip from=$trdate key=b}
                    <tr>
                        <td colspan="8" class="bold" align="left">
                            {$trip[0]->service_number}
                        </td>
                    </tr>
                    {foreach item=row from=$trip key=r}
                        <tr>                    
                            <td>{$row->ticket_code}</td>
                            <td>{$row->from_station_name} - {$row->to_station_name}</td>
                            <td>{$travel_status[$row->travel_status_code]}</td>
                            <td>{$row->seat_name}</td> 
                            <td>{$row->mobile_number}</td>                             
                            <td>{$row->user_name}</td> 
                            <td>{$row->boarding_point_name}</td> 
                            <td>{$row->boarding_time} 
                                {if $row->boarding_point_minutes>1440} 
                                next day
                                {/if}
                            </td> 
                        </tr>   
                    {/foreach}    
                                 
               {/foreach}                
                
            {/foreach}  

        </tbody>
    </table>                
</div>
<!-- <div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportBoardingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>  -->
<iframe name="ifrm_boarding_downloader" id="ifrm_boarding_downloader" style="display:none" ></iframe>   

     