<div class="brand_top">
    <h3>Branch Sales Summary Report</h3>
    {* <div class="text-right noprint hide" id="branch-sales-report-excel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportVehicleHireExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div> *}
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows branchwise paid booked LR and paid net amount
        </div>
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            branchwise topay delivery amount and topay delivery net amount
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
                                            <form id='branch-sales-report' name="branch-sales-report" method="post" action="report/branch-sales-summary-report-list" onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-3">
                                                        <label for="branch-sales-date-range" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="branch-sales-date-range" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label  for="branch-sales-org" class="">Branch</label>
                                                        <select class="form-control" id="branch-sales-org" {if $action_rights['DET-BRCH-ALLBR'] != 1}disabled="disabled"{/if}>
                                                            <option value="NA">Select Branch</option>
                                                            {foreach from=$organization item=val}
                                                                <option value="{$val->code}" {if $logged_in_usr_org_code == $val->code}selected{/if}>{$val->name}</option>
                                                            {/foreach}
                                                        </select>  
                                                    </div>
                                                    
                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            {* <input type="hidden" name="export" id="export" value="1"> *}
                                                            <button class="btn btn-success" type="button"  onclick="generateBranchSalesReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBranchSalesReport()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="branch-sales-report-action-state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                        
                
                <div class="row hidden" id="branch-sales-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="branch-sales-list" style="width: 70%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                                        
            </div>                    
        </div>
    </div>            
</div>

<div id="branch-sales-details-dialog"  class="dialog-content-page hide">
    <div class="popup_top">
        <div class="row">
            <div class="col-md-10 bold ft_14">
                Branch Sales Details
            </div>
            <div class="col-md-2">            
                <a class="align-right" onclick="closeBranchSalesDetailsDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
            </div>
        </div>    
    </div>
    <div id="branch-sales-details-list"></div>     
</div>
{* <iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe> *}

<script>
    $('#branch-sales-date-range').daterangepicker({
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
        // setEndTime(picker);
        picker.showCalendars();
    });
    
    $('#branch-sales-org').select2();

    function generateBranchSalesReport() {
        $('#branch-sales-list').html('');
        var data = {};
        data.dateRange = $('#branch-sales-date-range').val();
        data.organizationCode = $('#branch-sales-org').val();
        data.filterType = 'SUMMARY';

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.dateRange == '') {
            $('#branch-sales-date-range').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#branch-sales-report-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#branch-sales-report-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#branch-sales-report-action-state').show();
            return false;
        } else {
            $('#branch-sales-report-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#branch-sales-report-action-state').html('');
            $('#branch-sales-report-action-state').hide();
        }
        
        $('#branch-sales-list-container').removeClass('hidden');
        $('#branch-sales-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/branch-sales-summary-report-list",
            data: data,
            success: function (response) {
                $('#branch-sales-list').html(response);
                // $('#zone_rcv_rpt_excel').removeClass('hide');
            }
        })
    }

    function clearBranchSalesReport() {
        $('#branch-sales-date-range').val('');
        $('#branch-sales-org').val('NA').trigger('change');
        $('#branch-sales-list-container').addClass('hidden');
        $('#branch-sales-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#branch-sales-report-action-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
        // $('#zone_rcv_rpt_excel').addClass('hide');
    }

    function getBranchSalesDetails(org, from, to) {
        $('#branch-sales-details-dialog').css('background', '#fff');
        $('#branch-sales-details-dialog').removeClass('hide');
        $('#branch-sales-details-dialog').dialog({
            autoOpen: true,
            height: 600,
            width: $(window).width() - 300,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        
        var data = {};
        data.fromDate = fromDate;
        data.toDate = toDate;
        data.organizationCode = org;
        data.filterType = 'DETAILS';

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/branch-sales-summary-report-detail-list",
            data: data,
            success: function (response) {
                $('#branch-sales-details-list').html(response);
            }
        });
    }

    function closeBranchSalesDetailsDialog() {
        $('#branch-sales-details-dialog').addClass('hide');
        $('#branch-sales-details-dialog').dialog('destroy');
    }
    // function exportVehicleHireExcel() {
    //     document.zone_rcv_rpt_form.target = "ifrm_downloader";
    //     $('#export').val(1);
    //     document.zone_rcv_rpt_form.submit();
    //     return;
    // }
</script>

