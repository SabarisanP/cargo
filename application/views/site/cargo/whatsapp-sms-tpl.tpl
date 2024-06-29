{if $type == 'BOOK'}
Thank you for using {$namespace_name}

{lang('lr')} Number : {$summary->code}
Date: {$summary->bookedAt|date_format:$ns_datetime_format}
Fr: {$summary->fromOrganization->name}
To: {$summary->toOrganization->name}
Item: {$cargoItem|implode:', '}
Amt: {($summary->totalAmount+$summary->totalHandlingAmount+$summary->totalUnloadHandlingAmount+$summary->pickupHandlingAmount+$summary->deliveryHandlingAmount+$summary->serviceCharge+$summary->serviceTax+$summary->hamaliCharge+$summary->passCharge+$summary->docketCharge + $addons_mapped['PODCH']->value + $addons_mapped['DMRCH']->value + $addons_mapped['RNDF']->value + $addons_mapped['INSUR']->value + $addons_mapped['ADJSMT']->value + $addons_mapped['MCNHCH']->value + $addons_mapped['FOVCH']->value + $addons_mapped['DYCH']->value + $addons_mapped['CNCTCH']->value)|number_format:2} [{$pay_type[$summary->paymentType->code]}]

{if isNotNull($ns_domain_url)}
Click to download : https://{$ns_domain_url}/lr/download/{$summary->code}
{/if}
{/if}