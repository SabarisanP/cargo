<div class="brand_top"><h3>Vehicle</h3> 
    <span class="align-rights">
       {if $is_super_namespace==1}<button class="btn btn-primary" onclick="importBitsVehicles()">Import Bits Vehicles</button>{/if}
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="vehiclePopup();">Add New Vehicle</a>
    </span>
</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="content" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    
                                    <div class="row">
                                        <div class="col-md-2 bold">Total Vehicles : {$vehicle|@count}</div>
                                        {* <div class="col-md-2 bold">GPS Not Installed : <span id="nogpsspn"></span></div> *}
                                        <div class="col-md input-group pull-right" style="width: 25%;">
                                            <input type="search" class="form-control search-box" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
                                            <span class="input-group-addon point_cur" id="search-btn">
                                                <i class="fa fa-search"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <br>
                                    {assign var="nogpscount" value=0}
                                    <div class="table-responsive">

                                        <table class="table table-hover" id="all-data">
                                            <thead>
                                                <tr class="bold">
                                                    <th>Name</th>
                                                    <th>Reg No</th>

                                                    {if $is_super_namespace==1 && $cargo_setting->transitLocationModelCode == 'BRCH'}
                                                        <th>Transit Branch</th>
                                                    {elseif $is_super_namespace==1}
                                                        <th>Transit Station</th>
                                                    {/if}

                                                    <th>Ownership Type</th>
                                                    <th>Reg Date</th>
                                                    <th>Licence No</th>                                                    
                                                    <th>Brand/ Model</th>
                                                    <th>Vehicle Type</th> 
                                                    <th>Status</th>                                                    
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach item=row from=$vehicle}
                                                    <tr id="oz-{$row->code}" class="no-wrap point_cur" data-registration-number="{preg_replace('/[^a-zA-Z0-9]/', '', $row->registationNumber)}" onclick="view({$row|json_encode|escape})">
                                                        <td>{$row->name}</td>
                                                        <td>{$row->registationNumber}</td>

                                                        {if $is_super_namespace==1 && $cargo_setting->transitLocationModelCode == 'BRCH'}
                                                            <td>
                                                                {$row->transitOrganization->name|default:'-'}
                                                                <span class="p_l_15">
                                                                    <a href="javascript:;" class="btn btn-default btn-xs" title="Update Transit Branch" onclick='editTransitDialog("{$row->code}", "{$row->transitStation->code}", "{$row->transitOrganization->code}")' ><i class="fa fa fa-pencil"></i></a>
                                                                </span>
                                                            </td>
                                                        {elseif $is_super_namespace==1}
                                                            <td>
                                                                {$row->transitStation->name|default:'-'}
                                                                <span class="p_l_15">
                                                                    <a href="javascript:;" class="btn btn-default btn-xs" title="Update Transit Station" onclick='editTransitDialog("{$row->code}", "{$row->transitStation->code}", "{$row->transitOrganization->code}")' ><i class="fa fa fa-pencil"></i></a>
                                                                </span>
                                                            </td>
                                                        {/if}
                                                        
                                                        <td>{$row->ownershipType->name}</td>
                                                        <td>{$row->registrationDate|date_format:$ns_date_format}</td>
                                                        <td>{$row->licNumber}</td> 

                                                        {if $row->makeType != 'NA' && $row->modelType != 'NA'}                                                       
                                                            <td>{$row->makeType}-{$row->modelType}</td>
                                                        {else}
                                                            <td>-</td>
                                                        {/if}

                                                        <td>{$row->vehicleType->name}</td>
                                                        <td>
                                                            {if $row->activeFlag==1} 
                                                                <span class="label label-success status-label">Active</span>
                                                            {else}
                                                                <span class="label label-warning status-label">Disabled</span>
                                                            {/if}
                                                        </td>                                                        
                                                        <td>

                                                            {if $action_rights['STATUS-VCLE']>0}  
                                                                <a href="javascript:;" class=" est"   onclick='editStatusVehicle("{$row->code}", this)' data-status="{$row->activeFlag}">
                                                                    {if $row->activeFlag==1}
                                                                        <i class="fa fa-times fa-lg" title="Click to disable"></i>
                                                                    {else}
                                                                        <i class="fa fa-check fa-lg" title="Click to enable"></i>
                                                                    {/if}
                                                                </a>
                                                            {/if}

                                                            {if $action_rights['EDIT-VCLE']>0} 
                                                                <span class="p_l_15">
                                                                <a href="javascript:;" title="edit" {if $row->activeFlag==0}style='display:none'{/if}   class="edat" id='edt_sch_{$row->code}'  onclick='vehiclePopup("{$row->code}")' ><i class="fa fa fa-pencil fa-lg igreen"></i></a>
                                                                </span>
                                                            {/if}

                                                            {if $action_rights['DELETE-VCLE']>0} 
                                                                <span class="p_l_15">
                                                                <a href="javascript:;" title="delete" class="del"  onclick='deleteVehicle("{$row->code}")'><i class="fa fa-trash-o fa-lg ired"></i></a>
                                                                </span>
                                                            {/if}
                                                            {if $action_rights['RESET-VCLE'] > 0} 
                                                                {if $row->activeFlag==1}
                                                                    <span class="p_l_15" onclick='resetVehicle("{$row->code}")' title="Odometer Reset">
                                                                        <a href="javascript:;"  class="myButton" ><i class="fa fa-repeat" aria-hidden="true"></i></a>
                                                                    </span>
                                                                {/if}
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="table table-responsive">
                                        <table class="table none" style="border: 1px dashed #ddd;" id="view-data">
                                            <tbody>
                                                <tr>
                                                    <th>Name</th>
                                                    <td class="name"></td>
                                                    <th>Reg No</th>
                                                    <td class="reg-no"></td>
                                                    {if $is_super_namespace==1}
                                                        <th>Transit Station</th>
                                                        <td class="transit-station"></td>
                                                    {/if}
                                                    <th>Licence No</th>
                                                    <td class="licence-no"></td>
                                                </tr>

                                                <tr>
                                                    <th>Ownership Type</th>
                                                    <td class="ownership"></td>
                                                    <th>Transporter</th>
                                                    <td class="transporter"></td>
                                                    <th>Reg Date</th>
                                                    <td class="reg-date"></td>
                                                    <th>Vehicle Type</th>
                                                    <td class="vehicle-type"></td>
                                                </tr>

                                                <tr>
                                                    <th>Registration State</th>
                                                    <td class="state"></td>
                                                    <th>Purchase Date</th>
                                                    <td class="purchase-date"></td>
                                                    <th>Last FC Date</th>
                                                    <td class="fc-date"></td>
                                                    <th>Brand</th>
                                                    <td class="brand"></td>
                                                </tr>

                                                <tr>
                                                    <th>Model</th>
                                                    <td class="model"></td>
                                                    <th>Fuel</th>
                                                    <td class="fuel"></td>
                                                    <th>Avg Mileage</th>
                                                    <td class="avg-mileage"></td>
                                                    <th>Fuel Tank Capacity</th>
                                                    <td class="fuel-tank-capa"></td>
                                                </tr>

                                                <tr>
                                                    <th>Oil Capacity</th>
                                                    <td class="oil-capa"></td>
                                                    <th>AdBlue Capacity</th>
                                                    <td class="ad-blue-capa"></td>
                                                    <th>Dimension</th>
                                                    <td class="dimension"></td>
                                                    <th>Load Capacity</th>
                                                    <td class="load-capa"></td>
                                                </tr>

                                                <tr>
                                                    <th>GPS Device Code</th>
                                                    <td class="gps-device"></td>
                                                    <th>GPS Vendor Code</th>
                                                    <td class="gps-vendor"></td>
                                                    <th>Status</th>
                                                    <td class="status"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-center">
                                        <button class="btn btn-default none" id="cancel-view" type="button" onclick="cancelView();">Close</button>
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

