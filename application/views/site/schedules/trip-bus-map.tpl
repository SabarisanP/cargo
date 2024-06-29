
<div class="seat-map-over">
    <div class="seat-map-over-all">
        <div class="col-lg-1">
            <div class="seat-map-driver">&nbsp;
            </div>
            <div class="seat-map-selayer">
                <p class="vertical-text">Lower</p>
            </div>
        </div>
        <div class="col-lg-9" style="width:auto;height: auto;">

            {for $r=$xminl1 to $xmaxl1}
                {for $c=$yminl1 to $ymaxl1}
                    <div class="seat-lay-visibility-stg" id="lay1-{$r}{$c}">
                        &nbsp;
                    </div>
                {/for}
                <div class="clear_fix_both"></div>
            {/for}
        </div>

    </div>

    <div class="col-md-1"></div>        

    <div class="col-md-11 br_2 buslayer2">
        <div class="">
            <div class="col-lg-1 wwd_151">
                <!--<div class="seat-lay-visibility"></div>-->
                <p class="vertical-text">Upper</p>
            </div>
            <div class="col-lg-12" style="width:auto;height: auto;">
                {for $r=$xminl2 to $xmaxl2}
                    {for $c=$yminl2 to $ymaxl2}
                        <div class="seat-lay-visibility-stg" id="lay2-{$r}{$c}">
                            &nbsp;
                        </div>
                    {/for}
                    <div style="clear:both"></div>
                {/for}
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </div>
    
    {if $user_booking|count}
        <div class="col-md-1"></div>

        <div class="col-md-3">
            <table class="table table-bordered">
                <tr>
                    <td class="bold" nowrap="nowrap">Booked By</td>
                    <td class="bold" nowrap="nowrap">Seat Count</td>
                </tr>
                {foreach key=user item=row from=$user_booking}
                    <tr>
                        <td>{$user}</td>
                        <td>{$row['bo_seats']}</td>
                    </tr>
                {/foreach}
            </table>
        </div>
    {/if}
    
    <div class="col-md-2 col-md-offset-2" >
        <div id="seat-selection-list">
        </div>
    </div>
    <div class="clear_fix_both"></div><br><br>
    
    {if $tickets|count>0}
        <div class="row" id="sms-form-container" style="display:none;">
            <div class="col-sm-2">                
                <select id="sms-type" class="form-control" onchange="setSMSTypeReasons(this.value)">
                    <option value="">Select a type</option>
                    {foreach name=o key=k item=row from=$sms_type}
                        <option value="{$k}">{$row}</option>
                    {/foreach} 
                </select>
            </div>
            <div class="col-sm-2">                
                <select id="sms-reason" class="form-control">
                    <option value="">Select a reason</option>                    
                </select>
            </div>
            <div class="col-sm-2" id="div-boarding" style="display:none">                
                <select id="sms-boargin-point" class="form-control">
                    <option value="">Select a boarding point</option>
                    {foreach name=o key=k item=row from=$boardingpoints}
                        <option value="{$k}">{$row['name']} - {$row['time']}</option>
                    {/foreach} 
                </select>
            </div>
                        
            <div class="col-sm-2" id="div-delay-time">                
                <input  placeholder="Time" id="sms-delay-time" name="sms_delay_time"  class="form-control" value=''>
                <span class="small">Ex : 1 hour, 30 mins, 2 hours </span>
            </div>
                
            <div class="col-sm-2" id="div-support-no">                
                <input  placeholder="Support number" id="sms-support-no" name="sms_support_no"  class="form-control" value='' maxlength="10">
            </div>    
            
             <div class="col-sm-2">
                <button class="btn btn-success" type="button" onclick="processSMS()">Send</button>
                <button class="btn btn-default" type="button" onclick="clearSMS()">Clear</button>
            </div>
            
        </div>

        <div class="alert" id="resendsms-action-container" style="display:none"></div>
        <div class="row" id="sms-action-container" style="display:none">
            <div class="col-md-12">
                <div id="action-info" class="text-center"></div>
                <div class="progress progress-striped active">
                    <div style="width:0%" role="progressbar" class="progress-bar">
                        
                    </div>
                </div>
            </div>
        </div>        
        
        <div class="row" id="sms-filter-container">
            <div class="col-md-6">
                <div id="pnr-validation-state"></div>
            </div>
            <div class="col-md-3 text-right">                
                <button class="btn btn-success" type="button" onclick="sendTripSms()">Send SMS</button>            
            </div>
            <div class="col-md-3">
                {if $board|count > 0}
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-filter"></i></span>
                        <select id='brd_pnt' class='form-control'>
                            <option value = 'select'>Select boarding point </option>
                            {foreach item=row from=$board}
                                <option value="{$row['name']}">{$row['name']} - {$row['dateTime']|date_format:$ns_time_format}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
            </div>
        </div>


        <table class="table table-hover" id='trip-user-list' style="margin-top:10px">
            <tr>
                <th><input type="checkbox" id='chk_ticket_all' checked="checked" class="chk_ticket_all" onchange="togglePNRcheckboxs()"></th>
                <th>PNR</th> 
                <th>Booked At</th> 
                <th>Passenger name</th>
                <th>Seats</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Contact Number</th>
                <th>Booked By</th> 
                <th>Boarding Point</th>
            </tr>
            {foreach item=sclp from=$tickets}
                {$brd = $sclp['boardingPointName']|replace:' ':''}
                {$brd1 = $brd|replace:'(':''}
                {$brd2 = $brd1|replace:')':''}
                {$brd3 = $brd2|strip:''}
                <tr id='brd_{$brd3}' class='brd_pnt'>
                    <td><input type="checkbox" id='chk_ticket' value="{$sclp['pnr']}" checked="checked" class="chk_ticket" onchange="setActivePNRCount();"></td>
                    <td>{$sclp['pnr']}</td>
                    <td>{$sclp['bookedat']|date_format:$ns_datetime_format}</td>
                    <td title="{$sclp['passengerName']}">{$sclp['passengerName']|truncate:15}</td>
                    <td>{$sclp['seatName']}</td>
                    <td>{$sclp['passengerAge']}</td> 
                    <td>{$sclp['seatGendarStatus']}</td>
                    <td>
                        {$sclp['contactNumber']}&emsp;
                        <div class="dropdown dropup d-inline-block">
                            <button class="btn btn-xs btn-default dropdown-toggle" type="button" id="s-selection" data-toggle="dropdown" title="Whatsapp Share">
                                <i class="fa fa-lg fa-whatsapp" aria-hidden="true"></i>
                                <span class="caret">
                            </span></button>
                            <ul class="dropdown-menu dropdown-menu-right text-left" aria-labelledby="s-selection"> 
                                <li><a href="javascript:;" class="btn-notify-whatsapp" data-pnr="{$sclp['pnr']}" data-notify-type="TICKET">Ticket Details</a></li>
                                <li><a href="javascript:;" class="btn-notify-whatsapp" data-pnr="{$sclp['pnr']}" data-notify-type="RSNDGPSHJ">Driver Contact / GPS Tracking</a></li>
                            </ul>&emsp;
                        </div>
                    </td>
                    <td>{$sclp['bookedby']}</td>
                    <td>{$sclp['boardingPointName']}</td>
                </tr>
            {/foreach} 
        </table>
        
    {/if}
