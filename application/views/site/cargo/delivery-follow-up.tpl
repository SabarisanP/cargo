<div class="row">
    <div class="col-md-5">
        <div class="form-group">
            <label class="req">Contacted To</label>
            <input type="text" class="form-control" placeholder="Contact Person Name" id="followup-contact-person"/>
        </div>
    </div>
    <div class="col-md-7">
        <div class="form-group">
            <label class="req">Contacted At</label>
            <div class="input-group">
                <input type="text" name="fromDate" class="form-control sdate" id="followup-contacted-at" readonly="true" placeholder="Contacted At">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>
    </div>
    <div class="col-md-9">
        <div class="form-group">
            <label class="req">Remarks</label>
            <textarea class="form-control" placeholder="Remarks" id="followup-remarks"></textarea>
        </div>
    </div>
    <div class="col-md-3" id="followup-panel-btn">
        <label>&nbsp;</label>
        <button type="button" class="btn btn-success" onclick="saveDeliveryFollowUp();">Save</button>&nbsp;
        <button type="button" class="btn btn-default" onclick="hideLRActivityDialog();">Cancel</button>&nbsp;
    </div>
    <div class="col-md-12">
        <div id="followup-action-state"></div>
    </div>
</div>

<h6 class="bold">Follow Up Details</h6>
<div>
    <table class="table table-bordered">
        <thead>
            <tr class="active">
                <th>Contacted To</th>
                <th>Contacted At</th>
                <th>Remarks</th>
            </tr>
        </thead>
        <tbody>
            {assign var="remarksCount" value=0}
            {foreach from=$followup item=row}
                {if $row->cargoStatusCode == 'DLFLW'}
                    {assign var=details value=explode('|', $row->name)}
                    <tr>
                        <td>{$details[0]}</td>
                        <td>{$details[1]|date_format:$ns_datetime_format}</td>
                        <td>{$details[2]}</td>
                    </tr>
                    {assign var="remarksCount" value=$remarksCount + 1}
                {/if}
            {/foreach}
        </tbody>
        {if $remarksCount == 0}
            <tfoot>
                <tr>
                    <td colspan="100%" align="center">No records Found</td>
                </tr>
            </tfoot>
        {/if}
    </table>
</div>

<script>
    $(function () {
        $('#followup-contacted-at').daterangepicker({
            singleDatePicker: true,
            timePicker: true,
            timePickerIncrement: 1,
            format: 'DD-MM-YYYY hh:mm A',
            minDate: moment().subtract(1, 'd').startOf('d'),
            maxDate: moment(),
            autoApply: false,
            showDropdowns: false,
        }).on('hide.daterangepicker', function(ev, picker) {
            picker.updateInputText();
        });

        var picker = $('#followup-contacted-at').data('daterangepicker');
        picker.setStartDate(moment());
        picker.updateInputText();
    });

    function saveDeliveryFollowUp() {
        var data = {}, err = 0;
        data.activeFlag = 1;
        data.code = '';
        data.cargoCode = lrdata.code;
        data.cargoStatusCode = 'DLFLW';

        var followupContactPerson = $.trim($('#followup-contact-person').val());
        var followupContactedAt = $.trim($('#followup-contacted-at').val());
        var followupRemarks = $.trim($('#followup-remarks').val());

        var picker = $('#followup-contacted-at').data('daterangepicker');

        data.name = [followupContactPerson, picker.startDate.format('YYYY-MM-DD HH:mm:ss'), followupRemarks].join('|');

        $('.inp_error').removeClass('inp_error');
        if (!followupContactPerson) {
            $('#followup-contact-person').addClass('inp_error');
            err++;
        }
        if (!followupContactedAt) {
            $('#followup-contacted-at').addClass('inp_error');
            err++;
        }
        if (!followupRemarks) {
            $('#followup-remarks').addClass('inp_error');
            err++;
        }

        if (err) {
            $('#followup-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
            $('#followup-action-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }

        $('#followup-panel-btn').hide();
        $('#followup-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-remarks",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#followup-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function() {
                        getFollowUpDetails();
                    }, 2000);
                } else {
                    $('#followup-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                    $('#followup-panel-btn').show();
                }
            }
        });
    }
</script>