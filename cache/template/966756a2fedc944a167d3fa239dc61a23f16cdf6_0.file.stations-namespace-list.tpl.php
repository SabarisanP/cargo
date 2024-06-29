<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-14 12:50:07
  from 'E:\xampp\htdocs\cargo\application\views\site\admin\stations-namespace-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666bef27d11989_34207560',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '966756a2fedc944a167d3fa239dc61a23f16cdf6' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\admin\\stations-namespace-list.tpl',
      1 => 1716451523,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666bef27d11989_34207560 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="well well-sm">
    <input type="text" class="form-control" placeholder="Find Station..." id="list_search" >
</div>  
<div class="user_list_action bt_36">
    <ul class="user_list " id="user_list_search">
        <ul class="user_list " id="user_list_search" style="border:none">


            <?php if (count($_smarty_tpl->tpl_vars['stations']->value) > 0) {?>
                <div id="station_scroll">

                    <li class="hide st-db">
                        <div class="fl rt_8"><a href="javascript:;"></a></div>
                        <div class="fr fr_7">
                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['S-DELETE-STATION'] > 0) {?>
                            <a title="Delete" class="btn btn-default btn-xs" href="javascript:;" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['S-DELETE-STATION'] != 2) {?> onclick='deleteNamespaceMapping()' <?php }?>>
                                <i class="fa fa-trash-o"></i>
                            </a>
                             <?php }?>
                        </div>
                    </li>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'stgrp', false, 'statename');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['statename']->value => $_smarty_tpl->tpl_vars['stgrp']->value) {
?>
                        <li class="rt_8">
                            <div class="bold">
                                <?php echo $_smarty_tpl->tpl_vars['statename']->value;?>

                            </div>
                        </li>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stgrp']->value, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
                        <li id="ns-<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
" style="padding-left:10px;">
                        <div class="fl rt_8"><a href="javascript:;" onclick="getStationPointsList('<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
', '<?php echo $_smarty_tpl->tpl_vars['station']->value['name'];?>
', '<?php echo $_smarty_tpl->tpl_vars['station']->value['shortCode'];?>
');" id="station-link-<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
" data-obj="<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['station']->value), ENT_QUOTES, 'UTF-8', true);?>
" data-shortcode="<?php echo $_smarty_tpl->tpl_vars['station']->value['shortCode'];?>
" title="Click to view station points"><?php echo $_smarty_tpl->tpl_vars['station']->value['name'];?>
 <?php if ($_smarty_tpl->tpl_vars['station']->value['shortCode'] != '' && $_smarty_tpl->tpl_vars['station']->value['shortCode'] != 'NA') {?>(<?php echo $_smarty_tpl->tpl_vars['station']->value['shortCode'];?>
)<?php }?></a></div>
                        <div class="fr fr_7">
                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['S-DELETE-STATION'] > 0) {?> 
                                    <a title="Delete" class="btn btn-default btn-xs" href="javascript:;" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['S-DELETE-STATION'] != 2) {?>onclick='deleteNamespaceMapping(<?php echo json_encode($_smarty_tpl->tpl_vars['station']->value);?>
)'<?php }?>>
                                        <i class="fa fa-trash-o"></i>
                                    </a>
                                <?php }?>
                            </div>
                        </li>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                </div>
            <?php } else { ?>
                <li class="er_msg"><div class="well well-large "> No station found!</div></li>
                <?php }?>    
        </ul>
    </ul>
</div>
<?php echo '<script'; ?>
>

    $(document).ready(function() {
        $('input#list_search').quicksearch('#user_list_search #station_scroll > li');
    });

    $("#station_scroll").css({
        'max-height': '350px',
    }).perfectScrollbar({
        wheelSpeed: 20,
        wheelPropagation: false
    });
    $('#list_search').focus();

<?php echo '</script'; ?>
>

<?php }
}
