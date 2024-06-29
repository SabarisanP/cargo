<div class="brand_top">
    <h3>Trip Cancel Refund</h3> 
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="payment/tripcancel-acknowledgement-list" onsubmit="return false">
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
                                                        
                                                        <div class="form-group col-md-3">        
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="searchTripCancelList();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                        </div>
                                                    </div>            
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="tca-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="tripcancel-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="tripcancel-list"></div>                                    
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

        function exportTripCancelExcel() {
            document.brd_pnt.target = "ifrm_downloader";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }
        
        function chkAllPnr() {
            $(".tpnr").prop('checked', $('#checkAll').prop("checked"));
            $('#tc-action-state').html('');
        }

        $('#date_from').datepicker({
            format: 'yyyy-mm-dd',
            startDate: '-3m',
            endDate: "+3m",
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#date_to').datepicker('setStartDate', e.date);
            $("#date_to").datepicker("setEndDate", end)
        });
        
        $('#date_to').datepicker({
            startDate: '-3m',            
            endDate: "+3m",
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', e.date)
        });
        
        function tripCancelAcknowledge(opt) {
            $('#tc-action-state').html('');
            var pnrs = [];
            $('.tpnr:checked').each(function(){
                var t = $(this).val();
                var obj = _.find(tctickets, function(o) { return o.ticket_code == t; }); 
                pnrs.push(obj);
            });

            if(pnrs.length<=0) {
                $('#tc-action-state').html('<div class="alert alert-danger">Please select atleast one PNR.</div>');
                return;
            }
            
            var msg = 'Do you want to issue refund for these PNR?';
            if(opt==2)
                var msg = 'Do you want to remove this PNR from list?';

            if( confirm(msg) ) {
                $('#btnTripCancel').hide();
                $('#tripCancelProgressPane').removeClass('hide');
                $('.progress-bar').css('width','0%');
                tripCancelAckConfirm(pnrs, opt);
            }   
        }

        function tripCancelAckConfirm(pnrs, opt, i=0) {
            var data = {};
            data.pnr = pnrs[i];
            data.option = opt;
            
            $('#action-info').html('Initiating refund '+(i+1)+' of '+pnrs.length);
            
            $.ajax({
                type: "POST",
                url: "payment/tripcancel-confirm",
                data: data,
                dataType: 'json',
                success: function (res) {
                    var p = ((i+1)/pnrs.length) * 100;                        
                    $('.progress-bar').css('width',((++i/pnrs.length) * 100)+'%'); 
                    
                    if(res.status == 1){
                        $('#'+data.pnr.ticket_code).animate({backgroundColor: '#1AA1E1'}, 1000, function () {
                            $(this).remove();
                        });
                    }
                    
                    if( i < pnrs.length ) {
                        tripCancelAckConfirm(pnrs, opt, i);
                    } else {
                        window.setTimeout(function () {
                            searchTripCancelList();
                        }, 3000);
                    }
                }
            });
        }

        function searchTripCancelList() {
            $('#tripcancel-list').html('');
            var data = {};
            data.from_date = $('#date_from').val();
            data.to_date = $('#date_to').val();


            var err = 0;
            if (data.from_date == '') {
                $('#date_from').addClass('inp_error');
                err++;
            } else {
                $('#date_from').removeClass('inp_error');
            }
            
            if (data.from_date != '') {
                if (data.to_date == '') {
                    $('#date_to').removeClass('inp_error');
                    var d = new Date();
                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;
                    
                    var f = data.from_date.split('-');
                    var a = moment([d.getFullYear(), month, day]);
                    var b = moment([f[0], f[1], f[2]]);
                    var t = a.diff(b, 'days');
                    if(t>31){
                        err++;
                    }else {                    
                        data.to_date = output;
                        $('#date_to').val(output);
                    }
                }
            }
            
            if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);
                
                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#date_to').addClass('inp_error');
                    $('#tca-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#tca-action-state').html('Date range should be 31 days or less');
                    $('#tca-action-state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#tca-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#tca-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#tca-action-state').show();
                return false;
            } else {
                $('#tca-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#tca-action-state').html('');
                $('#tca-action-state').hide();
            }
            var html = "";
            
            $('#date_to').removeClass('inp_error');
            $('#tripcancel-list-container').removeClass('hidden');
            $('#tripcancel-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "payment/tripcancel-acknowledgement-list",
                data: data,
                success: function (response) {
                    $('#tripcancel-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            })
        }

        function clearReport() {
            $('#date_from').val('');
            $('#date_to').val('');
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#date_from').datepicker('setStartDate', start);
            $('#date_from').datepicker('setEndDate', end);
           
            $('#date_to').datepicker('setStartDate', start);
            $('#date_to').datepicker('setEndDate', end);

            $('#tripcancel-list-container').addClass('hidden');
            $('#tripcancel-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#tca-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#tca-action-state').html('');
            $('#tca-action-state').hide();

            $('#d_head_export_panel').addClass('hidden');
        }

    </script>
{/literal}