<div class="table-responsive">
    <table class="table table-striped">
        <thead class="success">
            <tr>
                <th align="left">#</th>
                <th align="left">Template Dlt Code</th>
                <th align="left">Content</th>
                <th align="left">Notification Type</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach key=i item=row from=$smstpl}
                <tr>
                    <td align="left">{$i + 1}</td>
                    <td align="left">{$row->templateDltCode}</td>
                    <td align="left">{$row->content|nl2br|truncate:160}</td>
                    <td align="left">{$row->notificationType->name}</td>
                    <td align="right">
                        <a class="edit pTip_top" title="Edit" href="javascript:;" id="smstpl-edit-{$row->code}" onclick="showSMSTplDialog('{$row->code}')">
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>&nbsp;
                        <a href="javascript:;" class="pTip_top" id="smstpl-status-{$row->code}" data-status="{$row->activeFlag}" onclick="toggleSMSTemplate('{$row->code}')">
                            {if $row->activeFlag == 1}
                                <i class="fa fa-times fa-lg" title="Click to disable"></i>
                            {else}
                                <i class="fa fa-check fa-lg" title="Click to enable"></i>
                            {/if}
                        </a>&nbsp;
                        <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteSMSTemplate('{$row->code}')">
                            <i class="fa fa-trash-o fa-lg"></i>
                        </a>
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="5" align="center">No data available</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

<div id="smstpl-dialog"  class="dialog-content-page hide">
    <form role="form">

        <div class="row">
            <div class="col-md-6 p_r_n">
                <div class=form-group>
                    <label class="req">Notification Type</label>
                    <select id="smstpl-notificationtype" class="form-control">
                        <option value="">Select Notification Type</option>
                        {foreach item=row from=$sms_notification_type}
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-md-6">
                <div class=form-group>
                    <label class="req">Template Dlt Code</label>
                    <input type="text" class="form-control" id="smstpl-dlt" placeholder="Template Dlt Code" maxlength="25">
                </div>
            </div>
        </div>       

        <div class=form-group>
            <label class="req">Content</label>
            <textarea class="form-control" id="smstpl-content" rows="20" style="resize: vertical"></textarea>
        </div>
    </form>

    <div class="clear_fix_both">
        <div class="alert" style="display: none;" id="smstpl-action-state"></div>
        <div class="align-right cre_sve" id="smstpl-form-buttons">
            <input type="hidden" id="smstpl-code-hid" value="" />
            <button class="btn btn-success" type="button" onclick="saveSMSTemplate();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelSMSTemplate();">Cancel</button>
        </div>
    </div>
</div>

<script>
    var smsTplList = {$smstpl|json_encode};

    $('#smstpl-notificationtype').select2({
        dropdownParent: $('#smstpl-dialog')
    });

    $.ui.dialog.prototype._allowInteraction = function (e) {
        return !!$(e.target).closest('.ui-dialog, .ui-datepicker, .select2-drop').length;
    };
</script>
