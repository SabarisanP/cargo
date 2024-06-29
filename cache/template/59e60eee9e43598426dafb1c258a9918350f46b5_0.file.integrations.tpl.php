<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 12:59:48
  from 'E:\xampp\htdocs\cargo\application\views\site\admin\integrations.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665587ec82ecf6_54819892',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '59e60eee9e43598426dafb1c258a9918350f46b5' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\admin\\integrations.tpl',
      1 => 1716451523,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665587ec82ecf6_54819892 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top"><h3> Integrations</h3></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12" >
                    <br>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="tabbable tabs-left">
                                <ul class="nav nav-tabs" id="integrations-tabs">
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['integrations_type']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                        <li><a id="integrations-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
-tab" data-code="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-name="<?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
" data-toggle="tab" href="#integrations-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" role="tab" aria-controls="integrations-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" aria-selected="false"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</a></li> 
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </ul>
                                <div class="tab-content" id="tabs_content_extra">
                                    <div id="bulk_station_point_exception" class="tab-pane active fade in">
                                        <div id="integrations-well-div">
                                            <div class="well">
                                                Please select an option in left panel to view menu settings.
                                            </div>
                                        </div>
                                        <div id="integrations-content"></div>
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

<div id="integrations-dialog" class="hide dialog-content-page">
    <form id="integrations-form" autocomplete="off" onsubmit="return false;">
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="req" for="integrations-account">Account</label>
                    <input type="text" class="form-control" id="integrations-account" placeholder="Account" required>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="req" for="integrations-accessurl">Access URL</label>
                    <input type="text" class="form-control" id="integrations-accessurl" placeholder="Access URL" required>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label class="req" for="integrations-accesstoken">Access Token</label>
                    <input type="text" class="form-control" id="integrations-accesstoken" placeholder="Access Token" required>
                </div>
            </div>
        </div>
        <div class="additional-fields hide" data-additionaltype="EWAYBILL">
            <h5 class="b_b_d">Additional Attributes</h5>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="req" for="integrations-state">State</label>
                        <select class="form-control" id="integrations-state" >
                            <option value="NA">Default</option>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['states']->value, 'state');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['state']->value) {
?>
                                <option value="<?php echo $_smarty_tpl->tpl_vars['state']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['state']->value->name;?>
</option>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </select>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="req" for="additional-secret">Secret Key</label>
                        <input type="text" class="form-control" id="additional-secret" placeholder="Secret Key" required>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="req" for="additional-id">App ID</label>
                        <input type="text" class="form-control" id="additional-id" placeholder="App ID" required>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="req" for="additional-gstin">GSTIN</label>
                        <input type="text" class="form-control" id="additional-gstin" placeholder="GSTIN" required>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="alert col-md-7" id="integrations-alert"></div>
                <button type="button" class="btn btn-default pull-right" onclick="Integrations.close()">Cancel</button>&emsp;
                <button type="button" class="btn btn-success pull-right" onclick="Integrations.update();">Save changes</button>&emsp;
                            </div>
        </div>
    </form>
</div>

<input type="hidden" id="integrations-data" value="<?php echo htmlspecialchars(json_encode((($tmp = @$_smarty_tpl->tpl_vars['integrations']->value)===null||$tmp==='' ? array() : $tmp)), ENT_QUOTES, 'UTF-8', true);?>
">

<?php echo '<script'; ?>
>
    var Integrations = {
        init: function () {
            this.data = JSON.parse($('#integrations-data').remove().val());

            $('#integrations-state').select2();

            $('#integrations-tabs a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                $('#integrations-form-div').removeClass('hide');
                $('#integrations-well-div').addClass('hide');

                var $tab = $(e.target);
                Integrations.getIntegrations($tab.data('code'), $tab.data('name'));

                $('.additional-fields').addClass('hide');
                $('.additional-fields[data-additionaltype="' + $tab.data('code') + '"]').removeClass('hide');
            });
        },
        edit: function (data) {
            $('#integrations-alert').removeClass('alert-danger alert-success');
            $('#integrations-alert').html('').hide();

            if (data) {
                $('#integrations-account').val(data.account);
                $('#integrations-accessurl').val(data.accessUrl);
                $('#integrations-accesstoken').val(data.accessToken);

                if (data.integrationType && data.integrationType.code == 'EWAYBILL') {
                    $('#integrations-state').val(data.state.code).trigger('change');
                    $('#additional-secret').val(data.additionalAttribute.SECRET);
                    $('#additional-id').val(data.additionalAttribute.APPID);
                    $('#additional-gstin').val(data.additionalAttribute.GSTIN);
                }
            } else {
                $('#integrations-code').val('');
                $('#integrations-form').trigger('reset');
            }

            var integrationTypeCode = $('#integrations-tabs li.active a').data('code');

            $('#integrations-dialog').removeClass('hide');
            $('#integrations-dialog').dialog({
                autoOpen: true,
                height: integrationTypeCode == 'EWAYBILL' ? 550 : 350,
                width: 750,
                modal: true,
                resizable: false
            });
        },
        update: function () {
            var data = {};
            data.activeFlag = 1;
            data.account = $('#integrations-account').val().trim();
            data.accessUrl = $('#integrations-accessurl').val().trim();
            data.accessToken = $('#integrations-accesstoken').val().trim();
            data.integrationType = {};
            data.integrationType.code = $('#integrations-tabs li.active a').data('code');
            data.integrationType.name = $('#integrations-tabs li.active a').data('name');
            data.additionalAttribute = {};

            if (!data.integrationType.code) {
                return;
            }
            
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.account == '') {
                $('#integrations-account').addClass('inp_error');
                err++;
            }
            if (data.accessUrl == '') {
                $('#integrations-accessurl').addClass('inp_error');
                err++;
            }
            if (data.accessToken == '') {
                $('#integrations-accesstoken').addClass('inp_error');
                err++;
            }

            if (data.integrationType.code == 'EWAYBILL') {
                data.state = {};
                data.state.code = $('#integrations-state').val();
                data.additionalAttribute.SECRET = $('#additional-secret').val().trim();
                data.additionalAttribute.APPID = $('#additional-id').val().trim();
                data.additionalAttribute.GSTIN = $('#additional-gstin').val().trim();

                if (data.state.code == '') {
                    $('#integrations-state').addClass('inp_error');
                    err++;
                }
                if (data.additionalAttribute.SECRET == '') {
                    $('#additional-secret').addClass('inp_error');
                    err++;
                }
                if (data.additionalAttribute.APPID == '') {
                    $('#additional-id').addClass('inp_error');
                    err++;
                }
                if (data.additionalAttribute.GSTIN == '') {
                    $('#additional-gstin').addClass('inp_error');
                    err++;
                }
            }
            
            if (err > 0) {
                $('#integrations-alert').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#integrations-alert').html('Please enter/select the values in the field that are marked in red');
                $('#integrations-alert').show();
                return false;
            }
            
            $('#integrations-alert').removeClass('alert-danger').removeClass('alert-success');
            $('#integrations-alert').html(loading_popup);
            $('#integrations-alert').show();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: 'admin/update-integrations',
                data: data,
                success: function (res) {
                    if (res.status === 1) {
                        $('#integrations-alert').addClass('alert-success').removeClass('alert-danger');
                        $('#integrations-alert').html('Your request has been completed successfully');
                        setTimeout(function () {
                            Integrations.close();
                            Integrations.getIntegrations(data.integrationType.code, data.integrationType.name);
                        }, 3000);
                    } else {
                        $('#integrations-alert').show();
                        $('#integrations-alert').addClass('alert-danger');
                        $('#integrations-alert').html(res.errorDesc);
                    }
                }
            });
        },
        delete: function (data) {
            if (!data) {
                return;
            }
            data.activeFlag = 2;

            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: 'admin/update-integrations',
                data: data,
                success: function (res) {
                    if (res.status === 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        setTimeout(function () {
                            Integrations.getIntegrations(data.integrationType.code, data.integrationType.name);
                        }, 2500);
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                        alert(res.errorDesc);
                    }
                    setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        },
        getIntegrations:  function (code, name) {
            var data = {};
            data.integrationTypeCode = code;
            data.integrationTypeName = name;

            if (!data.integrationTypeCode) {
                return;
            }

            $('#integrations-content').html(loading_popup);

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: 'admin/get-integrations',
                data: data,
                success: function (res) {
                    $('#integrations-content').html(res);
                }
            });
        },
        close: function () {
            $('#integrations-dialog').dialog('destroy');
            $('#integrations-dialog').hide();
        }
    };
    Integrations.init()
<?php echo '</script'; ?>
><?php }
}
