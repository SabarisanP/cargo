<div class="table-responsive" id="ogpl-trip-table-list">
    {if $result|count == 0}
        <div class="well well-large"> Sorry! No trips were found on the requested date.</div>
    {else}
        <table class="table info_table">
            <thead>
                <tr>
                    <th>{lang('ogpl_local_transit')} Code</th>
                    {*<th>Route</th>*}
                    <th>From Branch</th>
                    <th>To Branch</th>
                    <th>Vehicle</th>
                    <th class="text-center">Loaded</th>
                    <th class="text-center">Unloaded</th>
                    <th class="text-center">Total Lr</th>
                    <th>Remarks</th>
                    <th class="text-center">Action</th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$result item=row}
                    {foreach from=$row->activityType item=activityType}
                        {if $activityType->code == 'INTRNT'}
                            {assign var="loaded_count" value=0}
                            {assign var="unloaded_count" value=0}
                            {assign var="total_count" value=0}
                            {foreach item=list from=$row->transitCargoDetails}
                                {assign var="loaded_count" value=$loaded_count + $list->loadedCount}
                                {assign var="unloaded_count" value=$unloaded_count + $list->unLoadedCount}
                            {/foreach}
                        {assign var="total_count" value=$loaded_count + $unloaded_count}
                        {assign var="isEmptyLoad" value=$loaded_count == -1}

                        {if $loaded_count > 0 || $isEmptyLoad || ($cargo_setting->transitOdometerModelCode=="RTEBSD" && $endOdometer == 0)}
                            <tr>
                                <td>
                                    <span class="txt_green">
                                            {$row->aliasCode}
                                            <a href="javascript:;" title="Click to get Transit History" onclick="getTransitHistory('{$row->code}', '{$row->aliasCode}')"><i class="fa fa-history" aria-hidden="true"></i></a>
                                        </span>
                                        {if $isEmptyLoad}
                                            <br> <span class="badge badge-warning">Empty</span>
                                        {/if}
                                    </td>
                                    <td>
                                        {$row->transitCargoDetails[0]->fromOrganization->name}
                                    </td>
                                    <td>
                                        {$row->transitCargoDetails[0]->toOrganization->name}
                                    </td>
                                    <td>
                                        {$row->busVehicle->registationNumber}<br />
                                        <span class="text-muted">
                                            {$row->vehicleDriver->name}, {$row->vehicleDriver->mobileNumber}
                                        </span>
                                    </td>
                                    <td align="right">{$loaded_count|max:0}</td>
                                    <td align="center">{$unloaded_count|max:0}</td>
                                    <td align="center">
                                        {$total_count|max:0}&nbsp;
                                        {if $total_count >=0}
                                            <i class="fa fa-info-circle" data-toggle="popover" data-html="true" data-content="
                                                <table width='700' class='table'>
                                                    <tr>
                                                        <th>Branch</th>
                                                        <th>Loaded</th>
                                                        <th>Unloaded</th>
                                                        <th>Pending Unload</th>
                                                    </tr> 
                                                    {foreach from=$row->transitRoutes item=route}  
                                                        <tr>
                                                            <td>{$route->organization->name}</td>
                                                            <td align='right'>{$route->loadedCount}</td>
                                                            <td align='right'>{$route->unloadedCount}</td>
                                                            <td align='right'>{$route->pendingUnloadCount}</td>
                                                        </tr>                      
                                                    {/foreach}
                                                </table>">
                                            </i>
                                        {/if}
                                    </td>
                                    {* <td align="center">{$loaded_count|max:0}</td> *}
                                    <td>{($row->remarks) ? $row->remarks : '-'}</td>
                                    {* <td align="center">
                                        <a class="btn btn-success btn-xs" href="#cargo/local-transit-unload-lr?transitCode={$row->code}&date={$row->tripDate}&vehicleCode={$row->busVehicle->code}&redirect=unload" onclick="acceptUnloading();" title="Accept Unload">Accept</a>
                                    </td> *}
                                    <td align="right" nowrap>
                                        <a class="btn btn-success btn-xs" href="#cargo/local-transit-unload-lr?transitCode={$row->code}&date={$row->tripDate}&vehicleCode={$row->busVehicle->code}&redirect=unload&transitType=INTRNT" onclick="{if $isEmptyLoad}acceptEmptyUnload('{$row->code}', '{$row->busVehicle->code}', '{$row->toOrganization->code}'){else}acceptUnloading_local_transit();{/if}" title="Accept Unload">Accept</a>
                                    </td>
                                </tr>
                            {/if}
                        {/if}
                   {/foreach}
                {/foreach}
            </tbody>
        </table>
    {/if}
</div>

<script>
var cargoSetting = {$cargo_setting|json_encode};
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });

    $('[data-toggle="tooltip"]').tooltip({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    
    function acceptUnloading_local_transit() {
        if (!confirm('Do you want to accept unloading?')) {
            event && event.preventDefault();
        }
    }

    function acceptEmptyUnload(code, vehicleCode, toCrganizationCode) {
        event && event.preventDefault();
        if (!confirm('Do you want to accept unloading Empty OGPL?')) {
            return false;
        }

        if (!cargoSetting.mandateRouteWiseUnloadFlag) {
            saveEmptyUnload_localTransit(code);
            return;
        }

        var params = {};
        params.transitCode = code;
        params.vehicleCode = vehicleCode;
        params.toOrganizationCode = toCrganizationCode;
        console.log(params);
        showEndTripDialog(params, function(e) {
            if (e.data && e.data.success == 1) {
                saveEmptyUnload_localTransit(code);
            }
        });
    }

    function saveEmptyUnload_localTransit(code) {
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
            success: function(response) {
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
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
</script>