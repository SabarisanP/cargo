<div class="brand_top"><h3>Registered Account Customer</h3>
<div class="align-right " id="">
{if $action_rights['DOWNLOAD-EXCEL']}
    <button class="btn btn-default" onclick="exportCustomersExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>&nbsp;
{/if}
<span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="cargoVendorDialog();">Add RAC</a></span>
</div>
</div>
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
                                    <div class="input-group table_filters pull-right" style="width: 25%;">
                                        <input type="search" class="form-control search-box" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
                                        <span class="input-group-addon point_cur" id="search-btn">
                                            <i class="fa fa-search"></i>
                                        </span>
                                    </div>
                                    <div class="table-responsive">
                                       <table id="cargo_vendor_table" class="table table-bordered table-hover" width="100%">
                                            <thead>
                                                <tr class="success">
                                                    <th>#</th>
                                                    <th width="17%">Company Name</th>
                                                    <th width="17%">Contact Person</th>
                                                    <th>Mobile Number</th>
                                                    <th>Email</th>
                                                    <th>City</th>
                                                    <th>Vendor Branch</th>
                                                    <th>GST</th>
                                                    <th>Organization</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                {foreach item=row from=$vendors key=k}
                                                    <tr id='item_{$row->code}' class="point_cur" onclick="view('{$row->code}')">
                                                        <td>{$k+1}</td>
                                                        <td>
                                                            {if $row->shortCode !='NA'}
                                                                {$row->companyName}&nbsp;({$row->shortCode})<br>
                                                                <small class="text-muted">{$row->aliasCode}</small>
                                                            {else}
                                                                {$row->companyName}<br>
                                                                <small class="text-muted">{$row->aliasCode}</small>
                                                            {/if}
                                                        </td>
                                                        <td>{$row->name}</td>
                                                        <td>{$row->mobileNumber}</td>
                                                        <td>
                                                            {$row->email}
                                                            {if $row->emailVerifiedFlag == 1}
                                                                <br><span class="label label-success">Verified</span>
                                                            {else}
                                                                <br><span class="label label-warning">Yet to Verify</span>&nbsp;
                                                                <a href="javascript:;" class="email-verify-link" onclick="sendVendorVerifyEmail('{$row->code}', '{$row->email}')"><b>Verify</b></a>
                                                            {/if}
                                                        </td>
                                                        <td>{$row->station->name}</td>
                                                        <td>{$row->responsibleOrganization->name}</td>
                                                        <td>{$row->gst}</td>
                                                        <td>
                                                            <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                {foreach from=$row->organization item=desc}
                                                                    <li>{$desc->name|replace:"'":'"'}</li>
                                                                {/foreach}
                                                                </ul>'>
                                                                {if $row->organization}
                                                                    {foreach from=$row->organization item=desc}
                                                                        {$desc->name}
                                                                        {break}
                                                                    {/foreach}
                                                                    <span class="badge badge-info">{$row->organization|@count}</span>
                                                                {else}
                                                                    All Branch
                                                                {/if}
                                                            </a>
                                                        </td>
                                                        <td align="center" width="150px" class="no-wrap">
                                                            <span {if $row->emailVerifiedFlag != 1}data-toggle="tooltip" title="Email Not Verified"{/if}>
                                                            <a href="javascript:;" class="btn btn-default btn-xs" {if $row->emailVerifiedFlag == 1}title="Reset Password" onclick="showVendorPassword('{$row->code}')" {else} data-toggle="tooltip" title="Email Not Verified"  disabled {/if}><i class="fa fa-lock igreen"></i></a>&emsp;
                                                            </span>
                                                            
                                                            <div class="btn-group">
	                                                            {if $row->activeFlag ==1}
	                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Disable" onclick='disableCargoVendor("{$row->code}")'><i class="fa fa-times ired"></i></a>
	                                                            {else}
	                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Disable" onclick='disableCargoVendor("{$row->code}")'><i class="fa fa-check ired"></i></a>
	                                                            {/if}
	                                                            {if $native_namespace == 'bits' || $native_namespace == 'aprbits' || $native_namespace == 'evacaybits'}
	                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick='deleteCargoVendor("{$row->code}")'><i class="fa fa-trash-o ired"></i></a>
	                                                            {/if}
	                                                            {if $row->activeFlag ==1}
	                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick='cargoVendorDialog("{$row->code}")'><i class="fa fa-pencil igreen"></i></a>
	                                                            {/if}
                                                            </div>
                                                        </td>
                                                    </tr>
                                                <div id="notify_mes_{$row->code}" style="display:none">{$row->description}</div>
                                                {/foreach}
                                           </tbody>
                                           <tfoot>
                                                <tr class="none p_t_n" id="cargo-vendor-tabs">
                                                    <td colspan="10">
                                                        <div >
                                                            <div class="text-right">
                                                                <a href="javascript:;"class="none" id="cancel-view" type="button" onclick="cancelView();"><i class="fa fa-times-circle fa-2x"></i></a>
                                                            </div>
                                                            <ul class="nav nav-tabs" >
                                                                <li class="active"><a data-toggle="tab" id="ven-rem-det" href="#remaining-details">Remaining Details</a></li>
                                                                <li><a data-toggle="tab" id="ven-tariff" href="#tariff">Tariff</a></li>
                                                                <li><a data-toggle="tab" id="ven-address" href="#address">Address</a></li>
                                                            </ul>
                                                            <div class="tab-content">
                                                                <div id="remaining-details" class="tab-pane fade in active">
                                                                    <div class="table table-responsive">
                                                                        <table class="table border-0" id="vendor-info-table">
                                                                            <tbody>
                                                                                <tr id="basic-dtl">
                                                                                    <th class="no-wrap valign-top" width="10%">Company Name</th>
                                                                                    <td class="com-name valign-top" width="15%"></td>
                                                                                    <th class="no-wrap valign-top" width="10%">Contact Person</th>
                                                                                    <td class="con-per valign-top" width="15%"></td>
                                                                                    <th class="no-wrap valign-top" width="10%">Mobile Number</th>
                                                                                    <td class="mob valign-top" width="15%"></td>
                                                                                    <th class="no-wrap valign-top" width="10%">Email</th>
                                                                                    <td class="email valign-top" width="15%"></td>
                                                                                </tr>
                                    
                                                                                <tr id="basic-dtl">
                                                                                    <th class="no-wrap valign-top" width="10%">Username</th>
                                                                                    <td class="usr-name valign-top" width="15%"></td>
                                                                                    <th class="no-wrap valign-top" width="10%">GST</th>
                                                                                    <td class="gst valign-top" width="15%"></td>
                                                                                    <th class="no-wrap valign-top" width="10%">L. Charges</th>
                                                                                    <td class="l-char valign-top" width="15%"></td>
                                                                                    <th class="no-wrap valign-top" width="10%">UL. Charges</th>
                                                                                    <td class="ul-char valign-top" width="15%"></td>
                                                                                </tr>
                                    
                                                                                <tr id="basic-dtl">
                                                                                    <th class="no-wrap valign-top">Address</th>
                                                                                    <td class="address valign-top" colspan="3"></td>
                                                                                    <th class="no-wrap valign-top">Vendor Branch</th>
                                                                                    <td class="ven_brn valign-top"></td>
                                                                                    <th class="no-wrap valign-top">Organization</th>
                                                                                    <td class="org valign-top"></td>
                                                                                </tr>
                                                                                <tr id="basic-dtl">
                                                                                    <th class="no-wrap valign-top">Credit Limit</th>
                                                                                    <td class="credit-limit valign-top"></td>
                                                                                    <th class="no-wrap valign-top">Invoice Due Days</th>
                                                                                    <td class="inv-due-days valign-top"></td>
                                                                                    <th class="no-wrap valign-top">Settlement Due Days</th>
                                                                                    <td class="set-due-days valign-top"></td>
                                                                                    <th class="no-wrap valign-top">Vendor Category</th>
                                                                                    <td class="vendor-category valign-top"></td>
                                                                                </tr>
                                                                                <tr id="basic-dtl">
                                                                                    <th class="no-wrap valign-top">Notes</th>
                                                                                    <td class="vendor-notes valign-top" colspan="7"></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                                <div id="tariff" class="tab-pane fade">
                                                                    <span class="table_filters align-right">
                                                                        <button class="btn btn-success btn-sm" id="add-tariff-btn" onclick="cargoTariffDialog();">Add Tariff</button>
                                                                    </span>
                                                                    <div class="table table-responsive" id="tariff-details"></div>
                                                                </div>
                                                                <div id="address" class="tab-pane fade">
                                                                    <span class="table_filters align-right">
                                                                        <button class="btn btn-success btn-sm" id="add-address-btn" onclick="vendorAddressDialog();">Add Address</button>
                                                                    </span>
                                                                    <div class="clear_fix_both"></div>
                                                                    <div id="address-details"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                           </tfoot>
                                        </table>
                                    </div>
                                </div>
                                <div class="clear_fix_both"></div>
                                <div id="cargo-vendor-dialog" class="hide dialog-content-page">
                                    <form role="form">
                                        <div class="col-lg-8 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_company" class="req">Company Name</label>
                                                <input  placeholder="Company Name" id="vendor_company" value="" class="form-control" maxlength="120">
                                            </div>
                                        </div> 
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_short_code">Short Code</label>
                                                <input placeholder="Short Code" id="vendor_short_code" value="" class="form-control" maxlength="5">
                                            </div>
                                        </div>
                                        <div class="clear_fix_both"></div>
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_name" class="req">Contact Person</label>
                                                <input placeholder="Name" id="vendor_name" value="" class="form-control" maxlength="120">
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_mob" class="req">Mobile Number</label>
                                                <input placeholder="Mobile No" id="vendor_mob"  value="" class="form-control" maxlength="10">
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_email" class="req">Email</label>
                                                <input placeholder="Email" id="vendor_email" value="" class="form-control">
                                                <small class="text-muted no-wrap"><i class="fa fa-info-circle"></i> Verification mail will be send to this Email-ID</small>
                                            </div>
                                        </div>   
                                        <div class="clear_fix_both"></div>

                                        <div class="form-group col-lg-12 p_l_n" id="select-vendor-address">
                                            <label class="req" for="vendor_address">Address
                                                <a class="pull-right" href="javascript:;" onclick="addNewVendorAddress()">Add New Billing Address</a>
                                            </label>
                                            <input type="text" class="form-control" id="vendor_address" placeholder="Address">
                                        </div>
                                        <div class="well well-sm col-lg-12 none" id="vendor-new-address">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="form-group">
                                                        <label for="vendor_address_name" class="req">Name
                                                        <a class="pull-right" href="javascript:;" onclick="closeNewVendorAddress()" id="close-add-address">Choose Billing Address</a>
                                                        </label>
                                                        <input  placeholder="Name" id="vendor_address_name" value="" class="form-control">
                                                    </div>
                                                </div>   
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label for="vendor_addr1" class="req">Address 1</label>
                                                        <input  placeholder="Address 1" id="vendor_addr1" value="" class="form-control">
                                                    </div>
                                                </div>                                         
                                                <div class="col-lg-6 p_l_n">
                                                    <div class="form-group">
                                                        <label for="vendor_addr2" class="req">Address 2</label>
                                                        <input  placeholder="Address 2" id="vendor_addr2" value="" class="form-control">
                                                    </div>
                                                </div> 
                                                <div class="col-lg-4">
                                                    <div class="form-group">
                                                        <label for="vendor_pincode" class="req">Pincode</label>
                                                        <input  placeholder="Pincode" id="vendor_pincode" value="" class="form-control" maxlength="6">
                                                    </div>
                                                </div>                                         
                                                <div class="col-lg-4 p_l_n">
                                                    <div class="form-group">
                                                        <label for="vendor_landmark" class="req">Landmark</label>
                                                        <input  placeholder="Landmark" id="vendor_landmark" value="" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="col-lg-4 p_l_n">
                                                    <div class="form-group">
                                                        <label for="vendor_station" class="req">City</label>
                                                        <select id="vendor_station" class="form-control" >
                                                            <option value=''>Select City</option>
                                                            {foreach item=station from=$stations}
                                                                <option value="{$station.code}">{$station.name}</option>
                                                            {/foreach}
                                                        </select>      
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="clear_fix_both"></div>
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_gst" class="req">GST</label>
                                                <input  placeholder="GST" id="vendor_gst" value="" class="form-control">
                                            </div>
                                        </div> 
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_loading">Loading Charge</label>
                                                <input type="number" placeholder="Loading Charge" id="vendor_loading" value="0" class="form-control no-spin">
                                            </div>
                                        </div>                                        
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_unloading">Unloading Charge</label>
                                                <input type="number" placeholder="Unloading Charge" id="vendor_unloading" value="0" class="form-control no-spin">
                                            </div>
                                        </div> 
                                        <div class="clear_fix_both"></div>
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendors_branch" class="req">Vendor Branch</label>
                                                <select id="vendors_branch" class="form-control" >
                                                    <option value=''>Select branch</option>
                                                    {foreach item=row from=$organizations}
                                                        <option value="{$row->code}" data-station="{$row->station->code}">{$row->name}</option>
                                                    {/foreach}
                                                </select>      
                                            </div>
                                        </div>
                                        <div class="col-lg-8 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_org" class="req">Organization</label>
                                                <select id="vendor_org" multiple class="form-control" >
                                                    <option value='ALL'>All Branch</option>
                                                    {foreach item=row from=$organizations}
                                                        <option value="{$row->code}">{$row->name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                        <div class="clear_fix_both"></div>
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_creditlimit">Credit Limit</label>
                                                <input type="number" placeholder="Credit Limit" id="vendor_creditlimit" value="0" min="0" class="form-control no-spin">
                                            </div>
                                        </div> 
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_invoicedue">Invoice Due Days</label>
                                                <input type="number" placeholder="Invoice Due Days" id="vendor_invoicedue" value="0" min="0" class="form-control no-spin">
                                            </div>
                                        </div> 
                                        <div class="col-lg-4 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_settlementdue">Settlement Due Days</label>
                                                <input type="number" placeholder="Settlement Due Days" id="vendor_settlementdue" value="0" min="0" class="form-control no-spin">
                                            </div>
                                        </div> 
                                        <div class="clear_fix_both"></div>
                                        <div class="col-lg-12 p_l_n">
                                            <div class="form-group">
                                                <label for="vendor_notes">Notes</label>
                                                <textarea placeholder="Notes" id="vendor_notes" rows="1" class="form-control no-spin"></textarea>
                                            </div>
                                        </div> 
                                        <div class="clear_fix_both"></div>
                                        <div class="col-lg-4 p_l_n">
                                            <input type="checkbox" id="hide-cargo-frieght">
                                            <label style="display: inline-block;" for="hide-cargo-frieght">&nbsp;Hide Cargo Frieght</label>
                                        </div>
                                    </form>
                                    <div class="clear_fix_both"></div>
                                    <div class="clear_fix_both">                       
                                        <div class="alert fl suc_cre" style="display:none;" id="vendor-action-state"></div>
                                        <div class="align-right cre_sve" id="form-bttons">
                                            <input type="hidden" id="vendor_code"/>
                                            <input type="hidden" id="vendor_email_old"/>
                                            <button class="btn btn-success" type="button" onclick="saveCargoVendor();">Save</button>
                                            <button class="btn btn-default" type="button" onclick="cancelVendorDialog();">Cancel</button>
                                        </div>
                                    </div> 
                                    <br/>
                                </div>
                                <div id="edit-vendorCategory-dialog" style="display: none">
                                    <div class="clearfix">
                                        <b>Change Vendor Category</b>
                                        <a href="javascript:;" class="pull-right" onclick="hidevendorAliasDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
                                    </div>
                                    <div id="edit-vendorCategory-panel" class="clearfix" style="padding: 10px 5px;">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group" id="edit-vendorCategory-cont">
                                                    <label for="edit-vendorCategory">Choose new vendor category</label>
                                                    <select id="edit-vendorCategory" class="form-control">
                                                        <option value="">Choose new vendor category</option>
                                                        {foreach item=name key=code from=$vendor_category}
                                                            <option value="{$code}">{$name}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div id="edit-vendorCategory-action-state"></div>
                                            </div>
                                            <div class="col-md-12 text-right" id="edit-vendorCategory-btn">
                                                <button type="button" class="btn btn-success" onclick="savevendorAlias();">Save</button>&nbsp;
                                                <button type="button" class="btn btn-default" onclick="hidevendorAliasDialog();">Cancel</button>&nbsp;
                                            </div>
                                        </div>
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

<div id="cargo-vendor-tariff-dialog" class="hide dialog-content-page">
    <div class="clearfix">
        <h4 id="">Add Tariff</h4>
    </div>
    <div id="add-tariff">
        <div class="row">
            <div class="col-lg-4">
                <div>
                    <label for="tf-frm-ven" class="req">From Vendor</label>
                    <select class="form-control" id="tf-frm-ven" disabled>
                        <option value="">Select</option>
                        {foreach from=$vendors item=row}
                            <option value="{$row->code}">{$row->companyName}</option>
                        {/foreach}
                    </select>
                </div>
            </div> 
            <div class="col-lg-4 p_l_n">
                <div>
                    <label for="tf-to-ven" class="req">To Vendor</label>
                    <select class="form-control" id="tf-to-ven" multiple>
                        <option value="">All Vendor</option>
                        {foreach from=$vendors item=row}
                            <option value="{$row->code}">{$row->companyName}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-lg-4 p_l_n">
                <label for="ie-amount">&nbsp;</label>
                <div class="input-group">
                    <label class="radio-inline">
                        <input type="radio" name="vendorTariffRadio" class="vendor-tariff-type" value="STN" checked>Station
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="vendorTariffRadio" class="vendor-tariff-type" value="BRN">Branch
                    </label>
                </div>
            </div>
            <div class="clear_fix_both"><br></div>

            {* Station *}
            <div id="vendor-tariff-station">
                <div class="col-lg-3">
                    <div>
                        <label for="tf-frm-station" class="req">From Station</label>
                        <select id="tf-frm-station" class="form-control" multiple>
                            <option value=''>All Station</option>
                            {foreach item=station from=$stations}
                                <option value="{$station.code}">{$station.name}</option>
                            {/foreach}
                        </select> 
                    </div>
                </div>
                <div class="col-lg-3 p_l_n">
                    <div>
                        <label for="tf-to-station" class="req">To Station</label>
                        <select id="tf-to-station" class="form-control" multiple>
                            <option value=''>All Station</option>
                            {foreach item=station from=$stations}
                                <option value="{$station.code}">{$station.name}</option>
                            {/foreach}
                        </select> 
                    </div>
                </div>
            </div>

            {* Branch *}
            <div class="hide" id="vendor-tariff-branch">
                <div class="col-lg-3">
                    <div>
                        <label for="tf-frm-branch" class="req">From Branch</label>
                        <select id="tf-frm-branch" class="form-control" multiple>
                            <option value=''>All Branch</option>
                            {foreach item=brn from=$organizations}
                                <option value="{$brn->code}">{$brn->name}</option>
                            {/foreach}
                        </select> 
                    </div>
                </div>
                <div class="col-lg-3 p_l_n">
                    <div>
                        <label for="tf-to-branch" class="req">To Branch</label>
                        <select id="tf-to-branch" class="form-control" multiple>
                            <option value=''>All Branch</option>
                            {foreach item=brn from=$organizations}
                                <option value="{$brn->code}">{$brn->name}</option>
                            {/foreach}
                        </select> 
                    </div>
                </div>
            </div>

            <div class="col-lg-3 p_l_n">
                <div>
                    <label for="tf-hamali" class="req">Hamali Charge</label>
                    <input type="number" class="form-control" id="tf-hamali" placeholder="Hamali Charge" step="any">
                </div>
            </div>
            <div class="col-lg-3 p_l_n">
                <div>
                    <label for="tf-docket" class="req">Docket Charge</label>
                    <input type="number" class="form-control" id="tf-docket" placeholder="Docket Charge" step="any">
                </div>
            </div>  
            <div class="clear_fix_both"><br></div>

            <div class="col-lg-3">
                <div>
                    <label for="tf-door-pick" class="req">Door Pickup Charge</label>
                    <input type="number" class="form-control" id="tf-door-pick" placeholder="Door Pickup Charge" step="any">
                </div>
            </div>
            <div class="col-lg-3 p_l_n">
                <div>
                    <label for="tf-door-del" class="req">Door Delivery Charge</label>
                    <input type="number" class="form-control" id="tf-door-del" placeholder="Door Delivery Charge" step="any">
                </div>
            </div>   
        </div> <br>
        <div class="table-responsive">
            <table class="table table-striped" id="product-table">
                <thead>
                    <tr>
                        <th class="req">Article</th>
                        <th class="req">{lang('booking_UOM_label')}</th>
                        <th class="req">Rate</th>
                        <th class="req">Min Unit</th>
                        {if in_array('VOL', $cargo_setting->cargoUnitModel)}
                            <th class="req">Vol. Feet Value</th>
                        {/if}
                        <th class="req">Loading Ch</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr id="tr_clone" class="tr_clone">
                        <td width='30%'>
                            <select id="tf-item" onchange="allArticles(this);" class="form-control clone-field">
                                <option value=''>Select</option>
                                <option value='ALL'>All Articles</option>
                                {foreach item=val from=$items}
                                    <option value="{$val->code}">{$val->name}</option>
                                {/foreach}
                            </select> 
                        </td>

                        <td width=''>
                            <select id="tf-uom" class="form-control clone-field" onchange="setUOMValue(this)">
                                <option value=''>Select</option>
                                {foreach item=name key=code from=$article_unit}
                                    {if in_array($code, $cargo_setting->cargoUnitModel)}
                                        <option value="{$code}">{$name}</option>
                                    {/if}
                                {/foreach}
                                {if in_array('VOL', $cargo_setting->cargoUnitModel)}
                                    <option value="VOLFT">Volumetric Feet</option>
                                {/if}
                                {if $namespace == 'varahi'}
                                    <option value="PKPK">per Kg per KM</option>
                                    <option value="PTPK">per Ton per KM</option>
                                {/if}
                            </select> 
                        </td>

                        <td width=''>
                            <input type="num" placeholder="Amount" id="tf-amount" value="" class="form-control clone-field" step="any">
                        </td>

                        <td width=''>
                            <input  placeholder="Min Units" id="tf-min-unit" value="" class="form-control clone-field">
                        </td>

                        {if in_array('VOL', $cargo_setting->cargoUnitModel)}
                            <td width=''>
                                <input  placeholder="Vol. Feet Value" id="tf-add-val" value="" class="form-control clone-field" disabled>
                            </td>
                        {/if}

                        <td>
                            <input type="number" class="form-control" id="tf-loading-ch" placeholder="Loading Charge" step="any">
                        </td>

                        <td width='5%' align="right">
                            <a href="javascript:;" onclick="removeArticleRow(this);" data-index="1" class="btn btn-sm btn-danger tr_remove" title="Remove"><i class="fa fa-times"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="javascript:;" class="btn btn-sm btn-primary" id="tr_add_btn" title="Add {lang('booking_article_label')}" onclick="addArticleRow(this)"> <i class="fa fa-plus"></i> </a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display:none;" id="tariff-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" id="tariff-code"/>
            <button class="btn btn-success" type="button" onclick="saveTariff();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelTariffDialog();">Cancel</button>
        </div>
    </div> 
</div>

<div id="vendor-password-dialog" class="hide dialog-content-page">
    <form role="form" class="form-horizontal ">
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="vendor_password1" class="req">Password</label>
                <input type="password" placeholder="Company Name" id="vendor_password1" value="" class="form-control" autocomplete="new-password">
            </div>
        </div> 
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="vendor_password2" class="req">Confirm Password</label>
                <input type="password" placeholder="Name" id="vendor_password2" value="" class="form-control" autocomplete="off">
            </div>
        </div>
    </form>
    <div class="clear_fix_both"></div>
    <br/>
    <div class="col-md-12">
    <div class="alert" style="display:none;" id="vendor-password-action-state"></div>
    </div>
    <div class="clear_fix_both">
        <div class="align-right cre_sve" id="password-form-bttons">
            <input type="hidden" id="vendor_password_code"/>
            <button class="btn btn-success" type="button" onclick="resetVendorPassword();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelVendorPassword();">Cancel</button>
        </div>
    </div> 
</div>

<div id="vendor-address-dialog" class="dialog-content-page" style="display: none">
    <div class="ov_fl_290">
        <form role="form">
            <div class="col-lg-12 p_l_n">
                <div class="form-group">
                    <label for="vendor-address-name" class="req">Name</label>
                    <input type="text" id="vendor-address-name" class="form-control" placeholder="name" >
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <div class="col-lg-6 p_l_n">
                <div class="form-group">
                    <label for="vendor-address1" class="req">Address 1</label>
                    <textarea  placeholder="Address 1" id="vendor-address1" rows="2" class="form-control"></textarea>
                </div>
            </div>                                         
            <div class="col-lg-6 p_l_n">
                <div class="form-group">
                    <label for="vendor-address2" class="req">Address 2</label>
                    <textarea  placeholder="Address 2" id="vendor-address2" rows="2" class="form-control"></textarea>
                </div>
            </div> 
            <div class="clear_fix_both"></div>
            <div class="col-lg-4 p_l_n">
                <div class="form-group">
                    <label for="vendor-pincode" class="req">Pincode</label>
                    <input  placeholder="Pincode" id="vendor-pincode" value="" class="form-control" maxlength="6">
                </div>
            </div>                                         
            <div class="col-lg-4 p_l_n">
                <div class="form-group">
                    <label for="vendor-landmark" class="req">Landmark</label>
                    <input  placeholder="Landmark" id="vendor-landmark" value="" class="form-control">
                </div>
            </div>
            <div class="col-lg-4 p_l_n">
                <div>
                    <label for="vendor-station" class="req">Station</label>
                    <select id="vendor-station" class="form-control">
                        <option value="">Select Station</option>
                        {foreach item=station from=$stations}
                            <option value="{$station.code}">{$station.name}</option>
                        {/foreach} 
                    </select>
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display:none;" id="vendor-address-action-state"></div>
        <div class="align-right cre_sve" id="vendor-addr-form-buttons">
            <input type="hidden" id="vendor-address-code">
            <button class="btn btn-success" type="button" onclick="saveVendorAddress();">Save</button>
            <button class="btn btn-default" type="button" onclick="closeVendorAddress();">Cancel</button>
        </div>
    </div> 
</div>

<div id="merge-vendor-dialog-dialog" class="hide dialog-content-page">
    <form role="form" class="form-horizontal ">
        <div class="col-lg-6 p_l_n">
            <div>
                <label for="merge-with-vendor" class="req">Vendor</label>
                <select id="merge-with-vendor" class="form-control">
                    <option value="">Select Vendor</option>
                    {foreach item=vendor from=$vendors}
                        <option value="{$vendor->code}">{$vendor->companyName}</option>
                    {/foreach} 
                </select>
            </div>
        </div> 
        <div class="col-lg-6 p_r_n">
            <div>
                <label for="vendors-to-be-merged" class="req">Vendors to be merged</label>
                <select id="vendors-to-be-merged" class="form-control" multiple>
                    {foreach item=vendor from=$vendors}
                        <option value="{$vendor->code}">{$vendor->companyName}</option>
                    {/foreach} 
                </select>
            </div>
        </div>
    </form>
    <div class="clear_fix_both"></div>
    <br/>
    <div class="col-md-12">
    <div class="alert" style="display:none;" id="merge-vendor-action-state"></div>
    </div>
    <div class="clear_fix_both">
        <div class="align-right cre_sve" id="merge-vendor-form-bttons">
            <button class="btn btn-success" type="button" onclick="mergeVendor();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelMergeVendorDialog();">Cancel</button>
        </div>
    </div> 
</div>
    <form id="cargo_vendor" method="post" name="cargo_vendor" action="cargo/vendor" onsubmit="return false;" class="hidden">
    <input type="hidden" name="export" id="export" value="1">
    </form>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<script id="vendor-address-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-12">
            <b class="address-name"></b>
        </div>
        <div class="col-xs-12 text-muted small">
            <b class="address-address1"></b>,
            <b class="address-address2"></b>,
            <b class="address-landmark"></b>
        </div>
        <div class="col-xs-12 text-muted small">
            <b class="address-station"></b> - <b class="address-pincode"></b>
        </div>
    </div>
</script>

<input type="hidden" id="item-data" value="{$items|json_encode|escape}">
<input type="hidden" id="vendor-code" value="">

<script>
    var vendorData = {$vendors|json_encode};
    var cargo_setting = {$cargo_setting|json_encode};
</script>
{literal}
<script>
    var vendorAddressTpl = $('#vendor-address-tpl').html();
    var vendorsToBeMerged = $('#vendors-to-be-merged option');
    $('#product-table #tr_clone').find('#tf-item').select2();
    $('#vendor-station').select2();

    $(document).ready( function () {
        $('[data-toggle="tooltip"]').tooltip();
        $('#vendor_station').select2();
        $('#vendor_org').select2({
            placeholder: "Select Organization",
        });

        $('#vendors_branch').select2();

        $('#tf-to-ven').select2({
            placeholder: "Select",
        });
        $('#tf-frm-station, #tf-frm-branch').select2({
            placeholder: "Select From",
        });
        $('#tf-to-station, #tf-to-branch').select2({
            placeholder: "Select To",
        });
        $('#cargo_vendor_table').dataTable({
            "bPaginate": false,
            "info": false,
            "dom": 'lrt'
        });

        $('#merge-with-vendor').select2();
        $('#vendors-to-be-merged').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '100%',
            buttonClass: 'btn btn-default vendors-to-be-merged',
            dropLeft: true,
            templates: {
                ul: '<ul class="multiselect-container dropdown-menu" style="width: 100%;"></ul>',
                li: '<li><a><label style="white-space: normal;"></label></a></li>',
            }  
        });

        $('.search-box').on( 'input', function () {
            $('#cargo_vendor_table').dataTable().fnFilter($('.search-box').val());
            $('#cargo-vendor-tabs').addClass('none');
            $('#cargo_vendor_table tbody tr').removeClass('none');
        });

        $('a[href="#address"]').on('show.bs.tab', function (e) {
            getVendorAddress();
        });

        $('#merge-with-vendor').on('change', function() {
            var selectedVendor = $(this).val();
            $('#vendors-to-be-merged').html(function () {
                return vendorsToBeMerged.filter(function () {
                    return ($(this).val() != selectedVendor);
                });
            }).val('').multiselect('destroy').multiselect({
                maxHeight: 200,
                numberDisplayed: 1,
                buttonWidth: '100%',
                buttonClass: 'btn btn-default vendors-to-be-merged',
                dropLeft: true,
                templates: {
                    ul: '<ul class="multiselect-container dropdown-menu" style="width: 100%;"></ul>',
                    li: '<li><a><label style="white-space: normal;"></label></a></li>',
                }  
            });
        });
    });

    var items = JSON.parse($('#item-data').val());
    var masterItems = [];
    h = '<option value="">Select Article</option>';	
    $.each(items || [], function(key, art) {
        h = h+'<option value="'+key+'">'+art.name+'</option>'; 
        
        var ti = {};
        ti.label = art.name;
        ti.value = key;
        
        masterItems.push(ti);
    });
    
    var tr_id = $('#product-table tbody .tr_clone').length;
    
    $('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');
    $('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'hover');
    $('[data-toggle=popover]').popover({
        container: "body",
        html: true
    });

    $('input[name=vendorTariffRadio]').on('change', function() {
        var type = $(this).val();
        $('#vendor-tariff-station, #vendor-tariff-branch').addClass('hide');

        if (type == 'BRN') {
            $('#vendor-tariff-branch').removeClass('hide');
        } else {
            $('#vendor-tariff-station').removeClass('hide');
        }
    });

    function formatVendorAddress(address) {
        var $tpl = $(vendorAddressTpl);
        $tpl.find('.address-name').text(address.name);
        $tpl.find('.address-address1').text(address.address1);
        $tpl.find('.address-address2').text(address.address2);
        $tpl.find('.address-landmark').text(address.landmark);
        $tpl.find('.address-pincode').text(address.pincode);
        $tpl.find('.address-station').text(address.station.name);
        return $tpl;
    };

    function vendorAddressMatcher(term, text, address) {
        if (!address || !address.name || !address.station) {
            return false;
        }
        text = [address.name, address.station].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    }

    function view(code){
        var vendor = _.find(vendorData, function(o) { return o.code === code });

        if($('#cargo-vendor-tabs').hasClass('none')){
            $('#cargo-vendor-tabs').removeClass('none');
            $('#remaining-details').removeClass('none');
            $('#cancel-view').removeClass('none');
            $('#vendor-code').val(code);
            $('#cargo_vendor_table tbody tr').not('#item_'+code+', #basic-dtl').addClass('none');

            getVendorAddress();

            if (vendor.shortCode !='NA'){
                var comp_name = vendor.companyName + ' ('+vendor.shortCode+')';
            }else{
                var comp_name = vendor.companyName;
            }

            $('#vendor-info-table').find('.com-name').text(comp_name);
            $('#vendor-info-table').find('.con-per').text(vendor.name);
            $('#vendor-info-table').find('.mob').text(vendor.mobileNumber);

            if (vendor.emailVerifiedFlag == 1){
                var email_vfy = '&nbsp;<span class="label label-success">Verified</span>';
            }else{
                var email_vfy = '&nbsp;<span class="label label-warning">Yet to Verify</span>';
            }

            $('#vendor-info-table').find('.email').html(vendor.email + email_vfy);
            $('#vendor-info-table').find('.usr-name').text(vendor.user.username);

            if (vendor.vendorAddress) {
                $('#vendor-info-table').find('.address').text(vendor.vendorAddress.address1 + ', ' + vendor.vendorAddress.address2 + ', ' + vendor.vendorAddress.landmark + ', ' + vendor.vendorAddress.station.name + ' - ' + vendor.vendorAddress.pincode);
            } else {
                $('#vendor-info-table').find('.address').text('-');
            }

            $('#vendor-info-table').find('.gst').text(vendor.gst);
            $('#vendor-info-table').find('.l-char').text(vendor.loadingCharge);
            $('#vendor-info-table').find('.ul-char').text(vendor.unloadingCharge);
            $('#vendor-info-table').find('.credit-limit').text(vendor.creditLimit);
            $('#vendor-info-table').find('.inv-due-days').text(vendor.invoiceDueDays + ' days');
            $('#vendor-info-table').find('.set-due-days').text(vendor.settlementDueDays + ' days');
            $('#vendor-info-table').find('.vendor-category').html(vendor.aliasCode + '<span class=\'p_l_15\'><a href=\'javascript:;\' class=\'btn btn-default btn-xs\' title=\'Update Vendor Category\' onclick=\'vendorAliasDialog()\'><i class=\'fa fa fa-pencil\'></i></a></span>');
            $('#vendor-info-table').find('.ven_brn').text(vendor.responsibleOrganization.name);

            var vendor_notes = "-";
            if (isNotNull(vendor.remarks)) {
                vendor_notes = vendor.remarks;
            }
            $('#vendor-info-table').find('.vendor-notes').text(vendor_notes);

            var org = '';
            var org_len = vendor.organization.length;
            if(org_len != 0){
                $.each(vendor.organization, function( index, value ) {
                    if(index < org_len-1){
                        org += value.name + ',';
                    }else{
                        org += value.name;
                    }
                });
            }else{
                org = 'All Branch';
            }

            $('#vendor-info-table').find('.org').text(org);

            var data = {};
            data.code = code;
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/vendor-tariff',
                data: data,
                success: function (response) {
                    $('#tariff-details').html(response);
                    $('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');
                    $('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'hover');
                    $('[data-toggle=popover]').popover({
                        container: "body",
                        html: true
                    });
                }
            });

        }else{
            $('#remaining-details').addClass('none');
            $('#cargo_vendor_table tbody tr').removeClass('none');
            $('#cargo-vendor-tabs').addClass('none');
            $('#vendor-info-table').find('.com-name').text('');
            $('#vendor-info-table').find('.con-per').text('');
            $('#vendor-info-table').find('.mob').text('');
            $('#vendor-info-table').find('.email').text('');
            $('#vendor-info-table').find('.usr-name').text('');
            $('#vendor-info-table').find('.address').text('');
            $('#vendor-info-table').find('.gst').text('');
            $('#vendor-info-table').find('.l-char').text('');
            $('#vendor-info-table').find('.ul-char').text('');
            $('#vendor-info-table').find('.org').text('');
            $('#vendor-info-table').find('.ven_brn').text('');
            $('#vendor-info-table').find('.credit-limit').text('');
            $('#vendor-info-table').find('.inv-due-days').text('');
            $('#vendor-info-table').find('.set-due-days').text('');
            $('#vendor-info-table').find('.vendor-category').text('');
            $('#vendor-info-table').find('.vendor-notes').text('');
        }
    }

    function cancelView() {
        $('#remaining-details').addClass('none');
        $('#cargo_vendor_table tbody tr').removeClass('none');
        $('#cargo-vendor-tabs').addClass('none');
        $('#cancel-view').addClass('none');
    }

    function cargoVendorDialog(code){
        event && event.stopPropagation();
        addNewVendorAddress();
        $('#vendor_code,#vendor_name,#vendor_short_code,#vendor_mob,#vendor_email,#vendor_company,#vendor_payment_type,#vendor_address_name,#vendor_addr1,#vendor_addr2,#vendor_pincode,#vendor_landmark,#vendor_gst,#vendor_unloading,#vendor_loading,#vendor_creditlimit,#vendor_invoicedue,#vendor_settlementdue, #vendor_notes').val('');
        $('#vendor_station, #vendors_branch').select2('val','');
        $('#vendor_address').val('').select2('destroy');
        $('.inp_error').removeClass('inp_error');
        $('#vendor-action-state').removeClass('alert-success, alert-danger').html('').hide();
        $('#cargo-vendor-dialog').removeClass('hide');
        $('#vendor_org').val(['ALL']).trigger('change');
        $('#hide-cargo-frieght').prop('checked', false);
        $('#cargo-vendor-dialog').dialog({
            autoOpen: true,
            width: 700,
            height: $(window).height() - 50,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#close-add-address').addClass('none');

        if (_isdefined(code)) {
            var option = _.find(vendorData, function(o) { return o.code === code });
            $('#vendor_code').val(option.code);
            $('#vendor-code').val(option.code);
            getVendorAllAddress();
            closeNewVendorAddress();
            $('#close-add-address').removeClass('none');
        
            $('#vendor_name').val(option.name);
            $('#vendor_mob').val(option.mobileNumber);
            $('#vendor_email').val(option.email);
            $('#vendor_email_old').val(option.email);
            $('#vendor_company').val(option.companyName);
            $('#vendor_short_code').val(option.shortCode);
            $('#vendor_payment_type').val(option.preferedPaymentType);
            $('#vendor_address').val(option.vendorAddress.code).trigger('change');
            $('#vendor_gst').val(option.gst);
            $('#vendor_loading').val(option.loadingCharge);
            $('#vendor_unloading').val(option.unloadingCharge);  
            $('#vendor_creditlimit').val(option.creditLimit);  
            $('#vendor_invoicedue').val(option.invoiceDueDays);  
            $('#vendor_settlementdue').val(option.settlementDueDays);  
            $('#vendors_branch').select2('val',option.responsibleOrganization.code)
            $('#hide-cargo-frieght').prop('checked', option.hideCargoFreight == 1);
            $('#vendor_notes').val(option.remarks);

            var org = [];
            $.each(option.organization, function( key, value ) {
                org.push(value.code)
            });
            if(org.length > 0){
                $('#vendor_org').val(org).trigger('change');
            }else{
                $('#vendor_org').val('ALL').trigger('change');
            }
        }
    }

    function cancelVendorDialog(){
        $('#cargo-vendor-dialog').dialog('destroy');
        $('#cargo-vendor-dialog').hide();
    }

    function mergeVendorDialog(code){
        $('#merge-vendor-dialog-dialog').css('background', '#fff');
        $('#merge-vendor-dialog-dialog').removeClass('hide');
        $('#merge-vendor-dialog-dialog').dialog({
            autoOpen: true,
            height: 300,
            width: 600,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        $('.inp_error').removeClass('inp_error');
        $('#merge-vendor-action-state').removeClass('alert-success, alert-danger').html('').hide();
        $('#merge-with-vendor').val('').trigger('change');
        $('#vendors-to-be-merged').val(['']).multiselect('refresh');
    }

    function cancelMergeVendorDialog(){
        $('#merge-vendor-dialog-dialog').dialog('destroy');
        $('#merge-vendor-dialog-dialog').hide();
    }
    
    function vendorAliasDialog(code) {
        event && event.stopPropagation();
        $('#edit-vendorCategory-dialog').removeClass('hide');
        $('#edit-vendorCategory-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 350,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#edit-vendorCategory-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html('');
        
    }

    function hidevendorAliasDialog() {
        $('#edit-vendorCategory-dialog').dialog('destroy');
        $('#edit-vendorCategory-dialog').hide();
    }

    function savevendorAlias() {
        
        var data = {}, err = 0;
        data.code = $('#vendor-code').val();
        data.vendorCategory={};
        data.vendorCategory.code = $('#edit-vendorCategory').val();

        $('.inp_error').removeClass('inp_error');
        
        if ($('#edit-vendorCategory').val() == '') {
            $('#edit-vendorCategory').addClass('inp_error');
            err++;
        } else {
            $('#edit-vendorCategory').removeClass('inp_error');
        }

        if(err) {
            $('#edit-vendorCategory-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#edit-vendorCategory-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }
        $('#edit-vendorCategory-btn').hide();
        $('#edit-vendorCategory-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-vendor-aliascode",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#edit-vendorCategory-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hidevendorAliasDialog();
                        checkURL();
                    }, 1500);
                } else {
                    $('#edit-vendorCategory-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#edit-vendorCategory-btn').show();
                }
            }
        })
    }

    function cargoTariffDialog(code){
        event && event.stopPropagation();

        $('input[name=vendorTariffRadio][value=STN]').prop('checked', true).trigger('change');
        $('#tf-frm-ven, #tf-uom, #tf-amount, #tf-loading-ch, #tf-min-unit, #tariff-code').val('');
        $('#tf-hamali, #tf-docket, #tf-door-pick, #tf-door-del').val('');
        $('#tf-item').val('').trigger('change');
        $('#tf-to-ven, #tf-frm-station, #tf-to-station, #tf-frm-branch, #tf-to-branch').val(null).trigger('change');
        $('.inp_error').removeClass('inp_error');
        $('#tf-frm-ven').val($('#vendor-code').val()).trigger('change');
        $('#tariff-action-state').html('').addClass('none').removeClass('alert-danger alert-success');
        $('#cargo-vendor-tariff-dialog').removeClass('hide');
        $('#cargo-vendor-tariff-dialog').dialog({
            autoOpen: true,
            width: 900,
            height: 600,
            resizable: false,
            closeOnEscape: true
        });
        $(".ui-dialog-titlebar").hide();
        
        if (_isdefined(code)) {
            var option = _.find(vendorTariffData, function(o) { return o.code === code });
            $('#tariff-code').val(code);
            $('#tf-frm-ven').val(option.fromVendor.code); 
            
            var to_ven = [];
            $.each(option.toVendorList, function( key, value ) {
                to_ven.push(value.code)
            });
            if(to_ven.length > 0){
                $('#tf-to-ven').val(to_ven).trigger('change');
            }else{
                $('#tf-to-ven').val('').trigger('change');
            }

            if (option.routeType.code == 'RTE') {
                $('input[name=vendorTariffRadio][value=STN]').prop('checked', true).trigger('change');

                // from station
                var frm_sta = [];
                $.each(option.fromStationList || [], function( key, value ) {
                    frm_sta.push(value.code);
                });
                if(frm_sta.length > 0){
                    $('#tf-frm-station').val(frm_sta).trigger('change');
                }else{
                    $('#tf-frm-station').val('').trigger('change');
                }

                // to station
                var to_sta = [];
                $.each(option.toStationList || [], function( key, value ) {
                    to_sta.push(value.code);
                });
                if(to_sta.length > 0){
                    $('#tf-to-station').val(to_sta).trigger('change');
                }else{
                    $('#tf-to-station').val('').trigger('change');
                }
            } else if (option.routeType.code == 'BRTE') {
                $('input[name=vendorTariffRadio][value=BRN]').prop('checked', true).trigger('change');

                // from branch
                var frm_org = [];
                $.each(option.fromOrganizationList || [], function( key, value ) {
                    frm_org.push(value.code);
                });
                if(frm_org.length > 0){
                    $('#tf-frm-branch').val(frm_org).trigger('change');
                }else{
                    $('#tf-frm-branch').val('').trigger('change');
                }

                // to branch
                var to_org = [];
                $.each(option.toOrganizationList || [], function( key, value ) {
                    to_org.push(value.code);
                });
                if(to_org.length > 0){
                    $('#tf-to-branch').val(to_org).trigger('change');
                }else{
                    $('#tf-to-branch').val('').trigger('change');
                }
            }

            $('#tf-hamali').val(option.hamaliCharge);
            $('#tf-docket').val(option.docketCharge);
            $('#tf-door-pick').val(option.doorPickupCharge);
            $('#tf-door-del').val(option.doorDeliveryCharge);

            $.each(option.itemDetailList, function(key, val){
                if(key == 0){
                    $('#product-table tbody #tr_clone').find('#tf-item').val(val.cargoItem.code).trigger('change');
                    $('#product-table tbody #tr_clone').find('#tf-amount').val(val.amount);
                    $('#product-table tbody #tr_clone').find('#tf-uom').val(val.unit.code).trigger('change');
                    $('#product-table tbody #tr_clone').find('#tf-min-unit').val(val.minUnitValue);
                    $('#product-table tbody #tr_clone').find('#tf-add-val').val(val.additionalValue);
                    $('#product-table tbody #tr_clone').find('#tf-loading-ch').val(val.loadingCharge);
                }else{
                    $('.tr_clone:first-child').find('#tf-item').select2('destroy');

                    tr_id = tr_id+1;
                    var cloned_tr = $('.tr_clone:first-child').clone(true);
                    cloned_tr.attr({id: 'tr_clone' + (key+1)});
                    cloned_tr.find('#tf-item').select2();
                    $('.tr_clone:first-child').find('#tf-item').select2();
                    
                    cloned_tr.find('.tr_remove').attr('data-index', key+1);
                    cloned_tr.find('#tf-item').val(val.cargoItem.code).trigger('change');
                    cloned_tr.find('#tf-amount').val(val.amount);
                    cloned_tr.find('#tf-uom').val(val.unit.code).trigger('change');
                    cloned_tr.find('#tf-min-unit').val(val.minUnitValue);
                    cloned_tr.find('#tf-add-val').val(val.additionalValue);
                    cloned_tr.find('#tf-loading-ch').val(val.loadingCharge);

                    $('#product-table>tbody>tr').eq(-2).after(cloned_tr)
                }
            });
        }
    }
    
    function cancelTariffDialog(){
        tr_id = 1;
        $('#product-table tbody .tr_clone').not(':first-child').remove();
        $('#product-table tbody .tr_clone').attr({id: 'tr_clone'});
        $('#product-table tbody .tr_clone').find('.tr_remove').attr('data-index', 1);

        $('#cargo-vendor-tariff-dialog').dialog('destroy');
        $('#cargo-vendor-tariff-dialog').hide();
    }

    function addArticleRow(ele){
        $('.tr_clone:first-child').find('#tf-item').select2('destroy');

        tr_id = tr_id+1;
        var cloned_tr = $('.tr_clone:first-child').clone(true);

        cloned_tr.attr({id: 'tr_clone' + tr_id});
        cloned_tr.find('.tr_remove').attr('data-index', tr_id);
        cloned_tr.find('.clone-field').val('');
        cloned_tr.find('#tf-item').select2();
        $('.tr_clone:first-child').find('#tf-item').select2();

        $('#product-table>tbody>tr').eq(-2).after(cloned_tr);
    }

    function removeArticleRow(ele) {
        if($('#product-table tbody tr').length >2){
            ele.closest('tr').remove();
        }
    }

    function setUOMValue(uomSelect) {
        $(uomSelect).closest('tr').find('#tf-add-val').val('').prop('disabled', uomSelect.value != 'VOLFT')
    }

    function saveTariff(){
        $('.inp_error').removeClass('inp_error');
        var err = 0;

        var data = {}
        data.code = $('#tariff-code').val();
        data.activeFlag = 1;

        var ven_stp = 0;
        if($('#tf-frm-ven').val() != '' && $('#tf-to-ven').val() != ''){
            var ven_res = $.inArray( $('#tf-frm-ven').val(), $('#tf-to-ven').val());
            if( ven_res != -1 ) {
                alert('From vendor and to vendor contains same vendors');
                ven_stp = 1;
            }
        }

        data.fromVendor = {};
        data.fromVendor.code = $('#tf-frm-ven').val();
        
        if($('#tf-to-ven').val() == ''){
            data.toVendorList = [];
        }else{
            data.toVendorList = $.map($('#tf-to-ven').val() || [], (to_ven) => ({ code: to_ven }));
        }

        var sta_stp = 0;
        var type = $('input[name=vendorTariffRadio]:checked').val();
        if (type == 'STN') {
            if(($('#tf-frm-station').val() != '' && $('#tf-to-station').val() != '')){
                $.each($('#tf-frm-station').val() || [], function( key, value ) {
                    if(value != ''){
                        var index = $.inArray( value, $('#tf-to-station').val());
                        if( index != -1 ) {
                            alert('From station and to station contains same stations');
                            sta_stp = 1;
                            return false;
                        }
                    }
                });
            }

            if(sta_stp == 1){
                $('.inp_error').removeClass('inp_error');
                $('#tariff-action-state').html('').addClass('none').removeClass('alert-danger');
                return;
            }

            if($('#tf-frm-station').val() == ''){
                data.fromStationList = [];
            }else{
                data.fromStationList = $.map($('#tf-frm-station').val() || [], (to_ven) => ({ code: to_ven }));
            }

            if($('#tf-to-station').val() == ''){
                data.toStationList = [];
            }else{
                data.toStationList = $.map($('#tf-to-station').val() || [], (val) => ({ code: val }));
            }

            data.routeType = {};
            data.routeType.code = 'RTE';
        } else if (type == 'BRN') {
            if(($('#tf-frm-branch').val() != '' && $('#tf-to-branch').val() != '')){
                $.each($('#tf-frm-branch').val() || [], function( key, value ) {
                    if(value != ''){
                        var index = $.inArray( value, $('#tf-to-branch').val());
                        if( index != -1 ) {
                            alert('From branch and to branch contains same branches');
                            sta_stp = 1;
                            return false;
                        }
                    }
                });
            }

            if(sta_stp == 1){
                $('.inp_error').removeClass('inp_error');
                $('#tariff-action-state').html('').addClass('none').removeClass('alert-danger');
                return;
            }

            if($('#tf-frm-branch').val() == ''){
                data.fromOrganizationList = [];
            }else{
                data.fromOrganizationList = $.map($('#tf-frm-branch').val() || [], (to_ven) => ({ code: to_ven }));
            }

            if($('#tf-to-branch').val() == ''){
                data.toOrganizationList = [];
            }else{
                data.toOrganizationList = $.map($('#tf-to-branch').val() || [], (val) => ({ code: val }));
            }
            data.routeType = {};
            data.routeType.code = 'BRTE';
        }
        data.customerRole = {code:'RAC'};

        data.itemDetailList = [];
        $.each($('#product-table tbody tr').not(':last-child'), function(){
            var item_detail = {
                activeFlag: 1,
                cargoItem:{code:$(this).find('#tf-item').val()},
                amount:$(this).find('#tf-amount').val(),
                unit:{code:$(this).find('#tf-uom').val()},
                minUnitValue:$(this).find('#tf-min-unit').val(),
                additionalValue:$(this).find('#tf-add-val').val(),
                loadingCharge:$(this).find('#tf-loading-ch').val()
            };
            data.itemDetailList.push(item_detail);
        });
        
        data.hamaliCharge = $('#tf-hamali').val();
        data.docketCharge = $('#tf-docket').val();
        data.doorPickupCharge = $('#tf-door-pick').val();
        data.doorDeliveryCharge = $('#tf-door-del').val();

        if(data.hamaliCharge == ''){
            $('#tf-hamali').addClass('inp_error');
            err++;
        }

        if(data.docketCharge == ''){
            $('#tf-docket').addClass('inp_error');
            err++;
        }

        if(data.doorPickupCharge == ''){
            $('#tf-door-pick').addClass('inp_error');
            err++;
        }

        if(data.doorDeliveryCharge == ''){
            $('#tf-door-del').addClass('inp_error');
            err++;
        }

        if (data.itemDetailList.length >= 1) {
            $.each($('#product-table tbody tr').not(':last-child'), function(){
                if($(this).find('#tf-item').val() == ''){
                    $(this).find('#tf-item').addClass('inp_error');
                    err++;
                }

                if($(this).find('#tf-amount').val() == ''){
                    $(this).find('#tf-amount').addClass('inp_error');
                    err++;
                }

                if($(this).find('#tf-uom').val() == ''){
                    $(this).find('#tf-uom').addClass('inp_error');
                    err++;
                }

                if($(this).find('#tf-min-unit').val() == ''){
                    $(this).find('#tf-min-unit').addClass('inp_error');
                    err++;
                }

                if($(this).find('#tf-loading-ch').val() == ''){
                    $(this).find('#tf-loading-ch').addClass('inp_error');
                    err++;
                }
            });
        }
        
        if (err > 0) {
            $('#tariff-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#tariff-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#tariff-action-state').show();
            return false;
        } else {
            $('#tariff-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#tariff-action-state').hide();
        }
        
        $('#tariff-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#tariff-action-state').html(loading_popup);
        $('#tariff-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-tariff",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#tariff-action-state').removeClass('alert-danger');
                    $('#tariff-action-state').addClass('alert-success');
                    $('#tariff-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelTariffDialog();
                        view(data.fromVendor.code);
                        return;
                    }, 3000);
                } else {
                    $('#tariff-action-state').addClass('alert-danger');
                    $('#tariff-action-state').html(response.errorDesc);
                }
            }
        });        
    }

    function deleteTariff(code){
        if (confirm('Do you want to delete this Tariff?')) {
            var data = _.find(vendorTariffData, function(o) { return o.code === code });
            data.activeFlag = 2;
            
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-tariff",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
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
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        checkURL();
                    }, 2000);
                }
            });    
        }
    }
    
    function saveCargoVendor(){
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {}
        data.code = $('#vendor_code').val();
        data.name = $.trim($('#vendor_name').val());
        data.mobileNumber = $('#vendor_mob').val();
        data.email = $.trim($('#vendor_email').val());
        data.oldemail = $.trim($('#vendor_email_old').val());
        data.companyName = $.trim($('#vendor_company').val());
        data.shortCode = $.trim($('#vendor_short_code').val());
        data.preferedPaymentType = $('#vendor_payment_type').val();
        data.hideCargoFreight = $('#hide-cargo-frieght').is(':checked') ? 1 : 0;
        data.remarks = $.trim($('#vendor_notes').val());

        data.address = {};

        data.vendorAddress = {};
        data.vendorAddress.code = $.trim($('#vendor_address').val());
        if (data.vendorAddress.code == '') {
            data.vendorAddress.name = $.trim($('#vendor_address_name').val());
            data.vendorAddress.address1 = $.trim($('#vendor_addr1').val());
            data.vendorAddress.address2 = $.trim($('#vendor_addr2').val());
            data.vendorAddress.pincode = $.trim($('#vendor_pincode').val());
            data.vendorAddress.landmark = $.trim($('#vendor_landmark').val());

            data.vendorAddress.station = {};
            data.vendorAddress.station.code = $('#vendor_station').val();

            if (data.vendorAddress.name == '') {
                $('#vendor_address_name').addClass('inp_error');
                err++;
            } 

            if (data.vendorAddress.address1 == '') {
                $('#vendor_addr1').addClass('inp_error');
                err++;
            } 

            if (data.vendorAddress.address2 == '') {
                $('#vendor_addr2').addClass('inp_error');
                err++;
            } 

            if (isNaN(data.vendorAddress.pincode) || data.vendorAddress.pincode == '') {
                $('#vendor_pincode').addClass('inp_error');
                err++;
            } 

            if (data.vendorAddress.landmark == '') {
                $('#vendor_landmark').addClass('inp_error');
                err++;
            } 

            if (data.vendorAddress.station.code == '') {
                $('#vendor_station').addClass('inp_error');
                err++;
            } 
        }
        if (data.vendorAddress.code == '' && data.vendorAddress.name == '') {
            $('#vendor_address').addClass('inp_error');
            err++;
        }

        data.gst = $.trim($('#vendor_gst').val());
        data.loadingCharge = $.trim($('#vendor_loading').val());
        data.unloadingCharge = $.trim($('#vendor_unloading').val());
        data.creditLimit = $.trim($('#vendor_creditlimit').val()); 
        data.invoiceDueDays = $.trim($('#vendor_invoicedue').val()); 
        data.settlementDueDays = $.trim($('#vendor_settlementdue').val());

        data.responsibleOrganization = {};
        data.responsibleOrganization.code = $('#vendors_branch').val();

        data.station = {};
        data.station.code = $('#vendors_branch :selected').data('station');

        data.organization = $.map($('#vendor_org').val() || [], function (val) {
                return { code: val };
        });
        if($.inArray('ALL', $('#vendor_org').val()) != -1) {
            data.organization = [];
        }
        data.activeFlag = 1;
        
        if (data.name == '') {
            $('#vendor_name').addClass('inp_error');
            err++;
        }
        
        if (isNaN(data.mobileNumber) || data.mobileNumber.length !=10) {
            $('#vendor_mob').addClass('inp_error');
            err++;
        }
        
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (data.email == '' || !filter.test(data.email)) {
            $('#vendor_email').addClass('inp_error');
            err++;
        } 
        
        if (data.companyName == '') {
            $('#vendor_company').addClass('inp_error');
            err++;
        } 
        
        if (data.preferedPaymentType == '') {
            $('#vendor_payment_type').addClass('inp_error');
            err++;
        }
        
        if (data.gst == '') {
            $('#vendor_gst').addClass('inp_error');
            err++;
        } 

        if(data.gst != '' && !isValidGstNumber(data.gst)) {
            $('#vendor_gst').addClass('inp_error');
            $('#vendor-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vendor-action-state').html('Please enter a valid GSTIN');
            $('#vendor-action-state').show();
            return false;
        }

        if ($('#vendors_branch').val() == '') {
            $('#vendors_branch').addClass('inp_error');
            err++;
        } else {
            $('#vendors_branch').removeClass('inp_error');
        }

        if (isNaN(data.creditLimit) || Number(data.creditLimit) < 0) {
            $('#vendor_creditlimit').addClass('inp_error');
            err++;
        } else {
            $('#vendor_creditlimit').removeClass('inp_error');
        }
        if (isNaN(data.invoiceDueDays) || Number(data.invoiceDueDays) < 0) {
            $('#vendor_invoicedue').addClass('inp_error');
            err++;
        } else {
            $('#vendor_invoicedue').removeClass('inp_error');
        }
        if (isNaN(data.settlementDueDays) || Number(data.settlementDueDays) < 0) {
            $('#vendor_settlementdue').addClass('inp_error');
            err++;
        } else {
            $('#vendor_settlementdue').removeClass('inp_error');
        }
        
        if (err > 0) {
            $('#vendor-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vendor-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vendor-action-state').show();
            return false;
        } else {
            $('#vendor-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vendor-action-state').hide();
        }
        
        $('#form-bttons').hide();
        $('#vendor-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#vendor-action-state').html(loading_popup);
        $('#vendor-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-cargo-vendor",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#vendor-action-state').removeClass('alert-danger');
                    $('#vendor-action-state').addClass('alert-success');

                    if (response.emailVerificationSent == 1) {
                        $('#vendor-action-state').html('Your request has been completed and Verification email sent successfully');
                    } else {
                        $('#vendor-action-state').html('Your request has been completed successfully');
                    }

                    window.setTimeout(function () {
                        cancelVendorDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#vendor-action-state').addClass('alert-danger');
                    $('#vendor-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });        
    }
    
    function deleteCargoVendor(code){
        event && event.stopPropagation();

        if (confirm('Do you want to delete this Vendor?')) {
            var data = _.find(vendorData, function(o) { return o.code === code });
            data.activeFlag = 2;
            
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-cargo-vendor",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
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
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        checkURL();
                    }, 2000);
                }
            });    
        }
    }
    
    function disableCargoVendor(code){
        event && event.stopPropagation();

        var data = _.find(vendorData, function(o) { return o.code === code });
        var msg = '';
        if(data.activeFlag == 1){
            data.activeFlag = 0;
            msg = 'Do you want to disable this Vendor?';
        } else {
            data.activeFlag = 1;
            msg = 'Do you want to enable this Vendor?';
        }
        if(confirm(msg)){
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });       
        
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-cargo-vendor",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
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
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        checkURL();
                    }, 2000);
                }
            });    
        }
    }

    function sendVendorVerifyEmail(code, email) {
        event && event.stopPropagation();
        var data = {};
        data.vendorCode = code;
        data.email = email;
        
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/send-vendor-email-verify",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });

                    $('#item_' + code).find('.email-verify-link')
                        .replaceWith('<span class="text-success">Sent</span>');
                } else {
                    alert(response.errorDesc);
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

    function showVendorPassword(code) {
        event && event.stopPropagation();

        $('#vendor_password_code').val(code);
        $('#vendor_password1, #vendor_password2').val('');
        $('.inp_error').removeClass('inp_error');

        $('#vendor-password-dialog').removeClass('hide');
        $('#vendor-password-dialog').dialog({
            autoOpen: true,
            width: 470,
            height: 350,
            resizable: false,
            modal: true
        });
        $(".ui-dialog-titlebar").hide();
    }
    
    function cancelVendorPassword(){
        $('#vendor-password-dialog').dialog('destroy');
        $('#vendor-password-dialog').hide();
    }

    function resetVendorPassword() {
        var data = {}
        data.code = $('#vendor_password_code').val();
        data.password = $.trim($('#vendor_password1').val());
        var confirm_password = $.trim($('#vendor_password2').val());
        
        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.password.length < 6) {
            $('#vendor_password1').addClass('inp_error');
            $('#vendor_password2').addClass('inp_error');
            
            $('#vendor-password-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vendor-password-action-state').html('Password should be minimum 6 characters.');
            $('#vendor-password-action-state').show();
            return false;
        }
        if (data.password != confirm_password) {
            $('#vendor_password1').addClass('inp_error');
            $('#vendor_password2').addClass('inp_error');
            
            $('#vendor-password-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vendor-password-action-state').html('Passwords doesn\'t match');
            $('#vendor-password-action-state').show();
            return false;
        }
        if (err > 0) {
            $('#vendor-password-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vendor-password-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vendor-password-action-state').show();
            return false;
        } else {
            $('#vendor-password-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vendor-password-action-state').hide();
        }
        
        $('#password-form-bttons').hide();
        $('#vendor-password-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#vendor-password-action-state').html(loading_popup);
        $('#vendor-password-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-vendor-password",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#password-form-bttons').hide();
                    $('#vendor-password-action-state').removeClass('alert-danger');
                    $('#vendor-password-action-state').addClass('alert-success');
                    $('#vendor-password-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelVendorPassword();
                        checkURL();
                    }, 3000);
                } else {
                    $('#vendor-password-action-state').addClass('alert-danger');
                    $('#vendor-password-action-state').html(response.errorDesc);
                    $('#password-form-bttons').show();
                }
            }
        });  
    }

    function addNewVendorAddress() {
        $('#vendor-new-address .inp_error').removeClass('inp_error');
        $('#vendor_address_name, #vendor_addr1, #vendor_addr2, #vendor_pincode, #vendor_landmark, #vendor_station, #vendor_address').val('').trigger('change');

        $('#select-vendor-address').addClass('none');
        $('#vendor-new-address').removeClass('none');
    }

    function closeNewVendorAddress() {
        $('#select-vendor-address .inp_error').removeClass('inp_error');
        $('#vendor_address_name, #vendor_addr1, #vendor_addr2, #vendor_pincode, #vendor_landmark, #vendor_station, #vendor_address').val('').trigger('change');

        $('#select-vendor-address').removeClass('none');
        $('#vendor-new-address').addClass('none');
    }

    function vendorAddressDialog(code) {
        $('#vendor-address-code, #vendor-address-name, #vendor-address1, #vendor-address2, #vendor-pincode, #vendor-landmark').val('');
        $('#vendor-station').val('').trigger('change');
        $('.inp_error').removeClass('inp_error');
        $('#vendor-address-action-state').html('');
        $('#vendor-address-action-state').hide();
        $('#vendor-addr-form-buttons').show();
        $('#vendor-address-dialog').dialog({
            autoOpen: true,
            width: 700,
            maxWidth: 700,
            height: 400,
            resizable: false,
            modal: true,
        });
        $(".ui-dialog-titlebar").hide();
        
        if (_isdefined(code)) {
            var data = _.find(vendorAddressData, function(o) { return o.code === code });
            $('#vendor-address-code').val(data.code);
            $('#vendor-address-name').val(data.name);
            $('#vendor-address1').val(data.address1);
            $('#vendor-address2').val(data.address2);
            $('#vendor-pincode').val(data.pincode);
            $('#vendor-landmark').val(data.landmark);
            $('#vendor-station').val(data.station.code).trigger('change');
        }
    }

    function closeVendorAddress() {
        $('#vendor-address-dialog').dialog('destroy');
        $('#vendor-address-dialog').hide();
    }  

    function getVendorAddress() {
        var data = {};
        data.vendorCode = $('#vendor-code').val();
        $('#address-details').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/vendor-address',
            data: data,
            success: function (response) {
                $('#address-details').html(response);
            }
        });
    }

    function getVendorAllAddress() {
        var data = {};
        data.vendorCode = $('#vendor-code').val();

        $('#vendor_address').attr('placeholder', 'Loading...');

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-vendor-address',
            data: data,
            success: function (response) {
                var vendorAddress = [];
                    $.each(response.data || [], function (i, row) {
                    row.id = row.code;
                    row.name = row.name;
                    vendorAddress.push(row);
                });

                $('#vendor_address').attr('placeholder', 'Select Address');
                $('#vendor_address').select2({
                    data: { results: vendorAddress },
                    placeholder: 'Select Address',
                    formatResult: formatVendorAddress,
                    formatSelection: formatVendorAddress,
                    matcher: vendorAddressMatcher
                });
            }
        });
    }

    function saveVendorAddress() {
        var data = {};
        data.activeFlag = 1;
        data.code = $('#vendor-address-code').val();
        data.vendorCode = $('#vendor-code').val();
        data.name = $.trim($('#vendor-address-name').val());
        data.address1 = $('#vendor-address1').val();
        data.address2 = $.trim($('#vendor-address2').val());
        data.pincode = $.trim($('#vendor-pincode').val());
        data.landmark = $.trim($('#vendor-landmark').val());

        data.station = {};
        data.station.code = $('#vendor-station').val();
        
        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.name == '') {
            $('#vendor-address-name').addClass('inp_error');
            err++;
        }
        
        if (data.address1 == '') {
            $('#vendor-address1').addClass('inp_error');
            err++;
        } 
        
        if (data.address2 == '') {
            $('#vendor-address2').addClass('inp_error');
            err++;
        } 
        
        if (data.pincode == '') {
            $('#vendor-pincode').addClass('inp_error');
            err++;
        } 
        
        if (data.landmark == '') {
            $('#vendor-landmark').addClass('inp_error');
            err++;
        }

        if (data.station.code == '') {
            $('#vendor-station').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#vendor-address-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vendor-address-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vendor-address-action-state').show();
            return false;
        } else {
            $('#vendor-address-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vendor-address-action-state').hide();
        }
        $('#vendor-addr-form-buttons').hide();
        $('#vendor-address-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#vendor-address-action-state').html(loading_popup);
        $('#vendor-address-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/add-vendor-address",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#vendor-addr-form-buttons').hide();
                    $('#vendor-address-action-state').removeClass('alert-danger');
                    $('#vendor-address-action-state').addClass('alert-success');
                    $('#vendor-address-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        closeVendorAddress();
                        getVendorAddress();
                    }, 3000);
                } else {
                    $('#vendor-address-action-state').addClass('alert-danger');
                    $('#vendor-address-action-state').html(response.errorDesc);
                    $('#vendor-addr-form-buttons').show();
                }
            }
        })
    }

    function deleteVendorAddress(code) {
        var data = _.find(vendorAddressData, function(o) { return o.code === code });
        data.activeFlag = 2;
        data.vendorCode = $('#vendor-code').val();

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/add-vendor-address",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        getVendorAddress()
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }

            }
        })
    }

    function allArticles(ele) {
        var type = $(ele).val();
        $('#tr_add_btn').removeClass('hide');
        if (type == "ALL") {
            $('#tr_add_btn').addClass('hide');
            $('#product-table tbody tr').not(ele.closest('tr')).not(':last-child').remove();
        }
    }

    function mergeVendor() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');
        var data = {};
        data.code = $('#merge-with-vendor').val();

        if ($('#vendors-to-be-merged').val() == null) {
            $('.vendors-to-be-merged').addClass('inp_error');
            err++;
        } else {
            data.vendorReference = $.map($('#vendors-to-be-merged').val() || [], function(val) {
                return { code: val };
            });
        }

        if (data.code == '') {
            $('#merge-with-vendor').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#merge-vendor-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#merge-vendor-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#merge-vendor-action-state').show();
            return false;
        } else {
            $('#merge-vendor-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#merge-vendor-action-state').hide();
        }
        $('#merge-vendor-form-bttons').hide();
        $('#merge-vendor-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#merge-vendor-action-state').html(loading_popup);
        $('#merge-vendor-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/merge-vendor",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#merge-vendor-form-bttons').hide();
                    $('#merge-vendor-action-state').removeClass('alert-danger');
                    $('#merge-vendor-action-state').addClass('alert-success');
                    $('#merge-vendor-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelMergeVendorDialog();
                        checkURL();
                    }, 3000);
                } else {
                    $('#merge-vendor-action-state').addClass('alert-danger');
                    $('#merge-vendor-action-state').html(response.errorDesc);
                    $('#merge-vendor-form-bttons').show();
                }
            }
        });
    }

    function revertMergedVendors(code) {
        event && event.stopPropagation();
        if (confirm('Do you want to revert the merged vendors?')) {
            var data = {};
            data.code = code;

            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/revert-merged-vendors",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function() {
                            loading_overlay.hide();
                            checkURL()
                        }, 2000);
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                        window.setTimeout(function() {
                            loading_overlay.hide();
                        }, 2000);
                    }

                }
            })
        }
    }
    
    function exportCustomersExcel() {
        document.cargo_vendor.target = "ifrm_downloader";
        document.cargo_vendor.submit();
        return;
    }
</script>    
{/literal}