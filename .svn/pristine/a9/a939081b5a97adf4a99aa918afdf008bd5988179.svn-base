<form role="form" id="form1" class="form-horizontal ">
    <fieldset>
        <legend><span>Discount code details</span></legend>
        <div class="row sepH_b">
            <div class="col-sm-3">
                <label for="disc-grp" class="req">Category</label>
                <select id="disc-grp" name="disc-grp" class="form-control">
                    <option value="">Select Category</option>
                    {foreach name=o item=row from=$category}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach} 
                </select>
            </div>
            
            <div class="col-sm-3">
                <label for="txt_oz_name" class="req">Discount Code</label>
                <select id="coup-code" class="form-control coup-code">
                    <option value="">Select</option>
                    {foreach item=amt from=$coupon}
                        <option value="{$amt->code}">{$amt->coupon}</option>
                    {/foreach}
                </select>
            </div>
                
            <div class="col-sm-2">
                <label for="txt_l_name" class="req">Discount Value</label>
                <input  placeholder="Discount Value" id="disc_value" name="disc_value"  class="form-control" value=''>
            </div>
                
            <div class="col-sm-2">
                <label for="txt_l_name">&nbsp;</label>
                <input style="position:relative;top:5px" type="checkbox" id="disc_type" name="disc_type" checked /> 
                <span id="per" style="position:relative;top:5px">&nbsp;<b>%</b></span>
                <span id="rs" style="display:none;position:relative;top:5px">&nbsp;
                    <b><i class="fa fa-rupee"></i></b>
                </span>
            </div>
                
        </div>    
    </fieldset>  
    
    
    <!--<div class="col-lg-5 p_l_n">
        <div>
            <label for="txt_oz_name" class="req">Success Message</label>
            <input  placeholder="Message" id="succ-mess" name="succ-mess"  class="form-control">
        </div>
    </div>    
    <div class="clear_fix_both"></div>
    <br /> -->
    
    <fieldset>
        <legend><span>Criteria</span></legend>
        <div class="row sepH_b">
            
            <div class="col-sm-2">
                <label for="txt_m_name" class="req pull-left">User Group</label>                
                <select id="user_grp" class="form-control">
                    <option value="">All Group</option>
                    {foreach name=o item=row from=$group}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach} 
                </select>                
            </div>  

            <div class="col-sm-3">	    
                <label for="txt_oz_name" class="req">Active From & To</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="date_cop" id="date_cop" class="form-control" readonly="true" value="">
                </div>
            </div>
	  
            <div class="col-sm-2">
                <div>
                    <label for="txt_m_name">Day of Week</label>
                    <div class="btn-group btn-group-days" id="exp-weekdays" data-toggle="buttons">
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">S</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" value="1" name="station-point-weeks-comm">M</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">W</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">F</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">S</label>
                    </div> 
                </div>
            </div> 
                
            <div class="col-sm-2">                
                <label for="txt_m_name" >Max Usage Per User</label>
                <input  placeholder="Limit" id="usr_limit" name="usr_limit"  class="form-control">                
            </div> 
                
            <div class="col-sm-2">                
                <label for="txt_m_name" >Device Medium</label>
                <select id="deviceMedium" name="deviceMedium " class="form-control">
                    <option value="ALL">All Medium</option>
                    <option value="WEB">Website</option>
                    <option value="API">API</option>
                    <option value="MOB">Mobile Website</option> 
                    <option value="APP">Mobile APP</option>
                </select>                
            </div> 

        </div>
        
        <div class="row sepH_b">
            <div class="col-sm-2">                
                <label for="maxDiscountAmount" >Max Discount Amount</label>
                <select id="maxDiscountAmount" name="maxDiscountAmount"  class="form-control">
                    <option value="">No Limit</option>
                    <option value="25">25</option>
                    <option value="50">50</option>
                    <option value="75">75</option> 
                    <option value="100">100</option>
                    <option value="150">150</option>
                    <option value="200">200</option>
                    <option value="250">250</option>
                    <option value="300">300</option>
                    <option value="350">350</option>
                    <option value="400">400</option>
                    <option value="450">450</option>
                    <option value="500">500</option>
                </select>
            </div>
            <div class="col-sm-3">                
                <label for="minTicketFare" >Min Trans Amount</label>
                <input id="minTicketFare" name="minTicketFare" placeholder="Leave empty for any amount"   class="form-control">                
            </div>
            
            <div class="col-sm-2">                
                <label for="beforeBookingMinitues" >Time Before Booking</label>
                <div>
                    <div class="fl" style="width: 50px; margin-right: 10px">                    
                        <input id="beforeBookingMinitues" name="beforeBookingMinitues"  class="form-control fl">
                    </div>
                    <div class="fl">
                        <select id="beforeBookingMinituesOption" name="beforeBookingMinituesOption" class="form-control fl">
                            <option value="1">Minutes</option>
                            <option value="2">Hours</option>
                            <option value="3">Days</option>
                        </select>
                    </div>
                </div>
                <span class=" clear_fix_both help-block">Before 20 days of trip time</span>    
            </div>
            
            <div class="col-sm-2">                
                <label for="afterBookingMinitues" >Time After Booking</label>
                <div>
                    <div class="fl" style="width: 50px; margin-right: 10px">
                        <input id="afterBookingMinitues" name="afterBookingMinitues"  class="form-control">
                    </div>
                    <div class="fl">
                        <select id="afterBookingMinituesOption" name="afterBookingMinituesOption" class="form-control fl">
                            <option value="1">Minutes</option>
                            <option value="2">Hours</option>
                            <option value="3">Days</option>
                        </select>
                    </div>
                </div>
                <span class=" clear_fix_both help-block">Within 8 hours from trip time</span>  
            </div>
            
            <div class="col-sm-2">                
                <label for="minSeatCount" >Min Seat Count</label>                
                <select id="minSeatCount" name="minSeatCount" class="form-control">                  
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option> 
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
            </div>
        </div>        
    </fieldset>
    
    <fieldset>
        <legend><span>Routes & Schedules</span></legend>
        <div class="row sepH_b">
            
            <div class="col-sm-3">                
                <label for="txt_m_name" >Schedule(s)</label> 
                <select id="coup_schedule" multiple class="form-control coup_schedule ov_fl_height">
                    {foreach name=o item=row from=$schedules}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}   
                </select>
            </div>
                
            <div class="col-sm-3">
                <label for="txt_m_name">Route(s)</label>
                <select id="coup_route" multiple class="form-control coup_route ov_fl_height">
                    {foreach name=o item=row from=$route}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}   
                </select>
            </div>
                
            <div class="col-sm-2">
                <label>&nbsp;</label>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" id="round_trip" name="round_trip" > Round Trip Flag
                    </label>
                </div>                
            </div>

            <div class="col-sm-2">
                <label>&nbsp;</label>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" id="travel_date" name="travel_date" > Travel Date Flag
                    </label>
                </div>
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
		                   
	    <div class="clear_fix_both"></div>
	  <!--  <div id="category-dialog" class="hide dialog-content-page">
	        <div class="">
	            <form role="form" id="form1" class="form-horizontal ">
	                <div class="col-lg-5 p_l_n">
	                    <div>
	                        <label for="txt_oz_name" class="req">Name</label>
	                        <input  placeholder="Name" id="name" name="name"  class="form-control">
	                    </div>
	                </div>    
	                <div class="clear_fix_both"></div>
	                <br />  
	                <div class="col-lg-13 p_l_n">
	                    <div>
	                        <label for="txt_oz_name" class="req">Description</label>
	                        <textarea rows="8" placeholder="Description" id="desc" name="desc"  class="form-control rs_no"></textarea>
	                    </div>
	                </div>  
	            </form>
	        </div>
	        <div class="clear_fix_both"></div>
	        <br />
	        <div class="clear_fix_both"></div>
	        <div class="clear_fix_both">                       
	            <div class="alert fl suc_cre" style="display: none;" id="cat-form-action-state"></div>
	            <div class="align-right cre_sve" id="cat-form-bttons">
	                <input type="hidden" id="code">
	                <button class="btn btn-success" type="button" onclick="saveDiscountCategory();">Save</button>
	                <button class="btn btn-default" type="button" onclick="cancelDiscountCategory();">Cancel</button>
	            </div>
	        </div> -->
    					
