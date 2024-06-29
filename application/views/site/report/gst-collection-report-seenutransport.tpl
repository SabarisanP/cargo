<div class="brand_top">
    <h3>GST Collection Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            A date range above 7 days will automatically download excel rather than listing the data.
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

                                                <form id='con_bk_rpt' method="post" name="con_bk_rpt" action="report/gst-collection-report-list" onsubmit="return false">
                                                    <div class="row">   

                                                    <div class="form-group col-md-3">
                                                    <label for="gst_rpt_date_range" class="req">Date Range</label>
                                                    <div class="input-group">
                                                        <input type="text" name="dateRange" class="form-control sdate" id="gst_rpt_date_range" readonly="true" placeholder="Date Range">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                    </div>
                                                        {* <div class="form-group col-md-2">
                                                            <label  for="gst_rpt_filter_type">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="gst_rpt_filter_type" name="filterType"  class="form-control" >
                                                                    <option value='GST' selected="">GST</option>
                                                                    <option value='NON_GST'>NON GST</option>
                                                                </select>
                                                            </div>
                                                        </div> *}

                                                        <div class="form-group col-md-2">
                                                        <label for="gst-rpt-branch" class="">Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="gst-rpt-branch" name="organizationCode" class="form-control">
                                                                <option value="NA" data-brachcode="NA">All Branch</option>
                                                                {foreach item=branch from=$organization key=bcode}
                                                                    <option value="{$branch->code}" data-brachcode="{$branch->station->code}">{$branch->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>


                                                        <div class="form-group col-md-2 none" id="freight_amt">
                                                            <label  for="gst_rpt_freight_amt">Freight Amount More Than</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="number" id="gst_rpt_freight_amt" name="freightAmount" class="form-control">
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="searchCargoTrnsBooking();" id="generate-list">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearCargoTrnsReport();">Clear</button>
                                                            </div>
                                                        </div>

                                                    </div>
                                               
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="gst_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="gst-collections-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                        <div id="gst-report-list" class="tab-pane fade in active"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_consolidate_downloader" id="ifrm_consolidate_downloader" style="display:none"></iframe>  

    <script>
    var organization = {$organization|json_encode};

       $('#gst_rpt_date_range').daterangepicker({
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
        }).on('show.daterangepicker', function(ev, picker) {
        setEndTime(picker);
        picker.showCalendars();
         });

         var picker = $('#gst_rpt_date_range').data('daterangepicker');
         picker.container.find('.calendar').on('click', 'td.available', function() {
         setEndTime(picker);
          });

          function setEndTime(picker) {
              if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
              picker.setEndDate(moment(picker.endDate).endOf('day'));
               }
            }

        $('#gst_rpt_filter_type').on('change', function(){
            if($('#gst_rpt_filter_type').val() == 'NON_GST'){
                $('#freight_amt').removeClass('none')
            }else{
                $('#freight_amt').addClass('none')
            }
        })

        function exportCargoTransExcel() {
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#export').val(1);
            document.con_bk_rpt.submit();
            return;
        }

        function searchCargoTrnsBooking() {
            $('#gst-report-list').html('');
            var data = {};
            data.dateRange = $('#gst_rpt_date_range').val();
            var dateRangeString = $('#gst_rpt_date_range').val();
            var dateRangeArray = dateRangeString.split(' | ');
            // var options = { year: 'numeric', month: 'long', day: 'numeric' };
            // var fromDate = new Date(dateRangeArray[0]);
            // var toDate = new Date(dateRangeArray[1]);
            // var options = { year: 'numeric', month: 'long', day: 'numeric' };
            // fromDate = fromDate.toLocaleDateString('en-US', options);
            // toDate = toDate.toLocaleDateString('en-US', options);
            // console.log(fromDate);
            // if (!isNaN(fromDate.getTime()) && !isNaN(toDate.getTime())) {
            // fromDate = fromDate.toISOString().split('T')[0];
            // toDate = toDate.toISOString().split('T')[0];

            // }
            data.filterType = $('#gst_rpt_filter_type').val();
            data.freightAmount = $('#gst_rpt_freight_amt').val() || 0;

        
            // if(toDate.diff(fromDate, 'days') >= 7) {
            //     $('#gst-collections-list-container').removeClass('hidden');
            //     $('#gst-report-list').html('Your Excel Is Downloading Now'+ loading_popup);
            //     $('#generate-list').prop('disabled', true);
            //     $('#excl_cons').hide();
            //     exportCargoTransExcel();
            //     setTimeout(function() {
            //         $('#generate-list').prop('disabled', false); 
            //         $('#gst-collections-list-container').addClass('hidden');
            //     }, 3000);
            //     return false;
            // }

            var err = 0;
           

            if (data.dateRange == '') {
            $('#gst_rpt_date_range').addClass('inp_error');
            err++;
        } else {
            $('#gst_rpt_date_range').removeClass('inp_error');
        }

            if (err > 0) {
                $('#gst_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#gst_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#gst_rpt_action_state').show();
                return false;
            } else {
                $('#gst_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#gst_rpt_action_state').html('');
                $('#gst_rpt_action_state').hide();
            }
            var html = "";
            $('#gst_rpt_date_range').removeClass('inp_error');
            $('#gst-collections-list-container').removeClass('hidden');
            $('#gst-report-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/gst-collection-report-list",
                data: data,
                success: function (response) {
                    $('#gst-report-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#gst-collections-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }


        function clearCargoTrnsReport() {
            $('#gst_rpt_date_range').val('');
            $('#gst_rpt_freight_amt').val('');
            $('#gst_rpt_filter_type').val('GST').trigger('change');

            $('#gst-collections-list-container').addClass('hidden');
            $('#gst-report-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#gst_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#gst_rpt_action_state').html('');
            $('#gst_rpt_action_state').hide();

            $('#excl_cons').hide();
        }


    </script>

