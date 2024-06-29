<table class="table table-bordered">
    <tbody>
    <tr class="info">
      <td colspan="2" align="center">Booked Summery</td>
      <td colspan="2" align="center">Cancelled Summery</td>
    </tr> 
    <tr>
      <td>Ticket Fare (A)</td>
      <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="un_fare">0</span></td>

      <td >Ticket Fare </td> 
      <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="un_c_fare">0</span></td>              
    </tr>

    <tr>
      <td>Commission (B)</td>
      <td align="right"> <i class="fa fa-inr"></i>&nbsp;<span id="un_comm">0</span></td>

      <td>Cancellation Charges</td>  
      <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="un_cnclchrg">0</span></td>         
    </tr>
    <tr>
      <td>GST</td> 
      <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="un_stax">0</span></td>

      <td>Revoke Commission</td>
      <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="un_rvkcomm">0</span></td>              
    </tr>
    <tr>
      <td>Seat Count</td>
      <td align="right"><span id="un_seat" >0</span></td>

      <td>Agent Cancellation Charges (C)</td>
      <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="un_c_ag_charges">0</span></td>             
    </tr>
    <tr>
      <td></td>
      <td align="right"></td>

      <td>Seat Count</td>
      <td align="right"><span id="un_clseat">0</span></td>                        
    </tr>
    <tr>
      <td></td>
      <td align="right"></td>

      <td >Refundable Amount (D)</td> 
      <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="un_refund">0</span></td>               
    </tr>
    </tbody>
</table>


<div class="refunds_vou_top" id="refund_text">
    <b>Payable Amount (A-B-C-D)</b> : <i class="fa fa-inr"></i>&nbsp;<span id="un_ref1" class='vou_btn'>0</span>    
</div>

<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
            <tr class="success">                    
                <th>DOI</th>
                <th>DOJ</th>
                <th>User</th>
                <th>Txn.Code</th>
                <th>Tkt.Code</th>
                <th>Route</th>
                <th>Seat Name</th>
                <th>Ticket Amount</th>                
                <th>Comm Amount</th>
                <th>Revoke Comm Amt</th>
                <th>Cncl Charge</th>
                <th>Agnt Cncl Charge</th>
                <th>Refund Amt</th>
                <th>Txn.Type</th>                    
            </tr>
        </thead>
        <tbody class="body_table">

            {foreach item=row from=$voucher}
                <tr>
                    <td nowrap="">
                        {if $row->transactionType->code == 'TICKBO'}
                            <input type='hidden' class="un_trans hide" data-type="{$row->transactionType->code}" data-commission="{$row->commissionAmount}" data-servicetax="{$row->serviceTax}" data-transcode="{$row->transactionCode}" data-ticketamount="{$row->ticketAmount}" data-seats="{$row->seatCount}"  >
                    	{else}
                            <input type='hidden' class="un_trans hide"  data-type="{$row->transactionType->code}" data-transcode="{$row->transactionCode}" data-refund="{$row->refundAmount}" data-commission="{$row->commissionAmount}"  data-ticketamount="{$row->ticketAmount}" data-cancharges="{$row->cancellationChargeAmount}" data-seats='{$row->seatCount}' data-revoke="{$row->revokeCancelCommissionAmount}" data-agentcharges="{$row->agentCancellationChargeAmount}" >
                    	{/if}
                        
                        {$row->transactionDate|date_format:$ns_date_format}
                    </td>
                    <td nowrap="">{$row->travelDate|date_format:$ns_date_format}</td>
                    <td>{$row->user->name}</td>
                    <td>{$row->transactionCode}</td>
                    <td>{$row->ticketCode}</td>
                    <td>{$row->fromStation->name} - {$row->toStation->name}</td>
                    <td>{$row->seatNames}</td>
                    <td>{$row->ticketAmount}</td>                    
                    <td>&nbsp;{$row->commissionAmount}</td>
                    <td>&nbsp;{$row->revokeCancelCommissionAmount}</td>
                    <td>&nbsp;{$row->cancellationChargeAmount}</td>
                    <td>&nbsp;{$row->agentCancellationChargeAmount}</td>
                    <td>&nbsp;{$row->refundAmount}</td>
                    <td>{if $row->transactionType->code != ''}{$row->transactionType->code}{else}NA{/if}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="14" align="center">Sorry! No data found.</td>                    
                </tr>
            {/foreach}   
        </tbody>
    </table>

</div>
