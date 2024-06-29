<div class="row">
    <div class="col-sm-6">
        <h5 class="bold">Sender Name</h5>
    </div>
    <div class="col-sm-6 text-right" style="padding-top:10px;">
        <button class="btn btn-success btn-xs" onclick="showSMSSenderDialog();"><i class="fa fa-plus"></i>Add New</button>
    </div>
</div>
<div class="clear_fix_both"></div>

{if count($smsconfig)}
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th align="left">#</th>
                    <th align="left">Header</th>
                    <th align="left">Entity Code</th>
                    <th align="left">Header Dlt Code</th>
                    <th align="left">Notification Mode</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                {foreach key=i item=row from=$smsconfig}
                    <tr>
                        <td align="left">{$i + 1}</td>
                        <td align="left">{$row->header}</td>
                        <td align="left">{$row->entityCode}</td>
                        <td align="left">{$row->headerDltCode}</td>
                        <td align="left">{$notification_mode[$row->notificationMode]}</td>
                        <td align="right">
                            <a class="edit pTip_top" title="Edit" href="javascript:;" id="sender-edit-{$row->code}" onclick="showSMSSenderDialog('{$row->code}')">
                                <i class="fa fa-pencil fa-lg"></i>
                            </a>&nbsp;
                            <a href="javascript:;" class="pTip_top" id="sender-status-{$row->code}" data-status="{$row->activeFlag}" onclick="toggleSMSSender('{$row->code}')">
                                {if $row->activeFlag == 1}
                                    <i class="fa fa-times fa-lg" title="Click to disable"></i>
                                {else}
                                    <i class="fa fa-check fa-lg" title="Click to enable"></i>
                                {/if}
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteSMSSender('{$row->code}')">
                                <i class="fa fa-trash-o fa-lg"></i>
                            </a>
                        </td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    
    <div class="row">
        <div class="col-sm-12">
            <h5 class="bold">Template</h5>
        </div>
        <div class="col-sm-6">
            <form class="form-inline">
                <div class="form-group" style="display: flex; align-items: center;">
                    <label for="sms-sender-name">Sender Name&emsp;</label>
                    <select class="form-control" id="sms-sender-name" onchange="getSMSTemplate()">
                        {foreach item=row from=$smsconfig}
                            {if $row->activeFlag == 1}
                                <option value="{$row->code}">{$row->header}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>
            </form>
        </div>
        <div class="col-sm-6 text-right" style="padding-top:10px;">
            <button class="btn btn-success btn-xs" id="sms-tpl-addbtn" onclick="showSMSTplDialog();" style="display: none"><i class="fa fa-plus"></i>Add New</button>
        </div>
    </div>
    <div class="clear_fix_both"></div><br>
    
    <div id="sms-telplates">
        <div class="well text-center">Please select an Sender Name to view SMS Template.</div>
    </div>
{else}
    <div class="well text-center">No data available</div>
{/if}
<div class="clear_fix_both"></div><br>

<div id="sender-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal">

        <div class=form-group>
            <label class="req">Header</label>
            <input type="text" class="form-control" id="sender-header" placeholder="Header" maxlength="6">
        </div>

        <div class=form-group>
            <label class="req">Header Dlt Code</label>
            <input type="text" class="form-control" id="sender-dlt" placeholder="Header Dlt Code" maxlength="25">
        </div>

        <div class=form-group>
            <label class="req">Entity Code</label>
            <input type="text" class="form-control" id="sender-entity" placeholder="Entity" maxlength="25">
        </div>
        <div class=form-group>
            <label class="req">Notification Mode</label>
            <select class="form-control" id="sender-notificationMode" name="sender-notificationMode" >
                <option value="">Select Notification Mode</option>
                {foreach from=$notification_mode  item=u key=i}
                    <option value="{$i}">{$u}</option>
                {/foreach}
            </select>
        </div>
    </form>

    <div class="clear_fix_both">
        <div class="alert" style="display: none;" id="sender-action-state"></div>
        <div class="align-right cre_sve" id="sender-form-buttons">
            <input type="hidden" id="sender-code-hid" value="" />
            <button class="btn btn-success" type="button" onclick="saveSMSsender();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelSMSsender();">Cancel</button>
        </div>
    </div>
</div>

<input type="hidden" id="smsns-code-hid" value="{$nscode}" />

<script>
    var smsSenderList = {$smsconfig|json_encode};

    if ($('#sms-sender-name option').length == 1) {
        $('#sms-sender-name').trigger('change');
    } else {
        $('#sms-sender-name').prepend(new Option('Select Sender Name', '')).val('');
    }
</script>