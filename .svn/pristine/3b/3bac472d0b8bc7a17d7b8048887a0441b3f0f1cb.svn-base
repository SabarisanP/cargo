<div class="brand_top">
    <h3>Business Detailed Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-download fa-lg"></i>Excel <span class="fa fa-caret-down"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right text-left"> 
                <li><a href="javascript:;" onclick="exportRevenueExcel(1)">Model 1</a></li>
                <li><a href="javascript:;" onclick="exportRevenueExcel(2)">Model 2</a></li>
            </ul>
        </div>
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the from and to user commission for individual LR 
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
                                                <form id='con_rv_rpt' method="post" name="con_rv_rpt" action="cargo/business-detailed-report-list" onsubmit="return false;">
                                                    <div class="row">   
                                                        <div class="form-group col-md-3">
                                                            <label for="rev_rpt_date_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="rev_rpt_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label  for="rev_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="rev_rpt_from_station" name="fromStation"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="rev_rpt_date_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="rev_rpt_to_station" name="toStation"  class="form-control" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>    
                                                    </div>

                                                    <div class="row"> 

                                                        <div class="form-group col-md-2">
                                                            <label  for="rev_rpt_date_to">From Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="fromOrganizationCode" name="fromOrganizationCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Branch</option>
                                                                    {foreach item=branch from=$branches key=bcode}
                                                                        <option value="{$bcode}">{$branch}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="rev_rpt_date_to">To Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="toOrganizationCode" name="toOrganizationCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Branch</option>
                                                                    {foreach item=branch from=$branches key=bcode}
                                                                        <option value="{$bcode}">{$branch}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="cargo_pay_status">Cargo Payment Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="rev_rpt_pay_status" name="payStatus"  class="form-control" >
                                                                    <option value='NA' selected="">All Status</option>
                                                                    {foreach name=o item=statusname from=$cargo_payment_status key=code}                                                                        
                                                                        <option  value="{$code}">{$statusname}</option>                                                                      
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" id="fromDate" name="fromDate">
                                                                <input type="hidden" id="toDate" name="toDate">
                                                                <input type="hidden" name="modelopt" id="modelopt" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button"  onclick="revenueReport();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearRevenueReport();">Clear</button>
                                                            </div>
                                                        </div>        
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="revenue_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="revenue-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="revenue-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe> 

{literal}
    <script>
       
        $('#rev_rpt_date_range').daterangepicker({
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
            
        function revenueReport() {
            $('#revenue-list').html('');
            var data = {};
            var daterange = $('#rev_rpt_date_range').data('daterangepicker');
            data.fromDate = daterange.startDate.format('DD-MM-YYYY');
            data.toDate = daterange.endDate.format('DD-MM-YYYY');
            data.fromStation = $('#rev_rpt_from_station').val();
            data.toStation = $('#rev_rpt_to_station').val();
            data.fromOrganizationCode = $('#fromOrganizationCode').val();
            data.toOrganizationCode = $('#toOrganizationCode').val();
            data.payStatus = $('#rev_rpt_pay_status').val();
            
            var err = 0;

            if (err > 0) {
                $('#revenue_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#revenue_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#revenue_action_state').show();
                return false;
            } else {
                $('#revenue_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#revenue_action_state').html('');
                $('#revenue_action_state').hide();
            }
            var html = "";
            
            $('#revenue-list-container').removeClass('hidden');
            $('#revenue-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/business-detailed-report-list",
                data: data,
                success: function (response) {
                    $('#revenue-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#revenue-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearRevenueReport() {
            $('#rev_rpt_date_range').val('');
            $('#rev_rpt_date_range').data('daterangepicker').setStartDate({});
            $('#rev_rpt_date_range').data('daterangepicker').setEndDate({});
            $('#revenue-list-container').addClass('hidden');
            $('#revenue-list').html('');
            $('#revenue_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#revenue_action_state').html('');
            $('#revenue_action_state').hide();
            $('#rev_rpt_from_station').val('NA');
            $('#rev_rpt_to_station').val('NA');
            $('#fromOrganizationCode').val('NA');
            $('#toOrganizationCode').val('NA');
            $('#rev_rpt_pay_status').val('NA');
            $('#excl_cons').hide();
        }

        function exportRevenueExcel(opt) {
            var daterange = $('#rev_rpt_date_range').data('daterangepicker');
            var fromDate = daterange.startDate.format('DD-MM-YYYY');
            var toDate = daterange.endDate.format('DD-MM-YYYY');
            $('#fromDate').val(fromDate);
            $('#toDate').val(toDate);
            $('#export').val(1);
            $('#modelopt').val(opt);
            document.con_rv_rpt.target = "ifrm_downloader";
            document.con_rv_rpt.submit();
            return;
        }
    </script>
{/literal}
