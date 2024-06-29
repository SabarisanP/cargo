<button type="submit" class="btn btn-primary pull-right" onclick="addFareList();">Add Row</button>
<br/>
<br/>
<div class="table-responsive" id="adv-bp-grid">
    <table id="fare-rule-fare-table" class="table table-bordered table-hover">
        <thead>
            <tr class="success">
                <td rowspan="2">Route</td>
                <td colspan="2" align="center">Non AC Seater</td>
                <td colspan="2" align="center">AC Seater</td>
                <td colspan="2" align="center">Non AC Sleeper Lower</td>
                <td colspan="2" align="center">Non AC Sleeper Upper</td>
                <td colspan="2" align="center">AC Sleeper Lower</td>
                <td colspan="2" align="center">AC Sleeper Upper</td>
                <td colspan="2" align="center">MultiAxle Seater</td>
                <td colspan="2" align="center">MultiAxle Sleeper</td>
                <td rowspan="2">&nbsp;</td>
            </tr>
            <tr class="success">
                <td>Min Fare</td>
                <td>Max Fare</td>
                <td>Min Fare</td>
                <td>Max Fare</td>
                <td>Min Fare</td>
                <td>Max Fare</td>
                <td>Min Fare</td>
                <td>Max Fare</td>
                <td>Min Fare</td>
                <td>Max Fare</td>
                <td>Min Fare</td>
                <td>Max Fare</td>
                <td>Min Fare</td>
                <td>Max Fare</td>
                <td>Min Fare</td>
                <td>Max Fare</td>
            </tr>
        </thead>

        <tbody class="body_table">
            <tr class="tr-bg-yellow" id="tr-farelist-form">
                <td>
                    <div class="routelabel"></div>
                    <div class="routeselect">
                        <select class="fare-from-station form-control">
                            <option value="">Select From</option>
                            {foreach name=o item=row from=$stations}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach}
                        </select>
                        <select class="fare-to-station form-control">
                            <option value="">Select To</option>
                            {foreach name=o item=row from=$stations}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach}
                        </select>
                    </div>
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Min Fare" value="" data-key="nonAcSeaterMinFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Max Fare" value="" data-key="nonAcSeaterMaxFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Min Fare" value="" data-key="acSeaterMinFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Max Fare" value="" data-key="acSeaterMaxFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Min Fare" value="" data-key="nonAcSleeperLowerMinFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Max Fare" value="" data-key="nonAcSleeperLowerMaxFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Min Fare" value="" data-key="nonAcSleeperUpperMinFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Max Fare" value="" data-key="nonAcSleeperUpperMaxFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Min Fare" value="" data-key="acSleeperLowerMinFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Max Fare" value="" data-key="acSleeperLowerMaxFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Min Fare" value="" data-key="acSleeperUpperMinFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Max Fare" value="" data-key="acSleeperUpperMaxFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Min Fare" value="" data-key="multiAxleSeaterMinFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Max Fare" value="" data-key="multiAxleSeaterMaxFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Min Fare" value="" data-key="multiAxleAcSleeperMinFare">
                </td>
                <td>
                    <input type="text" class="form-control num-inp" maxlength="5" placeholder="Max Fare" value="" data-key="multiAxleAcSleeperMaxFare">
                </td>
                <td width="100">
                    <div style="display: none;" class="fare-list-action-state"></div>
                    <div class=' btn-save'>
                        <a href="javascript:;" onclick="saveFare(this)" title="Save" class="btn btn-success">Save</a>
                        <a href="javascript:;" onclick="addFareList()" title="close" class="btn btn-default btn-xs btn-close" style="display: none;"><i class="fa fa fa-times"></i></a>
                    </div>
                </td>
            </tr>
            {assign var=fareRuleDetailsArr value=[]}
            {assign var=fareRuleDetails value=$fares->fareRuleDetails}
            {foreach item=fare from=$fareRuleDetails}
                {assign var=route value=$fare->fromStation->code|cat:'-'|cat:$fare->toStation->code}
                <tr>
                    <td>
                        {$fare->fromStation->name} to {$fare->toStation->name}
                    </td>
                    <td align="right">{$fare->nonAcSeaterMinFare}</td>
                    <td align="right">{$fare->nonAcSeaterMaxFare}</td>
                    <td align="right">{$fare->acSeaterMinFare}</td>
                    <td align="right">{$fare->acSeaterMaxFare}</td>
                    <td align="right">{$fare->nonAcSleeperLowerMinFare}</td>
                    <td align="right">{$fare->nonAcSleeperLowerMaxFare}</td>
                    <td align="right">{$fare->nonAcSleeperUpperMinFare}</td>
                    <td align="right">{$fare->nonAcSleeperUpperMaxFare}</td>
                    <td align="right">{$fare->acSleeperLowerMinFare}</td>
                    <td align="right">{$fare->acSleeperLowerMaxFare}</td>
                    <td align="right">{$fare->acSleeperUpperMinFare}</td>
                    <td align="right">{$fare->acSleeperUpperMaxFare}</td>
                    <td align="right">{$fare->multiAxleSeaterMinFare}</td>
                    <td align="right">{$fare->multiAxleSeaterMaxFare}</td>
                    <td align="right">{$fare->multiAxleAcSleeperMinFare}</td>
                    <td align="right">{$fare->multiAxleAcSleeperMaxFare}</td>
                    <td align="right">
                        <div style="display: none;" class="fare-list-action-state"></div>
                        <div class=' btn-save'>
                            <a href="javascript:;" onclick="editFareList(this, '{$route}')" title="edit" class="btn btn-default btn-xs"><i class="fa fa fa-pencil"></i></a>
                            <a href="javascript:;" onclick="deleteFareList(this, '{$route}')" title="delete" class="btn btn-default btn-xs"><i class="fa fa fa-trash"></i></a>
                        </div>
                    </td>
                </tr>
                {$fareRuleDetailsArr[$route] = $fare}
            {/foreach}
        </tbody>
    </table>
    <div class="alert fl col-md-12" style="display: none;" id="fare-list-action-state"></div>
    <input type="hidden" id="hid-fare-rule-code" value="{$smarty.request.rulecode}">
