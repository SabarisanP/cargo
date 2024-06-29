<div class="brand_top">
    <h3>Banner & Announcement</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="addNewBanner('', 1);">Add New Banner</a>
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
                                    <div class="col-md-offset-0 col-md-7">
                                        <table class="table" width="100%">
                                            <tr>
                                                <th>Updated on</th>
                                                <th>Name</th>
                                                <th>Date Range</th>
                                                <th>Group</th>
                                                <th>Device Medium</th>
                                                <th></th>
                                            </tr>

                                            {foreach name=o item=row from=$banner}
                                                <tr id="am-{$row->code}" class="tr-hover" onclick="getDetails('{$row->code}');">
                                                    <td>{$row->updatedAt|date_format:$ns_datetime_format}</td>
                                                    <td>
                                                        {$row->name}<br />
                                                        {if $row->displayModel == 'N'}
                                                            <span class="label label-primary">Announcement</span>
                                                        {elseif $row->displayModel == 'A'}
                                                            <span class="label label-danger">Advertisement</span>
                                                        {elseif $row->displayModel == 'S'}
                                                            <span class="label label-success">Slider</span>
                                                        {/if}
                                                    </td>
                                                    <td>
                                                        {$row->fromDate} <span class="glyphicon glyphicon-resize-horizontal"></span> {$row->toDate}<br />
                                                        {if $row->dayOfWeek == '1111111'} All Days
                                                        {elseif $row->dayOfWeek !=''}
                                                            {assign var=bday value=$row->dayOfWeek}
                                                            <div class="btn-group btn-group-days-display">
                                                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                                                            </div>
                                                        {/if}
                                                    </td>
                                                    <td class="sp_min_fare col-xs-2 rt_12 p_l_n p_r_n">
                                                        {if $row->group|count >0}
                                                            {foreach from=$row->group item=group key=i}
                                                                {if $i == 0}
                                                                    {$group->name}
                                                                {else}
                                                                    {break}
                                                                {/if}
                                                            {/foreach}
                                                            {if $row->group|@count >1}
                                                                <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                                                       {foreach from=$row->group item=group key=i}
                                                                           {$group->name} <br/>
                                                                       {/foreach}
                                                                       "><span class="label label-success"> {$row->group|count} </span></a>
                                                            {/if}
                                                        {else}
                                                            All
                                                        {/if}
                                                    </td>

                                                    <td class="sp_max_fare col-xs-2 rt_12 p_l_n p_r_n">
                                                        {if $row->deviceMedium|count >0}
                                                            {foreach from=$row->deviceMedium item=deviceMedium key=i}
                                                                {if $i == 0}
                                                                    {$deviceMedium->code}
                                                                {else}
                                                                    {break}
                                                                {/if}
                                                            {/foreach}
                                                            {if $row->deviceMedium|@count >1}
                                                                <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                                                       {foreach from=$row->deviceMedium item=deviceMedium key=i}
                                                                           {$deviceMedium->code} <br/>
                                                                       {/foreach}
                                                                       "><span class="label label-success"> {$row->deviceMedium|count} </span></a>
                                                            {/if}
                                                        {else}
                                                            All
                                                        {/if}
                                                    </td>
                                                    <td class="sp_action col-xs-2 p_l_n p_r_n text-center">
                                                        <div class="btn-group btn-group-xs">

                                                            <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick="allBannerDialog('{$row->code}')"><i class="fa fa-pencil igreen"></i></a>

                                                            <a href="javascript:;" class="btn btn-default btn-sm" onclick="editBannerStatus('{$row->code}')">
                                                                {if $row->activeFlag==1}
                                                                    <i class="fa fa-times" id="sta-{$row->code}" data-status="0" title="Click to disable"></i>
                                                                {else}
                                                                    <i class="fa fa-check" id="sta-{$row->code}" data-status="9" title="Click to enable"></i>
                                                                {/if}
                                                            </a>

                                                            <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick="deleteBanner('{$row->code}')"><i class="fa fa-trash-o ired"></i></a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            {foreachelse}
                                                <tr>
                                                    <td colspan="100%" align="center">No Results Found!</td>
                                                </tr>
                                            {/foreach}
                                        </table>

                                    </div>
                                    <div class="col-md-offset-0 col-md-5" id="banner-well">
                                        <div class="well well-large">Please select banner to view images</div>
                                    </div>
                                    <div class="col-md-offset-0 col-md-5" id="banner-container" style="display: none;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h5><b id="det-head"></b></h5>
                                            </div>
                                            <div class="col-md-6 text-right pb10">
                                                {* <a href="javascript:;" class="btn btn-success  btn-sm" onclick="addBannerDetails();">Add New Content</a> *}
                                            </div>
                                        </div>
                                        <div id="banner-gallery" class="freewall_container clearfix">

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--panel Body end-->
                        </div>
                        <!--panel end-->

                    </div>

                </div>
                <!--row end-->
            </div>
            <!--content end-->
        </div>
    </div>
