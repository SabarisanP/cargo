{if $reports|count<=0}
    <div class="alert alert-info text-center"> Sorry! No data found. </div>
{else}    
    <table width="95%">
        <tr>
            <td  colspan="10" align="center">Payment Gateway Reconciliation Report</td>
        </tr>
        <tr>
            <td width="50%">                    
                <span class="bold">From </span> {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} 
            </td>
            <td width="50%" align="right">
                <span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}
            </td>
        </tr>
    </table>
        
    <h5><b>Summary</b></h5>
    <table class="table table-bordered" style="width:30%;">
        <thead>
            <tr class="success">
                <th >User</th>
                <th class="text-center">TXN Count</th> 
                <th class="text-center">Amount</th> 
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=total_amount value=0}
            {assign var=total_txn value=0}
            
            {foreach from=$amounts item=amount name=amt key=usrname}                
                <tr>
                    <td>{$usrname}</td> 
                    <td class="text-right">{$user_trans[$usrname]}</td>
                    <td class="text-right">{$amount|number_format:2}</td>                       
                </tr>
                {assign var=total_amount value=$total_amount+$amount}
                {assign var=total_txn value=$total_txn+$user_trans[$usrname]}
            {/foreach}
            <tr>
                    <td class="bold text-right">Total</td> 
                    <td class="bold text-right">{$total_txn}</td>
                    <td class="bold text-right">{$total_amount|number_format:2}</td>                       
                </tr>
        </tbody>
    </table>   
    
    <h5><b>Transactions</b></h5>
    <div class="table-responsive" id="adv-report-grid">
        <table id="dt_adv_booking_report_table" class="table table-bordered ">
            <thead>
                <tr class="success">
                    <th >#</th>
                    <th >Order Code</th>
                    {if $namespace=='bits'}
                    <th >Namespace</th> 
                    {/if}
                    <th >User</th>
                    <th class="text-center">TXN Amount</th>
                    <th >Medium</th>                    
                    <th >TXN Type</th>
                    <th >Provider</th>                     
                    <th >TXN Date</th> 
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach from=$reports item=row name=fetrans}                
                    <tr>
                        <td>{$smarty.foreach.fetrans.index+1}</td> 
                        <td>{$row->order_code}</td> 
                        {if $namespace=='bits'}
                        <td>{$row->namespace_name}</td> 
                        {/if}
                        <td>{$row->user_first_name}</td> 
                        <td class="text-right">{$row->transaction_amount|number_format:2}</td> 
                        <td>{$row->devicemedium}</td>
                        <td>{$row->transaction_type}</td> 
                        <td>{$row->provider_name}</td>                         
                        <td>{$row->transaction_date|date_format:$ns_datetime_format}</td>                        
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    <div class="text-right">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportReconciliationReport()"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>  
{/if}

