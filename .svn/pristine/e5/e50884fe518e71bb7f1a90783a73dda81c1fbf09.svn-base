<div class="clear_fix_both"></div>
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
                    <div class="seat-lay-visibility empty" id="lay1-{$r}{$c}">
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
                        <div class="seat-lay-visibility empty" id="lay2-{$r}{$c}">
                            &nbsp;
                        </div>
                    {/for}
                    <div style="clear:both"></div>
                {/for}
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </div>
    <div class="col-md-2 col-md-offset-2" >
        <div id="seat-selection-list">
        </div>
    </div>
    <div class="clear_fix_both"></div>
</div>
<script>
    var buslayer = {$busseatlayer|json_encode};
    
    var type = new Array();
    type["ALL"] = "Default";
    type["SS"] = "Semi Sleeper";
    type["SL"] = "Sleeper";
    type["ST"] = "Seater";
    type["USL"] = "Upper Sleeper";
    type["LSL"] = "Lower Sleeper";
    type["SUSL"] = "Single Upper Sleeper";
    type["SLSL"] = "Single Lower Sleeper";

    $(document).ready(function() {        
        var lay = 0;
        var seater_found = false; 
        $('.buslayer2,.seat-map-selayer').hide();
        $.each(buslayer, function(key1, bval) {
            if (bval.busSeatType.code == "SL" || bval.busSeatType.code == "USL" || bval.busSeatType.code == "LSL" || bval.busSeatType.code == "SLSL" || bval.busSeatType.code == "SUSL"){
                $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName)
                        .toggleClass('sleeper-lay-visibility sleeper-lay-search p_tool seat-select-visibility empty')
                        .attr('title', bval.busSeatType.name)
                        .attr('data-code', bval.code);
            } else if(bval.busSeatType.code !== 'RRM' &&  bval.busSeatType.code !== 'FRS') {
                $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName)
                        .addClass('seat-select-visibility')
                        .addClass('p_tool')
                        .removeClass('empty')
                        .attr('title', bval.busSeatType.name)
                        .attr('data-code', bval.code);
                seater_found = true;
            } else {
                $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x')
                        .addClass('hover-background')
                        .removeClass('empty').addClass('p_tool')
                        .attr('title', bval.busSeatType.name);
            }
            if(bval.orientation == 1) {
                $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).addClass('vertical-seat');
            }
            if (bval.layer == 2) {
                lay = 1;
            }
        });
        
        if(!seater_found) {
            $('.seat-map-over .empty').addClass('sleeper-lay-visibility');
            $('.seat-map-over .hover-background').addClass('sleeper-lay-visibility');
        }
        
        if (lay > 0) {
            $('.buslayer2,.seat-map-selayer').show();
        }        
    });


</script>
