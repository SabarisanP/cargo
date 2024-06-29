<div class="brand_top">
    <h3>Cargo Tags</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="TagsDialog();">Add New Tag</a>
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div class="clear_fix_both"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-3 col-md-6 ">
                                        <ul class="user_list">
                                            {foreach item=row from=$cargotags}
                                                <li id="tag-{$row->code}">
                                                    <span class="tag_name col-xs-3">{$row->name}</span>
                                                    <span class="tag_cr_dr_flag col-xs-3">
                                                        {$row->category->name}
                                                    </span>
                                                    <span class="tag_status col-xs-3">
                                                        {if $row->activeFlag==1}
                                                            <span class="label label-success" id="tag-lb-{$row->code}">Active</span>
                                                        {else}
                                                            <span class="label label-danger" id="tag-lb-{$row->code}">Disabled</span>
                                                        {/if}
                                                    </span>
                                                    <span class="tag_action col-xs-3">
                                                        <div class="btn-group btn-group-xs">
                                                            <a href="javascript:;" class="btn btn-default btn-sm" onclick="editTagsStatus('{$row->code}');">
                                                                {if $row->activeFlag==1}
                                                                    <i class="fa fa-times" id="tag-stu-{$row->code}" title="Click to disable"></i>
                                                                {else}
                                                                    <i class="fa fa-check" id="tag-stu-{$row->code}" title="Click to enable"></i>
                                                                {/if}
                                                            </a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm {if $row->activeFlag==0}none{/if}" title="Edit" id='tag_edt_{$row->code}' onclick='TagsDialog("{$row->code}");'><i class="fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick="deleteTags('{$row->code}');"><i class="fa fa-trash-o ired"></i></a>
                                                        </div>
                                                    </span>
                                                </li>
                                            {foreachelse}
                                                <li class="er_msg">
                                                    <div class="well well-large "> No Tags Found!</div>
                                                </li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                </div>
                                <!--panel Body end-->
                            </div>
                            <!--panel end-->
                        </div>
                    </div>
                    <!--row end-->
                </div>
                <!--content end-->
            </div>
        </div>
    </div>
</div>

<div id="tag-dialog" class="hide dialog-content-page">
    <form role="form" class="form-horizontal">

        <div class="form-group">
            <label class="col-sm-3 control-label req" for="tag-name">Name</label>
            <div class="col-sm-7">
                <input type="text" placeholder="Name" id="tag-name" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label req" for="tph_name">Category</label>
            <div class="col-sm-7">
                <select id="tag-category" class="form-control">
                    <option value="">Select Category</option>
                    <option value="BRCH">Branch</option>
                    <option value="VHCL">Vehicle</option>
                    <option value="DRVR">Driver</option>
                    <option value="TRANS">Transporter</option>
                    <option value="MGEXP">Manage Expense</option>
                </select>
            </div>
        </div>

        <input type="hidden" id="tag-code" class="form-control">
    </form>
    <div class="align-center pull-left" id="tag-action"></div>
    <div class="align-right" id="tag-buttons">
        <button class="btn btn-success" type="button" onclick="saveTags();">Save</button>
        <button class="btn btn-default" type="button" onclick="closeTags();">Cancel</button>
    </div>
</div>

<script>
    var cargoTags = {$cargotags|json_encode}

    function TagsDialog(code) {
        $('#tag-dialog .inp_error').removeClass('inp_error');
        $('#tag-action').hide();
        if (code) {
            var data = cargoTags.find(function(e) {
                return e.code == code;
            });
            $('#tag-code').val(data.code);
            $('#tag-name').val(data.name);
            $('#tag-category').val(data.category.code);
        } else {
            $('#tag-code, #tag-name, #tag-category').val('');
        }
        $('#tag-dialog').removeClass('hide');
        $('#tag-dialog').dialog({
            autoOpen: true,
            width: 600,
            maxWidth: 600,
            height: 350,
            resizable: false,
            modal: true
        });
        $(".ui-dialog-titlebar").hide();
    }

    function closeTags() {
        $('#tag-dialog').dialog('destroy');
        $('#tag-dialog').hide();
    }

    function saveTags() {
        var data = {};
        data.code = $('#tag-code').val();
        data.name = $('#tag-name').val();
        data.category = {};
        data.category.code = $('#tag-category').val();
        data.activeFlag = 1;

        $('.inp_error').removeClass('inp_error');
        var err = 0;
        if (data.name == '') {
            $('#tag-name').addClass('inp_error');
            err++;
        }
        if (data.category.code == '') {
            $('#tag-category').addClass('inp_error');
            err++;
        }
        if (err > 0) {
            $('#tag-action').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red</div>');
            $('#tag-action').show();
            return false;
        }

        $('#tag-buttons').hide();
        $('#tag-action').html(loading_popup).show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/update-cargo-tags',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#tag-action').html('<div class="alert alert-success">Your request has been completed successfully</div>');

                    window.setTimeout(function() {
                        closeTags();
                        checkURL();
                    }, 3000);
                } else {
                    $('#tag-action').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
                }

            }
        });
    }

    function deleteTags(code) {
        if (confirm('Do you want to delete this Tag?')) {
            var data = cargoTags.find(function(e) {
                return e.code == code;
            });
            data.activeFlag = 2;
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + 'config/update-cargo-tags',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function() {
                            checkURL();
                        }, 2000);
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

    function editTagsStatus(code) {
        var data = cargoTags.find(function(e) {
            return e.code == code;
        });
        data.activeFlag = (data.activeFlag) ? 0 : 1;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/update-cargo-tags',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function() {
                        checkURL();
                    }, 2000);
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
</script>
