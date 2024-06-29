<div id="main-content">

    <div class="container">
        <div class="row">
            <div id="content" class="col-lg-12">
                <!-- PAGE HEADER-->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-header">
                            <div class="clearfix">
                                <h3 class="content-title pull-left">Station Points</h3>
                            </div>

                        </div>
                    </div>
                </div>
                <!-- /PAGE HEADER -->

                <div class="panel panel-default">
                    <div class="panel-body">
                        <form class="form-inline" role="form">

                            <div class="form-group">                                
                                <div class="input-group" id="state-list">
                                    <select class="form-control" id="sel_state_id" >
                                        <option value="">Select a State</option>                                     
                                        {foreach from=$entity item=states}
                                            <option value="{$states->code}">{$states->name}</option>
                                        {/foreach}     
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">                                
                                <div class="input-group" id="station-list">
                                    <select class="form-control" id="sel_station_id" >
                                        <option value="">Select a Station</option>
                                    </select>
                                </div>
                            </div>

                            <button type="button" class="btn btn-success" onclick="getStationPointsList()">Get List</button> 
                            <button type="button" class="btn btn-default" onclick="clearSPsearch()">Cancel</button>
                            
                            <a href="javascript:;" onclick="editStationPoint()">Add New Station Point</a>
                        </form>                        

                    </div>
                </div>
                <div class=" align-center alert alert-danger" id="action-status" style="display: none"></div>                    
                <div id="result-panel" style="display: none;">                    
                </div>

            </div><!-- /CONTENT-->
        </div>
    </div>
</div>

<div id="addedit-dialog" class="hide" >
    <div class="dialog">
        <div class="dialog-header">
            <div class="close"><i class="fa fa-times"></i></div>
            <div class="title">Add / Edit Station Point</div>            
        </div>
        <div class="dialog-body">
            <form role="form" class="form-horizontal">
            <div class="form-group">
                  <label class="col-sm-2 control-label" for="txt_sp_name">State<span class="required">*</span></label>
                  <div class="col-sm-10" id="addedit-state-list">
                    <select class="form-control" id="addedit_sel_state_id" >
                        <option value="">Select a State</option>                     
                    </select>
                  </div>
            </div>
            <div class="form-group">
                  <label class="col-sm-2 control-label" for="txt_sp_name">Station<span class="required">*</span></label>
                  <div class="col-sm-10" id="addedit-station-list">
                    <select class="form-control" id="addedit_sel_station_id" >
                        <option value="">Select a State</option>                     
                    </select>
                  </div>
            </div>    
            <div class="form-group">
                  <label class="col-sm-2 control-label" for="txt_sp_name">Name<span class="required">*</span></label>
                  <div class="col-sm-10">
                    <input type="text" placeholder="Name" id="txt_sp_name" class="form-control">
                  </div>
            </div>
            <div class="form-group">
                  <label class="col-sm-2 control-label" for="txt_sp_latitude">Latitude</label>
                  <div class="col-sm-10">
                    <input type="text" placeholder="Latitude" id="txt_sp_latitude" class="form-control">
                  </div>
            </div>
                
            <div class="form-group">
                  <label class="col-sm-2 control-label" for="txt_sp_longitude">Longitude</label>
                  <div class="col-sm-10">
                    <input type="text" placeholder="Longitude" id="txt_sp_longitude" class="form-control">
                  </div>
            </div> 
                
            <div class="form-group">
                  <label class="col-sm-2 control-label" for="txt_sp_longitude">Status<span class="required">*</span></label>
                  <div class="col-sm-10">                     
                      <select id="sel_sp_status" class="form-control">
                          <option value="">Select</option>
                          <option value="1">Active</option>
                          <option value="0">Disabled</option>
                      </select>
                  </div>
            </div>     

            </form>
        </div>
        <input type="hidden" id="hid_sp_code" value="" />
        <div class="dialog-footer">
            <div class="align-center alert alert-danger" style="display: none;" id="form-action-state"></div>
            <div class="col-sm-offset-2 col-sm-10 align-right" id="form-bttons">
              <button class="btn btn-success" type="button" onclick="saveStationPoint();">Save</button>
              <button class="btn btn-default" type="button" onclick="cancelSPAddEdit();">Cancel</button>
            </div>
      </div>
    </div>
</div> 
                                 
{literal}
    <script>
        jQuery(document).ready(function() {
            //App.setPage("dynamic_table");  //Set current page
            App.init(); //Initialise plugins and elements        
            // destination div, output type, dropdown id, selected value, callback on change.
            _getAllStates('state-list', 'dropdown', 'sel_state_id', '', 'getStationsDropdownByState()');
        });
    </script>
{/literal}