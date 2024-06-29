<table border="1" >
    <tr>
        <td  colspan="10" align="center" style="font-weight: bold;">Customer List</td>
    </tr>
    <tr>
        <td colspan="4">                 
            DOJ From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} 
        </td>
        <td colspan="4">
            <span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}
        </td>
    </tr>
</table>
    
    <table border="1">
        <thead>
            <tr class="success">
                <td align="center" style="font-weight: bold;">#</td>
                <td align="center" style="font-weight: bold;">Mobile</td>
                <td align="center" style="font-weight: bold;">Email</td>
                <td align="center" style="font-weight: bold;"># Time Travellled</td>
                <td align="center" style="font-weight: bold;">Last Travelled Date</td>                      
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

 
