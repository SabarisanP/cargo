<div class="table-responsive" id="ogpl-trip-table-list">
    {if $result|count == 0}
        <div class="well well-large"> Sorry! No trips were found on the requested date.</div>
    {else}
        <table class="table info_table">
            <thead>
                <tr>
                    <th>{lang('ogpl')} No</th>
                    <th>Date of Dispatch</th>
                    <th>Vehicle Number</th>
                    <th>Driver Name</th>
                    <th>Source</th>
                    <th>Destination</th>
                    <th>Total Loaded</th>
                    <th class="text-center">Action</th>
                </tr>
            </thead>
            <tbody>
            
                {foreach from=$result item=row}
                  
                    {assign var="visible" value=0}
                    {foreach from=$row->activityType item=activityType}
                        {if  $activityType->code=='HBTRNT' || $activityType->code=='TRNT'}
                            {$visible = 1}
                            {break}
                        {else}
                            {$visible = 0}
                        {/if}
                      
                    {/foreach}
                    {if $visible==1}    
                            {assign var="loaded_count" value=0}
                            {assign var="unloaded_count" value=0}
                            {assign var="total_count" value=0}
                            {assign var="endOdometer" value=0}
                            {foreach item=list from=$row->transitCargoDetails}
                                {assign var="loaded_count" value=$loaded_count + $list->loadedCount}
                                {assign var="unloaded_count" value=$unloaded_count + $list->unLoadedCount}
    
                                {if $list->toStation->code == $user_org_code}
                                    {assign var="endOdometer" value=$list->endOdometer}
                                {/if}
                            {/foreach}
                            {$unloadType = 'End'}
                            {foreach item=val from=$row->viaStations}
                                {assign var="exit" value=0}
                                {if $row->toStation->code == $org_station_code}
                                    {$unloadType = 'End'}
                                    {assign var="exit" value=1} 
                                    {break}
                                {elseif $val->code == $org_station_code}
                                    {$unloadType = 'Arrival'}
                                {/if}
                                {if $exit}
                                    {break}
                                {/if}
                            {/foreach}

                            {assign var="total_count" value=$loaded_count + $unloaded_count}
                            {assign var="isEmptyLoad" value=$loaded_count == -1}

                             {if $loaded_count > 0 || $isEmptyLoad || ($cargo_setting->transitOdometerModelCode=="RTEBSD" && $endOdometer == 0)}
                                <tr>
                                <td nowrap>
                                    {* {$row->name} <br> *}
                                        <span class="txt_green">
                                            {$row->aliasCode}
                                            <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('{$row->code}', '{$row->aliasCode}')"><i class="fa fa-history" aria-hidden="true"></i></a>
                                        </span>
                                        {if $isEmptyLoad}
                                            <br> <span class="badge badge-warning">Empty</span>
                                        {/if}
                                    </td>
                                    <td nowrap>
                                        {$row->audit->updatedAt|date_format:$ns_datetime_format}<br><span class="text-muted">{$row->audit->updatedAt|time_elapsed_string}</span>
                                    </td>
                                    <td>{$row->busVehicle->registationNumber}</td>
                                    <td>{$row->vehicleDriver->name}, {$row->vehicleDriver->mobileNumber}</td>
                                    <td>{$row->fromStation->name}</td>
                                    <td>{$row->toStation->name}</td>
                                    <td>{$loaded_count|max:0}</td>
                                    <td align="right" nowrap>
                                        <a class="btn btn-success btn-xs" href="#cargo/ogpl-unload-lr?transitCode={$row->code}&date={$row->tripDate}&vehicleCode={$row->busVehicle->code}&unloadType={$unloadType}&redirect=unload" onclick="{if $isEmptyLoad}acceptEmptyUnload('{$row->code}', '{$row->busVehicle->code}', '{$row->toStation->code}'){else}acceptUnloading();{/if}" title="Accept Unload">Accept</a>
                                    </td>
                                </tr> 
                            {/if}
                        {/if}
                {/foreach}

            </tbody>
        </table>
    {/if}
</div>

<script>
    var cargoSetting = {$cargo_setting|json_encode};

    $('[data-toggle="popover"]').popover({
        placement: 'right',
        html: true,
        trigger: 'hover'
    });

    function acceptUnloading() {
        if (!confirm('Do you want to accept unloading?')) {
            event && event.preventDefault();
        }
    }

    function acceptEmptyUnload(code, vehicleCode, toOrganizationCode) {
        event && event.preventDefault();
        if (!confirm('Do you want to accept unloading Empty OGPL?')) {
            return false;
        }

        if (cargoSetting.transitOdometerModelCode=="NA") {
            saveEmptyUnload(code);
            return;
        }

        var params = {};
        params.transitCode = code;
        params.vehicleCode = vehicleCode;
        params.toOrganizationCode = toOrganizationCode;
        showEndTripDialog(params, function (e) {
            if (e.data && e.data.success == 1) {
                saveEmptyUnload(code);
            }
        });
    }

    function saveEmptyUnload(code) {
        var data = {};
        data.code = code;

        var loading_overlay = iosOverlay({
            text: "Unloading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + 'cargo/ogplv2-empty-unload',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Unloaded"
                    });
                    getOgplList();
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Unload Failed!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
</script>