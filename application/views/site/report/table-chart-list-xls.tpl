<table class="" width="95%" border='1'  style = "background-color:#eaecf5 !important;">
<tr><td colspan = "10"  align="center"><span class="bold" style = "font-size:25px;"><b><i>SEENU TRANSPORTS PVT LTD</i></b></span></td></tr>
    <tr>
        <td colspan="3"  border='0' align="left" style = "border-right:none !important;font-size:25px;"><span class="bold"><b>Date :<prev>  </prev> {$toDate}</b></span></td>
        <td colspan="7"  border='0' align="left" style = "border-left:none !important;font-size:25px;"><span class="bold"><b>Outstanding Payment List</b></span></td>

    </tr>
</table>

<div>
    <table border='1'  style = "background-color:#eaecf5 !important;">
        <thead>
            <tr class="success">
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>SL. NO</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>Party Name</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>Bill<br>Sub<br>mission</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>Bill No</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>Bill Date</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>No of Bill</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>Bill<br> Amt</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>Monthly <br>Total</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>Grand <br>Total</b></td>
                <td align = "center" style = " vertical-align: middle; height:10px;"><b>Remarks</b></td>
            </tr>
        </thead>
        <tbody class="body_table">
   <tr>
</tr>
   {foreach $pendingList as $key => $row}
       <tr>
       <td></td>
           <td  align="center" style = "font-size:25px;"><b><u><u>{$key}</u></u><b></td>
           <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td><td></td>
       </tr>
       {assign var="index1" value=0}
       {foreach $row as $singleOrg => $value}
           {assign var="totalIncome" value=0}
           {assign var="index1" value=$index1 + 1}
           {assign var="index2" value=0}
           {assign var="index3" value=0}
           {assign var= "totalIncomeIndex" value = 0}
           {assign var= "totalMonthlyIndex" value = 0}
           {foreach $value as $key2 => $Value}
            {assign var= "totalIncomeIndex" value =($totalIncomeIndex+($Value|count))}
            {/foreach}
           {foreach $value as $key2 => $Value}
               {assign var="monthlyIncome" value=0}
               {assign var="index2" value=$index2 + 1}
              
               {assign var= "totalMonthlyIndex" value =($totalMonthlyIndex+($Value|count))}
               {if $index2 == 1}
                   <tr>
                       <td><b></b></td>
                       <td colspan="3" align="center"><b>{$Value[0]->vendor_name}</b></td>
                       <td colspan="3" align="center"><b>{$Value[0]->vendor_contact}</b></td>
                       <td colspan="3" align="center" style = "color:#0000ff;">{$Value[0]->vendor_email}</td>
                   </tr>
               {/if}
               
          
               {foreach $Value as $innerValue}
                   {assign var="monthlyIncome" value=$monthlyIncome + $innerValue->transaction_amount}
                   {assign var="totalIncome" value=$totalIncome + $innerValue->transaction_amount}
                   {assign var="index3" value=$index3 + 1}
                   <tr>
                       <td style = "font-size:20px;" align="left">{$index3}</td>
                       <td style = "font-size:20px;" nowrap>{$innerValue->from_to_codes}</td>
                       <td style = "font-size:20px;" nowrap style = "color:#ff0039 !important;">{($innerValue->submitted_at|date_format:$ns_datetime_format)|substr:0:10}</td>
                       <td style = "font-size:20px;" nowrap>{$innerValue->invoice_number}</td>
                       <td style = "font-size:20px;" nowrap>{($innerValue->transaction_start_date|date_format:$ns_datetime_format)|substr:0:10}</td>
                       <td style = "font-size:20px;" nowrap>{$innerValue->cargo_count}</td>
                       <td style = "font-size:20px;" nowrap>{$innerValue->transaction_amount}</td>
                       <td style = "font-size:20px;" nowrap>{($index3 == $totalMonthlyIndex) ? $monthlyIncome : ''}</td>
                       <td style = "font-size:20px;" nowrap>{($index3 == $totalIncomeIndex) ? $totalIncome : ''}</td>
                       <td style = "font-size:20px;" nowrap>{$innerValue->remarks}</td>
                   </tr>
               {/foreach}
    
           {/foreach}
           <tr>
           <td></td>
           <td></td>
           <td></td> 
           <td></td> 
           <td></td>
            <td></td> 
            <td></td> 
            <td></td> 
            <td></td>
            <td></td>
           </tr>
           <tr>
           <td></td>
           <td></td>
           <td></td> 
           <td></td> 
           <td></td>
            <td></td> 
            <td></td> 
            <td></td> 
            <td></td>
            <td></td>
           </tr>
       {/foreach}
       
   {/foreach}
</tbody>

    </table>
</div>