$(document).ready(function() {
    $('.quick_links').click(function(){
        //console.log($(this).data());
        //ga_track_event('Home Page', 'Quick Links', $(this).data('label'));
    });

    getNotification();
    initQuickBook();
    loadRecentBookings();
    loadToPayVouchers();
    getTodaySnapshot();
    
    
    $("#snapopt input:radio").change(function () {
        $('#summary_pie').addClass('hide');
        $('#summary_table').addClass('hide');
        
        if ($(this).val() == "pie") {        
            $('#summary_pie').removeClass('hide');
            setCookie('b_sshot', 'pie', 15);
        } else {
            $('#summary_table').removeClass('hide');
            setCookie('b_sshot', 'tbl', 15);
        }
    });
    
    var sshot_opt = getCookie('b_sshot') ? getCookie('b_sshot') : 'pie';    
    if(sshot_opt == 'pie') {
        $("#option1").attr('checked', 'checked');
        $("#option1").parent().addClass('active');
    } else {
        $("#option2").attr('checked', 'checked');
        $("#option2").parent().addClass('active');
    }    

});

function getRandomizer(bottom, top) {
    return function() {
        return Math.floor( Math.random() * ( 1 + top - bottom ) ) + bottom;
    }
}

function getTodaySnapshot() {
    if( $('#summary_pie').length == 0 ) { return; }
    
    $('#summary_pie').addClass('hide');
    $('#summary_table').addClass('hide');
    var sshot_opt = getCookie('b_sshot') ? getCookie('b_sshot') : 'pie';
    if(sshot_opt == 'pie') {
        $('#summary_pie').removeClass('hide');
    } else {
        $('#summary_table').removeClass('hide');
    }
    
    $('#summary_pie').html('<div class="col-md-offset-5" style="padding-top:110px"><img src="'+base_url+'assets/img/loaders/20.gif" /></div>');
    $('#summary_table').html('<div class="col-md-offset-5" style="padding-top:110px"><img src="'+base_url+'assets/img/loaders/20.gif" /></div>');
    
    $.ajax({
        type: "POST",
        url: base_url + "widget/today-snapshot",
        dataType: 'json',
        success: function(result) {
            $('#occupancy_pane').removeClass('hide');
                           
            if(result.today_occupancy) {
                var t = result.today_occupancy;
//                $('.live-cells').find('.count').html('<span class="ion-loading-a" style="color:#368ee0"></span>');
                $('#trip_count').html(t.t_trips);
                $('#seats_count').html(t.t_seats);
                $('#booked_count').html(t.t_booked_seats);
                $('#pbooked_count').html(t.t_pbooked_seats);
                $('#vacant_count').html(t.t_vacant_seats);                
                $('#summary_at').html('(As on ' + moment(result.response_datetime).format('hh:mm A') + ')');
                //$('#occu_count').html('<span>'+t.occupancy+'%</span>');
                var tb = parseInt(t.t_booked_seats) + parseInt(t.t_pbooked_seats);


                chartdata = [
                    {label: "Booked", data: tb, color: '#2ca02c'},
                    {label: "Vacant", data: t.t_vacant_seats, color: '#efefef'},
                ];
                $.plot($('#occu_count'), chartdata, {
                    grid: {clickable: true, hoverable: true},
                    series: {
                        pie: {
                            show: true,
                            radius: 3 / 4,
                            label: {
                                show: false
                            },
                            innerRadius: 0
                        }
                    },
                    legend: {show: false},
                    tooltip: true,
                    tooltipOpts: {
                        content: "%p.0%, %s",
                        shifts: {
                            x: 20,
                            y: 0
                        },
                        defaultTheme: false
                    }
                });
           }

           if(result.groups) {
                masterItems = [];
                $.each(result.groups, function(name, count) {
                    var ti = [name,count];
                    masterItems.push(ti);
                });

                $('#summary_pie').highcharts({
                   chart:{
                       type:"pie",
                       renderTo:"",
                       options3d:{
                           enabled:"1", alpha:45
                       }
                   },
                   title:{text:""},
                   xAxis:{categories:[]},
                   yAxis:{
                       stackLabels:{
                           enabled:true
                       },min:0
                   },
                   tooltip:{
                       shared:false,
                       useHTML:true,
                       headerFormat:"<b>{point.key}</b><table>",
                       pointFormat:" : {point.y} seats",
                       footerFormat:"</table>",
                       percentageDecimals:1
                   },
                   series:[{
                           name:'',
                           data:masterItems
                       }
                   ],
                   credits:{enabled:false},
                   legend:{enabled:false},
                   exporting:{enabled:false},
                   tooltipPie:{
                       pointFormat:"<b>{point.percentage}%</b>",
                       percentageDecimals:1},
                   colors:["#FF6040","#A05030","#D0B090","#6600FF","#64E572","#FF9655","#FFF263","#6AF9C4"],
                   export:"",
                   plotOptions:{
                       pie:{
                           allowPointSelect:true,
                           cursor:"pointer",
                           dataLabels:{
                               enabled:true,
                               formatter:function () {return '<b>'+ this.point.name+'</b> : '+ Math.round(this.percentage) +' %';},
                               showInLegend:true,
                               percentageDecimals:1,
                               valueDecimals:2
                           },
                           showInLegend:true,
                           innerSize:"",
                           depth:""
                       }
                   }
               });
               
                //   revenue table.        
                var tb = parseInt(result.today_occupancy.t_booked_seats) + parseInt(result.today_occupancy.t_pbooked_seats);
                $('#summary_table').html( $('#tmpl_sshottable').html() );  
                var revList = $('#tmpl_sshotrow').html();
                var seats = 0; revenue = 0;
                $.each(result.groups, function(name, count) {
                    var ratio = (count/tb)*100; 
                    ratio = ratio.toFixed(0);
                    var ti = [name,count];                                        
                    var crevList = $('<div>').html(revList).clone();                    
                    crevList.find('.grpname').html(name);
                    crevList.find('.seats').html(count);
                    crevList.find('.ratio').html(ratio.concat(" % "));
                    crevList.find('.confrev').html(result.groups_revenue[name]);
                    $('#sstblbody').append( crevList.html() );
                    seats += count;
                    revenue += result.groups_revenue[name];
                });                
                
                var crevList = $('<div>').html(revList).clone();   
                crevList.find('.grpname').addClass('bold');
                crevList.find('.seats').addClass('bold');
                crevList.find('.confrev').addClass('bold');
                
                crevList.find('.grpname').html('Total');
                crevList.find('.seats').html(seats);                
                crevList.find('.ratio').html('-');
                crevList.find('.confrev').html(revenue.toFixed(2));
                
                $('#sstblbody').append( crevList.html() );
                
           }
           //ga_track_event('Analytics', 'Home Page Snapshot', 'Daily Occupancy');
        }
    });
}

