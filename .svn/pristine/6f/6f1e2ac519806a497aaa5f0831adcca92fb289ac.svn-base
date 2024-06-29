<div>
    <div class="col-md-12">
        <div class="row" style="position:relative;left:14px">
            <div class="seat-map-over-all buslayer2s">
                <div class="">
                    <div class="col-lg-1">
                        <p class="vertical-text">Upper</p>
                    </div>
                    <div class="col-lg-12" style="width:auto;height: auto;">
                        {for $r=$urowmin to $urowmax}
                            {for $c=$ucolmin to $ucolmax}
                                <div class="seat-lay-visibility-stg-ser" id="lays2-{$r}{$c}">
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
        <br>
        <div class="row" style="position:relative;left:14px">
            <div class="seat-map-over">
                <div class="seat-map-over-all">
                    <div class="col-lg-1">
                        <div class="seat-map-driver">&nbsp;
                        </div>
                        <div class="seat-map-selayer tmap-lower-label">
                            <p class="vertical-text">Lower</p>
                        </div>
                    </div>
                    <div class="col-lg-9" style="width:auto;height: auto;">
                        {for $r=$lrowmin to $lrowmax}
                            {for $c=$lcolmin to $lcolmax}
                                <div class="seat-lay-visibility-stg-ser" id="lays1-{$r}{$c}">
                                    &nbsp;
                                </div>
                            {/for}
                            <div class="clear_fix_both"></div>
                        {/for}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-12 p_t_20" id="save-migrate-cont">
        <div class="row">
            <div class="col-md-4">PNR : <span id="spn-pnr"></span> </div>
        </div>
        <table class="table table-hover" id="target-migrate">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Old Seat</th>
                    <th>New Seat</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div class="col-lg-12 alert" id="seat-action-state" style="display: none"></div>
        <div class="clear_fix_both"></div>
        <div class="col-lg-4 pull-right text-right">
            <input type="hidden" id="hid-seat-pnr"/>
            <button class="btn btn-default" type="button" onclick="clearSeatMigrate();">Clear</button>
            <button class="btn btn-success" type="button" onclick="saveSeatMigrate();">Save</button>
        </div>
    </div>
</div>

<script>
    var buslayers = {$busseatlayer|json_encode};
    if (buslayers != null) {
        var busseattypes = {$seattype|json_encode}
        var types = new Array();
        $.each(busseattypes, function (key, vals) {
            types[vals.code] = vals.name;
        });
        $(document).ready(function () {
            var lays = 0;
            $('.buslayer2s,.tmap-lower-label').hide();
            $.each(buslayers, function (key12, bvals) {
                $('#lays' + bvals.layer + '-' + bvals.rowPos + '' + bvals.colPos).html(bvals.seatName).addClass('seat-' + bvals.seatName).addClass('seat-' + bvals.busSeatType.code).addClass('seat-select-visibility3').addClass('p_tool2').attr('data-toggle', 'popover').attr('data-codesp', bvals.code).attr('data-container', 'body');
                if (bvals.ticketCode != undefined) {
                    $('#lays' + bvals.layer + '-' + bvals.rowPos + '' + bvals.colPos).addClass('selected2').attr('data-fare', bvals.seatFare).attr('data-btype', types[bvals.busSeatType.code]).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bvals.ticketCode + "<br />" + bvals.passengerName + "(" + bvals.seatGendarStatus.code + ") - " + bvals.contactNumber + "<br />" + bvals.route + "<br />" + bvals.boardingPointName + "<br />Booked By : " + bvals.user.name + "</div>");
                } else {
                    $('#lays' + bvals.layer + '-' + bvals.rowPos + '' + bvals.colPos).attr('data-placement', 'top').attr('data-fare', bvals.seatFare).attr('data-btype', types[bvals.busSeatType.code]).attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "<div align='center'>" + bvals.seatName + ", " + types[bvals.busSeatType.code] + " , <i class='fa fa-rupee'></i> " + bvals.seatFare + "<br /> " + bvals.seatStatus.name + "</div>");
                }
                $('[data-toggle=popover]').popover({
                    container: "body",
                    html: true
                });
                if (bvals.layer == 2) {
                    lays = 1;
                }
                if (bvals.layer == 2) {
                    lays = 1;
                }
                var color = '';

                if (bvals.seatGendarStatus.code == 'F') {
                    color = '#ffcfe3';
                }
                if (bvals.seatGendarStatus.code == 'M') {
                    color = '#88d1f2';
                }
                if (bvals.seatStatus.code == 'AO') {
                    color = '#D3D7D7';
                }
                if (bvals.seatStatus.code == 'BL') {
                    color = '#EED4AF';
                }
                if (bvals.seatStatus.code == 'AM') {
                    color = '2px solid #017099';
                    $('.seat-' + bvals.seatName).css('border', color);
                } else if (bvals.seatStatus.code == 'AF') {
                    color = '2px solid #ffcfe3';
                    $('.seat-' + bvals.seatName).css('border', color);
                } else {
                    $('.seat-' + bvals.seatName).css('background', color);
                }
            });
            if (lays > 0) {
                $('.buslayer2s,.tmap-lower-label').show();
            }
        });
    } else {
        $('.seat-map-over').html('<div class="well well-large">No Bus Found !</div>')
    }

    $('.p_tool2').on("click", function () {
        var seatno = $(this).html();
        var seatCode = $(this).attr('data-codesp');
        var length_from = $('.migrate-from').length;
        var length_to = $('.seat-transfer-to').length;
        if (!$(this).hasClass('seat-transfer-to') && !$(this).hasClass('selected2')) {
            if (length_from >= (length_to + 1)) {
                $(this).addClass('seat-transfer-to');
                var length_to = $('.seat-transfer-to').length - 1;
                while ($('.migrate-to-' + length_to).text()) {
                    length_to = length_to - 1;
                }
                $('.migrate-to-' + length_to).attr('data-new', seatCode).text(seatno);
            }
        } else {
            $('td[data-new="' + seatCode + '"').text('').attr('data-new', '');
            $(this).removeClass('seat-transfer-to');
        }
    });
</script>