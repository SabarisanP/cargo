<table border='1'>
    <tr>
        <td  colspan="12" align="center"><b>My Transactions Report</b></td>
    </tr>
    <tr>
        <td colspan="6">Report Date : {$smarty.request.from|date_format:$ns_date_format}  to {$smarty.request.to|date_format:$ns_date_format} </td>
        <td colspan="6" >User : {$smarty.request.selectedUser}</td>
    </tr>
</table>    
<br>
<table class="table table-bordered " border='1'>
    <thead>
        <tr style="font-weight:bold; background-color:#64b92a; color: #fff;">
            <th>#&nbsp;&nbsp;</th>
            <th>Ref / PNR Number&nbsp;&nbsp;</th>
            <th>Transaction Date&nbsp;&nbsp;</th>
            <th>Username</th>
            <th>Transaction Type&nbsp;&nbsp;</th>
            <th>Transaction Mode&nbsp;&nbsp;</th>
            <th align="right">Credit Amount&nbsp;&nbsp;</th>
            <th align="right">Debit Amount&nbsp;&nbsp;</th>
            <th align="right">TDS Amount&nbsp;&nbsp;</th>
            <th>Transaction Amount&nbsp;&nbsp;</th>
            <th>Closing Balance&nbsp;&nbsp;</th>
        </tr>
    </thead>
    <tbody class="body_table">
        {foreach item=row from=$reports key =k}
            <tr>
                <td >{$k+1}</td>
                <td >{$row->refferenceCode}</td>
                <td >{$row->transactionDate|date_format:$ns_datetime_format}</td>
                <td>{$row->user->name}</td>
                <td >{$row->transactionType->name} </td>
                <td >{$row->transactionMode->name} </td>

                <td  align="right">{$row->creditAmount|number_format:2}</td>
                <td  align="right">{$row->debitAmount|number_format:2}</td>
                <td  align="right">{$row->tdsTax|number_format:2}</td>
                <td  align="right">{$row->transactionAmount|number_format:2}</td>

                <td  align="right">{$row->closingBalance|number_format:2}</td>
            </tr>
        {/foreach}   
    </tbody>
</table>
