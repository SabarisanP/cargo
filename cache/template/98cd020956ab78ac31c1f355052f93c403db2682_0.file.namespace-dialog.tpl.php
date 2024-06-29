<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:33:57
  from 'E:\xampp\htdocs\cargo\application\views\site\template\namespace-dialog.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e1bd522510_74067270',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '98cd020956ab78ac31c1f355052f93c403db2682' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\template\\namespace-dialog.tpl',
      1 => 1716451522,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e1bd522510_74067270 (Smarty_Internal_Template $_smarty_tpl) {
?><!-- dialog -->


<div id="pro-dialog" class="dialog-content-page hidden noprint" >
    <form role="form" class="form-horizontal">
        <div class="form-group ">
            <label class="col-sm-2 control-label" for="e_code">Code<span class="required">*</span></label>
            <div class="col-sm-7 np-code">
                <input type="text" placeholder="Code" id="e_code" class="form-control">
            </div>
            <div class="pull-left">
                <a title=" Code should be in alphabet small letters" class="pull-left"><span class="fa fa-question-circle "></span></a>
            </div>
            <div class="col-sm-7 display-code">

            </div>
        </div>
        <div class="form-group" style="">
            <label class="col-sm-2 control-label" for="e_name">Name<span class="required">*</span></label>
            <div class="col-sm-7">
                <input type="text" placeholder="Name" id="e_name" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="e_pin">Pin<span class="required">*</span></label>
            <div class="col-sm-7">
                <input type="text" placeholder="Pin" id="e_pin" class="form-control">
            </div>
        </div>
    </form>

    <input type="hidden" id="flag"  > 
    <div class="pull-left"  id="nsp-action-loading" ></div>
    <div class="alert alert-danger pull-left" style="display: none" id="nsp-action-state"></div>
    <div class="align-right nsp-btn" id="nsp-form-bttons">
        <button class="btn btn-success" type="button" onclick="saveNamespace();">Save</button>
        <button class="btn btn-default" type="button" onclick="cancelProAddEdit();">Cancel</button>
    </div>
</div>

<!--dialog end --><?php }
}
