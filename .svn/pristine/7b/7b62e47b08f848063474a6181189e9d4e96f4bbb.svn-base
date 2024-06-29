  <!--Group dialog-->                 
                              <div id="edit-user-group" class="dialog-content-page" style="display: none">
                                    <form class="form-horizontal " action="#">
                                        <label>Please select a group</label>
                                        <div class="ov_fl_230">
                                            <ul class="user_list">
                                        {foreach item=grp from=$groups}
                                                <li>
                                                       <input type="radio" id="grp_{$grp->code}" value="{$grp->code}" class="grp_all" data-name="{$grp->name}"  name="grp_rad">
                                                       <lable for="grp_{$grp->code}">{$grp->name}</lable>
                                                </li>
                                         {/foreach}   
                                            </ul>
                                         </div>
                                         <div class="clear_fix_both"></div><br/>
                                        <input type="hidden" id="hid_grp_usr_code" />
                                        <input type="hidden" id="hid_grp_od_code" />
                                        <input type="hidden" id="hid_grp_flg" />
                                        <div id="ur-grp-loading" style="display:none"></div>
                                        <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-grp-state"></div>
                                        <div class="align-right" id="form-grp-bttons">
                                            <button type="button" id="btn-save" class="btn btn-success" onclick="saveUserGroup()">Update</button>
                                            <button type="button" class="btn btn-default" onclick="cancelgroup()">Cancel</button>
                                        </div>

                                    </form>
                                </div>
                                  <!--Group dialog end-->    
