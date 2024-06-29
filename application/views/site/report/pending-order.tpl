<div class="brand_top">
    <h3>Pending Order</h3> 
    <span class="align-right">
        <!--<a href="javascript:;" class="btn btn-success  btn-sm" onclick="getPendingOrder();"> <i class="fa fa-refresh"></i> Refresh</a>-->
        {if $action_rights['VIW-LIVE-BOOKING']==1}
            <a href="#ticket/progress" class="btn btn-success  btn-sm" >Live Booking</a>
        {/if}
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
                                        <li class="active"><a data-toggle="tab" href="#pending">Pending order</a></li>
                                            {if $action_rights['VIV-DENIED-ORDER']==1}
                                            <li><a data-toggle="tab" href="#denied">Denied order</a></li>
                                            {/if}
                                            {if $action_rights['VIV-FAILURE-ORDER']==1}
                                            <li><a data-toggle="tab" href="#failure">Failure order</a></li>
                                            {/if}
                                            {if $is_super_namespace==1} 
                                            <li><a data-toggle="tab" href="#blocked">Force Released</a></li>
                                            {/if}
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

                                                        <div class="col-sm-6" style="padding:1px !important">
                                                            <button type="button" class="btn btn-success btn-search" onclick="getPendingOrder()">Search</button>  &nbsp
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearPendingSearch()">Clear</button>
                                                        </div>
                                                    </div>    
                                                </form>
                                                <div class="note text-muted"><i class="fa fa-info-circle"></i> Reasons : No response from payment gateway, Customer not complete the payment, Connection issues.</div>
                                            </div>
                                            <div class="clear_fix_both"></div><br />

                                            <div id="pending-order-list"></div>
                                        </div>
                                        <div id="denied" class="tab-pane fade">

                                            <div id="right-search">
                                                <div class="divide-10"></div>
                                                <form class="form-inline" role="form">
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <label class="sr-only" for="sdate-search">Date</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" class="form-control sdate" id="ddate-from" readonly="true" placeholder="Date">

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <label class="sr-only" for="sdate-search">Date</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" class="form-control sdate" id="ddate-to" readonly="true" placeholder="Date">

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-6" style="padding:1px !important">
                                                            <button type="button" class="btn btn-success btn-search" onclick="getDeniedOrder()">Search</button>  &nbsp
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearDeniedSearch()">Clear</button>
                                                        </div>
                                                    </div>
                                                    <div class="note text-muted"><i class="fa fa-info-circle"></i> Reasons : Taking too long to complete payment, Received delayed response from payment gateway meanwhile the same seat booked by others.</div>
                                                </form>
                                            </div>
                                            <div class="clear_fix_both"></div><br />
                                            <div id="denied-order-list"></div>
                                        </div>
                                        <div id="failure" class="tab-pane fade">

                                            <div id="right-search">
                                                <div class="divide-10"></div>
                                                <form class="form-inline" role="form">
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <label class="sr-only" for="sdate-search">Date</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" class="form-control sdate" id="fdate-from" readonly="true" placeholder="Date">

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <label class="sr-only" for="sdate-search">Date</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" class="form-control sdate" id="fdate-to" readonly="true" placeholder="Date">

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-2" style="padding:1px !important">
                                                            <button type="button" class="btn btn-success btn-search" onclick="getFailureOrder()">Search</button>  &nbsp
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearFailureSearch()">Clear</button>
                                                        </div>
                                                        
                                                        <div class="col-sm-6">
                                                            <div align="center" class="clear_fix_both hidden" id="po-action-msg"></div>
                                                        </div>
                                                    </div>
                                                    <div class="note text-muted"><i class="fa fa-info-circle"></i> Reasons : Issue in API / Agent payment gateway, Not received confirmation request from API and technical issues in payment gateway.</div>
                                                </form>
                                            </div>
                                            <div class="clear_fix_both"></div><br />
                                            <div id="failure-order-list"></div>
                                        </div>
                                        <div id="blocked" class="tab-pane fade">

                                            <div id="right-search">
                                                <div class="divide-10"></div>
                                                <form class="form-inline" role="form">
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <label class="sr-only" for="sdate-search">Date</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" class="form-control sdate" id="bdate-from" readonly="true" placeholder="Date">

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <label class="sr-only" for="sdate-search">Date</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" class="form-control sdate" id="bdate-to" readonly="true" placeholder="Date">

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-6" style="padding:1px !important">
                                                            <button type="button" class="btn btn-success btn-search" onclick="getBlockCancelled();">Search</button>  &nbsp
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBlockCancelled();">Clear</button>
                                                        </div>
                                                    </div>
                                                    <div class="note text-muted"><i class="fa fa-info-circle"></i> Reasons : Manully force released a tentative booking.</div>
                                                </form>
                                            </div>
                                            <div class="clear_fix_both"></div><br />
                                            <div id="block-cancelled-list"></div>
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
</div>

