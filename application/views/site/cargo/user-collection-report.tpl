<div class="brand_top">
    <h3>User Booking and delivery Report</h3>
    <div class="text-right noprint" id="collection_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                <form id="collection_report" method="post" name="collection_report" action="cargo/user-collection-report-list" onsubmit="return false;">   
                                                    <div class="row">
                                                        <div class="form-group col-md-3">
                                                            <label for="user_collection_rpt_date_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="user_collection_rpt_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="collection_rpt_users">Users</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="collection_rpt_users" name="userCode" class="form-control" >
                                                                    <option value="NA" selected="">All Users</option>
                                                                    {foreach name=g item=group key=groupname from=$groupusers.groupusers}
                                                                        <optgroup label="{$groupname}">
                                                                            {foreach name=u item=usr from=$group}
                                                                                {if $usr.activeFlag == 1}
                                                                                    <option value="{$usr.code}">{$usr.name}</option>
                                                                                {/if}
                                                                            {/foreach}
                                                                        </optgroup>
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
                                                                <button type="button" class="btn btn-success" onclick="getCollectionReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearCollectionReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="collection_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="collection-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="collection-rpt-list"></div>
                                </div>
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

    $('#user_collection_rpt_date_range').daterangepicker({
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

    function exportCargoCollection() {
        var daterange = $('#user_collection_rpt_date_range').data('daterangepicker');
        var fromDate = daterange.startDate.format('DD-MM-YYYY');
        var toDate = daterange.endDate.format('DD-MM-YYYY');
        $('#fromDate').val(fromDate);
        $('#toDate').val(toDate);
        $('#export').val(1);
        document.collection_report.action ="cargo/user-collection-report-list";
        document.collection_report.target = "ifrm_downloader";
        document.collection_report.submit();
        return;
    }

    function getCollectionReport() {
        $('#collection-rpt-list').html('');
        var data = {};
        var daterange = $('#user_collection_rpt_date_range').data('daterangepicker');
        data.fromDate = daterange.startDate.format('DD-MM-YYYY');
        data.toDate = daterange.endDate.format('DD-MM-YYYY');
        data.userCode = $('#collection_rpt_users').val();
                                                                                                                                                                                                                                                                                                                                         
        var err = 0;
        $('.inp_error').removeClass('inp_error');
   
        if (err > 0) {
            $('#collection_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#collection_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#collection_rpt_action_state').show();
            return false;
        } else {
            $('#collection_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#collection_rpt_action_state').html('');
            $('#collection_rpt_action_state').hide();
        }

        $('#collection-rpt-list-container').removeClass('hidden');
        $('#collection-rpt-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/user-collection-report-list",
            data: data,
            success: function (response) {
                $('#collection-rpt-list').html(response);
                $('#collection_rpt_excel').show();
                $('html, body').animate({
                    scrollTop: $('#collection-rpt-list-container').offset().top - 35
                }, 'slow');
            }
        });
    }

    function clearCollectionReport() {
        $('#user_collection_rpt_date_range').val('');
        $('#user_collection_rpt_date_range').data('daterangepicker').setStartDate({});
        $('#user_collection_rpt_date_range').data('daterangepicker').setEndDate({});
        $('#collection-rpt-list-container').addClass('hidden');
        $('#collection-rpt-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#collection_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#collection_rpt_action_state').html('');
        $('#collection_rpt_action_state').hide();
        $('#collection_rpt_users').val('NA');
        $('#collection_rpt_excel').hide();
    }
   
</script>
{/literal}