<div class="brand_top">
    <h3>SMS Config</h3>
</div>

<div id="main_wrapper">

    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-md-3">
                            <div class="panel panel-default">

                                <div class="panel-body">

                                    <div id="ns-result-panel">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="align-center" id="ns-action-status"></div>
                                                <div id="ns-address-book" class="col-md-12">
                                                    <ul class="user_list" id="ns_lst_ul">

                                                        {if count($namespaces) > 0}
                                                            <div class="well well-sm">
                                                                <input type="text" class="form-control" placeholder="Find Namespace..." id="list_search">
                                                            </div>
                                                            <div class="ns_list_action bt_27">
                                                                <ul class="ns_list p_l_n pt10 " id="ns_list_search">
                                                                    <div id="ns_scroll">
                                                                        {foreach item=row from=$namespaces}
                                                                            <li id="ns-{$row->code}">
                                                                                <div class="" style="padding-left:10px;">
                                                                                    <a href="javascript:;" id="ns-viw-{$row->code}" onclick="nsSMSConfig('{$row->code}','{$row->name}')" data-toggle="tooltip" title="Click to view Namespace SMS config">
                                                                                        {$row->name}
                                                                                    </a>
                                                                                </div>
                                                                            </li>
                                                                        {/foreach}
                                                                    </div>
                                                                </ul>
                                                            </div>
                                                        {else}
                                                            <li class="er_msg">
                                                                <div class="well well-large"> No Namespace found!</div>
                                                            </li>
                                                        {/if}
                                                    </ul>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="menupermissions">
                                        <div class="container ">
                                            <div class="row">
                                                <div id="permission">                                
                                                <div class="heading_b" id='per-info'>SMS Config</div>

                                                    <div id="ns-permissions">
                                                        <div class="well text-center">
                                                            Please select an namespace in left panel to view namespace SMS config.
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
            </div>
        </div>
    </div>
</div>


