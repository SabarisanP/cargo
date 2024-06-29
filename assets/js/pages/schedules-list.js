

function init_schedules_page_actions(date) {


    $('.trip-date').datepicker({
        todayHighlight: true,
        format: "yyyy-mm-dd",
        //startDate: '-0m',
    });



    var date_new = new Date();
    $('.trip-date').datepicker("setDate", date_new);

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var tabload = $(this).attr('href');
        //e.target // activated tab
        //e.relatedTarget // previous tab
        //if (($(tabload).attr('data-load') == ' ' || $(tabload).attr('data-load') == undefined) && ($(this).attr('data-view') != '' && $(this).attr('data-view') != undefined)) {
        if ($(this).attr('data-view') != '' && $(this).attr('data-view') != undefined) {
            $(tabload).html(loading_big);
            $.ajax({
                type: "POST",
                url: "schedules/" + $(this).attr('data-view'),
                dataType: 'html',
                //async: false,
                success: function (res) {
                    $(tabload).html(res);
                    //$(tabload).attr('data-load', '1');
                }
            });
        }
        //}
    });

    if (date != 1) {
        window.setTimeout(function () {
            searchTrip(1, date);
        }, 100);

    }
}


function searchTrip(prm, date) {
    var data = {}
    data.searchType = prm;
    data.date = $.datepicker.formatDate("yy-mm-dd", $('.trip-date').datepicker('getDate')); //$('.trip-date').datepicker('getDate');
    if (prm == 1) {
        if (date == '' || date == undefined) {
            data.date = $.datepicker.formatDate("yy-mm-dd", $('.trip-date').datepicker('getDate')); //$('.trip-date').datepicker('getDate');
        } else {
            data.date = date;
        }
        $('#trip-schedules-list').html(loading_big);
        $('.trip-form-control').hide();
    } else if (prm == 2) {

        /*  if ($('#date-schedules-trips').val() == '' && $('#trip-from-station').val() == '' && $('#trip-to-station').val() == '') {
         $('#trip-error').html('<div class="alert alert-danger">Please select any one of filter.</div>');
         return false;
         }*/
        data.date = $('#date-schedules-trips').val();
        /* data.fromStation = $('#trip-from-station').val();
         data.toStation = $('#trip-to-station').val();*/
        $('#trip-table-list').html("<div align='center'>" + loading_big + "</div>");
    }
    $.ajax({
        type: "POST",
        url: "schedules/get-schedules-trips",
        data: data,
        dataType: 'html',
     //   async: false,
        cache : false,
        success: function (res) {
            if (prm == 1) {
                $('#trip-schedules-list').html(res); //date-schedules-trips                
            } else if (prm == 2) {
                $('#trip-table-list').html(res);
            }
            
            $('#hid-trip-date').val(data.date);
            
            $("[data-toggle='tooltip']").tooltip();
            if ($('.trip-pie').length) {
                $('.trip-pie').each(function () {
                    var ele = '#' + $(this).attr('id');
                    var tmp = $(this).attr('data-percent');
                    if(parseInt(tmp)<=30) {
                        var color = '#c0392b';
                    } else if(parseInt(tmp)>=31 && parseInt(tmp)<=50) {                        
                        var color = '#d7af0d';
                    } else if(parseInt(tmp)>=51 && parseInt(tmp)<=70) {
                        var color = '#4fbeba';
                    } else {
                        var color = '#2ca02c';
                    }
                    chartdata = [
                        {label: "Booked", data: $(this).attr('data-booked'), color: color},
                        {label: "Vacant", data: $(this).attr('data-vacant'), color: '#efefef'},
                    ];
                    $.plot(ele, chartdata, {
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
                });
            }

            /*if($('.easy_chart_booked').length) {
             $('.easy_chart_booked').easyPieChart({
             animate: 2000,
             size: 40,
             lineWidth: 5,
             scaleColor: false,
             barColor: '#27ae60',
             trackColor: '#eafaf1',
             lineCap: 'square'
             });
             }
             if($('.easy_chart_vacant').length) {
             $('.easy_chart_vacant').easyPieChart({
             animate: 2000,
             size: 40,
             lineWidth: 5,
             scaleColor: false,
             barColor: '#c0392b',
             trackColor: '#fbf0ee',
             lineCap: 'square'
             });
             }*/
        }
    });
}

function init_tab(code) {

    if ($('.sctp-' + code).html() == '') {
        var divHtml = $('#get-schedules-tab').html();
        divHtml = $('<div>').html(divHtml).clone();
        $('.sctp-' + code).html(divHtml);
        var html = loadTabData(code);
        $('.exp-tb').html(html);
        $('.sctp-' + code).slideDown('slow');
        $(".toggle-expensive-list").hide();
        togglebox();
    }
}

function tabschange(obj) {
    var link = $(obj).attr('href');
    var name = $(obj).attr('name');
    var code = $(obj).attr('code');

    $('.tbs-sctrp').html('').closest("td").addClass('bor-0');

    $('.sctp-' + code).closest("td").removeClass('bor-0');

    if ($('.sctp-' + code).html() == '') {
        var divHtml = $('#get-schedules-tab').html();
        divHtml = $('<div>').html(divHtml).clone();
        $('.sctp-' + code).html(divHtml);

    } else {
        $('.sctp-' + code).find('div.active').removeClass('active').removeClass('in');
        $('.sctp-' + code).find('li.active').removeClass('active');

        $('.sctp-' + code).find('#tabs' + link).tab('show');
        $('.sctp-' + code).find('a[href="' + link + '"]').parents('li').addClass('active').addClass('in');
    }



}

/*  $.ajax({
 type: "POST",
 url: "schedules/get-schedules-tabs",
 dataType : 'html',
 success: function(res) {
 $('.sctp-' + code).find('div.active').removeClass('active').removeClass('in');
 $('.sctp-' + code).find('li.active').removeClass('active');
 
 $('.sctp-' + code).find('#tabs'+link).tab('show');
 $('.sctp-' + code).find('a[href="'+link+'"]').parents('li').addClass('active').addClass('in');
 
 }
 });
 */

function loadTabData(code) {
    var data = {}
    data.tripCode = code;
    var html = '';
    $.ajax({
        type: "POST",
        url: "schedules/get-schedules-tabs",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res) {
            html = res;
        }
    });
    return html;
}
function saveTripExpensive() {
    var data = {}
    data.name = $('#exps-name').val();
    data.tmode = $('#exps-mode').val();
    data.thead = $('#exps-head').val();
    data.amount = $('#exps-amount').val();
    data.remark = $('#exps-remark').val();
    data.tripCode = $('#tripCode').val();
    var err = 0;
    $('#exps-amount').removeClass('inp_error');
    $('#sch-trp-exp').html('');
    if (data.name == '') {
        $('#exps-name').addClass('inp_error');
        err++;
    }
    if (data.tmode == '') {
        $('#exps-mode').addClass('inp_error');
        err++;
    }
    if (data.thead == '') {
        $('#exps-head').addClass('inp_error');
        err++;
    }
    if (data.amount == '') {
        $('#exps-amount').addClass('inp_error');
        err++;
    }
    if (err > 0) {
        $('#sch-trp-exp').html('<div align="center" class="alert alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }


    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-expensive",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                $('.exp-tb').html('');
                var html = loadTabData(data.tripCode);
                $('.exp-tb').html(html);
                $(".toggle-expensive-list").hide();
                togglebox();
            }
        }
    });

}
function togglebox() {
    $("#toggle-expensive").click(function () {
        $(".toggle-expensive-list").slideToggle("slow");
    });
}

