<div class="brand_top"><h3>Vendor</h3> <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="vendorDialog();">Add Vendor</a></span></div>
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
                                    <div class="table-responsive">
                                       <table id="vendor_table" class="table table-bordered">
                                            <thead>
                                                <tr class="success">
                                                    <th>#</th>
                                                    <th>Name</th>
                                                    <th>Mobile Number</th>
                                                    <th>Email</th>
                                                    <th>Address</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                {foreach item=row from=$vendors key=k}
                                                    <tr id='item_{$row->code}'>
                                                        <td>{$k+1}</td>
                                                        <td>{$row->name}</td>
                                                        <td>{$row->mobileNumber}</td>
                                                        <td>{$row->email}</td>
                                                        <td>{$row->address}</td>
                                                        <td>
                                                            {if $row->activeFlag ==1}
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Disable" onclick='disableVendor({$row|@json_encode})'><i class="fa fa-times ired"></i></a>
                                                            {else}
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Disable" onclick='disableVendor({$row|@json_encode})'><i class="fa fa-check ired"></i></a>
                                                            {/if}
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick='deleteVendor({$row|@json_encode})'><i class="fa fa-trash-o ired"></i></a>
                                                            {if $row->activeFlag ==1}
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick='vendorDialog({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                <div id="notify_mes_{$row->code}" style="display:none">{$row->description}</div>
                                                {/foreach} 
                                           </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="clear_fix_both"></div>
                                <div id="vendor-dialog" class="hide dialog-content-page">
                                    <form role="form" id="form1" class="form-horizontal ">
                                        <div class="col-lg-6 p_l_n">
                                            <div>
                                                <label for="vendor_name" class="req">Name</label>
                                                <input  placeholder="Name" id="vendor_name" value="" class="form-control">
                                            </div>
                                        </div> 
                                        <div class="col-lg-6 p_l_n">
                                            <div>
                                                <label for="vendor_mob" class="req">Mobile Number</label>
                                                <input placeholder="Mobile No" id="vendor_mob"  value="" class="form-control" maxlength="10">
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p_l_n">
                                            <div>
                                                <label for="vendor_email" class="req">Email</label>
                                                <input placeholder="Email" id="vendor_email" value="" class="form-control">
                                            </div>
                                        </div>   
                                        <div class="col-lg-6 p_l_n">
                                            <div>
                                                <label for="vendor_addr1" class="req">Address</label>
                                                <input  placeholder="Address 1" id="vendor_addr1" value="" class="form-control">
                                            </div>
                                        </div>
                                    </form>
                                    <div class="clear_fix_both"></div>
                                    <br/>
                                    <div class="clear_fix_both">                       
                                        <div class="alert fl suc_cre" style="display:none;" id="vendor-action-state"></div>
                                        <div class="align-right cre_sve" id="form-bttons">
                                            <input type="hidden" id="vendor_code"/>
                                            <button class="btn btn-success" type="button" onclick="saveVendor();">Save</button>
                                            <button class="btn btn-default" type="button" onclick="cancelVendorDialog();">Cancel</button>
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

{literal}
<script>   
    $(document).ready( function () {
        $('#vendor_table').DataTable({
            paging:false,
            ordering: false,
            info:false
        });
        $('#vendor_station').select2();
    });

    function vendorDialog(option){
        $('#vendor_code,#vendor_name,#vendor_mob,#vendor_email,#vendor_company,#vendor_payment_type,#vendor_addr1,#vendor_addr2,#vendor_pincode,#vendor_landmark,#vendor_gst').val('');
        $('#vendor_station').select2('val','');
        $('.inp_error').removeClass('inp_error');
        $('#vendor-dialog').removeClass('hide');
        $('#vendor-dialog').dialog({
            autoOpen: true,
            width: 600,
            height: 400,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        
        if (_isdefined(option)) {
            $('#vendor_code').val(option.code);
            $('#vendor_name').val(option.name);
            $('#vendor_mob').val(option.mobileNumber);
            $('#vendor_email').val(option.email);
            $('#vendor_addr1').val(option.address);  
        }
    }
    
    function cancelVendorDialog(){
        $('#vendor-dialog').dialog('destroy');
        $('#vendor-dialog').hide();
    }    
    
    function saveVendor(){
        var data = {}
        data.code = $('#vendor_code').val();
        data.name = $.trim($('#vendor_name').val());
        data.mobileNumber = $('#vendor_mob').val();
        data.email = $.trim($('#vendor_email').val());
        data.address = $.trim($('#vendor_addr1').val());
        data.activeFlag = 1;
        
        var err = 0;
        if (data.name == '') {
            $('#vendor_name').addClass('inp_error');
            err++;
        } else {
            $('#vendor_name').removeClass('inp_error');
        }
        if (isNaN(data.mobileNumber) || data.mobileNumber.length !=10) {
            $('#vendor_mob').addClass('inp_error');
            err++;
        } else {
            $('#vendor_mob').removeClass('inp_error');
        }
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (data.email == '' || !filter.test(data.email)) {
            $('#vendor_email').addClass('inp_error');
            err++;
        } else {
            $('#vendor_email').removeClass('inp_error');
        }
        if (data.address == '') {
            $('#vendor_addr1').addClass('inp_error');
            err++;
        } else {
            $('#vendor_addr1').removeClass('inp_error');
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
            url: base_url + "expense/update-vendor",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#vendor-action-state').removeClass('alert-danger');
                    $('#vendor-action-state').addClass('alert-success');
                    $('#vendor-action-state').html('Your request has been completed successfully');
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
    
    function deleteVendor(code){
        if (confirm('Do you want to delete this Vendor?')) {
            var data = code;
            data.activeFlag = 2;
            
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "expense/update-vendor",
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
    
    function disableVendor(code){
        var data = code;
        var msg = '';
        if(code.activeFlag == 1){
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
                url: base_url + "expense/update-vendor",
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
</script>    
{/literal}