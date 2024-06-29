<table style="border: 1px solid #000" cellpadding="20" width="100%">
    <tr>
        {* {if $namespace == 'seenutransport'} *}
            <td align="left" width="25%">
                &nbsp;<img src="{$base_url}/assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
        {* {/if} *}
        <td align="center" width="50%">
            <h2>Pending & Current Door Delivery Report</h2>
        </td>
        <td width="25%">
            <table width="100%" style="line-height: 20px;" class="bottom">
                <tr>
                    <td align="right" width="50%"><b>Branch</b></td>
                    <td width="100%">&nbsp;<b>:</b>{if $branch_name !=="NA"}{$branch_name}{else}ALL{/if} </td>
                </tr>
                <tr>
                    <td align="right" width="50%" class="bold"><b>Date</b></td>
                    <td width="100%">&nbsp;<b>:</b> {$smarty.now|date_format:$ns_date_format}</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table border="1" class="bordered" cellpadding="5" width="100%">
    <thead>
        <tr>
            <th colspan="10">Pending Door Delivery</th>
        </tr>
        <tr>
            <th>S.No</th>
            <th>NAME</th>
            <th>FROM PLACE</th>
            <th>LR DATE</th>
            <th>ARTICLES</th>
            <th>AMOUNT</th>
            <th>LR NO</th>
            <th>MODE OF PAYMENT</th>
            <th>TAKEN BY VEHICLENO</th>
            <th>STATUS</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_total_amount value=0}
        {foreach item=row from=$details key=i}
            {if $user_date > $row->booked_at|date_format:"%Y-%m-%d"}
                <tr>
                    <td align="left">{$i + 1}</td>
                    <td align="center">{$row->from_customer_name}</td>
                    <td align="center">{$row->from_organization_name}</td>
                    <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                    <td align="center">{$row->articles}</td>
                    <td align="right">{$row->total_amount}</td>
                    <td align="center">{$row->cargo_code}</td>
                    <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                    <td align="center">{$row->registration_number} {if isNotNull($row->unloaded_driver_name)}/{$row->unloaded_driver_name}{/if}</td>
                    <td align="center">{$row->bill_collection}</td>
                </tr>
                {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
            {/if}
        {foreachelse}
            <tr>
                <td colspan="12" align="center">No Records Found</td>
            </tr>
        {/foreach}
        <tr>
            <td colspan="5" align="center">Total</td>
            <td align="center">{$t_total_amount|number_format:2}</td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>

        </tr>

    </tbody>
</table>
<table style="border: 1px solid #000" cellpadding="20" width="100%">
    <tr>
        {* {if $namespace == 'seenutrans'} *}
            <td align="left" width="25%">
                &nbsp;<img src="{$base_url}/assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
        {* {/if} *}
        <td align="center" width="50%">
            <h2>Pending & Current Door Delivery Report</h2>
        </td>
        <td width="25%">
            <table width="100%" style="line-height: 20px;" class="bottom">
                <tr>
                    <td align="right" width="50%" class="bold">Date</td>
                    <td width="100%">&nbsp;<b>:</b> {$smarty.now|date_format:$ns_date_format}</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table border="1" class="bordered" cellpadding="2" width="100%">
    <thead>
        <tr>
            <th colspan="12">Current Door Delivery</th>
        </tr>
        <tr>
            <th>S.No</th>
            <th>Vehicle No.</th>
            <th></th>
            <th width="10%">Name</th>
            <th>From Location</th>
            <th>LR Date</th>
            <th>Articles</th>
            <th>Amount</th>
            <th>LR No.</th>
            <th>Mode of Payment</th>
            <th>Taken By Vehicle No.</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_total_amount value=0}
        {assign var="pending_rpt_sno" value=0}
        {foreach item=row from=$vehicleWise key=i}
            {assign var="pending_rpt_sub_no" value=0}
            {* {if $user_date == $row['booked_at']|date_format:"%Y-%m-%d"} *}
                {assign var="pending_rpt_sno" value=$pending_rpt_sno+1}

                <tr>
                    <td rowspan="{$row['vehicle_count']+1}">{$pending_rpt_sno}</td>
                    <td rowspan="{$row['vehicle_count']+1}">{$row['vehicle_no']}<br>{$row['vehicle_name']}<br>
                        (No.Of.Lr-{$row['vehicle_count']})
                    </td>
                    <td><b>SNo<b></td>
                    <td colspan="2" align="center"><b>{$row['loaded_date']|date_format:$ns_date_format}&nbsp;{$row['from_station_name']} TO {$row['to_station_name']}</b></td>
                    <td colspan="7"><b>Vehicle Arrival Time :- {$row['unloaded_date']|date_format:$ns_datetime_format}</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Unloading Person:- {$row['unloaded_user_name']}</b></td>
                </tr>
                {foreach item=val from=$row['code']}
                    {assign var="pending_rpt_sub_no" value=$pending_rpt_sub_no+1}
                    <tr>
                        <td>{$pending_rpt_sub_no}</td>
                        <td align="center">{$val->from_customer_name}</td>
                        <td align="center">{$val->from_organization_name}</td>
                        <td align="center" nowrap>{$val->booked_at|date_format:$ns_date_format}</td>
                        <td align="center">{$val->articles}</td>
                        <td align="right">{$val->total_amount}</td>
                        <td align="center">{$val->cargo_code}</td>
                        <td align="center">{$cargo_payment_status[$val->payment_status_code]}</td>
                        <td align="center">{$val->delivery_vehicle_number} <br> {$val->transit_driver_name}</td>
                        <td align="center">{$val->bill_collection|default:'-'}</td>
                    </tr>
                    {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
                {/foreach}
            {* {/if} *}
        {foreachelse}
            <tr>
                <td rowspan="2" align="center">-</td>
                <td rowspan="2" align="center">-</td>
                <td><b>SNo<b></td>
                <td colspan="2" align="center">-</td>
                <td colspan="7"><b>Vehicle Arrival Time :- </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Unloading Person:-</b></td>
            </tr>
            <tr>
                <td></td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="right">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
                <td align="center">-</td>
            </tr>
        {/foreach}
    </tbody>
</table>

<table width="100%">
    <h5><b>Summary</b></h5>
    <tr>
        <td align="left">
            <table border="1" class="bordered" cellpadding="2">
                <thead>
                    <tr>
                        <th>Payment Details :</th>
                        <th colspan="2"></th>
                    </tr>
                    <tr>
                        <th>Mode of Payment</th>
                        <th>No. of GCN</th>
                        <th>Amount(Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    {assign var=t_total_amount value=0}
                    {assign var=t_lr_count value=0}
                    {foreach item=row from=$summary key=i}
                        {if $row->attribute_type =='PAYMENT_TYPE'}
                            <tr>
                                <td align="center">{$cargo_payment_status[$row->attribute_code]}</td>
                                <td align="right">{$row->lr_count}</td>
                                <td align="right">{$row->amount}</td>
                            </tr>
                            {assign var=t_total_amount value=$t_total_amount + $row->amount}
                            {assign var=t_lr_count value=$t_lr_count + $row->lr_count}
                        {/if}
                    {foreachelse}
                        <tr>
                            <td colspan="12" align="center">No Records Found</td>
                        </tr>
                    {/foreach}
                </tbody>
                {assign var=t_lr_d_count value=$t_lr_count}
                {assign var=t_no_d_amount value=$t_total_amount}
                {if $summary|count}
                    <tfoot>
                        <tr class="active bold">
                            <td align="right">Total : </td>
                            <td align="right">{$t_lr_count}</td>
                            <td align='right'>{$t_total_amount|number_format:2}</td>
                        </tr>
                    </tfoot>
                {/if}
            </table>
        </td>
        <td align="center">
            <table border="1" class="bordered" cellpadding="2">
                <thead>
                    <tr>
                        <th>Delivery Details :</th>
                        <th colspan="2"></th>
                    </tr>
                    <tr>
                        <th>Delivery Status</th>
                        <th>No. of GCN</th>
                        <th>Amount(Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    {assign var=t_total_amount value=0}
                    {assign var=t_lr_count value=0}
                    {foreach item=row from=$summary key=i}
                        {if $row->attribute_type == 'DELIVERY DETAILS'}
                            <tr>
                                <td align="center">{$row->attribute_code}</td>
                                <td align="right">{$row->lr_count}</td>
                                <td align="right">{$row->amount}</td>
                            </tr>
                            {assign var=t_lr_count value=$t_lr_count + $row->lr_count}
                            {assign var=t_total_amount value=$t_total_amount + $row->amount}
                        {/if}
                    {foreachelse}
                        <tr>
                            <td colspan="12" align="center">No Records Found</td>
                        </tr>
                    {/foreach}
                </tbody>
                {if $summary|count}
                    <tfoot>
                        <tr class="active bold">
                            <td align="right">Total : </td>
                            <td align="right">{$t_lr_count}</td>
                            <td align='right'>{$t_total_amount|number_format:2}</td>
                        </tr>
                    </tfoot>
                {/if}
            </table>
        </td>
        <td align="right">
            <table border="1" class="bordered" cellpadding="2">
                <thead>
                    <tr>
                        <th>Return to branch :</th>
                        <th colspan="2"></th>
                    </tr>
                    <tr>
                        <th>Branch</th>
                        <th>No. of GCN</th>
                        <th>Amount(Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    {assign var=t_total_amount value=0}
                    {assign var=t_re_lr_count value=0}
                    {foreach item=row from=$summary key=i}
                        {if $row->attribute_type == 'RETURN_BRANCH'}
                            <tr>
                                <td align="center">{$row->attribute_code}</td>
                                <td align="right">{$row->lr_count}</td>
                                <td align="right">{$row->amount}</td>
                            </tr>
                            {assign var=t_total_amount value=$t_total_amount+$row->amount}
                            {assign var=t_re_lr_count value=$t_re_lr_count+$row->lr_count}
                        {/if}
                    {foreachelse}
                        <tr>
                            <td colspan="12" align="center">No Records Found</td>
                        </tr>
                    {/foreach}
                    {assign var=t_no_lr_count value=$t_lr_d_count - $t_re_lr_count }
                    {assign var=t_no_amount value=$t_no_d_amount - $t_total_amount }
                    <tr>
                        {if $summary|count}
                            <td align="center">No Return</td>
                            <td align="right">{$t_no_lr_count}</td>
                            <td align="right">{$t_no_amount}</td>
                        {/if}
                    </tr>
                </tbody>
                {assign var=t_tt_amount value=$t_total_amount + $t_no_amount}
                {assign var=t_tt_lr_count value=$t_no_lr_count + $t_re_lr_count}
                {if $summary|count}
                    <tfoot>
                        <tr class="active bold">
                            <td align="right">Total : </td>
                            <td align="right">{$t_tt_lr_count}</td>
                            <td align='right'>{$t_tt_amount|number_format:2}</td>
                        </tr>
                    </tfoot>
                {/if}
            </table>
        </td>
    </tr>
</table>
<br>
<table border="1" class="bordered" width="80%" align="center">
    <thead>
        <tr>
            <th>Collection Details :</th>
            <th colspan="6"></th>
        </tr>
        <tr>
            <th>Mode of Payment</th>
            <th>Total LR</th>
            <th>Total LR Amount (Rs.)</th>
            <th>Payment Received LR</th>
            <th>Payment Received LR Amount (Rs.)</th>
            <th>Pending LR</th>
            <th>Pending LR Amount (Rs.)</th>
        </tr>
    </thead>
    <tbody>
        {assign var=t_total_amount value=0}
        {assign var=t_lr_count value=0}
        {assign var=t_received_lr_count value=0}
        {assign var=t_amount value=0}
        {assign var=t_pending_lr_count value=0}
        {assign var=t_pending_amount value=0}
        {foreach item=row from=$summary key=i}
            {if $row->attribute_type == 'PAYMENT_RECEIVED_LR'}
                <tr>
                    <td align="center">{$row->attribute_code}</td>
                    <td align="right">{$row->lr_count}</td>
                    <td align="right">{$row->total_amount|inr_format}</td>
                    <td align="right">{$row->received_lr_count}</td>
                    <td align="right">{$row->amount|inr_format}</td>
                    <td align="right">{$row->pending_lr_count}</td>
                    <td align="right">{$row->pending_amount}</td>
                </tr>
                {assign var=t_lr_count value=$t_lr_count + $row->lr_count}
                {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
                {assign var=t_received_lr_count value=$t_received_lr_count + $row->received_lr_count}
                {assign var=t_amount value=$t_amount + $row->amount}
                {assign var=t_pending_lr_count value=$t_pending_lr_count + $row->pending_lr_count}
                {assign var=t_pending_amount value=$t_pending_amount + $row->pending_amount}

            {/if}
        {foreachelse}
            <tr>
                <td colspan="7" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
    {if $summary|count}
        <tfoot>
            <tr class="active bold">
                <td align="right">Total : </td>
                <td align="right">{$t_lr_count}</td>
                <td align='right'>{$t_total_amount|number_format:2}</td>
                <td align="right">{$t_received_lr_count}</td>
                <td align="right">{$t_amount|number_format:2}</td>
                <td align="right">{$t_pending_lr_count}</td>
                <td align="right">{$t_pending_amount|number_format:2}</td>
            </tr>
        </tfoot>
    {/if}
</table>

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

    table thead th,
    table thead td {
        font-weight: bold;
    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
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

<script>
    window.print();
</script>