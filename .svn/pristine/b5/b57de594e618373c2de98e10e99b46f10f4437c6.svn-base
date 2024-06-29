<div class="brand_top">
    <h3>Discount Coupon</h3>
</div>
<div id="main_wrapper" class="get_transactions">
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
                                    
                                        <!-- Nav tabs -->
                                        <ul class="nav nav-tabs nav-coupon" role="tablist">
                                            <li class="active ">
                                                <a href="#viw_coupons" role="tab" data-toggle="tab">
                                                    View Coupons
                                                </a>
                                            </li>
                                            <!--<li ><a href="#add_criteria" id="add-criteria" role="tab" data-toggle="tab">
                                                    Add Criteria
                                                </a>
                                            </li> -->
                                            <li >
                                                <a href="#cate" role="tab" data-toggle="tab"  id="add-cate">
                                                    </i> Category
                                                </a>
                                            </li>
                                            <li >
                                                <a href="#disc_coupon" role="tab" data-toggle="tab"  id="disc-coupon">
                                                    Coupons
                                                </a>
                                            </li>
                                        </ul>

                                        <!-- Tab panes -->
                                        <div class="tab-content coupon-content">
                                            <div class="tab-pane fade active in" id="viw_coupons">
                                                <div class="panel-body">
                                                    <form role="form" id="form1" class="form-horizontal ">
                                                        <div class="row">
                                                            <div class="col-md-2">
                                                                <div>                                                                    
                                                                    <select id="disc-coup-code" class="form-control disc-coup-code ov_fl_height">
                                                                        <option value="">Select a coupon</option>
                                                                        {foreach item=amt from=$coupon}
                                                                            <option value="{$amt->code}">{$amt->coupon}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div> 
                                                            <div class="col-md-4">                                                                
                                                                <button class="btn btn-success" type="button" onclick="getdiscountreport()">View Discount</button>
                                                                <button class="btn btn-success" type="button" onclick="addCriteria()">Add Criteria</button>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="alert suc_cre" style="display: none;" id="coup-form-action-state"></div>
                                                            </div>
                                                        </div>          
                                                    </form>
                                                              
                                                </div><!--panel Body end-->
                                                
                                                <div class="panel-body">
                                                    <div id="disc-coupon-rpt-list"></div>                                    
                                                </div>

                                            </div>
                                            <!--<div class="tab-pane fade" id="add_criteria">
                                                <div class="panel-body">
                                                    <div id="disc-criteria"></div>                                    
                                                </div>
                                            </div> -->
                                            <div class="tab-pane fade" id="cate">
                                                <div class="panel-body">
                                                    <div id="disc-cate"></div>                                    
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="disc_coupon">
                                                <div class="panel-body">
                                                    <div id="disc-coupons"></div>                                    
                                                </div>
                                            </div>
                                        </div>

                                    
                                </div><!-- panel body end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- container- fluid end-->
    </div>
</div> <!-- main wrapper end-->
<div id="discount-categories-result"></div>  
<div id="discounts-result"></div>   
<div id="discount-coupon-details-result"></div>

<div id="disc-criteria" style="display: none;">
    <form role="form" id="form1" class="form-horizontal ">
        <fieldset>
            <div class="row sepH_b">
                <div class="col-sm-3">
                    <label for="txt_oz_name" class="req">Discount Coupon</label>
                    <select id="coup-code" class="form-control coup-code">
                        <option value="">Select</option>
                        {foreach item=amt from=$coupon}
                            <option value="{$amt->code}">{$amt->coupon}</option>
                        {/foreach}
                    </select>
                </div>
                    
                <div class="col-sm-3">
                    <label for="txt_l_name" class="req">Discount Value</label>
                    <div class="input-group d-flex" style="flex-wrap: nowrap;">
                        <input  placeholder="Discount Value" id="disc_value" name="disc_value"  class="form-control" value=''>
                        <select name="disc_type" id="disc_type" class="input-group-addon" style="width: 30%;">
                            <option value="1">%</option>
                            <option value="0">INR</option>
                        </select>
                    </div>
                </div>

                <div class="col-sm-3">	    
                    <label for="txt_oz_name" class="req">Active From & To</label>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        <input type="text" name="date_cop" id="date_cop" class="form-control" readonly="true" value="">
                    </div>
                </div>
                
                <div class="col-sm-3">
                    <div>
                        <label for="txt_m_name">Day of Week</label>
                        <div class="btn-group btn-group-days" id="exp-weekdays"  data-toggle="buttons">
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" name="discount-weekdays" value="1">S</label>
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" value="1" name="discount-weekdays">M</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="discount-weekdays" value="1">T</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="discount-weekdays" value="1">W</label>
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" name="discount-weekdays" value="1">T</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="discount-weekdays" value="1">F</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="discount-weekdays" value="1">S</label>
                        </div> 
                    </div>
                </div> 
            </div>    
        </fieldset>

        <fieldset>
            <div class="row sepH_b">
                <div class="col-sm-3">
                    <label class="req">Branch</label>                
                    <select id="discount_branch" class="form-control" multiple="true">     
                        {foreach name=o item=row from=$organizations}
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach} 
                    </select>                
                </div>

                <div class="col-sm-2">                
                    <label for="maxDiscountAmount" class="req">Max Discount Amount</label>
                    <input id="maxDiscountAmount" name="maxDiscountAmount" placeholder="Max Discount Amount"   class="form-control">                
                </div>

                <div class="col-sm-2">                
                    <label for="minFreightAmount" class="req">Min Trans Amount</label>
                    <input id="minFreightAmount" name="minFreightAmount" placeholder="Min Trans Amount"   class="form-control">                
                </div>

                <div class="col-sm-2">                
                    <label for="paymentTypes" class="req">Payment Type</label>
                    <select id="paymentTypes" name="paymentTypes"  class="form-control" multiple="true">
                        {foreach from=$payment_type item=item key=key}
                            <option value="{$key}">{$item}</option>
                        {/foreach}
                    </select>
                </div>
            </div>      
        </fieldset>
        <input type="hidden" id="hid-critria-id" />
        <br>
        <div class="alert fl suc_cre" style="display: none;" id="cop-form-action-state"></div>
        <div class="pull-right" id="cop-form-buttons">
            <button class="btn btn-success" type="button" onclick="saveDiscount()">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelDiscount()">Cancel</button>
        </div>
    </form>
</div>
                
<script>
    $(function () {
        $('input[name="date_cop"]').daterangepicker({
            buttonClasses: ['btn', 'btn-sm'],
            format: 'YYYY-MM-DD',
            separator: ' | ',
            showDropdowns: true,
            showWeekNumbers: true,
        });

        $('.selectpicker').selectpicker();
        
        $('#discount_branch').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '100%',
            buttonClass: 'btn btn-default discount_branch',
            dropLeft: true
        });
        $('#paymentTypes').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '100%',
            buttonClass: 'btn btn-default paymentTypes',
            dropLeft: true
        });
    });
</script>

