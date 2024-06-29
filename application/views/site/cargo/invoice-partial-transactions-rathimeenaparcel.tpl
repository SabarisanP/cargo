<br><br>
<table style="padding:10px 10px;border: 1px solid #000;">
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
        <td colspan="6" align="center" style="font-weight:bold;font-size: 12px;">
            Invoice
        </td>
    </tr>

    <tr>
        <td width="17%"><b>Account</b></td>
        <td width="5%"><b>:</b></td>
        <td width="28%">RMT CREDIT</td>
        <td width="18%"><b>Invoice Description</b></td>
        <td width="5%"><b>:</b></td>
        <td width="27%">RCM INVOICE</td>
    </tr>
    <tr>
        <td><b>Supplier Name</b></td>
        <td><b>:</b></td>
        <td><b>{$ns_profile->name}</b></td>
        <td><b>Customer Name</b></td>
        <td><b>:</b></td>
        <td><b>{$companyName|ucwords}</b></td>
    </tr>
    <tr>
        <td><b>Supplier Address</b></td>
        <td><b>:</b></td>
        <td>{$nsprofile->address},{$nsprofile->city},<br/>{$nsprofile->state->name}-{$nsprofile->pincode}.</td>
        <td><b>Customer Address</b></td>
        <td><b>:</b></td>
        <td>{$address1}{if $address1},<br>{/if}{$landmark}{if $landmark},<br>{/if}{$address2}{if $address2} - {/if}{$pincode}</td>
    </tr>
    <tr>
        <td><b>GST No</b></td>
        <td><b>:</b></td>
        <td><b>33AYBPSO126Q3Z8</b></td>
        <td><b>GST No</b></td>
        <td><b>:</b></td>
        <td><b>{$gst}</b></td>
    </tr>
    <tr>
        <td><b>SAC CODE</b></td>
        <td><b>:</b></td>
        <td><b>996511</b></td>
        <td><b>Invoice Number</b></td>
        <td><b>:</b></td>
        <td><b>{$details->code}</b></td>
    </tr>
    <tr>
        <td><b>TAXABLE</b></td>
        <td><b>:</b></td>
        <td>Tax Payable Under RCM</td>
        <td><b>Invoice Period</b></td>
        <td><b>:</b></td>
        <td>{foreach from=$months item=val key=key}{$val['month']}{if count($months)-1 != $key},{else}-{/if}{/foreach}

            {foreach from=$years item=val key=key}{$val['year']}{if count($years)-1 != $key},{/if}{/foreach}
        </td>
    </tr>
    <tr>
        <td><b>Amount In Words</b></td>
        <td><b>:</b></td>
        <td>{$total|amount_in_words|ucwords}</td>
        <td><b>Invoice Date</b></td>
        <td><b>:</b></td>
        <td>{date("d M Y", strtotime($details->transactionDate))}</td>
        {* <td>{$details->transactionDate|date_format:$ns_date_format}</td> *}
    </tr>
    <tr>
        <td><b>Payment</b></td>
        <td><b>:</b></td>
        <td>Cheque/DD in favour of '<b> Rathimeena Speed Parcel Service </b>' Only.</td>
        <td><b>Total Consignment</b></td>
        <td><b>:</b></td>
        <td>{$total_lr}</td>
    </tr>
    <tr>
        <td colspan="3" rowspan="2" style="line-height: 15px;"><b>Bank A/C Details :</b><br><b>Name : Rathimeena Speed Parcel Service</b><br><b>A/C No : 004109000051421</b><br><b>Branch : KUMBAKONAM MAIN</b><br><b>IFSC : CIUB0000004</b><br></td>
        <td><b>Total Qty</b></td>
        <td><b>:</b></td>
        <td>{$total_qty}</td>
    </tr>
    <tr>
        <td><b>Invoice Amount</b></td>
        <td><b>:</b></td>
        <td><b>Rs. {$total|inr_format}/-</b></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        {* <td></td> *}
        <td align="left" colspan="3">For <b>RATHIMEENA SPEED PARCEL SERVICE</b></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td align="left" colspan="2"><br>Authorized Signatory</td>
    </tr>
</table>

{strip}
    <table style="padding:5px 0px;page-break-before: always;">
        <tr>
            <td align="center" style="font-weight:bold;font-size: 12px;">
                Consignment Details
            </td>
        </tr>
    </table>
{/strip}
<br/>

