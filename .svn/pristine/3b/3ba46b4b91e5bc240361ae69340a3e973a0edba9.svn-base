<table width="95%">
    <tr>
        <td colspan="10" align="center"><b>Vehicle Tariff Report</b></td>
    </tr>
    <tr>
        <td width="50%">
            <b>From</b>  {$smarty.request.fromDate|date_format:$ns_date_format}  <b>To</b> {$smarty.request.toDate|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <b>Report Date/Time :</b> {date("d-m-Y h:i:s A")}
        </td>
    </tr>
</table><br>
<table class="table table-bordered" style="width: 30%;">
    <tr>
        <td class="bold"><b>Total KM Amount</b></td>
        <td align="right">{$total_km_amt|inr_format:2}</td>
    </tr>
    <tr>
        <td class="bold"><b>Extra KM Amount</b></td>
        <td align="right">{$total_extra_km_amt|inr_format:2}</td>
    </tr>
    <tr>
        <td class="bold"><b>Paid Amount</b></td>
        <td align="right">{$total_paid_amt|inr_format:2}</td>
    </tr>
    <tr>
        <td class="bold"><b>Balance Amount</b></td>
        <td align="right">{$total_balance_amt|inr_format:2}</td>
    </tr>
</table>
<br>
<div class="table-responsive">
    <table class="table table-bordered" id="vehicle-tariff-report-table">
        <thead>
            <tr class="success">
                <th>S.No.</th>
                <th>Date</th>
                <th>OGPL No</th>  
                <th>Route</th>  
                <th>Total KM Amount</th>
                <th>Advance Amount</th>
                <th>Fuel Amount</th>                
                <th>Expense</th> 
                <th>Start KM</th> 
                <th>End KM</th> 
                <th>Total KM</th> 
                <th>Extra KM</th> 
                <th>Extra KM Amount</th> 
                <th>Balance</th> 
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=tot_advance value=0}
            {assign var=tot_fuel value=0}
            {assign var=tot_expense value=0}
            {assign var=tot_start_km value=0}
            {assign var=tot_end_km value=0}
            {assign var=tot_km value=0}
            {assign var=tot_extra_km value=0}
            {foreach item=row from=$results key=t}
                {assign var=total_km value=0}
                <tr>                    
                    <td align="center">{$t+1}</td>
                    <td>{$row->trip_date|date_format:$ns_date_format}</td>
                    <td>{$row->alias_code}</td> 
                    <td>{$row->from_station_name} - {$row->to_station_name}</td>
                    <td align="right">{($row->total_km_amount + $row->hiring_amount)|inr_format:2}</td> 
                    <td align="right">{$row->advance_amount|inr_format:2}</td> 
                    <td align="right">{$row->fuel_amount|inr_format:2}</td> 
                    <td align="right">{$row->expense_amount|inr_format:2}</td> 
                    <td align="center">{$row->start_odometer|default:'0'}</td>
                    <td align="center">{$row->end_odometer|default:'0'}</td>

                    {assign var=total_km value=$total_km+($row->end_odometer-$row->start_odometer)}
                    <td align="center">{$total_km|default:'0'}</td>
                    <td align="center">{$row->extra_km|default:'0'}</td>
                    <td align="right">{$row->extra_km_amount|inr_format:2}</td>
                    <td align="right">{($row->total_km_amount + $row->extra_km_amount + $row->hiring_amount - $row->advance_amount - $row->fuel_amount - $row->expense_amount)|inr_format:2}</td>
                </tr>
                {assign var=tot_advance value=$tot_advance+$row->advance_amount}
                {assign var=tot_fuel value=$tot_fuel+$row->fuel_amount}
                {assign var=tot_expense value=$tot_expense+$row->expense_amount}
                {assign var=tot_start_km value=$tot_start_km+$row->start_odometer}
                {assign var=tot_end_km value=$tot_end_km+$row->end_odometer}
                {assign var=tot_km value=$tot_km+$total_km}
                {assign var=tot_extra_km value=$tot_extra_km+$row->extra_km}
            {/foreach}  
        </tbody>
        <tfoot>
            <tr class="bold">
                <td align="right" colspan="4"><b>Total</b></td>
                <td align="right"><b>{$total_km_amt|inr_format:2}</b></td>
                <td align="right"><b>{$tot_advance|inr_format:2}</b></td>
                <td align="right"><b>{$tot_fuel|inr_format:2}</b></td>
                <td align="right"><b>{$tot_expense|inr_format:2}</b></td>
                <td align="center"><b>{$tot_start_km}</b></td>
                <td align="center"><b>{$tot_end_km}</b></td>
                <td align="center"><b>{$tot_km}</b></td>
                <td align="center"><b>{$tot_extra_km}</b></td>
                <td align="right"><b>{$total_extra_km_amt|inr_format:2}</b></td>
                <td align="right"><b>{$total_balance_amt|inr_format:2}</b></td>
            </tr>
        </tfoot>
    </table>                
</div>