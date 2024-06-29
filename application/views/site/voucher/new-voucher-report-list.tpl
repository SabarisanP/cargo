<div class="row">
    <div class="col-lg-6">
        <table class="table table-bordered" width="50%">
            <tbody>
            <tr class="info">
              <td colspan="2" align="center">Booked Summary</td>
              <td colspan="2" align="center">Cancel Summary</td>
            </tr> 
            <tr>
              <td>Ticket Fare (A)</td>
              <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="fare">0</span></td>

              <td >Ticket Fare </td> 
              <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="c_fare">0</span></td>              
            </tr>

            <tr>
              <td>Discount (B)</td>
              <td align="right"> <i class="fa fa-inr"></i>&nbsp;<span id="discount">0</span></td>

              <td>Cancellation Charges</td>  
              <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="cnclchrg">0</span></td>         
            </tr>
            <tr>
                <td>Commission (B)</td>
              <td align="right"> <i class="fa fa-inr"></i>&nbsp;<span id="comm">0</span></td>
              

              <td>Revoke Commission</td>
              <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="rvkcomm">0</span></td>              
            </tr>
            <tr>
                <td>AC Bus GST</td> 
              <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="stax">0</span></td>
              

              <td>Cancellation Charges Share (C)</td>
              <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="c_ag_charges">0</span></td>             
            </tr>
            
            <tr>
              <td>Seat Count</td>
              <td align="right"><span id="seat" >0</span></td>

              <td >Refundable Amount (D)</td> 
              <td align="right"><i class="fa fa-inr"></i>&nbsp;<span id="refund">0</span></td>               
            </tr>
            </tbody>
        </table>
        
        <div class="refunds_vou_top" id="refund_text">
            <b>Payable Amount (A-B-C-D)</b> : <i class="fa fa-inr"></i>&nbsp;<span id="ref1" class='vou_btn'>0</span>
            <button class="btn btn-new btn-success hd_btn" type="button" onclick="voucherPopup();">Generate Voucher</button>  
        </div>
        
    </div>
</div>
    


    



    <div class="table-responsive">
        <table id="dt_report_table" class="table table-striped">
            <thead>
                <tr>
                    <th>
                        <input {if $action_rights['UNCHECK-PNR']<=0} disabled="" {/if} type="checkbox" class="gen_vou_checkall" checked>
                    </th>
                    <th>DOT</th>
                    <th>DOJ</th>
                    <th>Txn.Code</th>
                    <th>Tkt.Code</th>
                    <th>Route</th>
                    <!--<th>Ticket Status</th>
                    <th>Seat Name</th>
                    <th>Seat Count</th>-->
                    <th>Fare</th>
                    <th>Discount</th>
                    <th>GST</th>
                    <th>Commission</th>
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
                        <td>
                        {if $row->transactionType->code == 'TICKBO'}
                            <input {if $action_rights['UNCHECK-PNR']<=0} disabled="" {/if} type='checkbox' class="gen_vou_check vou_check" onclick="calculateTransactionsAmount()" data-type="{$row->transactionType->code}" data-commission="{$row->commissionAmount}" data-servicetax="{$row->serviceTax}" data-transcode="{$row->transactionCode}" data-ticketamount="{$row->ticketAmount}" data-seats="{$row->seatCount}" data-discount="{$row->addonsAmount}"  checked="">
                    	{else}
                            <input {if $action_rights['UNCHECK-PNR']<=0} disabled="" {/if} type='checkbox' class="gen_vou_check view_vou_check" onclick="calculateTransactionsAmount()"  data-type="{$row->transactionType->code}" data-transcode="{$row->transactionCode}" data-refund="{$row->refundAmount}" data-commission="{$row->commissionAmount}"  data-ticketamount="{$row->ticketAmount}" data-cancharges="{$row->cancellationChargeAmount}" data-seats='{$row->seatCount}' data-revoke="{$row->revokeCancelCommissionAmount}" data-agentcharges="{$row->agentCancellationChargeAmount}" checked="">
                    	{/if}
                    	
                    	</td>
                        <td>{$row->transactionDate|date_format:$ns_datetime_format}</td>
                        <td>{$row->travelDate|date_format:$ns_date_format}</td>
                        <td>{$row->transactionCode}</td>
                        <td>{$row->ticketCode}<br> {$row->seatNames}</td>
                        <td>{$row->fromStation->name} - {$row->toStation->name}</td>
                        <!--<td>{$row->transactionType->code}</td>
                        <td>{$row->seatNames}</td>
                        <td>{$row->seatCount}</td>-->
                        <td>{$row->ticketAmount}</td>
                        <td>{$row->addonsAmount}</td>
                        <td>&nbsp;{$row->serviceTax}</td>
                        <td>&nbsp;{$row->commissionAmount}</td>
                       	<td>&nbsp;{$row->revokeCancelCommissionAmount}</td>
                       	<td>&nbsp;{$row->cancellationChargeAmount}</td>
                        <td>&nbsp;{$row->agentCancellationChargeAmount}</td>
                        <td>&nbsp;{$row->refundAmount}</td>
                        <td>{if $row->transactionType->code != ''}{$row->transactionType->code}{else}NA{/if}</td>
                        
                    </tr>
                {/foreach}   
            </tbody>
        </table>
        <div class="refunds_vou" id="refund_text">
            <b>Payable Amount</b> : <i class="fa fa-inr"></i>&nbsp;
            <span id="ref" class='vou_btn'>0</span>
            <button class="btn btn-new btn-success hd_btn" type="button" onclick="voucherPopup();">Generate Voucher</button>  
        </div> 
    </div>
                
<input type='hidden' id='total'>
<br><br><br><br>

<script>
    $('.gen_vou_checkall').on('change', function () {
        var $ele = $(this);
        
        $('.gen_vou_check')
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    
        calculateTransactionsAmount();
    });
</script>
