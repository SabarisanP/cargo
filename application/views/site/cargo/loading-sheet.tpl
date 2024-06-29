<div class="brand_top">
    <h3>Loading Sheet</h3>
    <span class="align-right">
        <a href="#cargo/ogpl" class="btn btn-success  btn-sm"><i class="fa fa-arrow-left"></i> Back</a>
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row" id="ogpl-form-div">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <label for="ogpl-tpl">{lang('ogpl')} Routes</label>
                                            <div class="input-group col-md-12">
                                                <select id="ogpl-tpl" class="form-control" onchange="setOGPLTemplate(this.value)">
                                                    <option value="" selected="">Select Routes</option>
                                                    {foreach item=tpl from=$ogpltpl}
                                                        {if $tpl->fromStation->code==$login_station}
                                                        <option value="{$tpl->code}">{$tpl->name}</option>
                                                        {/if}
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3 hide">
                                            <div class="form-group">
                                                <label for="ogpl-to" class="req">To Station</label>
                                                <div class="input-group col-md-12">
                                                    <select id="ogpl-to" class="form-control">
                                                        <option value="" selected="">Select To</option>
                                                        {foreach item=station from=$stations}
                                                            <option value="{$station.code}">{$station.name}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label for="ogpl-via" class="req">To Stations</label>
                                                <div class="input-group col-md-12 ogpl-via-stations">
                                                    <select id="ogpl-via" name="viaStationCodes" class="form-control" multiple="multiple">
                                                        {foreach item=station from=$stations}
                                                            <option value="{$station.code}">{$station.name}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="">&nbsp;</label>
                                            <div class="input-group">
                                                <input type="hidden" name="export" id="export" value="">
                                                <button class="btn btn-success" type="button" onclick="ogplLRSearchReport();">Generate</button>&nbsp;
                                                <button type="button" class="btn btn-default btn-clear" onclick="clearogplLRSearch();">Clear</button>
                                            </div>
                                        </div>
                                        <div class="clearfix_both"></div><br />
                                        <div class="row">
                                            <div class="col-md-9">
                                                <div class="alert" id="ogpl-load-action_state" style="display: none"></div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--panel Body end-->
                    </div>
                    <!--panel end-->

                    
                    <div class="row hidden" id="booked-ogpl-search-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="booked-ogpl-search-list"></div>
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


<script>
    var OGPLTemplates = {$ogpltpl|json_encode};
    var namespaceCode = {$namespaceCode|json_encode};

    $('#ogpl-tpl').select2();
    $('#ogpl-to').select2();
    $('#ogpl-via').select2({
        placeholder: 'Select To Stations'
    });
    $('#ogpl-via .select2-choices').css('max-height', '400px');

    function setOGPLTemplate(tplcode) {
        if (tplcode == '') {
            $('#ogpl-to').val('').trigger('change');
            $('#ogpl-via').val([]).trigger('change');
            return;
        }
        var tpl = _.find(OGPLTemplates, function(o) {
            return o.code == tplcode;
        });
        $('#ogpl-to').val(tpl.toStation.code).trigger('change');
        var via = $.map(tpl.viaStations || [], function(val) {
            return val.code;
        });
        via.push(tpl.toStation.code);
        $('#ogpl-via').val(via).trigger('change');
    }

    function ogplLRSearchReport(OGPLCode, OGPLDate) {
        var data = {}, err = 0;
        data.fromDate = moment().subtract(31, 'd').format('YYYY-MM-DD');
        data.toDate = moment().format('YYYY-MM-DD');
        data.viaStationCodes = ($('#ogpl-via').val() || []).join(',');
        
        $('.inp_error').removeClass('inp_error');
        if (data.fromDate == '') {
            $('#ogpl-load-from').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#ogpl-load-to').addClass('inp_error');
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

        $('#booked-ogpl-search-container').removeClass('hidden');
        $('#booked-ogpl-search-list').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/booked-ogpl-search-listv2',
            data: data,
            success: function (response) {
                $('#booked-ogpl-search-list').html(response);
            }
        });
    }
    
    function clearogplLRSearch() {
        $('#ogpl-load-from').val('');
        $('#ogpl-load-to').val('');
        $('#ogpl-load-org').val('NA');
        $('#booked-ogpl-search-container').addClass('hidden');
        $('#booked-ogpl-search-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#ogpl-load-action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#ogpl-load-action_state').html('');
        $('#ogpl-load-action_state').hide();
    }

    function printLoadingSheet() {
        var data = {};
        data.print = 1;
        data.fromDate = moment().subtract(31, 'd').format('YYYY-MM-DD');
        data.toDate = moment().format('YYYY-MM-DD');
        data.viaStationCodes = ($('#ogpl-via').val() || []).join(',');

        var url = base_url + "cargo/booked-ogpl-search-listv2?" + $.param(data);   
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
    }

    function printDmLoadingSheet() {
        var params = {};
        params.printType = 'DOTMATRIX';
        params.fromDate = moment().subtract(31, 'd').format('YYYY-MM-DD');
        params.toDate = moment().format('YYYY-MM-DD');
        params.viaStationCodes = ($('#ogpl-via').val() || []).join(',');

        var url = base_url + 'cargo/booked-ogpl-search-listv2?' + $.param(params);
        if (epIsActive()) {
            if (params.printType == 'DOTMATRIX' && ['citycargo', 'cityparcel'].includes(namespaceCode)) {
            epPrintUrlCommands(url);
            }
        } else {
            window.open(url, '_blank');
        }
    }
</script>
