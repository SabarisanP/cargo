<table class="table">
   <tr>        
        <td align="left" class="bold">Coupon</td>
        <td align="center" class="bold">Discount</td>    
        <td align="left" class="bold">Date Range</td>
        <td align="center" class="bold">Days</td>
        <td align="left" class="bold">Branch</td>
        <td align="center" class="bold">Max Discount Amt</td>
        <td align="center" class="bold">Min Transaction Amt</td>
        <td align="left" class="bold">Payment Type</td>
        <td></td>
    </tr>
    {if $coupon|@count > 0}  
        {foreach key=key from=$coupon item=coup name=clist}
            <tr>
                <td align="left">
                    {$coup->discountCoupon->coupon}<br>
                    <span class="text-muted small">{$coup->discountCoupon->discountCategory->name}</span>
                </td>
                <td align="center">{if $coup->percentageFlag == 'true'}{$coup->value} % {else} <i class="fa fa-inr"></i> {$coup->value}{/if}</td>                
                <td align="left">
                    {$coup->activeFrom|date_format:$ns_date_format} <i class="glyphicon glyphicon-resize-horizontal"></i> {$coup->activeTo|date_format:$ns_date_format}
                </td>
                <td align="center">
                    {if $coup->dayOfWeek!=''}
                        {assign var=bday value=$coup->dayOfWeek} 
                        <div class="btn-group btn-group-days-display">
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                        </div> 
                    {/if}
                </td>
                <td align="left">                    
                    {if $coup->organizations|count >0}
                        {$coup->organizations[0]->name}
                        {if $coup->organizations|@count >1}
                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                {foreach from=$coup->organizations item=org key=i}
                                    {$org->name} <br/>
                                {/foreach}
                            "><span class="label label-success"> {$coup->organizations|count} </span></a>
                        {/if}
                    {else}
                        All 
                    {/if}
                </td>
                <td align="center">{$coup->maxDiscountAmount}</td>
                <td align="center">{$coup->minFreightAmount}</td>
                <td align="left">                    
                    {if $coup->paymentTypes|count >0}
                        {$coup->paymentTypes[0]->name}
                        {if $coup->paymentTypes|@count >1}
                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                {foreach from=$coup->paymentTypes item=val key=i}
                                    {$val->name} <br/>
                                {/foreach}
                            "><span class="label label-success"> {$coup->paymentTypes|count} </span></a>
                        {/if}
                    {else}
                        All 
                    {/if}
                </td>
                <td align="center">
                    <div class="btn-group">
                        <a data-toggle="tooltip" title="Edit" class="btn btn-default btn-xs" href="javascript:;" onclick="addCriteria({$smarty.foreach.clist.index})" >
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>                        
                    </div>
                </td>
             </tr>
        {/foreach}
    {else}
        <tr> <td align="center" colspan="10"> Sorry! No Discounts Found!</td> </tr>
    {/if}   
</table>

<script>
    var discount_list = {$coupon|json_encode};
    $('.has-popover').popover({
        trigger: 'hover',
        placement : 'right',
        html: true
    });
</script>