<script>
    var namespaces = {$namespaces|json_encode}
    $("#ns_scroll").css({
        'max-height': '350px',
    }).perfectScrollbar({
        wheelSpeed: 20,
        wheelPropagation: false
    });
    $('input#list_search').quicksearch('#ns_list_search #ns_scroll > li');

    function nsSMSConfig(code, name){
        $('#ns-permissions').html(loading_small);
        $('#per-info').html('SMS Config for <b>'+name+'</b>');

        var data={}
        data.namespaceCode = code;
        data.namespaceName = name;
        
        $.ajax({
            type: "POST",
            dataType: "html",
            url: base_url + "admin/get-sms-config",
            data: data,
            success: function(response) {
                $('#ns-permissions').html(response);
            }
        });
    }

    // sender
    function showSMSSenderDialog(code) {
        $('#sender-form-buttons').show();
        $('#sender-action-state').html('').hide();
        $('.inp_error').removeClass('inp_error');

        $('#sender-dialog').css('background', '#fff');
        $('#sender-dialog').removeClass('hide');
        $('#sender-dialog').show();
        $('#sender-dialog').dialog({
            autoOpen: true,
            height: 400,
            width: 450,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        if (!code) {
            $('#sender-code-hid').val('');
            $('#sender-header').val('');
            $('#sender-dlt').val('');
            $('#sender-entity').val('');
            $('#sender-notificationMode').val('');
        } else {
            var data = _.find(smsSenderList, function (o) { return o.code === code; });

            $('#sender-code-hid').val(data.code);
            $('#sender-header').val(data.header);
            $('#sender-dlt').val(data.headerDltCode);
            $('#sender-entity').val(data.entityCode);
            $('#sender-notificationMode').val(data.notificationMode);
        }
    }
    
    function cancelSMSsender() {
        $('#sender-dialog').dialog('destroy');
        $('#sender-dialog').hide();
    }
    
    function saveSMSsender() {
        $('.inp_error').removeClass('inp_error');

        var data = {};
        var err = 0;

        data.activeFlag = 1;
        data.namespaceCode = $('#smsns-code-hid').val();
        data.code = $('#sender-code-hid').val().trim();
        data.header = $('#sender-header').val().trim();
        data.headerDltCode = $('#sender-dlt').val().trim();
        data.entityCode = $('#sender-entity').val().trim();
        data.notificationMode = $("#sender-notificationMode").val();
        var nodupheader = _.every(smsSenderList, function (o) {
            return o.code === data.code || o.header != data.header;
        });

        if (!nodupheader) {
            $('#sender-header').addClass('inp_error');
            $('#sender-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#sender-action-state').html('Entered Header already exists');
            $('#sender-action-state').show();
            return false;
        } 

        if(data.header == '') {
            $('#sender-header').addClass('inp_error');
            err++;
        }
        if(data.headerDltCode == '') {
            $('#sender-dlt').addClass('inp_error');
            err++;
        }
        if(data.entityCode == '') {
            $('#sender-entity').addClass('inp_error');
            err++;
        }
        if (data.notificationMode == '') {
            $('#sender-notificationMode').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#sender-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#sender-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#sender-action-state').show();
            return false;
        } else {
            $('#sender-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#sender-action-state').hide();
        }

        $('#sender-form-buttons').hide();
        $('#sender-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#sender-action-state').html(loading_popup);
        $('#sender-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'admin/update-sms-sender',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#sender-form-buttons').hide();
                    $('#sender-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#sender-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelSMSsender();
                        $('#ns-viw-' + data.namespaceCode).click();
                    }, 3000);
                } else {
                    $('#sender-action-state').show();
                    $('#sender-action-state').addClass('alert-danger');
                    $('#sender-action-state').html(response.errorDesc);
                    $('#sender-form-buttons').show();
                }
            }
        });
    }
    
    function deleteSMSSender(code) {
        if (!confirm('Do you want to delete this Sender Name?')) {
            return;
        }

        var data = _.find(smsSenderList, function (o) {
            return o.code === code;
        });
        data.activeFlag = 2;
        data.namespaceCode = $('#smsns-code-hid').val();

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'admin/update-sms-sender',
            data: data,
            success: function (response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        $('#ns-viw-' + data.namespaceCode).click();
                        return;
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            }
        });
    }

    function toggleSMSSender(code) {
        var data = _.find(smsSenderList, function (o) {
            return o.code === code;
        });
        data.activeFlag = 1 - $('#sender-status-' + code).data('status');
        data.namespaceCode = $('#smsns-code-hid').val();

        var loading_overlay = iosOverlay({
            text: "Loading...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'admin/update-sms-sender',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    if (data.activeFlag == 1) {
                        $('#sender-edit-' + code).show();
                        $('#sender-status-' + code).data('status', data.activeFlag)
                            .html('<i class="fa fa-times fa-lg" title="Click to disable"></i>');
                    } else {
                        $('#sender-edit-' + code).hide();
                        $('#sender-status-' + code).data('status', data.activeFlag)
                            .html('<i class="fa fa-check fa-lg" title="Click to enable"></i>');
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
                    $('#ns-viw-' + data.namespaceCode).click();
                }, 2000);
            }
        });
    }

    function getSMSTemplate(){
        $('#sms-telplates').html(loading_small);

        var data={};
        data.namespaceCode = $('#smsns-code-hid').val();
        data.smsConfigCode = $('#sms-sender-name').val();

        if (!data.smsConfigCode) {
            $('#sms-telplates').html('<div class="well text-center">Please select an Sender Name to view SMS Template.</div>');
            $('#sms-tpl-addbtn').hide();
            return;
        }
        
        $.ajax({
            type: "POST",
            dataType: "html",
            url: base_url + "admin/get-sms-template",
            data: data,
            success: function(response) {
                $('#sms-telplates').html(response);
                $('#sms-tpl-addbtn').show();
            }
        });
    }
    
    // template
    function showSMSTplDialog(code) {
        $('#smstpl-form-buttons').show();
        $('#smstpl-action-state').html('').hide();
        $('.inp_error').removeClass('inp_error');

        $('#smstpl-dialog').css('background', '#fff');
        $('#smstpl-dialog').removeClass('hide');
        $('#smstpl-dialog').show();
        $('#smstpl-dialog').dialog({
            autoOpen: true,
            height: 620,
            width: 600,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        if (!code) {
            $('#smstpl-code-hid').val('');
            $('#smstpl-dlt').val('');
            $('#smstpl-notificationtype').val('');
            $('#smstpl-content').val('');
        } else {
            var data = _.find(smsTplList, function(o) { return o.code === code; });

            $('#smstpl-code-hid').val(data.code);
            $('#smstpl-dlt').val(data.templateDltCode);
            $('#smstpl-notificationtype').val(data.notificationType.code).trigger('change');
            $('#smstpl-content').val(data.content);
        }
    }

    function cancelSMSTemplate() {
        $('#smstpl-dialog').dialog('destroy');
        $('#smstpl-dialog').hide();
    }

    function saveSMSTemplate() {
        $('.inp_error').removeClass('inp_error');

        var data = {};
        var err = 0;

        data.activeFlag = 1;
        data.namespaceCode = $('#smsns-code-hid').val();
        data.code = $('#smstpl-code-hid').val().trim();
        data.notificationSMSConfig = {};
        data.notificationSMSConfig.code = $('#sms-sender-name').val().trim();
        data.templateDltCode = $('#smstpl-dlt').val().trim();
        data.notificationType = {};
        data.notificationType.code = $('#smstpl-notificationtype').val().trim();
        data.content = $('#smstpl-content').val().trim();

        var nodupsmstype = _.every(smsTplList, function (o) {
            return o.code === data.code || o.notificationType.code != data.notificationType.code;
        });

        if (!nodupsmstype) {
            $('#smstpl-notificationtype').addClass('inp_error');
            $('#smstpl-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#smstpl-action-state').html('Selected Notification Type already exists');
            $('#smstpl-action-state').show();
            return false;
        } 


        if(data.notificationSMSConfig.code == '') {
            $('#sms-sender-name').addClass('inp_error');
            err++;
        }
        if(data.notificationType.code == '') {
            $('#smstpl-notificationtype').addClass('inp_error');
            err++;
        }
        if(data.templateDltCode == '') {
            $('#smstpl-dlt').addClass('inp_error');
            err++;
        }
        if(data.content == '') {
            $('#smstpl-content').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#smstpl-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#smstpl-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#smstpl-action-state').show();
            return false;
        } else {
            $('#smstpl-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#smstpl-action-state').hide();
        }

        $('#smstpl-form-buttons').hide();
        $('#smstpl-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#smstpl-action-state').html(loading_popup);
        $('#smstpl-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'admin/update-sms-template',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#smstpl-form-buttons').hide();
                    $('#smstpl-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#smstpl-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelSMSTemplate();
                        $('#sms-sender-name').change();
                    }, 3000);
                } else {
                    $('#smstpl-action-state').show();
                    $('#smstpl-action-state').addClass('alert-danger');
                    $('#smstpl-action-state').html(response.errorDesc);
                    $('#smstpl-form-buttons').show();
                }
            }
        });
    }

    
    function deleteSMSTemplate(code) {
        if (!confirm('Do you want to delete this SMS Template?')) {
            return;
        }

        var data = _.find(smsTplList, function (o) {
            return o.code === code;
        });
        data.activeFlag = 2;
        data.namespaceCode = $('#smsns-code-hid').val();
        data.notificationSMSConfig = {};
        data.notificationSMSConfig.code = $('#sms-sender-name').val().trim();

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'admin/update-sms-template',
            data: data,
            success: function (response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        $('#sms-sender-name').change();
                        return;
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            }
        });
    }

    function toggleSMSTemplate(code) {
        var data = _.find(smsTplList, function (o) {
            return o.code === code;
        });
        data.activeFlag = 1 - $('#smstpl-status-' + code).data('status');
        data.namespaceCode = $('#smsns-code-hid').val();
        data.notificationSMSConfig = {};
        data.notificationSMSConfig.code = $('#sms-sender-name').val().trim();

        var loading_overlay = iosOverlay({
            text: "Loading...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'admin/update-sms-template',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    if (data.activeFlag == 1) {
                        $('#smstpl-edit-' + code).show();
                        $('#smstpl-status-' + code).data('status', data.activeFlag)
                            .html('<i class="fa fa-times fa-lg" title="Click to disable"></i>');
                    } else {
                        $('#smstpl-edit-' + code).hide();
                        $('#smstpl-status-' + code).data('status', data.activeFlag)
                            .html('<i class="fa fa-check fa-lg" title="Click to enable"></i>');
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
</script>
