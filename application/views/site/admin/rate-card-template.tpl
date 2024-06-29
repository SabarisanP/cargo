<div class="brand_top">
    <h3>Billing Subscription Rate Card Template</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="addRateCard();">Add New Template</a>
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-3 col-md-6">
                                        <div class="panel-group" id="accordion">
                                            {foreach from=$result item=row key=key name=name}
                                                <div class="panel panel-info">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title">
                                                            <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row->code}">
                                                                {$row->name}
                                                                {if $row->pricingModel == 'LRCNT'}
                                                                    <span class="small label label-success">{$billing_conf_pricing_model[$row->pricingModel]}</span>
                                                                {else}
                                                                    <span class="small label label-warning">{$billing_conf_pricing_model[$row->pricingModel]}</span>
                                                                {/if}
                                                            </a>
                                                        </h3>

                                                        <div class="btn-group btn-group-xs ac_bu">
                                                            <a href="javascript:;" class="btn btn-default btn-sm est" onclick="changeStatus('{$row->code}','{1 - $row->activeFlag}')">
                                                                <i {if $row->activeFlag==1} class="fa fa-times" {else} class="fa fa-check" {/if} title="Click to enable/disable template" data-toggle="tooltip"></i>
                                                            </a>
                                                            <a href="javascript:;" title="Edit Group" data-toggle="tooltip" class="btn btn-default btn-sm edat" onclick="addRateCard('{$row->code}');"><i class="fa fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" title="Delete Group" onclick="changeStatus('{$row->code}','2')" data-toggle="tooltip" class="btn btn-default btn-sm del"><i class="fa fa-trash-o ired"></i></a>
                                                        </div>
                                                    </div>
                                                    <div id="collapse-{$row->code}" class="panel-collapse collapse">
                                                        <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    {if $row->pricingModel == 'LRCNT'}
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr class="bold">
                                                                                    <th>From </th>
                                                                                    <th>To</th>
                                                                                    <th>Type</th>
                                                                                    <th>Amount</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                {foreach from=$row->rateCardList item=item key=key name=name}
                                                                                    <tr>
                                                                                        <td>{$item->fromValue}</td>
                                                                                        <td>
                                                                                            {if $item->toValue == 0}
                                                                                                Infinity
                                                                                            {else}
                                                                                                {$item->toValue}
                                                                                            {/if}
                                                                                        </td>
                                                                                        <td>{$item->rateCardType->name}</td>
                                                                                        <td>{$item->amount|inr_format}</td>
                                                                                    </tr>
                                                                                {/foreach}
                                                                            </tbody>
                                                                        </table>
                                                                    {elseif $row->pricingModel == 'LRVOL'}
                                                                        {foreach from=$row->rateCardList item=item key=key name=name}
                                                                            <b>Total Transaction Value : {$item->fromValue}%</b>
                                                                            {break}
                                                                        {/foreach}
                                                                    {/if}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            {foreachelse}
                                                <div class="well well-large ">No Template found!</div>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div id="rate-card-dialog" class="hide dialog-content-page">
    <form role="form" id="form1" class="form-horizontal">

        <div class="form-group">
            <div>
                <label for="">Name</label>
                <input type="text" class="form-control" id="rate-card-name">
            </div>
        </div>
        <div class="form-group">
            <label>Pricing Model:</label>
            <div class="input-group">
                <label class="d-inline-block font-weight-normal">
                    <input type="radio" name="optradio" id="rate-card-price-model" class="rate-card-price-model" onchange="setRateCardPriceModel(this)" value="LRCNT" checked>
                    LR Count
                    &nbsp;
                </label>
                <label class="d-inline-block font-weight-normal">
                    <input type="radio" name="optradio" id="rate-card-price-model" class="rate-card-price-model" onchange="setRateCardPriceModel(this)" value="LRVOL">
                    LR Volume
                    &nbsp;
                </label>
            </div>
        </div>
        <div id="lr-count-model">
            <div class="row p_l_n">
                <div class="col-md-2 p_l_n">
                    <label for="">LR count <br>Min</label>
                </div>
                <div class="col-md-2 p_l_n">
                    <label for="">LR count <br>Max</label>
                </div>
                <div class="col-md-3 p_l_n">
                    <label for="">Rate Card <br>Type</label>
                </div>
                <div class="col-md-2 p_l_n">
                    <label for="">Amount</label>
                </div>
            </div>
            <div id="rate-card-list"></div>
            <div class="form-group">
                <p class="help-block">Enter Zero (0) in To value for from value to infinity (Ex: 500 to 0 (infinity))</p>
            </div>
            <div class="form-group">
                <button type="button" class="btn btn-xs btn-primary m-t-5" onclick="addRateCardRow()"><i class="fa fa-plus"></i> Add</button>
            </div>
        </div>
        <div id="lr-volume-model" class="hide">
            <div class="form-group">
                <label for="">Total Transction %</label>
                <input type="number" class="form-control wid-100 no-spin" id="lrvolume-trans-percent" placeholder="Percentage" min="0" max="100">
            </div>
        </div>

        <div class="clear_fix_both"></div>

        <div class="row">
            <div class="" id="form-loading"></div>
            <div class="alert fl" id="rate-card-action-state"></div>
        </div>

        <div class="text-right" class="form-buttons">
            <input type="hidden" id="rate-card-hid-id">
            <button class="btn btn-success" type="button" onclick="saveRateCardTemplate();">Save</button>
            <button class="btn btn-default" type="button" onclick="closeRateCardDialog();">Close</button>
        </div>

    </form>
