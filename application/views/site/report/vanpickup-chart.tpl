<div class="brand_top">
    <h3>Van Pickup Chart</h3> 
    <div class="text-right noprint" id="psngr_vanpkp_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
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

                                                <form id='psngr_vanpickup_form' action="" method="post" onsubmit="return false">
                                                    <div class="row">   
                                                        <div class="form-group col-md-2">
                                                            <label for="psngr_vanpkp_date">Travel Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="Date" class="form-control sdate" id="psngr_vanpkp_date" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="psngr_vanpkp_date"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>                                                        
                                                        <div class="form-group col-md-2">
                                                            <label  for="psngr_vanpkp_van">Van Route</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="psngr_vanpkp_van"  class="form-control" >
                                                                    <option value=''>Select Van Route</option>
                                                                    {foreach item=row from=$vanDetails}                                                                        
                                                                        <option  value="{$row->code}">{$row->name}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label  for="psngr_vanpkp_flag">Boarding / Dropping</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="psngr_vanpkp_flag"  class="form-control" >
                                                                    <option value='1'>Boarding</option>
                                                                    <option value='0'>Dropping</option>
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="getPsngrVanpickupReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearPsngrVanpickupReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="psngr-vanpickup-action-state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row hidden" id="psngr-vanpickup-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="psngr-vanpickup-list"></div>                                    
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
        $('#psngr_vanpkp_date').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
            startDate: '-3m',
            endDate: '+3m',
            maxDate: "+365D",
        });        
        $('#psngr_vanpkp_date').datepicker('setDate', new Date());
        function clearPsngrVanpickupReport(){
            $('.inp_error').removeClass('inp_error');
            $('#psngr_vanpkp_date,#psngr_vanpkp_van').val('');
            $('#psngr-vanpickup-list-container').addClass('hidden');
            $('#psngr-vanpickup-list').html('');
            $('#psngr-vanpickup-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#psngr-vanpickup-action-state').html('');
            $('#psngr-vanpickup-action-state').hide();
            $('#psngr_vanpkp_excel').hide();
        }
        
        function getPsngrVanpickupReport(){
            $('#psngr-vanpickup-list').html('');
            $('#psngr_vanpkp_excel').hide();
            var data = {};
            data.tripDate = $('#psngr_vanpkp_date').val();
            data.vehicleVanCode = $('#psngr_vanpkp_van').val();
            data.vehicleVanName = $("#psngr_vanpkp_van option:selected").text();;
            data.boardingDroppingFlag = $('#psngr_vanpkp_flag').val();
            
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.tripDate == '') {
                $('#psngr_vanpkp_date').addClass('inp_error');
                err++;
            }
            if (data.vehicleVanCode == '') {
                $('#psngr_vanpkp_van').addClass('inp_error');
                err++;
            }
            if (data.boardingDroppingFlag == '') {
                $('#psngr_vanpkp_flag').addClass('inp_error');
                err++;
            }
            
            if (err > 0) {
                $('#psngr-vanpickup-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#psngr-vanpickup-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#psngr-vanpickup-action-state').show();
                return false;
            } else {
                $('#psngr-vanpickup-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#psngr-vanpickup-action-state').html('');
                $('#psngr-vanpickup-action-state').hide();
            }
            var html = "";
            $('#psngr-vanpickup-list-container').removeClass('hidden');
            $('#psngr-vanpickup-list').html(loading_popup);
            
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/vanpickup-list",
                data: data,
                success: function (response) {
                    $('#psngr-vanpickup-list').html(response);
                    $('#psngr_vanpkp_excel').toggle(!!vanTripInfo && vanTripInfo.code);
                    $("html, body").animate({
                        scrollTop: $('#psngr-vanpickup-list-container').offset().top - 35
                    }, "slow");
                }
            });
        }
    </script>
{/literal}