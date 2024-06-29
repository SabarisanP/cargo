<style>
    .bordered td, .bordered th { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #000; }
    .border-outline { border: 1px solid #000; }
    .border-left { border-left: 1px solid #000; }
    .border-top { border-top: 1px solid #000; }
    .border-right { border-right: 1px solid #000;}
    .border-bottom { border-bottom: 1px solid #000; }
</style>
<br><br>
<table style="padding: 4px 0;border: 1px solid #000;">
    {foreach item=row from=$vendors}
        {if $row->code == ($details->user->username|upper)}
            {assign var="companyName" value=$row->companyName}
            {assign var="gst" value=$row->gst}
            {assign var="address1" value=$row->vendorAddress->address1}
            {assign var="address2" value=$row->vendorAddress->address2}
            {assign var="pincode" value=$row->vendorAddress->pincode}
            {assign var="landmark" value=$row->vendorAddress->landmark}
            {break}
        {/if}
    {/foreach}

    {assign var=total value=0}
    {assign var=total_lr value=0}
    {assign var=total_qty value=0}
    {assign var=inv_per value=''}
    {foreach item=row key=k from=$result}
        {assign var=total value=$total+($row->transaction_amount-$row->commission_amount)}
        {assign var=total_lr value=$k+1}
        {assign var=total_qty value=$total_qty+($row->total_item_count)}
    {/foreach}

    {if $total_lr >0}
        {$start = $result[0]->booked_at}
        {$end = $result[$total_lr-1]->booked_at}

       {$months = array()}
       {$years = array()}

        {while (strtotime($start) <= strtotime($end))}
            {$months[] = array('month' => date('M', strtotime($start)))}
            {$start = date('01 M Y', strtotime( "+1 month", strtotime($start)))}
        {/while}

        {$start_year = date("Y",strtotime($start))}
        {$end_year = date("Y",strtotime($end))}

        {while ($start_year <= $end_year)}
            {$years[] = array('year' => $start_year)}
            {$start_year = $start_year + 1}
        {/while}
    {/if}

    <tr>
        <td width="100%" align="center">
            &nbsp;<img src="assets/img/vijayalakshmi-invoice-header.png" alt="logo" width="450">
        </td>
    </tr>

    <tr>
        <td width="100%" align="center" class="border-top" ><b>STATEMENT CUM INVOICE</b></td>
    </tr>

    <tr>
        <td width="50%" class="border-right border-top">
            <table width="100%">
                <tr>
                    <td width="25%" align="right"><b>Cust. Name</b></td>
                    <td width="5%"><b> : </b></td>
                    <td width="70%" align="left"><b> {$companyName|ucwords}</b></td>
                </tr>
                <tr>
                    <td width="25%" align="right"><b>Address</b></td>
                    <td width="5%"><b> : </b></td>
                    <td width="70%" align="left"><b> {$address1}{if $address1},<br>{/if}{$landmark}{if $landmark},<br>{/if}{$address2}{if $address2} - {/if}{$pincode}</b></td>
                </tr>
                <tr>
                    <td width="25%" align="right"><b>GST NO</b></td>
                    <td width="5%"><b> : </b></td>
                    <td width="70%" align="left"><b> {$gst}</b></td>
                </tr>
            </table>
        </td>

        <td width="50%" class="border-top">
            <table width="100%">
                <tr>
                    <td width="25%"><b>Invoice No</b></td>
                    <td width="5"><b> : </b></td>
                    <td align="left" width="70%"><b> {$details->code}</b></td>
                </tr>
                <tr>
                    <td width="25%"><b>Invoice Date</b></td>
                    <td width="5"><b> : </b></td>
                    <td align="left" width="70%"><b> {date("d M Y", strtotime($details->transactionDate))}</b></td>
                </tr>
                <tr>
                    <td width="25%"><b>Invoice Period</b></td>
                    <td width="5"><b> : </b></td>
                    <td align="left" width="70%"> <b>{foreach from=$months item=val key=key}{$val['month']}{if count($months)-1 != $key},{else}-{/if}{/foreach}
                        {foreach from=$years item=val key=key}{$val['year']}{if count($years)-1 != $key},{/if}{/foreach}</b>
                    </td>
                </tr>
                {* <tr>
                    <td><b>State</b></td>
                    <td><b>:</b></td>
                    <td><b>{$details->code}</b></td>
                </tr>
                <tr>
                    <td><b>State Code</b></td>
                    <td><b>:</b></td>
                    <td><b>{$details->code}</b></td>
                </tr>
                <tr>
                    <td><b>PAN NO</b></td>
                    <td><b>:</b></td>
                    <td><b>{$details->code}</b></td>
                </tr> *}
            </table>
        </td>
    </tr>
</table>
<table width="100%" class="bordered border-outline">
    <tr style="font-weight:bold; background-color: #E8E8E8;">
        <th width="12%">Date</th>
        <th width="12%">LR NO</th>
        <th width="15%">From</th>
        <th width="15%">Sender</th>
        <th width="15%">To (Delivery)</th>
        <th width="14%">Receiver</th>
        <th width="5%">Qty</th>
        <th width="12%">Amount</th>
    </tr>
    <tbody class="body_table">
    {foreach item=row key=k from=$result}
        {assign var="unit_values" value=explode(',', $row->unit_value)}
        {$units = array()}
        {$wt = 0}

        {foreach from=$unit_values item=unit_value}
            {$unit_value = explode('-', $unit_value)}
            {$units[] = $unit_value}
        {/foreach}

        {foreach from=$units item=val}
            {$wt = $wt + $val[1]}
        {/foreach}

        <tr>
            <td>{$row->booked_at|date_format:$ns_date_format}</td>
            <td>{$row->cargo_code}</td>
            <td>{$row->from_organization_name}</td>
            <td>{$row->from_customer_name}</td>
            <td>{$row->to_organization_name}</td>
            <td>{$row->to_customer_name}</td>
            <td>{$wt|sigma:$tot_qty}</td>
            <td>{($row->transaction_amount-$row->commission_amount)|inr_format}</td>
        </tr>
    {/foreach}
    <tr>
        <td colspan="5"></td>
        <td>Total</td>
        <td>{$tot_qty}</td>
        <td>{$total|inr_format}</td>
    </tr>
    </tbody>
</table>
<table width="100%" class="border-outline" style="padding:3px;">
    <tr>
        <td width="100%"  align="center"><b>{$total|amount_in_words|ucwords}</b></td>
    </tr>
</table>