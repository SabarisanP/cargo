<div class="brand_top">
    <h3>Branch Collection Report</h3>
    <div class="text-right noprint" id="collection_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick={if ($namespaceCode == "seenucargo") || ($namespaceCode == "seenutransports")} printCollectionPrint(); {else} window.print(); {/if}><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the collection details based on the "Collection date" range along with filters used.                 
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
                                                <form id="collection_report" method="post" name="collection_report" action="cargo/collection-report-list" onsubmit="return false;">                                            
                                                    <div class="row"> 
                                                        <div class="form-group col-md-3">
                                                            <label for="collection_rpt_date_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="collection_rpt_date_range" readonly placeholder="Today" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="collection_rpt_from_org">Branch</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="collection_rpt_from_org" name="fromOrganizationCode" class="form-control">
                                                                    {if $action_rights['COLL-RPT-ALL-BRAH']==0}
                                                                        <option value="NA" selected="">All Branch</option>
                                                                        {foreach item=row from=$branches}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    {else}
                                                                        <option value="{$login_branch}">{$login_branch_name}</option>
                                                                    {/if}  
                                                                </select>
                                                            </div>
                                                        </div>
                                                         <div class="form-group col-md-2">
                                                            <label for="collection_rpt_from_station">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="collection_rpt_from_station" name="fromStation" class="form-control">
                                                                    <option value="NA" selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>

                                                    <div class="row">
                                                       
                                                        <div class="form-group col-md-2">
                                                            <label for="collection_rpt_to_station">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="collection_rpt_to_station" name="toStation" class="form-control">
                                                                    <option value="NA" selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="collection_rpt_filter">Delivery Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="collection_rpt_filter" name="deliveryType" class="form-control">
                                                                    <option value="NA" selected="">All Status</option>
                                                                    <option value="DYSE">Self Pickup</option>
                                                                    <option value="DYDO">Door Delivery</option>
                                                                    <option value="PUSE">Self Pickup</option>
                                                                    <option value="PUDO">Door Pickup</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="print" id="print" value="">
                                                                <input type="hidden" id="fromDate" name="fromDate">
                                                                <input type="hidden" id="toDate" name="toDate">
                                                                <input type="hidden" name="filterType" id="filterType" value="">
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
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>


{literal}
    <script>
        $('#collection_rpt_date_range').daterangepicker({
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
            var daterange = $('#collection_rpt_date_range').data('daterangepicker');
            var fromDate = daterange.startDate.format('DD-MM-YYYY');
            var toDate = daterange.endDate.format('DD-MM-YYYY');
            $('#fromDate').val(fromDate);
            $('#toDate').val(toDate);
            $('#export').val(1);
            $('#print').val('');
            document.collection_report.target = "ifrm_downloader";
            document.collection_report.submit();
            return;
        }

        function getCollectionReport() {

            $('#collection-rpt-list').html('');
            var data = {};
            var daterange = $('#collection_rpt_date_range').data('daterangepicker');
            data.fromDate = daterange.startDate.format('DD-MM-YYYY');
            data.toDate = daterange.endDate.format('DD-MM-YYYY');
            data.fromStationCode = $('#collection_rpt_from_station').val();
            data.toStationCode = $('#collection_rpt_to_station').val();
            data.fromOrganizationCode = $('#collection_rpt_from_org').val();
            data.deliveryType = $('#collection_rpt_filter').val();

            if(data.deliveryType=='NA'){
                $('#filterType').val('PAYMENT_DETAILS');
            }else{
                $('#filterType').val('DETAILS')
            }

            data.filterType= $('#filterType').val();

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

            var html = "";
            $('#collection-rpt-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#collection-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/collection-report-list",
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
            $('#collection_rpt_date_range').data('daterangepicker').setStartDate({});
            $('#collection_rpt_date_range').data('daterangepicker').setEndDate({});
            $('#collection-rpt-list-container').addClass('hidden');
            $('#collection-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#collection_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#collection_rpt_action_state').html('');
            $('#collection_rpt_action_state').hide();
            $('#collection_rpt_from_station').val('NA');
            $('#collection_rpt_to_station').val('NA');
            $('#collection_rpt_from_org').val('NA');
            $('#collection_rpt_excel').hide();
        }

        function printCollectionPrint(){
            var daterange = $('#collection_rpt_date_range').data('daterangepicker');
            var fromDate = daterange.startDate.format('DD-MM-YYYY');
            var toDate = daterange.endDate.format('DD-MM-YYYY');
            $('#fromDate').val(fromDate);
            $('#toDate').val(toDate);
            $('#print').val(1);
            $('#export').val('');
            document.collection_report.target = "ifrm_downloader";
            document.collection_report.submit();
            return;
        }
       
    </script>
{/literal}