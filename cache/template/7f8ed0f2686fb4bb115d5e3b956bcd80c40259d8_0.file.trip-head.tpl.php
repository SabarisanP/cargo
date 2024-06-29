<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-14 16:54:35
  from 'E:\xampp\htdocs\cargo\application\views\site\trips\trip-head.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666c28739250d7_04485593',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '7f8ed0f2686fb4bb115d5e3b956bcd80c40259d8' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\trips\\trip-head.tpl',
      1 => 1716451523,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666c28739250d7_04485593 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top"><h3>Income / Expense Heads</h3> <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="editTripHead();">Add New Head</a></span></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-2 col-md-8 ">
                                        <ul class="user_list " id="trip_list_search">
                                            
                                            <li>
                                                <span class="col-xs-2 bold">Name</span>
                                                <span class="col-xs-1 bold">Type</span>
                                                <span class="col-xs-2 bold">Txn Mode</span>
                                                <span class="col-xs-2 bold">Tags</span>
                                                <span class="col-xs-2 bold">Mandate. Fields</span>
                                                <span class="col-xs-1 bold">Status</span>
                                                <span class="col-xs-2 bold">Action</span>
                                            </li>
                                            <?php if (count($_smarty_tpl->tpl_vars['data']->value) > 0) {?>
                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'row', false, NULL, 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?> 

                                                    <li id="trp-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"  >
                                                        <span class="trp_name col-xs-2"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</span>
                                                        <span class="trp_cr_dr_flag col-xs-1"><?php if ($_smarty_tpl->tpl_vars['row']->value->transactionType == "Cr") {?>Credit<?php } else { ?>Debit<?php }?></span>
                                                        <span class="trp_mode col-xs-2"><?php echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->name;?>
</span>
                                                        <span class="trp_mode col-xs-2">
                                                            <a id="popup_msg"  data-content='<ul class="p_l_15">
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->tag, 'tag');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['tag']->value) {
?>
                                                                        <li><?php echo $_smarty_tpl->tpl_vars['manage_expense_type']->value[$_smarty_tpl->tpl_vars['tag']->value];?>
</li>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </ul>'>
                                                                <?php if ((count($_smarty_tpl->tpl_vars['row']->value->tag)) >= 1) {
echo $_smarty_tpl->tpl_vars['manage_expense_type']->value[$_smarty_tpl->tpl_vars['row']->value->tag[0]];
} else { ?>-<?php }?>
                                                                <?php if ((count($_smarty_tpl->tpl_vars['row']->value->tag)) > 1) {?><span style="cursor:pointer;" class="badge badge-secondary"><?php echo count($_smarty_tpl->tpl_vars['row']->value->tag);?>
</span><?php }?>
                                                            </a>
                                                        </span>
                                                        <span class="trp_mode col-xs-2">
                                                            <?php $_smarty_tpl->_assignInScope('additionalAttributes', explode(',',$_smarty_tpl->tpl_vars['row']->value->additionalAttributes));?>
                                                            <a id="popup_msg"  data-content='<ul class="p_l_15">
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['additionalAttributes']->value, 'tag');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['tag']->value) {
?>
                                                                        <li><?php echo $_smarty_tpl->tpl_vars['mandate_manage_expense_fields']->value[$_smarty_tpl->tpl_vars['tag']->value];?>
</li>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </ul>'>
                                                                <?php if ((count($_smarty_tpl->tpl_vars['additionalAttributes']->value)) >= 1) {
echo (($tmp = @$_smarty_tpl->tpl_vars['mandate_manage_expense_fields']->value[$_smarty_tpl->tpl_vars['additionalAttributes']->value[0]])===null||$tmp==='' ? '-' : $tmp);
}?>
                                                                <?php if ((count($_smarty_tpl->tpl_vars['additionalAttributes']->value)) > 1) {?><span style="cursor:pointer;" class="badge badge-secondary"><?php echo count($_smarty_tpl->tpl_vars['additionalAttributes']->value);?>
</span><?php }?>
                                                            </a>
                                                        </span>
                                                        <span class="trp_status col-xs-1">
                                                            <?php if ($_smarty_tpl->tpl_vars['row']->value->activeFlag == 1) {?>
                                                                <span class="label label-success" id="trp-lb-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
">Active</span>
                                                            <?php } else { ?>
                                                                <span class="label label-danger" id="trp-lb-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
">Disabled</span>    
                                                            <?php }?>    
                                                        </span>
                                                        <span  class="trp_action col-xs-2">
                                                            <div class="btn-group btn-group-xs">
                                                                
                                                                    <a href="javascript:;" class="btn btn-default btn-sm"   onclick="editTripHeadStatus('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', this)" data-transmode="<?php echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->code;?>
">

                                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->activeFlag == 1) {?>
                                                                            <i class="fa fa-times" id="trp-stu-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-status="0" title="Click to disable"></i>
                                                                        <?php } else { ?>
                                                                            <i class="fa fa-check" id="trp-stu-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-status="1" title="Click to enable"></i>
                                                                        <?php }?> 

                                                                    </a>
                                                                    
                                                                        <a href="javascript:;" class="btn btn-default btn-sm <?php if ($_smarty_tpl->tpl_vars['row']->value->activeFlag == 0) {?>none<?php }?>" title="Edit" id='tph_edt_<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
