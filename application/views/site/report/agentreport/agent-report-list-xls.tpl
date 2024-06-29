<table width="95%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">User Transaction Summary Report</td>
    </tr>
    <tr>
        <td width="50%">
               	User Transaction Summary Report
                From  {$smarty.request.date_from|date_format:$ns_date_format}  To {$smarty.request.date_to|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("Y-m-d h:i:s A")}
        </td>
    </tr>
</table>
        <table id="" class="" border="1">
            <thead>
             <tr class="info">
                <td rowspan="2" align="center">Agent Name</td>
                <td colspan="5" align="center">Booked Details</td> 
                <td colspan="5" align="center">Cancelled Details</td>
                <td  colspan="3" align="center">Account Details</td> 
                
            </tr>
                <tr class="info">
                <td align="center">Booked Seat Count</td> 
                <td align="center">Booked Ticket Amount</td>
                <td align="center">GST</td>
                <td align="center">Commission Amount</td>
                <td  align="center">Phone Booked Seat Count</td> 
                
                <td align="center" >Cancelled Seat Count</td>
                <td align="center" >Refund Amount</td> 
                <td align="center" >cancellation charges</td>
                <td align="center" >Revoke Commission </td> 
                <td align="center" >Phone  Cancelled Seat Count</td>
               
                <td  align="center">Opening Balance</td> 
                <td  align="center">Closing Balance</td> 
                <td  align="center">Recharge Amount</td> 

            </tr>
            </thead>
            <tbody class="body_table">
            {assign var=bkd_seat_count value=0}
            {assign var=bkd_tck_amount value=0}
            {assign var=bkd_comm_amount value=0}
            {assign var=ph_bkd_seat_count value=0}
            
            {assign var=cld_seat_count value=0}
            {assign var=refund_amount value=0}
            {assign var=cncl_charges value=0}
            {assign var=rvke_comm_amount value=0}
            {assign var=ph_cld_seat_count value=0}
            
            {assign var=service_tax value=0}
            
            {assign var=opening_bal value=0}
            {assign var=closing_bal value=0}
            {assign var=rech_amt value=0}
            
            {foreach item=row from=$tickets}
            <tr>
                <td align="left" >{$row->user_first_name}</td>				
                <td align="center">{$row->booked_seat_count}</td> 
                <td align="right" >{$row->booked_ticket_amount|inr_format}</td>
                <td  align="right">{$row->booked_ac_bus_tax_amount|inr_format}</td>
                <td align="right">{$row->booked_commission_amount|inr_format}</td>
                <td align="center">{$row->phone_booked_seat_count}</td> 
                
                <td align="center" >{$row->cancelled_seat_count}</td>
                <td align="right" >{$row->refund_amount|inr_format}</td>
                <td align="right" >{$row->cancellation_charges|inr_format}</td>
                <td align="right" >{$row->revoke_commission_amount|inr_format}</td>
                <td align="center" >{$row->phone_cancelled_seat_count}</td>
                 
                
                <td  align="right">{$row->opening_balance|inr_format}</td>
                <td  align="right">{$row->closing_balance|inr_format}</td>
                <td  align="right">{$row->recharge_amount|inr_format}</td>
                </tr>
                 {assign var=bkd_seat_count value=$bkd_seat_count+ $row->booked_seat_count}
                 {assign var=bkd_tck_amount value=$bkd_tck_amount+ $row->booked_ticket_amount}
	             {assign var=bkd_comm_amount value=$bkd_comm_amount+ $row->booked_commission_amount}
	             {assign var=ph_bkd_seat_count value=$ph_bkd_seat_count+ $row->phone_booked_seat_count}
	             
	             {assign var=cld_seat_count value=$cld_seat_count+$row->cancelled_seat_count}
	             {assign var=refund_amount value=$refund_amount+$row->refund_amount}
	             {assign var=cncl_charges value=$cncl_charges+$row->cancellation_charges}
	             {assign var=rvke_comm_amount value=$rvke_comm_amount+$row->revoke_commission_amount}
	             {assign var=ph_cld_seat_count value=$ph_cld_seat_count+$row->phone_cancelled_seat_count}
	             
	             {assign var=service_tax value=$service_tax+$row->booked_ac_bus_tax_amount}
	             
	             {assign var=opening_bal value=$opening_bal+$row->opening_balance}
            	 {assign var=closing_bal value=$closing_bal+$row->closing_balance}
            	 {assign var=rech_amt value=$rech_amt+$row->recharge_amount}
	             
              {/foreach}
              <tr class="info">
              <td>Grand Total</td>
              <td align="center">{$bkd_seat_count}</td>
              <td align="right">{$bkd_tck_amount|inr_format}</td>
              <td align="right">{$service_tax|inr_format}</td>
              <td align="right"> {$bkd_comm_amount|inr_format}</td>
              <td align="center">{$ph_bkd_seat_count}</td>
              
              <td align="center">{$cld_seat_count}</td>
              <td align="right">{$refund_amount|inr_format}</td>
              <td align="right">{$cncl_charges|inr_format}</td>
              <td align="right">{$rvke_comm_amount|inr_format}</td>
              <td align="center">{$ph_cld_seat_count}</td>
              
              
              
              <td align="right">{$opening_bal|inr_format}</td>
              <td align="right">{$closing_bal|inr_format}</td>
              <td align="right">{$rech_amt|inr_format}</td>
              
              </tr>

            </tbody>
        </table>


