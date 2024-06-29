<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-27 18:14:51
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\transit-odometer-details.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667d5ec35a3989_97581326',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '254264298ed698c45d82b34e01755c7f8e9e29ed' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\transit-odometer-details.tpl',
      1 => 1719464251,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667d5ec35a3989_97581326 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="row">
    <div class="col-md-6">
        <?php if ($_smarty_tpl->tpl_vars['type']->value == 'print' && $_smarty_tpl->tpl_vars['namespace']->value == 'seenutransports') {?>
            <div class="">
                <img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/img/Seenu-Cargo-header.jpg" alt="logo" style="max-width: 100%;">
            </div>
        <?php } elseif ($_smarty_tpl->tpl_vars['type']->value == 'print') {?>
            <h3 class="bold text-center "><?php echo $_smarty_tpl->tpl_vars['namespace']->value;?>
</h3>
        <?php } elseif ($_smarty_tpl->tpl_vars['namespace']->value == 'seenutransports') {?>
            <a class="btn btn-success pull-right" href="javascript:;" onclick="print_ogpl_routes('<?php echo $_smarty_tpl->tpl_vars['transitCode']->value;?>
')">Print</a>
        <?php } else { ?>
            <a class="btn btn-success pull-right" href="javascript:;" onclick="print_cargo_ogpl_routes('<?php echo $_smarty_tpl->tpl_vars['transitCode']->value;?>
')">Print</a>
        <?php }?>

        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['odometer']->value, 'transit', false, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value => $_smarty_tpl->tpl_vars['transit']->value) {
?>
            <h5 class="bold "><?php echo $_smarty_tpl->tpl_vars['station']->value;?>
</h5>
            <?php $_smarty_tpl->_assignInScope('i', 0);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transit']->value, 'routes', false, 'transitTypeCode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['transitTypeCode']->value => $_smarty_tpl->tpl_vars['routes']->value) {
?>
                <h6 class="bold">&nbsp;
                    <?php if ($_smarty_tpl->tpl_vars['transitTypeCode']->value == 'TRNT') {?>
                        OGPL
                    <?php } elseif ($_smarty_tpl->tpl_vars['transitTypeCode']->value == 'INTRNT') {?>
                        Local Transit
                    <?php } elseif ($_smarty_tpl->tpl_vars['transitTypeCode']->value == 'OTFD') {?>
                        Door Pickup and Delivery
                    <?php }?>
                </h6>
                <div class="p_l_15">
                <?php $_smarty_tpl->_assignInScope('edit_permision', $_smarty_tpl->tpl_vars['action_rights']->value['EDT_ODOMTR']);?>                      <table class="table info_table bordered" cellpadding="3">
                        <thead>
                            <tr>
                                <td class="bold" width="25%">Departure & Arrival</td>
                                <td class="bold" width="20%">Location</td>
                                <td class="bold" width="10%">KM</td>
                                <td class="bold" width="20%">Supervisor</td>
                                <td class="bold" width="20%">Date Time</td>
                                <?php if ($_smarty_tpl->tpl_vars['edit_permision']->value) {?>
                                    <td class="bold" width="20%"></td>
                                <?php }?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['routes']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                    <tr>
                                        <td>DEP:Starting KM</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->fromOrganization->name;?>
</td>
                                        <td><?php if ($_smarty_tpl->tpl_vars['row']->value->startOdometer > 0) {
echo $_smarty_tpl->tpl_vars['row']->value->startOdometer;
} else { ?>-<?php }?></td>
                                        <td><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->fromOrganizationContact->name)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                                        <td nowrap><?php echo (($tmp = @smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->departureAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value))===null||$tmp==='' ? '-' : $tmp);?>
</td>
                                        <?php if ($_smarty_tpl->tpl_vars['edit_permision']->value) {?>
                                            <?php if ($_smarty_tpl->tpl_vars['row']->value->startOdometer > 0) {?>
                                                <td> <i class="fa fa-edit" onclick="showEditTripdialog('from','<?php echo $_smarty_tpl->tpl_vars['row']->value->additionalAttribute->fromEntryType;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->additionalAttribute->fromReferenceCode;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->startOdometer;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->departureAt;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->fromOrganization->code;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->fromOrganizationContact->code;?>
');" data-toggle="tooltip" data-title="Notes" data-original-title="Edit Odometer details" title="<?php echo $_smarty_tpl->tpl_vars['row']->value->startOdometer;?>
"></i><td>
                                            <?php }?>
                                        <?php }?>
                                    </tr>
                                    <?php $_smarty_tpl->_assignInScope('i', $_smarty_tpl->tpl_vars['i']->value+1);?>
                                                                                                    <tr>
                                        <td>ARR:Closing KM</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->toOrganization->name;?>