function getNotification() {

    if( $('#notify').length == 0 ) { return; }

    $('#notify').html(loading_small);

    $.ajax({
        type: "POST",
        url: base_url + "widget/get-notification",
        dataType: 'html',
        success: function(result) {
           $('#notify').html(result);
           $("#notify").slimScroll({
                height: '120px',
                wheelStep: 1
            });
        }
    });
}

function UserNotifyDialog(code,date, flag,name) {
    $('#comment').val('');
    $('#notify_name').html(name);
    $('#viw-notify-dialog').css('background', '#fff');
    $('#viw-notify-dialog').removeClass('hide');
    $('#viw-notify-dialog').dialog({
        autoOpen: true,
        height: 470,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#org-form-action-state').html('');
    $('#org-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    $('.msg').html($('#notify-'+code).html());
    $('#notify_code').val(code);
    if(flag==1){
        $('.btn-msg').show();
        $('.ov_fl_230').addClass('ov_fl_350').removeClass('ov_fl_230');
        $('.hd_cmt').show();
    }else{
        $('.btn-msg').hide();
        $('.ov_fl_350').addClass('ov_fl_230').removeClass('ov_fl_350');
        $('.hd_cmt').hide();
    }

}
function cancelUsrNotify() {
    $('#viw-notify-dialog').dialog('destroy');
    $('#viw-notify-dialog').hide();

}
function HideNotify(code, date, flag,name) {


    if (confirm('Do you want to hide this notification?')) {

        var data = {};
        data.code = code;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "user/update-user-notify",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                 loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });

                $('#notify_' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                    $(this).remove()
                });
            } else {

            }
             window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
        }
    })
    };

}

