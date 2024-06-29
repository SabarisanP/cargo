<link rel="stylesheet" href="assets/lib/magnific-popup/magnific-popup.css">  
<div class="brand_top">
    <h3>Gallery</h3> 
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="saveDialogGallery();">Add New Gallery</a>
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
                                    <div id="user-result-panel">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="align-center" id="user-action-status"></div>
                                                <div id="user-address-book" class="col-md-3">
                                                        {if count($gallery) > 0}
                                                            <div class="user_list_action bt_27">
                                                                <ul class="user_list " id="user_gall_search">
                                                                    <div id="usr_scroll">
                                                                        {foreach name=o item=row from=$gallery} 
                                                                            <li id="gall-{$row->code}">
                                                                                <div class="fl rt_8">
                                                                                    <a href="javascript:;" id="gall-viw-{$row->code}" onclick="galleryView('{$row->code}','{$row->name}')" data-toggle="tooltip"  title="Click to view user details">
                                                                                        {$row->name}
                                                                                    </a>
                                                                                </div>
                                                                            </li>

                                                                        {/foreach}
                                                                    </div>
                                                                </ul>
                                                            </div>
                                                        {else}
                                                           <div class="well well-large "> No gallery found!</div>
                                                        {/if}   
                                                    
                                                </div>
                                                <div class="col-md-9" id="gal-viw-rslt">
                                                        <div >
                                                            <div class="well well-large "> Click any of the gallery name to view photos.</div>
                                                        </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="warning-text" id="useer-search-status"></div>
                                 <div id="gall-dialog" class="dialog-content-page" style="display:none">
                                    <form role="form" class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="gallery_name">Name<span class="required">*</span></label>
                                            <div class="col-sm-7">
                                                <input type="text" placeholder="Name" id="gall_name" class="form-control">
                                                <input type="hidden" id="gall_code" value="" />
                                            </div>
                                        </div>           
                                    </form>
                                    <div class="align-center alert alert-danger pull-left" style="display:none" id="gall-action-state"></div>
                                    <div class="align-right" id="gall-form-buttons">
                                        <button class="btn btn-success" type="button" onclick="saveGallery();">Save</button>
                                        <button class="btn btn-default" type="button" onclick="cancelGallery();">Cancel</button>
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
                                var userlist = {$users|json_encode};
                                $(document).ready(function () {
                                    $('input#gall_search').quicksearch('#user_gall_search #usr_scroll > li');
                                    $('#dpStart').datepicker({
                                        todayHighlight: true,
                                        startDate: '-0m',
                                        format: 'yyyy-mm-dd'
                                    }).on('changeDate', function (e) {
                                        var fDate = new Date(e.date);
                                        var end = new Date(fDate.setDate(fDate.getDate() + 365));
                                        $('#dpEnd').datepicker('setStartDate', e.date);
                                        $("#dpEnd").datepicker("setEndDate", end)
                                    });
                                    $('#dpEnd').datepicker({
                                        todayHighlight: true,
                                        startDate: '-0m',
                                        format: 'yyyy-mm-dd',
                                        maxDate: "+365D",
                                    }).on('changeDate', function (e) {
                                        $('#dpStart').datepicker('setEndDate', e.date)
                                    });
                                    // Slim Scroll
                                    $("#usr_scroll").css({
                                        'max-height': '350px',
                                    }).perfectScrollbar({
                                        wheelSpeed: 20,
                                        wheelPropagation: false
                                    });
                                    $('#gall_search').focus();


                                });
</script>







