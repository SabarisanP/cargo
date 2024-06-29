<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">TCS Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            From  {$smarty.request.fromDate|date_format:$ns_date_format}  To {$smarty.request.toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
<br/>
<h5><b>Summary</b></h5>
<div class="col-md-4 p_l_n">
    <table class="table table-bordered" style="width:100%;">
        <thead>
            <tr class="success">
                <th>Status</th>
                <th>Transaction Amount</th>
                <th>TCS</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td align="left">Booking</td>
                <td align="right">{$bo_tot_trans_amt|number_format:2}</td>
                <td align="right">{$bo_tot_ac_bus_tax|number_format:2}</td>
            </tr>
            <tr>
                <td align="left">Cancellation</td>
                <td align="right">{$ca_tot_trans_amt|number_format:2}</td>
                <td align="right">{$ca_tot_ac_bus_tax|number_format:2}</td>
            </tr>
            <tr class="bold">
                <td align="left">Total</td>
                <td align="right">{($bo_tot_trans_amt - $ca_tot_trans_amt)|number_format:2}</td>
                <td align="right">{($bo_tot_ac_bus_tax - $ca_tot_ac_bus_tax)|number_format:2}</td>
            </tr>
        </tbody>
    </table>
</div>
<div class="clearfix"></div>

<h5><b>Booking</b></h5>
<table id="tcs_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th>PNR</th>
            <th>Transaction Date</th>
            <th>Route</th>
            <th>Travel Date</th>
            <th>User</th>
            <th>Seats</th>
            <th>Transaction Amount</th>
            <th>TCS</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=bo_seats value=0}
        {assign var=bo_trans_amt value=0}
        {assign var=bo_ac_tax value=0}
        {assign var=bo_rows value=0}

        {foreach item=row from=$result key=t}
            {if $row->transaction_type == "BO"}
            <tr>
                <td align="left">{$row->ticket_code}</td>
                <td align="left">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                <td align="left">{$row->travel_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->user_name}</td>
                <td align="right">{$row->booked_count}</td>
                <td align="right">{($row->transaction_amount - $row->addons_amount)|number_format:2}</td>
                <td align="right">{$row->booked_ac_bus_tax|number_format:2}</td>
            </tr>
            {assign var=bo_seats value=$bo_seats + $row->booked_count}
            {assign var=bo_trans_amt value=$bo_trans_amt + ($row->transaction_amount - $row->addons_amount)}
            {assign var=bo_ac_tax value=$bo_ac_tax + $row->booked_ac_bus_tax}
            {assign var=bo_rows value=$bo_rows + 1}
            {/if}
        {/foreach}

        {if $bo_rows}
            <tr class="bold">
                <td align="right" colspan="5">Total</td>
                <td align="right">{$bo_seats}</td>
                <td align="right">{$bo_trans_amt|number_format:2}</td>
                <td align="right">{$bo_ac_tax|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>

<h5><b>Cancellation</b></h5>
<table id="tcs_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th>PNR</th>
            <th>Transaction Date</th>
            <th>Route</th>
            <th>Travel Date</th>
            <th>User</th>
            <th>Seats</th>
            <th>Transaction Amount</th>
            <th>TCS</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=ca_seats value=0}
        {assign var=ca_trans_amt value=0}
        {assign var=ca_ac_tax value=0}
        {assign var=ca_rows value=0}

        {foreach item=row from=$result key=t}
            {if $row->transaction_type == "CA"}
            <tr>
                <td align="left">{$row->ticket_code}</td>
                <td align="left">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                <td align="left">{$row->travel_date|date_format:$ns_date_format}</td>
                <td align="left">{$row->user_name}</td>
                <td align="right">{$row->booked_count}</td>
                <td align="right">{($row->transaction_amount - $row->addons_amount)|number_format:2}</td>
                <td align="right">{$row->booked_ac_bus_tax|number_format:2}</td>
            </tr>
            {assign var=ca_seats value=$ca_seats + $row->booked_count}
            {assign var=ca_trans_amt value=$ca_trans_amt + ($row->transaction_amount - $row->addons_amount)}
            {assign var=ca_ac_tax value=$ca_ac_tax + $row->booked_ac_bus_tax}
            {assign var=ca_rows value=$bo_rows + 1}
            {/if}
        {/foreach}

        {if $bo_rows}
            <tr class="bold">
                <td align="right" colspan="5">Total</td>
                <td align="right">{$ca_seats}</td>
                <td align="right">{$ca_trans_amt|number_format:2}</td>
                <td align="right">{$ca_ac_tax|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>