function deleteSchedule(code) {
    if (confirm('Do you want to delete this schedule?')) {
        var data = {};

        data.activeFlag = 2;
        data.code = code;


        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedule",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    $('#sch_' + response.data.code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}

function scheduleMoreOption(code) {
}
function closeScheduleOptions() {
    $('#log').val('');
    $('.viw_mre').each(function () {
        $(this).removeClass('hide');
        $(this).removeClass('active-row');
        $('#act-sch-workspace').addClass('hide');
        $('#sch-workspace-content').html('');
        $('#act-sch-tbl tbody tr').each(function () {
            $(this).removeClass("hide");
        });
    });
    
    var sc = $('#sch_code').val();
    $('#sch-'+sc).removeClass('open');
    $('html, body').animate({
        scrollTop: $('#sch-'+sc).offset().top-120
    }, 1500);
    
}

function closeTripOptions() {
    $('#log').val('');
    $('.viw_mre_trp').each(function () {
        $(this).removeClass('hide');
        $(this).removeClass('active-row');
        $('#trp-sch-workspace').addClass('hide');
        $('#trp-workspace-content').html('');
        $('#mail_inbox tbody tr').each(function () {
            $(this).removeClass("hide");
        });
    });
    var tc = $('#trpcode').val();   
    if( _isdefined(tc) & tc !='' ) {
        $('html, body').animate({
            scrollTop: $('#trp-'+tc).offset().top-120
        }, 1500);
    }
}
function getActiveScheduleCode() {
    var c = $('#act-sch-tbl').find('.active-row').attr('data-schedule-code');
    return c;
}

function init_seat_visiblity() {
    var data = {};
    data.sch_code = getActiveScheduleCode();

}

function setScheduleState(code, state) {

    var data = {};
    data.sch_state = state;
    data.sch_code = code;
    var txt = '';
    if (state == 0) {
        txt = 'Do you want to close this schedule, please make sure all advance booking tickets are transfered to other schedule?';
    } else if (state == 9) {
        txt = 'Do you want to activate / open this schedule?';
    }
    
    swal({
        title: "Are you sure?",
        text: txt,
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn-danger",
        confirmButtonText: "Yes, Continue!",
        closeOnConfirm: false
    },
    function(){
        if(state==0) {
            swal({
                title: "Please wait...",
                text: "Validating advance booking.",
                imageUrl: 'assets/img/loaders/19.gif',
                showConfirmButton:false
            });
            
            var data1 = {};
            data1.schedule_code = code;
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "report/schedule-advance-booking",
                data: data1,
                success: function (response) {
                    if(response.travel_date.length>0) { //  adv booking found
                        swal("Sorry!", "Advance booking found, please transfer advance booking tickets to other schedule and try again.", "error");
                    } else {
                        $('#loading_trip').html(loading_popup);
                        $.ajax({
                            type: "POST",
                            dataType: 'json',
                            url: base_url + "schedules/set-schedule-state",
                            data: data,
                            success: function (res) {
                                if (res.status == 1) {
                                    $('#sch-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                                        $(this).remove();
                                    });
                                    $('#loading_trip').html('');
                                    swal("Success!", "Schedule has been closed.", "success");
                                }
                            }
                        });
                    }
                }
            });
        } else {
            $('#loading_trip').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "schedules/set-schedule-state",
                data: data,
                success: function (res) {
                    if (res.status == 1) {
                        $('#sch-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                            $(this).remove();
                        });
                        $('#loading_trip').html('');
                        swal("Success!", "Schedule has been open.", "success");
                    }
                }
            });
        }        
    });
}

