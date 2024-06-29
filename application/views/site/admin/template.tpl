<div class="brand_top"><h3>Template</h3>{if $action_rights['ADD-TEMP']>0}<span class="align-rights"><a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['ADD-TEMP']==1}onclick="addTemplate();"{/if}>Add Template</a></span>{/if}</div>
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
                                    <div class="col-md-12">
                                        <div class="col-md-offset-3 col-md-6 ">
                                            <ul class="user_list " id="user_list_search">
                                                <li class="hide amt-db"  >
                                                    <span class="sp_name col-xs-6"></span>
                                                    <!-- <span class="sp_status col-xs-3">
                                                         <span class="label label-success" id="lb">Active</span>
                                                     </span>-->
                                                    <span  class="sp_action col-xs-6">
                                                        <div class="btn-group btn-group-xs">
                                                            <!-- <a href="javascript:;" class="btn btn-default btn-sm edsts" title="Status" onclick="editTemplateStatus()">
                                                                 <i class="fa fa-times" id="sta" data-status="0"  title="Click to disable"></i>
                                                             </a>--> 
                                                            <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick='addTemplate()'><i class="fa fa-pencil igreen"></i></a>
                                                            <!-- <a href="javascript:;" class="btn btn-default btn-sm delam" title="Delete" onclick="deleteTemplate()"><i class="fa fa-trash-o ired"></i></a>
                                                            --></div>
                                                    </span>
                                                </li> 
                                                {if count($template) > 0}
                                                    {foreach name=o item=row from=$template} 

                                                        <li id="am-{$row->code}"  >
                                                            <span class="sp_name col-xs-6">{$row->name}</span>
                                                            <!--<span class="sp_status col-xs-3">
                                                            {if $row->activeFlag==1}
                                                                <span class="label label-success" id="lb-{$row->code}">Active</span>
                                                            {else}
                                                                <span class="label label-danger" id="lb-{$row->code}">Disabled</span>    
                                                            {/if}    
                                                        </span>-->
                                                            <span  class="sp_action col-xs-6">
                                                                <div class="btn-group btn-group-xs">
                                                                    <!--  {if $action_rights['DISABLE-TEMP']>0}
                                                                          <a href="javascript:;" class="btn btn-default btn-sm" {if $action_rights['DISABLE-TEMP']!=2}  onclick="editTemplateStatus('{$row->code}', '{$row->name}', '{$row->template}')"{/if}>
  
                                                                    {if $row->activeFlag==1}
                                                                        <i class="fa fa-times" id="sta-{$row->code}" data-status="0" title="Click to disable"></i>
                                                                    {else}
                                                                        <i class="fa fa-check" id="sta-{$row->code}" data-status="1" title="Click to enable"></i>
                                                                    {/if} 

                                                                </a> {/if}  -->
                                                                    {if $action_rights['EDIT-TEMP']>0}
                                                                        <a href="javascript:;" class="btn btn-default btn-sm {if $row->activeFlag==0}none{/if}" title="Edit" id='at_edt_{$row->code}' {if $action_rights['EDIT-TEMP']!=2} onclick='addTemplate({$row|@json_encode})'{/if}><i class="fa fa-pencil igreen"></i></a>
                                                                        {/if}
                                                                    <!--{if $action_rights['DELETE-TEMP']>0}
                                                                    <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"  {if $action_rights['DELETE-TEMP']!=2} onclick="deleteTemplate('{$row->code}', '{$row->name}', '{$row->template}')" {/if}><i class="fa fa-trash-o ired"></i></a>
                                                                    {/if}-->
                                                                    </div>
                                                                </span>
                                                            </li> 
                                                            {/foreach}
                                                                {else}
                                                                    <li class="er_msg"><div class="well well-large "> No Templates Found!</div></li>
                                                                        {/if}  
                                                                    </ul>
                                                                </div>
                                                                <div>

                                                                    <!-- template -->

                                                                    <div class="clear_fix_both"></div>

                                                                    <div id="template-dialog" class="hide dialog-content-page">
                                                                        <div class="">
                                                                            <form role="form" id="form1" class="form-horizontal ">

                                                                                <div class="col-lg-6 p_l_n">
                                                                                    <div>
                                                                                        <label for="txt_m_name" class="req">Code</label>
                                                                                        <div id="hd_temp"><select id="code" class="form-control col-md-6">
                                                                                                <option value="">Select</option>
                                                                                                <option value="TICKET-PDF">TICKET-PDF</option>
                                                                                                <option value="TICKET-EMAIL">TICKET-EMAIL</option>
                                                                                                <option value="CANCEL-EMAIL">CANCEL-EMAIL</option>
                                                                                            </select> </div>
                                                                                        <div id="hd_test"></div>

                                                                                    </div>
                                                                                </div>


                                                                                <div class="clear_fix_both"></div>
                                                                                <br />

                                                                                <div class="col-lg-6 p_l_n">
                                                                                    <div>
                                                                                        <label for="txt_m_name" class="req">Name</label>
                                                                                        <input  placeholder="Name" id="name" name="name"  class="form-control">
                                                                                    </div>
                                                                                </div> 



                                                                                <div class="clear_fix_both"></div>
                                                                                <br />    


                                                                                <div class="col-lg-12 p_l_n">
                                                                                    <div>
                                                                                        <label for="txt_m_name" class="req">Template</label>
                                                                                        <textarea  style="resize:none" placeholder="<html>...</html>" class="form-control" rows="8" cols="10" name="remark" id="template"></textarea>
                                                                                    </div>
                                                                                </div>


                                                                                <div class="clear_fix_both"></div>
                                                                            </form>
                                                                        </div>
                                                                        <input type='hidden' id='add'>
                                                                        <br>
                                                                        <div class="clear_fix_both"></div>
                                                                        <div class="clear_fix_both">                       
                                                                            <div class="alert fl" style="display: none;" id="template-action-state"></div>
                                                                            <div class="align-right cre_sve" id="form-bttons">
                                                                                <button class="btn btn-success" type="button" onclick="saveTemplate();">Save</button>
                                                                                <button class="btn btn-default" type="button" onclick="cancelTemplate();">Cancel</button>
                                                                            </div>
                                                                        </div> 
                                                                    </div>
                                                                    <!-- template end -->
                                                                </div><!--row end-->

                                                            </div><!--content end-->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div></div></div>
                            </div>
                            <div id="rpt_lst"></div>                                                 
                            {literal}
                                <script>

                                    function addTemplate(option) {

                                    $('.inp_error').removeClass('inp_error');
                                    $('#hd_test').html('');
                                    $('#name').val('');
                                    $('#code').val('');
                                    $('#template').val('');
                                    $('#template-action-state').removeClass('alert-success').removeClass('alert-danger');
                                    $('#template-action-state').hide();
                                    $('#template-dialog').css('background', '#fff');
                                    $('#template-dialog').removeClass('hide');
                                    $('#template-dialog').dialog({
                                    autoOpen: true,
                                    height: 500,
                                    width: 700,
                                    modal: true,
                                    resizable: false
                                    });
                                    $(".ui-dialog-titlebar").hide();

                                    $('#form-bttons').show();
                                    $('#template-action-state').html('');
                                    $('#template-action-state').hide();
                                    $('.inp_error').removeClass('inp_error');

                                    if (_isdefined(option)) {
                                    $('#add').val('');   
                                    $('#hd_temp').hide();
                                    $('#hd_test').html(option.code);
                                    var new_name = $('#am-' + option.code).find('.sp_name').html();
                                    $('#name').val(option.name);
                                    $('#code').val(option.code);
                                    $('#template').val(option.template);

                                    } else {
                                    $('#add').val(1);   

                                    $('#hd_temp').show();
                                    }

                                    }

                                    function saveTemplate() {
                                    var data = {};

                                    data.activeFlag = 1;
                                    data.name = $('#name').val();
                                    data.template = $('#template').val();
                                    data.code = $('#code').val();
                                    data.temp_disable = menu_permission['DISABLE-TEMP'];
                                    data.temp_edit = menu_permission['EDIT-TEMP'];
                                    data.temp_del = menu_permission['DELETE-TEMP'];

                                    var err = 0;
                                    if ($('#name').val() == '') {
                                    $('#name').addClass('inp_error');
                                    err++;
                                    } else {
                                    $('#name').removeClass('inp_error');
                                    }
                                    if ($('#code').val() == '') {
                                    $('#code').addClass('inp_error');
                                    err++;
                                    } else {
                                    $('#code').removeClass('inp_error');
                                    }
                                    if ($('#template').val() == '') {
                                    $('#template').addClass('inp_error');
                                    err++;
                                    } else {
                                    $('#template').removeClass('inp_error');
                                    }

                                    if (err > 0) {
                                    $('#template-action-state').removeClass('alert-success').addClass('alert-danger');
                                    $('#template-action-state').html('Please enter/select the values in the field that are marked in red');
                                    $('#template-action-state').show();
                                    return false;
                                    } else {
                                    $('#template-action-state').removeClass('alert-success').removeClass('alert-danger');
                                    $('#template-action-state').hide();
                                    }


                                    $('#form-bttons').hide();
                                    $('#template-action-state').removeClass('alert-danger').removeClass('alert-success');
                                    $('#template-action-state').html(loading_popup);
                                    $('#template-action-state').show();

                                    $.ajax({
                                    type: "POST",
                                    dataType: 'json',
                                    url: base_url + "config/add-template",
                                    data: data,
                                    success: function(response) {

                                    if (response.status == 1) {
                                    $('#form-bttons').hide();
                                    $('#template-action-state').removeClass('alert-danger');
                                    $('#template-action-state').addClass('alert-success');
                                    $('#template-action-state').html('Your request has been completed successfully');
                                    window.setTimeout(function() {
                                    cancelTemplate();

                                    if ($('#add').val() == 1) {
                                
                                    $('#new_template').val('');
                                    var li = $('li.amt-db').clone();
                                    li.attr('id', "am-" + response.data.code);
                                    li.find(".sp_name").html(response.data.name);//lb
                                    li.find("#lb").attr('id', "lb-" + response.data.code);
                                    li.find("#sta").attr('id', "sta-" + response.data.code);

                                    if (data.temp_disable > 0) {
                                    if (data.temp_disable == 1) {
                                    li.find(".edsts").attr('onclick', "editTemplateStatus('" + response.data.code + "', '" + response.data.name + "','" + response.data.template + "')");//lb
                                    } else {
                                    li.find(".edsts").attr('onclick', "");//lb    
                                    }
                                    }
                                    else {
                                    li.find(".edsts").hide();
                                    }

                                    if (data.temp_edit > 0) {
                                    if (data.temp_edit == 1) {
                                    li.find(".edat").attr('onclick', "addTemplate({\"code\":\"" + response.data.code + "\",\"name\":\"" + response.data.name + "\",\"activeFlag\":" + response.data.activeFlag + "})");
                                    li.find(".edat").attr('id', "at_edt_" + response.data.code);
                                    } else {
                                    li.find(".edat").attr('onclick', "");
                                    li.find(".edat").attr('id', "at_edt_" + response.data.code);
                                    }
                                    }
                                    else {
                                    li.find(".edat").hide();
                                    }
                                    if (data.temp_del > 0) {
                                    if (data.temp_del == 1) {
                                    li.find(".delam").attr('onclick', "deleteTemplate('" + response.data.code + "', '" + response.data.name + "','" + response.data.template + "')");//lb
                                    } else {
                                    li.find(".delam").attr('onclick', "");//lb  
                                    }
                                    }
                                    else {
                                    li.find(".delam").hide();//lb  
                                    }
                                    li.removeClass('hide amt-db');
                                    $('#user_list_search').append(li);
                                    }
                                    }, 3000);
                                    } else {
                                    $('#template-action-state').addClass('alert-danger');
                                    $('#template-action-state').html(response.errorDesc);
                                    $('#form-bttons').show();
                                    }
                                    }
                                    })
                                    }

                                    function cancelTemplate() {
                                    $('#template-dialog').dialog('destroy');
                                    $('#template-dialog').hide();

                                    }

                                    function editTemplateStatus(am_code, am_name, am_temp) {
                                    var data = {};
                                    data.code = am_code;
                                    data.name = am_name;
                                    data.template = am_temp;
                                    data.activeFlag = $('#sta-' + am_code).attr('data-status');
                                    var loading_overlay = iosOverlay({
                                    text: "Loading",
                                    icon: "fa fa-spinner fa-spin"
                                    });
                                    $.ajax({
                                    type: "POST",
                                    dataType: 'json',
                                    url: base_url + "config/add-template",
                                    data: data,
                                    success: function(response) {
                                    if (response.status == 1) {
                                    var chg = data.activeFlag == 1 ? 0 : 1;
                                    $('#sta-' + am_code).attr('data-status', chg);
                                    if ($('#sta-' + am_code).attr('data-status') == 1) {
                                    $('#at_edt_' + am_code).hide();
                                    $('#sta-' + am_code).removeClass('fa-times').addClass('fa-check');
                                    $('#lb-' + am_code).removeClass('label-success').addClass('label-danger').html('Disabled');

                                    } else {
                                    $('#at_edt_' + am_code).show();
                                    $('#sta-' + am_code).removeClass('fa-times').addClass('fa-times');
                                    $('#lb-' + am_code).removeClass('label-danger').addClass('label-success').html('Active');

                                    }
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
                                    window.setTimeout(function() {
                                    loading_overlay.hide();
                                    }, 2000);
                                    }
                                    })
                                    }


                                    function deleteTemplate(am_code, am_name, am_temp) {
                                    if (confirm('Do you want to delete this template?')) {
                                    var data = {};
                                    data.code = am_code;
                                    data.name = am_name;
                                    data.template = am_temp
                                    var loading_overlay = iosOverlay({
                                    text: "Loading",
                                    icon: "fa fa-spinner fa-spin"
                                    });
                                    $.ajax({
                                    type: "POST",
                                    dataType: 'json',
                                    url: base_url + "config/delete-template",
                                    data: data,
                                    success: function(response) {
                                    if (response.status == 1) {
                                    $('#am-' + am_code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                                    $(this).remove()
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
                                    window.setTimeout(function() {
                                    loading_overlay.hide();
                                    }, 2000);
                                    }
                                    })
                                    }
                                    }


                                </script>
                            {/literal}