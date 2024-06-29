<div class="brand_top">
    <h3>E-Way Bill Tracker</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportEwayExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            It shows the {lang('lr')}  booked with E-Way Bill number.              
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

                                                <form id='con_rv_rpt' method="post" name="con_rv_rpt" action="ewaybill/ewaybill-tracker-list" onsubmit="return false;">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="eway_rpt_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="eway_rpt_date_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="eway_rpt_date_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="eway_rpt_date_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="eway_rpt_date_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>                                                           
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="eway_rpt_lrcode">{lang('lr')} Number</label>
                                                            <input type="text" class="form-control sdate initialism" id="eway_rpt_lrcode" name="lrCode" placeholder="{lang('lr')} Number">
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="eway_rpt_billno">E-Way Bill Number</label>
                                                            <input type="text" class="form-control sdate initialism" id="eway_rpt_billno" name="ewayBillNo" placeholder="E-Way Bill Number">
                                                        </div>

                                                        <div class="more-filters hide">
                                                            <div class="form-group col-md-2">
                                                                <label  for="eway_rpt_date_to">From Station</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="eway_rpt_from_station" name="fromStation"  class="form-control" >
                                                                        <option value='NA' selected="">All Stations</option>
                                                                        {foreach item=station from=$stations}
                                                                            <option value="{$station.code}">{$station.name}</option>
                                                                        {/foreach}
                                                                    </select>       
                                                                </div>
                                                            </div>

                                                            <div class="form-group col-md-2">
                                                                <label  for="eway_rpt_date_to">To Station</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="eway_rpt_to_station" name="toStation"  class="form-control" >
                                                                        <option value='NA' selected="">All Stations</option>
                                                                        {foreach item=station from=$stations}
                                                                            <option value="{$station.code}">{$station.name}</option>
                                                                        {/foreach}
                                                                    </select>      
                                                                </div>
                                                            </div>

                                                            <div class="form-group col-md-2">
                                                                <label  for="eway_rpt_date_to">From Branch</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="fromOrganizationCode" name="fromOrganizationCode"  class="form-control" >
                                                                        {if $action_rights['EWAY-ALL-BRCH']>0}
                                                                            <option value='NA' selected="">All Branch</option>
                                                                            {foreach item=branch from=$branches key=bcode}
                                                                                <option value="{$bcode}">{$branch}</option>
                                                                            {/foreach}
                                                                        {else}
                                                                            <option value="{$login_branch}">{$login_branch_name}</option>
                                                                        {/if}
                                                                    </select>
                                                                </div>
                                                            </div>

                                                            <div class="form-group col-md-2">
                                                                <label  for="eway_rpt_date_to">To Branch</label>
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
                                                                    <select id="eway_rpt_pay_status" name="payStatus"  class="form-control" >
                                                                        <option value='NA' selected="">All Status</option>
                                                                        {foreach name=o item=statusname from=$cargo_payment_status key=code}                                                                        
                                                                            <option  value="{$code}">{$statusname}</option>                                                                      
                                                                        {/foreach}
                                                                    </select>       
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button" id="generate-report-btn" onclick="ewayReport();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearEwayReport();">Clear</button>
                                                            </div>
                                                        </div>        
                                                    </div>
                                                </form> 
                                            </div>
                                            <a href="javascript:;" id="more-filter-btn" class="noprint" onclick="toggleFilterRows()">More Filters</a>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="eway_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="eway-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="eway-list"></div>                                    
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
        $('#eway_rpt_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            startDate: '-6m',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#eway_rpt_date_to').datepicker('setStartDate', e.date);
            $("#eway_rpt_date_to").datepicker("setEndDate", end)
        });
        $('#eway_rpt_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#eway_rpt_date_from').datepicker('setEndDate', e.date)
        });
        
        function ewayReport() {
            $('#eway-list').html('');
            var data = {};
            data.fromDate = $('#eway_rpt_date_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#eway_rpt_date_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.fromStation = $('#eway_rpt_from_station').val();
            data.toStation = $('#eway_rpt_to_station').val();
            data.fromOrganizationCode = $('#fromOrganizationCode').val();
            data.toOrganizationCode = $('#toOrganizationCode').val();
            data.payStatus = $('#eway_rpt_pay_status').val();

            data.lrCode = $.trim( $('#eway_rpt_lrcode').val() ).toUpperCase();
            data.ewayBillNo = $.trim( $('#eway_rpt_billno').val() ).toUpperCase();

            var err = 0;
            $('#eway_rpt_date_from, #eway_rpt_date_to').removeClass('inp_error');
            if (data.lrCode == '' && data.ewayBillNo == '') {
                if (data.fromDate == '') {
                    $('#eway_rpt_date_from').addClass('inp_error');
                    err++;
                }
                if (data.toDate == '') {
                    $('#eway_rpt_date_to').addClass('inp_error');
                    err++;
                }
            } else {
                $('#eway_rpt_date_from').val('');
                $('#eway_rpt_date_to').val('');
            }

            if (data.fromDate != '' && data.toDate != '') {
                var f = data.fromDate.split('-');
                var a = moment([f[0], f[1], f[2]]);

                var e = data.toDate.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if (t > 31) {
                    $('#eway_rpt_date_to').addClass('inp_error');
                    $('#eway_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#eway_action_state').html('Date range should be 31 days or less');
                    $('#eway_action_state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#eway_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#eway_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#eway_action_state').show();
                return false;
            } else {
                $('#eway_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#eway_action_state').html('');
                $('#eway_action_state').hide();
            }
            var html = "";
            $('#eway_rpt_date_to').removeClass('inp_error');
            $('#eway-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#eway-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "ewaybill/ewaybill-tracker-list",
                data: data,
                success: function (response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#eway-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#eway-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearEwayReport() {
            $('#eway_rpt_date_from').val('');
            $('#eway_rpt_date_to').val('');
            $('#eway-list-container').addClass('hidden');
            $('#eway-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#eway_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#eway_action_state').html('');
            $('#eway_action_state').hide();

            $('#eway_rpt_from_station').val('NA');
            $('#eway_rpt_to_station').val('NA');
            $('#fromOrganizationCode option:first').prop('selected', true);
            $('#toOrganizationCode').val('NA');
            $('#eway_rpt_pay_status').val('NA');
            $('#eway_rpt_lrcode').val('');
            $('#eway_rpt_billno').val('');
            
            $('#excl_cons').hide();
        }

        function exportEwayExcel() {
            $('#export').val(1);
            document.con_rv_rpt.target = "ifrm_downloader";
            document.con_rv_rpt.submit();
            return;
        }

        function toggleFilterRows() {
            $('.more-filters').toggleClass('hide');
            $('#more-filter-btn').hide();
        }
    </script>
{/literal}
