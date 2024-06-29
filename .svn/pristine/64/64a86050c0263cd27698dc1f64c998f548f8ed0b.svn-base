<div class="popup_top">
    <div class="row">
        <div class="col-md-10 ft_14">
            <span class="bold">EWayBill Details</span>
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="hideEwayBillVehicleDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>    
</div>

<div class="row">
    <div class="col-md-3 custom-scrollbar" style="max-height: 550px;overflow: auto;">
        <div class="table-responsive ov_fl_500 p_r_15">
            <table id="ewaybill-table" class="table table-bordered table-hover">
                <tbody class="body_table">
                    {foreach item=row from=$result key=k}
                        {if $cargo_code && $row->cargo->code != $cargo_code}
                            {continue}
                        {/if}
                        <tr class="point_cur" onclick="getEwayBillDetails('{$row->cargo->code}', '{$row->ewayBillNo}')" id="lr-{$row->cargo->code}">
                            <td>
                                <div class="ewaybill-card">
                                    <span class="bold"> LR No :</span> <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo->code}")'>{$row->cargo->code}</a><br>
                                    <span class="bold"> EwayBill No :</span> {$row->ewayBillNo}<br>
                                    <span class="bold"> From :</span> {$row->cargo->fromStation->name} - {$row->cargo->fromOrganization->shortCode} <br>
                                    <span class="bold"> To :</span> {$row->cargo->toStation->name} - {$row->cargo->toOrganization->shortCode} <br>
                                </div>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-md-9" style="max-height: 550px;overflow: auto;">
        <div id="ewaybill-details">
            <div class="well well-large"> Click any of the LR to view more details.</div>
        </div>
    </div>
</div>

<div id="ewaybill-partb-dialog"  class="dialog-content-page" style="display: none;">
    <div>
        <div class="row">
            <div class="col-md-10 ft_14">
                <span class="bold">Update Part-B Details</span>
            </div>
            <div class="col-md-2">
                <a class="align-right" onclick="hideEwayBillPartBDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
            </div>
        </div>
        <div id="update-partb-data">
            <br>
            <h6 class="bold">Following are the details going to updated</h6>
            <table width="100%" cellpadding="5" class="table table-bordered">
                <tbody class="body_table">
                    <tr>
                        <th>Eway Bill No: </th>
                        <td class="ewaybill"></td>
                    </tr>
                    <tr>
                        <th>Vehicle No: </th>
                        <td>{$vehicle_no}</td>
                    </tr>
                    <tr>
                        <th>From: </th>
                        <td>{$ogpl_from}</td>
                    </tr>
                    <tr>
                        <th>Transporter GSTIN: </th>
                        <td>{$ewaybill_integration->additionalAttribute->GSTIN}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="clear_fix_both"></div><br>
        <div id="eway-vehicle-alert"></div>
        <div>
            <input type="hidden" id="selected-eway-lr">
            <div class="align-right" id="form-bttons">
                <button class="btn btn-success" type="button" onclick="updateEwayBillPartB();">Update</button>
                <button class="btn btn-default" type="button" onclick="hideEwayBillPartBDialog();">Cancel</button>
            </div>
        </div>
    </div>
</div>

<script>
    {if $cargo_code}
        $('#lr-{$cargo_code}').trigger('click');
    {/if}

    function toggleAllEwayLR(el) {
        $('#eway_report_table .ewaybill-lr-cb').prop('checked', el.checked);
    }

    function ewaybillUpdateVehicle() {
        $('#ewaybill-partb-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 500,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
    }

    function hideEwayBillPartBDialog() {
        $('#ewaybill-partb-dialog').dialog('destroy');
        $('#ewaybill-partb-dialog').hide();
    }

    function updateEwayBillPartB() {
        var data = {};
        data.transitCode = '{$transitCode}';
        data.cargoList = $('#selected-eway-lr').val();

        // var cargoList = [];
        // $('#eway_report_table .ewaybill-lr-cb:checked').each(function () {
        //     cargoList.push(this.value);
        // });
        // data.cargoList = cargoList.join(',');

        // $('.inp_error').removeClass('inp_error');

        // if (!cargoList.length) {
        //     $('#eway-vehicle-alert').addClass('alert alert-danger').html('Please select at least one {lang('lr')}.');
        //     return;
        // }

        $('#eway-vehicle-alert').removeClass('alert alert-danger alert-success').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-ewaybill-vehicle",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#eway-vehicle-alert').addClass('alert alert-success').html( 'Your request processed successfully');
                } else {
                    $('#eway-vehicle-alert').addClass('alert alert-danger').html(response.errorDesc);
                }
            }
        });
    }

    function getEwayBillDetails(lrCode, ewayBillNo) {
        var data = {};
        data.ewayBillNo = ewayBillNo;

        $('#ewaybill-table tr').removeClass('last-active hover-background');
        $('#ewaybill-table tr[id="lr-' + lrCode + '"]').addClass('last-active hover-background');
        $('#ewaybill-details').html(loading_popup);

        $('#selected-eway-lr').val(lrCode);
        $('#update-partb-data .ewaybill').html(ewayBillNo);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/ewaybill-details",
            data: data,
            success: function (response) {
                $('#ewaybill-details').html(response);
            }
        });
    }
</script>