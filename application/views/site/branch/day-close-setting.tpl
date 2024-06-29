<div class="brand_top">
    <h3>Day Close Setting</h3>
    <div class="text-right noprint">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="addDayCloseSetting();">Add Day Close Setting</a>
    </div>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12"> <br>
                <div class="row">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="table table-responsive" style="width: 75%;">
                                    <table class="table table-bordered" id="day-close-setting-table">
                                        <thead>
                                            <tr class="success">
                                                <th>Day Close Type</th>
                                                <th>Branch</th>
                                                <th>Day Closing Time</th>
                                                <th>Max. Unclosed Days allowed</th>
                                                <th>Max. Pending Approval Count allowed</th>
                                                <th>Credit Limit</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach from=$dayCloseSettings item=row}
                                                <tr>
                                                    <td align="center">
                                                        {if $row->dayCloseType == "AUTO"}
                                                            <span class="badge badge-success">Auto</span>
                                                        {else if $row->dayCloseType == "MNUL"}
                                                            <span class="badge badge-primary">Manual</span>
                                                        {/if}
                                                    </td>
                                                    <td width="25%">
                                                        <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                {foreach from=$row->organizations item=branch}
                                                                    <li>{$branch->name}</li>
                                                                {/foreach}
                                                            </ul>'>
                                                            {if ($row->organizations|@count) >= 1}{$row->organizations[0]->name}{/if}
                                                            {if ($row->organizations|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->organizations|@count}</span>{/if}
                                                        </a>
                                                    </td>
                                                    <td align="center">{$row->dayCloseHour|cat:':00'|date_format:'h:i A'}</td>
                                                    <td align="center">{$row->maxUnclosedDays} Days</td>
                                                    <td align="center">{$row->maxPendingApprovalCount}</td>
                                                    <td align="right">{$row->creditLimit|inr_format}</td>
                                                    <td>
                                                        <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick='addDayCloseSetting("{$row->code}")'><i class="fa fa-pencil"></i></a>
                                                        <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick='deleteDayCloseSetting("{$row->code}")'><i class="fa fa-trash-o"></i></a>
                                                    </td>
                                                </tr>
                                            {foreachelse}
                                                <tr>
                                                    <td colspan="7" align="center">No data found</td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="add-day-close-setting-dialog"  class="dialog-content-page hide">
    <div>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label class="" for="day-close-setting-type">&nbsp;</label>
                    <div class="input-group">
                        <label class="radio-inline">
                            <input type="radio" name="optradio" class="day-close-setting-type" value="MNUL" checked>Manual&nbsp;
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="optradio" class="day-close-setting-type" value="AUTO">Auto&nbsp;
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-group col-md-4">
                <label class="req" for="day-close-setting-branch">Branch</label>
                <select id="day-close-setting-branch" class="form-control" multiple>                                                                    
                    <option value="">Select a Branch</option>
                    {foreach from=$organizations item=val}
                            <option value="{$val->code}">{$val->name}</option>
                    {/foreach}
                </select>     
            </div>
            
            <div class="col-md-4">
                <label for="day-close-setting-hour" class="req">Day Close Hour</label>
                <select class="form-control" id="day-close-setting-hour">
                    <option value="">Select Hour</option>
                    {for $hour=0 to 23}
                        <option value="{$hour}">{$hour}</option>
                    {/for}
                </select>
            </div>
            <div class="clear_fix_both"></div> <br>

            <div class="col-md-4">
                <label for="day-close-setting-maxuncloseddays" class="req">Max Unclosed Days Allowed</label>
                <input type="number" class="form-control" id="day-close-setting-maxuncloseddays" placeholder="Max Unclosed Days Allowed">
            </div>

            <div class="col-md-4">
                <label for="day-close-setting-maxpending" class="req">Max Pending Approval Count Allowed</label>
                <input type="number" class="form-control" id="day-close-setting-maxpending" placeholder="Max Pending Approval Count Allowed">
            </div>

            <div class="col-md-4">
                <label for="day-close-setting-creditlimit" class="req">Credit Limit</label>
                <input type="text" class="form-control" id="day-close-setting-creditlimit" placeholder="Credit Limit">
            </div>
        </div>
        <br>

        <div class="row">
            <div class="col-md-12"> 
                <input type="hidden" id="day-close-setting-code" value="">
                <div class="clear_fix_both">                       
                    <div class="alert" id="day-close-setting-action-state" style="display: none;"></div>
                    <div class="align-right" id="day-close-setting-form-buttons">                    
                        <button class="btn btn-success" type="button" onclick="updateDayCloseSetting();">Save</button>
                        <button class="btn btn-default" type="button" onclick="closeDayCloseSetting();">Cancel</button>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>

<iframe name="ifrm_balance_sheet" id="ifrm_balance_sheet" style="display:none"></iframe>

<script>
    var dayCloseSettingsData = {$dayCloseSettings|json_encode};
    
    $('a[id=popup_msg]').attr('data-toggle', 'popover');
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    
    $('#day-close-setting-branch').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default day-close-setting-branch',
    });

    $('#day-close-setting-hour').select2();

    if (isNotNull(dayCloseSettingsData)) {
        $('#day-close-setting-table').dataTable();
    }

    function addDayCloseSetting(code) {
        $('#add-day-close-setting-dialog').css('background', '#fff');
        $('#add-day-close-setting-dialog').removeClass('hide');
        $('#add-day-close-setting-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: $(window).width() - 750,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        $('.inp_error').removeClass('inp_error');
        $('#day-close-setting-action-state').removeClass('alert-success, alert-danger').html('').hide();

        $('.day-close-setting-type[value=MNUL]').prop('checked', true).trigger('change');
        $('#day-close-setting-code, #day-close-setting-maxuncloseddays, #day-close-setting-maxpending, #day-close-setting-creditlimit').val('');
        $('#day-close-setting-branch').val('').multiselect('refresh');
        $('#day-close-setting-hour').val('').trigger('change');

        if (isNotNull(code)) {
            var data = _.find(dayCloseSettingsData, function(o) {
                return o.code === code;
            });
            
            $('#day-close-setting-code').val(code);
            $('.day-close-setting-type[value='+data.dayCloseType+']').prop('checked', true).trigger('change'); 
            $('#day-close-setting-maxuncloseddays').val(data.maxUnclosedDays); 
            $('#day-close-setting-maxpending').val(data.maxPendingApprovalCount); 
            $('#day-close-setting-hour').val(data.dayCloseHour).trigger('change');
            $('#day-close-setting-creditlimit').val(data.creditLimit); 

            $('#day-close-setting-branch').val(data.organizations.map(function(val){
                return val.code;
            })).multiselect('refresh');
        }
    }

    function closeDayCloseSetting() {
        $('#add-day-close-setting-dialog').addClass('hide');
        $('#add-day-close-setting-dialog').dialog('destroy');
    }

    function updateDayCloseSetting() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.code = $('#day-close-setting-code').val();
        data.activeFlag = 1;

        data.organizations = $.map($('#day-close-setting-branch').val() || [], function(val) {
            return { code: val };
        });

        data.dayCloseHour = $('#day-close-setting-hour').val();
        data.dayCloseType = $('.day-close-setting-type:checked').val();
        data.maxUnclosedDays = $.trim($('#day-close-setting-maxuncloseddays').val());
        data.maxPendingApprovalCount = $.trim($('#day-close-setting-maxpending').val());
        data.creditLimit = $.trim($('#day-close-setting-creditlimit').val());

        if ($('#day-close-setting-branch').val() == 0) {
            $('.day-close-setting-branch').addClass('inp_error');
            err++;
        }

        if (isNull(data.dayCloseHour)) {
            $('#day-close-setting-hour').addClass('inp_error');
            err++;
        }

        if (isNull(data.maxUnclosedDays)) {
            $('#day-close-setting-maxuncloseddays').addClass('inp_error');
            err++;
        }

        if (isNull(data.maxPendingApprovalCount)) {
            $('#day-close-setting-maxpending').addClass('inp_error');
            err++;
        }

        if (isNull(data.creditLimit)) {
            $('#day-close-setting-creditlimit').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#day-close-setting-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#day-close-setting-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#day-close-setting-action-state').show();
            return false;
        }
        
        $('#day-close-setting-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#day-close-setting-action-state').html(loading_popup).show();
        
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'branch/update-day-close-setting',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#day-close-setting-action-state').removeClass('alert-danger');
                    $('#day-close-setting-action-state').addClass('alert-success');
                    $('#day-close-setting-action-state').html('Your request has been completed successfully').show();
                    window.setTimeout(function() {
                        closeDayCloseSetting();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#day-close-setting-action-state').addClass('alert-danger');
                    $('#day-close-setting-action-state').html(response.errorDesc).show();
                }
            }
        });
    }

    function deleteDayCloseSetting(code) {
        var data = _.find(dayCloseSettingsData, function(o) {
            return o.code === code;
        });
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "branch/update-day-close-setting",
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
</script>