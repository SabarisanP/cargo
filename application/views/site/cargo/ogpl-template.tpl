<div class="brand_top">
    <h3>{lang('ogpl')} Routes</h3>
    <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="cargoTemplateDialog();">Add Routes</a></span>
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
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr class="success">
                                                    <th>Name</th>
                                                    <th>From Station</th>
                                                    <th>To Station</th>
                                                    <th>Via Stations</th>
                                                    <th nowrap>Departure Time</th>
                                                    <th nowrap>Arrival Time</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                {foreach item=row from=$tpl}
                                                    <tr id='{$row->code}'>
                                                        <td>{$row->name}</td>
                                                        <td>{$row->fromStation->name}</td>
                                                        <td>{$row->toStation->name}</td>
                                                        <td>
                                                            {foreach item=via from=$row->viaStations}
                                                                {$via->name}{if !$via@last}, {/if}
                                                            {/foreach}
                                                        </td>
                                                        <td>{($row->departureMinutes) ? min_to_time($row->departureMinutes * 60) : '-'}</td>
                                                        <td nowrap>
                                                            {if $row->arrivalMinutes > 2880}
                                                                {min_to_time(($row->arrivalMinutes - 2880) * 60)} Third Day
                                                            {elseif $row->arrivalMinutes > 1440}
                                                                {min_to_time(($row->arrivalMinutes - 1440) * 60)} Next Day
                                                            {else}
                                                                {($row->arrivalMinutes) ? min_to_time($row->arrivalMinutes * 60) : '-'}
                                                            {/if}
                                                        </td>
                                                        <td align="center" width="150">
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick="deleteCargoTemplate('{$row->code}')">
                                                                <i class="fa fa-trash-o ired"></i>
                                                            </a>
                                                            {if $row->activeFlag ==1}
                                                                <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick="cargoTemplateDialog('{$row->code}')">
                                                                    <i class="fa fa-pencil igreen"></i>
                                                                </a>
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="clear_fix_both"></div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>

