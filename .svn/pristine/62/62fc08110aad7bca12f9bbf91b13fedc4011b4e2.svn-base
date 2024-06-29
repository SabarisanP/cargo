<table border='1'>
    <tr>
        <td  colspan="12" align="center"><b>Payment Gateway Reconciliation Report</b></td>
    </tr>
    <tr>
        <td colspan="6">Report Date : {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format} </td>
        <td colspan="6" >Report At : {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
        <td colspan="6" ><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>    

<br>

<table border='1' width="100%">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <th>#</th>
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
    <tbody>
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
            
        {foreachelse}
            <tr>
                <td colspan="8" align="center">No data found</td>
            </tr>
        {/foreach}
    </tbody>
</table>



