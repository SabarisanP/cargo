<div class="row">
    <div class="col-md-6">
        {if $type == 'print' && $namespace == 'seenutransports'}
            <div class="">
                <img src="{$base_url}assets/img/Seenu-Cargo-header.jpg" alt="logo" style="max-width: 100%;">
            </div>
        {elseif $type == 'print'}
            <h3 class="bold text-center ">{$namespace}</h3>
        {elseif $namespace == 'seenutransports'}
            <a class="btn btn-success pull-right" href="javascript:;" onclick="print_ogpl_routes('{$transitCode}')">Print</a>
        {else}
            <a class="btn btn-success pull-right" href="javascript:;" onclick="print_cargo_ogpl_routes('{$transitCode}')">Print</a>
        {/if}

        {foreach from=$odometer key=station item=transit}
            <h5 class="bold ">{$station}</h5>
            {assign var=i value=0}
            {foreach from=$transit key=transitTypeCode item=routes}
                <h6 class="bold">&nbsp;
                    {if $transitTypeCode == 'TRNT'}
                        OGPL
                    {elseif $transitTypeCode == 'INTRNT'}
                        Local Transit
                    {elseif $transitTypeCode == 'OTFD'}
                        Door Pickup and Delivery
                    {/if}
                </h6>
                <div class="p_l_15">
                {assign var="edit_permision" value=$action_rights['EDT_ODOMTR']}  {* // permision require *}
                    <table class="table info_table bordered" cellpadding="3">
                        <thead>
                            <tr>
                                <td class="bold" width="25%">Departure & Arrival</td>
                                <td class="bold" width="20%">Location</td>
                                <td class="bold" width="10%">KM</td>
                                <td class="bold" width="20%">Supervisor</td>
                                <td class="bold" width="20%">Date Time</td>
                                {if $edit_permision}
                                    <td class="bold" width="20%"></td>
                                {/if}
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$routes item=row}
                                {* {if $row->startOdometer > 0} *}
                                    <tr>
                                        <td>DEP:Starting KM</td>
                                        <td>{$row->fromOrganization->name}</td>
                                        <td>{if $row->startOdometer > 0}{$row->startOdometer}{else}-{/if}</td>
                                        <td>{$row->fromOrganizationContact->name|default:'-'}</td>
                                        <td nowrap>{$row->departureAt|date_format:$ns_datetime_format|default:'-'}</td>
                                        {if $edit_permision}
                                            {if $row->startOdometer > 0}
                                                <td> <i class="fa fa-edit" onclick="showEditTripdialog('from','{$row->additionalAttribute->fromEntryType}','{$row->additionalAttribute->fromReferenceCode}','{$row->startOdometer}','{$row->departureAt}','{$row->fromOrganization->code}','{$row->fromOrganizationContact->code}');" data-toggle="tooltip" data-title="Notes" data-original-title="Edit Odometer details" title="{$row->startOdometer}"></i><td>
                                            {/if}
                                        {/if}
                                    </tr>
                                    {assign var=i value=$i+1}
                                {* {/if} *}
                                {* {if $row->endOdometer > 0} *}
                                    <tr>
                                        <td>ARR:Closing KM</td>
                                        <td>{$row->toOrganization->name}</td>
                                        <td>{if $row->endOdometer > 0}{$row->endOdometer}{else}-{/if}</td>
                                        <td>{$row->toOrganizationContact->name|default:'-'}</td>
                                        <td nowrap>{$row->arrivalAt|date_format:$ns_datetime_format|default:'-'}</td>
                                        {if $edit_permision}
                                            {if $row->endOdometer}
                                                <td><i class="fa fa-edit" onclick="showEditTripdialog('to','{$row->additionalAttribute->toEntryType}','{$row->additionalAttribute->toReferenceCode}','{$row->endOdometer}','{$row->departureAt}','{$row->toOrganization->code}','{$row->toOrganizationContact->code}');" data-toggle="tooltip" data-title="Notes" data-original-title="Edit Odometer details" title="{$row->endOdometer}"></i><td>
                                            {/if}
                                        {/if}
                                    </tr>
                                    {assign var=i value=$i+1}
                                {* {/if} *}
                                {* {if $row->startOdometer > 0 && $row->endOdometer > 0} *}
                                    <tr>
                                        <td></td>
                                        <td class="bold" align="center">Total</td>
                                        <td class="bold">{if $row->startOdometer > 0 && $row->endOdometer > 0}{($row->endOdometer - $row->startOdometer)}{else}-{/if}</td>
                                        <td></td>
                                        <td class="bold" nowrap>{if $row->runningTime}{$row->runningTime} Hrs{else}-{/if}</td>
                                    </tr>
                                    {assign var=i value=$i+1}
                                {* {/if} *}
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            {/foreach}
            {if $i == 0}
                <tr>
                    <td align="center" colspan="5">No Data Found</td>
                </tr>
            {/if}
        {foreachelse}
            <div class="clearfix"></div><br>
            <div class="well">No Data Found</div>
        {/foreach}
    </div>
    <div class="col-md-6 noprint">
        <div id="transit-via-map"></div>
    </div>
