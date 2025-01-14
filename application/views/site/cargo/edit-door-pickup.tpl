<div class="row">
    <div class="col-md-4">
        <div class="form-group">
            <label for="from_phone">Door Pickup Charges</label>
            <div class="input-group">
                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                <input type="number" class="form-control no-spin" id="edit-dp-charges" value="0" data-mask="inrcurrency">
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="form-group">
            <label class="req" for="txt_m_name">Select Address 
                <a href="javascript:;" onclick="editSelectedAddress();" id="edit-selected-address" class="hide"><i class="fa fa-pencil pull-right">&nbsp;&nbsp;Edit selected Address</i></a>
            </label>
            <select id="dp_address_list" class="form-control">
                {foreach name=o item=row from=$address}
                    {assign var="addr" value=[$row->address1, $row->address2, $row->landmark, $row->station->name, $row->pincode]}
                    <option value="{$row->code}" data-address="{$row|json_encode|@escape}">{implode(', ', array_filter($addr, 'isNotNull'))}</option>
                {/foreach}
                <option value="OTHER">Other</option>
            </select>
        </div>
    </div>
</div>
<div class="row hide" id="door-pickup-pannel">
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dp_address_type">Address Type</label>
            <input type="text" name="dp_address_type" class="form-control" id="dp_address_type" maxlength="50" placeholder="Address Type" />
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <div>
                <label class="req" for="txt_m_name">From Station</label>
                <select id="dp_station" class="form-control">
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
            <label class="req" for="dp_address1">Flat, House no., Building, Company, Apartment</label>
            <textarea name="dp_address" class="form-control" id="dp_address1" rows="2" placeholder="Flat, House no., Building, Company, Apartment" maxlength="180"></textarea>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dp_address2">Area, Colony, Street, Sector, Village</label>
            <textarea name="dp_address" class="form-control" id="dp_address2" rows="2" placeholder="Area, Colony, Street, Sector, Village" maxlength="180"></textarea>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dp_landmark">Landmark</label>
            <input type="text" name="dp_landmark" value="" class="form-control" id="dp_landmark" maxlength="80" placeholder="Landmark" />
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="req" for="dp_pincode">Pincode</label>
            <input type="text" name="dp_pincode" value="" class="form-control" id="dp_pincode" maxlength="6" placeholder="Pincode" data-mask="positiveinteger"/>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="door-pickup-action-state"></div>
    </div>

    <div class="col-md-12 text-right" id="door-pickup-panel-btn">
        <input type="hidden" id="update_pkp_addre" value="">
        <button type="button" class="btn btn-success" onclick="saveDoorPickup();">Save</button>&nbsp;
        <button type="button" class="btn btn-default" onclick="hideLRActivityDialog();">Cancel</button>&nbsp;
    </div>
</div>
<input type="hidden" id="hid-user-code" value="{$user}">

