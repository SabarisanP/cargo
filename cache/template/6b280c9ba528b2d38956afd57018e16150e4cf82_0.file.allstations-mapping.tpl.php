<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-14 12:50:07
  from 'E:\xampp\htdocs\cargo\application\views\site\admin\allstations-mapping.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666bef27479b87_19347655',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '6b280c9ba528b2d38956afd57018e16150e4cf82' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\admin\\allstations-mapping.tpl',
      1 => 1716451523,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666bef27479b87_19347655 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Stations</h3> 
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">
                                        <form class="form-inline" role="form">
                                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['S-ADD-STATION'] > 0) {?><div class="form-group">                                
                                                    <div class="input-group" id="state-list">
                                                        <select class="form-control" id="sel_state_id" >
                                                            <option value="">Select a State</option> 
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group hidden" id="sp-list">
                                                    <div class="row">
                                                        <div class="col-lg-6">
                                                            <select id="station_list" class="form-control wi_200">
                                                                <option value="">Select</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                            <?php }?>
                                            <input type='hidden' id='s_delete' value=<?php echo $_smarty_tpl->tpl_vars['action_rights']->value['S-DELETE-STATION'];?>
>
                                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['S-ADD-STATION'] > 0) {?><button type="button" class="btn btn-success" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['S-ADD-STATION'] != 2) {?> onclick="addNamespaceMapping()"<?php }?>>Add to My Stations</button> <?php }?>

                                        </form> 
                                    </div>        
                                    <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['S-ADD-STATION'] > 0) {?>   <br /><?php }?>
                                    <div class="warning-text" id="search-status"></div>

                                    <div id="result-panel" class="hide">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="address-book">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="align-center" id="action-status"></div>
                                        <h4>My Stations</h4>
                                        <div id="namespace"></div>
                                    </div>                                    
                                    <div class="col-md-9">                                         
                                        <div id="station-point-result">
                                            <div class="p_t_100">
                                                <div class="well well-large "> Click any of the station to view station points.</div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" value="" id="addedit_sel_station_id" name="addedit_sel_station_id" />
                                </div><!--panel Body end-->
                            </div><!--panel end-->
                        </div>
                    </div><!--row end-->
                </div><!--content end-->
            </div>
        </div>
    </div>

</div>

<div id="station-point-dialog" class="dialog" style="display: none">
    <form role="form" class="form-horizontal pf_15" data-parsley-validate>
        <div class="col-md-5">

            <div class="form-group">
                <label class="req" for="txt_sp_name">Name</label>
                <div class="">
                    <input type="text" placeholder="Name" id="txt_sp_name" class="form-control">
                    <span class="text-muted"><i class="fa fa-info-circle"></i> Special characters not allowed (except 0-9, A-Z, (, ), blank space).</span>
                </div>
            </div>
            <div class="form-group">
                <label class="req" for="txt_sp_address">Address</label>
                <div class="">
                    <textarea id="txt_sp_address" class="form-control rs_no" rows="7" maxlength="250"></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="req" for="txt_sp_phone">Phone Number</label>
                <div class="">
                    <input type="text" placeholder="Phone number" id="txt_sp_phone" class="form-control">
                </div>
            </div> 

            <div class="form-group">
                <label class="req" for="txt_sp_landmark">Land Mark</label>
                <div class="">
                    <input type="text" placeholder="Land Mark" id="txt_sp_landmark" class="form-control">
                </div>
            </div> 

            <div class="form-group">
                <input type="checkbox" id="share_to_cust" onchange="toggleDirections();"> 
                <label for="share_to_cust" class="d-inline-block">&nbsp;Want to share google map directions to customers?</label>
                <div id="sec-directions" style="display:none;">                    

                    <div class="help-block">
                        <span class="text-danger">Attention!, </span> Drag and place the red color map pin in to exact location of your boarding point in Google map. 
                        Click on the bellow link and make sure it redirectes to corrent location.
                    </div>


                    <div class="text-center">
                        <span><i class="fa fa-map-marker fa-lg text-danger"></i></span> &nbsp; <a href="" id="a_directions" target="_blank">Directions Link</a>
                    </div>

                </div>
            </div> 

            <div class="form-group" id="dialog_footer">
                <br/>
                <div id="st-form-action-state" class="fl align-center alert alert-danger"></div>
                <div class="align-right" id="form-bttons">
                    <button class="btn btn-success" type="button" onclick="saveStationPoint();">Save</button>
                    <button class="btn btn-default" type="button" onclick="cancelSPAddEdit();">Cancel</button>
                </div>
            </div>
        </div>
        <input type="hidden" id="txt_sp_latitude">
        <input type="hidden" id="txt_sp_longitude">
        <input type="hidden" id="sel_sp_status" value="1">
        <input type="hidden" id="hid_sp_code" value="">
        <input type="hidden" id="station_name" value="">
        <input type="hidden" id="newStation" value="">
        <div class="align-right col-md-7 hide">Latitude: &nbsp;<span id="lag_id"></span>&nbsp; Longitude: &nbsp;<span id="lat_id"></span></div>
        <div class="col-md-7">
            <div id="map_canvas"></div>
        </div>                 
    </form>
</div>

<?php echo '<script'; ?>
>

    function loadstations_mapping() {

        _getAllStates('state-list', 'dropdown', 'sel_state_id', '', 'bulidStationPoint()');
        $('#station_list').select2({
            allowClear: true,
            width: 'resolve',
            placeholder: "Select..."
        });
        buildNameSpaceMappingList();
    }

    $('#txt_sp_name').on('input', function () {
        this.value = this.value.replace(/[^a-zA-Z\d\s:\(\)]/, '');
    });

<?php echo '</script'; ?>
><?php }
}