</div>
<script>
    
    var sms_type_reasons = {$sms_type_reasons|json_encode};
    var sms_boarding = {$boardingpoints|json_encode};
    var buslayer = {$busseatlayer|json_encode};
    
    $('#trip-user-list').find('.btn-notify-whatsapp').click(function() {
        var data = {};
        data.type = $(this).data('notify-type');
        data.pnr = $(this).data('pnr');

        var eventaction = (data.type === 'TICKET') ? 'Whatsapp Ticket' : 'Whatsapp Tracking';
        ga_track_event('Ticket', eventaction, '');

        var url = base_url + "ticket/whatsapp-share?" + $.param(data);
        var wo = window.open(url, "_blank");
    });
    
    if (buslayer != null) {
        var busseattype = {$seattype|json_encode}
        var type = new Array();
        $.each(busseattype, function (key, vals) {
            type[vals.code] = vals.name;
        });
        $(document).ready(function () {
            setActivePNRCount();
            var lay = 0;
            $('.buslayer2,.seat-map-selayer').hide();
            $.each(buslayer, function (key1, bval) {
                bval.seatName = $.trim(bval.seatName);
                if(bval.busSeatType.code !== 'RRM' &&  bval.busSeatType.code !== 'FRS') {
                    $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass(bval.seatName).addClass('seat-select-visibility3').addClass('p_tool').attr('data-toggle', 'popover').attr('data-codesp', bval.code).attr('data-container', 'body');
                    if (bval.ticketCode != undefined) {
                        $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bval.ticketCode + "<br />" + bval.passengerName + "(" + bval.seatGendarStatus.code + ") - " + bval.contactNumber + "<br />" + bval.route + "<br />" + bval.boardingPointName + "<br />Booked By : " + bval.user.name + "</div>");
                    } else {
                        $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bval.seatName + ", " + type[bval.busSeatType.code] + " , <i class='fa fa-rupee'></i> " + bval.seatFare + "<br /> " + bval.seatStatus.name + "</div>");
                    }
                } else {
                    $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                    $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
                }
                $('[data-toggle=popover]').popover({
                    container: "body",
                    html: true
                });
                if (bval.layer == 2) {
                    lay = 1;
                }
                if (bval.layer == 2) {
                    lay = 1;
                }
                var color = '';
                if (bval.seatGendarStatus.code == 'F') {
                    color = '#ffcfe3';
                }
                if (bval.seatGendarStatus.code == 'M') {
                    color = '#88d1f2';
                }
                if (bval.seatStatus.code == 'AO') {
                    color = '#D3D7D7';
                }
                if (bval.seatStatus.code == 'BL') {
                    color = '#EED4AF';
                }
                if (bval.seatStatus.code == 'AM') {
                    color = '2px solid #017099';
                    $('.' + bval.seatName).css('border', color);
                } else if (bval.seatStatus.code == 'AF') {
                    color = '2px solid #ffcfe3';
                    $('.' + bval.seatName).css('border', color);
                } else if (bval.seatStatus.code == 'TBL') {
                    $('.' + bval.seatName).addClass('live-booking seat-booked-blocked');
                } else {
                    $('.' + bval.seatName).css('background', color);
                }
            });
            if (lay > 0) {
                $('.buslayer2,.seat-map-selayer').show();
            }
        });
    } else {
        $('.seat-map-over').html('<div class="well well-large">Sorry! No details found</div>')
    }
    
     $('#brd_pnt').on("change", function () {
        var lay = 0;
        
        if (this.value != 'select') {            
            $('.brd_pnt').hide();
            var brd = this.value;
            var brd2 = brd.replace(/\s+/g, '');
            brd2 = brd2.replace(/"/g, "").replace(/'/g, "").replace(/\(|\)/g, "");
            $('[id = brd_' + brd2 + ']').show();
                       
            
            
            $.each(buslayer, function (key1, bval) {
                bval.seatName = $.trim(bval.seatName);
                if (bval.boardingPointName != undefined && bval.boardingPointName == brd) {
                    $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass(bval.seatName).addClass('seat-select-visibility3').addClass('p_tool').attr('data-toggle', 'popover').attr('data-codesp', bval.code).attr('data-container', 'body');
                    if (bval.ticketCode != undefined) {
                        $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bval.ticketCode + "<br />" + bval.passengerName + "(" + bval.seatGendarStatus.code + ") - " + bval.contactNumber + "<br />" + bval.route + "<br />" + bval.boardingPointName + "<br />Booked By : " + bval.user.name + "</div>");
                    } else {
                        $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bval.seatName + ", " + type[bval.busSeatType.code] + " , <i class='fa fa-rupee'></i> " + bval.seatFare + "<br /> " + bval.seatStatus.name + "</div>");
                    }
                    $('[data-toggle=popover]').popover({
                        container: "body",
                        html: true
                    });
                    if (bval.layer == 2) {
                        lay = 1;
                    }
                    if (bval.layer == 2) {
                        lay = 1;
                    }
                    var color = '';
                    if (bval.seatGendarStatus.code == 'F') {
                        color = '#ffcfe3';
                    }
                    if (bval.seatGendarStatus.code == 'M') {
                        color = '#88d1f2';
                    }
                    if (bval.seatStatus.code == 'AO') {
                        color = '#D3D7D7';
                    }
                    if (bval.seatStatus.code == 'BL') {
                        color = '#EED4AF';
                    }
                    if (bval.seatStatus.code == 'AM') {
                        color = '2px solid #017099';
                        $('.' + bval.seatName).css('border', color);
                    } else if (bval.seatStatus.code == 'AF') {
                        color = '2px solid #ffcfe3';
                        $('.' + bval.seatName).css('border', color);
                    } else {
                        $('.' + bval.seatName).css('background', color);
                    }
                } else {
                    $('.' + bval.seatName).css('background', 'none');
                }
            });
             if (lay > 0) {
                $('.buslayer2,.seat-map-selayer').show();
            }
        } else {
            $('.brd_pnt').show();
            
            $('.buslayer2,.seat-map-selayer').hide();
            $.each(buslayer, function (key1, bval) {
                bval.seatName = $.trim(bval.seatName);
                $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass(bval.seatName).addClass('seat-select-visibility3').addClass('p_tool').attr('data-toggle', 'popover').attr('data-codesp', bval.code).attr('data-container', 'body');
                if (bval.ticketCode != undefined) {
                    $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bval.ticketCode + "<br />" + bval.passengerName + "(" + bval.seatGendarStatus.code + ") - " + bval.contactNumber + "<br />" + bval.route + "<br />" + bval.boardingPointName + "<br />Booked By : " + bval.user.name + "</div>");
                } else {
                    $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bval.seatName + ", " + type[bval.busSeatType.code] + " , <i class='fa fa-rupee'></i> " + bval.seatFare + "<br /> " + bval.seatStatus.name + "</div>");
                }
                $('[data-toggle=popover]').popover({
                    container: "body",
                    html: true
                });
                if (bval.layer == 2) {
                    lay = 1;
                }
                if (bval.layer == 2) {
                    lay = 1;
                }
                var color = '';
                if (bval.seatGendarStatus.code == 'F') {
                    color = '#ffcfe3';
                }
                if (bval.seatGendarStatus.code == 'M') {
                    color = '#88d1f2';
                }
                if (bval.seatStatus.code == 'AO') {
                    color = '#D3D7D7';
                }
                if (bval.seatStatus.code == 'BL') {
                    color = '#EED4AF';
                }
                if (bval.seatStatus.code == 'AM') {
                    color = '2px solid #017099';
                    $('.' + bval.seatName).css('border', color);
                } else if (bval.seatStatus.code == 'AF') {
                    color = '2px solid #ffcfe3';
                    $('.' + bval.seatName).css('border', color);
                } else {
                    $('.' + bval.seatName).css('background', color);
                }
            });
             if (lay > 0) {
                $('.buslayer2,.seat-map-selayer').show();
            }
        }
        
        $('#chk_ticket_all').prop("checked", true);
        togglePNRcheckboxs();
    });
    
    

</script>
