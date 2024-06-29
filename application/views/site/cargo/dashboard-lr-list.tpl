<div class="popup_top">
    <div class="row">
        {* <div class="col-md-5 ft_14">
            <span class="bold"> {lang('branch_stock_status_'|cat:$cargoStatusCode)} </span> : {$organization_name}
        </div> *}
        <div class="col-md-10">
            <span class="bold">Total {lang('lr')}</span> : {$result|count}
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeDashLrListDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>
{if empty($result)}
    <div class="alert alert-danger">Invalid {lang('lr')} Code</div>
{else}
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
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$result key=key}
            <tr>
                <td>{$key + 1}</td>
                <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->code}")'>{$row->code}</a></td>
                <td align="left" nowrap>{$row->bookedAt|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->fromOrganization->name}</td>
                <td align="left">{$row->toOrganization->name}</td>
                <td align="left">{($row->transitOrganization->name)? $row->transitOrganization->name : '-'}</td>
                <td align="left">
                    {$row->paymentType->code|_cargo_payment_status_badge}
                </td>
                <td align="left">{$cargo_status[$row->cargoStatus->code]}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        {/foreach}
    </tbody>
</table>
{/if}