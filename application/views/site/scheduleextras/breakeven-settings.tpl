<div>
    <span class="pull-right">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="showBreakevenDialog();">Add New Breakeven Setting</a>
    </span>
    <span class="pull-left">
        <span class="bold">Breakeven Settings</span> <br>
        <i class="fa fa-info-circle"> </i> &nbsp; Breakeven Configuration Settings.
    </span>
</div>

<br><br><br>

<div class="row">
    <div class="col-md-9 col-md-offset-1">

        <div class="panel-group" id="accordion">
            {foreach item=row from=$breakeven_settings} 
                <div class="panel panel-info" id="breakeven-{$row->code}">
                    <div class="panel-heading">
                        <h3 class="panel-title"> 
                            <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row->code}">

                                <div class="row">
                                    <div class="col-sm-8">{$row->name}</div>
                                    <div class="col-sm-2">{$row->breakevenDetails->mileage + 0} Kmpl</div>
                                </div>
                            </a>
                            <div class="btn-group btn-group-xs ac_bu">
                                <a href="javascript:;" class="btn btn-default btn-sm" id="breakeven-status-{$row->code}" data-status="{$row->activeFlag}" onclick="editBreakevenStatus('{$row->code}')">
                                    {if $row->activeFlag == 1}
                                        <i class="fa fa-times" title="Click to disable"></i>
                                    {else}
                                        <i class="fa fa-check" title="Click to enable"></i>
                                    {/if}
                                </a>
                                <a href="javascript:;" title="edit" class="btn btn-default btn-sm" id="breakeven-edit-{$row->code}" onclick="showBreakevenDialog('{$row->code}')" {if $row->activeFlag != 1}style="display: none;"{/if}><i class="fa fa fa-pencil"></i></a>
                                <a href="javascript:;" title="delete" class="btn btn-default btn-sm" onclick="deleteBreakevenDialog('{$row->code}')"><i class="fa fa-trash-o"></i></a>
                            </div>
                        </h3>
                    </div>  
                    <div id="collapse-{$row->code}" class="panel-collapse collapse">
                        <div class="panel-body"> 

                            <div class="col-md-12">
                                <div class="row">
                                    <label class="col-xs-2">Name</label>
                                    <div class="col-xs-9">{$row->name}</div>
                                </div>
                                <div class="row">
                                    <label class="col-xs-2">Layout</label>
                                    <div class="col-xs-9">{$row->bus->categoryCode|bus_category_string} - ({$row->bus->seatCount} Seats)</div>
                                </div>
                                <div class="row">
                                    <label class="col-xs-2">Avg. Mileage</label>
                                    <div class="col-xs-9">{$row->breakevenDetails->mileage + 0} Kmpl</div>
                                </div>
                                <hr class="m-t-4 m-b-4"/>
                                <div class="row">
                                    <label class="col-xs-2">Tax</label>
                                    <div class="col-xs-12">
                                        <ol class="p_l_15">
                                            {foreach item=tax from=$row->breakevenDetails->tax} 
                                                <li>{$tax->name} - {$tax->value} - {$breakeven_setting_type[$tax->type]}</li>
                                            {/foreach}
                                        </ol>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-xs-2">Expense</label>
                                    <div class="col-xs-12">
                                        <ol class="p_l_15">
                                            {foreach item=expense from=$row->breakevenDetails->expense} 
                                                <li>{$expense->name} - {$expense->value} - {$breakeven_setting_type[$expense->type]}</li>
                                            {/foreach}
                                        </ol>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            {foreachelse}
                <div class="well well-large "> No Breakeven Settings found!</div>
            {/foreach}
        </div>
        
    </div>
</div>


