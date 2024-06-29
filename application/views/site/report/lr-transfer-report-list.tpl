<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><b>Lr Transfer Report</b></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Date :</span>{$fromDate|date_format:$ns_date_format} To {$toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
<br>
<div class="overflow-x-auto">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success bold">
                <td align="center">S.No</td>
                <td align="center">OGPL No</td>
                <td align="center">From Station</td>
                <td align="center">To Station</td>
                <td align="center">From Branch</td>
                <td align="center">To Branch</td>
                <td align="center">Vehicle No</td>
                <td align="center">Transfer Vehicle No</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=sno value=0}
            {foreach item=val from=$result}
                {assign var=sno value=$sno+1}
                <tr>
                    <td align="center">{$sno}</td>
                    <td align="center">
                        <a href="javascript:;" onclick="showOgplWiseLrTransfer('{$val->alias_code}');">{$val->alias_code}</a>
                    </td>
                    <td align="center">{$val->from_station_name}</td>
                    <td align="center">{$val->to_station_name}</td>
                    <td align="center">{$val->from_organization_name}</td>
                    <td align="center">{$val->to_organization_name}</td>
                    <td align="center">{$val->vehicle_number}</td>
                    <td align="center">{$val->transfer_vehicle_number}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>