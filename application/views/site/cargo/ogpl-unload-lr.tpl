<div class="brand_top">
    <h3>Unload {lang('ogpl')}</h3>
    <span class="align-right">
        {if count($result) == 0}
            <a href="javascript:;" class="btn btn-primary btn-sm" onclick="refreshTransitData('{$transit_code}')"><i
                    class="fa fa-refresh"></i> Refresh</a>
        {/if}
        {if $smarty.request.redirect == 'unload'}
            <a href="#cargo/ogpl-unload?fill=1" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
        {else}
            <a href="#cargo/ogpl?fill=1" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
        {/if}
    </span>
</div>

{* initialize  *}
{assign var="is_destination" value=1}
{if $unload_type=="Arrival"}
    {$is_destination=0}
{/if}

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row" id="add-ogpl-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h5><b>Transactions</b></h5>
                                    <table id="loaded-lr-table" class="table table-bordered " style="width:99%">
                                        <thead>
                                            <tr class="success">
                                                <td align="center">
                                                    <input type="checkbox" class="all-check"
                                                        onchange="selectAllLoaded(this);checkHandle();" />
                                                </td>
                                                <td align="center">{lang('lr')} No</td>
                                                <td align="center">Booked Date</td>
                                                <td align="center">Booked by</td>
                                                <td align="center">{lang('booking_from_term')}</td>
                                                <td align="center">{lang('booking_to_label')}</td>
                                                <td align="center">{lang('booking_sender_term')}</td>
                                                <td align="center">{lang('booking_receiver_term')}</td>
                                                <td align="center">Payment Status</td>
                                                <td align="center">Cargo Status</td>
                                                <td align="center">Items</td>
                                                <td align="center">Qty</td>
                                                <td align="center">Remarks</td>
                                            </tr>
                                        </thead>
                                        <tbody class="body_table" id="load-ogpl-list">

                                            {foreach item=row1 from=$result key=t1 }
                                                <tr>
                                                    <td align="center" colspan="14" class="bold">{$t1}</td>
                                                </tr>
                                                {foreach item=row from=$row1 key=t }
                                                    {assign var="allowunloadstatus" value=0}
                                                    {if $row->start_odometer == 0 && $cargo_setting->transitOdometerModelCode != 'NA' }
                                                        {assign var="allowunloadstatus" value=1}
                                                    {/if}

                                                    {assign var="additional_status_list" value=explode(',', $row->additional_status_code)}
                                                    <tr class="unload-row-{$row->cargo_code}">
                                                        <td align="center">
                                                            <input type="checkbox"
                                                                class="mainCheckbox ogpl-loaded-lr unload-row-datas-{$row->cargo_code}"
                                                                onclick="checkHandle();"
                                                                {if !in_array($row->load_type, ['FTL', 'PTL']) && !in_array('CGRTN', $additional_status_list) && $row->user_code == $usr_login_id}
                                                                    disabled title="Booked user not allowed to unload"
                                                                {elseif $allowunloadstatus == 1} disabled
                                                                title="Trip not yet started" {else} 
                                                                {/if}
                                                                data-from="{$row->from_station_code}"
                                                                data-to="{$row->to_station_code}" value="{$row->cargo_code}"
                                                                data-from="{$row->from_station_code}"
                                                                data-fromstationname="{$row->from_station_name}"
                                                                data-to="{$row->to_station_code}"
                                                                data-tostationname="{$row->to_station_name}"
                                                                data-status="{$row->cargo_status_code}"
                                                                value="{$row->cargo_code}" />
                                                        </td>
                                                        <td align="center">
                                                            <a href='javascript:;'
                                                                {if $allowunloadstatus == 1}class="badge badge-danger text-white"
                                                                {/if}
                                                                title="{if $allowunloadstatus == 1}Trip not yet started{else}more details{/if}"
                                                                onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>
                                                        </td>
                                                        <td align="left" nowrap>
                                                            {$row->booked_at|date_format:$ns_datetime_format}</td>
                                                        <td align="left">{$row->user_first_name}</td>
                                                        <td align="left">{$row->from_organization_name} -
                                                            {$row->from_station_name}</td>
                                                        <td align="left">{$row->to_organization_name} - {$row->to_station_name}
                                                        </td>
                                                        <td align="left">{$row->from_customer_name} -
                                                            {$row->from_customer_mobile|mask_mobileno}</td>
                                                        <td align="left">{$row->to_customer_name} -
                                                            {$row->to_customer_mobile|mask_mobileno}</td>
                                                        <td align="center">
                                                            {$row->payment_status_code|_cargo_payment_status_badge}
                                                        </td>
                                                        <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                                                        <td align="left">{$row->cargo_item_name}</td>
                                                        <td align="center">{$row->total_item_count}</td>
                                                        <td align="left" width="300">
                                                            <input
                                                                class="form-control remarks-{$row->cargo_code} unload-remarks"
                                                                placeholder="Remarks" />
                                                        </td>
                                                    </tr>
                                                    {* LR-Split Section start *}
                                                    {if $action_rights['LR-SPLTUP'] == 1 && $cargo_setting->cargoPartitionFlag == 1}
                                                        {* permision *}
                                                        {* loop this content Start*}
                                                        {assign var="artical" value=explode('|',$row->item_details)}
                                                        {if $row->cargo_type=="PBO"}
                                                            {assign var="artical_items" value=explode('|',$row->item_portion_details)}
                                                        {/if}
                                                        <tr class="splt-row row-{$row->cargo_code} row-link-{$row->cargo_code}">
                                                            <td colspan="14">
                                                                <div class="well well-sm custom-well" id="cargo-{$row->cargo_code}">
                                                                    <div class="custom-checkbox-group d-flex">
                                                                        {foreach from=$artical key=key item=art}
                                                                            {assign var="carg_items" value=explode(',',$art) }
                                                                            {assign var="art_id" value=$carg_items[0]}
                                                                            {assign var="art_inside" value=explode('-',$carg_items[1]) }
                                                                            {assign var="art_name" value=$art_inside[0]}
                                                                            {assign var="art_qty" value=$art_inside[1]}

                                                                            {if count($artical) ==1 && $art_qty==1}
                                                                                <span class="text-muted">Application cannot be split due to
                                                                                    single article and product in this LR.</span>
                                                                            {else}
                                                                                <div class="d-flex wrapDist artical-group artical{$art_id}">
                                                                                    <div class="d-flex wrapDist">
                                                                                        {if $row->cargo_type=="PBO"}
                                                                                            {assign var="partials" value=$artical_items}
                                                                                            {assign var="partial_items" value=$artical_items[$key]}

                                                                                            {assign var="each_items" value=explode(',',$partial_items)}
                                                                                            {foreach from=$each_items item=box key=key}
                                                                                                <div
                                                                                                    class="custom-checkbox unload-{$row->cargo_code}">
                                                                                                    <input type="checkbox"
                                                                                                        onclick="btnValidation();checkAllValidation({$row->total_item_count},'{$row->cargo_code}','unload');"
                                                                                                        id="checkbox{$art_id}_{$box}-direct"
                                                                                                        value="{$box}" data-value="{$art_id}"
                                                                                                        data-artname="{$art_name}"
                                                                                                        data-artqty="{$art_qty}"
                                                                                                        data-total="{$art_qty}"
                                                                                                        data-cargoid="{$row->cargo_code}"
                                                                                                        class="custom-control-input directbox"
                                                                                                        data-tobranch="{$row->to_organization_code}"
                                                                                                        data-from="{$row->from_station_code}"
                                                                                                        data-to="{$row->to_station_code}"
                                                                                                        data-oldtransitorg="{$row->transit_organization_code}"
                                                                                                        data-oldtransitstn="{$row->transit_station_code}"
                                                                                                        data-cargostatuscode="{$row->cargo_status_code}">
                                                                                                    <label class="custom-control-label"
                                                                                                        for="checkbox{$art_id}_{$box}-direct">
                                                                                                        {$box}
                                                                                                    </label>
                                                                                                </div>
                                                                                            {/foreach}
                                                                                        {else}
                                                                                            {for $box=1 to $art_qty}
                                                                                                <div class="custom-checkbox unload-{$row->cargo_code}">
                                                                                                    <input type="checkbox"
                                                                                                        onclick="btnValidation();checkAllValidation({$row->total_item_count},'{$row->cargo_code}','unload');"
                                                                                                        id="checkbox{$art_id}_{$box}-direct"
                                                                                                        value="{$box}" data-value="{$art_id}"
                                                                                                        data-artname="{$art_name}"
                                                                                                        data-artqty="{$art_qty}"
                                                                                                        data-total="{$art_qty}"
                                                                                                        data-cargoid="{$row->cargo_code}"
                                                                                                        class="custom-control-input directbox"
                                                                                                        data-tobranch="{$row->to_organization_code}"
                                                                                                        data-from="{$row->from_station_code}"
                                                                                                        data-to="{$row->to_station_code}"
                                                                                                        data-oldtransitorg="{$row->transit_organization_code}"
                                                                                                        data-oldtransitstn="{$row->transit_station_code}"
                                                                                                        data-cargostatuscode="{$row->cargo_status_code}">
                                                                                                    <label class="custom-control-label"
                                                                                                        for="checkbox{$art_id}_{$box}-direct">
                                                                                                        {$box}
                                                                                                    </label>
                                                                                                </div>
                                                                                            {/for}
                                                                                        {/if}
                                                                                    </div>
                                                                                    <div class="text-center bg-light artical-container">
                                                                                        {$art_name}
                                                                                    </div>
                                                                                </div>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        
                                                    {/if}
                                                    {*LR-Split Section end *}
                                                {/foreach}
                                            {/foreach}
                                        </tbody>
                                    </table>

                                    <div class="clearfix_both"></div><br />
                                    <div class="row">
                                        <div class="col-md-6">
                                            {if $action_rights['OGPL-UNL-CGOMISS']==1}
                                                <label>&nbsp;</label>
                                                <button class="btn btn-danger" type="button"
                                                    onclick="missingOGPLLr();">Cargo Missing</button>
                                            {/if}
                                        </div>
                                        <div class="col-md-6">
                                            {* <div class="col-md-2 w-auto pull-right">
                                                <label for="ogpl-unload-transit-branch">&nbsp;</label>
                                                <div class="action-btn">
                                                    <button class="btn btn-success pull-right upload-btn none" type="button" onclick="unloadOGPLLr('main');">Unload</button>        
                                                    <button class="btn btn-danger pull-right split-btn none" type="button" onclick="splitLRs();">Split & Unload</button>  
                                                </div>
                                            </div> *}

                                            {* All button section here Start *}
                                            <div class="col-md-2 w-auto pull-right">
                                                <label for="ogpl-unload-transit-branch">&nbsp;</label>
                                                <div class="action-btn">
                                                    {* Unload Btn *}
                                                    <button class="btn btn-success pull-right upload-btn" type="button"
                                                        onclick="unloadOGPLLr('main');">Unload</button>
                                                    {* Partial Btn *}
                                                    <button class="btn btn-success pull-right split-btn" type="button"
                                                        onclick="splitLRs();">Partial Unload</button>
                                                    {* Trip button *}
                                                    <button class="btn btn-warning" id="start-odometer-btn"
                                                        type="button" onclick="showStartTripDialog();">{$unload_type}
                                                        Trip</button>
                                                    {* tript And Unload Btn *}
                                                    <button class="btn unload-trip-btn btn-success pull-right"
                                                        type="button" onclick="showStartTripDialog();">Unload and
                                                        {$unload_type}Trip</button>

                                                    {if in_array('TRIP-CLOSE-APLCBL',$ogpl->activity)}
                                                        <button class="btn btn-sm btn-danger" onclick="updateEndTrip();">Trip Close</button>
                                                    {/if}
                                                    
                                                  
                                                </div>
                                            </div>
                                            {* All button section here end *}

                                            {if $action_rights['OGPL-HUB-LOAD']==1}
                                                <div class="form-group col-md-3 p_r_n pull-right">
                                                    <label for="ogpl-unload-transit-branch">Unload to Hub Branch</label>
                                                    <div class="input-group col-md-12">
                                                        <select id="ogpl-unload-transit-branch"
                                                            name="transitOrganizationCode" class="form-control">
                                                            <option value="" selected="">Select Hub Branch</option>
                                                            {foreach item=row from=$branches}
                                                                {if $row->hubFlag}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/if}
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                            {/if}
                                            {* {if $cargo_setting->transitOdometerModelCode=="RTEBSD"}
                                                {if (!isset($odoDetails) && (in_array('FULL-TRK-LOAD', $ogpl->activity) || in_array('PART-TRK-LOAD', $ogpl->activity))) || (isset($odoDetails) && $odoDetails->endOdometer == 0)}
                                                    <div class="col-md-2 w-auto pull-right">
                                                        <label for="ogpl-unload-transit-branch">&nbsp;</label>
                                                        <button class="btn btn-warning" id="start-odometer-btn" type="button" onclick="showStartTripDialog();">{$unload_type} Trip</button>
                                                    </div>
                                                {/if}

                                            {elseif $cargo_setting->transitOdometerModelCode=="ORGDTN"}
                                                {if $org_station_code == $ogpl->toStation->code}
                                                    {if $odoDetails->endOdometer ==0}
                                                        <button class="btn unload-trip-btn btn-success pull-right" type="button" onclick="showStartTripDialog();">Unload and {$unload_type}Trip</button>
                                                    {else}
                                                        <button class="btn unload-trip-btn btn-success pull-right" type="button" onclick="showStartTripDialog();">Unload and {$unload_type}Trip</button>
                                                    {/if}
                                                {else}

                                                {/if}
                                                {if $odoDetails->endOdometer ==0}
                                                    <button class="btn btn-warning" id="start-odometer-btn" type="button" onclick="showStartTripDialog();">{$unload_type} Trip</button>
                                                {/if}
                                            {else}
                                                {if $odoDetails->endOdometer ==0}
                                                    <button class="btn btn-warning" id="start-odometer-btn" type="button" onclick="showStartTripDialog();">{$unload_type} Trip</button>
                                                {/if}
                                            {/if} *}
                                        </div>
                                        <div class="col-md-6">
                                            <div class="alert pull-left" id="missing-ogpl-action-state"
                                                style="display: none"></div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="alert pull-right" id="unload-ogpl-action-state"
                                                style="display: none"></div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <!--row end-->
                </div>
                <!--content end-->
            </div>
        </div>
    </div>