</div>
<!--Banner dialog-->
<div id="banner-dialog" class="dialog-content-page" style="display: none;padding: 0rem 8rem;">
    <form class="" action="#">
        <!-- <label>Please select a route</label>
        -->
        <br />
        <div class="row">
            <div class="col-md-2 w-auto">
                <span class="label label-primary">Notice Type</span>
            </div>
            <div class="col-md-3">
                <label class="radio-inline">
                    <input type="radio" value="TEXT" id="booktype-admin" name="booktype-radio" onchange="toggleBookType()" checked>Text &nbsp;&nbsp;
                </label>
                <label class="radio-inline">
                    <input type="radio" value="IMAGE" id="booktype-office" name="booktype-radio" onchange="toggleBookType()">Image &nbsp;&nbsp;
                </label>
            </div>
            <div class="col-md-3 pull-right">
                <div class="form-group">
                    {* <label class="req d-inline-block" for="display_model" class="pull-left">Display Model</label> *}
                    <select id="display_model" class="form-control" onchange="displayModelChange(this)">
                        <option value="N">Announcement</option>
                        {if $is_super_namespace==1}
                            <option value="A">Advertisement</option>
                            <option value="S">Slider</option>
                        {/if}
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <div class="input-group col-md-12" id="state-list">
                        <label for="txt_oz_name" class="req">Active From & To</label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            <input type="text" name="date_cop" id="date_cop" class="form-control" readonly="true" value="">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-1">&nbsp;</div>
            <div class="col-lg-3">
                <div>
                    <label class="req">Day of Week</label>
                </div>
                <div class="btn-group btn-group-days" id="banner-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="banner-weekday" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="banner-weekday" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="banner-weekday" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="banner-weekday" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="banner-weekday" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="banner-weekday" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="banner-weekday" value="1">S</label>
                </div>
            </div>
            <div class="col-lg-1">&nbsp;</div>
            <div class="col-lg-3">
                <div class="form-group">
                    <div>
                        <label for="txt_level" class="req">Color</label>
                    </div>
                    <div>
                        {$colors = ['007bff', '6c757d', 'f00', '061fff', 'ffc107', '17a2b8', '343a40']}
                        {foreach from=$colors item=item key=key name=name}
                            <span type="button" id="group-color-{$item}" class="group-color text-center color-{$item}" style="background-color: #{$item};margin: 5px 0px 5px; width: 20px; height: 20px" onclick="chooseColor('{$item}', this);"></span>
                        {/foreach}
                        <input type="hidden" id="hid-selected-color">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <div class="form-group">
                    <label for="txt_m_name">&nbsp;</label>
                    <label for="txt_m_name" class="req pull-left">Subscriber List</label>
                </div>
            </div>
            <div class="col-md-10">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="txt_m_name" class="req pull-left">User Group</label>
                            <select id="user_grp" class="form-control" multiple="true">
                                <option value="ALL" selected>All Group</option>
                                {foreach name=o item=row from=$user_group}
                                    <option value="{$row->code}">{$row->name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="req" for="txt_m_name">Device Medium</label>
                            <select id="deviceMedium" name="deviceMedium " class="form-control" multiple="true">
                                <option value="ALL" selected>All Medium</option>
                                <option value="WEB">Website</option>
                                <option value="API">API</option>
                                <option value="MOB">Mobile Website</option>
                                <option value="APP">Mobile APP</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <div class="form-group">
                    <label for="txt_m_name" class="req pull-left">Subject</label>
                </div>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <input type="text" name="banner_name" id="ban_name" class="form-control" value="">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <div class="form-group">
                    <label for="txt_m_name" class="req pull-left">Redirect Url</label>
                </div>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <input type="text" name="banner_name1" id="ban_reurl" class="form-control" value="">
                </div>
            </div>
        </div>
        <div class="row" id="text-type">
            <div class="col-md-2">
                <div class="form-group">
                    <label for="txt_m_name" class="req pull-left">Message</label>
                </div>
            </div>
            <div class="col-md-10">
                <div class="form-group">
                    <textarea class="summernote" id="summernote"></textarea>


                </div>
            </div>
        </div>
        <div class="row" id="upload-cont">
            <div class="col-md-2" id="image-type">
                <div class="form-group">
                    <label for="txt_m_name" class="req pull-left">Images</label>
                </div>
            </div>
            <div class="col-md-4">
                <div>
                    <small class="text-muted">Upload your file</small><br><br>
                    <span id="uploads">
                        <div id="container">
                            <a id="pickfiles" class="btn btn-primary butt-d1 btn-sm" href="javascript:;">Pick file</a>

                            <div class="" id="drop_element"></div>
                            {* <a id="uploadfiles" class="btn btn-success  btn-sm" href="javascript:;">Upload files</a> *}
                        </div>
                        <br />
                    </span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <div class="form-group">
                </div>
            </div>
            <div class="col-md-10">

                <div id="filelist"></div>
                <div id="banner-epreview"></div>
            </div>
        </div>

        <div class="clear_fix_both"></div><br />
        <input type="hidden" id="code">
        <div id="ur-org-loading"></div>
        <div class="col-md-12 p_r_n">
            <div class="align-center alert alert-danger pull-left rt_err" id="usr-org-state"></div>
            <div class="align-right" id="form-org-bttons">
                <button type="button" id="btn-save" class="btn btn-success" onclick="saveNewBanner()">Save</button>
                <button type="button" class="btn btn-default" onclick="cancelBanner()">Cancel</button>
            </div>
        </div>
        <br>
        <br>

    </form>
</div>

<div id="banner-det-dialog" class="dialog-content-page" style="display: none">
    <form class="" action="#" onsubmit="return false;">
        <br />
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="txt_m_name" class="pull-left">Text</label>
                    <input type="text" name="alternate_text" id="alternate_text" class="form-control" value="">
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label for="txt_m_name" class="pull-left">Redirect Url</label>
                    <input type="text" name="redirect_url" id="redirect_url" class="form-control" value="">
                </div>
            </div>
            <div class="col-md-12">
                {* <span id="uploads">         
                    <div id="container">
                        <a id="pickfiles" class="btn btn-info  btn-sm"  href="javascript:;">Select files</a>
                       <a id="uploadfiles" class="btn btn-success  btn-sm" href="javascript:;">Upload files</a>
                    </div>
                    <br />
                    <div id="filelist"></div>
                </span> *}
            </div>
        </div>

        <div class="clear_fix_both"></div><br />
        <input type="hidden" id="banner-det-code">
        <input type="hidden" id="banner-code-for-det">
        <div class="col-md-12 p_r_n">
            <div class="align-center alert alert-danger pull-left rt_err" id="banner-det-state"></div>
            <div class="align-right" id="banner-det-bttons">
                <button type="button" id="btn-save" class="btn btn-success" onclick="saveBannerDetails();">Save</button>
                <button type="button" class="btn btn-default" onclick="cancelBannerDetails();">Cancel</button>
            </div>
        </div>

    </form>
</div>

<style>
    .modal-backdrop {
        display: none;
    }

    .note-editor .modal-header .close {
        font-size: 30px;
    }

    .note-editable {
        height: 120px;
    }

    ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button {
        font-size: 12px !important;
    }
</style>

<link rel="stylesheet" href="assets/lib/magnific-popup/magnific-popup.css">
<link href="assets/lib/summernote/summernote.min.css" rel="stylesheet">
<script src="assets/lib/summernote/summernote.min.js" onload="initSummerNote()"></script>

<!--Organization dialog end-->
<script>
    var bannerDel = {$banner|json_encode};

    $('input[name="date_cop"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });

    $('#user_grp').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        buttonClass: 'btn btn-default user_grp',
        dropLeft: true
    });

    $('#deviceMedium').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        buttonClass: 'btn btn-default deviceMedium',
        dropLeft: true
    });
    $('.has-popover').popover({
        trigger: 'hover',
        placement: 'right',
        container: 'body',
        html: true
    });

    function initSummerNote() {
        $('#summernote').summernote();
    }
