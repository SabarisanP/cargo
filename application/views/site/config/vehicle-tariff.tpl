<div class="brand_top">
    <h3>Vehicle Tariff</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success btn-sm" id="add-vehicle-tariff" onclick="addVehicelTariffDialog()">Add vehicle tariff</a>
    </span>
</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#local">Local</a></li>
                                        <li><a data-toggle="tab" href="#outstation">Outstation</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="local" class="tab-pane fade in active">
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="vehicle-tariff-local-action-state"></div>
                                            <div id="vehicle-tariff-local-list"></div>
                                        </div>
                                        <div id="outstation" class="tab-pane fade">
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="vehicle-tariff-outstation-action-state"></div>
                                            <div id="vehicle-tariff-outstation-list"></div>
                                        </div>
                                    </div>
                                </div><!--content end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="vehicle-tariff-dialog" class="hide">
    <div class="">
        <br>
        <div class="col-lg-2 p_l_n">
            <label>Vehicle Tariff Type</label>
            <div class="input-group">
                <label class="radio-inline">
                    <input type="radio" name="optradio" class="vehicle-tariff-type" value="LOC" data-referencetype="{if $cargo_setting->transitLocationModelCode == 'STN'}STN{else}BCH{/if}" checked>Local&nbsp;
                </label>

                <label class="radio-inline">
                    <input type="radio" name="optradio" class="vehicle-tariff-type" value="OUT" data-referencetype="{if $cargo_setting->transitLocationModelCode == 'STN'}RTE{else}BRTE{/if}">Out Station&nbsp;
                </label>
            </div>
        </div>
        
        <div class="col-lg-2 p_l_n">
            <label class="req">Name</label>
            <input type="text" class="form-control" id="vehicle-tariff-name" placeholder="Name">
        </div>
        
        <div class="col-lg-2 p_l_n">
            <label class="req">Ownership Type</label>
            <select id="vehicle-tariff-owntype" class="form-control col-md-6">
                <option value="OWN">Own</option>
                <option value="ATCH">Attached</option>
                <option value="HIRE">Hire / Walk-In</option>
            </select>
        </div>
        
        <div id="vehi_tariff_local">
            <div class="col-lg-3 p_l_n">
                <label class="req">Vehicle</label>
                <select id="vehicle-tariff-local-vehicle" class="form-control col-md-6" multiple="true">
                    <option value="" selected>Default</option>
                    {foreach key=key item=val from=$vehicle}
                        {if $val->ownershipType->code == 'OWN'}
                            <option value="{$val->code}">{$val->registationNumber}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>

            {if $cargo_setting->transitLocationModelCode == 'STN'}
                <div class="col-lg-3 p_l_n p_r_n">
                    <label class="req">Station</label>
                    <select id="vehicle-tariff-station" class="form-control col-md-6" multiple="true">
                        {foreach key=key item=val from=$stations}
                            <option value="{$val.code}">{$val.name}</option>
                        {/foreach}
                    </select>
                </div>
            {elseif $cargo_setting->transitLocationModelCode == 'BRCH'}
                <div class="col-lg-3 p_l_n p_r_n">
                    <label class="req">Branch</label>
                    <select id="vehicle-tariff-station" class="form-control col-md-6" multiple="true">
                        {foreach key=key item=val from=$branches}
                            <option value="{$val->code}">{$val->name}</option>
                        {/foreach}
                    </select>
                </div>
            {/if}
        </div>

        <div class="hide" id="vehi_tariff_outstation">
            <div class="col-lg-3 p_l_n">
                <label class="req">Vehicle</label>
                <select id="vehicle-tariff-outstation-vehicle" class="form-control col-md-6" multiple="true">
                    <option value="" selected>Default</option>
                    {foreach key=key item=val from=$vehicle}
                        {if $val->ownershipType->code == 'OWN'}
                            <option value="{$val->code}">{$val->registationNumber}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <div class="table-responsive" style="height: 300px;overflow: auto;">
                <table class="table table-striped" id="ratecardlist-table">
                    <thead class="sticky-row-top">
                        <tr>
                            <th class="req" id="route-label">Route</th>
                            <th class="req">Ton</th>
                            <th class="req">Amount / KM (Extra KM)</th>
                            <th class="req">Total Km</th>
                            <th class="req">Total Amount</th>
                            <td align="right">
                                <a href="javascript:;" class="btn btn-sm btn-primary hide" id="tr_add_btn" title="Add" onclick="addArticleRow(this)"> <i class="fa fa-plus"></i> </a>
                            </td>
                        </tr>
                    </thead>
                    <tbody id="article_rows">
                        <tr class="article_row" data-tariffdetailscode="">
                            <td width='35%' nowrap style="overflow: auto;">
                                <div class="routes d-flex" id="routes">
                                    {if $cargo_setting->transitLocationModelCode == 'STN'}
                                        <select class="form-control vehicle-tariff-fromstation" style="width: 40%;">
                                            <option value="">Select from station</option>
                                            {foreach key=key item=val from=$stations}
                                                <option value="{$val.code}">{$val.name}</option>
                                            {/foreach}
                                        </select>
                                        &nbsp;
                                        <select class="form-control vehicle-tariff-tostation" style="width: 40%;">
                                            <option value="">Select to station</option>
                                            {foreach key=key item=val from=$stations}
                                                <option value="{$val.code}">{$val.name}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $cargo_setting->transitLocationModelCode == 'BRCH'}
                                        <select class="form-control vehicle-tariff-fromstation">
                                            <option value="">Select from branch</option>
                                            {foreach key=key item=val from=$branches}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/foreach}
                                        </select>
                                        &nbsp;
                                        <select class="form-control vehicle-tariff-tostation">
                                            <option value="">Select to branch</option>
                                            {foreach key=key item=val from=$branches}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/foreach}
                                        </select>
                                    {/if}
                                    &nbsp;
                                    <div style="width: 20%;">
                                        <button class="btn btn-success" type="button" onclick="addRoutes(this);">Add</button>
                                        <button class="btn btn-default" type="button" onclick="removeRoutes(this);"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                            </td>
                            <td width=''>
                                <input type="number" class="form-control vehicle-tariff-ton" step="any" placeholder="Ton" data-startunit="1">
                            </td>

                            <td width=''>
                                <input type="number" class="form-control vehicle-tariff-amountperkm" step="any" placeholder="Amount / KM (Extra KM)">
                            </td>

                            <td width=''>
                                <input type="number" class="form-control vehicle-tariff-totalkm" step="any" placeholder="Total Km">
                            </td>

                            <td width=''>
                                <input type="number" class="form-control vehicle-tariff-totalamount" step="any" placeholder="Total Amount">
                            </td>

                            <td width='5%' align="right">
                                <a href="javascript:;" onclick="removeArticleRow(this);" data-index="1" class="btn btn-sm btn-danger hide tr_remove" title="Remove"><i class="fa fa-times"></i></a>
                            </td>
                        </tr>
                    </tbody>

                    <tfoot>
                        <tr id="tr_clone" style="display:none" data-tariffdetailscode="">
                            <td width='35%' nowrap style="overflow: auto;">
                                <div class="routes d-flex">
                                    {if $cargo_setting->transitLocationModelCode == 'STN'}
                                        <select class="form-control vehicle-tariff-fromstation" style="width: 40%;">
                                            <option value="">Select from station</option>
                                            {foreach key=key item=val from=$stations}
                                                <option value="{$val.code}">{$val.name}</option>
                                            {/foreach}
                                        </select>
                                        &nbsp;
                                        <select class="form-control vehicle-tariff-tostation" style="width: 40%;">
                                            <option value="">Select to station</option>
                                            {foreach key=key item=val from=$stations}
                                                <option value="{$val.code}">{$val.name}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $cargo_setting->transitLocationModelCode == 'BRCH'}
                                        <select class="form-control vehicle-tariff-fromstation">
                                            <option value="">Select from branch</option>
                                            {foreach key=key item=val from=$branches}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/foreach}
                                        </select>
                                        &nbsp;
                                        <select class="form-control vehicle-tariff-tostation">
                                            <option value="">Select to branch</option>
                                            {foreach key=key item=val from=$branches}
                                                <option value="{$val->code}">{$val->name}</option>
                                            {/foreach}
                                        </select>
                                    {/if}
                                    &nbsp;
                                    <div style="width: 20%;">
                                        <button class="btn btn-success" type="button" onclick="addRoutes(this);">Add</button>
                                        <button class="btn btn-default" type="button" onclick="removeRoutes(this);"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                            </td>
                            <td width=''>
                                <input type="number" class="form-control vehicle-tariff-ton" step="any" placeholder="Ton" data-startunit="1">
                            </td>

                            <td width=''>
                                <input type="number" class="form-control vehicle-tariff-amountperkm" step="any" placeholder="Amount / KM (Extra KM)">
                            </td>

                            <td width=''>
                                <input type="number" class="form-control vehicle-tariff-totalkm" step="any" placeholder="Total Km">
                            </td>

                            <td width=''>
                                <input type="number" class="form-control vehicle-tariff-totalamount" step="any" placeholder="Total Amount">
                            </td>

                            <td width='5%' align="right">
                                <a href="javascript:;" onclick="removeArticleRow(this);" data-index="1" class="btn btn-sm btn-danger tr_remove" title="Remove"><i class="fa fa-times"></i></a>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <label>Remarks</label>
            <textarea id="vehicle-tariff-remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="200"></textarea>
        </div>
        <div class="clear_fix_both"></div><br/>
    </div>
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="vehicle-tariff-action-state"></div>
        <div class="align-right" id="form-bttons">
            <input type="hidden" id="vehicle-tariff-code"/>
            <input type="hidden" id="vehicle-tariff-detail-code"/>
            <button class="btn btn-success" type="button" id="save-vehicle-tariff-btn" onclick="saveVehicleTariff();">Save Vehicle Tariff</button>
            <button class="btn btn-default" type="button" onclick="closeVehicelTariffDialog();">Cancel</button>
        </div>
    </div>
