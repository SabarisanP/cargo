{* <h4>Stations Point - <span id="stat_title"></span> 
    {if $action_rights['S-ADD-SP']>0}
        <div class="fr">
            <a href="javascript:;" class="btn btn-success" {if $action_rights['S-ADD-SP']!=2}onclick="editStationPoint()"{/if}>
                <i class="fa fa-plus"></i>Add New Station Point
            </a>
        </div>
    {/if}
</h4>
<div class="clear_fix_both"></div><br />
<div class='responsive-table1'>
    <div class='table-responsive'>
        <table id="datatable2" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover" >
            <thead>
                <tr>
                    <th width="4%" class="pth" >S/No</th>
                    <th width="20%" class="pth" >Station Point</th>
                    <th width="30%" class="lat" >Address</th>
                    <th width="20%" class="lad" >Landmark</th>
                    <th width="12%" class="mno" >Phone Number</th>
                    <th width="14%" class="pth" >Actions</th>
                </tr>
            </thead>
            <tbody>
            <tr class="st_pt hide"  >
                <td width="4%" class="sp_no"></td>	
                <td width="20%" class="sp_name"></td>
                <td width="30%" class="sp_lat"></td>
                <th width="20%" class="sp_lad" ></th>
                <th width="12%" class="sp_mno" ></th>
                <td width="14%" class="sp_action">
                    <div class="btn-group btn-group-xs">
                     <a href="javascript:;" class="btn btn-default btn-xs act"><i title="Click to disable" class="fa fa-check"></i></a>
                      <a href="javascript:;" class="btn btn-default btn-xs ed-bt" title="Edit" {if $action_rights['S-EDIT-SP']!=2}onclick='editStationPoint({$row|@json_encode})'{/if}><i class="fa fa-pencil"></i></a>
                       <a href="javascript:;" class="btn btn-default btn-xs del-bt" title="Delete" {if $action_rights['S-DELETE-SP']!=2}onclick="deleteStationPoint('{$row->code}', '{$row->name}')"{/if}><i class="fa fa-trash-o"></i></a>
                    </div>
                </td>
            </tr> 
            
            {foreach name=o item=row from=$entity} 
            <tr id="sp-{$row->code}">
                <td width="4%" class="sp_no">{$smarty.foreach.o.index+1}</td>	
                <td width="20%" class="sp_name">{$row->name}</td>
                <td width="30%" class="sp_lat">{$row->address}</td>
                <td width="20%" class="sp_lad">{$row->landmark}</td>
                <td width="12%" class="sp_mno">{$row->number}</td>                  
                <td width="14%" class="sp_action">
                    <div class="btn-group btn-group-xs">                        
                        {if $action_rights['S-DISABLE-SP']>0}   <a href="javascript:;" class="btn btn-default btn-xs act" {if $action_rights['S-DISABLE-SP']!=2}onclick="editStatusStationPoint('{$row->code}', '{$row->name}', '{$row->longitude}', '{$row->latitude}', '{$row->station->code}')"{/if} id="st_sts-{$row->code}" data-status="{$row->activeFlag}">{if $row->activeFlag==1}<i class="fa fa-times" id="sta-{$row->code}" title="Click to disable"></i>{else}<i class="fa fa-check" id="sta-{$row->code}" title="Click to enable"></i>{/if}</a>{/if}
                        {if $action_rights['S-EDIT-SP']>0}  <a href="javascript:;" id='edt_points_{$row->code}' {if $row->activeFlag==0}style='display:none'{/if}  class="btn btn-default btn-xs ed-bt" title="Edit" {if $action_rights['S-EDIT-SP']!=2}onclick='editStationPoint({$row|@json_encode|escape})'{/if}><i class="fa fa-pencil"></i></a>{/if}
                      {if $action_rights['S-DELETE-SP']>0}   <a href="javascript:;" class="btn btn-default btn-xs del-bt" title="Delete" {if $action_rights['S-DELETE-SP']!=2}onclick="deleteStationPoint('{$row->code}', '{$row->name}')"{/if}><i class="fa fa-trash-o"></i></a>{/if}
                    </div>
                </td>
            </tr> 
            {/foreach}

                
            </tbody>
        </table>
    </div>
</div>
<script>
   var table = $('#datatable2').dataTable({
    "aaSorting": [[ 1, "asc" ]]});
    
</script> *}

