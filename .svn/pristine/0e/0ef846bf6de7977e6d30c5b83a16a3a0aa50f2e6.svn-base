<div class="brand_top">
    <h3> Billing Configuration</h3>
</div>
<div id="main_wrapper">
    <div class="page_content" style="min-height: 350px;">
        <div id="container-fluid">
            <div class="row">
                <div id="billing-subscription" class="">
                    <br>
                    <div class="col-lg-12">
                        <div class="col-lg-6 pb20">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="">
                                        <div class="col-md-6 p_l_n">
                                            <label for="">Client Notify Email</label>
                                            <div class="form-group">
                                                <input type="text" class="form-control" id="billing-email" value="{$result->email}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="">Billing Start Date</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="billing-startDate" readonly="true" placeholder="Start Date" value="{$result->startDate|date_format:$ns_date_format}">
                                                <label class="input-group-addon" for="collection_rpt_from"><i class="fa fa-calendar"></i></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 pb20">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="">
                                        <div class="d-flex justify-space-between align-items-center">
                                            <label>Min. Billing Amount</label>
                                            <div class="input-group">
                                                <label class="input-group-addon bold">Rs.</label>
                                                <input type="number" class="form-control wid-100 no-spin" id="min-billing-amount" placeholder="Amount" min="0" value="{$result->minBillingAmount}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clear_fix_both"></div>
                        <div class="col-lg-12 pb20">
                            <div class="panel panel-default">
                                <div class="">
                                    <div class="">
                                        <div class="d-flex align-items-center">
                                            <label><b>Pricing Model: </b></label>&emsp;
                                            <div class="input-group">
                                                <label class="d-inline-block">
                                                    <input type="radio" name="optradio" class="rate-card-price-model" onchange="setRateCardPriceModel(this)" value="LRCNT" checked>
                                                    LR Count
                                                    &nbsp;
                                                </label>
                                                <label class="d-inline-block">
                                                    <input type="radio" name="optradio" class="rate-card-price-model" onchange="setRateCardPriceModel(this)" value="LRVOL">
                                                    LR Volume
                                                    &nbsp;
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clear_fix_both"></div>
                        <div class="col-lg-12 pb20">
                            <div class="d-flex justify-space-between pb10">
                                <h5 class="header">Create Billing Rate Card</h5>
                                <div class="dropdown" id="rate-card-dropdown">
                                    <button class="btn btn-primary dropdown-toggle" id="cargo-button" type="button" data-toggle="dropdown">Use Template
                                        <span class="caret"></span></button>
                                    <ul class="dropdown-menu">
                                        {foreach from=$rateCardTemplate item=item key=key name=name}
                                            <li>
                                                <a href="javascript:;" onclick="setRateCardList('{$item->code}');">
                                                    {$item->name}<br>
                                                    <small class="text-muted">{$billing_conf_pricing_model[$item->pricingModel]}</small>
                                                </a>
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>

                            <div id="rate-card-list"></div>
                            <div id="rate-card-lrvolume" class="hide">
                                <div class="row">
                                    <div class="col-lg-6 pb20">
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <div class="">
                                                    <div class="d-flex justify-space-between align-items-center">
                                                        <label class="bold">Total Transaction Value %</label>
                                                        <div class="input-group">
                                                            <input type="number" class="form-control wid-100 no-spin" id="lrvolume-trans-percent" placeholder="Percentage" min="0" max="100">
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
                    <div class="clear_fix_both"></div>

                    {* ratecard preview *}
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-12 pb20">
                                <div class="col-md-6" id="rate-card-preview">
                                    <h5 class="header">Rate Card Preview</h5>
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <div>
                                                <table class="table table-bordered hide" id="rate-card-preview-table">
                                                    <thead>
                                                        <th>Total Receipts Per Month</th>
                                                        <th>Pricing</th>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                                <label class="bold form-group hide" id="rate-card-volume-preview"></label>
                                            </div>
                                            <div id="notification-amount-preview">
                                                {* <span><b>SMS : </b>0.20 paise / SMS </span>
                                                <span><b>Email : </b> 0.20 paise / Nil</span>
                                                <span><b>Whatsapp :</b> 0.20 paise / Msg </span>
                                                <span><b>EzeeBot :</b> 0.20 paise /User </span> *}
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <h5 class="header">Notification</h5>

                                    <div class="col-md-6 pb10">
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <label class="bold">
                                                    <input type="checkbox" class="he_25 form-check-input notify-medium" value="SMS"> Enable SMS
                                                </label>
                                                <div class="d-flex justify-space-between notification-amt-div">
                                                    <label> Per SMS Cost</label>
                                                    <input type="text" class="form-control wid-100 notify-amount" id="sms-amount" data-code="SMS">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    {* <div class="clear_fix_both"></div> *}

                                    <div class="col-md-6 pb10">
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <label class="bold">
                                                    <input type="checkbox" class="he_25 form-check-input notify-medium" value="MAIL"> Enable Email
                                                </label>
                                                <div class="d-flex justify-space-between notification-amt-div">
                                                    <label> Per Email Cost</label>
                                                    <input type="text" class="form-control wid-100 notify-amount" id="mail-amount" data-code="MAIL">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clear_fix_both"></div>

                                    <div class="col-md-6 pb10">
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <label class="bold">
                                                    <input type="checkbox" class="he_25 form-check-input notify-medium" value="WAP"> Enable Whatsapp
                                                </label>
                                                <div class="d-flex justify-space-between notification-amt-div">
                                                    <label> Per Msg Cost</label>
                                                    <input type="text" class="form-control wid-100 notify-amount" id="wap-amount" data-code="WAP">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    {* <div class="clear_fix_both"></div> *}

                                    <div class="col-md-6 pb10">
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <label class="bold">
                                                    <input type="checkbox" class="he_25 form-check-input notify-medium" value="APP"> Enable EzeeBot
                                                </label>
                                                <div class="d-flex justify-space-between notification-amt-div">
                                                    <label> Per User Cost</label>
                                                    <input type="text" class="form-control wid-100 notify-amount" id="app-amount" data-code="APP">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="clear_fix_both"></div>

                    <div class="col-lg-12">
                        <div class="col-md-6">
                            <h5 class="header">Terms for Billing & Grace Period</h5>

                            <div class="col-md-12 pb20 p_l_n">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="d-flex justify-space-between align-items-center">
                                            <div class="col-md-6 p_l_n">
                                                <label class="bold">Billing Cycle</label>
                                                <p class="help-block">[ As per calender days, based on this Invoice will be generated ]</p>

                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-group">
                                                    <input type="number" min="0" class="form-control wid-100" id="billing-cycle" placeholder="Price" value={$result->billingPeriod}>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="grace-period-div">

                            </div>




                        </div>
                        {* addon notificaion *}

                        <div class="col-md-6">
                            <h5 class="header">Add On</h5>
                            <div class="col-md-9 pb10">
                                <div class="panel panel-default">
                                    <div class="panel-body d-flex justify-space-between align-items-center">
                                        <label class="bold">
                                            <input type="checkbox" class="he_25 form-check-input notify-addon" value="S"> Enable Custom SMS Masking
                                        </label>
                                        <input type="text" class="form-control wid-100 addon-amount" id="addon-amount" data-code="S">
                                    </div>
                                </div>
                            </div>

                            <div class="clear_fix_both"></div>

                            <div class="col-md-9 pb10">
                                <div class="panel panel-default">
                                    <div class="panel-body d-flex justify-space-between align-items-center">
                                        <label class="bold">
                                            <input type="checkbox" class="he_25 form-check-input notify-addon" value="E"> Enable Custom Email Masking
                                        </label>
                                        <input type="text" class="form-control wid-100 addon-amount" id="addon-amount" data-code="E">
                                    </div>
                                </div>
                            </div>


                            <div class="clear_fix_both"></div>

                            <div class="col-md-9 pb10">
                                <div class="panel panel-default">
                                    <div class="panel-body d-flex justify-space-between align-items-center">
                                        <label class="bold">
                                            <input type="checkbox" class="he_25 form-check-input notify-addon" value="B"> Enable EzeeBot Notifications
                                        </label>
                                        <input type="text" class="form-control wid-100 addon-amount" id="addon-amount" data-code="B">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="clear_fix_both"></div>

                    <div class="row pb10 d-flex justify-center">
                        <div class="" id="form-loading"></div>
                        <div class="alert fl" id="rate-card-action-state"></div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 d-flex justify-center">
                            <button class="btn btn-success" type="button" onclick="saveBillingConfiguration();">Save</button>
                        </div>
                    </div>

                    <!--panel end-->
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="grace-period-list-tpl">
    <div class="row p_l_n grace-period-row pb10">
        <div class="col-md-12 pb20">
            <div class="col-md-8 p_l_n">
                <div class="panel panel-default custom-panel">
                    <div class="panel-body">
                        <div class="d-flex justify-space-between align-items-center">
                            <div class="col-md-6 p_l_n">
                                <label class="bold">Grace Period</label>
                                <p class="help-block">[ Given after billing cycle ]</p>

                            </div>
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="number" min="0" class="form-control wid-100" id="grace-period">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-2 grace-period-remove-div">
                <div class="panel panel-default custom-panel">
                    <div class="panel-body text-center">
                        <a href="javascript:;" id="billing-add-button" onclick="removeGracePeriodRow(this)">
                            <i class="fa fa-times" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-2 grace-period-add-div">
                <div class="panel panel-default custom-panel">
                    <div class="panel-body text-center">
                        <a href="javascript:;" id="billing-add-button" onclick="addGracePeriodRow('1')">
                            <i class="fa fa-plus" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12">
            <p class="help-block">Activities carried out after the above grace period ended</p>

            <div id="billing-events">
                {foreach from=$billing_events item=item key=key name=name}
                    <div class="col-md-4">
                        <label class="checkbox-inline">
                            <input type="checkbox" class="he_25 form-check-input billing-extension" value="{$item['menu']}" data-event="{$item['event']}"> {$item['name']}
                        </label>
                    </div>
                {/foreach}
            </div>

        </div>
    </div>
