<div class="brand_top">
    <h3>Branch Consolidation Report</h3>
    <div class="text-right noprint hide" id="brn_con_rpt_excel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBranchConsolidationExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows overall booking and delivery transaction details based on branch                 
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
                                            <form id='brn_con_rpt_form' name="brn_con_rpt_form" method="post" action="report/branch-consolidation-report-list" onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-4">
                                                        <label for="brn_con_range" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="brn_con_range" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    
                                                    {if $action_rights['BRN-CONS-ALL-ZONE'] == 1 && $action_rights['EBL-ALL-STATION'] == 1}
                                                        <div class="form-group col-md-2">
                                                            <label for="brn-con-zone" class="">Zone</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="brn-con-zone" name="zoneCode" class="form-control">
                                                                    <option value="NA" selected="">All Zone</option>
                                                                    {foreach key=key item=row from=$zone}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    {/if}

                                                    <div class="form-group col-md-2">
                                                        <label for="brn-con-station" class="">Station</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="brn-con-station" name="station"  class="form-control" {if $action_rights['EBL-ALL-STATION']!=1}disabled{/if}>
                                                                <option value="NA" selected="">All Station</option>
                                                                {foreach key=key item=row from=$station}
                                                                    <option value="{$row->station->code}" {if $user_profile->organization->station->code == $row->station->code}selected{/if}>{$row->station->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button"  onclick="searchBRNCONReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBRNCONReport()">Clear</button>
                                                        </div>
                                                    </div>
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="brn_con_rpt_action_state"></div>
                                                </div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                        
                
                <div class="row hidden" id="brn-con-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="brn-con-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
                                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>


<script>
    var zoneData = {$zone|json_encode};
    var stationData = {$station|json_encode};

    $('#brn_con_range').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY HH:mm',
        separator: ' | ',
        timePicker: true,
        timePicker12Hour: false,
        timePickerIncrement: 1,
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

    var picker = $('#brn_con_range').data('daterangepicker')
    picker.container.find('.calendar').on('click', 'td.available', function () {
        setEndTime(picker);
    });

    function setEndTime(picker) {
        if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
            picker.setEndDate(moment(picker.endDate).endOf('day'));
        }
    }

    $('#brn-con-station').select2();
    //$('#brn-cons-users').select2();

    /* var $usrOptions = $('#brn-cons-users option');
    var emptyOption = '<option value="">Select User</option>';

    $('#brn-cons-station').on('change', function () {
        var organization = $(this).val();

        $('#brn-cons-users').html(function () {
            return $usrOptions.filter(function () {
                return $(this).data('org') === organization;
            });
        }).prepend(emptyOption).val('').trigger('change');
    }).trigger('change'); */

    $('#brn-con-zone').select2();
    
    $('#brn-con-zone').on('change', function () {
        var zoneCode = $('#brn-con-zone').val();
        var zone = _.find(zoneData, zone => zone.code == zoneCode);
        var stations = zone ? zone.stations : stationData;

        $('#brn-con-station').html(new Option('All Station', 'NA'));
        $.each(stations || [], function (i, station) {
            $('#brn-con-station').append(new Option(station.name, station.code));
        });
        $('#brn-con-station').val('NA').trigger('change');
    });

    function searchBRNCONReport() {
        $('#brn-con-list').html('');
        var data = {};
        data.dateRange = $('#brn_con_range').val();
        data.zoneCode = $('#brn-con-zone').val();
        data.station = $('#brn-con-station').val();

        var err = 0;
        if (data.dateRange == '') {
            $('#brn_con_range').addClass('inp_error');
            err++;
        }else{
            $('#brn_con_range').removeClass('inp_error');
        }

        if (err > 0) {
            $('#brn_con_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#brn_con_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#brn_con_rpt_action_state').show();
            return false;
        } else {
            $('#brn_con_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#brn_con_rpt_action_state').html('');
            $('#brn_con_rpt_action_state').hide();
        }
        var html = "";
        $('#brn_con_range').removeClass('inp_error');
        $('#brn-con-list-container').removeClass('hidden');
        $('#brn-con-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/branch-consolidation-report-list",
            data: data,
            success: function (response) {
                $('#brn-con-list').html(response);
                $('#brn_con_rpt_excel').removeClass('hide');
            }
        })
    }

    function clearBRNCONReport() {
        $('#brn_con_range').val('');
        $('#brn-con-station').val('').trigger('change');
        $('#brn-con-list-container').addClass('hidden');
        $('#brn-con-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#brn_con_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#brn_con_rpt_excel').addClass('hide');
    }

    function exportBranchConsolidationExcel() {
        document.brn_con_rpt_form.target = "ifrm_downloader";
        $('#export').val(1);
        document.brn_con_rpt_form.submit();
        return;
    }
</script>

