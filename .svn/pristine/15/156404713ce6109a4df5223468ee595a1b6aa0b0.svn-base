<div class="brand_top">
    <h3>Deliver Cargo</h3>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the deliverable goods details to update delivery.              
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">

                                    <div class="col-md-12">

                                        <div id="search-panel" class="well well-sm">
                                            <form id='findLR' name="find_lr" method="get" action="" onsubmit="return false">
                                                <div class="row">
                                                    <div class="col-md-2">
                                                        <label class="sr-only">Enter {lang('lr')}</label>
                                                        <div class="">
                                                            <input type="text" name="LR" class="form-control sdate input_capital" id="quicklr" placeholder="Enter {lang('lr')}">
                                                        </div>
                                                    </div>

                                                    <div class="col-md-10">
                                                        <button class="btn btn-success" type="button" onclick="getLRDetails();">Get Details</button>
                                                        <button class="btn btn-success" type="button" onclick="getAllDetails();">Get All {lang('lr')}</button>
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearLR();">Clear</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                        <div class="align-center alert alert-danger pull-left" style="display:none;float:left" id="lr-action-state"></div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="find-dlcargo-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="find-dlcargo-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{literal}
    <script>
        $(document).ready(function() {
            $('#quicklr').focus();
            $("#quicklr").bind("input", function(e) {
                this.value = this.value.replace(/[^0-9a-zA-Z-]+/g, '').toUpperCase();
            });

            $('#quicklr').keyup(function(event) {
                if (event.which == 13) {
                    event.preventDefault();
                    getLRDetails();
                }
            });
        });
    
        function clearLR() {
            $('#quicklr').val('');
            $('#rpt_lsts').html('');
            $('.inp_error').removeClass('inp_error');
            $('#lr-action-state').hide();
            $('#lr').focus();

            $('#find-dlcargo-list-container').addClass('hidden');
            $('#find-dlcargo-list').html('');
        }
    
        function getLRDetails() {
            var err = 0;
            $('#quicklr').removeClass('inp_error');
            var term = $.trim($('#quicklr').val());
            if (term.length < 3) {
                $('#quicklr').addClass('inp_error');
                err++;
            }
            if (err > 0) {
                $('#lr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#lr-action-state').html('Please enter valid LR code');
                $('#lr-action-state').show();
                return false;
            } else {
                $('#lr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#lr-action-state').html('');
                $('#lr-action-state').hide();
            }

            $('#find-dlcargo-list-container').addClass('hidden');
            $('#find-dlcargo-list').html('');

            var data = {};
            data.code = term;

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/dashboard-lr-list",
                data: data,
                success: function (response) {
                    try {
                        json = JSON.parse(response);
                        // closeDashLrListDialog();
                        getCargoDetails(json.data[0].code);
                    } catch (e) {
                        $('#dashboard-lr-list-dialog').html(response);
                    }
                }
            });
        }
    
        function getAllDetails() {
            var data = {};

            $('#find-dlcargo-list-container').removeClass('hidden');
            $('#find-dlcargo-list').html(loading_popup);

            $.ajax({
                type: "POST",
                url: base_url + "cargo/ogpl-deliver-list",
                data: data,
                dataType: 'html',
                success: function (response) {
                    $('#find-dlcargo-list').html(response);
                }
            });
        }    
    </script>
{/literal}
