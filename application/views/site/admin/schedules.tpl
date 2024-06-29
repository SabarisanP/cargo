<div class="brand_top"><h3>Payment Schedules</h3> <span class="align-rights">{if $action_rights['PG-SCH-ADD']>0}<a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['PG-SCH-ADD']!=2}onclick="editSchedules();"{/if}>Add New Schedule</a>{/if}</span></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="content" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-3 col-md-6">
                                        <div class="panel-group" id="accordion">
                                            <div class="panel panel-info hide" id="oz-dm">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title"> 
                                                        <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-"></a>
                                                        <div class="btn-group btn-group-xs ac_bu">
                                                            <a href="javascript:;" class="btn btn-default btn-sm est" onclick="editStatusSchedules()" data-status="1"><i class="fa fa-times"  title="Click to disable"></i></a>
                                                            <a href="javascript:;" title="edit" class="btn btn-default btn-sm edat" onclick='editSchedules()'><i class="fa fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" onclick="deleteSchedules()"><i class="fa fa-trash-o ired"></i></a>
                                                        </div>
                                                    </h3>    
                                                </div>  
                                            </div>

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

                                            {if count($schedule) > 0}

                                                {foreach name=o item=row from=$schedule}
                                                    <div class="panel panel-info" id="oz-{$row->code}">
                                                        <div class="panel-heading">
                                                            <h3 class="panel-title"> 
                                                                <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row->code}"> <span id="usr_cnt_{$row->code}"><span title="Precedence">{$row->precedence}</span> - {$row->name} - {foreach from=$row->deviceMedium item=deviceMedium key=i}
                                                                           {$deviceMedium}
                                                                       {/foreach}</span> </a>
                                                                <div class="btn-group btn-group-xs ac_bu">
                                                                    {if $action_rights['PG-SCH-DISABLE']>0}  <a href="javascript:;" class="btn btn-default btn-sm est"   {if $action_rights['PG-SCH-DISABLE']!=2} onclick='editStatusSchedules({$row|@json_encode}, this)'{/if} data-status="{$row->activeFlag}">
                                                                        {if $row->activeFlag==1}
                                                                            <i class="fa fa-times" title="Click to disable"></i>
                                                                        {else}
                                                                            <i class="fa fa-check" title="Click to enable"></i>
                                                                        {/if}
                                                                        </a>{/if}
                                                                        {if $action_rights['PG-SCH-EDIT']>0} <a href="javascript:;" title="edit" {if $row->activeFlag==0}style='display:none'{/if}   class="btn btn-default btn-sm edat" id='edt_sch_{$row->code}'  {if $action_rights['PG-SCH-EDIT']>0} onclick='editSchedules({$row|@json_encode})'{/if}><i class="fa fa fa-pencil igreen"></i></a>{/if}
                                                                        {if $action_rights['PG-SCH-DELETE']>0}<a href="javascript:;" title="delete" class="btn btn-default btn-sm del"   {if $action_rights['PG-SCH-DELETE']>0} onclick='deleteSchedules({$row|@json_encode})'{/if}><i class="fa fa-trash-o ired"></i></a>{/if}

                                                                </div>
                                                            </h3>
                                                        </div> 
                                                        <div id="collapse-{$row->code}" class="panel-collapse collapse">
                                                            <div class="panel-body"> 
                                                                <div class="col-md-8 ">
                                                                    <label  class="col-xs-5">Gateway Partner </label>
                                                                    <label class='col-xs-2'> : </label>
                                                                    <div class="add1">
                                                                        {foreach name=o item=rows from=$partner}

                                                                            {if $rows->code == $row->gatewayPartner->code}
                                                                                {$rows->name} ({$rows->paymentMode->name})
                                                                            {/if}    
                                                                        {/foreach}
                                                                    </div>
                                                                    <div class="clear_fix_both"></div>
                                                                    <label  class="col-xs-5">Group </label>
                                                                    <label class='col-xs-2'> : </label>
                                                                    <div class="add1">{$row->group->name}</div>
                                                                    <div class="clear_fix_both"></div>
                                                                    <label  class="col-xs-5">From Date </label>
                                                                    <label class='col-xs-2'> : </label>
                                                                    <div class="add1">{$row->fromDate|date_format:$date}</div>
                                                                    <div class="clear_fix_both"></div>
                                                                    <label  class="col-xs-5">To Date </label>
                                                                    <label class='col-xs-2'> : </label>
                                                                    <div class="add2">{$row->toDate|date_format:$date}</div>
                                                                    <div class="clear_fix_both"></div>
                                                                    <label  class="col-xs-5">Device Medium </label>
                                                                    <label class='col-xs-2'> : </label>
                                                                    <div class="add1">{foreach from=$row->deviceMedium item=deviceMedium key=i}
                                                                           {$deviceMedium}
                                                                       {/foreach}</div>
                                                                    <div class="clear_fix_both"></div>
                                                                    <label  class="col-xs-5">Precedence </label>
                                                                    <label class='col-xs-2'> : </label>
                                                                    <div class="add1">{$row->precedence}</div>
                                                                    <div class="clear_fix_both"></div>

                                                                </div>


                                                            </div>
                                                        </div>
                                                    </div>
                                                    <script type="text/javascript">
                                                        $(document).ready(function ($) {
                                                            $("#org_scroll_{$row->code}").css({
                                                                'max-height': '220px',
                                                            }).perfectScrollbar({
                                                                wheelSpeed: 20,
                                                                wheelPropagation: false
                                                            });
                                                        });
                                                    </script>
                                                {/foreach} 
                                            {else}
                                                <div class="well well-large ">No Schedules found!</div>
                                            {/if}
                                        </div>
                                    </div>
                                    <div class="clear_fix_both"></div>

                                    <div id="pg-organization-dialog" class="hide dialog-content-page">
                                        <div >
                                            <form role="form" id="form1" class="form-horizontal ">

                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">Name</label>
                                                        <input  placeholder="Name" id="name" name="name"  class="form-control">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">Device Medium</label>
                                                        <select id="device" class="form-control col-md-6" multiple="true">
                                                            <option value="WEB">WEB</option>
                                                            <option value="MOB">MOB</option>
                                                            <option value="APP">APP</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <br />

                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_oz_name" class="req">Gateway Partner</label>
                                                        <select id="gateway" class="form-control col-md-6">
                                                            <option value="">Select</option>
                                                            {foreach name=o item=row from=$partner}
                                                                <option value="{$row->code}">{$row->name} ({$row->paymentMode->name})</option>
                                                            {/foreach}   
                                                        </select>
                                                    </div>
                                                </div>   

                                                <div class="col-lg-6 p_l_n">
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


                                                <div class="clear_fix_both"></div>
                                                <br />    

                                                <input type="hidden" id="code_edit">


                                                <div class="col-lg-6 p_l_n">

                                                    <label for="txt_l_name" class="req">From Date</label>
                                                    <div class="input-group">
                                                        <input  placeholder="Date From" id="fdate" name="fdate"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">To Date</label>
                                                        <div class="input-group">
                                                            <input  placeholder="Date To" id="tdate" name="tdate"  class="form-control"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <br />
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_l_name" class="req">Service Charges (%)</label>
                                                        <input  placeholder="Service Charges" id="service_charges" name="service_charges"  class="form-control">
                                                    </div>
                                                </div> 
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">TXN Type</label>
                                                        <select id="pgs_txn_type" class="form-control col-md-6">
                                                            <option value="">Select</option>
                                                            <option value="RECHG">Recharge</option>
                                                            <option value="TICKBO">Ticket Booking</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <br />
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_l_name" class="req">Precedence</label>
                                                        <input type="number" placeholder="Precedence" id="sch-precedence" class="form-control no-spin">
                                                    </div>
                                                </div> 

                                                <div class="clear_fix_both"></div>
                                                <br />
                                            </form>
                                        </div>
                                        <div class="clear_fix_both"></div>
                                        <div class="clear_fix_both">                       
                                            <div class="alert fl suc_cre" style="display: none;" id="org-form-action-state"></div>
                                            <div class="align-right cre_sve" id="form-bttons">
                                                <input type="hidden" name="id_oz_code" id="id_oz_code" value="" />

                                                <button class="btn btn-success" type="button" onclick="saveSchedule();">Save</button>
                                                <button class="btn btn-default" type="button" onclick="cancelOrganization();">Cancel</button>
                                            </div>
                                        </div> 


                                        <div id="all_usr_org" class="hide dialog-content-page">
                                            <form role="form" id="form_org" class="form-horizontal ">
                                                <label>Please select user</label>
                                                <div class="ov_fl_230">
                                                    <ul class="user_list">

                                                        {foreach item=usr from=$users}
                                                            <li>
                                                                <div style="padding-left: 10px;"> 
                                                                    <div class="radio">
                                                                        <input type="checkbox" id="usr_org_{$usr->code}" value="{$usr->code}" class="org_usr_all" data-name="{$usr->name}"  name="usr_org_all">
                                                                        <lable for="usr_org_{$usr->code}">{$usr->name}</lable>
                                                                    </div>
                                                                </div> 
                                                            </li>
                                                        {/foreach}   
                                                    </ul>
                                                </div>

                                                <div class="clear_fix_both">      <br/>        
                                                    <div class="fl" id="all-form-loading"></div>
                                                    <div class="alert fl" style="display: none;" id="all-org-state"></div>
                                                    <div class="align-right" id="all-form-bttons">
                                                        <input type="hidden" name="aid_oz_code" id="aid_oz_code" value="" />
                                                        <input type="hidden" name="sel_oz_status" id="sel_oz_status" value="1" />

                                                        <button class="btn btn-success" type="button" onclick="saveUserOrganizatio();">Save</button>
                                                        <button class="btn btn-default" type="button" onclick="cancelUserOrganization();">Cancel</button>
                                                    </div>
                                                </div> 
                                            </form>
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
        $(document).ready(function () {
            $('#fdate').datepicker({
                todayHighlight: true,
                startDate: '-0m',
                format: 'yyyy-mm-dd'
            }).on('changeDate', function (e) {
                var fDate = new Date(e.date);
                var end = new Date(fDate.setDate(fDate.getDate() + 365));
                $('#tdate').datepicker('setStartDate', e.date);
                $("#tdate").datepicker("setEndDate", end)
            });
            $('#tdate').datepicker({
                todayHighlight: true,
                startDate: '-0m',
                format: 'yyyy-mm-dd',
                maxDate: "+365D",
            }).on('changeDate', function (e) {
                $('#fdate').datepicker('setEndDate', e.date)
            });
        });

        $('#device').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '200px',
            buttonClass: 'btn btn-default deviceMedium',
            dropLeft: true
        });
    </script>

