<div class="brand_top">
    <h3>After Departure Booking</h3> 
    <span class="align-right">
        refresh interval 1 min
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
                            
                            <div class="panel panel-default hidden" id="live-graph">
                                <div class="panel-body">

                                    <div class="row">       
                                        <div class="col-md-5">
                                            <div class="row departure-cells">
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="web_count">0</div>
                                                    <div class="text-center labeltxt">Web / Agent</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="api_count">0</div>
                                                    <div class="text-center labeltxt">API</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="mob_count">0</div>
                                                    <div class="text-center labeltxt">Mobile site</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="app_count">0</div>
                                                    <div class="text-center labeltxt">Mobile APP</div>
                                                </div>
                                            </div>
                                            <div class="row departure-cells hide">
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="bo_count">0</div>
                                                    <div class="text-center labeltxt">BO</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="pbl_count">0</div>
                                                    <div class="text-center labeltxt">PBL</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="bl_count">0</div>
                                                    <div class="text-center labeltxt">BL</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="fail_count">0</div>
                                                    <div class="text-center labeltxt">FAIL</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" col-md-offset-4 col-md-3">
                                            <div class="text-center">
                                                <div id="gauge" style="width:60px;"></div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
                            
                            <br>
                            
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-12 live-booking">                                            
                                            <div class="list-group">
                                                <div class="row list-group-item bold">
                                                    <div class="col-md-1" id="pnr">PNR</div>     
                                                    <div class="col-md-1" id="from">From</div>
                                                    <div class="col-md-1" id="to">To</div>
                                                    <div class="col-md-1" id="fare">Service No</div>
                                                    <div class="col-md-1" id="seats">Seats</div>                                                    
                                                    <div class="col-md-1" id="mobile">Mobile</div>
                                                    <div class="col-md-1" id="user">By</div>                                                    
                                                    <div class="col-md-1" id="state">Trip Time</div>
                                                    <div class="col-md-1" id="medium">BP</div>
                                                    <div class="col-md-1" id="travel">Boarding Time</div>
                                                    <div class="col-md-1" id="trans">Booked At</div>                                                    
                                                    <div class="col-md-1" id="action">&nbsp;</div>
                                                </div>
                                                
                                            </div>
                                            <div class="list-group ticketslist">                                               
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>                   
                    </div>                    
                </div>                
            </div>
        </div>        
    </div>
</div>

<script id="template-ticket-row" type="text/template">
        <div class="col-md-1" id="pnr">PNKG21GU943</div> 
        <div class="col-md-1" id="from">Chennai (6:30 PM )</div>
        <div class="col-md-1" id="to">Madurai</div>
        <div class="col-md-1" id="fare">Service No</div>
        <div class="col-md-1" id="seats">seats</div>        
        <div class="col-md-1" id="mobile">987654321</div>
        <div class="col-md-1" id="user">Redbus</div>        
        <div class="col-md-1" id="state">Trip Time</div>
        <div class="col-md-1" id="medium">Boarding Point</div>
        <div class="col-md-1" id="travel">Boarding Time</div>
        <div class="col-md-1" id="trans">Booked At</div>        
        <div class="col-md-1" id="action"></div>
</script>    

