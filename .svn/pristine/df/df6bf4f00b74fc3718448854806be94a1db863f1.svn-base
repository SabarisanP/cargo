<div class="brand_top">
    <h3>Unload Cargo Bookings</h3> 
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">                        
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">                                        
                                        <div class="">
                                            <div id="search-panel">                                         

                                                <form id='unload_cargo_form' method="post" name="cargo_unload" action="" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="unload_date">Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="Date" class="form-control sdate" id="unload_date" readonly="true" placeholder="Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2 hide">
                                                            <label  for="vehicle_no">Vehicle No</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="vehicle_no" name="vehicleNo"  class="form-control" >
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <button class="btn btn-success" type="button"  onclick="getLRList();">Get {lang('lr')}</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearUnloadCargo();">Clear</button>
                                                            </div>
                                                        </div>
                                                       
                                                    </div>  
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="unload_cargo_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="find-uncargo-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="find-uncargo-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
  

{literal}
    <script>
        $('#unload_date').datepicker({
            todayHighlight: true,
            format: 'yyyy-mm-dd',
            endDate:'0d',
            autoclose: true,
            changeMonth: true,
            endDate:"0d"
        }).on('changeDate', function (e) {
            getVehicleNos();
        });
        
        function getVehicleNos(){
            var data = {};
            data.date = $.datepicker.formatDate("yy-mm-dd", $('#unload_date').datepicker('getDate'));
            $('#vehicle_no').html('<option value="">Select a vehicle</option>');
            $.ajax({
                type: "POST",
                url: base_url +"cargo/get-vehicle-no",
                data: data,
                dataType: 'json',   
                success: function (response) {
                    $.each(response, function(key, value) {
                        if(_.has(value, 'tripInfo.busVehicle.registationNumber')) {
                            $('#vehicle_no').append($("<option></option>").attr("value", value.tripCode).text(value.tripInfo.busVehicle.registationNumber));
                        }
                    });
                    $('#vehicle_no').closest(".form-group").removeClass('hide');
                }
            });
        }
        
        function getLRList(){
            var data = {};
            data.tripCode = $('#vehicle_no').val();
            
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if(!data.tripCode) {
                $('#vehicle_no').addClass('inp_error').closest('.form-group').removeClass('hide');;
                err++;
            }
            if ($('#unload_date').val() == '') {
                $('#unload_date').addClass('inp_error');
                err++;
            } else {
                $('#unload_date').removeClass('inp_error');
            }
            if (err > 0) {
                $('#unload_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#unload_cargo_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#unload_cargo_action_state').show();
                return false;
            } else {
                $('#unload_cargo_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#unload_cargo_action_state').html('');
                $('#unload_cargo_action_state').hide();
            }
            
            $('#find-uncargo-list-container ').removeClass('hidden');
            $('#find-uncargo-list').html(loading_popup);
            
            $.ajax({
                type: "POST",
                url: base_url +"cargo/get-unload-cargo",
                data: data,
                dataType: 'html',   
                success: function (response) {
                    $('#find-uncargo-list').html(response);
                    $("html, body").animate({
                        scrollTop: $('#find-uncargo-list-container').offset().top - 35
                    }, "slow");
                }
            });
        }
        
        function clearUnloadCargo() {
            $('#unload_date').val('');
            $('#vehicle_no').closest(".form-group").addClass('hide');
            $('.inp_error').removeClass('inp_error');
            $('#find-uncargo-list-container ').addClass('hidden');
            $('#find-uncargo-list').html('');
            $('#unload_cargo_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#unload_cargo_action_state').html('');
            $('#unload_cargo_action_state').hide();
        }
        
        function selectBooking(st) {
            var lrcount = 0;
            var lritems = 0;

            $('input[class=lritems]').each(function() {
                if( $(this).is(":checked")==true ) {
                   lrcount++;
                   lritems = lritems + Number($(this).attr('data-items'));
                }
            });
            
            $('#flrcount').html(lrcount);
            $('#fitemcount').html(lritems);
        }
        
        function unloadBookings() {
            $('#form-action').removeClass('alert-success').removeClass('alert-danger');
            $('#form-action').html('');
            
            var data = {};
            var lrs = [];
            $('input[class=lritems]').each(function() {
                if( $(this).is(":checked")==true ) {
                   lrs.push($(this).val());
                }
            });
            
            if(lrs.length<=0) {
                $('#form-action').removeClass('alert-danger').removeClass('alert-success');
                $('#form-action').addClass('alert-danger');
                $('#form-action').html('Please select atleast 1 LR to load');
                return;
            }
            
            data.state = 'CUL';
            data.codes = lrs;
            
            var err = 0;
            
            if (err > 0) {
                $('#form-action').removeClass('alert-success').addClass('alert-danger');
                $('#form-action').html('Please enter/select the values in the field that are marked in red');
                $('#form-action').show();
                return false;
            } 
            
            $('#form-bttons').hide();
            $('#form-action').removeClass('alert-danger').removeClass('alert-success');
            $('#form-action').html(loading_popup);
            $('#form-action').show();
    
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-booking-status",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#form-bttons').hide();
                        $('#form-action').removeClass('alert-danger');
                        $('#form-action').addClass('alert-success');
                        $('#form-action').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                            getLRList();
                            return;
                        }, 3000);
                    } else {
                        $('#form-action').addClass('alert-danger');
                        $('#form-action').html(response.errorDesc);
                        $('#form-bttons').show();
                    }
                }
            });
        }        
    </script>
{/literal}
