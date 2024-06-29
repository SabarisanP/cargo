<div class="brand_top">
    <h3>Trip Statement</h3> 
    <div class="text-right noprint" id="exc-tr" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportEntries()"><i class="fa fa-download fa-lg"></i>Excel</button>            
        </div>
    </div> 
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12"> <br>
                <!-- PAGE HEADER-->
                <div class="row">                        
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-12">                                        
                                    <div class="">
                                        <div id="search-panel">    
                                            <form id='mytrans_form' name="trans_form" method="post"  onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-2">
                                                        <label for="tsr_travel_date">Travel Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="travel_date" class="form-control sdate" id="tsr_travel_date" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label  for="tsr_trip_code">Trips</label>
                                                        <div class="input-group col-md-12" id="tsr_trip_cintainer">
                                                            <select id="tsr_trip_code" name="trip_code"  class="form-control" >
                                                                <option value='' selected="">Select a trip</option>
                                                                {foreach item=schedule from=$active_schedules}
                                                                    <option value="{$schedule.code}">{$schedule.name}</option>
                                                                {/foreach}
                                                            </select>       
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="cons_rpt_date_to">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateExpenses()">View Entries</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearExpensesList()">Clear</button>
                                                        </div>
                                                    </div>        
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="texp_action_state"></div>
                                                </div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="expenses-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="expenses-list"></div>                                    
                            </div>
                        </div>
                    </div>
                </div>

            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe> 

<div id="expenses-dialog"  class="dialog-content-page hide">

    <div style="padding:15px;">
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label class="req" for="seat-sch-date">Head</label>
                    <select id="texp-head" class="form-control">
                        <option value="">Select</option>
                        {foreach item=row from=$triphead} 
                            {if $row->name!=''}
                                <option value="{$row->code}">{$row->name}</option>
                            {/if}
                        {/foreach} 
                    </select>
                </div>
            </div> 
                        
            <div class="col-lg-4">
                <div class="form-group">
                    <label class="req" for="seat-sch-date">Transaction Mode</label>
                    <select id="texp-mode" class="form-control">
                        <option value="">Select</option>
                        {foreach name=o item=row from=$t_mode}
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach} 
                    </select>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label class="req">Amount</label>
                    <input  placeholder="Amount" id="texp-amount" name="amount"  class="form-control">                    
                </div>
            </div>
        </div>

        <div class="row">        
            <div class="col-lg-8"> 
                <label>Remarks</label>
                <textarea id="texp-remarks"  placeholder="Enter your remarks" style="resize:none" class="form-control" rows="3" cols="30" name="remark" id="remark"></textarea>
            </div>                                 
        </div>

        <div class="row">
            <input type="hidden" id="texp-code" value="">
            <div class="clear_fix_both">                       
                <div class="alert" style="display: none;" id="texp-action-state"></div>
                <div class="align-right" id="aspe-form-buttons">                    
                    <button class="btn btn-success" type="button" onclick="saveTripExpenses();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeEntriesDialog();">Cancel</button>
                </div>
            </div> 
        </div>

    </div>            
</div>

<script>
    function _init_expenses_page() {
        init_expenses_page();
    }
</script>