</div>

<div class="hide d-flex" id="routes-clone">
    {if $cargo_setting->transitLocationModelCode == 'STN'}
        <select class="form-control vehicle-tariff-fromstation" style="width: 40%;">
            <option value="">Select from station</option>
            {foreach key=key item=val from=$stations}
                <option value="{$val.code}">{$val.name}</option>
            {/foreach}
        </select>
        &nbsp;
        <select class="form-control vehicle-tariff-tostation" style="width: 40%;">
            <option value="">Select to station</option>
            {foreach key=key item=val from=$stations}
                <option value="{$val.code}">{$val.name}</option>
            {/foreach}
        </select>
    {elseif $cargo_setting->transitLocationModelCode == 'BRCH'}
        <select class="form-control vehicle-tariff-fromstation">
            <option value="">Select from branch</option>
            {foreach key=key item=val from=$branches}
                <option value="{$val->code}">{$val->name}</option>
            {/foreach}
        </select>
        &nbsp;
        <select class="form-control vehicle-tariff-tostation">
            <option value="">Select to branch</option>
            {foreach key=key item=val from=$branches}
                <option value="{$val->code}">{$val->name}</option>
            {/foreach}
        </select>
    {/if}
    &nbsp;
    <div style="width: 20%;">
        <button class="btn btn-success" type="button" onclick="addRoutes(this);">Add</button>
        <button class="btn btn-default" type="button" onclick="removeRoutes(this);"><i class="fa fa-times"></i></button>
    </div>
