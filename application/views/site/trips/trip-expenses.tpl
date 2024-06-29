<div class="text-right">
    <button class="btn btn-success" type="button" id="add-expenses"><i class="fa fa-plus"></i>&nbsp;Add</button>
</div>
<br>
{assign var=a value=0}
{assign var=b value=0}
<div id="trip-expense-list">
    {if count($data) > 0}
        <div class="col-md-11" id="toggle-seat_header3">
            <table class="table seat-visibilty-list3">
                <tr>
                    <th></th>
                    <th>Remarks</th>
                    <th>Trip Head</th>
                    <th>Transaction Mode</th>
                    <th>Amount</th>
                    <th>Actions</th>
                </tr>

                {foreach item=row from=$data}
                    <tr class="del-seat-{$sv->code} hover">
                        <td></td>
                        <td>{if $row->remarks == ''}-{else}{$row->remarks}{/if}</td>
                        <td>{$row->tripCashHeadIO->name}</td>
                        <td>{$row->transactionModeIO->name}</td>
                        <td>{$row->amount}&nbsp;&nbsp;{$row->tripCashHeadIO->creditDebitFlag}</td>
                        <td>
                            <div class="btn-group btn-group-xs">
                                {if $action_rights['TP-ED']>0}
                                    <a href="javascript:;" class="btn btn-default btn-sm {if $row->activeFlag==0}none{/if}" title="Edit" id='tph_edt_{$row->code}' {if $action_rights['TP-ED']!=2} onclick='editTripHeadStatus("{$row->code}")'{/if}><i class="fa fa-pencil igreen"></i></a>
                                    {/if}

                                {if $action_rights['TP-DE']>0}
                                    <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"  {if $action_rights['TP-DE']!=2} onclick="deleteTripExpense('{$row->code}')" {/if}><i class="fa fa-trash-o ired"></i></a>
                                    {/if}
                            </div>
                        </td>
                    </tr>
                    {if $row->tripCashHeadIO->creditDebitFlag=="Cr"}
                        {assign var=a value=$a+$row->amount}                                                                        
                    {else}
                        {assign var=b value=$b+$row->amount}                                                                        

                    {/if}
                {/foreach}
            </table>
        </div>
        <span style="padding: 0 100px 0 371px;color:green;font-weight: bold; font-size: 15px">Credit Amount : {$a}</span>
        <span style="font-size: 15px;color:green;font-weight: bold;">Debit Amount: {$b}</span>
    {else}
        <div class="well well-large" align="center"> Please add trip expenses</div>
    {/if} 
</div>

<div class="box_content toggle-seat-list3 hide" id="addexpenses">
    <div class="col-md-3">
        <label>Remarks</label>
        <textarea id="remarks"  placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="1" cols="10" name="remark" id="remark"></textarea>
    </div>
    <div class="col-md-2">
        <label class="req" for="seat-sch-date">Trip Head</label>
        <select id="tripCashHeadIO" class="form-control col-md-6">
            <option value="">Select</option>
            {foreach item=row from=$triphead} 
                {if $row->name!=''}
                    <option value="{$row->code}">{$row->name}</option>
                {/if}
            {/foreach} 
        </select>
    </div>
    <div class="col-md-2">
        <label class="req" for="seat-sch-date">Transaction Mode</label>
        <select id="transactionModeIO" class="form-control col-md-6">
            <option value="">Select</option>
            {foreach name=o item=row from=$t_mode}
                <option value="{$row->code}">{$row->name}</option>
            {/foreach} 
        </select>
    </div>

    <div class="col-md-2">
        <label class="req">Amount</label>
        <input  placeholder="Amount" id="amount" name="amount"  class="form-control">
    </div>
    <div class="col-md-2">
        <label>&nbsp;</label>
        <button class="btn btn-success" type="button" onclick="saveexpense('{$smarty.request.tripcode}')">Save</button>
        <button class="btn btn-default" type="button" onclick="closeexpense()">Cancel</button>
    </div><div class="clear_fix_both"></div>
    <br>
    <div class="alert fl suc_cre" style="display: none;" id="trp-action-state"></div>   
    <div class="clear_fix_both"></div>

</div>

<input type="hidden" id="trp_code" value="{$smarty.request.tripcode}">           

<script>    
    var triphead = {$data|json_encode}
</script>





