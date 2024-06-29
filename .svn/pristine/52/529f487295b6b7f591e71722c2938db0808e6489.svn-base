<style>
    .bold {
        font-weight: bold;
    }

    .bordered,
    .bordered tr th,
    .bordered tr td {
        border: 1px solid #000000;
    }

    .title {
        font-weight: bold;
        text-align: center;
    }

    .bold {
        font-weight: bold;
    }

    .bolder {
        font-weight: 900;
    }

    .border-top {
        border-top: 1px solid #000;
    }

    .bordered td {
        border: 1px solid #000;
    }

    .border-bottom {
        border-bottom: 1px solid #000;
    }

    .dotted-border-bottom {
        border-bottom: 1px dashed #000;
    }

    .border-outline {
        border: 1px solid #000;
    }
</style>




<table style="border: 1px solid #000" cellpadding="5" width="100%">
    <tr>
        <td align="left" width="25%">
            &nbsp;<img src="{$base_url}/assets/img/seenutransports-logo.png" alt="logo" width="150px">
        </td>
        <td align="center" width="50%">
            <h2 style="font-size: 16px;"> Seenu Transports Pvt.Ltd. </h2>
            <span>{$organizationDetails[0]->address1},{$organizationDetails[0]->address2}</span>
            <h2 style="font-size: 14px;"> LR Transfer Report</h2>
        </td>
        <td width="25%">
        </td>
    </tr>
</table>

<table style="border: 1px solid #000" cellpadding="5" width="100%">
    <tr>
        <td align="left">Lr Transfer No : {$transitCode}</td>
        <td align="left">Lr Transfer Date : {$result[0]->loaded_at|date_format:$ns_date_format}</td>
        <td align="left">Time Chart Id :</td>
    </tr>
    <tr>
        <td align="left">From Fleet Type : {$result[0]->vehicle_type}</td>
        <td align="left">From Fleet No : {$result[0]->vehicle_number}</td>
        <td align="left">From Fleet Name : {$result[0]->vehicle_name}</td>
    </tr>
    <tr>
        <td align="left">To Fleet Type : {$result[0]->transfer_vehicle_type}</td>
        <td align="left">To Fleet No : {$result[0]->transfer_vehicle_number}</td>
        <td align="left">To Fleet Name : {$result[0]->transfer_driver_name}</td>
    </tr>
    <tr>
        <td align="left">From Branch : {$result[0]->from_organization_name}</td>
        <td align="left">To Branch : {$result[0]->to_organization_name}</td>
        <td align="left"></td>
    </tr>
    <tr>
        <td align="left">Driver Type : {$result[0]->ownership_type}</td> 
        <td align="left">Driver Code : {$result[0]->driver_code}</td>
        <td align="left">Driver Name : {$result[0]->driver_name}</td>
    </tr>
</table>

<table border="1" class="bordered" cellpadding="5" width="100%">
    <thead>
        <tr class="bold">
            <th nowrap>S.No</th>
            <th nowrap >GCN No</th>
            <th nowrap >GCN Date</th>
            <th nowrap >luggage List No</th>
            <th nowrap >Consigner Name</th>
            <th nowrap >Consignee Name</th>
            <th nowrap >From Location</th>
            <th nowrap >To Location</th>
            <th nowrap >Mode Of Payment</th>
            <th nowrap >No Of Packages</th>
            <th nowrap>Amount</th>
        </tr>
    </thead>
    <tbody>
        {assign var=sno value=0}
        {assign var=t_lr_amt value=0}
        {assign var=t_item_count value=0}
        {foreach item=val from=$result key=i}
            {assign var=sno value=$sno+1}
            {assign var=t_lr_amt value=$t_lr_amt+$val->total_amount}
            {assign var=t_item_count value=$t_item_count+$val->total_item_count}
            <tr>
                <td align="center" nowrap>{$sno}</td>
                <td align="center" nowrap>{$val->cargo_code}</td>
                <td align="center" nowrap>{$val->booked_at|date_format:$ns_date_format}</td>
                <td align="center" nowrap>{$val->alias_code}</td>
                <td align="center" nowrap>{$val->cargo_from_customer_name}</td>
                <td align="center" nowrap>{$val->cargo_to_customer_name}</td>
                <td align="center" nowrap>{$val->cargo_from_organization_name}</td>
                <td align="center" nowrap>{$val->cargo_to_organization_name}</td>
                <td align="center" nowrap>{$cargo_payment_status[$val->payment_type_code]}</td>
                <td align="center" nowrap>{$val->total_item_count}</td>
                <td align="center" nowrap>{$val->total_amount|number_format:2}</td>
            </tr>
        {/foreach}
        {if count($result) >0}
            <tr class="bold" style="font-weight: bold;">
                <td align="right" colspan="9">Total</td>
                <td align="center">{$t_item_count}</td>
                <td align="center">{$t_lr_amt|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>
<br><br>
<table>
    <tr>
        <td width="30%"></td>
        <td width="50%">
            <br> <br>
            <table border="1" class="bordered" cellpadding="5" width="100%">
                <thead>
                    <tr>
                        <td align="center" class="bold"> &nbsp;Payment Details &nbsp;</td>
                        <td align="center" class="bold" colspan="2"></td>
                    </tr>
                    <tr>
                        <td align="center" class="bold" nowrap> &nbsp;Mode Of Payment &nbsp;</td>
                        <td align="center" class="bold" nowrap> &nbsp;No Of GCN &nbsp;</td>
                        <td align="center" class="bold" nowrap> &nbsp;Amount (RS.) &nbsp;</td>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {assign var=t_payable value=0}
                    {foreach item=row from=$paymentWise}
                        <tr>
                            <td align="center">{$cargo_payment_status[$row['code']]}</td>
                            <td align="center">{$row['cargo_Count']}</td>
                            <td align="center">{$row['amount']|number_format:2}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
        <td width="30%"></td>
    </tr>
</table>