<html>

<head>
    <title>OGPL Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
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

        table {
            border-collapse: collapse;
        }
    </style>
</head>

<body class="border-outline" style="padding: 2px;">
    <table class="border-outline" width="100%" cellpadding="5">
        <tr class="bold">
            <td width="25%">
                &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" colspan="2" style="font-size: 20px;">
                Seenu Transports Pvt.Ltd.<br>
                <span>Godown Report</span><br>
                <span class="bold">Delivery Pending To Customer</span>
            </td>
            <td width="25%"></td>
        </tr>

        {* <tr class="bold">
            <td width="25%">
                From Location : <span></span>
            </td>
            <td align="center">
            </td>
            <td width="25%">
                To Location : <span></span>
            </td>
        </tr> *}

        <tr class="bold">
            <td width="25%" nowrap>
                From LR Date : <span> {$fromDate|date_format}</span>
            </td>
            <td align="center">
            </td>
            <td width="25%">
                To LR Date : <span> {$toDate|date_format:$ns_date_format}</span>
            </td>
        </tr>
    </table>
    <table class="bordered" width="100%" cellpadding="5">
        <thead>
            <tr class="bolder">
                <td>S.No</td>
                <td>LR No.</td>
                <td>From Date</td>
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
        </tr> <br> <br>
        <tfoot>
            <tr class="bold">
                <td align="center" class="bold" colspan="6">Printed By : {$usr_login_name}</td>
                <td align="center" class="bold" colspan="6">Printed At : {$smarty.now|date_format:$ns_datetime_format}</td>
            </tr>
        </tfoot>
    </table>

    <div class="print-footer ">
        <table cellpadding="3" width="100%">

        </table>
    </div>
    {* </table> *}
    <style>
        table {
            width: 100%;
        }
    </style>
    <script>
        window.print();
    </script>
    <style type="text/css" media="print">
        @page {
            size: landscape;
        }

        @media print {
            body {
                -webkit-print-color-adjust: exact !important;
                /* Chrome, Safari */
                color-adjust: exact !important;
                /* Firefox */
            }

            .print-footer {
                position: fixed;
                bottom: 10px;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }
        }
    </style>

</html>