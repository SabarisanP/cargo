<div class="brand_top">
    <h3>Record Topay Payment</h3> 
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

                                                <form id='topay_form' method="post" name="topay_form" onsubmit="return false">
                                                    <div class="row">   
                                                        <div class="form-group col-md-4">
                                                            <label for="topay_pmt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="topay_pmt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        {if $action_rights['CGO-TRAS-USR-FILTER']>0}
                                                        <div class="form-group col-md-2">
                                                            <label for="topay_pmt_user_code">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="topay_pmt_user_code" name="userCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Users</option>
                                                                    {foreach name=o item=row from=$groupusers.users}                                                                        
                                                                        <option  value="{$row.code}">{$row.name}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="topay_pmt_cargo_status">Cargo Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="topay_pmt_cargo_status" name="cargoStatus"  class="form-control" >
                                                                    <option value='NA' selected="">All Status</option>
                                                                    {foreach name=o item=statusname from=$cargo_status key=code}                                                                        
                                                                        <option  value="{$code}">{$statusname}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>        
                                                    </div>

                                                    <div class="row">  
                                                        <div class="form-group col-md-2">
                                                            <label for="topay_pmt_from_station">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="topay_pmt_from_station" name="fromStation" class="form-control">
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>                                                              
                                                        <div class="form-group col-md-2">
                                                            <label  for="topay_pmt_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="topay_pmt_to_station" name="toStation"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label  for="topay_pmt_cargo_code">{lang('cargo_code_term')}</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" class="form-control" id="topay_pmt_cargo_code" name="cargoCode" placeholder="{lang('cargo_code_term')}" value="" style="text-transform:uppercase" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <button class="btn btn-success" type="button"  onclick="getTopayPmtList();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTopayPmt();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="topay_pmt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="topay-pmt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="topay-pmt-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>                        
            </div>                    
        </div>
    </div>            
</div>
   

{literal}
    <script>
        $('#topay_pmt_date_range').daterangepicker({
            buttonClasses: ['btn', 'btn-xs'],
            format: 'DD-MM-YYYY',
            separator: ' | ',
            timePicker: false,
            ranges: {
                'Today': [moment().startOf('day'), moment().endOf('day')],
                'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
                'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
                'Last 31 Days': [moment().subtract(30, 'days').startOf('day'), moment().endOf('day')],
            },
        }).on('show.daterangepicker', function(ev, picker) {
            setEndTime(picker);
            picker.showCalendars();
        });

        var picker = $('#topay_pmt_date_range').data('daterangepicker');
        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }

        $('#topay_form #topay_pmt_cargo_code').keypress(function(event) {
            if (event.keyCode == 13) {
                getTopayPmtList();
            }
        });

        function getTopayPmtList(){
            $('#topay-pmt-list').html('');
            var data = {};
            data.dateRange = $('#topay_pmt_date_range').val();
            data.cargoStatus = $('#topay_pmt_cargo_status').val();
            data.userCode = $('#topay_pmt_user_code').val();           
            data.fromStation = $('#topay_pmt_from_station').val();
            data.toStation = $('#topay_pmt_to_station').val(); 
            data.cargoCode = $('#topay_pmt_cargo_code').val();  

            var err = 0;
            $('#topay_pmt_from, #topay_pmt_to').removeClass('inp_error');
            
            if (data.dateRange == '') {
                $('#topay_pmt_date_range').addClass('inp_error');
                err++;
            } else {
                $('#topay_pmt_date_range').removeClass('inp_error');
            }

            if (data.cargoCode == "") {
                if (data.fromDate == '') {
                    $('#topay_pmt_from').addClass('inp_error');
                    err++;
                }

                if (data.toDate == '') {
                    $('#topay_pmt_to').addClass('inp_error');
                    err++;
                }
            }
        
            if (err > 0) {
                $('#topay_pmt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#topay_pmt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#topay_pmt_action_state').show();
                return false;
            } else {
                $('#topay_pmt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#topay_pmt_action_state').html('');
                $('#topay_pmt_action_state').hide();
            }
            $('#topay_pmt_to').removeClass('inp_error');
            $('#topay-pmt-list-container').removeClass('hidden');
            $('#topay-pmt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/topay-payment-list",
                data: data,
                success: function(response) {
                    $('#topay-pmt-list').html(response);
                    $("html, body").animate({
                        scrollTop: $('#topay-pmt-list-container').offset().top - 35
                    }, "slow");
                }
            });
        }

        function clearTopayPmt() {
            $('#topay_pmt_from').val('');
            $('#topay_pmt_to').val('');
            $('#topay-pmt-list-container').addClass('hidden');
            $('#topay-pmt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#topay_pmt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#topay_pmt_action_state').html('');
            $('#topay_pmt_action_state').hide();
            $('#topay_pmt_from_station').val('NA');
            $('#topay_pmt_to_station').val('NA');
            $('#topay_pmt_cargo_status').val('NA');
            $('#topay_pmt_user_code').val('NA');
            $('#topay_pmt_cargo_code').val('');
        }

        function updateTopayPayment(code) {
            var data = {};
            data.code = code;
            data.amount = $.trim($('#' + code).val());
            data.delivery = ($('#delivery-' + code).is(':checked')) ? '1' : '0';
            data.offlineUserCode = $('#behalf-' + code).val();
            $('#' + code).removeClass('inp_error');
            
            if (data.amount == "") {
                $('#' + code).addClass('inp_error');
                return;
            } else if (Number(data.amount) <= 0) {
                $('#' + code).addClass('inp_error');
                return;
            } else if (isNaN(data.amount)) {
                $('#' + code).addClass('inp_error');
                return;
            }
            $('#' + code + '-action .save-btn').addClass('hide');
            $('#' + code + '-action .act-status').html('');
            $('#' + code + '-action .act-loading').html(loading_small);
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-topay-payment",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#' + code).parent('td').text($('#' + code).val());
                        $('#behalf-' + code).parent('td').text($('#behalf-' + code).find(':selected').text());
                        $('#' + code + '-action .act-loading').html('');
                        $($('#' + code + '-action .act-status')).html('<span class="txt_green">Success<span>');
                    } else {
                        $('#' + code + '-action .save-btn').removeClass('hide');
                        $('#' + code + '-action .act-loading').html('');
                        $('#' + code + '-action .act-status').html('<span class="warning-text">' + response.errorDesc + '<span>');
                    }
                }
            });
        }
    </script>
{/literal}