</script>

<script type="text/html" id="rate-card-lis-tpl">
    <div class="row d-flex align-items-center rate-card-list-row pb10">
        <div class="col-md-4">
            <div class="panel panel-default custom-panel">
                <div class="panel-body">
                    <div class="d-flex justify-space-between align-items-center">
                        <label>Receipts</label>

                        <input type="text" class="form-control wid-100" id="rate-card-from" placeholder="From">
                        <input type="text" class="form-control wid-100" id="rate-card-to" placeholder="To">
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-2">
            <div class="input-group">
                <label>
                    <input type="radio" name="optradio" id="rate-card-type" class="rate-card-type" onchange="setRateCardPriceType(this)" data-type="Receipt" value="METERED" checked>METERED
                    &nbsp;
                    </label>
                <label>
                    <input type="radio" name="optradio" id="rate-card-type" class="rate-card-type" onchange="setRateCardPriceType(this)" data-type="Flat" value="FIXED">FIXED
                    &nbsp;
                    </label>
            </div>
        </div>

        <div class="col-md-4">
            <div class="panel panel-default custom-panel">
                <div class="panel-body">
                    <div class="d-flex justify-space-between align-items-center">
                        <label>Price</label>
                        <div class="input-group">
                            <input type="text" class="form-control wid-100" id="rate-card-amount" placeholder="Price">
                            <label class="input-group-addon priceType">Flat</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-1 rate-card-remove-div">
            <div class="panel panel-default custom-panel">
                <div class="panel-body text-center">
                    <a href="javascript:;" id="billing-add-button" onclick="removeRateCardRow(this)">
                        <i class="fa fa-times" aria-hidden="true"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-1 rate-card-add-div">
            <div class="panel panel-default custom-panel">
                <div class="panel-body text-center">
                    <a href="javascript:;" id="billing-add-button" onclick="addRateCardRow()">
                        <i class="fa fa-plus" aria-hidden="true"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</script>

