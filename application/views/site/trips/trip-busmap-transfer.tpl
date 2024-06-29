
<div class="well well-sm">Please select seats to transfer</div>

<div class="">        
    <div class="seat-map-over-all buslayer2">
        <div class="">
            <div class="col-lg-1">
                <p class="vertical-text">Upper</p>
            </div>
            <div class="col-lg-12" style="width:auto;height: auto;">
                {for $r=$xminl2 to $xmaxl2}
                    {for $c=$yminl2 to $ymaxl2}
                        <div class="seat-lay-visibility-stg-ser" id="blay2-{$r}{$c}">
                            &nbsp;
                        </div>
                    {/for}
                    <div style="clear:both"></div>
                {/for}
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </div>
</div>
<div class="clear_fix_both"></div> <br>
<div class="">
    <div class="seat-map-over">    
        <div class="seat-map-over-all">
            <div class="">
            <div class="col-lg-1">
                <div class="seat-map-driver">&nbsp;</div>
                <div class="seat-map-selayer">
                    <p class="vertical-text">Lower</p>
                </div>
            </div>
            <div class="col-lg-9" style="width:auto;height: auto;">
                {for $r=$xminl1 to $xmaxl1}
                    {for $c=$yminl1 to $ymaxl1}
                        <div class="seat-lay-visibility-stg-ser" id="blay1-{$r}{$c}">
                            &nbsp;
                        </div>
                    {/for}
                    <div style="clear:both"></div>
                {/for}
            </div>
            </div> 
            <div class="clear_fix_both"></div>
        </div>
    </div>
</div>     

<div class="clear_fix_both"></div>


