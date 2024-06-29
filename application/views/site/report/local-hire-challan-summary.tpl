<style type="text/css" media="print">
        @page {
            size: landscape;
        }

        @media print {
            body {
                -webkit-print-color-adjust: exact !important;
                /* Chrome, Safari */
                color-adjust: exact !important;
                /* Firefox */
            }

            .print-footer {
                position: fixed;
                bottom: 10px;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }
        }
    </style>
<div class="brand_top">
    <h3>Local Hire Challan Summary</h3>
    <div class="text-right" id="excl_sum" style="display:none">
    <div class="btn-group btn-group-sm shirt-design">
        <button class="btn btn-default" onclick="exportChallanSummaryExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
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

                                                <form id='hire_chl_sum_rpt' method="post" name="hire_chl_sum_rpt" action="report/local-hire-challan-summary-report" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-3">
                                                        <label for="local_hier_chl_summary_date" class="req">Date
                                                            Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange"
                                                                class="form-control sdate" id="local_hier_chl_summary_date"
                                                                readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i
                                                                    class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="local_hier_chl_summary_vehicle">Vehicle</label>
                                                        <div class="input-group">
                                                            <select id="local_hier_chl_summary_vehicle" name="vehicleCode"
                                                                class="form-control select2">
                                                                <option value="NA" selected="">Select Vehicle</option>
                                                                {foreach item=row from=$vehicles}
                                                                    {if $row->activeFlag == 1}
                                                                        <option value="{$row->code}">{$row->registationNumber} -
                                                                            {$row->vehicleType->name}</option>
                                                                    {/if}
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="from-group col-md-2 hidden">
                                                        <label for="hire_chl_summary_transitType">transitTypeCode</label>
                                                        <div class="input-group ">
                                                            <select id="hire_chl_summary_transitType"  name="transitType" class="form-control">
                                                            <option value="INTRNT" selected>transitTypeCode</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                   

                                                    <div class="from-group col-md-1">
                                                        <label for="hire_chl_summary_OwnerShip">Owner Ship</label>
                                                        <div class="input-group">
                                                            <select id="hire_chl_summary_OwnerShip" name="ownerShipType"
                                                                class="form-control">
                                                                <option value="OWN">Own</option>
                                                                <option value="ATCH">Attached</option>
                                                                <option value="HIRE">Hire/Walk-In</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="from-group col-md-2 hidden">
                                                    <label for="hire_chl_summary_transporterCode">transporterCode</label>
                                                        <div class="input-group">
                                                            <select id="hire_chl_summary_transporterCode" name="transporterCode" class="form-control">
                                                                <option value="NA" selected>transporterCode</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-3">
                                                    <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                        <input type="hidden" name="export" id="export" value="">
                                                        <input type="hidden" name="transitType" id="hire_chl_transitType" value="">
                                                            <button class="btn btn-success" type="button"
                                                                onclick="searchHireChallanSummary();" style="margin-bottom: 0px;">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear"
                                                            onclick="clearHireSummary();" style="margin-bottom: 0px;">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none"
                                                id="hire_summary_rpts"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="local_hier-chl-summary-list-container">
                        <br>
                        <div class="col-lg-12">

                            <div id="local_hier-chl-summary-list"></div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe id="ifrm_download" name="ifrm_download" style="display: none"></iframe>
<script>
    $('#local_hier_chl_summary_date').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY',
        separator: ' | ',
        timePicker: false,
        ranges: {
            'Today': [moment().startOf('day'), moment().endOf('day')],
            'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf(
                'day')],
            'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
            'Last 30 Days': [moment().subtract(29, 'days').startOf('day'), moment().endOf('day')],
        },
    }).on('show.daterangepicker', function(ev, picker) {
        setEndTime(picker);
        picker.showCalendars();
    });

    var picker = $('#local_hier_chl_summary_date').data('daterangepicker');
    picker.container.find('.calendar').on('click', 'td.available', function() {
        setEndTime(picker);
    });

    function setEndTime(picker) {
        if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
            picker.setEndDate(moment(picker.endDate).endOf('day'));
        }
    }

    $('#excl_sum').hide();

    function searchHireChallanSummary() {
        
        $('#local_hier-chl-summary-list').html('');
        var err = 0;
        var data = {};
        data.dateRange = $('#local_hier_chl_summary_date').val();
        data.vehicleCode = $('#local_hier_chl_summary_vehicle').val();
        data.transitTypeCode = $('#hire_chl_summary_transitType').val();
        data.ownerShipType = $('#hire_chl_summary_OwnerShip').val();
        data.transporterCode = $('#hire_chl_summary_transporterCode').val();
        console.log(data);

        if (data.dateRange == '') {
            $('#local_hier_chl_summary_date').addClass('inp_error');
            err++;
        } else {
            $('#local_hier_chl_summary_date').removeClass('inp_error');
        }

        if (err > 0) {
            $('#hire_summary_rpts').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#hire_summary_rpts').html('Please enter/select the values in the field that are marked in red');
            $('#hire_summary_rpts').show();
            return false;
        } else {
            $('#hire_summary_rpts').removeClass('alert-success').removeClass('alert-danger');
            $('#hire_summary_rpts').html('');
            $('#hire_summary_rpts').hide();
        }

        var html = "";
        $('#local_hier-chl-summary-date').removeClass('inp_error');
        $('#local_hier-chl-summary-list-container').removeClass('hidden');
        $('#local_hier-chl-summary-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/local-hire-challan-summary-report",
            data: data,
            success: function(response) {
                $('#local_hier-chl-summary-list').html(response);
                $('#excl_sum').show();
            }
           
        })
    }

    function clearHireSummary () {
        $('#local_hier_chl_summary_date').val('');
        $('#local_hier_chl_summary_vehicle').val('NA');
        $('#local_hier_chl_summary_transporterCode').val('');
        $('#hire_chl_summary_OwnerShip').val('OWN');
        $('#local_hier-chl-summary-list').html('');
        $('#local_hier-chl-summary-list-container').addClass('hidden');
        $('.inp_error').removeClass('inp_error');
        $('#hire_summary_rpts').removeClass('alert-success').removeClass('alert-danger');
        $('#hire_summary_rpts').html('');
        $('#hire_summary_rpts').hide();
        $('#excl_sum').hide();
    }

    function exportChallanSummaryExcel(){
        $('#export').val(1);
        $('#print').val('');
        $('#hire_chl_transitType').val($('#transitTypeCode').val());
        document.hire_chl_sum_rpt.action = "report/local-hire-challan-summary-report";
        document.hire_chl_sum_rpt.target = "ifrm_download";
        document.hire_chl_sum_rpt.submit();
        return;

        }
</script>