<div id="discount-coupon-list-result"></div>

    <script>
        $(function () {

            $('select.coup_schedule,select.coup_route').select2({
                placeholder: "All Selected",
                escapeMarkup: function (markup) {
                    return markup;
                }
            });

            $('input[name="date_cop"]').daterangepicker({
                buttonClasses: ['btn', 'btn-sm'],
                format: 'YYYY-MM-DD',
                separator: ' | ',
                showDropdowns: true,
                showWeekNumbers: true,
            });

            $('.selectpicker').selectpicker();

        });

        function saveDiscount() {
            var data = {};
            data.coupon_code = $('#coup-code').val();
            data.disc_group = $('#disc-grp').val();
            //data.success = $('#succ-mess').val();
            data.name = $('#coup_name').val();
            data.schedule = $('#coup_schedule').val();
            var dateDisc =  $.trim( $('#date_cop').val() );
            var date = dateDisc.split('|');
            data.activeFrom = $.trim(date[0]);
            data.activeTo = $.trim(date[1]);
            data.dayOfWeek = $("input[name='station-point-weeks-comm']").map(function () {
                return +$(this).is(':checked');
            }).get();
            data.comm_value =  $.trim( $('#disc_value').val() );
            data.percentageFlag = $('#disc_type:checked').val() ? true : false;
            data.group = $('#user_grp').val();
            data.limit =  $.trim( $('#usr_limit').val() );
            data.route = $('#coup_route').val();
            data.round_trip = $('#round_trip:checked').val() ? true : false;
            data.travel_date = $('#travel_date:checked').val() ? true : false;
            
            data.maxDiscountAmount = $.trim( $('#maxDiscountAmount').val() );
            data.minTicketFare =  $.trim( $('#minTicketFare').val() );
            data.afterBookingMinitues =  $.trim( $('#afterBookingMinitues').val() );
            data.beforeBookingMinitues =  $.trim( $('#beforeBookingMinitues').val() );
            data.deviceMedium =  $.trim( $('#deviceMedium').val() );
            
            
            data.afterBookingMinituesOption =  $.trim( $('#afterBookingMinituesOption').val() );
            data.beforeBookingMinituesOption =  $.trim( $('#beforeBookingMinituesOption').val() );
            
            data.minSeatCount =  $.trim( $('#minSeatCount').val() );
            data.critriaId =  $('#hid-critria-id').val();
            

            var err = 0;
            if ($('#coup-code').val() == '' || $('#coup-code').val() == null) {
                $('#coup-code').addClass('inp_error');
                err++;
            } else {
                $('#coup-code').removeClass('inp_error');
            }

            if ($('#disc-grp').val() == '') {
                $('#disc-grp').addClass('inp_error');
                err++;
            } else {
                $('#disc-grp').removeClass('inp_error');
            }

            /*if ($('#succ-mess').val() == '') {
                $('#succ-mess').addClass('inp_error');
                err++;
            } else {
                $('#succ-mess').removeClass('inp_error');
            }*/

            if ($('#coup_name').val() == '') {
                $('#coup_name').addClass('inp_error');
                err++;
            } else {
                $('#coup_name').removeClass('inp_error');
            }

            /*if ($('#user_grp').val() == '') {
                $('#user_grp').addClass('inp_error');
                err++;
            } else {
                $('#user_grp').removeClass('inp_error');
            }*/

            if ($('#date_cop').val() == '') {
                $('#date_cop').addClass('inp_error');
                err++;
            } else {
                $('#date_cop').removeClass('inp_error');
            }
            if ($('#disc_value').val() == '') {
                $('#disc_value').addClass('inp_error');
                err++;
            } else {
                $('#disc_value').removeClass('inp_error');
            }

            /*if ($('#usr_limit').val() == '') {
                $('#usr_limit').addClass('inp_error');
                err++;
            } else {
                $('#usr_limit').removeClass('inp_error');
            }*/


            if (err > 0) {
                $('#cop-form-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#cop-form-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#cop-form-action-state').show();
                return false;
            } else {
                $('#cop-form-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#cop-form-action-state').hide();
            }

            $('#cop-form-buttons').hide();
            $('#cop-form-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#cop-form-action-state').html(loading_popup);
            $('#cop-form-action-state').show();

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/update-discount-criteria",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#cop-form-bttons').hide();
                        $('#cop-form-action-state').removeClass('alert-danger');
                        $('#cop-form-action-state').addClass('alert-success');
                        $('#cop-form-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                           // checkURL();
                           // return;
                           $('#add-criteria').trigger('click');
                        }, 3000);
                    } else {
                        $('#cop-form-action-state').addClass('alert-danger');
                        $('#cop-form-action-state').html(response.errorDesc);
                        $('#cop-form-buttons').show();
                    }
                }
            })
        }


        $('#disc_type').change(function () {
            if (this.checked) {
                $('#per').show();
                $('#rs').hide();
            }
            else {
                $('#per').hide();
                $('#rs').show();
            }
        });

    </script>