<script>
    var mandateAddressOnBookingFlag ={$mandateAddressOnBookingFlag|json_encode}
    var fromStationCode ={$fromStationCode|json_encode}

    $('#dp_station').val(lrdata.fromStation.code || '').select2();
    $('#edit-dp-charges').val(lrdata.pickupHandlingAmount || 0);
    
    $('#dp_address_type').autocomplete({
        minLength: 0,
        source: [
            'Home',
            'Office',
        ],
        appendTo: '#lr-activity-dialog'
    }).focus(function(){
        $(this).autocomplete('search', '');
    });

    $('#door-pickup-pannel [data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });

    $('#dp_address_list').on('change', function () {
        $('#dp_address_type, #dp_address1, #dp_address2, #dp_landmark, #dp_pincode, #update_pkp_addre').val('');
        $('#dp_station').val('').trigger('change');
        
        if (this.value == 'OTHER') {
            $('#door-pickup-pannel').removeClass('hide');
            $('#edit-selected-address').addClass('hide')
        } else {
            $('#door-pickup-pannel').addClass('hide');
            $('#edit-selected-address').removeClass('hide')
        }
    }).trigger('change');

    function editSelectedAddress(){
        $('#dp_address_type, #dp_address1, #dp_address2, #dp_landmark, #dp_pincode, #update_pkp_addre').val('');
        $('#dp_station').val('').trigger('change');

        if($('#door-pickup-pannel').hasClass('hide')){
            $('#door-pickup-pannel').removeClass('hide');
            var data = $('#dp_address_list option:selected').data('address');
            
            $('#update_pkp_addre').val(1);
            $('#dp_address_type').val(data.name);
            $('#dp_address1').val(data.address1);
            $('#dp_landmark').val(data.landmark);
            $('#dp_station').val(data.station.code).trigger('change');
            $('#dp_address2').val(data.address2);
            $('#dp_pincode').val(data.pincode);
        }else{
            $('#door-pickup-pannel').addClass('hide');
        }
    }

    function saveDoorPickup() {
        var data = {}, err = 0;
        data.code = lrdata.code;
        data.name = lrdata.toCustomer.name;
        data.userCode = $('#hid-user-code').val();
        data.toCustomerAddress = {};
        data.toCustomerAddress.code = lrdata.toCustomerAddress.code || '';

        var fromCustomerAddressCode = $('#dp_address_list').val();
        data.fromCustomerAddressCode = (fromCustomerAddressCode == 'OTHER') ? '' : fromCustomerAddressCode;
        data.updatePickupAddress = $('#update_pkp_addre').val();

        data.pickupType = lrdata.pickupType.code || '';
        data.deliveryType = lrdata.deliveryType.code || '';

        data.name = $.trim($('#dp_address_type').val());
        data.address1 = $.trim($('#dp_address1').val());
        data.address2 = $.trim($('#dp_address2').val());
        data.landmark = $.trim($('#dp_landmark').val());
        data.pincode = $.trim($('#dp_pincode').val());
        data.station = $.trim($('#dp_station').val());

        data.pickupHandlingAmount = $.trim($('#edit-dp-charges').val()) || 0;
        data.deliveryHandlingAmount = lrdata.deliveryHandlingAmount;

        if (cargoSetting.lrGstTaxComputeType == 'NET') {
            netAmount = Number(data.pickupHandlingAmount)+lrdata.totalAmount+lrdata.totalHandlingAmount+lrdata.totalUnloadHandlingAmount+lrdata.deliveryHandlingAmount+lrdata.serviceCharge+lrdata.hamaliCharge+lrdata.passCharge+lrdata.docketCharge+addonamount;

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
        //if (fromCustomerAddressCode == 'OTHER') {
        if ($('#door-pickup-pannel').hasClass('hide') == false) {
            if (mandateAddressOnBookingFlag == true) {
                if (!data.name) {
                    $('#dp_address_type').addClass('inp_error');
                    err++;
                }
                if (!data.address1) {
                    $('#dp_address1').addClass('inp_error');
                    err++;
                }
                if (!data.address2) {
                    $('#dp_address2').addClass('inp_error');
                    err++;
                }
                if (!data.landmark) {
                    $('#dp_landmark').addClass('inp_error');
                    err++;
                }
                if (!data.pincode) {
                    $('#dp_pincode').addClass('inp_error');
                    err++;
                }
                if (!data.station) {
                    $('#dp_station').addClass('inp_error');
                    err++;
                }
            }
        }

        // if (isNaN(data.pickupHandlingAmount) || Number(data.pickupHandlingAmount) <= 0) {
        //     $('#edit-dp-charges').addClass('inp_error');
        //     err++;
        // }

        if (err) {
            $('#door-pickup-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#door-pickup-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }

        $('#door-pickup-panel-btn').hide();
        $('#door-pickup-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-door-pickup",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#door-pickup-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function() {
                        hideLRActivityDialog();
                        getCargoDetails(lrdata.code);
                    }, 2000);
                } else {
                    $('#door-pickup-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#edit-paytype-panel-btn').show();
                }
            }
        });
    }

    if (mandateAddressOnBookingFlag == false) {
        $('#dp_station').val(fromStationCode).trigger('change');
    }
</script>