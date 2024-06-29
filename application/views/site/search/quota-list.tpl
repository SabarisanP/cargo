<table class="table info_table table-hover"  width="100%">
<thead>
    <tr>
        <th>Seat No</th>
        <th>Quota To</th>
        <th>Gender</th>
        <th>Route</th>
        <th>Quota by</th>
        <th></th>
    </tr>
</thead>
<tbody>
    {foreach from=$quota item=row name=dq}
        <tr id="quotarow{$smarty.foreach.dq.index}">
            <td>{$row->quotaSeat->seatName}</td>
            <td>{$row->user->name}</td>
            <td align="center">{$row->quotaSeat->passengerGendar}</td>
            <td>{$row->fromStation->name} - {$row->toStation->name}</td>
            <td>
                <span style="font-size:10px">{$row->updatedUser->name}</span> <br>
                <span style="font-size:10px">{$row->updatedAt|date_format:$ns_datetime_format}</span>
            </td>
            <td id="releasebtn{$smarty.foreach.dq.index}">
                <button class="btn btn-primary btn-xs" type="button" onclick="deleteDetailedQuota({$smarty.foreach.dq.index})">&nbsp;&nbsp;<i class="fa fa-trash"></i>&nbsp;&nbsp;</button>
            </td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="6" align='center'>No quota added</td>
        </tr>
    {/foreach}    
</tbody>
</table>
<div class="row">           
    <div class="col-lg-12 col-md-12 text-right" >
        <button class="btn btn-default btn-clear" type="button" onclick="clearDetailedQuotaList()">Clear</button>
    </div>
</div>
<script>
    var detaildquota = {$quota|json_encode};
</script>