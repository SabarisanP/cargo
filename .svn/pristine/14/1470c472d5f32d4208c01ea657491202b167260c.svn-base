<div class="busmap-list">

    <div class="header">
        <div class="pull-left col-lg-3"><span class="bold">From :</span>{$busmap->fromStation->name}</div>
        <div class="pull-left col-lg-3"><span class="bold">To :</span> {$busmap->toStation->name}</div>
        <div class="pull-left col-lg-4"><span class="bold">On :</span> 25/03/2014 9.30 PM  <!--<a href="javascript:;"><i data-original-title="Information" data-toggle="popover" data-content="Cancellation Terms,  Partial cancellation terms,  Max tickets allowed to book" class="fa fa-info-circle f17 has-popover"></i></a>--></div>                                                                

        <div class="pull-right"> <a id="close" href="javascript:;"><i class="fa fa-times f17"></i></a></div>
    </div>
    <div align="center" class="busmap"> 
        <div class="col-md-11 br_2 buslayer1">
            <div class="">
                <div class="col-lg-1 wd_15">
                    <div class="seat-driver">&nbsp;
                    </div>
                    <p class="vertical-text">Lower</p>
                </div>
                <div class="col-lg-12" style="width:auto;height: auto;">
                    {for $r=$lrowmin to $lrowmax}
                        {for $c=$lcolmin to $lcolmax}
                            <div class="seat-lay-visibility" id="busmaplay1{$busmap->tripCode}-{$tabid}-{$r}{$c}">
                                &nbsp;
                            </div>
                        {/for}
                        <div style="clear:both"></div>
                    {/for}
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </div>
        <div class="clear_fix_both"></div><br />
        <div class="col-md-11 br_2 buslayer2{$busmap->tripCode}-{$tabid}">
            <div class="">
                <div class="col-lg-1 wd_15">
                    <div class="seat-lay-visibility">
                    </div>
                    <p class="vertical-text">Upper</p>
                </div>
                <div class="col-lg-12" style="width:auto;height: auto;">
                    {for $r=$urowmin to $urowmax}
                        {for $c=$ucolmin to $ucolmax}
                            <div class="seat-lay-visibility" id="busmaplay2{$busmap->tripCode}-{$tabid}-{$r}{$c}">
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
    <div class="clear_fix_both"></div><br />
    <div align="center" class="busmap-container"> 
        <span class="text-danger bold">Seats :</span> <span class="seat-list">-</span> &nbsp; <span> <span class=" text-danger">Total Fare :</span> <i class="fa  fa-rupee"></i><span class="fare">0</span></span>
    </div>
    <div class="clear_fix_both"></div><br />
    <div class="passenger-info">

        <form role="form" class="form-inline">
            <div class="form-group">
                <div class="input-group">
                    <input type="email" placeholder="Email Address" id="emailaddress" name="emailaddress"  class="form-control">
                    <span class="input-group-addon">@</span>
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <input type="text" placeholder="Phone / Mobile" id="mobileno" name="mobileno" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                </div>
            </div>
            <div class="form-group">                                                                            
                <select class="form-control">
                    <option>Bording Points</option>
                    {foreach from=$busmap->fromStation->stationPoint item=stp}
                        <option value="{$stp->code}">{$stp->name}</option>
                    {/foreach}    
                </select>
            </div>

        </form>

    </div>
 <div class="clear_fix_both"></div><br />

 <div class="passenger-info">                                    
        <table class="table" id="bus-contact-list">
            <tr>
                <td>
                    <input type="text" name="name" id="name" class="form-control" placeholder="Name"/></td>
                <td><input type="text" name="age" id="age" class="form-control" placeholder="Age"/></td>
                <td>
                    <select class="form-control" name="gender" placeholder="Gender">
                        <option value="">Gender</option>
                        <option value="ACT">Male</option>
                        <option value="IDL">Female</option>
                    </select>
                </td>
                <td></td>
            </tr>
             <tr>
                <td colspan="5" align="right">
                    <a class="btn btn-sm btn-default btn-add-contact" type="button">Add Event</a>
                </td>
             </tr>
        </table>
            
