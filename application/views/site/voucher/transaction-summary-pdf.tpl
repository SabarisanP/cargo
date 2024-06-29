<style>                        
    .bordered td{ border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px }
    .bordered .noborder{ border:1px solid #fff; }
    .bold{ font-weight:bold; }
</style>

<table width="100%" cellpadding="5">
    <tr>
        <td align="center" style="font-weight:bold">{$namespace_name}</td>
    </tr>
    <tr>
    	<td align="center" class="bold">Payment Voucher</td>
    </tr>
</table>

<table width="100%" cellpadding="5">
    <tr>
        <td align="right">{$summary->transactionDate|date_format:$ns_date_format}</td>        	
    </tr>
</table>

<table width="100%" cellpadding="5" class="table bordered ">
    <tbody class="body_table" >
    <tr>
    	<td align="left" width="15%"  class="bold">Payment Code</td>
        <td align="left" width="35%" >{$summary->code}</td>
        
        <td align="left" width="15%"  class="bold">Agent Name</td>
        <td align="left" width="35%">{$summary->user->name}</td>        	
    </tr>
    <tr>
    	<td align="left" width="15%" class="bold">Amount</td>
        <td align="left" width="35%">{$summary->transactionAmount|number_format:2}</td>
        
        <td align="left" width="15%" class="bold">Transaction Mode</td>
        <td align="left" width="35%">{$summary->transactionMode->name}</td>        	
    </tr>
    <tr>
    	<td align="left"  width="15%" class="bold">Acknowledge Status</td>
        <td align="left" width="35%">{$summary->acknowledgeStatus->name}</td>
        
        <td align="left" width="15%"  class="bold">Amount Received</td>
        <td align="left" width="35%">{$summary->amountReceivedDate|date_format:$ns_date_format}</td>        	
    </tr>
    <tr>
    	<td align="left"  width="15%" class="bold">Remarks</td>
        <td align="left" colspan="3" width="85%">{$summary->remarks}</td>        	
    </tr>
    </tbody>
</table>

<table width="100%" cellpadding="5">
    <tr>
        <td align="center" width="50%">&nbsp;</td>
        <td align="center" width="50%">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" width="50%">&nbsp;</td>
        <td align="center" width="50%">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" width="50%">Voucher By</td>
        <td align="center" width="50%">Received By</td>
    </tr>
</table>