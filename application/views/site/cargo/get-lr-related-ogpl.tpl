<br>
<div class="table-responsive" id="ogpl-trip-table-list">
    <table class="table info_table">
        <thead>
            <tr>
                <th nowrap>Name / {lang('ogpl')} Code</th>
                <th>Date</th>
                <th>Route</th>
                <th>Vehicle</th>
                <th class="text-right">Loaded</th>
                {* <th class="text-right">Unloaded</th>
                <th class="text-right" nowrap>Total {lang('lr')}</th> *}
                <th class="text-right" nowrap>Total Weight</th>
                <th class="text-center">Action</th>
            </tr>
        </thead>
        <tbody>
            {assign var="i" value=0}
            {foreach from=$result item=row}
                {if $row->cargoActivityType->code == 'TRNT'}
                <tr>
                    <td nowrap>
                        {$row->name} <br>
                        <span class="txt_green">
                            <a href="#cargo/ogpl-chart-details?transitCode={$row->code}&date={$row->tripDate}" title="View Chart" target="_blank">{$row->aliasCode}</a>
                            <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('{$row->code}', '{$row->aliasCode}')"><i class="fa fa-history" aria-hidden="true"></i></a>
                        </span>
                    </td>
                    <td nowrap>
                        {$row->tripDate|date_format:$ns_date_format}
                        
                        {if $row->departureMinutes}
                            <br/>
                            <span class="text-muted">
                                <span title="Departure Time">{min_to_time($row->departureMinutes * 60)}</span> to
                                <span title="Arrival Time">
                                    {if $row->arrivalMinutes > 2880}
                                        {min_to_time(($row->arrivalMinutes - 2880) * 60)} Third Day
                                    {elseif $row->arrivalMinutes > 1440}
                                        {min_to_time(($row->arrivalMinutes - 1440) * 60)} Next Day
                                    {elseif $row->arrivalMinutes}
                                        {min_to_time($row->arrivalMinutes * 60)}
                                    {/if}
                                </span>
                            </span>
                        {/if}
                    </td>
                    <td>
                        {$row->fromStation->name} - {$row->toStation->name}<br/>
                        <span class="text-muted">
                            {foreach from=$row->viaStations item=via key=i name=v}
                                {if $i < 3}
                                    {$via->name}{if !$smarty.foreach.v.last && $i < 4},{/if}
                                {/if}
                            {/foreach}
                            {if $row->viaStations|count > 3}
                                <a href="javascript:;" class="ogpl-via" title="via routes" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
                                    {foreach from=$row->viaStations item=via key=i name=v}
                                        {$via->name}<br/>
                                    {/foreach}
                                    "><i class="fa fa-info-circle"></i></a>
                                {/if}
                        </span>
                    </td>
                    <td>
                        {$row->busVehicle->registationNumber}<br/>
                        <span class="text-muted">
                            {$row->vehicleDriver->name}, {$row->vehicleDriver->mobileNumber}
                        </span>
                    </td>
                    <td align="right">
                        {assign var="loaded_count" value=0}
                        {assign var="unloaded_count" value=0}
                        {assign var="total_count" value=0}
                        {foreach item=list from=$row->transitCargoDetails}
                            {assign var="loaded_count" value=$loaded_count + $list->loadedCount}
                            {assign var="unloaded_count" value=$unloaded_count + $list->unLoadedCount}
                        {/foreach}
                        {assign var="total_count" value=$loaded_count + $unloaded_count}
                        {$loaded_count}
                    </td>
                    {* <td align="right">{$unloaded_count}</td>
                    <td align="right">{$total_count}</td> *}
                    <td align="right">{$row->totalWeight}</td>
                    <td align="right" nowrap>
                        <button class="btn btn-success btn-xs" title="Load" onclick="loadLRToOGPL('{$row->code}')">Load</button>
                    </td>
                </tr>
                {assign var="i" value=$i + 1}
                {/if}
            {/foreach}
            {if $i == 0}
                <tr>
                    <td colspan="100%" align="center" class="hover-background">No Records Found!</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>

<div class="row">
    <div class="col-md-4">
        <div class="input-group  col-md-12">
            <select id="load-ogpl-tpl" class="form-control">
                <option value="" selected="">Select Routes</option>
                {foreach item=tpl from=$ogpltpl}
                    <option value="{$tpl->code}">{$tpl->name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="col-md-3">
        <div class="form-group">
            {* <label for="ogpl-vehicle" class="req">Vehicle</label> *}
            <div class="input-group col-md-12">
                <select id="load-ogpl-vehicle" class="form-control">
                    <option value="" selected="">Select Vehicle</option>
                    {foreach item=row from=$vehicles}
                        {if $row->activeFlag == 1}
                            <option value="{$row->code}">{$row->registationNumber} - {$row->vehicleType->name}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="form-group">
            {* <label for="ogpl-driver-name" class="req">Driver Name</label> *}
            <div class="input-group col-md-12">
                <select id="load-ogpl-driver-name" class="form-control">
                    <option value="" selected="">Select Driver</option>
                    {foreach item=row from=$drivers}
                        {if $row->activeFlag == 1}
                            <option value="{$row->code}">{$row->name}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    <div class="col-md-2 p_r_n text-left">
        <button class="btn btn-success btn-xs m-t-5" title="Load" onclick="loadLRToOGPLAdd()">Create OGPL & Load</button>
    </div>
</div>

<div class="alert hide" id="popup-load-ogpl-action"></div> 
<br>
{* <div class="text-right">
    <button type="button" class="btn btn-default" onclick="hideloadToOGPL()"> <i class="fa fa-arrow-left"></i> Back</button>
</div> *}

<script>
    var ogplTemplates = {$ogpltpl|json_encode};

    $('#load-ogpl-tpl, #load-ogpl-vehicle, #load-ogpl-driver-name').select2();

    $('#ogpl-trip-table-list [data-toggle="popover"]').popover({
        placement: 'right',
        html: true,
        trigger: 'hover'
    });
    $('#ogpl-trip-table-list [data-toggle="tooltip"]').tooltip({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>