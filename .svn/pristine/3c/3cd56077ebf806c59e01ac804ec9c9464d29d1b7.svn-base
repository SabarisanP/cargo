<table style="border: 1px solid #000" cellpadding="0" width="100%">
    <tr>
        <td align="left" width="25%">
        </td>
        <td align="center" width="50%">
            <br>
            <h2>{if $branch_name !=="NA"}{$branch_name}{else}ALL{/if} - DOOR DELIVERY - CHART</h2>
        </td>
        <td width="25%">
        </td>
    </tr>
</table>
<br>
<table width="100%" cellpadding="7">
    <tr>
        <td align="left" style="border: 1px solid #000;" width="30%">
            <b> Branch Name : {if $branch_name !=="NA"}{$branch_name}{else}ALL{/if}</b>
        </td>
        <td align="left" width="5%"></td>
        <td align="center" style="border: 1px solid #000;" width="30%">
            <b> Summary :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
        </td>
        <td align="left" width="5%"></td>
        <td align="left" style="border: 1px solid #000;" width="30%">
            <b> DATE : </b>{$user_date|date_format:$ns_date_format}
        </td>
    </tr>
</table>
<br>

<table width="100%" cellpadding="7">
    <tr>
        <td align="left" width="30%" style="vertical-align: text-top;">
            <table border="1" class="bordered" cellpadding="7" width='100%'>
                <thead>
                    <tr>
                        <th>DLVD :- Bill Not Received</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                    {assign var=pending_lrs value=0}
                    {assign var=current_lrs value=0}

                    {foreach item=row from=$summary key=i}
                        {if $row->attribute_type=="PENDING"}
                            <tr>
                                <td align="right">LGO DD Pending {$row->from_organization_short_code}</td>
                                <td align="right">{$row->lr_count}</td>
                            </tr>
                            {assign var=pending_lrs value=$pending_lrs+$row->lr_count}
                        {/if}

                        {if $row->attribute_type=="CURRENT"}
                            {assign var=current_lrs value=$current_lrs+$row->lr_count}
                        {/if}
                    {/foreach}
                </tbody>
                <tr>
                    <td align="right">Current</td>
                    <td align="right">{$current_lrs}</td>
                </tr>
                <tr>
                    <td align="right"><b>Total</b></td>
                    <td align="right">{($current_lrs)+{$pending_lrs}}</td>
                </tr>
            </table>
        </td>
        <td align="left" width="5%"></td>
        <td align="left" width="30%">
            <table border="1" class="bordered" cellpadding="7" width='100%'>
                <thead>
                    <tr>
                        <th>DLVD :- Bill Not Received</th>
                        <th>{$delivery_withOut_bill_rec}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td align="center">LR Received</td>
                        <td align="right">{$delivery_bill_rec}</td>
                    </tr>
                </tbody>

                <tr>
                    <td align="center">Balance</td>
                    <td align="right"></td>
                </tr>
            </table>
            <br>
            <table border="1" class="bordered" cellpadding="7" width='100%'>
                <tbody>
                    <tr>
                        <td align="center">Pending DD</td>
                        <td align="right">{$pending_lrs}</td>
                    </tr>
                    <tr>
                        <td align="center">Current DD</td>
                        <td align="right">{$current_lrs}</td>
                    </tr>
                    <tr>
                        <td align="center"><b>Total</b></td>
                        <td align="right">{($current_lrs)+($pending_lrs)}</td>
                    </tr>
                </tbody>
            </table>
            <br> <br>
            <table border="1" class="bordered" cellpadding="7" width='100%'>
                <tbody>
                    <tr>
                        <td align="center"><b>Delivered</b></td>
                        <td align="right"></td>
                    </tr>
                    <tr>
                        <td align="center">Pending DD</td>
                        <td align="right">{$delivery_pending_lr}</td>
                    </tr>
                    <tr>
                        <td align="center">Current DD</td>
                        <td align="right">{$delivery_current_lr}</td>
                    </tr>
                    <tr>
                        <td align="center"></td>
                        <td align="right"></td>
                    </tr>
                    <tr>
                        <td align="center"><b>Total </b></td>
                        <td align="right">{$delivery_current_lr+$delivery_pending_lr}</td>
                    </tr>
                    <tr>
                        <td align="center"></td>
                        <td align="right"></td>
                    </tr>
                    <tr>
                        <td align="center"><b>Total Pending</b></td>
                        <td align="right">{($current_lrs)+($pending_lrs)-($delivery_current_lr+$delivery_pending_lr)}</td>
                    </tr>
                </tbody>
            </table>
        </td>
        <td align="left" width="5%"></td>
        <td align="left" width="30%">
            <table border="1" class="bordered" cellpadding="7" width='100%' style="border: 1px solid #000;">
                <tr>
                    <th colspan="3">DOOR DELIVERY LR'S SUMMARY</th>
                </tr>
                <tr>
                    <td colspan="2">DLVD - Total LR'S</td>
                    <td>{$delivery_current_lr+$delivery_pending_lr}</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>DLVD :- Bill Not Rec</b></td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>Paid</b></td>
                    <td>{$delivery_paid_lr}</td>
                </tr>
                <tr>
                    <td><b>To-Pay</b></td>
                    <td>{$delivery_topay_lr}</td>
                </tr>
                <tr>
                    <td><b>TBB</b></td>
                    <td>{$delivery_onaccount_lr}</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>GRAND TOTAL</b></td>
                    <td>{$delivery_paid_lr+$delivery_topay_lr+$delivery_onaccount_lr}</td>
                </tr>
            </table>
            <br>
            <table border="1" class="bordered" cellpadding="7" width='100%' style="border: 1px solid #000;">
                <tr>
                    <td colspan="2"><b>Total - To-Pay LR'S</b></td>
                    <td>{$delivery_topay_lr}</td>
                </tr>
                <tr>
                    <td><b>Payment Received</b></td>
                    <td>{$delivery_payment_rec}</td>
                </tr>
                <tr>
                    <td><b>Account Party</b></td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>Single Party</b></td>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<script>
    window.print();
</script>

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