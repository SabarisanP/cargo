{foreach item=rows from=$users key=r}
    {if $rows['userlist']|@count > 0}
        <div style="padding:10px;background-color: #eaeaea;" class='col-md-12'>
            <label>{$rows['name']}</label>
        </div>
        {foreach item=row from=$rows['userlist'] key=s}
            {if $row->activeFlag == 1}
                <label class="col-md-2" style='padding:0px 23px;font-weight: lighter'>
                    <input type="checkbox" value="{$row->code}"  id="usr_rights_{$row->code}" name="usr_rights">&nbsp;{$row->name}
                </label>
            {/if}
        {/foreach}
    {/if}
{/foreach}

<div class="align-right" id="privilege-button" style=' padding-bottom: 21px;position: relative;top: 30px;'>
   <span class="align-left error_visib"></span>&nbsp;&nbsp;&nbsp;
    <button type="button" id="btn-save" class="btn btn-success right_btn" onclick="saveScheduleRights()">Save</button>
</div>

<script>
var assingned_users = {$assigned_users|json_encode};
</script>

