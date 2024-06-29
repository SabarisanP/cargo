<table border="1">
    <tr>
        <td  colspan="10" align="center"><b>Branch Date Wise Transaction Report</b></td>
    </tr>
    <tr>
        <td colspan="5"><b>Date :</b> {$from_date|date_format:$ns_date_format} to {$to_date|date_format:$ns_date_format}</td>
        <td colspan="5" align="right"><b>Report Date/Time :</b> {date("d-m-Y h:i A")}</td>
    </tr>
</table>

<table border="1">
    <thead>
        <tr class="success">
            <td rowspan="3">S No</td>
            <td rowspan="3">Branch</td>

            {foreach item=dte from=$date_range}
                <td colspan="12" align="center" nowrap>{date("d-m-Y", strtotime($dte))}</td>
            {/foreach}
        </tr>
        <tr class="success">
            {foreach item=dte from=$date_range}
                <td align="center" colspan="4">Paid</td>
                <td align="center" colspan="4">Topay</td>
                <td align="center" colspan="4">On Account</td>
            {/foreach}
        </tr>
        <tr class="success">
            {foreach item=dte from=$date_range}
                <td colspan="2">Freight Amount</td>
                <td colspan="2">Other Charges</td>
                <td colspan="2">Freight Amount</td>
                <td colspan="2">Other Charges</td>
                <td colspan="2">Freight Amount</td>
                <td colspan="2">Other Charges</td>
            {/foreach}
        </tr>
    </thead>
    <tbody class="body_table">
        {$key = 1}
        {foreach item=row from=$list_data key=t}
            <tr id="{$t}">
                <td>{$key}</td>
                <td>{$row['org_name']|ucwords}</td>

                {foreach item=dte from=$date_range}
                    <td align='right' colspan="2" data-format="{$xlformat['currency']}">{$row[$dte]['paid']|default:'0.00'}</td>
                    <td align='right' colspan="2" data-format="{$xlformat['currency']}">{$row[$dte]['paid_other']|default:'0.00'}</td>
                    
                    <td align='right' colspan="2" data-format="{$xlformat['currency']}">{$row[$dte]['topay']|default:'0.00'}</td>
                    <td align='right' colspan="2" data-format="{$xlformat['currency']}">{$row[$dte]['topay_other']|default:'0.00'}</td>
                    
                    <td align='right' colspan="2" data-format="{$xlformat['currency']}">{$row[$dte]['onacc']|default:'0.00'}</td>
                    <td align='right' colspan="2" data-format="{$xlformat['currency']}">{$row[$dte]['onacc_other']|default:'0.00'}</td>
                {/foreach}
            </tr>
            {$key = $key+1}
        {foreachelse}
            <tr>
                <td colspan="2" align="center">No data found</td>
            </tr>
        {/foreach}
    </tbody>
</table>
