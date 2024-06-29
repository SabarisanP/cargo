<!--Organization dialog-->                     
<div id="edit-user-organization" class="dialog-content-page" style="display: none">
                <form class="form-horizontal " action="#">
                    <label>Please select a organization</label>
                    <div class="ov_fl_230">
                        <ul class="user_list">
                    {foreach item=org from=$organization}
                            <li>
                                <div style="padding-left: 10px;"> 
                                    <div class="radio">
                                        <input type="radio" id="org_{$org->code}" value="{$org->code}" class="org_all" data-name="{$org->name}"  name="org_rad">
                                        <lable for="org_{$org->code}">{$org->name}</lable>
                                    </div>
                                </div> 
                            </li>
                     {/foreach}   
                        </ul>
                     </div>
                     <div class="clear_fix_both"></div><br/>
                    <input type="hidden" id="hid_org_usr_code" />
                    <input type="hidden" id="hid_org_od_code" />
                    <input type="hidden" id="hid_flg" />
                    <div id="ur-org-loading" style="display:none"></div>
                    <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-org-state"></div>
                    <div class="align-right" id="form-org-bttons">
                        <button type="button" id="btn-save" class="btn btn-success" onclick="saveUserOrganization()">Update</button>
                        <button type="button" class="btn btn-default" onclick="cancelorganization()">Cancel</button>
                    </div>

                </form>
</div>
<!--Organization dialog end-->   