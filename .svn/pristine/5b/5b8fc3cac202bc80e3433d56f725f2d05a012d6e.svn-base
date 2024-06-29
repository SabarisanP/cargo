<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12" id="vche">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">
                                        <div>
                                            <div id="search-panel">                                         
                                                <div class="divide-10"></div>
                                                <form>
                                                    <div class="row">
												      <div class="form-group col-md-2">
                                                        <div class="input-group col-xs-12">
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
                                                        </div>
                                                   	 </div>
                                                       
                                                    <div class="form-group col-md-2">
                                                        <label class="sr-only" for="date_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="date_from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group col-md-2">
                                                        <label class="sr-only" for="date_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="date_to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                               </div>
                                                       
                                               <div class="row">
                                                     <div class="form-group col-md-2">
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_schedule" name="schedule_code"  class="form-control" >
                                                                    <option value='NA' selected="">All Schedules</option>
                                                                    {foreach item=schedule from=$active_schedules}
                                                                        <option value="{$schedule.code}">{$schedule.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                   
                                                    <div class="form-group col-md-2">
                                                    <div class="vou_radio " style="margin-top:10px">
	                                                    <div class="radio-inline">
	                                                        <label>
	                                                            <input type="radio" class='flag' name="voucher_flag" value="booked"  checked>
	                                                            <span style="font-weight:lighter">Booked Date</span>
	                                                        </label>
	                                                    </div>
	                                                    <div class="radio-inline">
	                                                        <label>
	                                                            <input type="radio" class='vchr_trvldate' name="voucher_flag" value="travel" >
	                                                            <span style="font-weight:lighter">Travel Date</span>
	                                                        </label>
	                                                    </div>
	                                                </div> 
                                                </div> 
                                                <div class="form-group col-md-2"> 
                                                    <button class="btn btn-success vou_click" type="button" onclick="searchVoucher();">Generate</button>&nbsp;&nbsp;
                                                    <button type="button" class="btn btn-default btn-clear" onclick="clearVoucher();">Clear</button>
                                                 </div>
                                             </div>
                                         </form>
                                                
                                         <div class="align-center alert alert-danger pull-left" class='vou_error' id="usr-action-state"></div>
                                         </div>
                                         <div class="clear_fix_both"></div>
                                         
                                            <div id="voucher-dialog" class="hide dialog-content-page">
                                                <div class="ov_fl_262">
                                                    <form role="form" id="form1" class="form-horizontal ">
                                                        <div class="col-lg-6 p_l_n">
                                                            <label for="txt_l_name">Voucher Handled By</label>
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

                                                        <div class="col-lg-6 p_l_n">
                                                            <label for="txt_l_name" class="req">Amount Received Date</label>
                                                            <div class="input-group">
                                                                <input  placeholder="Date Received" id="ARdate" name="ARdate"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div> 
                                                        </div>
                                                        <div class="col-lg-6 p_l_n">
                                                            <div>
                                                                <label for="txt_m_name" class="req">Voucher To</label>
                                                                <select id="gru_users" class="form-control" name='gru_users'>
                                                               		 <option value="">Select User</option>
		                                                                {foreach name=o item=row from=$entity}
		                                                                    <optgroup label="{$row['groupname']}">
		                                                                        {foreach name=o item=usr from=$row["users"]}
		                                                                            <option value='{$usr['code']}'>{$usr['name']}</option>
		                                                                        {/foreach}
		                                                                    </optgroup>
		                                                                {/foreach}
                                                           		</select>
                                                              
                                                            </div>
                                                        </div>

                                                        <div class="clear_fix_both"></div>
                                                        <br />    

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
	                                                        <button class="btn btn-default" type="button" onclick="cancelVoucher();">Cancel</button>
	                                                    </div>
	                                                </div> 
                                            </div>                        
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div></div></div>
    </div>
<input type="hidden" value="{$usr['code']}"/>
    <div id="rpt_lst_voucher"></div> 
    <div id="view_voucher"></div>         

    <script>
        $(document).ready(function() {
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
            }).on('changeDate', function(e) {
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
            }).on('changeDate', function(e) {
                $('#date_from').datepicker('setEndDate', e.date)
            });
        });

 
        function searchVoucher() {
            $('#rpt_lst_voucher').html('');
            var data = {};
            data.user = $('#users').val();
         	data.schedule_code = $('#trns_rpt_schedule').val();
            data.from = $('#date_from').val();
            data.to = $('#date_to').val();
            data.flag = $('input[name=voucher_flag]:checked').val();
            var err = 0;
           $('#users' , '#trns_rpt_schedule, #date_from, #date_to').removeClass('inp_error');
          
		  if (data.schedule_code  == '') {
                $('#trns_rpt_schedule').addClass('inp_error');
                err++;
            } else {
                $('#trns_rpt_schedule').removeClass('inp_error');
            }
            
            if (data.from == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }

            if (data.from == '') {
                if (data.to == '') {
                    $('#date_to').addClass('inp_error');
                    err++;

                } else {
                    $('#date_to').removeClass('inp_error');
                }
            }

            if (data.from != '') {
                if (data.to == '') {
                    $('#date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to = output;
                    $('#date_to').val(output);
                }
            }

            if (err > 0) {
                $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#usr-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#usr-action-state').show();
                return false;
            } else {
                $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#usr-action-state').html('');
                $('#usr-action-state').hide();
            }
            var html = "";
            $('#date_to').removeClass('inp_error');
            $('#rpt_lst_voucher').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "voucher/new-voucher-list",
                data: data,
                success: function(response) {
                    $('#rpt_lst_voucher').html(response);
                }
            })
        }

        function clearVoucher() {
            $('#users').val('');
            $('#date_from').val('');
            $('#date_to').val('');
 			$('#trns_rpt_schedule').val('NA');
            $('#rpt_lst_voucher').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
            $('input:radio[class=flag]').prop('checked', true);
        }

        function VoucherPopup() {

            $('#t_mode').val('');
            $('#ARdate').val('');
            $('#reg_textarea').val('');
            $('#user').val('');
            $('.inp_error').removeClass('inp_error');
            $('#vou-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vou-action-state').hide();
            $('#voucher-dialog').css('background', '#fff');
            $('#voucher-dialog').removeClass('hide');
            $('#voucher-dialog').dialog({
                autoOpen: true,
                height: 430,
                width: 700,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });
            $(".ui-dialog-titlebar").hide();

            $('#form-bttons').show();
            $('#org-form-action-state').html('');
            $('#org-form-action-state').hide();
            $('.inp_error').removeClass('inp_error');

        }
        function cancelVoucher() {
            $('#voucher-dialog').dialog('destroy');
            $('#voucher-dialog').hide();

        }
    
       

 </script>

