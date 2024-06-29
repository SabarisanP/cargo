<div class="brand_top">
    <h3>Extra Commission Slab</h3> 
    <span class="align-rights">
        <a href="#config/extra-commission" class="btn btn-default" > <i class="fa fa-arrow-left"></i> Back</a>
        
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="editSlab('');">Add New Slab</a>
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div style="clear: both;"></div><br>
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">

                            <table class="table table-hover">
                                <tbody>  
                                    <tr>
                                        <th>Name</th>
                                        <th>Calendar Interval</th>
                                        <th>Calendar Mode</th>
                                        <th>Slab Mode</th>
                                        <th>Slab From Value</th>
                                        <th>Slab To Value</th>
                                        <th>Actions</th>
                                    </tr>
                                    
                                    {foreach key=key from=$slabs->data item=slab}
                                    <tr class="slab-row">
                                        <td>{$slab->name}</td>
                                        <td>{$slab->slabCalenderType->code}</td>
                                        <td>{$slab->slabCalenderMode->name}</td>
                                        <td>{$slab->slabMode->name}</td>
                                        <td>{$slab->slabFromValue}</td>
                                        <td>{$slab->slabToValue}</td>
                                        <td>
                                            <a href="javascript:;" onclick="editSlab('{$slab->code}')" title="edit" class="btn btn-default btn-xs"><i class="fa fa fa-pencil"></i></a>
                                            
                                            <a href="javascript:;" onclick="deleteSlab('{$slab->code}')" title="delete" class="btn btn-default btn-xs"><i class="fa fa fa-trash"></i></a>
                                        </td>
                                    </tr>    
                                    {/foreach} 
                                    
                                    <tr id="edit-panel" class="hide">
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="Name" value="{$stop->name}" maxlength="50" id="ecs_name" class="form-control">                                                    
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <select class="form-control" id="ecs_interval">
                                                        <option value="DAY" {if $stop->itemType=='DAY'} selected="selected" {/if}>Day</option>
                                                        <option value="WEEK" {if $stop->itemType=='WEEK'} selected="selected" {/if}>Week</option>
                                                        <option value="MONTH" {if $stop->itemType=='MONTH'} selected="selected" {/if}>Month</option>
                                                    </select>
                                                </div>
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <select class="form-control" id="ecs_cal_mode">
                                                        <option value="FLEXI" {if $stop->itemType=='FLEXI'} selected="selected" {/if}>Flexi</option>
                                                        <option value="STRICT" {if $stop->itemType=='STRICT'} selected="selected" {/if}>Strict</option>                                                        
                                                    </select>
                                                </div>
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <select class="form-control" id="ecs_slab_mode">
                                                        <option value="STCNT" {if $stop->itemType=='STCNT'} selected="selected" {/if}>Seat Count</option>
                                                        <option value="STAMT" {if $stop->itemType=='STAMT'} selected="selected" {/if}>Total Amount</option>                                                        
                                                    </select>
                                                </div>
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="From Value" value="{$stop->name}" id="ecs_slab_from" class="form-control" maxlength="5" >                                                    
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="To Value" value="{$stop->name}" id="ecs_slab_to" class="form-control" maxlength="5">
                                                    <input type="hidden" value="" id="ecs_code" class="form-control">                                                    
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="" id="form-bttons">
                                                    <button class="btn btn-success" type="button" onclick="saveSlab();">Save</button> &nbsp;
                                                    <button class="btn btn-default" type="button" onclick="clearSlab();">Clear</button>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div><!--panel Body end-->

<script>
var slabs_json = {$slabs->data|json_encode};
function editSlab(code){
    $('.slab-row').hide();    
    $('#edit-panel').removeClass('hide'); 
    
    $('#ecs_name').val('') ;
    $('#ecs_interval').val('DAY');
    $('#ecs_cal_mode').val('FLEXI');    
    $('#ecs_slab_mode').val('STCNT');
    $('#ecs_slab_from').val('');
    $('#ecs_slab_to').val('');
    $('#ecs_code').val('');  
    
    if(code!="") {
        $.each(slabs_json, function(keys, values) {
            if (values.code == code) {
                $('#ecs_name').val(values.name) ;
                $('#ecs_interval').val(values.slabCalenderType.code);
                $('#ecs_cal_mode').val(values.slabCalenderMode.code);    
                $('#ecs_slab_mode').val(values.slabMode.code);
                $('#ecs_slab_from').val(values.slabFromValue);
                $('#ecs_slab_to').val(values.slabToValue);
                $('#ecs_code').val(values.code);                
            }
        });        
    }
}

function clearSlab(){
    $('.slab-row').show();    
    $('#edit-panel').addClass('hide'); 
}

function deleteSlab(code) {
    var data = {};
    data.code = code;
    
    if(confirm('Do you want to delete this slab?')) {   
            
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-extra-commission-slab",
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
}

function saveSlab() {
    var data = {};
     
    data.name = $.trim( $('#ecs_name').val() );
    data.interval = $.trim($('#ecs_interval').val());
    data.intervalmode = $.trim($('#ecs_cal_mode').val());    
    data.slabmode = $.trim($('#ecs_slab_mode').val());
       
    data.fromvalue = $.trim($('#ecs_slab_from').val());
    data.tovalue = $.trim($('#ecs_slab_to').val());
    
    data.code = $('#ecs_code').val();    
    
    $('.err_bor').removeClass('err_bor');
    var err = 0;
    
    if(data.name=="") {
        $('#ecs_name').addClass('err_bor');
        err++;
        return;
    } 
    
    if(data.fromvalue=="") {
        $('#ecs_slab_from').addClass('err_bor');
        err++;
        return;
    }
    
    if(isNaN(data.fromvalue)) {
        $('#ecs_slab_from').addClass('err_bor');
        err++;
        return;
    }
    
    if(data.tovalue=="") {
        $('#ecs_slab_to').addClass('err_bor');
        err++;
        return;
    }
    if(isNaN(data.tovalue=="")) {
        $('#ecs_slab_to').addClass('err_bor');
        err++;
        return;
    }
    
    if(parseInt(data.fromvalue) >= parseInt(data.tovalue) ) {
        $('#ecs_slab_to').addClass('err_bor');
        err++;
        return;
    }
    
    $('#form-bttons').hide();
    $('#st-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#st-form-action-state').html(loading_popup);
    $('#st-form-action-state').show();
    
    
    if (err > 0) {
        $('#st-form-action-state').removeClass('alert-success');
        $('#st-form-action-state').addClass('alert-danger');
        $('#form-bttons').show();
        return false;
    }
    
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/save-extra-commission-slab",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
                    
                $('.er_msg').remove();
                $('#st-form-action-state').removeClass('alert-danger');
                $('#st-form-action-state').addClass('alert-success');
                $('#st-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    loading_overlay.hide();
                    checkURL();
                }, 1000);
            } else {
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Sorry!"
                });
                $('#st-form-action-state').addClass('alert-error');
                $('#st-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
}    
</script>            