<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><b>Diesel Coupon Report</b></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Date :</span>{$from_date|date_format:$ns_date_format} To {$to_date|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
<br>
<table id="" class="" style="width:100%">
    <tr>
        <td width="50%">
            <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
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
                            <td align="center">{$row['amount']|inr_format:2}</td>
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
                    <tfoot>
                        <tr class="bold">
                            <td align="right">Total</td>
                            <td align="center">{$t_bunk_count}</td>
                            <td align="center">{$t_amount|inr_format:2}</td>
                        </tr>
                    </tfoot>
                {/if}
            </table>
        </td>
        <td width="50%"></td>
    </tr>
</table>
<div class="overflow-x-auto">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
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
                    <td align="center">{$row->total_amount|inr_format:2}</td>
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
</div>