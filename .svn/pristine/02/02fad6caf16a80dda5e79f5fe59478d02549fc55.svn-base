<table width="100%" style="font-family: Times New Roman;">
    <tr>
        <td colspan="10" align="center"><b>Diesel Coupon Report</b></td>
    </tr>
    <tr>
        <td colspan="3"><b>From {$from_date|date_format:$ns_date_format} &nbsp; To {$to_date|date_format:$ns_date_format} </b></td>
        <td colspan="4" align="right"><b>Report Date/Time : {date("d-m-Y h:i A")}</b></td>
    </tr>
</table>
<br>
<table width="100%" style="font-family: Times New Roman;" border="1">
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
    <tbody class="body_table">
        {assign var=t_price_ltr value=0}
        {assign var=t_ltrs value=0}
        {assign var=t_total_amount value=0}
        {foreach item=row from=$result key=i}
            <tr>
                <td align="center">{$i + 1}</td>
                <td align="center">{$row->fuel_date|date_format:$ns_date_format}</td>
                <td align="center">{$row->alias_code}</td>
                <td align="center">{$row->registation_number}</td>
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
        <tfoot>
            <tr class="bold">
                <td align="right" colspan="6">Total</td>
                <td align="center">{$t_ltrs}</td>
                <td align="center"></td>
                <td align="center">{$t_total_amount|inr_format:2}</td>
                <td align="center"></td>
            </tr>
        </tfoot>
    {/if}
</table>
<br>
<table id="" class="" style="width:100%" border="1">
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