<div id="ogpl-tpl-dialog" class="hide dialog-content-page">
    <form role="form" id="form1" class="form-horizontal">
        <div>
            <div class="col-lg-12">
                <div class="form-group">
                    <label for="tpl-name" class="req">Name</label>
                    <input placeholder="Name" id="tpl-name" value="" class="form-control">
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <div class="col-lg-6">
                <div class="form-group col-lg-12 p_l_n p_r_n">
                    <label for="tpl-fromstation" class="req">From Station</label>
                    <select id="tpl-fromstation" class="form-control">
                        <option value="" selected="">Select From</option>
                        {foreach item=station from=$stations}
                            <option value="{$station.code}">{$station.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label for="tpl-departuretime" class="req">Departure Time</label>
                    <select id="tpl-departuretime" class="form-control">
                        <option value="" selected="">Select Time</option>
                        {assign var="timerange" value=hours_range(0, 86400 -1, 60 * 15)}

                        {foreach item=time key=seconds from=$timerange}
                            <option value="{$seconds / 60}">{$time}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <div class="col-lg-6">
                <div class="form-group col-lg-12 p_l_n p_r_n">
                    <label for="tpl-tostation" class="req">To Station</label>
                    <select id="tpl-tostation" class="form-control">
                        <option value="" selected="">Select To</option>
                        {foreach item=station from=$stations}
                            <option value="{$station.code}">{$station.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label for="tpl-arrivaltime" class="req">Arrival Time</label>
                    <div class="input-group" style="display: flex;">
                        <select id="tpl-arrivaltime" class="form-control">
                            <option value="" selected="">Select Time</option>
                            {foreach item=time key=seconds from=$timerange}
                                <option value="{$seconds / 60}">{$time}</option>
                            {/foreach}
                        </select>
                        <select id="tpl-arrivalday" class="form-control" style="width: 175px;">
                            <option value="0" selected="">Same Day</option>
                            <option value="1440">Next Day</option>
                            <option value="2880">Third Day</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <div class="col-lg-12">
                <div class="form-group">
                    <label for="tpl-via" class="req">Via Stations</label>
                    <div class="input-group col-md-12">
                        <select id="tpl-via" class="form-control" multiple="multiple">
                            {foreach item=station from=$stations}
                                <option value="{$station.code}">{$station.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="clear_fix_both"></div>
    <br/>
    <div class="col-lg-12">
        <div class="alert fl suc_cre" style="display:none;" id="tpl-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" id="tpl-code"/>
            <button class="btn btn-success" type="button" onclick="saveCargoTemplate();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelTemplateDialog();">Cancel</button>
        </div>
    </div>
</div>


<script>
    var OGPLTemplates = {$tpl|json_encode};

    {literal}
        $('#tpl-fromstation').select2({
            width: 'resolve',
            dropdownParent: $('#ogpl-tpl-dialog')
        });
        $('#tpl-tostation').select2({
            width: 'resolve',
            dropdownParent: $('#ogpl-tpl-dialog')
        });
        $('#tpl-via').select2({
            width: 'resolve',
            placeholder: 'Select Via Stations',
            dropdownParent: $('#ogpl-tpl-dialog')
        });

        function cargoTemplateDialog(code) {
            $('.inp_error').removeClass('inp_error');
            $('#tpl-action-state').removeClass('alert-success alert-danger').hide();
            $('#ogpl-tpl-dialog').removeClass('hide');
            $('#ogpl-tpl-dialog').dialog({
                autoOpen: true,
                width: 600,
                height: 500,
                modal: true,
                resizable: false,
                open: function() {
                    if ($.ui && $.ui.dialog && !$.ui.dialog.prototype._allowInteractionRemapped && $(this).closest(".ui-dialog").length) {
                        if ($.ui.dialog.prototype._allowInteraction) {
                            var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
                            $.ui.dialog.prototype._allowInteraction = function(e) {
                                if ($(e.target).closest('.select2-drop').length) return true;
                                return ui_dialog_interaction.apply(this, arguments);
                            };
                            $.ui.dialog.prototype._allowInteractionRemapped = true;
                        }
                    }
                },
                _allowInteraction: function(event) {
                    return !!$(event.target).is(".select2-input") || this._super(event);
                }
            });
            $(".ui-dialog-titlebar").hide();

            if (_isdefined(code)) {
                var option = _.find(OGPLTemplates, function (o) {
                    return o.code == code;
                });
                $('#tpl-code').val(option.code);
                $('#tpl-name').val(option.name);
                $('#tpl-fromstation').val(option.fromStation.code).trigger('change');
                $('#tpl-tostation').val(option.toStation.code).trigger('change');
                var via = $.map(option.viaStations, function (val) {
                    return val.code;
                });
                $('#tpl-via').val(via).trigger('change');

                var arrivalMinutes, arrivalday;
                if (option.arrivalMinutes > 2880) {
                    arrivalMinutes = option.arrivalMinutes - 2880;
                    arrivalday = 2880;
                } else if (option.arrivalMinutes > 1440) {
                    arrivalMinutes = option.arrivalMinutes - 1440;
                    arrivalday = 1440;
                } else {
                    arrivalMinutes = option.arrivalMinutes;
                    arrivalday = 0;
                }
                $('#tpl-arrivalday').val(arrivalday);
                $('#tpl-arrivaltime').val(arrivalMinutes || '');
                $('#tpl-departuretime').val(option.departureMinutes || '');
            } else {
                $('#tpl-code').val('');
                $('#tpl-name').val('');
                $('#tpl-fromstation').val('').trigger('change');
                $('#tpl-tostation').val('').trigger('change');
                $('#tpl-arrivaltime').val('');
                $('#tpl-departuretime').val('');
                $('#tpl-arrivalday').val('0');
                $('#tpl-via').val([]).trigger('change');
            }
        }

        function cancelTemplateDialog() {
            $('#ogpl-tpl-dialog').dialog('destroy');
            $('#ogpl-tpl-dialog').hide();
        }

        function saveCargoTemplate() {
            var data = {};
            data.activeFlag = 1;
            data.code = $.trim($('#tpl-code').val());
            data.name = $.trim($('#tpl-name').val());
            data.fromStation = {};
            data.fromStation.code = $('#tpl-fromstation').val();
            data.toStation = {};
            data.toStation.code = $('#tpl-tostation').val();
            data.viaStations = $.map($('#tpl-via option:selected') || [], function (opt) {
                return {code: $(opt).val(), name: $(opt).text()};
            });

            data.departureMinutes = Number($('#tpl-departuretime').val());
            data.arrivalMinutes = Number($('#tpl-arrivalday').val()) + Number($('#tpl-arrivaltime').val());

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.name == '') {
                $('#tpl-name').addClass('inp_error');
                err++;
            }
            if (data.fromStation.code == '') {
                $('#tpl-fromstation').addClass('inp_error');
                err++;
            }
            if (data.toStation.code == '') {
                $('#tpl-tostation').addClass('inp_error');
                err++;
            }
            if (data.viaStations.length == 0) {
                $('#tpl-via').addClass('inp_error');
                err++;
            }
            if (!data.departureMinutes) {
                $('#tpl-departuretime').addClass('inp_error');
                err++;
            }
            if (!data.arrivalMinutes) {
                $('#tpl-arrivaltime').addClass('inp_error');
                err++;
            }
            if (data.departureMinutes && data.arrivalMinutes && data.arrivalMinutes < data.departureMinutes) {
                $('#tpl-arrivaltime').addClass('inp_error');
                $('#tpl-departuretime').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#tpl-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#tpl-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#tpl-action-state').show();
                return false;
            } else {
                $('#tpl-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#tpl-action-state').hide();
            }

            $('#form-bttons').hide();
            $('#tpl-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#tpl-action-state').html(loading_popup);
            $('#tpl-action-state').show();

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-ogpl-template",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#form-bttons').hide();
                        $('#tpl-action-state').removeClass('alert-danger');
                        $('#tpl-action-state').addClass('alert-success');
                        $('#tpl-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                            cancelTemplateDialog();
                            checkURL();
                            return;
                        }, 3000);
                    } else {
                        $('#tpl-action-state').addClass('alert-danger');
                        $('#tpl-action-state').html(response.errorDesc);
                        $('#form-bttons').show();
                    }
                }
            });
        }

        function deleteCargoTemplate(code) {
            if (confirm('Do you want to delete this Vendor?')) {
                var data = _.find(OGPLTemplates, function (o) {
                    return o.code == code;
                });
                data.activeFlag = 2;

                var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
                });

                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "cargo/update-ogpl-template",
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
    {/literal}
</script>