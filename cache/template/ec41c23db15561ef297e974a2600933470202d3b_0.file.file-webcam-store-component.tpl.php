<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:33:57
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\file-webcam-store-component.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e1bd9dfa30_02204959',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'ec41c23db15561ef297e974a2600933470202d3b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\file-webcam-store-component.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e1bd9dfa30_02204959 (Smarty_Internal_Template $_smarty_tpl) {
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
    <button class="btn btn-primary" id="openButton" onclick="openWebcam();">Open Webcam</button>
    <button class="btn btn-secondary" id="closeButton" onclick="closeWebcam()">Close Webcam</button>
    <button class="btn btn-success" id="takeSnapshot" onclick="take_snapshot()">Take snapshot</button>
    <button class="btn btn-danger" id="clearSnapshot" onclick="clear_snapshot()">Clear snapshot</button>
    <div id="my_camera" style="margin-top: 3px;margin-bottom: 3px;"></div>
</div>

<div class="col-md-12" style="max-height: 100px;overflow-y: auto;">
    <div id="captured_image" ></div>
</div>

<?php echo '<script'; ?>
>
    Webcam.set({
        width: 200,
        height: 140,
        image_format: 'jpeg',
        jpeg_quality: 90
    });

    function openWebcam() {
        Webcam.attach('#my_camera');
        $('#openButton').prop('disabled', true);
        $('#closeButton').prop('disabled', false);
        $('#takeSnapshot').prop('disabled', false);
    }

    function closeWebcam() {
        Webcam.reset();
        $('#openButton').prop('disabled', false);
        $('#closeButton').prop('disabled', true);
        $('#takeSnapshot').prop('disabled', true);
        $('#my_camera').removeAttr("style");
    }

    function clear_snapshot() {
        $('#captured_image').html('');
    }

    function take_snapshot() {
        Webcam.snap(function(data_uri) {
            $('#captured_image').append("<img style='width: 33%;' src='"+data_uri+"'/>");
        });
    }
<?php echo '</script'; ?>
><?php }
}
