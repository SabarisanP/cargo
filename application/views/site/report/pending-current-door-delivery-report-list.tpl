<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><b>Pending & Current Door Delivery Report</b></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Date :</span>{$smarty.request.date|date_format:$ns_date_format}
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
            <tr class="success">
                <th>S.No</th>
                <th>NAME</th>
                <th>FROM PLACE</th>
                <th>LR DATE</th>
                <th>ARTICLES</th>
                <th>LR NO</th>
                <th>MODE OF PAYMENT</th>
                <th>TAKEN BY VEHICLENO</th>
                <th>BILLCOLLECTION</th>
                <th>AMOUNT</th>
            </tr>
        </thead>
        <tbody class="body_table">

            {assign var=t_total_amount value=0}
        
            {foreach item=row from=$details key=i}
                <tr>
                    <td align="left">{$i + 1}</td>
                    <td align="left">{$row->from_customer_name}</td>
                    <td align="left">{$row->from_station_name}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_date_format}</td>
                    <td align="left">{$row->articles}</td>
                    <td align="left">{$row->cargo_code}</td>
                    <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>
                    <td align="left">{$row->registration_number}</td>
                    <td align="left">{$row->bill_collection}</td>
                    <td align="right">{$row->total_amount|sigma:$t_total_amount|inr_format}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="12" align="center">No Records Found</td>
                </tr>
            {/foreach}
        </tbody>
        {if $details|count}
            <tfoot>
                <tr class="active bold">
                    <td colspan="9" align="right">Total</td>
                    <td align='right' colspan="1">{$t_total_amount|number_format:2}</td>
                </tr>
            </tfoot>
        {/if}
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoEditReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="DeliveryReportPrint();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>