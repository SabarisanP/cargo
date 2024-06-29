<div class="brand_top">
    <h3>Cargo Transaction Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="exportTalyExcel()"><i class="fa fa-download fa-lg"></i>Tally Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the LR's specific branch commission and particular branch transaction amount.
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

                                                <form id='con_bk_rpt' method="post" name="con_bk_rpt" action="cargo/transaction-report-list" onsubmit="return false">
                                                    <div class="row">   
                                                         <div class="form-group col-md-3">
                                                            <label for="trns_rpt_date_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="trns_rpt_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        {if $action_rights['CGO-TRAS-USR-FILTER']>0}
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_user_code" name="userCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Users</option>
                                                                    {foreach name=o item=row from=$groupusers.users}                                                                        
                                                                        <option  value="{$row.code}">{$row.name}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">Cargo Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_cargo_status" name="cargoStatus"  class="form-control" >
                                                                    <option value='NA' selected="">All Status</option>
                                                                    {foreach name=o item=statusname from=$cargo_status key=code}                                                                        
                                                                        <option  value="{$code}">{$statusname}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>        
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_transaction_mode">Transaction Mode</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_transaction_mode" name="transactionModeCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Transaction Modes</option>
                                                                    {foreach key=key item=name from=$transaction_mode}
                                                                        <option value="{$key}">{$name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        {if $action_rights['CGO-TRAS-USR-FILTER']>0}
                                                            <div class="form-group col-md-2">
                                                                <label for="trns-group">Groupwise</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="trns-group" name="groupCode" class="form-control">
                                                                        <option value="NA">All group</option>
                                                                        {foreach item=row from=$groups}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                    </div>

                                                    <div class="row">  

                                                        <div class="form-group col-md-2">
                                                            <label  for="trns_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_from_station" name="fromStation"  class="form-control" >
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
                                                                <select id="trns_rpt_to_station" name="toStation"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>  
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label  for="cargo_pay_status">Cargo Payment Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_pay_status" name="payStatus"  class="form-control" >
                                                                    <option value='NA' selected="">All Status</option>
                                                                    {foreach name=o item=statusname from=$cargo_payment_status key=code}                                                                        
                                                                        <option  value="{$code}">{$statusname}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="cargo_filter_code">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_filter_code" name="filterCode"  class="form-control" >
                                                                    <option value='BOOK' selected="">Booked date</option>
                                                                    <option value='TRANSACTION'>Transaction date</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" id="fromDate" name="fromDate">
                                                                <input type="hidden" id="toDate" name="toDate">
                                                                <button class="btn btn-success" type="button" id="generate-report-btn" onclick="searchCargoTrnsBooking();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearCargoTrnsReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="trns_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="trns-booking-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="trns-booking-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_consolidate_downloader" id="ifrm_consolidate_downloader" style="display:none"></iframe>  
   

{literal}
    <script>
      
        $('#trns_rpt_date_range').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY',
        separator: ' | ',
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        },
        }).on('show.daterangepicker', function (ev, picker) {
            picker.showCalendars()
        });

        $('#trns_rpt_user_code, #trns_rpt_cargo_status, #trns_rpt_transaction_mode, #trns_rpt_from_station, #trns_rpt_to_station, #trns_rpt_pay_status, #trns-group').select2();

        function exportCargoTransExcel() {
            var daterange = $('#trns_rpt_date_range').data('daterangepicker');
            var fromDate = daterange.startDate.format('DD-MM-YYYY');
            var toDate = daterange.endDate.format('DD-MM-YYYY');
            $('#fromDate').val(fromDate);
            $('#toDate').val(toDate);
            document.con_bk_rpt.action = "cargo/transaction-report-list";
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#export').val(1);
            document.con_bk_rpt.submit();
            return;
        }

        function searchCargoTrnsBooking() {
            $('#trns-booking-list').html('');
            
            var data = {};
            var daterange = $('#trns_rpt_date_range').data('daterangepicker');
            data.fromDate = daterange.startDate.format('DD-MM-YYYY');
            data.toDate = daterange.endDate.format('DD-MM-YYYY');
            data.cargoStatus = $('#trns_rpt_cargo_status').val();
            data.userCode = $('#trns_rpt_user_code').val();
            data.payStatus = $('#trns_rpt_pay_status').val();            
            data.fromStation = $('#trns_rpt_from_station').val();
            data.toStation = $('#trns_rpt_to_station').val();
            data.filterCode = $('#trns_rpt_filter_code').val();
            data.transactionModeCode = $('#trns_rpt_transaction_mode').val();
            data.groupCode = $('#trns-group').val();

            var err = 0;

            if (err > 0) {
                $('#trns_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#trns_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#trns_rpt_action_state').show();
                return false;
            } else {
                $('#trns_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#trns_rpt_action_state').html('');
                $('#trns_rpt_action_state').hide();
            }
            var html = "";
          
            $('#trns-booking-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#trns-booking-list').html(loading_popup);
            
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/transaction-report-list",
                data: data,
                success: function (response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#trns-booking-list').html(response);
                    $('#excl_cons').show();                    
                    $("html, body").animate({
                        scrollTop: $('#trns-booking-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }
        

        function clearCargoTrnsReport() {
            $('#trns_rpt_date_range').val('');
            $('#trns_rpt_date_range').data('daterangepicker').setStartDate({});
            $('#trns_rpt_date_range').data('daterangepicker').setEndDate({});
            $('#trns-booking-list-container').addClass('hidden');
            $('#trns-booking-list').html('');
            // $('.inp_error').removeClass('inp_error');
            $('#trns_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#trns_rpt_action_state').html('');
            $('#trns_rpt_action_state').hide();
            $('#trns_rpt_from_station').val('NA').trigger('change');
            $('#trns_rpt_to_station').val('NA').trigger('change');
            $('#trns_rpt_pay_status').val('NA').trigger('change');
            $('#trns_rpt_cargo_status').val('NA').trigger('change');
            $('#trns_rpt_user_code').val('NA').trigger('change');
            $('#trns_rpt_filter_code').val('TRANSACTION');
            $('#trns_rpt_transaction_mode').val('NA').trigger('change');
            $('#trns-group').val('NA').trigger('change');
            $('#excl_cons').hide();
        }

        function exportTalyExcel() {
            document.con_bk_rpt.action = "cargo/transaction-report-list-tally";
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#export').val(1);
            document.con_bk_rpt.submit();
            return;
        }
       
    </script>
{/literal}
