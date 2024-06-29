{$no_of_articles = 0}
{$weight = 0}
{foreach from=$summary->itemDetails item=$article}
    {$no_of_items = $article->cargoItem->name}
    {$no_of_articles = $no_of_articles + $article->itemCount}
    {$weight = $weight + $article->unitValue}
{/foreach}

<table cellpadding="6">
    <tr>
        <td colspan="12"><br><br><br><br><br><br><br></td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td colspan="4">{$summary->fromOrganization->name}</td>
        <td colspan="2"></td>
        <td colspan="4">{$summary->toOrganization->name}</td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td colspan="4">{$summary->fromCustomer->name}</td>
        <td colspan="2"></td>
        <td colspan="4">{$summary->toCustomer->name}</td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td colspan="4">{$summary->code}</td>
        <td colspan="2"></td>
        <td colspan="4">{$summary->bookedAt|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td colspan="4"><br>{$no_of_items}</td>
        <td colspan="2"></td>
        <td colspan="4">{$summary->totalAmount|inr_format}</td>
    </tr>
    {* <tr>
        <td colspan="2"></td>
        <td colspan="4"><br><br><br>{$weight}</td>
        <td colspan="6"></td>
    </tr> *}
    <tr>
        <td colspan="2"></td>
        <td colspan="4"><br><br><br>{$no_of_articles}</td>
        <td colspan="6"></td>
    </tr>
    <tr>
        <td colspan="6"></td>
        <td colspan="2"></td>
        <td colspan="4"><br>{$summary->totalHandlingAmount|inr_format}</td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td colspan="4">{$summary->remarks[0]->name}</td>
        <td colspan="2"></td>
        <td colspan="4"><br><br>{$summary->cargoTransactionList[0]->transactionMode->name}</td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td colspan="4">{$smarty.now|date_format:'H:i:s'}</td>
        <td colspan="2"></td>
        <td colspan="4"><br>{$summary->paymentAmount|inr_format}</td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td colspan="10"><br>{$summary->paymentAmount|amount_in_words}</td>
    </tr>
    <tr>
        <td colspan="4"></td>
        <td colspan="8"><br><br>
            {if isNotNull($summary->toCustomerAddress->code) && ($summary->deliveryType->code == 'DYDO' || $summary->deliveryType->code == 'PDDO')}
                <b>{$summary->toCustomer->name|strtolower|ucwords}</b>
                {substr($summary->toCustomerAddress->address1, 0, 25)}, {substr($summary->toCustomerAddress->landmark, 0, 10)}, {substr($summary->toCustomerAddress->station->name, 0, 13)} - {$summary->toCustomerAddress->pincode}
                {$summary->toCustomer->mobileNumber}
            {else}
                <b>{$summary->toOrganization->name|strtolower|ucwords}</b>
                {if isNotNull($summary->toOrganization->address1)}{$summary->toOrganization->address1},{/if}
                {if isNotNull($summary->toOrganization->address2)}{$summary->toOrganization->address2}<br>{/if}
                {$summary->toOrganization->contact}
            {/if}
        </td>
    </tr>
</table>