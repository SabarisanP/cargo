<table class="table info_table table-hover"  width="100%">
<thead>
    <tr>
        <th>Seat No</th>
        <th>Gender</th>
        <th></th>
    </tr>
</thead>
<tbody>
    {foreach from=$preference item=row name=dq}
        <tr id="genderprefrow{$smarty.foreach.dq.index}">
            {$seats = []}
            {foreach from=$row->bus->seatLayoutList item=r}
                {$seats[] = $r->seatName}
            {/foreach}
            <td>
                {$seats|implode:', '}
            </td>
            <td>
                {if $row->preferenceGendar == 'F'}
                    Female
                {else if $row->preferenceGendar == 'M'}
                    Male
                {/if}
            </td>
            <td id="releasepref{$smarty.foreach.dq.index}">
                <button class="btn btn-primary btn-xs" type="button" onclick="deleteGenderSeatPreference({$smarty.foreach.dq.index})">&nbsp;&nbsp;<i class="fa fa-trash"></i>&nbsp;&nbsp;</button>
            </td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="6" align='center'>No Gender Preference added</td>
        </tr>
    {/foreach}    
</tbody>
</table>
<div class="row">           
    <div class="col-lg-12 col-md-12 text-right" >
        <button class="btn btn-default btn-clear" type="button" onclick="clearSeatPreferenceList()">Clear</button>
    </div>
</div>
<script>
    var detailGenderPreference =  {$preference|json_encode};
</script>