</script>

<script>
    function displayModelChange(el) {
        if (el.value == 'A') {
            $('[name="booktype-radio"]').prop('disabled', true);
            $('[name="booktype-radio"][value="IMAGE"]').prop('checked', true).trigger('change')
            return
        }
        $('[name="booktype-radio"]').prop('disabled', false);
        $('[name="booktype-radio"][value="TEXT"]').prop('checked', true).trigger('change')
    }

    function addNewBanner(option, id) {

        $('.inp_error').removeClass('inp_error');
        $('#usr-org-state').hide();
        $('#form-org-bttons').show();
        $('#banner-dialog').dialog({
            autoOpen: true,
            height: $(window).height() - 100,
            width: $(window).width() - 400,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#code').val('');
        $('[name=banner_name]').val('');
        $('[name=date_cop]').val('');
        $('#user_grp').val('ALL');
        $('#user_grp').val(['ALL']).multiselect('refresh');
        $('#deviceMedium').val('ALL');
        $('#deviceMedium').val(['ALL']).multiselect('refresh');
        $('#ban_reurl').val('')
        $('#summernote').summernote('code', '');
        $('#banner-det-code').val('')
        $('[name="booktype-radio"]').prop('disabled', false);
        $('[name="booktype-radio"][value="TEXT"]').prop('checked', true).trigger('change')
        $('#banner-epreview').html('')
        $('#display_model').prop('disabled', false).val('N')
    }

    function cancelBanner() {
        $('#banner-dialog').dialog('destroy');
        $('#banner-dialog').hide();
    }

    function saveNewBanner() {

        var err = 0;
        if ($('#ban_name').val() == '') {
            $('#ban_name').addClass('inp_error');
            err++;
        } else {
            $('#ban_name').removeClass('inp_error');
        }

        if ($('#date_cop').val() == '') {
            $('#date_cop').addClass('inp_error');
            err++;
        } else {
            $('#date_cop').removeClass('inp_error');
        }

        var data = {};
        if ($('#user_grp').val() == null) {
            $('.user_grp').addClass('inp_error');
            err++;
        } else if ($.inArray('ALL', $('#user_grp').val()) != -1) {
            data.group = [{ code: '' }];
        } else {
            data.group = $.map($('#user_grp').val() || [], function(val) {
                return { code: val };
            });
        }

        $('#deviceMedium').removeClass('inp_error');
        if ($('#deviceMedium').val() == null) {
            $('.deviceMedium').addClass('inp_error');
            err++;
        } else if ($.inArray('ALL', $('#deviceMedium').val()) != -1) {
            data.deviceMedium = [{ code: '' }];
        } else {
            data.deviceMedium = $.map($('#deviceMedium').val() || [], function(val) {
                return { code: val };
            });
        }

        if (err > 0) {
            $('#usr-org-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#usr-org-state').html('Please select the values in the field that are marked in red');
            $('#usr-org-state').show();
            return false;
        } else {
            $('#usr-org-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-org-state').html('');
            $('#usr-org-state').hide();
        }

        $('#set_id').val('');

        data.displayModel = $('#display_model').val();
        data.activeFlag = 1;
        data.code = $('#code').val();
        data.name = $('#ban_name').val();
        data.color = $('#hid-selected-color').val();
        var dateDisc = $.trim($('#date_cop').val());
        var date = dateDisc.split('|');
        data.fromDate = $.trim(date[0]);
        data.toDate = $.trim(date[1]);
        data.dayOfWeek = $('input[name="banner-weekday"]').map(function() {
            return +$(this).is(':checked');
        }).get().join('');

        var type = $('[name="booktype-radio"]:checked').val()
        if (type == 'TEXT') {
            data.bannerDetails = {};
            data.bannerDetails.code = $('#banner-det-code').val() || '';
            data.bannerDetails.activeFlag = 1;
            data.bannerDetails.alternateText = $('#summernote').summernote('code');
            data.bannerDetails.redirectUrl = $.trim($('#ban_reurl').val());
            data.bannerDetails.sequence = 1;
            data.bannerDetails.messageType = {};
            data.bannerDetails.messageType.code = 'TEXT';
        } else if (data.code) {
            var option = _.find(bannerDel, function(o) {
                return o.code === data.code;
            });

            if (option.bannerDetails[0]) {
                data.bannerDetails = option.bannerDetails[0] || {};
                data.bannerDetails.code = $('#banner-det-code').val() || '';
                data.bannerDetails.redirectUrl = $.trim($('#ban_reurl').val());
            }
        }

        $('#ur-org-loading').removeClass('alert alert-danger alert-success hide');
        $('#ur-org-loading').html(loading_small);
        $('#form-org-bttons').hide();
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/update-banner',
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#banner-code-for-det').val(response.data.code);
                    saveBannerDetails();
                    return;
                    $('#usr-org-state').show();
                    $('#usr-org-state').removeClass('alert-danger');
                    $('#usr-org-state').addClass('alert alert-success');
                    $('#ur-org-loading').html('');
                    $('#usr-org-state').html('Your request has been completed successfully');
                } else {
                    $('#ur-org-loading').html('');
                    $('#usr-org-state').addClass('alert alert-danger').removeClass('alert-success hide');
                    $('#usr-org-state').html(response.errorDesc);
                    $('#usr-org-state').show();
                    $('#form-org-bttons').show();
                }
                window.setTimeout(function() {
                    cancelBanner();
                    checkURL();
                    return;
                }, 2000);
            }
        });
    }

    function allBannerDialog(option, id) {

        $('.inp_error').removeClass('inp_error');
        $('#usr-org-state').hide();
        $('#form-org-bttons').show();
        if (id == 1) {
            $('[name=banner_name]').val('');
            $('[name=date_cop]').val('');
        } else {
            $('[name=banner_name]').val('');
        }

        if (id == 3) {
            $('#test').val(1);
        } else {
            $('#test').val('');
        }
        $('#ban_reurl').val('')
        $('#summernote').summernote('code', '');
        $('#banner-det-code').val('')
        $('[name="booktype-radio"]').prop('disabled', false).trigger('change')

        $('#banner-dialog').dialog({
            autoOpen: true,
            height: $(window).height() - 100,
            width: $(window).width() - 400,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();

        if (option != '') {
            var option = _.find(bannerDel, function(o) {
                return o.code === option;
            });
            var name = option.name;
            var fdate = option.fromDate;
            var tdate = option.toDate;
            var date = fdate + " | " + tdate;
            $('#code').val(option.code);
            $('[name=banner_name]').val(name);
            $('[name=date_cop]').val(date);
            $('#deviceMedium').val(option.deviceMedium);
            $('#user_grp').val(option.group);
            $('#display_model').val(option.displayModel).prop('disabled', true).trigger('change');
            $('.group-color').html('');
            $('#group-color-' + option.color).html("<i class='fa fa-check group-color- text-white' aria-hidden='true' style='color:white'></i>");
            $('#hid-selected-color').val(option.color);
            var userGroups = $.map(option.group || [], function(obj) {
                return obj.code;
            });
            var deviceMedium = $.map(option.deviceMedium || [], function(obj) {
                return obj.code;
            });

            if (userGroups.length) {
                $('#user_grp').val(userGroups).multiselect('refresh');
            } else {
                $('#user_grp').val(['ALL']).multiselect('refresh');
            }

            if (deviceMedium.length) {
                $('#deviceMedium').val(deviceMedium).multiselect('refresh');
            } else {
                $('#deviceMedium').val(['ALL']).multiselect('refresh');
            }

            $.each(option.bannerDetails || [], function(i, row) {
                var html = '';
                sequence = 0;
                if (row.messageType.code == undefined || row.messageType.code == 'IMAGE') {
                    html += '<div class="freewall_item image_' + row.code + '" style="min-height: 80px">' +
                        '<img src="' + row.url.replace('[##]', 'thumb') + '" alt="">' +
                        '<div class="item_overlay">' +
                        '<h4>' + row.alternateText + '</h4>' +
                        '<a href="javascript:;" class="item_edit btn btn-xs" onclick=\'deleteBannerDetails("' + option.code + '", "' + row.code + '")\'><i class="fa fa-trash"></i> Delete</a>' +
                        '<a href="' + row.url.replace('[##]', 'image') + '" class="item_preview btn btn-xs"><i class="fa fa-search-plus"></i> View</a>' +
                        '</div>' +
                        '</div>'
                } else if (row.messageType.code == 'TEXT') {
                    $('#ban_reurl').val(row.redirectUrl)
                    $('#summernote').summernote('code', row.alternateText);
                }

                $('#banner-epreview').html(html);
                
                $('[name="booktype-radio"][value="' + row.messageType.code + '"]').prop('checked', true).trigger('change')
                $('#banner-det-code').val(row.code)
                $('#ban_reurl').val(row.redirectUrl)
                $('[name="booktype-radio"]').prop('disabled', true)
                return false;
            });
        }
    }

    function editBannerStatus(code) {

        var data = _.find(bannerDel, function(o) {
            return o.code === code;
        });
        data.activeFlag = $('#sta-' + code).attr('data-status');

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-banner",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    var chg = data.activeFlag == 1 ? 0 : 1;
                    $('#sta-' + code).attr('data-status', chg);
                    if ($('#sta-' + code).attr('data-status') == 1) {
                        $('#edt_rots_' + code).hide();
                        $('#sta-' + code).removeClass('fa-times').addClass('fa-check');
                        $('#lb-' + code).removeClass('label-success').addClass('label-danger').html('Disabled');

                    } else {
                        $('#edt_rots_' + code).show();
                        $('#sta-' + code).removeClass('fa-times').addClass('fa-times');
                        $('#lb-' + code).removeClass('label-danger').addClass('label-success').html('Active');

                    }
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function() {
                    loading_overlay.hide();

                    checkURL();
                    return;

                }, 2000);
            }
        })
    }

    function deleteBanner(code) {
        if (confirm('Do you want to delete this banner?')) {
            var data = _.find(bannerDel, function(o) {
                return o.code === code;
            });
            data.activeFlag = 2;

            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/update-banner",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function() {
                        loading_overlay.hide();

                        checkURL();
                        return;

                    }, 2000);
                }
            })
        }
    }

    var sequence = 0;

    function getDetails(code) {
        var data = _.find(bannerDel, function(o) {
            return o.code === code;
        });

        var html = '';
        sequence = 0;
        $.each(data.bannerDetails || [], function(i, row) {
            sequence = Math.max(sequence, Number(row.sequence));
            if (row.messageType.code == undefined || row.messageType.code == 'IMAGE') {
                html += '<div class="freewall_item image_' + row.code + '" style="min-height: 80px">' +
                    '<img src="' + row.url.replace('[##]', 'thumb') + '" alt="">' +
                    '<div class="item_overlay">' +
                    '<h4>' + row.alternateText + '</h4>' +
                    '<a href="javascript:;" class="item_edit" onclick=\'deleteBannerDetails("' + code + '", "' + row.code + '")\'><i class="fa fa-trash"></i></a>' +
                    '<a href="' + row.url.replace('[##]', 'image') + '" class="item_preview"><i class="fa fa-search-plus"></i></a>' +
                    '</div>' +
                    '</div>'
            } else if (row.messageType.code == 'TEXT') {
                html += '<div>' +
                    row.alternateText +
                    '&nbsp;<a href="javascript:;" class="item_edit btn btn-xs" onclick=\'deleteBannerDetails("' + code + '", "' + row.code + '")\'><i class="fa fa-trash"></i> Delete</a>' +
                    '</div>'
            }
        });

        if (data.bannerDetails.length == 0) {
            html = '<br><br><br><div class="well well-large">No Images Found</div>'
        }

        $('#banner-gallery').html(html);
        $('#banner-code-for-det').val(code);
        $('tr.hover-background').removeClass('hover-background');
        $('#am-' + code).addClass('hover-background');
        $('#det-head').html(data.name);
        $('#banner-well').hide();
        $('#banner-container').show();

        imagesLoaded('.freewall_item > img', function() {
            gallery_wall = new freewall("#gallery_grid");
            gallery_wall.reset({
                selector: '.freewall_item',
                animate: true,
                cellW: 220,
                cellH: 'auto',
                onResize: function() {
                    gallery_wall.fitWidth();
                }
            });
            gallery_wall.fitWidth();
            $(window).trigger("resize");

            $('.freewall_item').on('mouseenter', function() {
                if (!$(this).hasClass('.item_selected')) {
                    $(this).children('.item_overlay').addClass('show_overlay');
                }
            }).on('mouseleave', function() {
                if (!$(this).hasClass('.item_selected')) {
                    $(this).children('.item_overlay').removeClass('show_overlay');
                }
            });
        });

        if ($('.freewall_item .item_preview').length) {
            $('.freewall_item .item_preview').magnificPopup({
                type: 'image',
                gallery: {
                    enabled: true,
                    arrowMarkup: '<i title="%title%" class="glyphicon glyphicon-chevron-%dir% mfp-nav"></i>'
                },
                removalDelay: 500, //delay removal by X to allow out-animation
                callbacks: {
                    beforeOpen: function() {
                        // just a hack that adds mfp-anim class to markup 
                        this.st.image.markup = this.st.image.markup.replace('mfp-figure', 'mfp-figure mfp-with-anim');
                        this.st.mainClass = 'mfp-zoom-in';
                    }
                },
                closeOnContentClick: true,
                midClick: true // allow opening popup on middle mouse click. Always set it to true if you don't provide alternative source.
            });
        }
    }

    var uploader = new plupload.Uploader({
        runtimes: 'html5,html4',
        browse_button: 'pickfiles', // you can pass an id...
        container: document.getElementById('container'), // ... or DOM Element itself
        drop_element: 'drop_element',
        url: base_url + "config/upload-banner?id=",
        multi_selection: true,
        resize: {
            width: 1000,
            height: 1000,
            quality: 100
        },
        filters: {
            mime_types: [
                { title: "Image files", extensions: "jpg,gif,png,svg" },
            ],
            max_file_size: '3mb'
        },
        init: {
            PostInit: function(ul) {
                document.getElementById('filelist').innerHTML = '';
            },
            FilesAdded: function(up, files) {
                plupload.each(files, function(file) {
                    document.getElementById('filelist').innerHTML = '<div id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></div>';
                });
            },

            FileUploaded: function(up, files, res) {
                if (up.total.queued == 0) {
                    uploader.splice();
                    uploader.refresh();
                    $('#usr-org-state').show();
                    $('#usr-org-state').removeClass('alert-danger');
                    $('#usr-org-state').addClass('alert-success');
                    $('#ur-org-loading').html('');
                    $('#usr-org-state').html('Your request has been completed successfully');
                    cancelBanner();
                    // cancelBannerDetails();
                    checkURL();
                }
            },

            UploadProgress: function(up, file) {
                document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
            },

            Error: function(up, err) {
                $('#banner-det-state').html("Error #" + err.code + ": " + err.message);
            },
            BeforeUpload: function(up, file) {
                sequence = Number(sequence) + 1;

                var data = {};
                data.code = $('#banner-code-for-det').val();
                data.bannerDetailscode = $('#banner-det-code').val() || '';
                data.alternateText = $.trim($('#alternate_text').val());
                data.redirectUrl = $.trim($('#redirect_url').val());
                data.sequence = sequence;
                data.messageType = {};

                if (/^image/.test(file.type)) {
                    data.messageType.code = 'IMAGE'
                }

                up.settings.url = base_url + "config/update-banner-details?" + $.param(data);
            }
        }
    });
    uploader.init();

    function addBannerDetails() {
        $('.inp_error').removeClass('inp_error');
        $('#usr-org-state').hide();
        $('#alternate_text').val('');
        $('#redirect_url').val('');

        $('#banner-det-dialog').dialog({
            autoOpen: true,
            height: 400,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
    }

    function cancelBannerDetails() {
        $('#banner-det-dialog').dialog('destroy');
        $('#banner-det-dialog').hide();
    }

    function saveBannerDetails() {
        var alttext = $.trim($('#alternate_text').val());
        var bookingtype = $('[name="booktype-radio"]:checked').val();
        if (alttext && bookingtype == 'TEXT' && uploader.files == 0) {
            sequence = Number(sequence) + 1;

            var data = {};
            data.code = $('#banner-code-for-det').val();
            data.bannerDetailscode = $('#banner-det-code').val() || '';
            data.alternateText = alttext;
            data.redirectUrl = $.trim($('#redirect_url').val());
            data.sequence = sequence;
            data.messageType = {};
            data.messageType.code = 'TEXT';

            $.ajax({
                type: "GET",
                dataType: 'json',
                url: base_url + "config/update-banner-details",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        cancelBannerDetails();
                        checkURL();
                    } else {
                        alert(response.errorDesc)
                    }
                }
            })
            return
        } else if (uploader.files.length > 0) {
            uploader.start();
        } else {
            $('#usr-org-state').show();
            $('#usr-org-state').removeClass('alert-danger');
            $('#usr-org-state').addClass('alert-success');
            $('#ur-org-loading').html('');
            $('#usr-org-state').html('Your request has been completed successfully');
            cancelBanner();
            checkURL();
        }
    }

    function deleteBannerDetails(bannercode, detailcode) {
        var banners = _.cloneDeep(bannerDel);
        var data = _.find(banners, function(o) {
            return o.code === bannercode;
        });
        data.bannerDetails = _.filter(data.bannerDetails, function(o) {
            return o.code === detailcode;
        });
        $.each(data.bannerDetails, function(i) {
            data.bannerDetails[i].activeFlag = 2;
        });

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-banner-details",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        cancelBanner()
                        checkURL();
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            }
        })
    }

    function chooseColor(color, ele) {
        if (($(ele).children('i').length)) {
            $('#hid-selected-color').val('');
            $(ele).html('');
            $('.selected-color').css('display', 'none');
            return;
        }
        $('.group-color').html('');

        $('#hid-selected-color').val(color);
        $(ele).html("<i class='fa fa-check group-color- text-white' aria-hidden='true' style='color:white'></i>");

    }

    function toggleBookType() {
        var bookingtype = $('[name="booktype-radio"]:checked').val();
        $('#text-type, #image-type, #audio-type, #record-type, #upload-cont').addClass('hide');
        switch (bookingtype) {
            case 'TEXT':
                $('#text-type').removeClass('hide');
                break;
            case 'IMAGE':
                $('#image-type').removeClass('hide');
                $('#upload-cont').removeClass('hide');
                break;
                break;
            default:
                break;
        }
    }
</script>
