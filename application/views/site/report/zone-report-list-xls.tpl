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
<table border="1" style="font-family: Times New Roman;">
    <thead>
        <tr style="background-color:#92d050; color: #0000; font-weight: bold;">
            <td>ZONE</td>

            {if $transactionType == 'BOOKING'}
                <td>TO STATION</td>
                <td>TO BRANCH</td>
            {else}
                <td>FROM STATION</td>
                <td>FROM BRANCH</td>
            {/if}
            <td>NOS</td>
            <td>PAID</td>
            <td>TOPAY</td>
            <td>ON A/C</td>
            <td style="color:#ff0017;">TOTAL</td>
            <td>LOADING</td>
            <td>OTHER</td>
            <td>COMM</td>
            <td>AMOUNT</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var="total_lr_count" value=0}
        {assign var="total_paid" value=0}
        {assign var="total_topay" value=0}
        {assign var="total_on_account" value=0}
        {assign var="total_freight" value=0}
        {assign var="total_loading_charge" value=0}
        {assign var="total_other_charge" value=0}
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
            {assign var="zone_other_charge" value=0}
            {assign var="zone_commission" value=0}
            {assign var="zone_total_amount" value=0}
            {foreach item=stn from=$row['station'] key=stn_key}
                {assign var="station_count" value=0}
                {if $stn['branch']['out_con_ch']|count}
                    {foreach item=brn from=$stn['branch']['out_con_ch'] key=brn_key}
                        <tr style="background-color:#fcd5b4;">
                            <td>
                                {if $zone_count == 0}
                                    {$row['zone_name']}
                                {/if}
                            </td>
                            <td>
                                {if $station_count == 0}
                                    {$stn['station_name']}
                                {/if}
                            </td>
                            <td>{$brn['branch_name']}</td>
                            <td align="center">{$brn['lr_count']}</td>
                            <td align="right">{$brn['paid']|number_format:2}</td>
                            <td align="right">{$brn['topay']|number_format:2}</td>
                            <td align="right">{$brn['on_account']|number_format:2}</td>
                            <td align="right">{$brn['paid']+$brn['topay']+$brn['on_account']|number_format:2}</td>
                            <td align="right">{$brn['loading_charge']|number_format:2}</td>
                            <td align="right">{$brn['other_charge']|number_format:2}</td>
                            <td align="right">{$brn['commision']|number_format:2}</td>
                            <td align="right">{$brn['total_amount']|number_format:2}</td>
                        </tr>

                        {* Zone Wise Total *}
                        {assign var="zone_lr_count" value=$zone_lr_count+$brn['lr_count']}
                        {assign var="zone_paid" value=$zone_paid+$brn['paid']}
                        {assign var="zone_topay" value=$zone_topay+$brn['topay']}
                        {assign var="zone_on_account" value=$zone_on_account+$brn['on_account']}
                        {assign var="zone_freight" value=$zone_freight+($brn['paid']+$brn['topay']+$brn['on_account'])}
                        {assign var="zone_loading_charge" value=$zone_loading_charge+$brn['loading_charge']}
                        {assign var="zone_other_charge" value=$zone_other_charge+$brn['other_charge']}
                        {assign var="zone_commission" value=$zone_commission+$brn['commision']}
                        {assign var="zone_total_amount" value=$zone_total_amount+$brn['total_amount']}

                        {* Grand Total *}
                        {assign var="zone_count" value=$zone_count+1}
                        {assign var="station_count" value=$station_count+1}
                        {assign var="total_lr_count" value=$total_lr_count+$brn['lr_count']}
                        {assign var="total_paid" value=$total_paid+$brn['paid']}
                        {assign var="total_topay" value=$total_topay+$brn['topay']}
                        {assign var="total_on_account" value=$total_on_account+$brn['on_account']}
                        {assign var="total_freight" value=$total_freight+($brn['paid']+$brn['topay']+$brn['on_account'])}
                        {assign var="total_loading_charge" value=$total_loading_charge+$brn['loading_charge']}
                        {assign var="total_other_charge" value=$total_other_charge+$brn['other_charge']}
                        {assign var="total_commission" value=$total_commission+$brn['commision']}
                        {assign var="total__t_amount" value=$total__t_amount+$brn['total_amount']}
                    {foreachelse}
                        <tr>
                            <td colspan="12" align="center">No data found</td>
                        </tr>
                    {/foreach}
                {/if}
                {if $stn['branch']['con_ch']|count}
                    {foreach item=brn from=$stn['branch']['con_ch'] key=brn_key}
                        <tr style="background-color:#fcd5b4;">
                            <td>
                                {if $zone_count == 0}
                                    {$row['zone_name']}
                                {/if}
                            </td>
                            <td>
                                {if $station_count == 0}
                                    {$stn['station_name']}
                                {/if}
                            </td>
                            <td>{$brn['branch_name']}{$conection_ch}</td>
                            <td align="center">{$brn['lr_count']}</td>
                            <td align="right">{$brn['paid']|number_format:2}</td>
                            <td align="right">{$brn['topay']|number_format:2}</td>
                            <td align="right">{$brn['on_account']|number_format:2}</td>
                            <td align="right">{$brn['freight']|number_format:2}</td>
                            <td align="right">{$brn['loading_charge']|number_format:2}</td>
                            <td align="right">{$brn['other_charge']|number_format:2}</td>
                            <td align="right">{$brn['commision']|number_format:2}</td>
                            <td align="right">{$brn['total_amount']|number_format:2}</td>
                        </tr>

                        {* Zone Wise Total *}
                        {assign var="zone_lr_count" value=$zone_lr_count+$brn['lr_count']}
                        {assign var="zone_paid" value=$zone_paid+$brn['paid']}
                        {assign var="zone_topay" value=$zone_topay+$brn['topay']}
                        {assign var="zone_on_account" value=$zone_on_account+$brn['on_account']}
                        {assign var="zone_freight" value=$zone_freight+$brn['freight']}
                        {assign var="zone_loading_charge" value=$zone_loading_charge+$brn['loading_charge']}
                        {assign var="zone_other_charge" value=$zone_other_charge+$brn['other_charge']}
                        {assign var="zone_commission" value=$zone_commission+$brn['commision']}
                        {assign var="zone_total_amount" value=$zone_total_amount+$brn['total_amount']}

                        {* Grand Total *}
                        {assign var="zone_count" value=$zone_count+1}
                        {assign var="station_count" value=$station_count+1}
                        {assign var="total_lr_count" value=$total_lr_count+$brn['lr_count']}
                        {assign var="total_paid" value=$total_paid+$brn['paid']}
                        {assign var="total_topay" value=$total_topay+$brn['topay']}
                        {assign var="total_on_account" value=$total_on_account+$brn['on_account']}
                        {assign var="total_freight" value=$total_freight+$brn['freight']}
                        {assign var="total_loading_charge" value=$total_loading_charge+$brn['loading_charge']}
                        {assign var="total_other_charge" value=$total_other_charge+$brn['other_charge']}
                        {assign var="total_commission" value=$total_commission+$brn['commision']}
                        {assign var="total__t_amount" value=$total__t_amount+$brn['total_amount']}
                    {foreachelse}
                        <tr>
                            <td colspan="12" align="center">No data found</td>
                        </tr>
                    {/foreach}
                {/if}
            {/foreach}

            <tr style="background-color:#f4a6cd; color:#000; font-weight:bold;">
                <td colspan="3"></td>
                <td align="center"><b>{$zone_lr_count}</b></td>
                <td align="right"><b>{$zone_paid|number_format:2}</b></td>
                <td align="right"><b>{$zone_topay|number_format:2}</b></td>
                <td align="right"><b>{$zone_on_account|number_format:2}</b></td>
                <td align="right"><b>{$zone_freight|number_format:2}</b></td>
                <td align="right"><b>{$zone_loading_charge|number_format:2}</b></td>
                <td align="right"><b>{$zone_other_charge|number_format:2}</b></td>
                <td align="right"><b>{$zone_commission|number_format:2}</b></td>
                <td align="right"><b>{$zone_total_amount|number_format:2}</b></td>
            </tr>
        {/foreach}
    </tbody>

    <tfoot>
        <tr style="background-color: #92d050; font-weight: bold;">
            <td colspan="3" align="right">Total</td>
            <td align="center">{$total_lr_count}</td>
            <td align="right">{$total_paid|number_format:2}</td>
            <td align="right">{$total_topay|number_format:2}</td>
            <td align="right">{$total_on_account|number_format:2}</td>
            <td align="right">{$total_freight|number_format:2}</td>
            <td align="right">{$total_loading_charge|number_format:2}</td>
            <td align="right">{$total_other_charge|number_format:2}</td>
            <td align="right">{$total_commission|number_format:2}</td>
            <td align="right">{$total__t_amount|number_format:2}</td>
        </tr>
    </tfoot>
</table>