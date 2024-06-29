<div class="brand_top">
    <h3>Alert Subscription</h3>    
    <span class="align-right">
        <a class="btn btn-success btn-sm" href="javascript:;" onclick="showReport();">Report</a>
    </span>
</div>

<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12"> <br>
                <!-- PAGE HEADER-->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">

                                <div class="panel-group" id="alertCollapse">
                                    {foreach from=$eventtypes item=type}
                                        {if $type->activeFlag == 0}
                                        <div class="panel panel-info" style="overflow:visible;">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#alertCollapse" href="#accordion_{$type->code}" class="collapsed">{$type->name}</a>
                                                </h4>
                                            </div>
                                            <div id="accordion_{$type->code}" data-eventtype="{$type->code}" class="panel-collapse collapse">
                                                <div class="panel-body">
                                                    <div class="event-ws-{$type->code}">
                                                        {* <div class="row">
                                                            <div class="col-sm-12">
                                                                <b>Subscribe</b> :&nbsp;
                                                                <input type="checkbox" id="subscribe_state" class="bs_switch" data-on-text=" On " data-off-text=" Off " value="1" data-handle-width="auto" data-size="normal" data-on-color="success"> &nbsp;
                                                            </div>
                                                        </div>
                                                        <br> *}

                                                        <div class="row">
                                                            <div class="col-sm-12 bold">Subscriber List :</div>
                                                            <div class="clearfix"></div><br />
                                                            <div class="col-sm-2 bold">Group</div>
                                                            <div class="col-sm-2 bold">User</div>
                                                            <div class="col-sm-2 bold">Channel</div>
                                                            <div class="col-sm-1 bold">Action</div>
                                                        </div>
                                                        <div id="subscribelist" class="row"></div>

                                                        <div id="subscribefooter">
                                                            <div class="row pt10">
                                                                <div class="col-sm-2">
                                                                    <a href="javascript:;" onclick="addSubscribeRow('{$type->code}')"> + Add New List</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        {/if}
                                    {/foreach}
                                </div>

                            </div>
                        </div>
                    </div>
                    <!--panel Body end-->
                </div>
                <!--panel end-->
            </div>
        </div>
    </div>
</div>

<div class="modal" id="modal-compose" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog modal-lg" style="width : 1200px">
        <div class="modal-content invoice-modal-content"> 
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times-circle fa-lg"></i></button>
                <div class="container" id="iwContent">
                </div>
            </div>
            <div class="modal-body">
                <div id="subscription-report" style="height:76vh;overflow-y: auto;overflow-x: hidden;" class="table-responsive">
                </div>
            </div>
        </div>
    </div>
</div>

<script id="template-subsciber-list" type="text/template">
    <div class="eventsubsbr">
        <div class="col-sm-2">
            <select class="form-control alrt_group" multiple="multiple">
                {foreach name=o item=row from=$groups}
                    <option value="{$row->code}">{$row->name}</option>
                {/foreach}
            </select>
        </div>
        <div class="col-sm-2">
            <select class="form-control alrt_user" multiple="multiple">
            {foreach name=o item=group from=$usersbygroup key=groupname}
                <optgroup label="{$groupname}">
                    {foreach name=o item=usr from=$group}
                        <option value='{$usr['code']}'>{$usr['name']}</option>
                    {/foreach}
                </optgroup>
            {/foreach}
            </select>
        </div>
        <div class="col-sm-2">
            <select class="form-control alrt_channel" multiple="multiple">
                {foreach name=o item=channelname key=channelcode from=$nitifychannel}
                    <option value="{$channelcode}">{$channelname}</option>
                {/foreach}
            </select>
        </div>
        <div class="col-sm-4">
            <input type="hidden" class="alrt_code">
            <button class="btn btn-success btn-sm alrt_savebtn" type="button" onclick="saveSubscriber(this);">Save</button>
            <button class="btn btn-danger btn-sm alrt_delbtn" type="button" onclick="deleteSubscriber(this);" title="Delete">
                <i class="fa fa-trash"></i>
            </button>&emsp;
            <span class="alrt_action_state"></span>
        </div>
        <div class="clearfix"></div>
    </div>
</script>

<script>
    var userAlerts = {$useralerts|json_encode};
</script>