<h4>Station - <span id="stat_title"></span></h4>

<br>
<div class="col-md-3">

    <div id="sta-short-code">
        <span><b>Short Code :</b></span>
        <span>{if $smarty.request.shortCode != 'NA'}{$smarty.request.shortCode}{else}-{/if}</span>

        <span class="pull-right"><a href="javascript:;" onclick="editStationShortCode()">change</a></span>
    </div>
    <div id="sta-short-edit" style="display: none;">
        <label><b>Short Code :</b></label>
        <div class="form-group">
            <input type="text" id="sta-short-code-inp" class="form-control capitalize" onblur="validateShortCode();" placeholder="Short Code" value="{if $smarty.request.shortCode != 'NA'}{$smarty.request.shortCode}{/if}" maxlength="5">
            <span class="text-danger short-code-warning"></span>
        </div>

        <div id="station-sc-action-state" class="alert" style="display: none;"></div>
        <div class="align-right">
            <input type="hidden" id="station-hid-code" value="{$smarty.request.station_code}">
            <button type="button" class="btn btn-success" onclick="saveStationShortCode()">Save</button>
        </div>
    </div>
</div>

<script>
    $('.short-code-warning').text('');

    $("#sta-short-code-inp").bind("input", function (e) {
        this.value = this.value.replace(/[^0-9a-zA-Z]+/g, '').toUpperCase();
    });
    
    function editStationShortCode() {
        $('#sta-short-code').hide();
        $('#sta-short-edit').show();
    }

    function validateShortCode() {
        $('#sta-short-code-inp').removeClass('inp_error');
        $('.short-code-warning').text('')

        var statcode = $('#station-hid-code').val();
        var shortcode = $('#sta-short-code-inp').val().trim().toUpperCase();
        if (!shortcode) return true;

        if ($('#station_scroll [data-shortcode="' + shortcode + '"]').not('#station-link-' + statcode).length) {
            $('.short-code-warning').text('Short code already Used');
            $('#sta-short-code-inp').addClass('inp_error');
            return false;
        } 

        return true;
    }

    function saveStationShortCode() {
        var err = 0;

        var stationcode = $('#station-hid-code').val();
        var data = $('#station-link-' + stationcode).data('obj')
        data.shortCode = $('#sta-short-code-inp').val().trim().toUpperCase();
        
        if(!validateShortCode()){
            err++;
            return;
        }
        if(data.shortCode == '') {
            $('#sta-short-code-inp').addClass('inp_error');
            err++;
        }
        
        if (err > 0) {
            $('#station-sc-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#station-sc-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#station-sc-action-state').show();
            return false;
        }

        $('#station-sc-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#station-sc-action-state').html(loading_popup);
        $('#station-sc-action-state').show();
        
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/add-namespace-station',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    var statecode = '';
                    if (data.shortCode != 'NA') {
                        statecode = ' (' + data.shortCode + ')';
                    }
                    $('#station-link-' + stationcode).data('obj' , data)
                        .attr('onclick', "getStationPointsList('" +data.code+ "', '" +data.name+ "', '" +data.shortCode+ "');")
                            .html(data.name + statecode)
                    $('#station-sc-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#station-sc-action-state').html('Your request has been completed successfully');
                    setTimeout(function () {
                        $('#station-sc-action-state').html('').hide();
                    }, 3000);
                } else {
                    $('#station-sc-action-state').addClass('alert-danger');
                    $('#station-sc-action-state').html(response.errorDesc);
                }
            }
        });
    }
</script>