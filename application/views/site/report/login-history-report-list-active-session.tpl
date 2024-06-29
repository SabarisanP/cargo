{if $reports|count<=0}
    <div class="alert alert-info text-center"> Sorry! No data found. </div>
{else}    
    <div class="table-responsive" id="adv-report-grid">
        <table id="dt_adv_booking_report_table" class="table table-bordered ">
            <thead>
                <tr class="success">
                    <th>#</th>
                    <th>User</th>
                    <th>Role</th>
                    <th>Logged In</th>                    
                    <th>Logged Out</th>                    
                    <th>IP Address</th>                     
                </tr>

            </thead>
            <tbody class="body_table">
                {foreach from=$reports item=row name=fetrans}                
                    <tr>
                        <td>{$smarty.foreach.fetrans.index+1}</td> 
                        <td>{$row->username}</td>
                        <td>{$row->group_name}</td>
                        <td>{$row->session_started_at|date_format:$ns_datetime_format}</td>                        
                        <td>{$row->session_end_at|date_format:$ns_datetime_format}</td>
                        <td>{$row->ip_address}</td>                        
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    <div class="text-right">
        <div class="btn-group btn-group-sm">
            <!--<button class="btn btn-default" onclick="exportPaymentReport()"><i class="fa fa-download fa-lg"></i>Excel</button>-->
        </div>
    </div>  
{/if}