<div id="vehicle-dialog" class="hide dialog-content-page">
    <div class="clearfix">
        <h4 id="">Add New Vehicle</h4>
    </div>                                     
    <div class="ov_fl_2301" id="vehicle-body">
        <form role="form" id="form1" class="form-horizontal ">
            <div class="row">
                <div class="col-lg-3">
                    <div>
                        <label for="txt_m_name" class="req">Name</label>
                        <input  placeholder="Name" id="name" name="name"  class="form-control">
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="txt_m_name" class="req">Registration Number</label>
                        <input  placeholder="Registration Number" id="reg_no" name="reg_no"  class="form-control" maxlength="15">
                        <span class="text-muted"><i class="fa fa-info-circle"></i> Special characters not allowed (except 0-9, A-Z, blank space).</span>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="txt_m_name" class="req">License Number</label>
                        <input  placeholder="License Number" id="lic_no" name="lic_no"  class="form-control">
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_type" class="req">Vehicle Type</label>
                        <select id="vehicle_type" class="form-control col-md-6">
                            <option value="">Select</option>
                            <option value="TRUCK">Truck</option>
                            <option value="MINITRUCK">Mini Truck</option>
                            <option value="BUS">Bus</option>
                        </select>
                    </div>
                </div> 

                <div class="clear_fix_both"></div>
                <br />
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_own_type" class="">Ownership Type</label>
                        <select id="vehicle_own_type" class="form-control col-md-6">
                            <option value="OWN">Own</option>
                            <option value="ATCH">Attached</option>
                            <option value="HIRE">Hire / Walk-In</option>
                        </select>
                    </div>
                </div> 
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_trans" class="req">Transporter</label>
                        <select id="vehicle_trans" class="form-control col-md-6">
                            <option value="">Select Transporter</option>
                            {foreach name=o item=row from=$contact}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-lg-3">
                    <label for="txt_l_name" class="req">Registration Date</label>
                    <div class="input-group">
                        <input  placeholder="Registration date" id="Rdate" name="Rdate"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
                <input type="hidden" id="code_edit">
                
                
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_state" class="req">Registration State</label>
                        <div class="" id="state-list">
                            <select class="form-control col-md-6" id="sel_state_id" >
                                <option value="">Select a State</option>   
                            </select>
                        </div>
                    </div>
                </div>
                {* <div class="col-lg-3">
                    <div>
                        <label for="adhar" class="req">Adhar No</label>
                        <input type="text" placeholder="Adhar No" id="adhar" class="form-control" maxlength="12">
                    </div>
                </div> *}

                <div class="clear_fix_both"></div>
                <div class="clear_fix_both"></div>
                <br />
                <div class="col-lg-3">
                    <div>
                        <label for="ph_date" class="req">Purchase Date</label>
                        <div class="input-group">
                            <input  placeholder="Purchase Date" id="ph_date" name="ph_date"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="fc_date" class="req">Last FC Date</label>
                        <div class="input-group">
                            <input  placeholder="Last FC Date" id="fc_date" name="fc_date"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_brand" class="req">Brand</label>
                        <select class="form-control col-md-6" id="vehicle_brand">
                            <option value="">Select a Brand</option>
                            {foreach from=$vehicle_brand item=val}
                                <option value="{$val}">{$val}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_model" class="req">Model</label>
                        <input  placeholder="Model" id="vehicle_model" name="model"  class="form-control">
                    </div>
                </div> 

                <div class="clear_fix_both"></div>
                <div class="clear_fix_both"></div>
                <br />
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_fuel" class="">Fuel</label>
                        <select id="vehicle_fuel" class="form-control col-md-6">
                            <option value="DIESEL">Diesel</option>
                            <option value="PETROL">Petrol</option>
                            <option value="GAS">Gas</option>
                            <option value="ELECTRIC">Electric</option>
                        </select>
                    </div>
                </div> 
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_avg_mlg" class="req">Avg.Mileage</label>
                        <input  placeholder="Avg.Mileage" id="vehicle_avg_mlg" name="avgMileage"  class="form-control">
                    </div>
                </div>
                <div class="col-lg-6">
                    <div>
                        <label for="vehicle_length" class="req">Tank Capacity</label>
                        <div class="row">
                            <div class="col-lg-4">
                                <input type="number" placeholder="Fuel Capacity" id="ftank_capacity" name="fuelTank"  class="form-control" maxlength="6">
                                <span class="text-muted"><i class="fa fa-info-circle"></i>Fuel Capacity</span>
                            </div>
                            <div class="col-lg-4">
                                <input type="number" placeholder="Oil Capacity" id="oil_capacity" name="Oil"  class="form-control" maxlength="6">
                                <span class="text-muted"><i class="fa fa-info-circle"></i>Oil Capacity</span>
                            </div>
                            <div class="col-lg-4">
                                <input type="number"  placeholder="Ad Blue Capacity" id="adblue_capacity" name="adBlue"  class="form-control" maxlength="6">
                                <span class="text-muted"><i class="fa fa-info-circle"></i>Ad Blue Capacity</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="clear_fix_both"></div>
                <br />
                <div class="col-lg-3">
                    <div>
                        <label for="load_capacity" class="req">Load Capacity</label>
                        <input type="number" placeholder="Load Capacity" id="load_capacity" name="load"  class="form-control">
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_uom" class="">Load UOM</label>
                        <select id="vehicle_uom" class="form-control col-md-6">
                            <option value="KG">KG</option>
                            <option value="TON">TON</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div>
                        <label for="vehicle_length" class="req">Dimension</label>
                        <div class="row">
                            <div class="col-lg-4">
                                <input type="number" placeholder="Length" id="vehicle_length" name="length"  class="form-control" maxlength="6">
                                <span class="text-muted"><i class="fa fa-info-circle"></i>Length</span>
                            </div>
                            <div class="col-lg-4">
                                <input type="number" placeholder="Width" id="vehicle_width" name="width"  class="form-control" maxlength="6">
                                <span class="text-muted"><i class="fa fa-info-circle"></i>Width</span>
                            </div>
                            <div class="col-lg-4">
                                <input type="number"  placeholder="Height" id="vehicle_height" name="height"  class="form-control" maxlength="6">
                                <span class="text-muted"><i class="fa fa-info-circle"></i>Height</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="clear_fix_both"></div>
                <br />
                <div class="col-lg-3">
                    <div>
                        <label for="txt_m_name" >GPS Device Code</label>
                        <input  placeholder="GPS Device Code" id="gps" name="gps"  class="form-control">
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="txt_oz_name">GPS Device Vendor</label>
                        <select id="gps_vendor" class="form-control col-md-6">                                                                                    
                            {foreach name=o item=row from=$gpsVendors}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach}   
                        </select>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div>
                        <label for="vehicle_tags">Tags</label>
                        <select id="vehicle_tags" class="form-control col-md-6" multiple>
                            {foreach name=o item=row from=$cargotags}
                                <option value="{$row->code}">{$row->name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="clear_fix_both"></div> <br>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="vehicle-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" name="vehicle_code" id="vehicle_code" value="" />
            <input type="hidden" name="vehicle_status" id="vehicle_status" value="1" />
            <button class="btn btn-success" type="button" onclick="saveVehicle();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelVehicle();">Cancel</button>
        </div>
    </div> 
</div>

<div id="import-bits-vehicles" class="dialog-content-page" style="display: none">
    <form class="form-horizontal " action="#">

        <div class="form-group">
            <div>
                <label class="req">Bits Vehciles</label>
                <select class="form-control" id="bits-vehicles" multiple></select>
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>
        <div class="align-center alert alert-danger pull-left" style="display: none;" id="import-bits-vehicles-state"></div>
        <div class="align-right">
            <button type="button" id="btn-save" class="btn btn-success" onclick="saveBitsVehicles()">Save</button>
            <button type="button" class="btn btn-default" onclick="cancelBitsVehicles()">Cancel</button>
        </div>
    </form>
</div>


<div id="edit-transit-dialog" style="display: none">
    <div class="clearfix">
        <b>Change Transit {if $cargo_setting->transitLocationModelCode == 'BRCH'}Branch{else}Station{/if}</b>
        <a href="javascript:;" class="pull-right" onclick="hideTransitBranchDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="edit-transit-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            {if $cargo_setting->transitLocationModelCode == 'BRCH'}
                <div class="col-md-12">
                    <div class="form-group" id="edit-transit-branch-cont">
                        <label for="edit-transit-branch">Choose new transit branch</label>
                        <select id="edit-transit-branch" class="form-control">
                            <option value="">Choose new transit branch</option>
                            {foreach item=org from=$organizations}
                                <option value="{$org->code}">{$org->name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            {else}
                <div class="col-md-12">
                    <div class="form-group" id="edit-transit-branch-cont">
                        <label for="edit-transit-branch">Choose new transit station</label>
                        <select id="edit-transit-branch" class="form-control">
                            <option value="">Choose new transit station</option>
                            {foreach item=station from=$stations}
                                <option value="{$station['code']}">{$station['name']}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            {/if}
            <div class="col-md-12 hide">
                <div class="form-group" id="edit-transit-branch-cont">
                    <label class="req">Remarks</label>
                    <input class="form-control" placeholder="Remarks" id="edit-transit-remarks"/>
                </div>
            </div>
            <div class="col-md-12">
                <div id="edit-transit-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="edit-transit-panel-btn">
                <input type="hidden" id="transit-location-mode" value="{$cargo_setting->transitLocationModelCode}">
                <input type="hidden" id="hid-transit-vehicle">
                <button type="button" class="btn btn-success" onclick="saveTransitBranch();">Save</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideTransitBranchDialog();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>

<script>
    var allVehicleData = {$vehicle|json_encode} 
    $(document).ready(function() {
        $('#Rdate, #ph_date, #fc_date').datepicker({
            todayHighlight: true,
            format: 'yyyy-mm-dd',
            viewMode: "months"

        });

        $('#all-data').DataTable({
            "bPaginate": false,
            "info": false,
            "dom": 'lrt'
        });

        $('.search-box').on( 'input', function () {
            $('#all-data').dataTable().fnFilter($('.search-box').val());
            $('#view-data').addClass('none');
            $('#all-data tbody tr').removeClass('none');
        });

        $('#reg_no').on('input', function(){
            this.value = this.value.replace(/[^a-zA-Z\d\s:]/, '').toUpperCase();
        });
        
        $('.gps-popover').popover({
            container : 'body',
            trigger : 'hover',
            html : 'true'
        });

        $('#vehicle_tags').select2({
            placeholder: 'Select Tags'
        });
        
        $('#edit-transit-branch').select2();

        if ($.ui && $.ui.dialog) {
            $.ui.dialog.prototype._allowInteraction = function(e) {
                return !!$(e.target).closest('.ui-dialog, .ui-datepicker, .select2-drop').length;
            };
        }
    });

    var bitsVehiclelist = [];    
    {literal} 

    $('#bits-vehicles').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        dropLeft: true,
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        buttonClass: 'btn btn-default bits-vehicles',
        buttonContainer: '<div id="bits-vehicles-list-container" class="custom-cb multiselect-inline bits-vehicles"></div>',
        templates: {
            button: '',
            ul: '<ul class="multiselect-container bits-vehicles-list" style="width: 100%;"></ul>',
            li: '<li><label></label></li>',
        }
    });

    $('#vehicle_own_type').on('change', function(event, code){
        var data = {};
        data.entityTypeCode = 'TRANS';
        data.tag = $('#vehicle_own_type').val();

        $('#vehicle_trans').html(new Option('Loading...', '', true, true));

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/get-contact-v2',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    var options = [new Option('Select Transporter', '', true, true)];
                    $.each(response.data || [], function(key, val){
                        options.push(new Option(val.name, val.code));
                    });
                    $('#vehicle_trans').html(options).val(code).trigger('change');
                }
            }
        });
    });

    function sm_loadstates() {
        _getAllStates('state-list', 'dropdown', 'sel_state_id', '', '');
    }

    function view(data) {
        if($('#view-data').hasClass('none')){
            $('#view-data').removeClass('none');
            $('#all-data tbody tr').not('#oz-'+data.code).addClass('none');
            $('#cancel-view').removeClass('none');
            $('.name').text(data.name);
            $('.reg-no').text(data.registationNumber);

            if(data.transitStation.name){
                $('.transit-station').text(data.transitStation.name);
            }else{
                $('.transit-station').text('-');
            }
            $('.state').text(data.state.name);
            $('.gps-device').text(data.gpsDeviceCode);
            $('.gps-vendor').text(data.gpsDeviceVendor.name);
            $('.ownership').text(data.ownershipType.name);
            $('.transporter').text(data.transporterContact.name);
            $('.reg-date').text(moment(data.registrationDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('.purchase-date').text(moment(data.purchaseDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('.fc-date').text(moment(data.lastFcDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('.licence-no').text(data.licNumber);
            $('.bus-type').text();
            $('.vehicle-type').text(data.vehicleType.name);
            $('.avg-mileage').text(data.averageMileage+' Km/Ltr');
            $('.brand').text(data.makeType);
            $('.model').text(data.modelType);
            $('.fuel').text(data.fuelType.name);

            var dimension = data.dimensions.split('|');
            if(dimension[0] != undefined || dimension[1] != undefined || dimension[2] != undefined){
                $('.dimension').text(dimension[0]+'L x '+dimension[1]+'W x '+dimension[2]+'H');
            }else{
                $('.dimension').text('-')
            }

            $('.fuel-tank-capa').text(data.fuelTankCapacity+' Ltr');
            $('.oil-capa').text(data.oilCapacity+' Ltr');
            $('.ad-blue-capa').text(data.adblueCapacity+' Ltr');
            $('.load-capa').text(data.loadCapacity+' Ltr');

            if(data.activeFlag == 1){
                $('.status').html('<span class="label label-success status-label">Active</span>');
            }else{
                $('.status').html('<span class="label label-warning status-label">Disabled</span>');
            }

        }else{
            $('#view-data').addClass('none');
            $('#cancel-view').addClass('none');
            $('#all-data tbody tr').removeClass('none');
            $('.name').text('');
            $('.reg-no').text('');
            $('.transit-station').text('');
            $('.state').text('');
            $('.gps-device').text('');
            $('.gps-vendor').text('');
            $('.ownership').text('');
            $('.transporter').text('');
            $('.reg-date').text('');
            $('.purchase-date').text('');
            $('.fc-date').text('');
            $('.licence-no').text('');
            $('.bus-type').text('');
            $('.vehicle-type').text('');
            $('.avg-mileage').text('');
            $('.brand').text('');
            $('.model').text('');
            $('.fuel').text('');
            $('.dimension').text('');
            $('.fuel-tank-capa').text('');
            $('.oil-capa').text('');
            $('.ad-blue-capa').text('');
            $('.load-capa').text('');
            $('.status').html('');
        }
    }

    function cancelView() {
        $('#view-data').addClass('none');
        $('#cancel-view').addClass('none');
        $('#all-data tbody tr').removeClass('none');
    }

    function importBitsVehicles() {
        $('.inp_error').removeClass('inp_error');
        $('#bits-vehicles-list-container ul').html($('<li/>').html(loading_popup));
        $('#import-bits-vehicles-state').hide();

        $('#import-bits-vehicles').dialog({
            autoOpen: true,
            height: 500,
            width: 600,
            modal: true,
            resizable: false
        });

        $(".ui-dialog-titlebar").hide();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/import-bits-vehicles",
            success: function(response) {
                if (response.status == 1) {
                    bitsVehiclelist = response.data;
                    var options = [];
                    $.each(response.data || [], function (i, v) {
                        var regno = v.registationNumber.replace(/[^a-zA-Z0-9]/g, '');
                        if (!$('[data-registration-number="' + regno + '"]').length) {
                            options.push(new Option(v.registationNumber + ' (' + v.name + ' - ' + v.vehicleType.code + ')', v.code));
                        }
                    });

                    if(options.length == 0) {
                        $('#bits-vehicles-list-container ul').html('<li><div class="well well-large">No Vehicles Found</div></li>');
                    } else {
                        $('#bits-vehicles').html(options).multiselect('rebuild');
                    }
                } else {
                    $('#import-bits-vehicles-state').removeClass('alert-success').addClass('alert-danger');
                    $('#import-bits-vehicles-state').html(response.errorDesc);
                    $('#import-bits-vehicles-state').show();                    
                }
            }
        });
    }

    function cancelBitsVehicles() {
        $('#import-bits-vehicles').dialog('destroy');
        $('#import-bits-vehicles').hide();
    }

    function saveBitsVehicles() {        
        var err = 0;
        var data = {};
        data.vehicleList = [];

        $.each(bitsVehiclelist || [], function (i, v) {
            if($('#bits-vehicles [value="' + v.code + '"]').is(':selected')) {
                data.vehicleList.push(v);
            }
        });

        $('.inp_error').removeClass('inp_error');

        if ((data.vehicleList || []).length == 0) {
            $("ul.bits-vehicles-list").addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#import-bits-vehicles-state').removeClass('alert-success').addClass('alert-danger');
            $('#import-bits-vehicles-state').html('Please enter the values in the field that are marked in red');
            $('#import-bits-vehicles-state').show();
            return false;
        }
        $('#import-bits-vehicles-state').removeClass('alert-success alert-danger');
        $('#import-bits-vehicles-state').html(loading_popup);
        $('#import-bits-vehicles-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/save-bits-vehicles",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#import-bits-vehicles-state').removeClass('alert-danger').addClass('alert-success');
                    $('#import-bits-vehicles-state').show();
                    $('#import-bits-vehicles-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelBitsVehicles();
                        checkURL();
                    }, 2000);
                } else {
                    $('#import-bits-vehicles-state').removeClass('alert-success').addClass('alert-danger');
                    $('#import-bits-vehicles-state').html(response.errorDesc);
                    $('#import-bits-vehicles-state').show();
                }
            }
        });
    }

    function editTransitDialog(vehicleCode, stationCode = '', organizationCode = '') {
        event && event.stopPropagation();
        $('#edit-transit-dialog').removeClass('hide');
        $('#edit-transit-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();

        if ($('#transit-location-mode').val() == 'BRCH') {
            $('#edit-transit-branch').val(organizationCode).trigger('change');
        } else {
            $('#edit-transit-branch').val(stationCode).trigger('change');
        }
        $('#hid-transit-vehicle').val(vehicleCode);
        $('#edit-transit-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html('');
    }

    function hideTransitBranchDialog() {
        $('#edit-transit-dialog').dialog('destroy');
        $('#edit-transit-dialog').hide();
    }

    function saveTransitBranch() {
        var data = {}, err = 0;
        data.vehicleCode = $('#hid-transit-vehicle').val();

        if ($('#transit-location-mode').val() == 'BRCH') {
            data.organizationCode = $('#edit-transit-branch').val();
        } else {
            data.stationCode = $('#edit-transit-branch').val();
        }

        $('.inp_error').removeClass('inp_error');
        if(err) {
            $('#edit-transit-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#edit-transit-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }
        $('#edit-transit-panel-btn').hide();
        $('#edit-transit-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/reset-vehicle-transit-station",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#edit-transit-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hideTransitBranchDialog();
                        checkURL();
                    }, 1500);
                } else {
                    $('#edit-transit-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#edit-transit-panel-btn').show();
                }
            }
        })
    }
    {/literal}
</script>