</div>

<style>
    .multiselect-container {
        max-width: 100%;
    }

    .multiselect-container li a {
        white-space: break-spaces;
    }
</style>
<script>
    var allVehicleTariff = {$vehicletariff|json_encode}
    var allVehicles = {$vehicle|json_encode} 
    var allStations = {$stations|json_encode}
    var cargoSetting = {$cargo_setting|json_encode};

    $('a[id=popup_msg]').attr('data-toggle', 'popover');
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    $('#vehicle-tariff-local-vehicle, #vehicle-tariff-outstation-vehicle').multiselect({
        maxHeight: 200,
        maxWidth: '100%',
        numberDisplayed: 1,
        buttonWidth: '100%',
        buttonClass: 'btn btn-default vehicle-tariff-local-vehicle vehicle-tariff-outstation-vehicle',
        dropLeft: true,
        // includeSelectAllOption: true
    });

    $('#vehicle-tariff-station').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        buttonClass: 'btn btn-default vehicle-tariff-station',
        dropLeft: true,
    });

    if (cargoSetting.transitLocationModelCode == 'STN') {
        $('#article_rows .vehicle-tariff-fromstation').select2({
            placeholder: 'Select from station'
        });

        $('#article_rows .vehicle-tariff-tostation').select2({
            placeholder: 'Select to station'
        });
    } else if (cargoSetting.transitLocationModelCode == 'BRCH') {
        $('#article_rows .vehicle-tariff-fromstation').select2({
            placeholder: 'Select from branch'
        });

        $('#article_rows .vehicle-tariff-tostation').select2({
            placeholder: 'Select to branch'
        });
    }

    getVehicleTariffLocal();
    $('a[href="#local"]').on('show.bs.tab', function (e) {
        getVehicleTariffLocal();
    });

    $('a[href="#outstation"]').on('show.bs.tab', function (e) {
        getVehicleTariffOutstation();
    });

    $('.vehicle-tariff-type').on('change', function() {
        $('#vehi_tariff_outstation').addClass('hide');
        $('#vehi_tariff_local').addClass('hide');
        $('.add-route').removeClass('hide');
        $('.save-route').addClass('hide');
        
        var tariffType = $(this).val();
        $('#vehicle-tariff-owntype').on('change', function() {
            var entityTypeCode = $(this).val();
            var options = [new Option('Default', '', true, true)];
            if (tariffType == 'LOC') {
                $('#vehicle-tariff-local-vehicle').html(new Option('Loading...', '', true, true));
                $.each(allVehicles || [], function(key, val){
                    if (entityTypeCode == val.ownershipType.code) {
                        options.push(new Option(val.registationNumber, val.code));
                    }
                });
                $('#vehicle-tariff-local-vehicle').html(options).multiselect('rebuild');
            } else {
                $('#vehicle-tariff-outstation-vehicle').html(new Option('Loading...', '', true, true));
                $.each(allVehicles || [], function(key, val){
                    if (entityTypeCode == val.ownershipType.code) {
                        options.push(new Option(val.registationNumber, val.code));
                    }
                });
                $('#vehicle-tariff-outstation-vehicle').html(options).multiselect('rebuild');
            }
        });
        
        $('#vehicle-tariff-owntype').val('OWN').trigger('change');
        resetArticleRow();

        if (tariffType == 'LOC') {
            $('#vehi_tariff_local').removeClass('hide');
            $('#tr_add_btn, .tr_remove').addClass('hide');
            $('.routes').closest('td').addClass('hide');
            $('#route-label').addClass('hide');
        } else {
            $('#vehi_tariff_outstation').removeClass('hide');
            $('#tr_add_btn, .tr_remove').removeClass('hide')
            $('.routes').closest('td').removeClass('hide');
            $('#route-label').removeClass('hide');
        }
    });

    var tr_id = 1;
    function addArticleRow(autofocus = true) {
        tr_id = tr_id + 1;
        var $newrow = $('#tr_clone').clone(true);
        $newrow.removeAttr('style');

        if (cargoSetting.transitLocationModelCode == 'STN') {
            $newrow.find('.vehicle-tariff-fromstation').select2({
                placeholder: 'Select from station'
            });

            $newrow.find('.vehicle-tariff-tostation').select2({
                placeholder: 'Select to station'
            });
        } else if (cargoSetting.transitLocationModelCode == 'BRCH') {
            $newrow.find('.vehicle-tariff-fromstation').select2({
                placeholder: 'Select from branch'
            });

            $newrow.find('.vehicle-tariff-tostation').select2({
                placeholder: 'Select to branch'
            });
        }

        $newrow.attr('id', 'article_row_' + tr_id).attr('data-index', tr_id);
        $newrow.addClass('article_row').removeAttr('style');
        $('#article_rows').append($newrow);
    }

    function removeArticleRow(btn) {
        $(btn).closest('tr.article_row').attr('data-deleted', 1).hide();
    }

    function resetArticleRow() {
        tr_id = 1;
        $('#ratecardlist-table tbody .article_row').not(':first-child').remove();
        $('#ratecardlist-table tbody .article_row:first-child').find(".vehicle-tariff-ton").val('');
        $('#ratecardlist-table tbody .article_row:first-child').find(".vehicle-tariff-amountperkm").val('');
        $('#ratecardlist-table tbody .article_row:first-child').find(".vehicle-tariff-totalkm").val('');
        $('#ratecardlist-table tbody .article_row:first-child').find(".vehicle-tariff-totalamount").val('');
        $('#ratecardlist-table tbody .article_row:first-child').removeAttr("data-index").removeAttr('id');
    }

    function setTonStartUnit(ele) {
        var tonValue = parseFloat($(ele).closest('.article_row').prev().find('.vehicle-tariff-ton').val()) || 0;
        if(!isNaN(tonValue)) {
            $(ele).attr('data-startunit', tonValue+1)
        }
    }

    function getVehicleTariffLocal() {
        var data = {};
        data.tariffType = 'LOC';

        $('#vehicle-tariff-local-list').html(loading_popup);
        $('#vehicle-tariff-outstation-list').html('');

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'config/get-vehicle-tariff',
            data: data,
            success: function (response) {
                $('#vehicle-tariff-local-list').html(response);
            }
        });
    }

    function getVehicleTariffOutstation() {
        var data = {};
        data.tariffType = 'OUT';

        $('#vehicle-tariff-outstation-list').html(loading_popup);
        $('#vehicle-tariff-local-list').html('');

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'config/get-vehicle-tariff',
            data: data,
            success: function (response) {
                $('#vehicle-tariff-outstation-list').html(response);
            }
        });
    }

    function addRoutes(ele) {
        var $newroute = $('#routes-clone').clone(true);
        $newroute.find('.vehicle-tariff-fromstation, .vehicle-tariff-tostation').select2()
        $newroute.addClass('routes').removeClass('hide');
        $newroute.attr('id', '');
        $newroute.insertAfter($(ele).closest('td').find('.routes:last'));
    }

    function removeRoutes(ele) {
        if ($(ele).closest('td').find('.routes').length > 1) {
            $(ele).closest('.routes').remove();
        }
    }

    function resetRoutesRow() {
        $('#ratecardlist-table .routes').not(':first-child').remove();
        $('#ratecardlist-table .routes:first-child').find(".vehicle-tariff-fromstation").val('').trigger('change');
        $('#ratecardlist-table .routes:first-child').find(".vehicle-tariff-tostation").val('').trigger('change');
    }

    function addVehicelTariffDialog(code) {
        event && event.stopPropagation();
        $('#vehicle-tariff-dialog').css('background', '#fff');
        $('#vehicle-tariff-dialog').removeClass('hide');
        $('#vehicle-tariff-dialog').dialog({
            autoOpen: true,
            height: 650,
            width: $(window).width() - 300,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        $('#vehicle-tariff-dialog .inp_error').removeClass('inp_error');
        $('#vehicle-tariff-action-state').removeClass('alert-success alert-danger').html('').hide();

        $('.vehicle-tariff-type[value="LOC"]').prop('checked', true).trigger('change');
        $('#vehicle-tariff-code, #vehicle-tariff-detail-code').val('');
        $('#vehicle-tariff-name, #vehicle-tariff-remarks').val('').trigger('change');
        $('#vehicle-tariff-owntype').val('OWN').trigger('change');
        $('#vehicle-tariff-local-vehicle, #vehicle-tariff-outstation-vehicle, #vehicle-tariff-station').val(['']).multiselect('refresh');
        resetArticleRow();
        resetRoutesRow();

        if (_isdefined(code)) {
            var vehicleTariff = _.find(allVehicleTariff, function(o) {
                return o.code === code;
            });

            $('#vehicle-tariff-code').val(code);
            $('#vehicle-tariff-detail-code').val(vehicleTariff.tariffDetails[0].code);
            $('.vehicle-tariff-type[value="'+vehicleTariff.tariffType+'"]').prop('checked', true).trigger('change');
            $('#vehicle-tariff-name').val(vehicleTariff.name);
            $('#vehicle-tariff-owntype').val(vehicleTariff.ownershipType.code).trigger('change');
            $('#vehicle-tariff-remarks').val(vehicleTariff.tariffDetails[0].remarks);
            
            if (vehicleTariff.vehicles.length == 0) {
                $('#vehicle-tariff-local-vehicle').val('').multiselect('refresh');
                $('#vehicle-tariff-outstation-vehicle').val('').multiselect('refresh');
            } else {
                $('#vehicle-tariff-local-vehicle').val($.map(vehicleTariff.vehicles || [], function(val) { return val.code; })).multiselect('refresh');
                $('#vehicle-tariff-outstation-vehicle').val($.map(vehicleTariff.vehicles || [], function(val) { return val.code; })).multiselect('refresh');
            }
            
            var count = vehicleTariff.tariffDetails.length;
            $.each(vehicleTariff.tariffDetails || [], function (i, val) {
                var $article = $('.article_row:last');
                $article.removeAttr('style');
                if (cargoSetting.transitLocationModelCode == 'STN') {
                    $('#vehicle-tariff-station').val($.map(val.stations || [], function(val) { return val.code; })).multiselect('refresh');

                    if (isNotNull(val.routes)) {
                        var routecount = val.routes.length;
                        $.each(val.routes || [], function(key, val) {
                            $article.find('.routes').eq(key).find('.vehicle-tariff-fromstation').val(val.fromStation.code).trigger('change');
                            $article.find('.routes').eq(key).find('.vehicle-tariff-tostation').val(val.toStation.code).trigger('change');
                            if (routecount != key+1) {
                                addRoutes($article.find('.vehicle-tariff-tostation'));
                            }
                        });
                    }
                } else if (cargoSetting.transitLocationModelCode == 'BRCH') {
                    $('#vehicle-tariff-station').val($.map(val.organizations || [], function(val) { return val.code; })).multiselect('refresh');

                    if (isNotNull(val.organizationRoutes)) {
                        var routecount = val.organizationRoutes.length;
                        $.each(val.organizationRoutes || [], function(key, val) {
                            $article.find('.routes').eq(key).find('.vehicle-tariff-fromstation').val(val.fromOrganization.code).trigger('change');
                            $article.find('.routes').eq(key).find('.vehicle-tariff-tostation').val(val.toOrganization.code).trigger('change');
                            if (routecount != key+1) {
                                addRoutes($article.find('.vehicle-tariff-tostation'));
                            }
                        });
                    }
                }
                $article.data('tariffdetailscode', val.code);
                $article.find('.vehicle-tariff-ton').attr('data-startunit', val.rateCardList[0].startUnitValue || 0);
                $article.find('.vehicle-tariff-ton').val(val.rateCardList[0].endUnitValue || 0);

                $article.find('.vehicle-tariff-amountperkm').val(val.rateCardList[0].ratePerKm || 0);
                $article.find('.vehicle-tariff-totalkm').val(val.rateCardList[0].fixedKm || 0);
                $article.find('.vehicle-tariff-totalamount').val(val.rateCardList[0].fixedRate || 0);
                
                if (count != i+1) {
                    addArticleRow();
                }
            });
        }
    }

    function closeVehicelTariffDialog() {
        $('#vehicle-tariff-dialog').dialog('destroy');
        $('#vehicle-tariff-dialog').hide();
    }

    function saveVehicleTariff() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.code = $('#vehicle-tariff-code').val();
        data.activeFlag = 1;

        data.name = $('#vehicle-tariff-name').val().trim();
        if (data.name == '') {
            $('#vehicle-tariff-name').addClass('inp_error');
            $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vehicle-tariff-action-state').html('Please enter/select a valid name').show();
            return;
        }

        data.tariffType = $('.vehicle-tariff-type:checked').val();

        data.ownershipType = {};
        data.ownershipType.code = $('#vehicle-tariff-owntype').val();
        
        if (data.tariffType == 'LOC') {
            data.vehicles = [];
            if ($.inArray('', $('#vehicle-tariff-local-vehicle').val()) == -1) {
                data.vehicles = $.map($('#vehicle-tariff-local-vehicle').val() || [], (vehicle) => ({ code: vehicle }));
                if (data.vehicles.length == 0) {
                    $(".vehicle-tariff-local-vehicle").addClass('inp_error');
                    $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#vehicle-tariff-action-state').html('Please enter/select a valid vehicle').show();
                    return;
                }
            } 
        } else if (data.tariffType == 'OUT') {
            data.vehicles = [];
            if ($.inArray('', $('#vehicle-tariff-outstation-vehicle').val()) == -1) {
                data.vehicles = $.map($('#vehicle-tariff-outstation-vehicle').val() || [], (vehicle) => ({ code: vehicle }));
                if (data.vehicles.length == 0) {
                    $(".vehicle-tariff-outstation-vehicle").addClass('inp_error');
                    $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#vehicle-tariff-action-state').html('Please enter/select a valid vehicle').show();
                    return;
                }
            }
        }
        
        data.tariffDetails =[];
        $('.article_row').each(function() {
            if ($(this).attr('style') && isNull($(this).find('.vehicle-tariff-ton').val())) {
                return;
            }
            var tariffDetails = {};
            tariffDetails.code = $(this).data('tariffdetailscode');

            if ($(this).data('deleted')) {
                tariffDetails.activeFlag = 2;
            } else {
                tariffDetails.activeFlag = 1;
            }

            tariffDetails.remarks = $('#vehicle-tariff-remarks').val();

            tariffDetails.referenceType = {};
            tariffDetails.referenceType.code = $('.vehicle-tariff-type:checked').data('referencetype');

            tariffDetails.stations = [];
            tariffDetails.organizations = [];
            if (data.tariffType == 'LOC') {
                if (cargoSetting.transitLocationModelCode == 'STN') {
                    tariffDetails.stations = $.map($('#vehicle-tariff-station').val() || [], (station) => ({ code: station }));
                    
                    if (tariffDetails.stations.length == 0) {
                        $(".vehicle-tariff-station").addClass('inp_error');
                        $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                        $('#vehicle-tariff-action-state').html('Please enter/select a valid station').show();
                        return;
                    }
                } else if (cargoSetting.transitLocationModelCode == 'BRCH'){
                    tariffDetails.organizations = $.map($('#vehicle-tariff-station').val() || [], (branch) => ({ code: branch }));
                    
                    if (tariffDetails.organizations.length == 0) {
                        $(".vehicle-tariff-station").addClass('inp_error');
                        $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                        $('#vehicle-tariff-action-state').html('Please enter/select a valid Branch').show();
                        return;
                    }
                }
            }

            tariffDetails.routes = [];
            tariffDetails.organizationRoutes = [];
            if (data.tariffType == 'OUT') {
                if (cargoSetting.transitLocationModelCode == 'STN') {
                    $(this).find('.routes').each(function(key, rte) {
                        var route = {};

                        route.fromStation = {};
                        route.fromStation.code = $(rte).find('select.vehicle-tariff-fromstation').val();

                        route.toStation = {};
                        route.toStation.code = $(rte).find('select.vehicle-tariff-tostation').val();
                        tariffDetails.routes.push(route);

                        
                        if (isNull(route.fromStation.code) || isNull(route.toStation.code)) {
                            err++;
                            $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                            $('#vehicle-tariff-action-state').html('Please enter/select a valid route').show();
                            return;
                        }
                    });
                } else if (cargoSetting.transitLocationModelCode == 'BRCH') {
                    $.each($(this).find('.routes'), function(key, rte) {
                        var route = {};

                        route.fromOrganization = {};
                        route.fromOrganization.code = $(rte).find('select.vehicle-tariff-fromstation').val();

                        route.toOrganization = {};
                        route.toOrganization.code = $(rte).find('select.vehicle-tariff-tostation').val();
                        tariffDetails.organizationRoutes.push(route);

                        if (isNull(route.fromOrganization.code) || isNull(route.toOrganization.code)) {
                            err++;
                            $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                            $('#vehicle-tariff-action-state').html('Please enter/select a valid route').show();
                            return;
                        }
                    });
                }
            }

            tariffDetails.rateCardList = [];
            var ratecard = {};
            ratecard.startUnitValue = $(this).find('.vehicle-tariff-ton').data('startunit');
            ratecard.endUnitValue = parseFloat($(this).find('.vehicle-tariff-ton').val());
            ratecard.ratePerKm = parseFloat($(this).find('.vehicle-tariff-amountperkm').val());
            ratecard.fixedKm = parseFloat($(this).find('.vehicle-tariff-totalkm').val());
            ratecard.fixedRate = parseFloat($(this).find('.vehicle-tariff-totalamount').val());
            
            if (isNaN(ratecard.endUnitValue)) {
                err++;
                $(this).find('.vehicle-tariff-ton').addClass('inp_error').focus();
                $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#vehicle-tariff-action-state').html('Please enter valid ton').show();
                return;
            }

            if (isNaN(ratecard.ratePerKm)) {
                err++;
                $(this).find('.vehicle-tariff-amountperkm').addClass('inp_error').focus();
                $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#vehicle-tariff-action-state').html('Please enter valid amount / KM (Extra KM)').show();
                return;
            }

            if (isNaN(ratecard.fixedKm)) {
                err++;
                $(this).find('.vehicle-tariff-totalkm').addClass('inp_error').focus();
                $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#vehicle-tariff-action-state').html('Please enter valid total km').show();
                return;
            }

            if (isNaN(ratecard.fixedRate)) {
                err++
                $(this).find('.vehicle-tariff-totalamount').addClass('inp_error').focus();
                $('#vehicle-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#vehicle-tariff-action-state').html('Please enter valid total amount').show();
                return;
            }
            tariffDetails.rateCardList.push(ratecard);
            data.tariffDetails.push(tariffDetails);
        });
        
        if (err > 0) {
            return;
        } else {
            $('#vehicle-tariff-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vehicle-tariff-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#vehicle-tariff-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#vehicle-tariff-action-state').html(loading_popup);
        $('#vehicle-tariff-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-vehicle-tariff",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#vehicle-tariff-action-state').removeClass('alert-danger');
                    $('#vehicle-tariff-action-state').addClass('alert-success');
                    $('#vehicle-tariff-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closeVehicelTariffDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#vehicle-tariff-action-state').addClass('alert-danger');
                    $('#vehicle-tariff-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        })
    }
    
    function toggleRateCard(code) {
        if($('.ratecardlist').hasClass(code)) {
            $('.ratecardlist .slide').slideToggle('linear', function() {
                $('.ratecardlist').remove();
            });
            return;
        }
        $('.ratecardlist').remove();
        var $trows = $('.tariffRateCard').filter('.' + code);
        $('#'+code).after('<tr class="ratecardlist ' + code + '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">'
                + $trows.html() + '</table></div></td></tr>');
        $('.ratecardlist .slide').slideToggle('linear');
    }
    
    function deleteVehicleTariff(code){
        event && event.stopPropagation();

        if (confirm('Do you want to delete this vehicle tariff?')) {
            var data = _.find(allVehicleTariff, function(o) { return o.code === code });
            data.activeFlag = 2;
            
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/update-vehicle-tariff",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        checkURL();
                    }, 2000);
                }
            });    
        }
    }
</script>