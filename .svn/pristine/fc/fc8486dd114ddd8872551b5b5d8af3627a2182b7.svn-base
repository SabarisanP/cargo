<table class="" width="95%">
    <tr>
    <td colspan="5" align="left"><span class="bold"><b>Date :<prev>  </prev> {$toDate}</b></span></td>
    <td colspan="5" align="left" style = "text-indent:-44px;"><span class="bold">Outstanding Payment List</span></td>
       
    </tr>
</table>

<br>

<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered ">
   <thead>
   <tr class="success">
   <td>SL. NO</td>
   <td>Party Name</td>
   <td>Bill Submission</td>
   <td>Bill No</td>
   <td>Bill Date</td>
   <td>No of Bill</td>
   <td>Bill Amt</td>
   <td>Monthly Total</td>
   <td>Grand Total</td>
   <td>Remarks</td>
   </tr>
   </thead>
   <tbody class="body_table">
   {foreach $pendingList as $key => $row}
       <tr>
           <td colspan="9" align="center"><b>{$key}<b></td>
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
                <tr style = "height:30px;"><td colspan="10"></td></tr>
                   <tr>
                       <td><b>{$index1}</b></td>
                       <td colspan="3" align="center"><b>{$Value[0]->vendor_name}</b></td>
                       <td colspan="3" align="center"><b>{$Value[0]->vendor_contact}</b></td>
                       <td colspan="3" align="center"><b>{$Value[0]->vendor_email}</b></td>
                   </tr>
                   <tr style = "height:30px;"><td colspan="10"></td></tr>
               {/if}
               
          
               {foreach $Value as $innerValue}
                   {assign var="monthlyIncome" value=$monthlyIncome + $innerValue->transaction_amount}
                   {assign var="totalIncome" value=$totalIncome + $innerValue->transaction_amount}
                   {assign var="index3" value=$index3 + 1}
                   <tr>
                       <td>{$index3}</td>
                       <td nowrap>{$innerValue->from_to_codes}</td>
                       <td nowrap>{($innerValue->submitted_at|date_format:$ns_datetime_format)|substr:0:10}</td>
                       <td nowrap>{$innerValue->invoice_number}</td>
                       <td nowrap>{($innerValue->transaction_start_date|date_format:$ns_datetime_format)|substr:0:10}</td>
                       <td nowrap>{$innerValue->cargo_count}</td>
                       <td nowrap>{$innerValue->transaction_amount}</td>
                       <td nowrap><b>{($index3 == $totalMonthlyIndex) ? $monthlyIncome : ''}</b></td>
                       <td nowrap><b>{($index3 == $totalIncomeIndex) ? $totalIncome : ''}</b></td>
                       <td nowrap>{$innerValue->remarks}</td>
                   </tr>
               {/foreach}
           {/foreach}
       {/foreach}
   {/foreach}
</tbody>
    </table>
</div>

<script>
</script>