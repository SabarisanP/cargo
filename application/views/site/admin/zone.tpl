<div class="brand_top">
    <h3>Zone</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showAddZoneDialog();">Add New Zone</a>
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <div class="row" id="zone-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="zone-list" style="width: 70%;margin: auto;">
                                        <table width="100%" class="table table-bordered">
                                            <thead>
                                                <tr class="success">
                                                    <th width="15%">Name</th>
                                                    <th width="45%">Station</th>
                                                    <th width="25%">Description</th>
                                                    <th width="15%"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {$stationsArray = array()}
                                                {foreach from=$result item=row}
                                                    <tr>
                                                        <td>{$row->name}</td>
                                                        <td>
                                                            {foreach from=$row->stations item=stn key=key}
                                                                {if count($row->stations)-1 == $key }
                                                                    {$stn->name}
                                                                {else}
                                                                    {$stn->name},
                                                                {/if}
                                                                {$stationsArray[] = $stn->code}
                                                            {/foreach}
                                                        </td>
                                                        <td>
                                                            {if $row->description}
                                                                {$row->description}
                                                            {else}
                                                                -
                                                            {/if}
                                                        </td>
                                                        <td>
                                                            <div class="btn-group">
                                                                <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick="showAddZoneDialog({$row|json_encode|@escape});"><i class="fa fa-pencil igreen"></i></a>
                                                                <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick="deleteZone({$row|json_encode|@escape});"><i class="fa fa-trash ired"></i></a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                {foreachelse}
                                                    <tr>
                                                        <td colspan="4" align="center">No Data Found !!!</td>
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
</div>


<div id="add-zone-dialog" style="display: none">
    <div class="clearfix">
        <span style="font-size: 18px;">Add Zone</span>
        <a href="javascript:;" class="pull-right" onclick="hideAddZoneDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="add-zone-panel" class="clearfix" style="padding: 10px 5px;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-6">
                    <label class="req h5">Name</label>
                    <input type="text" id="zone-name" class="form-control" placeholder="Zone Name">
                </div>
                <div class="col-md-6">
                    <label class="req h5">Stations</label>
                    <select class="form-control" id="zone-stations" multiple>
                        {foreach from=$stations item=stn}
                            <option value="{$stn.code}">{$stn.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-12">
                    <label class="h5">Description</label>
                    <textarea class="form-control" id="zone-desc" rows="4" cols="2"></textarea>
                </div>
                <div class="col-md-12"><br>
                    <div class="alert m_b_5" id="add-zone-action-state"></div>
                    <div class="align-right" id="form-buttons">
                        <input type="hidden" id="hid-zone-code">
                        <button type="submit" class="btn btn-success" id="add-zone-btn" onclick="saveZone();">Save Zone</button>
                        <button type="button" class="btn btn-default" onclick="hideAddZoneDialog()">Cancel</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    var assignedStations = {$stationsArray|json_encode};
    var stationsField = $('#zone-stations option');
</script>

{literal}
    <script>
        $('#zone-stations').select2({
            placeholder: 'Select Stations'
        });

        function showAddZoneDialog(zone_data) {
            $('.inp_error').removeClass('inp_error');
            $('#add-zone-dialog').css('background','#fff');
            $('#add-zone-dialog').removeClass('hide');
            $('#add-zone-dialog').dialog({
                autoOpen: true,
                height: 400,
                width: 600,
                modal: true,
                resizable: false
            });
            $(".ui-dialog-titlebar").hide();
            
            $('#add-zone-action-state').html('');
            $('#add-zone-action-state').hide();

            $('#zone-name').val('');
            $('#zone-desc').val('');
            $('#zone-stations').val('').trigger('change');

            if (assignedStations.length > 0) {
                $('#zone-stations').html(function () {
                    return stationsField.filter(function () {
                        return $.inArray($(this).val(), assignedStations) == -1;
                    });
                }).trigger('change');
            }

            if (_isdefined(zone_data)) {
                $('#hid-zone-code').val(zone_data.code);

                $('#zone-name').val(zone_data.name);
                $('#zone-desc').val(zone_data.description);
            
                var stn = [];
                $.each(zone_data.stations, function( key, value ) {
                    stn.push(value.code);
                });

                if(stn.length > 0){
                    $('#zone-stations').html(function () {
                        return stationsField.filter(function () {
                            return ($.inArray($(this).val(), assignedStations) == -1) || ($.inArray($(this).val(), stn) != -1);
                        });
                    }).val(stn).trigger('change');
                }
            }
        }

        function hideAddZoneDialog(){
            $('#add-zone-dialog').dialog('destroy');
            $('#add-zone-dialog').hide();
        }

        function saveZone(){
            var data = {};

            data.code = $('#hid-zone-code').val();
            data.activeFlag = 1;
            data.name = $('#zone-name').val();
            data.description = $('#zone-desc').val();

            data.stations = $.map($('#zone-stations').val() || [], (stn) => ({ code: stn }));

            var err=0;
            if($('#zone-name').val()==''){
                $('#zone-name').addClass('inp_error') ;
                err++;
            }else{
                $('#zone-name').removeClass('inp_error');
            }

            if(data.stations.length == 0){
                $('#zone-stations').addClass('inp_error') ;
                err++;
            }else{
                $('#zone-stations').removeClass('inp_error');
            }
            
            if(err > 0){
                $('#add-zone-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#add-zone-action-state').html('Please enter the values in the field that are marked in red');
                $('#add-zone-action-state').show();
                return false;
            }else{
                $('#add-zone-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#add-zone-action-state').html('');
                $('#add-zone-action-state').hide();
            }
            
            $('#form-buttons').hide();
            $('#add-zone-action-state').html(loading_popup);
            $('#add-zone-action-state').show();
            
            $.ajax({
                type: "POST",
                dataType:'json',
                url: base_url+"config/save-zone",
                data: data,
                success: function(response) {            
                    if(response.status==1) {
                        $('#add-zone-action-state').html('');
                        $('#add-zone-action-state').hide();
                        $('#add-zone-action-state').removeClass('alert-danger').addClass('alert-success');
                        $('#add-zone-action-state').show();
                        $('#add-zone-action-state').html('Your request has been completed successfully');                
                        window.setTimeout( function() { 
                            hideAddZoneDialog(); 
                            checkURL();
                        }, 3000);
                    } else{                
                        $('#add-zone-action-state').html('');
                        $('#add-zone-action-state').hide();
                        $('#add-zone-action-state').removeClass('alert-success').addClass('alert-danger');

                        if(response.errorCode == 205){
                            $('#add-zone-action-state').html(response.data);
                        }else{
                            $('#add-zone-action-state').html(response.errorDesc);
                        }

                        $('#add-zone-action-state').show();
                        $('#form-buttons').show();
                    }
                }
            })  
        }
        
        function deleteZone(code){
            event && event.stopPropagation();
    
            var data = code;
            data.activeFlag = 2;
            
            msg = 'Do you want to delete this zone?';
            if(confirm(msg)){
                var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
                });       
            
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "config/save-zone",
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
    </script>
{/literal}