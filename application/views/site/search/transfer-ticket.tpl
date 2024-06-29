<div class="col-md-12 p_t_20" id="right-search">
    <span class="pull-left">
        <span class="bold">Transfer Ticket</span> <br>
        <i class="fa fa-info-circle"> </i> &nbsp; Transfer tickets from one service to another service or another DOJ <br>
    </span>
    <div class="clear_fix_both"></div><br>
    
    <div class="row">
        <div class="col-md-5">
            <div class="form-group">
                <select class="form-control from" id="transfer-frm-station" onchange="loadTransferToStation();">
                    <option value=""></option>
                </select>
            </div>
        </div>

        <div class="col-md-5">
            <div class="form-group">
                <select class="form-control to" id="transfer-to-station" >
                    <option value="">Select Destination</option>
                </select>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-5">
            <div class="form-group">
                <label class="sr-only" for="transfer-date">Date</label>
                <div class="input-group">
                    <input type="text" class="form-control sdate" id="transfer-date" readonly="true" placeholder="Date">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
        </div>

        <div class="col-md-5">
            <input type="hidden" id="transfer-from-pnr">
            <button type="button" class="btn btn-success btn-search" onclick="tripsToTransfer()">Search</button>  &nbsp
            <button type="button" class="btn btn-default btn-clear" onclick="clearTicketTranfer()">Clear</button>
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
            <div class="col-md-4"><b>PNR : </b><span id="spn-pnr"></span> </div>
            <div class="col-md-4"><b>Boarding : </b><span id="spn-boarding"></span> </div>
            <div class="col-md-4"><b>Dropping : </b><span id="spn-dropping"></span> </div>
        </div>

        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Old Seat</th>
                    <th>New Seat</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <br>
        <span id="transfer_action"></span><br>
        <div class="text-right" id="trasfer-button">
            <button class="btn btn-default clear-ticket" type="button" onclick="refreshBusLayout();">Clear</button>
            <button type="button" class="btn btn-success btn-search" onclick="transferTicketSearch();">Save</button>
        </div>
    </div>
</div>

<script  type="text/template" id="tranfer-table-tpl">
    <tbody>
        <tr style="border-top:1px solid #dddddd">
        <td class="sch_o_name"></td>
        <td class="sch_o_age"></td>
        <td class="sch_o_gendar"></td>
        <td class="sch_o_seat"></td>
        <td class="sch_n_seat"></td>
        </tr>
    </tbody>
</script>


