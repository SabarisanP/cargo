<div class="brand_top">
    <h3>Voucher</h3>
    <span class="align-right">
        
        {if $action_rights['VOU-GENERATE']>0}
        <a href="javascript:;" id='generate' onclick="newVouchers();" class="btn btn-success  btn-sm">Generate</a>
        {/if}
        
        <a href="javascript:;" id='back' onclick="generatedVouchers();" style='display:none' onclick="generatedVouchers();" class="btn btn-default  btn-sm">Back</a>
        
        {if $action_rights['VOU-UNPAID-TRANS']>0}
        <a href="javascript:;" id='unpid' onclick="viewUnpaid();" class="btn btn-success  btn-sm">Unpaid Trans</a>
        {/if}
        
    </span>
</div>


<div id="main_wrapper" class="voucher_transaction_details">
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
                                    <div class="col-md-12">
                                        <div id="search-panel-result">                                         
                                            <div class="divide-10"></div>
                                            <form id='test' target="_blank" name="frm_voucher" method="get">
                                                {if $action_rights['VOU-USR-FILTER']>0}
                                                <div class="form-group col-md-2">                                                    
                                                    <select id="gru_users" name="user" class="form-control" name='users'>
                                                        <option value="NA">All Users</option>
                                                        {foreach name=o item=row from=$entity}
                                                            <optgroup label="{$row['groupname']}">
                                                                {foreach name=o item=usr from=$row["users"]}
                                                                    <option value='{$usr['code']}'>{$usr['name']}</option>
                                                                {/foreach}
                                                            </optgroup>
                                                        {/foreach}
                                                    </select>                                                   
                                                </div>
                                                {else}
                                                    <input type="hidden" value="{$logged_in_user}" id="gru_users" />  
                                                {/if} 
                                                    
                                                <div class="form-group col-md-2">
                                                    <label class="sr-only" for="date_from">From Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="from" class="form-control sdate" id="date_fromdate" readonly="true" placeholder="Date From">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label class="sr-only" for="date_to">To Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="to" class="form-control sdate" id="date_todate" readonly="true" placeholder="Date To">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">                                                                
                                                    <select id="voucher-ack-status" class="form-control" name='acknowledmentStatus'>
                                                        <option value="NA">All Acknowledment Status</option>
                                                        {foreach name=o key=k item=name from=$f_a_status}
                                                            <option value="{$k}">{$name}</option>
                                                        {/foreach} 
                                                    </select>                                                                
                                                </div>
                                                <button class="btn btn-success" type="button" onclick="searchTransactionDetails();">View Vouchers</button>
                                                <button type="button" class="btn btn-default btn-clear" id="download-pdf" style="display: none;" onclick="exportTransactionsPdf();"> Download PDF </button>
                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTransactionDetails();">Clear</button>
                                            </form>
                                            <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usrv-action-state"></div>
                                        </div><!--row end-->

                                    </div><!--search-panel-result end-->
                                </div>
                            </div><!--panel-default end-->
                        </div>
                    </div> 
                    
                    <div class="row hidden" id="vouchers-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="gen_voucher_list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                                                    
                   
                    
                </div>
            </div>
            
             
        </div>
    </div>
</div>
                                                

