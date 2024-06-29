<div class="brand_top">
    <h3>Income / Expense Head</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="IEHeadDialog();">Add New Head</a>
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
                                            {foreach item=row from=$result}
                                                <li id="ie-{$row->code}">
                                                    <span class="ie_name col-xs-3">{$row->name}</span>
                                                    <span class="ie_cr_dr_flag col-xs-3">
                                                        {if $row->creditDebitFlag=="Cr"}
                                                            Indirect Income
                                                        {elseif $row->creditDebitFlag=="Dr"}
                                                            Indirect Expense
                                                        {elseif $row->creditDebitFlag=="DCr"}
                                                            Direct Income
                                                        {elseif $row->creditDebitFlag=="DDr"}
                                                            Direct Expense   
                                                        {/if}
                                                    </span>
                                                    <span class="ie_status col-xs-3">
                                                        {if $row->activeFlag==1}
                                                            <span class="label label-success" id="ie-lb-{$row->code}">Active</span>
                                                        {else}
                                                            <span class="label label-danger" id="ie-lb-{$row->code}">Disabled</span>
                                                        {/if}
                                                    </span>
                                                    <span  class="ie_action col-xs-3">
                                                        <div class="btn-group btn-group-xs">
                                                            <a href="javascript:;" class="btn btn-default btn-sm" onclick="editIEHeadStatus('{$row->code}');">
                                                                {if $row->activeFlag==1}
                                                                    <i class="fa fa-times" id="ie-stu-{$row->code}" title="Click to disable"></i>
                                                                {else}
                                                                    <i class="fa fa-check" id="ie-stu-{$row->code}" title="Click to enable"></i>
                                                                {/if}
                                                            </a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm {if $row->activeFlag==0}none{/if}" title="Edit" id='ie_edt_{$row->code}' onclick='IEHeadDialog("{$row->code}");'><i class="fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick="deleteIEHead('{$row->code}');"><i class="fa fa-trash-o ired"></i></a>
                                                        </div>
                                                    </span>
                                                </li>
                                            {foreachelse}
                                                <li class="er_msg"><div class="well well-large "> No Income / Expense Head Found!</div></li>
                                                {/foreach}
                                        </ul>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                </div><!--panel Body end-->
                            </div><!--panel end-->
                        </div>
                    </div><!--row end-->
                </div><!--content end-->
            </div>
        </div>
    </div>
</div>

<div id="ie-head-dialog" class="hide dialog-content-page" >
    <form role="form" class="form-horizontal">

        <div class="form-group">
            <label class="col-sm-3 control-label req" for="ieh-name">Name</label>
            <div class="col-sm-7">
                <input type="text" placeholder="Name" id="ieh-name" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label req" for="tph_name">Description</label>
            <div class="col-sm-7">
                <textarea id="ieh-description" class="rs_no form-control"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label req" for="tph_name">Expense or Income</label>
            <div class="col-sm-7">
                <select id="ie-cr-dr" class="form-control">
                    <optgroup label="Expense">
                    <option value="DDr">Direct Expense</option>
                    <option value="Dr">Indirect Expense</option>
                    </optgroup>
                    <optgroup label="Income">
                    <option value="DCr">Direct Income</option>
                    <option value="Cr">Indirect Income</option>
                    </optgroup>
                </select>
            </div>
        </div>

        <input type="hidden" id="ieh-code" class="form-control">

    </form>
    <div class="align-center pull-left" id="ie-head-action"></div>
    <div class="align-right" id="ie-head-buttons">
        <button class="btn btn-success" type="button" onclick="saveIEHead();">Save</button>
        <button class="btn btn-default" type="button" onclick="closeIEHead();">Cancel</button>
    </div>
    <div class="">
        <div class="col-sm-12">
            <p id="ie-cr-note"style="margin-top:2em"><b>Note :</b>&nbsp;&nbsp;&nbsp;&nbsp;Direct Expenses related to cargo expenses <br/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Indirect Expenses related to general expenses </p>
        </div>
    </div>
</div>


<script>
    var cargoIEHead = {$result|json_encode}
    {literal}
        $('.bsn_switch').bootstrapSwitch('size', 'mini');
        function IEHeadDialog(code) {
            $('#ie-head-dialog .inp_error').removeClass('inp_error');
            $('#ie-head-action').hide();
            if (code) {
                var data = cargoIEHead.find(function (e) {
                    return e.code == code;
                });
                $('#ieh-code').val(data.code);
                $('#ieh-name').val(data.name);
                $('#ieh-description').val(data.description);
                $('#ie-cr-dr').val(data.creditDebitFlag);

                //$('.bsn_switch').bootstrapSwitch('state', (data.creditDebitFlag == 'Cr')?true:false);
            } else {
                $('#ieh-code, #ieh-name, #ieh-description,#ie-cr-dr').val('');
                $('.bsn_switch').bootstrapSwitch('state', true);
            }
            $('#ie-head-dialog').removeClass('hide');
            $('#ie-head-dialog').dialog({
                autoOpen: true,
                width: 600,
                maxWidth: 600,
                height: 350,
                resizable: false,
                modal: true
            });
            $(".ui-dialog-titlebar").hide();
        }

        function closeIEHead() {
            $('#ie-head-dialog').dialog('destroy');
            $('#ie-head-dialog').hide();
        }

        function saveIEHead() {
            var data = {};
            data.code = $('#ieh-code').val();
            data.name = $('#ieh-name').val();
            data.activeFlag = 1;
            data.description = $('#ieh-description').val();
            data.creditDebitFlag = $('#ie-cr-dr').val();

            $('.inp_error').removeClass('inp_error');
            var err = 0;
            if (data.name == '') {
                $('#ieh-name').addClass('inp_error');
                err++;
            }
            if (data.description == '') {
                $('#ieh-description').addClass('inp_error');
                err++;
            }
            if (err > 0) {
                $('#ie-head-action').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red</div>');
                $('#ie-head-action').show();
                return false;
            }

            $('#ie-head-buttons').hide();
            $('#ie-head-action').html(loading_popup).show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/update-income-expense-head',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#ie-cr-note').hide();
                        $('#ie-head-action').html('<div class="alert alert-success">Your request has been completed successfully</div>');
                        
                        window.setTimeout(function () {
                        closeIEHead();
                        checkURL();
                    }, 3000);
                    } else {
                        $('#ie-head-action').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
                    }
                    
                }
            });
        }

        function deleteIEHead(code) {
            if (confirm('Do you want to delete this Income / Expense Head?')) {
            var data = cargoIEHead.find(function(e) {
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
                url: base_url + "cargo/update-income-expense-head",
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
                        }, 2000);
                    }
                });
            }
        }

        function editIEHeadStatus(code) {
            var data = cargoIEHead.find(function (e) {
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
                url: base_url + 'cargo/update-income-expense-head',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        if (data.activeFlag == 1) {
                            $('#ie_edt_' + code).show();
                            $('#ie-stu-' + code).removeClass('fa-check').addClass('fa-times');
                            $('#ie-lb-' + code).removeClass('label-danger').addClass('label-success').html('Active');
                        } else {
                            $('#ie_edt_' + code).hide();
                            $('#ie-stu-' + code).removeClass('fa-times').addClass('fa-check');
                            $('#ie-lb-' + code).removeClass('label-success').addClass('label-danger').html('Disabled');
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
    {/literal}
</script>
