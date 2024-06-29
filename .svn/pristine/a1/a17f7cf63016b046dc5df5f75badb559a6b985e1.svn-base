<div class="brand_top">
    <h3>Branch Balance</h3>
    <div class="text-right noprint" id="branchbalance_rpt_excel" style="display:none">
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
                                                <form id="branchbalance_report" method="post" name="branchbalance_report" action="branch/branch-balance-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="col-lg-2 w-auto">
                                                            <div>
                                                                <label for="receipt-user">&nbsp;</label>
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="branch_balance_to" value="BRANCH" checked> Branch</label>
                                                                </span>&nbsp;
                                                                <span class="radio d-inline-block">
                                                                    <label><input type="radio" name="branch_balance_to" value="USER"> User</label>
                                                                </span>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont" style="display: none;">
                                                            <div class="form-group">
                                                                <label for="branch_balance_organization">Branch</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="branch_balance_organization" name="organizationCode" class="form-control">
                                                                        {if $action_rights['DAY-CLO-ALL-BRCH'] == 1}
                                                                            <option value="NA">All Branch</option>
                                                                            {foreach item=row from=$branches}
                                                                                <option value="{$row->code}">{$row->name}</option>
                                                                            {/foreach}
                                                                        {else}
                                                                            <option value="{$login_branch}">{$login_branch_name}</option>
                                                                        {/if}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-2 cont" style="display: none;">
                                                            <div class="form-group">
                                                                <label  for="branch_balance_user">Users</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="branch_balance_user" name="userCode"  class="form-control" >
                                                                        {if $action_rights['DAY-CLO-ALL-BRCH'] == 1 || $action_rights['DAY-CLO-SAM-BRCH'] == 1}
                                                                            <option value="">Select a user</option>
                                                                        {/if}
                                                                        {foreach item=branch from=$branchusers}
                                                                            {if $action_rights['DAY-CLO-SAM-BRCH'] == 1 && $branch['code'] != $login_branch}
                                                                                {continue}
                                                                            {/if}
                                                                            <optgroup label="{$branch['name']}">
                                                                                {foreach item=row from=$branch['users']}
                                                                                    {if $action_rights['DAY-CLO-ALL-BRCH'] != 1 && $action_rights['DAY-CLO-SAM-BRCH'] != 1 && $row->code != $usr_login_id}
                                                                                        {continue}
                                                                                    {/if}
                                                                                    {if $row->activeFlag == 1}
                                                                                        {if in_array($row->code, $primary)}
                                                                                            <option value="{$row->code}" data-org="{$row->organization->code}" {if $row->code == $usr_login_id}selected{/if}>{$row->name} <span class="bold">(Primary)</span></option>
                                                                                        {else}
                                                                                            <option value="{$row->code}" data-org="{$row->organization->code}" {if $row->code == $usr_login_id}selected{/if}>{$row->name}</option>
                                                                                        {/if}
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
                                                                <button type="button" class="btn btn-success" onclick="getBranchBalanceReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearBranchBalanceReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="branchbalance_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="branch-balance-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="branch-balance-list"></div>
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
        $('#branch_balance_user, #branch_balance_organization').select2();

        $('[name="branch_balance_to"]').on('change', function() {
            var balanceto = $('[name="branch_balance_to"]:checked').val();
            $('#branch_balance_organization, #branch_balance_user').closest('.cont').hide();
            if (balanceto == 'BRANCH') {
                $('#branch_balance_organization').closest('.cont').show();
            } else if (balanceto === 'USER') {
                $('#branch_balance_user').closest('.cont').show();
            }
        }).trigger('change');


        function getBranchBalanceReport() {
            $('#branch-balance-list').html('');
            var data = {};

            var balanceto = $('[name="branch_balance_to"]:checked').val();
            data.filterby = balanceto;
            $('#filterby').val(balanceto);
            
            if (balanceto === 'BRANCH') {
                data.userCode = 'NA';
                data.organizationCode = $('#branch_balance_organization').val();
            } else if (balanceto === 'USER') {
                data.userCode = $('#branch_balance_user').val();
                data.organizationCode = 'NA';
            }

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (err > 0) {
                $('#branchbalance_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#branchbalance_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#branchbalance_action_state').show();
                return false;
            } else {
                $('#branchbalance_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#branchbalance_action_state').html('');
                $('#branchbalance_action_state').hide();
            }

            $('#branchbalance_to').removeClass('inp_error');
            $('#branch-balance-list-container').removeClass('hidden');
            $('#branch-balance-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "branch/branch-balance-list",
                data: data,
                success: function(response) {
                    $('#branch-balance-list').html(response);
                    $('#branchbalance_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#branch-balance-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }

        function clearBranchBalanceReport() {
            $('#branchbalance_from').val('');
            $('#branchbalance_to').val('');
            $('#branch-balance-list-container').addClass('hidden');
            $('#branch-balance-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#branchbalance_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#branchbalance_action_state').html('');
            $('#branchbalance_action_state').hide();
            $('#branchbalance_user option:first').prop('selected', true).trigger('change');
            $('#branchbalance_rpt_excel').hide();
        }

        function closeUserBalance(code) {
            var data = branchUserTransactions;

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
                url: base_url + "branch/save_branch_user_transactions",
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
            document.branchbalance_report.target = "ifrm_downloader";
            document.branchbalance_report.submit();
            return;
        }
    </script>
{/literal}
