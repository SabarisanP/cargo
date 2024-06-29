<div class="brand_top"><h3>Cargo Routes</h3></div>
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
                                    <div class="table-responsive">
                                        <table id="cargo-route-table" class="table table-bordered">
                                            <thead>
                                                <tr class="success">
                                                    <th>From</th>
                                                    <th>To</th>
                                                    <th>Distance</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                <tr id="tr-cargo-route-form">
                                                    <td width="20%">
                                                        <select id="from_station" name="from_station"  class="form-control from-station" onclick="toggleToStation('', '');">
                                                            <option value='' selected = 'selected'>From Station</option>
                                                            {foreach item=station from=$stations key=scode}
                                                                <option value="{$station.code}" >{$station.name}</option>
                                                            {/foreach}
                                                        </select>
                                                        <span class="from-ele"></span>
                                                    </td>
                                                    <td width="20%">
                                                        <select id="to_station" name="to_station"  class="form-control to-station">
                                                            <option value="">To Branch</option>                                                            
                                                        </select>
                                                        <span class="to-ele"></span>
                                                    </td>
                                                    <td width="10%">
                                                        <input type="text" class="form-control cargo-route-distance " maxlength="5" placeholder="Distance" value="" data-key="Distance">
                                                    </td>
                                                    <td width="15%">
                                                        <input type="hidden" name="code" id="hid-code"/>
                                                        <div style="display: none;" class="cargo-route-action-state"></div>
                                                        <div>
                                                            <button class="btn btn-success" type="button" onclick="saveCargoRoutes(this);">Save</button>
                                                            <a href="javascript:;" onclick="addCargoRoute()" title="close" class="btn btn-default btn-xs btn-close" style="display: none;"><i class="fa fa fa-times"></i></a>
                                                        </div>
                                                    </td>
                                                </tr>
                                                {foreach item=row from=$result key=k}
                                                    <tr id='item_{$row->fromStation->code}_{$row->toStation->code}'>
                                                        <td width="20%">{$row->fromStation->name}</td>
                                                        <td width="20%">{$row->toStation->name}</td>
                                                        <td width="10%">{$row->distance} &nbsp;KMs</td>
                                                        <td width="15%">
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not edat" title="Edit" onclick='editCargoRoute(this,{$row|@json_encode});'><i class="fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not delam" title="Delete" onclick='deleteCargoRoute({$row|@json_encode})'><i class="fa fa-trash-o ired"></i></a>
                                                        </td>
                                                    </tr>
                                                    <div id="notify_mes_{$row->code}" style="display:none">{$row->description}</div>
                                                {/foreach} 
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="clear_fix_both"></div>
                                
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>


