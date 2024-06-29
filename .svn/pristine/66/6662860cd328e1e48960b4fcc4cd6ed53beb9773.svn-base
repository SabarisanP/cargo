<table width="100%" style="font-family: Times New Roman;">
    <tr>
        <td colspan="10" align="center"><b>Zone Report</b></td>
    </tr>
    <tr>
        <td colspan="5"><b>From {$from_date|date_format:$ns_date_format} To {$to_date|date_format:$ns_date_format} </b></td>
        <td colspan="5" align="right"><b>Report Date/Time : {date("d-m-Y h:i A")}</b></td>
    </tr>
    <tr>
        <td colspan="10" align="center">
            <b>{$zoneName}
                {if isNotNull($branch)}
                    &nbsp;({$branch})
                {/if}
            </b>
        </td>
    </tr>
</table>
<br>
<div class="table-responsive">
    <table width="80%" class="table_format">
        <thead>
            <tr>
                <td colspan="2" style="background-color:#fea500;">BOOKING SUMMARY</td>
                <td colspan="8" style="background-color:#c0ea00;">
                    {foreach $branches as $branch }
                        {if $branch_code == 'NA'}
                            ALL BRANCH : {$from_date|date_format:$ns_date_format} to {$to_date|date_format:$ns_date_format}
                            {break}
                        {/if}
                        {if  $branch_code == $branch->code }
                            {$branch->name} : {$from_date|date_format:$ns_date_format} to {$to_date|date_format:$ns_date_format}
                            {break}
                        {/if}
                    {/foreach}
                </td>
            </tr>
            <tr style="background-color:#e4e6fa;">
                <td>Region</td>

                {if $transactionType == 'BOOKING'}
                    <td>To Station</td>
                    <td>To Branch</td>
                {else}
                    <td>From Station</td>
                    <td>From Branch</td>
                {/if}
                <td>Nos</td>
                <td>Paid</td>
                <td>Topay</td>
                <td>Total</td>
                <td>Load </td>
                <td>Conn</td>
                <td>Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var="total_lr_count" value=0}
            {assign var="total_paid" value=0}
            {assign var="total_topay" value=0}
            {assign var="total_on_account" value=0}
            {assign var="total_freight" value=0}
            {assign var="total_loading_charge" value=0}
            {assign var="total_connecting_charge" value=0}
            {assign var="total_commission" value=0}
            {assign var="total__t_amount" value=0}
            {assign var="conection_ch" value=" [CON] "}
            {foreach item=row from=$summary key=key}
                {assign var="zone_count" value=0}
                {assign var="zone_lr_count" value=0}
                {assign var="zone_paid" value=0}
                {assign var="zone_topay" value=0}
                {assign var="zone_on_account" value=0}
                {assign var="zone_freight" value=0}
                {assign var="zone_loading_charge" value=0}
                {assign var="zone_connecting_charge" value=0}
                {assign var="zone_commission" value=0}
                {assign var="zone_total_amount" value=0}
                {foreach item=stn from=$row['station'] key=stn_key}
                    {assign var="station_count" value=0}
                    {if $stn['branch']['out_con_ch']|count}
                        {foreach item=brn from=$stn['branch']['out_con_ch'] key=brn_key}

                            <tr style="background-color:bisque;">
                                <td style="width:100px">
                                    {if $zone_count == 0}
                                        {$row['zone_name']|upper}
                                    {/if}
                                </td>
                                <td style="width:100px">
                                    {if $station_count == 0}
                                        {$stn['station_name']|upper}
                                    {/if}
                                </td>
                                <td style="width:100px">{$brn['branch_name']|upper}</td>
                                {if $brn['lr_count'] >0 }
                                    <td align="left" style="width:60px">{$brn['lr_count']}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['paid'] >0 }
                                    <td align="left" style="width:60px">{$brn['paid']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['topay'] >0 }
                                    <td align="left" style="width:60px">{$brn['topay']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['freight'] >0 }
                                    <td align="left" style="width:60px">{($brn['paid']+$brn['topay']+$brn['on_account'])|inr_format:2}</td>
                                {else}
                                    <td></td>
                                {/if}
                                {if $brn['loading_charge'] >0 }
                                    <td align="left" style="width:60px">{$brn['loading_charge']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['connecting_charge'] >0 }
                                    <td align="left" style="width:60px">{$brn['connecting_charge']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['total_amount'] >0 }
                                    <td align="left" style="width:60px">{$brn['total_amount']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                            </tr>

                            {* Zone Wise Total *}
                            {assign var="zone_lr_count" value=$zone_lr_count+$brn['lr_count']}
                            {assign var="zone_paid" value=$zone_paid+$brn['paid']}
                            {assign var="zone_topay" value=$zone_topay+$brn['topay']}
                            {assign var="zone_on_account" value=$zone_on_account+$brn['on_account']}
                            {assign var="zone_freight" value=$zone_freight+($brn['paid']+$brn['topay']+$brn['on_account'])}
                            {assign var="zone_loading_charge" value=$zone_loading_charge+$brn['loading_charge']}
                            {assign var="zone_connecting_charge" value=$zone_connecting_charge+$brn['connecting_charge']}
                            {assign var="zone_commission" value=$zone_commission+$brn['commision']}
                            {assign var="zone_total_amount" value=$zone_total_amount+$brn['total_amount']}

                            {* Grand Total *}
                            {assign var="zone_count" value=$zone_count+1}
                            {assign var="station_count" value=$station_count+1}
                            {assign var="total_lr_count" value=$total_lr_count+$brn['lr_count']}
                            {assign var="total_paid" value=$total_paid+$brn['paid']}
                            {assign var="total_topay" value=$total_topay+$brn['topay']}
                            {assign var="total_freight" value=$total_freight+($brn['paid']+$brn['topay']+$brn['on_account'])}
                            {assign var="total_loading_charge" value=$total_loading_charge+$brn['loading_charge']}
                            {assign var="total_connecting_charge" value=$total_connecting_charge+$brn['connecting_charge']}
                            {assign var="total__t_amount" value=$total__t_amount+$brn['total_amount']}
                        {foreachelse}
                            <tr>
                                <td colspan="12" align="center">No data found</td>
                            </tr>
                        {/foreach}
                    {/if}
                    {if $stn['branch']['con_ch']|count}
                        {foreach item=brn from=$stn['branch']['con_ch'] key=brn_key}

                            <tr style="background-color:bisque;">
                                <td style="width:100px">
                                    {if $zone_count == 0}
                                        {$row['zone_name']|upper}
                                    {/if}
                                </td>
                                <td style="width:100px">
                                    {if $station_count == 0}
                                        {$stn['station_name']}
                                    {/if}
                                </td>
                                <td style="width:100px" nowrap>{$brn['branch_name']|upper}{$conection_ch}</td>
                                {if $brn['lr_count'] >0 }
                                    <td align="left" style="width:60px">{$brn['lr_count']}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['paid'] >0 }
                                    <td align="left" style="width:60px">{$brn['paid']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['topay'] >0 }
                                    <td align="left" style="width:60px">{$brn['topay']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['freight'] >0 }
                                    <td align="left" style="width:60px">{$brn['freight']|inr_format:2}</td>
                                {else}
                                    <td></td>
                                {/if}
                                {if $brn['loading_charge'] >0 }
                                    <td align="left" style="width:60px">{$brn['loading_charge']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['connecting_charge'] >0 }
                                    <td align="left" style="width:60px">{$brn['connecting_charge']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                                {if $brn['total_amount'] >0 }
                                    <td align="left" style="width:60px">{$brn['total_amount']|inr_format:2}</td>
                                {else}
                                    <td style="width:60px"></td>
                                {/if}
                            </tr>

                            {* Zone Wise Total *}
                            {assign var="zone_lr_count" value=$zone_lr_count+$brn['lr_count']}
                            {assign var="zone_paid" value=$zone_paid+$brn['paid']}
                            {assign var="zone_topay" value=$zone_topay+$brn['topay']}
                            {assign var="zone_on_account" value=$zone_on_account+$brn['on_account']}
                            {assign var="zone_freight" value=$zone_freight+$brn['freight']}
                            {assign var="zone_loading_charge" value=$zone_loading_charge+$brn['loading_charge']}
                            {assign var="zone_connecting_charge" value=$zone_connecting_charge+$brn['connecting_charge']}
                            {assign var="zone_commission" value=$zone_commission+$brn['commision']}
                            {assign var="zone_total_amount" value=$zone_total_amount+$brn['total_amount']}

                            {* Grand Total *}
                            {assign var="zone_count" value=$zone_count+1}
                            {assign var="station_count" value=$station_count+1}
                            {assign var="total_lr_count" value=$total_lr_count+$brn['lr_count']}
                            {assign var="total_paid" value=$total_paid+$brn['paid']}
                            {assign var="total_topay" value=$total_topay+$brn['topay']}
                            {assign var="total_freight" value=$total_freight+$brn['freight']}
                            {assign var="total_loading_charge" value=$total_loading_charge+$brn['loading_charge']}
                            {assign var="total_connecting_charge" value=$total_connecting_charge+$brn['connecting_charge']}
                            {assign var="total__t_amount" value=$total__t_amount+$brn['total_amount']}
                        {foreachelse}
                            <tr>
                                <td colspan="12" align="center">No data found</td>
                            </tr>
                        {/foreach}
                    {/if}
                {/foreach}
                <tr style="background-color:pink; color:#000; font-weight:bold;">
                    <td colspan="3"></td>
                    {if $zone_lr_count >0 }
                        <td align="left">{$zone_lr_count}</td>
                    {else}
                        <td style="width:60px"></td>
                    {/if}
                    {if $zone_paid >0 }
                        <td align="left">{$zone_paid|inr_format:2}</td>
                    {else}
                        <td style="width:60px"></td>
                    {/if}
                    {if $zone_topay > 0 }
                        <td align="left">{$zone_topay|inr_format:2}</td>
                    {else}
                        <td style="width:60px"></td>
                    {/if}
                    {if $zone_freight > 0 }
                        <td align="left">{$zone_freight|inr_format:2}</td>
                    {else}
                        <td style="width:60px"></td>
                    {/if}
                    {if $zone_loading_charge >0 }
                        <td align="left">{$zone_loading_charge|inr_format:2}</td>
                    {else}
                        <td style="width:60px"></td>
                    {/if}
                    {if $zone_connecting_charge >0 }
                        <td align="left">{$zone_connecting_charge|inr_format:2}</td>
                    {else}
                        <td style="width:60px"></td>
                    {/if}
                    {if $zone_total_amount >0 }
                        <td align="left">{$zone_total_amount|inr_format:2}</td>
                    {else}
                        <td style="width:60px"></td>
                    {/if}
                </tr>
            {/foreach}
        </tbody>
        <tfoot>
            <tr style="background-color:#e4e6fa; font-weight:bold;"">
                <td colspan=" 3" align="right">Total</td>
                {if $total_lr_count >0 }
                <td align="left">{$total_lr_count}</td>
                {else}
                <td style="width:60px"></td>
                {/if}

                {if $total_paid >0 }
                <td align="left">{$total_paid|inr_format:2}</td>
                {else}
                <td style="width:60px"></td>
                {/if}

                {if $total_topay > 0 }
                <td align="left">{$total_topay|inr_format:2}</td>
                {else}
                <td style="width:60px"></td>
                {/if}

                {if $total_freight > 0 }
                <td align="left">{$total_freight|inr_format:2}</td>
                {else}
                <td style="width:60px"></td>
                {/if}

                {if $total_loading_charge >0 }
                <td align="left">{$total_loading_charge|inr_format:2}</td>
                {else}
                <td style="width:60px"></td>
                {/if}

                {if $total_connecting_charge >0 }
                <td align="left">{$total_connecting_charge|inr_format:2}</td>
                {else}
                <td style="width:60px"></td>
                {/if}

                {if $total__t_amount >0 }
                <td align="left">{$total__t_amount|inr_format:2}</td>
                {else}
                <td style="width:60px"></td>
                {/if}
            </tr>
        </tfoot>
    </table>
</div>