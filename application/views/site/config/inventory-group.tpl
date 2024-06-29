<div id="user-address-book" class="col-md-12">
    <h4>Inventory Group Details</h4>
    <ul class="user_list " id="user_list_search">
    {foreach item=group from=$groups}
    <li   >
        <span class="sp_name col-xs-10">{$group->name}</span>    

        <span  class="sp_action col-xs-2">
            <div class="btn-group btn-group-xs">
                <a href="javascript:;" class="btn btn-default btn-sm est"  onclick="editgroupInventoryStatus('{$row->code}', this)" data-status="{$row->activeFlag}">
                    {if $group->activeFlag==1}
                        <i class="fa fa-check" title="Click to enable"></i>
                    {else}
                        <i class="fa fa-times" title="Click to disable"></i>
                    {/if}
                </a>
            </div>   
        </span>
    </li> 
    {/foreach}    
    </ul>
    <div>
    <button class="btn btn-success" style="margin-left: 500px" type="button" onclick="saveinventorygroup();">Save</button>
    <a href="javascript:;" class="btn btn-default" onclick="cancelInventorygroup();" >cancel</a>
    </div>

</div>