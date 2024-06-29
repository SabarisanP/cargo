<div class="brand_top">
    <h3>Ticket Transfer Details</h3> 
    <div class="text-right noprint" id="tkt-tfr-export" style="display: none">
        <div class="btn-group btn-group-sm">            
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
            <button class="btn btn-default" onclick="exportTktTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                        <div id="search-panel">    
                                            <form id='tkt_tfr_form' name="tkt_tfr_form" method="post" action="report/sms-utilization-report-list" onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-2">
                                                        <label for="tkt_tfr_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="from" class="form-control sdate" id="tkt_tfr_from" readonly="true" placeholder="Date From">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="tkt_tfr_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="to" class="form-control sdate" id="tkt_tfr_to" readonly="true" placeholder="Date To">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>  
                                                    <div class="form-group col-md-2">
                                                        <label for="tkt_tfr_flag">Date Option</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="tkt_tfr_flag" name="travelDateFlag"  class="form-control">                                                                  
                                                                <option value="1">Travel Date</option>
                                                                <option value="0">Transaction Date</option>
                                                            </select>     
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="cons_rpt_date_to">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="getTicketTransfer()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearTicketTransfer()">Clear</button>
                                                        </div>
                                                    </div>        
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="tkt_tfr_action_state"></div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row hidden" id="tkt-tfr-list-container">
                <br>
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div id="tkt-tfr-list"></div>                                    
                        </div>
                    </div>
                </div>
            </div>

        </div>                    
    </div>
</div>            

<iframe name="ifrm_tkt_tfr_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>                                                         
{literal}
<script>
    $('#tkt_tfr_from').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        startDate: '-3m',
        endDate: '+3m',
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 31));
        $('#tkt_tfr_to').datepicker('setStartDate', e.date);
        $('#tkt_tfr_to').datepicker('setEndDate', end)
    });
    $('#tkt_tfr_to').datepicker({
        todayHighlight: true,
        startDate: '-3m',
        endDate: '-0m',
        format: 'yyyy-mm-dd',
        autoclose: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var start = new Date(fDate.setDate(fDate.getDate() - 31));
        $('#tkt_tfr_from').datepicker('setStartDate', start);
        $('#tkt_tfr_from').datepicker('setEndDate', e.date)
    });
    function clearTicketTransfer() {
        $('#tkt_tfr_from').val('');
        $('#tkt_tfr_to').val('');
        $('#tkt_tfr_flag').val('')
        $('#tkt-tfr-list-container').addClass('hidden');
        $('#tkt-tfr-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#tkt_tfr_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#tkt_tfr_action_state').html('');
        $('#tkt_tfr_action_state').hide();
        $('#tkt-tfr-export').hide();        
    }
    function getTicketTransfer(){
        $('#tkt-tfr-list').html('');
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.from = $('#tkt_tfr_from').val();
        data.to = $('#tkt_tfr_to').val();
        data.travelDateFlag = $('#tkt_tfr_flag').val(); 

        if (data.from == '') {
            $('#tkt_tfr_from').addClass('inp_error');
            err++;
        }
        if (data.to == '') {
            $('#tkt_tfr_to').addClass('inp_error');
            err++;
        }
        if (data.travelDateFlag == '') {
            $('#tkt_tfr_flag').addClass('inp_error');
            err++;
        }
        if (err > 0) {
            $('#tkt_tfr_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#tkt_tfr_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#tkt_tfr_action_state').show();
            return false;
        } else {
            $('#tkt_tfr_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#tkt_tfr_action_state').html('');
            $('#tkt_tfr_action_state').hide();
        }
        $('#tkt-tfr-list-container').removeClass('hidden');
        $('#tkt-tfr-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/ticket-transfer-report-list",
            data: data,
            success: function (response) {
                $('#tkt-tfr-list').html(response);
                $('#tkt-tfr-export').show();
            }
        })
    }
    function exportTktTransExcel() {
        document.tkt_tfr_form.action = "report/ticket-transfer-report-list";
        document.tkt_tfr_form.target = "ifrm_tkt_tfr_downloader";
        $('#export').val(1);
        document.tkt_tfr_form.submit();
        return;
    }
</script>
{/literal}