<div class="brand_top">
    <h3>Live Boarding</h3>
    <span class="align-right">
        refresh interval 1 min
    </span>
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
                            <div class="row">
                                <div class="col-lg-8">
                                    <div class="panel panel-default hidden" id="live-graph">
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-5">
                                                    <div class="row departure-cells">
                                                        <div class="col-md-4 cell">
                                                            <div class="text-center count" id="notboarded-count">0</div>
                                                            <div class="text-center labeltxt">Not Boarded</div>
                                                        </div>
                                                        <div class="col-md-4 cell">
                                                            <div class="text-center count" id="nottravelled-count">0</div>
                                                            <div class="text-center labeltxt">Not Travelled</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-offset-4 col-md-3">
                                                    <div class="pull-right">
                                                        <div id="gauge" style="width:60px;"></div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="panel panel-default">
                                        <div class="row">
                                            <div id="pnr-stat-div" class="pf_15 p_t_20">
                                                <div class="form-group col-md-4">
                                                    <label for="pnr-text">PNR</label>
                                                    <div class="input-group">
                                                        <input type="text" name="pnr" class="form-control sdate" id="pnr-text" placeholder="Enter PNR">
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-5 p_l_n">
                                                    <label for="">&nbsp;</label>
                                                    <div class="input-group">
                                                        <button type="button" class="btn btn-success" onclick="updatePNRStatus();">Update</button>&nbsp;
                                                        <button type="button" class="btn btn-default" onclick="clearPNR();">Clear</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br>

                            <div class="row">
                                <div class="col-md-8 ">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-12 live-boarding">
                                                    <div class="heading_b">Not Boarded</div>
                                                    <div class="table-responsive">
                                                        <table class="table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>PNR</th>
                                                                    <th>Route</th>
                                                                    <th>Service No</th>
                                                                    <th>Seats</th>
                                                                    <th>BP</th>
                                                                    <th>Boarding Time</th>
                                                                    <th>&nbsp;</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="notboarded-list">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="heading_b">Not Travelled<div class="note text-muted pull-right f12"><i class="fa fa-info-circle"></i>&nbsp;PNRs opened for ReBooking</div></div>
                                                    <div class="table-responsive">
                                                        <table class="table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>PNR</th>
                                                                    <th>Service No</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="nottravelled-list">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="hide" id="travel-status-seats">
    <div class="">
        <br/>
        <div class="col-md-12">
            <label id="lbl-ltitle">Please select the seats</label>
            <ul class="user_list" id="seats-ul"></ul>
        </div>
    </div>
    <div class="form-group col-md-3">
        <label for="pnr-status" class="hide">Status</label>
        <select id="pnr-status" name="status" class="form-control hide">
            <option value="">Status</option>
            <option value="BOARDED">Boarded</option>
            <option value="NOTBOARDED">Not Boarded</option>
            <option value="NOTTRAVELED">Not Traveled</option>
        </select>
    </div>
    <div class="clear_fix_both">
        <div class="alert hide" id="travel-status-action"></div>
    </div>
    <div class="clear_fix_both">
        <div class="text-right" id="ts-btn-pane">
            <button class="btn btn-success" type="button" id="change-status-btn" onclick="changeStatus();">Update</button>
            <button class="btn btn-default" type="button" onclick="closeChangeStatusDialog();">Cancel</button>
        </div>
    </div>
</div>

<script id="template-notboarded" type="text/template">
    <tr class="list-group-item-danger tkt" >
        <td class="pnr"><a href="javascript:;"></a><br/></td>
        <td class="rte"></td>
        <td class="sno"></td>
        <td class="sts"></td>
        <td class="brd"></td>
        <td class="tim"></td>
        <td class="act">
        <td>
            <div class="btn-group">
                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog"></i> <span class="caret"></span></button>                                                                            <ul class="dropdown-menu sch">
                <li><a class="reopen" href="javascript:;">Reopen to Booking</a></li>
                <li><a class="board" href="javascript:;">Boarded</a></li>
            </div>
        </td>
    </tr>
</script>

<script id="template-nottravelled" type="text/template">
    <tr class="list-group-item-danger tkt" >
        <td class="pnr"><a href="javascript:;"></a><br/></td>
        <td class="sno"></td>
        <td><a class="reopen" href="javascript:;" title="Open for Booking"><i class="fa fa-trash-o fa-lg"></i></a></td>
    </tr>
</script>

