<div class="brand_top">
    <h3>SMS Utilization Report</h3> 
    <div class="text-right noprint" id="exc-tr1" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div> 
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the sent SMS details only for 35 days.                 
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
                                                <form id='mytrans_form' name="trans_form" method="post" action="report/sms-utilization-report-list" onsubmit="return false">
                                                    <div class="row">   
                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from" class="form-control sdate" id="sms_rpt_date_from" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="sms_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to" class="form-control sdate" id="sms_rpt_date_to" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>   
                                                        
                                                    </div>

                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label  for="sms_rpt_searchby">Search By</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="sms_rpt_searchby" name="sms_rpt_searchby"  class="form-control" onchange="setSearchBy()" >                                                                    
                                                                    <option value="1">SMS Type</option>
                                                                    <option value="2">Mobile</option>
                                                                    <option value="3">{lang('lr')}</option>
                                                                </select>     
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2" id="bytype">
                                                            <label  for="sms_rpt_noti_type">SMS Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="sms_rpt_noti_type" name="sms_rpt_noti_type"  class="form-control"  >                                                                    
                                                                    <option value="">Select a type</option>
                                                                    {foreach name=o key=k item=name from=$entity}
                                                                        <option value="{$k}">{$name}</option>
                                                                    {/foreach}
                                                                </select>     
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2 hide" id="bymobile">
                                                            <label for="sms_rpt_mob">Mobile</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="mobile" class="form-control sdate input_capital" id="mobile" placeholder="Mobile">
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2 hide" id="bypnr">
                                                            <label for="sms_rpt_pnr">{lang('lr')}</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="pnr" class="form-control sdate input_capital" id="pnr" placeholder="{lang('lr')} Number">
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-3">
                                                            <label for="sms_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="smsUtilizationReport()">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTransReport()">Clear</button>
                                                            </div>
                                                        </div>
                                                        <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="cons_rpt_action_state"></div>
                                                    </div>
                                            </div>
                                            </form>
                                        </div>
                                        <br class="clear_fix_both">
                                        <div class="align-center alert alert-danger pull-left" style="display:none" id="cancel_rpt_action_state"></div>
                                    </div><!--row end-->
                                </div><!--content end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row hidden" id="sms-utilization-list-container">
                <br>
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div id="cons-booking-list"></div>                                    
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>                    
</div>
</div>            
<iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>                                                         
    {literal}
    <script>
        $('#sms_rpt_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#sms_rpt_date_to').datepicker('setStartDate', e.date);
            $("#sms_rpt_date_to").datepicker("setEndDate", end)
        });
        $('#sms_rpt_date_to').datepicker({
            todayHighlight: true,
            startDate: '-3m',
            endDate: '-0m',
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#sms_rpt_date_from').datepicker('setStartDate', start);
            $('#sms_rpt_date_from').datepicker('setEndDate', e.date)
        });
        
        function setSearchBy() {
            var type = $('#sms_rpt_searchby').val();
            $('#bytype, #bymobile, #bypnr').addClass('hide');
            $('#sms_rpt_noti_type, #mobile, #pnr').val('');
            
            if(type==1) $('#bytype').removeClass('hide');
            if(type==2) $('#bymobile').removeClass('hide');
            if(type==3) $('#bypnr').removeClass('hide');
        }
        
        function clearTransReport() {
            $('#sms_rpt_date_from').val('');
            $('#sms_rpt_date_to').val('');
            $('#sms-utilization-list-container').addClass('hidden');
            $('#cons-booking-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#cons_rpt_action_state').html('');
            $('#cons_rpt_action_state').hide();
            $('#exc-tr').hide();
            $('#sms_rpt_noti_type, #mobile, #pnr').val('');
            $('#bytype, #bymobile, #bypnr').addClass('hide');
            $('#sms_rpt_searchby').val(1);
            $('#bytype').removeClass('hide');
        }
        
        function smsUtilizationReport() {
            $('#cons-booking-list').html('');
            var err = 0;
            $('.inp_error').removeClass('inp_error');
            
            var data = {};
            data.from = $('#sms_rpt_date_from').val();
            data.to = $('#sms_rpt_date_to').val();
            data.searchby = $('#sms_rpt_searchby').val();
            data.notification_type = $('#sms_rpt_noti_type').val();
            data.mobile = $('#mobile').val();
            data.pnr = $('#pnr').val();

            

            if (data.from == '') {
                $('#sms_rpt_date_from').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                if (data.to == '') {
                    $('#sms_rpt_date_to').addClass('inp_error');
                    err++;
                }
            }
            
            if(data.searchby==1) {
                if(data.notification_type=="") {
                    $('#sms_rpt_noti_type').addClass('inp_error');
                    err++;
                }
            }
            
            if(data.searchby==2) {
                if(data.mobile=="") {
                    $('#mobile').addClass('inp_error');
                    err++;
                }
            }
            
            if(data.searchby==3) {
                if(data.pnr=="") {
                    $('#pnr').addClass('inp_error');
                    err++;
                }
            }

            if (data.from != '') {
                if (data.to == '') {
                    $('#sms_rpt_date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to = output;
                    $('#sms_rpt_date_to').val(output);
                }
            }

            if (err > 0) {
                $('#cons_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#cons_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#cons_rpt_action_state').show();
                return false;
            } else {
                $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#cons_rpt_action_state').html('');
                $('#cons_rpt_action_state').hide();
            }
            var html = "";
            $('#sms_rpt_date_to').removeClass('inp_error');
            $('#sms-utilization-list-container').removeClass('hidden');
            $('#cons-booking-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/sms_utilization_report_list",
                data: data,
                success: function (response) {
                    $('#cons-booking-list').html(response);
                    $('#exc-tr').show();
                }
            })
        }

        

        function exportTransExcel() {
            document.trans_form.action = "report/sms-utilization-report-list";
            document.trans_form.target = "ifrm_trans_downloader";
            $('#export').val(1);
            document.trans_form.submit();
            return;
        }

        function exportTalyExcel() {
            document.trans_form.action = "report/sms-utilization-report-list-tally";
            document.trans_form.target = "ifrm_trans_downloader";
            $('#export').val(1);
            document.trans_form.submit();
            return;
        }


    </script>
{/literal}

