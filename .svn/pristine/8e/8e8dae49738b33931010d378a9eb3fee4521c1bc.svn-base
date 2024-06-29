<div class="brand_top"><h3>Notifications</h3> <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="AdminNotifyDialog();">Add New Notification</a></span></div>
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
                                    <div class="table-responsive">
                                        <table id="dt_notify_admin_table" class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Active From</th>
                                                    <th>Active To</th>
                                                    <th>Message</th>
                                                    <th>Comment Flag</th>
                                                    <th>Group / User</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">

                                                {if $date_format == 'Y-m-d'}
                                                    {$date = '%Y-%m-%d'} 
                                                {else if $date_format == 'd-m-Y'}
                                                    {$date = '%d-%m-%Y'} 
                                                {else if $date_format == 'e/b/Y'}
                                                    {$date = '%e/%b/%Y'} 
                                                {else if $date_format == 'D'}
                                                    {$date = '%D'} 
                                                {else if $date_format == 'd-b-y'}    
                                                    {$date = '%d-%b-%y'} 
                                                {/if}

                                                {foreach item=row from=$notify key=k}
                                                    <tr>
                                                        <td style='width:50px'>{$k+1}</td>
                                                        <td style='width:50px'>{$row->activeFrom|date_format:$date}</td>
                                                        <td style='width:50px'>{$row->activeTo|date_format:$date}</td>
                                                        <td style='width:100px'><a id="popup_msg" data-content='{$row->message|replace:"'":'"'}'>{$row->message|truncate:30}</a></td>
                                                        <td style='width:50px'>  <input type="checkbox" id="ph_bkg" name ='ph_bkg' class="bs_switch" data-size="small" {if $row->commentFlag==1}checked='checked'{/if}></td>
                                                        <td style='width:50px'>{if $row->group->name!=''}{$row->group->name}{else}{$row->user->name}{/if}</td>
                                                        <td style="width:100px"><a href="javascript:;" class="btn btn-default btn-sm-not edat" title="Edit" onclick="AdminNotifyDialog('{$row->code}',  '{$row->activeFrom}','{$row->activeTo}','{$row->group->code}','{$row->user->code}','{$row->commentFlag}', '{$row->name}')"><i class="fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not delam" title="Delete" onclick='deleteNotify({$row|@json_encode})'><i class="fa fa-trash-o ired"></i></a></td>
                                                    </tr>
                                                <div id="notify_mes_{$row->code}" style="display:none">{$row->message}</div>
                                                {/foreach}   
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="clear_fix_both"></div>

                                <div id="adm-notify-dialog" class="hide dialog-content-page">
                                    <div class="ov_fl_290">
                                        <form role="form" id="form1" class="form-horizontal ">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Select Notify To</label>
                                                    <div class="radio-inline">
                                                        <label>
                                                            <input type="radio" name="noti_flag"  value="group" class="grp_radio"  checked>
                                                            <span style="font-weight:lighter">Group</span>
                                                        </label>
                                                    </div>
                                                    <div class="radio-inline">
                                                        <label>
                                                            <input type="radio" name="noti_flag" class="usr_radio" value="user" >
                                                            <span style="font-weight:lighter">User</span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Name</label>
                                                    <input  placeholder="Name" id="name" name="name"  value="" class="form-control">
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <br />

                                            <div class="col-lg-6 p_l_n grp">
                                                <div>
                                                    <label for="txt_oz_name" class="req">Group</label>
                                                    <select id="group" class="form-control col-md-6">
                                                        <option value="">Select</option>
                                                        {foreach name=o item=row from=$groups}
                                                            <option value="{$row->code}">{$row->name}</option>
                                                        {/foreach}   
                                                    </select>
                                                </div>
                                            </div>   

                                            <div class="col-lg-6 p_l_n usr">
                                                <div>
                                                    <label for="txt_oz_name" class="req">User</label>
                                                    <select id="user" class="form-control col-md-6">
                                                        <option value="">Select</option>
                                                        {foreach name=o item=row from=$users}
                                                            <option value="{$row->code}">{$row->name}</option>
                                                        {/foreach}
                                                    </select>

                                                </div>
                                            </div>   

                                            <div class="col-lg-6 p_l_n">

                                                <label for="txt_l_name" class="req">Date Active From and To </label>
                                                <div class="input-group">
                                                    <input  placeholder="Date From" id="fdate" name="fdate"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                </div>
                                            </div>       

                                            <div class="clear_fix_both"></div>
                                            <br />    
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Message</label>
                                                    <textarea id="message"  placeholder="Enter your message here..." style="resize:none" class="form-control" rows="3" cols="10" name="message" id="message"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name">Comment Flag</label>
                                                    <input type="checkbox" id="cmt_flg" name ='cmt_flg' class="bs_switch1" data-size="small" checked="checked">
                                                </div>
                                            </div>

                                            <div class="clear_fix_both"></div>
                                        </form>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                    <div class="clear_fix_both">                       
                                        <div class="alert fl suc_cre" style="display: none;" id="org-form-action-state"></div>
                                        <div class="align-right cre_sve" id="form-bttons">
                                            <input type="hidden" name="notify_code" id="notify_code" value="" />

                                            <button class="btn btn-success" type="button" onclick="saveAdminNotify();">Save</button>
                                            <button class="btn btn-default" type="button" onclick="cancelNotify();">Cancel</button>
                                        </div>
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

</div>

<script>

    $('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');

    $('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'hover');
   

    $('[data-toggle=popover]').popover({
        container: "body",
        html: true
    });  

    $(document).ready(function() {

        $('.usr').hide();
        $('.bs_switch').bootstrapSwitch('size', 'mini');
        $('.bs_switch1').bootstrapSwitch('size', 'mini');
        $('.bs_switch').bootstrapSwitch('toggleDisabled');
        $('#dt_notify_admin_table').dataTable({
            scrollY: 250,
        });
        $("select[name=dt_notify_admin_table_length]").val("50").change();

        $('input[name="noti_flag"]').change(function() {
            if (this.checked) {
                if (this.value == 'group') {
                    $('.usr').hide();
                    $('.grp').show();
                } else {
                    $('.grp').hide();
                    $('.usr').show();
                }

            }
        });

        $('input[name="fdate"]').daterangepicker({
            buttonClasses: ['btn', 'btn-sm'],
            format: 'YYYY-MM-DD',
            separator: ' | ',
        });

        $('[data-toggle="popover"]').popover();


    });



</script>