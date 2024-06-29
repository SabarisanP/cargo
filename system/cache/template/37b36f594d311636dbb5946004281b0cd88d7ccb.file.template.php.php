<?php /* Smarty version Smarty-3.1.16, created on 2014-01-21 20:29:43
         compiled from "application\views\site\template.php" */ ?>
<?php /*%%SmartyHeaderCode:2367052de66012a7491-10691780%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '37b36f594d311636dbb5946004281b0cd88d7ccb' => 
    array (
      0 => 'application\\views\\site\\template.php',
      1 => 1390307379,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2367052de66012a7491-10691780',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.16',
  'unifunc' => 'content_52de6601722769_27934908',
  'variables' => 
  array (
    'page_body' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_52de6601722769_27934908')) {function content_52de6601722769_27934908($_smarty_tpl) {?>    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>Title</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <!--<link rel="shortcut icon" type="image/x-icon" href="images/fave-icon.png" />-->
    </head>
    <body>
    
    <div id="content" style="clear:both">
        <?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['page_body']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array('title'=>'page_content'), 0);?>

    </div>
    
    <div class="footer"> footer </div><?php }} ?>