<script>
    var allRoutes = {$stations|json_encode};
    
    addCargoRoute();

    function toggleToStation(fromCode, toCode) {
        var fromStationCode = '';
        var toStationCode = '';
        var selected = "selected = selected";
        if (fromCode == '') {
            fromStationCode = $('#from_station').val();
        } else if ((fromCode != '') && (toCode != '')) {
            fromStationCode = fromCode;
            toStationCode = toCode;
        }

        $(allRoutes).each(function(key, val){
            if(val != undefined && val.code == fromStationCode){
                delete allRoutes[key]
            }
        })
        
        var tbhtml = '<option value="">To Station</option>';
        $(allRoutes).each(function (i, e) {
            if(e != undefined){
                tbhtml += '<option value="' + e.code + '"+>' + e.name + '</option>';
            }
        });

        $("#to_station").select2("destroy");
        $('#to_station').html(tbhtml);
        $("#to_station").select2({
            width: 'resolve',
            dropdownParent: $('#cargo-item-dialog')
        });
        if (toStationCode != '') {
            $('#to_station').val(toStationCode);
            $('#to_station').trigger('change');
        }
    }
    
    function editCargoRoute(el,option){
        var $tr = $(el).closest('tr');
        
        var $formtr = $('#tr-cargo-route-form');
        $formtr.find(':input').val('');
        $formtr.find(':input').removeClass('inp_error');
        $formtr.find('.cargo-route-action-state').html('');
        $formtr.find('#hid-code').val(option.code);
        $formtr.find('input.cargo-route-distance').val(option.distance);
        $formtr.find('select.from-station').val(option.fromStation.code).trigger('change');
        
        $formtr.find('select.to-station').val(option.toStation.code).trigger('change');
        toggleToStation(option.fromStation.code , option.toStation.code);
        $formtr.find('.btn-close').show();
        
       $('#cargo-route-table tbody tr.hidden').removeClass('hidden');
        $tr.after($formtr).addClass('hidden');
        $formtr.find('input[data-key]:first').focus();
        
        $formtr.find('select.from-station, select.to-station').addClass('hide');
        $formtr.find('span.to-ele').html(option.toStation.name);
        $formtr.find('span.from-ele').html(option.fromStation.name);
    
    }
    function addCargoRoute() {
        $('#from_station').select2("destroy");
        $('#to_station').find('option').remove().end().append('<option value="">To Station</option>');
        $('#from_station').select2({
            width: 'resolve',
            dropdownParent: $('#cargo-item-dialog')
        });
        $('#rt_distance,#from_station,#to_station').val('');
        $('#from_station').val($('#from_station option:eq(0)').val()).trigger('change');
        $('#to_station').val($('#to_station option:eq(0)').val()).trigger('change');
        var $formtr = $('#tr-cargo-route-form').detach();
        $formtr.find(':input').val('').trigger('change');
        $formtr.find(':input').removeClass('inp_error');
        $formtr.find('.btn-close').hide();
        $formtr.find('span.from-ele').html('');
        $formtr.find('span.to-ele').html('');
        $formtr.find('select.from-station, select.to-station').removeClass('hide');
        $formtr.find('.cargo-route-action-state').html(''); 
        $('#cargo-route-table tbody').prepend($formtr);
        $('#cargo-route-table tbody tr.hidden').removeClass('hidden');
    }    
    function saveCargoRoutes(el){
        var err = 0;
        
        $('#cargo-route-table .inp_error').removeClass('inp_error');
        
        var $tr = $(el).closest('tr');
        var data = {};
        data.code = $('#hid-code').val();
        data.activeFlag = 1;
        data.distance = $('input.cargo-route-distance').val();
        data.fromStation = $tr.find('select.from-station').val();
        data.toStation = $tr.find('select.to-station').val();
        
        if (data.fromStation == '') {
            $tr.find('select.from-station').addClass('inp_error');
            err++;
        }
        if (data.toStation == '') {
            $tr.find('select.to-station').addClass('inp_error');
            err++;
        }
        if (data.distance == '') {
            $tr.find('input.cargo-route-distance').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $tr.find('.cargo-route-action-state').removeClass('alert-success').addClass('alert-danger');
            $tr.find('.cargo-route-action-state').html('Please enter/select the values in the field that are marked in red');
            $tr.find('.cargo-route-action-state').show();
            return false;
        }

        $tr.find('.cargo-route-action-state').removeClass('alert-danger').removeClass('alert-success');
        $tr.find('.cargo-route-action-state').html(loading_popup);
        $tr.find('.cargo-route-action-state').show();
        $tr.find('.btn-save').hide();
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-cargo-route",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $tr.find('.cargo-route-action-state').removeClass('text-danger');
                    $tr.find('.cargo-route-action-state').addClass('text-success');
                    $tr.find('.cargo-route-action-state').html('Success').show();
                    setTimeout(function () {
                        checkURL();
                        return;
                    }, 2000);

                } else {
                    $tr.find('.cargo-route-action-state').addClass('text-danger');
                    $tr.find('.cargo-route-action-state').html(response.errorDesc).show();
                }
            }
        });
            
    }

    function deleteCargoRoute(options) {
        if (confirm('Do you want to delete this route ?')) {
            var data = {};
            data.code = options.code
            data.distance = options.distance;
            data.activeFlag = 2;
            data.fromStation = options.fromStation.code;
            data.toStation = options.toStation.code;

            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/update-cargo-route",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        checkURL();
                        return;
                    }, 2000);
                }
            })
        }
    }

</script>    