<script>
    var result = {$result|json_encode};
    var rateCardTemplate = {$rateCardTemplate|json_encode};
    var cloneId = 0;
    $(document).ready(function() {
        result.pricingModel = result.pricingModel || 'LRCNT'; // default

        $('.rate-card-price-model[value="' + result.pricingModel + '"]').prop('checked', true).trigger('change');

        if (result.pricingModel == 'LRCNT') {
            if (_isdefined(result.billingRateCard) && result.billingRateCard.length) {
                $('#rate-card-list').html(loading_popup);
                extractRateCard(result.billingRateCard);
            } else {
                addRateCardRow();
            }
        } else if (result.pricingModel == 'LRVOL') {
            $.each(result.billingRateCard || [], function (i, row) {
                $('#lrvolume-trans-percent').val(row.fromValue);
            });
            setRateCardPreview();
        }

        if (_isdefined(result.billingNotification)) {
            var notifyPreview = '';
            $.each(result.billingNotification || [], function(index, value) {
                if (value.activeFlag != 1) return;
                $('.notify-medium[value="' + value.notificationMedium.code + '"]').prop('checked', true);
                $('.notify-amount[data-code="' + value.notificationMedium.code + '"]').val(value.amount);
                
                notifyPreview += '<span><b>'+value.notificationMedium.code+' : </b>'+value.amount+' <i class="fa fa-inr"></i> / '+value.notificationMedium.code+'</span>';
            })
            $('#notification-amount-preview').html(notifyPreview);
        }

        if (_isdefined(result.addonDetails)) {
            $.each(result.addonDetails || [], function(index, value) {
                $('.addon-amount[data-code="' + value.code + '"]').val(value.value);
                if (value.activeFlag != 1) return;
                $('.notify-addon[value="' + value.code + '"]').prop('checked', true);
            })
        }

        if (_isdefined(result.billingExtension) && result.billingExtension.length) {
            extractGracePeriod(result.billingExtension);
        } else {
            addGracePeriodRow('1');
        }

        $('#billing-startDate').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true
        })
    })

    function setRateCardPriceModel(el) {
        var model = $(el).val();

        $('#rate-card-list').addClass('hide');
        $('#rate-card-lrvolume').addClass('hide');

        if (model == 'LRCNT') {
            $('#rate-card-list').removeClass('hide');
            $('#rate-card-lrvolume').addClass('hide');
            if ($('#rate-card-list .rate-card-list-row').length == 0) {
                addRateCardRow();
            }
        } else if (model == 'LRVOL') {
            $('#rate-card-list').addClass('hide');
            $('#rate-card-lrvolume').removeClass('hide');
        }
    }

    function setRateCardPriceType(ele) {
        $(ele).closest('.rate-card-list-row').find('.priceType').text('Flat')
        if ($(ele).val() == "METERED") {
            $(ele).closest('.rate-card-list-row').find('.priceType').text('Receipt')
        }
    }

    function addRateCardRow(code) {
        var rateCareRow = $('#rate-card-lis-tpl').html();
        var $tpl = $(rateCareRow);
        $tpl.find("input").prop("name", "optradio" + cloneId);
        cloneId++;
        if (code) {
            return $tpl.appendTo('#rate-card-list');
        } else {
            $tpl.appendTo('#rate-card-list');
            resetAddRemoveRateCard();
        }
    }

    function addGracePeriodRow(code) {
        var gracePeriodRow = '';
        gracePeriodRow = $('#grace-period-list-tpl').html();

        if ($('.grace-period-row').length) {
            gracePeriodRow = $('.grace-period-row:last').clone();
        }

        var $tpl = $(gracePeriodRow);
        $tpl.find('#grace-period').attr('data-code', '');
        
        if (code == 1) {
            $tpl.appendTo('#grace-period-div');
            resetAddRemoveGracePeriod();
        } else {
            return $tpl.appendTo('#grace-period-div')

        }

    }

    function removeRateCardRow(btn) {
        if ($('.rate-card-list-row').length == 1) return;
        $(btn).closest('.rate-card-list-row').remove();
        resetAddRemoveRateCard();
    }

    function removeGracePeriodRow(btn) {
        if ($('.grace-period-row').length == 1) return;
        $(btn).closest('.grace-period-row').remove();
        resetAddRemoveGracePeriod();
    }

    function setRateCardList(code) {
        if (!code) return;

        var data = _.find(rateCardTemplate, function(o) {
            return o.code === code;
        });

        $('.rate-card-price-model[value="' + data.pricingModel + '"]').prop('checked', true).trigger('change');

        if (data.pricingModel == 'LRCNT') {
            extractRateCard(data.rateCardList);
        } else if (data.pricingModel == 'LRVOL') {
            $.each(data.rateCardList || [], function (i, row) {
                $('#lrvolume-trans-percent').val(row.fromValue);
            });
            setRateCardPreview();
        }
    }

    function extractRateCard(data) {
        $('#rate-card-list').html('');

        $.each(data || [], function(index, value) {
            var $row = addRateCardRow(data);

            $row.find('#rate-card-from').val(value.fromValue);
            $row.find('#rate-card-to').val(value.toValue);
            $row.find('#rate-card-amount').val(value.amount);
            $row.find('#rate-card-type[value="' + value.rateCardType.code + '"]').prop('checked', true);

            if (value.rateCardType.code == "METERED") {
                $row.find('.priceType').text('Receipt')
            }
        });

        resetAddRemoveRateCard();
        setRateCardPreview();
    }

    function setRateCardPreview() {
        var pricingModel = $.trim($('.rate-card-price-model:checked').val());

        $('#rate-card-preview-table').addClass('hide');
        $('#rate-card-volume-preview').addClass('hide');
        if (pricingModel == 'LRCNT') {
            var html = '';
            $('#rate-card-list .rate-card-list-row').each(function(i, row) {
                var $row = $(row);
                html += '<tr>';
                var toValue = ($row.find('#rate-card-to').val() == 0)? 'Infinity' : $row.find('#rate-card-to').val();
                html += '<td>' + $row.find('#rate-card-from').val() + ' to ' + toValue + '</td>'
                html += '<td><i class="fa fa-inr"></i>&nbsp; ' + $row.find('#rate-card-amount').val() + '&nbsp; /' + $row.find('#rate-card-type:checked').data('type') + '</td>';
            });

            $('#rate-card-preview-table tbody').html(html);
            $('#rate-card-preview-table').removeClass('hide');
        } else if (pricingModel == 'LRVOL') {
            var html = $('#lrvolume-trans-percent').val() + '% of Total Transactions per month';
            $('#rate-card-volume-preview').html(html).removeClass('hide');
        }

    }

    function resetAddRemoveRateCard() {
        $('.rate-card-list-row:last').find('.rate-card-add-div').removeClass('hide');
        $('.rate-card-list-row').not(':last').find('.rate-card-add-div').addClass('hide');
    }

    function resetAddRemoveGracePeriod() {
        $('.grace-period-row:last').find('.grace-period-add-div').removeClass('hide');
        $('.grace-period-row').not(':last').find('.grace-period-add-div').addClass('hide');
    }

    function extractGracePeriod(data) {
        $.each(data || [], function(index, value) {
            var $row = addGracePeriodRow(data);
            $row.find('#grace-period').val(value.gracePeriod);
            $row.find('#grace-period').attr('data-code', value.code);
            $.each(value.menu || [], function(i, v) {
                $row.find('.billing-extension[value="' + v.code + '"]').prop('checked', true);
            });
        });

        resetAddRemoveGracePeriod();
    }

    function saveBillingConfiguration() {
        var data = {};
        data.name = '';
        data.email = $('#billing-email').val();
        data.startDate = $('#billing-startDate').data('datepicker').getFormattedDate('yyyy-mm-dd');
        data.billingPeriod = $('#billing-cycle').val();
        data.minBillingAmount = $.trim($('#min-billing-amount').val());
        data.pricingModel = $.trim($('.rate-card-price-model:checked').val());
        data.billingRateCard = [];
        data.billingNotification = [];
        data.activeFlag = 1;

        $('.notify-medium').each(function(i, row) {
            var list = {};
            var code = $(row).val();
            list.notificationMedium = {}
            list.notificationMedium.code = code;
            list.activeFlag = +$(row).is(':checked');
            list.amount = $('.notify-amount[data-code="' + code + '"]').val() || 0;

            data.billingNotification.push(list);
        });

        data.addonDetails = [];

        $('.notify-addon').each(function(i, row) {
            var list = {};
            list.code = $(row).val();
            list.activeFlag = +$(row).is(':checked');
            list.value = $('.addon-amount[data-code="' + list.code + '"]').val();
            data.addonDetails.push(list);
        });

        var err = 0;
        if (data.pricingModel == 'LRCNT') {
            var previousToValue = -1;
            $('.rate-card-list-row:last').find('#rate-card-to').val() //above value 
            $('#rate-card-list .rate-card-list-row').each(function(i, row) {
                var $row = $(row);
                var list = {};

                $row.find('input').removeClass('inp_error');
                list.fromValue = $row.find('#rate-card-from').val();
                list.toValue = $row.find('#rate-card-to').val();
                list.amount = $row.find('#rate-card-amount').val();
                list.rateCardType = {};
                list.rateCardType.code = $row.find('#rate-card-type:checked').val();
                data.billingRateCard.push(list);

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
            lrVolume.fromValue = $.trim($('#lrvolume-trans-percent').val());

            if (lrVolume.fromValue == '' || isNaN(lrVolume.fromValue) || Number(lrVolume.fromValue) < 0 || Number(lrVolume.fromValue) > 100) {
                $('#lrvolume-trans-percent').addClass('inp_error');
                err++;
            }
            data.billingRateCard.push(lrVolume);
        }

        data.gracePeriod = [];

        var billlingExtension = $.map(result.billingExtension || [], function(i, row) {
            i.activeFlag = 0;
            return i;
        });

        $('#grace-period-div .grace-period-row').each(function(i, row) {
            var list = {};
            var $row = $(row);
            list.code = $row.find('#grace-period').data('code');
            list.gracePeriod = $row.find('#grace-period').val();
            list.activeFlag = 1;
            list.menu = [];
            list.menuEvents = [];

            $row.find('.billing-extension').each(function(index, value) {
                var menu = {};
                var menuEvents = {};
                if ($(value).is(':checked')) {
                    menu.code = $(value).val();
                    menuEvents.code = $(value).data('event');

                    list.menu.push(menu);
                    list.menuEvents.push(menuEvents);
                }
            })
            data.gracePeriod.push(list);
        });

        data.gracePeriod = $.extend(billlingExtension, data.gracePeriod);

        if (err) return;

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
            url: base_url + "admin/update-billing-configuration",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#form-loading').html('');
                    $('#form-loading').hide();
                    $('#rate-card-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#rate-card-action-state').show();
                    $('#rate-card-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
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
</script>