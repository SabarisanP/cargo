<h4>Branch - <span id="stat_title"></span>
    <div class="fr">
        <span class="sp_action">
            {if $org->latitude != '0'}
                <a title="Map" class="btn btn-default btn-sm" id='station-map-{$org->code}'  href="https://maps.google.com/?q={$org->latitude},{$org->longitude}" target="_blank"><i class="fa fa-map-marker" aria-hidden="true"></i></a>
            {/if}
            <a title="User" class="btn btn-default btn-sm" id='og_user_{$org->code}'  href="javascript:;" onclick='userOrganizationDialog({$org|json_encode|escape})'><i class="fa fa-user" aria-hidden="true"></i></a>
        </span>
        <span class="">
            {if $action_rights['ORG-DISABLE']>0} 
                <a href="javascript:;" class="btn btn-default btn-sm est"  {if $action_rights['ORG-DISABLE']!=2}onclick='editStatusOrganization({$org|json_encode|escape}, this)'{/if} data-status="{$org->activeFlag}">
                    {if $org->activeFlag ==1}
                        <i class="fa fa-times" title="Click to disable"></i>
                    {else}
                        <i class="fa fa-check" title="Click to enable"></i>
                    {/if}
                </a>
            {/if}
            {if $action_rights['ORG-EDIT']>0} 
            <a href="javascript:;" title="edit" id='og_edt_{$org->code}' {if $org->activeFlag ==0}style='display:none'{/if} class="btn btn-default btn-sm edat" {if $action_rights['ORG-EDIT']!=2}onclick='editOrganization({$org|json_encode|escape})'{/if}><i class="fa fa fa-pencil igreen"></i></a>
            {/if}
            {if $action_rights['ORG-DELETE']>0}
                <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" {if $action_rights['ORG-DELETE']!=2}onclick="deleteOrganization('{$org->code}', '{$org->name}')"{/if}><i class="fa fa-trash-o ired"></i></a>
            {/if}
        </span>
    </div>
</h4>
<div class="clear_fix_both"></div><br />
<div class='responsive-table1'>
    <div class='table-responsive'>
        <table id="datatable2" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover org-det-table" >
            <thead>
                <tr>
                    <th class="pth">Station</th>
                    <th class="pth">Address</th>
                    <th class="pth">Contact</th>
                    <th class="pth">Booking payment type</th>
                    <th class="pth">Delivery Payment Type</th>
                    <th class="lat">Hub Flag</th>
                    <th class="lad">Primary User</th>
                    <th class="mno">Tags</th>
                    <th nowrap>Transit Close Time</th>
                </tr>
            </thead>
            <tbody>
                <tr id="sp-{$org->code}">
                    <td class="sp_no">{$org->station->name}</td>

                    <td class="sp_name" style="text-overflow: ellipsis;">
                        {$org->address1}{if $org->address2}{','}{$org->address2}{/if}{if $org->pincode}{' - '}{$org->pincode}{/if}
                    </td>

                    <td class="sp_no">{$org->contact}</td>
                    <td class="sp_no">
                    <a id="popup_msg" 
                        data-content='<ul class="p_l_15">
                        {foreach from=$bookingPaymentTypeList item=desc}
                            <li>{$desc->name|replace:"'":'"'}</li>
                        {/foreach}
                        </ul>'>
                        {if $bookingPaymentTypeList}
                            {foreach from=$bookingPaymentTypeList item=desc}
                                {$desc->name}
                                {break}
                            {/foreach}
                            <span class="badge badge-info">{$bookingPaymentTypeList|@count}</span>
                        {else}
                            -
                        {/if}
                    </a>
                </td>
                <td class="sp_no">
                    <a id="popup_msg" 
                        data-content='<ul class="p_l_15">
                        {foreach from=$deliveryPaymentTypeList item=desc}
                            <li>{$desc->name|replace:"'":'"'}</li>
                        {/foreach}
                        </ul>'>
                        {if $deliveryPaymentTypeList}
                            {foreach from=$deliveryPaymentTypeList item=desc}
                                {$desc->name}
                                {break}
                            {/foreach}
                            <span class="badge badge-info">{$deliveryPaymentTypeList|@count}</span>
                        {else}
                            -
                        {/if}
                    </a>
                </td>
                    <td class="sp_lat">
                        {if $org->hubFlag == 'true'}
                            <span class="badge badge-success">Yes</span>
                        {else}
                            -
                        {/if}
                    </td>

                    <td class="sp_lad">
                        {if $org->user->name}
                            {$org->user->name}
                        {else}
                            -
                        {/if}
                    </td>
                    <td class="sp_mno nowrap">
                        <a id="popup_msg" 
                            data-content='<ul class="p_l_15">
                            {foreach from=$org->tag item=desc}
                                <li>{$desc->name|replace:"'":'"'}</li>
                            {/foreach}
                            </ul>'>
                            {if $org->tag}
                                {foreach from=$org->tag item=desc}
                                    {$desc->name}
                                    {break}
                                {/foreach}
                                <span class="badge badge-info">{$org->tag|@count}</span>
                            {else}
                                -
                            {/if}
                        </a>
                    </td> 
                    <td align="center">
                        {if $org->transitCloseMinutes >= 0}
                            {date('g:i A', mktime(0, $org->transitCloseMinutes))}
                        {else}
                            -
                        {/if}
                    </td>
                </tr> 
            </tbody>
        </table>
    </div>
