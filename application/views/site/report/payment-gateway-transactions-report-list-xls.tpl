<table border='1'>
    <tr>
        <td  colspan="12" align="center"><b>Payment Gateway Transactions Report</b></td>
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

<table border='1'>
    <tr>
        <td class="bold" >Booking (A)</td>
        <td class="text-right">{$amounts['booking']|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" >Refund (B)</td>
        <td class="text-right">{$amounts['refund']|number_format:2}</td>
    </tr>
    <tr>
        <td class="bold" >Service Charges (C)</td>
        <td class="text-right">{$amounts['service_charges']|number_format:2}</td>
    </tr>

    <tr>
        <td class="bold">Net Amount (A-B-C)</td>                                                                                           
        <td class="bold text-right">
            {($amounts['booking']-($amounts['refund']+$amounts['service_charges']))|number_format:2}
        </td>
    </tr>
</table> 

<br>
    
<table class="table table-bordered " border='1'>
    <thead>
        <tr class="success">
            <th >#</th>
            <th >Order Code</th>
            <th >Access Code</th>
            <th >TXN Amount</th>
            <th >Service Charge</th>
            <th >TXN Date</th>
            <th >TXN Type</th>
            <th >Provider</th>                     
            <th >Partner Name</th> 
            <th >Provider Id</th> 
            <th >Type Code</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach from=$reports item=row name=fetrans}                
            <tr>
                <td>{$smarty.foreach.fetrans.index+1}</td> 
                <td>{$row->order_code}</td> 
                <td>{$row->payment_credentials_access_code}</td> 
                <td>{$row->transaction_amount|number_format:2}</td> 
                <td>{$row->service_charge|number_format:2}</td> 
                <td>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                <td>{$row->transaction_type_code}</td> 
                <td>{$row->payment_gateway_provider_name}</td>                         
                <td>{$row->payment_gateway_partner_name}</td>
                <td>{$row->payment_gateway_provider_id}</td>
                <td>{$row->payment_gateway_transaction_code}</td>                         
            </tr>
        {/foreach}
    </tbody>
</table>
 

