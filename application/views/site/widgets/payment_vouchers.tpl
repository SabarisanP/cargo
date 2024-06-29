<div class="table-responsive">
    {if $voucher|count==0} 
        <div class="well well-large"> No voucher found.</div>
    {else}  
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Voucher No</th>
                    <th>Generated At</th>
                    <th>Status</th>
                    <th>Amount</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                {assign var=total_amt value=0}
                {foreach item=row from=$voucher}
                    {if $row->acknowledment_status == "INITD"} 
                        {assign var=total_amt value=$total_amt+$row->transaction_amount}
                    {/if}
                    {if $row->acknowledment_status != "ACKED"}
                    <tr>
                        <td>{$row->transaction_code}</td>
                        <td>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <td>{$f_a_status[$row->acknowledment_status]}</td>
                        <td {if $row->acknowledment_status == "INITD"} class="bold" {/if}>{$row->transaction_amount|number_format:2}</td>
                        <td>
                            <a target="_blank" class="btn btn-default" href="{$base_url}voucher/download?code={$row->transaction_code}" title="Download PDF">Details</a>
                            {if $row->acknowledment_status == "INITD"}    
                            <a class="btn btn-success" href="javascript:;" title="Mark your payment" onclick="makeVoucherPayment('{$row->transaction_code}');">Update Paid</a>                        
                            {/if}
                        </td>
                    </tr>
                    {/if}
                {/foreach}  
                <tr >
                    <td colspan="3" align="right" >Total Payable</td>
                    <td class="bold text-danger" style="font-size: 14px;">{$total_amt|number_format:2}</td>
                    <td>&nbsp;</td>
                </tr>
            </tbody>
        </table>
    {/if}
</div>


<div id="voucher-pay-dialog" class="hide dialog-content-page">
    <div>
        <form role="form" id="form1" class="form-horizontal ">
            
            <div class="col-lg-12 p_l_n">
                <div>
                    <label for="txt_m_name" class="req">Transaction Mode</label>
                    <select id="voc_pay_mode" class="form-control col-md-6">
                        <option value="">Select</option>
                        {foreach name=o item=row from=$f_t_mode key=tmode}
                            <option value="{$tmode}">{$row}</option>
                        {/foreach} 
                    </select>
                </div>
            </div>

            <div class="clear_fix_both"></div>
            <br />

            <div class="col-lg-12 p_l_n">
                <div>
                    <label for="txt_m_name">Remarks</label>
                    <textarea id="voc_pay_remarks"  placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" id="remark"></textarea>
                </div>
            </div>

            <div class="clear_fix_both"></div>
        </form>
    </div>
                    
    <div class="clear_fix_both">   
        <br>
        <div class="alert fl suc_cre" style="display: none;" id="vou-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" id="voc_code" value="" />
            <button class="btn btn-success" type="button" onclick="confirmVoucherPaymentStatus();">Confirm Pay</button>
            <button class="btn btn-default" type="button" onclick="closeVoucherPaymentDialog();">Cancel</button>
        </div>
    </div> 
                    
</div> 

