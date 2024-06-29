<div class="brand_top">
    <h3>Namespace Privilege</h3> 
</div>
<div id="main_wrapper">

    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-md-3">
                            <div class="panel panel-default">

                                <div class="panel-body">

                                    <div id="user-result-panel">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="align-center" id="user-action-status"></div>
                                                <div id="user-address-book" class="col-md-12">
                                                    <ul class="user_list" id="usr_lst_ul">

                                                        {if count($users) > 0}
                                                            <div class="well well-sm">
                                                                <input type="text" class="form-control" placeholder="Find User..." id="list_search" >
                                                            </div>  
                                                            <div class="user_list_action bt_27">
                                                                <ul class="user_list " id="user_list_search">
                                                                    <div id="usr_scroll">
                                                                        {foreach name=ow key=ugrpname item=ugroup from=$users} 
                                                                            <li class="rt_8">
                                                                                <div class="bold">
                                                                                    {$ugrpname}
                                                                                </div>
                                                                            </li>
                                                                            {foreach name=o item=row from=$ugroup} 
                                                                                <li id="usr-{$row->code}">
                                                                                    <div class="" style="padding-left:10px;">
                                                                                        <a href="javascript:;" id="usr-viw-{$row->code}" onclick="userNamespacePrivilage('{$row->code}','{$row->name}')" data-toggle="tooltip"  title="Click to view user Namespace Privilage">
                                                                                            {$row->name}
                                                                                        </a>
                                                                                    </div>
                                                                                </li>
                                                                            {/foreach}

                                                                        {/foreach}
                                                                    </div>
                                                                </ul>
                                                            </div>
                                                        {else}
                                                            <li class="er_msg"><div class="well well-large "> No user found!</div></li>
                                                            {/if}   
                                                    </ul>

                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="menupermissions">
                                        <div class="container ">
                                            <div class="row">
                                                <div id="permission" >                                                           
                                                    <div class="heading_b" id='per-info'>Namespace Permissions</div>

                                                    <div class="row" id="user-permissions">
                                                        <div class="well text-center">
                                                            Please select an user in left panel to view namespace permission settings.
                                                        </div>    
                                                    </div>      
                                                    
                                                </div>    
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> 
                        


<script>
    var namespaces = {$namespaces|json_encode}
    $("#usr_scroll").css({
        'max-height': '350px',
    }).perfectScrollbar({
        wheelSpeed: 20,
        wheelPropagation: false
    });
    $('input#list_search').quicksearch('#user_list_search #usr_scroll > li');
    {literal}
    function userNamespacePrivilage(code,name){
        $('#user-permissions').html('<div align="left">' + loading_small + '</div>');
        $('#per-info').html('Namespace Permissions for <b>'+name+'</b>');
        var data={}
        data.code = code;
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/get-user-namespace-privilege",
            data: data,
            success: function(response) {
                $('#user-permissions').html('');
                if(response.status == '1'){
                    var selected = [];
                    $.each(response.data, function(i, sct) {
                        selected.push(sct.code);
                    });
                    $.each(namespaces, function(i, nsp) {
                        if(selected.includes(nsp.code)){
                            $('#user-permissions').append('<div class="col-xs-4"><label class="checkbox-inline nsp-list"><input type="checkbox" value="'+nsp.code+'" data-parent="" onchange="setUserPrivilage(\''+code+'\',\''+nsp.code+'\')" checked>&nbsp;'+nsp.name+'</label></div>');
                        } else {
                            $('#user-permissions').append('<div class="col-xs-4"><label class="checkbox-inline nsp-list"><input type="checkbox" value="'+nsp.code+'" data-parent="" onchange="setUserPrivilage(\''+code+'\',\''+nsp.code+'\')">&nbsp;'+nsp.name+'</label></div>');
                        }
                    });
                } 
            }
        });
    }
    function setUserPrivilage(userCode,namespaceCode){
        var data={};
        data.code = userCode;
        data.namespaceCode = namespaceCode;
        
        if($('input[value="'+namespaceCode+'"]').is(":checked")){
            data.action = "add";            
        } else {
            data.action = "delete";
        }
        
        var loading_overlay = iosOverlay({
            text: "Updating...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/save-user-namespace-privilege",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        return;
                    }, 2000);
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
        });
    }
    {/literal}
</script>

<style>
.nsp-list{
    padding: 0px!important;
    margin: 5px 0px!important; 
}    
.nsp-list > input{
    margin: 3px!important; 
    padding: 0px!important;
}  
</style>