function cloneSchedule(scode){ 
    $('#sch-clone').removeClass('hide');
    $('#sch-clone').dialog({
        autoOpen: true,
        height: 450,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#clone_sch_id').val(scode);
    $('.schd_rows').removeClass('last-active');
    $('#sch-' + scode).addClass('last-active');
}
function doClone() {
    var opts = [];
    var data = {};
    $('.chk_sch_clone:checked').each(function() {
        opts.push( $(this).val() );
    });
    
    data.clonetype = $('.chk_sch_clone_type:checked').val();
        
    $('#save-as-bttons').addClass('hide');
    $('#save-as-action').removeClass('hide');
    $('#save-as-action').html(loading_popup);
    
    data.code = $('#clone_sch_id').val();
    data.options = opts.join(',');
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/do-clone",
        data: data,
        success: function (res) {
            if (res.status == 1) {
                $('#save-as-action').removeClass('alert-danger').addClass('alert-success');
                $('#save-as-action').html('Your request has been processed successfully. <br>Please wait... you will be redirected.');
                window.setTimeout(function () {
                    closeClonePopup();
                    window.location.href = "#schedules/edit-schedules?c=1&t=0&i="+res.data.code;
                }, 3000);
            } else {
                $('#save-as-action').removeClass('alert-success').addClass('alert-danger');
                $('#save-as-action').html(res.errorDesc);
                window.setTimeout(function () {
                    $('#save-as-bttons').removeClass('hide');
                    $('#save-as-action').addClass('hide');
                    $('#save-as-action').html('');
                }, 4000);
            }
        }
    });
}
function closeClonePopup() {
    $('#sch-clone').dialog('destroy');
    $('#sch-clone').addClass('hide');
}

