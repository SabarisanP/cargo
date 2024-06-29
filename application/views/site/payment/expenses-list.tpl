<div class='well well-sm'>
    <div class="row">
        <div class="col-md-8" style="margin-top:8px;">
            <span class="bold">Trip :</span> {$smarty.request.trip_name}&nbsp;&nbsp;
            <span class="bold">Vehicle :</span> {$tripinfo->busVehicle->registationNumber} &nbsp;&nbsp;
            <span class="bold">Driver :</span> {$tripinfo->driverName}&nbsp;&nbsp;
            <span class="bold">Trip Date :</span> {$smarty.request.travel_date|date_format:$ns_date_format}
        </div>
        <div class="col-md-4 text-right">
            <button class="btn btn-success" onclick="showEntriesDialog('');">Add Entry</button>
        </div>
    </div>    
</div>
    
{assign var=a value=0}
{assign var=b value=0}
<div id="trip-expense-list">
    {if count($data) > 0}
        <div id="toggle-seat_header3">
            <table class="table table-bordered-light">
                <tr>                    
                    <td align='left' class="bold">Head</td>
                    <td align='left' class="bold">Transaction Mode</td>
                    <td align='left' class="bold">Description</td>
                    <td align='right' class="bold">Revenue</td>
                    <td align='right' class="bold">Expense</td>                    
                    <td align='center' class="bold">Actions</td>
                </tr>

                {foreach item=row from=$data}
                    <tr>                        
                        <td align='left'>{$row->tripCashHead->name}</td>
                        <td align='left'>{$row->transactionMode->name}</td>
                        <td align='left'>{if $row->remarks == ''}-{else}{$row->remarks}{/if}</td>
                        <td align='right'>
                            {if $row->tripCashHead->creditDebitFlag=="Cr"}
                                {$row->amount|number_format:2}
                            {else}
                                0
                            {/if}
                        </td>
                        <td align='right'>
                            {if $row->tripCashHead->creditDebitFlag=="Dr"}
                                {$row->amount|number_format:2}
                            {else}
                                0
                            {/if}
                        </td>
                        
                        <td align='center'>
                            <div class="btn-group btn-group-xs">
                                <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" onclick="showEntriesDialog('{$row->code}')"><i class="fa fa-pencil igreen"></i></a>
                                <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"  onclick="deleteTripExpense('{$row->code}')"><i class="fa fa-trash-o ired"></i></a>
                            </div>
                        </td>
                    </tr>
                    {if $row->tripCashHead->creditDebitFlag=="Cr"}
                        {assign var=a value=$a+$row->amount}                                                                        
                    {else}
                        {assign var=b value=$b+$row->amount}                                                                        

                    {/if}
                {/foreach}
                <tr>
                    <td colspan="3" align="right" class="bold">Total</td>
                    <td align="right" class="success-text bold">{$a|number_format:2}</td>
                    <td align="right" class="warning-text bold">{$b|number_format:2}</td>
                    <td align="right"></td>
                </tr>
                <tr>
                    <td colspan="5" align="right" class="bold"></td>
                    <td align="right">
                        <div class="well well-sm" style="border-radius: 4px; border: 1px solid #b6b8b9;">    
                            <table class="" width="100%" cellpadding="2">
                                <tr>
                                    <td style="border:1px solid #ecf0f1" align="right">Revenue :</td>
                                    <td style="border:1px solid #ecf0f1" align="right">{$a|number_format:2}</td>
                                </tr>
                                <tr>
                                    <td style="border:1px solid #ecf0f1" align="right">Expense :</td>
                                    <td style="border:1px solid #ecf0f1" align="right">{$b|number_format:2}</td>
                                </tr>
                                <tr>
                                    <td style="border-bottom:1px solid #b6b8b9; padding-top: 0px" align="right" colspan="2"></td>
                                </tr>                                 
                                <tr>
                                    <td style="border-top:1px solid #b6b8b9" align="right" class="bold">NetAmount :</td>
                                    <td style="border-top:1px solid #b6b8b9" align="right" class="bold">{($a-$b)|number_format:2}</td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    {else}
        <div class="well well-large" align="center">Sorry! No entries added.</div>
    {/if} 
</div>
<script>
    var entries = {$data|json_encode};
</script>
