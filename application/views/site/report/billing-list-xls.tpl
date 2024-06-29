<table border='1'>
    <tr>
        <td colspan="4" align='center' style="font-weight: bold;">Billing Report for the month of {$smarty.request.month}</td>
    </tr>
    <tr style="background-color: #efefef; font-weight: bold">
        <td align="center" width='1%'>#</td>
        <td align="center">Operator Name</td>
        {foreach item=head from=$entity_head key=h}
            <td align='center'>{$head}</td>
        {/foreach}                
    </tr>

    {foreach item=entity from=$entities key=e name=bill}
    <tr>
        <td>{$smarty.foreach.bill.index+1}</td>
        <td>{$e}</td>
        {foreach item=head from=$entity_head key=h}
            <td>
                {foreach item=headitem from=$entity[$head] key=ei}                                
                    {$headitem['value']}
                    {if $headitem['attribute'] !=''} - {$headitem['attribute']}, {/if}                            
                {/foreach}
            </td>
        {/foreach} 
    </tr>                
    {/foreach}  
</table>                
