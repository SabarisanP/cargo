<html>
    <head>
        <title>Print Ticket</title>
        <link href="{$base_url}assets/icons/font-awesome/css/font-awesome.min.css?{$asset_ver}" rel="stylesheet">
        {literal}
            <style>
                {/literal}
                {if $namespace=="sreejothi"}
                    {literal}*{font: normal 14pt/20px arial; }{/literal}
                {else}
                    {literal}*{font: normal 13px/20px arial; }{/literal}
                {/if}
                {literal}
                strong{ font-weight: bold; }
                .border-top{ border-top: 1px solid #ccc; }
                .grid { border: solid #ccc; border-width:1px 0 0 1px !important;}
                .grid th,  .grid td { border:solid #ccc !important; border-width:0 1px 1px 0 !important;}
                .cancelled-seat{  text-decoration:line-through; }
            </style> 
        {/literal}
    </head>
    <body>
        <table cellpadding="5" cellspacing="0" width="98%" align="center">
            <tr>
                <td align="center">  <img src="{$web_cdn_url}/bits/print/{$namespace}/trip_chart_logo.jpg" > </td>
            </tr>
            <tr>
                <td align="right" style="font-size:10px">Printed By {$usr_login_name} @ {date("d/m/Y h:i A")} </td>
            </tr>
            <tr>
                <td class="border-top">
                    <table cellspacing="0" cellpadding="5" border="0" width="98%">
                        <tbody>
                            <tr>
                                <td width="25%">
                                    <strong style="font-size:15px;">PNR / Invoice Number</strong><br>
                                    {$tck->code} &nbsp;
                                    {if $tck->deviceMedium == 'WEB'}
                                        <i class="fa fa-desktop"></i>
                                    {else if $tck->deviceMedium == 'APP'}
                                        <i class="fa fa-mobile"></i>
                                    {else}
                                        <i class="fa fa-buysellads"></i>
                                    {/if}
                                </td>
                                <td width="25%">
                                    <strong style="font-size:15px;">Travel Date/Time</strong> <br>
                                    {date('d/m/Y',strtotime($tck->travelDate))}
                                    {date('g:i A',strtotime($tck->fromStation->stationPoint[0]->dateTime))}
                                </td>
                                <td width="25%">
                                    <strong style="font-size:15px;">Route</strong>  <br>
                                    {$tck->fromStation->name} - {$tck->toStation->name}
                                </td>
                                 <td width="25%">
                                    <strong style="font-size:15px;">Bus Type</strong>  <br>
                                    {formatBusCategory cate_code=$tck->bus->categoryCode}
                                </td>
                            </tr>
                                                 
                            <tr>
                                <td>
                                    <strong style="font-size:15px;">Boarding Address</strong> <br>
                                    {$tck->fromStation->stationPoint[0]->address}, 
                                    {$tck->fromStation->stationPoint[0]->name},
                                    {$tck->fromStation->name} <br>
                                    Contact : {$tck->fromStation->stationPoint[0]->number}
                                </td>
                                
                                <!--<td valign="top">
                                    <strong style="font-size:15px;">Reporting Time</strong> <br>
                                    {$tck->reportingTime|date_format:$ns_time_format}
                                </td>-->
                                
                                <td valign="top">
                                    <strong style="font-size:15px;">Boarding Time</strong> <br>
                                    {$tck->fromStation->stationPoint[0]->dateTime|date_format:$ns_datetime_format}
                                </td>
                                
                                <td>
                                    <strong style="font-size:15px;">Alighting Info</strong> <br>
                                    {$tck->toStation->stationPoint[0]->address},
                                    {$tck->toStation->stationPoint[0]->name},
                                    {$tck->toStation->name} <br>
                                    Contact : {$tck->toStation->stationPoint[0]->number}
                                </td>                                
                            </tr>
                            <tr>
                                <td>
                                    <strong style="font-size:15px;">Passenger Mobile</strong><br>
                                    {$tck->passegerMobleNo}
                                </td>                                
                                <td>
                                    <strong style="font-size:15px;">Booking Info</strong><br>
                                    {$tck->user->name} , {date('d/m/Y g:i A',strtotime($tck->transactionDate))}
                                </td>
                                <td>
                                    {if $tck->serviceNo != ''}
                                        <strong style="font-size:15px;">Service Number</strong><br>
                                        {$tck->serviceNo}
                                    {/if}
                                </td>
                                <td></td>
                            </tr>
                            {if $tck->code != $tck->bookingCode }
                            <tr>
                                <td><strong>Transaction ID</strong></td>                                
                                <td>{$tck->bookingCode}</td>
                            </tr>
                            {/if}
                        </tbody>
                    </table>

                </td>
            </tr>
            <tr>
                <td>
                    <table width="98%" border="0" cellpadding="1" cellspacing="0" class="grid" >
                        <tr bgcolor="#F5F5F5" >
                            <th width="35%" align="left" ><strong>Passenger Name</strong></th>
                            <th width="10%" align="center" ><strong>Seat No</strong> </th>
                            <th width="10%" align="center" ><strong>Gender</strong></th>
                            <th width="10%" align="center" ><strong>Age</strong></th>                            
                            <th width="15%" align="center"><strong>Status</strong></th>
                            <th width="15%" align="right" ><strong>Fare</strong></th>
                        </tr>
                        {assign var="tot_trans" value=0}
                        {assign var="seat_fare" value=0}
                        {assign var="ca_seat_fare" value=0}
                        {assign var="tax" value=0}
                        {assign var="ca_tax" value=0}
                        {assign var="can_charge" value=0}
                        {assign var="refund" value=0}
                        
                        {foreach item=ticket from=$tck->ticketDetails}   
                            <tr class="{if $ticket->seatStatus->code=="CA" || $ticket->seatStatus->code=="PBC"} cancelled-seat {/if}">
                                <td >{$ticket->passengerName}</td>
                                <td align="center">{$ticket->seatName}</td>
                                <td align="center">{$ticket->passengerGendar}</td>
                                <td align="center">{$ticket->passengerAge}</td>                                
                                <td align="center" nowrap>{$ticket->seatStatus->name}</td>
                                <td align="right"><i class="fa fa-rupee"></i> {$ticket->seatFare|number_format:2}</td>
                            </tr>
                            {if $ticket->seatStatus->code=="CA"}
                                {assign var="can_charge" value=$can_charge+$ticket->cancellationCharges}
                                {assign var="refund" value=$refund+$ticket->refundAmount+$ticket->serviceTax}
                                {assign var="ca_seat_fare" value=$ca_seat_fare+$ticket->seatFare}
                                {assign var="ca_tax" value=$ca_tax+$ticket->serviceTax}
                            {else if $ticket->seatStatus->code!="PBC"}
                                {assign var="tot_trans" value=$tot_trans+$ticket->seatFare+$ticket->serviceTax}
                                {assign var="tax" value=$tax+$ticket->serviceTax}
                                {assign var="seat_fare" value=$seat_fare+$ticket->seatFare}
                            {/if}                       
                        {/foreach} 

                        {assign var="discount" value=0}
                        {assign var="gogreen" value=0}
                        {assign var="ca_discount" value=0}
                        {assign var="service_charges" value=0}

                        {foreach item=dis from=$tck->ticketAddonsDetails}
                            {if $dis->addonType->code=="AGSC"}
                                {assign var="service_charges" value=$service_charges+$dis->value}
                                {assign var="tot_trans" value=$tot_trans+$dis->value}
                            {elseif ($dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP" || $dis->addonType->code=="OFDS") && $dis->addonStatus->code!="CA"} 
                                {assign var="discount" value=$discount+$dis->value}
                                {assign var="tot_trans" value=$tot_trans-$dis->value}  
                            {elseif ($dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP" || $dis->addonType->code=="OFDS") && $dis->addonStatus->code=="CA"}     
                                {assign var="refund" value=$refund-$dis->value}
                                {assign var="ca_discount" value=$ca_discount+$dis->value}
                            {elseif $dis->addonType->code == 'WARD' || $dis->addonType->code == 'WACP'}
                                {assign var="discount" value=$discount+$dis->value}
                                {assign var="tot_trans" value=$tot_trans-$dis->value}
                            {elseif $dis->addonType->code == 'GGN'}
                                {assign var="gogreen" value=$gogreen+$dis->value}
                                {assign var="tot_trans" value=$tot_trans+$dis->value}
                            {/if}
                        {/foreach}  
                    
                        
                    </table>
                    
                    <br>
                        
                    <table width="98%" border="0" cellspacing="0" >
                        <tr>
                            <td width="40%" align="right" valign="top">
                                {if $tck->tax!=''}
                                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="grid" >
                                    <tr>
                                        <td align="center" colspan="2" class="bold" bgcolor="#F5F5F5"><strong>GST</strong></td>
                                        <tr>
                                            <td align="left"> GSTIN</td>
                                            <td align="left"> {$tck->tax->gstin}</td>
                                        </tr>
                                        <tr>
                                            <td align="left"> Trade Name</td>
                                            <td align="left"> {$tck->tax->tradeName}</td>
                                        </tr>
                                        {if $tck->tax->cgstValue>0}
                                            <tr>
                                                <td align="left"> CGST</td>
                                                <td align="left">  {$tck->tax->cgstValue} %</td>
                                            </tr>
                                        {/if}
                                        {if $tck->tax->sgstValue>0}
                                            <tr>
                                                <td align="left"> SGST</td>
                                                <td align="left">  {$tck->tax->sgstValue} %</td>
                                            </tr>
                                        {/if}
                                        {if $tck->tax->igstValue>0}
                                            <tr>
                                                <td align="left"> IGST</td>
                                                <td align="left"> {$tck->tax->igstValue} %</td>
                                            </tr>
                                        {/if}
                                        {if $tck->tax->ugstValue>0}
                                            <tr>
                                                <td align="left"> UGST</td>
                                                <td align="left">  {$tck->tax->ugstValue} %</td>
                                            </tr>
                                        {/if}
                                        <tr>
                                            <td align="left"> SAC Code</td>
                                            <td align="left"> 996422</td>
                                        </tr>
                                    </tr>
                                </table>
                                {/if}
                            </td>
                            <td width="6%">&nbsp;</td>
                            <td width="27%" align="right" valign="top">
                                {if $can_charge>0 || $refund>0}
                                    
                                            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="grid" >
                                                <tr>
                                                    <td align="center" colspan="2" class="bold" bgcolor="#F5F5F5"><strong>Cancellation</strong></td>                            
                                                </tr>
                                                {if $ca_seat_fare>0}
                                                    <tr>
                                                        <td align="right"> Gross Amount :</td>
                                                        <td align="right">  {$ca_seat_fare|number_format:2}</td>
                                                    </tr>
                                                {/if}

                                                {if $ca_tax>0}
                                                    <tr>
                                                        <td align="right"> GST :</td>
                                                        <td align="right">  + {$ca_tax|number_format:2}</td>
                                                    </tr>
                                                {/if}

                                                {if $can_charge>0}
                                                    <tr>
                                                        <td align="right"> Cancellation Charge :</td>
                                                        <td align="right"> - {$can_charge|number_format:2}</td>
                                                    </tr>
                                                {/if}
                                                {if $ca_discount>0}
                                                    <tr>
                                                        <td align="right"> Discount :</td>
                                                        <td align="right"> - {$ca_discount|number_format:2}</td>
                                                    </tr>
                                                {/if}

                                                {if $refund>0}
                                                    <tr>
                                                        <td align="right" class="bold"> Refund :</td>
                                                        <td align="right" class="bold"> {$refund|number_format:2}</td>
                                                    </tr>
                                                {/if}
                                            </table>
                                           
                                {/if} 
                            </td>
                            <td width="6%">&nbsp;</td>
                            <td width="27%" align="right" valign="top">
                               <table width="100%" border="0" cellpadding="2" cellspacing="0" class="grid" >
                                <tr>
                                    <td align="center" colspan="2" class="bold" bgcolor="#F5F5F5"><strong>Booking</strong></td>                            
                                </tr>
                                {if $seat_fare > 0}
                                    <tr>
                                        <td align="right"> Gross Amount :</td>
                                        <td align="right">  {$seat_fare|number_format:2}</td>
                                    </tr>
                                {/if}
                                
                                {if $discount > 0}  
                                    <tr>
                                        <td align="right"> Discount :</td>
                                        <td align="right"> - {$discount|number_format:2} </td>
                                    </tr>  
                                {/if}

                                {if $tax > 0}
                                    <tr>
                                        <td align="right"> GST :</td>
                                        <td align="right"> + {$tax|number_format:2}</td>
                                    </tr>
                                {/if}
                                
                                {if $gogreen > 0}
                                    <tr>
                                        <td align="right"> Go Green Donation :</td>
                                        <td align="right"> + {$gogreen|number_format:2}</td>
                                    </tr>
                                {/if}

                                {if $service_charges > 0}  
                                    <tr>
                                        <td align="right"> Service Charges :</td>
                                        <td align="right"> + {$service_charges|number_format:2} </td>
                                    </tr>  
                                {/if} 


                                {if $tot_trans > 0} 
                                <tr>
                                    <td align="right" class="bold"> Total :</td>
                                    <td align="right" class="bold"> {$tot_trans|number_format:2} </td>
                                </tr>
                                 {/if}  
                            </table> 
                            </td>
                        </tr>
                    </table>    
                </td>
            </tr>
            <tr>
                <td> <strong>Cancellation Policy </strong> </td>
            </tr>
            <tr>
                <td>
                    <table width="98%" border="0" cellpadding="1" cellspacing="0" class="" style="font-size:12px;" >
                        <thead>
                            <tr bgcolor="#F5F5F5" >
                                <td width="50%"><strong>Timing</strong></td>
                                <td><strong>Deduction</strong></td>
                                <td><strong>Refund</strong></td>
                                <td><strong>Charges</strong></td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach item=row from=$tck->cancellationTerms->policyList}    
                                <tr> 
                                    <td>{$row->term}</td>
                                    <td>{$row->deductionAmountTxt}</td>
                                    <td>{$row->refundAmountTxt}</td>
                                    <td>{$row->chargesTxt}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
            {if $terms|count > 0}
                <tr>
                    <td> <strong>Terms & Conditions </strong></td>
                </tr>
            {/if}

            <tr>
                <td>
                    <table width="98%" border="0" cellpadding="1" cellspacing="0" class="" style="font-size:12px;" >
                        <tbody>
                            {assign var="tmp" value=1}
                            {foreach item=row from=$terms} 
                                {if $row->name !="" && $row->activeFlag==1}
                                    <tr> 
                                        <td width="1%" valign="top">{$tmp}.</td> 
                                        <td>{$row->name}</td>                                
                                    </tr>
                                    {assign var="tmp" value=$tmp+1}
                                {/if}
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>  

        </table>

    </body>
</html>
{if $smarty.request.print==1}
<script>
    window.setTimeout(function () {
        window.print();
    }, 2000);
</script>
{/if}