<table class="table remove-border-top noprint" id="chart_meta_container">
    <tr>
        <td>
            <div class="row">
                <div class="col-lg-10">
                    <div class="row">
                        <div class="col-lg-12">
                            <p class="text-muted">If found any driver / attender / vehicle not listed, kindly add in to master list. ( Master => Bus => Driver / Vehicle  ) </p>
                            <br/>
                        </div>
                        <br/>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="driver-name" class="req">Driver 1 Name & Mobile</label>
                                <select id="driver-name" class="form-control" onchange="getMobileNumber(this, '#driver-phone', drivers);">
                                    <option value="">Select Driver</option>
                                    {foreach from=$drivers item=row}
                                        <option value="{$row->code}" data-name="{$row->name}" {if $vehicles->primaryDriver->code == $row->code}selected{/if}>
                                            {$row->name|upper}
                                            {if $row->employeeCode!="" && $row->employeeCode!="NA"} | {$row->employeeCode} {/if}
                                            {if $row->mobileNumber!="" && $row->mobileNumber!="NA"} | {$row->mobileNumber} {/if}
                                        </option>
                                    {/foreach}
                                </select>
                                <p class="lic-status-info" style="display:none;position: absolute;" id="dri-action" class="form-control"></p>
                            </div>
                            <div class="form-group">
                                <label for="driver-name" class="invisible">Driver 1 Phone</label>
                                <input type="text" class="form-control" id="driver-phone" name="driver-phone" placeholder="Driver Phone" value="{if $vehicles->driverMobile != 'NA'}{$vehicles->driverMobile}{/if}">
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="driver-name" >Driver 2 Name & Mobile</label>
                                <select id="driver2-name" class="form-control" onchange="getMobileNumber(this, '#driver2-phone', drivers);">
                                    <option value="">Select Driver</option>
                                    {foreach from=$drivers item=row}
                                        <option value="{$row->code}" data-name="{$row->name}" {if $vehicles->secondaryDriver->code == $row->code}selected{/if}>
                                            {$row->name|upper}
                                            {if $row->employeeCode!="" && $row->employeeCode!="NA"} | {$row->employeeCode} {/if}
                                            {if $row->mobileNumber!="" && $row->mobileNumber!="NA"} | {$row->mobileNumber} {/if}
                                        </option>
                                    {/foreach}
                                </select>
                                <p class="lic-status-info" id="dri-action" style="display:none;position: absolute;" class="form-control"></p>
                            </div>
                            <div class="form-group">
                                <label for="driver-name" class="invisible">Driver 2 Phone</label>
                                <input type="text" class="form-control" id="driver2-phone" name="driver2-phone" placeholder="Driver2 Phone" value="{if $vehicles->driverMobile2 != 'NA'}{$vehicles->driverMobile2}{/if}">
                            </div>
                            
                            <br/><br/>
                            <br/><br/>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label for="driver-name">Attender Name & Mobile</label>
                                <select id="attender-name" class="form-control" onchange="getMobileNumber(this, '#attender-phone', attenders);">
                                    <option value="">Select Attender</option>
                                    {foreach from=$attenders item=row}
                                        <option value="{$row->code}" data-name="{$row->name}" {if $vehicles->attendant->code == $row->code}selected{/if}>
                                            {$row->name|upper}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="driver-name" class="invisible">Attender Phone</label>
                                <input type="text" class="form-control" id="attender-phone" name="attender-phone" placeholder="Attender Phone" value="{if $vehicles->attenderMobile != 'NA'}{$vehicles->attenderMobile}{/if}">
                            </div> 
                        </div>    
                        <div class="col-lg-3">
                            <div class="form-group">
                                <div class="form-group">
                                    <label for="remarks" class="req">Vehicle</label>
                                    <select id="vehicles" class="form-control">
                                        <option value="">Select Vehicle</option>
                                        {foreach name=o item=row key=k from=$vehicle}
                                            <option value="{$row->code}" {if $vehicles->busVehicle->code == $row->code}selected{/if}>
                                                {$row->registationNumber} 
                                                {if $row->bus->name != ""} ( {$row->bus->name} ) {/if}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="form-group center">
                                    <label class='' style='visibility: hidden'>save</label>
                                    <button class="btn btn-success pull-left" id="btn_save_remarks" onclick="save_driver_info()">Save</button>
                                    <br/><br/><br/>
                                    <div id="remarks_action"></div>
                            </div>                                                                
                        </div>   
                    </div>                                                            
                </div>
            </div>            
        </td>
    </tr>
</table>  
<input type="hidden" id="tripCode">


<script>
    var vehicle_list = {$vehicle|json_encode};
    var drivers = {$drivers|json_encode};
    var attenders = {$attenders|json_encode};
    var tdate = {$current_date|json_encode};
    
    $('#driver-name').select2();
    $('#driver2-name').select2();
    $('#attender-name').select2();
    $('#vehicles').select2({
        placeholder: "Select vehicle",
        escapeMarkup: function(markup) {
            return markup;
        }
    });
    
    function getMobileNumber(select, inputId, list = []) {
        $(select).next('.lic-status-info').html('');
        var dcode = $(select).val();
        if(dcode == ''){
            return;
        }
        var option = _.find(list, function (o) {
            return o.code === dcode;
        });
        
        var days = expiryDate(option.licenseExpiryDate);
        if(days == 0 || days < 0){
            $(select).next('.lic-status-info').addClass('text-danger').removeClass('text-warning');
            $(select).next('.lic-status-info').html('Licence Expired');
        }else if(days <= 15){
            $(select).next('.lic-status-info').addClass('text-warning').removeClass('text-danger');
            $(select).next('.lic-status-info').html('Licence will be expired in '+days+' days');
        }
            
        $(select).next('.lic-status-info').show();
        $(inputId).val(option.mobile || option.mobileNumber);
    }
    
    function expiryDate(date_string) {
        var expiration = moment(date_string).format("YYYY-MM-DD");
        var current_date = moment(tdate).format("YYYY-MM-DD");
        var days = moment(expiration).diff(current_date, 'days');
        return days;
    }
</script>