<div id="main_wrapper" class="get_transactions">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12" id="gen" style="display:none">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">

                                        <!--<div id="info">
                                            <div class="well well-sm">
                                                Please click on "View Voucher" button.  if you want view already generated voucher.
                                                <br>
                                                Pleae click "Generate" button, if you want to generate new voucher.
                                            </div>
                                        </div>-->

                                        <div id="search-panel" style="display: none;">                                         
                                            <div class="divide-10"></div>
                                            <form>
                                                <div class="row">

                                                    <div class="form-group col-md-2">                                                        
                                                        <div class="input-group">
                                                            <input type="text" name="date_from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">                                                       
                                                        <div class="input-group">
                                                            <input type="text" name="date_to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">   
                                                        {if $action_rights['VOU-USR-FILTER']>0}
                                                        <select id="users" class="form-control" name='users'>
                                                            <option value="">Select User</option>
                                                            {foreach name=o item=row from=$entity}
                                                                <optgroup label="{$row['groupname']}">
                                                                    {foreach name=o item=usr from=$row["users"]}
                                                                        <option value='{$usr['code']}'>{$usr['name']}</option>
                                                                    {/foreach}
                                                                </optgroup>
                                                            {/foreach}
                                                        </select>
                                                        {else}
                                                            <input type="hidden" value="{$logged_in_user}" id="users" />  
                                                        {/if}    
                                                    </div>

                                                </div>


                                                <div class="row">
                                                    <div class="form-group col-md-2">                                                        
                                                        <select id="trns_rpt_schedule" name="schedule_code"  class="form-control" >
                                                            <option value='' selected="">All Schedules</option>
                                                            {foreach item=schedule from=$active_schedules}
                                                                <option value="{$schedule.code}">{$schedule.name}</option>
                                                            {/foreach}
                                                        </select>                                                               
                                                    </div>

                                                    <div class="form-group col-md-2">                                                       
                                                        <div class="input-group col-md-12">
                                                            <select id="date_opt" name="date_option"  class="form-control" >
                                                                {if $action_rights['VOU-TRAVEL-DATE']>0}
                                                                <option value="1">Travel Date</option>
                                                                {/if}
                                                                <option value="0">Transaction Date</option>                                                                
                                                            </select>       
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4"> 
                                                        <button class="btn btn-success vou_click" type="button" onclick="searchTransactions();">Get Transactions</button>&nbsp;&nbsp;
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearVoucher();">Clear</button>
                                                    </div>
                                                </div>
                                            </form>

                                            <div class="align-center alert alert-danger pull-left" class='vou_error' id="usr-action-state"></div>
                                        </div>

                                    </div>
                                </div>  <!--panel-body end-->
                            </div>  <!-- panel-default end-->
                        </div>
                    </div>   <!-- row end-->

                    <div class="row hidden" id="voucher-feed-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="rpt_lst_voucher"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div><!-- main wrapper end-->


<div id="main_wrapper" class="unpaid_transactions">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12" id="gen">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">

                                        <div id="search-panel">                                         
                                            <div class="divide-10"></div>
                                            <form>
                                                <div class="row">

                                                    <div class="form-group col-md-2">                                                        
                                                        <div class="input-group">
                                                            <input type="text" name="un_date_from" class="form-control sdate" id="un_date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">                                                       
                                                        <div class="input-group">
                                                            <input type="text" name="un_date_to" class="form-control sdate" id="un_date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">   
                                                        {if $action_rights['VOU-USR-FILTER']>0}
                                                        <select id="un_users" class="form-control" name='users'>
                                                            <option value="NA">All Users</option>
                                                            {foreach name=o item=row from=$entity}
                                                                <optgroup label="{$row['groupname']}">
                                                                    {foreach name=o item=usr from=$row["users"]}
                                                                        <option value='{$usr['code']}'>{$usr['name']}</option>
                                                                    {/foreach}
                                                                </optgroup>
                                                            {/foreach}
                                                        </select>
                                                        {else}
                                                            <input type="hidden" value="{$logged_in_user}" id="un_users" />  
                                                        {/if}    
                                                    </div>

                                                </div>


                                                <div class="row">
                                                    <div class="form-group col-md-2">                                                        
                                                        <select id="un_trns_rpt_schedule" name="un_schedule_code"  class="form-control" >
                                                            <option value='' selected="">All Schedules</option>
                                                            {foreach item=schedule from=$active_schedules}
                                                                <option value="{$schedule.code}">{$schedule.name}</option>
                                                            {/foreach}
                                                        </select>                                                               
                                                    </div>

                                                    <div class="form-group col-md-2">                                                       
                                                        <div class="input-group col-md-12">
                                                            <select id="un_date_opt" name="un_date_option"  class="form-control" >
                                                                {if $action_rights['VOU-TRAVEL-DATE']>0}
                                                                <option value="1">Travel Date</option>
                                                                {/if}
                                                                <option value="0">Transaction Date</option>                                                                
                                                            </select>       
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4"> 
                                                        <button class="btn btn-success vou_click" type="button" onclick="searchUnpaidTransactions();">Get Unpaid Trans</button>&nbsp;&nbsp;
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearUnpaid();">Clear</button>
                                                    </div>
                                                </div>
                                            </form>

                                            <div class="align-center alert alert-danger pull-left" style="display: none;" class='un_vou_error' id="un-action-state"></div>
                                        </div>

                                    </div>
                                </div>  <!--panel-body end-->
                            </div>  <!-- panel-default end-->
                        </div>
                    </div>   <!-- row end-->

                    <div class="row hidden" id="unpaid-trans-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="unpaid-trans-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<input type="hidden" id="hid-user" value=""/>
