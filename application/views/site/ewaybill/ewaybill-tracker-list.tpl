{foreach item=transitList from=$summary key=vehicleNo}
    <div class="row bg-info">
        <div class="col-md-6 p_l_n">
            <div class="col-md-4"><h5><b title="Vehicle No">{$vehicleNo|default:' - '}</b></h5></div>
            <div class="col-md-3 p-y-10 bold text-center"></div>
            <div class="col-md-5 m-t-4"></div>
        </div>
    </div>
    {foreach item=transit from=$transitList key=transitCode}
        <div class="row hover-background">
            <div class="col-md-2">
                <h6><b title="{lang('ogpl')} No">{$transit['alias_code']|default:' - '}</b></h6>
            </div>
            <div class="col-md-6">
                <h6><b title="{lang('ogpl')} No">{$transit['transit_name']}</b></h6>
            </div>
            <div class="col-md-4">
                {if $action_rights['EBL-EWAY-BILL'] > 0 && isNotNull($transitCode)}
                    <button type="button" class="btn btn-success pull-right btn-xs" onclick="generateConsolidatedEwayBill('{$transitCode}');">Generate Consolidated Eway Bill</button>
                {/if}
            </div>
        </div><br/>
        <div class="clearfix"></div>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr class="bold">
                        {if $action_rights['EBL-EWAY-BILL'] > 0 && isNotNull($transitCode)}
                            <th class="text-center"><input type="checkbox" class="ewaybill_cb_all {$vehicleNo|clean_string} {$transitCode}" data-vehicleno="{$vehicleNo|clean_string}" data-ogplcode="{$transitCode}" checked></th>
                        {/if}
                        <th>{lang('lr')} No</th>
                        <th align="left">E-Way Bill No.</th>
                        <th align="left">Booked At</th>
                        <th>Origin</th>
                        <th>Destination</th>
                        <th align="left">Reg No.</th>
                        <th align="left">{lang('ogpl')} No</th>
                        <th align="left">Loaded At</th>
                        <th align="left">Payment Type</th>
                        <th align="left">Cargo Status</th>
                        <th align="left">Remarks</th>
                        {if $action_rights['EBL-EWAY-BILL'] > 0}
                            <th align="left"></th>
                        {/if}
                    </tr>
                </thead>
                <tbody>
                    {foreach item=row from=$transit['data']}
                        <tr data-lr="{$row->cargo_code}">
                            {if $action_rights['EBL-EWAY-BILL'] > 0 && isNotNull($transitCode)}
                                <td align="center"><input type="checkbox" {if $row->ewaybill_vehicle_no == $row->registration_number}disabled title="Part-B already Updated"{else}class="ewaybill_cb {$row->registration_number|clean_string} {$row->transit_code}" value="{$row->cargo_code}" data-vehicleno="{$vehicleNo|clean_string}" data-ogplcode="{$transitCode}" checked{/if}></th>
                            {/if}
                            <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                            <td align="left">{$row->ewaybill_number}</td>
                            <td align="left" nowrap>{(isNotNull($row->booked_at)) ? ($row->booked_at|date_format:$ns_datetime_format) : '-'}</td>
                            <td align="left">{$row->from_station_name} -<br/>{$row->from_organization_name}</td>
                            <td align="left">{$row->to_station_name} -<br/>{$row->to_organization_name}</td>
                            <td align="left" nowrap>{$row->registration_number|default:'-'}</td>
                            <td align="left" nowrap>{$row->transit_alias_code|default:'-'}</td>
                            <td align="left" nowrap>{(isNotNull($row->loaded_at)) ? ($row->loaded_at|date_format:$ns_datetime_format) : '-'}</td>
                            <td align="center">{$row->payment_type_code|_cargo_payment_status_badge}</td>
                            <td align="center">{$cargo_status[$row->cargo_status_code]}</td>
                            <td align="left" width="320">
                                <div class="remarks">
                                    <span class="remarks-txt">{$row->remarks|default:'-'} </span>
                                    <a href="javascript:;" title="Edit" class="btn btn-default btn-xs pull-right" onclick='addRemarks(this, "{$row->cargo_code}");'><i class="fa fa-pencil igreen"></i></a>
                                </div>
                                <div class="remarks-cont"></div>
                            </td>
                            {if $action_rights['EBL-EWAY-BILL'] > 0}
                                <td>
                                    {if isNotNull($row->transit_code) && $row->ewaybill_vehicle_no != $row->registration_number}
                                        <button class="btn btn-primary btn-xs pull-right vehicle-btn" onclick="showEwayBillVehicleDialog({
                                            transitCode: '{$row->transit_code}',
                                            vehicleNo: '{$row->registration_number}',
                                            ogplFrom: '{$row->from_station_name}',
                                            lrCode: '{$row->cargo_code}',
                                        })">Update Part-B</button>                        
                                    {/if}
                                </td>
                            {/if}
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    {/foreach}
{foreachelse}
    <div class="well well-large"> No Data found.</div>
{/foreach}

