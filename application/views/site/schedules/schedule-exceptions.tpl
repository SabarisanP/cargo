{if $smarty.request.type ==1 }
<section>

    <div class=" pd_bt_45">
        <div class="col-xs-6 p_l_n">
            <div>
                <label for="txt_m_name" class="col-md-4" style="font-size:13px">Active From  </label>
                <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="from_sch">{$schedules[0]->activeFrom}</label>
            </div>
        </div>
        <div class="col-xs-6 p_l_n">
            <div>
                <label for="txt_m_name" class="col-md-4" style="font-size:13px">Active To </label>
                <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="to_sch">{$schedules[0]->activeTo}</label>
            </div>
        </div>   
        <div class="clear_fix_both"></div>
        <div class="col-xs-6 p_l_n">
            <div>
                <label for="txt_m_name" class="col-md-4" style="font-size:13px">Service Number  </label>
                <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="date_sch">{$schedules[0]->serviceNumber}</label>
            </div>
        </div>
        <div class="col-xs-6 p_l_n">
            <div>
                <label for="txt_m_name" class="col-md-4" style="font-size:13px">Display Name </label>
                <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="bus_sch">{$schedules[0]->displayName}</label>
            </div>
        </div>

        <div class="clear_fix_both"></div>
        <div class="col-xs-6 p_l_n">
            <div>
                <label for="txt_m_name" class="col-md-4" style="font-size:13px">Name  </label>
                <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="from_sch">{$schedules[0]->name}</label>
            </div>
        </div>
        <div class="clear_fix_both"></div>


    </div>

    {if $schedules[0]->code!=''}
        <a href="javascript:;" alt="Add exception" onclick="basicExceptionDialog()" title="Add exception"><i class="fa fa-plus"></i>&nbsp;Add Exception</a>
    {/if}
{/if}
    {if count($schedules[0]->overrideList) > 0 }

       <table class="table table-design tab-wid-80" id='booking-schedules-list'>
            <tr>
                <th>
                    From
                </th>
                <th>
                    To
                </th>
                <th>Day of Week</th>
                <th>

                </th>
            </tr>
            {foreach item=sclp from=$schedules[0]->overrideList}
                <tr class="sch-lok-{$sclp->code}">
                    <td>{$sclp->activeFrom}</td>
                    <td>{$sclp->activeTo}</td>
                    <td>
                        {if $sclp->dayOfWeek!=''}
                            {assign var=bday value=$sclp->dayOfWeek} 
                            <div class="btn-group btn-group-days-display">
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                            </div> 
                        {/if}  </td>
                    <td>
                        <a href="javascript:;" class="pTip_top" data-date='{$sclp->activeFrom} | {$sclp->activeTo}' data-days='{$sclp->dayOfWeek}' title="Edit exception" onclick="basicExceptionDialog('{$sclp->code}', this)">
                            <i class="fa fa-pencil"></i>
                        </a>
                        <a href="javascript:;" class="pTip_top sch-exp-del" data-datef='{$sclp->activeFrom}' data-datet='{$sclp->activeTo}' data-days='{$sclp->dayOfWeek}' title="Delete exception" onclick="deleteBasicException('{$sclp->code}', this)">
                            <i class="fa fa-trash-o"></i>
                        </a>
                    </td>
                </tr>
            {/foreach} 
        </table>

    {/if}
</section>

{if $smarty.request.type ==1 }
<div id="basic-schedule-dialog" class="dialog-content-page" style="display: none">
    <form role="form" id="basic-sch" class="form-horizontal">
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class="req col-md-3" for="basic_except_description">Description</label>
            <div class="col-md-9">
                <textarea id="basic_except_description" class="rs_no form-control"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label  class="req col-md-3" for="exp-weekdays-exp">Day of week</label>
            <div class="col-md-5">
                <div class="btn-group btn-group-days" id="exp-weekdays-exp" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked"  name="exp-weeks-exp" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">S</label>
                </div> 
            </div>
        </div>   
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class="col-md-3 control-label req" for="basic_except" class="req">Date</label>
            <div class="col-md-9"> 
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="basic_except" id="basic_except" class="form-control" readonly="true" value="">
                </div>
            </div>
        </div>


        <div class="clear_fix_both"></div><br />
        <div class="pull-left" id="basic-except-sch-loading"></div>
        <input type="hidden" id="sc-exp-code" value="" />
        <div class="pull-right" id="basic-except-sch-button">
            <button class="btn btn-success" type="button" onclick="saveBasicException('1')">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelBasicExceptionDialog();">Cancel</button>
        </div>
    </form>
</div>

<script>
    $('input[name="basic_except"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
</script>

{/if}