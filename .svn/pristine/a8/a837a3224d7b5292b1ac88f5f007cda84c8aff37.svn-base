<div class="table-responsive" style="width: 70%;">
    <table id="dt_ack" class="table table-bordered">
        <thead>
            <tr class="success">
                <th>Name</th>
                <th>Vehicle</th>
                <th>Ownership Type</th>
                <th>Remarks</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row key=k from=$vehicletariff}
                {if $tariffType == 'LOC' && $row->tariffType == 'LOC'}
                    <tr id="{$row->code}" class="tr-hover" onclick="toggleRateCard('{$row->code}');">
                        <td>{$row->name}</td>
                        <td nowrap="nowrap">
                            {if ($row->vehicles|@count) >= 1}
                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                        {foreach from=$row->vehicles item=vehi}
                                            <li>{$vehi->registationNumber}</li>
                                        {/foreach}
                                    </ul>'>
                                    {if ($row->vehicles|@count) >= 1}{$row->vehicles[0]->registationNumber}{/if}
                                    {if ($row->vehicles|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->vehicles|@count}</span>{/if}
                                </a>
                            {else}
                                Default
                            {/if}
                        </td>
                        <td nowrap="nowrap">{$row->ownershipType->name}</td>
                        <td width="20%">
                            {if isNotNull($row->tariffDetails[0]->remarks)}<span data-toggle="popover" data-content="{$row->tariffDetails[0]->remarks}">{$row->tariffDetails[0]->remarks|truncate:35}{/if}
                        </td>
                        <td>
                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick='addVehicelTariffDialog("{$row->code}")'><i class="fa fa-pencil"></i></a>
                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick='deleteVehicleTariff("{$row->code}")'><i class="fa fa-trash-o"></i></a>
                        </td>
                    </tr>
                {elseif $tariffType == 'OUT' && $row->tariffType == 'OUT'}
                    <tr id="{$row->code}" class="tr-hover" onclick="toggleRateCard('{$row->code}');">
                        <td>{$row->name}</td>
                        <td nowrap="nowrap">
                            {if ($row->vehicles|@count) >= 1}
                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                        {foreach from=$row->vehicles item=vehi}
                                            <li>{$vehi->registationNumber}</li>
                                        {/foreach}
                                    </ul>'>
                                    {if ($row->vehicles|@count) >= 1}{$row->vehicles[0]->registationNumber}{/if}
                                    {if ($row->vehicles|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->vehicles|@count}</span>{/if}
                                </a>
                            {else}
                                Default
                            {/if}
                        </td>
                        <td nowrap="nowrap">{$row->ownershipType->name}</td>
                        <td width="20%">
                            {if isNotNull($row->tariffDetails[0]->remarks)}<span data-toggle="popover" data-content="{$row->tariffDetails[0]->remarks}">{$row->tariffDetails[0]->remarks|truncate:35}{/if}
                        </td>
                        <td>
                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick='addVehicelTariffDialog("{$row->code}")'><i class="fa fa-pencil"></i></a>
                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick='deleteVehicleTariff("{$row->code}")'><i class="fa fa-trash-o"></i></a>                        
                        </td>
                    </tr>
                {/if}
            {/foreach}   
        </tbody>
    </table>

    <table class="hide">
        {foreach item=tariff from=$vehicletariff key=t}
            <tr class="{$tariff->code} hide tariffRateCard">
                <td>
                    <table id="dt_ss_report_table" class="table table-bordered " width="100%">
                        <thead>
                            <tr class="active">
                                <td rowspan="2" align="center">
                                    {if $tariffType == 'LOC'}
                                        {if $cargo_setting->transitLocationModelCode == 'STN'}
                                            Station
                                        {elseif $cargo_setting->transitLocationModelCode == 'BRCH'}
                                            Branch
                                        {/if}
                                    {else}
                                        Route
                                    {/if}
                                </td>
                                <td colspan="2" align="center">Ton</td>
                                <td rowspan="2" align="center">Amount / Km</td>
                                <td rowspan="2" align="center">Total Km</td>
                                <td rowspan="2" align="center">Total Amount</td>
                            </tr>
                            <tr class="active">
                                <td align="center">Start Unit</td>
                                <td align="center">End Unit</td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach item=row from=$tariff->tariffDetails key=k}
                                <tr>
                                    <td nowrap="nowrap">
                                        {if $tariffType == 'LOC'}
                                            {if $cargo_setting->transitLocationModelCode == 'STN'}
                                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                                        {foreach from=$row->stations item=station}
                                                            <li>{$station->name}</li>
                                                        {/foreach}
                                                    </ul>'>
                                                    {if ($row->stations|@count) >= 1}{$row->stations[0]->name}{/if}
                                                    {if ($row->stations|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->stations|@count}</span>{/if}
                                                </a>
                                            {elseif $cargo_setting->transitLocationModelCode == 'BRCH'}
                                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                                        {foreach from=$row->organizations item=branch}
                                                            <li>{$branch->name}</li>
                                                        {/foreach}
                                                    </ul>'>
                                                    {if ($row->organizations|@count) >= 1}{$row->organizations[0]->name}{/if}
                                                    {if ($row->organizations|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->organizations|@count}</span>{/if}
                                                </a>
                                            {/if}
                                        {else}
                                            {if $cargo_setting->transitLocationModelCode == 'STN'}
                                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                                        {foreach from=$row->routes item=route}
                                                            <li>{$route->fromStation->name} - {$route->toStation->name}</li>
                                                        {/foreach}
                                                    </ul>'>
                                                    {if ($row->routes|@count) >= 1}{$row->routes[0]->fromStation->name} - {$row->routes[0]->toStation->name}{/if}
                                                    {if ($row->routes|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->routes|@count}</span>{/if}
                                                </a>
                                            {elseif $cargo_setting->transitLocationModelCode == 'BRCH'}
                                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                                        {foreach from=$row->organizationRoutes item=route}
                                                            <li>{$route->fromOrganization->name} - {$route->toOrganization->name}</li>
                                                        {/foreach}
                                                    </ul>'>
                                                    {if ($row->organizationRoutes|@count) >= 1}{$row->organizationRoutes[0]->fromOrganization->name} - {$row->organizationRoutes[0]->toOrganization->name}{/if}
                                                    {if ($row->organizationRoutes|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->organizationRoutes|@count}</span>{/if}
                                                </a>
                                            {/if}
                                        {/if}
                                    </td>
                                    
                                    <td align='center'>{$row->rateCardList[0]->startUnitValue}</td>
                                    <td align='center'>{$row->rateCardList[0]->endUnitValue}</td>
                                    <td align='right'>{$row->rateCardList[0]->ratePerKm|inr_format}</td>
                                    <td align='center'>{$row->rateCardList[0]->fixedKm}</td>
                                    <td align='right'>{$row->rateCardList[0]->fixedRate|inr_format}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                    <script>
                        $('a[id=popup_msg]').attr('data-toggle', 'popover');
                        $('[data-toggle="popover"]').popover({
                            placement: 'top',
                            html: true,
                            trigger: 'hover'
                        });
                    </script>
                </td>
            </tr>
        {/foreach}
    </table>
</div>