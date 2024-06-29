<table width="100%" style="font-family: Times New Roman;">
    <tr>
        <td colspan="10" align="center"><b>Godown Report</b></td>
    </tr>
    <tr>
        <td colspan="5"></td>
        <td colspan="5" align="right"><b>Report Date/Time : {date("d-m-Y h:i A")}</b></td>
    </tr>
</table>
<br>
<table border="1">
    <thead>
        <tr style="background-color:#92d050; color: #0000; font-weight: bold;">
            <td>S.No</td>
            <td>LR No.</td>
            <td>LR Date</td>
            <td>From Party</td>
            <td>To Party</td>
            <td>From Location</td>
            <td>To Location</td>
            <td>Mode Of Payment</td>
            <td>Article</td>
            <td>LR Amount</td>
            <td>Informed</td>
            <td>Remark</td>
        </tr>
    </thead>
    <tbody>
        {assign var="branch_rpt_sno" value=0}
        {assign var="branch_t_amt" value=0}
        {assign var="branch_t_count" value=0}
        {foreach $result as $val}
            {assign var="branch_rpt_sno" value=$branch_rpt_sno+1}
            <tr>
                <td align="center">{$branch_rpt_sno}</td>
                <td nowrap>{$val->cargo_code}</td>
                <td nowrap>{$val->booked_at|date_format:$ns_date_format}</td>
                <td>{$val->from_customer_name}</td>
                <td>{$val->to_customer_name}</td>
                <td>{$val->from_organization_name}</td>
                <td>{$val->to_organization_name}</td>
                <td align="center">{$cargo_payment_status[$val->payment_type_code]}</td>
                <td align="center">{$val->total_item_count}</td>
                <td>{$val->total_amount|number_format:2}</td>
                <td>{$val->delivery_contact_person}</td>
                <td>{$val->delivery_contact_remark}</td>
                {assign var="branch_t_amt" value=$branch_t_amt+$val->total_amount}
                {assign var="branch_t_count" value=$branch_t_count+$val->total_item_count}
            </tr>
        {/foreach}
    </tbody>
    <tr class="bold">
        <td nowrap align="right" colspan="8">Total</td>
        <td nowrap align="center">{$branch_t_count}</td>
        <td nowrap align="center">{$branch_t_amt|number_format:2}</td>
        <td></td>
        <td></td>
    </tr>
</table>