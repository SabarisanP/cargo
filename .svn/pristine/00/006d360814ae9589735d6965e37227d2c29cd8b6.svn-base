<div class="brand_top">
    <h3>Bus Layout</h3> 
    <span class="align-right">
        <a href="#config/bus-type" class="btn btn-success  btn-sm" >Back</a>
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
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-0">
                                        <div class="row pt10 pb10" id="bus-type-dialog">
                                            <div class="row">
                                                <div class="col-md-10">            
                                                    <div class="col-md-3">
                                                        <input id="txt_bus_name" class="form-control" placeholder="Bus Name" maxlength="100" size="50" value="{$buses->name}" />

                                                        {assign var=ly value="|"|explode:$buses->categoryCode} 
                                                    </div>
                                                    <div class="col-md-3">
                                                        <select id="sel_layer" class="form-control" onchange="view_layer(this)" >
                                                            <option value="1">Single Layer</option>
                                                            <option value="2">Double Layer</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <select id="sel_layout" class="form-control" >
                                                            <option value="">Layout</option>
                                                            {foreach name=b_layout item=layout from=$master_categories['layout']}
                                                                <option value="{$layout->code}"  {if $ly.0==$layout->code}selected{/if}>{$layout->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <select id="sel_climate" class="form-control" >
                                                            <option value="">Climate</option>
                                                            {foreach name=b_layout item=layout from=$master_categories['climate']}
                                                                <option value="{$layout->code}" {if $ly.1==$layout->code}selected{/if}>{$layout->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>

                                                </div>         
                                            </div>
                                            <br />    
                                            <div class="row">                
                                                <div class="col-md-10">      
                                                    <div class="col-md-3">
                                                        <select id="sel_chase" class="form-control" >
                                                            <option value="">Chase</option>
                                                            {foreach name=b_layout item=layout from=$master_categories['chasis']}
                                                                <option value="{$layout->code}" {if $layout->code=="CS02" || $layout->code=="CS03"} disabled="true"  {/if} {if $ly.2==$layout->code}selected{/if}>{$layout->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    <div class="col-md-3">

                                                        <select id="sel_make" class="form-control" >
                                                            <option value="">Make</option>
                                                            {foreach name=b_layout item=layout from=$master_categories['make']}
                                                                <option value="{$layout->code}" {if $layout->code=="MK02" || $layout->code=="MK03"} disabled="true"  {/if} {if $ly.3==$layout->code}selected{/if}>{$layout->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <select id="sel_seatype" class="form-control" >
                                                            <option value="">Seat Type</option>
                                                            {foreach name=b_layout item=layout from=$master_categories['seattype']}
                                                                <option value="{$layout->code}" {if $ly.4==$layout->code}selected{/if}>{$layout->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>


                                            <br>            
                                            <div class="buslayout">
                                                <div class="row">                 

                                                    <div class="col-md-2 low_sel_bs" id='low_select'>
                                                        <span class="fa fa-question-circle tme_tool lt_77" id="lower_cursor"></span>
                                                        <select id="lower_option" class="form-control" >
                                                            {foreach name=b_layout item=s_type from=$seattype}
                                                                <option value="{$s_type->code}">{$s_type->code}</option>
                                                            {/foreach}
                                                        </select>

                                                        <a style="color: #428BCA;" class="low_adv" href="javascript:;" id='test_lower'>Advanced</a>          
                                                    </div>

                                                </div>

                                                <div class="col-md-2 up_sel_bs" id='up_select' style='display:none'>
                                                    <span class="fa fa-question-circle tme_tool lt_77" id="upper_cursor"></span>
                                                    <select id="upper_option" class="form-control" >
                                                        {foreach name=b_layout item=s_type from=$seattype}
                                                            <option value="{$s_type->code}">{$s_type->code}</option>
                                                        {/foreach}
                                                    </select>
                                                    <a style="color: #428BCA;" class="up_adv" href="javascript:;" id='test_upper'>Advanced</a> 
                                                </div>


                                            </div>



                                            <br />
                                            <div class="pull-left" style="display: none;" id="bustype_loading"></div>


                                            <div class="alert pull-left" style="display: none;" id="bustype-state"></div>
                                            <div class="align-right" id="form-btn-bustype">
                                                <input type="hidden" id="te">
                                                <input type="hidden" name="bus_code" id="bus_code" value="{$buses->code}" />
                                                <input type="hidden" name="bus_status" id="bus_status" value="{if $buses->activeFlag!=''}{$buses->activeFlag}{else}1{/if}" />

                                                <input type="button" id="back" class="btn btn-gray hide" value="Back">
                                                <input class="btn btn-success nxt" type="button" value="Next" onclick="buttonSelection();">
                                                <button class="btn btn-success hide save" type="button" onclick="saveBusType();">Save</button>
                                                <a class="btn btn-default" href="#config/bus-type">Cancel</a>

                                            </div>          
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
    var bus_code = "{$smarty.request.code}";
    var bustypelayer = {$buslayer|json_encode}
    var busseattype = {$seattype|json_encode}
    var pop = ''
    $.each(busseattype, function(key, vals) {
        pop += vals.code + " : " + vals.name;
        pop += "<br>";
    });

    $('#lower_cursor').attr('data-toggle', 'popover').attr('data-container', 'body');

    $('#lower_cursor').attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', pop);
    $('#upper_cursor').attr('data-toggle', 'popover').attr('data-container', 'body');

    $('#upper_cursor').attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', pop);


    $('[data-toggle=popover]').popover({
        container: "body",
        html: true
    });
    
    function _init_busmap_edit() {
        init_busmp_edit();
    }
    
</script>