</div>

<div id="start-trip-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideStartTripDialog();"><i
                class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="start-trip-panel" class="clearfix" style="padding: 10px 5px;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-6 text-center">
                    <img src="assets/img/start-trip.png" width="80%">
                </div>
                <div class="col-md-6 text-right">
                    <h4 class="bold">Arrival Time</h4>
                    <h5 id="trip-start-date"></h5>
                    <h4 id="trip-start-time"></h4>
                    <div class="clearfix"></div>
                    <h5 class="bold">Last odometer Reading</h5>
                    <h4><span id="last-odometer"></span> Km</h4>
                </div>
                <div class="col-md-12">
                    <label class="req h5">Enter odometer reading to End Trip</label>
                    <div class="row">
                        <div class="col-md-4">
                            <input type="number" id="start-trip-odo" class="form-control no-spin"
                                placeholder="Odometer">
                        </div>
                        <div class="col-md-4 p_l_n">
                            <div class="input-group col-md-12">
                                <select id="start-trip-supervisor" class="form-control">
                                    <option value="" selected>Select Supervisor</option>
                                    {foreach item=row from=$branchContact}
                                        {if $row->category->code == 'SPVSR'}
                                            <option value="{$row->code}">{$row->name}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        {if $cargo_setting->transitOdometerModelCode=="ORGDTN"}
                            <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn"
                                onclick="unloadOGPLLrAndEndTrip();">{$unload_type} Trip</button>
                        {elseif $cargo_setting->transitOdometerModelCode=="RTEBSD"}
                            <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn"
                                onclick="startOGPLTrip();">{$unload_type} Trip</button>
                        {else}
                            <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn"
                                onclick="startOGPLTrip();">{$unload_type} Trip</button>
                        {/if}
                        <button type="submit" class="btn btn-warning col-md-3" style="display:none;"
                            id="partial-start-trip-btn" onclick="PartialunloadOGPLLrAndEndTrip(true);">{$unload_type}
                            Trip</button>

                    </div>
                </div>
                <div class="col-md-12"><br>
                    <div id="start-trip-action-state"></div>
                </div>
            </div>
        </form>
    </div>
