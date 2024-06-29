<html>
    <head>
        <title>Print Ticket</title>
        <link href="{$base_url}assets/icons/font-awesome/css/font-awesome.min.css?{$asset_ver}" rel="stylesheet">
        {literal}
            <style>
                *{font: normal 12px/20px arial; }
                strong{ font-weight: bold; }
                .border-top{ border-top: 1px solid #ccc; }
                .grid { border: solid #ccc; border-width:1px 0 0 1px !important;}
                .grid th,  .grid td { border:solid #ccc !important; border-width:0 1px 1px 0 !important;}
                .cancelled-seat{  text-decoration:line-through; }
            </style> 
        {/literal}
    </head>
    <body>
        <div style="position: absolute;left: 50%;top: 75px;">
            {if $tck->ticketStatus->code == 'BO'}
                <img src="{$base_url}assets/img/booked.jpg" style="width: 600px;left: -50%;opacity: 0.3;position: relative;">
            {elseif $tck->ticketStatus->code == 'CA'}
                <img src="{$base_url}assets/img/cancelled.png" style="width: 600px;left: -50%;opacity: 0.3;position: relative;">
            {elseif $tck->ticketStatus->code == 'PBL'}
                <img src="{$base_url}assets/img/phonebooked.jpg" style="width: 700px;left: -50%;opacity: 0.3;position: relative;">
            {elseif $tck->ticketStatus->code == 'PBC'}
                <img src="{$base_url}assets/img/phonebookcancelled.jpg" style="width: 700px;left: -50%;opacity: 0.3;position: relative;">
            {/if}
        </div>
        <table cellpadding="5" cellspacing="0" width="98%" align="center">
            <tr>
                <td align="center"><strong style="font-size:25px;">{$tck->operator->name}</strong></td>
            </tr>
            <tr>
                <td align="right" style="font-size:10px">Printed By {$usr_login_name} @ {date("d/m/Y h:i A")} </td>
            </tr>
            <tr>
                <td class="border-top">
                    <table cellspacing="0" cellpadding="0" border="0" width="98%">
                        <tbody>
                            <tr>
                                <td width="30%">
                                    <strong style="font-size:14px;">PNR Number</strong><br>
                                    {$tck->code} &nbsp;
                                    {if $tck->deviceMedium == 'WEB'}
                                        <i class="fa fa-desktop"></i>
                                    {else if $tck->deviceMedium == 'APP'}
                                        <i class="fa fa-mobile"></i>
                                    {else}
                                        <i class="fa fa-buysellads"></i>
                                    {/if}
                                </td>
                                <td width="20%">
                                    <strong style="font-size:14px;">Travel Date/Time</strong> <br>
                                    {date('d/m/Y',strtotime($tck->travelDate))}
                                    {date('g:i A',strtotime($tck->fromStation->stationPoint[0]->dateTime))}
                                </td>
                                <td width="30%">
                                    <strong style="font-size:14px;">Route</strong>  <br>
                                    {$tck->fromStation->name} - {$tck->toStation->name}
                                </td>
                                <td width="20%">
                                    <strong style="font-size:14px;">Bus Type</strong>  <br>
                                    {formatBusCategory cate_code=$tck->bus->categoryCode}
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <strong style="font-size:14px;">Boarding Address</strong> <br>
                                    {$tck->fromStation->stationPoint[0]->address}, 
                                    {$tck->fromStation->stationPoint[0]->name},
                                    {$tck->fromStation->name} <br>
                                    Contact : {$tck->fromStation->stationPoint[0]->number}
                                </td>

                                <!--<td valign="top">
                                    <strong style="font-size:14px;">Reporting Time</strong> <br>
                                {$tck->reportingTime|date_format:$ns_time_format}
                                </td>-->

                                <td valign="top">
                                    <strong style="font-size:14px;">Boarding Time</strong> <br>
                                    {$tck->fromStation->stationPoint[0]->dateTime|date_format:$ns_datetime_format}
                                </td>

                                <td>
                                    <strong style="font-size:14px;">Alighting Info</strong> <br>
                                    {$tck->toStation->stationPoint[0]->address},
                                    {$tck->toStation->stationPoint[0]->name},
                                    {$tck->toStation->name} <br>
                                    Contact : {$tck->toStation->stationPoint[0]->number}
                                </td>                                
                            </tr>
                            <tr>
                                <td>
                                    <strong style="font-size:14px;">Passenger Mobile</strong><br>
                                    {$tck->passegerMobleNo}
                                </td>                                
                                <td>
                                    <strong style="font-size:14px;">Booking Info</strong><br>
                                    {$tck->user->name} , {date('d/m/Y g:i A',strtotime($tck->transactionDate))}
                                </td>
                                <td></td>
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
                    <table width="98%" border="0" cellspacing="0" >
                        <tr>
                            <td valign="top">
                                <strong style="font-size:14px;">Passenger Details</strong> <br>
                                {assign var="tot_trans" value=0}
                                {assign var="seat_fare" value=0}
                                {assign var="ca_seat_fare" value=0}
                                {assign var="tax" value=0}
                                {assign var="ca_tax" value=0}
                                {assign var="can_charge" value=0}
                                {assign var="refund" value=0}

                                {foreach item=ticket from=$tck->ticketDetails}
                                    {if $ticket->seatStatus->code!="CA" && $ticket->seatStatus->code!="PBC"} 
                                        {$ticket->seatName}, 
                                        {$ticket->passengerName} ({$ticket->passengerGendar}),
                                        {$ticket->passengerAge}
                                        <br>
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
                                    {elseif ($dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP" || $dis->addonType->code=="OFDS" || $dis->addonType->code=="WARD" || $dis->addonType->code=="WACP") && $dis->addonStatus->code!="CA"} 
                                        {assign var="discount" value=$discount+$dis->value}
                                        {assign var="tot_trans" value=$tot_trans-$dis->value}  
                                    {elseif ($dis->addonType->code=="SHDS" || $dis->addonType->code=="DSAMT" || $dis->addonType->code=="COUP" || $dis->addonType->code=="OFDS" || $dis->addonType->code=="WARD" || $dis->addonType->code=="WACP") && $dis->addonStatus->code=="CA"}     
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
                            </td>  
                            <td width="6%">&nbsp;</td>                
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
                                    </table>
                                {/if}
                        <tr>
                    </table>
                </td>
            </tr>
            <tr>                             
                <td>                        
                    <table width="98%" border="0" cellspacing="0" >
                        <tr>
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
                                {if $tot_trans > 0} 
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
                                {/if}  
                            </td>
                        </tr>
                    </table>    
                </td>
            </tr>
        </table>
    </body>
</html>
<script>
    window.setTimeout(function () {
        window.print();
    }, 2000);
</script>
