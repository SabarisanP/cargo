<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-29 18:17:38
  from 'E:\xampp\htdocs\cargo\application\views\site\template\document-upload-dialog.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665723ea6b86a7_21125925',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '6a64d6b6b525146f7043ce107da1ad82ce2b495b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\template\\document-upload-dialog.tpl',
      1 => 1716980854,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:site/cargo/file-webcam-store-component.tpl' => 1,
    'file:site/cargo/file-store-component.tpl' => 1,
  ),
),false)) {
function content_665723ea6b86a7_21125925 (Smarty_Internal_Template $_smarty_tpl) {
?><div id="proof-gallery-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideProofGallery();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="proof-gallery-panel" class="clearfix" style="padding: 10px 5px;">
        <div>
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#tab_pob" role="tab" data-toggle="tab">POB</a></li>
                <li role="presentation"><a href="#tab_pod" role="tab" data-toggle="tab">POD</a></li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="tab_pob">
                    <label class="proof-gallery-document"></label>
                    <div class="file-upload-gallery dialog-gallery"></div>
                    <label class="webcam-proof-gallery-document"></label>
                    <div class="file-webcam-upload-gallery"></div>
                </div>
                <div role="tabpanel" class="tab-pane" id="tab_pod">
                    <label class="proof-gallery-document"></label>
                    <div class="file-upload-gallery dialog-gallery"></div>
                    <label class="webcam-proof-gallery-document"></label>
                    <div class="file-webcam-upload-gallery"></div>
                </div>
            </div>
        </div>

        <div id="proof-gallery-alert"></div>
    </div>
</div> 

<div id="proof-document-dialog" style="display: none">
    <div class="clearfix">
        <b id="proof-document-title"></b>
    </div>
    <div id="proof-document-panel" class="clearfix" style="padding: 10px 5px;">
        <div class="row" style="overflow-y: auto;">
            <div class="col-md-4">
                <label for="proof-document-type" class="req">Document Type</label>
                <select id="proof-document-type" class="form-control">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['proof_document_type']->value, 'name', false, 'code');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['code']->value => $_smarty_tpl->tpl_vars['name']->value) {
?>
                        <option value="<?php echo $_smarty_tpl->tpl_vars['code']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['name']->value;?>
</option>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </select>
            </div>
            <div class="col-lg-4 p_l_n">
                <label for="proof-document-no">Document Number</label>
                <input type="text" class="form-control" id="proof-document-no" placeholder="Document Number" maxlength="25">
            </div>
            <div class="col-lg-4 p_l_n">
                <label for="proof-mobile-no">Mobile Number</label>
                <input type="text" class="form-control" id="proof-mobile-no" placeholder="Mobile Number" maxlength="10" inputmode="decimal" data-mask="inrcurrency" oninput="validateNumberInput(this, 10)">
            </div>
        
            <div>
                <?php $_smarty_tpl->_subTemplateRender("file:site/cargo/file-webcam-store-component.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('id'=>"webcam-proof-fileupload",'axis'=>"horizontal"), 0, false);
?>
            </div>

            <div class="col-md-12">
                <?php $_smarty_tpl->_subTemplateRender("file:site/cargo/file-store-component.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('id'=>"proof-fileupload",'axis'=>"horizontal"), 0, false);
?>
            </div>

            <div class="col-md-12">
                <div id="proof-document-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="proof-document-panel-btn">
                <input type="hidden" id="proof-document-category" value="">
                <button type="button" class="btn btn-success" onclick="saveProofDocument();">Upload</button>&nbsp;
                <button type="button" class="btn btn-default" id="proof-document-cancel" onclick="hideProofDialog();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>  
<?php echo '<script'; ?>
>
    var adhaarValue = $('#proof-document-type option:selected').val();
    if (adhaarValue == 'ADHR') {
        $('#proof-document-no').attr('maxlength', '12');
    } else {
        $('#proof-document-no').attr('maxlength', '25');
    }

    $('#proof-document-type').on('change', function() {
        var selectedValue = $('#proof-document-type option:selected').val();
        if (selectedValue == 'ADHR') {
            $('#proof-document-no').attr('maxlength', '12');
        } else {
            $('#proof-document-no').attr('maxlength', '25');
        }
        $('#proof-document-no').val('').trigger('change');
    });
<?php echo '</script'; ?>
><?php }
}
