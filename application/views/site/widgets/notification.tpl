{if count($notify) > 0}
    {foreach item=row from=$notify}
        <div class="stat_box1 stat_up1" id="notify_{$row->code}" >   
            <span>{if $row->newImageFlag==1} <i class="fa ion-alert-circled text-info" title="New"></i> &nbsp;{/if}</span>{if $row->name !='' }{$row->name|truncate:80}{else}{$row->message|truncate:80}{/if}</span>
        <a href="javascript:;" class="btn btn-default btn-sm-not delam vw_noty"  title="Hide" onclick="HideNotify('{$row->code}', '{$row->activeFrom}', '{$row->commentFlag}', '{$row->name}')"><i class="fa fa-trash-o ired"></i></a>
        <a href="javascript:;" class="btn btn-default btn-sm-not edat fr" title="View" onclick="UserNotifyDialog('{$row->code}', '{$row->activeFrom}', '{$row->commentFlag}', '{$row->name}')"><i class="fa fa-folder-open"></i></a>
        <div id="notify-{$row->code}" style="display:none">{$row->message}</div>  
    </div>
{/foreach}
{else}
    <br>
    <div class="well well-large ">No Notification found!</div>

{/if}
<div id="viw-notify-dialog" class="hide dialog-content-page">
    <div class="ov_fl_350">

        <div class="col-lg-6 p_l_n" style="border-bottom:1px solid #DDDDDD;width:100%">
            <div>
                <label><span id="notify_name"></span></label> 
            </div>
        </div>   
        <div class="clear_fix_both"></div>
        <br />

        <div class="col-lg-12 p_l_n">
            <div>
                <span class="msg"></span>
            </div>
        </div>

        <div class="clear_fix_both"></div>
        <br />

        <div class="col-lg-13 p_l_n hd_cmt">
            <div>

                <textarea placeholder="Enter your comment here..." style="resize:none" class="form-control" rows="3" cols="10" name="comment" id="comment"></textarea>
            </div>
        </div>


    </div> 
    <div class="alert fl suc_cre" style="display: none;" id="org-form-action-state"></div>
    <div class="align-right cre_sve" id="form-bttons">
        <input type="hidden" name="notify_code" id="notify_code" value="" />

        <button class="btn btn-success btn-msg" type="button" onclick="saveUsrNotify();">Save</button>
        <button class="btn btn-default" type="button" onclick="cancelUsrNotify();">Cancel</button>
    </div>
</div>