</div>

<div class="clear_fix_both"></div><br />
<h4>Payment Preference
    <div class="fr">
        {if !$pay_pref}
            <a href="javascript:;" title="Add" id='add-pay-pref' class="btn btn-default btn-sm" onclick='addPaymentPreference()'><i class="fa fa fa-plus igreen"></i></a>
        {/if}
        {if $pay_pref}
            <a href="javascript:;" title="edit" id='edit-pay-pref' {if $org->activeFlag ==0}style='display:none'{/if} class="btn btn-default btn-sm" {if $action_rights['ORG-EDIT']!=2}onclick='addPaymentPreference({$pay_pref|json_encode|escape})'{/if}><i class="fa fa fa-pencil igreen"></i></a>
        {/if}
        <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" {if $action_rights['ORG-DELETE']!=2}onclick="deletePaymentPreference({$pay_pref|json_encode|escape})"{/if}><i class="fa fa-trash-o ired"></i></a>
    </div>
</h4>
<div class="clear_fix_both"></div><br />
<div class='responsive-table1'>
    <div class='table-responsive'>
        <table id="datatable2" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover branch-pay-pref-table" >
            <thead>
                <tr>
                    <th class="pth">From Organization</th>
                    <th class="pth">To Organization</th>
                </tr>
            </thead>
            <tbody>
                <tr id="sp-{$pay_pref->code}">
                    <td class="sp_no">{$pay_pref->fromOrganization->name} - {$pay_pref->fromOrganization->station->name}</td>
                    <td class="sp_mno">
                        <a id="popup_msg" 
                            data-content='<ul class="p_l_15">
                            {foreach from=$pay_pref->toOrganizationList item=desc}
                                <li>{$desc->name|replace:"'":'"'} - {$desc->station->name}</li>
                            {/foreach}
                            </ul>'>
                            {if $pay_pref}
                                {if $pay_pref->toOrganizationList}
                                    {foreach from=$pay_pref->toOrganizationList item=desc}
                                        {$desc->name} - {$desc->station->name}
                                        {break}
                                    {/foreach}
                                    <span class="badge badge-info">{$pay_pref->toOrganizationList|@count}</span>
                                {else}
                                    All
                                {/if}
                            {else}
                                -
                            {/if}
                        </a>
                    </td> 
                </tr> 
            </tbody>
        </table>
    </div>
</div>

