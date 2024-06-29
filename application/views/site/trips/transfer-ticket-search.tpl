<br>
<div class="row" style="position:relative;left:14px">        
    <div class="seat-map-over-all buslayer2s">
        <div class="">
            <div class="col-lg-1">
                <p class="vertical-text">Upper</p>
            </div>
            <div class="col-lg-12" style="width:auto;height: auto;">
                {for $r=$xminl2 to $xmaxl2}
                    {for $c=$yminl2 to $ymaxl2}
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
                {for $r=$xminl1 to $xmaxl1}
                    {for $c=$yminl1 to $ymaxl1}
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
        
<br>
            
<div>
    <div class="form-group col-md-6 p_l_n">
        <div class="input-group col-md-12">
            <select class="form-control" id="brd">
                <option value=''>Select Boarding Point</option>
                {foreach from=$boarding item=brd}
                    <option value="{$brd->code}">{$brd->name} - {$brd->dateTime|date_format:"%I:%M %p"}</option>
                {/foreach}     
            </select>
        </div>
    </div>
    <div class="form-group col-md-6 p_l_n">
        <div class="input-group col-md-12">
            <select class="form-control" id="drp">
                <option value=''>Select Dropping Point</option>
                {foreach from=$dropping item=drp}
                    <option value="{$drp->code}">{$drp->name} - {$drp->dateTime|date_format:"%I:%M %p"}</option>
                {/foreach}     
            </select>
        </div>
    </div>
    <div class="form-group col-md-4 p_l_n">
        <label for="txt_m_name">Capture Fare Differece</label>
        <input type="checkbox" id="caputure_fare_diff" class="bs_switch" data-on-text="Yes" data-off-text="No">
    </div>
    <div class="form-group col-md-4 p_l_n">
        <label for="txt_m_name">Capture Transfer Charge</label>
        <input type="checkbox" id="caputure_transfer_charge" class="bs_switch" data-on-text="Yes" data-off-text="No">
    </div>
    <div class="form-group col-md-4 p_l_n">
        <label for="txt_m_name">Send SMS Notification</label>
        <input type="checkbox" id="caputure_sms_notif" class="bs_switch" data-on-text="Yes" data-off-text="No">
    </div>
</div>


<script>
    $('.bs_switch').bootstrapSwitch('size', 'mini');
    
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
                $('#lays' + bvals.layer + '-' + bvals.rowPos + '' + bvals.colPos).html(bvals.seatName).addClass('seat-'+bvals.seatName).addClass('seat-'+bvals.busSeatType.code).addClass('seat-select-visibility3').addClass('p_tool2').attr('data-toggle', 'popover').attr('data-codesp', bvals.code).attr('data-container', 'body');
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
                /*else if (bvals.seatStatus.code == 'BO') {
                    $('.' + bvals.seatName).css('background', color);
                }*/
            });
            if (lays > 0) {
                $('.buslayer2s,.tmap-lower-label').show();
            }
        });
    } else {
        $('.seat-map-over').html('<div class="well well-large">No Bus Found !</div>')
    }

    $('.p_tool2').on("click", function () {
        var seatno = '';
        var length_from = $('.seat-transfer-from').length;
        var length_to = $('.seat-transfer-to').length;
        if (!$(this).hasClass('seat-transfer-to') && !$(this).hasClass('selected2')) {
            if (length_from >= (length_to + 1)) {
                $(this).addClass('seat-transfer-to');
                seatno = $(this).html();
                var length_to = $('.seat-transfer-to').length;
                length_to = length_to - 1;
                $('.sch_n_seat_' + length_to).addClass('to_seat').addClass('seat_' + seatno).html(seatno);
            }
        } else {
            var length_to = $('.seat-transfer-to').length;
            seatno = $(this).html();
            $('.seat_' + seatno).html('');
            $(this).removeClass('seat-transfer-to');
        }
    });

</script>
