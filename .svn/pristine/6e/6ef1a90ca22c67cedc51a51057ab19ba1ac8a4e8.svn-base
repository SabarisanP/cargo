<style type="text/css" media="print">
@media print { 
    body {
       -webkit-print-color-adjust: exact; 
     }
    @page {
                size: A4 portrait;
                counter-increment: page;
            }

            table {
            border-collapse: collapse;
        }

        table thead th,
        table thead td {
            font-weight: bold;
        }

        table.bordered th,
        table.bordered td {
            border: .1px solid #000;
        }

        div.print-border {
            position: fixed;
            bottom: 0px;
            left: 0px;
            border: 1px solid black;
            border-top:none;
            width: 100%;
            background-color:black;
        }

        div.print-border-top {
            position: fixed;
            top: 0px;
            left: 0px;
            right:0px;
            border: 1px solid black;
            border-top:none;
            width: 100%;
            background-color:black;
        }

        div.print-border-left {
            position: fixed;
            top: 0px;
            height: 100%;
            width: 0;
            left:0;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }

        div.print-border-right{
            position: fixed;
            top: 0px;
            height: 100%;
            width: 0;
            left:99.8%;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }
}
</style>
<div class="print-border-top"></div>
<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>
<div align = "center" class = "text-center">
<h2 style="margin:0;">Seenu Transports Pvt Ltd</h2>
</div>
<table class="" width="100%" >
    <tr>
    <td colspan="6" align="left"><span class="bold"><b>Date :<prev>  </prev> {$toDate}</b></span></td>
    <td colspan="6" align="left" style = "text-indent:-44px;"><span class="bold">Outstanding Payment List</span></td>
    </tr>
</table>

<br>

<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered " border="1">
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
           <td colspan="10" align="center"><b>{$key}<b></td>
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
                       <td colspan="2" align="center"><b>{$Value[0]->vendor_email}</b></td>
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

{* <div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoDeliveryExcel()"><i
                class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div> *}

<script>
window.print();
</script>