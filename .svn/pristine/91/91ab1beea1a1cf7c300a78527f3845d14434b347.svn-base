<div class="" style="height:300px; overflow-x: auto;">
    <table class="table info_table table-hover"  width="100%">
    <thead>
        <tr>
            <th>Route</th>
            {foreach from=$seatTypes item=row}
            <th>{$row['name']}</th>
            {/foreach}

        </tr>
    </thead>
    <tbody>
        {foreach from=$fares item=row}
            <tr>           
                <td valign="middle" nowrap>{$row['fromName']} - {$row['toName']}</td>
                {foreach from=$seatTypes item=type}            
                <td align="center">{$row['stageFare'][$type['type']]->fare}</td>
                {/foreach}
            </tr>
        {/foreach}     
    </tbody>
    </table>
</div>