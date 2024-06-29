{if $smarty.request.code != ''}
    <ul class="nav nav-tabs" id="tabs_a">                                            
        <li class="active"><a data-toggle="tab" href="#ogpl-notloaded-tab">Load New LR</a></li>
        <li><a data-toggle="tab" href="#ogpl-loaded-tab">Loaded LR</a></li>
    </ul>
{/if}
<div class="tab-content">
    <div id="ogpl-notloaded-tab" class="tab-pane fade in active">

        <div class="row" id="edit-ogpl-search-container">
            <br>
            <div class="col-lg-12">
                <form onsubmit="return false;">
                    <div class="row">
                        <div class="form-group col-md-2">
                            <label for="ogpl-load-from">Booked Date From</label>
                            <div class="input-group">
                                <input type="text" name="fromDate" class="form-control sdate" id="ogpl-load-from" readonly="true" placeholder="Date From">
                                <label class="input-group-addon" for="ogpl-load-from"><i class="fa fa-calendar"></i></label>
                            </div>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="ogpl-load-to">Booked Date To</label>
                            <div class="input-group">
                                <input type="text" name="toDate" class="form-control sdate" id="ogpl-load-to" readonly="true" placeholder="Date To">
                                <label class="input-group-addon" for="ogpl-load-to"><i class="fa fa-calendar"></i></label>
                            </div>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="ogpl-load-from_org">
                                {lang('lr')} To Station 
                                <a href="javascript:;" class="pull-right" onclick="toggleToStations()">Hub Loading</a>
                            </label>
                            <div class="input-group col-md-12">
                                <select id="ogpl-load-org" name="fromOrganizationCode" class="form-control"></select>
                            </div>
                        </div>
                        {if $action_rights['OGPL-HUB-LOAD']==1}
                        <div class="form-group col-md-2">
                            <label for="ogpl-load-transit-branch">Transit Branch</label>
                            <div class="input-group col-md-11">
                                <select id="ogpl-load-transit-branch" name="transitOrganizationCode" class="form-control"></select>
                            </div>
                        </div>
                        {/if}
                        <div class="form-group col-md-2">
                            <label  for="ogpl-load-cargocode">{lang('cargo_code_term')}</label>
                            <div class="input-group col-md-12">
                                <input type="text" class="form-control" id="ogpl-load-cargocode" name="cargoCode" placeholder="{lang('cargo_code_term')}" value="" style="text-transform:uppercase" />     
                            </div>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="">&nbsp;</label>
                            <div class="input-group">
                                <input type="hidden" name="export" id="export" value="">
                                <button type="button" class="btn btn-success" onclick="ogplLRSearchReport();">Get {lang('lr')} List</button>&nbsp;
                                <button type="button" class="btn btn-default btn-clear" onclick="clearogplLRSearch();">Clear</button>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="align-center alert alert-danger pull-left" style="display:none" id="ogpl-load-action_state"></div>
            </div>
        </div>
        <div id="booked-ogpl-search-list"></div>
    </div>
    <div id="ogpl-loaded-tab" class="tab-pane fade"></div>
</div>


