<br><br><br><br>
<table width="100%" cellpadding="3" class="font-10">
    <tr>
        <td >
            <table width="100%" cellpadding="3">
                <tr>
                    <td align="left" width="40%">
                        <br/><br/><br/><br/><br/><br>
                        {$summary->fromCustomer->name}<br>                        
                        {$summary->fromStation->name}<br>
                        Mobile : {$summary->fromCustomer->mobileNumber}<br>
                        GSTIN : {$summary->fromCustomerGST->name}
                    </td>                
                    <td align="left" width="43%">
                        <br/><br/><br/><br/><br/><br>
                        {$summary->toCustomer->name} <br>                          
                        {$summary->toStation->name} <br>
                        Moble : {$summary->toCustomer->mobileNumber}<br>
                        GSTIN : {$summary->toCustomerGST->name}
                    </td>
                    <td align="left">
                        <table width="100%" cellpadding="4">
                        <tr>
                            <td>{$summary->fromOrganization->name|truncate:15}</td>
                        </tr>
                        <tr>
                            <td>{$cargoCode}</td>
                        </tr>
                        <tr>
                            <td>{$summary->bookedAt|date_format:$ns_datetime_format}</td>
                        </tr>
                        <tr>
                            <td>{$summary->fromStation->name}</td>
                        </tr>
                        <tr>
                            <td>{$summary->toStation->name}</td>
                        </tr>
                        <tr>
                            <td>{$summary->toOrganization->name}</td>
                        </tr>
                        </table>
                    </td>
                </tr>
            </table>    
        </td>    
    </tr>
</table>
<br><br>

<table width="100%" cellpadding="1" class="font-10">
    <tr>
        <td width="50%"><br><br><br><br>
            <table width="100%" cellpadding="2" >
                {assign var=ic value=0}
                {assign var=qty value=0}
                {assign var=subtotal value=0}
                {assign var=totalitems value=0}
                {assign var=totalweight value=0}
                {assign var=weightunit value=''}
                {foreach from=$summary->itemDetails item=article name=carArt}
                    {assign var=qty value=$qty + $article->itemCount}
                    {assign var=totalitems value=$totalitems+$article->itemCount}
                    {assign var=totalweight value=$totalweight+$article->unitValue}
                    {assign var=weightunit value=$article_unit[$article->unit->code]}
                    <tr>
                        <td align="center" width="17%" >{$article->itemCount}</td>
                        <td align="left" width="25%" >{$article->cargoItem->name|truncate:15}</td>
                        <td align="left" width="50%" >{$article->cargoItem->description[0]|truncate:35}</td>
                        {assign var=subtotal value=$subtotal + $article->computed->freight}
                    </tr>
                    {assign var=ic value=$ic+1}    
                {/foreach} 
                {assign var=ic value=$ic+1}
                
                {for $t=$ic to 2}
                    <tr>
                        <td align="center" width="17%" >&nbsp;</td>
                        <td align="left" width="25%" >&nbsp;</td>
                        <td align="center" width="50%">&nbsp;</td>
                    </tr>
                {/for}

                <tr>
                    <td align="center" width="17%" >{$qty}</td>
                    <td align="center" width="75%" colspan="2"> No Of Items : {$artcle_in_words|upper}</td>
                </tr>
                <tr>
                    <td align="center" width="100%" > HIRE UPTO - {$summary->toStation->name}</td>
                </tr>
                <tr>
                    <td align="center" width="100%" > {$rcm|upper} </td>
                </tr>    
            </table>
        </td>
        <td width="20%">
                <br><br>
            <table width="100%" cellpadding="2">
                <tr>
                    <td align="right" colspan="4"><br><br></td>
                </tr>
                <tr>
                    <td align="right" width="50%">{$ton_actual_wt}</td>
                    <td align="right" width="50%">{$ton_quantity}</td>
                </tr>
                <tr>
                    <td align="right" colspan="2"><br><br></td>
                </tr>
                <tr>
                    <td align="right" width="50%">{$ton_charged_wt}</td>
                    <td align="right" width="50%">{$ton_quantity}</td>
                </tr>
                <tr>
                    <td align="right" colspan="2"><br><br></td>
                </tr>
                <tr>
                    <td align="right" width="50%">0</td>
                    <td align="right" width="50%">0</td>
                </tr>
                <tr>
                    <td align="center" colspan="2" style="font-size:12px; font-weight:bold;">{$payment_type_name|upper|truncate:7}</td>
                </tr>
            </table>
        

        </td>
        <td width="28%" align="right">
            <br><br><br>
            <table width="100%" cellpadding="3">
            <tr>
                <td align="right">{$summary->totalAmount|number_format:2}</td>
            </tr>
            <tr>
                <td align="right">{$summary->pickupHandlingAmount|number_format:2}</td>
            </tr>
            <tr>
                <td align="right">{$summary->deliveryHandlingAmount|number_format:2}</td>
            </tr>
            <tr>
                <td align="right">{$summary->pickupHandlingAmount|number_format:2}</td>
            </tr>
            <tr>
                <td align="right">{$tax_computed->cgstValue|number_format:2}</td>
            </tr>
            <tr>
                <td align="right">{$tax_computed->sgstValue|number_format:2}</td>
            </tr>
            <tr>
                <td align="right">0.00</td>
            </tr>
            <tr>
               {assign var="nettotal" value=$summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value}
                <td align="right" style="font-size:12px; font-weight:bold;">{$nettotal|number_format:2}</td>
            </tr>
            </table>
        </td>
    </tr>
   
</table>

       
