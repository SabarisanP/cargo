<div class="brand_top">
    <h3>Subscription Report</h3>
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportSubscriptionReport()"><i class="fa fa-download fa-lg"></i>Excel</button>   
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
                                                <form id='subscription_report' method="post" name="subscription_report" method="post" action="report/subscription-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="subscription-days" class="req">Due Days</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="subscription-days" name="days"  class="form-control" >
                                                                    <option value="">Select Days</option>
                                                                    <option value="1">1 Day</option>
                                                                    {for $days=2 to 31}
                                                                        <option value="{$days}">{$days} Days</option>
                                                                    {/for}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-3">
                                                            <label>&nbsp;</label>
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateSubscriptionReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearSubscriptionReport();">Clear</button>
                                                        </div>
                                                    </div>
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="subscription-report-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="subscription-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="subscription-report-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<iframe id="ifrm_downloader" name="ifrm_downloader" style="display: none"></iframe>

<script>
    $('#subscription-days').select2();
    
    function generateSubscriptionReport() {
        $('#subscription-report-list').html('');
        var data = {};
        data.days = $('#subscription-days').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.days == '') {
            $('#subscription-days').addClass('inp_error');
            err++;
        } else {
            $('#subscription-days').removeClass('inp_error');
        }

        if (err > 0) {
            $('#subscription-report-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#subscription-report-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#subscription-report-action-state').show();
            return false;
        } else {
            $('#subscription-report-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#subscription-report-action-state').html('');
            $('#subscription-report-action-state').hide();
        }

        $('#subscription-report-list-container').removeClass('hidden');
        $('#subscription-report-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/subscription-report-list",
            data: data,
            success: function (response) {
                $('#subscription-report-list').html(response);
                $('#excl_cons').show();
            }
        });
    }

    function clearSubscriptionReport() {
        $('#subscription-days').val('').trigger('change');
        $('#subscription-report-list-container').addClass('hidden');
        $('#subscription-report-list').html('');
        $('.inp_error').removeClass('inp_error');
        
        $('#subscription-report-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#subscription-report-action-state').html('');
        $('#subscription-report-action-state').hide();
        $('#excl_cons').hide();
    }

    function exportSubscriptionReport() {
        document.subscription_report.target = "ifrm_downloader";
        $('#export').val(1);
        document.subscription_report.submit();
        return;
    }
</script>