function saveUsrNotify() {
    var data = {};

    data.code = $('#notify_code').val();
    data.comments = $('#comment').val();


    var err = 0;
    if ($('#comment').val() == '') {
        $('#comment').addClass('inp_error');
        err++;
    } else {
        $('#comment').removeClass('inp_error');
    }



    if (err > 0) {
        $('#org-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#org-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#org-form-action-state').show();
        return false;
    } else {
        $('#org-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#org-form-action-state').hide();
    }

    $('#form-bttons').hide();
    $('#org-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#org-form-action-state').html(loading_popup);
    $('#org-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "user/update-user-notify",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#org-form-action-state').removeClass('alert-danger');
                $('#org-form-action-state').addClass('alert-success');
                $('#org-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelViwNotify();
                }, 3000);
            } else {
                $('#org-form-action-state').addClass('alert-danger');
                $('#org-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })
}

function initQuickFind() {
    $('#quick-find-term').removeClass('inp_error');
    var term = $.trim( $('#quick-find-term').val() );
    if(term.length<6) {
        $('#quick-find-term').addClass('inp_error');
        return;
    }
    
    ga_track_event('Home Page', 'Quick Find', 'Quick Find Button');
    var t = '#ticket/find-edit-ticket';
    window.location.href = t+'?term='+term;
}

function initQuickBook() {
    $('#from-station').select2({
        placeholder: "Select Origin",
        escapeMarkup: function(markup) {
            return markup;
        }
    });
    $('#to-station').select2({
        placeholder: "Select Destination",
        escapeMarkup: function(markup) {
            return markup;
        }
    });

    $('#sdate-search').datepicker({
        todayHighlight: true,
        format: "dd-mm-yyyy",
        startDate: '-0m',
        autoclose: true

    });

    var d = new Date();
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1;
    var curr_year = d.getFullYear();
    if (curr_month < 10) {
        curr_month = '0' + curr_month;
    }
    if (curr_date < 10) {
        curr_date = '0' + curr_date;
    }
    var date_format = curr_date + '-' + curr_month + '-' + curr_year;
    $('#sdate-search').datepicker("setDate", date_format);
    $('#sdate-search').val(date_format);

    $('#from-station').change( function() {
        if( $("#from-station").val() != "" ){
            var from_code = $("#from-station").val();
            var to_codes = eval(routes1[from_code]);
            var html="<option value=''>Select Destination</option>";
            $(to_codes).each(function() {
                html+="<option value="+this.code+">"+this.name+"</option>";
            });
            $('#to-station').html(html);
         }
    });

    $('#quick-search').click(function() {
        $('.parsley-error').removeClass('parsley-error');
        if($("#from-station").val()=="") {
            $("#from-station").addClass('parsley-error');
            return;
        }
        if($("#to-station").val()=="") {
            $("#to-station").addClass('parsley-error');
            return;
        }

        var strDate = $("#sdate-search").val();

        ga_track_event('Home Page', 'Quick Book', 'Quick Book Button');
        var t = '#search/minimized';
        window.location.href = t+'?from='+$("#from-station").val()+'&to='+$("#to-station").val()+'&date='+strDate;
    });
}

function loadRecentBookings() {
    if( $('#recent-bookings').length == 0 ) { return; }
    $('#recent-bookings').html(loading_small);
    $.ajax({
        type: "POST",
        url: base_url + "widget/get-recent-bookings",
        dataType: 'html',
        success: function(result) {
           $('#recent-bookings').html(result);
        }
    });
}

function loadToPayVouchers() {
    if( $('#payment-vouchers').length == 0 ) { return; }
    $('#payment-vouchers').html(loading_small);
    $.ajax({
        type: "POST",
        url: base_url + "widget/get-payment-vouchers",
        dataType: 'html',
        success: function(result) {
           $('#payment-vouchers').html(result);
        }
    });
}

function makeVoucherPayment(code) {
    $('#voucher-pay-dialog').css('background', '#fff');
    $('#voucher-pay-dialog').removeClass('hide');
    $('#voucher-pay-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#voc_code').val(code);
}

function closeVoucherPaymentDialog() {
    $('#voucher-pay-dialog').dialog('destroy');
    $('#voucher-pay-dialog').hide();
    loadToPayVouchers();
}

function confirmVoucherPaymentStatus() {
    var data = {};
    data.code = $('#voc_code').val();
    data.transactionMode = $('#voc_pay_mode').val();
    data.remarks = $.trim( $('#voc_pay_remarks').val() );

    var err = 0;
    if (data.transactionMode == '') {
        $('#voc_pay_mode').addClass('inp_error');
        err++;
    } else {
        $('#voc_pay_mode').removeClass('inp_error');
    }

    if (err > 0) {
        $('#vou-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#vou-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#vou-action-state').show();
        return false;
    } else {
        $('#vou-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#vou-action-state').hide();
    }

    $('#form-bttons').hide();
    $('#vou-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#vou-action-state').html(loading_popup);
    $('#vou-action-state').show();


    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "voucher/update-payment-status",
        data: data,
        success: function(res) {
            if (res.status == 1) {
                $('#form-bttons').hide();
                $('#vou-action-state').removeClass('alert-danger');
                $('#vou-action-state').addClass('alert-success');
                $('#vou-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    closeVoucherPaymentDialog();
                    loadToPayVouchers();
                }, 3000);
            } else {
                $('#vou-action-state').addClass('alert-danger');
                $('#vou-action-state').html(res.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
}

