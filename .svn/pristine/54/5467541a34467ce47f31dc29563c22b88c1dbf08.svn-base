<div class="brand_top">
    <h3>Recharge Pending Order</h3>
    <span class="align-right">
        <a href="#report/recharge" class="btn btn-success  btn-sm"> <i class="fa fa-arrow-left"></i> Back</a>
    </span>
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
                                    <!-- Tabs -->
                                    <ul class="nav nav-tabs">
                                        <li class="active hide"><a data-toggle="tab" href="#pending">Pending order</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="pending" class="tab-pane fade in active">

                                            <div id="right-search">                                         

                                                <form class="form-inline" role="form">
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <label class="sr-only" for="sdate-search">Date</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" class="form-control sdate" id="pdate-from" readonly="true" placeholder="Date">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <label class="sr-only" for="sdate-search">Date</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" class="form-control sdate" id="pdate-to" readonly="true" placeholder="Date">

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-2" style="padding:1px !important">
                                                            <button type="button" class="btn btn-success btn-search" onclick="getRechargePendingOrder()">Search</button>  &nbsp
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearRechargePendingSearch()">Clear</button>
                                                        </div>
                                                        
                                                        <div class="col-sm-6">
                                                            <div align="center" class="clear_fix_both hidden" id="po-action-msg"></div>
                                                        </div>
                                                    </div>    
                                                </form>
                                                <div class="note text-muted"><i class="fa fa-info-circle"></i> Reasons : No response from payment gateway, Customer not complete the payment, Connection issues.</div>
                                            </div>
                                            <div class="clear_fix_both"></div><br />

                                            <div id="pending-order-list"></div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Tabs ends -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="confirm_dialog" style="background-color: #fff;" class="hidden">
    <div class="col-sm-7">
        <div id="pg-orderstatus">
            <br/>
            <div class="wd_100 bold m-b-4"> <span class="fa fa-university"></span> &nbsp;&nbsp;Payment Gateway Status</div>
            <div id="order-status"></div>
        </div>
    </div>

    <div id="po-c-ticket-details" class="col-sm-5"></div>
</div>

{literal}
    <script>
        function _init_recharge_pending_order_page() {
            init_recharge_pending_order_page();
        }
        
        
        $('#pdate-from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#pdate-to').datepicker('setStartDate', e.date);
            $("#pdate-to").datepicker("setEndDate", end)
        });
        $('#pdate-to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#pdate-from').datepicker('setEndDate', e.date)
        });
    </script>
{/literal}


