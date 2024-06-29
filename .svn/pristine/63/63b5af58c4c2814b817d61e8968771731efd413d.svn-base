<div class="brand_top">
    <h3>Online Customers</h3> 

    <div class="text-right hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCustomersExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>            
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/customers-report-list" onsubmit="return false">
                                                    <div class="form-group col-md-2">
                                                        <label class="sr-only" for="date_to">Role</label>
                                                        <div class="input-group">
                                                            <select id="user_role" name="user_role" class="form-control">                                                                
                                                                <option value="ALL">All</option>
                                                                <option value="CUST">Customers</option>
                                                                <option value="USER">Users / Agents</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <input type="hidden" name="export" id="export" value="">
                                                        <button class="btn btn-success" type="button"  onclick="searchCustomersReport();" > <i class="fa fa-file-excel-o"> </i> Download</button>
                                                        <!--<button type="button" class="btn btn-default btn-clear" onclick="clearCustomersReport();">Clear</button>-->
                                                    </div>
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

                    <div class="row hidden" id="customers-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="customers-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe id="ifrm_customers_downloader" name="ifrm_customers_downloader" style="display: none"></iframe>                                            
{literal}
    <script>

        function exportCustomersExcel() {
            document.brd_pnt.target = "ifrm_customers_downloader";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }
        
        function searchCustomersReport() {
            exportCustomersExcel();
            return;
            $('#customers-list').html('');
            var data = {}; 
            data.user_role = $('#user_role').val();
            var err = 0;           

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
            
            $('#customers-list-container').removeClass('hidden');
            $('#customers-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/customers-report-list",
                data: data,
                success: function (response) {
                    $('#customers-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                }
            })
        }

        function clearCustomersReport() {
            $('#user_role').val('ALL');            

            $('#customers-list-container').addClass('hidden');
            $('#customers-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();

            $('#d_head_export_panel').addClass('hidden');
        }
    </script>
{/literal}