</td>
                                        <td><?php if ($_smarty_tpl->tpl_vars['row']->value->endOdometer > 0) {
echo $_smarty_tpl->tpl_vars['row']->value->endOdometer;
} else { ?>-<?php }?></td>
                                        <td><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->toOrganizationContact->name)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                                        <td nowrap><?php echo (($tmp = @smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->arrivalAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value))===null||$tmp==='' ? '-' : $tmp);?>
</td>
                                        <?php if ($_smarty_tpl->tpl_vars['edit_permision']->value) {?>
                                            <?php if ($_smarty_tpl->tpl_vars['row']->value->endOdometer) {?>
                                                <td><i class="fa fa-edit" onclick="showEditTripdialog('to','<?php echo $_smarty_tpl->tpl_vars['row']->value->additionalAttribute->toEntryType;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->additionalAttribute->toReferenceCode;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->endOdometer;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->departureAt;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->toOrganization->code;?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value->toOrganizationContact->code;?>
');" data-toggle="tooltip" data-title="Notes" data-original-title="Edit Odometer details" title="<?php echo $_smarty_tpl->tpl_vars['row']->value->endOdometer;?>
"></i><td>
                                            <?php }?>
                                        <?php }?>
                                    </tr>
                                    <?php $_smarty_tpl->_assignInScope('i', $_smarty_tpl->tpl_vars['i']->value+1);?>
                                                                                                    <tr>
                                        <td></td>
                                        <td class="bold" align="center">Total</td>
                                        <td class="bold"><?php if ($_smarty_tpl->tpl_vars['row']->value->startOdometer > 0 && $_smarty_tpl->tpl_vars['row']->value->endOdometer > 0) {
echo ($_smarty_tpl->tpl_vars['row']->value->endOdometer-$_smarty_tpl->tpl_vars['row']->value->startOdometer);
} else { ?>-<?php }?></td>
                                        <td></td>
                                        <td class="bold" nowrap><?php if ($_smarty_tpl->tpl_vars['row']->value->runningTime) {
echo $_smarty_tpl->tpl_vars['row']->value->runningTime;?>
 Hrs<?php } else { ?>-<?php }?></td>
                                    </tr>
                                    <?php $_smarty_tpl->_assignInScope('i', $_smarty_tpl->tpl_vars['i']->value+1);?>
                                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </tbody>
                    </table>
                </div>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php if ($_smarty_tpl->tpl_vars['i']->value == 0) {?>
                <tr>
                    <td align="center" colspan="5">No Data Found</td>
                </tr>
            <?php }?>
        <?php
}
} else {
?>
            <div class="clearfix"></div><br>
            <div class="well">No Data Found</div>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </div>
    <div class="col-md-6 noprint">
        <div id="transit-via-map"></div>
    </div>
</div>
<div id="start-trip-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideEditStartTripDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="start-trip-panel" class="clearfix" style="padding: 10px 5px;">
          <input type="hidden" name ="entrytype" id="entrytype">
          <input type="hidden" name ="reference" id="reference">
          <input type="hidden" name ="tripat" id="tripAt">
          <input type="hidden" name ="fromOrganization" id="fromOrganization">
            <div class="row">
                <div class="col-md-6 text-center">
                    <img src="assets/img/start-trip.png" width="80%">
                </div>
                <div class="col-md-6 text-right">
                    <h4 class="bold">Arrival Time</h4>
                    <h5 id="trip-start-date"></h5>
                    <h4 id="trip-start-time"></h4>
                    <div class="clearfix"></div>
                    <h5 class="bold">Last odometer Reading</h5>
                    <h4><span id="last-odometer"></span> Km</h4>
                </div>
                <div class="col-md-12">
                    <label class="req h5">Please ensure that you enter a valid odometer reading.</label>
                    <div class="row">
                        <div class="col-md-4">
                            <input type="number" id="start-trip-odo" class="form-control no-spin" placeholder="Odometer">
                        </div>
                        <div class="col-md-4 p_l_n">
                            <div class="input-group col-md-12">
                                <select id="start-trip-supervisor" class="form-control">
                                    <option value="" selected>Select Supervisor</option>
                                                                    </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning col-md-3" id="start-trip-btn" onclick="editStartOGPLTrip();">Change Trip</button>
                            
                    </div>
                </div>
                <div class="col-md-12"><br>
                    <div id="start-trip-action-state"></div>
                </div>
            </div>
    </div>
</div>

<style>
    .leaflet-top,
    .leaflet-bottom {
        z-index: 10 !important;
    }

    .leaflet-pane {
        z-index: 4 !important;
    }
</style>

<style type="text/css" media="print">
    @media print {
        table {
            border-collapse: collapse;
            width: 100%;
        }

        table thead th,
        table thead td {
            font-weight: bold;
        }

        table.bordered th,
        table.bordered td {
            border: 1px solid #000;
        }
        .text-center {
            text-align: center;
        }

        .noprint {
            display: none;
        }
    }
</style>

<?php echo '<script'; ?>
>
    var odoDetailsData = <?php echo json_encode($_smarty_tpl->tpl_vars['odoDetails']->value);?>
;
    var type = <?php echo json_encode($_smarty_tpl->tpl_vars['type']->value);?>
;
    var fromSupervisor = <?php echo json_encode($_smarty_tpl->tpl_vars['from_supervisors']->value);?>
;
    var toSupervisor = <?php echo json_encode($_smarty_tpl->tpl_vars['to_supervisors']->value);?>
;
   

    if (type == 'print') {
        print_cargo_ogpl_routes();
    }
    
    
        function initViaRouteMap(stations) {
            var map = L.map('transit-via-map', { attributionControl: false }).setView([20.5937, 78.9629], 5);

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

            var markerLayer = L.featureGroup();
            $.each(odoDetailsData || [], function(i, detail) {
                if (Number(detail.fromOrganization.latitude) && Number(detail.fromOrganization.longitude)) {
                    L.marker([detail.fromOrganization.latitude, detail.fromOrganization.longitude])
                        .bindPopup('<b>' + detail.fromOrganization.name + '</b>')
                        .addTo(markerLayer);
                }

                if (Number(detail.toOrganization.latitude) && Number(detail.toOrganization.longitude)) {
                    L.marker([detail.toOrganization.latitude, detail.toOrganization.longitude])
                        .bindPopup('<b>' + detail.toOrganization.name + '</b>')
                        .addTo(markerLayer);
                }
            });

            markerLayer.addTo(map);
            map.fitBounds(markerLayer.getBounds());
        }

        initViaRouteMap();
    

    function print_cargo_ogpl_routes(transitCode) {
        var url = base_url + "cargo/ogpl-odometer-report?transitCode="+transitCode+"&type=print";
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }

    function print_ogpl_routes(transitCode) {
        var url = base_url + "cargo/ogpl-route-print?transitCode="+transitCode;
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }
    
    
    

    function showEditTripdialog(choosedType,entryType,referenceCode,odometer,tripAt,fromOrganization,supervisor) {

        $.ajax({
            type: "POST",
            url:base_url + 'cargo/get-supervisor',
            dataType: 'json',
            data:{
                'organizationCode':fromOrganization,
                'categoryCode':'SPVSR'
            },
            success: function (response) {
                if(response.status == 1){
                    var html = "";
                    $('#start-trip-supervisor').html();
                    html += '<option value="NA">Choose Supervisor</option>';
                    html += response.data.map((item) => {
                        var selectedAttribute = (item.code === supervisor) ? 'selected' : '';
                        return `<option value="${item.code}" ${selectedAttribute}>${item.name}</option>`; 
                    }).join('');
                   $('#start-trip-supervisor').html(html);
                }
            }     
        })

        $('#start-trip-dialog').removeClass('hide');
        $('#last-odometer').text(odometer);
        $('#entrytype').val(entryType);
        $('#reference').val(referenceCode);
        $('#tripAt').val(tripAt);
        $('#fromOrganization').val(fromOrganization);

        var supervisorSelect = $('#start-trip-supervisor');
        var supervisorValue = supervisorSelect.val();
        var supervisorOption = supervisorSelect.find('option[value="' + supervisor + '"]');

        $('#start-trip-dialog').dialog({
            autoOpen: true,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $('#start-trip-dialog .inp_error').removeClass('inp_error');
        $('#start-trip-action-state').removeClass('alert alert-danger alert-success').html('');
        $('#start-trip-odo').val(odometer);
        let tripMoment = moment(tripAt);
        $('#trip-start-date').html(tripMoment.format('DD MMM YYYY'));
        $('#trip-start-time').html(tripMoment.format('hh : mm A'));
    }
    

    function hideEditStartTripDialog() {
        $('#start-trip-dialog').dialog('destroy');
        $('#start-trip-dialog').hide();
    }
    function editStartOGPLTrip(){
        let entryType =$('#entrytype').val();
        let tripAt =$('#tripAt').val();
        var data = {};
        data.code = $('#reference').val();
        data.action = entryType;
        data.transitCode = '<?php echo $_REQUEST['transitCode'];?>
';
        data.startOdometer = Number($('#start-trip-odo').val());
        data.fromOrganization = {};
        data.fromOrganization.code =$('#fromOrganization').val();
        data.fromOrganizationContact = {};
        data.fromOrganizationContact.code =$('#start-trip-supervisor').val();
        data.departureAt = moment(tripAt).format('YYYY-MM-DD HH:mm:ss');

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/edit-odometer",
            data: data,
            success: function (response) {
                if (response.status == 1) {                
                    $('#start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                    window.setTimeout(function () {
                        hideEditStartTripDialog();
                        toggleOgplList();
                       
                    }, 3000);
                } else {
                    $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);  
                    $('#start-trip-panel-btn').show();
                }
            }
        });
    }
<?php echo '</script'; ?>
>
<?php }
}