<div id="start-trip-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideStartTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="start-trip-panel" class="clearfix" style="padding: 10px 5px;max-height: 600px;overflow-x: hidden;overflow-y: auto;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-4 text-center">
                    <img src="assets/img/start-trip.png" width="65%">
                </div>
                <div class="col-md-4 text-center">
                    <h4 class="bold">Departure Time</h4>
                    <h5 id="trip-start-date"></h5>
                    <h4 id="trip-start-time"></h4>
                </div>
                <div class="col-md-4 text-center">
                    <h5 class="bold">Last odometer Reading</h5>
                    <h5><span id="last-odometer"></span> Km</h5>
                </div>
                <div class="clearfix"></div>

                <div class="col-md-12">
                    <label class="h5">Fill The Following Details To Start Trip</label>
                    <h6 class="bold">Odometer</h6>
                    <div class="row">
                        <div class="col-md-4">
                            <label class="control-label req" for="">Odometer</label>
                            <input type="number" id="start-trip-odo" class="form-control no-spin" placeholder="Odometer">
                        </div>
                        <div class="col-md-4 p_l_n">
                            <div class="input-group col-md-12">
                                <label class="control-label" for="">Supervisor</label>
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
                    </div>

                    <div id="start-trip-expense">
                        <h6 class="bold">Payments</h6>
                        <div class="row">
                            <div id="start-trip-hiring-amt">
                                <div class="col-md-4">
                                    <label class="control-label" for="">Hiring Amount</label>
                                    <input type="number" class="form-control" id="start-trip-hire-amount" placeholder="Hiring Amount" step="any">
                                </div>
                                <div class="clearfix"></div><br>
                            </div>

                            <div class="col-md-4">
                                <label class="control-label" for="">Advance Amount</label>
                                <input type="number" id="start-trip-advance-amount" class="form-control no-spin" placeholder="Advance Amount">
                            </div>
                            <div class="col-md-4">
                                <div class="input-group col-md-12">
                                    <label class="control-label" for="">Payment Mode</label>
                                    <select id="start-trip-adv-paymode" class="form-control" onchange="setStartTripTransactionMode();">
                                        <option value="" selected>Payment Mode</option>
                                        {foreach name=o key=k item=name from=$f_t_mode}
                                            <option value="{$k}">{$name}</option>
                                        {/foreach} 
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 p_l_n">
                                <label class="control-label" for="">Payment By</label>
                                <select id="start-trip-adv-payby" class="form-control">
                                    <option value="" selected>Payment By</option>
                                    {foreach from=$contact item=con key=key}
                                        {foreach from=$con item=val}
                                            {if $val->contactCategory->actionCode == 'BRCH'}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/if}
                                        {/foreach}
                                    {/foreach}
                                </select>
                            </div>
                            <div class="clearfix"></div><br>
                            <div class="hide" id="start-trip-adv-upi-mode-panel">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="start-trip-adv-upi-orgbank">Organization Bank</label>
                                        <select class="form-control" id="start-trip-adv-upi-orgbank">
                                            <option value="">Select Organization Bank</option>
                                            {foreach from=$bankdetail item=val}
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="start-trip-adv-upi-id">UPI ID</label>
                                        <input type="text" class="form-control" id="start-trip-adv-upi-id" maxlength="250" placeholder="UPI ID" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="start-trip-adv-upi-details">Ref. #</label>
                                        <input type="text" class="form-control" id="start-trip-adv-upi-details" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>

                            {* Netbanking *}
                            <div class="hide" id="start-trip-adv-netbanking-mode-panel">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-netbanking-orgbank">Organization Bank</label>
                                        <select class="form-control" id="start-trip-adv-netbanking-orgbank">
                                            <option value="">Select Organization Bank</option>
                                            {foreach from=$bankdetail item=val}
                                                <option value="{$val->code}">{$val->name}, Acc No: {$val->accountNumber}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-netbanking-accholder">Account Holder Name</label>
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-accholder" maxlength="250" placeholder="Account Holder Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="start-trip-adv-netbanking-bankname-div">
                                        <label for="start-trip-adv-netbanking-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-netbanking-details">Ref. #</label>
                                        <input type="text" class="form-control" id="start-trip-adv-netbanking-details" placeholder="Ref. #" autocomplete="off">
                                    </div>
                                </div>
                            </div>

                            {* Cheque *}
                            <div class="hide" id="start-trip-adv-cheque-mode-panel">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-payer">Payer Details</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-payer" maxlength="250" placeholder="Payer Details" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-no">Cheque No</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-no" maxlength="60" placeholder="Cheque No" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-date">Cheque Date</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-date" maxlength="20" placeholder="Cheque Date" autocomplete="off" readonly>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-bankcity">Bank City</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-bankcity" maxlength="90" placeholder="Bank City" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="start-trip-adv-cheque-bankname-div">
                                        <label for="start-trip-adv-cheque-bankname">Bank Name</label>
                                        <input type="text" class="form-control" id="start-trip-adv-cheque-bankname" maxlength="120" placeholder="Bank Name" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="start-trip-adv-cheque-remarks">Remarks</label>
                                        <input type="text" class="form-control" placeholder="Remarks" id="start-trip-adv-cheque-remarks" data-mask="englishonly"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h6 class="bold">Fuel Expense</h6>
                        <div class="row">
                            <div class="col-md-2">
                                <label class="control-label" for="">Fuel Litres</label>
                                <input type="number" id="start-trip-fuel-litres" class="form-control no-spin" placeholder="Fuel Litres">
                            </div>
                            <div class="col-md-2">
                                <label class="control-label" for="">Fuel Rate / Liter</label>
                                <input type="number" class="form-control" id="start-trip-fuel-rate" placeholder="Fuel Rate / Liter" step="any">
                            </div>
                            <div class="col-md-3">
                                <div class="input-group col-md-12">
                                    <label class="control-label" for="">Vendor</label>
                                    <select id="start-trip-fuel-vendor" class="form-control">
                                        <option value="" selected>Select Vendor</option>
                                        {foreach item=row from=$vendors} 
                                            {if $row->contactCategory->actionCode == 'RAC'}
                                                <option value="{$row->code}">{$row->name}</option> 
                                            {/if}
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="input-group col-md-12">
                                    <label for="start-trip-fuel-payment-mode" class="req">Payment Mode</label>
                                    <select id="start-trip-fuel-payment-mode" class="form-control">
                                        <option value="CASH">Cash Payment</option> 
                                        <option value="CRDT">Credit Payment</option> 
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label class="control-label" for="">Fuel Coupon</label>
                                <input type="text" class="form-control" id="start-trip-fuel-coupon" placeholder="Fuel Coupon">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 text-center"><br>
                    <div id="start-trip-action-state"></div>
                    <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn" onclick="startOGPLTrip();" style="float: none;">Start Trip</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div id="end-trip-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideEndTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="end-trip-panel" class="clearfix" style="padding: 10px 5px;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-6 text-center">
                    <img src="assets/img/start-trip.png" width="80%">
                </div>
                <div class="col-md-6 text-right">
                    <h4 class="bold">Arrival Time</h4>
                    <h5 id="trip-end-date"></h5>
                    <h4 id="trip-end-time"></h4>
                    <div class="clearfix"></div>
                    <h5 class="bold">Last odometer Reading</h5>
                    <h4><span id="last-odometer-end-trip"></span> Km</h4>
                </div>
                <div class="col-md-12">
                    <label class="req h5">Enter odometer reading to End Trip</label>
                    <div class="row">
                        <div class="col-md-4">
                            <input type="number" id="end-trip-odo" class="form-control no-spin" placeholder="Odometer">
                        </div>
                        <div class="col-md-4 p_l_n">
                            <div class="input-group col-md-12">
                                <select id="end-trip-supervisor" class="form-control">
                                    <option value="" selected>Select Supervisor</option>
                                    {foreach item=row from=$branchContact}
                                        {if $row->category->code == 'SPVSR'}
                                            <option value="{$row->code}">{$row->name}</option>                                    
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning col-md-3" id="end-trip-btn" onclick="endOGPLTrip();">End Trip</button>
                    </div>
                </div>
                <div class="col-md-12"><br>
                    <div id="end-trip-action-state"></div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    var allStations = {$stations|json_encode};
    var allZone = {$zone|json_encode};
    var loadingAllowed = '{$smarty.request.loadtype}';
    var namespace = {$namespace|json_encode};
    var cargo_setting = {$cargo_setting|json_encode};
    var bankNamesList = {$bank_names_list|json_encode};

    $('#start-trip-adv-cheque-date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true
    });
    $('#start-trip-adv-netbanking-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#start-trip-adv-netbanking-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#start-trip-adv-cheque-bankname').autocomplete({
        minLength: 0,
        source: bankNamesList,
        appendTo: '#start-trip-adv-cheque-bankname-div'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#start-trip-supervisor, #end-trip-supervisor').select2();
    $('#start-trip-fuel-vendor').select2();
    $('#start-trip-adv-payby').select2();
    $('#ogpl-load-from').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#ogpl-load-to').datepicker('setStartDate', e.date);
        $('#ogpl-load-to').datepicker('setEndDate', end);
    });
    $('#ogpl-load-to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'dd-mm-yyyy',
        maxDate: '+365D',
        autoclose: true
    }).datepicker("setDate", new Date()).on('changeDate', function (e) {
        $('#ogpl-load-from').datepicker('setEndDate', e.date);
    });

    {if $namespace == 'royalcargo'}
        $('#ogpl-load-from').datepicker('setStartDate', '-7d');
        $('#ogpl-load-from').datepicker('setDate', '-7d');
    {else}
        $('#ogpl-load-from').datepicker('setDate', '-1m');
    {/if}

    var stationMap = new Map();
    stationMap.set(OGPLFormData.toStation.code, OGPLFormData.toStation.name);
    $.each(OGPLFormData.viaStations || [], function (i, val) {
        stationMap.set(val.code, val.name);
    })

    var stationsOption = [];
    stationMap.forEach(function (val, key) {
        stationsOption.push(new Option(val, key));
    });

    $('#ogpl-load-org')
            .html('<option value="NA">All Stations</option>')
            .append(stationsOption).select2();

    {if $action_rights['OGPL-HUB-LOAD']==1}
        var stationbranch = {$stationbranch|json_encode};
        var branchesOption = [];
        stationMap.forEach(function (val, key) {
            $.each (stationbranch[key] || [], function (i, row) {
                if (!row.code != '{$userorgcode}') {
                    branchesOption.push(new Option(row.name, row.code));
                }
            });
        });
        $('#ogpl-load-transit-branch')
                .html(new Option('{$userorgname}', '{$userorgcode}'))
                .append(branchesOption).select2();
    {/if}

    if (odoDetails && (odoDetails.startOdometer > 0)) {
        $('#start-trip-expense').addClass('hide');
    }

    function toggleToStations() {
        var $zoneGroup = $('<optgroup label="ZONE"/>');
        $.each(allZone || [], function (k, zone) {
            var stationCodes = $.map(zone.stations, s => s.code).join(',');
            $zoneGroup.append(new Option(zone.name, stationCodes));
        });

        var $stationGroup = $('<optgroup label="ALL STATIONS"/>');
        $.each(allStations || [], function (k, station) {
            $stationGroup.append(new Option(station.name, station.code));
        });

        $('#ogpl-load-org')
                .select2('destroy')
                .html('<option value="">Select Station</option>')
                .append($zoneGroup)
                .append($stationGroup)
                .select2()
                .select2('open');
    }

    $('a[href="#ogpl-loaded-tab"]').one('show.bs.tab', function (e) {
        getLoadedOGPL();
    });

    $('select.load-branch').each(function () {
        if ($(this).find('option').length <= 2) {
            $(this).find('option[value=""]').remove();
        }
    });

    if (loadingAllowed == 'RESTRICT') {
        $('a[href="#ogpl-notloaded-tab"]').prop('disabled', true).addClass('disabled').removeAttr('href');
        $('a[href="#ogpl-loaded-tab"]').tab('show');
    } else {
        ogplLRSearchReport();
    }

    function setAllTransitBranch() {
        var tsbnch = $('.load-branch:first').val();
        if(tsbnch==""){
            $('.load-branch:first').addClass('inp_error');
            return;
        }
        $('.load-branch:first').removeClass('inp_error');
        $('.load-branch').each(function () {
            this.value = tsbnch;
        });
    }

    function selectAllBookingOutstation(cb) {
        var $cb = $(cb);

        $('.ogpl-new-items')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked'))
                .trigger('change');
    }

    function loadOGPL() {
        var err = 0;
        var ogplRoutes = {};
        //var loadToHub = $('#ogpl-load-hub').is(':checked');
        var loadToHub = true;
        
        $('.inp_error').removeClass('inp_error');
        
        if($('#load-ogpl-list .ogpl-new-items:checked').length === 0) {
            $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#load-ogpl-action-state').html('Please select atleast one LR');
            $('#load-ogpl-action-state').show();
            return false;
        }

        $('#load-ogpl-list .ogpl-new-items:checked').each(function (i, cb) {
            var $cb = $(cb);            
            var $tr = $cb.parents('tr:first');            
            var transitsta = $tr.find('.load-branch-sel :selected').data('station');
            var transitorg = $tr.find('.load-branch-sel').val();
            if (transitorg == '') {
                $tr.find('.load-branch-sel').addClass('inp_error');
                ogplRoutes = {};
                err++;
                //return false;
            } else if( !loadToHub  && $cb.data('tobranch') != transitorg) {
                $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#load-ogpl-action-state').html($cb.val() + ' not valid for the selected "Transit To Branch"');
                $('#load-ogpl-action-state').show();
                ogplRoutes = {};
                return false;
            }else {
                var route = $cb.data('from') + '-' + $cb.data('to') + '-' + transitorg;
                if (!ogplRoutes[route]) {
                    ogplRoutes[route] = {};
                    ogplRoutes[route].cargoList = [];
                    ogplRoutes[route].from = $cb.data('oldtransitstn');
                    ogplRoutes[route].to = transitsta;
                    ogplRoutes[route].oldTransitOrg = $cb.data('oldtransitorg');
                    ogplRoutes[route].transitOrganization = transitorg;
                }
                ogplRoutes[route].cargoList.push($cb.val());
            }
                
            /*if (loadToHub 
                || $cb.data('to') == OGPLFormData.fromStation.code
                || $cb.data('to') == OGPLFormData.toStation.code
                || OGPLFormData.via.includes($cb.data('from'))
                || OGPLFormData.via.includes($cb.data('to'))) {                

                var route = $cb.data('from') + '-' + $cb.data('to') + '-' + transitorg;
                if (!ogplRoutes[route]) {
                    ogplRoutes[route] = {};
                    ogplRoutes[route].cargoList = [];
                    ogplRoutes[route].from = $cb.data('from');
                    ogplRoutes[route].to = $cb.data('to');
                    ogplRoutes[route].transitOrganization = transitorg;
                }
                ogplRoutes[route].cargoList.push($cb.val());
            } else {
                $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#load-ogpl-action-state').html($cb.val() + ' not valid for the selected Branch. Kinldy check from and to stations');
                $('#load-ogpl-action-state').show();
                ogplRoutes = {};
                return false;
            } */
        });
        
        if(err) {            
            $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#load-ogpl-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#load-ogpl-action-state').show();
        }

        if ($.isEmptyObject(ogplRoutes)) {
            return false;
        }

        $('#load-ogpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#load-ogpl-action-state').html(loading_popup).show();
        $('#load-to-ogpl-btn').prop('disabled', true);

        var data = OGPLFormData;
        data.loadList = _.values(ogplRoutes);

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/load-ogpl-list',
            data: data,
            success: function (response) {
                $('#load-to-ogpl-btn').prop('disabled', false);
                if (response.status == 1) {
                    var errors = [];
                    $.each(response.cargoResponseState || [], function (i, state) {
                        if (state.activeFlag != 1) {
                            errors.push(state.code + ' - ' + state.name);
                        }
                    });

                    OGPLFormData.code = response.OGPLCode;

                    if (errors.length) {
                        $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                        $('#load-ogpl-action-state').html(errors.join('<br/>'));
                    } else {
                        $('#load-ogpl-action-state').removeClass('alert-danger').addClass('alert-success');
                        $('#load-ogpl-action-state').html('Your request processed successfully');
                        
                        window.setTimeout(function () {
                            ogplLRSearchReport();
                        }, 3000);
                    }
                } else {
                    $('#load-ogpl-action-state').removeClass('alert-success').addClass('alert-danger')
                    $('#load-ogpl-action-state').html(response.errorDesc);
                }
            }
        }); 
    }

    function getLoadedOGPL() {
        var data = {};
        data.transitCode = '{$smarty.request.code}';

        $('#ogpl-loaded-tab').html(loading_popup);
        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/loaded-ogpl-list',
            data: data,
            success: function (response) {
                $('#ogpl-loaded-tab').html(response);
            }
        });
    }

    function ogplLRSearchReport() {
        var data = {}, err = 0;
        data.code = OGPLFormData.code;
        data.tripDate = OGPLFormData.tripDate;
        data.fromDate = $('#ogpl-load-from').val();
        data.toDate = $('#ogpl-load-to').val();
        data.toStationCode = $('#ogpl-load-org').val();
        data.transitOrganizationCode = $('#ogpl-load-transit-branch').val();
        data.ogplVia = OGPLFormData.viaStations;
        data.endStation = {}
        data.endStation.code = OGPLFormData.toStation.code;
        data.endStation.name = OGPLFormData.toStation.name;
        data.viaStationCodes = [].concat(OGPLFormData.toStation, OGPLFormData.viaStations).map(i => i.code).join(',');
        data.cargoCode = $('#ogpl-load-cargocode').val();
        
        $('.inp_error').removeClass('inp_error');
        if (data.fromDate == '') {
            $('#ogpl-load-from').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#ogpl-load-to').addClass('inp_error');
            err++;
        }
        if (data.toStationCode == '') {
            $('#ogpl-load-org').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#ogpl-load-action_state').removeClass('alert-success').addClass('alert-danger');
            $('#ogpl-load-action_state').html('Please enter/select the values in the field that are marked in red');
            $('#ogpl-load-action_state').show();
            return false;
        }
        $('#ogpl-load-action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#ogpl-load-action_state').hide();

        $('#booked-ogpl-search-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/booked-ogpl-search-list',
            data: data,
            success: function (response) {
                $('#booked-ogpl-search-list').html(response);
            }
        });
    }

    function clearogplLRSearch() {
        $('#ogpl-load-from').val('');
        $('#ogpl-load-to').val('');

        var stationsOption = [];
        stationMap.forEach(function (val, key) {
            stationsOption.push(new Option(val, key));
        });

        $('#ogpl-load-org')
            .html('<option value="NA">All Stations</option>')
            .append(stationsOption).select2(); // revert hub loading click.

        $('#ogpl-load-org option:first').prop('selected', true).trigger('change');
        $('#booked-ogpl-search-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#ogpl-load-action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#ogpl-load-action_state').html('');
        $('#ogpl-load-action_state').hide();
    }

    function printLoadingSheet() {
        var data = {};
        data.print = 1;
        data.code = '{$smarty.request.code}';
        data.fromDate = $('#ogpl-load-from').val();
        data.toDate = $('#ogpl-load-to').val();
        data.toStationCode = $('#ogpl-load-org').val();
        data.transitOrganizationCode = $('#ogpl-load-transit-branch').val();
        data.vehicleNo = OGPLFormData.busVehicle.registationNumber;
        data.viaStationCodes = [].concat(OGPLFormData.toStation, OGPLFormData.viaStations).map(i => i.code).join(',');

        var url = base_url + "cargo/booked-ogpl-search-list?" + $.param(data);   
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
    }

    function showStartTripDialog() {
        $('#start-trip-dialog').removeClass('hide');
        $('#start-trip-dialog').dialog({
            autoOpen: true,
            width: 800,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $('#start-trip-dialog .inp_error').removeClass('inp_error');
        $('#start-trip-action-state').removeClass('alert alert-danger alert-success').html('');
        $('#start-trip-odo, #start-trip-hire-amount, #start-trip-advance-amount, #start-trip-adv-paymode, #start-trip-fuel-litres, #start-trip-fuel-rate, #start-trip-fuel-coupon').val('');
        $('#start-trip-supervisor, #start-trip-fuel-vendor, #start-trip-adv-payby').val('').trigger('change');
        $('#start-trip-fuel-payment-mode').val('CASH').trigger('change');
        $('#start-trip-hiring-amt').removeClass('hide');

        $('#trip-start-date').html(moment().format('DD MMM YYYY'));
        $('#trip-start-time').html(moment().format('hh : mm A'));

        var vehicle = _.find(OGPLVehicles, o => o.code == OGPLFormData.busVehicle.code) || {};
        if (vehicle.ownershipType.code != "HIRE" && cargo_setting.userAccountModel.code == 'TXRT') {
            $('#start-trip-hiring-amt').addClass('hide');
        }
        $('#last-odometer').html(vehicle.lastOdometer);
    }

    function hideStartTripDialog() {
        $('#start-trip-dialog').dialog('destroy');
        $('#start-trip-dialog').hide();
    }

    function startOGPLTrip() {
        err = 0;
        $('.inp_error').removeClass('inp_error');
        var data = {};

        // odometer
        data.action = 'DEPARTURE';
        data.transitCode = OGPLFormData.code;
        data.transitCargo = {};
        data.transitCargo.code = OGPLFormData.code;
        data.fromOrganization = {};
        data.fromOrganization.code = '{$login_branch}';
        data.startOdometer = Number($('#start-trip-odo').val());
        data.departureAt = moment().format('YYYY-MM-DD HH:mm:ss');
        data.fromOrganizationContact = {};
        data.fromOrganizationContact.code = $('#start-trip-supervisor').val();

        if (!isNull(ogplDetailsData) && !isNull(ogplDetailsData.activity) && (ogplDetailsData.activity.includes('FULL-TRK-LOAD') || ogplDetailsData.activity.includes('PART-TRK-LOAD'))) {
            data.fromOrganization = null;
        }
        
        // odometer
        if (isNaN(data.startOdometer) || data.startOdometer <= 0) {
            $('#start-trip-odo').addClass('inp_error');
            err++;
        }
        var vehicle = _.find(OGPLVehicles, o => o.code == OGPLFormData.busVehicle.code) || {};
        if (vehicle && vehicle.lastOdometer > 0 && data.startOdometer < vehicle.lastOdometer) {
            $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#start-trip-action-state').html('Entered odometer value should be greater than last odometer value');
            return;
        }

        if (isNull(odoDetails) || (odoDetails && (odoDetails.startOdometer == 0))) {
            // fuel expense
            data.fuelExpenseCode = '';
            data.activeFlag = 1;
            data.fuelDate = moment().format('YYYY-MM-DD');
            data.vehicle = {};
            data.vehicle.code = OGPLFormData.busVehicle.code;
            
            data.vendorContact = {};
            data.vendorContact.code = $('#start-trip-fuel-vendor').val();

            data.transactionMode = {};
            data.transactionMode.code = $('#start-trip-fuel-payment-mode').val();

            data.litres = Number($('#start-trip-fuel-litres').val());
            data.pricePerLitre = Number($('#start-trip-fuel-rate').val());
            data.totalAmount = data.litres * data.pricePerLitre;
            data.billNumber = $.trim($('#start-trip-fuel-coupon').val());

            // hiring amount and advance amount
            data.ogpl = [];

            if ((cargo_setting.userAccountModel.code == 'TXRT' && vehicle.ownershipType.code == "HIRE") || cargo_setting.userAccountModel.code != 'TXRT') {
                var hire = {};

                hire.code = '';
                hire.activeFlag = 1;
                hire.amount = Number($('#start-trip-hire-amount').val());
                hire.remarks = '';

                hire.user = {};
                hire.user.code = '{$usr_login_id}';

                hire.transitCargo = {};
                hire.transitCargo.code = OGPLFormData.code;
                
                hire.cashbookType = {};
                hire.cashbookType.code = 'HIRING';

                if (Number(hire.amount) > 0) {
                    data.ogpl.push(hire);
                }
            }
            
            var advance = {};

            advance.code = '';
            advance.activeFlag = 1;
            advance.amount = Number($('#start-trip-advance-amount').val());
            advance.remarks = '';

            advance.user = {};
            advance.user.code = '{$usr_login_id}';

            advance.transitCargo = {};
            advance.transitCargo.code = OGPLFormData.code;

            advance.transactionMode = {};
            advance.transactionMode.code = $('#start-trip-adv-paymode').val();
            
            advance.cashbookType = {};
            advance.cashbookType.code = 'ADVANCE';

            advance.paymentByContact = {};
            advance.paymentByContact.code = $('#start-trip-adv-payby').val();

            if (advance.transactionMode.code == 'UPI') {
                advance.bankDetails = {};
                advance.bankDetails.code = $('#start-trip-adv-upi-orgbank').val();
                advance.addAttr1 = $.trim($('#start-trip-adv-upi-id').val());
                advance.addAttr2 = $.trim($('#start-trip-adv-upi-details').val());
            } else if (advance.transactionMode.code == 'NBK') {
                advance.bankDetails = {};
                advance.bankDetails.code = $('#start-trip-adv-netbanking-orgbank').val();
                advance.addAttr1 = $.trim($('#start-trip-adv-netbanking-accholder').val());
                advance.addAttr2 = $.trim($('#start-trip-adv-netbanking-bankname').val());
                advance.addAttr3 = $.trim($('#start-trip-adv-netbanking-details').val());
            } else if (advance.transactionMode.code == 'CHEQUE') {
                advance.chequeDetails = {};
                advance.chequeDetails.code = $('#start-trip-adv-chq-code').val();
                advance.chequeDetails.activeFlag = 1;

                advance.chequeDetails.organization = {};
                advance.chequeDetails.organization.code = '{$login_branch}';

                advance.chequeDetails.bankDetails = $.trim($('#start-trip-adv-cheque-bankname').val());
                advance.chequeDetails.payerDetails = $.trim($('#start-trip-adv-cheque-payer').val());

                advance.chequeDetails.chequeDate = moment($('#start-trip-adv-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                advance.chequeDetails.chequeNo = $.trim($('#start-trip-adv-cheque-no').val());
                advance.chequeDetails.bankCity = $.trim($('#start-trip-adv-cheque-bankcity').val());

                advance.chequeDetails.chequeStatus = {};
                advance.chequeDetails.chequeStatus.code = 'NEW';

                advance.chequeDetails.remarks = $.trim($('#start-trip-adv-cheque-remarks').val());
            }

            if (Number(advance.amount) > 0) {
                data.ogpl.push(advance);
            }

            // advance amount
            if ((cargo_setting.userAccountModel.code == 'TXRT' && $.inArray(OGPLFormData.cargoActivityType.code, ['OTFD', 'INTRNT']) != -1 && vehicle.ownershipType.code == "OWN" && !isNull(hire) && hire.amount != '') || (cargo_setting.userAccountModel.code != 'TXRT' && !isNull(hire) && hire.amount != '') || advance.amount != '' || advance.transactionMode.code != '' || advance.paymentByContact.code != '') {
                if (!isNull(hire) && hire.amount == '') {
                    $('#start-trip-hire-amount').addClass('inp_error');
                    err++;
                }
                
                if (advance.amount == '') {
                    $('#start-trip-advance-amount').addClass('inp_error');
                    err++;
                }

                if (advance.transactionMode.code == '') {
                    $('#start-trip-adv-paymode').addClass('inp_error');
                    err++;
                }

                if (advance.paymentByContact.code == '') {
                    $('#start-trip-adv-payby').addClass('inp_error');
                    err++;
                }

                if (advance.transactionMode.code == 'UPI') {
                    if (advance.addAttr1 == '') {
                        $('#start-trip-adv-upi-id').addClass('inp_error');
                        err++;
                    }

                    if ($('#start-trip-adv-upi-orgbank').val() == '') {
                        $('#start-trip-adv-upi-orgbank').addClass('inp_error');
                        err++;
                    }

                    if (advance.addAttr2 == '') {
                        $('#start-trip-adv-upi-details').addClass('inp_error');
                        err++;
                    }
                } else if (advance.transactionMode.code == 'NBK') {
                    if (advance.addAttr1 == '') {
                        $('#start-trip-adv-netbanking-accholder').addClass('inp_error');
                        err++;
                    }

                    if (advance.addAttr2 == '') {
                        $('#start-trip-adv-netbanking-bankname').addClass('inp_error');
                        err++;
                    }

                    if ($('#start-trip-adv-netbanking-orgbank').val() == '') {
                        $('#start-trip-adv-netbanking-orgbank').addClass('inp_error');
                        err++;
                    }

                    if (advance.addAttr3 == '') {
                        $('#start-trip-adv-netbanking-details').addClass('inp_error');
                        err++;
                    }
                } else if (advance.transactionMode.code == 'CHEQUE') {
                    if (advance.chequeDetails.payerDetails == '') {
                        $('#start-trip-adv-cheque-payer').addClass('inp_error');
                        err++;
                    }

                    if ($('#start-trip-adv-cheque-date').val() == '') {
                        $('#start-trip-adv-cheque-date').addClass('inp_error');
                        err++;
                    }

                    if (advance.chequeDetails.chequeNo == '') {
                        $('#start-trip-adv-cheque-no').addClass('inp_error');
                        err++;
                    }

                    if (advance.chequeDetails.bankDetails == '') {
                        $('#start-trip-adv-cheque-bankname').addClass('inp_error');
                        err++;
                    }

                    if (advance.chequeDetails.bankCity == '') {
                        $('#start-trip-adv-cheque-bankcity').addClass('inp_error');
                        err++;
                    }
                }
            }

            // fuel expense
            if (data.vendorContact.code != '' || data.litres != '' || data.pricePerLitre != '' || data.billNumber != '') {
                if (data.vendorContact.code == '') {
                    $('#start-trip-fuel-vendor').addClass('inp_error');
                    err++;
                }

                if (data.litres == '') {
                    $('#start-trip-fuel-litres').addClass('inp_error');
                    err++;
                }

                if (data.pricePerLitre == '') {
                    $('#start-trip-fuel-rate').addClass('inp_error');
                    err++;
                }

                if (data.billNumber == '') {
                    $('#start-trip-fuel-coupon').addClass('inp_error');
                    err++;
                }
            }
        }
        if(err) {
            $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#start-trip-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }
        $('#start-trip-panel-btn').hide();
        $('#start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-start-odometer",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hideStartTripDialog();
                        ogplLRSearchReport();
                    }, 3000);
                } else {
                    $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#start-trip-panel-btn').show();
                }
            }
        })
    }

    function showOGPLEndTripDialog() {
        $('#end-trip-dialog').removeClass('hide');
        $('#end-trip-dialog').dialog({
            autoOpen: true,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $('#end-trip-dialog .inp_error').removeClass('inp_error');
        $('#end-trip-action-state').removeClass('alert alert-danger alert-success').html('');
        $('#end-trip-odo').val('');

        $('#trip-end-date').html(moment().format('DD MMM YYYY'));
        $('#trip-end-time').html(moment().format('hh : mm A'));

        var vehicle = _.find(OGPLVehicles, o => o.code == OGPLFormData.busVehicle.code) || {};
        if (vehicle) {
            $('#last-odometer-end-trip').html(vehicle.lastOdometer);
        }
    }

    function hideEndTripDialog() {
        $('#end-trip-dialog').dialog('destroy');
        $('#end-trip-dialog').hide();
    }

    function endOGPLTrip() {
        var data = {}, err = 0;
        data.action = 'ARRIVAL';
        data.transitCode = OGPLFormData.code;
        data.transitCargo = {};
        data.transitCargo.code = OGPLFormData.code;
        data.toOrganization = {};
        data.toOrganization.code = '{$logged_in_org}';
        data.endOdometer = Number($('#end-trip-odo').val());
        data.arrivalAt = moment().format('YYYY-MM-DD HH:mm:ss');
        data.toOrganizationContact = {};
        data.toOrganizationContact.code = $('#end-trip-supervisor').val();

        $('.inp_error').removeClass('inp_error');
        if (isNaN(data.endOdometer) || data.endOdometer < 0) {
            $('#end-trip-odo').addClass('inp_error');
            err++;
        }

        var vehicle = _.find(OGPLVehicles, o => o.code == OGPLFormData.busVehicle.code) || {};
        if (vehicle && vehicle.lastOdometer > 0 && data.endOdometer < vehicle.lastOdometer) {
            $('#end-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#end-trip-action-state').html('Entered odometer value should be greater than last odometer value');
            return;
        }
        if(err) {
            $('#end-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#end-trip-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }
        $('#end-trip-panel-btn').hide();
        $('#end-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-end-odometer",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#end-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hideEndTripDialog();
                        checkURL();
                    }, 3000);
                } else {
                    $('#end-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#end-trip-panel-btn').show();
                }
            }
        })
    }

    function setStartTripTransactionMode() {
        var mode = $('#start-trip-adv-paymode').val();

        $('#start-trip-adv-cheque-mode-panel').addClass('hide');
        $('#start-trip-adv-netbanking-mode-panel').addClass('hide');
        $('#start-trip-adv-upi-mode-panel').addClass('hide');

        if (mode == 'CASH') {
            return;
        }

        if (mode == 'CHEQUE') {
            $('#start-trip-adv-cheque-mode-panel').removeClass('hide');
        } else if (mode == 'NBK') {
            $('#start-trip-adv-netbanking-mode-panel').removeClass('hide');
        } else if (mode == 'UPI') {
            $('#start-trip-adv-upi-mode-panel').removeClass('hide');
        }
    }
</script>