<script>
    var sourceTicket = {};
    sourceTicket.busType = "{$sourceBusType}";    
    var buslayer = {$busseatlayer|json_encode};
    
    $.each(tripStages, function (k, stg) {
        if (stg.tripCode == $('#trpcode').val()) {
            sourceTicket.doj = stg.stage.fromStation.dateTime;            
        }
    });
    
    if (buslayer != null) {
        var busseattype = {$seattype|json_encode}
        var type = new Array();
        $.each(busseattype, function (key, vals) {
            type[vals.code] = vals.name;
        });
        $(document).ready(function () {
            var lay = 0;
            $('.buslayer2,.seat-map-selayer').hide();
            $.each(buslayer, function (key1, bval) {
                bval.seatName = $.trim(bval.seatName);
                if(bval.busSeatType.code !== 'RRM' &&  bval.busSeatType.code !== 'FRS') {
                    $('#blay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass(bval.seatName).addClass('seat-'+bval.busSeatType.code).addClass('seat-select-visibility3').addClass('p_tool').attr('data-toggle', 'popover').attr('data-codesp', bval.code).attr('data-container', 'body');
                    if (bval.ticketCode != undefined) {
                        $('#blay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-pname', bval.passengerName).attr('data-page', bval.passengerAge).attr('data-pcontact', bval.contactNumber).attr('data-pgendar', bval.seatGendarStatus.name).attr('data-tck', bval.ticketCode).attr('data-boarding', bval.boardingPointName).attr('data-route',bval.route).attr('data-by',bval.user.name).attr('data-usercode',bval.user.code).addClass('Selected').attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bval.ticketCode + "<br />" + bval.passengerName + "(" + bval.seatGendarStatus.code + ") - " + bval.contactNumber + "<br />" + bval.route + "<br />" + bval.boardingPointName + "<br />Booked By : " + bval.user.name + "</div>");
                    } else {
                        $('#blay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bval.seatName + ", " + type[bval.busSeatType.code] + " , <i class='fa fa-rupee'></i> " + bval.seatFare + "<br /> " + bval.seatStatus.name + "</div>");
                    }
                } else {
                    $('#blay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background restroom-sleeper-filer').attr('data-toggle', 'popover');
                    $('#blay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
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
        });
    } else {
        $('.buslayer2').hide();
        $('.seat-map-over').html('<div class="well well-large">No Bus Found !</div>')
    }

    $('.p_tool').on("click", function () {
        if ($(this).hasClass('Selected')) {
            $('#table-transfer').removeClass('hidden');
            var length_from = $('.sel').length;
            
            if (length_from > 0) {
                var old = $('.sel').data('tck');
                if (old != $(this).data('tck')) {
                    if (confirm('Are you sure to switch PNR?')) {
                        $('.tcks').remove();
                        $('.seat-transfer-to').removeClass('seat-transfer-to');
                        $('.seat-transfer-from').removeClass('seat-transfer-from');
                        $('.sel').removeClass('sel');
                    } 
                } else {
                    if ($(this).hasClass('seat-transfer-from')) {
                        $('.seat-transfer-from').removeClass('seat-transfer-from');
                        $('.seat-transfer-to').removeClass('seat-transfer-to');
                        $('.tcks').remove();
                        $('#table-transfer').hide();
                        return;
                    } 
                }
            }
            //if (old != $(this).data('tck')) {
                $('#table-transfer').show();
                
                $(this).addClass('sel');
                $(this).addClass('seat-transfer-from');
                
                var pnr = $(this).data('tck');
                sourceTicket.pnr = pnr;
                sourceTicket.name = $(this).data('pname');
                sourceTicket.contact = $(this).data('pcontact');
                sourceTicket.route = $(this).data('route');
                sourceTicket.by = $(this).data('by');
                sourceTicket.usercode = $(this).data('usercode');
                sourceTicket.seatname = '';
                
                $('[data-tck="' + pnr + '"]').addClass('seat-transfer-from');
                
                $('#spn-pnr').html(pnr);
                $('#spn-by').html($(this).data('by'));
                $('#spn-boarding').html($(this).data('boarding'));
                
                //  pupluate search fields
                var route = $(this).data('route');
                var routes = route.split(' - ');                
                $("#frm-station-search").find("option:contains('" + routes[0] +"')").each(function () {
                    $(this).attr("selected", "selected");
                });
                toStationLoading();
                $("#tos-station-search").find("option:contains('" + routes[1] +"')").each(function () {
                    $(this).attr("selected", "selected");
                });                
                $('#sdate-search').val( $('#picker-show').text() );
                $('#sdate-search').datepicker("setDate", $('#picker-show').text());
                $('#right-search').show();                
                
                var transfer_len = $('.seat-transfer-from').length;
                if (transfer_len > 0) {
                    
                    console.log(sourceTicket);
                    
                    $('.tcks').remove();
                    $('.seat-transfer-to').removeClass('seat-transfer-to');
                    // seat transfer table //
                    var z = 0;
                    $.each($('.seat-transfer-from'), function () {
                        var seatno = $(this).html();
                        var tr = $('#ticket-table').html();
                        tr = $('<div>').html(tr).clone();
                        tr.find('tr').attr('class', 'tcks');
                        tr.find('tr').attr('id', 'from_' + seatno);
                        tr.find('.sch_o_seat').addClass('sch_o_seat_' + z).removeClass('sch_o_seat').html(seatno);
                        tr.find('.sch_n_seat').addClass('sch_n_seat_' + z).removeClass('sch_n_seat').html('');
                        tr.find('.sch_o_name').addClass('sch_o_seat_' + z).html($(this).data('pname'));
                        tr.find('.sch_o_age').addClass('sch_o_seat_' + z).html($(this).data('page'));
                        tr.find('.sch_o_gendar').addClass('sch_o_seat_' + z).html($(this).data('pgendar'));
                        $('#targetTable tbody').append(tr.html());
                        z++;
                        
                        sourceTicket.seatname += seatno+',';
                    });
                    // seat transfer table ends //
                }
            //}
        } else {
            $(this).removeClass('seat-transfer-from');
        }
    });
</script>
