<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-12 11:07:57
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\cargo-remarks.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66693435f01f58_89269926',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'c5456cd4aa906235c24f163d52eabcecef50c884' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\cargo-remarks.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66693435f01f58_89269926 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3> Cargo Remarks</h3>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <br>
                    <div class="panel panel-default">
                        <div class="panel-body">

                            <div class="tabbable" id="remarks-tab-div">
                                <ul class="nav nav-tabs" id="remarks-tab">
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargo_remarks_status']->value, 'status_name', false, 'status', 'loop', array (
  'first' => true,
  'index' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['status']->value => $_smarty_tpl->tpl_vars['status_name']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['index']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['first'] = !$_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['index'];
?>
                                        <li <?php if ((isset($_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['first']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['first'] : null)) {?>class="active" <?php }?>>
                                            <a data-toggle="tab" href="#<?php echo $_smarty_tpl->tpl_vars['status']->value;?>
_pane" data-tab="<?php echo $_smarty_tpl->tpl_vars['status']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['status_name']->value;?>
</a>
                                        </li>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </ul>
                                <div class="tab-content" id="tabs_content_a">
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargo_remarks_status']->value, 'status_name', false, 'status', 'loop', array (
  'first' => true,
  'index' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['status']->value => $_smarty_tpl->tpl_vars['status_name']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['index']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['first'] = !$_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['index'];
?>
                                        <div id="<?php echo $_smarty_tpl->tpl_vars['status']->value;?>
_pane" class="tab-pane fade in <?php if ((isset($_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['first']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_loop']->value['first'] : null)) {?>active<?php }?>">
    
                                            <table class="table table-striped remarks-table" id="remarks-table-<?php echo $_smarty_tpl->tpl_vars['status']->value;?>
" data-status="<?php echo $_smarty_tpl->tpl_vars['status']->value;?>
">
                                                <thead>
                                                    <tr>
                                                        <th></th>
                                                        <th width="200"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                                <tfoot>
                                                </tfoot>
                                            </table>
    
                                        </div>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </div>
                            </div>

                        </div>
                        <!--panel Body end-->
                    </div>
                    <!--panel end-->
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo '<script'; ?>
 id="template-remarks-row" type="text/template">
    <tr class="remarks_row">
        <td>
            <input type="text" class="form-control rms_name" value="" placeholder="Enter Remarks">
        </td>
        <td width="230">
            <div class="btn-group btn-group-days hide remarks-status-btn-group" data-toggle="buttons">
                <label class="btn btn-xs btn-success" data-status="1" data-toggle="tooltip" title="Positive Remark">
                    <input type="radio" class="remarks-status-type" value="1" autocomplete="off"> <i class="fa fa-2x fa-thumbs-up"></i>
                </label>
                <label class="btn btn-xs btn-success" data-status="0" data-toggle="tooltip" title="Negative Remark">
                    <input type="radio" class="remarks-status-type" value="0" autocomplete="off"> <i class="fa fa-2x fa-thumbs-down fa-flip-horizontal"></i>
                </label>
            </div>&emsp;
            <div class="btn-group">
                <a href="javascript:;" class="btn btn-sm btn-default tr_remove" tabindex="-1" onclick="remove_remarks(this)">Remove</a>
            </div>
        </td>
    </tr>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 id="template-row-buttons" type="text/template">
    <tr id="tr_add">
        <td>
            <div class="alert rms-form-action-state"></div>
        </td>
        <td>
            <div class="remarks-buttons">
                <a href="javascript:;" class="btn btn-sm btn-primary addrow"  onclick="new_remarks_row(this);" >Add </a>
                <a href="javascript:;" class="btn btn-sm btn-success" onclick="save_remarks(this);">Save </a>
            </div>
        </td>
    </tr>
<?php echo '</script'; ?>
>

<style>
    .remarks-status-btn-group > .btn {
        background-color: transparent !important;
        border: none !important;
        box-shadow: none !important;
        color: #bbb;
    }
    .remarks-status-btn-group > .btn[data-status="1"]:focus,
    .remarks-status-btn-group > .btn[data-status="1"]:active,
    .remarks-status-btn-group > .btn.active[data-status="1"] {
        color: #68c12c !important;
    }
    .remarks-status-btn-group > .btn[data-status="0"]:focus,
    .remarks-status-btn-group > .btn[data-status="0"]:active,
    .remarks-status-btn-group > .btn.active[data-status="0"] {
        color: #c83b2d !important;
    }
</style>

<?php echo '<script'; ?>
>
    var remarksList = <?php echo json_encode($_smarty_tpl->tpl_vars['remarks']->value);?>
;

    $('#remarks-tab-div').on('input change', '.remarks_row', function () {
        $(this).closest('.remarks_row').data('modified', 1);
    });

    $('#remarks-tab-div').on('input', '.remarks-table .remarks_row:last-child', function () {
        new_remarks_row(this)
    });

    $('#remarks-tab-div').on('click', '.remarks-status-btn-group label', function (e) {
        if ($(this).find('.remarks-status-type').is(':checked')) {
            $(this).removeClass('active').find('.remarks-status-type').prop('checked', false).trigger('change');
            e.preventDefault();
            e.stopPropagation();
            return false;
        }
    });

    $(document).ready(function() {
        $.each(remarksList, function(bkey, bval) {
            add_remarks_row(bval);
        });

        var row_button = $('#template-row-buttons').html();
        var html = $(row_button).clone();
        $('.remarks-table tfoot').html(html);

        new_remarks_row($('.addrow'));

        $('#remarks-tab').on('show.bs.tab', function (e) {
            var tab = $(e.target).data('tab');
            var $tab = $('#' + tab + '_pane');

            $tab.find('.remarks-status-btn-group').addClass('hide');
            if (tab == 'DRDLY') {
                $tab.find('.remarks-status-btn-group').removeClass('hide');
            }
        });

        $('[data-toggle="tooltip"]').tooltip({
            container: '#main_page_content'
        });
    });

    function add_remarks_row(r) {
        var row_tmplate = $('#template-remarks-row').html();
        var $row = $(row_tmplate).clone();

        $row.attr('data-code', r.code);
        $row.find('input.rms_name').val(r.name);
        $row.find('.remarks-status-type').attr('name', 'remarks-status-' + r.code);
        $row.find('.remarks-status-type[value="' + r.statusFlag + '"]').prop('checked', true).closest('.btn').addClass('active');
        $('#remarks-table-' + r.cargoStatus.code + ' tbody').append($row);
    }

    function new_remarks_row(el) {
        var row_tmplate = $('#template-remarks-row').html();
        var $row = $(row_tmplate).clone();

        $(el).closest('table').find('tbody').append($row);

        if ($(el).closest('.remarks-table').data('status') == 'DRDLY') {
            $row.find('.remarks-status-type').attr('name', 'remarks-status-' + Date.now());
            $(el).closest('.remarks-table').find('.remarks-status-btn-group').removeClass('hide');
        }
    }

    function remove_remarks(ele) {
        var $tr = $(ele).closest('.remarks_row');
        var code = $tr.data('code');

        if (!code) {
            $tr.remove();
            return;
        }

        delete_remarks(code);
    }

    function save_remarks(el) {
        var $table =  $(el).closest('table');
        var status = $table.data('status');

        var data = {};
        data.remarks = [];

        var err = 0;

        $table.find('.remarks_row').each(function() {
            var $tr = $(this);

            if($tr.data('modified') != 1) {
                return;
            }
            
            var obj = {};
            obj.activeFlag = 1;
            obj.code = $tr.data('code');
            obj.name = $tr.find('.rms_name').val().trim();
            obj.cargoStatus = {};
            obj.cargoStatus.code = status;
            obj.statusFlag = $tr.find('.remarks-status-type:checked').val();

            if(obj.code != '' && obj.name == '') {
                $tr.find('.rms_name').addClass('inp_error');
                err++;
            }
            data.remarks.push(obj);
        });

        var $alertdiv = $table.find('.rms-form-action-state');
        if (data.remarks.length == 0) {
            $alertdiv.removeClass('alert-success').addClass('alert-danger');
            $alertdiv.html('Please add/edit atleast one remarks to proceed');
            $alertdiv.show();
            return;
        }

        if (err) {
            $alertdiv.removeClass('alert-success').addClass('alert-danger');
            $alertdiv.html('Please enter/select the values in the field that are marked in red');
            $alertdiv.show();
            return;
        }

        $alertdiv.html(loading_popup);
        $table.find('.remarks-buttons').hide();
    
        $.ajax({
            type: "POST",
            url: base_url + "cargo/batch-update-cargo-remarks",
            data: data,
            dataType: "json",
            success: function(response) {
                if (response.status == 1) {
                    $table.find('.remarks-buttons').show();
                    $alertdiv.removeClass('alert-danger');
                    $alertdiv.addClass('alert-success');
                    $alertdiv.html('Your request has been completed successfully');
                    setTimeout(checkURL, 3000);
                } else {
                    $alertdiv.addClass('alert-danger');
                    $alertdiv.html(response.errorDesc);
                    $table.find('.remarks-buttons').show();
                }
            }
        });

    }

    function delete_remarks(code) {
        var data = _.find(remarksList || [], i => i.code == code);
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-cargo-remarks",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    console.log($('.remarks_row[data-code="' + code + '"]'))
                    $('.remarks_row[data-code="' + code + '"]').animate({
                        backgroundColor: '#1AA1E1'}, 2000, function () {
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
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
<?php echo '</script'; ?>
>
<?php }
}