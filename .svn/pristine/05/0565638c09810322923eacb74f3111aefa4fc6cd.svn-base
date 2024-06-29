<table class="bordered" cellpadding="0" width="100%">
    <tr>
        <td align="left" width="25%">
        </td>
        <td align="center" width="50%">
            <h2 style="font-size: 20px;"> Seenu Transports Pvt.Ltd. </h2>
            <h2 style="font-size: 20px;">DEPARTURE & ARRIVAL SUMMARY</h2>
            <span class="bold"><b>Date :</b></span>{$from_date|date_format:$ns_date_format} To {$to_date|date_format:$ns_date_format}
        </td>
        <td width="25%">
        </td>
    </tr>
</table>
<table class="border" cellpadding="2" width="100%">
    <thead>
        <tr>
            <td>S.No</td>
            <td>DESCRIPTION</td>
            <td>TOTAL VEHICLE</td>
            <td>TOTAL LUGGAGE LIST</td>
            <td>TOTAL LRS</td>
            <td>TOTAL SOFTWARE LRS</td>
            <td>TOTAL MANUVAL LRS</td>
            <td>TOTAL LUGGAGE LIST AMOUNT</td>
        </tr>
    </thead>
    <tbody>
        {assign var=d_sno value=0}
        {assign var=t_luggage_count_d value=0}
        {assign var=t_vehicle_count_d value=0}
        {assign var=t_lr_count_d value=0}
        {assign var=t_lr_amt_d value=0}
        {foreach item=val from=$stationWise key=key}
            {assign var=d_sno value=$d_sno+1}
            {assign var=t_luggage_count_d value=$t_luggage_count_d+$val['luggage_count']}
            {assign var=t_lr_count_d value=$t_lr_count_d+$val['load_count']}
            {assign var=t_lr_amt_d value=$t_lr_amt_d+$val['total_luggage_amt']}
            {assign var=t_vehicle_count_d value=$t_vehicle_count_d+$val['vehicle_count']}
            <tr>
                <td align="center">{$d_sno}</td>
                <td align="center">{$val['from_station_name']}</td>
                <td align="center">{$val['vehicle_count']}</td>
                <td align="center">{$val['luggage_count']}</td>
                <td align="center">{$val['load_count']}</td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center">{$val['total_luggage_amt']}</td>
            </tr>
        {/foreach}
        <tr>
            <td align="right"></td>
            <td align="center"><b>Total</b></td>
            <td align="center"><b>{$t_vehicle_count_d}</b></td>
            <td align="center"><b>{$t_luggage_count_d}</b></td>
            <td align="center"><b>{$t_lr_count_d}</b></td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"><b>{$t_lr_amt_d}</b></td>
        </tr>
    </tbody>
</table><br>
<table class="border" cellpadding="2" width="100%">
    <thead>
        <tr>
            <td align="center" colspan="6">VEHICLE FREIGHT AMT BELOW & ABOVE 20,000 (SUMMARY AS ON DATE : {$from_date|date_format:$ns_date_format} )</td>
        </tr>
        <tr>
            <td align="center">TOTAL VEHICLE</td>
            <td align="center">BELOW 20,000</td>
            <td align="center">ABOVE 20,000</td>
            <td align="center">ABOVE 25,000</td>
            <td align="center">ABOVE 30,000</td>
            <td align="center">TOTAL</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td align="center">{$t_vehicle_count_d}</td>
            <td align="center">{$twenty_below_vehicle_count}</td>
            <td align="center">{$twenty_above_vehicle_count}</td>
            <td align="center">{$twenty_five_above_vehicle_count}</td>
            <td align="center">{$thirty_above_vehicle_count}</td>
            <td align="center"> {$t_vehicle_count_d}</td>
        </tr>
        <tr>
            <td align="center" colspan="6"><b>VEHICLE BELOW 20,000 REASON AS ON DATE : {$from_date|date_format:$ns_date_format}</b></td>
        </tr>
        <table id="" class="border" style="width:100%;border-top: none;">
            <thead>
                <tr>
                    <td align="center">S.No</td>
                    <td align="center">VEHICLE NO</td>
                    <td align="center">TRUCK DETAILS</td>
                    <td align="center">FROM BRANCH</td>
                    <td align="center">TO BRANCH</td>
                    <td align="center">BOOKING AMT</td>
                    <td align="center">REASON</td>
                </tr>
            </thead>
            <tbody>
                {assign var=sno value=0}
                {assign var=t_luggage_count value=0}
                {assign var=t_lr_count value=0}
                {assign var=t_lr_amt value=0}
                {foreach item=val from=$vehicleWise}
                    {if $val['total_luggage_amt'] < 20000}
                        {assign var=sno value=$sno+1}
                        {assign var=t_luggage_count value=$t_luggage_count+$val['luggage_count']}
                        {assign var=t_lr_count value=$t_lr_count+$val['load_count']}
                        {assign var=t_lr_amt value=$t_lr_amt+$val['total_luggage_amt']}
                        <tr>
                            <td align="center">{$sno}</td>
                            <td align="center">{$val['registration_numer']}</td>
                            <td align="center">{$val['vehicle_ownership_type']}</td>
                            <td align="center">{$val['from_via_organization_short_code']|trim:', '}</td>
                            <td align="center">{$val['to_via_organization_short_code']|trim:', '}</td>
                            <td align="center">{$val['total_luggage_amt']}</td>
                            <td align="center"></td>
                        </tr>
                    {/if}
                {/foreach}
            </tbody>
        </table>
    </tbody>
