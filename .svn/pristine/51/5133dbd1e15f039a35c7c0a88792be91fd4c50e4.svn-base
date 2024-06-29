<table border="1">
    <tr>
        <td colspan="6" align="center"><b>Branch Stock Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$fromdate|date_format:$ns_date_format} to {$to_date|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
    </tr>
</table>

<h5><b>Summary</b></h5>
<table border="1">
    <thead>
        <tr class="success">
            <th></th>
            {foreach item=statuscount key=statuscode from=$all_payment_status}
                <th align="center">{$cargo_payment_status[$statuscode]}</th>
            {/foreach}
            <th align="center">Total</th>
        </tr>
    </thead>
    <tbody>
        {foreach item=count from=$summary key=branch}
            <tr>
                <td align="left"><b>{$branch}</b></td>
                {foreach item=statuscount key=statuscode from=$all_payment_status}
                    <td align="right">{$count[$statuscode] + 0}</td>
                {/foreach}
                <td align="right"><b>{$count['total']}</b></td>
            </tr>
        {/foreach}
    </tbody>
    <tfoot>
        <tr>
            <th align="left"><b>Total</b></th>
            {assign var="tot" value=0}
            {foreach item=statuscount from=$all_payment_status}
                <th align="right">{$statuscount + 0}</th>
                {assign var="tot" value=$tot + $statuscount}
            {/foreach}
            <td align="right"><b>{$tot}</b></td>
        </tr>
    </tfoot>
</table>

<h5><b>Transactions</b></h5>
<table border="1">
    <thead>
        <tr style="font-weight: bold; background-color:#64b92a; color: #fff;">
            <td align="center">{lang('cargo_code_term')}</td>
            {if $cargo_status_code != 'CB'}
                <td align="center">OGPL No</td>
            {/if}
            <td align="center">Booked Date</td>
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">Transit Branch</td>
            <td align="center">{lang('booking_sender_term')} Name</td>
            <td align="center">{lang('booking_sender_term')} Contact</td>
            <td align="center">{lang('booking_receiver_term')} Name</td>
            <td align="center">{lang('booking_receiver_term')} Contact</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Hub Activity</td>
            <td align="center">No. Of Articles</td>
            <td align="center">Qty</td>
            <td align="center">Freight</td>
            {if $cargo_status_code == 'CMS'}
                <td align="center">{lang('ogpl')}</td>
                <td align="center">Reg No.</td>
                <td align="center">Updated By</td>
                <td align="center">Updated User Branch</td>
                <td align="center">Updated At</td>
            {/if}
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=t_item_count value=0}
        {assign var=t_total_item_count value=0}
        {assign var=t_total_amount value=0}
        {foreach item=row from=$result}
            <tr>
                <td align="left">{$row->cargo_code}</td>
                {if $cargo_status_code != 'CB'}
                    <td align="left">{$row->alias_code}</td>
                {/if}
                <td align="left">{$row->booked_at|date_format:'%d %b, %I:%M %p'}</td>
                <td align="left">{$row->from_organization_name}</td>
                <td align="left">{$row->to_organization_name}</td>
                <td align="left">{$row->transit_organization_name}</td>
                <td align="left">{$row->from_customer_name}</td>
                <td align="left">{$row->from_customer_mobile|mask_mobileno}</td>
                <td align="left">{$row->to_customer_name}</td>
                <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                <td align="left">
                    {$row->payment_type_code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="center">
                    {if $row->hub_transit_tag}
                        {assign var="hubflags" value=comma_split($row->hub_transit_tag)}
                        {foreach from=$hubflags item=flag}
                            {if $flag == 'HL'}
                                Hub.L
                            {elseif $flag == 'HU'}
                                , Hub.UL
                            {/if}
                        {/foreach}
                    {else}
                        -
                    {/if}
                </td>
                <td align="right">{$row->item_count}</td>
                <td align="right">{$row->total_item_count}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount}</td>
                {if $cargo_status_code == 'CMS'}
                    <td align="left">{(isNotNull($row->alias_code)) ? $row->alias_code : '-'}</td>
                    <td align="left">{$row->registration_number|default:'-'}</td>
                    <td align="left">{$row->status_updated_user_name|default:'-'}</td>
                    <td align="left">{$row->status_updated_organization_name|default:'-'}</td>
                    <td align="left" nowrap>{(isNotNull($row->status_updated_at)) ? ($row->status_updated_at|date_format:$ns_datetime_format) : '-'}</td>
                {/if}
            </tr>
            {assign var=t_item_count value=$t_item_count + $row->item_count}
            {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
        {/foreach}

        {if $result|count}
            <tfoot>
                <tr style="background-color: #bbbbbb; color: #fff;">
                    <td colspan="{if $cargo_status_code != 'CB'}12{else}11{/if}" align="center" data-format="{$xlformat['currency']}">
                        {foreach from=$paytype_summary item=amt key=paytype}
                            <b>{$cargo_payment_status[$paytype]} : </b> {$amt}&emsp;&emsp;&emsp;
                        {/foreach}
                    </td>
                    <td colspan="1" align="right"><b>Total</b></td>
                    <td align='right'>{$t_item_count}</td>
                    <td align='right'>{$t_total_item_count}</td>
                    <td align='right' data-format="{$xlformat['currency']}">{$t_total_amount}</td>
                    {if $cargo_status_code == 'CMS'}
                        <td colspan="5"></td>
                    {/if}
                </tr>
            </tfoot>
        {else}
            <tfoot>
                <tr>
                    <td colspan="{if $cargo_status_code == 'CMS'}20{else}15{/if}" align="center">No Records Found</td>
                </tr>
            </tfoot>
        {/if}
    </tbody>
</table>