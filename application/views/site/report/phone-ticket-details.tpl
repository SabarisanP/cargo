<div class="brand_top">
    <h3>Phone Booking Report</h3> 
    <div class="text-right noprint" id="phone-ticket-export" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportPhoneTicket()"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>
</div>

<div id="main_wrapper">
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
                                                <form id='phone_ticket_form' name="phone_ticket_form" action=report/phone-ticket-details-list" method="post" onsubmit="return false;">
                                                    <div class="row">   
                                                        <div class="form-group col-md-2">
                                                            <label for="phone-ticket-from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from" class="form-control sdate" id="phone-ticket-from" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="phone-ticket-to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to" class="form-control sdate" id="phone-ticket-to" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>   
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label>Users</label>
                                                            <select id='phone-ticket-user' name="userCode" class="form-control">
                                                                <option  value="NA">Select a user</option>
                                                                {foreach name=o item=grpusr from=$groupusers.groups}
                                                                    <optgroup label="{$grpusr->name}">
                                                                    {foreach name=o item=usr from=$groupusers.users} 
                                                                        {if $usr.groupcode == $grpusr->code && $usr.activeFlag == 1}
                                                                            <option  value="{$usr.code}">{$usr.name}</option>      
                                                                        {/if}
                                                                    {/foreach}      
                                                                    </optgroup>
                                                                {/foreach}                                 
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="row">           
                                                        <div class="form-group col-md-2">
                                                            <label for="phone-ticket-type">Transaction Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="phone-ticket-type" name="filterTypeCode" class="form-control" >
                                                                    <option value="PBL">Phone Booked</option> 
                                                                    <option value="PBC">Phone Cancelled</option>                                                                    
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="phone-ticket-flag">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="phone-ticket-flag" name="travelDateFlag"  class="form-control">
                                                                    <option value="">Select an option</option> 
                                                                    <option value="1">Travel Date</option>
                                                                    <option value="0">Transaction Date</option>
                                                                </select>     
                                                            </div>
                                                        </div>
      
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="getPhoneTicketDetails();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearPhoneTktDetails();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="phone_ticket_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="phone-ticket-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="phone-ticket-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_phone_tkt_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>    

{literal}
<script>
    $('#phone-ticket-from').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        startDate: '-3m',
        endDate: '+3m',
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 31));
        $('#phone-ticket-to').datepicker('setStartDate', e.date);
        $("#phone-ticket-to").datepicker("setEndDate", end)
    });
    $('#phone-ticket-to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        endDate: '+3m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var start = new Date(fDate.setDate(fDate.getDate() - 31));
        $('#phone-ticket-from').datepicker('setStartDate', start);
        $('#phone-ticket-from').datepicker('setEndDate', e.date)
    });
    $('#phone-ticket-user').select2();
    
    function clearPhoneTktDetails(){
        $('#phone-ticket-from').val('');
        $('#phone-ticket-to').val('');
        $('#phone-ticket-user').select2('val','NA');
        $('#phone-ticket-type').val('NA');
        $('#phone-ticket-flag').val('NA');
        $('#phone-ticket-list-container').addClass('hidden');
        $('#phone-ticket-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#phone_ticket_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#phone_ticket_action_state').html('');
        $('#phone_ticket_action_state').hide();      
    }
    
    function getPhoneTicketDetails(){
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.from = $('#phone-ticket-from').val();
        data.to = $('#phone-ticket-to').val();
        data.userCode = $('#phone-ticket-user').val();
        data.filterTypeCode = $('#phone-ticket-type').val(); 
        data.travelDateFlag = $('#phone-ticket-flag').val();
        
        if (data.from == '') {
            $('#phone-ticket-from').addClass('inp_error');
            err++;
        }
        if (data.to == '') {
            $('#phone-ticket-to').addClass('inp_error');
            err++;
        }
        if (data.travelDateFlag == '') {
            $('#phone-ticket-flag').addClass('inp_error');
            err++;
        }
        if (err > 0) {
            $('#phone_ticket_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#phone_ticket_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#phone_ticket_action_state').show();
            return false;
        } else {
            $('#phone_ticket_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#phone_ticket_action_state').html('');
            $('#phone_ticket_action_state').hide();
        }
        $('#phone-ticket-list-container').removeClass('hidden');
        $('#phone-ticket-list').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/phone-ticket-details-list",
            data: data,
            success: function (response) {
                $('#phone-ticket-list').html(response);
                $('#phone-ticket-export').show();
            }
        })
    }
    function exportPhoneTicket(){
        document.phone_ticket_form.action = "report/phone-ticket-details-list";
        document.phone_ticket_form.target = "ifrm_phone_tkt_downloader";
        $('#export').val(1);
        document.phone_ticket_form.submit();
        return;
    }
</script>
{/literal}