<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:38:36
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\delivery-file-webcam-store-component.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e2d4333494_35081490',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '36fbe4d01ec72e29cc06154c8ac4da7df81f6cee' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\delivery-file-webcam-store-component.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e2d4333494_35081490 (Smarty_Internal_Template $_smarty_tpl) {
echo '<script'; ?>
 type="text/javascript" src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/lib/webcamjs/webcam.min.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 type="text/javascript" src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/lib/webcamjs/webcam.js?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
"><?php echo '</script'; ?>
>

<div class="col-md-12 mt-10">
    <button class="btn btn-primary" id="delOpenButton" onclick="delOpenWebcam();">Open Webcam</button>
    <button class="btn btn-secondary" id="delCloseButton" onclick="delCloseWebcam()">Close Webcam</button>
    <button class="btn btn-success" id="delTakeSnapshot" onclick="del_take_snapshot()">Take snapshot</button>
    <button class="btn btn-danger" id="delClearSnapshot" onclick="del_clear_snapshot()">Clear snapshot</button>
    <div id="del_my_camera" style="margin-top: 3px;margin-bottom: 3px;"></div>
</div>

<div class="col-md-12" style="max-height: 100px;overflow-y: auto;">
    <div id="del_captured_image" ></div>
</div>

<?php echo '<script'; ?>
>
    Webcam.set({
        width: 200,
        height: 140,
        image_format: 'jpeg',
        jpeg_quality: 90
    });

    function delOpenWebcam() {
        Webcam.attach('#del_my_camera');
        $('#delOpenButton').prop('disabled', true);
        $('#delCloseButton').prop('disabled', false);
        $('#delTakeSnapshot').prop('disabled', false);
    }

    function delCloseWebcam() {
        Webcam.reset();
        $('#delOpenButton').prop('disabled', false);
        $('#delCloseButton').prop('disabled', true);
        $('#delTakeSnapshot').prop('disabled', true);
        $('#del_my_camera').removeAttr("style");
    }

    function del_clear_snapshot() {
        $('#del_captured_image').html('');
    }

    function del_take_snapshot() {
        Webcam.snap(function(data_uri) {
            $('#del_captured_image').append("<img style='width: 33%;' src='"+data_uri+"'/>");
        });
    }
<?php echo '</script'; ?>
><?php }
}
