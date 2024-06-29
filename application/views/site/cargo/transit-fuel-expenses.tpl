<div class="clearfix">
    <div class="col-md-8">
        <div class="clearfix">
            <h5>Overall Cost for Fuel : <b>{$totalFuelAmount|inr_format}</b></h5>
        </div>
        <div id="transit-fuel-entries">
            {foreach from=$fuelExpensesData item=row}
                <div class="loaded-ogpl-tile">
                    <div class="btn-group pull-right">
                        <a href="javascript:;" class="btn btn-default btn-xs" title="Edit" onclick="editFuelExpense('{$row->code}')"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:;" class="btn btn-default btn-xs" title="Delete" onclick="deleteFuelExpense('{$row->code}')"><i class="fa fa-trash"></i></a>
                    </div>
                    <h5 class="bold">{$row->fuelDate|date_format:$ns_date_format}</h5>
                    <div>{$row->vendorContact->name}</div>
                    <div>Payment Mode: {$row->transactionMode->name}</div>
                    <div>{$row->litres} Litres at the rate Rs.{$row->pricePerLitre}</div>
                    <div>Coupon: {$row->billNumber}</div><br>
                    <span>Total:  <i class="fa fa-inr"></i> <span class="h4">{$row->totalAmount|inr_format}</span></span>
                </div>
            {foreachelse}
            {/foreach}
        </div>
        {if count($fuelExpensesData) == 0}
            <div class="well well-large">No Fuel Expenses Found!</div>
        {/if}
    </div>
    <div class="col-md-4 b_l">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="fuel-litres" class="req">Fuel Litres</label>
                        <input type="number" id="fuel-litres" class="form-control no-spin" placeholder="Fuel Litres">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="fuel-rate" class="req">Fuel Rate / Litre</label>
                        <input type="number" id="fuel-rate" class="form-control no-spin" placeholder="Fuel Rate / Litre">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="fuel-vendor" class="req">Vendor</label>
                        <select id="fuel-vendor" class="form-control">
                            <option value="">Select Vendor</option>
                            {foreach item=row from=$vendors} 
                                <option  value="{$row->code}">{$row->name}</option> 
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="fuel-payment-mode" class="req">Payment Mode</label>
                        <select id="fuel-payment-mode" class="form-control">
                            <option value="CASH">Cash Payment</option> 
                            <option value="CRDT">Credit Payment</option> 
                        </select>
                    </div>
                </div>
                <div class="col-md-6 hide">
                    <div class="form-group">
                        <label for="fuel-location" class="req">Location</label>
                        <input type="text" id="fuel-location" class="form-control" placeholder="Location">
                    </div>
                </div>
            </div>
            <div class="row hide">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="fuel-evidenceno" class="req">Evidence No</label>
                        <input type="text" id="fuel-evidenceno" class="form-control" placeholder="Evidence No">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="fuel-billno" class="req">Bill No</label>
                        <input type="text" id="fuel-billno" class="form-control" placeholder="Bill No">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="form-group">
                        <label for="fuel-coupon" class="req">Fuel Coupon</label>
                        <input type="text" id="fuel-coupon" class="form-control" placeholder="Fuel Coupon">
                    </div>
                </div>
                <div class="col-md-4" id="fuel-form-buttons">
                    <label>&nbsp;</label>
                    <input type="hidden" id="fuel-code">
                    <button class="btn btn-success" type="button" onclick="updateFuelExpense()">Save</button>
                    <button class="btn btn-default" type="button" onclick="clearFuelExpense()">Clear</button>
                </div>
                <div class="col-md-12">
                    <div class="alert fl suc_cre" style="display: none;" id="fuel-action-state"></div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    var fuelExpensesData = {$fuelExpensesData|json_encode};

    $('#fuel-vendor').select2();

    function clearFuelExpense() {
        $('#fuel-action-state').removeClass('alert-danger alert-success').html('');
        $('.inp_error').removeClass('inp_error');

        $('#fuel-litres').val('');
        $('#fuel-rate').val('');
        $('#fuel-vendor').val('').trigger('change');
        $('#fuel-payment-mode').val('CASH').trigger('change');
        $('#fuel-location').val('');
        $('#fuel-evidenceno').val('');
        $('#fuel-billno').val('');
        $('#fuel-coupon').val('');
        $('#fuel-code').val('');
    }

    function editFuelExpense(code) {
        var data = _.find(fuelExpensesData, function (o) {
            return o.code === code;
        });

        if (!data) {
            return;
        }

        $('#fuel-action-state').removeClass('alert-danger alert-success').html('');
        $('.inp_error').removeClass('inp_error');

        $('#fuel-litres').val(data.litres);
        $('#fuel-rate').val(data.pricePerLitre);
        $('#fuel-vendor').val(data.vendorContact.code).trigger('change');
        $('#fuel-payment-mode').val(data.transactionMode.code);
        $('#fuel-location').val(data.location);
        // $('#fuel-evidenceno').val(row.evidenceNumber);
        // $('#fuel-billno').val(row.billNumber);
        $('#fuel-coupon').val(data.billNumber);
        $('#fuel-code').val(data.code);
    }
    
    function updateFuelExpense() {
        $('.inp_error').removeClass('inp_error');
        var transitData = getActiveTransitData();

        var data = {};
        var err = 0;

        data.code = $('#fuel-code').val();
        data.activeFlag = 1;
        data.fuelDate = moment().format('YYYY-MM-DD');
        data.vehicle = {};
        data.vehicle.code = transitData.busVehicle.code;
        data.location = $.trim($('#fuel-location').val());
        data.transitCargo = {};
        data.transitCargo.code = transitData.code;
        data.vendorContact = {};
        data.vendorContact.code = $.trim($('#fuel-vendor').val());
        data.paymentBranch = {};
        data.paymentBranch.code = '{$login_branch}';
        data.litres = Number($('#fuel-litres').val());
        data.pricePerLitre = Number($('#fuel-rate').val());
        data.totalAmount = data.litres * data.pricePerLitre;
        data.evidenceNumber = $.trim($('#fuel-evidenceno').val());
        // data.billNumber = $.trim($('#fuel-billno').val());
        data.billNumber = $.trim($('#fuel-coupon').val());

        data.transactionMode = {};
        data.transactionMode.code = $('#fuel-payment-mode').val();

        if (!data.litres) {
            $('#fuel-litres').addClass('inp_error');
            err++;
        }
        if (!data.pricePerLitre) {
            $('#fuel-rate').addClass('inp_error');
            err++;
        }
        if (!data.vendorContact.code) {
            $('#fuel-vendor').addClass('inp_error');
            err++;
        }
        if (!data.billNumber) {
            $('#fuel-coupon').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#fuel-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#fuel-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#fuel-action-state').show();
            return false;
        } else {
            $('#fuel-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#fuel-action-state').hide();
        }

        $('#fuel-form-buttons').hide();
        $('#fuel-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#fuel-action-state').html(loading_popup);
        $('#fuel-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/update-ogpl-fuel-expense',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#fuel-form-buttons').hide();
                    $('#fuel-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#fuel-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        loadTransitFuelExpense();
                    }, 2500);
                } else {
                    $('#fuel-action-state').show();
                    $('#fuel-action-state').addClass('alert-danger');
                    $('#fuel-action-state').html(response.errorDesc);
                    $('#fuel-form-buttons').show();
                }
            }
        });
    }
    
    function deleteFuelExpense(code) {
        if (!confirm('Do you want to delete this Fuel Expense?')) {
            return;
        }

        var data = _.find(fuelExpensesData, function (o) {
            return o.code === code;
        });
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/update-ogpl-fuel-expense',
            data: data,
            success: function (response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        loadTransitFuelExpense();
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            }
        });
    }
</script>