{if $type == 'TICKET'}
Hi {$pass_name}
Thanks for using {$reports->operator->name}

PNR : {$reports->code}
Route : {$reports->fromStation->name} To {$reports->toStation->name}
On : {date('d/m/Y', strtotime($reports->travelDate))}

Seat(s) : {$seat_name|rtrim:', '}
Fare : {$tot_trans|number_format:2}
Bus Type : {formatBusCategory cate_code=$reports->bus->categoryCode}

Boarding : {$reports->fromStation->stationPoint[0]->name} at: {$reports->fromStation->stationPoint[0]->dateTime|date_format:$ns_datetime_format}
{strip}
Address : {if $reports->fromStation->stationPoint[0]->name !=''}
            {$reports->fromStation->stationPoint[0]->name|trim},
            {$reports->fromStation->stationPoint[0]->landmark|trim},
            {$reports->fromStation->stationPoint[0]->address|trim}
        {else}-{/if}
{/strip}

Boarding Contact : {$reports->fromStation->stationPoint[0]->number}

Boarding Directions : https://maps.google.com/?saddr=My+Location&daddr={$reports->fromStation->stationPoint[0]->latitude},{$reports->fromStation->stationPoint[0]->longitude}
{if $ns_domain_url}

{$ns_domain_url}
{/if}
{elseif $type == 'RSNDGPSHJ'}
Dear {$pass_name},

Your travel from {$reports->fromStation->name} To {$reports->toStation->name} is going to start at {date('d/m/Y g:i A', strtotime($reports->fromStation->stationPoint[0]->dateTime))}.

Please reach your boarding point before 15 minutes. 

PNR : {$reports->code}
Boarding : {$reports->fromStation->stationPoint[0]->name}
Boarding Address : {if $reports->fromStation->stationPoint[0]->name !=''}
{strip}
{$reports->fromStation->stationPoint[0]->name|trim}, 
{$reports->fromStation->stationPoint[0]->landmark|trim}, 
{$reports->fromStation->stationPoint[0]->address|trim}
{/strip}
{$reports->fromStation->stationPoint[0]->number|trim}
{else}-{/if}
        
Boarding Directions : https://maps.google.com/?saddr=My+Location&daddr={$reports->fromStation->stationPoint[0]->latitude},{$reports->fromStation->stationPoint[0]->longitude}

Service Number : {$reports->serviceNo}
{if $trips->busVehicle->registationNumber}
Bus No : {$trips->busVehicle->registationNumber}
{/if}
{if $trips->driverMobile}
Driver Contact : {$trips->driverMobile}
{/if}
{if $tracking_link}

Track Bus : {$tracking_link}
{/if}

Have a happy Journey. 

{if $ns_domain_url}
{$ns_domain_url}
{/if}
{/if}