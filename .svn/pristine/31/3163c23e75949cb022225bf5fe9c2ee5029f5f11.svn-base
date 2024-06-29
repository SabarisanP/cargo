<div class="brand_top">
    <h3>Arrange Seat Order</h3> 
    {if $action_rights['BUS-ADD']>0}
        <span class="align-right">
            <a href="#config/bus-type" class='btn btn-success'> <i class="fa fa-arrow-left fa-lg"></i>Back</a>        
        </span>
    {/if}
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
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-6" id="bus_seatname">
                                        <div class="text-center">Drag and order the seat numbers</div>
                                        <ul class="sort-list">
                                            {foreach item="row" from=$buslayer}
                                                <li class="sortable-item" code="{$row['code']}" title="Drag and re-order">
                                                    <div class="row">
                                                        <div class="bold col-md-4">{$row['name']}</div>
                                                        <div class="col-md-5">{$row['type']}</div>
                                                    </div>
                                                </li>
                                            {/foreach}	
                                        </ul>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="set-sorter-info">
                                            <div class="bold">{$bus->name} ({$bus->seatCount} seats)</div>
                                            <div>{formatBusCategory cate_code=$bus->categoryCode}</div>
                                            <input type="hidden" value="{$bus->code}" id="bcode" />
                                            <br>
                                            <div class="seat-sorter">
                                                {$layer_1 = 1}
                                                {$layer_2 = 2}
                                                {if $layer_2|in_array:$busmap['layer_all']}  
                                                    <div class="col-md-9 br_2"  id="l2-{$bus->code}">
                                                        <div class="">
                                                            <div class="col-sm-1 wd_15">
                                                                <p class="vertical-text">Upper</p>
                                                            </div>
                                                            <div class="col-sm-9 lt_10">
                                                                {for $r={$busmap['x-axis-min2']} to {$busmap['x-axis-max2']}}
                                                                    {for $c={$busmap['y-axis-min2']} to {$busmap['y-axis-max2']}}
                                                                        <div class="seat-lay" id="lays2-{$r}{$c}-{$bus->code}">
                                                                            &nbsp;
                                                                        </div>
                                                                    {/for}
                                                                    <div style="clear:both"></div>
                                                                {/for}
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/if}
                                                
                                                <div class="clearfix"></div> <br><br>
                                                
                                                {if $layer_1|in_array:$busmap['layer_all']}
                                                    <div class="col-md-9 br_2 ">
                                                        <div class="">
                                                            <div class="col-sm-1">
                                                                <div class="seat-driver">&nbsp;</div>
                                                                {if $layer_2|in_array:$busmap['layer_all']}  
                                                                    <div class="selayer">
                                                                        <p class="vertical-text">Lower</p>
                                                                    </div>
                                                                {/if}
                                                            </div>
                                                            <div class="col-sm-9 lt_10">
                                                                
                                                                {for $r={$busmap['x-axis-min1']} to {$busmap['x-axis-max1']}}
                                                                    {for $c={$busmap['y-axis-min1']} to {$busmap['y-axis-max1']}}
                                                                        <div class="seat-lay" id="lays1-{$r}{$c}-{$bus->code}">
                                                                            &nbsp;
                                                                        </div>
                                                                    {/for}
                                                                    <div class="clear_fix_both"></div>
                                                                {/for}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                {/if}
                                                
                                                
                                                
                                            </div>
                                                
                                            <div class=" clear_fix_both"></div> <br> <br>
                                            
                                            <div class="text-center" id="seat-sorter-action"></div>
                                            
                                            <div class="text-right" id="seat-sorter-buttons">
                                                <button onclick="saveSeatOrder();" type="button" class="btn btn-success">Save</button>                                            
                                                <a href="#config/bus-type" class='btn btn-default'> Back </a>
                                            </div>
                                        </div>
                                        
                                    </div>

                                </div><!--panel Body end-->
                            </div><!--panel end-->

                        </div>

                    </div><!--row end-->
                </div><!--content end-->
            </div>
        </div>
    </div>
</div>
                                                
<script>
    var bustype = [];
    bustype[0] = {$busmap|json_encode};
    var busseattype = {$seattype|json_encode};
</script>

{literal}
<script>
    $(document).ready(function () {
        $('#bus_seatname .sort-list').sortable();
        
        var lay = 0;

        var type = new Array();
        $.each(busseattype, function(key, vals) {
            type[vals.code] = vals.name;
        });

        $.each(bustype, function(keys, values) {
            $.each(values.buslayers, function(key1, bval) {

                $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).addClass('seat-select').addClass('p_tool').attr('data-toggle', 'popover').attr('data-container', 'body');
                $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).addClass('seat-select').addClass('p_tool').attr('data-toggle', 'popover').attr('data-container', 'body');
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);

                if (bval.busSeatType.code == "SL" || bval.busSeatType.code == "USL" || bval.busSeatType.code == "LSL"){
                    $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).removeClass('seat-lay').addClass('sleeper-lay');
                }
                if (bval.busSeatType.code == "SL" || bval.busSeatType.code == "USL" || bval.busSeatType.code == "LSL"){
                    $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).removeClass('seat-lay').addClass('sleeper-lay');
                }
                
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).html( bval.seatName );


                //data-placement="top" data-title="A Title" data-trigger="hover"
                $('[data-toggle=popover]').popover({
                    container: "body",
                    html: true
                });

                if (bval.layer == 2) {
                 lay = 1;
                }
            }); 
            
            if (lay == 0) {
                $('#l2-' + values.code).hide();
                $('#lyr-' + values.code).html('1');
                lay = 0;
            } else {
                $('#lyr-' + values.code).html('2');
            }
        });
        
        //$('.p_tool').powerTip({placement: 's'});

    });
    
    function saveSeatOrder() {
        var i = 1;
        var seats = [];
        $('.sortable-item').each( function() {
            var seat = {};
            seat.code = $(this).attr('code');
            seat.sequence = i;
            i++;
            
            seats.push(seat);
        });
        $('#seat-sorter-buttons').hide();
        $('#seat-sorter-action').html(loading_popup);
        
        var data = {};
        data.buscode = $('#bcode').val();
        data.seats = seats;
        
        $.ajax({
            type: "POST",
            url: "config/save-seat-order",
            dataType: 'json',
            data: data,
            success: function(res) {
                if(res.status==1){
                    $('#seat-sorter-action').html('<div class="alert alert-success">Your request has been processed successfully</div>');
                    window.setTimeout(function() {
                       $('#seat-sorter-action').html('');
                       $('#seat-sorter-buttons').show();
                    }, 4000);
                } else {
                    $('#seat-sorter-action').html('<div class="alert alert-danger">'+res.errorDesc+'</div>');
                    $('#seat-sorter-buttons').show();
                }
            }
        });
        
    }
</script>
{/literal}
