<div class="brand_top"><h3>Confirm Phone Tickets</h3> </div>

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
                                        <div>
                                            <div id="search-panel">                                         
                                                    <div class="divide-10"></div>
                                                    <form id='test'>
                                                        <div class="form-group col-md-3">
                                                            <label class="sr-only" for="date_from">Select a travel date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="date_from" class="form-control sdate" id="date_from" readonly="true" placeholder="Select a travel date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>                                                        
                                                        <button class="btn btn-success" type="button" onclick="getPhoneBookingList();">Get List</button>
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearPhoneBookingReport();">Clear</button>
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
                    
                       <div class="row hidden" id="phone-order-list-container">
                            <div style="clear: both;"></div><br>
                            <div class="col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div id="phone-order-list"></div>                                    
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                
                </div>
              </div>
        </div>        
</div>


<div id="pb_dialog" style="background-color: #fff;"></div>

<script>
    var term = "{$smarty.request.term}";
    function init_confirm_phonebooking() {
        init_phonebooking_confirm_action();
        if(term=='today') {
            getPhoneBookingList();
        }
    }
</script>