<!-- Breakeven Setting Popup -->
<div id="breakeven-setting-dialog"  class="dialog-content-page" style="display: none;">
    <form role="form" id="breakeven-setting-form" class="p_t_20">

        <div class="col-lg-7 p_l_n p_r_n">
            <div class="col-lg-12">
                <label class="req">Name</label>
                <input type="text" class="form-control" id="breakeven-name" placeholder="Name" maxlength="256"/>
            </div>

            <div class="clear_fix_both"></div><br/>

            <div class="col-lg-4">
                <label class="req">Avg. Mileage</label>
                <div class="input-group">
                    <input type="number" class="form-control no-spin" id="breakeven-mileage" placeholder="Mileage"/>
                    <span class="input-group-addon">Kmpl</span>
                </div>
            </div>

            <div class="col-md-8">
                <div class="form-group">
                    <label class="req">Bus Type</label>
                    <select id="breakeven-bustype" class="form-control" onchange="loadBusPreview();">
                        <option value="">Select a Bus Type</option>
                        {foreach item=bus from=$buses}
                            <option value="{$bus->code}">{$bus->name} - ({$bus->seatCount} - seats) - {$bus->code} </option>
                        {/foreach}
                    </select>
                </div>
            </div>

            <div class="clear_fix_both"></div><br/>

            <fieldset class="col-md-12">
                <legend>
                    <label class="d-inline-block">Tax</label> 
                    <a href="javascript:;" class="btn btn-xs pull-right btn-primary" onclick="addBreakevenDetail('#breakeven-tax-list')">Add tax</a>
                </legend>

                <div id="breakeven-tax-list"></div>
            </fieldset>
            <fieldset class="col-md-12">
                <legend>
                    <label class="d-inline-block">Expenses</label>
                    <a href="javascript:;" class="btn btn-xs pull-right btn-primary" onclick="addBreakevenDetail('#breakeven-expense-list')">Add Expense</a>
                </legend>

                <div id="breakeven-expense-list"></div>
            </fieldset>

            <div class="clear_fix_both"></div><br/>
            <div class="alert col-md-12" id="breakeven-action-state" style="display: none;"></div>

            <div class="col-md-12 text-right">
                <input type="hidden" id="breakeven-code-hid" value="" />
                <button class="btn btn-success" type="button" onclick="saveBreakevenDialog();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelBreakevenDialog();">Cancel</button>
            </div>

        </div>
        <div class="col-lg-5 p_l_n p_r_n">
            <div id="sch-bus-over-seat-map">
                <br><div class="well well-large text-center"> Please select a Bus Type to load preview!</div>
            </div> 
        </div>

        <div class="clear_fix_both"></div><br/>
    </form>
</div>

<script type="text/template" id="breakeven-details-row-tpl">
    <div class="row breakeven-detail">
        <div class="col-md-4">
            <input type="text" class="form-control name-inp" placeholder="Name"/>
        </div>
        <div class="col-md-6">
            <div class="form-group col-md-6 p_r_n p_l_n">
                <div class="input-group col-md-12">
                    <input type="text" class="form-control value-inp" placeholder="Value"/>
                </div>
            </div>
            <div class="form-group col-md-6 p_l_n p_r_n">
                <select class="form-control type-inp">
                    {foreach item=val key=key from=$breakeven_setting_type}
                        <option value="{$key}">{$val}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="col-md-2">
            <button class="btn btn-sm btn-default remove-row" onclick="deleteBreakevenDetail(this)"><i class="fa fa-times"></i></button>
        </div>
    </div>
</script>

