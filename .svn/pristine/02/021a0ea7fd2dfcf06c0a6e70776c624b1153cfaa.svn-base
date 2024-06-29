<div class="brand_top">
    <h3>Transaction Report</h3> 
    <div class="text-right noprint" id="exc-tr" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>           
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
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
                                                        <label for="trns_rpt_date_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="cons_rpt_date_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="cons_rpt_date_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="cons_rpt_date_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>   
                                                    <div class="form-group col-md-2">
                                                        <label  for="trns_rpt_date_to">Date Option</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="cons_rpt_date_opt" name="date_option"  class="form-control" >                                                                    
                                                                <option value="0">Transaction Date</option>
                                                                <option value="1">Travel Date</option>
                                                            </select>     
                                                        </div>
                                                    </div>
                                                                                   
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="cons_rpt_action_state"></div>
                                                </div>

                                                      
                                                <div class="row">          
                                                    <div class="form-group col-md-2">
                                                        <label  for="trns_rpt_date_to">From Station</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="cons_trns_rpt_from_station" name="from_code"  class="form-control" >
                                                                <option value='NA' selected="">All Stations</option>
                                                                {foreach item=station from=$stations}
                                                                    <option value="{$station.code}">{$station.name}</option>
                                                                {/foreach}
                                                            </select>       
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label  for="trns_rpt_date_to">To Station</label>
                                                        <div class="input-group col-md-11">
                                                            <select id="cons_trns_rpt_to_station" name="to_code"  class="form-control" >
                                                                <option value='NA' selected="">All Stations</option>
                                                                {foreach item=station from=$stations}
                                                                    <option value="{$station.code}">{$station.name}</option>
                                                                {/foreach}
                                                            </select>      
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label  for="trns_rpt_date_to">Users</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="cons_trns_rpt_user_code" name="user_code"  class="form-control" >
                                                                <option value='NA' selected="">All Users</option>
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
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="searchTransBooking()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearTransReport()">Clear</button>
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
                                                            
                    <div class="row hidden" id="cons-booking-list-container">
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
            $('#cons_rpt_date_from').datepicker({
                //     todayHighlight: true,
                format: 'yyyy-mm-dd',
                autoclose: true,
                startDate: '-3m',
                endDate: '+3m',
                changeMonth: true,
            }).on('changeDate', function (e) {
                var fDate = new Date(e.date);
                var end = new Date(fDate.setDate(fDate.getDate() + 31));
                $('#cons_rpt_date_to').datepicker('setStartDate', e.date);
                $("#cons_rpt_date_to").datepicker("setEndDate", end)
            });
            $('#cons_rpt_date_to').datepicker({
                todayHighlight: true,
                startDate: '-0m',
                endDate: '+3m',
                format: 'yyyy-mm-dd',
                maxDate: "+365D",
                autoclose: true
            }).on('changeDate', function (e) {
                var fDate = new Date(e.date);
                var start = new Date(fDate.setDate(fDate.getDate() - 31));
                $('#cons_rpt_date_from').datepicker('setStartDate', start);
                $('#cons_rpt_date_from').datepicker('setEndDate', e.date)
            });

            function searchTransBooking() {
                $('#cons-booking-list').html('');
                var data = {};
                data.date_option = $('#cons_rpt_date_opt').val();
                data.from = $('#cons_rpt_date_from').val();
                data.to = $('#cons_rpt_date_to').val();
                data.from_code = $('#cons_trns_rpt_from_station').val();
                data.to_code = $('#cons_trns_rpt_to_station').val();
                data.user_code = $('#cons_trns_rpt_user_code').val();
                data.tagCode = $('#tag_filter').val();


                var err = 0;
                $('#trans_rpt', '#cons_rpt_date_opt, #cons_rpt_date_from, #cons_rpt_date_to').removeClass('inp_error');


                if (data.date_option == '') {
                    $('#cons_rpt_date_opt').addClass('inp_error');
                    err++;
                }

                if (data.from == '') {
                    $('#cons_rpt_date_from').addClass('inp_error');
                    err++;
                }

                if (data.from == '') {
                    if (data.to == '') {
                        $('#cons_rpt_date_to').addClass('inp_error');
                        err++;
                    }
                }

                if (data.from != '') {
                    if (data.to == '') {
                        $('#cons_rpt_date_to').removeClass('inp_error');
                        var d = new Date();

                        var month = d.getMonth() + 1;
                        var day = d.getDate();

                        var output = d.getFullYear() + '-' +
                                (('' + month).length < 2 ? '0' : '') + month + '-' +
                                (('' + day).length < 2 ? '0' : '') + day;

                        data.to = output;
                        $('#cons_rpt_date_to').val(output);
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
                $('#cons_rpt_date_to').removeClass('inp_error');
                $('#cons-booking-list-container').removeClass('hidden');
                $('#cons-booking-list').html(loading_popup);
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "report/ids-transaction-report-list",
                    data: data,
                    success: function (response) {
                        $('#cons-booking-list').html(response);
                        $('#exc-tr').show();
                    }
                })
            }

            function clearTransReport() {
                $('#cons_rpt_date_from').val('');
                $('#cons_rpt_date_to').val('');
                $('#cons-booking-list-container').addClass('hidden');
                $('#cons-booking-list').html('');
                $('.inp_error').removeClass('inp_error');
                $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#cons_rpt_action_state').html('');
                $('#cons_rpt_action_state').hide();
                $('#cons_trns_rpt_from_station').val('NA');
                $('#cons_trns_rpt_to_station').val('NA');
                $('#cons_trns_rpt_user_code').val('NA');
                $('#exc-tr').hide();
            }
            
            function exportTransExcel() {
                document.trans_form.action = "report/ids-transaction-report-list";
                document.trans_form.target = "ifrm_trans_downloader";
                $('#export').val(1);
                document.trans_form.submit();
                return;
            }

        </script>
    {/literal}

