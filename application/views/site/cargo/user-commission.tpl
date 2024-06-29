<div class="brand_top">
    <h3>User Commissions</h3>
    <div class="text-right noprint" id="userbalance_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBalanceExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                <form id="userbalance_report" method="post" name="userbalance_report" action="cargo/user-commission-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="col-lg-2 w-auto hide">
                                                            <div>
                                                                <label for="receipt-user">&nbsp;</label>
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="user_balance_to" value="BRANCH" checked> Branch</label>
                                                                </span>&nbsp;
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="user_balance_to" value="USER"> User</label>
                                                                </span>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont" style="display: none;">
                                                            <div class="form-group">
                                                                <label for="user_balance_organization">Branch</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="user_balance_organization" name="organizationCode" class="form-control">
                                                                        <option value="NA">All Branch</option>
                                                                        {foreach item=row from=$branches}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont" style="display: none;">
                                                            <div class="form-group">
                                                                <label  for="user_balance_user">Users</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="user_balance_user" name="userCode"  class="form-control" >
                                                                        <option value='NA' selected="">All Users</option>
                                                                        {foreach key=branch item=users from=$branchusers}
                                                                            <optgroup label="{$branch}">
                                                                                {foreach item=row from=$users}
                                                                                    {if $row->activeFlag == 1}
                                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                                    {/if}
                                                                                {/foreach}
                                                                            </optgroup>
                                                                        {/foreach}
                                                                    </select>       
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <input type="hidden" name="filterby" id="filterby">
                                                                <button type="button" class="btn btn-success" onclick="getUserBalanceReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearUserBalanceReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="userbalance_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="user-balance-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="user-balance-list"></div>
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
        $('#user_balance_user, #user_balance_organization').select2();

        $('[name="user_balance_to"]').on('change', function() {
            var balanceto = $('[name="user_balance_to"]:checked').val();
            $('#user_balance_organization, #user_balance_user').closest('.cont').hide();
            if (balanceto == 'BRANCH') {
                $('#user_balance_organization').closest('.cont').show();
            } else if (balanceto === 'USER') {
                $('#user_balance_user').closest('.cont').show();
            }
        }).trigger('change');


        function getUserBalanceReport() {
            $('#user-balance-list').html('');
            var data = {};

            var balanceto = $('[name="user_balance_to"]:checked').val();
            data.filterby = balanceto;
            $('#filterby').val(balanceto);
            if (balanceto === 'BRANCH') {
                data.userCode = 'NA';
                data.organizationCode = $('#user_balance_organization').val();
            } else if (balanceto === 'USER') {
                data.userCode = $('#user_balance_user').val();
                data.organizationCode = 'NA';
            }

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (err > 0) {
                $('#userbalance_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#userbalance_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#userbalance_action_state').show();
                return false;
            } else {
                $('#userbalance_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#userbalance_action_state').html('');
                $('#userbalance_action_state').hide();
            }

            $('#userbalance_to').removeClass('inp_error');
            $('#user-balance-list-container').removeClass('hidden');
            $('#user-balance-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/user-commission-list",
                data: data,
                success: function(response) {
                    $('#user-balance-list').html(response);
                    $('#userbalance_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#user-balance-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }

        function clearUserBalanceReport() {
            $('#userbalance_from').val('');
            $('#userbalance_to').val('');
            $('#user-balance-list-container').addClass('hidden');
            $('#user-balance-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#userbalance_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#userbalance_action_state').html('');
            $('#userbalance_action_state').hide();
            $('#userbalance_user option:first').prop('selected', true).trigger('change');
            $('#userbalance_rpt_excel').hide();
        }

        function closeUserBalance(code) {
            var data = userUserTransactions;

            if (!confirm('Do you want to close balance?')) {
                return;
            }

            var loading_overlay = iosOverlay({
                text: "Closing",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "user/save_user_user_transactions",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Done!"
                        });
                    } else {
                        alert(response.errorDesc);
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Failed!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }
        
        function exportBalanceExcel() {
            $('#export').val(1);
            document.userbalance_report.target = "ifrm_downloader";
            document.userbalance_report.submit();
            return;
        }
    </script>
{/literal}
