<div class="row">
    <div class="col-md-4">
        <div class="form-group">
            <label for="from_phone">Door Delivery Charges</label>
            <div class="input-group">
                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                <input type="number" class="form-control no-spin" id="edit-dd-charges" value="0" data-mask="inrcurrency">
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label class="req" for="txt_m_name">Select Address 
                <a href="javascript:;" onclick="editSelectedAddress();" id="edit-selected-address" class="hide"><i class="fa fa-pencil pull-right">&nbsp;&nbsp;Edit selected Address</i></a>
            </label>
            <select id="dd_address_list" class="form-control">
                {foreach name=o item=row from=$address}
                    {assign var="addr" value=[$row->address1, $row->address2, $row->landmark, $row->station->name, $row->pincode]}
                    <option value="{$row->code}" data-address="{$row|json_encode|@escape}">{implode(', ', array_filter($addr, 'isNotNull'))}</option>
                {/foreach}
                <option value="OTHER">Other</option>
            </select>
        </div>
    </div>
</div>
<div class="row hide" id="door-delivery-pannel">
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dd_address_type">Address Type</label>
            <input type="text" name="dd_address_type" class="form-control" id="dd_address_type" maxlength="50" placeholder="Address Type" />
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <div>
                <label class="req" for="txt_m_name">To Station</label>
                <select id="dd_station" class="form-control">
                    <option value="">Select City</option>
                    {foreach name=o item=row from=$stations}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dd_address1">Flat, House no., Building, Company, Apartment</label>
            <textarea name="dd_address" class="form-control" id="dd_address1" rows="2" placeholder="Flat, House no., Building, Company, Apartment" maxlength="180"></textarea>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dd_address2">Area, Colony, Street, Sector, Village</label>
            <textarea name="dd_address" class="form-control" id="dd_address2" rows="2" placeholder="Area, Colony, Street, Sector, Village" maxlength="180"></textarea>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dd_landmark">Landmark</label>
            <input type="text" name="dd_landmark" value="" class="form-control" id="dd_landmark" maxlength="80" placeholder="Landmark" />
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dd_pincode">Pincode</label>
            <input type="text" name="dd_pincode" value="" class="form-control" id="dd_pincode" maxlength="6" placeholder="Pincode" data-mask="positiveinteger"/>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="door-delivery-action-state"></div>
    </div>

    <div class="col-md-12 text-right" id="door-delivery-panel-btn">
        <input type="hidden" id="update_del_addre" value="">
        <button type="button" class="btn btn-success" onclick="saveDoorDelivery();">Save</button>&nbsp;
        <button type="button" class="btn btn-default" onclick="hideLRActivityDialog();">Cancel</button>&nbsp;
    </div>
</div>
<input type="hidden" id="hid-user-code" value="{$user}">