<div class="clear_fix_both"></div><br />
<h4>
    Other Details
    <div class="fr">
        {if !$org_dimension->dimensions}
            <a href="javascript:;" title="Add Details" id='add-dimension' class="btn btn-default btn-xs" onclick="addOrganizationDimension('{$org->code}')"><i class="fa fa fa-plus igreen"></i></a>
        {else}
            <a href="javascript:;" title="Edit Details" id='edit-dimension' class="btn btn-default btn-xs" onclick='editOrganizationDimension({$org_dimension|json_encode|escape})'><i class="fa fa fa-pencil igreen"></i></a>
        {/if}
    </div>
</h4>
<div class="clear_fix_both"></div>
<div class="row">
    <div class="col-md-6" id="branch-view-files">
        <h5 class="">Branch Photos / Docs</h5>
        {include file="site/cargo/file-upload-component.tpl" id="ie-fileupload" axis="horizontal"}
        <button type="button" class="btn btn-success hide" id="org-upload-btn" onclick="saveOrganizationDocuments('{$org->code}');">Upload</button>
    </div>
    <div class="col-md-6">
        <h5 class="">
            Bank Details
        </h5>
        <div class="clear_fix_both"></div>
        <div id="org_bank"></div>
        <br>
        <h5 class="">
            Dimension &nbsp;<span class="badge badge-pill" style="background: #c3c1c1;">In Feet</span> 
        </h5>
        <div class="clear_fix_both"></div>
        <div class="table table-responsive">
            <table class="datatable table table-striped table-bordered table-hover org-det-table">
                <thead>
                    <tr>
                        <th>Length</th>
                        <th>Width</th>
                        <th>Height</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="branch-dimension">
                        <td id="org_length"></td>
                        <td id="org_breadth"></td>
                        <td id="org_height"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="clear_fix_both"></div><br />
<h4>Branch Staff
    <div class="fr">
        <a href="javascript:;" title="Add" class="btn btn-default btn-sm del" onclick="addBranchContactsDialog()"><i class="fa fa-plus igreen"></i></a>
    </div>
</h4>
<div class="clear_fix_both"></div><br />
<div class='responsive-table1'>
    <div class='table-responsive'>
        <table id="datatable2" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover branch-staff-table" >
            <thead>
                <tr>
                    <th>Employee Code</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Category</th>
                    <th>Mobile Number</th>
                    <th>Alt Mobile Number</th>
                    <th>Qualification</th>
                    <th>Language</th>
                    <th>POB <i class="fa fa-info-circle" title="Place Of Birth"></i></th>
                    <th>Address</th>
                    <th>Remark</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$brn_con item=brn key=k}
                    {$pob = ''}
                    {foreach from=$states item=val}
                        {if $val->code == $brn->placeOfBirth}
                            {$pob = $val->name}
                        {/if}
                    {/foreach}
                    <tr>
                        <td width="9%">{$brn->aliasCode}</td>
                        <td width="8%">{$brn->name}</td>
                        <td width="2%">{$brn->age}</td>
                        <td width="6%">{$brn->category->name}</td>
                        <td width="14%">{$brn->mobile}</td>
                        <td width="14%">{$brn->alternateMobile}</td>
                        <td width="6%">{$brn->qualification}</td>
                        <td width="8%">{$brn->languages}</td>
                        <td width="10%">
                            {if $pob != ''}
                                {$pob}
                            {else}
                                {$p_o_b = explode("-",$brn->placeOfBirth)}
                                {$p_o_b[1]}
                            {/if}
                        </td>
                        <td width="12%">{$brn->address}</td>
                        <td width="7%">{$brn->remarks}</td>
                        <td width="4%">
                            <span>
                                <a href="javascript:;" title="edit" class="brn-con-edit" onclick='addBranchContactsDialog({$brn|@json_encode})' ><i class="fa fa fa-pencil fa-lg igreen"></i></a>
                            </span>
                            
                            <span>
                                <a href="javascript:;" title="delete" class="brn-con-delete"  onclick='deleteBranchContact({$brn|@json_encode})'><i class="fa fa-trash-o fa-lg ired"></i></a>
                            </span>
                        </td>
                    </tr>
                    {foreachelse}
                        <tr>
                            <td align="center" colspan="12">No Data Found !!!</td>
                        </tr> 
                {/foreach}
            </tbody>
        </table>
    </div>
