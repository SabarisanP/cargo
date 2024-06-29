<div class="brand_top">
    <h3>Conatct Category</h3>
    <div class="text-right">
        <a href="#contact/contact-users" class="btn btn-primary btn-sm">Back</a>
        <button class="btn btn-success btn-sm" onclick="addContactCategory();">Add Contact Category</button>
    </div>
</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-8">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table id="cargo_item_table" class="table table-bordered">
                                            <thead>
                                                <tr class="success">
                                                    <th>#</th>
                                                    <th>Name</th>
                                                    <th>Type</th>
                                                    <th>Tag</th>
                                                    <th>Credit / Debit</th>
                                                    <th>Description</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                {assign var="i" value=1}
                                                {foreach item=row from=$contactCategory key=k}
                                                    {if !in_array($row->actionCode, ['TRANS', 'BRCH', 'RAC', 'NMSP', 'EXP'])}
                                                    <tr>
                                                        <td width="5%">{$i}</td>
                                                        <td>{$row->name}</td>
                                                        <td>{$contact_category_action_codes[$row->actionCode]|default:'-'}</td>
                                                        <td nowrap>
                                                            {if $row->tag|count > 0}
                                                                {if $row->tag|count == 1 && ($row->tag[0] == 'CREDIT' || $row->tag[0] == 'DEBIT')}
                                                                    -
                                                                {elseif $row->tag[0] == 'CREDIT' || $row->tag[0] == 'DEBIT'}
                                                                    {$contact_category_tags[$row->tag[1]]}
                                                                {else}
                                                                    {$contact_category_tags[$row->tag[0]]}
                                                                {/if}
                                                                {if $row->tag|count > 1}
                                                                    <span data-toggle="popover" data-placement="top" data-content='<ul class="p_l_15">
                                                                        {foreach from=$row->tag item=tags}
                                                                            {if $tags != 'CREDIT' && $tags != 'DEBIT'}
                                                                            <li><b>{$contact_category_tags[$tags]}</b></li>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </ul>'><i class="fa fa-info-circle"></i></span>
                                                                {/if}
                                                            {else}
                                                                -
                                                            {/if}
                                                        </td>
                                                        <td>
                                                            {if in_array('CREDIT', $row->tag)}
                                                                <span class="badge badge-danger">Credit</span>
                                                            {elseif in_array('DEBIT', $row->tag)}
                                                                <span class="badge badge-success">Debit</span>
                                                            {else}
                                                                -
                                                            {/if}
                                                        </td>
                                                        <td width="40%">{$row->description}</td>
                                                        <td width="10%">
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not edat" title="Edit" onclick="addContactCategory('{$row->code}')"><i class="fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not delam" title="Delete" onclick="deleteContactCategory('{$row->code}')"><i class="fa fa-trash-o ired"></i></a>
                                                        </td>
                                                    </tr>
                                                    {assign var="i" value=$i+1}
                                                    {/if}
                                                {/foreach} 
                                            </tbody>
                                        </table>
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

<div id="add-contact-category-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideAddContactCategory();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-8">
                <div class="form-group">
                    <label class="req">Contact Category Name</label>
                    <input type="text" class="form-control" placeholder="Contact Category Name" id="contact-category-name"/>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="form-group">
                    <label for="contact-category-taglist">Credit / Debit</label>
                    <span class="radio d-inline-block">
                        <label><input type="radio" name="contact-category-taglist" value="CREDIT" checked> Credit</label>
                    </span>&emsp;
                    <span class="radio d-inline-block">
                        <label><input type="radio" name="contact-category-taglist" value="DEBIT"> Debit</label>
                    </span>&emsp;
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label>Type</label>
                    <select class="form-control" id="contact-category-type">
                        <option value="">Select type</option>
                        {foreach item=row key=key from=$contact_category_action_codes}
                            {if !in_array($key, ['TRANS', 'BRCH', 'RAC', 'NMSP', 'EXP'])}
                            <option value="{$key}">{$row}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="contact-category-tags">Tags</label>
                    <select class="form-control" id="contact-category-tags" multiple>
                        {foreach item=row key=key from=$contact_category_tags}
                            <option value="{$key}">{$row}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label>Description</label>
                    <textarea placeholder="Enter your description here..." class="form-control" rows="3" id="contact-category-description"></textarea>
                </div>
            </div>
            <div class="col-md-12">
                <div class="alert" id="contact-category-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="form-bttons">
                <input type="hidden" id="contact-category-hid-code">
                <button type="button" class="btn btn-success" onclick="saveContactCategory();">Save</button>&nbsp;
                <button type="button" class="btn btn-default" onclick="hideAddContactCategory();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>

<script>
    var allContactCategoryData = {$contactCategory|json_encode};
    $('#contact-category-type').select2();
    $('#contact-category-tags').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default contact-category-tags'
    });

    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });

    function addContactCategory(code) {
        $('#add-contact-category-dialog').removeClass('hide');
        $('#add-contact-category-dialog').dialog({
            autoOpen: true,
            height: 450,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#contact-category-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#contact-category-action-state').html('').hide();
        $('#contact-category-hid-code, #contact-category-name, #contact-category-description').val('');
        $('#contact-category-type').val('').trigger('change');
        $('#contact-category-tags').val('').multiselect('refresh');
        $('[name="contact-category-taglist"][value="CREDIT"]').prop('checked', true).trigger('change');

        if (_isdefined(code)) {
            var data = _.find(allContactCategoryData, o => o.code == code);

            $('#contact-category-hid-code').val(data.code);
            $('#contact-category-name').val(data.name);
            $('#contact-category-type').val(data.actionCode).trigger('change');
            $('#contact-category-description').val(data.description);
            $('#contact-category-tags').val(data.tag).multiselect('refresh');

            if ($.inArray('CREDIT', data.tag) != -1) {
                $('[name="contact-category-taglist"][value="CREDIT"]').prop('checked', true).trigger('change');
            } else if ($.inArray('DEBIT', data.tag) != -1) {
                $('[name="contact-category-taglist"][value="DEBIT"]').prop('checked', true).trigger('change');
            }
        }
    }

    function hideAddContactCategory() {
        $('#add-contact-category-dialog').dialog('destroy');
        $('#add-contact-category-dialog').hide();
    }

    function saveContactCategory() {
        var data = {};
        data.code = $('#contact-category-hid-code').val();
        data.activeFlag = 1;
        data.name = $.trim( $('#contact-category-name').val() );
        data.action_code = $('#contact-category-type').val();
        data.tag = $('#contact-category-tags').val() || [];

        var tagList = $('input[name=contact-category-taglist]:checked').val();
        if (isNotNull(tagList)) {
            data.tag.push(tagList)
        }
        data.description = $.trim( $('#contact-category-description').val() );

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.name == '') {
            $('#contact-category-name').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#contact-category-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#contact-category-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#contact-category-action-state').show();
            return false;
        } else {
            $('#contact-category-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#contact-category-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#contact-category-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#contact-category-action-state').html(loading_popup);
        $('#contact-category-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "contact/update-contact-category",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#contact-category-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#contact-category-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        hideAddContactCategory();
                        checkURL();
                    }, 3000);
                } else {
                    $('#contact-category-action-state').addClass('alert-danger');
                    $('#contact-category-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }

    function deleteContactCategory(code) {
        if (confirm('Do you want to delete this Contact Category?')) {
            var data = _.find(allContactCategoryData, function(o) {
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
                url: base_url + "contact/update-contact-category",
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
</script>    