{literal}
<script>
    var nbcount = 0;
    var ntcount = 0;
    
    function refreshList(first) {
        var alert = false;
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "boardingtripchart/live-boarding-list",
            data: '',
            success: function (res) {
                if (res.status == 1) {
                    $('.tkt').addClass('exis');
                    $.each(res.data, function (i, val) {
                        if(val.ticketDetails[0].travelStatus.code == 'NOTBOARDED') {
                            if ($('.notboarded-list #' + val.ticketDetails[0].seatCode).length > 0) {
                                $('.notboarded-list #' + val.ticketDetails[0].seatCode).removeClass('exis');
                                return true;
                            }
                            var temp = $('#template-notboarded').html();
                            var divhtml = $(temp).clone();
                            divhtml.attr('id', val.ticketDetails[0].seatCode);
                            divhtml.find('.pnr').append(val.passegerMobleNo);
                            divhtml.find('.pnr a').html(val.code).attr('onclick', "PrintTck('" + val.code + "');");
                            divhtml.find('.rte').html(val.fromStation.name + ' - ' + val.toStation.name + '<br/>' + val.user.name);
                            divhtml.find('.sno').html('<span class="warning-text">'+val.serviceNo+'</span>&nbsp;<i class="fa fa-bus"></i>' + '<br/><span title="Trip Time">' + moment(val.tripTime).format('hh:mm A') + '</span>');
                            divhtml.find('.sts').html(val.ticketDetails.map(e => e.seatName).join(", "));
                            divhtml.find('.brd').html(val.fromStation.stationPoint[0].name.substring(0, 12)).attr('title', val.fromStation.stationPoint[0].name);
                            divhtml.find('.tim').html(moment(val.fromStation.stationPoint[0].dateTime).format('hh:mm A'));
                            divhtml.find('.reopen').attr('onclick', 'changeStatus("' + val.code + '","' + val.ticketDetails.map(e => e.seatCode).join(",") + '","NOTTRAVELED")');
                            divhtml.find('.board').attr('onclick', 'changeStatus("' + val.code + '","' + val.ticketDetails.map(e => e.seatCode).join(",") + '","BOARDED")');
                            $('.notboarded-list').prepend(divhtml);

                            var info = '';
                            if(val.hasOwnProperty('tripDetails')) {
                                info = 'Driver Name : '+val.tripDetails.driverName+'<br>Driver Mobile : '+val.tripDetails.driverMobile+'<br>Bus No : '+val.tripDetails.registrationNumber;
                            }
                            divhtml.find('.sno').find('i').popover({
                                container: 'body',
                                content: info,
                                html: true,
                                placement: 'top',
                                trigger: 'hover'
                            });
                            $('#notboarded-count').html(++nbcount);
                            $('.notboarded-list #' + val.ticketDetails[0].seatCode).removeClass('list-group-item-danger', (first) ? 0 : 10000);
                        } else if(val.ticketDetails[0].travelStatus.code == 'NOTTRAVELED') {
                            if ($('.nottravelled-list #' + val.ticketDetails[0].seatCode).length > 0) {
                                $('.nottravelled-list #' + val.ticketDetails[0].seatCode).removeClass('exis');
                                return true;
                            }
                            var temp = $('#template-nottravelled').html();
                            var divhtml = $(temp).clone();
                            divhtml.attr('id', val.ticketDetails[0].seatCode);
                            divhtml.find('.pnr').append(val.passegerMobleNo);
                            divhtml.find('.pnr a').html(val.code).attr('onclick', "PrintTck('" + val.code + "');");
                            divhtml.find('.sno').html('<span class="warning-text">'+val.serviceNo+'</span>&nbsp;<i class="fa fa-bus"></i>' + '<br/><span title="Trip Time">' + moment(val.tripTime).format('hh:mm A') + '</span>');
                            divhtml.find('.reopen').attr('onclick', 'changeStatus("' + val.code + '","' + val.ticketDetails.map(e => e.seatCode).join(",") + '","BOARDED")');
                            $('.nottravelled-list').prepend(divhtml);

                            var info = '';
                            if(val.hasOwnProperty('tripDetails')) {
                                info = 'Driver Name : '+val.tripDetails.driverName+'<br>Driver Mobile : '+val.tripDetails.driverMobile+'<br>Bus No : '+val.tripDetails.registrationNumber;
                            }
                            divhtml.find('.sno').find('i').popover({
                                container: 'body',
                                content: info,
                                html: true,
                                placement: 'top',
                                trigger: 'hover'
                            });
                            $('#nottravelled-count').html(++ntcount);
                            $('.nottravelled-list #' + val.ticketDetails[0].seatCode).removeClass('list-group-item-danger', (first) ? 0 : 10000);
                        }                        
                        alert = true;
                    });

                    $('.exis').each(function () {
                        if($(this).parent('.notboarded-list').length) {
                            $('#notboarded-count').html(--nbcount);
                        } else if($(this).parent('.nottravelled-list').length) {
                            $('#nottravelled-count').html(--ntcount);
                        }

                        $(this).animate({backgroundColor: '#c0392b'}, 5000, function () {
                            $(this).remove();
                        });
                    });

                    $('#live-graph').removeClass('hidden');

                    // create the timer
                    $('#gauge').html('');
                    $('#gauge').polartimer({
                        timerSeconds: 60,
                        color: '#FF6040',
                        opacity: 0.9,
                        callback: function () {
                            $('#gauge').polartimer('destroy');
                            refreshList();
                            $('#gauge').html('<br>Refreshing...');
                        }
                    });
                    
                    // start the timer
                    $('#gauge').polartimer('start');

                    if (first != 1 && alert == true) {   //  play alert
                        new Howl({src: ['assets/sound/car-alarm.mp3'], volume: 0.9}).play();
                    }
                }
            }
        });
    }

    function init_progress() {
        refreshList(1);
    }

    function changeStatus(ticketCode, seatCode, travelStatus) {
        if (confirm('Do you want to Reopen this ticket?')) {
            var data = {};
            data.ticketCode = ticketCode;
            if(!seatCode) {
                var seatCodeList = [];
                $('input.seat-check').each(function(){
                    if($(this).is(':checked')){
                        seatCodeList.push($(this).val());
                    }
                });
                data.seatCodeList = seatCodeList.join(',');
            } else {
                data.seatCodeList = seatCode;
            }

            if(!travelStatus) {
                data.travelStatus = $('#pnr-status').val();
            } else {
                data.travelStatus = travelStatus;
            }

            var loading_overlay = iosOverlay({
                text: "Please Wait...",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "boardingtripchart/update-live-boarding",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });

                        clearPNR();
                        $('#gauge').polartimer('destroy');
                        refreshList();
                        $('#gauge').html('<br>Refreshing...');

                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 1000);
                }
            });
        }
    }

    function clearPNR(){
        $('#pnr-text').val('');
        $('#pnr-status').val('');
        $('#pnr-stat-div .inp_error').removeClass('inp_error');
    }

    function updatePNRStatus(){
        var data = {};
        var err = 0;
        data.ticketCode = $.trim($('#pnr-text').val());
        //data.travelStatus = $('#pnr-status').val();

        $('.inp_error').removeClass('inp_error');
        if (data.ticketCode == '') {
            $('#pnr-text').addClass('inp_error');
            err++;
        }
        //if (data.travelStatus == '') {
        //    $('#pnr-status').addClass('inp_error');
        //    err++;
        //}
        if(err > 0){
            return;
        }

        $('#travel-status-seats').css('background', '#fff');
        $('#travel-status-seats').removeClass('hide');
        $('#travel-status-seats').dialog({
            autoOpen: true,
            height: 400,
            width: 570,
            modal: true,
            resizable: false,
            closeOnEscape: false
        });
        $('.ui-dialog-titlebar').hide();
        $('#travel-status-action').addClass('hide').html('');
        $('#pnr-status, label[for="pnr-status"]').removeClass('hide');
        $('#seats-ul').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "boardingtripchart/update-ticket-travel-status",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#seats-ul').html('');
                    $.each(response.data.ticketDetails, function(i,val){
                        $('#seats-ul').append('<li><input type="checkbox" checked="checked" class="seat-check" value="'+val.seatCode+'">&emsp;'+val.seatName+' - '+val.travelStatus.name+'</li>');
                    });
                    $('#change-status-btn').attr('onclick', "changeStatus('"+data.ticketCode+"', '')");
                } else {
                    $('#seats-ul').html('');
                    $('#travel-status-action').addClass('alert-danger').removeClass('hide');
                    $('#travel-status-action').html(response.errorDesc);
                }
            }
        });
    }

    function closeChangeStatusDialog() {
        $('#travel-status-seats').dialog('close');
    }
</script>
{/literal}
