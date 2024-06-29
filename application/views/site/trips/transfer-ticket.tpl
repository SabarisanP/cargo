<div class="row">
    <div class="col-md-6"> 
        <div class="alert alert-info">
            <b>Information ! </b><br><br>
            This feature implemented in "Search" page itself with more friendly manner. <br>
            Can be removed from here in near future.</div>
    </div>
</div>

<div class="row">
    <div class="col-md-6">        
        <div id="triplist-transfer"></div>
        <br>
        <div id="maps">
            <div class="well well-large text-center">Please select a stage to get busmap</div>
        </div>
    </div>
    
    <div class="col-md-6" id="right-search" style="display: none">        
        <div >   
            
            <div class="row">
                <div class="col-md-5">
                    <div class="form-group">                        
                        <select class="form-control from" id="frm-station-search" onchange="toStationLoading()">
                            <option value=""></option>
                        </select>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="form-group">                        
                        <select class="form-control to" id="tos-station-search" >
                            <option value="">Select Destination</option>
                        </select>
                    </div>
                </div>
            </div>    

            <div class="row">
                <div class="col-md-5">
                    <div class="form-group">
                        <label class="sr-only" for="sdate-search">Date</label>
                        <div class="input-group">                            
                            <input type="text" class="form-control sdate" id="sdate-search" readonly="true" placeholder="Date">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>                            
                        </div>
                    </div>
                </div>

                <div class="col-md-5">
                    <button type="button" class="btn btn-success btn-search" onclick="dosearchTrip()">Search</button>  &nbsp
                    <button type="button" class="btn btn-default btn-clear" onclick="clearSearch()">Clear</button>
                </div>

            </div>               
            
        </div>

        
        <div class="ser-sch" id="search-schedule">
            <div class="well well-sm">Search and select a trip</div>
        </div>
        
        <div class="clear_fix_both"></div>   
        <div id="ticket-search"></div>
        <div class="clear_fix_both"></div><br>
        <div id="table-transfer" class="hidden">
            
            <div class="row">
                <div class="col-md-4">PNR : <span class="" id="spn-pnr"></span> </div>
                <!--<div class="col-md-7">By : <span class="" id="spn-by"></span> </div>-->
                <div class="col-md-8">Boarding : <span class="" id="spn-boarding"></span> </div>
            </div>            
            
            <table class="table table-hover" id='targetTable'>
                <tr>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Old Seat</th>
                    <th>New Seat</th>
                </tr>
            </table>
            <br>
            <span id="transfer_action"></span><br>
            <div class="text-right" id="trasfer-button">
                <button type="button" class="btn btn-success btn-search" onclick="transferTicket()">Save</button>  &nbsp
            </div>     
        </div>
    </div>
</div>



<script  type="text/template" id="ticket-table">
   <tr style="border-top:1px solid #dddddd">
    <td class="sch_o_name"></td>
    <td class="sch_o_age"></td>
    <td class="sch_o_gendar"></td>
    <td class="sch_o_seat"></td>
    <td class="sch_n_seat"></td>
   </tr>
</script>


