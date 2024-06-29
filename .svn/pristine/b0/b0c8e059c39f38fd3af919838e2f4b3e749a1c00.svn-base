<div class="brand_top">
    <h3>{iflang('Pending GC Delivery Report')}</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportRevenueExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the pending delivery LR's
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

                                                <form id='con_rv_rpt' method="post" name="con_rv_rpt" action="cargo/pending-gc-delivery-report-list" onsubmit="return false;">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="rev_rpt_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="rev_rpt_date_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="rev_rpt_date_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="rev_rpt_date_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="rev_rpt_date_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>                                                           
                                                        {if $action_rights['PND-DLVRY-ALL-BRANCH']>0}    
                                                        <div class="form-group col-md-2">
                                                            <label  for="rev_rpt_date_to">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="organizationCode" name="organizationCode"  class="form-control select2" >
                                                                    <option value='NA' selected="">All Branch</option>
                                                                    {foreach item=branch from=$branches key=bcode}
                                                                        <option value="{$bcode}">{$branch}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>    
                                                        {/if}
                                                    </div>

                                                    <div class="row">


                                                        <div class="form-group col-md-2">
                                                            <label  for="rev_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="rev_rpt_from_station" name="fromStation"  class="form-control select2" >
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
                                                                <select id="rev_rpt_to_station" name="toStation"  class="form-control select2" >
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button"  onclick="deliveryReport();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearDeliveryReport();">Clear</button>
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
        $('#rev_rpt_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            startDate: '-6m',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#rev_rpt_date_to').datepicker('setStartDate', e.date);
            $("#rev_rpt_date_to").datepicker("setEndDate", end)
        });
        $('#rev_rpt_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#rev_rpt_date_from').datepicker('setEndDate', e.date)
        });

        $('.select2').select2();
        
        function deliveryReport() {
            $('#revenue-list').html('');
            var data = {};
            data.fromDate = $('#rev_rpt_date_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#rev_rpt_date_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.fromStation = $('#rev_rpt_from_station').val();
            data.toStation = $('#rev_rpt_to_station').val();
            data.organizationCode = $('#organizationCode').val();

            var err = 0;
            $('#rev_rpt_date_from, #rev_rpt_date_to').removeClass('inp_error');
            if (data.fromDate == '') {
                $('#rev_rpt_date_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#rev_rpt_date_to').addClass('inp_error');
                err++;
            }

            if (data.fromDate != '' && data.toDate != '') {
                var f = data.fromDate.split('-');
                var a = moment([f[0], f[1], f[2]]);

                var e = data.toDate.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if (t > 31) {
                    $('#rev_rpt_date_to').addClass('inp_error');
                    $('#revenue_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#revenue_action_state').html('Date range should be 31 days or less');
                    $('#revenue_action_state').show();
                    err++;
                    return false;
                }
            }

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
            $('#rev_rpt_date_to').removeClass('inp_error');
            $('#revenue-list-container').removeClass('hidden');
            $('#revenue-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/pending-gc-delivery-report-list",
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

        function clearDeliveryReport() {
            $('#rev_rpt_date_from').val('');
            $('#rev_rpt_date_to').val('');
            $('#revenue-list-container').addClass('hidden');
            $('#revenue-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#revenue_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#revenue_action_state').html('');
            $('#revenue_action_state').hide();

            $('#rev_rpt_from_station').val('NA').trigger('change');
            $('#rev_rpt_to_station').val('NA').trigger('change');
            $('#organizationCode').val('NA').trigger('change');
            
            $('#excl_cons').hide();
        }

        function exportRevenueExcel() {
            $('#export').val(1);
            document.con_rv_rpt.target = "ifrm_downloader";
            document.con_rv_rpt.submit();
            return;
        }
    </script>
{/literal}
