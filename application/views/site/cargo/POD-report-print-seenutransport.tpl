{if $namespace =="seenutransports"}
    <table style="border: 1px solid #000" cellpadding="2" width="100%">
        <tr>
            <td align="center" width="25%">
                &nbsp;<img src="{$base_url}/assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" width="50%">
                <h1>Seenu Transports Pvt Ltd</h1>
                <p>{$userBranchAddress->address1} ,{$userBranchAddress->address2} , Phone : {$userBranchAddress->contact}</p>
                {if $filterType =="WI_POD"}
                    <h3>POD Summary Report</h3>
                {else if $filterType =="WO_OTP_POD"}
                    <h3> Delivered without POD Report </h3>
                {else}
                    <h3>Delivery Report</h3>
                {/if}
            </td>
            <td width="25%">
                <table width="100%" style="line-height: 20px;">
                    <tr>
                        <td align="right" width="50%" class="bold">{lang('lr')} From Date</td>
                        <td width="50%">&nbsp;<b>:</b> {$fromDate|date_format:$ns_date_format}</td>
                    </tr>
                    <tr>
                        <td align="right" width="50%" class="bold">{lang('lr')} To Date</td>
                        <td width="50%">&nbsp;<b>:</b> {$toDate|date_format:$ns_date_format}</td>
                    </tr>
                    {if $action_rights['CGO-VIEW-SAME-BRNCH-LR']==1}
                        <tr>
                            <td align="left" width="100%" colspan="2" class="bold">BRANCH <b>:</b> {$login_branch_name}</td>
                        </tr>
                    {else}
                        <tr>
                            <td align="left" width="100%" colspan="2" class="bold">BRANCH <b>:</b> {$userBranch|default:'ALL'}</td>
                        </tr>
                    {/if}
                </table>
            </td>
        </tr>

        <tr></tr>
    </table>
{else}
    <table style="border: 1px solid #000" cellpadding="2" width="100%">
        <tr>
            <td align="center" width="25%">

            </td>
            <td align="center" width="50%">
                <h1>{$namespace_name}</h1>
                <h3>Delivery Report</h3>
            </td>
            <td width="25%">
                <table width="100%" style="line-height: 20px;">
                    <tr>
                        <td align="right" width="50%" class="bold">{lang('lr')} From Date</td>
                        <td width="50%">&nbsp;<b>:</b> {$fromDate|date_format:$ns_date_format}</td>
                    </tr>
                    <tr>
                        <td align="right" width="50%" class="bold">{lang('lr')} To Date</td>
                        <td width="50%">&nbsp;<b>:</b> {$toDate|date_format:$ns_date_format}</td>
                    </tr>
                    {if $action_rights['CGO-VIEW-SAME-BRNCH-LR']==1}
                        <tr>
                            <td align="left" width="100%" colspan="2" class="bold">BRANCH <b>:</b> {$login_branch_name}</td>
                        </tr>
                    {else}
                        <tr>
                            <td align="left" width="100%" colspan="2" class="bold">BRANCH <b>:</b> {$userBranch|default:'ALL'}</td>
                        </tr>
                    {/if}
                </table>
            </td>
        </tr>

        <tr></tr>
    </table>
{/if}

<table border="1" cellpadding="2" width="100%">
    <thead>
        <tr>
            <td align="center">S.No</td>
            <td align="center">GCN Date</td>
            <td align="center">Delivered Date</td>
            <td align="center">POD Status</td>
            <td align="center">Branch Name</td>
            <td align="center">GCN No.</td>
            <td align="center">Consignor Name</td>
            <td align="center">Consignee Name</td>
            <td align="center">From Location</td>
            <td align="center">To Location</td>
            <td align="center">Total GCN Amount(Rs.)</td>
            <td align="center">Payment Type</td>
        </tr>
    </thead>
    <tbody>
        {assign var=tot_lr_count value=0}
        {assign var=tot_item_count value=0}
        {assign var=tot_fare value=0}
        {assign var=tot_handling value=0}
        {assign var=tot_payable value=0}
        {assign var=tot_paid value=0}
        {assign var=tot_topay value=0}
        {assign var=tot_items value=0}
        {assign var=tot_commission value=0}
        {assign var=s_no value=1}
        {assign var=index value=0}

        {foreach item=row from=$result key=t}
            {if $row->cargo_status_code!='CA' && $row->cargo_status_code!='CR'}
                {if $index % 9 == 0}
                    <tr class="page-break"></tr>
                {/if}
                <tr>
                    <td align="center">{$s_no}</td>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                    <td align="left" nowrap>
                        {if $row->delivered_at}
                            {$row->delivered_at|date_format:$ns_date_format}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="center" nowrap>{$row->cargo_code}</td>
                    <td align="left">{$row->from_customer_name}<br>{$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name}<br>{$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="right" nowrap>
                        {($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount)|inr_format}
                    </td>
                    <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                </tr>
                {assign var=index value=$index+1}
                {assign var=s_no value=$s_no+1}
                {assign var=tot_lr_count value=$tot_lr_count+1}
                {assign var=tot_item_count value=$tot_item_count+$row->item_count}
                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_handling value=$tot_handling+$row->total_handling_amount}
                {assign var=tot_payable value=$tot_payable+$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->other_charges_amount}
                {assign var=tot_paid value=$tot_paid+$row->transaction_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
                {assign var=t_other_tot_amount value=$t_other_tot_amount + $row->service_charge + $row->other_charges_amount}

                {assign var=tot_commission value=$tot_commission+$row->commission_amount}
            {/if}
        {/foreach}

    </tbody>
</table>

<div class="print-footer" id="print-footer">
    <table>
        <tr>
            <td width="35%">Printed On : {$smarty.now|date_format:$ns_datetime_format}</td>
            <td width="25%">Printed By: {$usr_login_name} </td>
        </tr>
    </table>
</div>
<style>
    .print-footer {
        position: fixed;
        bottom: 0;
        width: 100%;
        text-align: center;
        font-size: 10px;
        color: #333;
    }

    .bold {
        font-weight: bold;
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

    .page-break {
        page-break-before: always;
    }

    table{
        font-size: 12px;
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