<script>
    var mandateAddressOnBookingFlag ={$mandateAddressOnBookingFlag|json_encode}
    var toStationCode ={$toStationCode|json_encode}
    $('#dd_station').val(lrdata.toStation.code || '').select2();
    $('#edit-dd-charges').val(lrdata.deliveryHandlingAmount || 0);
    
    $('#dd_address_type').autocomplete({
        minLength: 0,
        source: [
            'Home',
            'Office',
        ],
        appendTo: '#lr-activity-dialog'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#door-delivery-pannel [data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });

    $('#dd_address_list').on('change', function () {
        $('#dd_address_type, #dd_address1, #dd_address2, #dd_landmark, #dd_pincode, #update_del_addre').val('');
        $('#dd_station').val('').trigger('change');
        
        if (this.value == 'OTHER') {
            $('#door-delivery-pannel').removeClass('hide');
            $('#edit-selected-address').addClass('hide')
        } else {
            $('#door-delivery-pannel').addClass('hide');
            $('#edit-selected-address').removeClass('hide')
        }
    }).trigger('change');

    function editSelectedAddress(){
        $('#dd_address_type, #dd_address1, #dd_address2, #dd_landmark, #dd_pincode, #update_del_addre').val('');
        $('#dd_station').val('').trigger('change');

        if($('#door-delivery-pannel').hasClass('hide')){
            $('#door-delivery-pannel').removeClass('hide');
            var data = $('#dd_address_list option:selected').data('address');
            
            $('#update_del_addre').val(1);
            $('#dd_address_type').val(data.name);
            $('#dd_address1').val(data.address1);
            $('#dd_landmark').val(data.landmark);
            $('#dd_station').val(data.station.code).trigger('change');
            $('#dd_address2').val(data.address2);
            $('#dd_pincode').val(data.pincode);
        }else{
            $('#door-delivery-pannel').addClass('hide');
        }
    }

    function saveDoorDelivery() {
        var data = {}, err = 0;
        data.code = lrdata.code;
        data.name = lrdata.toCustomer.name;
        data.userCode = $('#hid-user-code').val();
        data.fromCustomerAddress = {};
        data.fromCustomerAddress.code = lrdata.fromCustomerAddress.code || '';

        var toCustomerAddressCode = $('#dd_address_list').val();
        data.toCustomerAddressCode = (toCustomerAddressCode == 'OTHER') ? '' : toCustomerAddressCode;
        data.updateDelAddress = $('#update_del_addre').val();

        data.pickupType = lrdata.pickupType.code || '';
        data.deliveryType = lrdata.deliveryType.code || '';

        data.name = $.trim($('#dd_address_type').val());
        data.address1 = $.trim($('#dd_address1').val());
        data.address2 = $.trim($('#dd_address2').val());
        data.landmark = $.trim($('#dd_landmark').val());
        data.pincode = $.trim($('#dd_pincode').val());
        data.station = $.trim($('#dd_station').val());

        data.pickupHandlingAmount = lrdata.pickupHandlingAmount;
        data.deliveryHandlingAmount = $.trim($('#edit-dd-charges').val()) || 0;

        if (cargoSetting.lrGstTaxComputeType == 'NET') {
            netAmount = Number(data.deliveryHandlingAmount)+lrdata.totalAmount+lrdata.totalHandlingAmount+lrdata.totalUnloadHandlingAmount+lrdata.pickupHandlingAmount+lrdata.serviceCharge+lrdata.hamaliCharge+lrdata.passCharge+lrdata.docketCharge+addonamount;

            data.lrGSTEdit = {}
            data.lrGSTEdit.code = lrdata.code;
            data.lrGSTEdit.serviceTax = Number(parseFloat(netAmount) * cargoSetting.serviceTaxPercentage / 100).toFixed(2);

            data.lrGSTEdit.itemDetails = [];
            $(lrdata.itemDetails).each(function(k, item){
                var lrGSTItemDetails = {};
                lrGSTItemDetails.code = item.code;
                lrGSTItemDetails.serviceTax = item.serviceTax;
                lrGSTItemDetails.unit = {};
                lrGSTItemDetails.unit.code = item.unit.code;
                data.lrGSTEdit.itemDetails.push(lrGSTItemDetails);
            });

            data.serviceTaxEditFlag = 1;
        }

        $('.inp_error').removeClass('inp_error');
        //if (toCustomerAddressCode == 'OTHER') {
        if ($('#door-delivery-pannel').hasClass('hide') == false) {
            if (mandateAddressOnBookingFlag == true) {
                if (!data.name) {
                    $('#dd_address_type').addClass('inp_error');
                    err++;
                }
                if (!data.address1) {
                    $('#dd_address1').addClass('inp_error');
                    err++;
                }
                if (!data.address2) {
                    $('#dd_address2').addClass('inp_error');
                    err++;
                }
                if (!data.landmark) {
                    $('#dd_landmark').addClass('inp_error');
                    err++;
                }
                if (!data.pincode) {
                    $('#dd_pincode').addClass('inp_error');
                    err++;
                }
                if (!data.station) {
                    $('#dd_station').addClass('inp_error');
                    err++;
                }
            }
        }

        // if (isNaN(data.deliveryHandlingAmount) || Number(data.deliveryHandlingAmount) <= 0) {
        //     $('#edit-dd-charges').addClass('inp_error');
        //     err++;
        // }

        if (err) {
            $('#door-delivery-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#door-delivery-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }

        $('#door-delivery-panel-btn').hide();
        $('#door-delivery-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-door-delivery",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#door-delivery-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function() {
                        hideLRActivityDialog();
                        getCargoDetails(lrdata.code);
                    }, 2000);
                } else {
                    $('#door-delivery-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#edit-paytype-panel-btn').show();
                }
            }
        });
    }

    if (mandateAddressOnBookingFlag == false) {
        $('#dd_station').val(toStationCode).trigger('change');
    }
</script>