<div class="table-responsive">
{if $tickets|count==0} 
    <div class="well well-large"> Sorry! No tickets booked.</div>
{else}  
    <table class="table table-hover">
        <thead>
            <tr>
                <th>PNR</th>
                <th>From</th>
                <th>To</th>
                <th>Travel Date</th>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$tickets}
                <tr>
                    <td>{$row->code}</td>
                    <td>{$row->fromStation}</td>
                    <td>{$row->toStation}</td>
                    <td>{$row->travel_date|date_format:$ns_date_format}</td>
                </tr>
            {/foreach}    
        </tbody>
    </table>
{/if}
</div>