</div>

<div id="fare-list-tpl" class="hidden"></div>

<script>
    var allFareRuleList = {$fareRuleDetailsArr|json_encode}
    var deletedFares = [];
    var hashchanged = false;
    $(window).one('hashchange', function (e) {
        hashchanged = true;
    });

    $('#fare-rule-fare-table').on('input', '.num-inp', function () {
        this.value = this.value.replace(/\D/g, '');
    });

    {*$('#fare-rule-fare-table tbody tr:first').clone()
            .removeAttr('data-fromstation').removeAttr('data-tostation')
            .find('select option').removeAttr('selected').end()
            .find(':input').val('').end()
            .appendTo($('#fare-list-tpl'));*}

    $('#fare-rule-fare-table select.fare-from-station').select2();
    $('#fare-rule-fare-table select.fare-to-station').select2();

    {*$('#fare-rule-fare-table').on('change input', function (e) {
        $(e.target).parents('tr:first').attr('data-modified', true);
    });*}

    function addFareRow() {
        $('#fare-rule-fare-table tbody').append($('#fare-list-tpl tr').clone());

        $('#fare-rule-fare-table select.fare-from-station').select2();
        $('#fare-rule-fare-table select.fare-to-station').select2();
    }

    function deleteFareList(btn) {
        var $row = $(btn).parents('tr:first');

        if ($row.data('fromstation') || $row.data('tostation')) {
            var data = {};
            data.activeFlag = 2;
            data.fromStation = {};
            data.fromStation.code = $row.data('fromstation');
            data.toStation = {};
            data.toStation.code = $row.data('tostation');
            deletedFares.push(data);
        }

        $row.remove();
    }

    function saveFareList() {
        var err = 0;
        var fares = deletedFares || [];
        var fareRuleCode = $('#hid-fare-rule-code').val();

        $('#fare-rule-fare-table .inp_error').removeClass('inp_error');

        $('#fare-rule-fare-table tbody tr[data-modified=true]').each(function () {
            var $tr = $(this);
            var data = {};
            data.rowIndex = $tr.index();
            data.fromStation = {};
            data.fromStation.code = $tr.find('select.fare-from-station').val();
            data.toStation = {};
            data.toStation.code = $tr.find('select.fare-to-station').val();

            if (data.fromStation.code != '' || data.toStation.code != '') {
                if (data.fromStation.code == '') {
                    $tr.find('select.fare-from-station').addClass('inp_error');
                    err++;
                }
                if (data.toStation.code == '') {
                    $tr.find('select.fare-to-station').addClass('inp_error');
                    err++;
                }
            }

            $tr.find('input[data-key]').each(function () {
                var $input = $(this);
                data[$input.data('key')] = Number($input.val()) || 0;

                if ($input.val().trim() == '') {
                    $input.addClass('inp_error');
                }
            });
            fares.push(data);
        });

        if (fares.length == 0) {
            $('#fare-list-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#fare-list-action-state').html('Please change any value');
            $('#fare-list-action-state').show();
            return false;
        }

        if (err > 0) {
            $('#fare-list-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#fare-list-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#fare-list-action-state').show();
            return false;
        }

        $('#fare-list-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#fare-list-action-state').html(loading_popup);
        $('#fare-list-action-state').show();

        updateFareList(fareRuleCode, fares);
    }

    function updateFareList(fareRuleCode, fares, i = 0) {
        if (hashchanged) {
            return;
        }
        if (i >= fares.length) {
            $('#fare-list-action-state').removeClass('alert-danger');
            $('#fare-list-action-state').addClass('alert-success');
            $('#fare-list-action-state').html('Your request has been completed successfully');
            setTimeout(function () {
                getFaresList();
            }, 3000);
            return;
        }
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-fare-rule-farelist",
            data: {
                fareRuleCode: fareRuleCode,
                fares: [fares[i]]
            },
            success: function (response) {
                if (fares[i].rowIndex >= 0) {
                    var $tr = $('#fare-rule-fare-table tbody tr').eq(fares[i].rowIndex);
                }
                if (response.status == 1) {
                    updateFareList(fareRuleCode, fares, ++i);
                    if (!$tr) {
                        return;
                    }
                    $tr.find('.fare-list-action-state').removeClass('text-danger');
                    $tr.find('.fare-list-action-state').addClass('text-success');
                    $tr.find('.fare-list-action-state').html('Success').show();

                } else {
                    if (!$tr) {
                        return;
                    }
                    $tr.find('.fare-list-action-state').addClass('text-danger');
                    $tr.find('.fare-list-action-state').html(response.errorDesc).show();
                }
            }
        });
    }
    
    function saveFare(el) {
        var err = 0;

        $('#fare-rule-fare-table .inp_error').removeClass('inp_error');
        
        var $tr = $(el).closest('tr');
        var data = {};
        data.fareRuleCode = $('#hid-fare-rule-code').val();
        data.fromStation = {};
        data.fromStation.code = $tr.find('select.fare-from-station').val();
        data.toStation = {};
        data.toStation.code = $tr.find('select.fare-to-station').val();

        if (data.fromStation.code == '') {
            $tr.find('select.fare-from-station').addClass('inp_error');
            err++;
        }
        if (data.toStation.code == '') {
            $tr.find('select.fare-to-station').addClass('inp_error');
            err++;
        }

        $tr.find('input[data-key]').each(function () {
            var $input = $(this);
            data[$input.data('key')] = Number($input.val()) || 0;

            if ($input.val().trim() == '') {
                $input.addClass('inp_error');
                err++;
            }
        });

        if (err > 0) {
            $tr.find('.fare-list-action-state').removeClass('alert-success').addClass('alert-danger');
            $tr.find('.fare-list-action-state').html('Please enter/select the values in the field that are marked in red');
            $tr.find('.fare-list-action-state').show();
            return false;
        }

        $tr.find('.fare-list-action-state').removeClass('alert-danger').removeClass('alert-success');
        $tr.find('.fare-list-action-state').html(loading_popup);
        $tr.find('.fare-list-action-state').show();
        $tr.find('.btn-save').hide();
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-fare-rule-farelist",
            data: {
                fareRuleCode: data.fareRuleCode,
                fares: [data]
            },
            success: function (response) {
                if (response.status == 1) {
                    $tr.find('.fare-list-action-state').removeClass('text-danger');
                    $tr.find('.fare-list-action-state').addClass('text-success');
                    $tr.find('.fare-list-action-state').html('Success').show();
                    setTimeout(function () {
                        getFaresList();
                    }, 2000);

                } else {
                    $tr.find('.fare-list-action-state').addClass('text-danger');
                    $tr.find('.fare-list-action-state').html(response.errorDesc).show();
                }
            }
        });
    }
    
    
    function deleteFareList(el, route) {
        $('#fare-rule-fare-table .inp_error').removeClass('inp_error');
        
        var $tr = $(el).closest('tr');
        var data = allFareRuleList[route];
        data.activeFlag = 2;
        data.fareRuleCode = $('#hid-fare-rule-code').val();

        $tr.find('.fare-list-action-state').removeClass('alert-danger').removeClass('alert-success');
        $tr.find('.fare-list-action-state').html(loading_popup);
        $tr.find('.fare-list-action-state').show();
        $tr.find('.btn-save').hide();
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-fare-rule-farelist",
            data: {
                fareRuleCode: data.fareRuleCode,
                fares: [data]
            },
            success: function (response) {
                if (response.status == 1) {
                    $tr.find('.fare-list-action-state').removeClass('text-danger');
                    $tr.find('.fare-list-action-state').addClass('text-success');
                    $tr.find('.fare-list-action-state').html('Success').show();
                    $tr.animate({
                             backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                } else {
                    $tr.find('.fare-list-action-state').addClass('text-danger');
                    $tr.find('.fare-list-action-state').html(response.errorDesc).show();
                    $tr.find('.btn-save').show();
                }
            }
        });
    }
    function editFareList(el, route) {
        
        var $tr = $(el).closest('tr');
        
        var $formtr = $('#tr-farelist-form');
        $formtr.find(':input').val('');
        
        var data = allFareRuleList[route];
        $formtr.find('select.fare-from-station').val(data.fromStation.code).trigger('change');
        $formtr.find('select.fare-to-station').val(data.toStation.code).trigger('change');
        
        $formtr.find('.routelabel').html(data.fromStation.name + ' to ' + data.toStation.name).show();
        $formtr.find('.routeselect').hide();
        $formtr.find('.btn-close').show();

        $formtr.find('input[data-key]').val(function () {
            return data[$(this).data('key')];
        });
        
        $('#fare-rule-fare-table tbody tr.hidden').removeClass('hidden');
        $tr.after($formtr).addClass('hidden');
        $formtr.find('input[data-key]:first').focus();
    }
    
    function addFareList() {
        var $formtr = $('#tr-farelist-form').detach();
        $formtr.find(':input').val('').trigger('change');
        $formtr.find('.routelabel').hide();
        $formtr.find('.routeselect').show();
        $formtr.find('.btn-close').hide();
        $('#fare-rule-fare-table tbody').prepend($formtr);
        $('#fare-rule-fare-table tbody tr.hidden').removeClass('hidden');
    }
</script>