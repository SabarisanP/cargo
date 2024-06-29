<!DOCTYPE html>
<html dir="ltr" lang="en-US">
  <head>
  <meta charset="utf-8" />
  <title>Bus Layout View</title>
  <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
  <link href="{$base_url}assets/css/print-regular.css?{$asset_ver}" rel="stylesheet">
  </head>
  <body>

{if $api_error==1}
    Sorry! Error getting data. Please try again later.
{else}

    <table class="remove-border-top" cellpadding="5"  width="98%">
        
        <tr>
            <td width="100%" colspan="2">
                <table width="100%">
                    <tr>
                        <td width="40%">
                            {$trips->schedule->name}<br>  
                            {$category}, {$from_time|date_format:$ns_time_format}<br>
                            Driver Name : {$data->driverName}
                        </td>
                        <td width="40%" >
                            Trip Id : &nbsp;  {$tripCode}<br>
                            Travel Date:{$from_time|date_format:$ns_date_format}<br>
                            Mobile : {$data->driverMobile}
                        </td>
                        <td width="20%">
                            {if $trips->schedule->serviceNumber!=''}
                            <span style="border:1px solid #aaa; padding: 5px;"><b>{$trips->schedule->serviceNumber}</b></span> <br><br>
                            {/if}
                            Vehicle : {$vehicle_nunmber}  
                        </td>
                    </tr>
                </table> 
            </td>
        </tr>
    </table>
    
    <br/>
    
    <table class="table remove-border-top" width="100%">
        <tr>                    
            <td width="100%" valign="top" >
                
                    {if $xmaxl2 > 0 && $xminl2 > 0}
                        <table width="98%" border="1px solid #ddd;">
                            <tr>
                                <td>
                                    <table width="98%" cellspacing="0" cellpading="0">
                                        <tr>
                                            <td rowspan="7" width="2" align="center">U<br>P<br>P<br>E<br>R</td>
                                        </tr>
                                        {for $r=$xminl2 to $xmaxl2}
                                            <tr>
                                                {for $c=$yminl2 to $ymaxl2}
                                                    {if $name['2'][$r][$c] != ''}
                                                        {if $seatcode['2'][$r][$c] != 'RRM' && $seatcode['2'][$r][$c] != 'FRS'}
                                                            <td class="seat-cell" style="border:1px solid black; width:300px" valign="top">
                                                                <span class="bold">{$name['2'][$r][$c]}</span> 
                                                                {if $bookedGender[$name['2'][$r][$c]]!=""}, {$bookedGender[$name['2'][$r][$c]]}  {/if} 
                                                                {if $bp_books_seats[$name['2'][$r][$c]]->passengerAge!=""}, {$bp_books_seats[$name['2'][$r][$c]]->passengerAge} {/if} <br>

                                                                {$bp_books_seats[$name['2'][$r][$c]]->passengerMobile} <br>
                                                                {$bp_books_seats[$name['2'][$r][$c]]->boardingPoint->name|truncate:15}
                                                            </td>
                                                        {else}
                                                            <td class="seat-cell" style="border:none;" valign="top"><span class="bold">x</span></td>
                                                        {/if}
                                                    {else}
                                                        <td class="seat-cell" >
                                                        </td>
                                                    {/if}
                                                {/for}
                                            </tr>
                                        {/for}
                                    </table>
                                </td>
                            </tr>
                        </table> 
                        <br> 
                    {/if}
                    <table width="98%" border="1px solid #ddd">
                        <tr>
                            <td>
                                <table width="98%" cellspacing="0" cellpading="0">
                                    <tr>
                                        <td rowspan="7" width="2" align="center">{if $xmaxl2 > 0 && $xminl2 > 0} <div class="seat-map-driver"></div><br>L<br>O<br>W<br>E<br>R{else} <div class="seat-map-driver-info"></div> {/if}</td>
                                    </tr>
                                    {for $r=$xminl1 to $xmaxl1}
                                        <tr>
                                            {for $c=$yminl1 to $ymaxl1}
                                                {if $name['1'][$r][$c] != ''}
                                                    {if $seatcode['1'][$r][$c] != 'RRM' && $seatcode['1'][$r][$c] != 'FRS'}
                                                        <td class="seat-cell" style="border:1px solid black; width:300px" valign="top">
                                                            <span class="bold">{$name['1'][$r][$c]}</span> 
                                                            {if $bookedGender[$name['1'][$r][$c]]!=""}, {$bookedGender[$name['1'][$r][$c]]} {/if} 
                                                            {if $bp_books_seats[$name['1'][$r][$c]]->passengerAge!=""}, {$bp_books_seats[$name['1'][$r][$c]]->passengerAge} {/if} <br>

                                                            {$bp_books_seats[$name['1'][$r][$c]]->passengerMobile} <br>
                                                            {$bp_books_seats[$name['1'][$r][$c]]->boardingPoint->name|truncate:15}
                                                        </td>     
                                                    {else}
                                                        <td class="seat-cell" style="border:none;" valign="top"><span class="bold">x</span></td>
                                                    {/if}
                                                {else}
                                                    <td class="seat-cell">
                                                    </td>
                                                {/if}
                                            {/for}
                                        </tr>
                                    {/for}
                                </table>
                            </td>
                        </tr>
                    </table>
                                        
                </td>                
            </tr>
        </table>
        
        <br>
        
        <table width="98%">
        <tr>                    
            <td width="40%" valign="top" >
                <table class="table table-bordered" cellpading="10">
                    <tr>
                        <td nowrap><strong>Station</strong></td>
                        <td><strong>Station Point</strong></td>
                        <td><strong>Seats</strong></td>                                                                           
                    </tr>
                    {assign var="prestation" value=""}
                    {foreach item=point from=$points}
                        {if $bp_books[$point['code']]|count > 0}
                            <tr>
                                <td>{if $prestation!=$point['stageName']} {$point['stageName']} {/if}</td>
                                <td >{$point['name']} - {$point['time']}</td> 
                                <td >{$bp_books[$point['code']]|count}</td>                         
                            </tr>    
                            {assign var="prestation" value=$point['stageName']}
                        {/if}                                                            
                    {/foreach}                                                       
                </table>
            </td>
            <td width="60%" valign="top" >
                <table class="table table-bordered" cellpading="10" >
                    <tr>
                        <td class="bold" align="center" nowrap><b>Total seats</b></td>                        
                        <td class="bold" align="center"><b>Booked</b></td>
                        <td class="bold" align="center"><b>Vacant</b></td>
                    </tr>
                    <tr>
                        <td align="center">{$totalSeatCount}</td>                        
                        <td align="center">{$totalBookedCount}</td>
                        <td align="center">{count($unbookedlist)}</td>
                    </tr>
                </table>
            </td>
        </tr>
        </table>
        
        
    {/if}                
    <script>
        window.print();
    </script>    
 </body>
</html>