</div>
 <div class="clear_fix_both"></div><br />
 <div class="passenger-info" align="center"> 
                        <button type="button" class="btn btn-success btn-confirm">Confirm</button>
                        <button type="button" class="btn btn-default">Cancel</button>
 </div>

</div>
<script>
    $(function() {
        $("[data-toggle='tooltip']").tooltip();
    });
    </script>
<script>
    var buslayer = {$busseatlayer|json_encode};
    var busseattype = {$seattype|json_encode}
    var type = new Array();

    $.each(busseattype, function(key, vals) {
        type[vals.code] = vals.name;
    });

    $(document).ready(function() {
        var lay = 0;
        $('.buslayer2{$busmap->tripCode}-{$tabid}').hide();

        $.each(buslayer, function(key1, bval) {

            $('#busmaplay' + bval.layer + '{$busmap->tripCode}-{$tabid}-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility').addClass('p_tool').attr('data-toggle', 'popover').attr('data-code', bval.code).attr('data-container', 'body').attr('data-seat', bval.seatName).attr('data-fare', bval.seatFare);
            $('#busmaplay' + bval.layer + '{$busmap->tripCode}-{$tabid}-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatTypeCode]);

            $('#busmaplay' + bval.layer + '{$busmap->tripCode}-{$tabid}-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility').addClass('p_tool').attr('data-toggle', 'popover').attr('data-code', bval.code).attr('data-container', 'body').attr('data-seat', bval.seatName).attr('data-fare', bval.seatFare);
            $('#busmaplay' + bval.layer + '{$busmap->tripCode}-{$tabid}-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatTypeCode]);


            //data-placement="top" data-title="A Title" data-trigger="hover"
            $('[data-toggle=popover]').popover({
                container: "body",
                html: true
            });

            if (bval.layer == 2) {
                lay = 1;
            }
        });

        if (lay > 0) {
            $('.buslayer2{$busmap->tripCode}-{$tabid}').show();
        }

        $('.tab-list-{$tabid}-{$busmap->tripCode}').find('.seat-select-visibility').click(function() {
            $(this).toggleClass("schedule-seat");
            var set = '';
            var amt = 0;
            $('.tab-list-{$tabid}-{$busmap->tripCode}').find('.schedule-seat').each(function(i) {
                if (set != '')
                    set += ',';
                set += $(this).attr('data-seat');
                amt = amt + Number($(this).attr('data-fare'));

            });
            if (set == '')
                set = '-';
            if (amt == '')
                amt = '0';
            $('.tab-list-{$tabid}-{$busmap->tripCode}').find('.seat-list').html("&nbsp;" + set);
            $('.tab-list-{$tabid}-{$busmap->tripCode}').find('.fare').html("&nbsp;" + amt);
        });
        // 
        $('.tab-list-{$tabid}-{$busmap->tripCode}').find('.btn-add-contact').click(function() {
            var tr = $('#template-contact-list').html();
            tr = $('<div>').html(tr).clone();
            
            $('.tab-list-{$tabid}-{$busmap->tripCode}').find('#bus-contact-list tr:last').before(tr.html());
        });
        $('.tab-list-{$tabid}-{$busmap->tripCode}').find('.btn-confirm').click(function() {
            var name = $('.tab-list-{$tabid}-{$busmap->tripCode}').find('input[name="name"]').serializeArray();
            var age = $('.tab-list-{$tabid}-{$busmap->tripCode}').find('input[name="age"]').serializeArray();
            var gender = $('.tab-list-{$tabid}-{$busmap->tripCode}').find('select[name="gender"]').serializeArray();
            var phone = $('.tab-list-{$tabid}-{$busmap->tripCode}').find('#mobileno').val();
            var emailaddress = $('.tab-list-{$tabid}-{$busmap->tripCode}').find('#emailaddress').val();
        });
    });
</script>