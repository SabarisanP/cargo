<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:37:00
  from 'E:\xampp\htdocs\cargo\application\views\site\widgets\announcements.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e2748c2f12_72398676',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'e28008d598c0d9c7d379f632cfdf5fa2197d0e52' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\widgets\\announcements.tpl',
      1 => 1716451522,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e2748c2f12_72398676 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.replace.php','function'=>'smarty_modifier_replace',),));
?>
<div>
    <div id="advertisement-panel">
        <div id="carousel-advertisement" class="carousel slide" data-ride="carousel">
            <?php $_smarty_tpl->_assignInScope('slidecount', 0);?>
            <div class="carousel-inner" role="listbox">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['banners']->value, 'banner');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['banner']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['banner']->value->displayModel != 'A') {?>
                        <?php continue 1;?>
                    <?php }?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['banner']->value->bannerDetails, 'detail', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['detail']->value) {
?>
                        <div class="item <?php if ($_smarty_tpl->tpl_vars['slidecount']->value == 0) {?>active<?php }?>">
                            <a href="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['detail']->value->redirectUrl)===null||$tmp==='' ? 'javascript:;' : $tmp);?>
" target="_blank">
                                <img src="<?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['detail']->value->url,'[##]','image');?>
" alt="<?php echo $_smarty_tpl->tpl_vars['detail']->value->alternateText;?>
" width="100%">
                            </a>
                        </div>
                        <?php $_smarty_tpl->_assignInScope('slidecount', ($_smarty_tpl->tpl_vars['slidecount']->value+1));?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </div>

                    </div>

        <?php echo '<script'; ?>
>
            $(function () {
                $('#carousel-advertisement').carousel({ interval: 5000 });
            });
        <?php echo '</script'; ?>
>
        <br>
        <br>
    </div>

    <div id="announcement-panel" class="panel panel-default">
        <div id="carousel-announcement" class="carousel slide" data-ride="carousel">
            <?php $_smarty_tpl->_assignInScope('slidecount', 0);?>
            <div class="carousel-inner" role="listbox">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['banners']->value, 'banner');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['banner']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['banner']->value->displayModel != 'N') {?>
                        <?php continue 1;?>
                    <?php }?>
                    <div class="item <?php if ($_smarty_tpl->tpl_vars['slidecount']->value == 0) {?>active<?php }?>">
                        <div class="title label label-danger bold" style="background-color: #<?php echo $_smarty_tpl->tpl_vars['banner']->value->color;?>
!important"><?php echo $_smarty_tpl->tpl_vars['banner']->value->name;?>
</div>
                        <div class="pull-right text-muted"><?php echo date('jS F Y h:i A',strtotime($_smarty_tpl->tpl_vars['banner']->value->updatedAt));?>
</div>
                        <div class="body-panel">
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['banner']->value->bannerDetails, 'detail', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['detail']->value) {
?>
                                
                                    <div class="subtext" type="button" data-toggle="modal" data-target="#modal-<?php echo $_smarty_tpl->tpl_vars['detail']->value->code;?>
" title="Click to view more details" style="cursor: pointer;">
                                        <?php if ($_smarty_tpl->tpl_vars['detail']->value->messageType->code == 'IMAGE') {?>
                                            <img class="dash-announcement-image" src="<?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['detail']->value->url,'[##]','image');?>
" alt="<?php echo $_smarty_tpl->tpl_vars['detail']->value->alternateText;?>
" height="150px">
                                        <?php } else { ?>                                                
                                            <?php echo $_smarty_tpl->tpl_vars['detail']->value->alternateText;?>

                                        <?php }?>
                                    </div>

                                    <div class="modal modal-announcement fade" id="modal-<?php echo $_smarty_tpl->tpl_vars['detail']->value->code;?>
" tabindex="-1" data-keyboard="false" data-backdrop="static" aria-labelledby="myModalLabel">
                                        <div class="modal-dialog modal-centered modal-lg" style="padding-top: 5%;">
                                            <div class="modal-content  last-active" style="    border-radius: 12px;">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times-circle fa-lg"></i></button>
                                                    <span class="label label-danger bold"><?php echo $_smarty_tpl->tpl_vars['banner']->value->name;?>
</span>
                                                </div>
                                                <div class="modal-body" style="white-space: normal;">
                                                    <?php if ($_smarty_tpl->tpl_vars['detail']->value->messageType->code == 'IMAGE') {?>
                                                        <img class="dash-announcement-image1" src="<?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['detail']->value->url,'[##]','image');?>
" alt="<?php echo $_smarty_tpl->tpl_vars['detail']->value->alternateText;?>
">
                                                    <?php } else { ?>                                                
                                                        <?php echo $_smarty_tpl->tpl_vars['detail']->value->alternateText;?>

                                                    <?php }?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                
                                <?php $_smarty_tpl->_assignInScope('slidecount', ($_smarty_tpl->tpl_vars['slidecount']->value+1));?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </div>
                    </div>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </div>

            <?php if ($_smarty_tpl->tpl_vars['slidecount']->value > 1) {?>
                <a class="left carousel-control" href="#carousel-announcement" role="button" data-slide="prev">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="30" height="30" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 20 20"><path d="M13.891 17.418a.697.697 0 0 1 0 .979a.68.68 0 0 1-.969 0l-7.83-7.908a.697.697 0 0 1 0-.979l7.83-7.908a.68.68 0 0 1 .969 0a.697.697 0 0 1 0 .979L6.75 10l7.141 7.418z" fill="#999"/></svg>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-announcement" role="button" data-slide="next">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="30" height="30" style="-ms-transform: rotate(180deg); -webkit-transform: rotate(180deg); transform: rotate(180deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 20 20"><path d="M13.891 17.418a.697.697 0 0 1 0 .979a.68.68 0 0 1-.969 0l-7.83-7.908a.697.697 0 0 1 0-.979l7.83-7.908a.68.68 0 0 1 .969 0a.697.697 0 0 1 0 .979L6.75 10l7.141 7.418z" fill="#999"/></svg>
                    <span class="sr-only">Next</span>
                </a>                
            <?php }?>
        </div>

        <?php echo '<script'; ?>
>
            $(function () {

                $('#carousel-announcement, #carousel-advertisement').on('slide.bs.carousel', function (e) {
                    if ($('.modal-announcement').hasClass('in')) {
                        e.preventDefault();
                        return;
                    }
                    $('.modal-announcement.in').modal('hide')
                })
            });
        <?php echo '</script'; ?>
>
    </div>
</div><?php }
}
