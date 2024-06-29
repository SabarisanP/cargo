<div class="brand_top">
    <h3>Van Routes</h3> 
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showVanRouteDialog();">Add New Van Route</a>
    </span>
</div>
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
                                <div class="col-md-offset-0 col-md-6">
                                    <ul class="user_list">
                                        {if count($route) > 0}
                                            {foreach name=o item=row from=$route}
                                                <li id="van-{$row->code}">
                                                    <span class="sp_name col-xs-5 rt_23">{$row->name} - 
                                                        {foreach item=list from=$stations}
                                                            {if $list->code == $row->station->code}
                                                                {$list->name}
                                                            {/if}
                                                        {/foreach}
                                                    </span>
                                                    <span class="sp_status col-xs-2 rt_12">
							{if $row->activeFlag==1}
							    <span class="label label-success">Active</span>
							{else}
							    <span class="label label-danger">Disabled</span>    
							{/if}    
						    </span>
                                                    <span  class="sp_action">
                                                        <a href="javascript:;" onclick="editVanRoutesStatus('{$row->code}')">
                                                            {if $row->activeFlag==1}
                                                                <i class="fa fa-times fa-lg" data-status="0" title="Click to disable"></i>
                                                            {else}
                                                                <i class="fa fa-check fa-lg" data-status="9" title="Click to enable"></i>
                                                            {/if} 
                                                        </a> 
                                                    </span>
                                                    {if $row->activeFlag==1}
                                                        <span class="p_l_15">
                                                            <a href="javascript:;" title="Edit" onclick="showVanRouteDialog('{$row->code}')"><i class="fa fa fa-pencil fa-lg"></i></a>
                                                        </span>
                                                    {/if} 
                                                    <span class="p_l_15">
                                                        <a href="javascript:;" title="Delete" onclick="deleteVanRoutes('{$row->code}')"><i class="fa fa-trash-o fa-lg"></i></a>
                                                    </span>
                                                </li>
                                            {/foreach}
                                        {/if}
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="van-route-dialog" class="hide dialog-content-page">
    <form role="form" id="van-rte"class="form-horizontal ">
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="van-route" class="req">Name</label>
                <input type="text" placeholder="Name" id="van-route" class="form-control">
            </div>
        </div>
        <div class="clear_fix_both"></div> <br>
        <div class="col-lg-12 p_l_n p_r_n">
            <label for="sel-van-station" class="req">Station</label>
            <select class="form-control" id="sel-van-station">
                <option value="">Select</option>
                {foreach item=row from=$stations}
                    <option value="{$row->code}">{$row->name}</option>
                {/foreach}
            </select>
        </div>
        <input type="hidden" id="hid-van-rte-code">
        <input type="hidden" id="hid-activ-flag">
    </form>
    <div class="clear_fix_both"></div> <br>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="van-route-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveVanRoute();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelVanRouteDialog();">Cancel</button>
        </div>
    </div> 
</div>
<script>
    var van_route = {$route|json_encode};
    function showVanRouteDialog(code) {
        $('#van-route-dialog').css('background', '#fff');
        $('#van-route-dialog').removeClass('hide');
        $('#van-route-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        
        if (_isdefined(code)) {
            var data = $.grep(van_route, function(e) {
                        return e.code == code;
                    });
            data = data[0];
            $('#van-route').val(data.name);
            $('#sel-van-station').val(data.station.code);
            $('#hid-van-rte-code').val(data.code);
            $('#hid-activ-flag').val(data.activeFlag);
        } else {
            $('#van-route').val('');
            $('#sel-van-station').val('');
            $('#hid-van-rte-code').val('');
            $('#hid-activ-flag').val('1');
        }
    }
    
    function cancelVanRouteDialog() {
        $('#van-route-dialog').dialog('destroy');
        $('#van-route-dialog').hide();
    }
    
    function saveVanRoute(){
        var data = {};
        data.name = $('#van-route').val();
        data.stationCode = $('#sel-van-station').val();
        data.code = $('#hid-van-rte-code').val();
        data.activeFlag = $('#hid-activ-flag').val();

        var err = 0;
        if ($('#van-route').val() == '') {
            $('#van-route').addClass('inp_error');
            err++;
        } else {
            $('#van-route').removeClass('inp_error');
        }
        
        if ($('#sel-van-station').val() == '') {
            $('#sel-van-station').addClass('inp_error');
            err++;
        } else {
            $('#sel-van-station').removeClass('inp_error');
        }

        if (err > 0) {
            $('#van-route-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#van-route-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#van-route-action-state').show();
            return false;
        } else {
            $('#van-route-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#van-route-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#van-route-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#van-route-action-state').html(loading_popup);
        $('#van-route-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-van-route",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#van-route-action-state').removeClass('alert-danger');
                    $('#van-route-action-state').addClass('alert-success');
                    $('#van-route-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelVanRouteDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#van-route-action-state').addClass('alert-danger');
                    $('#van-route-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }
    
    function deleteVanRoutes(code){
        if (confirm('Do you want to delete this route?')) {
            var data = $.grep(van_route, function(e) {
                        return e.code == code;
                    });
               
            data = data[0];
            data.activeFlag = 2;
            data.stationCode = data.station.code;
            
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'JSON',
                url: base_url + "config/update-van-route",
                data: data,
                success: function(response) {
                    if (response.status == 1) {                    
                        $('#van-' + code).animate({
                                backgroundColor: '#1AA1E1'
                            }, 2000, function() {
                            $(this).remove();
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
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
    }
    
    function editVanRoutesStatus(code){
        var data = $.grep(van_route, function(e) {
                        return e.code == code;
                    });
        data = data[0];
        data.stationCode = data.station.code;
        var msg ='';
        if(data.activeFlag == 1){
            data.activeFlag = 0;
            msg = 'Do you want to disable this route?';
        } else {
            data.activeFlag = 1;
            msg = 'Do you want to enable this route?';
        }
        if (confirm(msg)) {
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'JSON',
                url: base_url + "config/update-van-route",
                data: data,
                success: function(response) {
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
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        checkURL();
                    }, 2000);
                }
            });
        }
    }
</script>