<input type="hidden" id="hid-total" value=""/>
<div id="search-panel-result"></div>

<div id="voucher-dialog" class="hide dialog-content-page">
    <div class="ov_fl_2621">
        <form role="form" id="form1" class="form-horizontal ">
            <div class="col-lg-6 p_l_n">
                <label for="txt_l_name">Voucher By</label>
                <label for="txt_l_name"><span style='font-weight:lighter'>{$username}</span></label>
            </div>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="req">Transaction Mode</label>
                    <select id="t_mode" class="form-control col-md-6">
                        <option value="">Select</option>
                        {foreach name=o item=row from=$t_mode}
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach} 
                    </select>
                </div>
            </div>

            <div class="clear_fix_both"></div>
            <br />
            {if $action_rights['VOU-TODAY-PAY-DATE']>0}
                <input type="hidden" id="ARdate" name="ARdate" value="{$smarty.now}">
            {else}  
            <div class="col-lg-6 p_l_n">
                <label for="txt_l_name" class="req">Payment Date</label>
                <div class="input-group">
                    <input  placeholder="Payment Date"  id="ARdate" name="ARdate"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div> 
            </div>
            {/if}
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="txt_m_name">Remarks</label>
                    <textarea id="reg_textarea"  placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" id="remark"></textarea>
                </div>
            </div>

            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class='fr amt_vce'><br> <b>Payable Amount :</b> <i class="fa fa-inr"></i>&nbsp; <span id="popup_amt" class='vou_btn'>0</span></div>                
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="vou-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="confirmVoucher();">Confirm Pay</button>
            <button class="btn btn-default" type="button" onclick="closeVoucherPopup();">Cancel</button>
        </div>
        
        <div class="align-center hide clear_fix_both" id="print-info">
            <br>
            Do you want to print this voucher &nbsp;
            <a class="btn btn-success" target="_blank" id="print-button" href="">Yes</a> &nbsp; &nbsp; &nbsp;
            <button class="btn btn-default" type="button" onclick="closeVoucherPopup(); generatedVouchers();">No</button>
        </div>
        
    </div> 
</div>   

<script>

    $('#usr-action-state').hide();
    
    $('#ARdate').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        autoclose: true
    });    
    
    $('#date_from').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        autoclose: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#date_to').datepicker('setStartDate', e.date);
        $("#date_to").datepicker("setEndDate", end)
    });
    $('#date_to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
        $('#date_from').datepicker('setEndDate', e.date)
    });

    $('#date_fromdate').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        autoclose: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#date_todate').datepicker('setStartDate', e.date);
        $("#date_todate").datepicker("setEndDate", end)
    });
    $('#date_todate').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
        $('#date_fromdate').datepicker('setEndDate', e.date)
    });
    
    $('#un_date_from').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        autoclose: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#un_date_to').datepicker('setStartDate', e.date);
        $("#un_date_to").datepicker("setEndDate", end)
    });
    $('#un_date_to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
        $('#un_date_from').datepicker('setEndDate', e.date)
    });

</script>