<script>
    var routes = {$route|json_encode};
    var stations = {$stations|json_encode};
    var q_from = '{$smarty.request.from}';
    var q_to = '{$smarty.request.to}';
    var q_date = '{$smarty.request.date}';
    var buslayer = {$busseatlayer|json_encode};
    
    var opthml = "<option value=''>Select From</option>";
    var farray = new Array();
    $.each(stations, function (rkey, rvls) {
        if ($.inArray(rvls.code, farray) < 0) {
            opthml += '<option id="' + rvls.code + '" value="' + rvls.code + '">' + rvls.name + '</option>';
            farray.push(rvls.code)
        }

    });

    $('#frm-station-search').html(opthml);
    /*$('#frm-station-search').select2({
        placeholder: "Select Origin",
        escapeMarkup: function (markup) {
            return markup;
        }
    });
    $('#tos-station-search').select2({
        placeholder: "Select Destination",
        escapeMarkup: function (markup) {
            return markup;
        }
    });*/
    
    function toStationLoading() {
        var stcode = $('#frm-station-search').val();
        var html = '<option value=""></option>';
        $('#tos-station-search').val('');
        $('#tos-station-search').select2('val', '');
        var to_codes = eval(routes[stcode]);
        var html = "<option selected='selected' value=''>Select Destination</option>";
        $(to_codes).each(function () {
            html += "<option value=" + this.code + ">" + this.name + "</option>";
        });
        $('#tos-station-search').html(html);
        return;
    }

    function dosearchTrip() {
        $('.to_seat').html('');
        $('#ticket-search').html('');
        $('.inp_error').removeClass('inp_error');
        //$('.ser-sch').hide();
        var data = {};
        data.fromStation = $('#frm-station-search').val();
        data.toStation = $('#tos-station-search').val();
        data.sdate = $('#sdate-search').val();
        if (data.fromStation == '') {
            $('#frm-station-search').addClass('inp_error');
            return false;
        }
        if (data.toStation == '') {
            $('#tos-station-search').addClass('inp_error');
            return false;
        }
        if (data.sdate == '') {
            $('#sdate-search').addClass('inp_error');
            return false;
        }
        $('.inp_error').removeClass('inp_error');        
        $('#search-schedule').html(loading_small);
        $.ajax({
            type: "POST",
            url: "search/get-bus-details",
            data: data,
            dataType: 'json',
            success: function (res) {
                //$('.load-sch').html('');
                //$('.ser-sch').show();
                if (res.data) { 
                    var option = '<select class="form-control" id="all-schedules"> <option value="0">Select a trip</option>';                    
                    $.each(res.data, function (bkey, bval) {
                        option += '<option value="' + bval.tripStageCode + '">' + bval.fromStation.name +' [ '+ datetimeToTime(bval.fromStation.dateTime) + ' ] - ' +  bval.toStation.name +' [ '+ datetimeToTime(bval.toStation.dateTime) + ' ] - [ ' + bval.busCategory + ' ]</option>';
                    });                    
                    option += '</select>';
                    $('#search-schedule').html(option);
                    
                    $('#all-schedules').on("change", function () {
                        if (this.value != 0) {
                            $('.to_seat').html('');
                            getTripBusMapSearch(this.value);
                        }
                    });
    
                } else {
                    $('#search-schedule').html('<div class="alert alert-danger text-center"> Sorry! No trip found </div>');
                }
            }
        });
    }

    

    function clearSearch() {
        $('#frm-station-search').val('');
        $('#tos-station-search').val('');
        $('#sdate-search').val('');
        $('#all-schedules').html('<option value="0">Select a schedule</option>');
        $('#ticket-search').html('');
        //$('#search-schedule').addClass('hidden');
        toStationLoading();
    }

    
    function transferTicket() {
        var data = {};
        $('#transfer_action').html('');
        $('.inp_error').removeClass('inp_error');
        var length_from = $('.seat-transfer-from').length;
        var length_to = $('.seat-transfer-to').length;
        if (length_to < length_from) {
            $('#transfer_action').html('<div class="alert alert-danger">Please select new seats.</div>');
            return false; 
        }
        if ($('#brd').val() == '') {
            $('#brd').addClass('inp_error');
            $('#transfer_action').html('<div class="alert alert-danger">Please select boarding point.</div>');
            return false; 
        }
        if ($('#drp').val() == '') {
            $('#drp').addClass('inp_error');
            $('#transfer_action').html('<div class="alert alert-danger">Please select dropping point.</div>');
            return false; 
        }
        data.seatCode = '';
        data.transferSeatCode = '';
        data.transferBoardingPoint = $('#brd').val();
        data.transferDroppingPoint = $('#drp').val();
        data.captureFareDifference = $('#caputure_fare_diff').bootstrapSwitch('state');
        data.captureTransferCharge = $('#caputure_transfer_charge').bootstrapSwitch('state');
        data.notificationFlag = $('#caputure_sms_notif').bootstrapSwitch('state');
        data.myAccountFlag = 'false';
        data.ticketCode = '';
        data.tripCode = $('#all-schedules').val();
        $('.seat-transfer-from').each(function() {
           data.seatCode += $(this).attr('data-codesp')+',';
           data.ticketCode = $(this).attr('data-tck');
        });
           $('.seat-transfer-to').each(function() {
           data.transferSeatCode +=  $(this).attr('data-codesp')+',';
        });
        
        data.oldTicket = sourceTicket;
        
        $('#transfer_action').html(loading_small);
        $('#trasfer-button').hide();
        $.ajax({
            type: "POST",
            url: "search/transfer-tickets",
            data: data,
            dataType: 'json',
            success: function (res) {
                if(res.status==1) {
                    $('#transfer_action').html('<div class="alert alert-success">Your request processed successfully.</div>');
                    window.setTimeout(function () {
                        $('#right-search').hide();
                        $('#search-schedule').html('<div class="well well-sm">Search and select a trip</div>');
                        $('#transfer_action').html('');
                        $('#ticket-search').html('');
                        $('#trasfer-button').show();
                        getTripMap1();
                    }, 4000);
                } else {
                    $('#transfer_action').html('<div class="alert alert-danger">' + res.errorDesc + '</div>');
                    $('#trasfer-button').show();
                } 
            }
        });
        
        
    }

    function datetimeToTime(time) {
        var dateString = time.replace(/-/g, "/");
        var dt = new Date(dateString);
        var hours = dt.getHours()
        var minutes = dt.getMinutes()
        if (minutes < 10)
            minutes = "0" + minutes
        var suffix = "AM";
        if (hours >= 12) {
            suffix = "PM";
            hours = hours - 12;
        }
        if (hours == 0) {
            hours = 12;
        }
        return hours + ":" + minutes + " " + suffix;
    }


</script>

{if $action_rights['TT-ONY-CUR-DATE']==1}
<script>
    $('#sdate-search').datepicker({
        todayHighlight: false,
        format: "yyyy-mm-dd",
        startDate: '-0m',
        endDate: '1d',
        autoclose: true
    });
 </script>  
{else}
<script>
    $('#sdate-search').datepicker({        
        format: "yyyy-mm-dd",
        startDate: '-0m',        
        autoclose: true
    });
 </script>   
{/if}    
