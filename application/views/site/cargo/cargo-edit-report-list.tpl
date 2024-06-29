<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Cargo Edit Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br />
<div class="clearfix"></div>

<div class="table-responsive">
    <table class="table table-bordered" id="cargo-edit-report-table">
        <thead>
            <tr class="success">
                <th align="left">{lang('cargo_code_term')} <i class="fa fa-sort"></i></th>
                <th align="left">From - To Station <i class="fa fa-sort"></i></th>
                <th align="left">Booked At <i class="fa fa-sort"></i></th>
                <th align="left">Payment Status <i class="fa fa-sort"></i></th>
                <th align="left">Cargo Status <i class="fa fa-sort"></i></th>
                <th align="right">Total Item Count <i class="fa fa-sort"></i></th>
                <th align="right">Total Amount <i class="fa fa-sort"></i></th>
                <th align="left">Edited At <i class="fa fa-sort"></i></th>
                <th align="left">Booked By <i class="fa fa-sort"></i></th>
                <th align="left">Edited By <i class="fa fa-sort"></i></th>
                <th align="left">Edited Event <i class="fa fa-sort"></i></th>
            </tr>
        </thead>
        <tbody>
            {assign var=t_total_item_count value=0}
            {assign var=t_total_amount value=0}

            {foreach item=row from=$result}
                <tr>
                    <td align="left">
                        <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>
                    </td>
                    <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                    <td align="center">{$cargo_status[$row->cargo_status_code]}</td> 
                    <td align="right">{$row->total_item_count}</td>
                    <td align="right">{$row->total_amount|inr_format}</td>
                    <td align="left">{$row->edited_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->edited_user_first_name}</td>
                    <td align="left">
                        <a href='javascript:;' title="histroy" onclick='getCargoHistory("{$row->cargo_code}")'>{$row->event}</a>
                    </td>
                </tr>

                {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
                {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
            {/foreach}
        </tbody>
        <tfoot>
            {if $result|count}
                <tr class="active bold">
                    <td>{$result|count} {lang('lr')}s edited</td>
                    <td colspan="4" align="right">Total</td>
                    <td align='right'>{$t_total_item_count}</td>
                    <td align='right'>{$t_total_amount|inr_format}</td>
                    <td colspan="4" align="right"></td>
                </tr>
            {/if}        
        </tfoot>
    </table>
</div>

<script>
    $('#cargo-edit-report-table').DataTable({
        paging: false
    });
</script>