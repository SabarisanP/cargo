<table width="100%" border="1">
    <tr>
        <td  colspan="8" align="center"><b>E-Ticket Transactions</b></td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Transaction Date :</b>From  {$smarty.request.from_date|date_format:$ns_date_format}  To {$smarty.request.to_date|date_format:$ns_date_format}
            <br>
            <b>Report By :</b> {$user_name} 
        </td>
        <td colspan="4">
            <b>Report Date/Time :</b> {$smarty.now|date_format:$ns_datetime_format} 
        </td>
    </tr>

</table>

<table border="1">
    <thead>
        <tr>
            <th>PNR</th> 
            <th>Namespace Code</th>
            <th>Namespace Name</th>
            <th>Amount</th> 
            <th>Transaction Type</th>
            <th>Provider</th>
            <th>Transaction Date</th> 
            <th>Transaction Date Time</th> 
        </tr>
    </thead>
    <tbody>            
        {foreach name=users item=row from=$data key=t}
            <tr>                    
                <td>{$row->order_code}</td>
                <td>{$row->namespace_code}</td>
                <td>{$row->namespace_name}</td> 
                <td>{if $row->transaction_type_code=="RFD"}-{/if}{$row->transaction_amount}</td> 
                <td>{$row->transaction_type_code}</td> 
                <td>{$row->payment_gateway_provider_name}</td> 
                <td>{$row->transaction_date|date_format:$ns_date_format}</td> 
                <td>{$row->transaction_date|date_format:$ns_datetime_format}</td> 
            </tr>
        {/foreach}  

    </tbody>
</table>                


     