</div>


<div id="user-organization-dialog" class="hide dialog-content-page">
    <h4>Users {if $action_rights['ORG-ADD-USER']>0} <a href="javascript:;" title="Add user" class="btn btn-success pull-right" {if $action_rights['ORG-ADD-USER']!=2}onclick="allUserOrganizations('{$org->code}')" {/if}>Add User</a>{/if}</h4>
    <div class="clear_fix_both b_b"></div>
    {if count($user) > 0}
        <div id="org_scroll">
            <ul class="user_list rmv-tp-br"
                id="org_usr">
                {foreach name=o item=usr from=$user}
                    <li class="p_l_n p_r_n"
                        id="usr_{$usr->code}">
                        <div class="pull-left">{$usr->name}
                        </div>
                        {if $action_rights['ORG-CHANGE-MAP']>0}
                            <div class="pull-right">
                                <a title="Change organization" href="javascript:;" class="btn btn-default btn-xs" {if $action_rights['ORG-CHANGE-MAP']!=2}onclick="organtaionDialogUser('{$usr->code}', '{$org->code}', 'org')" {/if}><i class="fa fa-pencil"></i></a>
                            </div>
                        {/if}
                    </li>
                    {$usr_det="`$usr_det`,`$usr->code`"}
                {/foreach}
            </ul>

            <input type="hidden" id="alr_usr_{$org->code}" value="{$usr_det}" />
        </div>
    {else}
        <div class="well well-large "> No user available .</div>
    {/if}
    <div class="clear_fix_both"> <br />
    <div class="align-right" id="user-organization-bttons">
        <button class="btn btn-default" type="button" onclick="cancelUserOrganizationDialog();">Cancel</button>
    </div>
</div>

<script type="text/javascript">
    var fileupload = new fileUpload('#ie-fileupload');
    var dmsdomain = '{$dms_domain}';
    
    var dim = {$org_dimension|json_encode};
    if(dim.dimensions){
        var dimension = dim.dimensions.split('|');
        
        $('#org_breadth').text(dimension[1]);
        $('#org_length').text(dimension[0]);
        $('#org_height').text(dimension[2]);
    }else{
        $('.branch-dimension').html('<td colspan="3" align="center">No data found</td>')
    }

    if (dim.bankDetails) {
        var bank_detail = "";
        $.each(dim.bankDetails, function( key, value ) {
            bank_detail = bank_detail + '<li><b>'+value.bankName+', '+value.branchLocation+'</b><br><b>UPI:</b> '+value.upiId+'</li>'
        });
        $('#org_bank').html('<ol>'+bank_detail+'</ol>');
    } else {
        $('#org_bank').html('<div class="well well-sm m-0"> No bank details available!</div>');
    }

    $('.file-upload-buttons, #org-upload-btn').on('click', function(){
        $('.file-upload-gallery').on('DOMSubtreeModified', function(){
            if($('.file-upload-gallery .file-upload-file').length > 0){
                $('.file-upload-buttons').addClass('hide');
                $('#org-upload-btn').removeClass('hide');
            }else{
                $('.file-upload-buttons').removeClass('hide');
                $('#org-upload-btn').addClass('hide');
            }
        });
    });
    
    $(document).ready(function ($) {
        $("#org_scroll").css({
        'max-height': '220px',
        }).perfectScrollbar({
            wheelSpeed: 20,
            wheelPropagation: false
        });
    });
</script>

<script>
    $('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');
    $('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'hover');
    $('[data-toggle=popover]').popover({
        container: "body",
        html: true
    });
</script>