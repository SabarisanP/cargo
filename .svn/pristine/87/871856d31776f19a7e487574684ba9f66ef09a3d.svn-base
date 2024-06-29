
<div class="brand_top"><h3>Find & Edit Tickets</h3> </div>
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
                                                                                  
                                            <div id="search-panel" >                                         
                                                <div class="divide-10"></div>
                                                <form id='test'>

                                                    <div class="form-group col-md-2">
                                                        <label class="sr-only" for="date_to">PNR</label>
                                                        <div class="input-group col-md-12">
                                                            <input type="text" name="pnr" class="form-control sdate input_capital" id="pnr"  placeholder="PNR Number">
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label class="sr-only" for="date_from">Mobile Number</label>
                                                        <div class="input-group col-md-12">
                                                            <input type="text" name="mobile" class="form-control sdate" id="mobile" placeholder="Mobile Number">
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label class="sr-only" for="email">Email Id</label>
                                                        <div class="input-group col-md-12">
                                                            <input type="text" name="email" class="form-control sdate" id="email"  placeholder="Email Address">
                                                        </div>
                                                    </div>     
                                                    <button class="btn btn-success cn_tck" type="button"  onclick="searchTicketDetails();">Get Ticket</button>
                                                    <button type="button" class="btn btn-default btn-clear" onclick="clearTicket();">Clear</button>

                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px;float:left" id="prt-action-state"></div>
                                            </div>                                               
                                        <input type="hidden" id="type" value="CAN">
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="find-edit-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="find-edit-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div> 

                </div>                    
            </div>                
        </div>
    </div>        
</div>
<script>
 var term = "{$smarty.request.term}";
</script>
{literal}
    <script>
        $('#pnr').focus();
        
        function searchTicketDetails() {

            var pnr = $('#pnr').val();
            var mobile = $('#mobile').val();
            var email = $('#email').val();

            var data = {};
            data.pnr = pnr;
            data.mobile = mobile;
            data.email = email;

            var err = 0;
            if (data.pnr == '' && data.mobile == '' && data.email == '') {
                $('#pnr,#email,#mobile').addClass('inp_error');
                err++;
            } else {
                $('#pnr,#email,#mobile').removeClass('inp_error');
            }
            if (err > 0) {
                $('#prt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#prt-action-state').html('Please enter values to search');
                $('#prt-action-state').show();
                return false;
            } else {
                $('#prt-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#prt-action-state').html('');
                $('#prt-action-state').hide();
            }

            $('#find-edit-list-container').removeClass('hidden');
            $('#find-edit-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "ticket/find-edit-ticket",
                data: data,
                success: function (response) {
                    if (response != '') {
                        $('#find-edit-list').html(response);
                    }
                }
            })


        }
        $(".input_capital").bind("input", function (e) {
            this.value = this.value.toUpperCase();
        });
        function clearTicket() {
            $('#prt-action-state').html('');
            $('#prt-action-state').hide();
            $('#pnr,#mobile,#email').val('');
            $('#find-edit-list-container').addClass('hidden');
            $('#find-edit-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#pnr').focus();
        }


        $(function() {
            if(term!="") {
                if(isValidEmailAddress(term)) {
                    $('#email').val(term);
                } else if(isValidPhonenumber(term)) {
                    $('#mobile').val(term);
                } else {
                    $('#pnr').val(term);
                }
                searchTicketDetails();
            }
        });


    </script>
{/literal}
