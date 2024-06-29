<div class="brand_top">
    <h3>Zone Receivable Report</h3>
    {* <div class="text-right noprint hide" id="brn_con_rpt_excel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBranchConsolidationExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div> *}
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the branch collection amount based on grouping multiple branch.                 
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
                                            <form id='zone_rcv_report' name="zone_rcv_report" method="post" action="report/zone-receivable-report-list" onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-4">
                                                        <label for="zone_rcv_date_range" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="zone_rcv_date_range" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    
                                                    {* {if $action_rights['BRN-CONS-ALL-ZONE'] == 1 && $action_rights['EBL-ALL-STATION'] == 1} *}
                                                        <div class="form-group col-md-2">
                                                            <label for="zone-rcv-zone" class="">Zone</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="zone-rcv-zone" name="zoneCode" class="form-control">
                                                                    <option value="NA" selected="">All Zone</option>
                                                                    {foreach key=key item=row from=$zone}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    {* {/if} *}

                                                    <div class="form-group col-md-2">
                                                        <label for="zone-transaction-type" class="">Type</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="zone-transaction-type" name="dateType" class="form-control">
                                                                <option value="BOOKING">Booking</option>
                                                                <option value="DELIVERY">Delivery</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button"  onclick="searchZoneReceivableReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearZoneReceivableReport()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br class="clear_fix_both">
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="zone_rcv_rpt_action_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                        
                
                <div class="row hidden" id="zone-rcv-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="zone-rcv-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
                                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<div id="zone-rcv-rpt-details-dialog"  class="dialog-content-page hide">
    <div id="zone-rcv-details-list"></div>     
</div>

<script>
    $('#zone_rcv_date_range').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY',
        separator: ' | ',
        timePicker: false,
        ranges: {
            'Today': [moment().startOf('day'), moment().endOf('day')],
            'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
            'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
            'Last 30 Days': [moment().subtract(29, 'days').startOf('day'), moment().endOf('day')],
        },
    }).on('show.daterangepicker', function (ev, picker) {
        setEndTime(picker);
        picker.showCalendars();
    });

    var picker = $('#zone_rcv_date_range').data('daterangepicker');
    picker.container.find('.calendar').on('click', 'td.available', function () {
        setEndTime(picker);
    });

    function setEndTime(picker) {
        if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
            picker.setEndDate(moment(picker.endDate).endOf('day'));
        }
    }
    $('#zone-rcv-zone').select2();

    function searchZoneReceivableReport() {
        $('#zone-rcv-list').html('');
        var data = {};
        data.dateRange = $('#zone_rcv_date_range').val();
        data.zoneCode = $('#zone-rcv-zone').val();
        data.transactionType = $('#zone-transaction-type').val();
        data.filterType = 'SUMMARY';

        var err = 0;
        if (data.dateRange == '') {
            $('#zone_rcv_date_range').addClass('inp_error');
            err++;
        }else{
            $('#zone_rcv_date_range').removeClass('inp_error');
        }

        if (err > 0) {
            $('#zone_rcv_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#zone_rcv_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#zone_rcv_rpt_action_state').show();
            return false;
        } else {
            $('#zone_rcv_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#zone_rcv_rpt_action_state').html('');
            $('#zone_rcv_rpt_action_state').hide();
        }
        
        $('#zone_rcv_date_range').removeClass('inp_error');
        $('#zone-rcv-list-container').removeClass('hidden');
        $('#zone-rcv-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/zone-receivable-report-list",
            data: data,
            success: function (response) {
                $('#zone-rcv-list').html(response);
                // $('#zone_rcv_rpt_excel').removeClass('hide');
            }
        })
    }

    function clearZoneReceivableReport() {
        $('#zone_rcv_date_range').val('');
        $('#zone-transaction-type').val('BOOKING');
        $('#zone-rcv-zone').val('').trigger('change');
        $('#zone-rcv-list-container').addClass('hidden');
        $('#zone-rcv-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#zone_rcv_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        // $('#zone_rcv_rpt_excel').addClass('hide');
    }

    function getDetailsDialog(branch_code, zone_code) {
        event && event.stopPropagation();

        $('#zone-rcv-rpt-details-dialog').css('background', '#fff');
        $('#zone-rcv-rpt-details-dialog').removeClass('hide');
        $('#zone-rcv-rpt-details-dialog').dialog({
            autoOpen: true,
            height: 600,
            // width: 1500,
            width: $(window).width() - 100,
            modal: true,
            resizable: false,
            closeOnEscape: true,
        });
        $('.ui-dialog-titlebar').hide();

        var data = {};
        data.zone_code = zone_code;
        data.branch_code = branch_code;
        
        data.fromDate = fromDate;
        data.toDate = toDate;
        data.zoneCode = zoneCode;
        data.transactionType = transactionType;
        data.filterType = 'DETAILS';

        $('#zone-rcv-details-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/zone-receivable-report-details-list",
            data: data,
            success: function (response) {
                $('#zone-rcv-details-list').html(response);
            }
        })
    }

    function closeDetailsDialog() {
        $('#zone-rcv-rpt-details-dialog').addClass('hide');
        $('#zone-rcv-rpt-details-dialog').dialog('destroy');
    }

    // function exportBranchConsolidationExcel() {
    //     document.zone_rcv_rpt_form.target = "ifrm_downloader";
    //     $('#export').val(1);
    //     document.zone_rcv_rpt_form.submit();
    //     return;
    // }
</script>

