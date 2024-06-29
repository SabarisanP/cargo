<div class="brand_top"><h3>Income / Expense Heads</h3> <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="editTripHead();">Add New Head</a></span></div>
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
                                            {if count($data) > 0}
                                                {foreach name=o item=row from=$data} 

                                                    <li id="trp-{$row->code}"  >
                                                        <span class="trp_name col-xs-2">{$row->name}</span>
                                                        <span class="trp_cr_dr_flag col-xs-1">{if $row->transactionType=="Cr"}Credit{else}Debit{/if}</span>
                                                        <span class="trp_mode col-xs-2">{$row->transactionMode->name}</span>
                                                        <span class="trp_mode col-xs-2">
                                                            <a id="popup_msg"  data-content='<ul class="p_l_15">
                                                                    {foreach from=$row->tag item=tag}
                                                                        <li>{$manage_expense_type[$tag]}</li>
                                                                    {/foreach}
                                                                </ul>'>
                                                                {if ($row->tag|@count) >= 1}{$manage_expense_type[$row->tag[0]]}{else}-{/if}
                                                                {if ($row->tag|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$row->tag|@count}</span>{/if}
                                                            </a>
                                                        </span>
                                                        <span class="trp_mode col-xs-2">
                                                            {assign var="additionalAttributes" value=explode(',', $row->additionalAttributes)}
                                                            <a id="popup_msg"  data-content='<ul class="p_l_15">
                                                                    {foreach from=$additionalAttributes item=tag}
                                                                        <li>{$mandate_manage_expense_fields[$tag]}</li>
                                                                    {/foreach}
                                                                </ul>'>
                                                                {if ($additionalAttributes|@count) >= 1}{$mandate_manage_expense_fields[$additionalAttributes[0]]|default:'-'}{/if}
                                                                {if ($additionalAttributes|@count) > 1}<span style="cursor:pointer;" class="badge badge-secondary">{$additionalAttributes|@count}</span>{/if}
                                                            </a>
                                                        </span>
                                                        <span class="trp_status col-xs-1">
                                                            {if $row->activeFlag==1}
                                                                <span class="label label-success" id="trp-lb-{$row->code}">Active</span>
                                                            {else}
                                                                <span class="label label-danger" id="trp-lb-{$row->code}">Disabled</span>    
                                                            {/if}    
                                                        </span>
                                                        <span  class="trp_action col-xs-2">
                                                            <div class="btn-group btn-group-xs">
                                                                
                                                                    <a href="javascript:;" class="btn btn-default btn-sm"   onclick="editTripHeadStatus('{$row->code}', this)" data-transmode="{$row->transactionMode->code}">

                                                                        {if $row->activeFlag==1}
                                                                            <i class="fa fa-times" id="trp-stu-{$row->code}" data-status="0" title="Click to disable"></i>
                                                                        {else}
                                                                            <i class="fa fa-check" id="trp-stu-{$row->code}" data-status="1" title="Click to enable"></i>
                                                                        {/if} 

                                                                    </a>
                                                                    
                                                                        <a href="javascript:;" class="btn btn-default btn-sm {if $row->activeFlag==0}none{/if}" title="Edit" id='tph_edt_{$row->code}'  onclick='editTripHead("{$row->code}")'><i class="fa fa-pencil igreen"></i></a>
                                                                    
                                                                    
                                                                    
                                                                        <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"   onclick="deleteTripHead('{$row->code}', this)" data-transmode="{$row->transactionMode->code}" ><i class="fa fa-trash-o ired"></i></a>
                                                                   
                                                                </div>
                                                            </span>
                                                        </li> 
                                                        {/foreach}
                                                        {else}
                                                                <li class="er_msg"><div class="well well-large "> No Trip Head Found!</div></li>
                                                        {/if}  
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
                                                                    {* <div class="form-group">
                                                                        <label class="col-sm-3 control-label req" for="tph_name">Description</label>
                                                                        <div class="col-sm-7">
                                                                             <textarea id="tph-description" class="rs_no form-control"></textarea>
                                                                        </div>
                                                                    </div>  *}
                                                                    <div class="form-group">
                                                                        <label for="t_mode" class="col-sm-3 control-label req">Transaction Mode</label>
                                                                        <div class="col-sm-7">
                                                                            <select id="t_mode" class="form-control">
                                                                                <option value="">Select Transaction Mode</option>
                                                                                {foreach key=key item=value from=$transactionMode}
                                                                                    <option value="{$key}">{$value}</option>
                                                                                {/foreach}
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
                                                                                {foreach key=key item=value from=$manage_expense_type}
                                                                                    <option value="{$key}">{$value}</option>
                                                                                {/foreach}
                                                                            </select>
                                                                        </div>
                                                                    </div> 

                                                                    <div class="form-group hide">
                                                                        <label for="trip_head_mandatory_fields" class="col-sm-3 control-label">Mandatory Fields</label>
                                                                        <div class="col-sm-7">
                                                                            <select id="trip_head_mandatory_fields" class="form-control" multiple>
                                                                                {foreach key=key item=value from=$mandate_manage_expense_fields}
                                                                                    <option value="{$key}">{$value}</option>
                                                                                {/foreach}
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
<script>
    var triphead = {$data|json_encode}
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
</script>

<script id="template-trip-head-list" type="text/template">
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
</script>