</div>
{* //show edit trip dialogbox start *}
<div id="start-trip-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideEditStartTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="start-trip-panel" class="clearfix" style="padding: 10px 5px;">
          <input type="hidden" name ="entrytype" id="entrytype">
          <input type="hidden" name ="reference" id="reference">
          <input type="hidden" name ="tripat" id="tripAt">
          <input type="hidden" name ="fromOrganization" id="fromOrganization">
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
                    <label class="req h5">Please ensure that you enter a valid odometer reading.</label>
                    <div class="row">
                        <div class="col-md-4">
                            <input type="number" id="start-trip-odo" class="form-control no-spin" placeholder="Odometer">
                        </div>
                        <div class="col-md-4 p_l_n">
                            <div class="input-group col-md-12">
                                <select id="start-trip-supervisor" class="form-control">
                                    <option value="" selected>Select Supervisor</option>
                                    {* {foreach item=row from=$branchContact}
                                        {if $row->category->code == 'SPVSR'}
                                            <option value="{$row->code}">{$row->name}</option>                                    
                                        {/if}
                                    {/foreach} *}
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn" onclick="editStartOGPLTrip();">Change Trip</button>
                            
                    </div>
                </div>
                <div class="col-md-12"><br>
                    <div id="start-trip-action-state"></div>
                </div>
            </div>
    </div>
</div>
{* //show edit trip dialogbox end *}

<style>
    .leaflet-top,
    .leaflet-bottom {
        z-index: 10 !important;
    }

    .leaflet-pane {
        z-index: 4 !important;
    }
</style>

<style type="text/css" media="print">
    @media print {
        table {
            border-collapse: collapse;
            width: 100%;
        }

        table thead th,
        table thead td {
            font-weight: bold;
        }

        table.bordered th,
        table.bordered td {
            border: 1px solid #000;
        }
        .text-center {
            text-align: center;
        }

        .noprint {
            display: none;
        }
    }
</style>

<script>
    var odoDetailsData = {$odoDetails|json_encode};
    var type = {$type|json_encode};
    var fromSupervisor = {$from_supervisors|json_encode};
    var toSupervisor = {$to_supervisors|json_encode};
   

    if (type == 'print') {
        print_cargo_ogpl_routes();
    }
    
    {literal}
        function initViaRouteMap(stations) {
            var map = L.map('transit-via-map', { attributionControl: false }).setView([20.5937, 78.9629], 5);

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

            var markerLayer = L.featureGroup();
            $.each(odoDetailsData || [], function(i, detail) {
                if (Number(detail.fromOrganization.latitude) && Number(detail.fromOrganization.longitude)) {
                    L.marker([detail.fromOrganization.latitude, detail.fromOrganization.longitude])
                        .bindPopup('<b>' + detail.fromOrganization.name + '</b>')
                        .addTo(markerLayer);
                }

                if (Number(detail.toOrganization.latitude) && Number(detail.toOrganization.longitude)) {
                    L.marker([detail.toOrganization.latitude, detail.toOrganization.longitude])
                        .bindPopup('<b>' + detail.toOrganization.name + '</b>')
                        .addTo(markerLayer);
                }
            });

            markerLayer.addTo(map);
            map.fitBounds(markerLayer.getBounds());
        }

        initViaRouteMap();
    {/literal}

    function print_cargo_ogpl_routes(transitCode) {
        var url = base_url + "cargo/ogpl-odometer-report?transitCode="+transitCode+"&type=print";
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }

    function print_ogpl_routes(transitCode) {
        var url = base_url + "cargo/ogpl-route-print?transitCode="+transitCode;
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }
    
    {literal}
    

    function showEditTripdialog(choosedType,entryType,referenceCode,odometer,tripAt,fromOrganization,supervisor) {

        $.ajax({
            type: "POST",
            url:base_url + 'cargo/get-supervisor',
            dataType: 'json',
            data:{
                'organizationCode':fromOrganization,
                'categoryCode':'SPVSR'
            },
            success: function (response) {
                if(response.status == 1){
                    var html = "";
                    $('#start-trip-supervisor').html();
                    html += '<option value="NA">Choose Supervisor</option>';
                    html += response.data.map((item) => {
                        var selectedAttribute = (item.code === supervisor) ? 'selected' : '';
                        return `<option value="${item.code}" ${selectedAttribute}>${item.name}</option>`; 
                    }).join('');
                   $('#start-trip-supervisor').html(html);
                }
            }     
        })

        $('#start-trip-dialog').removeClass('hide');
        $('#last-odometer').text(odometer);
        $('#entrytype').val(entryType);
        $('#reference').val(referenceCode);
        $('#tripAt').val(tripAt);
        $('#fromOrganization').val(fromOrganization);

        var supervisorSelect = $('#start-trip-supervisor');
        var supervisorValue = supervisorSelect.val();
        var supervisorOption = supervisorSelect.find('option[value="' + supervisor + '"]');

        $('#start-trip-dialog').dialog({
            autoOpen: true,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $('#start-trip-dialog .inp_error').removeClass('inp_error');
        $('#start-trip-action-state').removeClass('alert alert-danger alert-success').html('');
        $('#start-trip-odo').val(odometer);
        let tripMoment = moment(tripAt);
        $('#trip-start-date').html(tripMoment.format('DD MMM YYYY'));
        $('#trip-start-time').html(tripMoment.format('hh : mm A'));
    }
    {/literal}

    function hideEditStartTripDialog() {
        $('#start-trip-dialog').dialog('destroy');
        $('#start-trip-dialog').hide();
    }
    function editStartOGPLTrip(){
        let entryType =$('#entrytype').val();
        let tripAt =$('#tripAt').val();
        var data = {};
        data.code = $('#reference').val();
        data.action = entryType;
        data.transitCode = '{$smarty.request.transitCode}';
        data.startOdometer = Number($('#start-trip-odo').val());
        data.fromOrganization = {};
        data.fromOrganization.code =$('#fromOrganization').val();
        data.fromOrganizationContact = {};
        data.fromOrganizationContact.code =$('#start-trip-supervisor').val();
        data.departureAt = moment(tripAt).format('YYYY-MM-DD HH:mm:ss');

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/edit-odometer",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hideEditStartTripDialog();
                        toggleOgplList();
                       
                    }, 3000);
                } else {
                    $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);  
                    $('#start-trip-panel-btn').show();
                }
            }
        });
    }
</script>
