<div class="brand_top"><h3>Mobile Block</h3> <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="editMobile();">Add New Block</a></span></div>
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
                                        <table class="table" id="mb-table" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>Mobile</th>
                                                    <th>Remarks</th>
                                                    <th>Status</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach name=o item=row from=$blocks} 
                                                    <tr id="sch-{$row->mobile}">
                                                        <td>{$row->mobile}</td>
                                                        <td>{$row->remarks}</td>
                                                        <td>
                                                            {if $row->activeFlag==1}
                                                                <span class="label label-success" id="lb-{$row->mobile}">Active</span>
                                                            {else}
                                                                <span class="label label-danger" id="lb-{$row->mobile}">Disabled</span>    
                                                            {/if}    
                                                        </td>
                                                        <td>
                                                            <div class="btn-group btn-group-xs">
                                                                <a href="javascript:;" class="btn btn-default btn-sm" onclick="editMobileBlockStatus('{$row->mobile}')">
                                                                    {if $row->activeFlag==1}
                                                                        <i class="fa fa-times" id="mb-{$row->mobile}" data-status="0" title="Click to disable"></i>
                                                                    {else}
                                                                        <i class="fa fa-check" id="mb-{$row->mobile}" data-status="9" title="Click to enable"></i>
                                                                    {/if}
                                                                </a>
                                                                <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick="deleteMobile('{$row->mobile}')"><i class="fa fa-trash-o ired"></i></a>
                                                            </div>
                                                        </td>
                                                    </tr>   
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                    <div id="mb-block-dialog" class="hide dialog-content-page" >
                                        <form role="form" class="form-horizontal">

                                            <div class="form-group">
                                                <label class="col-sm-3 control-label req" for="mb-mobile">Mobile</label>
                                                <div class="col-sm-7">
                                                    <input type="text" placeholder="Mobile" id="mb-mobile" class="form-control">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label" for="mb-remarks">Remarks</label>
                                                <div class="col-sm-7">
                                                    <textarea id="mb-remarks" class="form-control rs_no" maxlength="120" placeholder="Remarks" rows="3"></textarea>
                                                </div>
                                            </div>
                                        </form>
                                        <div class="alert align-center pull-left" style="display:none;" id="mb-block-action"></div>
                                        <div class="align-right" id="mb-block-buttons">
                                            <button class="btn btn-success" type="button" onclick="saveMobileBlock()">Save</button>
                                            <button class="btn btn-default" type="button" onclick="closeMobileBlockDialog()">Cancel</button>
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
        $('#mb-table').DataTable({
        paging : false,
        });
    });
    var blocks = {$blocks|json_encode};
    function editMobile() {
        $('#mb-block-dialog').css('background', '#fff');
        $('.inp_error').removeClass('inp_error');
        $('#mb-block-dialog').removeClass('hide');
        $('#mb-block-action').html('');
        $('#mb-block-action').hide();
        $('#mb-block-dialog').dialog({
            autoOpen: true,
            height: 300,
            width: 450,
            modal: true,
            resizable: false
        });
        
        $('#mb-mobile,#mb-remarks').val('');
        $(".ui-dialog-titlebar").hide();
    }
    
    function saveMobileBlock() {
        var data = {};
        data.mobile = $.trim($('#mb-mobile').val());
        data.activeFlag = 1;
        data.remarks = $('#mb-remarks').val();
        
        var err = 0;
        
        if (data.mobile.length != 10 || isNaN(data.mobile)) {
            $('#mb-mobile').addClass('inp_error');
            err++;
        }
        if (err > 0) {
            $('#mb-block-action').removeClass('alert-success').addClass('alert-danger');
            $('#mb-block-action').html('Please enter/select the values in the field that are marked in red');
            $('#mb-block-action').show();
            return false;
        } else {
            $('#mb-block-action').removeClass('alert-success').removeClass('alert-danger');
            $('#mb-block-action').hide();
        }
        $('#mb-block-action').hide();
        $('#mb-block-action').removeClass('alert-danger').removeClass('alert-success');
        $('#mb-block-action').html(loading_popup);
        $('#mb-block-action').show();
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-mobile-block",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#mb-block-action').removeClass('alert-danger');
                    $('#mb-block-action').addClass('alert-success');
                    $('#mb-block-action').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        closeMobileBlockDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#mb-block-action').addClass('alert-danger');
                    $('#mb-block-action').html(response.errorDesc);
                    $('#mb-block-action').show();
                }
            }
        });

    }
    
    function deleteMobile(mobile) {
        if (confirm('Do you want to delete this Mobile Number ?')) {

            var data ={};
            var data = _.find(blocks, function (o) {
                return o.mobile === mobile;
            });

            data.activeFlag = 2;
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/update-mobile-block",
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

    function editMobileBlockStatus(mobile) {

        var data = _.find(blocks, function (o) {
            return o.mobile === mobile;
        });
        data.activeFlag = $('#mb-' + mobile).attr('data-status');
        
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-mobile-block",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    var chg = data.activeFlag == 1 ? 0 : 1;
                    $('#mb-' + mobile).attr('data-status', chg);
                    if ($('#mb-' + mobile).attr('data-status') == 1) {
                        $('#mb-' + mobile).removeClass('fa-times').addClass('fa-check');
                    } else {
                        $('#mb-' + mobile).removeClass('fa-times').addClass('fa-times');
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

    function closeMobileBlockDialog() {
        $('#mb-block-dialog').dialog('destroy');
        $('#mb-block-dialog').hide();
    }
</script>
