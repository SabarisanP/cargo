<div class="brand_top">
    <h3>Agent / Branch Collection Report : UnLoaded Date</h3>
    <div class="text-right noprint" id="collection_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the collections details based on the "UnLoaded date" for a branch.                 
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
                                                <form id="collection_report" method="post" name="collection_report" action="cargo/agent-collection-unloaded-report-list" onsubmit="return false;">                                                  <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="collection_rpt_from">UnLoaded Date From</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="collection_rpt_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="collection_rpt_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="collection_rpt_to">UnLoaded Date To</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="collection_rpt_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="collection_rpt_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class=" form-group col-md-2">
                                                            <label for="collection_rpt_to">Filter Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="filterType" name="filterType" class="form-control" onchange="setBranchLabel();">
                                                                    <option value="NA" selected="">Booking & Delivery</option>
                                                                    <option value="TRANSIT">Delivery</option>
                                                                    <option value="BOOK">Booking</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        {if $action_rights['AGTU-COLL-ALL-BRANCH']>0}
                                                            <div class="form-group col-md-2">
                                                                <label for="collection_rpt_to_org" id="branch-label">Transit Branch</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="collection_rpt_to_org" name="transitOrganizationCode" class="form-control select2" onchange="branchSelected(this)">
                                                                        <option value="NA" selected="">Select Branch</option>
                                                                        {foreach item=row from=$branches}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                                    <input type="hidden" name="orgname" id="orgname" value="0">
                                                            </div>
                                                            <div class="form-group col-md-2">
                                                                <label for="collection_rpt_users">Users</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="collection_rpt_users" name="userCode" class="form-control" > </select>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
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

<script>
    var allusers = {$users|json_encode};

    function branchSelected (select) {
        var value = select.value;

        var branchusers = [new Option('All Users', 'NA')];
        $.each(allusers || [], function (i, row) {
            if(row.organization.code == value) {
                branchusers.push(new Option(row.name, row.code));
            }
        });
        $('#collection_rpt_users').html(branchusers);
    }
</script>

{literal}
    <script>
        $('.select2').select2();

        $('#collection_rpt_from').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#collection_rpt_to').datepicker('setStartDate', e.date);
            $('#collection_rpt_to').datepicker('setEndDate', end)
        });
        $('#collection_rpt_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'dd-mm-yyyy',
            maxDate: '+365D',
            autoclose: true
        }).on('changeDate', function (e) {
            $('#collection_rpt_from').datepicker('setEndDate', e.date)
        });

        function exportCargoCollection() {
            $('#export').val(1);
            $('#orgname').val($("#collection_rpt_to_org option:selected").html());
            document.collection_report.target = "ifrm_downloader";
            document.collection_report.submit();
            return;
        }
        
        function setBranchLabel(code){
            ($("#filterType").val() == 'BOOK')? $('#branch-label').html('From Branch'): $('#branch-label').html('Transit Branch');
        }

        function getCollectionReport() {
            $('#collection-rpt-list').html('');
            var data = {};
            data.fromDate = $('#collection_rpt_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#collection_rpt_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.transitOrganizationCode = $('#collection_rpt_to_org').val();
            data.orgname = $("#collection_rpt_to_org option:selected").html();
            data.filterType = $("#filterType").val();
            data.userCode = $("#collection_rpt_users").val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            
            if (data.fromDate == '') {
                $('#collection_rpt_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#collection_rpt_to').addClass('inp_error');
                err++;
            }
            if (data.transitOrganizationCode == 'NA') {
                $('#collection_rpt_to_org').addClass('inp_error');
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
            $('#collection-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/agent-collection-unloaded-report-list",
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
            $('#collection_rpt_from').val('');
            $('#collection_rpt_to').val('');
            $('#collection-rpt-list-container').addClass('hidden');
            $('#collection-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#collection_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#collection_rpt_action_state').html('');
            $('#collection_rpt_action_state').hide();
            $('#collection_rpt_to_org').val('NA').trigger('change');
            $('#collection_rpt_excel').hide();
        }
    </script>
{/literal}