<div id="ewaybill-remarks-panel" class="hidden">
    <div id="ewaybill-remarks-form">
        <input class="form-control" placeholder="Remarks" id="ewaybill-remarks"/>
        <input type="hidden" id="ewaybill-cargo-code">
        <button class="btn btn-success btn-sm" type="button" id="routes-fare-save-btn" onclick="saveRemarks();">Save</button>
        <button class="btn btn-default btn-xs" type="button" onclick="cancelAddRemarks();" title="Close">
            <i class="fa fa-times-circle"></i>
        </button>
        <div id="ewaybill-action-state">&nbsp;</div>
    </div>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportEwayExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>

<div id="ewaybill-vehicle-dialog"  class="dialog-content-page" style="display: none;"></div>

<script>
    $('#ewaybill-remarks').autocomplete({
        minLength: 0,
        source: [
            'Verified',
            'Un-Verified',
            'Part-B Updated',
            'Insufficient Data',
            'Invalid E-Way Bill Number',
        ]
    }).focus(function(){
        $(this).autocomplete('search', '');
    });
    
    $('.ewaybill_cb_all').on('change', function () {
        var $ele = $(this);
        
        $('.ewaybill_cb.' + $ele.data('vehicleno') + '.' + $ele.data('ogplcode'))
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });
    
    function addRemarks(btn, code) {
        // table.search('').draw();

        var $tr = $(btn).closest('tr');

        $('#eway_report_table .remarks').show();
        $tr.find('.remarks').hide();
        $('#ewaybill-remarks-form').find('#ewaybill-cargo-code').val(code);
        $('#ewaybill-remarks-form').find('#ewaybill-action-state').html('&nbsp;');
        $('#ewaybill-remarks-form').find('#ewaybill-remarks').removeClass('inp_error');
        $tr.find('.remarks-cont').append($('#ewaybill-remarks-form'));
    }

    function cancelAddRemarks() {
        $('#eway_report_table .remarks').show();
        $('#ewaybill-remarks-panel').append($('#ewaybill-remarks-form'));
    }

    function saveRemarks() {
        var data = {}, err = 0;

        var remarks = {};
        remarks.code = '';
        remarks.name = $('#ewaybill-remarks').val().trim();
        remarks.cargoStatusCode = 'CL';

        data = remarks;
        data.cargoCode = $('#ewaybill-cargo-code').val();

        $('.inp_error').removeClass('inp_error');
        if (!remarks.name) {
            $('#ewaybill-remarks').addClass('inp_error');
            $('#ewaybill-remarks').focus();
            err++;
        }
        if(err) {
            $('#ewaybill-action-state').removeClass('text-success hide').addClass('text-danger').show();
            $('#ewaybill-action-state').html('Please enter/select the remarks');
            return;
        }

        $('#remove-ogpl-panel-btn').hide();
        $('#ewaybill-action-state').removeClass('alert').removeClass('text-danger').removeClass('text-success').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-remarks",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#ewaybill-action-state').addClass('text-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        $('tr[data-lr=' + data.cargoCode + ']').find('.remarks-txt').html(remarks.name);
                        cancelAddRemarks();
                    }, 1000);
                } else {
                    $('#ewaybill-action-state').addClass('text-danger').html(response.errorDesc);
                }
            }
        });
    }
    
    function ewaybillUpdateVehicle(transitCode, cargoCode) {
        var data = {};
        data.transitCode = transitCode;
        data.cargoList = cargoCode;

        $('.inp_error').removeClass('inp_error');

        var loading_overlay = iosOverlay({
            text: "Updating",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-ewaybill-vehicle",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('tr[data-lr=' + cargoCode + ']').find('.vehicle-btn').remove();
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Failed!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }

    function hideOgplTransferDialog() {
        $('#ogpl-transfer-dialog').dialog('destroy');
        $('#ogpl-transfer-dialog').hide();
    }

    function showEwayBillVehicleDialog(param) {
        $('#ewaybill-vehicle-dialog').dialog({
            autoOpen: true,
            height: 620,
            width: $(window).width() - 200,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });

        $('#ewaybill-vehicle-dialog').html(loading_small);

        var data = {};
        data.transitCode = param.transitCode;
        data.vehicleNo = param.vehicleNo;
        data.ogplFrom = param.ogplFrom;
        data.lrCode = param.lrCode;

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/ogpl-ewaylr-list",
            data: data,
            success: function (response) {
                $('#ewaybill-vehicle-dialog').html(response);
            }
        })
    }
    
    function hideEwayBillVehicleDialog() {
        $('#ewaybill-vehicle-dialog').dialog('destroy');
        $('#ewaybill-vehicle-dialog').hide();
    }

    function generateConsolidatedEwayBill(transitCode) {
        var data = {};
        data.transitCode = transitCode;
        data.cargoList = $('.ewaybill_cb[data-ogplcode="' + transitCode + '"]:checked').map((i, e) => e.value).get().join(',');

        if (data.cargoList.lentgh == 0) {
            alert('Please select atleast one LR');
            return;
        }

        $('.inp_error').removeClass('inp_error');

        var loading_overlay = iosOverlay({
            text: "Updating",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "ewaybill/generate-consolidate-ewaybill",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        ewayReport();
                    }, 1000);
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Failed!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
</script>
