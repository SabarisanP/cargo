<div class="btn-group pull-left"><h4>Auth List</h4></div> 
<span class="align-right">
    {if $action_rights['ADL-ADD']>0} <a href="javascript:;" class="btn btn-success  btn-sm"   onclick="saveAuthDialog();">Add New Auth</a>{/if}
</span>

<div class="clear_fix_both"></div>
<div class="table-responsive">
    <table id="usr_com_table" class="table table-bordered">
        <thead>
            <tr>
                <th>Type</th>
                <th>Name</th>
                <th>Action</th>
            </tr>

        </thead>
        <tbody class="body_table">
        {foreach name=o item=row from=$devices} 
            <tr id="sp-{$row->code}">
                <td width="20%" class="sp_name">
                    {if $row->refferenceType=="UR"}
                        User
                    {else}
                        Group
                    {/if}
                </td>
                <td width="30%" class="sp_lat">
                    {if $row->refferenceType=="UR"}
                        {$row->user->name}
                    {else}
                        {$row->group->name}
                    {/if}
                </td>
                <td width="15%" class="sp_action">
                    <div class="btn-group btn-group-xs">                      
                      {if $action_rights['ADL-DELETE']>0}<a href="javascript:;" class="btn btn-default btn-xs del-bt" title="Delete" onclick="deleteAuthDevice('{$row->code}')"><i class="fa fa-trash-o"></i></a>{/if}
                    </div>
                </td>
            </tr> 
            {/foreach}    
        </tbody>
    </table>
</div>
<input type="hidden" id="hid_device_id" value="{$smarty.request.code}" />