function pushSchedule(tcode, scode){ 
    $('#sch-push').removeClass('hide');
    $('#sch-push').dialog({
        autoOpen: true,
        height: 525,
        width: 600,
        modal: true,
        resizable: false
    });
    $('#push-action').html('');
    $('#push-action').removeClass('alert-success').removeClass('alert-danger');
    $(".ui-dialog-titlebar").hide();
    $('#push_trip_code').val(tcode);
    $('#push_sch_code').val(scode);
    
    var data = {};
    data.code = scode;

    $('#push-routes-cont').html(loading_small);
    $.ajax({
        type: 'POST',
        url: 'schedules/get-schedule-routes-fare',
        data: data,
        dataType: 'json',
        success: function (res) {
            $('#push-routes-cont').html('<label><input type="checkbox" onchange="togglePushRoutes(this);"> Select all</label>');
            $.each(res, function(i, val){
                $('#push-routes-cont').append('<div class="col-md-6 p_l_n"><label class="checkbox-inline"><input type="checkbox" class="push-route-cb" value="' + i + '">&nbsp;' + val.fromStation.name + ' - ' + val.toStation.name + '</label></div>');
            });
        }
    });
}
function togglePushRoutes(ele) {
    var value = $(ele).is(':checked');
    $('.push-route-cb:checkbox').each(function() {
        $(this).prop('checked', value);
    });
}
function doPushSchedule() {
    var data = {};
    data.tripCode = $('#push_trip_code').val();
    data.tripDate = $('#push-tripdate').val();
    data.tillDay = $('#push-tilldays').val();
    data.pushstations = 0;
    if( $('.push-stations').is(':checked')) {
        data.pushstations = 1;
    }
    
    data.routeList = $('.push-route-cb:checked').map(function() { 
        return $(this).val(); 
    }).get();
    
    $('.inp_error').removeClass('inp_error');
    if (data.tripDate == '') {
        $('#push-tripdate').addClass('inp_error');
        $('#push-action').addClass('alert-danger').removeClass('hide');
        $('#push-action').html('Please enter/select the values in the field that are marked in red');
        return false;
    }
    if (data.routeList.length == 0) {
        $('#exps-mode').addClass('inp_error');
        $('#push-action').addClass('alert-danger').removeClass('hide');
        $('#push-action').html('Please select atleast one route');
        return false;
    }
        
    $('#push-buttons').addClass('hide');
    $('#push-action').html(loading_popup).removeClass('alert-success').removeClass('alert-danger').removeClass('hide');
      
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/push-to-vendor",
        data: data,
        success: function (res) {
            if (res.status == "ok") {
                $('#push-action').removeClass('alert-danger').addClass('alert-success');
                $('#push-action').html('Your request has been processed successfully.');
                window.setTimeout(function () {
                    $('.push-stations').prop('checked', false);
                    $('#push-buttons').removeClass('hide');
                    $('#push-action').removeClass('alert-success').removeClass('alert-danger').removeClass('hide');
                    //closePushPopup();
                }, 1000);
            } else {
                $('#push-action').removeClass('alert-success').addClass('alert-danger');
                $('#push-action').html(res.message);
                window.setTimeout(function () {
                    $('#push-buttons').removeClass('hide');
                    $('#push-action').addClass('hide');
                    $('#push-action').html('');
                }, 10000);
            }
        }
    });
}
function closePushPopup() {
    $('#sch-push').dialog('destroy');
    $('#sch-push').addClass('hide');
}

