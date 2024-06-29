{if $reports|count ==0}
    <div class="well well-large ">No details Found</div>
{else}

    <div id="main_wrapper" style="max-height: 400px; overflow: auto;">
        <br/>   

        <div>
            <div class="table-responsive">
                <table id="dt_report_table" class="table table-bordered">
                    <thead>
                        <tr bgcolor="#F5F5F5">
                            <th>Txn.Date</th>
                            <th>Travel Date</th>
                            <th>PNR</th>
                            <th>Route</th>                            
                            <th>Seats</th>
                            <th>Ticket Amt</th>                            
                            <th>Comm Amt</th>
                            <th>Revoke Comm Amt</th>
                            <th>Cncl Charge</th>
                            <th>Cncl Agnt Share</th>
                            <th>Refund Amt</th>                            
                        </tr>
                    </thead>
                    <tbody class="voucher-feeds">
                        {assign var=trans value=0}
                        {assign var=total_tk_amt value=0}
                        {assign var=stax value=0}
                        {assign var=comm_amt value=0}
                        
                        {assign var=c_refund value=0}
                        {assign var=c_charges value=0}
                        {assign var=c_agent_charges value=0}
                        
                        {foreach item=row from=$reports}
                            <tr>
                                <td align="center">{$row->transactionDate|date_format:$ns_date_format}</span></td>
                                <td align="center">{$row->travelDate|date_format:$ns_date_format}</td>
                                <td align="left"> <span id="new_name">{$row->ticketCode} </span> <br> {$row->seatNames}</td>
                                <td align="left" nowrap>{$row->fromStation->name} -  {$row->toStation->name}</td>                                
                                <td align="right">{$row->seatCount}</td>
                                <td align="right">{$row->ticketAmount}</td>                                
                                <td align="right">{$row->commissionAmount}</td>
                                <td align="right">{$row->revokeCancelCommissionAmount}</td>
                                <td align="right">{$row->cancellationChargeAmount}</td>
                                <td align="right">{$row->agentCancellationChargeAmount}</td>
                                <td align="right">{$row->refundAmount}</td>                                
                            </tr>
                            {if $row->transactionType->code == 'TICKBO'}
                                {assign var=total_tk_amt value=$total_tk_amt+$row->ticketAmount}                            
                                {assign var=comm_amt value=$comm_amt+$row->commissionAmount}
                            {else}
                                {assign var=c_refund value=$c_refund + $row->refundAmount}
                                {assign var=c_charges value=$c_charges + $row->cancellationChargeAmount}
                                {assign var=c_agent_charges value=$c_agent_charges + $row->agentCancellationChargeAmount}
                            {/if}
                            
                        {/foreach}
                        <tr bgcolor="#F5F5F5">
                            <td colspan="5" align="center">Total</td>
                            <td align="right">{$total_tk_amt}</td>                            
                            <td align="right">{$comm_amt}</td>
                            <td align="right">&nbsp;</td>
                            <td align="right">{$c_charges}</td>
                            <td align="right">{$c_agent_charges}</td>
                            <td align="right">{$c_refund}</td>
                        </tr>
                        {assign var=payable value=($total_tk_amt-$comm_amt) - ($c_refund - $c_agent_charges) }
                        
                        <tr bgcolor="#F5F5F5">
                            <td colspan="5" align="center">Total Payable</td>
                            <td colspan="6" align="right">{$payable|number_format:2}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>


{/if}