</table>
<br>
{if $filterType =="LOAD"}
    {foreach item=vals from=$stationWise key=key}
        <table class="border" cellpadding="0" width="100%">
            <tr>
                <td align="center"><b>DEPARTURE REPORT</b></td>
            </tr>
            <tr>
                <td align="center"><b>{$vals['from_station_name']|upper} -{$vals['to_station_name']|upper} TRUCK DEPARTURE DETAILS</b></td>
            </tr>
            <tr>
                <td align="center"><b>DEPARTURE DATE :{$from_date|date_format:$ns_date_format}</b></td>
            </tr>
            <tr>
                <td align="center"><b>ARRIVAL DATE :{$to_date|date_format:$ns_date_format}</b></td>
            </tr>
        </table>
        <table id="" class="border" style="width:100%">
            <thead>
                <tr>
                    <td align="center">S.No</td>
                    <td align="center">VEHICLE NO</td>
                    <td align="center">TRUCK DETAILS</td>
                    <td align="center">FROM BRANCH</td>
                    <td align="center">TO BRANCH</td>
                    <td align="center">LUGGAGE LIST COUNT</td>
                    <td align="center">NO OF LR</td>
                    <td align="center">LUGGAGE LIST AMOUNT</td>
                </tr>
            </thead>
            <tbody>
                {assign var=sno value=0}
                {assign var=t_luggage_count value=0}
                {assign var=t_lr_count value=0}
                {assign var=t_lr_amt value=0}
                {foreach item=row from=$vals['code']}
                    {assign var=sno value=$sno+1}
                    {assign var=t_luggage_count value=$t_luggage_count+count($row->alias_code)}
                    {assign var=t_lr_count value=$t_lr_count+$row->load_count}
                    {assign var=t_lr_amt value=$t_lr_amt+$row->transit_total_amount}

                    <tr>
                        <td align="center">{$sno}</td>
                        <td align="center">{$row->registration_numer}</td>
                        <td align="center">{$row->vehicle_ownership_type}</td>
                        <td align="center">{$row->from_via_organization_short_code}</td>
                        <td align="center">{$row->to_via_organization_short_code}</td>
                        <td align="center">{count($row->alias_code)}</td>
                        <td align="center">{$row->load_count}</td>
                        <td align="center">{$row->transit_total_amount}</td>
                    </tr>
                {/foreach}
            </tbody>
            <tr>
                <td align="right" colspan="5"><b>Total</b></td>
                <td align="center"><b>{$t_luggage_count}</b></td>
                <td align="center"><b>{$t_lr_count}</b></td>
                <td align="center"><b>{$t_lr_amt}</b></td>
            </tr>
        </table>
        <table class="" cellpadding="0" width="100%">
            <tr>
                <td align="center" width="15%"></td>
                <td align="center" width="70%">
                    <br>
                    <table id="" class="border" style="width:100%">
                        <tbody>
                            <tr>
                                <td align="center" colspan="3">SUMMARY</td>
                            </tr>
                            <tr>
                                <td align="center"></td>
                                <td align="center">{$vals['from_station_name']|upper} - {$vals['to_station_name']|upper}</td>
                                <td align="center">TOTAL</td>
                            </tr>
                            <tr>
                                <td align="center">TOTAL VEHICLE</td>
                                <td align="center">{$sno}</td>
                                <td align="center">{$sno}</td>
                            </tr>
                            <tr>
                                <td align="center">TOTAL L.LIST</td>
                                <td align="center">{$t_luggage_count}</td>
                                <td align="center">{$t_luggage_count}</td>
                            </tr>
                            <tr>
                                <td align="center">TOTAL LR</td>
                                <td align="center">{$t_lr_count}</td>
                                <td align="center">{$t_lr_count}</td>
                            </tr>
                            <tr>
                                <td align="center">TOTAL AMOUNT</td>
                                <td align="center">{$t_lr_amt}</td>
                                <td align="center">{$t_lr_amt}</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td align="center" width="15%"></td>
            </tr>
        </table>
        <br>
    {/foreach}
{else}
    {foreach item=vals from=$stationWise key=key}
        <table class="" cellpadding="0" width="100%">
            <tr>
                <td align="center"><b>ARRIVAL REPORT</b></td>
            </tr>
            <tr>
                <td align="center"><b>{$vals['from_station_name']|upper} -{$vals['to_station_name']|upper} ( TRUCK DEPARTURE DETAILS )</b></td>
            </tr>
            <tr>
                <td align="center"><b>DEPARTURE DATE :{$from_date|date_format:$ns_date_format}</b></td>
            </tr>
            <tr>
                <td align="center"><b>ARRIVAL DATE :{$to_date|date_format:$ns_date_format}</b></td>
            </tr>
        </table>
        <table id="" class="border" style="width:100%">
            <thead>
                <tr>
                    <td align="center">S.No</td>
                    <td align="center">VEHICLE NO</td>
                    <td align="center">TRUCK DETAILS</td>
                    <td align="center">FROM BRANCH</td>
                    <td align="center">TO BRANCH</td>
                    <td align="center">LUGGAGE LIST COUNT</td>
                    <td align="center">NO OF LR</td>
                    <td align="center">LUGGAGE LIST AMOUNT</td>
                </tr>
            </thead>
            <tbody>
                {assign var=sno value=0}
                {assign var=t_luggage_count value=0}
                {assign var=t_lr_count value=0}
                {assign var=t_lr_amts value=0}
                {foreach item=row from=$vals['code']}
                    {assign var=sno value=$sno+1}
                    {assign var=t_luggage_count value=$t_luggage_count+count($row->alias_code)}
                    {assign var=t_lr_count value=$t_lr_count+$row->load_count}
                    {assign var=t_lr_amts value=$t_lr_amts+$row->transit_total_amount}
                    <tr>
                        <td align="center">{$sno}</td>
                        <td align="center">{$row->registration_numer}</td>
                        <td align="center">{$row->vehicle_ownership_type}</td>
                        <td align="center">{$row->from_via_organization_short_code}</td>
                        <td align="center">{$row->to_via_organization_short_code}</td>
                        <td align="center">{count($row->alias_code)}</td>
                        <td align="center">{$row->load_count}</td>
                        <td align="center">{$row->transit_total_amount}</td>
                    </tr>
                {/foreach}
            </tbody>
            <tr>
                <td align="right" colspan="5"><b>Total</b></td>
                <td align="center"><b>{$t_luggage_count}</b></td>
                <td align="center"><b>{$t_lr_count}</b></td>
                <td align="center"><b>{$t_lr_amts}</b></td>
            </tr>
        </table>
        <table class="" cellpadding="0" width="100%">
            <tr>
                <td align="center" width="15%"></td>
                <td align="center" width="70%">
                    <br>
                    <table id="" class="border" style="width:100%">
                        <tbody>
                            <tr>
                                <td align="center" colspan="3">SUMMARY</td>
                            </tr>
                            <tr>
                                <td align="center"></td>
                                <td align="center">{$vals['from_station_name']|upper} - {$vals['to_station_name']|upper}</td>
                                <td align="center">TOTAL</td>
                            </tr>
                            <tr>
                                <td align="center">TOTAL VEHICLE</td>
                                <td align="center">{$sno}</td>
                                <td align="center">{$sno}</td>
                            </tr>
                            <tr>
                                <td align="center">TOTAL L.LIST</td>
                                <td align="center">{$t_luggage_count}</td>
                                <td align="center">{$t_luggage_count}</td>
                            </tr>
                            <tr>
                                <td align="center">TOTAL LR</td>
                                <td align="center">{$t_lr_count}</td>
                                <td align="center">{$t_lr_count}</td>
                            </tr>
                            <tr>
                                <td align="center">TOTAL AMOUNT</td>
                                <td align="center">{$t_lr_amt}</td>
                                <td align="center">{$t_lr_amt}</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td align="center" width="15%"></td>
            </tr>
        </table>
        <br>
    {/foreach}
{/if}


<script>
    window.print();
</script>

<style>
    .bold {
        /* font-weight: bold; */
        font-family: Arial, Helvetica, sans-serif;
        font-weight: normal;
        font-size: 0.9em;
        margin: 1px;
        padding: 0;
    }

    table {
        border-collapse: collapse;

    }

    table.border thead td,
    table.border tbody td {
        border: 1px solid #000;
    }

    table thead th,
    table thead td {
        font-weight: bold;
    }

    .bordered {
        border: 1px solid #000;
        border-bottom: none;
    }
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }
    }

    @page {
        size: A4 landscape;
    }
</style>