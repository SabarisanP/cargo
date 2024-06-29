<div class="brand_top">
    <h3>Bus Type</h3> 
    {if $action_rights['BUS-ADD']>0}
        <span class="align-right">
            <a  class="btn btn-success  btn-sm" {if $action_rights['BUS-ADD']!=2} href="#config/get-bustype-category" {/if}>Add Bus Type</a>
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
                                    <div class="col-md-12">

                                        {$layer_1 = 1}
                                        {$layer_2 = 2}

                                        <div class="panel-group " id="accordion">

                                            {foreach name=b_type item=bus from=$buses}
                                                <div class="panel panel-info"  id="bs-{$bus['code']}">
                                                    <div class="panel-heading" >
                                                        <h3 class="panel-title"> 
                                                            {assign var=ct value="|"|explode:$bus['categoryCode']} 
                                                            <a  class="accordion-toggle ht_auto" data-loaded="0" data-toggle="collapse" data-parent="#accordion" href="#collapse{$smarty.foreach.b_type.index}">
                                                                <div class="row col-md-4 fl" > {$bus['name']} - ({$bus['seatCount']} - seats) 

                                                                    {if $categoryList['Layout'][$ct.0]!='' && $categoryList['ClimateControl'][$ct.1] && $categoryList['Chasis'][$ct.2] && $categoryList['Make'][$ct.3] && $categoryList['Seattype'][$ct.4]}
                                                                        <br />    {$categoryList['Layout'][$ct.0]} {$categoryList['Seattype'][$ct.4]}  {$categoryList['ClimateControl'][$ct.1]} {$categoryList['Make'][$ct.3]}   {$categoryList['Chasis'][$ct.2]}
                                                                    {/if}

                                                                </div> 
                                                                {if $layer_1|in_array:$bus['layer_all']}
                                                                    <div class="row col-md-7 br_2 hidden-sm hidden-xs hidden-md">
                                                                        <div class="">
                                                                            <div class="col-lg-1 wd_15">
                                                                                <div class="seat-driver">&nbsp;
                                                                                </div>
                                                                               {if $layer_2|in_array:$bus['layer_all']}  <div class="selayer">
                                                                                   <p class="vertical-text">Lower</p>
                                                                                </div>{/if}
                                                                            </div>
                                                                            <div class="col-lg-9 lt_10">
                                                                                {for $r={$bus['x-axis-min1']} to {$bus['x-axis-max1']}}
                                                                                    {for $c={$bus['y-axis-min1']} to {$bus['y-axis-max1']}}
                                                                                        <div class="seat-lay" id="lays1-{$r}{$c}-{$bus['code']}">
                                                                                            &nbsp;
                                                                                        </div>
                                                                                    {/for}
                                                                                    <div class="clear_fix_both"></div>
                                                                                {/for}
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-1"></div>{/if}
                                                                    {if $layer_2|in_array:$bus['layer_all']}  <div class="col-md-11 br_2 hidden-sm hidden-xs hidden-md  {if $layer_2|in_array:$bus['layer_all']} rt_15 {/if}"  id="l2-{$bus['code']}">
                                                                            <div class="">
                                                                                <div class="col-lg-1 wd_15">

                                                                                    <p class="vertical-text">Upper</p>
                                                                                </div>
                                                                                <div class="col-lg-9 lt_10">
                                                                                    {for $r={$bus['x-axis-min2']} to {$bus['x-axis-max2']}}
                                                                                        {for $c={$bus['y-axis-min2']} to {$bus['y-axis-max2']}}
                                                                                            <div class="seat-lay" id="lays2-{$r}{$c}-{$bus['code']}">
                                                                                                &nbsp;
                                                                                            </div>
                                                                                        {/for}
                                                                                        <div style="clear:both"></div>
                                                                                    {/for}
                                                                                </div>
                                                                            </div></div>{/if}
                                                                    </a> 
                                                                    <div class="btn-group btn-group-xs ac_bu">
                                                                        <a href="javascript:;" class="btn btn-link btn-sm bus-schedule-data" id="bus-schedule-data" data-busCode="{$bus['code']}">Schedules</a>
                                                                        {if $action_rights['BUS-DISABLE']>0} <a href="javascript:;" class="btn btn-default btn-sm est"  {if $action_rights['BUS-DISABLE']!=2}onclick="statusbusType('{$bus['code']}', '{$bus['name']}', this)"{/if} data-status="{$bus['activeFlag']}">
                                                                                {if $bus['activeFlag']==1}
                                                                                    <i class="fa fa-times" title="Click to disable"></i>
                                                                                {else}
                                                                                    <i class="fa fa-check" title="Click to enable"></i>
                                                                                {/if}
                                                                            </a>{/if}
                                                                            {if $action_rights['BUS-EDIT']>0}<a title="edit" id="bs_edt_{$bus['code']}"  {if $bus['activeFlag']==0}style="display:none"{/if} class="btn btn-default btn-sm edat" {if $action_rights['BUS-EDIT']!=2}href='#config/get-bustype-category?code={$bus['code']}'{/if}><i class="fa fa fa-pencil igreen"></i></a>{/if}
                                                                            {if $action_rights['BUS-DELETE']>0}<a href="javascript:;" title="delete" class="btn btn-default btn-sm del" {if $action_rights['BUS-DELETE']!=2}onclick="deletebusType('{$bus['code']}')"{/if}><i class="fa fa-trash-o ired"></i></a>{/if}
                                                                             <a class="btn btn-default btn-sm " href="#config/seat-sorter?bc={$bus['code']}" title="Sort Seat"><i class="fa fa-random"></i></a>
                                                                            
                                                                            <div class="text-center" style="color:#fff"> {$bus['code']}</div>                                                              
                                                                       
                                                                        </div>
                                                                    </h3>
                                                                </div>
                                                               
                                                                <div id="collapse{$smarty.foreach.b_type.index}" class="panel-collapse collapse">

                                                                    <div class="panel-body">
                                                                        <div class="col-md-12">
                                                                            <div class="row">
                                                                                <label class="col-xs-3">Layout</label>
                                                                                <div class="col-xs-3">{$categoryList['Layout'][$ct.0]}</div>
                                                                                <label class="col-xs-3">Climate</label>
                                                                                <div class="col-xs-3">{$categoryList['ClimateControl'][$ct.1]}</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <label class="col-xs-3">Chasis</label>
                                                                                <div class="col-xs-3">{$categoryList['Chasis'][$ct.2]}</div>
                                                                                <label class="col-xs-3">Make</label>
                                                                                <div class="col-xs-3">{$categoryList['Make'][$ct.3]}</div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <label class="col-xs-3">Seat Type</label>
                                                                                <div class="col-xs-3">{$categoryList['Seattype'][$ct.4]}</div>
                                                                                <label class="col-xs-3">Layer</label>
                                                                                <div class="col-xs-3" id="lyr-{$bus['code']}"></div>
                                                                            </div>
                                                                        </div>
                                                                     </div>
                                                                  </div>
                                                                </div>
                                                              {/foreach}                                     
                                                              </div>

                                                                    <!-- /BOX -->
                                                                    <!-- /BOX -->
                                                                </div>
                                                            </div><!--panel Body end-->
                                                        </div><!--panel end-->
                                                        <div id="bus-type-dialog" class="dialog-content-page">

                                                        </div>
                                                    </div>

                                                </div><!--row end-->
                                            </div><!--content end-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script>
                                var bustype ={$buses|json_encode}
                                var busseattype = {$seattype|json_encode}
                            </script>
                            {literal}
                                <script>

                                    $(document).ready(function() {

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

					if (bval.busSeatType.code == "SL" || bval.busSeatType.code == "USL" || bval.busSeatType.code == "LSL" || bval.busSeatType.code == "SLSL" || bval.busSeatType.code == "SUSL"){
						$('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).removeClass('seat-lay').addClass('sleeper-lay');
					}
					if (bval.busSeatType.code == "SL" || bval.busSeatType.code == "USL" || bval.busSeatType.code == "LSL" || bval.busSeatType.code == "SLSL" || bval.busSeatType.code == "SUSL"){
						$('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).removeClass('seat-lay').addClass('sleeper-lay');
					}
                                        if (bval.busSeatType.code == "RRM" || bval.busSeatType.code == "FRS"){
                                            $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).html('').addClass('bus-lay-cross');
					}


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
                                    $('.p_tool').powerTip({placement: 's'});
                                    });

                                    $('.bus-schedule-data').popover({
                                        container: '#main_page_content',
                                        content: loading_popup,
                                        html: true,
                                        placement: 'left',
                                        trigger: 'click',
                                    }).on('show.bs.popover', function () {
                                        var ele = this;
                                        var data = {};
                                        data.busCode = $(this).attr('data-busCode');

                                        $('.bus-schedule-data').not(this).popover('hide');
                                        $.ajax({
                                            type: "POST",
                                            dataType: 'html',
                                            url: base_url + "scheduleextras/bus-utilize",
                                            data: data,
                                            success: function (response) {
                                                $(ele).popover('destroy').popover({
                                                    container: '#main_page_content',
                                                    content: response,
                                                    html: true,
                                                    placement: 'left',
                                                    trigger: 'click',
                                                }).on('show.bs.popover', function () {
                                                    $('.bus-schedule-data').not(this).popover('hide');
                                                });
                                                if ($(ele).is(':focus')) {
                                                    $(ele).popover('show');
                                                }
                                            }
                                        });
                                    });
                                </script>
                            {/literal}