{literal}
    <script>
        $('.bs_switch').bootstrapSwitch();

        $('#alertCollapse').on('show.bs.collapse', function (e) {
            var eventcode = $(e.target).data('eventtype');
            renderSubscribeRow(eventcode);
        });

        function showReport(){
            $('#modal-compose').modal('show');    
            $('#subscription-report').html('<div class="text-center p_t_100">' + loading_big + '<div>');
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "profile/alert-subscription-report-list",
                success: function (response) {                    
                    $('#subscription-report').html(response);
                }
            });
                                
                    
        }

        function renderSubscribeRow(eventcode) {
            var $workspace = $('.event-ws-' + eventcode);
            $workspace.find('#subscribelist').html('');
            
            $.each(userAlerts || [], function (i, alert) {
                if (alert.subscriptionType.code != eventcode) {
                    return;
                }
                addSubscribeRow(eventcode, alert);
            });
            addSubscribeRow(eventcode);
        }

        function addSubscribeRow(eventcode, alert) {
            var $sublisttpl = $($('#template-subsciber-list').html());

            $sublisttpl.find('.alrt_group').multiselect({
                maxHeight: 200,
                numberDisplayed: 1,
                buttonWidth: '200px',
                buttonClass: 'btn btn-default btn_alrt_group',
                dropLeft: true
            });

            $sublisttpl.find('.alrt_user').multiselect({
                maxHeight: 200,
                numberDisplayed: 1,
                buttonWidth: '200px',
                buttonClass: 'btn btn-default btn_alrt_user',
                dropLeft: true
            });

            $sublisttpl.find('.alrt_channel').multiselect({
                maxHeight: 200,
                enableFiltering: false,
                numberDisplayed: 1,
                buttonWidth: '200px',
                buttonClass: 'btn btn-default btn_alrt_channel',
                dropLeft: true
            });

            $sublisttpl.attr('data-eventcode', eventcode);

            if (alert) {
                $sublisttpl.find('.alrt_code').val(alert.code);

                var mediumList = $.map(alert.mediumList || [], function(val) {
                    return val.code;
                })
                $sublisttpl.find('.alrt_channel').multiselect('select', mediumList);

                var userList = $.map(alert.userList || [], function(val) {
                    return val.code;
                })
                $sublisttpl.find('.alrt_user').multiselect('select', userList);

                var groupList = $.map(alert.groupList || [], function(val) {
                    return val.code;
                })
                $sublisttpl.find('.alrt_group').multiselect('select', groupList);
            }

            var $workspace = $('.event-ws-' + eventcode);
            $workspace.find('#subscribelist').append($sublisttpl);
        }

        function saveSubscriber(btn) {
            var $eventsubsbr = $(btn).closest('.eventsubsbr');

            var err = 0;
            var data = {};
            data.code = $eventsubsbr.find('.alrt_code').val();
            data.activeFlag = 1;
            data.subscriptionType = {};
            data.subscriptionType.code = $eventsubsbr.data('eventcode');
            data.mediumList = $eventsubsbr.find('.alrt_channel').val();
            data.mediumList = $.map(data.mediumList || [], function(val) {
                return { code:val };
            });
            data.userList = $eventsubsbr.find('.alrt_user').val();
            data.userList = $.map(data.userList || [], function(val) {
                return { code:val };
            });
            data.groupList = $eventsubsbr.find('.alrt_group').val();
            data.groupList = $.map(data.groupList || [], function(val) {
                return { code:val };
            });

            $eventsubsbr.find('.inp_error').removeClass('inp_error');
            if (data.groupList.length < 1 && data.userList.length < 1) {
                $eventsubsbr.find('.btn_alrt_group').addClass('inp_error');
                $eventsubsbr.find('.btn_alrt_user').addClass('inp_error');
                err++;
            }

            if (data.mediumList.length < 1) {
                $eventsubsbr.find('.btn_alrt_channel').addClass('inp_error');
                err++;
            }

            var $eventActionState = $eventsubsbr.find('.alrt_action_state');
            if (err > 0) {
                $eventActionState.removeClass('text-success').addClass('text-danger');
                $eventActionState.html('Please enter/select the values in the field that are marked in red');
                $eventActionState.removeClass('hide');
                return false;
            } else {
                $eventActionState.removeClass('text-success').removeClass('text-danger');
                $eventActionState.addClass('hide');
            }

            $eventActionState.removeClass('text-danger').removeClass('text-success');
            $eventActionState.html(loading_popup);
            $eventActionState.removeClass('hide');

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + "profile/update-alert-subscription",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $eventActionState.removeClass('text-danger');
                        $eventActionState.addClass('text-success');
                        $eventActionState.html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            checkURL();
                        }, 3000);
                    } else {
                        $eventActionState.addClass('text-danger');
                        $eventActionState.html(response.errorDesc || 'Unknown Exception');
                    }
                }
            });
        }

        function deleteSubscriber(btn) {
            var $eventsubsbr = $(btn).closest('.eventsubsbr');
            var code = $eventsubsbr.find('.alrt_code').val();

            if(!code) {
                $eventsubsbr.remove();
                return;
            }

            if (!confirm('Do you want to delete this Subscription?')) {
                return;
            }

            var data = _.find(userAlerts, function (o) {
                return o.code === code;
            });
            data.activeFlag = 2;

            var loading_overlay = iosOverlay({
                text: "Loading...",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'profile/update-alert-subscription',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $eventsubsbr.animate({
                            backgroundColor: '#1AA1E1'
                        }, 1500, function() {
                            $(this).remove()
                        });
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
{/literal}