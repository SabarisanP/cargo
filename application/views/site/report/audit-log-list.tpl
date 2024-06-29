<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th>Edited By</th>
                <th>Event</th>
                <th>Log</th>                
                <th>Updated On</th> 
            </tr>
        </thead>
         <tbody class="body_table">            
            {if $log|@count > 0}
             {foreach item=row from=$log key=r}
                        <tr>                    
                            <td>{$row->first_name}</td>
                            <td>{$row->event}</td>
                            <td>{$row->log|wordwrap:26:"\n":true}</td>
                            <td>{$row->updatedOn}</td> 
                        </tr>   
                    {/foreach}{else}
                        <tr> <td>No Logs Found<td></tr>
                    {/if}    
            </tbody>
    </table>                
</div>

                
        