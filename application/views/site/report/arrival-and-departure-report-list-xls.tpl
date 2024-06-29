<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><b>Arrival & Departure Report</b></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Date :</span>{$from_date|date_format:$ns_date_format} To {$to_date|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
<br>
<table border="1">
    <thead>
        <tr style="background-color:#92d050; color: #0000; font-weight: bold;">
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
    <tbody class="body_table">
        {assign var=sno value=0}
        {assign var=t_luggage_count value=0}
        {assign var=t_lr_count value=0}
        {assign var=t_lr_amt value=0}
        {foreach item=val from=$vehicleWise}
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
                <td align="center">{$val['luggage_count']}</td>
                <td align="center">{$val['load_count']}</td>
                <td align="center">{$val['total_luggage_amt']}</td>
            </tr>
        {/foreach}
    </tbody>
    {if count($vehicleWise) >0}
        <tr class="bold">
            <td align="right" colspan="5">Total</td>
            <td align="center">{$t_luggage_count}</td>
            <td align="center">{$t_lr_count}</td>
            <td align="center">{$t_lr_amt}</td>
        </tr>
    {/if}
</table>