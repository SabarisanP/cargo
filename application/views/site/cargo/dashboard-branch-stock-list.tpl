<div class="popup_top">
    <div class="row">
        <div class="col-md-5 ft_14">
            <span class="bold"> {lang('branch_stock_status_'|cat:$cargoStatusCode)} </span> : {$organization_name}
        </div>
        <div class="col-md-5">
            <span class="bold">Total {lang('lr')}</span> : {$result|count} &nbsp;
            <span class="bold">Total Articles </span> : {$article_count} 
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeDashReportDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>



<table class="table table-bordered" width="98%">
    <thead>
        <tr class="success">
            <td align="center">S.No</td>
            <td align="center">{lang('cargo_code_term')}</td>
            <td align="center">Booked Date</td>
            <td align="center">{lang('booking_from_term')}</td>
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">Transit Branch</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Hub Activity</td>
            <td align="center">No. Of Articles</td>
            <td align="center">Qty</td>
            <td align="center">Freight</td>
            {if $cargo_status_code == 'CMS'}
                <td align="center">Reg No. / {lang('ogpl')}</td>
                <td align="center">Updated By</td>
                <td align="center">Updated At</td>
            {/if}
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=t_item_count value=0}
        {assign var=t_total_item_count value=0}
        {assign var=t_total_amount value=0}
        {foreach item=row from=$result key=key}
            <tr>
                <td>{$key + 1}</td>
                <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->from_organization_name}</td>
                <td align="left">{$row->to_organization_name}</td>
                <td align="left">{($row->transit_organization_name)? $row->transit_organization_name : '-'}</td>
                <td align="left">
                    {$row->payment_type_code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                <td align="center">
                    {if $row->hub_transit_tag}
                        {assign var="hubflags" value=comma_split($row->hub_transit_tag)}
                        {foreach from=$hubflags item=flag}
                            {if $flag == 'HL'}
                                <span class="badge badge-secondary">Hub.L</span> 
                            {elseif $flag == 'HU'}
                                <span class="badge badge-secondary">Hub.UL</span>
                            {/if}
                        {/foreach}                        
                    {else}
                        -
                    {/if}
                </td>
                <td align="right">{$row->item_count}</td>
                <td align="right">{$row->total_item_count}</td>
                <td align="right">{$row->total_amount|inr_format}</td>
                {if $cargo_status_code == 'CMS'}
                    <td align="left">{$row->registration_number|default:'-'} <br/><small class="text-muted" title="{lang('ogpl')} Code">{(isNotNull($row->alias_code)) ? $row->alias_code : ''}</small></td>
                    <td align="left">{$row->status_updated_user_name|default:'-'} <br/><small class="text-muted" title="Branch">{$row->status_updated_organization_name}</small></td>
                    <td align="left" nowrap>{(isNotNull($row->status_updated_at)) ? ($row->status_updated_at|date_format:$ns_datetime_format) : '-'}</td>
                {/if}
            </tr>
            
            {assign var=t_item_count value=$t_item_count + $row->item_count}
            {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/foreach}

        {if $result|count}
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="9" align="right"><b>Total</b></td>
                <td align='right'>{$t_item_count}</td>
                <td align='right'>{$t_total_item_count}</td>
                <td align='right'>{$t_total_amount|inr_format}</td>
                {if $cargo_status_code == 'CMS'}
                    <td colspan="3" align="right"></td>
                {/if}
            </tr>
        {/if}
    </tbody>
</table>