'  onclick='editTripHead("<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
")'><i class="fa fa-pencil igreen"></i></a>
                                                                    
                                                                    
                                                                    
                                                                        <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"   onclick="deleteTripHead('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
', this)" data-transmode="<?php echo $_smarty_tpl->tpl_vars['row']->value->transactionMode->code;?>
" ><i class="fa fa-trash-o ired"></i></a>
                                                                   
                                                                </div>
                                                            </span>
                                                        </li> 
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                        <?php } else { ?>
                                                                <li class="er_msg"><div class="well well-large "> No Trip Head Found!</div></li>
                                                        <?php }?>  
                                       </ul>
                                                            </div>
                                                            <div class="clear_fix_both"></div>
                                                            <div id="trip-head-dialog" class="hide dialog-content-page" >
                                                                <form role="form" class="form-horizontal">

                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label req" for="tph-name">Name</label>
                                                                        <div class="col-sm-7">
                                                                            <input type="text" placeholder="Name" id="tph-name" class="form-control">
                                                                        </div>
                                                                    </div>    
                                                                                                                                        <div class="form-group">
                                                                        <label for="t_mode" class="col-sm-3 control-label req">Transaction Mode</label>
                                                                        <div class="col-sm-7">
                                                                            <select id="t_mode" class="form-control">
                                                                                <option value="">Select Transaction Mode</option>
                                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactionMode']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
                                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value;?>
</option>
                                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                     <div class="form-group">
                                                                        <label class="col-sm-3 control-label req" for="tph_name">Credit or Debit</label>
                                                                        <div class="col-sm-7">
                                                                            <input type="checkbox" checked id="trp-cr-dr" class="bsn_switch" data-on-text="Credit" data-off-text="Debit">
                                                                        </div>
                                                                    </div> 

                                                                    <div class="form-group">
                                                                        <label for="trip_head_tags" class="col-sm-3 control-label">Tags</label>
                                                                        <div class="col-sm-7">
                                                                            <select id="trip_head_tags" class="form-control" multiple>
                                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['manage_expense_type']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
                                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value;?>
</option>
                                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                            </select>
                                                                        </div>
                                                                    </div> 

                                                                    <div class="form-group hide">
                                                                        <label for="trip_head_mandatory_fields" class="col-sm-3 control-label">Mandatory Fields</label>
                                                                        <div class="col-sm-7">
                                                                            <select id="trip_head_mandatory_fields" class="form-control" multiple>
                                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['mandate_manage_expense_fields']->value, 'value', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['value']->value) {
?>
                                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value;?>
</option>
                                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                            </select>
                                                                        </div>
                                                                    </div> 
                                                                   
                                                                     <input type="hidden" id="tph-code" class="form-control">
                                                                </form>
                                                                <div class="align-center pull-left" id="trip-head-action"></div>
                                                                <div class="align-right" id="trip-head-buttons">
                                                                    <button class="btn btn-success" type="button" onclick="saveTripHead()">Save</button>
                                                                    <button class="btn btn-default" type="button" onclick="closeTripHead()">Cancel</button>
                                                                </div>


                                                            </div>
                                                        </div><!--panel Body end-->
                                                    </div><!--panel end-->

                                                </div>

                                            </div><!--row end-->
                                        </div><!--content end-->
                                    </div>
                                </div>
                            </div>
                        </div>
<?php echo '<script'; ?>
>
    var triphead = <?php echo json_encode($_smarty_tpl->tpl_vars['data']->value);?>

    $('#trip_head_mandatory_fields').multiselect({
        maxHeight: 160,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default',
        templates: {
            ul: '<ul class="multiselect-container dropdown-menu" style="width: 100%;"></ul>',
            li: '<li><a><label style="white-space: normal;"></label></a></li>',
        }  
    });
    
    $('#trip_head_tags').multiselect({
        maxHeight: 160,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default',
        templates: {
            ul: '<ul class="multiselect-container dropdown-menu" style="width: 100%;"></ul>',
            li: '<li><a><label style="white-space: normal;"></label></a></li>',
        }  
    });

    $('a[id=popup_msg]').popover({
        container: "body",
        placement: 'right',
        html: true,
        trigger: 'hover',
    });

    $('#trip_head_tags').on('change', function() {
        $('#trip_head_mandatory_fields').closest('.form-group').addClass('hide');
        if ($.inArray('BRN', $(this).val()) != -1) {
            $('#trip_head_mandatory_fields').closest('.form-group').removeClass('hide');
        }
    });

    function _init_Trip_Page(){
        init_Trip_Page();
    }
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 id="template-trip-head-list" type="text/template">
    <li>
                <span class="trp_name col-xs-3"></span>
                <span class="trp_cr_dr_flag col-xs-3">Credit</span>
                <span class="trp_status col-xs-3">
                    <span class="label label-success" id="lb">Active</span>
                </span>
                <span  class="trp_action col-xs-3">
                    <div class="btn-group btn-group-xs">
                        <a href="javascript:;" class="btn btn-default btn-sm edsts" title="Status" onclick="editStatus()">
                            <i class="fa fa-times" id="trp-stu" data-status="0"  title="Click to disable"></i>
                        </a> 
                        <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick='editAmenities()'><i class="fa fa-pencil igreen"></i></a>
                        <a href="javascript:;" class="btn btn-default btn-sm delam" title="Delete" onclick="deleteAmenities()"><i class="fa fa-trash-o ired"></i></a>
                    </div>
                </span>
  </li> 
<?php echo '</script'; ?>
>
<?php }
}
