<table cellpadding="20" width="100%">
    <tr>
        {if $namespace == 'seenutransports'}
            <td align="left" width="25%">
                &nbsp;<img src="{$base_url}/assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
        {/if}
        <td align="center" width="50%">
            <h3>Seenu Transports Pvt Ltd.</h3>
            <h2>DIESEL COUPON REPORT</h2>
        </td>
        <td width="25%">
            <table width="100%" style="line-height: 20px;" class="bottom">
                <tr>
                    <td align="left" width="50%" class="bold"> <b>From Date : {$from_date|date_format:$ns_date_format} </b></td>
                </tr>
                <tr>
                    <td align="left" width="50%" class="bold"><b>To Date : {$to_date|date_format:$ns_date_format}</b></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table id="" class="border" style="width:100%" cellpadding="4">
    <thead>
        <tr class="success bold">
            <td align="center">S.No</td>
            <td align="center">DATE</td>
            <td align="center">EVIDENCE NO</td>
            <td align="center">VEHICLE NO</td>
            <td align="center">BUNK NAME</td>
            <td align="center">COUPON NO</td>
            <td align="center">DIESEL LITRES</td>
            <td align="center">DIESEL RATE</td>
            <td align="center">DIESEL AMOUNT</td>
            <td align="center">LOCATION</td>
        </tr>
    </thead>
    <tbody>
        {assign var=t_price_ltr value=0}
        {assign var=t_ltrs value=0}
        {assign var=t_total_amount value=0}
        {foreach item=row from=$result key=i}
            <tr>
                <td align="center">{$i + 1}</td>
                <td align="center" nowrap>{$row->fuel_date|date_format:$ns_date_format}</td>
                <td align="center" nowrap>{$row->alias_code}</td>
                <td align="center" nowrap>{$row->registation_number}</td>
                <td align="center">{$row->fuel_vendor_name}</td>
                <td align="center">{$row->bill_number}</td>
                <td align="center">{$row->litres}</td>
                <td align="center">{$row->price_per_litre}</td>
                <td align="center">{$row->total_amount}</td>
                <td align="center">{$row->organization_name}</td>
            </tr>
            {assign var=t_price_ltr value=$t_price_ltr+$row->price_per_litre}
            {assign var=t_ltrs value=$t_ltrs+$row->litres}
            {assign var=t_total_amount value=$t_total_amount+$row->total_amount}
        {foreachelse}
            <tr>
                <td colspan="10" align="center">No Records Found</td>
            </tr>
        {/foreach}
    </tbody>
    {if $result|count}
        <tr class="bold">
            <td align="right" colspan="6">Total</td>
            <td align="center">{$t_ltrs}</td>
            <td align="center"></td>
            <td align="center">{$t_total_amount|inr_format:2}</td>
            <td align="center"></td>
        </tr>
    {/if}
</table>
<br>
<table id="" class="" style="width:100%">
    <tr>
        <td width="50%">
            <table id="" class="border" style="width:100%">
                <thead>
                    <tr class="success bold">
                        <td align="center">BUNK NAME</td>
                        <td align="center">COUNT</td>
                        <td align="center">AMOUNT</td>
                    </tr>
                </thead>
                <tbody>
                    {assign var=t_bunk_count value=0}
                    {assign var=t_amount value=0}
                    {foreach item=row from=$vendorWise key=i}
                        <tr>
                            <td align="center">{$row['bunk_name']}</td>
                            <td align="center">{$row['bunk_count']}</td>
                            <td align="center">{$row['amount']}</td>
                        </tr>
                        {assign var=t_bunk_count value=$t_bunk_count+$row['bunk_count']}
                        {assign var=t_amount value=$t_amount+$row['amount']}
                    {foreachelse}
                        <tr>
                            <td colspan="3" align="center">No Records Found</td>
                        </tr>
                    {/foreach}
                </tbody>
                {if $vendorWise|count}
                    <tr class="bold">
                        <td align="right">Total</td>
                        <td align="center">{$t_bunk_count}</td>
                        <td align="center">{$t_amount|inr_format:2}</td>
                    </tr>
                {/if}
            </table>
        </td>
        <td width="50%"></td>
    </tr>
</table>

{* <div class="print-footer" id="print-footer">
    <table>
        <tr>
            <td width="35%">Printed On : {$smarty.now|date_format:$ns_datetime_format}</td>
            <td width="25%"> </td>
            <td width="25%"> </td>
            <td width="25%" nowrap>Generated By: {$usr_login_name} </td>

        </tr>
    </table>
</div> *}

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

    .print-footer {
        position: fixed;
        bottom: 4px;
        text-align: center;
        border-top: 1px solid #000000;
    }

    table.border thead td,
    table.border tbody td {
        border: 1px solid #000;
    }

    table thead th,
    table thead td {
        font-weight: bold;
    }

    .bordered {
        border: 1px solid #000;
        border-bottom: none;
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