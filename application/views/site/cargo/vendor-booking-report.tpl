<div class="brand_top">
    <h3>Vendor Booking Report</h3> 
    <div class="text-right noprint" id="vendor_bkg_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportVendorBookingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
            <button class="btn btn-default" onclick="exportBranchCollectionsPdf();"><i class="fa fa-print fa-lg"></i> PDF</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the specific vendor booking LR's with details.                 
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

                                                <form id='vendor_bkg_form' action="" method="post" name="vendor_bkg_form" onsubmit="return false">
                                                    <div class="row">   
                                                         <div class="form-group col-md-3">
                                                            <label for="vendor_bkg_date_range">Date Range</label>
                                                            <div class="input-group">
                                                               <input type="text" name="fromDate" class="form-control sdate" id="vendor_bkg_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                               <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-3">
                                                            <div class="input-group col-md-12">
                                                                <label for="vendor-bkg-users">Vendor</label>
                                                                <select id="vendor-bkg-users" name="vendorCode" class="form-control" placeholder="select vendore"> 
                                                                    {if $action_rights['EBL-ALL-VENDOR']>0}
                                                                        <option value="NA">All Vendors</option>
                                                                    {/if}  
                                                                    {foreach item=vendor_usr from=$vendors} 
                                                                        {if $action_rights['EBL-ALL-VENDOR']>0 || $vendor_usr->user->code == $usr_login_id}
                                                                            <option value="{$vendor_usr->code}" {if $vendor_usr->user->code == $usr_login_id}selected{/if}>{$vendor_usr->companyName}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>         
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" id="fromDate" name="fromDate">
                                                                <input type="hidden" id="toDate" name="toDate">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button"  onclick="getVendorBookingReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearVendorBookingReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="vendor_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="vendor-booking-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="vendor-booking-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_vendor_bkg_downloader" id="ifrm_vendor_bkg_downloader" style="display:none"></iframe>  
   
{* <div id="gallery-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideProofGallery();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="proof-gallery-panel" class="clearfix" style="padding: 10px 5px;">
        <div>
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#tab_pob" role="tab" data-toggle="tab">POB</a></li>
                <li role="presentation"><a href="#tab_pod" role="tab" data-toggle="tab">POD</a></li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="tab_pob">
                    <label class="proof-gallery-document"></label>
                    <div class="file-upload-gallery dialog-gallery"></div>
                </div>
                <div role="tabpanel" class="tab-pane" id="tab_pod">
                    <label class="proof-gallery-document"></label>
                    <div class="file-upload-gallery dialog-gallery"></div>
                </div>
            </div>
        </div>

        <div id="proof-gallery-alert"></div>
    </div>
</div>    *}

{* <div class="col-md-12 hide">
    {include file="site/cargo/file-store-component.tpl" id="proof1-fileupload" axis="horizontal"}
</div> *}
<script>                                      
    if(!proofupload){
        var proofupload = new fileUpload('#proof-fileupload');
    }
   
    $('#vendor_bkg_date_range').daterangepicker({
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

    {if $action_rights['EBL-ALL-VENDOR']==1}
        $('#vendor-bkg-users').select2({
            width: '100%'
        });
    {/if}
    
    function exportVendorBookingExcel(){
        var daterange = $('#vendor_bkg_date_range').data('daterangepicker');
        var fromDate = daterange.startDate.format('DD-MM-YYYY');
        var toDate = daterange.endDate.format('DD-MM-YYYY');
        $('#fromDate').val(fromDate);
        $('#toDate').val(toDate);
        $('#pdf').val('');
        $('#export').val(1);
        document.vendor_bkg_form.action = "cargo/vendor-booking-report-list";
        document.vendor_bkg_form.target = "ifrm_vendor_bkg_downloader";
        document.vendor_bkg_form.submit();
        return;
    }
    
    function clearVendorBookingReport() {
       
        $('#vendor_bkg_date_range').val('');
        $('#vendor_bkg_date_range').data('daterangepicker').setStartDate({});
        $('#vendor_bkg_date_range').data('daterangepicker').setEndDate({});
        $('#vendor-bkg-users option:first').prop('selected', true);
        $('#vendor-bkg-users option:first').trigger('change')
        $('#vendor-booking-list-container').addClass('hidden');
        $('#vendor-booking-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#vendor_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#vendor_rpt_action_state').html('');
        $('#vendor_rpt_action_state').hide();
        $('#vendor_bkg_excel').hide();
    }
    
    function getVendorBookingReport(){
        $('#vendor-booking-list').html('');
        var data = {};
        var daterange = $('#vendor_bkg_date_range').data('daterangepicker');
        data.fromDate = daterange.startDate.format('DD-MM-YYYY');
        data.toDate = daterange.endDate.format('DD-MM-YYYY');
        data.vendorCode = $('#vendor-bkg-users').val();
        
        var err = 0;
        $('#vendor-bkg-users').removeClass('inp_error');
       
        if (data.vendorCode == '') {
            $('#vendor-bkg-users').addClass('inp_error');
            err++;
        }
        if (err > 0) {
            $('#vendor_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#vendor_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#vendor_rpt_action_state').show();
            return false;
        } else {
            $('#vendor_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#vendor_rpt_action_state').html('');
            $('#vendor_rpt_action_state').hide();
        }
        
        $('#vendor-booking-list-container').removeClass('hidden');
        $('#vendor-booking-list').html(loading_popup);
        
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/vendor-booking-report-list",
            data: data,
            success: function (response) {
                $('#vendor-booking-list').html(response);
                $('#vendor_bkg_excel').show();
                $("html, body").animate({
                    scrollTop: $('#vendor-booking-list-container').offset().top - 35
                }, "slow");
            }
        });
    }
    function exportBranchCollectionsPdf() {
        var daterange = $('#vendor_bkg_date_range').data('daterangepicker');
        var fromDate = daterange.startDate.format('DD-MM-YYYY');
        var toDate = daterange.endDate.format('DD-MM-YYYY');
        $('#fromDate').val(fromDate);
        $('#toDate').val(toDate);
        $('#export').val('');
        $('#pdf').val(1);
        document.vendor_bkg_form.action = "cargo/vendor-booking-report-list";
        document.vendor_bkg_form.target = "irm_downloader";
        document.vendor_bkg_form.submit();
        return;
    }
</script>