<div class="brand_top">
    <h3>Collection Report (Transaction Based)</h3>
    <div class="text-right noprint" id="collection_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the transaction amount for Specific branch & user.                 
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
                                                <form id="collection_report" method="post" name="collection_report" action="cargo/collection-report-listv2" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-4">
                                                            <label for="collection_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="collection_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class=" form-group col-md-2">
                                                            <label for="collection_rpt_to">Filter Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="filterType" name="filterType" class="form-control" onchange="setBranchLabel();">
                                                                    <option value="SUMMARY">Summary</option>
                                                                    <option value="DETAILS">Details</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row"> 
                                                        <div class="form-group col-md-2">
                                                            <label for="collection_rpt_to_org" id="branch-label">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="collection_rpt_to_org" name="organizationCode" class="form-control select2" onchange="branchSelected(this)">
                                                                    {if $action_rights['COLL-TXN-RPT-ALL-BRAH']==1}
                                                                        <option value="NA" selected="">All Branch</option>
                                                                        {foreach item=row from=$branches}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    {else}
                                                                        <option value="{$login_branch}">{$login_branch_name}</option>
                                                                    {/if} 
                                                                </select>
                                                            </div>
                                                                <input type="hidden" name="orgname" id="orgname" value="0">
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="collection_rpt_users">Users</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="collection_rpt_users" name="userCode" class="form-control select2" > </select>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button type="button" class="btn btn-success" id="generate-report-btn" onclick="getCollectionReport();">Generate</button>&nbsp;
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
<div id="dia-rev-details" class="hide dialog-content-page">
    <div>
    <div class="popup_top noprint">
        <div class="row">
            <div class="col-md-10 bold ft_14">Collection Report (Transaction Based) - <span id="dia-rev-details-user"></span></div>
            <div class="col-md-2"> 

                <a class="align-right" onclick="closeRevenueDetailsDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
            </div>
        </div>    
    </div>
    <br/>
    <div class="clearfix"></div>
    <div id="dia-rev-details-list">
        
    </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<script>
    var allusers = {$users|json_encode};

    function branchSelected(select) {
        var value = select.value;

        var branchusers = [new Option('All Users', 'NA')];
        $.each(allusers || [], function (i, row) {
            if(value == 'NA' || row.organization.code == value) {
                branchusers.push(new Option(row.name, row.code));
            }
        });
        $('#collection_rpt_users').html(branchusers);
    }

    $('#collection_rpt_to_org').trigger('change')
</script>

{literal}
    <script>
        $('.select2').select2();

        $('#collection_rpt_date_range').daterangepicker({
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

        var picker = $('#collection_rpt_date_range').data('daterangepicker');

        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }

        function exportCargoCollection() {
            $('#export').val(1);
            $('#orgname').val($("#collection_rpt_to_org option:selected").html());
            document.collection_report.target = "ifrm_downloader";
            document.collection_report.submit();
            return;
        }

        function setBranchLabel(code) {
            ($("#filterType").val() == 'BOOK') ? $('#branch-label').html('From Branch'): $('#branch-label').html('Transit Branch');
        }

        function getCollectionReport() {
            $('#collection-rpt-list').html('');
            var data = {};
            data.dateRange = $('#collection_rpt_date_range').val();
            data.organizationCode = $('#collection_rpt_to_org').val();
            data.orgname = $("#collection_rpt_to_org option:selected").html();
            data.filterType = $("#filterType").val();
            data.userCode = $("#collection_rpt_users").val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');


            if (data.dateRange == '') {
                $('#collection_rpt_date_range').addClass('inp_error');
                err++;
            }

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

            $('#collection_rpt_to').removeClass('inp_error');
            $('#collection-rpt-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#collection-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/collection-report-listv2",
                data: data,
                success: function (response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#collection-rpt-list').html(response);
                    $('#collection_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#collection-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }


        function clearCollectionReport() {
            $('#collection_rpt_date_range').val('');
            $('#collection-rpt-list-container').addClass('hidden');
            $('#collection-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#collection_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#collection_rpt_action_state').html('');
            $('#collection_rpt_action_state').hide();
            $('#collection_rpt_to_org option:first').prop('selected', true).trigger('change');
            $('#collection_rpt_excel').hide();
        }

        function closeRevenueDetailsDialog() {
            $('#dia-rev-details').dialog('destroy');
            $('#dia-rev-details').hide();
            $('#dia-rev-details-list').html('');
        }
    </script>
{/literal}