</div>

<script type="text/html" id="rate-card-lis-tpl">
    <div class="row p_l_n rate-card-list-row pb10">
        <div class="col-md-2 p_l_n">
            <input type="text" class="form-control" id="rate-card-from" placeholder="From">
        </div>
        <div class="col-md-2 p_l_n">
            <input type="text" class="form-control" id="rate-card-to" placeholder="To">
        </div>
        <div class="col-md-3 p_l_n p_r_n">
            <div class="input-group">
                <label class="radio-inline">
                    <input type="radio" name="optradio" id="rate-card-type" class="rate-card-type" value="METERED" checked>METERED
                </label>
                <label class="radio-inline">
                    <input type="radio" name="optradio" id="rate-card-type" class="rate-card-type" value="FIXED">FIXED
                </label>
            </div>
        </div>
        <div class="col-md-2 p_l_n">
            <input type="text" class="form-control" id="rate-card-amount" placeholder="Amount">
        </div>
        <div class="col-md-1 p_l_n">
            <button class="btn btn-xs m-t-5" onclick="removeRateCardRow(this)"><i class="fa fa-times"></i></button>
        </div>
    </div>
</script>


<script>
    var rateCards = {$result|json_encode};

    function setRateCardPriceModel(el) {
        var model = $(el).val();

        $('#lr-count-model').addClass('hide');
        $('#lr-volume-model').addClass('hide');

        if (model == 'LRCNT') {
            $('#lr-count-model').removeClass('hide');
            $('#lr-volume-model').addClass('hide');
        } else if (model == 'LRVOL') {
            $('#lr-count-model').addClass('hide');
            $('#lr-volume-model').removeClass('hide');
        }
    }

    function addRateCard(code) {
        $('.inp_error').removeClass('inp_error');
        $('#rate-card-dialog').css('background', '#fff');
        $('#rate-card-dialog').removeClass('hide');
        $('#rate-card-dialog').dialog({
            autoOpen: true,
            height: 450,
            width: 600,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        if (code) {
            var data = _.find(rateCards, function(o) {
                return o.code === code;
            });
            $('#rate-card-name').val(data.name);
            $('#rate-card-hid-id').val(data.code);

            $('.rate-card-price-model[value="' + data.pricingModel + '"]').prop('checked', true).trigger('change');
            if (data.pricingModel == 'LRCNT') {
                if (_isdefined(data.rateCardList)) {
                    $.each(data.rateCardList || [], function(index, value) {
                        console.log(index, value);
                        var $row = addRateCardRow();

                        $row.find('#rate-card-from').val(value.fromValue);
                        $row.find('#rate-card-to').val(value.toValue);
                        $row.find('#rate-card-amount').val(value.amount);
                        console.log(value.rateCardType.code);
                        $row.find('#rate-card-type[value="' + value.rateCardType.code + '"]').prop('checked', true);
                    });
                }
            } else if (data.pricingModel == 'LRVOL') {
                $.each(data.rateCardList || [], function (i, row) {
                    $('#lrvolume-trans-percent').val(row.fromValue);
                });
            }
        } else {
            $('.rate-card-price-model[value="LRCNT"]').prop('checked', true).trigger('change');
            addRateCardRow();
            $('#rate-card-hid-id, #rate-card-name, #lrvolume-trans-percent').val('')
        }
    }

    function saveRateCardTemplate() {
        var data = {};
        data.code = $('#rate-card-hid-id').val();
        data.name = $('#rate-card-name').val();
        data.pricingModel = $.trim($('.rate-card-price-model:checked').val());
        data.activeFlag = 1;
        data.rateCardList = [];

        var err = 0;
        if (data.pricingModel == 'LRCNT') {
            var previousToValue = -1;
            $('#rate-card-list .rate-card-list-row').each(function(i, row) {
                var $row = $(row);
                var list = {};

                $row.find('input').removeClass('inp_error');
                list.fromValue = $row.find('#rate-card-from').val();
                list.toValue = $row.find('#rate-card-to').val();
                list.amount = $row.find('#rate-card-amount').val();
                list.pricingModel = data.pricingModel;
                list.rateCardType = {};
                list.rateCardType.code = $row.find('#rate-card-type:checked').val();
                data.rateCardList.push(list);
                console.log(list);

                if (list.fromValue == '') {
                    $row.find('#rate-card-from').addClass('inp_error');
                    err++;
                }

                if (list.toValue == '') {
                    $row.find('#rate-card-to').addClass('inp_error');
                    err++;
                }

                if (list.amount == '') {
                    $row.find('#rate-card-amount').addClass('inp_error');
                    err++;
                }

                if (list.fromValue && list.toValue && list.toValue != 0 && Number(list.fromValue) >= Number(list.toValue)) {
                    $row.find('#rate-card-from, #rate-card-to').addClass('inp_error');
                    $('#rate-card-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#rate-card-action-state').html('From value should be less than To value');
                    $('#rate-card-action-state').show();
                    err++;
                }

                if (list.fromValue && list.toValue && Number(list.fromValue) <= Number(previousToValue)) {
                    $row.find('#rate-card-from').addClass('inp_error');
                    $('#rate-card-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#rate-card-action-state').html('From value should be higher than previous To value');
                    $('#rate-card-action-state').show();
                    err++;
                }
                previousToValue = list.toValue;

            });
        } else if (data.pricingModel == 'LRVOL') {
            var lrVolume = {};
            lrVolume.rateCardType = {};
            lrVolume.rateCardType.code = 'VOLUME';
            lrVolume.pricingModel = data.pricingModel;
            lrVolume.fromValue = $.trim($('#lrvolume-trans-percent').val());

            if (lrVolume.fromValue == '' || isNaN(lrVolume.fromValue) || Number(lrVolume.fromValue) < 0 || Number(lrVolume.fromValue) > 100) {
                $('#lrvolume-trans-percent').addClass('inp_error');
                err++;
            }
            data.rateCardList.push(lrVolume);
        }

        if (err) return;

        if (data.name == '') {
            $('#rate-card-name').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#rate-card-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#rate-card-action-state').html('Please enter the values in the field that are marked in red');
            $('#rate-card-action-state').show();
            return false;
        } else {
            $('#rate-card-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#rate-card-action-state').html('');
            $('#rate-card-action-state').hide();
        }
        $('#form-bttons').hide();
        $('#form-loading').html(loading_popup);
        $('#form-loading').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "admin/update-rate-card-template",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#form-loading').html('');
                    $('#form-loading').hide();
                    $('#rate-card-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#rate-card-action-state').show();
                    $('#rate-card-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closeRateCardDialog();
                        checkURL();
                    }, 3000);
                } else {
                    $('#form-loading').html('');
                    $('#form-loading').hide();
                    $('#rate-card-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#rate-card-action-state').html(response.errorDesc);
                    $('#rate-card-action-state').show();
                    $('#form-bttons').show();
                }
            }
        })


    }

    var cloneId = 0;

    function addRateCardRow() {
        var rateCareRow = $('#rate-card-lis-tpl').html();
        var $tpl = $(rateCareRow);
        $tpl.find("input").prop("name", "optradio" + cloneId);
        cloneId++;
        return $tpl.appendTo('#rate-card-list');
    }

    function removeRateCardRow(btn) {
        $(btn).closest('.rate-card-list-row').remove();
    }

    function closeRateCardDialog() {
        $('#rate-card-dialog').dialog('destroy');
        $('#rate-card-dialog').hide();
        $('.rate-card-list-row').remove();
    }

    function changeStatus(code, status) {
        if (status == 2 && !confirm('Do you want to delete this rate card template?')) {
            return;
        }

        var data = _.find(rateCards, function(o) {
            return o.code === code;
        });

        data.activeFlag = status;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "admin/update-rate-card-template",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });

                    window.setTimeout(function() {
                        loading_overlay.hide();
                        checkURL();
                    }, 1000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });

                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 1000);
                }
            }
        });
    }
</script>