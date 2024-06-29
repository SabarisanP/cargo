<div class="row">
    <div class="col-md-6">
        <h5>Dynamic Pricing Configration</h5>
    </div>
    <div class="col-md-6 text-right">        
        <button class="btn btn-success" type="button" onclick="historyScheduleDynamicPricing()">History</button>&nbsp;
        <button class="btn btn-success" type="button" onclick="exceptionScheduleDynamicPricing()">Add Exception</button>&nbsp;
        <button class="btn btn-success" type="button" onclick="disableScheduleDynamicPricing()">Disable</button>&nbsp;
        <button class="btn btn-danger" type="button" onclick="deleteScheduleDynamicPricing()">Delete</button>
    </div>    
</div>


<br>

<div class="row">
    <div class="col-md-6" style="border-right:1px solid #ccc;" >
        <form role="form" id="form" class="form-horizontal ">
            <div class="row">        
                <div class="col-md-6">
                    <div>
                        <label for="txt_oz_name" class="req">Active From & To</label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            <input type="text" name="date_dp" id="date_dp" class="form-control" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                        </div>
                    </div>
                </div>  
                <div class="col-md-6">
                    <div>
                        <label for="txt_m_name" class="req">Day of Week</label>
                        <div class="btn-group btn-group-days" id="dp-weekdays" data-toggle="buttons">
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" name="dp-weeks" value="1">S</label>
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" name="dp-weeks" value="1" >M</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="dp-weeks" value="1">T</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="dp-weeks" value="1">W</label>
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" name="dp-weeks" value="1">T</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="dp-weeks" value="1">F</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="dp-weeks" value="1">S</label>
                        </div> 
                    </div>
                </div>
            </div>

            <br>

            <div class="row">
                <div class="col-md-12">

                    <table class="table info_table table-hover"  width="60%">
                        <thead>
                            <tr>
                                <td class="bold">Route</td>
                                <td><span class="bold">Min Fare</span> <br><span class="text-muted">must be greater then 200</span></td>
                                <td><span class="bold">Max Fare</span> <br><span class="text-muted">must be less then 5000</span></td>
                            </tr>
                        </thead>
                        <tbody>
                        {foreach from=$routes item=row}
                            <tr class="farerow">           
                                <td valign="middle" nowrap>{$row['fromName']} - {$row['toName']}</td>
                                <td>
                                    <input type="hidden" id="fromcode" value="{$row['fromCode']}" /> 
                                    <input type="hidden" id="tocode" value="{$row['toCode']}" />

                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-rupee"> </i></span>
                                        <input type="input" class='form-control minfare' maxlength="4" style="width:50px"  value="0" />                    
                                    </div>
                                </td>
                                <td>
                                     <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-rupee"> </i></span>
                                        <input type="input" class='form-control maxfare' maxlength="4" style="width:50px"  value="0" />                    
                                    </div>
                                </td>
                            </tr>
                        {/foreach}     
                        </tbody>
                    </table>  

                    <div class="row">
                        <div class="col-md-12">                       
                            <div class="alert suc_cre" id="disc-form-action-state"></div>
                            <div class="text-center" id="disc-form-buttons">
                                
                                <button class="btn btn-success" type="button" onclick="saveScheduleDynamicPricing();">Save</button>                    
                            </div>
                        </div> 
                    </div> 

                </div> 
            </div>      
        </form>


    </div>

    <div class="col-md-6">
        <div class="row">
            <div class="col-lg-6">
                <a href=""> <i class="fa fa-plus"></i> Add Exceptoin</a>
            </div>
        </div>  
    </div>
</div>  

    
    
<!-- Exception Popup --> 


<div id="exception-dialog" class="dialog-content-page" style="display: none">
    <form role="form" id="basic-sch" class="form-horizontal">
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class="req col-md-3" for="basic_except_description">Name</label>
            <div class="col-md-9">
                <input type="text" value="" id="exp_disc_name" name="exp_disc_name" class="form-control">
            </div>
        </div>
        <div class="clear_fix_both"></div>
<br>
        <div class="form-group">
            <label  class="req col-md-3" for="exp-weekdays" class="req">Day of week</label>
            <div class="col-md-5">
                <div class="btn-group btn-group-days" id="exp-disc-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">S</label>
                </div> 
            </div>
        </div>   
        <div class="clear_fix_both"></div>
<br>
        <div class="clear_fix_both"></div>
        <div class="form-group">
            <label class="col-md-3 req" for="basic_except" class="req">Date</label>
            <div class="col-md-9"> 
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="exp_disc_date" id="exp_disc_date" class="form-control" readonly="true" value="">
                </div>
            </div>
        </div>


        <div class="clear_fix_both"></div><br />
        <input type="hidden" id="exp_code">
        <div class="alert fl suc_cre" style="display: none;" id="exp-form-action-state"></div>
        <div class="pull-right" id="exp-form-buttons">
            <button class="btn btn-success" type="button" onclick="saveDiscountException()">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelExceptionDialog();">Cancel</button>
        </div>
    </form>
</div>
<script>
    $('input[name="date_dp"],input[name="fao-exp_disc_date"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
</script>
