<div class="brand_top">
    <h3>Notification Report</h3>
    <div class="text-right noprint" id="exc-tr" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="AllDownload()"><i class="fa fa-download fa-lg"></i>Download All</button>
            <button class="btn btn-default" onclick="exportTransExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                <form id='mytrans_form' name="trans_form" method="post" action="report/notification-report-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-3">
                                                            <label for="sms_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="sms_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-1">
                                                            <label for="sms_search_type">Medium</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="sms_search_type" name="notificationModeCode" class="form-control">
                                                                    <option value="NA">All</option>
                                                                    {foreach from=$notification_mode item=typename key=typecode}
                                                                        {if $typecode !=='APP'}
                                                                            <option value="{$typecode}">{$typename}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-1 hide">
                                                            <label for="sms_rpt_searchby">Search By</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="sms_rpt_searchby" name="sms_rpt_searchby" class="form-control" onchange="setSearchBy()">
                                                                    <option value="1">Notification Type</option>
                                                                    <option value="2">Mobile</option>
                                                                    <option value="3">PNR</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2" id="bytype">
                                                            <label for="sms_rpt_noti_type">Notification Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="sms_rpt_noti_type" name="notificationType" class="form-control">
                                                                <option value="CGBOT">ALL</option>
                                                                    {foreach name=o key=k item=row from=$sms_notification_type}
                                                                        <option value="{$row->code}" data-dynamic="{$row->isDynamic}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2" id="bymobile_pnr">
                                                            <label for="sms_rpt_mob_pnr">Mobile/PNR</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="mobile-pnr" class="form-control sdate input_capital" id="sms_rpt_mob_pnr" placeholder="Mobile/PNR">
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2 hide" id="bypnr">
                                                            <label for="sms_rpt_pnr">PNR</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="pnr" class="form-control sdate input_capital" id="pnr" placeholder="PNR Number">
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-3">
                                                            <label for="sms_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="downloadAll" id="ex_downloadAll" value="NA">
                                                                <button class="btn btn-success" type="button" onclick="smsUtilizationReport()">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTransReport()">Clear</button>
                                                            </div>
                                                        </div>
                                                        <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="cons_rpt_action_state"></div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                        <br class="clear_fix_both">
                                        <div class="align-center alert alert-danger pull-left" style="display:none" id="cancel_rpt_action_state"></div>
                                    </div><!--row end-->
                                </div><!--content end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row hidden" id="sms-utilization-list-container">
                <br>
                <div class="col-lg-12">
                    <div id="cons-booking-list"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>
{literal}
    <script>
        $('#sms_rpt_date_range').daterangepicker({
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

         var picker = $('#sms_rpt_date_range').data('daterangepicker');
         picker.container.find('.calendar').on('click', 'td.available', function() {
         setEndTime(picker);
          });

          function setEndTime(picker) {
              if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
              picker.setEndDate(moment(picker.endDate).endOf('day'));
               }
            }


        $('#sms_rpt_noti_type').select2();

        function clearTransReport() {
            $('#sms_rpt_date_range').val('');
            $('#sms-utilization-list-container').addClass('hidden');
            $('#cons-booking-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#cons_rpt_action_state').html('');
            $('#cons_rpt_action_state').hide();
            $('#exc-tr').hide();
            $('#sms_rpt_mob_pnr').val('');
            $('#sms_rpt_searchby').val(1);
            $('#bytype').removeClass('hide');
            $('#sms_search_type').val('NA').trigger('change');
        }

        function smsUtilizationReport() {
            $('#cons-booking-list').html('');
            var err = 0;
            $('.inp_error').removeClass('inp_error');

            var data = {};
            data.dateRange = $('#sms_rpt_date_range').val();
            data.notificationModeCode = $('#sms_search_type').val();
           
            data.notificationType = $('#sms_rpt_noti_type').val();
            data.mobile_pnr = $('#sms_rpt_mob_pnr').val();
          
            console.log(data);  
            if (data.dateRange == '') {
                $('#sms_rpt_date_range').addClass('inp_error');
                err++;
            } else {
                $('#sms_rpt_date_range').removeClass('inp_error');
            }

           

            if (err > 0) {
                $('#cons_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#cons_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#cons_rpt_action_state').show();
                return false;
            } else {
                $('#cons_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#cons_rpt_action_state').html('');
                $('#cons_rpt_action_state').hide();
            }
            var html = "";
            $('#sms_rpt_date_range').removeClass('inp_error');
            $('#sms-utilization-list-container').removeClass('hidden');
            $('#cons-booking-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/notification_report_list",
                data: data,
                success: function(response) {
                    $('#cons-booking-list').html(response);
                    $('#exc-tr').show();
                }
            })
        }

        function exportTransExcel() {
            document.trans_form.action = "report/notification-report-list";
            document.trans_form.target = "ifrm_trans_downloader";
            $('#export').val(1);
            document.trans_form.submit();
            return;
        }

        function exportTalyExcel() {
            document.trans_form.action = "report/notification-report-list-tally";
            document.trans_form.target = "ifrm_trans_downloader";
            $('#export').val(1);
            document.trans_form.submit();
            return;
        }

        function AllDownload() {
            document.trans_form.action = "report/notification-report-list-Download";
            document.trans_form.target = "ifrm_trans_downloader";
            $('#ex_downloadAll').val('NA');
            document.trans_form.submit();
            return;
        }
    </script>
{/literal}

