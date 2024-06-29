<div class="brand_top">
    <h3>User Right & Permission Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportPermissionExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
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

                                                <form id='con_rv_rpt' method="post" name="con_rv_rpt" action="cargo/permission-report-list" onsubmit="return false;">
                                                    <div class="row">

                                                        <div class="form-group col-md-2">
                                                            <label  for="permission_rpt_date_to">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="organizationCode" name="organizationCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Branch</option>
                                                                    {foreach item=branch from=$branches key=bcode}
                                                                        <option value="{$bcode}">{$branch}</option>
                                                                    {/foreach}
                                                                </select>      
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button"  onclick="permissionReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearPermissionReport();">Clear</button>
                                                            </div>
                                                        </div>        
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="permission_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="permission-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="permission-list"></div>                                    
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
        $('#organizationCode').select2();

        function permissionReport() {
            $('#permission-list').html('');
            var data = {};
            data.organizationCode = $('#organizationCode').val();

            var err = 0;
            $('#permission_rpt_date_from, #permission_rpt_date_to').removeClass('inp_error');
            if (data.fromDate == '') {
                $('#permission_rpt_date_from').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#permission_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#permission_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#permission_action_state').show();
                return false;
            } else {
                $('#permission_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#permission_action_state').html('');
                $('#permission_action_state').hide();
            }
            var html = "";
            $('#permission_rpt_date_to').removeClass('inp_error');
            $('#permission-list-container').removeClass('hidden');
            $('#permission-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/permission-report-list",
                data: data,
                success: function (response) {
                    $('#permission-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#permission-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearPermissionReport() {
            $('#permission-list-container').addClass('hidden');
            $('#permission-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#permission_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#permission_action_state').html('');
            $('#permission_action_state').hide();
            $('#organizationCode').val('NA').trigger('change');
            
            $('#excl_cons').hide();
        }

        function exportPermissionExcel() {
            $('#export').val(1);
            document.con_rv_rpt.target = "ifrm_downloader";
            document.con_rv_rpt.submit();
            return;
        }
    </script>
{/literal}

<link href="https://cdn.jsdelivr.net/npm/jquery-treegrid@0.3.0/css/jquery.treegrid.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/jquery-treegrid@0.3.0/js/jquery.treegrid.min.js" defer></script>