{literal}
<script>
    var stateclass = {
        "BO" : '',
        "BL" : 'list-group-item-info',
        "PBL" : '',
        "FAIL" : 'list-group-item-warning'
    } 
    var t = null;
    var g1 = null;
    var ga = false;
    var fr = true;
    var is_alert = false;
    function refreshList() {
        t = null; is_alert = false;
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "ticket/after-departure-booking-list",
            data: '',
            success: function (res) {
                if(res.status==1) {
                    $('.tkt').each(function() {
                        $(this).addClass('exis');
                    });
                    var temp = $('#template-ticket-row').html();
                    $.each(res.tickets, function(key, tkt) {
                        if( $('#'+tkt.pnr).length > 0 ) {
                            var s = $('#'+tkt.pnr).find('#state').html();                                
                            //$('#'+tkt.pnr).attr('data-state',tkt.state);
                            //$('#'+tkt.pnr).find('#state').html(tkt.state);                            
                            //$('#'+tkt.pnr).find('#trans').html(tkt.transactionDate);
                            
                            $('#'+tkt.pnr).removeClass('exis');

                            if( s != tkt.state ) {
                                if(tkt.state=='BO')
                                    $('#'+tkt.pnr).removeClass('list-group-item-info', 5000).removeClass('list-group-item-warning', 5000);
                                else
                                    $('#'+tkt.pnr).removeClass('list-group-item-info').removeClass('list-group-item-warning'); 

                                $('#'+tkt.pnr).addClass(stateclass[tkt.state], 5000);                                     
                            }                            
                        } else {
                            var divhtml = $('<div class="row list-group-item list-group-item-danger tkt">').html(temp).clone();                            
                            divhtml.attr('id',tkt.pnr);
                            divhtml.attr('data-state',tkt.state);
                            
                            var c_icon = '<i class="fa fa-caret-right"></i>';
                            if(tkt.isCustomer==0) {
                                c_icon = '';
                            }
                            
                            var t_pnr = '<a href="javascript:;" onclick=PrintTck("'+tkt.pnr+'");> '+c_icon+tkt.pnr+'</a>';
                                                        
                            divhtml.find('#pnr').html(t_pnr );
                            divhtml.find('#from').html(tkt.from);
                            divhtml.find('#to').html(tkt.to);
                            divhtml.find('#mobile').html(tkt.mobile);
                            divhtml.find('#travel').html(tkt.travelDate);
                            divhtml.find('#trans').html(tkt.transactionDate); 
                            
                            divhtml.find('#user').html(tkt.user.substring(0,12));
                            divhtml.find('#user').attr( 'title', tkt.user);
                            
                            divhtml.find('#medium').html( tkt.boardingPoint.substring(0,12) );
                            divhtml.find('#medium').attr( 'title', tkt.boardingPoint);
                            
                            divhtml.find('#seats').html(tkt.seats);
                            var info = ''
                            if(tkt.driverName!='' || tkt.driverMobile!='' || tkt.registrationNumber!='') {
                                var info = 'Driver Name : '+tkt.driverName+'<br>Driver Mobile : '+tkt.driverMobile+'<br>Bus No : '+tkt.registrationNumber
                                tkt.serviceNumber = tkt.serviceNumber+'&nbsp;&nbsp;<a><i class="fa fa-bus"></i></a>';
                            }
                            divhtml.find('#fare').html(tkt.serviceNumber);  
                            divhtml.find('#state').html(tkt.tripTime);
                            
                            divhtml.find('#action').html('<a href="javascript:;" onclick=removeItem("'+tkt.pnr+'") title="remove this">remove</a>');
                            
                            
                            divhtml.find('#fare').find('a').popover({
                                container:'body',
                                content:info,
                                html:true,
                                placement:'top',
                                trigger:'hover',
                            });
                            
                            $('.ticketslist').prepend(divhtml);
                            
                            if(fr==false) {
                                $('#'+tkt.pnr).removeClass('list-group-item-danger', 10000);
                            } else {
                                $('#'+tkt.pnr).removeClass('list-group-item-danger');
                            }
                            
                            is_alert = true;
                        }

                    });

                    $('#web_count').html(res.device_medium.WEB);
                    $('#api_count').html(res.device_medium.API);
                    $('#mob_count').html(res.device_medium.MOB);
                    $('#app_count').html(res.device_medium.APP);
                    
                    /*$('#bo_count').html(res.ticket_status.BO);
                    $('#pbl_count').html(res.ticket_status.PBL);
                    $('#bl_count').html(res.ticket_status.BL);
                    $('#fail_count').html(res.ticket_status.FAIL);*/

                    $('.exis').each(function() {
                        $(this).animate({backgroundColor: '#c0392b'}, 5000, function() {
                            $(this).remove();
                        });                            
                    });

                    $('#live-graph').removeClass('hidden');
                    
                    // create the timer
                    $('#gauge').html('');
                    $('#gauge').polartimer({
                        timerSeconds: 60,
                        color: '#FF6040',
                        opacity: 0.9,
                        callback: function () {
                            $('#gauge').polartimer('destroy');
                            refreshList(); 
                            $('#gauge').html('<br>Refreshing...');
                        }
                    });
                    // start the timer
                    $('#gauge').polartimer('start');
                    
                    if(fr==false && is_alert==true) {   //  play alert
                        new Howl({src: ['assets/sound/car-alarm.mp3'], volume: 0.9}).play();
                    }                    
                }
               fr = false; 
            }
        });
        
    }
    function init_progress() {
        refreshList();
        
        

    }
    
    function removeItem(code) {
        if(confirm('Have you acknowledged this ticket? Do you want to remove?')) {
            var data = {};    
            data.pnr = code;

            var loading_overlay = iosOverlay({
                text: "Please Wait...",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "ticket/acknowledge-after-departure-booking",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Removed!"
                        });
                        
                        $('#'+code).animate({backgroundColor: '#c0392b'}, 5000, function() {
                            $(this).remove();
                        });
                        
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 1000);
                }
            });
        }
    }
    
</script>
{/literal}
