<div class="brand_top">
    <h3>Billing Report</h3> 

    <div class="text-right hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBillingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <!--<button class="btn btn-default" onclick="window.print()"><i class="fa fa-print fa-lg"></i> Print</button>-->
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
                                                <div class="divide-10"></div>
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/billing-list" onsubmit="return false">
                                                    <!--<div class="form-group col-md-3">
                                                        <label class="sr-only" for="date_to">From Station</label>
                                                        <div class="input-group">
                                                            <select id="station_id" name="staion" class="form-control sdate">
                                                                {foreach item=station from=$stations}
                                                                    <option value="{$station->code}"> {$station->name} </option>
                                                                {/foreach}    
                                                            </select>
                                                            <span class="input-group-addon"><i class="fa fa fa-level-up"></i></span>
                                                        </div>
                                                    </div> -->

                                                    <div class="form-group col-md-3">
                                                        <label class="sr-only" for="date_from">Month</label>
                                                        <div class="input-group">
                                                            <input type="text" name="month" class="form-control sdate" id="srch_month" readonly="true" placeholder="Select a month">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-3">
                                                        <label class="sr-only" for="namespace">Namespace</label>
                                                        <select id="namespace" name="namespaceCode" class="form-control">
                                                            {* <option value="NA"> All Namespaces </option> *}
                                                            {foreach item=namespace from=$namespace_list}
                                                                <option value="{$namespace->code}"> {$namespace->name} </option>
                                                            {/foreach}    
                                                        </select>
                                                    </div>
                                                    <input type="hidden" name="export" id="export" value="">
                                                    <button class="btn btn-success" type="button"  onclick="searchBillingReport();" >Generate</button>
                                                    <button type="button" class="btn btn-default btn-clear" onclick="clearBillingReport();">Clear</button>
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usr-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="billing-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="billing-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe id="irm_billing_downloader" name="irm_billing_downloader"  style="display: none"></iframe>                                            
{literal}
    <script>
        $('#namespace').select2();

        function exportBillingExcel() {
            document.brd_pnt.target = "irm_billing_downloader";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }

        $('#srch_month').datepicker({            
            format: 'mm-yyyy',
            autoclose: true,
            startView: "months", 
            minViewMode: "months"
        })

        /*$('#station_id').select2({
            placeholder: "Select a station",
            escapeMarkup: function (markup) {
                return markup;
            }
        }); */

        function searchBillingReport() {
            $('#biling-list').html('');
            var data = {};
            //data.staionname = $('#station_id').find('option:selected').text();
            //data.staion = $('#station_id').val();
            //data.tripdate = $('#date_from').val();
            data.month = $('#srch_month').val();
            data.namespaceCode = $('#namespace').val();

            var err = 0;
            if (data.month == '') {
                $('#srch_month').addClass('inp_error');
                err++;
            } else {
                $('#srch_month').removeClass('inp_error');
            }

            if (err > 0) {
                $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#usr-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#usr-action-state').show();
                return false;
            } else {
                $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#usr-action-state').html('');
                $('#usr-action-state').hide();
            }
            var html = "";
            $('#srch_month').removeClass('inp_error');
            $('#billing-report-list-container').removeClass('hidden');
            $('#billing-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/billing-list",
                data: data,
                success: function (response) {
                    $('#billing-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            })
        }

        function clearBillingReport() {
            //$('#station_id').val('');
            //$('#station_id').select2('val', '');
            //$('#station_id').select2('data', '');
            $('#srch_month').val('');
            $('#namespace option:selected').prop('selected', false).trigger('change');            

            $('#billing-report-list-container').addClass('hidden');
            $('#billing-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();

            $('#d_head_export_panel').addClass('hidden');
        }

       

    </script>
{/literal}