<script>
    var opthml = "<option value=''>Select From</option>";
    var farray = new Array();
    $.each(stations, function (rkey, rvls) {
        if ($.inArray(rvls.code, farray) < 0) {
            opthml += '<option id="' + rvls.code + '" value="' + rvls.code + '">' + rvls.name + '</option>';
            farray.push(rvls.code)
        }
    });
    $('#transfer-frm-station').html(opthml);

    function loadTransferToStation() {
        var stcode = $('#transfer-frm-station').val();
        var html = '<option value=""></option>';
        $('#transfer-to-station').val('');
        $('#transfer-to-station').select2('val', '');
        var to_codes = eval(routes[stcode]);
        var html = "<option selected='selected' value=''>Select Destination</option>";
        $(to_codes).each(function () {
            html += "<option value=" + this.code + ">" + this.name + "</option>";
        });
        $('#transfer-to-station').html(html);
        return;
    }

    function tripsToTransfer() {
        $('.to_seat').html('');
        $('#ticket-search').html('');
        var data = {};
        data.fromStation = $('#transfer-frm-station').val();
        data.toStation = $('#transfer-to-station').val();
        data.sdate = $('#transfer-date').val();

        $('#right-search .inp_error').removeClass('inp_error');
        if (data.fromStation == '') {
            $('#transfer-frm-station').addClass('inp_error');
            return false;
        }
        if (data.toStation == '') {
            $('#transfer-to-station').addClass('inp_error');
            return false;
        }
        if (data.sdate == '') {
            $('#transfer-date').addClass('inp_error');
            return false;
        }
        $('#search-schedule').html(loading_small);

        $.ajax({
            type: 'POST',
            url: 'search/get-bus-details',
            data: data,
            dataType: 'json',
            success: function (res) {
                if (res.data) {
                    var option = '<select class="form-control" id="all-schedules"> <option value="0">Select a trip</option>';
                    $.each(res.data, function (bkey, bval) {
                        option += '<option value="' + bval.tripStageCode + '|' + bval.tripCode +'">' + bval.fromStation.name + ' [ ' + datetimeToTime(bval.fromStation.dateTime) + ' ] - ' + bval.toStation.name + ' [ ' + datetimeToTime(bval.toStation.dateTime) + ' ] - [ ' + bval.busCategory + ' ]</option>';
                    });
                    option += '</select>';
                    $('#search-schedule').html(option);
                    $('#ticket-search').html('<br/><div class="well well-sm">Select a trip</div>');

                    $('#all-schedules').on("change", function () {
                        if (this.value == 0) {
                            $('#ticket-search').html('<br/><div class="well well-sm">Select a trip</div>');
                            return;
                        }
                        $('.to_seat').html('');
                        codes = this.value.split('|');                        
                        getTripBusMapSearch(codes[0]);
                    });

                } else {
                    $('#search-schedule').html('<div class="alert alert-danger text-center"> Sorry! No trip found </div>');
                }
            }
        });
    }

    function clearTicketTranfer() {
        $('#transfer-frm-station').val('');
        $('#transfer-to-station').val('');
        $('#transfer-date').val('');
        $('#all-schedules').html('<option value="0">Select a schedule</option>');
        $('#ticket-search').html('');
        loadTransferToStation();
    }


    function transferTicketSearch() {
        var data = {};
        $('#transfer_action').html('');
        var length_from = $('.seat-transfer-from').length;
        var length_to = $('.seat-transfer-to').length;
        $('#right-search .inp_error').removeClass('inp_error');
        if($('#all-schedules').val() == '0') {
            $('#all-schedules').addClass('inp_error');
            $('#transfer_action').html('<div class="alert alert-danger">Please select a schedule.</div>');
            return false;
        }
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
        data.transferBoardingPoint = $('#brd').val();
        data.transferDroppingPoint = $('#drp').val();
        data.captureFareDifference = $('#caputure_fare_diff').bootstrapSwitch('state');
        data.captureTransferCharge = $('#caputure_transfer_charge').bootstrapSwitch('state');
        data.notificationFlag = $('#caputure_sms_notif').bootstrapSwitch('state');
        data.myAccountFlag = 'false';
        data.ticketCode = $('#transfer-from-pnr').val();
        
        var codes = $('#all-schedules').val();
        codes = codes.split('|');         
        data.tripCode = codes[1];
        data.tripStageCode = codes[0]; 
        
        data.seatCode = $('.seat-transfer-from').map(function () {
            return $(this).attr('data-code');
        }).get().join(',');
        data.transferSeatCode = $('.seat-transfer-to').map(function () {
            return  $(this).attr('data-codesp');
        }).get().join(',');
        
        data.fromStation = $('#transfer-frm-station').val();
        data.toStation = $('#transfer-to-station').val();
        data.sdate = $('#transfer-date').val();

        $('#transfer_action').html(loading_small);
        $('#trasfer-button').hide();
        $.ajax({
            type: 'POST',
            url: 'search/transfer-tickets',
            data: data,
            dataType: 'json',
            success: function (res) {
                if (res.status == 1) {
                    $('#transfer_action').html('<div class="alert alert-success">Your request processed successfully.</div>');
                    window.setTimeout(function () {
                        $('#search-schedule').html('<div class="well well-sm">Search and select a trip</div>');
                        $('#transfer_action').html('');
                        $('#ticket-search').html('');
                        $('#trasfer-button').show();
                        refreshBusLayout();
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

    function getTripBusMapSearch(stage) {
        var data = {};
        data.stageCode = stage;
        $('.p_tool2').popover('hide');
        $('#ticket-search').html('<br/>' + loading_small);
        $.ajax({
            type: 'POST',
            url: 'tripexpenses/get-trip-busmaps-search',
            data: data,
            dataType: 'html',
            success: function (res) {
                $('#ticket-search').html(res);
                var brd = $('#spn-boarding').attr('data-code');
                var drp = $('#spn-dropping').attr('data-code');
                
                if($('#brd').find('option[value=' + brd + ']').length) {
                    $('#brd').val(brd);
                }
                if($('#drp').find('option[value=' + drp + ']').length) {
                    $('#drp').val(drp);
                }
            }
        });
    }

</script>

{if $action_rights['TT-ONY-CUR-DATE']==1}
    <script>
        $('#transfer-date').datepicker({
            todayHighlight: false,
            format: "yyyy-mm-dd",
            startDate: '-0m',
            endDate: '1d',
            autoclose: true
        });
    </script>
{else}
    <script>
        $('#transfer-date').datepicker({
            format: "yyyy-mm-dd",
            startDate: '-0m',
            autoclose: true
        });
    </script>
{/if}
