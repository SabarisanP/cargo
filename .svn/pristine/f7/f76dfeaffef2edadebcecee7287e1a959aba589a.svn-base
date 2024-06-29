<div class="row noprint">
    <div class="form-group col-md-2">
        <label class="req"  for="vanpkp_driver">Driver</label>
        <div class="input-group col-md-12">
            <select id="vanpkp_driver"  class="form-control">
                <option value=''>Select Driver</option>
                {foreach item=row from=$driver}
                    <option value="{$row->code}" {if $vaninfo->driver->code == $row->code}selected{/if}>{$row->name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group col-md-2">
        <label class="req" for="vanpkp_mobile">Driver Mobile No</label>
        <input placeholder="Mobile No" id="vanpkp_mobile" name="Mobile No"  value="{$vaninfo->mobileNumber}" class="form-control" maxlength="10">  
    </div>
    <div class="form-group col-md-2">
        <label class="req"  for="vanpkp_vehicle">Vehicle</label>
        <div class="input-group col-md-12">
            <select id="vanpkp_vehicle"  class="form-control">
                <option value=''>Select Vehicle</option>
                {foreach key=type item=vehicles from=$vehiclegrouped}
                    <optgroup label="{$type}">
                    {foreach item=row from=$vehicles}
                        <option value="{$row->code}" {if $vaninfo->vehicle->code == $row->code}selected{/if}>{$row->registationNumber}</option>
                    {/foreach}
                    </optgroup>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group col-md-3">
        <label for="">&nbsp;</label>
        <div class="input-group">
            <input type="hidden" id="vanpkp_tripinfo_code" value="{$vaninfo->code}">
            <input type="hidden" id="vanpkp_code" value="{$vanpickup_code}">
            <input type="hidden" id="vanpkp_tripdate" value="{$vanpickup_tripdate}">
            <button class="btn btn-success" type="button"  onclick="saveVanTripInfo();">Save</button>&nbsp;
            <button class="btn btn-success" type="button"  onclick="smsVanTripInfo();">Send SMS</button>&nbsp;
            <button type="button" class="btn btn-default btn-clear" onclick="clearVanTripInfo();">Clear</button>
        </div>
    </div>
    <br class="clear_fix_both">
    <div class="form-group col-md-4">
        <div class="align-center alert alert-danger pull-left" style="display:none" id="vanpkp-action-state"></div>
    </div>
    <div class="col-md-12 hidden" id="noti-list">
        <div class="progress progress-striped">
            <div style="width:0%" role="progressbar" class="progress-bar" id="noti-progress"></div>
        </div>
    </div>
</div>

<table class="" width="99%">
    <tr>
        <td class='hidden'  colspan="7" align="center">
            <img src="{$base_url}public/{$namespace}/trip_chart_logo.jpg" >
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center"><b>Van Pickup Chart</b></td>
    </tr>
    <tr>
        <td width="50%">
            <b>Report Date : </b>
            {$smarty.request.tripDate|date_format:$ns_date_format}</td>
        <td width="50%" align="right"><b>Report At : </b> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">
            <b>Vehicle : </b> 
            {foreach key=type item=vehicles from=$vehiclegrouped}
                {foreach item=row from=$vehicles}
                    {if $vaninfo->vehicle->code == $row->code}{$row->registationNumber}{/if}
                {/foreach}
            {/foreach}
    </td>
    <td width="50%" align="right">
        <b>Driver : </b>
        {$vaninfo->driver->name} - {$vaninfo->mobileNumber}
    </td>
</tr>
<tr>
    <td width="50%">
        <b>Van Route : </b>
        {$smarty.request.vehicleVanName}</td>
    <td width="50%" align="right"><span>Printed By : {$usr_login_name}</span> </td>
</tr>
</table>
<br/>
<table id="psngr_vanpkp_report_table" class="table table-bordered " width="99%">
    <thead>
        <tr class="success">
            <th align="center">S No</th>
            <th align="center">PNR</th>
            <th align="center">Name</th>
            <th align="center">Phone</th>
            <th align="center">Seat Name (Gender)</th>
            <th align="center">Route</th>
            <th align="center">Booked By</th>
        </tr>
    </thead>
    <tbody class="body_table" >
        {if count($result)>0}
            {assign var=i value=0}
            {assign var=total_seats value=0}
            {assign var=vanpkp_pnr value=[]}
            {foreach item=station from=$result key=k}
                <tr class="active"><td  colspan="7" align="center">{$k} , {$station['time']|date_format:$ns_time_format}</td></tr>
                {foreach item=row from=$station['tickets'] key=t}
                    <tr>
                        <td align="left">{$i+1}</td>
                        <td align="left">{$row[0]->ticket_code}</td>
                        <td align="left">{$row[0]->passenger_name}</td>
                        <td align="left">{$row[0]->mobile_number}</td>
                        <td align="left">
                            {foreach item=seats from=$station['tickets'][$t] name=sts}
                                {$seats->seat_name} ({$seats->seat_gender}){if not $smarty.foreach.sts.last} , {/if}
                            {/foreach}
                        </td>
                        <td align="left">
                            {if $row[0]->service_number} <span class="warning-text">{$row[0]->service_number}</span>, {/if}
                            {$row[0]->from_station_name} - {$row[0]->to_station_name}
                        </td>
                        <td align="left">{$row[0]->user_name}</td>
                    </tr>
                    {$i = $i+1}
                    {$total_seats = $total_seats + count($station['tickets'][$t])}
                    {$vanpkp_pnr[] = $row[0]->ticket_code}
                {/foreach}
            {/foreach}
        {else}
            <tr><td colspan="7" align="center">No data available</td><tr>
            {/if}
    </tbody>
</table>
<br/>
<h5>Boarding Details</h5>
<table class="table table-bordered" style="max-width: 50%">
    <thead>
        <tr>
            <td class="bold">Station Point</td>
            <td class="bold">Seats</td>
            <td class="bold">Seat Name</td>
        </tr>
    </thead>
    <tbody>
        {foreach item=station from=$result key=k}
            <tr><td>{$k}</td>
                {assign var=all_seats value=0}
                {foreach item=row from=$station['tickets'] key=t}
                    {$all_seats = $all_seats + count($row)}
                {/foreach}
                <td>{$all_seats}</td>
                <td>
                    {foreach item=ticket from=$station['tickets'] name=ses}
                        {foreach item=row from=$ticket name=sts}
                            {$row->seat_name} {if not $smarty.foreach.sts.last} , {/if}
                        {/foreach} {if not $smarty.foreach.ses.last} , {/if}
                    {/foreach}
                </td>
            </tr>
        {/foreach}
        <tr>
            <td class="bold">Total seats</td>
            <td colspan="2" class="bold">{$total_seats}</td>
    </tbody>
</table>

{if $vaninfo->code}
    <div class="clear_fix_both text-right">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
{/if}

<script>
    var vanTripInfo = {$vaninfo|json_encode};
    var vanPickupPnr = {$vanpkp_pnr|json_encode};

    function clearVanTripInfo() {
        $('.inp_error').removeClass('inp_error');
        $('#vanpkp_driver, #vanpkp_vehicle, #vanpkp_mobile').val('');
        $('#vanpkp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#vanpkp-action-state').html('');
        $('#vanpkp-action-state').hide();
    }

    function saveVanTripInfo() {
        var data = {};
        data.activeFlag = 1;
        data.code = $('#vanpkp_tripinfo_code').val();
        data.driver = {};
        data.driver.code = $('#vanpkp_driver').val();
        data.tripDate = $('#vanpkp_tripdate').val();
        data.mobileNumber = $.trim($('#vanpkp_mobile').val());
        data.vanPickup = {};
        data.vanPickup.code = $('#vanpkp_code').val();
        data.vehicle = {};
        data.vehicle.code = $('#vanpkp_vehicle').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.driver.code == '') {
            $('#vanpkp_driver').addClass('inp_error');
            err++;
        }
        if (data.vehicle.code == '') {
            $('#vanpkp_vehicle').addClass('inp_error');
            err++;
        }
        if (!isValidPhonenumber(data.mobileNumber)) {
            $('#vanpkp_mobile').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#vanpkp-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#vanpkp-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vanpkp-action-state').show();
            return false;
        }
        $('#vanpkp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#vanpkp-action-state').show();
        $('#vanpkp-action-state').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-van-trip-info",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#vanpkp-action-state').addClass('alert-success').removeClass('alert-danger');
                    $('#vanpkp-action-state').html('Your request has been completed successfully');
                } else {
                    $('#vanpkp-action-state').addClass('alert-danger').removeClass('alert-success');
                    $('#vanpkp-action-state').html(response.errorDesc);
                }
                window.setTimeout(function () {
                    $('#vanpkp-action-state').hide();
                    getPsngrVanpickupReport();
                }, 3000);
            }
        });
    }

    function smsVanTripInfo() {
        if (!confirm('Do you want to send SMS?')) {
            return;
        }
        $('#noti-progress').css({
            width: '0%'
        });
        $('#noti-list').removeClass('hidden');
        sendVanTripSMS();
    }

    function sendVanTripSMS(i = 0) {
        if (i === vanPickupPnr.length || location.hash !== '#report/vanpickup-chart') {
            $('#noti-list').addClass('hidden');
            $('#vanpkp-action-state').addClass('alert-success').removeClass('alert-danger');
            $('#vanpkp-action-state').html('SMS Sent Successfully');
            $('#vanpkp-action-state').show();
            window.setTimeout(function () {
                $('#vanpkp-action-state').hide();
            }, 3000);
            return;
        }

        var data = {}
        data.tripinfocode = $('#vanpkp_tripinfo_code').val();
        data.ticketCodes = [vanPickupPnr[i]];
        
        if(!data.tripinfocode) {
            return;
        }

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/send-vanpickup-sms",
            data: data,
            success: function (res) {
                if (res.status === 1) {
                    var per = ((i + 1) / vanPickupPnr.length) * 100;
                    $('#noti-progress').css({
                        width: per + '%'
                    });
                }
                sendVanTripSMS(i + 1);
            }
        });
    }
</script>