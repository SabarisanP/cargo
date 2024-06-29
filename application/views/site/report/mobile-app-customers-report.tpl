<div class="brand_top">
    <h3>Mobile APP Customers</h3>
    <div class="text-right noprint">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportAppCustomers();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="copyAppCustomers();"><i class="fa fa-copy fa-lg"></i> Copy Mobile Numbers</button>
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

                                                <form id="mob_app_customers_form" name="mob_app_customers_form" method="post" onsubmit="return false;">
                                                    <input type="hidden" name="export" id="export" value="1">
                                                </form>

                                                <table id="mob_app_customers_table" class="table table-bordered" width="99%">
                                                    <thead>
                                                        <tr class="success">
                                                            <th align="center">Name</th>
                                                            <th align="center">Mobile</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="body_table" >
                                                        {foreach item=row from=$result key=t}
                                                            <tr>
                                                                <td align="left">{$row->first_name} {$row->last_name}</td>
                                                                <td align="left">{$row->mobile}</td>
                                                            </tr>
                                                        {foreachelse}
                                                            <tr><td colspan="2" align="center">No data available</td><tr>
                                                        {/foreach}
                                                    </tbody>
                                                </table>

                                                <textarea id="all-customer-no" cols="11" style="height: 0px;opacity: .01;">{foreach item=row from=$result key=t}{$row->mobile},&#10;{/foreach}</textarea>

                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_mobile_app_customers" id="ifrm_mobile_app_customers" style="display:none"></iframe>

<script>
    function copyAppCustomers() {
        $('#all-customer-no').select();
        document.execCommand('copy');
        var loading_overlay = iosOverlay({
            text: 'Copied',
            icon: 'fa fa-check'
        });
        setTimeout(function () {
            loading_overlay.hide();
        }, 300);
    }
    
    function exportAppCustomers() {    
        document.mob_app_customers_form.action = 'report/mobile_app_customers_report';
        document.mob_app_customers_form.target = 'ifrm_mobile_app_customers';
        document.mob_app_customers_form.submit();
        return;
    }
</script>