{$box_rate = 0}
{$wt = 0}
{foreach item=row key=k from=$result}
    {assign var="unit_values" value=explode(',', $row->unit_value)}
    {$units = array()}
    
    {foreach from=$unit_values item=unit_value}
        {$unit_value = explode('-', $unit_value)}
        {$units[] = $unit_value}
    {/foreach}
    {foreach from=$units item=val}
        {* {print_r($units[0][0])} *}
        {if trim($units[0][0]) == 'NPPKG'}
            {$box_rate = $row->total_amount}
            {break}
        {else}
            {if trim($val[0]) != 'NPPKG'}
                {$wt = $wt + $val[1]}
            {/if}
        {/if}
    {/foreach}
{* {foreachelse}
    {$wt = 1} *}
{/foreach}


{if $wt > 0}
    <table style="padding:5px 4px;" align="center">
        <thead>
            <tr style="font-weight:bold; background-color: #E8E8E8;">
                <th align="center" width="5%" style="border: 1px solid #000000;">S.No</th>
                <th align="center" width="10%" style="border: 1px solid #000000;">Date</th>
                <th align="center" width="15%" style="border: 1px solid #000000;">{lang('lr')} No</th>
                <th align="center" width="20%" style="border: 1px solid #000000;">Receiver Name</th>
                <th align="center" width="15%" style="border: 1px solid #000000;">To</th>
                <th align="center" width="5%" style="border: 1px solid #000000;">Qty</th>
                <th align="center" width="15%" style="border: 1px solid #000000;">Weight</th>
                {* <th align="center" style="border: 1px solid #000000;">Box Rate</th> *}
                <th align="center" width="15%" style="border: 1px solid #000000;">Amount</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=total value=0}
            {assign var=total_lr value=0}
            {assign var=total_qty value=0}
            {$cnt = 1}
            {foreach item=row key=k from=$result}
                {assign var="unit_values" value=explode(',', $row->unit_value)}
                {$units = array()}
                {$bx_rte = 0}
                {$weight = 0}
                {foreach from=$unit_values item=unit_value}
                    {$unit_value = explode('-', $unit_value)}
                    {$units[] = $unit_value}
                {/foreach}
                {foreach from=$units item=val}
                    {if trim($units[0][0]) == 'NPPKG'}
                        {$bx_rte = $row->total_amount}
                        {break}
                    {else}
                        {if trim($val[0]) != 'NPPKG'}
                            {$weight = $weight + $val[1]}
                        {/if}
                    {/if}
                {/foreach}
                {if $weight > 0}
                    <tr>
                        <td align="center" width="5%" style="border: 1px solid #000000;">{$cnt}</td>
                        <td align="center" width="10%" style="border: 1px solid #000000;">{$row->booked_at|date_format:$ns_date_format}</td>
                        <td align="left" width="15%" style="border: 1px solid #000000;">{$row->cargo_code}</td>
                        <td align="left" width="20%" style="border: 1px solid #000000;">{$row->to_customer_name}</td>
                        <td align="left" width="15%" style="border: 1px solid #000000;">{$row->to_organization_name}</td>
                        <td align="center" width="5%" style="border: 1px solid #000000;">{$row->total_item_count}</td>
                        <td align="center" width="15%" style="border: 1px solid #000000;">{$weight}</td>
                        {* <td align="center" style="border: 1px solid #000000;">{$box_rate}</td> *}
                        <td align="right" width="15%" style="border: 1px solid #000000;">{($row->transaction_amount-$row->commission_amount)|number_format:2}</td>
                    </tr>
                    {assign var=total value=$total+($row->transaction_amount-$row->commission_amount)}
                    {* {assign var=total_lr value=$k+1} *}
                    {assign var=total_qty value=$total_qty+($row->total_item_count)}
                    {$cnt = $cnt +1}
                {/if}
            {foreachelse}
                <tr>
                    <td colspan="8" align="center" style="border: 1px solid #000000;">No Records Found!</td>
                </tr>
            {/foreach}
            {if $result|count}
                <tr style="font-weight:bold;">
                    <td align="right" colspan="2" style="border-left: 1px solid #000000;border-bottom: 1px solid #000000;">Total Consignment</td>
                    <td align="left" style="border-bottom: 1px solid #000000;">{$cnt-1}</td>
                    <td align="right" colspan="2" style="border-bottom: 1px solid #000000;">Total Quantity</td>
                    <td align="left" style="border-bottom: 1px solid #000000;">{$total_qty}</td>
                    <td align="right" style="border-bottom: 1px solid #000000;">Total Amount</td>
                    <td align="left" style="border-bottom: 1px solid #000000;border-right: 1px solid #000000;">{$total|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
{/if}
<div></div>

{if $box_rate > 0}
    <table style="padding:5px 4px;" align="center">
        <thead>
            <tr style="font-weight:bold; background-color: #E8E8E8;">
                <th align="center" width="5%" style="border: 1px solid #000000;">S.No</th>
                <th align="center" width="15%" style="border: 1px solid #000000;">Date</th>
                <th align="center" width="15%" style="border: 1px solid #000000;">{lang('lr')} No</th>
                <th align="center" width="20%" style="border: 1px solid #000000;">Receiver Name</th>
                <th align="center" width="20%" style="border: 1px solid #000000;">To</th>
                <th align="center" width="5%" style="border: 1px solid #000000;">Qty</th>
                {* <th align="center" style="border: 1px solid #000000;">Weight</th> *}
                {* <th align="center" width="15%" style="border: 1px solid #000000;">Box Rate</th> *}
                <th align="center" width="20%" style="border: 1px solid #000000;">Amount</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=total value=0}
            {assign var=total_lr value=0}
            {assign var=total_qty value=0}
            {$cnt = 1}
            {foreach item=row key=k from=$result}
                {assign var="unit_values" value=explode(',', $row->unit_value)}
                {$units = array()}
                {$bx_rte = 0}
                {$weight = 0}
                {foreach from=$unit_values item=unit_value}
                    {$unit_value = explode('-', $unit_value)}
                    {$units[] = $unit_value}
                {/foreach}
                {foreach from=$units item=val}
                    {if trim($units[0][0]) == 'NPPKG'}
                        {$bx_rte = $row->total_amount}
                        {break}
                    {else}
                        {if trim($val[0]) != 'NPPKG'}
                            {$weight = $weight + $val[1]}
                        {/if}
                    {/if}
                {/foreach}
                {if $bx_rte > 0}
                    <tr>
                        <td align="center" width="5%" style="border: 1px solid #000000;">{$cnt}</td>
                        <td align="center" width="15%" style="border: 1px solid #000000;">{$row->booked_at|date_format:$ns_date_format}</td>
                        <td align="left" width="15%" style="border: 1px solid #000000;">{$row->cargo_code}</td>
                        <td align="left" width="20%" style="border: 1px solid #000000;">{$row->to_customer_name}</td>
                        <td align="left" width="20%" style="border: 1px solid #000000;">{$row->to_organization_name}</td>
                        <td align="center" width="5%" style="border: 1px solid #000000;">{$row->total_item_count}</td>
                        {* <td align="center" style="border: 1px solid #000000;">{$wt}</td> *}
                        {* <td align="center" width="15%" style="border: 1px solid #000000;">{$bx_rte|inr_format}</td> *}
                        <td align="right" width="20%" style="border: 1px solid #000000;">{($row->transaction_amount-$row->commission_amount)|number_format:2}</td>
                    </tr>
                    {assign var=total value=$total+($row->transaction_amount-$row->commission_amount)}
                    {* {assign var=total_lr value=$k+1} *}
                    {assign var=total_qty value=$total_qty+($row->total_item_count)}
                    {$cnt = $cnt +1}
                {/if}
            {foreachelse}
                <tr>
                    <td colspan="7" align="center" style="border: 1px solid #000000;">No Records Found!</td>
                </tr>
            {/foreach}
            {if $result|count}
                <tr style="font-weight:bold;">
                    <td align="right" colspan="2" style="border-left: 1px solid #000000;border-bottom: 1px solid #000000;">Total Consignment &nbsp;&nbsp;{$cnt-1}</td>
                    {* <td align="left" style="border-bottom: 1px solid #000000;"></td> *}
                    <td align="right" colspan="2" style="border-bottom: 1px solid #000000;">Total Quantity</td>
                    <td align="left" style="border-bottom: 1px solid #000000;">{$total_qty}</td>
                    <td align="right" colspan="2" style="border-bottom: 1px solid #000000;border-right: 1px solid #000000;">Total Amount &nbsp;&nbsp;{$total|number_format:2}</td>
                    {* <td align="left" style="border-bottom: 1px solid #000000;border-right: 1px solid #000000;"></td> *}
                </tr>
            {/if}
        </tbody>
    </table>
{/if}
<div style="page-break-before: always;"></div>
{* &nbsp;<br>
&nbsp;<br> *}
<table style="padding:10px 10px;border: 1px solid #000;">
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
        <td colspan="6" align="center" style="font-weight:bold;font-size: 12px;">
            Invoice
        </td>
    </tr>

    <tr>
        <td width="17%"><b>Account</b></td>
        <td width="5%"><b>:</b></td>
        <td width="28%">RMT CREDIT</td>
        <td width="18%"><b>Invoice Description</b></td>
        <td width="5%"><b>:</b></td>
        <td width="27%">RCM INVOICE</td>
    </tr>
    <tr>
        <td><b>Supplier Name</b></td>
        <td><b>:</b></td>
        <td><b>{$ns_profile->name}</b></td>
        <td><b>Customer Name</b></td>
        <td><b>:</b></td>
        <td><b>{$companyName|ucwords}</b></td>
    </tr>
    <tr>
        <td><b>Supplier Address</b></td>
        <td><b>:</b></td>
        <td>{$nsprofile->address},{$nsprofile->city},<br/>{$nsprofile->state->name}-{$nsprofile->pincode}.</td>
        <td><b>Customer Address</b></td>
        <td><b>:</b></td>
        <td>{$address1}{if $address1},<br>{/if}{$landmark}{if $landmark},<br>{/if}{$address2}{if $address2} - {/if}{$pincode}</td>
    </tr>
    <tr>
        <td><b>GST No</b></td>
        <td><b>:</b></td>
        <td><b>33AYBPSO126Q3Z8</b></td>
        <td><b>GST No</b></td>
        <td><b>:</b></td>
        <td><b>{$gst}</b></td>
    </tr>
    <tr>
        <td><b>SAC CODE</b></td>
        <td><b>:</b></td>
        <td><b>996511</b></td>
        <td><b>Invoice Number</b></td>
        <td><b>:</b></td>
        <td><b>{$details->code}</b></td>
    </tr>
    <tr>
        <td><b>TAXABLE</b></td>
        <td><b>:</b></td>
        <td>Tax Payable Under RCM</td>
        <td><b>Invoice Period</b></td>
        <td><b>:</b></td>
        <td>{foreach from=$months item=val key=key}{$val['month']}{if count($months)-1 != $key},{else}-{/if}{/foreach}

            {foreach from=$years item=val key=key}{$val['year']}{if count($years)-1 != $key},{/if}{/foreach}
        </td>
    </tr>
    <tr>
        <td><b>Amount In Words</b></td>
        <td><b>:</b></td>
        <td>{$total|amount_in_words|ucwords}</td>
        <td><b>Invoice Date</b></td>
        <td><b>:</b></td>
        <td>{date("d M Y", strtotime($details->transactionDate))}</td>
        {* <td>{$details->transactionDate|date_format:$ns_date_format}</td> *}
    </tr>
    <tr>
        <td><b>Payment</b></td>
        <td><b>:</b></td>
        <td>Cheque/DD in favour of '<b> Rathimeena Speed Parcel Service </b>' Only.</td>
        <td><b>Total Consignment</b></td>
        <td><b>:</b></td>
        <td>{$total_lr}</td>
    </tr>
    <tr>
        <td colspan="3" rowspan="2" style="line-height: 15px;"><b>Bank A/C Details :</b><br><b>Name : Rathimeena Speed Parcel Service</b><br><b>A/C No : 004109000051421</b><br><b>Branch : KUMBAKONAM MAIN</b><br><b>IFSC : CIUB0000004</b><br></td>
        <td><b>Total Qty</b></td>
        <td><b>:</b></td>
        <td>{$total_qty}</td>
    </tr>
    <tr>
        <td><b>Invoice Amount</b></td>
        <td><b>:</b></td>
        <td><b>Rs. {$total|inr_format}/-</b></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td align="left" colspan="2">For <b>{$companyName|ucwords}</b></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td align="left" colspan="2"><br>Authorized Signatory</td>
    </tr>
</table>