{if $reports|count<=0}
    <div class="alert alert-info text-center"> Sorry! No data found. </div>
{else}    
    <div class="table-responsive" id="adv-report-grid">
        <table id="dt_adv_booking_report_table" class="table table-bordered ">
            <thead>
                <tr class="success">
                    <th rowspan="2">#</th>
                    <th rowspan="2">Payment Order Code</th>
                    <th rowspan="2">Transaction Amount</th>
                    <th rowspan="2">Transaction Date</th> 
                    <th rowspan="2">Payment Mode</th> 
                    <th rowspan="2">Payment Gateway Provider</th>
                    <td colspan="3" align="center">Log Data</td>               
                    <th rowspan="2">Transaction Status</th> 
                </tr>
                <tr class="success">                
                    <td>Date</td>
                    <td>Request</td>               
                    <td>Response</td> 
                </tr>

            </thead>
            <tbody class="body_table">
                {foreach from=$reports item=row name=fetrans}                
                    <tr>
                        <td>{$smarty.foreach.fetrans.index+1}</td> 
                        <td>{$row->order_code}</td>  
                        <td align="right">{$row->transaction_amount|number_format:2}</td> 
                        <td nowrap>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <td>{$row->payment_mode}</td>                    
                        <td nowrap>{$row->gateway_provider}</td> 
                        <td nowrap>{$row->requestDate|date_format:$ns_datetime_format}</td> 
                        <td>{$row->request}</td> 
                        <td>{$row->response}</td> 
                        <td>{$row->transaction_status}</td> 
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    <div class="text-right">
        <div class="btn-group btn-group-sm">
            <!--<button class="btn btn-default" onclick="exportPaymentReport()"><i class="fa fa-download fa-lg"></i>Excel</button>-->
            <button class="btn btn-default" onclick="window.print()"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>  
{/if}

