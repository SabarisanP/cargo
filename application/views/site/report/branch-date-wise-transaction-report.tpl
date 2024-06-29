<div class="brand_top">
    <h3>Branch Date Wise Transaction Report</h3>
    <div class="text-right noprint hide" id="brn_date_wise_trns_excel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBrnDateWiseTrnsExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                            <form id='brn_date_wise_trn_form' name="brn_date_wise_trn_form" method="post" action="report/branch-date-wise-transaction-report-list" onsubmit="return false">
                                                <div class="row">   
                                                    <div class="form-group col-md-4">
                                                        <label for="bdwt_range" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="bdwt_range" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    
                                                    {* <div class="form-group col-md-2">
                                                        <label for="bdwt_station" class="">Station</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="bdwt_station" name="station"  class="form-control" {if $action_rights['EBL-ALL-STATION']!=1}disabled{/if}>
                                                                <option value="NA" selected="">All Station</option>
                                                                {foreach key=key item=row from=$station}
                                                                    <option value="{$row->station->code}" {if $user_profile->organization->station->code == $row->station->code}selected{/if}>{$row->station->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div> *}

                                                    <div class="form-group col-md-2">
                                                        <label for="bdwt_branch" class="">Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="bdwt_branch" name="branch"  class="form-control" {if $action_rights['EBL-ALL-BRANCH']!=1}disabled{/if}>
                                                                <option value="NA" selected="">All Branch</option>
                                                                {foreach key=key item=row from=$org}
                                                                    <option value="{$row->code}" {if $user_profile->organization->code == $row->code}selected{/if}>{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>


                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button"  onclick="searchBrnDateWiseTrnReport()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBrnDateWiseTrnReport()">Clear</button>
                                                        </div>
                                                    </div>
                                                    <br>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="bdwt_rpt_action_state"></div>
                                                </div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                        
                
                <div class="row hidden" id="bdwt-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="bdwt-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
                                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>


{literal}
    <script>
        $('#bdwt_range').daterangepicker({
            buttonClasses: ['btn', 'btn-xs'],
            format: 'DD-MM-YYYY',
            separator: ' | ',
            ranges: {
                'Today': [moment().startOf('day'), moment().endOf('day')],
                'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
                'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
                'Last 30 Days': [moment().subtract(29, 'days').startOf('day'), moment().endOf('day')],
            },
        }).on('show.daterangepicker', function (ev, picker) {
            picker.showCalendars();
        });

        var picker = $('#bdwt_range').data('daterangepicker');
        
        $('#bdwt_branch').select2();
        
        function searchBrnDateWiseTrnReport() {
            $('#bdwt-list').html('');
            var data = {};
            data.dateRange = $('#bdwt_range').val();
            data.branch = $('#bdwt_branch').val();

            var err = 0;
            if (data.dateRange == '') {
                $('#bdwt_range').addClass('inp_error');
                err++;
            }else{
                $('#bdwt_range').removeClass('inp_error');
            }

            if (err > 0) {
                $('#bdwt_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#bdwt_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#bdwt_rpt_action_state').show();
                return false;
            } else {
                $('#bdwt_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#bdwt_rpt_action_state').html('');
                $('#bdwt_rpt_action_state').hide();
            }
            var html = "";
            $('#bdwt_range').removeClass('inp_error');
            $('#bdwt-list-container').removeClass('hidden');
            $('#bdwt-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/branch-date-wise-transaction-report-list",
                data: data,
                success: function (response) {
                    $('#bdwt-list').html(response);
                    $('#brn_date_wise_trns_excel').removeClass('hide');
                }
            })
        }

        function clearBrnDateWiseTrnReport() {
            $('#bdwt_range').val('');
            $('#bdwt_branch').val('').trigger('change');
            $('#bdwt-list-container').addClass('hidden');
            $('#bdwt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#bdwt_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#brn_date_wise_trns_excel').addClass('hide');
        }

        function exportBrnDateWiseTrnsExcel() {
            document.brn_date_wise_trn_form.target = "ifrm_downloader";
            $('#export').val(1);
            document.brn_date_wise_trn_form.submit();
            return;
        }
    </script>
{/literal}

