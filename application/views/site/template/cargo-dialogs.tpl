<div id="quick-add-vehicle-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="closeQuickAddVehicle();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="quick-add-vehicle-pannel" class="clearfix" style="padding: 5px;">
        <div class="row">
            <div class="col-lg-12">
                <div class="form-group">
                    <label for="quick_vehicle_regno" class="req">Registration Number</label>
                    <input placeholder="Registration Number" id="quick_vehicle_regno" name="reg_no" class="form-control" maxlength="15">
                    <small class="text-muted"><i class="fa fa-info-circle"></i> Special characters not allowed (except 0-9, A-Z, blank space).</small>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label for="quick_vehicle_type" class="req">Vehicle Type</label>
                    <select id="quick_vehicle_type" class="form-control col-md-6">
                        <option value="">Select</option>
                        <option value="TRUCK">Truck</option>
                        <option value="MINITRUCK">Mini Truck</option>
                        <option value="BUS">Bus</option>
                    </select>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group">
                    <label for="quick_vehicle_own_type" class="">Ownership Type</label>
                    <select id="quick_vehicle_own_type" class="form-control col-md-6">
                        <option value="OWN">Own</option>
                        <option value="ATCH">Attached</option>
                        <option value="HIRE">Hire / Walk-In</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="clear_fix_both"></div><br>
        <div class="clear_fix_both">
            <div class="alert" style="display: none;" id="quick-vehicle-action-state"></div>
            <div class="align-right" id="quick-vehicle-buttons">
                <button class="btn btn-success" type="button" onclick="saveQuickAddVehicle();">Save</button>
                <button class="btn btn-default" type="button" onclick="closeQuickAddVehicle();">Cancel</button>
            </div>
        </div>
    </div>
</div>

<div id="start-transit-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideStartTransitDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="start-transit-panel" class="clearfix" style="padding: 10px 5px;"></div>
</div>

<div id="end-transit-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideEndTransitDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="end-transit-panel" class="clearfix" style="padding: 10px 5px;"></div>
</div>