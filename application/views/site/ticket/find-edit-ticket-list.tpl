
<div class="clear_fix_both"></div>
<div >
<div class="table-responsive">
    <table id="dt_basic" class="table table-bordered ">
        <thead>
            <tr  class="success" >
                <th>Txn Id</th>
                <th>PNR</th>                
                <th>Email</th>
                <th>Mobile</th>
                <th>From Station</th>
                <th>To Station</th>
                <th>Travel Date</th>
                <th>Booked At</th>   
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row from=$ticket}
                <tr>
                    <td data-tripcode="{$row['tripCode']}">{$row['bookingCode']}</td> 
                    <td>{$row['ticketCode']}</td>                    
                    <td>{$row['email']}</td>
                    <td>{$row['mobile']}</td>
                    <td>{$row['fromStation']}</td>
                    <td>{$row['toStation']}</td>
                    <td>{$row['travelDate']|date_format:$ns_date_format}</td>
                    <td>{$row['bookedDate']|date_format:$ns_datetime_format}</td> 
                    <td>{$row['statusCode']}</td> 
                    <td>
                        <a href="javascript:;" class="btn btn-default btn-xs" title="view history" onclick="getTicketHistory('{$row['ticketCode']}')" >
                            <i class="fa fa-list"></i>
                        </a>
                        {if $row['statusCode'] != 'CA' && $row['statusCode'] != 'PCA' }
                            {if $action_rights['FIND-EDT-TCK-PRINT']>0}
                                <a {if $action_rights['FIND-EDT-TCK-PRINT'] == 1}href="javascript:;" onclick="printTktWindow('{$row['operatorCode']}','{$row['bookingCode']}','ticket',1);" {else}href="javascript:;"{/if} class="btn btn-default btn-xs" title="print ticket">
                            <i class="fa fa-print"></i>
                        </a> &nbsp;{/if}
                        {if $action_rights['FIND-EDIT-TCK-CANCEL']>0}
                            <a {if $action_rights['FIND-EDIT-TCK-CANCEL']==1}href="#search/cancel-ticket?v={$row['ticketCode']}" {else}href="javascript:;"{/if}id="tck_can" class="btn btn-default btn-xs" title="cancel ticket">
                            <i class="fa fa-times"></i>
                        </a> &nbsp;{/if}{/if}
                        {if $action_rights['FIND-EDIT-TCK-EDIT']>0}
                        <a id="tck_edt" href="javascript:;" {if $action_rights['FIND-EDIT-TCK-EDIT']==1} onclick="editTicket('{$row["ticketCode"]}')" {/if} class="btn btn-default btn-xs" title="edit ticket details">
                            <i class="fa fa-pencil"></i>
                        </a>{/if}
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
 