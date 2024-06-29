<div class="brand_top">
    <h3>Sequence</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="addDialog();">Add New</a>    
    </span>
</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <div class="row">                        
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body"> 
                                    <div class="col-md-offset-3 col-md-6 ">
                                        <table class="table">
                                            <tr>
                                                <th>Branches / Organization</th>
                                                <th>Prefix</th>
                                                <th>Sequence</th>
                                                <th>Actions</th>
                                            </tr>
                                            {if !empty($list->data)}
                                                {$branches[] = ''}
                                                {foreach key=key from=$list->data item=value}
                                                    {append var='branches' value=$value->organization->code index=$key}
                                                    <tr>                    
                                                        <td>{$value->organization->name}</td>
                                                        <td>{$value->prefixCode}</td>
                                                        <td>{$value->sequence}</td>
                                                        <td> <a class="btn btn-default btn-sm-not edat" title="Edit" onclick='editDialog({$value|@json_encode})'>
                                                                <i class="fa fa-pencil igreen"></i>
                                                        </a></td>
                                                    </tr>
                                                {/foreach}
                                            {else}
                                                <tr colspan="4" align="center"><td>No Records Found<td></tr>
                                            {/if}
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

<div id="add-dialog" class="hide dialog-content-page" >
    <form id='sequenceForm' class="form-horizontal " method="post" name="sequenceForm" action="cargo/sequence" onsubmit="return false" role="form" autocomplete="off">
        <div class="col-lg-6 p_l_n">
            <label  for="organizationCode" class="req">Branch / Organization</label>
            <select id="organizationCode" name="organizationCode" class="form-control" required>
                <option value='NA' disabled selected hidden>Select organization</option>
                {foreach item=value from=$organization->data}        
                    {if !$value->code|in_array:$branches}
                        <option value={$value->code}>{$value->name}</option> 
                    {/if}
                {/foreach}
            </select>  
        </div>
        <div class="col-lg-6 p_l_n">
            <label for="prefixCode" class="req">Prefix</label>
            <input type="text" class="form-control" id="prefixCode" name="prefixCode" placeholder="Prefix Code" value="" maxlength="3" style="text-transform:uppercase" required>      
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="col-lg-6 p_l_n">
            <label for="sequence" class="req">Sequence</label>
            <input type="text" class="form-control" id="sequence" name="sequence" placeholder="Sequence" value="" maxlength="4" required>      
        </div>
        <div class="clear_fix_both"></div>
    </form> 
    <!--div class="alert" style="display:none;position:absolute;" id="add-action-state"></div-->
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">
        <div class="alert fl suc_cre" style="display:none;" id="add-action-state"></div>   
        <div class="align-right cre_sve" id="add-form-bttons">
            <button class="btn btn-success" type="button" id="sequenceFormSubmit" onclick="submit();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelGroup();">Cancel</button>
        </div>
    </div>
</div>
                         
<script type="text/javascript">
    $("#prefixCode").keypress(function (e) {
        if (!(e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57))) {
            return false;
       }
    });
    $("#sequence").keypress(function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
       }
    });
    function addDialog() {
        $('#add-dialog').css('background', '#fff');
        $('#add-dialog').removeClass('hide');
        $('#add-dialog').dialog({
            autoOpen: true,
            height: 290,
            width: 600,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
    }
    function editDialog(option) {
        $('#add-dialog').css('background', '#fff');
        $('#add-dialog').removeClass('hide');
        $('#add-dialog').dialog({
            autoOpen: true,
            height: 290,
            width: 600,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        if (_isdefined(option)) {
            $('#organizationCode').append($("<option></option>").attr({literal}{value:option.organization.code,id:'temp',selected:''}{/literal}).text(option.organization.name)); 
            $('#prefixCode').val(option.prefixCode);
            $('#sequence').val(option.sequence);
        } else {
            $('#organizationCode').val('NA');
            $('#prefixCode').val('');
            $('#sequence').val('');
        }
    }
    function cancelGroup() {
        $('#temp').remove();
        $('#organizationCode').val('NA').removeClass('inp_error');
        $('#prefixCode').val('').removeClass('inp_error');
        $('#sequence').val('').removeClass('inp_error');
        $('#add-action-state').removeClass('alert-success');
        $('#add-action-state').removeClass('alert-danger');
        $('#add-dialog').dialog('destroy');
        $('#add-dialog').hide();
    }
    
    function submit() {
        var err = 0;
        if ($('#organizationCode').val() == null) {
            $('#organizationCode').addClass('inp_error');
            err++;
        } else {
            $('#organizationCode').removeClass('inp_error');
        }
        if ($('#prefixCode').val() == '') {
            $('#prefixCode').addClass('inp_error');
            err++;
        } else {
            $('#prefixCode').removeClass('inp_error');
        }
        if ($('#sequence').val() == '') {
            $('#sequence').addClass('inp_error');
            err++;
        } else {
            $('#sequence').removeClass('inp_error');
        }
        if (err > 0) {
            $('#add-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#add-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#add-action-state').show();
            return false;
        } else {
            $('#add-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#add-action-state').hide();
            $('#add-action-state').show();
            $('#add-action-state').html(loading_popup);
            var data = $("#sequenceForm").serialize();
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/organizationSequence",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#add-form-bttons').hide();
                        $('#add-action-state').removeClass('alert-danger').addClass('alert-success');
                        $('#add-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                            cancelGroup();
                            checkURL();
                            return;
                        }, 3000);
                    } else {
                        $('#add-form-bttons').hide();
                        $('#add-action-state').show();
                        $('#add-action-state').removeClass('alert-success').addClass('alert-danger');
                        $('#add-action-state').html(response.errorDesc);
                    }
                }
            });
        }
    }
</script>  