<link rel="stylesheet" href="assets/lib/magnific-popup/magnific-popup.css"> 
<div class="brand_top">
    <h3>Vehicle Driver</h3>
    <span class="align-right">
        {if $is_super_namespace==1}<button class="btn btn-primary" onclick="importBitsDrivers()">Import Bits Drivers</button>{/if}
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showDriverDialog();">Add Driver</a>
    </span>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12">
                <!-- PAGE HEADER-->
                <div class="row">
                    <div style="clear: both;"></div><br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body" style="padding-bottom: 0;">
                                <div class="input-group pull-right table_filters" style="width: 25%;">
                                    <input type="search" class="form-control search-box" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
                                    <span class="input-group-addon point_cur" id="search-btn">
                                        <i class="fa fa-search"></i>
                                    </span>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover" id="dri-all-data">
                                        <thead>
                                            <tr class="bold">
                                                <th>Name</th>
                                                <th>Employee Code</th>
                                                <th>Mobile No</th>
                                                <th>License No</th>
                                                <th>Badge No</th>
                                                <th>Join Date</th>
                                                <th>DOB</th>
                                                <th>Ownership Type</th>
                                                <th>Emer No</th>
                                                <th>Licence Exire on</th>
                                                <th>Blood Group</th>
                                                <th>Remarks</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach item=row from=$driver}
                                                <tr id="driver-{$row->code}" class="no-wrap point_cur" data-drv-mobile="{$row->mobileNumber}" onclick="view({$row|json_encode|escape})">
                                                    <td>{$row->name} {$row->lastName}</td>
                                                    <td>{$row->employeeCode}</td>
                                                    <td>{$row->mobileNumber}</td>
                                                    <td>{$row->licenseNumber}</td>
                                                    <td>{$row->badgeNumber}</td>
                                                    <td>{$row->joiningDate|date_format:$ns_date_format}</td>
                                                    <td>{$row->dateOfBirth|date_format:$ns_date_format}</td>
                                                    <td>{$row->ownershipType->name}</td>
                                                    <td>{$row->emergencyContactNumber}</td>
                                                    <td>{$row->licenseExpiryDate|date_format:$ns_date_format}</td>
                                                    <td>{$row->bloodGroup}</td>
                                                    <td>{$row->remarks}</td>
                                                    <td>
                                                        <span class="sp_action">
                                                            <a href="javascript:;" onclick="editDriverMode('{$row->code}', {if $row->activeFlag == 1}0{else}9{/if});">
                                                                {if $row->activeFlag==1}
                                                                    <i class="fa fa-times fa-lg" title="Click to disable"></i>
                                                                {else}
                                                                    <i class="fa fa-check fa-lg" title="Click to enable"></i>
                                                                {/if}
                                                            </a>
                                                        </span>
                                                        {if $row->activeFlag==1}
                                                            <span class="p_l_15">
                                                                <a href="javascript:;" title="Edit" onclick="showDriverDialog('{$row->code}');"><i class="fa fa fa-pencil fa-lg"></i></a>
                                                            </span>
                                                        {/if}
                                                        <span class="p_l_15">
                                                            <a href="javascript:;" title="Delete" onclick="editDriverMode('{$row->code}');"><i class="fa fa-trash-o fa-lg"></i></a>
                                                        </span>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            {* </div> *}
                                <div class=" none p_t_n" id="dri-view-data">
                                    <ul class="nav nav-tabs" >
                                        <li class="active"><a data-toggle="tab" id="ven-rem-det" href="#remaining-details">Remaining Details</a></li>
                                        <li><a data-toggle="tab" id="ven-tariff" href="#bnk">Bank Details</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="remaining-details" class="tab-pane fade in active">
                                            <div class="table table-responsive">
                                                <table class="table table-borderless" style="border: 1px dashed #ddd;" id="dri-rem-det-table">
                                                    <tbody>
                                                        <tr>
                                                            <th>Name</th>
                                                            <td class="name"></td>
                                                            <th>Last Name</th>
                                                            <td class="last-name"></td>
                                                            <th>Ownership Type</th>
                                                            <td class="own-type"></td>
                                                            <th>Transporter</th>
                                                            <td class="transporter"></td>
                                                        </tr>

                                                        <tr>
                                                            <th>Employee Code</th>
                                                            <td class="emp-code"></td>
                                                            <th>Mobile</th>
                                                            <td class="mob"></td>
                                                            <th>Emergency / Alternate Mobile</th>
                                                            <td class="alt-mob"></td>
                                                            <th>Email Id</th>
                                                            <td class="email"></td>
                                                        </tr>

                                                        <tr>
                                                            <th>DOB</th>
                                                            <td class="dob" style="vertical-align: baseline;"></td>
                                                            <th>Address</th>
                                                            <td class="address" style="width: 25%;word-break: break-word;"></td>
                                                            <th>Join Date</th>
                                                            <td class="join-date" style="vertical-align: baseline;"></td>
                                                            <th>License No</th>
                                                            <td class="lic-no" style="vertical-align: baseline;"></td>
                                                        </tr>

                                                        <tr>
                                                            <th>Licence Expire on</th>
                                                            <td class="lic-exp" ></td>
                                                            <th>Badge No</th>
                                                            <td class="bdge"></td>
                                                            <th>Qualification</th>
                                                            <td class="qualification"></td>
                                                            <th>Blood Group</th>
                                                            <td class="blood-grp"></td>
                                                        </tr>

                                                        <tr>
                                                            <th>Tags</th>
                                                            <td class="tag"></td>
                                                            <th>Remarks</th>
                                                            <td class="remarks" colspan="3"></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div id="bnk" class="tab-pane fade">
                                            <button class="btn btn-success  btn-sm none pull-right" id="add-bank-btn" onclick="showBankDialog();">Add Bank Details</button>
                                            <div class="table table-responsive" id="bank-details">
                                            
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <button class="btn btn-default none btn-sm" id="cancel-view" type="button" onclick="cancelView();">Close</button>
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
<div id="vehicle-driver-dialog" class="hide dialog-content-page">
    <div class="col-lg-12">
        <div>
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" id="driver-details-link" href="#driver-details">Basic info</a></li>
                <li><a data-toggle="tab" id="driver-gallery-link" href="#driver-gallery" onclick="getDriverGallery()">Photos</a></li>
            </ul>
            <div class="tab-content">
                <div id="driver-details" class="tab-pane fade in active">
                    <form role="form" class="form-horizontal" id="vehicle-driver">
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-name" class="req">Name</label>
                                <input type="text" placeholder="Name" id="dri-name" maxlength="30" class="form-control">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n ">
                            <div>
                                <label for="dri-lname" class="">Last Name</label>
                                <input type="text" placeholder="Last Name" id="dri-lname" maxlength="30" class="form-control">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri_own_type" class="">Ownership Type</label>
                                <select id="dri_own_type" class="form-control col-md-6">
                                    <option value="OWN">Own</option>
                                    <option value="ATCH">Attached</option>
                                    <option value="HIRE">Hire / Walk-In</option>
                                </select>
                            </div>
                        </div> 
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri_trans" class="req">Transporter</label>
                                <select id="dri_trans" class="form-control col-md-6">
                                    <option value="">Select Transporter</option>
                                    {foreach name=o item=row from=$contact}
                                        <option value="{$row->code}">{$row->name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-emp-code">Employee Code</label>
                                <input type="text" placeholder="Employee Code" id="dri-emp-code" class="form-control">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-mob" class="req">Mobile</label>
                                <input type="text" placeholder="Mobile" id="dri-mob" class="form-control" maxlength="10">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-emer" class="req">Emergency / Alternate Mobile</label>
                                <input type="text" placeholder="Alternate Mobile" id="dri-emer" class="form-control" maxlength="10">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-dob"  class="req">DOB</label>
                                <div class="col-md-4 p_l_n p_r_n">
                                    <select class="form-control" id="dri-dob-dd">
                                        <option value="">-</option>
                                        {for $i=1 to 31}
                                            <option val="{$i}">{$i}</option>
                                        {/for}
                                    </select>
                                </div>
                                <div class="col-md-4 p_l_n p_r_n">
                                    <select class="form-control col-md-4" id="dri-dob-mm">
                                        <option value="">-</option>
                                        {for $i=1 to 12}
                                            <option val="{$i}">{$i}</option>
                                        {/for}
                                    </select>
                                </div>
                                <div class="col-md-4 p_l_n p_r_n">
                                    <select class="form-control col-md-4" id="dri-dob-yy">
                                        <option value="">-</option>
                                        {for $i=1950 to 2000}
                                            <option val="{$i}">{$i}</option>
                                        {/for}
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-12 p_l_n">
                            <div>
                                <label for="dri-address" class="">Address</label>
                                <textarea id="dri-address" class="form-control" maxlength="75" placeholder="Address" style="resize: none;" ></textarea>
                            </div>
                        </div>

                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri_city" class="req">City</label>
                                <select id="dri_city" class="form-control">
                                    <option value="">Select a City</option>
                                    {foreach item=station from=$stations}
                                        <option value="{$station['code']}">{$station['name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri_state" class="req">State</label>
                                <div class="" id="state-list">
                                    <select class="form-control col-md-6" id="sel_state_id" >
                                        <option value="">Select a State</option>   
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri_pincode" class="req">Pincode</label>
                                <input type="text" class="form-control" id="dri_pincode" maxlength="6">
                            </div>
                        </div>
                        {* <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-bank-details">Bank Account</label>
                                <select id="dri-bank-details" class="form-control" multiple>
                                    {foreach name=o item=row from=$cargotags}
                                        <option value="{$row->code}">{$row->name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div> *}
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-adhar" class="req">Adhar No</label>
                                <input type="text" placeholder="Adhar No" id="dri-adhar" class="form-control" maxlength="12">
                            </div>
                        </div>

                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-email" class="req">Email Id</label>
                                <input type="email" placeholder="Email" id="dri-email" class="form-control">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-joining" class="req">Join Date</label>
                                <input type="text" placeholder="Joining Date" id="dri-joining" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-licence" class="req">License No</label>
                                <input type="text" placeholder="License No" id="dri-licence" maxlength="30" class="form-control initialism">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-licencedate" class="req">Licence Expire on</label>
                                <input type="text" placeholder="Licence Exire on" id="dri-licencedate" class="form-control" readonly>
                            </div>
                        </div>

                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-licence" class="req">Badge No</label>
                                <input type="text" placeholder="Badge No" id="dri-badge" maxlength="30" class="form-control initialism">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-quali" class="">Qualification</label>
                                <input type="text" placeholder="Qualification" id="dri-quali" maxlength="30" class="form-control">
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-blood" class="">Blood Group</label>
                                <select class="form-control" id="dri-blood">
                                    <option value="">Select</option>
                                    <option value="O−">O−</option>
                                    <option value="O+">O+</option>
                                    <option value="A−">A−</option>
                                    <option value="A+">A+</option>
                                    <option value="B−">B−</option>
                                    <option value="B+">B+</option>
                                    <option value="AB−">AB−</option>
                                    <option value="AB+">AB+</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 p_l_n">
                            <div>
                                <label for="dri-tags">Tags</label>
                                <select id="dri-tags" class="form-control" multiple>
                                    {foreach name=o item=row from=$cargotags}
                                        <option value="{$row->code}">{$row->name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>

                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-12 p_l_n">
                            <div>
                                <label for="dri-remarks" class="">Remarks</label>
                                <textarea id="dri-remarks" class="form-control" maxlength="75" placeholder="Remarks" style="resize: none;" ></textarea>
                            </div>
                        </div>
                        <div class="clear_fix_both"></div> <br>
                        <input type="hidden" id="hid-dri-code">
                    </form>
                    <div class="clear_fix_both"></div>
                    <div class="clear_fix_both">
                        <div class="alert fl suc_cre" style="display: none;" id="vehicle-driver-action-state"></div>
                        <div class="align-right cre_sve" id="form-bttons">
                            <button class="btn btn-success" type="button" onclick="saveVehicleDriver();">Save</button>
                            <button class="btn btn-default" type="button" onclick="cancelVehicleDriver();">Cancel</button>
                        </div>
                    </div>
                </div>
                <div id="driver-gallery" class="tab-pane fade">
                    <div>
                        <div class="align-center" id="user-action-status"></div>
                        <div class="row" id="gal-viw-rslt">
                            <div>
                                <div class="well well-large "> Click any of the driver name to view photos.</div>
                            </div>
                        </div>
                        <div class="clear_fix_both"></div>
                        <div class="align-right" id="form-bttons">
                            <button class="btn btn-default" type="button" onclick="cancelVehicleDriver();">Cancel</button>
                        </div>
                    <div class="clear_fix_both"></div><br/>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="dri-bank-dialog" class="hide dialog-content-page">
    <form role="form" id="form1" class="form-horizontal ">
        <div class="row">
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="dri-acc-name" class="req">Acc Holder Name</label>
                    <input type="text" placeholder="Acc Holder Name" id="dri-acc-name" class="form-control">
                </div>
            </div>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="dri-acc-no" class="req">Account No</label>
                    <input type="text" placeholder="Account No" id="dri-acc-no" class="form-control">
                </div>
            </div>

            <div class="clear_fix_both"></div> <br>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="dri-ifc" class="req">IFSC Code</label>
                    <input type="text" placeholder="IFSC Code" id="dri-ifc" class="form-control">
                </div>
            </div>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="dri-bank-name" class="req">Bank Name</label>
                    <input type="text" placeholder="Bank Name" id="dri-bank-name" class="form-control">
                </div>
            </div>

            <div class="clear_fix_both"></div> <br>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="dri-branch" class="req">Branch Location</label>
                    <input type="text" placeholder="Branch location" id="dri-branch" class="form-control">
                </div>
            </div>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="dri-acc-type" class="req">Acc Type</label>
                    <select id="dri-acc-type" class="form-control">
                        <option value="">Select</option>
                        <option value="CURR">Current Account</option>
                        <option value="SVGS">Savings Account</option>
                        <option value="SLRY">Salary Account</option>
                    </select>
                </div>
            </div>

            <div class="clear_fix_both"></div> <br>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="dri-upi" class="req">UPI ID</label>
                    <input type="text" placeholder="UPI ID" id="dri-upi" class="form-control">
                </div>
            </div>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="dri-entity" class="req">Bank entity type</label>
                    <select id="dri-entity" class="form-control">
                        <option value="">Select</option>
                        <option value="TRANS">Transporter</option>
                        <option value="DRVR">Driver</option>
                        <option value="SPLR">Supplier</option>
                        <option value="BRCH">Branch</option>
                        <option value="RAC">Registered Account Customer</option>
                    </select>
                </div>
            </div>
            <input type="hidden" id="hid-dri-bank-code">
            <div class="clear_fix_both"></div> <br>                    
            <div class="alert fl suc_cre" style="display: none;" id="dri-bank-state"></div>
            <div class="align-right">
                <button class="btn btn-success" type="button" onclick="saveBankDetail();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelBankDialog();">Cancel</button>
            </div>
        </div>
    </form>
</div>

<div id="import-bits-drivers" class="dialog-content-page" style="display: none">
    <form class="form-horizontal " action="#">

        <div class="form-group">
            <div>
                <label class="req">Bits Drivers</label>
                <select class="form-control" id="bits-drivers" multiple></select>
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>
        <div class="align-center alert alert-danger pull-left" style="display: none;" id="import-bits-drivers-state"></div>
        <div class="align-right">
            <button type="button" id="btn-save" class="btn btn-success" onclick="saveBitsDrivers()">Save</button>
            <button type="button" class="btn btn-default" onclick="cancelBitsDrivers()">Cancel</button>
        </div>
    </form>
</div>

<script>
    var vehicleDriver = {$driver|json_encode};
    var bitsDriverlist = []; 

    $('#dri-joining').datepicker({
        todayHighlight: true,
        endDate: '-0d',
        autoclose: true,
        format: 'yyyy-mm-dd'
    });
    $('#dri-licencedate').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        autoclose: true,
        format: 'yyyy-mm-dd'
    });

    $('#dri-all-data').dataTable({
        "bPaginate": false,
        "info": false,
        "dom": 'lrt'
    });

    $('.search-box').on( 'input', function () {
        $('#dri-all-data').dataTable().fnFilter($('.search-box').val());
        $('#dri-view-data').addClass('none');
        $('#dri-all-data tbody tr').removeClass('none');
    });

    $('#bits-drivers').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        dropLeft: true,
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        buttonClass: 'btn btn-default bits-drivers',
        buttonContainer: '<div id="bits-drivers-list-container" class="custom-cb multiselect-inline bits-drivers"></div>',
        templates: {
            button: '',
            ul: '<ul class="multiselect-container bits-drivers-list" style="width: 100%;"></ul>',
            li: '<li><label></label></li>',
        }
    });
    $('#dri-tags').select2({
        placeholder: 'Select Tags'
    });

    $('#dri-bank-details').select2({
        placeholder: 'Select Bank Account'
    });

    $('#dri_own_type').on('change', function(event, code){
        var data = {};
        data.entityTypeCode = 'TRANS';
        data.tag = $('#dri_own_type').val();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/get-contact',
            data: data,
            success: function (response) {
                if(response.status == 1){
                    var res = response.data;
                    $('#dri_trans').empty().append(function(){
                        return '<option value="">Select Transporter</option>' + $.map(res, function(val, key){
                            return '<option value="'+val.code+'">'+val.name+'</option>';
                        });
                    });
                    $('#dri_trans').val(code);
                }
            }
        });
    });

    function sm_loadstates() {
        _getAllStates('state-list', 'dropdown', 'sel_state_id', '', '');
    }

    function view(get_data) {
        if($('#dri-view-data').hasClass('none') || $('#dri-bank-data').hasClass('none')){
            $('#hid-dri-code').val(get_data.code);
            $('#dri-view-data').removeClass('none');
            $('#dri-bank-data').removeClass('none');
            $('#add-bank-btn').removeClass('none');
            $('#cancel-view').removeClass('none');
            $('#dri-all-data tbody tr').not('#driver-'+get_data.code).addClass('none');
            $('.name').text(get_data.name);
            $('.last-name').text(get_data.lastName);
            $('.transporter').text(get_data.transporterContact.name);
            $('.emp-code').text(get_data.employeeCode);
            $('.mob').text(get_data.mobileNumber);
            $('.alt-mob').text(get_data.emergencyContactNumber);
            $('.email').text(get_data.email);
            $('.dob').text(moment(get_data.dateOfBirth, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('.address').text(get_data.address + ', ' + get_data.station.name + ', ' + get_data.state.name + ' - ' + get_data.pincode);
            $('.city').text(get_data.station.name);
            $('.state').text(get_data.state.name);
            $('.pin').text(get_data.pincode);
            //$('.bank-acc').text(get_data.bankDetails.map(i => i.name));
            $('.join-date').text(moment(get_data.joiningDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('.lic-no').text(get_data.licenseNumber);
            $('.lic-exp').text(moment(get_data.licenseExpiryDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
            $('.bdge').text(get_data.badgeNumber);
            $('.qualification').text(get_data.qualification);
            $('.blood-grp').text(get_data.bloodGroup);
            $('.own-type').text(get_data.ownershipType.name);
            $('.tag').text(get_data.tag.map(i => i.code));
            $('.remarks').text(get_data.remarks);

            var data = {};
            data.code = get_data.code;
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'config/get-bank-detail',
                data: data,
                success: function (response) {
                    $('#bank-details').html(response);
                    $('#bank-details-table').removeClass('none')
                }
            });

        }else{
            $('#dri-view-data').addClass('none');
            $('#dri-bank-data').addClass('none');
            $('#add-bank-btn').addClass('none');
            $('#bank-details-table').addClass('none');
            $('#cancel-view').addClass('none');
            $('#dri-all-data tbody tr').removeClass('none');
            $('.name').text('');
            $('.last-name').text('');
            $('.transporter').text('');
            $('.emp-code').text('');
            $('.mob').text('');
            $('.alt-mob').text('');
            $('.email').text('');
            $('.dob').text('');
            $('.address').text('');
            $('.city').text('');
            $('.state').text('');
            $('.pin').text('');
            $('.bank-acc').text('');
            $('.join-date').text('');
            $('.lic-no').text('');
            $('.lic-exp').text('');
            $('.bdge').text('');
            $('.qualification').text('');
            $('.blood-grp').text('');
            $('.own-type').text('');
            $('.tag').text('');
            $('.remarks').text('');
        }
    }

    function cancelView() {
        $('#dri-view-data').addClass('none');
        $('#dri-bank-data').addClass('none');
        $('#add-bank-btn').addClass('none');
        $('#bank-details-table').addClass('none')
        $('#dri-all-data tbody tr').removeClass('none');
        $('#cancel-view').addClass('none');
    }

    function showDriverDialog(code) {
        event && event.stopPropagation();

        $('.inp_error').removeClass('inp_error');
        $('#driver-details-link').trigger('click');
        $('#vehicle-driver-action-state').hide();
        $('#vehicle-driver-dialog').css('background', '#fff');
        $('#vehicle-driver-dialog').removeClass('hide');
        $('#vehicle-driver-dialog').dialog({
            autoOpen: true,
            height: 620,
            width: 950,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        if (_isdefined(code)) {
            var data = vehicleDriver.find(function (e) {
                return e.code == code;
            });
            var dob = data.dateOfBirth.split('-');
            $('#hid-dri-code').val(data.code);
            $('#dri-name').val(data.name);
            $('#dri-lname').val(data.lastName);
            $('#dri-dob-dd').val(Number(dob[2]));
            $('#dri-dob-mm').val(Number(dob[1]));
            $('#dri-dob-yy').val(Number(dob[0]));
            $('#dri-joining').val(data.joiningDate);
            $('#dri-mob').val(data.mobileNumber);
            $('#dri-emer').val(data.emergencyContactNumber);
            $('#dri-licence').val(data.licenseNumber);
            $('#dri-licencedate').val(data.licenseExpiryDate);
            $('#dri-badge').val(data.badgeNumber);
            $('#dri-quali').val(data.qualification);
            $('#dri-blood').val(data.bloodGroup);
            $('#dri-remarks').val(data.remarks);
            $('#dri-emp-code').val(data.employeeCode);
            $('#dri-tags').val(data.tag.map(i => i.code)).trigger('change');
            $('#dri-adhar').val(data.aadharNo);
            $('#dri-email').val(data.email);
            $('#dri_own_type').val(data.ownershipType.code).trigger('change', data.transporterContact.code);
            //$('#dri_trans').val(data.transporterContact.code).trigger('change');
            $('#dri-address').val(data.address);
            $('#dri_city').val(data.station.code).trigger('change');
            $('#sel_state_id').val(data.state.code).trigger('change');
            $('#dri_pincode').val(data.pincode);
            //$('#dri-bank-details').val(data.bankDetails.map(i => i.code)).trigger('change');
            $('#driver-gallery-link').show();
        } else {
            $('#hid-dri-name').val('');
            $('#dri-name').val('');
            $('#dri-lname').val('');
            $('#dri-dob-dd,#dri-dob-mm,#dri-dob-yy').val('');
            $('#dri-joining').val('');
            $('#dri-mob').val('');
            $('#dri-emer').val('');
            $('#dri-licence').val('');
            $('#dri-licencedate').val('');
            $('#dri-badge').val('');
            $('#dri-quali').val('');
            $('#dri-blood').val('');
            $('#dri-remarks').val('');
            $('#dri_own_type').val('OWN').trigger('change');
            $('#dri_trans').val('')
            $('#dri-adhar').val('');
            $('#dri-email').val('');
            $('#dri-address').val('');
            $('#dri_city').val('');
            $('#sel_state_id').val('');
            $('#dri_pincode').val('');
            $('#dri-bank-details').val([]).trigger('change');
            $('#dri-emp-code').val('');
            $('#dri-tags').val([]).trigger('change');
            $('#driver-gallery-link').hide();
        }
    }

    function cancelVehicleDriver() {
        $('#vehicle-driver-dialog').dialog('destroy');
        $('#vehicle-driver-dialog').hide();
    }

    function showBankDialog(code) {
        event && event.stopPropagation();

        $('.inp_error').removeClass('inp_error');
        $('#dri-bank-state').hide();
        $('#dri-bank-dialog').css('background', '#fff');
        $('#dri-bank-dialog').removeClass('hide');
        $('#dri-bank-dialog').dialog({
            autoOpen: true,
            height: 445,
            width: 720,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        if (_isdefined(code)) {
            var data = JSON.parse(code)
            
            $('#hid-dri-bank-code').val(data.code);
            $('#dri-acc-name').val(data.name);
            $('#dri-acc-no').val(data.accountNumber);
            $('#dri-ifc').val(data.ifscCode);
            $('#dri-bank-name').val(data.bankName);
            $('#dri-branch').val(data.branchLocation);
            $('#dri-acc-type').val(data.accountType.code).trigger('change');
            $('#dri-upi').val(data.upiId);
            $('#dri-entity').val(data.entityType.code).trigger('change');
        } else {
            $('#dri-acc-name').val('');
            $('#dri-acc-no').val('');
            $('#dri-ifc').val('');
            $('#dri-bank-name').val('');
            $('#dri-branch').val('');
            $('#dri-acc-type').val('').trigger('change');
            $('#dri-upi').val('');
            $('#dri-entity').val('').trigger('change');
        }
    }

    function cancelBankDialog() {
        $('#dri-bank-dialog').dialog('destroy');
        $('#dri-bank-dialog').hide();
    }

    function saveVehicleDriver() {
        var data = {}, err = 0;

        data.code = $.trim($('#hid-dri-code').val());
        data.name = $.trim($('#dri-name').val());
        data.lastName = $.trim($('#dri-lname').val());
        data.employeeCode = $.trim($('#dri-emp-code').val());
        data.dateOfBirth = $('#dri-dob-yy').val() + '-' + $('#dri-dob-mm').val() + '-' + $('#dri-dob-dd').val();
        data.joiningDate = $.trim($('#dri-joining').val());
        data.mobileNumber = $.trim($('#dri-mob').val());
        data.emergencyContactNumber = $.trim($('#dri-emer').val());
        data.licenseNumber = $.trim($('#dri-licence').val()).toUpperCase();
        data.licenseExpiryDate = $.trim($('#dri-licencedate').val());
        data.badgeNumber = $.trim($('#dri-badge').val()).toUpperCase();
        data.qualification = $.trim($('#dri-quali').val());
        data.bloodGroup = $.trim($('#dri-blood').val());
        data.remarks = $.trim($('#dri-remarks').val());
        data.tag = $.map($('#dri-tags').val() || [], (tag) => ({ code: tag}));

        data.aadharNo = $('#dri-adhar').val();
        data.email = $.trim($('#dri-email').val());

        data.ownershipType = {};
        data.ownershipType.code = $('#dri_own_type').val();
        
        data.transporterContact = {};
        data.transporterContact.code = $('#dri_trans').val();

        data.address = $.trim($('#dri-address').val());

        data.station = {};
        data.station.code = $('#dri_city').val();

        data.state = {};
        data.state.code = $('#sel_state_id').val();

        data.pincode = $.trim($('#dri_pincode').val());
        //data.bankDetails = $.map($('#dri-bank-details').val() || [], (bankDetails) => ({ code: bankDetails }));
        data.activeFlag = 1;

        $('.inp_error').removeClass('inp_error');

        if (data.name == '') {
            $('#dri-name').addClass('inp_error');
            err++;
        }
        if (data.mobileNumber.length != 10 || isNaN(data.mobileNumber)) {
            $('#dri-mob').addClass('inp_error');
            err++;
        }
        if (data.emergencyContactNumber.length != 10 || isNaN(data.emergencyContactNumber)) {
            $('#dri-emer').addClass('inp_error');
            err++;
        }
        if (data.joiningDate == '') {
            $('#dri-joining').addClass('inp_error');
            err++;
        }
        if (data.licenseNumber == '') {
            $('#dri-licence').addClass('inp_error');
            err++;
        }
        if (data.licenseExpiryDate == '') {
            $('#dri-licencedate').addClass('inp_error');
            err++;
        }
        if (data.badgeNumber == '') {
            $('#dri-badge').addClass('inp_error');
            err++;
        }
        if ($('#dri_city').val() == '') {
            $('#dri_city').addClass('inp_error');
            err++;
        }
        if ($('#sel_state_id').val() == '') {
            $('#sel_state_id').addClass('inp_error');
            err++;
        }
        if (data.pincode == '') {
            $('#dri_pincode').addClass('inp_error');
            err++;
        }
        if (data.email == '') {
            $('#dri-email').addClass('inp_error');
            err++;
        }
        if (data.aadharNo == '') {
            $('#dri-adhar').addClass('inp_error');
            err++;
        }
        if ($('#dri-dob-yy').val() == '') {
            $('#dri-dob-yy').addClass('inp_error');
            err++;
        }
        if ($('#dri-dob-mm').val() == '') {
            $('#dri-dob-mm').addClass('inp_error');
            err++;
        }
        if ($('#dri-dob-dd').val() == '') {
            $('#dri-dob-dd').addClass('inp_error');
            err++;
        }
        if($('#dri_trans').val() == ''){
            $('#dri_trans').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#vehicle-driver-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vehicle-driver-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vehicle-driver-action-state').show();
            return false;
        } else {
            $('#vehicle-driver-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vehicle-driver-action-state').hide();
        }

        $('#vehicle-driver-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#vehicle-driver-action-state').html(loading_popup);
        $('#vehicle-driver-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/update-vehicle-driver',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#vehicle-driver-action-state').removeClass('alert-danger');
                    $('#vehicle-driver-action-state').addClass('alert-success');
                    $('#vehicle-driver-action-state').html('Your request has been completed successfully');
                    setTimeout(function () {
                        cancelVehicleDriver();
                        checkURL();
                    }, 3000);
                } else {
                    $('#vehicle-driver-action-state').addClass('alert-danger');
                    $('#vehicle-driver-action-state').html(response.errorDesc);
                }
            }
        });
    }

    function saveBankDetail() {
        var data = {}, err = 0;

        data.code = $.trim($('#hid-dri-bank-code').val());
        data.name = $.trim($('#dri-acc-name').val());
        data.accountNumber = $.trim($('#dri-acc-no').val());
        data.referenceCode = $('#hid-dri-code').val();

        data.accountType = {};
        data.accountType.code = $('#dri-acc-type').val();

        data.entityType = {};
        data.entityType.code = $('#dri-entity').val();

        data.bankName = $.trim($('#dri-bank-name').val());
        data.branchLocation = $.trim($('#dri-branch').val());
        data.ifscCode = $.trim($('#dri-ifc').val());
        data.upiId = $.trim($('#dri-upi').val());
        data.activeFlag = 1;

        $('.inp_error').removeClass('inp_error');

        if (data.name == '') {
            $('#dri-acc-name').addClass('inp_error');
            err++;
        }
        if (data.accountNumber == '') {
            $('#dri-acc-no').addClass('inp_error');
            err++;
        }
        if (data.accountType == '') {
            $('#dri-acc-type').addClass('inp_error');
            err++;
        }
        if (data.entityType == '') {
            $('#dri-entity').addClass('inp_error');
            err++;
        }
        if (data.bankName == '') {
            $('#dri-bank-name').addClass('inp_error');
            err++;
        }
        if (data.branchLocation == '') {
            $('#dri-branch').addClass('inp_error');
            err++;
        }
        if (data.ifscCode == '') {
            $('#dri-ifc').addClass('inp_error');
            err++;
        }
        if (data.upiId == '') {
            $('#dri-upi').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#dri-bank-state').removeClass('alert-success').addClass('alert-danger');
            $('#dri-bank-state').html('Please enter/select the values in the field that are marked in red');
            $('#dri-bank-state').show();
            return false;
        } else {
            $('#dri-bank-state').removeClass('alert-success').removeClass('alert-danger');
            $('#dri-bank-state').hide();
        }

        $('#dri-bank-state').removeClass('alert-danger').removeClass('alert-success');
        $('#dri-bank-state').html(loading_popup);
        $('#dri-bank-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/add-bank-details',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#dri-bank-state').removeClass('alert-danger');
                    $('#dri-bank-state').addClass('alert-success');
                    $('#dri-bank-state').html('Your request has been completed successfully');
                    setTimeout(function () {
                        cancelBankDialog();
                        checkURL();
                    }, 3000);
                } else {
                    $('#dri-bank-state').addClass('alert-danger');
                    $('#dri-bank-state').html(response.errorDesc);
                }
            }
        });
    }

    function deleteBankDetail(code, flag = 2) {
        event && event.stopPropagation();

        var data = JSON.parse(code)
        data.activeFlag = flag;

        if (flag == 2 && !confirm('Do you want to delete this Bank Account?')) {
            return;
        }

        var loading_overlay = iosOverlay({
            text: 'Loading',
            icon: 'fa fa-spinner fa-spin'
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: 'config/add-bank-details',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: 'fa fa-check',
                        text: 'Success!'
                    });
                } else {
                    loading_overlay.update({
                        icon: 'fa fa-times',
                        text: 'Sorry!'
                    });
                }
                setTimeout(function () {
                    loading_overlay.hide();
                    checkURL();
                }, 2000);
            }
        });
    }

    function editDriverMode(code, flag = 2) {
        event && event.stopPropagation();

        var data = vehicleDriver.find(function (e) {
            return e.code == code;
        });
        data.activeFlag = flag;

        if (flag == 2 && !confirm('Do you want to delete this Driver?')) {
            return;
        }

        var loading_overlay = iosOverlay({
            text: 'Loading',
            icon: 'fa fa-spinner fa-spin'
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: 'config/update-vehicle-driver',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: 'fa fa-check',
                        text: 'Success!'
                    });
                } else {
                    loading_overlay.update({
                        icon: 'fa fa-times',
                        text: 'Sorry!'
                    });
                }
                setTimeout(function () {
                    loading_overlay.hide();
                    checkURL();
                }, 2000);
            }
        });
    }

    function getDriverGallery(loading = true) {
        var data = {};
        data.code = $('#hid-dri-code').val();
        
        loading && $('#gal-viw-rslt').html(loading_small);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "config/get-driver-gallery",
            data: data,
            success: function (response) {
                if (response) {
                    $('#gal-viw-rslt').html(response);
                }
            }
        })
    } 

    function importBitsDrivers() {
        $('.inp_error').removeClass('inp_error');
        $('#bits-drivers-list-container ul').html($('<li/>').html(loading_popup));
        $('#import-bits-drivers-state').hide();

        $('#import-bits-drivers').dialog({
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
            url: base_url + "config/import-bits-drivers",
            success: function(response) {
                if (response.status == 1) {
                    bitsDriverlist = response.data;
                    var options = [];
                    $.each(response.data || [], function (i, v) {
                        if (!$('[data-drv-mobile="' + v.mobileNumber + '"]').length) {
                            options.push(new Option(v.name + ' ' + v.lastName + ' (' + v.mobileNumber + ', DOB : ' + new Date(v.dateOfBirth).format('dd-MM-yyyy') + ')', v.code));
                        }
                    });

                    if(options.length == 0) {
                        $('#bits-drivers-list-container ul').html('<li><div class="well well-large">No Drivers Found</div></li>');
                    } else {
                        $('#bits-drivers').html(options).multiselect('rebuild');
                    }
                } else {
                    $('#import-bits-drivers-state').removeClass('alert-success').addClass('alert-danger');
                    $('#import-bits-drivers-state').html(response.errorDesc);
                    $('#import-bits-drivers-state').show();                    
                }
            }
        });
    }

    function cancelBitsDrivers() {
        $('#import-bits-drivers').dialog('destroy');
        $('#import-bits-drivers').hide();
    }

    function saveBitsDrivers() {        
        var err = 0;
        var data = {};
        data.driverList = [];

        $.each(bitsDriverlist || [], function (i, v) {
            if($('#bits-drivers [value="' + v.code + '"]').is(':selected')) {
                data.driverList.push(v);
            }
        });

        $('.inp_error').removeClass('inp_error');

        if ((data.driverList || []).length == 0) {
            $("ul.bits-drivers-list").addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#import-bits-drivers-state').removeClass('alert-success').addClass('alert-danger');
            $('#import-bits-drivers-state').html('Please enter the values in the field that are marked in red');
            $('#import-bits-drivers-state').show();
            return false;
        }
        $('#import-bits-drivers-state').removeClass('alert-success alert-danger');
        $('#import-bits-drivers-state').html(loading_popup);
        $('#import-bits-drivers-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/save-bits-drivers",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#import-bits-drivers-state').removeClass('alert-danger').addClass('alert-success');
                    $('#import-bits-drivers-state').show();
                    $('#import-bits-drivers-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelBitsDrivers();
                        checkURL();
                    }, 2000);
                } else {
                    $('#import-bits-drivers-state').removeClass('alert-success').addClass('alert-danger');
                    $('#import-bits-drivers-state').html(response.errorDesc);
                    $('#import-bits-drivers-state').show();
                }
            }
        });
    }    
</script>