<script>
    var allBreakevenSetting = {$breakeven_settings|json_encode};

    function addBreakevenDetail(id) {
        var $tpl = $($('#breakeven-details-row-tpl').html());
        $(id).append($tpl);
    }

    function deleteBreakevenDetail(btn) {
        $(btn).closest('.breakeven-detail').remove();
    }

    function loadBusPreview(){
        var data = {}
        data.busType = $('#breakeven-bustype').val();
        if (data.busType == ''){
            $('#sch-bus-over-seat-map').html('<br><div class="well well-large text-center"> Please select a Bus Type to load preview!</div>');
            return;
        }
        $('#sch-bus-over-seat-map').removeClass('hide');
        $('#sch-bus-over-seat-map').html(loading_small);
        $.ajax({
            type: "POST",
            url: "schedules/get-bus-seatmap",
            data: data,
            dataType: 'html',
            success: function (res) {
                $('#sch-bus-over-seat-map').html(res);
            }
        });
    }

    function showBreakevenDialog(code) {
        $('#breakeven-setting-dialog').dialog({
            autoOpen: true,
            height: $(window).height() - 150,
            width: $(window).width() - 300,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        $('.inp_error').removeClass('inp_error');
        $('#breakeven-action-state').html('').hide();

        if(code) {
            var data = _.find(allBreakevenSetting, function (o) {
                return o.code === code;
            });
            $('#breakeven-code-hid').val(code);
            $('#breakeven-name').val(data.name);
            $('#breakeven-mileage').val(data.breakevenDetails.mileage);
            $('#breakeven-bustype').val(data.bus.code).trigger('change');

            $('#breakeven-tax-list').html('');
            $.each(data.breakevenDetails.tax || [], function (i, row) {
                var $tpl = $($('#breakeven-details-row-tpl').html());

                $tpl.find('.name-inp').val(row.name);
                $tpl.find('.value-inp').val(row.value);
                $tpl.find('.type-inp').val(row.type);
                $('#breakeven-tax-list').append($tpl);
            });

            $('#breakeven-expense-list').html('')
            $.each(data.breakevenDetails.expense || [], function (i, row) {
                var $tpl = $($('#breakeven-details-row-tpl').html());

                $tpl.find('.name-inp').val(row.name);
                $tpl.find('.value-inp').val(row.value);
                $tpl.find('.type-inp').val(row.type);
                $('#breakeven-expense-list').append($tpl);
            });
        } else {
            $('#breakeven-code-hid').val('');
            $('#breakeven-name').val('');
            $('#breakeven-mileage').val('');
            $('#breakeven-bustype').val('').trigger('change');

            var $tpl = $($('#breakeven-details-row-tpl').html());
            $('#breakeven-tax-list').html($tpl);

            var $tpl = $($('#breakeven-details-row-tpl').html());
            $('#breakeven-expense-list').html($tpl);
        }
    }

    function saveBreakevenDialog () {
        var data = {};
        var err = 0;

        data.activeFlag = 1;
        data.code = $('#breakeven-code-hid').val();
        data.name = $('#breakeven-name').val().trim();
        data.bus = {};
        data.bus.code = $('#breakeven-bustype').val();
        data.breakevenDetails = {};
        data.breakevenDetails.mileage = $('#breakeven-mileage').val().trim();

        data.breakevenDetails.tax = [];
        $('#breakeven-tax-list .breakeven-detail').each(function() {
            var obj = {};
            obj.name = $('.name-inp', this).val().trim();
            obj.value = $('.value-inp', this).val().trim();
            obj.type = $('.type-inp', this).val();

            if(obj.name == '' && obj.value == '' && obj.type == 'NA') {
                return;
            }

            if(obj.name == '') {
                $('.name-inp', this).addClass('inp_error');
                err++;
            }
            if(data.value == '') {
                $('.value-inp', this).addClass('inp_error');
                err++;
            }

            data.breakevenDetails.tax.push(obj);
        });

        data.breakevenDetails.expense = [];
        $('#breakeven-expense-list .breakeven-detail').each(function() {
            var obj = {};
            obj.name = $('.name-inp', this).val().trim();
            obj.value = $('.value-inp', this).val().trim();
            obj.type = $('.type-inp', this).val();

            if(obj.name == '' && obj.value == '' && obj.type == 'NA') {
                return;
            }

            if(obj.name == '') {
                $('.name-inp', this).addClass('inp_error');
                err++;
            }
            if(data.value == '') {
                $('.value-inp', this).addClass('inp_error');
                err++;
            }

            data.breakevenDetails.expense.push(obj);
        });

        if(data.name == '') {
            $('#breakeven-name').addClass('inp_error');
            err++;
        }
        if(data.bus.code == '') {
            $('#breakeven-bustype').addClass('inp_error');
            err++;
        }
        if(data.breakevenDetails.mileage == '') {
            $('#breakeven-mileage').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#breakeven-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#breakeven-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#breakeven-action-state').show();
            return false;
        }

        $('#breakeven-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#breakeven-action-state').html(loading_popup);
        $('#breakeven-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'scheduleextras/update-breakeven-settings',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#breakeven-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#breakeven-action-state').html('Your request has been completed successfully');
                    setTimeout(function () {
                        cancelBreakevenDialog();
                        getBreakevenSettings();
                    }, 3000);
                } else {
                    $('#breakeven-action-state').addClass('alert-danger');
                    $('#breakeven-action-state').html(response.errorDesc);
                }
            }
        });
    }
    
    function editBreakevenStatus(code) {
        var data = _.find(allBreakevenSetting, function (o) {
            return o.code === code;
        });
        data.activeFlag = 1 - $('#breakeven-status-' + code).data('status');

        var loading_overlay = iosOverlay({
            text: "Loading...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'scheduleextras/update-breakeven-settings',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    if (data.activeFlag == 1) {
                        $('#breakeven-edit-' + code).show();
                        $('#breakeven-status-' + code).data('status', data.activeFlag)
                            .html('<i class="fa fa-times" title="Click to disable"></i>');
                    } else {
                        $('#breakeven-edit-' + code).hide();
                        $('#breakeven-status-' + code).data('status', data.activeFlag)
                            .html('<i class="fa fa-check" title="Click to enable"></i>');
                    }
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
                }, 2000);
            }
        });
    }

    function deleteBreakevenDialog(code) {
        if (!confirm('Do you want to delete this Breakeven Setting?')) {
            return;
        }
        var data = _.find(allBreakevenSetting, function (o) {
            return o.code === code;
        });
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'scheduleextras/update-breakeven-settings',
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
                    getBreakevenSettings();
                }, 2000);
            }
        });
    }

    function cancelBreakevenDialog() {
        $('#breakeven-setting-dialog').dialog('destroy');
        $('#breakeven-setting-dialog').hide();
    }
</script>