</div>
{* split Lr pop-up section *}
<div class="panel panel-default col-between popup-split hide">
    <div class="panel-body">
        <div class="pop-close pop-close-splitup">
            <h3>Partial LR's</h3>
            <div>
                <a title="close" href="javascript:;" class="btn-lg" onclick="closeSplitPop();"> <i
                        class="fa fa-times-circle fa-lg"></i> </a>
            </div>
        </div>

        <div class="mt-2 direct-lr-section lr-card">
            <div class="lr-card-header">Partial UnpLoad LR</div>
            <div class="list-group list-group-flush directLoadList">
            </div>
        </div>

        {* <div class="mt-2 link-lr-section lr-card" style="margin-top: 10px;">
                <div class="lr-card-header">Link Load LR</div>
                    <div class="list-group list-group-flush linkLoadList">

                </div>
            </div> *}
    </div>
    <div class="panel-footer">

        <button class="btn btn-success pull-right upload-final none" type="button"
            onclick="unloadOGPLLr('split');">Unload</button>
        <button class="btn btn-success pull-right partial-upload-final-trip" type="button"
            onclick="PartialunloadOGPLLrAndEndTripDialogue(true);">Trip and Unload</button>
        <button class="btn btn-success pull-right upload-final-trip" type="button"
            onclick="PartialunloadOGPLLrAndEndTrip(false);">Unload</button>

    </div>
</div>

