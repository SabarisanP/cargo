<table width="100%">
    <tr>
        <td colspan="10" align="center"><span class="bold">Alert Subscription Report</td>
    </tr>
</table>
<br/>
<div class="table-responsive overflow-y-auto" id="adv-bp-grid" style="height:73vh">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="center" width='1%'>#</th>
                <th>Notification Type <i class="fa fa-sort"></i></th>
                <th>Group <i class="fa fa-sort"></i></th>
                <th>User <i class="fa fa-sort"></i></th>
                <th>Notification Medium <i class="fa fa-sort"></i></th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row from=$result key=e name=bill}
                <tr>
                    <td>{$smarty.foreach.bill.index+1}</td>
                    <td>{$row->notification_type_name}</td>
                    <td>{$row->group_name}</td>
                    <td>{$row->user_name}</td>
                    <td>{$row->notification_medium_name}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="5">No results found</td>
                </tr>
            {/foreach}

        </tbody>
    </table>
</div>
<script>
$('#dt_bp_report_table').dataTable({
    "searching": true,
    "paging" : false,
});
</script>