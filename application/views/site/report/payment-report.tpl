<div class="brand_top">
    <h3>Payment Receipt</h3> 
    <div class="text-right noprint" id="pay-tr" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="PaymentPdf()"><i class="fa fa-download fa-lg"></i>Download</button>
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
                                            <form id='pays_form' name="pays_form" method="post" action="report/payment-report-list" onsubmit="return false" target="_blank">
                                                <div class="row">   
                                                    <div class="form-group col-md-2">
                                                        <label for="trns_rpt_date_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="pays_rpt_date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="cons_rpt_date_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="pays_rpt_date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>   
                                                    <div class="form-group col-md-2">
                                                        <label  for="trns_rpt_date_to">Date Option</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="pays_rpt_date_opt" name="date_option"  class="form-control" >                                                                    
                                                                <option value="1">Travel Date</option>
                                                                <option value="0">Transaction Date</option>
                                                            </select>     
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2" id='trp'>
                                                        <label  for="trns_rpt_date_to">Group By</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="pays_trip" name="group_by"  class="form-control" >                                                                    
                                                                <option value="">Select</option>
                                                                <option value="1" selected="">Schedule</option>
                                                            </select>     
                                                        </div>
                                                    </div>

                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="pays_rpt_action_state"></div>
                                                </div>

                                                <div class="row">  

                                                    <div class="form-group col-md-4">
                                                        <label  for="trns_rpt_date_to">Schedule</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="pays_trns_rpt_schedule" name="schedule_code"  class="form-control" >
                                                                <option value='NA' selected="">All Schedules</option>
                                                                {foreach item=schedule from=$active_schedules}
                                                                    <option value="{$schedule.code}">{$schedule.name}</option>
                                                                {/foreach}
                                                            </select>       
                                                        </div>
                                                    </div>

                                                    {if $action_rights['PAY-USER-FILTER']==1}         
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="pays_trns_rpt_user_code" name="user_code"  class="form-control" >
                                                                    <option value='NA' selected="">Select</option>
                                                                    {foreach name=o item=row from=$entity}
                                                                        <optgroup label="{$row['name']}">
                                                                            {foreach name=o item=usr from=$row["userlist"]}
                                                                                <option value='{$usr->code}'>{$usr->name}</option>
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                    {/if}
                                                            
                                                    <div class="form-group col-md-2">
                                                        <label  for="tag_filter">Tags</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="tag_filter" name="tagCode"  class="form-control" >                                                                    
                                                                    <option value="">Select Tags</option>
                                                                    {foreach from=$tags item=row}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                            </select>       
                                                        </div>
                                                    </div>         

                                                    <div class="form-group col-md-2">
                                                        <label for="cons_rpt_date_to">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="pdf" id="pdf" value="">
                                                            <input type="hidden" name="usrnm" id="usrnm">
                                                            <button class="btn btn-success" type="button"  onclick="searchPaymentReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearPaymentReport()">Clear</button>
                                                        </div>
                                                    </div>

                                                </div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="pays-booking-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="pays-booking-list"></div>                                    
                            </div>
                        </div>
                    </div>
                </div>

            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_pays_downloader" id="ifrm_pays_downloader" style='display:none'></iframe>                                                         
{literal}
    <script>
        $('#pays_rpt_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#pays_rpt_date_to').datepicker('setStartDate', e.date);
            $("#pays_rpt_date_to").datepicker("setEndDate", end)
        });
        $('#pays_rpt_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#pays_rpt_date_from').datepicker('setEndDate', e.date)
        });

        function searchPaymentReport() {
            $('#pays-booking-list').html('');
            var data = {};
            data.date_option = $('#pays_rpt_date_opt').val();
            data.from = $('#pays_rpt_date_from').val();
            data.to = $('#pays_rpt_date_to').val();
            data.schedule_code = $('#pays_trns_rpt_schedule').val();
            data.user_code = $('#pays_trns_rpt_user_code').val();
            data.group_by = $('#pays_trip').val();
            data.username = $("#pays_trns_rpt_user_code option:selected").text();
            data.tagCode = $('#tag_filter').val();
            var err = 0;
            $('#pays_rpt_date_opt, #pays_rpt_date_from, #pays_rpt_date_to').removeClass('inp_error');

            if (data.date_option == '') {
                $('#pays_rpt_date_opt').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                $('#pays_rpt_date_from').addClass('inp_error');
                err++;
            }

            if (data.from == '') {
                if (data.to == '') {
                    $('#pays_rpt_date_to').addClass('inp_error');
                    err++;
                }
            }

            if (data.from != '') {
                if (data.to == '') {
                    $('#pays_rpt_date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to = output;
                    $('#pays_rpt_date_to').val(output);
                }
            }

            if (err > 0) {
                $('#pays_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#pays_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#pays_rpt_action_state').show();
                return false;
            } else {
                $('#pays_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#pays_rpt_action_state').html('');
                $('#pays_rpt_action_state').hide();
            }
            var html = "";
            $('#pays_rpt_date_to').removeClass('inp_error');
            $('#pays-booking-list-container').removeClass('hidden');
            $('#pays-booking-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/payment-report-list",
                data: data,
                success: function (response) {
                    $('#pays-booking-list').html(response);
                    $('#pay-tr').show();
                    $('#usrnm').val(data.username);

                }
            })
        }

        function clearPaymentReport() {
            $('#pays_rpt_date_from').val('');
            $('#pays_rpt_date_to').val('');
            $('#pays-booking-list-container').addClass('hidden');
            $('#pays-booking-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#pays_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#pays_rpt_action_state').html('');
            $('#pays_rpt_action_state').hide();
            $('#pays_trns_rpt_schedule').val('NA');
            $('#pays_trns_rpt_user_group').val('NA');
            $('#pays_trns_rpt_user_code').val('NA');
            $('#pays_trip').val('');
            $('#pay-tr').hide();
        }
        
        function PaymentPdf() {
                //document.pays_form.target = "ifrm_pays_downloader";
                document.pays_form.action = "report/payment-report-list?r="+Math.random();
                $('#pdf').val(1);
                document.pays_form.submit();
                return;
        }


    </script>
{/literal}

