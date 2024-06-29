<div class="brand_top">
    <h3>GST Collection Report</h3> 
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/ac-bus-tax-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="from_date" class="form-control sdate" id="date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="to_date" class="form-control sdate" id="date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="date_option" name="date_option"  class="form-control" >
                                                                    <option value="0">Transaction Date</option>
                                                                    <option value="1">Travel Date</option>                                                                    
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only">Tax Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="gst_filter" name="gst_filter" class="form-control" onchange="setGstFilter(this);">
                                                                    <option value="GST">GST</option>
                                                                    <option value="NON_GST">Non GST</option>                                                                    
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-3">        
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="searchTaxReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                        </div>
                                                    </div>            
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usr-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="boarding-point-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    
                                    <ul class="nav nav-tabs" id='report-tabs'>
                                        <li class="active"><a data-toggle="tab" href="#gst-state">State Wise</a></li>
                                        <li><a data-toggle="tab" href="#gst-role" onclick="generateRoleWiseReport()">Group / Role Wise</a></li>
                                        <li><a data-toggle="tab" href="#gst-user" onclick="generateUserWiseReport()">User Wise</a></li>
                                        <li><a data-toggle="tab" href="#gst-schedule" onclick="generateScheduleWiseReport()">Schedule Wise</a></li>
                                        <li><a data-toggle="tab" href="#gst-trip" onclick="generateTripWiseReport()">Trip Wise</a></li>
                                        <li><a data-toggle="tab" href="#gst-gst" onclick="generateGSTWiseReport()">GST Type Wise</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="gst-state" class="tab-pane fade in active"></div>
                                        <div id="gst-role" class="tab-pane fade"></div>
                                        <div id="gst-user" class="tab-pane fade"></div>
                                        <div id="gst-schedule" class="tab-pane fade"></div>
                                        <div id="gst-trip" class="tab-pane fade"></div>
                                        <div id="gst-gst" class="tab-pane fade"></div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe id="irm_downloader" style="display: none"></iframe>                                            
{literal}
    <script>
        function setGstFilter(ele) {
            if($(ele).val() === 'GST') {
                $('a[href="#gst-gst"]').show();
            } else {
                $('#gst-gst').html('');
                $('a[href="#gst-gst"]').hide();
                if($('a[href="#gst-gst"]').parent('li.active').length) {
                    $('a[href="#gst-state"]').tab('show');
                }
            }
        }

        function exportBoardingExcel() {
            document.brd_pnt.target = "ifrm_boarding_downloader";
            document.brd_pnt.action = "report/ac-bus-tax-list-statewise";            
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }
        
        function exportGSTExcelRolewise() {
            document.brd_pnt.target = "ifrm_boarding_downloader";
            document.brd_pnt.action = "report/ac-bus-tax-list-rolewise";            
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }
        
        function exportGSTExcelUserwise() {
            document.brd_pnt.target = "ifrm_boarding_downloader";
            document.brd_pnt.action = "report/ac-bus-tax-list-userwise";            
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }
        
        function exportGSTExcelSchedulewise() {
            document.brd_pnt.target = "ifrm_boarding_downloader";
            document.brd_pnt.action = "report/ac-bus-tax-list-schedulewise";            
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }

        function exportGSTExcelTripwise() {
            document.brd_pnt.target = "ifrm_boarding_downloader";
            document.brd_pnt.action = "report/ac-bus-tax-list-tripwise";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }
        
        function exportGSTExcelGSTwise() {
            document.brd_pnt.target = "ifrm_boarding_downloader";
            document.brd_pnt.action = "report/ac-bus-tax-list-gstwise";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }

        $('#date_from').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            //var fDate = new Date(e.date);
            //var end = new Date(fDate.setDate(fDate.getDate() + 31));
            //$('#date_to').datepicker('setStartDate', e.date);
            //$("#date_to").datepicker("setEndDate", end)
        });
        
        $('#date_to').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
            //var fDate = new Date(e.date);
            //var start = new Date(fDate.setDate(fDate.getDate() - 31));
            //$('#date_from').datepicker('setStartDate', start);
            //$('#date_from').datepicker('setEndDate', e.date)
        });
        
        function generateScheduleWiseReport() {
            $('#gst-schedule').html('');
            var data = {};            
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.date_option = $('#date_option').val();
            data.gst_filter = $('#gst_filter').val();

            var err = 0;

            if (data.from_date == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }
            
            if (data.to_date == '') {
                $('#date_to').addClass('inp_error');
                err++;
            } else {
                $('#date_to').removeClass('inp_error');
            }
            
            /*if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);
                
                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#date_to').addClass('inp_error');
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#usr-action-state').html('Date range should be 31 days or less');
                    $('#usr-action-state').show();
                    err++;
                    return false;
                }
            }*/

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
            $('#boarding-point-list-container').removeClass('hidden');
            $('#gst-schedule').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/ac-bus-tax-list-schedulewise",
                data: data,
                success: function (response) {
                    $('#gst-schedule').html(response);
                }
            })
        }
        
        function generateUserWiseReport() {
            $('#gst-user').html('');
            var data = {};            
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.date_option = $('#date_option').val();
            data.gst_filter = $('#gst_filter').val();

            var err = 0;

            if (data.from_date == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }
            
            if (data.to_date == '') {
                $('#date_to').addClass('inp_error');
                err++;
            } else {
                $('#date_to').removeClass('inp_error');
            }
            
            /*if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);
                
                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#date_to').addClass('inp_error');
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#usr-action-state').html('Date range should be 31 days or less');
                    $('#usr-action-state').show();
                    err++;
                    return false;
                }
            }*/

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
            $('#boarding-point-list-container').removeClass('hidden');
            $('#gst-user').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/ac-bus-tax-list-userwise",
                data: data,
                success: function (response) {
                    $('#gst-user').html(response);
                }
            })
        }
        
        function generateRoleWiseReport() {
            $('#gst-role').html('');
            var data = {};            
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.date_option = $('#date_option').val();
            data.gst_filter = $('#gst_filter').val();

            var err = 0;

            if (data.from_date == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }
            
            if (data.to_date == '') {
                $('#date_to').addClass('inp_error');
                err++;
            } else {
                $('#date_to').removeClass('inp_error');
            }
            
            /*if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);
                
                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#date_to').addClass('inp_error');
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#usr-action-state').html('Date range should be 31 days or less');
                    $('#usr-action-state').show();
                    err++;
                    return false;
                }
            }*/

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
            $('#boarding-point-list-container').removeClass('hidden');
            $('#gst-role').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/ac-bus-tax-list-rolewise",
                data: data,
                success: function (response) {
                    $('#gst-role').html(response);                    
                }
            })
        }

        function searchTaxReport() {
            $('#gst-state').html('');
            var data = {};            
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.date_option = $('#date_option').val();
            data.gst_filter = $('#gst_filter').val();

            var err = 0;

            if (data.from_date == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }
            
            if (data.to_date == '') {
                $('#date_to').addClass('inp_error');
                err++;
            } else {
                $('#date_to').removeClass('inp_error');
            }
            
            /*if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);
                
                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#date_to').addClass('inp_error');
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#usr-action-state').html('Date range should be 31 days or less');
                    $('#usr-action-state').show();
                    err++;
                    return false;
                }
            }*/

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
            $('#boarding-point-list-container').removeClass('hidden');
            $('#gst-state').html(loading_popup);
            
            $('#gst-role').html('');
            $('#gst-user').html('');
            $('#gst-schedule').html('');
            
            $('#report-tabs a:first').tab('show');
            
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/ac-bus-tax-list-statewise",
                data: data,
                success: function (response) {
                    $('#gst-state').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            })
        }

        function clearReport() {
            $('#date_from').val('');
            $('#date_to').val('');
            $('#date_option').val(0);
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', end);
           
            $('#date_to').datepicker('setStartDate', start);
            $('#date_to').datepicker('setEndDate', end);

            $('#boarding-point-list-container').addClass('hidden');
            $('#gst-state').html('');
            $('#gst-role').html('');
            $('#gst-user').html('');
            $('#gst-schedule').html('');
            
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();

            $('#d_head_export_panel').addClass('hidden');
        }

        function generateTripWiseReport() {
            $('#gst-trip').html('');
            var data = {};
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.date_option = $('#date_option').val();
            data.gst_filter = $('#gst_filter').val();

            var err = 0;

            if (data.from_date == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }

            if (data.to_date == '') {
                $('#date_to').addClass('inp_error');
                err++;
            } else {
                $('#date_to').removeClass('inp_error');
            }

            /*if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);

                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#date_to').addClass('inp_error');
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#usr-action-state').html('Date range should be 31 days or less');
                    $('#usr-action-state').show();
                    err++;
                    return false;
                }
            }*/

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

            $('#date_to').removeClass('inp_error');
            $('#boarding-point-list-container').removeClass('hidden');
            $('#gst-trip').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/ac-bus-tax-list-tripwise",
                data: data,
                success: function (response) {
                    $('#gst-trip').html(response);
                }
            });
        }
        
        function generateGSTWiseReport() {
            $('#gst-gst').html('');
            var data = {};
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();
            data.date_option = $('#date_option').val();
            data.gst_filter = $('#gst_filter').val();

            var err = 0;

            if (data.from_date == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }

            if (data.to_date == '') {
                $('#date_to').addClass('inp_error');
                err++;
            } else {
                $('#date_to').removeClass('inp_error');
            }

            /*if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);

                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#date_to').addClass('inp_error');
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#usr-action-state').html('Date range should be 31 days or less');
                    $('#usr-action-state').show();
                    err++;
                    return false;
                }
            }*/

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

            $('#date_to').removeClass('inp_error');
            $('#boarding-point-list-container').removeClass('hidden');
            $('#gst-gst').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/ac-bus-tax-list-gstwise",
                data: data,
                success: function (response) {
                    $('#gst-gst').html(response);
                }
            });
        }
    </script>
{/literal}