<div id="confirm_dialog" style="background-color: #fff;" class="hidden">
    <div class="col-sm-7">
        <div id="busmap-1" style="min-height: 250px;"></div>        
        <div id="pg-orderstatus">
            <br/>
            <div class="wd_100 bold m-b-4"> <span class="fa fa-university"></span> &nbsp;&nbsp;Payment Gateway Status</div>
            <div id="order-status"></div>
        </div>
    </div>

    <div id="po-c-ticket-details" class="col-sm-5"></div>
</div>


<script id="template-busmap-list" type="text/template">

    <div class="busmap-list">

    <div align="center" class="busmap col-xs-12">
    <div class="seat-map-over upper-layer col-md-12 hide">
    <div class="seat-map-over-all">
    <div class="col-xs-1">
    <p class="vertical-text">Upper</p>
    </div>
    <div class="col-xs-12 upper" style="width:auto;height: auto;">

    </div>
    </div>
    <div class="clear_fix_both"></div>
    </div>
    <div class="clear_fix_both"></div><br />
    <div class="seat-map-over col-xs-12">
    <div class="seat-map-over-all">
    <div class="col-xs-1 seat-map-driver-head">
    <div class="seat-map-driver">&nbsp;
    </div>
    <div class="seat-map-selayer hide">
    <p class="vertical-text">Lower</p>
    </div>
    </div>
    <div class="col-xs-12 lower" style="width:auto;height: auto;">

    </div>
    </div>
    <div class="clear_fix_both"></div>
    </div> 

    </div><!--
    <div class="col-xs-4">

    <div class="seat-available-gents seat-lay-details mrg-3 .AM">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf .AM">Available Male</div>
    <div class="clear_fix_both .AM"></div>
    <div class="seat-available-ladies seat-lay-details mrg-3 .AF">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf .AF">Available Ladies</div>
    <div class="clear_fix_both .AF"></div>
    <div class="seat-available-all seat-lay-details mrg-3 .AL">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf .AL">Allocated for all</div>
    <div class="clear_fix_both .AL"></div>
    <div class="seat-available-you seat-lay-details mrg-3 .AY">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf .AY">Allocated for You</div>
    <div class="clear_fix_both .AY"></div>
    <div class="seat-available-other seat-lay-details mrg-3 .AO">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf .AO">Allocated for Other</div>
    <div class="clear_fix_both .AO"></div>
    <div class="seat-booked-gents seat-lay-details mrg-3 .BM">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf .BM">Booked for Male</div>
    <div class="clear_fix_both .BM"></div>
    <div class="seat-booked-ladies seat-lay-details mrg-3 .BF">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf .BF">Booked for ladies</div>
    <div class="clear_fix_both .BF"></div>
    <div class="seat-booked-blocked seat-lay-details mrg-3 .TBL .BL">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf .TBL .BL">Blocked Seat</div>
    <div class="clear_fix_both .TBL .BL"></div>
    <div class="seat-now-select seat-lay-details mrg-3">&nbsp;</div>
    <div class="col-xs-9 txt-alg-lf">Selected Seat</div>
    <div class="clear_fix_both"></div>

    </div>-->
    <div class="clear_fix_both"></div>

    </div>

</script>   

{literal}
        <script>
            function _init_pending_order_page() {
                init_pending_order_page();
            }
            $('#pdate-from,#pdate-to,#ddate-from,#ddate-to,#fdate-from,#fdate-to,#bdate-from,#bdate-to').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true
            });
            //$('#pdate-from,#ddate-from,#fdate-from').datepicker().datepicker('setDate',new Date());
            $("#pdate-from,#ddate-from,#fdate-from,#bdate-from").datepicker({
                dateFormat: "yy-mm-dd"
            }).datepicker("setDate", "-1d        ");
    </script>
    {/literal}


