<div class="brand_top">
    <h3>Travel Stops</h3> 
    <span class="align-right">        
        <a href="#config/edit-travel-stops" class="btn btn-success" >Add New Stop</a>
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
                                    <div class="col-md-offset-3 col-md-6">
                                        <div class="panel-group" id="accordion">
                                            {if count($entity) > 0}
                                                {foreach name=o item=row from=$entity}

                                                    <div class="panel panel-info" id="stop-{$row->code}">
                                                        <div class="panel-heading">
                                                            <h3 class="panel-title"> 
                                                                <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row->code}">
                                                                    {$row->name}
                                                                </a>

                                                                <div class="btn-group btn-group-xs ac_bu">
                                                                   
                                                                        <a href="javascript:;" class="btn btn-default btn-sm est"  onclick="editStatusStop('{$row->code}', {$row->activeFlag})">
                                                                            {if $row->activeFlag==1} 
                                                                                <i class="fa fa-times" title="Click to disable" data-toggle="tooltip"></i>
                                                                            {else}
                                                                                <i class="fa fa-check" title="Click to enable" data-toggle="tooltip"></i>
                                                                            {/if}
                                                                        </a>
                                                                    <a href="#config/edit-travel-stops?code={$row->code}" title="Edit" id='gp_edt_{$row->code}'  data-toggle="tooltip" class="btn btn-default btn-sm" ><i class="fa fa fa-pencil igreen"></i></a>
                                                                    <a href="javascript:;" title="Delete" data-toggle="tooltip" class="btn btn-default btn-sm del" onclick="deleteStop('{$row->code}')"><i class="fa fa-trash-o ired"></i></a>

                                                                </div>
                                                            </h3>
                                                        </div>  
                                                        <div id="collapse-{$row->code}" class="panel-collapse collapse">
                                                            <div class="panel-body"> 
                                                                
                                                                <div class="row">
                                                                    <div class="col-md-2">Landmark :</div>
                                                                    <div class="col-md-9">{$row->landmark}</div>
                                                                </div>
                                                                                                                                
                                                                <div class="row">
                                                                    <div class="col-md-2">Position :</div>
                                                                    <div class="col-md-9"><a href="http://www.google.com/maps/place/{$row->latitude},{$row->longitude}" target="_blank">Map Link</a></div>
                                                                </div>
                                                                
                                                                <div class="row">
                                                                    <div class="col-md-2">Amenities :</div>
                                                                    <div class="col-md-9">{', '|implode:$row->amenities}</div>
                                                                </div>
                                                                
                                                                <div class="row">
                                                                    <div class="col-md-2">Halt Time :</div>
                                                                    <div class="col-md-9">{$row->minutes} minutes</div>
                                                                </div>
                                                                
                                                            </div>
                                                        </div>
                                                    </div>

                                                {/foreach} 
                                            {else}
                                                <div class="well well-large ">No stops found!</div>
                                            {/if}
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
    var mas_stops = {$entity|json_encode};
</script>