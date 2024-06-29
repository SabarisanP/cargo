<table width="95%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">User Transaction Summary Report</td>
    </tr>
    <tr>
        <td width="50%">
            User Transaction Summary Report
            From  {$smarty.request.date_from|date_format:$ns_date_format}  To {$smarty.request.date_to|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
<div class="panel panel-default">
    <div class="table-responsive">
        <table id="dt_report_table" class="table table-bordered">
            <thead>
                <tr class="info">
                    <td class="sorting" rowspan="2" align="center">Group Name <i class="fa fa-sort"></i></td>
                    <td rowspan="2" align="center">User Name <i class="fa fa-sort"></i></td>
                    <td colspan="5" align="center">Booked Details</td> 
                    <td colspan="5" align="center">Cancelled Details</td>
                    <td colspan="3" align="center">Account Details</td> 
                </tr>
                <tr class="info">

                    <!-- Booked Details-->

                    <td align="center">Seats &nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">Fare&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">GST&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">Commission&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">PhoneBook Seats &nbsp;&nbsp;<i class="fa fa-sort"></i></td>

                    <!--Cancelled Details-->

                    <td align="center">Seats&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">Refund&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">Charges&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">Revoke Com&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">Phone Cancelled Seats&nbsp;&nbsp;<i class="fa fa-sort"></i></td>

                    <!-- Account Details-->

                    <td align="center">Opening Balance&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">Closing Balance&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                    <td align="center">Recharge&nbsp;&nbsp;<i class="fa fa-sort"></i></td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=bkd_seat_count value=0}
                {assign var=bkd_tck_amount value=0}
                {assign var=bkd_comm_amount value=0}
                {assign var=ph_bkd_seat_count value=0}

                {assign var=cld_seat_count value=0}
                {assign var=refund_amount value=0}
                {assign var=cncl_charges value=0}
                {assign var=rvke_comm_amount value=0}
                {assign var=ph_cld_seat_count value=0}

                {assign var=service_tax value=0}

                {assign var=opening_bal value=0}
                {assign var=closing_bal value=0}
                {assign var=rech_amt value=0}

                {foreach item=row from=$tickets key =k}
                    <tr>
                        <td align="left">{$row->user_group_code}</td>
                        <td align="left">{$row->user_first_name}</td>

                        <!-- Booked Details -->

                        <td align="center">{$row->booked_seat_count}</td>
                        <td align="right">{$row->booked_ticket_amount|inr_format}</td>
                        <td align="right">{$row->booked_ac_bus_tax_amount|inr_format}</td>
                        <td align="right">{$row->booked_commission_amount|inr_format}</td>
                        <td align="center">{$row->phone_booked_seat_count}</td>

                        <!-- Cancelled Details -->

                        <td align="center">{$row->cancelled_seat_count}</td>
                        <td align="right">{$row->refund_amount|inr_format}</td>
                        <td align="right">{$row->cancellation_charges|inr_format}</td>
                        <td align="right">{$row->revoke_commission_amount|inr_format}</td>
                        <td align="center">{$row->phone_booked_seat_count}</td>

                        <td align="right">{$row->opening_balance|inr_format}</td>
                        <td align="right">{$row->closing_balance|inr_format}</td>
                        <td align="right">{$row->recharge_amount|inr_format}</td>
                    </tr>
                    {assign var=bkd_seat_count value=$bkd_seat_count+ $row->booked_seat_count}
                    {assign var=bkd_tck_amount value=$bkd_tck_amount+ $row->booked_ticket_amount}
                    {assign var=bkd_comm_amount value=$bkd_comm_amount+ $row->booked_commission_amount}
                    {assign var=ph_bkd_seat_count value=$ph_bkd_seat_count+ $row->phone_booked_seat_count}

                    {assign var=cld_seat_count value=$cld_seat_count+$row->cancelled_seat_count}
                    {assign var=refund_amount value=$refund_amount+$row->refund_amount}
                    {assign var=cncl_charges value=$cncl_charges+$row->cancellation_charges}
                    {assign var=rvke_comm_amount value=$rvke_comm_amount+$row->revoke_commission_amount}
                    {assign var=ph_cld_seat_count value=$ph_cld_seat_count+$row->phone_cancelled_seat_count}

                    {assign var=service_tax value=$service_tax+$row->booked_ac_bus_tax_amount}

                    {assign var=opening_bal value=$opening_bal+$row->opening_balance}
                    {assign var=closing_bal value=$closing_bal+$row->closing_balance}
                    {assign var=rech_amt value=$rech_amt+$row->recharge_amount}
                {/foreach}   

            </tbody>
            <tr class="info">
                <td colspan="2" align="center">Grand Total</td>
                <td align="center" id="tkt_booked">{$bkd_seat_count}</td>
                <td align="right">{$bkd_tck_amount|inr_format}</td>
                <td align="right">{$service_tax|inr_format}</td>
                <td align="right"> {$bkd_comm_amount|inr_format}</td>
                <td align="center" id="tkt_pb_blocked">{$ph_bkd_seat_count}</td>

                <td align="center" id="tkt_canceled">{$cld_seat_count}</td>
                <td align="right">{$refund_amount|inr_format}</td>
                <td align="right">{$cncl_charges|inr_format}</td>
                <td align="right">{$rvke_comm_amount|inr_format}</td>
                <td align="center">{$ph_cld_seat_count}</td>

                <td align="right">{$opening_bal|inr_format}</td>
                <td align="right">{$closing_bal|inr_format}</td>
                <td align="right">{$rech_amt|inr_format}</td>
            </tr>
        </table>
    </div>
</div>
<br/><br/>
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportConsolidateExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>

<script>
    var book_summary ={$book_summary|json_encode};
    var cancel_summary ={$cancel_summary|json_encode};
</script>  

<script>
    $(document).ready(function () {

        $('#dt_report_table').dataTable({

            "sDom":
                    '<"well well-sm"<"row"<"col-md-4 clearfix"l><"col-md-8 clearfix"fT>r>>' +
                    't' +
                    '<"row"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>',

        });
        $('#ToolTables_dt_report_table_0').hide();
        $('#ToolTables_dt_report_table_1').hide();
        $('#ToolTables_dt_report_table_2').hide();
        $('#ToolTables_dt_report_table_3').hide();
        $("select[name=dt_report_table_length]").val("100").change();


    });

</script>