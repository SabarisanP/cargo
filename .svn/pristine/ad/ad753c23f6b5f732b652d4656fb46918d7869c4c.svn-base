<div class="brand_top"><h3>Schedule Tags</h3> <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="editTag();">Add New Tag</a></span></div>
<div id="main_wrapper">
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
                                    <div class="col-md-offset-3 col-md-6 ">
                                        <table class="table" id="tag-table" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>Tags &nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                                                    <th>Status&nbsp;&nbsp;<i class="fa fa-sort"</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach name=o item=row from=$tags} 
                                                    <tr id="sch-{$row->code}">
                                                        <td>{$row->name}</td>
                                                        <td>
                                                            {if $row->activeFlag==1}
                                                                <span class="label label-success" id="lb-{$row->code}">Active</span>
                                                            {else}
                                                                <span class="label label-danger" id="lb-{$row->code}">Disabled</span>    
                                                            {/if}    
                                                        </td>
                                                        <td>
                                                            <div class="btn-group btn-group-xs">
                                                                <a href="javascript:;" class="btn btn-default btn-sm" title="Edit"  onclick='editTag("{$row->code}")'><i class="fa fa-pencil igreen"></i></a>
                                                                <a href="javascript:;" class="btn btn-default btn-sm" onclick="editTagStatus('{$row->code}')">
                                                                    {if $row->activeFlag==1}
                                                                        <i class="fa fa-times" id="schc-{$row->code}" data-status="0" title="Click to disable"></i>
                                                                    {else}
                                                                        <i class="fa fa-check" id="schc-{$row->code}" data-status="9" title="Click to enable"></i>
                                                                    {/if}
                                                                </a>
                                                                <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick="deleteTags('{$row->code}')"><i class="fa fa-trash-o ired"></i></a>
                                                            </div>
                                                        </td>
                                                    </tr>                                              
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                    <div id="sch-tag-dialog" class="hide dialog-content-page" >
                                        <form role="form" class="form-horizontal">

                                            <div class="form-group">
                                                <label class="col-sm-3 control-label req" for="tph-name">Name</label>
                                                <div class="col-sm-7">
                                                    <input type="text" placeholder="Name" id="sch-tag-name" class="form-control">
                                                </div>
                                            </div>
                                            <input type="hidden" id="sch-tag-code" class="form-control">
                                        </form>
                                        <div class="alert align-center pull-left" style="display:none;" id="sch-tag-action"></div>
                                        <div class="align-right" id="sch-tag-buttons">
                                            <button class="btn btn-success" type="button" onclick="saveTag()">Save</button>
                                            <button class="btn btn-default" type="button" onclick="closeTagDialog()">Cancel</button>
                                        </div>


                                    </div>
                                </div><!--panel Body end-->
                            </div><!--panel end-->

                        </div>

                    </div><!--row end-->
                </div><!--content end-->
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#tag-table').DataTable({
        paging : false,
        });
    });
    var tags = {$tags|json_encode};
    function editTag(code) {
        $('#sch-tag-dialog').css('background', '#fff');
        $('.inp_error').removeClass('inp_error');
        $('#sch-tag-dialog').removeClass('hide');
        $('#sch-tag-action').html('');
        $('#sch-tag-action').hide();
        $('#sch-tag-dialog').dialog({
            autoOpen: true,
            height: 250,
            width: 450,
            modal: true,
            resizable: false
        });
        $('#sch-tag-name').val('');
        $('#sch-tag-code').val('');
        $(".ui-dialog-titlebar").hide();
        if (_isdefined(code)) {

            var option = _.find(tags, function (o) {
                return o.code === code;
            });
            $('#sch-tag-code').val(option.code);
            $('#sch-tag-name').val(option.name);

        }

    }
    function saveTag() {
        var data = {};
        data.name = $('#sch-tag-name').val();
        data.activeFlag = 1;
        data.code = $('#sch-tag-code').val();
        if ($('#sch-tag-code').val() != "") {
        }
        var err = 0;
        if ($('#sch-tag-name').val() == '') {
            $('#sch-tag-name').addClass('inp_error');
            err++;
        }
        if (err > 0) {
            $('#sch-tag-action').removeClass('alert-success').addClass('alert-danger');
            $('#sch-tag-action').html('Please enter/select the values in the field that are marked in red');
            $('#sch-tag-action').show();
            return false;
        } else {
            $('#sch-tag-action').removeClass('alert-success').removeClass('alert-danger');
            $('#sch-tag-action').hide();
        }
        $('#sch-tag-action').hide();
        $('#sch-tag-action').removeClass('alert-danger').removeClass('alert-success');
        $('#sch-tag-action').html(loading_popup);
        $('#sch-tag-action').show();
        console.log(data);
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-schedule-tags",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#sch-tag-action').removeClass('alert-danger');
                    $('#sch-tag-action').addClass('alert-success');
                    $('#sch-tag-action').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        closeTagDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#sch-tag-action').addClass('alert-danger');
                    $('#sch-tag-action').html(response.errorDesc);
                    $('#sch-tag-action').show();
                }
            }
        });

    }



    function deleteTags(code) {
        if (confirm('Do you want to delete this Tag ?')) {

            var data ={};
            var data = _.find(tags, function (o) {
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
                url: base_url + "config/update-schedule-tags",
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
                        return;
                    }, 2000);
                }
            })
        }
    }

    function editTagStatus(code) {

        var data = _.find(tags, function (o) {
            return o.code === code;
        });
        data.activeFlag = $('#schc-' + code).attr('data-status');
        console.log(data);
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-schedule-tags",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    var chg = data.activeFlag == 1 ? 0 : 1;
                    $('#schc-' + code).attr('data-status', chg);
                    if ($('#schc-' + code).attr('data-status') == 1) {
                        $('#schc-' + code).removeClass('fa-times').addClass('fa-check');
                    } else {
                        $('#schc-' + code).removeClass('fa-times').addClass('fa-times');
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

                    checkURL();
                    return;

                }, 2000);
            }
        })
    }

    function closeTagDialog() {
        $('#sch-tag-dialog').dialog('destroy');
        $('#sch-tag-dialog').hide();
    }
</script>