<script>
    var vehicle = {$vehicle|json_encode};
    var unloadRemarksList = {$unloadremarks|json_encode};
    var ogplDetailsData = {$ogpl|json_encode};
    var orginStartTrip = ogplDetailsData.activity.includes('ORGN-START-TRIP');


    var endOdometer=Number({$odoDetails->endOdometer});
    var odometer_type='{$cargo_setting->transitOdometerModelCode}';
    var odometerRangeFrom=Number('{$odoDetails->fromOdometerRange}');
    var odometerRangeTo=Number('{$odoDetails->toOdometerRange}');
    var isStation='{$org_station_code}'; //session sation
    var getStation='{$ogpl->toStation->code}';  //ogpl station
    var isDestination={$is_destination};

    //split LR Initialization
    var gatheredData = [];
    var gatheredDataLink = [];
    var gatheredDataLocal = [];
    var globalLrDetails = [];
    var globalLrLinkDetails = [];
    var globalLrLocalDetails = [];
    var totalSplitLrs = [];
    var splittedLRList = [];
    var remainingLR = [];

    $('#start-trip-supervisor').select2();
    $('#ogpl-unload-transit-branch').select2();

    $('.unload-remarks').autocomplete({
        minLength: 0,
        source: $.map(unloadRemarksList || [], i => i.name)
    }).focus(function() {
        $(this).autocomplete('search', '');
    });

    function selectAllLoaded(cb) {
        var $cb = $(cb);

        $('.ogpl-loaded-lr')
            .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $cb.is(':checked'))
            .trigger('change');
    }

    function unloadOGPLLr(param) {
        var data = {};
        data.transitCode = '{$smarty.request.transitCode}';
        data.transitOrganization = {};
        data.transitOrganization.code = $('#ogpl-unload-transit-branch').val() || '';
        data.codes = $('.ogpl-loaded-lr:checked').map(function() {
            var data = {};
            data.code = $(this).val();
            data.cargoStatus = {};
            data.cargoStatus.code = 'CUL';
            data.remarks = [];

            var remarks = {};
            remarks.code = '';
            remarks.name = $(this).closest('tr').find('.unload-remarks').val().trim();
            remarks.cargoStatusCode = 'CUL';
            data.remarks.push(remarks);

            return data;
        }).get();

        data.codes = data.codes.concat(globalLrDetails);
        $('#unload-ogpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#unload-ogpl-action-state').html(loading_popup).show();
        $('#start-odometer-btn').addClass('hide');
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/ogpl-update-unload',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    if (param == 'split') {
                        closeSplitPop();
                    }
                    var errors = [];
                    $.each(response.data.cargoList || [], function(i, state) {
                        if (state.activeFlag != 1) {
                            errors.push(state.code + ' - ' + state.name);
                        }
                    });

                    if (errors.length) {
                        $('#unload-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#unload-ogpl-action-state').html(errors.join('<br/>'));
                    } else {
                        $('#unload-ogpl-action-state').removeClass('alert-danger').addClass(
                        'alert-success');
                        $('#unload-ogpl-action-state').html('Your request processed successfully');
                        window.setTimeout(function() {
                            checkURL();
                        }, 3000);
                    }
                } else {
                    $('#unload-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                    $('#unload-ogpl-action-state').html(response.errorDesc);
                }
            }
        });
    }

    function refreshTransitData(transitCode) {
        var data = {}
        data.transitCode = transitCode;

        var loading_overlay = iosOverlay({
            text: "Refreshing",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + 'cargo/refresh-transit-data',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function() {
                        checkURL();
                    }, 1000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }

    function missingOGPLLr() {
        var data = {};
        data.transitCode = '{$smarty.request.transitCode}';
        data.transitOrganization = {};
        data.transitOrganization.code = $('#ogpl-unload-transit-branch').val() || '';
        data.cargoList = $('.ogpl-loaded-lr:checked').map(function() {
            var data = {};
            data.code = $(this).val();
            data.statusCode = 'CMS';
            data.remarks = [];

            var remarks = {};
            remarks.code = '';
            remarks.name = $(this).closest('tr').find('.unload-remarks').val().trim();
            remarks.cargoStatusCode = 'CMS';
            data.remarks.push(remarks);

            return data;
        }).get();

        if (!data.cargoList || !data.cargoList.length) {
            alert('Please select atleast one LR');
            return;
        }

        if (!confirm('Do you want to update missing status?')) {
            return;
        }

        $('#missing-ogpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#missing-ogpl-action-state').html(loading_popup).show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/ogpl-update-missing',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#missing-ogpl-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#missing-ogpl-action-state').html('Your request processed successfully');
                    window.setTimeout(function() {
                        checkURL();
                    }, 3000);
                } else {
                    $('#missing-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                    $('#missing-ogpl-action-state').html(response.errorDesc);
                }
            }
        });

    }

    function showStartTripDialog() {
        $('#start-trip-dialog').removeClass('hide');
        $('#start-trip-dialog').dialog({
            autoOpen: true,
            width: 550,
            modal: true,
            closeOnEscape: true,
            resizable: false
        });
        $('#start-trip-dialog .inp_error').removeClass('inp_error');
        $('#start-trip-action-state').removeClass('alert alert-danger alert-success').html('');
        $('#start-trip-odo').val('');

        $('#trip-start-date').html(moment().format('DD MMM YYYY'));
        $('#trip-start-time').html(moment().format('hh : mm A'));

        if (vehicle) {
            $('#last-odometer').html(vehicle.lastOdometer);
        }
    }

    function hideStartTripDialog() {
        $('#start-trip-dialog').dialog('destroy');
        $('#start-trip-dialog').hide();
    }

    function startOGPLTrip() {
        var data = {},
            err = 0;
        data.action = 'ARRIVAL';
        data.transitCode = '{$smarty.request.transitCode}';
        data.transitCargo = {};
        data.transitCargo.code = '{$smarty.request.transitCode}';
        data.toOrganization = {};
        data.toOrganization.code = '{$userorgcode}';
        data.endOdometer = Number($('#start-trip-odo').val());
        data.arrivalAt = moment().format('YYYY-MM-DD HH:mm:ss');
        data.toOrganizationContact = {};
        data.toOrganizationContact.code = $('#start-trip-supervisor').val();

        if (ogplDetailsData && ogplDetailsData.activity && ogplDetailsData.activity.includes('FULL-TRK-LOAD')) {
            data.toOrganization = null;
        }

        $('.inp_error').removeClass('inp_error');
        if (isNaN(data.endOdometer) || data.endOdometer < 0) {
            $('#start-trip-odo').addClass('inp_error');
            err++;
        }
        if (vehicle && vehicle.lastOdometer > 0 && data.endOdometer < vehicle.lastOdometer) {
            $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#start-trip-action-state').html('Entered odometer value should be greater than last odometer value');
            return;
        }
        if (err) {
            $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#start-trip-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }
        $('#start-trip-panel-btn').hide();
        $('#start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success')
            .html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-end-odometer",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#start-trip-action-state').addClass('alert').addClass('alert-success').html(
                        'Your request processed successfully');
                    window.setTimeout(function() {
                        hideStartTripDialog();
                        checkURL();
                    }, 3000);
                } else {
                    $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response
                        .errorDesc);
                    $('#start-trip-panel-btn').show();
                }
            }
        });
    }

    {literal}   

    $(document).ready(function() {
        globalSelectionValidation();
    });
    //split LR section
    //splitted LR's objects for direct LRs
        function checkHandle() {
            $('.ogpl-loaded-lr:checked').each(function() {
                var cargoCode = $(this).val();
                $('.row-' + cargoCode).hide();
                $('.row-' + cargoCode).find('.directbox').prop('checked', false);
            });

            $('.ogpl-loaded-lr:not(:checked)').each(function() {
                var cargoCode = $(this).val();
                $('.row-' + cargoCode).show();
            });
            btnValidation();
        }

        btnValidation();

        function btnValidation() {
            var selectedElm = $('.ogpl-loaded-lr:checked').length;
            var splitedElm = $('.directbox:checked').length;
            let parentBtnElement = $('.action-btn'); // parent button
            var unloadTripPartialBtn = $('.partial-upload-final-trip'); // partial unload and trip
            var unloadPartialBtn = $('.upload-final-trip'); // partial unload 
            var tripBtn = $('#start-odometer-btn'); //trip button
            var unLoadBtn = $('.upload-btn'); //unload btn
            var unloadTripBtn = $('.unload-trip-btn'); // unload and Trip 
            var splitBtn = $('.split-btn'); // split button

            // initial state of button action
            unloadTripPartialBtn.hide();
            unloadPartialBtn.hide();
            tripBtn.hide();
            unLoadBtn.hide();
            unloadTripBtn.hide();
            splitBtn.hide();

            if (odometer_type == 'RTEBSD') {
                let selectElBtn = $('.action-btn');
                if (endOdometer == 0) {
                    if (splitedElm > 0 && selectedElm > 0) {
                        splitBtn.show();
                        unloadTripBtn.hide();
                        unloadTripPartialBtn.show();
                    } else if (splitedElm > 0 && selectedElm == 0) {
                        splitBtn.show();
                        unloadTripBtn.hide();
                        unloadTripPartialBtn.show();
                    } else if (splitedElm == 0 && selectedElm > 0) {
                       
                        tripBtn.show();
                        splitBtn.hide();
                    } else {
                        unloadTripBtn.hide();
                        splitBtn.hide();
                    }
                } else {
                    if (splitedElm > 0 && selectedElm > 0) {
                        splitBtn.show();
                        unLoadBtn.hide();
                        unloadPartialBtn.show();
                    } else if (splitedElm > 0 && selectedElm == 0) {
                        splitBtn.show();
                        unLoadBtn.hide();
                        //show partial unload btn
                        unloadPartialBtn.show();
                    } else if (splitedElm == 0 && selectedElm > 0) {
                        unLoadBtn.show();
                        splitBtn.hide();
                    } else {
                        unLoadBtn.hide();
                        splitBtn.hide();
                    }
                }

            } else if (odometer_type == 'ORGDTN') {
                if (orginStartTrip) {
                    if (splitedElm > 0 && selectedElm > 0) {
                        if (endOdometer == 0) {
                            splitBtn.show();
                            unloadTripBtn.hide();
                            unloadTripPartialBtn.show();
                        } else {
                            splitBtn.show();
                            unloadTripBtn.hide();
                            unloadPartialBtn.show();
                        }
                    } else if (splitedElm > 0 && selectedElm == 0) {
                        splitBtn.show();
                        tripBtn.hide();
                        if (endOdometer == 0) {
                            unloadTripBtn.hide();
                            unloadPartialBtn.hide();
                            unloadTripPartialBtn.show();
                        } else {
                            unloadPartialBtn.show();
                        }
                    } else if (selectedElm > 0) {
                        if (endOdometer == 0) {
                            if (isDestination) {
                                unloadTripBtn.show();
                                tripBtn.hide();
                            } else {
                                unloadTripBtn.show();
                                tripBtn.hide();
                            }
                        } else {
                            if (isDestination) {
                                unLoadBtn.show();
                                tripBtn.hide();
                            } else {
                                unLoadBtn.show();
                                tripBtn.hide();
                            }
                        }
                    } else {
                        if (endOdometer == 0) {
                            tripBtn.show();
                            if (isDestination) {}
                        }
                    }

                } else {
                    if (endOdometer == 0) {
                        if (splitedElm > 0 && selectedElm > 0) {
                            splitBtn.show();
                            tripBtn.show();
                            unLoadBtn.hide();
                        } else if (splitedElm > 0 && selectedElm == 0) {
                            splitBtn.show();
                            unloadTripBtn.hide();
                            unloadPartialBtn.show();
                            tripBtn.show();
                        } else if (splitedElm == 0 && selectedElm > 0) {
                            unLoadBtn.show();
                            tripBtn.show();
                            splitBtn.hide();
                        }
                    } else {
                        if (splitedElm > 0 && selectedElm > 0) {
                            splitBtn.show();
                            unLoadBtn.hide();
                        } else if (splitedElm > 0 && selectedElm == 0) {
                            splitBtn.show();
                            unloadTripBtn.hide();
                            unloadPartialBtn.show();
                        } else if (splitedElm == 0 && selectedElm > 0) {
                            unLoadBtn.show();
                            splitBtn.hide();
                        }
                    }

                }
            }else{
                if(selectedElm > 0 && splitedElm ==0){
                   unLoadBtn.show();
                   if(endOdometer == 0){
                       tripBtn.show();
                   }
                }
                else if (splitedElm > 0){
                    unloadPartialBtn.show();
                    splitBtn.show();
                    if(endOdometer == 0){
                       tripBtn.show();
                   }
                }
            }

        }


        function gatherCheckedData() {
            gatheredData = [];
            $('.custom-checkbox-group .directbox:checked').each(function(key, cb) {
                var code = $(this).data('cargoid');
                var $cb = $('.unload-row-datas-' + code);
                var articalId = $(this).data('value');
                var articalName = $(this).data('artname');
                var articalQty = $(this).data('artqty');
                var value = $(this).val();

                var fromStationName = $cb.data('fromstationname');
                var toStationName = $cb.data('tostationname');


                // var remarks=$('.remarks-'+$cb.data('cargoid')+'').val();
                var remarks = $('.remarks-' + code + '').val();
                var cargoStatus = $cb.data('cargostatuscode');

                var unloadObj = {
                    "code": code,
                    "cargoStatus": {
                        "code": "CUL"
                    },
                    "remarks": [{
                        "code": "",
                        "name": remarks,
                        "cargoStatusCode": "CUL"
                    }]
                };

                var existingCargo = gatheredData.find(function(obj) {
                    return obj.code === code;
                });

                if (existingCargo) {
                    var existingArticle = existingCargo.itemDetails.find(function(article) {
                        return article.code === articalId;
                    });

                    if (existingArticle) {
                        // Check if the value is not already present in itemCountPortion
                        if (!existingArticle.itemCountPortion.includes(value)) {
                            existingArticle.itemCountPortion.push(value);
                            existingArticle.itemCount = existingArticle.itemCountPortion.length;
                        }
                    } else {
                        existingCargo.itemDetails.push({
                            code: articalId,
                            articalName: articalName,
                            itemCount: 1,
                            itemCountPortion: [value],
                            activeFlag: 1,
                            "totalItem": articalQty
                        });
                    }
                } else {
                    var dataObject = {
                        code: code,
                        itemDetails: [{
                            code: articalId,
                            articalName: articalName,
                            itemCount: 1,
                            itemCountPortion: [value],
                            activeFlag: 1,
                            "totalItem": articalQty
                        }],
                        'type': 'link',
                        'extraData': {
                            'remarks': remarks,
                            'fromStation': fromStationName,
                            'toStation': toStationName,

                        },
                        'unloadObj': unloadObj
                    };

                    gatheredData.push(dataObject);
                }
            });
            return gatheredData;
        }

        function getdirectLrsSrc() {
            var lrsSrc = [];
            $('.custom-checkbox-group .directbox:checked').each(function(i, cb) {
                var $cb = $(cb);
                var $tr = $cb.closest('tr:first');
                var transitsta = $('.direct-load-branch-sel :selected').data('station');
                var transitorg = $('.direct-load-branch-sel').val();
                var remarks = $('.remarks-' + $cb.data('cargoid') + '').val();
                var cargoStatus = $cb.data('cargostatuscode');
                var unloadObj = {
                    "code": $cb.data('cargoid'),
                    "cargoStatus": {
                        "code": "CUL"
                    },
                    "remarks": [{
                        "code": "",
                        "name": remarks,
                        "cargoStatusCode": "CUL"
                    }]
                };
                lrsSrc.push(unloadObj);
            });
            return lrsSrc;
        }
        // splitted LR's objects end
    function loadSplitLR(lr, type) {
        let splittedLR;
        let lrSRc;
        if (type == "direct") {
            splittedLR = gatheredData;
            lrSRc = getdirectLrsSrc();
        }
        let lrDetails = lrSRc.find(item => item.code === lr);
        let specificLR = splittedLR.find(item => item.code === lr);
        let sendData = JSON.stringify(specificLR);

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/split_lr',
            data: sendData,
            success: function(response) {
                $('.emptyLr').hide();
                let getLrDetails = response.data[0];
                let getRemainLrDetails = response.data[1];
                let btnEl = $('.btn-' + specificLR.code + '');
                btnEl.removeAttr('onclick');
                btnEl.removeClass('btn-success');
                btnEl.addClass('btn-danger');
                btnEl.text('Splitted');
                $('.splittedLR-'+lr+'').html(`<span class="badge badge-success badge-sm">${getLrDetails.code}</span>`);

                splittedLRList.push({
                    mainLr: lr,
                    splitLR: getLrDetails.code,
                });
                var directLrObj = {
                    "code": getLrDetails.code,
                    "cargoStatus": {
                        "code": lrDetails.cargoStatus.code
                    },
                    "remarks": [{
                        "code": "",
                        "name": lrDetails.remarks[0].name,
                        "cargoStatusCode": lrDetails.remarks[0].cargoStatusCode
                    }]
                };
                if (response.status == 1) {
                    if (type == "direct") {
                        globalLrDetails.push(directLrObj);
                        deleteObjectByCode(gatheredData, lr);
                    }
                }

                function deleteObjectByCode(array, codeToDelete) {
                    for (let i = 0; i < array.length; i++) {
                        if (array[i].code === codeToDelete) {
                            array.splice(i, 1);
                            break;
                        }
                    }
                }
            }
        });
    }

    function removeLR(lr, type) {
        getdirectLrsSrc();
        gatherCheckedData();
        if (type == "direct") {
            splittedLR = gatheredData;
            lrSRc = getdirectLrsSrc();
        }
        var currendRow = $('.direct-loded-' + lr + '');
        currendRow.remove();

        var targetEl = $('.unload-' + lr + ' input').prop('checked', false);

        deleteObjectByCode(gatheredData, lr);

        function deleteObjectByCode(array, codeToDelete) {
            for (let i = 0; i < array.length; i++) {
                if (array[i].code === codeToDelete) {
                    array.splice(i, 1);
                    break;
                }
            }
        }

        if (gatheredData.length <= 1) {
            let unLoadBtn = $('.upload-btn');
            unLoadBtn.show();
        }
        btnValidation();
    }
    // Splitted LR's listing page
        function splitLRs() {
            let popHtml = $('.popup-split');
            popHtml.removeClass('hide');
            gatherCheckedData();
            btnValidation();

            let splittedLR = gatheredData;
            let splittedLRLink = gatheredDataLink;
            let splittedLRLocal = gatheredDataLocal;
            let directTable = $('.directLoadList');
            let linkTable = $('.linkLoadList');
            let localTable = $('.localLoadList');

            directTable.empty();
            linkTable.empty();
            localTable.empty();

            $('.direct-lr-section').hide();
            $('.link-lr-section').hide();
            $('.local-lr-section').hide();


            let directHtml = "";
            let linkHtml = "";
            let localHtml = "";

            // direct load split list 
            if (splittedLR.length > 0) {
                $('.direct-lr-section').show();
                $.each(splittedLR, function(key, value) {
                    const splitLRElements = splittedLRList.filter(splr => splr.mainLr === value.code).map(splr => `<span class="badge badge-${splr.mainLr == value.code ? 'success' : 'danger'} badge-sm">${splr.splitLR}</span>`).join('');
                    const itemCountPortionHtml = (portion) => `<div class="badge badge-primary">${portion}</div>`;
                    const itemDetailsHtml = value.itemDetails.map(item => `
                        <div class="article-list px5px border-right">
                            <div class="d-flex">
                                <div class="">
<b>${item.totalItem}</b> out of <b>${item.itemCountPortion.length}</b> items
                                </div>
                            </div>
                            <div class="text-center bg-light artical-container">
${item.articalName}
                            </div>
                        </div>
                    `).join('');

                    directHtml += `
<div class="list-group-item direct-loded-${value.code}">
                        <div class="row">
                            <div class="col-md-11">
                                <div class="row">
                                    <div class="col-md-1" style="padding: 0 4px;">
<h5 class="badge badge-danger">${value.code}</h5>
<div class="splittedLR-${value.code}">${splitLRElements}</div> 
                                    </div>
                                    <div class="col-md-11">
<div class="text-center align-center"><span title="from station"><b>${value.extraData.fromStation}</b></span> <span><i class="fa fa-arrow-right"></i></span> <span title="to station"><b>${value.extraData.toStation}</b></span></div>
                                        <div class="d-flex article-container">
${itemDetailsHtml}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1">
<button class="btn remove-btn-${value.code} btn-sm btn-danger" onclick="removeLR('${value.code}','direct');"> Remove </button> 
                            </div>
                        </div>
                    </div>`;
                });

                directTable.append(directHtml);
            }

            $(popHtml).dialog({
                autoOpen: true,
                height: $(window).height() - 50,
                width: $(window).width() - 100,
                modal: true,
                resizable: false
            });
        }

        function closeSplitPop() {
            $('.popup-split').addClass('hide');
            $('.popup-split').dialog('destroy');
        }

        //close showing unload button after splitting the partition LRs
        function unloadBtnHandle() {
            let setLrs = gatheredData.length - 1;
            let elm = $('.upload-split');
            let exElm = $('.upload-btn');
            setLrs == 0 ? exElm.removeClass('none') : exElm.addClass('none');
            setLrs == 0 ? elm.removeClass('none') : elm.addClass('none');
        }

        function checkAllValidation(totalCount, cargoCode, action) {
            var checkboxes = document.querySelectorAll('.' + action + '-' + cargoCode + ' input[type="checkbox"]');
            var checkedCount = 0;

            checkboxes.forEach(function(checkbox) {
                if (checkbox.checked) {
                    checkedCount++;
                }
            });

            // If all checkboxes are checked
            if (checkedCount === totalCount) {
                let currentRow = $('.' + action + '-' + cargoCode).closest('tr');
                let selectElement = currentRow.prevAll('tr').first().find('td:first input');
                selectElement.prop('checked', true);
                selectElement.prop('indeterminate', false);

                checkboxes.forEach(function(checkbox) {
                    checkbox.checked = false;
                });

                currentRow.hide();
            }

            // If some checkboxes are checked
            if (checkedCount > 0 && checkedCount < totalCount) {
                let currentRow = $('.' + action + '-' + cargoCode).closest('tr');
                let selectElement = currentRow.prevAll('tr').first().find('td:first input');
                selectElement.prop('checked', false);
                selectElement.prop('indeterminate', true);
            }

            // If no checkboxes are checked
            if (checkedCount === 0) {
                let currentRow = $('.' + action + '-' + cargoCode).closest('tr');
                let selectElement = currentRow.prevAll('tr').first().find('td:first input');
                selectElement.prop('checked', false);
                selectElement.prop('indeterminate', false);
            }
            btnValidation();
        }


        //During the page load, ensure that the main LR checkbox is checked, making the split LR elements unselectable.
        loadValidation();

        function loadValidation() {
            $('.mainCheckbox').each(function(index, elm) {
                var cargoId = $(elm).val();
                var splitLrRow = $('.row-' + cargoId);
                if ($(this).prop('disabled')) {
                    splitLrRow.hide();
                } else {
                    splitLrRow.show();
                }
            });
        }
    {/literal}
    function unloadOGPLLrAndEndTrip() {
        var data = {},
            err = 0;
        data.action = 'ARRIVAL';
        data.transitCode = '{$smarty.request.transitCode}';
        data.transitCargo = {};
        data.transitCargo.code = '{$smarty.request.transitCode}';
        data.toOrganization = {};
        data.toOrganization.code = '{$userorgcode}';
        data.endOdometer = Number($('#start-trip-odo').val());
        data.arrivalAt = moment().format('YYYY-MM-DD HH:mm:ss');
        data.toOrganizationContact = {};
        data.toOrganizationContact.code = $('#start-trip-supervisor').val();

        if (ogplDetailsData && ogplDetailsData.activity && ogplDetailsData.activity.includes('FULL-TRK-LOAD')) {
            data.toOrganization = null;
        }

        $('.inp_error').removeClass('inp_error');
        if (odometer_type == "RTEBSD") {
            if (isNaN(data.endOdometer) || data.endOdometer < 0) {
                $('#start-trip-odo').addClass('inp_error');
                err++;
            }
            if (vehicle && vehicle.lastOdometer > 0 && data.endOdometer < vehicle.lastOdometer) {
                $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#start-trip-action-state').html('Entered odometer value should be greater than last odometer value');
                return;
            }
            if (err) {
                $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#start-trip-action-state').html(
                'Please enter/select the values in the field that are marked in red');
                return;
            }
        } else if (odometer_type == "ORGDTN") {
            if (isStation === getStation) { //validate existing flow
                if (vehicle && vehicle.lastOdometer > 0 && data.endOdometer < vehicle.lastOdometer) {
                    $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger')
                    .show();
                    $('#start-trip-action-state').html(
                        'Entered odometer value should be greater than last odometer value');
                    return;
                }
                if (err) {
                    $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger')
                    .show();
                    $('#start-trip-action-state').html(
                        'Please enter/select the values in the field that are marked in red');
                    return;
                }
            } else {

                if ((odometerRangeTo != 0 && data.endOdometer > odometerRangeTo) || (odometerRangeFrom != 0 && data
                        .endOdometer < odometerRangeFrom)) {
                    $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger')
                    .show();
                    $('#start-trip-action-state').html('Entered odometer value should be include than ' +
                        odometerRangeFrom + '- ' + odometerRangeTo + ' value');
                    return;
                    err++;
                }
            }
        } else {}

        // $('#start-trip-panel-btn').hide();
        // $('#start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

        //update and load lrs start

        var lrData = {};
        lrData.transitCode = '{$smarty.request.transitCode}';
        lrData.transitOrganization = {};
        lrData.transitOrganization.code = $('#ogpl-unload-transit-branch').val() || '';
        lrData.codes = $('.ogpl-loaded-lr:checked').map(function() {
            var lrData = {};
            lrData.code = $(this).val();
            lrData.cargoStatus = {};
            lrData.cargoStatus.code = 'CUL';
            lrData.remarks = [];

            var remarks = {};
            remarks.code = '';
            remarks.name = $(this).closest('tr').find('.unload-remarks').val().trim();
            remarks.cargoStatusCode = 'CUL';
            lrData.remarks.push(remarks);

            return lrData;
        }).get();

        lrData.codes = lrData.codes.concat(globalLrDetails);
        $('#unload-ogpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#unload-ogpl-action-state').html(loading_popup).show();
        $('#start-odometer-btn').addClass('hide');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/ogpl-update-unload',
            data: lrData,
            success: function(response) {
                if (response.status == 1) {
                    // if(param=='split'){
                    //     // closeSplitPop();
                    // }
                    //update odameter details start
                    $.ajax({
                        type: "POST",
                        dataType: 'json',
                        url: base_url + "cargo/update-end-odometer",
                        data: data,
                        success: function(response) {
                            if (response.status == 1) {
                                completeTrip = true;
                                $('#start-trip-action-state').addClass('alert').addClass(
                                    'alert-success').html(
                                    'Your request processed successfully');
                                window.setTimeout(function() {
                                    hideStartTripDialog();
                                    checkURL();
                                }, 3000);
                            } else {
                                $('#start-trip-action-state').addClass('alert').addClass(
                                    'alert-danger').html(response.errorDesc);
                                $('#start-trip-panel-btn').show();
                            }
                        }
                    });
                    //update odameter details end
                    var errors = [];
                    $.each(response.data.cargoList || [], function(i, state) {
                        if (state.activeFlag != 1) {
                            errors.push(state.code + ' - ' + state.name);
                        }
                    });
                    if (errors.length) {
                        $('#start-trip-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#start-trip-action-state').html(errors.join('<br/>'));
                    } else {
                        $('#start-trip-action-state').removeClass('alert-danger').addClass('alert-success');
                        $('#start-trip-action-state').html('Your request processed successfully');
                    }
                } else {
                    $('#start-trip-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#start-trip-action-state').html(response.errorDesc);
                }
            }
        });

        //update and load lrs end
    }

    function PartialunloadOGPLLrAndEndTripDialogue() {
        $('#start-trip-btn').hide();
        $('#partial-start-trip-btn').show();
        showStartTripDialog();
    }

    function PartialunloadOGPLLrAndEndTrip($withtrip) {
        let tripData = [];
        if ($withtrip) {
            $('#start-trip-btn').hide();
            $('#partial-start-trip-btn').show();
            var data = {},
                err = 0;
            data.action = 'ARRIVAL';
            data.transitCode = '{$smarty.request.transitCode}';
            data.transitCargo = {};
            data.transitCargo.code = '{$smarty.request.transitCode}';
            data.toOrganization = {};
            data.toOrganization.code = '{$userorgcode}';
            data.endOdometer = Number($('#start-trip-odo').val());
            data.arrivalAt = moment().format('YYYY-MM-DD HH:mm:ss');
            data.toOrganizationContact = {};
            data.toOrganizationContact.code = $('#start-trip-supervisor').val();

            if (ogplDetailsData && ogplDetailsData.activity && ogplDetailsData.activity.includes('FULL-TRK-LOAD')) {
                data.toOrganization = null;
            }

            $('.inp_error').removeClass('inp_error');
            if (odometer_type == "RTEBSD") {
                if (isNaN(data.endOdometer) || data.endOdometer < 0) {
                    $('#start-trip-odo').addClass('inp_error');
                    err++;
                }
                if (vehicle && vehicle.lastOdometer > 0 && data.endOdometer < vehicle.lastOdometer) {
                    $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger')
                    .show();
                    $('#start-trip-action-state').html(
                        'Entered odometer value should be greater than last odometer value');
                    return;
                }
                if (err) {
                    $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger')
                    .show();
                    $('#start-trip-action-state').html(
                        'Please enter/select the values in the field that are marked in red');
                    return;
                }
            } else if (odometer_type == "ORGDTN") {
                if (isStation === getStation) { //validate existing flow
                    if (vehicle && vehicle.lastOdometer > 0 && data.endOdometer < vehicle.lastOdometer) {
                        $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger')
                            .show();
                        $('#start-trip-action-state').html(
                            'Entered odometer value should be greater than last odometer value');
                        return;
                    }
                    if (err) {
                        $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger')
                            .show();
                        $('#start-trip-action-state').html(
                            'Please enter/select the values in the field that are marked in red');
                        return;
                    }
                } else {
                    if ((odometerRangeTo != 0 && data.endOdometer > odometerRangeTo) || (odometerRangeFrom != 0 && data
                            .endOdometer < odometerRangeFrom)) {
                        $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger')
                            .show();
                        $('#start-trip-action-state').html('Entered odometer value should be include than ' +
                            odometerRangeFrom + '- ' + odometerRangeTo + ' value');
                        return;
                        err++;
                    }
                }
                tripData.push(data);
            } else {}
        }

        // $('#start-trip-panel-btn').hide();
        // $('#start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

        //update and load lrs start

        var lrData = {};
        lrData.transitCode = '{$smarty.request.transitCode}';
        lrData.transitOrganization = {};
        lrData.transitOrganization.code = $('#ogpl-unload-transit-branch').val() || '';
        lrData.codes = $('.ogpl-loaded-lr:checked').map(function() {
            var lrData = {};
            lrData.code = $(this).val();
            lrData.cargoStatus = {};
            lrData.cargoStatus.code = 'CUL';
            lrData.remarks = [];

            var remarks = {};
            remarks.code = '';
            remarks.name = $(this).closest('tr').find('.unload-remarks').val().trim();
            remarks.cargoStatusCode = 'CUL';
            lrData.remarks.push(remarks);
            return lrData;
        }).get();
        $('#unload-ogpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#unload-ogpl-action-state').html(loading_popup).show();
        $('#start-odometer-btn').addClass('hide');

        var sendData = {
            'data': lrData ?? [],
            'tripData': tripData,
            'partial': gatheredData ?? [],
        }
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'transitpartialunload/partial-unload',
            data: sendData,
            success: function(resp) {
                if (resp.status == 1) {

                    if ($withtrip) {
                        hideStartTripDialog();
                    }
                    if (resp.data.unloadData.status == 1) {
                        closeSplitPop();
                        var errors = [];
                        $.each(resp.data.unloadData.data.cargoList || [], function(i, state) {
                            if (state.activeFlag != 1) {
                                errors.push(state.code + ' - ' + state.name);
                            }
                        });

                        if (errors.length) {
                            $('#unload-ogpl-action-state').removeClass('alert-success').addClass(
                                'alert-danger')
                            $('#unload-ogpl-action-state').html(errors.join('<br/>'));
                        } else {
                            $('#unload-ogpl-action-state').removeClass('alert-danger').addClass(
                                'alert-success');
                            $('#unload-ogpl-action-state').html('Your request processed successfully');
                            window.setTimeout(function() {
                                checkURL();
                            }, 3000);
                        }
                    } else {
                        $('#unload-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#unload-ogpl-action-state').html(resp.data.unloadData.errorDesc);
                    }
                    //unload success section end
                    //partial response section start
                    resp.data.partial.success.forEach(success => {
                        success(success.code + " - partial success");
                    });
                    resp.data.partial.failed.forEach(failed => {
                        success(failed.code + " - partial success");
                    });
                    //partial response section end
                } else {
                    alert(resp.msg);
                }
            }
        });

        //update and load lrs end
    }

    function success(message) {
        toastr.success('Success', message);
    }

    function globalSelectionValidation() {
        var len = $('.ogpl-loaded-lr').length;
        var disabledLen = $('.ogpl-loaded-lr:disabled').length

        if (len === disabledLen) {
            $('.all-check').prop('disabled', true);
        } else {
            $('.all-check').prop('disabled', false);
        }
    }

    function updateEndTrip(){
        var data = {};
        data.transitCode = '{$smarty.request.transitCode}';

        $.ajax({
            type: "post",
            url: "cargo/ogpl-endtrip",
            data: data,
            success: function(response) {
                response = JSON.parse(response);
               if(response.status == 1){

                   $('#unload-ogpl-action-state').addClass('alert').addClass('alert-success').html(
                        'Your request processed successfully').show();
               }else{
                 $('#unload-ogpl-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc).show();
               }
            }
        });
    }
</script>