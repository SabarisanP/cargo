var ua = [];    //  user action recorder
function ua_record(i) {
    ua[i] = 1;    
}
function ua_reset() {
   ua[0] = 0; ua[1] = 0; ua[2] = 0; ua[3] = 0; ua[4] = 0; ua[5] = 0; 
}
function ua_is_edited(i) {
    return ua[i];
    //return 1;
}

function setContentHeight($wizard) {
    setTimeout(function () {
        var cur_height = $($wizard).children('.content').children('.body.current').outerHeight();
        $($wizard).find('.content').height(cur_height);
    }, 0);
}

function fillField() {
    var fval = $('#name_sch').val(); //service_sch ,service_sch
    $('#service_sch,#display_sch').val(fval);
}
function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}
function saveBasicSchedule() {
    //service_sch,display_sch,name_sch,PNR_sch,RTB_sch
    $('.err-act').html('');
    $('#adv-book-link').addClass('hide');
    var err = 0;
    if ($('#name_sch').val() == '') {
        $('#name_sch').addClass('parsley-error');
        err++;
    } else {
        $('#name_sch').removeClass('parsley-error');
    }
    if ($('#date_sch').val() == '') {
        $('#date_sch').addClass('parsley-error');
        err++;
    } else {
        $('#date_sch').removeClass('parsley-error');
    }
    
    if ($('#tax').val() == '') {
        $('#tax').addClass('parsley-error');
        err++;
    } else {
        $('#tax').removeClass('parsley-error');
    }
    
    if ($('#PNR_sch').val() == '') {
        $('#PNR_sch').addClass('parsley-error');
        err++;
    } else {
        $('#PNR_sch').removeClass('parsley-error');
    }
    if ($('#RTB_sch').val() == '') {
        $('#RTB_sch').addClass('parsley-error');
        err++;
    } else {
        $('#RTB_sch').removeClass('parsley-error');
    }
    if (!$("input[name='week']:checkbox:checked").length > 0) {
        $(".chk-btn").addClass('parsley-error');
        err++
    } else {
        $(".chk-btn").removeClass('parsley-error');
    }    
    if (menu_permission['USR-APLY-SECTOR'] == 1) {
        if (($('#sch-basic-sector').val() || []).length == 0) {  
            getScheduleSectors();
            $('.toggle-list').show();
            setContentHeight('#wizard_form');
        
            $('#sch-basic-sector').addClass('parsley-error');
            err++;
        } else {
            $('#sch-basic-sector').removeClass('parsley-error');
        }
    }
    if (err > 0) {
        $('.err-act').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }
    if ($('#RTB_sch').val() > 59) {
        $('#RTB_sch').addClass('parsley-error');
        $('.err-act').html('<div class="alert fl alert-danger">Please enter valid report time.</div>');
        return false;
    }
    $('.err-act').html(loading_small);

    var dateSch = $('#date_sch').val();
    var date = dateSch.split('|');
    var data = {}

    data.name = $('#name_sch').val();
    data.serviceNumber = $('#service_sch').val();
    data.activeFlag = $('#activeFlag').val();
    data.mobileTicketFlag = $('#ph_bkg:checked').val() ? 1 : 0;
    data.boardingReportingMinitues = $('#RTB_sch').val();
    data.displayName = $('#display_sch').val();
    data.pnrStartCode = $('#PNR_sch').val();
    data.apiDisplayname = $('#API_dn').val();
    data.code = $('#sch_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.tax = $('#tax').val();
    data.serviceTax = $('#service_tax').val();
     data.scheduleTagList = $.map($('#sch-basic-tag').val() || [], function (val) {
                return { code: val };
            });
    data.sectorList = $.map($('#sch-basic-sector').val() || [], function (val) {
        return { code: val };
    });
    data.dayOfWeek = $("#weekdays :checkbox").map(function () {
        return +$(this).is(':checked');
    }).get();
    
    // category tag
    data.tag = $('#RTB_tag').val();
    data.tagCode = $('#RTB_tag_code').val();

    $.ajax({
        type: "POST",
        url: "schedules/update-schedules",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                $('.err-act').html('');
                $('#sch_code').val(res.data.code);
                $('#sch_tmp_code').html('Code : ' + res.data.code);
                return true;
            } else if (res.status == 110) {
                $('#date_sch').addClass('parsley-error');
                $('#adv-book-link').removeClass('hide');
                $('.err-act').html('');
                setContentHeight('#wizard_form');
                return false;
            } else{
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
                return false;
            }
        }
    });
}
function stationSchedule(currentIndex, newIndex) {

    if (newIndex == 0) {
        return true;
    }
    $('.err-act').html(loading_small);
    if ($("input[name='station-sched-code']").val() == undefined || $("input[name='station-sched-code']").val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please add the stations.</div>');
        return false;
    }
    var c = 0;
    $("input[name='station-sched-code']").each(function () {
        if ($(this).val() != '') {
            c++;
        }
    });
    if (c < 2) {
        $('.err-act').html('<div class="alert fl alert-danger">Please add atleast two stations to create a route.</div>');
        return false;
    }
    $('.err-act').html('');
}
function changeBusType() {
    var dateSch = $('#date_sch').val();
    var date = dateSch.split('|');
    var data = {}
   
    data.code = $('#sch_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    
    $('#change_bus_link').find('.well').html('Validating...');
    
    $.ajax({
        type: "POST",
        url: "schedules/can-edit-bus-layout",
        data: data,
        dataType: 'json',        
        success: function (res) {
            if (res.status == 1) {
                $('#change_bus_link').hide();
                $('#bustype').removeAttr('disabled').css('display','block');   
            } else if (res.status == 110) {                
                $('#change_bus_link').html('<div class="alert alert-danger">'+res.errorDesc+'</div>');                
            }
        }
    });
    
     
}
function saveBusSchedule(currentIndex, newIndex) {

    if (newIndex == 1) {
        return true;
    }
    
    if( ua_is_edited(currentIndex) == 0) { // check is edited any info
        return true;
    }
    ua_reset();  
    var dateSch = $('#date_sch').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.busCode = $('#bus-sch-code').val();
    data.dayOfWeek = $("#weekdays :checkbox").map(function () {
        return +$(this).is(':checked');
    }).get();
    
    data.amenities = $('#amenities').val();
    data.bustype = $('#bustype').val();

    if ($('#bustype').val() == '') {
        $('#bustype').addClass('parsley-error');
        $('.err-act').html('<div class="alert fl alert-danger">Please select the bus type</div>');
        return false;
    } else {
        $('#bustype').removeClass('parsley-error');
        $('.err-act').html('');
    }
    $('.err-act').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-bustype",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                $('.err-act').html('');
                setContentHeight('#wizard_form');
                //return true;
                $('#bus-sch-code').val(res.data.code);
                //var html = "<option value='" + data.bustype + "' selected='selected'>" + $('#bustype').find(":selected").text() + "</option>";
                //$('#bus-type-sch-seat').append(html);
            } else {
                if(res.errorCode=="315A"){
                    res.errorDesc = 'Advance booking identified, Not allowed to change bus type.';
                }
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
                return false;
            }
        }
    });


}
function routesFarechecking(currentIndex, newIndex) {

    if (newIndex == 2) {
        return true;
    }
    var rout = 0;
    $('.routes-map').each(function (i) {
        if ($(this).val() != '') {
            rout++;
        }
    })
    var routesValue = $('.routes-map').html();
    if (routesValue == undefined) {
        $('.err-act').html('<div class="alert fl alert-danger">Please add routes fare.</div>');
        return false;
    } else {
        $('.err-act').html('');
    }




}
function saveExit(obj) {
    var currentIndex = $(obj).attr('data-cur');
    var newIndex = $(obj).attr('data-new');
    
    switch (newIndex) {
        case "0":
            saveBasicSchedule();
            if ($('#adv-book-link').hasClass('hide')) {
                redirectLoction();                
            } else {
                return false;
            }            
            break;
        case "1":
            stationSchedule(currentIndex, newIndex);
            redirectLoction();
            break;
        case "2":
            saveBusSchedule(currentIndex, newIndex);
            redirectLoction(); 
            break;
        case "3":
            routesFarechecking(currentIndex, newIndex);
            redirectLoction();
            break;
    }
}
function redirectLoction() {
    window.location.href = base_url + "#schedules";
}
function init_schedule_wizard() {


    var wizard_form = $('#wizard_form');
    // initialize wizard
    if ($("#wizard_form").length) {
        wizard_form.steps({
            headerTag: 'h3',
            bodyTag: "section",
            enableAllSteps: true,
            titleTemplate: "<span class=\"number\">#index#</span><span class=\"title\">#title#</span>",
            transitionEffect: "slideLeft",
            labels: {
                next: "Next Step <i class=\"fa fa-angle-right\"></i>",
                previous: "<i class=\"fa fa-angle-left\"></i> Previous Step",
                current: "",
                finish: "<i class=\"fa fa-check\"></i> Finished"
            },
            onStepChanging: function (event, currentIndex, newIndex) {
                if (newIndex == 2) {
                    getSeatVisiblitySchedulesByselect();
                }
                var cursentStep = wizard_form.find('.content > .body').eq(currentIndex);
                // check input fields for errors
                cursentStep.find('[data-parsley-id]').each(function () {
                    $(this).parsley().validate();
                });
                var result = '';
                $('.err-act').html('');
                //if(currentIndex > newIndex){
                $('.bt-small').attr('data-cur', currentIndex);
                $('.bt-small').attr('data-new', newIndex);
                if (currentIndex == 0) {
                    saveBasicSchedule();
                    if ($('#adv-book-link').hasClass('hide')) {                        
                        if ($('#bustype').val() != '' && $('#bus-type-sch-seat option[value=' + $('#bustype').val() + ']').length == 0) {
                            var html = "<option value='" + $('#bustype').val() + "' selected='selected'>" + $('#bustype').find(":selected").text() + "</option>";
                            $('#bus-type-sch-seat').append(html);
                        }
                        getSchedulesStation();
                        setContentHeight('#wizard_form');
                    } else {
                        $('.bt-small').attr('data-cur', currentIndex);
                        $('.bt-small').attr('data-new', currentIndex);
                    }
                }
                if (currentIndex == 1) {
                    stationSchedule(currentIndex, newIndex);
                }
                if (currentIndex == 2) {
                    saveBusSchedule(currentIndex, newIndex);
                    load_routes();
                }
                
                if (currentIndex == 3) {
                    if($('#routes-schedules-form-div').is(':visible') && $('#routes-schedules-form-div .routes-fare:valid').length) {
                        $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">Please save route fare.</div>');
                        setContentHeight('#wizard_form');
                        return false;
                    } else {
                        $('#routes-fare-sch-loading').html('');
                    }
                    routesFarechecking(currentIndex, newIndex);
                    cancelSchedules();
                }
                if (currentIndex == 4) {
                    if (newIndex == 3) {
                        return true;
                    }
                    // getSeatVisiblitySchedules();
                    bookingschedules();
                }
                if (currentIndex == 5) {
                    if (newIndex == 4) {
                        return true;
                    }
                    //reviewSchedules();
                }
                if (currentIndex == 6) {
                    if (newIndex == 5) {
                        return true;
                    }
                    //  reviewSchedules();

                }

                // adjust wizard height


                if (cursentStep.find('.parsley-error').length) {
                    return false;
                } else {
                    return true;
                }
            },
            onStepChanged: function (event, currentIndex, priorIndex) {
                if (currentIndex == 3 && $('#rout-list').text().length == 0) {
                    load_routes();
                } else if (currentIndex == 4 && $('#cancel-list').text().length == 0) {
                    cancelSchedules();
                } else if (currentIndex == 5 && $('#booking-list').text().length == 0) {
                    //  getSeatVisiblitySchedules();
                    bookingschedules();
                } else if (currentIndex == 6) {


                    $('.wizard_pagination').find('.btn').addClass('disabled');
                    if ($('#rout-list').text().length == 0) {
                        load_routes();
                    }
                    if ($('#cancel-list').text().length == 0) {
                        cancelSchedules();
                    }

                    if ($('#booking-list').text().length == 0) {
                        bookingschedules();
                    }
                    reviewSchedules();
                    $('.wizard_pagination').find('.btn').removeClass('disabled');
                }
                thisIndex = currentIndex;

                setContentHeight('#wizard_form');
            },
            onFinishing: function (event, currentIndex) {
                $('.err-act').html(loading_small);
                var data = {}
                data.code = $('#sch_code').val();
                $.ajax({
                    type: "POST",
                    url: "schedules/schedules-refresh",
                    data: data,
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        if (res.status == 1) {
                            $('.err-act').html('<div class="align-center alert alert-success">' + res.data + '</div>'); // Your request has been completed successfully
                            window.setTimeout(function () {
                                $('.err-act').html('');
                                window.location.hash = '#schedules';
                            }, 2000);
                        } else {
                            $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
                            return false;
                        }
                    }
                });
                var cursentStep = wizard_form.find('.content > .body').eq(currentIndex);
                // check input fields for errors
                cursentStep.find('[data-parsley-id]').each(function () {
                    $(this).parsley().validate();
                });

                // adjust wizard height
                setContentHeight('#wizard_form');

                if (cursentStep.find('.parsley-error').length) {
                    return false;
                } else {
                    return true;
                }
            },
            onFinished: function (event, currentIndex) {

            }
        });

    }

    /*$('.pTip_top').attr('title','');
     $('.pTip_top').each(function(){
     $(this).attr('title',$(this).attr('alt'));
     });*/
    //$('.pTip_top').powerTip({ placement: 'n' });
    ua_reset();
    $('a[href="#previous"]').parent().after('<li class="pull-left col-md-offset-1 err-act"></li>');

    $('input[name="date_sch"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
        //        yearRange: '1930:+0',



    });
    $('input[name="basic_except"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true
    });

    $("#toggle-l").click(function () {
        $(".toggle-list").toggle();
        setContentHeight('#wizard_form');
    }).one('click', getScheduleSectors);
    
    $('.bs_switch').bootstrapSwitch('size', 'mini');
    $('select.amenities').select2({
        placeholder: "Select amenities",
        escapeMarkup: function (markup) {
            return markup;
        }
    });
    
    $('#sch-basic-tag').select2({
        placeholder: "Select Tags",
        maximumSelectionSize: 3
    });
    $("#RTB_sch").inputmask({"mask": "99"});
    $("#PNR_sch").inputmask({"mask": "AAA"});
    setContentHeight('#wizard_form');
    $('.toggle-list').hide();

    $('#review-schedules').on('shown.bs.collapse', function () {
        setContentHeight('#wizard_form');
    });
    $('#review-schedules').on('hidden.bs.collapse', function () {
        setContentHeight('#wizard_form');
    })
    /*$('a[data-parent="#review-schedules"]').bind('click', function() {
     var $wizard = $('#wizard_form'); 
     var cur_height = $($wizard).children('.content').children('.body.current').outerHeight();
     $($wizard).find('.content').height(cur_height);
     
     });*/

    var index = GetParameterValues('t');

    if (index != '' && index != undefined) {
        changesSteps(index);
        $('a[href="#next"]').parent().after('<li class="pull-right"><a class="btn btn-success bt-small" href="javascript:;" onclick="saveExit(this)" data-cur="0" data-new="0" >Save & Exit</a>&nbsp;&nbsp;&nbsp;</li>');
        if (index == 3) {
            load_routes();
        }
    }

    var driverList = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('tagName'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: base_url + 'schedules/tags?rnd=' + Math.random(),
    });
    driverList.initialize();

    $('#RTB_tag').typeahead(null, {
        name: 'best-pictures',
        displayKey: 'tagName',
        source: driverList.ttAdapter(),
        templates: {
            empty: [
                '<div class="empty-message">',
                'unable to find',
                '</div>'
            ].join('\n'),
            suggestion: Handlebars.compile('<p><strong>{{tagName}}</strong></p>')
        }
    }).on('typeahead:selected', function (e, d, n) {
        $('#RTB_tag').val(d.tagName);
        $('#RTB_tag_code').val(d.tagCode);
    });

}

function stationSchedulesDialog(opt) {
    $('#schedules-station-dialog').css('background', '#fff');
    $('#station-sch-mobno').removeClass('inp_error');


    $('#schedules-station-dialog').removeClass('hide');
    $('#schedules-station-dialog').show();
    $('#schedules-station-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $("#station-schedules-day-type option[value='1']").removeAttr('disabled', 'disabled');
    $("#station-schedules-day-type option[value='2']").removeAttr('disabled', 'disabled');

    $('#station-sch-button,.sta-sch-dy').show();
    var h = $('#main_wrapper').height() + 100;
    $('.ui-widget-overlay').height(h);
    //

    $('.advance-station-schedules').hide();

    $('#station-week-days').find("input[name='station-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');        
        $(this).parent().addClass('active');
    });
    $('#station-schedules-date').val('');
    $('#station-sch-mobno').val('');
    if (_isdefined(opt)) {
        $("input[name='station-week']").each(function (i) {
            $(this).removeAttr("checked");
            $(this).parent().removeClass('active');
        });

        var stationtime = $('#station-sched-time-' + opt).val();
        $('#station_code').val(opt);
        //$('#station-list-sch').val( $('#station-sched-code-' + opt).val() );
        $("#station-list-sch").select2("val", $('#station-sched-code-' + opt).val());

        $('#station-schedules-date').val($('#station-sched-daterange-' + opt).val());
        if (stationtime > 1439 && stationtime < 2880) {
            stationtime = stationtime - 1440;
            $('#station-schedules-day-type').val(2);
        }
        else if (stationtime > 2879) {
            stationtime = stationtime - 2880;
            $('#station-schedules-day-type').val(3);
        }


        $('#station-sch-hours').val(stationtime);
        $('#station-time-range').val(stationtime);

        if ($('#station-days-schedules-' + opt).val() != '' && $('#station-days-schedules-' + opt).val() != undefined) {
            var str = $('#station-days-schedules-' + opt).val();

            var res = str.split("");

            $("input[name='station-week']").each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked").prop("checked", "checked");
                    $(this).parent().addClass('active');
                }

            });
            $('.advance-station-schedules').show();
        }

        if ($('#station-days-range-schedules-' + opt).val() != '' && $('#station-days-range-schedules-' + opt).val() != undefined) {
            $('#station-schedules-date').val($('#station-days-range-schedules-' + opt).val());
        }
        
        $('#station-sch-mobno').val( $('#station-days-mobno-' + opt).val() );
    }

    if (station_json != undefined) {
        var pretime, crn, type;
        $.each(station_json, function (k, sval) {
            if (sval.code == opt) {
                return false;
            }
            pretime = sval.minitues;
        });


        if (pretime > 1439 && pretime < 2880) {
            var t = 2;
        } else if (pretime > 2879) {
            type = 3;
        } else {
            type = 1;
        }

        if (type == 2 || $('#station-schedules-day-type').val() == 2) {
            $("#station-schedules-day-type option[value='1']").attr("disabled", "disabled");
        } else if (type == 3) {
            $("#station-schedules-day-type option[value='1']").attr("disabled", "disabled");
            $("#station-schedules-day-type option[value='2']").attr("disabled", "disabled");
        }
    }

    var seq = 1;
    $('.sequence').each(function () {
        if ($(this).val() != '') {
            seq++;
        }
    });

    if (seq != '' && seq > 0) {
        $('#stationSequence').val(seq);
    }
    if (seq == 1 || $('#station-sequence-' + opt).val() == 1) {
        $('.sta-sch-dy').hide();
    }



    $("#station-sch-hours").ionRangeSlider({
        type: "single",
        step: 5,
        postfix: "",
        from: function () {
            if ($('#station-sch-hours').val() != '') {
                return $('#station-sch-hours').val();
            } else {
                return 0;
            }
        },
        to: 23.59,
        max: 1439,
        min: 0,
        // hideMinMax: true,               // hide Min and Max fields
        hideFromTo: true, // hide From and To fields
        onLoad: function (ui) {
            $('.irs-min').html("0");
            $('.irs-max').html("23.59");
        },
        onChange: function (ui) {
            $('#station-time-range').val(ui.fromNumber);

            var hours = Math.floor(ui.fromNumber / 60);
            var minutes = ui.fromNumber - (hours * 60);
            if (hours.toString().length == 1)
                hours = '0' + hours;
            if (minutes.toString().length == 1)
                minutes = '0' + minutes;

            $('#station-sch-time-label').html(hours + ':' + minutes);
            //console.log($('#station-time-range').val());
        },
        hasGrid: false
    });
    $('#station-sch-hours').val(0);
}

function cancelStationSchedulesDialog() {
    $('#schedules-station-dialog').dialog('destroy');
    $('#schedules-station-dialog').hide();
    $("#station-sch-hours").ionRangeSlider("remove");
    $('#station-sch-hours').val(0);
    $('#station-time-range').val(0)
    $('#station_code').val('')
    $('#stationSequence').val(1);
    $('#station-sch-loading').html('');
    $("#station-list-sch").select2("val", "");
}
function deleteStationschedules(opt) {
    if (confirm('Do you want to delete this Station?')) {
        var dateSch = $('#date_sch').val();
        var date = dateSch.split('|');
        var data = {};
        data.stationschedules = opt;
        data.code = $('#sch_code').val()
        data.activeTo = date[1];
        data.activeFrom = date[0];
        data.activeFlag = 2;
        data.stationcode = $('#station-sched-code-' + opt).val();
        data.stationtime = $('#station-sched-time-' + opt).val();
        data.mobileNumber = $('#station-days-mobno-' + opt).val()

        data.dayOfWeek = $("#station-week-days :checkbox").map(function () {
            return +$(this).is(':checked');
        }).get();

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-station",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.del-station-sch-' + opt).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    $('#usr-viw-rslt').html('<div class="p_t_100"><div class="well well-large "> Click any of the user name to view more details.</div></div>');
                } else if (response.status == 0 && response.errorCode == '313A') {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    $('html, body').animate({
                        scrollTop: ($('.err-act').offset().top)
                    }, 500);
                    $('.err-act').html('<div class="alert fl alert-danger">' + response.errorDesc + '</div>');
                    window.setTimeout(function () {
                        $('.err-act').html('');
                    }, 3000);
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
function viewStationadvance() {
    $('.advance-station-schedules').show();
}
function saveStationSchedules() {
    var dateSch = $('#date_sch').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val();
    data.stationschedules = $('#station_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.activeFlag = $('#stationactiveFlag').val();
    data.stationcode = $('#station-list-sch').val();
    data.stationtime = $('#station-time-range').val();
    data.mobileNumber = $.trim( $('#station-sch-mobno').val() );
    if ($('#station-sequence-' + data.stationschedules).val() != '' && $('#station-sequence-' + data.stationschedules).val() != undefined) {
        data.stationSequence = $('#station-sequence-' + data.stationschedules).val();
    } else {
        data.stationSequence = $('#stationSequence').val();
    }

    if ($('.advance-station-schedules').css('display') != 'none') {
        var dayOfWeek = $("#station-week-days :checkbox").map(function () {
            return +$(this).is(':checked');
        }).get();
        if (dayOfWeek) {
            data.dayOfWeek = dayOfWeek;
        }
        if ($('#station-schedules-date').val() != '') {
            var stationdate = $('#station-schedules-date').val();
            var sdate = stationdate.split('|');
            data.stationActiveTo = sdate[1];
            data.stationActiveFrom = sdate[0];
        }
    }
    data.dateFlag = $('#station-schedules-day-type').val();



    $('#station-sch-loading').html('');
    if ($('#station-list-sch').val() == '') {
        $('#station-sch-loading').html('<div class="alert pull-left alert-danger">Please select the station.</div>');
        return false;
    }
    var err = 0;
    $('input[name="station-sched-code"]').each(function () {
        if ($('#station-list-sch').val() == $(this).val() && (($('#station_code').val() == '') || $('#station_code').val() != $(this).attr('data-code'))) {
            err++;
        }
    });
    if (err > 0) {
        $('#station-sch-loading').html('<div class="alert pull-left alert-danger">Already station added.</div>');
        return false;
    }
    
    if(data.mobileNumber != '' && !isValidPhonenumber(data.mobileNumber)) {
        $('#station-sch-mobno').addClass('inp_error');
        $('#station-sch-loading').html('<div class="alert pull-left alert-danger">Please enter valid Mobile No.</div>');
        return false;
    } else {
        $('#station-sch-mobno').removeClass('inp_error');
    }

    $('#station-sch-loading').html(loading_small);
    $('#station-sch-button').hide();

    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-station",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                var code = res.data.code;
                $('#station-sch-loading').html('');
                cancelStationSchedulesDialog();
                getSchedulesStation();
                setContentHeight('#wizard_form');
            } else {
                $('#station-sch-loading').html('<div class="alert pull-left alert-danger">' + res.errorDesc + '</div>');
                $('#station-sch-button').show();
            }
        }
    });

}
function stationPointSchedulesDialog(code, scode, opt) {
    $('#schedules-station-point-dialog').css('background', '#fff');
    $('#schedules-station-point-dialog').removeClass('hide');
    $('#schedules-station-point-dialog').show();
    $('#schedules-station-point-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 100,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#station_prt_code').val(code);
    $('#stationa_point_code,#station-point-sch').val('');
    $('.advance-station-point-schedules').hide();

    $('#station-point-schedules-date').val('');
    $('#station-point-schedules-fare').val(0).removeClass('inp_error');
    $('#station-point-bdflag').val(1);
    
    var data = {}
    data.stationCode = code;
    $('#station-point-sch-loading').html(loading_small);
    $('#station-point-sch').html(loading_small);
    $('#station-point-sch-button').hide();
    $.ajax({
        type: "POST",
        url: "schedules/get-stationpoint-by-station-schedules",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                var html = '';
                html += "<option value=''></option>";
                $.each(res.data, function (keys1, cvalues) {
                    html += "<option value='" + cvalues.code + "'>" + cvalues.name + "</option>";
                });
                $('#station-point-sch').html(html);
                $('#station-point-sch-loading').html('');
                $('#station-point-addr').html('');
                $('#station-point-sch').on('change', function(){
                    var val = $(this).val();
                    var sp = _.find(res.data, function(o) { return o.code === val; });
                    $('#station-point-addr').html((!sp) ? '' : (sp.address + ', ' + sp.number));
                });
            }
        }

    });
    $("input[name='station-point-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    if (_isdefined(opt)) {

        var er = $('#station-point-code-' + opt).val();
        if (er != '' && er != undefined) {
            $('#station-point-sch').val(er).trigger('change');
        }
        var st = $('#station-point-time-' + opt).val();

        if (st != '' && st != undefined) {
            $('#point-station-sch-hours').val(st);
            $('#station-point-time-range').val(st);
        }
        if ($('#station-point-days-range-' + opt).val() != '' && $('#station-point-days-range-' + opt).val() != undefined) {
            $('#station-point-schedules-date').val($('#station-point-days-range-' + opt).val());
            viewStationPointAdvance(opt);
        }
        if ($('#station-point-days-week-' + opt).val() != '' && $('#station-point-days-week-' + opt).val() != undefined) {
            $("input[name='station-point-week']").each(function (i) {
                $(this).removeAttr("checked");
                $(this).parent().removeClass('active');
            });
            var str = $('#station-point-days-week-' + opt).val();

            var res = str.split("");
            $("input[name='station-point-week']").each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked").prop("checked", "checked");
                    ;
                    $(this).parent().addClass('active');
                }

            });
            viewStationPointAdvance(opt);
        }
        $('#stationa_point_code').val(opt);
        $('#station-point-schedules-fare').val($('#station-point-fare-' + opt).val() || 0);
        
        var bp = $('#station-point-bflag-' + opt).val();
        var dp = $('#station-point-dflag-' + opt).val();
        if(bp==1 && dp==1) {
            $('#station-point-bdflag').val(1);
        } else if(bp==1 && dp==0) {
            $('#station-point-bdflag').val(2);
        } else if(bp==0 && dp==1) {
            $('#station-point-bdflag').val(3);
        }
    }
    var sli_from = 0;
    if ($('#point-station-sch-hours').val() != '')
        sli_from = $('#point-station-sch-hours').val();

    $("#point-station-sch-hours").ionRangeSlider({
        type: "single",
        step: 1,
        postfix: "",
        from: sli_from,
        to: 5,
        max: 300,
        min: -300,
        // hideMinMax: true,               // hide Min and Max fields
        hideFromTo: true, // hide From and To fields
        onLoad: function (ui) {
            $('.irs-min').html("-1");
            $('.irs-max').html("1");
        },
        onChange: function (ui) {
            $('#station-point-time-range').val(ui.fromNumber);
            var stationtime = $('#station-sched-time-point-' + code).val();
            if (stationtime > 1439 && stationtime < 2880) {
                stationtime = stationtime - 1440;
            }
            else if (stationtime > 2879) {
                stationtime = stationtime - 2880;
            }
            var time = Number(stationtime) + ui.fromNumber;
            var hours = Math.floor(time / 60);
            var minutes = time - (hours * 60);
            if (hours.toString().length == 1)
                hours = '0' + hours;
            if (minutes.toString().length == 1)
                minutes = '0' + minutes;

            $('#station-point-sch-time-label').html(hours + ':' + minutes);
            console.log(Number($('#station-sched-time-point-' + code).val()));
        },
        hasGrid: false
    });


    $('#station-point-sch').select2({
        allowClear: true,
        placeholder: "Select..."
    });
    $('#station-point-sch-button').show();

    $('#station-sch-loading').html('');

}
function viewStationPointAdvance(code) {
    $('.advance-station-point-schedules').show();
    var data = {}
    data.stationCode = $('#station_prt_code').val();
    $('#van-route-dropdown').html($('<option>', {value: '',text : 'Select Van Route'}));
    $.ajax({
        type: "POST",
        url: "config/get-van-route-by-station",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $.each(res.data, function (i, item) {
                    $('#van-route-dropdown').append($('<option>', {
                        value: item.code,
                        text : item.name
                    }));
                });
                $('#van-route-dropdown').val($('#van-route-code-'+code).val());
            }
        }
    });
}
function cancelStationPointSchedulesDialog() {
    $('#schedules-station-point-dialog').dialog('destroy');
    $('#schedules-station-point-dialog').hide();
    $('#station-sch-loading').html('');
    $("#point-station-sch-hours").ionRangeSlider("remove");
    $('#station-point-time-range,#point-station-sch-hours').val(0);
    $('#station-point-sch,#station_prt_code,#station_point_code').val('');
    $("#ssstation-point-sch").select2("val", "");
    $('.advance-station-point-schedules').hide();
}
function saveStationPointSchedulesDialog() {

    var data = {}
    data.code = $('#sch_code').val();
    data.activeFlag = $('#stationpointactiveFlag').val();
    data.station = $('#station_prt_code').val();

    data.stationtime = $('#station-sched-time-point-' + $('#station_prt_code').val()).val();
    data.minitues = $('#station-point-time-range').val();
    data.stationPoint = $('#station-point-sch').val();
    data.stationPointCode = $('#stationa_point_code').val();
    data.vanRoute = $('#van-route-dropdown').val();
    data.fare = $.trim( $('#station-point-schedules-fare').val() );
    
    var bdflag = $('#station-point-bdflag').val();
    
    if(bdflag==1) {
        data.boardingFlag = 1;
        data.droppingFlag = 1;
    } else if(bdflag==2) {
        data.boardingFlag = 1;
        data.droppingFlag = 0;
    } else if(bdflag==3) {
        data.boardingFlag = 0;
        data.droppingFlag = 1;
    } 
    
    
    if ($('.advance-station-point-schedules').css('display') != 'none') {
        data.dayOfWeek = $("input[name='station-point-week']").map(function () {
            return +$(this).is(':checked');
        }).get();
        var dateSch = $('#station-point-schedules-date').val();
        var date = dateSch.split('|');
        data.activeTo = date[1];
        data.activeFrom = date[0];
    }

    $('#station-point-sch-loading').html('');
    if (data.stationPoint == '') {
        $('#station-point-sch-loading').html('<div class="alert pull-left alert-danger">Please select the station.</div>');
        return false;
    }
    
    if (data.fare == '') {
        $('#station-point-schedules-fare').addClass('inp_error');
        $('#station-point-sch-loading').html('<div class="alert pull-left alert-danger">Please enter/select the values in the field that are marked in red.</div>');
        return false;
    } else if (Number(data.fare) > 300) {
        $('#station-point-schedules-fare').addClass('inp_error');
        $('#station-point-sch-loading').html('<div class="alert pull-left alert-danger">Please update the fare 300 or below.</div>');
        return false;
    } else {        
        $('#station-point-schedules-fare').removeClass('inp_error');
    }

    var err = 0;
    $('input[name="station-point-schedul-code"]').each(function () {
        if ($('#station-point-sch').val() == $(this).val() && (($('#stationa_point_code').val() != '' && $('#stationa_point_code').val() != $(this).attr('data-code')) || $('#stationa_point_code').val() == '')) {
            err++;
        }
    });
    if (err > 0) {
        $('#station-point-sch-loading').html('<div class="alert pull-left alert-danger">Already station point added.</div>');
        return false;
    }

    $('#station-point-sch-loading').html(loading_small);
    //$('#station-sch-button').hide();

    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-station-point",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('#station-point-sch-loading').html('');
                cancelStationPointSchedulesDialog();
                getSchedulesStation();
                setContentHeight('#wizard_form');
            } else {
                $('#station-sch-loading').html('<div class="alert pull-left alert-danger">' + res.errorDesc + '</div>');
                $('#station-sch-button').show();
            }
        }
    });

}
function stationpointSchedulesDelete(scode, opt) {
    if (confirm('Do you want to delete this Station point?')) {
        var data = {};

        var dateSch = $('#date_sch').val();
        var date = dateSch.split('|');

        data.code = $('#sch_code').val();
        data.activeFlag = $('#stationpointactiveFlag').val();
        data.station = scode;
        data.activeTo = date[1];
        data.activeFrom = date[0];

        data.stationPoint = $('#all-stp-code-' + opt).val();
        data.stationPointCode = opt;
        data.dayOfWeek = $("#weekdays :checkbox").map(function () {
            return +$(this).is(':checked');
        }).get();

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-station-point-schedules",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.del-st-p-' + opt).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function getSchedulesStation(id) {
    var data = {}
    data.code = $('#sch_code').val();
    if (data.code == '') {
        $('#wizard_form-t-0').trigger('click');
        return false;
    }
    if (id == 1) {
        $('#station-schedules-list').html(loading_small);
    } else {
        $('.err-act').html(loading_small);
    }
    $.ajax({
        type: "POST",
        url: "schedules/get-schedules-station",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res) {
            if (id == 1) {
                $('#station-schedules-list').html("<br><br>" + res);
            } else {
                $('#station-schedules-list').html(res);
            }
            $('#station-list-sch').select2({
                allowClear: true,
            });
            $.ui.dialog.prototype._allowInteraction = function (e) {
                return !!$(e.target).closest('.ui-dialog, .ui-datepicker, .select2-drop').length;
            };
            $('.err-act').html('');
            return true;
        }
    });
}
function removeStationpoint() {
    //st-pnt-rm
    $('.st-pnt-rm').on('click', function () {
        $(this).parent().parent().remove();
    });
}
function removeStation() {
    //st-pnt-rm
    $('.st-rm').on('click', function () {
        var child = 'st-pt_' + $(this).attr('data-child');//st-pt_
        //$(this).parent().parent().remove();
        $(this).closest('tr').remove();
        $('#' + child).remove();
    });
}

function load_routes(highlightRoute) {
    $('.err-act').html(loading_small);
    var data = {}
    data.code = $('#sch_code').val();
    data.bustype = $('#bustype').val();

    $.ajax({
        type: "POST",
        url: "schedules/get-schedules-routes",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res) {
            $('#rout-list').html(res);
            if(highlightRoute) {
                $('td[data-rfcode="' + highlightRoute + '"]').parent('tr').animate({backgroundColor: '#1AA1E1'}, 2500, function() { 
                        $(this).animate({backgroundColor: '#ffffff'}, 1000)
                });
            }
            setContentHeight('#wizard_form');
            $('.err-act').html('');
            return true;
        }
    });
}

function load_sch_routes() {
    $('#route-list').html(loading_small);
    var data = {}
    data.act = 1;
    data.code = $('#sch_code').val();
    data.bustype = $('#bustype').val();

    $.ajax({
        type: "POST",
        url: "schedules/get-schedules-routes",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res) {
            $('#route-list').html(res);
            setContentHeight('#wizard_form');
            return true;
        }
    });
}


function routesSchedulesDialog(opt) {
    $('#sch-route-fare-table tr:not(#routes-schedules-form-div)').show();
    $('#sch-route-fare-table tr:last').after($('#routes-schedules-form-div'));
    if(!$('#routes-schedules-form-div').is(':visible')) {
        $('#routes-schedules-form-div').fadeToggle(function() {
            setContentHeight('#wizard_form');
        });  
    }
    $('#routes-fare-sch-loading').html('');
    $('#routes-schedules-from, #routes-schedules-to').val('');
    $('.routes-fare.input').val('').attr('data-code', '');
    $('#routes-code').val('');
}
function cancelRoutesSchedulesDialog() {
    $('#routes-schedules-form-div').is(':visible') && $('#routes-schedules-form-div').fadeToggle(function() {
        $('#sch-route-fare-table tr:not(#routes-schedules-form-div)').show();
    });
}
function addRoutesSchedules() {
    var from = $('#routes-schedules-from').val();
    var to = $('#routes-schedules-to').val();
    var err = 0;
    $('.parsley-error').removeClass('parsley-error')
    if (from == '') {
        //parsley-error
        $('#routes-schedules-from').addClass('parsley-error');
        err++;
    }
    if (to == '') {
        $('#routes-schedules-to').addClass('parsley-error');
        err++;
    }

    if (err > 0) {
        $('#routes-sch-loading').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red.</div>');
        return false;
    }
    var ex = 0;
    $('.routes-ext').each(function () {
        if ($(this).attr('data-from') == from && $(this).attr('data-to') == to) {
            ex++;
            return false;
        }
    });
    if (ex > 0) {
        $('#routes-sch-loading').html('<div class="alert fl alert-danger">Already rotues are added.</div>');
        return false;
    }
    if (from == to) {
        $('#routes-sch-loading').show();
        $('#routes-sch-loading').html('<div class="alert fl alert-danger">Same station point selected</div>');
        return false;
    }

    var html = '    <tr class="">       \n\
                             <th class="bold">' + $("#routes-schedules-from").find(":selected").text() + ' to ' + $("#routes-schedules-to").find(":selected").text() + '</th>\n\
                             <th><a href="javascript:;" class="routes-ext" data-from="' + from + '" data-to="' + to + '" onclick="routesFareSchedulesDialog(this)">\n\
                                    <i class="fa fa-plus"></i>&nbsp;Add Fare\n\
                                </a>    &nbsp;&nbsp; \n\
                               <a href="javascript"><i class="fa fa-trash-o"></i></a>  \n\
                              </th> \n\
                   </tr>    \n\
                   <tr class="">\n\
                            <td colspan="2">\n\
                                <table class="table table-hover remove-border-top">\n\
                                    <tbody>\n\
                                    </tbody>\n\
                                </table>\n\
                             </td>\n\
                   </tr>';
    /*<tr>\n\
     <th>Seat</th>\n\
     <th>Group</th>\n\
     <th>Fare</th>\n\
     <th></th>\n\
     </tr>\n\*/
    $('.table-design tbody.routes-add').append(html);
    cancelRoutesSchedulesDialog();
}

function routesFareSchedulesDialog(obj) {
    $('#routes-fare-schedules-dialog').css('background', '#fff');

    $('#routes-fare-schedules-dialog').removeClass('hide');
    $('#routes-fare-schedules-dialog').show();
    $('#routes-fare-schedules-dialog').dialog({
        autoOpen: true,
        height: 550,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#routes-fare-sch-button').show();
    var h = $('#main_wrapper').height() + 100;
    $('.ui-widget-overlay').height(h);
    $('.grp-dis').hide();
    $("input[name='routes-week']").each(function (i) {
        $(this).attr("checked", "checked").prop('checked', true);
        $(this).parent().addClass('active');
    });
    $('#routes-fare-sch-loading').html('');
    if (_isdefined($(obj).attr('data-code'))) {
        $("input[name='routes-week']").each(function (i) {
            $(this).removeAttr("checked");
            $(this).parent().removeClass('active');
        });
        $('#routes-schedules-group').val($(obj).attr('data-group'));
        $('#routes-schedules-seat').val($(obj).attr('data-seat'));
        $('#routes-fare').val($(obj).attr('data-fare'));
        $('#routes-code').val($(obj).attr('data-code'));
        $('#routes-schedules-date').val($(obj).attr('data-date'));
        if (($(obj).attr('data-group') != '' && $(obj).attr('data-group') != undefined) || ($(obj).attr('data-date') != '' && $(obj).attr('data-date') != undefined) || ($(obj).attr('data-days-of-week') != '' && $(obj).attr('data-days-of-week') != undefined)) {
            $('.grp-dis').show();
        }
        if ($(obj).attr('data-days-of-week') != '' && $(obj).attr('data-days-of-week') != undefined) {
            var str = $(obj).attr('data-days-of-week');

            var res = str.split("");
            $("input[name='routes-week']").each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked").prop('checked', true);
                    ;
                    $(this).parent().addClass('active');
                }

            });
        }
    }
    $('#routes-from').val($(obj).attr('data-from'));
    $('#routes-to').val($(obj).attr('data-to'));

}
function cancelRoutesFareSchedules() {
    $('#routes-fare-schedules-dialog').dialog('destroy');
    $('#routes-fare-schedules-dialog').hide();
    $('#routes-schedules-group,#routes-schedules-seat,#routes-fare,#routes-code,#routes-schedules-date').val('');
}
function saveRoutesFareSchedules(obj) {
    var data = {}
    data.from = $('#routes-from').val();
    data.to = $('#routes-to').val();
    data.code = $('#sch_code').val();
    data.Farecode = $('#routes-code').val();

    data.seatType = $('#routes-schedules-seat').val();
    data.fare = $('#routes-fare').val();
    data.fareStatus = 1;
    data.group = $('#routes-schedules-group').val();
    if ($('.grp-dis').css('display') != 'none') {
        if ($('#routes-schedules-date').val() != '') {
            var stationdate = $('#routes-schedules-date').val();
            var sdate = stationdate.split('|');
            data.routesActiveTo = sdate[1];
            data.routesActiveFrom = sdate[0];
        }
        data.dayOfWeek = $("#routes-week-days :checkbox").map(function () {
            return +$(this).is(':checked');
        }).get();
    }
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');
    $('#routes-fare-sch-loading').html('');
//    if(data.seatType==''){
//        //parsley-error
//        $('#routes-schedules-seat').addClass('parsley-error');
//        err++;
//    }
    if (data.fare == '') {
        $('#routes-fare').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        //
        $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }

    var ex = 0;

    $('.routes-seat-exit-' + data.from + '-' + data.to).each(function () {
        if (data.Farecode != '' && data.Farecode != $(this).attr('data-code')) {
            if ((data.seatType == $(this).attr('data-seat') || data.seatType == '') && (($(this).attr('data-group') == '' && data.group == '') || (data.group == $(this).attr('data-group') && $(this).attr('data-group') != ''))) { //
                ex++;
            }
        } else if (data.Farecode == '') {
            if ((data.seatType == $(this).attr('data-seat') || data.seatType == '') && (($(this).attr('data-group') == '' && data.group == '') || (data.group == $(this).attr('data-group') && $(this).attr('data-group') != ''))) { //
                ex++;
            }
        }

    });

    if (ex > 0) {
        $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">Already seat type are added.</div>');
        return false;
    }


    $('#routes-fare-sch-loading').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/update-routes-fare-schedules",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                $('#routes-fare-sch-button').hide();
                cancelRoutesFareSchedules();
                load_routes();
            } else {
                $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });
}
function visibleGroup() {
    $('.grp-dis').show();
}

function deleteRoutesFareSchedules(obj) {
    if (confirm('Do you want to delete this Fare?')) {
        var data = {};
        data.Farecode = $(obj).attr('data-code');
        data.code = $('#sch_code').val();
        data.from = $(obj).attr('data-from');
        data.to = $(obj).attr('data-to');
        data.group = $(obj).attr('data-group');
        data.seatType = $(obj).attr('data-seat');
        data.fare = $(obj).attr('data-fare');
        data.fareStatus = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/update-routes-fare-schedules",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#fare-' + data.Farecode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function deleteRoutesAllScedules(rfrom, rto) {
    if (confirm('Do you want to delete this Fare?')) {
        //del-all-

        var fare = new Array();
        var from = new Array();
        var to = new Array();
        var seatType = new Array();
        var code = new Array();
        var Farecode = new Array();

        $('.del-all-' + rfrom + '-' + rto).each(function () {
            fare.push($(this).attr('data-fare'));
            from.push($(this).attr('data-from'));
            to.push($(this).attr('data-to'));
            seatType.push($(this).attr('data-seat'));
            code.push($('#sch_code').val());
            Farecode.push($(this).attr('data-code'));

        });
        var data = {};
        data.Farecode = Farecode;
        data.code = code;
        data.from = from;
        data.to = to;
        data.seatType = seatType;
        data.fare = fare;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-routes-fare-schedules",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.del-all-remo-' + rfrom + '-' + rto).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function cancelSchedules(id) {
    if (id == 1) {
        $('#cancel-list').html(loading_small);
    } else {
        $('.err-act').html(loading_small);
    }
    var data = {}
    data.code = $('#sch_code').val();

    $.ajax({
        type: "POST",
        url: "schedules/get-schedules-cancel",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res) {
            $('.err-act').html('');
            if (id == 1) {
                $('#cancel-list').html("<br><br>" + res);
            } else {
                $('#cancel-list').html(res);
            }
            $("#toggle-1").click(function () {
                $(".toggle-cancel-list").slideToggle("slow");
            });
            $(".toggle-cancel-list").hide();
            setContentHeight('#wizard_form');
            return true;
        }
    });
}
function savePolicyFareSchedules() {
    var data = {}

    data.code = $('#sch_code').val();
    data.policy = $('#cancel-schedules').val();
    data.group = $('#cancel-group-schedules').val();
    data.cancelCode = '';
    data.activeFlag = 1;
    if (data.policy == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select policy.</div>');
        return false;
    }
    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-cancel",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                $('#cancel-schedules,#cancel-group-schedules').val('');
                cancelSchedules();
            } else {
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });
}
function deleteCancelschedules(code, cnlcode) {
    if (confirm('Do you want to delete this Policy?')) {

        var data = {};

        data.code = $('#sch_code').val();
        data.policy = cnlcode;
        data.activeFlag = 2;
        data.cancelCode = code;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/update-schedules-cancel",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#cancel-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function deleteBookingschedules(code) {
    if (confirm('Do you want to delete this Booking?')) {

        var data = {};

        data.code = $('#sch_code').val();
        data.bCode = code;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-booking-schedules",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.sch-bk-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function bookingschedules() {
    var data = {}
    data.code = $('#sch_code').val();
    $('.err-act').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/get-booking-schedules",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res) {
            $('#booking-list').html(res);
            $('.err-act').html('');
            $("#toggle-booking").click(function () {
                $(".toggle-booking-list").slideToggle("slow", function () {
                    if ($(".toggle-booking-list").css('display') != 'none') {
                        setContentHeight('#wizard_form');
                    } else {
                        setContentHeight('#wizard_form');
                    }
                });
                $('#hid-sch-bkg-code').val('');
                $('#close-hour-booking').val('');
                $('#booking-group-schedules').val('');
                $('#route_stg').val('');
                $('#openclose').bootstrapSwitch('state', true);  
                $('#open-day-booking').val('');
                $('#open-hour-booking').val('');
                $('#open-min-booking').val('');
                $('#adv-date').val('');
                $('#adv-week-days').find("input[name='adv-week-days']").each(function (i) {
                    $(this).attr("checked", "checked");        
                    $(this).parent().addClass('active');
                });
                if($('#adv-opt-row').is(":visible")){
                    toggleAdvOpt();          
                }
                $('input[name="adv-type"]').prop('checked',false);
                $('#adv-type-selected').val('');
                $('#adv-type-alt').hide();
                $('.adv-type-day').hide();
            });
            $(".toggle-booking-list").hide();
            return true;


        }
    });
}

function bookingschedulesAct() {
    var data = {}
    data.act = 1;
    data.code = $('#sch_code').val();
    $('#book-list').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/get-booking-schedules",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res) {
            $('#book-list').html(res);
        }
    });
}

function getScheduleExceptions(type) {
    var data = {}
    data.code = $('#sch_code').val();
    data.type = type;
    $('#load_exp').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/get-schedule-exceptions",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res) {
            $('#load_exp').html(res);
        }
    });
}

function saveBookingSchedules() {
    /* var dateSch = $('#date_sch').val();
     var date = dateSch.split('|');*/
    var data = {}
    data.code = $('#hid-sch-bkg-code').val();
    data.schcode = $('#sch_code').val();
    /*data.activeTo = date[1];
     data.activeFrom = date[0];*/
    //data.dayOfWeek = $("#weekdays :checkbox").map(function () {
        //return +$(this).is(':checked');
    //}).get();
    if($('#adv-type-selected').val() == 'DAY') {
        data.adv_dayOfWeek =  $("input[name='adv-week-days']").map(function () {
            return + $(this).is(':checked');
        }).get().join(''); 
        var dateSch = $('#adv-day-date').val();
        var date = dateSch.split('|');
        data.adv_from = date[0];
        data.adv_to = date[1];
    } else if($('#adv-type-selected').val() == 'ALT') {
        data.adv_dayOfWeek = 'ALRNATE';  
        data.adv_from = $('#adv-date').val(); 
        data.adv_to = '';
    } else {
        data.adv_dayOfWeek = '';
        data.adv_from = '';
        data.adv_to = '';
    }
    data.odays = $('#open-day-booking').val();
    data.ohours = $('#open-hour-booking').val();
    data.omin = $('#open-min-booking').val();
    data.chours = $('#close-hour-booking').val();
    /*    data.cmin = $('#close-min-booking').val();*/
    data.group = $('#booking-group-schedules').val();
    data.stg = $('#route_stg').val();
    data.status = $('input[name="openclose"]').is(":checked") == true ? 1 : 0;
    $('.parsley-error').removeClass('parsley-error');
    var err = 0;
    if (data.odays == '') {
        $('#open-day-booking').addClass('parsley-error');
        err++;
    }
    if (data.ohours == '') {
        $('#open-hour-booking').addClass('parsley-error');
        err++;
    }
    if (data.omin == '') {
        $('#open-min-booking').addClass('parsley-error');
        err++;
    }
    if (data.chours == '') {
        $('#close-hour-booking').addClass('parsley-error');
        err++;
    }
    if (data.cmin == '') {
        $('#close-min-booking').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('.err-act').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }
    $('.booking-button').hide();
    $('.err-act').html(loading_popup);
    
    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-booking",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('.err-act').html('');
                $('.booking-button').show();
                $('.err-act').html('<div class="alert alert-success">Your request has been completed successfully.</div>');
                window.setTimeout(function () {
                    bookingschedules();
                }, 2000);
            } else {
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
                $('.booking-button').show();
            }
        }
    });


}
function bookingExceptionDialog(code, groupCode) {

    $('#booking-schedules-exception').css('background', '#fff');
    $('#booking-schedules-exception').show();
    $('#booking-schedules-exception').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });
    $('#bok-exp-scd-date,#booking-group-exp-schedules,#bok-ovr-scd-date,#open-day-ovr-booking,#open-hour-ovr-booking,#open-min-ovr-booking,#close-hour-exp-booking').val('');
    //bok-except-week
    //bok-ovr-week
    $("input[name='bok-except-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    $("input[name='bok-ovr-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    /*$('#open-min-ovr-booking,#open-hour-ovr-booking').removeAttr('disabled','disabled');
     $("#open-day-ovr-booking").change(function() {
     if($(this).val()=="-1"){
     // ,open-min-ovr-booking
     $('#open-min-ovr-booking,#open-hour-ovr-booking').attr('disabled','disabled');
     }else{ 
     $('#open-min-ovr-booking,#open-hour-ovr-booking').removeAttr('disabled','disabled');
     }
     });*/
    $('#bok-sch-exp-code').val(code);
    $('#hid-bok-sch-exp-code').val('');
    $('#hid-bok-sch-ovr-code').val('');
    $(".ui-dialog-titlebar").hide();
    $('#tabs_bok_exp li a[href="#bok-expt"]').trigger('click');
    $('#book-sch-exo-loading,#book-sch-ovr-loading').html('');
    $("#booking-group-exp-schedules option").each(function () {
        if ($(this).val() == groupCode) {
            $(this).attr("selected", "selected");
        }
    });
}
function cancelBookingExceptionSchedulesDialog() {
    $('#booking-schedules-exception').dialog('destroy');
    $('#booking-schedules-exception').hide();
}
function saveBookingExceptionSchedules() {
    var dateRot = $('#bok-exp-scd-date').val();
    var date = dateRot.split('|');
    var data = {}
    data.code = $('#hid-bok-sch-exp-code').val();
    data.schcode = $('#sch_code').val();
    data.rcode = $('#bok-sch-exp-code').val();
    data.closetime = '-1';
    data.opentime = '-1';
    data.activeFlag = 1;
    data.dayOfWeek = $("#bok-except-week-days :checkbox").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.ractiveTo = $.trim(date[1]);
    data.ractiveFrom = $.trim(date[0]);
    data.group = $('#booking-group-exp-schedules').val();
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');
    $('#book-sch-exo-loading').html('');
    if (dateRot == '') {
        $('#bok-exp-scd-date').addClass('parsley-error');
        err++;
    }

    if (err > 0) {
        $('#book-sch-exo-loading').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }
    $('#book-sch-exo-loading').html(loading_popup);
    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-booking",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('#book-sch-exo-loading').html('<div class="alert alert-success">Your request has been completed successfully.</div>');
                window.setTimeout(function () {
                    cancelBookingExceptionSchedulesDialog();
                    bookingschedules();
                }, 2000);
            } else {
                $('#book-sch-exo-loading').html('<div class="alert alert-danger">'+res.errorDesc+'</div>');
            }
        }
    });
}
function saveBookingOverrideSchedules() {
    var dateRot = $('#bok-ovr-scd-date').val();
    var date = dateRot.split('|');
    var data = {}
    data.code = $('#hid-bok-sch-ovr-code').val();
    data.schcode = $('#sch_code').val();
    data.rcode = $('#bok-sch-exp-code').val();
    data.closetime = $('#close-hour-exp-booking').val();
    data.odays = $('#open-day-ovr-booking').val();
    data.ohours = $('#open-hour-ovr-booking').val();
    data.omin = $('#open-min-ovr-booking').val();
    data.activeFlag = 1;
    data.dayOfWeek = $("#bok-ovr-week-days :checkbox").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.ractiveTo = $.trim(date[1]);
    data.ractiveFrom = $.trim(date[0]);
    data.group = $('#booking-group-exp-schedules').val();
    data.status = $('#bok-ovr-openclose').is(':checked')? 1: 0;
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');
    $('#book-sch-ovr-loading').html('');
    if (dateRot == '') {
        $('#bok-ovr-scd-date').addClass('parsley-error');
        err++;
    }
    if (data.odays == '') {
        $('#open-day-ovr-booking').addClass('parsley-error');
        err++;
    }
    if (data.ohours == '' && $('#open-hour-ovr-booking').attr('disabled') == undefined) {
        $('#open-hour-ovr-booking').addClass('parsley-error');
        err++;
    }
    if (data.omin == '' && $('#open-min-ovr-booking').attr('disabled') == undefined) {
        $('#open-min-ovr-booking').addClass('parsley-error');
        err++;
    }
    if (data.closetime == '') {
        $('#close-hour-exp-booking').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#book-sch-ovr-loading').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }
    $('#book-sch-ovr-loading').html(loading_popup);
    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-booking",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('#book-sch-ovr-loading').html('<div class="alert alert-success">Your request has been completed successfully.</div>');
                window.setTimeout(function () {
                    cancelBookingExceptionSchedulesDialog();
                    bookingschedules();
                }, 2000);
            } else {
                $('#book-sch-ovr-loading').html('<div class="alert alert-danger">'+res.errorDesc+'</div>');                
            }
        }
    });
}
function deleteBookingExpOvrSchedules(ecode, code) {
    if (confirm('Do you want to delete this booking exception/override?')) {

        var data = {};

        data.code = $('#sch_code').val();
        data.ecode = ecode;
        data.rcode = code;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-booking-schedules",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.bk-eo-del-' + ecode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function getSeatVisiblitySchedulesByselect() {
    var data = {}
    data.code = $('#sch_code').val();
    data.busType = $('#bustype').val();
    if (data.busType == "")
        return;
    $('.err-act').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/get-bus-seatmap",
        data: data,
        dataType: 'html',
        async: false,
        success: function (res1) {
        	
            $("#dynamic-seat").html(res1);
            $(".toggle-seat-list").hide();
            $("#toggle-seat").hide();
            $("#toggle-seat_header").hide();
            $('.err-act').html('');
            setContentHeight('#wizard_form');
            return true;
        }
    });
}
function getSeatVisiblitySchedules() {
    $('.err-act').html(loading_small);
    $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#seat_visiblity').html(loading_small);
    $('#err').html('');
    var data = {}
    data.code = $('#sch_code').val();
    data.busType = $('#bus-type-sch-seat').val();

    $.ajax({
        type: "POST",
        url: "schedules/get-seat-visiblity-schedules",
        data: data,
        dataType: 'html',
        success: function (res) {

            $("#dynamic-seat").html("");
            $('#seat-vis-list').html(res);
            $(".toggle-seat-list").show();
            $("#toggle-seat").show();
            $("#toggle-seat_header").show();
            $('.err-act').html('');
            $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#seat_visiblity').html(res);
            $("#toggle-seat").click(function () {
                $(".toggle-seat-list").slideToggle("slow", function () {
                    if ($(".toggle-seat-list").css('display') != 'none') {
                        $('.seat-visibilty-list').hide();
                        $('.seat-select-visibility').css('background-color', 'none').attr("style", "");
                    } else {
                        clearSeatVisibilty();
                        $('.seat-visibilty-list').show();
                    }
                });
            });

            $(".toggle-seat-list").hide();
            setContentHeight('#wizard_form');
            return true;
        }
    });
}
function saveSeatSchedules(fromSearch) {
    var dateSch = $('#seat-sch-date').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.busCode = $('#bus-type-sch-seat').val();
    data.activeFlag = 1;
    var day = 0;
//    data.dayOfWeek = $("#busTypeweekdays :checkbox").map(function () {
//        if (!$(this).is(':checked')) {
//            day++;
//        }
//        return +$(this).is(':checked');
//    }).get();
    
    data.dayOfWeek = $("#busTypeweekdays label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
 
    var seat = new Array();
    $(".schedule-seat-visibility").each(function () {
        seat.push($(this).attr('data-code'));
    }).get();

    data.seatCode = seat;
    data.viewStatus = $('input[name="viewstatus"]').is(":checked") == true ? 1 : 0;

    data.roleType = $("input[name='assignOption']:checked").val();
    data.seatViscode = $('#seat-visibily-code').val();
    
    
    data.releaseBefore = $('#vis-rele-time').val();
    data.remarks = $('#vis_remarks').val();
    
    $('.err-act').show();
    $('.err-act').html('');
    if (seat.length == 0) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one seat.</div>');
        return false;
    }
    if ($('#seat-sch-date').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select date.</div>');
        return false;
    }
    if (data.roleType == '' || data.roleType == undefined) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select role scope.</div>');
        return false;
    }

    if (data.roleType == 'GR') {
        if ($('#group-seat-sch').val() == null) {
            $('.err-act').html('<div class="alert fl alert-danger">Please select group.</div>');
            return false;
        } else if($.inArray('', $('#group-seat-sch').val()) != -1) {
            data.groupList = [{ code: '' }];
        } else {
            data.groupList = $.map($('#group-seat-sch').val() || [], function(val) {
                return { code: val };
            });
        }
    } else if (data.roleType == 'UR') {
        if ($('#user-seat-sch').val() == null) {
            $('.err-act').html('<div class="alert fl alert-danger">Please select a user.</div>');
            return false;
        } else if($.inArray('', $('#user-seat-sch').val()) != -1) {
            data.userList = [{ code: '' }];
        } else {
            data.userList = $.map($('#user-seat-sch').val() || [], function(val) {
                return { code: val };
            });
        }
    } else if (data.roleType == 'SG') {
        if ($('#vis-sch-route').val() == null) {
            $('.err-act').html('<div class="alert fl alert-danger">Please select a Route.</div>');
            return false;
        } else if ($.inArray('ALL', $('#vis-sch-route').val()) != -1) {
            data.routeList = [{code: ''}];
        } else {
            data.routeList = $.map($('#vis-sch-route').val() || [], function (val) {
                val = val.split('-');
                return {
                    fromStation: {code: val[0]},
                    toStation: {code: val[1]}
                };
            });
        }
    }
    
    if (data.dayOfWeek.length == day) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one week days.</div>');
        return false;
    }

    $('.err-act').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/update-seat-visiblity-schedules",
        data: data,
        dataType: 'json',
        //async: false,
        success: function (res) {
            if (res.status == 1) {
                $('.err-act').html('');
                // $('#log').val('');
                // closeScheduleOptions();
                // $('#schs-'+data.code).trigger('click');
                if(fromSearch==1) {
                    load_seat_visiblity();
                } else {
                    getSeatVisiblitySchedules();
                }
            } else {
                $('#log').val('');
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
                $('.booking-button').show();
            }
        }
    });
}
function deleteSeatVisiblity(code) {
    var data = {}
    $.each(seatAssign, function (k, sval) {
        if (sval.code == code) {
            if (sval.activeFrom != '' && sval.activeFrom != undefined && sval.activeTo != '' && sval.activeTo != undefined) {
                data.activeFrom = sval.activeFrom;
                data.activeTo = sval.activeTo;
            }
        }
    });
    data.activeFlag = 2;
    data.code = $('#sch_code').val();

    data.busCode = $('#bus-type-sch-seat').val();
    data.dayOfWeek = $("#busTypeweekdays :checkbox").map(function () {
        return +$(this).is(':checked');
    }).get();

    data.viewStatus = 0;

    data.roleType = "HIDE";
    data.seatViscode = code;

    if (confirm('Do you want to delete this visiblity?')) {

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-seat-visibility-schedules",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.del-seat-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function editSeatVisiblity(code) {
    $('#seat-visibily-code').val(code);    
    $.each(seatAssign, function (k, sval) {
        if (sval.code == code) {
            //$('input[name="assignOption"]').removeAttr("checked");
            //$('#assign_option').val(sval.roleType);
            $('.assignee').hide();
            if (sval.activeFrom != '' && sval.activeFrom != undefined && sval.activeTo != '' && sval.activeTo != undefined) {
                $('#seat-sch-date').val(sval.activeFrom + " | " + sval.activeTo);
            }
            $("input[value='" + sval.roleType + "']").attr("checked", "checked");
            $("input[value='" + sval.roleType + "']").attr('checked', true);
            $("input[value='" + sval.roleType + "']").prop('checked', true);

            $('.' + $("input[value='" + sval.roleType + "']").attr('data-view')).show();
            
            $('#vis-rele-time').val(sval.releaseMinutes);
            
            $('#vis_remarks').val(sval.remarks);
            //$('#vis-sch-route').val(sval.fromStation.code+'-'+sval.toStation.code);

            if (sval.roleType == 'GR') {
                $('.group-assignee').show();
                $('#group-seat-sch').val($.map(sval.groupList || [], function(val) { return val.code; })).multiselect('refresh');
                if(sval.groupList.length == 0) { 
                    $('#group-seat-sch').val(['']).multiselect('refresh');
                }
            }
            if (sval.roleType == 'UR') {
                $('.user-assignee').show();
                $('#user-seat-sch').val($.map(sval.userList || [], function(val) { return val.code; })).multiselect('refresh');
                if(sval.userList.length == 0) { 
                    $('#user-seat-sch').val(['']).multiselect('refresh');
                }
            }
            
            if (sval.roleType == 'SG') {
                $('.stage-assignee').show();
                $('#vis-sch-route').val($.map(sval.routeList || [], function(val) { return val.fromStation.code+'-'+val.toStation.code; })).multiselect('refresh');
                if(sval.routeList.length == 0) { 
                    $('#vis-sch-route').val(['']).multiselect('refresh');
                }
            }
            
            
            
            $('#busTypeweekdays').find('.active').removeClass('active').removeAttr("checked");
            
            var str = sval.dayOfWeek;
            var res = str.split("");
            $('#busTypeweekdays').find("input[name='busweek']").each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked");//.addClass('active');
                    $(this).parent().addClass('active');
                }

            });
            $('#viewstatus').removeAttr("checked");
            if (sval.visibilityType == 'ACAT') {
                $('#viewstatus').trigger('click');
            }
            $('.seat-select-visibility').css('background-color', 'none').attr("style", "");
            var color = $('#seat-assign-' + sval.code).css('background-color');
            var seat = '';
            $.each(sval.busSeatLayout, function (kb, bsval) {
                if (seat != '')
                    seat += ',';
                seat += bsval.seatName;

                $('div[data-code="' + bsval.code + '"]').addClass('schedule-seat-visibility');
                if (bsval.code != '') {
                    $('div[data-code="' + bsval.code + '"]').addClass('schedule-seat-visibility').css('background-color', color + " !important").addClass('seat-visible');
                }
            });
            $('#seat-selection-list').html('<h5>Selected seats</h5>' + seat);
            
            
            
            $(".toggle-seat-list").show();//.show('slow');

            $('.seat-visibilty-list').hide();//.hide('slow');



            //$("input[value='"+sval.roleType+"']").trigger('click');
        }
    });
}
function clearSeatVisibilty() {
    $('input[name="assignOption"]').removeAttr("checked");
    $('.assignee').hide();
    $('#group-seat-sch').val([]).multiselect('refresh');
    $('#user-seat-sch').val([]).multiselect('refresh');
    $('#vis-sch-route').val([]).multiselect('refresh');
    $('input[name="busweek"]').addClass('active').attr("checked");
    $('.seat-visible').removeClass('seat-visible');
    $('#vis-rele-time').val('-1');
    $('.grp-seat').remove();
    $('#vis_remarks').val("");

    $.each(seatAssign, function (k, sval) {

        var color = $('#seat-assign-' + sval.code).css('background-color');
        //busSeatLayout schedule-seat-visibility
        $.each(sval.busSeatLayout, function (kb, bsval) {

            if (bsval.code != '') {
                if ($('div[data-code="' + bsval.code + '"]').hasClass("seat-visible")) {
                    if (!$('div[data-code="' + bsval.code + '"]').find('i').hasClass('fa-users')) {
                        $('div[data-code="' + bsval.code + '"]').css('background', 'none').append("<i class='fa fa-users grp-seat' ></i>");
                    }
                } else {
                    $('div[data-code="' + bsval.code + '"]').css('background', color).addClass('seat-visible');
                }
            }
        });
    });
    $('.schedule-seat-visibility').removeClass('schedule-seat-visibility');
    $(".toggle-seat-list").hide();//.slideUp(2000);
    $('#seat-selection-list').html('');
    $('.seat-visibilty-list').show();//.slideDown(2000);
}

function reviewSchedules() {
    $('.name-schedules').html($('#name_sch').val());
    $('.date-schedules').html($('#date_sch').val());
    $('.servicenumber-schedules').html($('#service_sch').val());
    $('.display-name-schedules').html($('#display_sch').val());
    $('.pnr-code-schedules').html($('#PNR_sch').val());
    $('.report-time-schedules').html($('#RTB_sch').val());
    var html = '';
    var week = new Array('Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa')
    $("input[name='week']").each(function (i) {
        if ($(this).is(':checked')) {
            if (html != '')
                html += ',';
            html += week[i];
        }
    });
    var mob = $('input[name="ph_bkg"]').is(":checked") == true ? "Yes" : "No";
    $('.mticket-schedules').html(mob);
    $('.dayofweek-schedules').html(html);

    var station_html = $('#station-schedules-list').clone();
    station_html.find('a').remove();
    station_html.removeAttr('id');
    $('#station-schedules-accordion').html(station_html.html());

    //var station_html = $('#station-schedules-list').html().find('a').remove();
    //$('#station-schedules-accordion').html(station_html);

    $('.bus-type-schedules').html($('#bustype').find(":selected").text());
    var selText = '';
    $("#amenities option:selected").each(function () {
        if (selText != '')
            selText += ',';
        selText += $(this).text();
    });
    $('.amenities-schedules').html(selText);

    var rotuesHtml = $('#rout-list').clone();
    rotuesHtml.find('a').remove();
    rotuesHtml.removeAttr('id');
    $('#routes-schedules-accordion').html(rotuesHtml);

    var cancelHtml = $('.cancel-schedules-list').clone();
    cancelHtml.removeClass('cancel-schedules-list');
    $('#cancel-schedules-accordion').html(cancelHtml);

    var seatHtml = $('.seat-visibilty-list').clone();
    seatHtml.find('a').remove();
    seatHtml.removeClass('seat-visibilty-list');
    $('#seat-schedules-accordion').html(seatHtml);

    var bookingHtml = $('#booking-schedules-list').clone();
    bookingHtml.find('a').remove();
    bookingHtml.removeAttr('id');
    $('#booking-schedules-accordion').html(bookingHtml); //btn-group
    setContentHeight('#wizard_form');

    $('#cancel-schedules-accordion .accordion-toggle').each(function (i) {
        var id = $(this).attr('href');
        $(this).attr('href', '#review-' + i);
        $('#cancel-schedules-accordion ' + id).attr('id', 'review-' + i)

    });
    $('#cancel-schedules-accordion .del').remove();
    $('#review-schedules').find('.btn-group').remove();

}
function changesSteps(i) {

    $('#wizard_form-t-' + i).trigger('click');
}
function basicExceptionDialog(code, obj) {
    $('#basic-schedule-dialog').css('background', '#fff');

    $('#basic-schedule-dialog').removeClass('hide');
    $('#basic-schedule-dialog').show();
    $('#basic-schedule-dialog').dialog({
        autoOpen: true,
        height: 380,
        width: 600,
        modal: true,
        resizable: false
    });
    $('#basic_except,#basic_except_description,#sc-exp-code').val('');
    $('#basic-except-sch-loading').html('');
    $("input[name='exp-weeks-exp']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    if (_isdefined(code)) {
        $('#basic_except').val($(obj).attr('data-date'));
        $('#sc-exp-code').val(code);
        $('#exp-weekdays-exp').find('.active').removeClass('active').removeAttr("checked");
        var str = $(obj).attr('data-days');
        var res = str.split("");
        $("input[name='exp-weeks-exp']").each(function (i) {
            if (res[i] == 1) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            }

        });
    }
    $(".ui-dialog-titlebar").hide();
}
function cancelBasicExceptionDialog() {
    $('#basic-schedule-dialog').dialog('destroy');
    $('#basic-schedule-dialog').hide();
}
function saveBasicException(type) {
    var data = {}
    var ldateSch = $('#basic_except').val();
    var ldate = ldateSch.split('|');
    data.lactiveTo = $.trim(ldate[1]);
    data.lactiveFrom = $.trim(ldate[0]);
    data.ldescription = $('#basic_except_description').val();

    var dateSch = $('#date_sch').val();
    var date = dateSch.split('|');
    data.name = $('#name_sch').val();
    data.serviceNumber = $('#service_sch').val();
    data.activeFlag = $('#activeFlag').val();
    data.mobileTicketFlag = $('#ph_bkg:checked').val() ? 1 : 0;
    data.boardingReportingMinitues = $('#RTB_sch').val();
    data.displayName = $('#display_sch').val();
    data.pnrStartCode = $('#PNR_sch').val();
    data.apiDisplayname = $('#API_dn').val();
    data.code = $('#sch_code').val();
    data.activeTo = $.trim(date[1]);
    data.activeFrom = $.trim(date[0]);
    data.serviceTax = $('#service_tax').val();
     data.scheduleTagList = $.map($('#sch-basic-tag').val() || [], function (val) {
                return { code: val };
            });
    data.ecode = $('#sc-exp-code').val();
    data.dayOfWeek = $("#exp-weekdays-exp label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    var err = 0;
    $('#basic-except-sch-loading').html('');
    $('.parsley-error').removeClass('parsley-error');
    if (ldateSch == '') {
        $('#basic_except').addClass('parsley-error');
        err++;
    }
    if (data.ldescription == '') {
        $('#basic_except_description').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#basic-except-sch-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#basic-except-sch-loading').html(loading_small);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                if (type == 1) {
                    $('#basic-except-sch-loading').html('<div class="alert alert-success">Exception added successfully.</div>');
                    window.setTimeout(function () {
                        cancelBasicExceptionDialog();
                        getScheduleExceptions();
                    }, 2000);
                } else {
                        cancelBasicExceptionDialog();
                        getScheduleExceptions(type);
                    //if (data.ecode == '') {
//                        var tr = $('#schedules-exp-template').html();
//                        tr = $('<div>').html(tr).clone();
//                        tr.find('tr').addClass('sch-lok-' + response.data.code);
//                        tr.find('.sch-fdate').html(data.lactiveFrom);
//                        tr.find('.sch-tdate').html(data.lactiveTo);
//                        tr.find('.edt-e-lop').attr('data-date', ldateSch);
//                        tr.find('.edt-e-lop').attr('data-days', data.dayOfWeek);
//                        tr.find('.edt-e-lop').attr('onclick', 'basicExceptionDialog("' + response.data.code + '", this)');
//                        tr.find('.sch-exp-del').attr('onclick', 'deleteBasicException("' + response.data.code + '")');
//                        $('#schedules-exeption-list tbody').append(tr.html());
                    ///} else {

                    //}
                }
                if (type != 1) {
                    //cancelBasicExceptionDialog();
                }
            } else {
                $('#basic-except-sch-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}
function deleteBasicException(code, obj) {
    if (confirm('Do you want to delete this exception?')) {

        var data = {};
        data.code = $('#sch_code').val()
        data.ecode = code;
        data.activeFrom = $(obj).attr('data-datef');
        data.activeTo = $(obj).attr('data-datet');
        data.days = $(obj).attr('data-days');
        data.name = 'sample';


        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.sch-lok-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function stationExceptionDialog(obj) {
    $('#schedules-exception-station-dialog').css('background', '#fff');
    $('#schedules-exception-station-dialog').removeClass('hide');
    $('#schedules-exception-station-dialog').show();
    $('#schedules-exception-station-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 600,
        modal: true,
        resizable: false
    });
    $('#sta-exp-sch-loading').html('');
    $('#sta-prt-code,#sta-exp-sch-code,#sta-exp-scd-date,#sta-exp-code').val('');
    
    var station_obj = _.find(station_json, function(o) { return o.code == $(obj).attr('data-station-code'); }); 
    
    if(station_obj) {
        $('#schedules-exception-head').html(station_obj.station.name + ' - ' + station_obj.hoursminitues);
    }
    
    if ($(obj).attr('data-station') != '') {
        $('#sta-prt-code').val($(obj).attr('data-station'));
    }
    if ($(obj).attr('data-station-code') != '') {
        $('#sta-exp-sch-code').val($(obj).attr('data-station-code'));
    }
    if ($(obj).attr('data-ecode') != '') {
        $('#sta-exp-code').val($(obj).attr('data-ecode'));
    }
    
    if ($(obj).attr('data-ovr-extra-time') != '') {
        $('#station-ovr-extra-time').val($(obj).attr('data-ovr-extra-time'));
    }

    //
    //
    $("input[name='sta-except-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    $("input[name='sta-ovr-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    
    $('#tabs_a_exp li a[href="#st-ovr"]').off('shown.bs.tab').on('shown.bs.tab', function (e) {
        $("#sta-ovr-hours").ionRangeSlider('update');
    });
    
    if ($(obj).attr('data-tab') != '' && $(obj).attr('data-tab') == "#st-ovr") {
        var $date = $('#sta-ovr-scd-date');
        var $dayweek = $("input[name='sta-ovr-week']");
        $('#tabs_a_exp li a[href="#st-ovr"]').trigger('click');
    } else {
        var $date = $('#sta-exp-scd-date');
        var $dayweek = $("input[name='sta-except-week']");
        $('#tabs_a_exp li a[href="#st-expt"]').trigger('click');
    }
    if ($(obj).attr('data-date') != '') {
        $date.val($(obj).attr('data-date'));
    }
    if ($(obj).attr('data-daysofweek') != '' && $(obj).attr('data-daysofweek') != 'null' && $(obj).attr('data-daysofweek') != ' ') {

        var str = $(obj).attr('data-daysofweek');
        if ($.trim(str) === "") {

        } else {
            $dayweek.each(function (i) {
                $(this).removeAttr("checked");
                $(this).parent().removeClass('active');
            });
            var res = str.split("");
            $dayweek.each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked");//.addClass('active');
                    $(this).parent().addClass('active');
                }

            });
        }
    }
    //if ($(obj).attr('data-time') != '') {
        var stam_time = Number( $(obj).attr('data-stationtime') );
        if(Number($(obj).attr('data-time')) >0) {   //  edit
            $("#sta-ovr-hours").val( $(obj).attr('data-time') );
            $('#station-ovr-time-range').val( Number( $(obj).attr('data-time') ) );
        } else { // new
            $("#sta-ovr-hours").val( $(obj).attr('data-stationtime') );
            $('#station-ovr-time-range').val( Number( $(obj).attr('data-stationtime') ) );
        }
        
        $("#sta-ovr-hours").hide();
    //} else {
        //$("#sta-ovr-hours").val(0)
        //$('#station-ovr-time-range').val(0);
    //}
   //$("#sta-ovr-hours").ionRangeSlider();
   
   var ovrHoursFrom;
   if($(obj).attr('data-ecode')) {
       ovrHoursFrom = Number($(obj).attr('data-time')) || 0;
   } else {
       ovrHoursFrom = Math.abs($("#sta-ovr-hours").val() - $(obj).attr('data-ovr-extra-time')) || 0;
   }
   $('#station-ovr-sch-time-label').html('');
   
   window.setTimeout(function() {
       $("#sta-ovr-hours").ionRangeSlider({
        type: "single",
        step: 5,
        postfix: "",
        from: ovrHoursFrom,
        //to: 23.59,
        max: 1439,
        min: 0,
        // hideMinMax: true,               // hide Min and Max fields
        hideFromTo: true, // hide From and To fields
        onLoad: function (ui) {
            $('.irs-min').html("0");
            $('.irs-max').html("23.59");
        },
        onChange: function (ui) {
            $('#station-ovr-time-range').val(ui.fromNumber);
            
            var times = Number(ui.fromNumber); // + Number(stam_time);
            var hours = Math.floor(times / 60);
            var minutes = times - (hours * 60);
            if (hours.toString().length == 1)
                hours = '0' + hours;
            if (minutes.toString().length == 1)
                minutes = '0' + minutes;
            //console.log( Number( $('#sta-ovr-hours').val()));
            $('#station-ovr-sch-time-label').html(hours + ':' + minutes);
            console.log($('#station-time-range').val());
        },
        hasGrid: false
    });
   }, 30);
    
    
    //$('#sta-ovr-hours').val(0);
    $(".ui-dialog-titlebar").hide();
}
function cancelStationExceptionDialog() {
    $("#sta-ovr-hours").ionRangeSlider("remove");
    $('#station-ovr-sch-time-label').val(0);
    $('#sta-ovr-hours').val(0)
    $('#schedules-exception-station-dialog').dialog('destroy');
    $('#schedules-exception-station-dialog').hide();

}
function deleteStationExceptionschedules(obj) {
    var data = {}
    data.code = $('#sch_code').val()
    data.activeFlag = 2;
    data.stationcode = $(obj).attr('data-station');
    data.sscode = $(obj).attr('data-station-code');
    data.ecode = $(obj).attr('data-ecode');
    if (confirm('Do you want to delete this station exception/override?')) {
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-station-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#st-eo-del-' + data.ecode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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


function saveStationExceptionDialog() {
    $('#sta-exp-sch-loading').html('');
    var data = {}
    var dateSch = $('#sta-exp-scd-date').val();
    var date = dateSch.split('|');
    data.code = $('#sch_code').val();
    data.eactiveTo = date[1];
    data.eactiveFrom = date[0];
    data.stationschedules = $('#sta-exp-sch-code').val();
    data.stationcode = $('#sta-prt-code').val();
    data.description = $('#sta-exp-scd-description').val();
//    data.dayOfWeek = $("#sta-except-week-days :checkbox").map(function() {
//        return +$(this).is(':checked');
//    }).get();

    data.dayOfWeek = $("#sta-except-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    data.stationtime = "-1";
    data.secode = $('#sta-exp-code').val();
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');

    if (dateSch == '') {
        $('#sta-exp-scd-date').addClass('parsley-error');
        err++;
    }

    if (data.eactiveTo == '') {
        $('#sta-exp-scd-date').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#sta-exp-sch-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#sta-exp-sch-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedules-station",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelStationExceptionDialog();
                $('#sta-exp-sch-loading').html('');
                getSchedulesStation();
                setContentHeight('#wizard_form');
            } else {
                $('#sta-exp-sch-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}
function saveStationOverrideDialog() {
    $('#sta-ovr-sch-loading').html('');
    var data = {}
    var dateSch = $('#sta-ovr-scd-date').val();
    var date = dateSch.split('|');
    data.code = $('#sch_code').val();
    data.eactiveTo = date[1];
    data.eactiveFrom = date[0];
    data.stationschedules = $('#sta-exp-sch-code').val();
    data.stationcode = $('#sta-prt-code').val();
    data.description = $('#sta-ovr-scd-description').val();
//    data.dayOfWeek = $("#sta-ovr-week-days :checkbox").map(function() {
//        return +$(this).is(':checked');
//    }).get();

    data.dayOfWeek = $("#sta-ovr-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();    
    var ovrExtraTime = parseInt($('#station-ovr-extra-time').val());
    data.stationtime = ovrExtraTime + parseInt($('#station-ovr-time-range').val());
    data.secode = $('#sta-exp-code').val();
    var err = 0;
    $('#sta-exp-sch-loading').html('');
    $('.parsley-error').removeClass('parsley-error');

    if (dateSch == '') {
        $('#sta-ovr-scd-date').addClass('parsley-error');
        err++;
    }

    if (data.eactiveTo == '') {
        $('#sta-ovr-scd-date').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#sta-ovr-sch-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#sta-ovr-sch-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedules-station",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelStationExceptionDialog();
                $('#sta-ovr-sch-loading').html('');
                getSchedulesStation();
                setContentHeight('#wizard_form');
            } else {
                $('#sta-ovr-sch-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}
function stationSequenceupdate(obj) {
    var data = {}
    data.code = $('#sch_code').val();
    data.newCode = $(obj).attr('data-code');//code;

    data.active_flag = 5;
    var sequence = $(obj).attr('data-sequence');
    var before = Number(sequence) - 1;
    var after = Number(sequence) + 1;
    var oldsequence, newsequence, oldcode;

    if ($(obj).hasClass('sequence-up')) {

        $.each($(".sequence-up"), function (i, obj) {
            if ($(this).attr('data-sequence') == before) {
                oldsequence = sequence;
                newsequence = $(this).attr('data-sequence');
                oldcode = $(this).attr('data-code');
                return false;
            }
        });
    }
    if ($(obj).hasClass('sequence-down')) {
        $.each($(".sequence-down"), function (i, obj) {
            if ($(this).attr('data-sequence') == after) {
                oldsequence = sequence;
                newsequence = $(this).attr('data-sequence');
                oldcode = $(this).attr('data-code');
                return false;
            }
        });
    }

    data.oldsequence = oldsequence;
    data.newsequence = newsequence;
    data.oldcode = oldcode;
    $('.err-act').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedules-station-sequence",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('.err-act').html('');
                getSchedulesStation();
            } else {
                $('.err-act').html('<div class="alert fl alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}
function viewStationExceptionOverride(e, code) {
    var source = e.target || e.srcElement;
    if (source.nodeName != "TH")
        return;
    $('.station-sch-exp-' + code + ',.station-sch-ove-' + code).toggle('slow');
    $('#stationExcTab-' + code).toggle('slow');
    $('#stationOvrTab-' + code).toggle('slow');
    setContentHeight('#wizard_form');
}
function cancelStationExceptionOverride(code) {
    $('.station-sch-exp-' + code + ',.station-sch-ove-' + code).hide();
    setContentHeight('#wizard_form');
}
function viewStationPointExceptionOverride(e, code) {
    var source = e.target || e.srcElement;
    if (source.nodeName != "TD")
        return;
    $('.station-point-sch-ove-' + code).toggle('slow');
    setContentHeight('#wizard_form');
}
function cancelStationPointExceptionOverride(code) {
    $('.station-point-sch-ove-' + code).hide();
    setContentHeight('#wizard_form');
}
function stationPointExceptionDialog(obj) {
    $('#schedules-exception-station-point-dialog').css('background', '#fff');
    $('#schedules-exception-station-point-dialog').removeClass('hide');
    $('#schedules-exception-station-point-dialog').show();
    $('#schedules-exception-station-point-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 550,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#sta-exp-pin-code,#sta-pit-exp-sch-code,#sta-pit-exp-scd-date,#sta-pit-prt-exp-code,#sta-pit-exp-code').val();
    $('#sta-pit-ovr-scd-date,#sta-pit-exp-scd-date').val('');
    $("#sta-pit-ovr-sch-hours").val(0)
    $('#station-ovr-time-range').val(0);
      $("input[name='sta-pit-except-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    $("input[name='sta-pit-ovr-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    if ($(obj).attr('data-station') != '') {
        $('#sta-exp-pin-code').val($(obj).attr('data-station'));
    }
    if ($(obj).attr('data-station-point-sch-code') != '') {
        $('#sta-pit-exp-sch-code').val($(obj).attr('data-station-point-sch-code'));
    }

    if ($(obj).attr('data-station-point-code') != '') {
        $('#sta-pit-prt-exp-code').val($(obj).attr('data-station-point-code'));
    }

    if ($(obj).attr('data-ecode') != '') {
        $('#sta-pit-exp-code').val($(obj).attr('data-ecode'));

    }
    $('#sta-pit-exp-fare').val($(obj).attr('data-additionalspfare'));
    $('#schedules-sp-exception-head').html($(obj).attr('data-dialoghead'));

    var $date;
    var $dayweek;
    if ($(obj).attr('data-tab') != '' && $(obj).attr('data-tab') == "#stp-exp") {
        $date = $('#sta-pit-exp-scd-date');
        $dayweek = $("input[name='sta-pit-except-week']");
        $('#tabs_stp_exp li a[href="#stp-expt"]').trigger('click');
    } else {
        $date = $('#sta-pit-ovr-scd-date');
        $dayweek = $("input[name='sta-pit-ovr-week']");
        $('#tabs_stp_exp li a[href="#stp-ovr"]').trigger('click');
    }

    if ($(obj).attr('data-date') != '') {
        $date.val($(obj).attr('data-date'));
    }
    if ($(obj).attr('data-dayweek') != '' && $(obj).attr('data-dayweek') != 'null' && $(obj).attr('data-dayweek') != ' ') {

        var str = $(obj).attr('data-dayweek');
        if ($.trim(str) === "") {

        } else {
            $dayweek.each(function (i) {
                $(this).removeAttr("checked");
                $(this).parent().removeClass('active');
            });
            var res = str.split("");
            $dayweek.each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked");//.addClass('active');
                    $(this).parent().addClass('active');
                }

            });
        }
    }
    //if ($(obj).attr('data-time') != '') {
        if( Number( $(obj).attr('data-stationptime') ) > 0 ) {
            var sta_time = Number( $(obj).attr('data-stationtime') ) + Number( $(obj).attr('data-stationptime')  ) ;
            $("#sta-pit-ovr-sch-hours").val( $(obj).attr('data-time') );
        } else { 
            var sta_time = Number( $(obj).attr('data-stationtime') ) + Number( $(obj).attr('data-time')  ) ;
            $("#sta-pit-ovr-sch-hours").val(0);
        }
        $("#sta-pit-ovr-sch-hours").hide();
        $('#sta-pit-ovr-time-range').val( Number( $(obj).attr('data-time') ) );
    //} else {
        //$("#sta-pit-ovr-sch-hours").val(0)
        //$('#station-ovr-time-range').val(0);
    //}
    
    window.setTimeout( function() {
        $("#sta-pit-ovr-sch-hours").ionRangeSlider({
            type: "single",
            step: 5,
            postfix: "",
            from: function () {
                if ($('#sta-pit-ovr-sch-hours').val() != '') {
                    return $('#sta-pit-ovr-sch-hours').val();
                } else {
                    return 0;
                }
            },
            to: 5,
            max: 300,
            min: -300,
            // hideMinMax: true,               // hide Min and Max fields
            hideFromTo: true, // hide From and To fields
            onLoad: function (ui) {
                $('.irs-min').html("-5");
                $('.irs-max').html("5");
            },
            onChange: function (ui) {
                $('#sta-pit-ovr-time-range').val(ui.fromNumber);

                /* if (stationtime > 1439 && stationtime < 2880) {
                 stationtime = stationtime - 1440;
                 }
                 else if (stationtime > 2879) {
                 stationtime = stationtime - 2880;
                 }*/
                var time = Number( ui.fromNumber )  + Number( sta_time ) ;
                var hours = Math.floor(time / 60);
                var minutes = time - (hours * 60);
                if (hours.toString().length == 1)
                    hours = '0' + hours;
                if (minutes.toString().length == 1)
                    minutes = '0' + minutes;

                $('#sta-pit-ovr-sch-hours-label').html(hours + ':' + minutes);

            },
            hasGrid: false
        });
    }, 700);
    

}
function cancelStationPointExceptionDialog() {
    $("#sta-pit-ovr-sch-hours").ionRangeSlider("remove");
    $('#sta-pit-ovr-sch-hours-label').val(0);
    $('#sta-pit-ovr-time-range').val(0)
    $('#schedules-exception-station-point-dialog').dialog('destroy');
    $('#schedules-exception-station-point-dialog').hide();
}
function saveStationPointSchedules() {
    $('#sta-pit-exp-sch-loading').html('');
    var dateSch = $('#sta-pit-exp-scd-date').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val();
    data.station = $('#sta-exp-pin-code').val();
    // data.minitues = $('#sta-pit-prt-exp-code').val();
    data.stationPoint = $('#sta-pit-prt-exp-code').val();
    data.stationPointCode = $('#sta-pit-exp-sch-code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.minitues = -1;
//    data.dayOfWeek = $("#sta-pit-except-week-days :checkbox").map(function() {
//        return +$(this).is(':checked');
//    }).get();

    data.dayOfWeek = $("#sta-pit-except-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    data.ecode = $('#sta-pit-exp-code').val();
    data.fare = $.trim( $('#sta-pit-exp-fare').val() );
    var err = 0;
    $('#sta-pit-exp-sch-loading').html('');
    $('.parsley-error').removeClass('parsley-error');
    if (dateSch == '') {
        $('#sta-pit-exp-scd-date').addClass('parsley-error');
        err++;
    }
    if (data.activeTo == '') {
        $('#sta-pit-exp-scd-date').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#sta-pit-exp-sch-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#sta-pit-exp-sch-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-station-point-exception-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelStationPointExceptionDialog();
                $('#sta-pit-exp-sch-loading').html('');
                getSchedulesStation();
                setContentHeight('#wizard_form');
            } else {

            }
        }
    })
}
function saveStationPointOverrideSchedules() {

    var dateSch = $('#sta-pit-ovr-scd-date').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val();
    data.station = $('#sta-exp-pin-code').val();
    // data.minitues = $('#sta-pit-prt-exp-code').val();
    data.stationPoint = $('#sta-pit-prt-exp-code').val();
    data.stationPointCode = $('#sta-pit-exp-sch-code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.minitues = $('#sta-pit-ovr-time-range').val();
//    data.dayOfWeek = $("#sta-pit-except-week-days :checkbox").map(function() {
//        return +$(this).is(':checked');
//    }).get();

    data.dayOfWeek = $("#sta-pit-ovr-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    data.ecode = $('#sta-pit-exp-code').val();    
    data.fare = $.trim( $('#sta-pit-exp-fare').val() );
    var err = 0;
    $('#sta-pit-exp-sch-loading').html('');
    $('.parsley-error').removeClass('parsley-error');
    if (dateSch == '') {
        $('#sta-pit-exp-scd-date').addClass('parsley-error');
        err++;
    }
    if (data.activeTo == '') {
        $('#sta-pit-exp-scd-date').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#sta-pit-exp-sch-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#sta-pit-exp-sch-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-station-point-exception-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelStationPointExceptionDialog();
                $('#sta-pit-exp-sch-loading').html('');
                getSchedulesStation();
                setContentHeight('#wizard_form');
            } else {

            }
        }
    })
}
function deleteStationPointExceptionschedules(obj) {
    var data = {}
    data.code = $('#sch_code').val()
    data.activeFlag = 2;
    data.stationcode = $(obj).attr('data-station');
    // data.sscode = $(obj).attr('data-station-code');
    data.ecode = $(obj).attr('data-ecode');
    data.stationpoint = $(obj).attr('data-station-point-code');
    data.stationschpoint = $(obj).attr('data-station-point-sch-code');
    if (confirm('Do you want to delete this station point exception/override?')) {
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-station-point-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#st-pt-exp-del-' + data.ecode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function busExceptionDialog(obj) {
    $('#bus-schedule-dialog').css('background', '#fff');
    $('#bus-schedule-dialog').removeClass('hide');
    $('#bus-schedule-dialog').show();
    $('#bus-schedule-dialog').dialog({
        autoOpen: true,
        height: 300,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
}
function cancelBusExceptionDialog() {
    $('#bus-schedule-dialog').dialog('destroy');
    $('#bus-schedule-dialog').hide();
}

function saveBusException() {
    var dateSch = $('#bus-exp-date').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val(); //
    data.busCode = $('#bus-sch-code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.bustype = $('#bus-except-type').val();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-bustype-exceptio-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelBusExceptionDialog();
            } else {

            }
        }
    })
} //rts-exp-sdl-dialog
function routesExceptionDialog(obj) {
    $('#rts-exp-sdl-dialog').css('background', '#fff');
    $('#rts-exp-sdl-dialog').removeClass('hide');
    $('#rts-exp-sdl-dialog').show();
    $('#rts-exp-sdl-dialog').dialog({
        autoOpen: true,
        height: 450,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#rts-exp-sdl-group,#rts-exp-seat,#rts-ovr-sdl-fare,#rts-ovr-sdl-date,#rts-exp-sdl-date,#rts-code,#rts-exp-from,#rts-exp-to,#rts-exp-code').val('');
    $('.seat-type-label').html('');

    $("input[name='rou-except-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    $("input[name='rou-ovr-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });

    if ($(obj).attr('data-group') != '') {
        $('#rts-exp-sdl-group').val($(obj).attr('data-group'));
    }
    if ($(obj).attr('data-seat') != '') {
        $('#rts-exp-seat').val($(obj).attr('data-seat'));
    }
    if ($(obj).attr('data-fare') != '') {
        $('#rts-ovr-sdl-fare').val($(obj).attr('data-fare'));
    }

    if ($(obj).attr('data-seatname') != '') {
        $('.seat-type-label').html($(obj).attr('data-seatname'));
    }
    if ($(obj).attr('data-code') != '') {
        $('#rts-code').val($(obj).attr('data-code'));
    }
    if ($(obj).attr('data-from') != '') {
        $('#rts-exp-from').val($(obj).attr('data-from'));
    }
    if ($(obj).attr('data-to') != '') {
        $('#rts-exp-to').val($(obj).attr('data-to'));
    }
    if ($(obj).attr('data-ecode') != '') {
        $('#rts-exp-code').val($(obj).attr('data-ecode'));
    }

    if ($(obj).attr('data-tab') != '' && $(obj).attr('data-tab') == "#rot-ovr") {
        var $date = $('#rts-ovr-sdl-date');
        var $dayweek = $("input[name='rou-ovr-week']");
        $('#tabs_ovr_exp li a[href="#rot-ovr"]').trigger('click');
    } else {
        var $date = $('#rts-exp-sdl-date');
        var $dayweek = $("input[name='rou-except-week']");
        $('#tabs_ovr_exp li a[href="#rou-expt"]').trigger('click');
    }

    if ($(obj).attr('data-date') != '') {
        $date.val($(obj).attr('data-date'));
    }
    if ($(obj).attr('data-daysofweek') != '' && $(obj).attr('data-daysofweek') != 'null' && $(obj).attr('data-daysofweek') != ' ') {
        var str = $(obj).attr('data-daysofweek');

        if ($.trim(str) === "") {

        } else {
            $dayweek.each(function (i) {
                $(this).removeAttr("checked");
                $(this).parent().removeClass('active');
            });
            var res = str.split("");
            $dayweek.each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked");//.addClass('active');
                    $(this).parent().addClass('active');
                }

            });
        }
    }
    var groupCode = $(obj).attr('data-group');
    $("#rts-ovr-sdl-group option").each(function () {
        if ($(this).val() == groupCode) {
            $(this).attr("selected", "selected");
        }
    });
}

function cancelRoutesExceptionDialog() {
    $('#rts-exp-sdl-dialog').dialog('destroy');
    $('#rts-exp-sdl-dialog').hide();
}
function saveRoutesFareExceptionSchedules() {
    $('#rts-exp-fare-loading').html('');
    var dateSch = $('#rts-exp-sdl-date').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val(); //
    data.routeCode = $('#rts-code').val();
    data.seatType = $('#rts-exp-seat').val();
    data.fare = -1;
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.from = $('#rts-exp-from').val();
    data.to = $('#rts-exp-to').val();
//    data.dayOfWeek = $("#rou-except-week-days :checkbox").map(function() {
//        return +$(this).is(':checked');
//    }).get();

    data.dayOfWeek = $("#rou-except-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    data.ecode = $('#rts-exp-code').val();

    var err = 0;
    $('.parsley-error').removeClass('parsley-error');
    /*if(data.fare==''){
     $('#rts-exp-sdl-fare').addClass('parsley-error');
     err++;
     }*/
    if (dateSch == '') {
        $('#rts-exp-sdl-date').addClass('parsley-error');
        err++;
    }

    if ($('#rts-exp-sdl').val() == '') {
        $('#rts-exp-sdl').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#rts-exp-fare-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#rts-exp-fare-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-routes-exception-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelRoutesExceptionDialog();
                $('#rts-exp-fare-loading').html('');
                load_routes();
            } else {

            }
        }
    })
}
function saveRoutesFareOverrideSchedules() {
    $('#rts-ovr-fare-loading').html('');
    var dateSch = $('#rts-ovr-sdl-date').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val(); //
    data.routeCode = $('#rts-code').val();
    data.seatType = $('#rts-exp-seat').val();
    data.fare = $('#rts-ovr-sdl-fare').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.from = $('#rts-exp-from').val();
    data.to = $('#rts-exp-to').val();
//    data.dayOfWeek = $("#rou-ovr-week-days :checkbox").map(function() {
//        return +$(this).is(':checked');
//    }).get();

    data.dayOfWeek = $("#rou-ovr-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    data.ecode = $('#rts-exp-code').val();
    data.group = $('#rts-ovr-sdl-group').val();
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');
    if (data.fare == '') {
        $('#rts-ovr-sdl-fare').addClass('parsley-error');
        err++;
    }
    if (dateSch == '') {
        $('#rts-ovr-sdl-date').addClass('parsley-error');
        err++;
    }
    if ($('#rts-exp-sdl').val() == '') {
        $('#rts-exp-sdl').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#rts-ovr-fare-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#rts-ovr-fare-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-routes-exception-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelRoutesExceptionDialog();
                load_routes();
            } else {

            }
        }
    })
}

function deleteRoutesFareExpOvrSchedules(obj) {
    var data = {}
    data.code = $('#sch_code').val(); //
    data.routeCode = $(obj).attr('data-code');
    data.ecode = $(obj).attr('data-ecode');
    data.seatType = $(obj).attr('data-seat');
    data.from = $(obj).attr('data-from');
    data.to = $(obj).attr('data-to');
    if (confirm('Do you want to delete this route exception/override?')) {
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-routes-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.st-eo-del-' + data.ecode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function viewRoutestExceptionOverride(e, code) {
    var source = e.target || e.srcElement;
    if (source.nodeName != "TD")
        return;
    $('.routes-sch-exp-' + code + ',.routes-sch-ove-' + code).toggle('slow');
    $("#toggle-seat_header").toggle('slow');
    setContentHeight('#wizard_form');
}
function cancelRoutestExceptionOverride(code) {
    $('.routes-sch-exp-' + code + ',.routes-sch-ove-' + code).hide();
    setContentHeight('#wizard_form');
}
function viewBookingExceptionOverride(code) {
    $('.bok-sch-exp-' + code + ',.bok-sch-ove-' + code).toggle('slow');
    setContentHeight('#wizard_form');
}

function timeConvert(time) {
    return Math.round(time / 24 / 60) + ":" + Math.round(time / 60 % 24) + ':' + Math.round(time % 60);
}

function CancelExceptionschedules(code, groupCode) {
    $('#cancel-override-dialog').css('background', '#fff');
    $('#cancel-override-dialog').removeClass('hide');
    $('#cancel-override-dialog').show();
    $('#cancel-override-dialog').dialog({
        autoOpen: true,
        height: 450,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#cancel-exp-date,#cancel-ovr-scl,#cal-group-ovr').val();
    $("input[name='cnl-ovr-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    $('#can-ovr-code').val(code);
    $("#cal-group-ovr option").each(function () {
        if ($(this).val() == groupCode) {
            $(this).attr("selected", "selected");
        }
    });
}
function saveCancelException() {
    var data = {}
    var dateSch = $('#cancel-exp-date').val();
    var date = dateSch.split('|');
    data.code = $('#sch_code').val();
    data.oactiveTo = date[1];
    data.oactiveFrom = date[0];
    data.dayOfWeek = $("#cnl-ovr-week-days :checkbox").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.cancelpolicy = $('#cancel-ovr-scl').val();
    data.group = $('#cal-group-ovr').val();
    data.ccode = $('#can-ovr-code').val();
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');

    if (dateSch == '') {
        $('#cancel-exp-date').addClass('parsley-error');
        err++;
    }
    if (data.cancelpolicy == '') {
        $('#cancel-ovr-scl').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#cnl-ovr-sch-loading').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }
    $.ajax({
        type: "POST",
        url: "schedules/update-schedules-cancel",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                $('#cancel-schedules,#cancel-group-schedules').val('');
                closeCancelExceptionschedules();
                cancelSchedules();
            } else {
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });
}
function closeCancelExceptionschedules() {
    $('#cancel-override-dialog').dialog('destroy');
    $('#cancel-override-dialog').hide();
}
function viewCancelOvr(code) {
    $('.cnl-ovr-' + code).show();
    setContentHeight('#wizard_form');
}
function deleteCancelOvr(ecode, code) {
    var data = {}
    data.code = $('#sch_code').val(); //
    data.ecode = ecode;
    data.ccode = code;
    if (confirm('Do you want to delete this cancel override?')) {
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-cancel-override",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('.cnl-ovr-del-' + data.ecode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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

function seatVisiblityExceptionOverride(obj) {
    $('.parsley-error').removeClass('parsley-error');
    $('#vis-expt-loading, #vis-ovr-sch-loading').html('');
    
    $('#visiblity-exception-dialog').css('background', '#fff');
    $('#visiblity-exception-dialog').removeClass('hide');
    $('#visiblity-exception-dialog').show();
    $('#visiblity-exception-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#vis-exp-scd-date,#vis-exp-scd-description,#vis-exp-scd-date,#vis-ovr-scd-date').val('');
    $('#vis-exp-scd-description').val('desc');
    $('#vis-exp-code,#vis-ovr-code').val('');
    $('#vis-ovr-roleType').val(0);
    $(".vis-ovr-exp-days").each(function (i) {
        $(this).attr("checked", "checked");
        $(this).parent().addClass('active');
    });
    
    if( $(obj).attr('data-from')=='trp-set' ) {
        $('#vis-ovr-scd-date').val(settings_date+' | '+settings_date);
        $('#vis-exp-scd-date').val(settings_date+' | '+settings_date);
    } else {
        $('.vis-exp-date').daterangepicker({
            buttonClasses: ['btn', 'btn-sm'],
            format: 'YYYY-MM-DD',
            separator: ' | ',
            showDropdowns: true,
            showWeekNumbers: true,
            //yearRange: '1930:+0',
        });
    }
    $('#vis-expt-code,#vis-ovr-roleType,#vis-visibility-type,#vis-exov-code').val('');
    $('.seat-select-override').html('');
    var code = $(obj).data('viscode');
    $('#vis-expt-code').val(code);
    var eocode = $(obj).data('expcode');

    if (seatAssign != undefined) {

        $.each(seatAssign, function (k, vval) {
            if (vval.code == code) {
                var seat = vval.busSeatLayout;
                var html = '';
                $('#vis-ovr-roleType').val(vval.roleType);
                $('#vis-ovr-release-min').val(vval.releaseMinutes);
                if (vval.visibilityType == 'ACAT') {
                    $('#vis-visibility-type').val(1);
                } else {
                    $('#vis-visibility-type').val(2);
                }

                $.each(seat, function (k, sl) {
                    html += '<label class="pull-left p_r_5"><input type="checkbox" id="seat-override" class="seat-override-code" name="seat-override" value="' + sl.code + '" />&nbsp;' + sl.seatName + '</label>';
                });
                $('.seat-select-override').html(html);
                
                if (vval.roleType == 'GR') {
                    if (vval.groupList.length === 0) {
                        $('#vis-exp-scd-scope, #vis-ovr-scd-scope').html('<option value="" selected="selected">All Groups</option>');
                    } else {
                        var option = $.map(vval.groupList || [], function(val) {
                            return $('<option/>', {value: val.code}).html(val.name);
                        });
                        $('#vis-exp-scd-scope, #vis-ovr-scd-scope').html(option);
                    }
                } else if (vval.roleType == 'UR') {
                    if (vval.userList.length === 0) {
                        $('#vis-exp-scd-scope, #vis-ovr-scd-scope').html('<option value="" selected="selected">All Users</option>');
                    } else {
                        var option = $.map(vval.userList || [], function(val) {
                            return $('<option/>', {value: val.code}).html(val.name);
                        });
                        $('#vis-exp-scd-scope, #vis-ovr-scd-scope').html(option);
                    }
                } else if (vval.roleType == 'SG') {
                    if (vval.routeList.length === 0) {
                        $('#vis-exp-scd-scope, #vis-ovr-scd-scope').html('<option value="" selected="selected">All Routes</option>');
                    } else {
                        var option = $.map(vval.routeList || [], function(val) {
                            return $('<option/>', {value: val.fromStation.code+'-'+val.toStation.code}).html(val.fromStation.name+'-'+val.toStation.name);
                        });
                        $('#vis-exp-scd-scope, #vis-ovr-scd-scope').html(option);
                    }
                }
                
                $('#vis-exp-scd-scope, #vis-ovr-scd-scope').multiselect('rebuild');
                
                if (vval.overrideList != undefined) {
                    $.each(vval.overrideList, function (e, eov) {
                        if (eocode == eov.code) {
                            $('.seat-override-code').removeAttr('checked');
                            $('#vis-exp-scd-description').val('desc');
                            $('#vis-exov-code').val(eov.code);
                            if (eov.busSeatLayout != '') {
                                $.each(eov.busSeatLayout, function (i, vs) {
                                    $("input[value='" + vs.code + "']").prop('checked', true);

                                });
                                if (eov.visibilityType == 'ACAT') {
                                    $('input[name="view-ovr-status"]').attr("checked", "checked");
                                    $('input[name="view-ovr-status"]').attr('checked', true);
                                    $('input[name="view-ovr-status"]').prop('checked', true);
                                    $('input[name="view-ovr-status"]').trigger('click');
                                }                                
                            }
                            var $date;
                            var $dayweek;
                            var $visiscope = $();
                            if ($(obj).attr('data-tab') != '' && $(obj).attr('data-tab') == "#stv-exp") {
                                $date = $('#vis-exp-scd-date');
                                $dayweek = $("input[name='vis-except-week']");
                                $visiscope =  $('#vis-exp-scd-scope');
                                $('#tabs_stv_exp li a[href="#vis-expt"]').trigger('click');
                            } else {
                                $date = $('#vis-ovr-scd-date');
                                $dayweek = $("input[name='vis-ovr-week']");
                                $visiscope = $('#vis-ovr-scd-scope');
                                $('#tabs_stv_exp li a[href="#vis-ovr"]').trigger('click');
                            }

                            if (eov.activeTo != '') {
                                $date.val(eov.activeFrom + " | " + eov.activeTo);
                            }
                            if (eov.dayOfWeek != '' && eov.dayOfWeek != 'null' && eov.dayOfWeek != ' ') {

                                var str = eov.dayOfWeek;
                                if ($.trim(str) === "") {

                                } else {
                                    $dayweek.each(function (i) {
                                        $(this).removeAttr("checked");
                                        $(this).parent().removeClass('active');
                                    });
                                    var res = str.split("");
                                    $dayweek.each(function (i) {
                                        if (res[i] == 1) {
                                            $(this).attr("checked", "checked");//.addClass('active');
                                            $(this).parent().addClass('active');
                                        }

                                    });
                                }
                            }
                            
                            if (eov.roleType == 'GR') {
                                $visiscope.val($.map(eov.groupList || [], function(val) { return val.code; })).multiselect('refresh');
                                if(eov.groupList.length == 0) { 
                                    $visiscope.val(['']).multiselect('refresh');
                                }
                            }
                            if (eov.roleType == 'UR') {
                                $visiscope.val($.map(eov.userList || [], function(val) { return val.code; })).multiselect('refresh');
                                if(eov.userList.length == 0) { 
                                    $visiscope.val(['']).multiselect('refresh');
                                }
                            }
                            if (eov.roleType == 'SG') {
                                $visiscope.val($.map(eov.routeList || [], function(val) { return val.fromStation.code+'-'+val.toStation.code; })).multiselect('refresh');
                                if(eov.routeList.length == 0) { 
                                    $visiscope.val(['']).multiselect('refresh');
                                }
                            }
                        }
                    });
                }
            }

        });

    }
}

function saveVisiblityExceptionDialog(fromSearch) {
    $('#vis-expt-loading').html('');
    var data = {}
    var dateSch = $('#vis-exp-scd-date').val();
    var date = dateSch.split('|');
    data.code = $('#sch_code').val();
    data.vcode = $('#vis-expt-code').val();
    data.roleType = $('#vis-ovr-roleType').val(); //vis-visibility-type
    data.viewStatus = $('#vis-visibility-type').val();
    data.seatCode = '';
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.description = $('#vis-exp-scd-description').val();
    //data.busCode = $('#bus-sch-code').val();
    data.busCode = $('#bus-sch-code').val();
    data.activeFlag = 1;
    data.seatViscode = $('#vis-exov-code').val();
    data.dayOfWeek = $("#vis-except-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    
    data.releaseBefore = '-1';
    
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');
    
    if (data.roleType == 'GR') {
        if ($('#vis-exp-scd-scope').val() == null) {
            $('.vis-exp-scd-scope').addClass('parsley-error');
            err++;
        } else if($.inArray('', $('#vis-exp-scd-scope').val()) != -1) {
            data.groupList = [{ code: '' }];
        } else {
            data.groupList = $.map($('#vis-exp-scd-scope').val() || [], function(val) {
                return { code: val };
            });
        }
    } else if (data.roleType == 'UR') {
        if ($('#vis-exp-scd-scope').val() == null) {
            $('.vis-exp-scd-scope').addClass('parsley-error');
            err++;
        } else if($.inArray('', $('#vis-exp-scd-scope').val()) != -1) {
            data.userList = [{ code: '' }];
        } else {
            data.userList = $.map($('#vis-exp-scd-scope').val() || [], function(val) {
                return { code: val };
            });
        }
    } else if (data.roleType == 'SG') {
        if ($('#vis-exp-scd-scope').val() == null) {
            $('.vis-exp-scd-scope').addClass('parsley-error');
            err++;
        } else if ($.inArray('ALL', $('#vis-exp-scd-scope').val()) != -1) {
            data.routeList = [{code: ''}];
        } else {
            data.routeList = $.map($('#vis-exp-scd-scope').val() || [], function (val) {
                val = val.split('-');
                return {
                    fromStation: {code: val[0]},
                    toStation: {code: val[1]}
                };
            });
        }
    }

    if (dateSch == '') {
        $('#vis-exp-scd-date').addClass('parsley-error');
        err++;
    }
    if (data.description == '') {
        $('#vis-exp-scd-description').addClass('parsley-error');
        err++;
    }
    if (err > 0) {
        $('#vis-expt-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#vis-expt-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-seat-visiblity-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelVisiblityExceptionDialog();
                $('#sta-exp-sch-loading').html('');                
                if(fromSearch==1) {
                    load_seat_visiblity();
                } else {
                    getSeatVisiblitySchedules();
                }
                //setContentHeight('#wizard_form');
            } else {
                $('#vis-expt-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}
function saveVisiblityOverrideDialog(fromSearch) {
    $('#vis-ovr-sch-loading').html('');
    var data = {}
    var dateSch = $('#vis-ovr-scd-date').val();
    var date = dateSch.split('|');
    var seat = new Array();
    $("input[name='seat-override']").each(function () {
        if ($(this).is(":checked") == true) {
            seat.push($(this).val());
        }
    }).get();
    data.code = $('#sch_code').val();
    data.vcode = $('#vis-expt-code').val();
    data.roleType = $('#vis-ovr-roleType').val(); //vis-visibility-type
    data.viewStatus = $('input[name="view-ovr-status"]').is(":checked") == true ? 1 : 0;
    data.seatCode = seat;
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.releaseBefore = $('#vis-ovr-release-min').val();

    data.busCode = $('#bus-sch-code').val();
    data.activeFlag = 1;
    data.seatViscode = $('#vis-exov-code').val();

    data.dayOfWeek = $("#vis-ovr-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();


    var err = 0;
    $('.parsley-error').removeClass('parsley-error');
        
    if (data.roleType == 'GR') {
        if ($('#vis-ovr-scd-scope').val() == null) {
            $('.vis-ovr-scd-scope').addClass('parsley-error');
            err++;
        } else if($.inArray('', $('#vis-ovr-scd-scope').val()) != -1) {
            data.groupList = [{ code: '' }];
        } else {
            data.groupList = $.map($('#vis-ovr-scd-scope').val() || [], function(val) {
                return { code: val };
            });
        }
    } else if (data.roleType == 'UR') {
        if ($('#vis-ovr-scd-scope').val() == null) {
            $('.vis-ovr-scd-scope').addClass('parsley-error');
            err++;
        } else if($.inArray('', $('#vis-ovr-scd-scope').val()) != -1) {
            data.userList = [{ code: '' }];
        } else {
            data.userList = $.map($('#vis-ovr-scd-scope').val() || [], function(val) {
                return { code: val };
            });
        }
    } else if (data.roleType == 'SG') {
        if ($('#vis-ovr-scd-scope').val() == null) {
            $('.vis-ovr-scd-scope').addClass('parsley-error');
            err++;
        } else if ($.inArray('ALL', $('#vis-ovr-scd-scope').val()) != -1) {
            data.routeList = [{code: ''}];
        } else {
            data.routeList = $.map($('#vis-ovr-scd-scope').val() || [], function (val) {
                val = val.split('-');
                return {
                    fromStation: {code: val[0]},
                    toStation: {code: val[1]}
                };
            });
        }
    }

    if (dateSch == '') {
        $('#vis-ovr-scd-date').addClass('parsley-error');
        err++;
    }

    if (err > 0) {
        $('#vis-ovr-sch-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#vis-ovr-sch-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-seat-visiblity-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                cancelVisiblityExceptionDialog();
                $('#sta-exp-sch-loading').html('');
                if(fromSearch==1) {
                    load_seat_visiblity();
                } else {
                    getSeatVisiblitySchedules();
                }
                //setContentHeight('#wizard_form');
            } else {
                $('#vis-expt-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}
function deleteSeatVisibilityExceptionschedules(obj) {
    var data = {}
    data.code = $('#sch_code').val();
    data.busCode = $('#bustype').val();
    data.activeFlag = 2;
    data.vcode = $(obj).attr('data-viscode');
    data.seatViscode = $(obj).attr('data-expcode');

    if (confirm('Do you want to delete this Seat Visibility exception/override?')) {
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-seat-visibility-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#stv-eo-del-' + data.seatViscode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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
function cancelVisiblityExceptionDialog() {
    $('#visiblity-exception-dialog').dialog('destroy');
    $('#visiblity-exception-dialog').hide();
}

function toogleVisiblityExceptionOverrideList(ele, code) {
    $(ele).toggleClass('active');
    $('.ex-' + code).toggle();
    setContentHeight('#wizard_form');
}

function getAuditLog() {
    var data = {}
    data.scheduleCode = $('#sch_code').val();
    $('#load_audit').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "report/schedule-audit-log",
        data: data,
        success: function (res) {
            $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#audit_log').html(res);
        }
    });
}

function getScheduleRights() {
    $('#visib_rights').html(loading_small);
    var data = {}
    data.sch_code = $('#sch_code').val();
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-schedule-visibility-rights",
        data: data,
        success: function (res) {
            $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#visib_rights').html(res);
            if (assingned_users.length) {
                $.each(assingned_users, function (k, v) {
                    $('#usr_rights_' + v.code).attr('checked', 'true');
                });
            }
        }
    });
}

function saveScheduleRights() {

    var data = {}
    var users = '';
    data.scheduleCode = $('#sch_code').val();
    $("input[name=usr_rights]:checked").each(function () {
        users += $(this).val() + ',';
    });
    data.users = users;
    $('.error_visib').html(loading_small);
    $('.right_btn').hide();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/save-schedule-visibility-rights",
        data: data,
        success: function (res) {
            if (res.status == 1) {
                $('.error_visib').html('<div class="alert alert-success">Your request has been successfully processed.</div>');
                setTimeout(function () {
                    $('.right_btn').show();
                    $('.error_visib').html('');
                    //getScheduleRights();
                }, 6000);
            } else {
                $('.right_btn').show();
                $('.error_visib').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });

}

function getScheduleDiscount() {

    var data = {}
    data.scheduleCode = $('#sch_code').val();
    $('#load_discount').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get_schedule_discounts",
        data: data,
        success: function (res) {
            if (res) {
                $('#load_discount').html(res);
            } else {
                $('.error_visib').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });

}

function showDiscountDialog(code, name, discValue, flag, group, datatype, from, to, week, devicemedium, usertype) {
    $('#disc-form-buttons').show();
    $('#disc-form-action-state').html('');
    $('#disc-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    $('#discount-dialog').css('background', '#fff');
    $('#discount-dialog').removeClass('hide');
    $('#discount-dialog').show();
    $('#discount-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 570,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    if (code != '' && code != undefined) {
        $('#discount_code').val(code);
        $('#name').val(name);
        $('#date_disc').val(from + ' | ' + to);
        if (group != '' && group != undefined) {
            $('#group').val(group);
        } else {
            $('#group').val('all');
        }
        
        $('#dis_device_medium').val(devicemedium);
        $('#dis_user_type').val(usertype);
        
        $('#disc_value').val(discValue);
        if (flag == 1) {
            $('#disc_type').attr('checked', true);
        } else {
            $('#disc_type').attr('checked', false);
        }

        $('#exp-weekdays ').find('.active').removeClass('active').removeAttr("checked");
        var str = week;
        var res = str.split("");
        $("input[name='station-point-weeks']").each(function (i) {
            if (res[i] == 1) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            }

        });


        $('input[name=disc_data][value=' + datatype + ']').prop("checked", true);
    }
    else {
        $('#name').val('');
        $('#date_disc').val('');
        $('#group').val('all');
        $('#dis_device_medium').val('ALL');
        $('#dis_user_type').val('ALL');
        $('#disc_value').val('');
        $('#exp-weekdays').find("input[name='station-point-weeks']").each(function (i) {
            $(this).attr("checked", "checked");//.addClass('active');        
            $(this).parent().addClass('active');
        });
        $('#disc_type').attr('checked', false);
        $('input[name=disc_data][value=TXN]').prop("checked", true);
    }
}

function cancelDiscountDialog() {
    $('#discount-dialog').dialog('destroy');
    $('#discount-dialog').hide();
}

function saveDiscount() {

    var data = {};

    var dateDisc = $('#date_disc').val();
    var date = dateDisc.split('|');

    data.name = $('#name').val();
    data.dayOfWeek = $("input[name='station-point-weeks']").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    data.group = $('#group').val();
    if (data.group == 'all') {
        data.group = '';
    }
    data.disc_value = $('#disc_value').val();
    data.disc_data = $('#disc_data:checked').val();
    data.percentageFlag = $('#disc_type:checked').val() ? 1 : 0;
    data.scheduleCode = $('#sch_code').val();
    data.discountCode = $('#discount_code').val();
    
    data.deviceMedium = $('#dis_device_medium').val();
    data.userType = $('#dis_user_type').val();

    var err = 0;
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
    }

    if ($('#date_disc').val() == '') {
        $('#date_disc').addClass('inp_error');
        err++;
    } else {
        $('#date_disc').removeClass('inp_error');
    }

    if ($('#disc_value').val() == '') {
        $('#disc_value').addClass('inp_error');
        err++;
    } else {
        $('#disc_value').removeClass('inp_error');
    }
    if ($('#disc_type').val() == '') {
        $('#disc_type').addClass('inp_error');
        err++;
    } else {
        $('#disc_type').removeClass('inp_error');
    }

    if (err > 0) {
        $('#disc-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#disc-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#disc-form-action-state').show();
        return false;
    } else {
        $('#disc-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#disc-form-action-state').hide();
    }


    $('#disc-form-buttons').hide();
    $('#disc-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#disc-form-action-state').html(loading_popup);
    $('#disc-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedules-discount",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#disc-form-buttons').hide();
                $('#disc-form-action-state').removeClass('alert-danger');
                $('#disc-form-action-state').addClass('alert-success');
                $('#disc-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelDiscountDialog();
                    getScheduleDiscount();
                }, 3000);
            } else {
                $('#disc-form-action-state').show();
                $('#disc-form-action-state').addClass('alert-danger');
                $('#disc-form-action-state').html(response.errorDesc);
                $('#disc-form-buttons').show();
            }
        }
    })
}


function ExceptionDialog(code, exc_code, name, from, to, week) {
    $('#exp-form-buttons').show();
    $('#exp-form-action-state').html('');
    $('#exp-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#exception-dialog').css('background', '#fff');
    $('#exception-dialog').removeClass('hide');
    $('#exception-dialog').show();
    $('#exception-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 500,
        modal: true,
        resizable: false
    });
    $('#exp_disc_date,#exp_disc_name').val('');
    $('#exp-disc-weekdays').find("input[name='exp-week']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');        
        $(this).parent().addClass('active');
    });
    $('#discount_code').val(code);

    if (code != '' && exc_code != undefined) {
        $('#exp_disc_name').val(name);
        $('#exp_code').val(exc_code);
        $('#exp_disc_date').val(from + ' | ' + to);
        $('#exp-disc-weekdays').find('.active').removeClass('active').removeAttr("checked");
        var str = week;
        var res = str.split("");
        $("input[name='exp-week']").each(function (i) {
            if (res[i] == 1) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            }
        });

    } else {
        $('#exp_disc_name').val('');
        $('#exp_code').val('');
        $('#exp_disc_date').val('');
        $('#exp-disc-weekdays').find("input[name='exp-week']").each(function (i) {
            $(this).attr("checked", "checked");//.addClass('active');        
            $(this).parent().addClass('active');
        });
    }


    $(".ui-dialog-titlebar").hide();
}
function cancelExceptionDialog() {
    $('#exception-dialog').dialog('destroy');
    $('#exception-dialog').hide();
}

function saveDiscountException() {

    var data = {};

    var dateExp = $('#exp_disc_date').val();
    var date = dateExp.split('|');
    var data = {}

    data.name = $('#exp_disc_name').val();
    data.dayOfWeek = $("input[name='exp-week']").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.activeFrom = date[0];
    data.activeTo = $.trim(date[1]);
    data.scheduleCode = $('#sch_code').val();
    data.discountCode = $('#discount_code').val();
    data.expCode = $('#exp_code').val();

    var err = 0;
    if ($('#exp_disc_name').val() == '') {
        $('#exp_disc_name').addClass('inp_error');
        err++;
    } else {
        $('#exp_disc_name').removeClass('inp_error');
    }

    if ($('#exp_disc_date').val() == '') {
        $('#exp_disc_date').addClass('inp_error');
        err++;
    } else {
        $('#exp_disc_date').removeClass('inp_error');
    }


    if (err > 0) {
        $('#exp-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#exp-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#exp-form-action-state').show();
        return false;
    } else {
        $('#exp-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#exp-form-action-state').hide();
    }


    $('#exp-form-buttons').hide();
    $('#exp-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#exp-form-action-state').html(loading_popup);
    $('#exp-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedules-discount-exception",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#exp-form-buttons').hide();
                $('#exp-form-action-state').removeClass('alert-danger');
                $('#exp-form-action-state').addClass('alert-success');
                $('#exp-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelExceptionDialog();
                    getScheduleDiscount();
                }, 3000);
            } else {
                $('#exp-form-action-state').show();
                $('#exp-form-action-state').addClass('alert-danger');
                $('#exp-form-action-state').html(response.errorDesc);
                $('#exp-form-buttons').show();
            }
        }
    })
}

function deleteScheduleDiscount(opt) {
    if (confirm('Do you want to delete this schedule discount?')) {
        var data = {}
        data.scheduleCode = $('#sch_code').val();
        data.code = opt;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-discount",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        getScheduleDiscount();
                    }, 3000);
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

function deleteDiscountException(code, exp_code) {
    if (confirm('Do you want to delete this discount exception?')) {
        var data = {}
        data.scheduleCode = $('#sch_code').val();
        data.disc_code = code;
        data.exp_code = exp_code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-discount-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        getScheduleDiscount();
                    }, 3000);
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

function getScheduleSeatAutoRelease() {
    var data = {}
    data.code = $('#sch_code').val();
    data.busType = $('#bus-type-sch-seat').val();
    $('#load_released').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/get-seat-auto-release",
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#released').html('');
            $("#dynamic-seat").html("");
            $('#seat-vis-list').html(res);
            $(".toggle-seat-list2").show();
            $("#toggle-seat2").show();
            $("#toggle-seat_header2").show();
            $('.err-act').html('');
            $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#released').html(res);
            $("#toggle-seat2").click(function () {
                $(".toggle-seat-list2").slideToggle("slow", function () {
                    if ($(".toggle-seat-list2").css('display') != 'none') {
                        $('.seat-visibilty-list2').hide();
                        $('.seat-select-visibility2').css('background-color', 'none').attr("style", "");
                    } else {
                        clearSeatAutoRelease();
                        $('.seat-visibilty-list2').show();
                    }
                });
            });

            $(".toggle-seat-list2").hide();
            setContentHeight('#wizard_form');
            return true;
        }
    });
}

function saveSeatAutoRelease() {
    var dateSch = $('#seat-sch-date-rel').val();
    var date = dateSch.split('|');
    var data = {}
    data.schedule = $('#sch_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.busCode = $('#bus-type-sch-seat').val();
    data.activeFlag = 1;
    var day = 0;
    data.dayOfWeek = $("#busTypeweekdaysrel :checkbox").map(function () {
        if (!$(this).is(':checked')) {
            day++;
        }
        return +$(this).is(':checked');
    }).get();
    var seat = new Array();
    $(".schedule-seat-visibility").each(function () {
        seat.push($(this).attr('data-codes'));
    }).get();

    data.seatCode = seat;
    data.releaseMinutes = $('#release-minute').val();
    data.minutesType = $('#minute-type').val();

//    if (data.minutesType == 'HRS') {
//        data.releaseMinutes = data.releaseMinutes * 60;
//    } else {
//        data.releaseMinutes = data.releaseMinutes
//    }
//
//    if (data.minutesType == 'HRS') {
//        data.minutesType = 'MIN';
//    } else {
//        data.minutesType = $('#minute-type').val();
//    }

    data.releaseType = $('#release-type').val();
    data.releaseMode = $('#release-mode').val();
    data.group = $('#group').val();
    data.code = $('#release-code').val();

    $('.err-act').show();
    $('.err-act').html('');
    if (seat.length == 0) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one seat.</div>');
        return false;
    }
    if ($('#seat-sch-date-rel').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select date.</div>');
        return false;
    }
    if ($('#group').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select group.</div>');
        return false;
    }
    if ($('#release-minute').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please enter release time.</div>');
        return false;
    }
    if ($('#minute-type').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select minute type.</div>');
        return false;
    }
    if ($('#release-type').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select release type</div>');
        return false;
    }
    if ($('#release-mode').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please enter release mode.</div>');
        return false;
    }



    if (data.dayOfWeek.length == day) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one week days.</div>');
        return false;
    }

    $('.err-act').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/update-seat-auto-release",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('.err-act').html('<div class="alert fl alert-success">Your request has been completed successfully</div>');
                window.setTimeout(function () {
                    $('.err-act').html('');
                    $('.err-act').hide();
                    $('#rel').val('');
                    $('#release').trigger('click');
                }, 3000);
            } else {
                $('.err-act').html('<div class="alert fl alert-success">' + res.errorDesc + '</div>');
            }
        }
    });
}

function editSeatAutoRelease(code) {
    $('#seat-auto-code').val(code);
    $.each(seatAssigns, function (k, sval) {
        if (sval.code == code) {            
            if (sval.activeFrom != '' && sval.activeFrom != undefined && sval.activeTo != '' && sval.activeTo != undefined) {
                $('#seat-sch-date-rel').val(sval.activeFrom + " | " + sval.activeTo);
            }
            $('#busTypeweekdaysrel').find('.active').removeClass('active').removeAttr("checked");
            var str = sval.dayOfWeek;
            var res = str.split("");
            $("input[name='busweeks']").each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked");//.addClass('active');
                    $(this).parent().addClass('active');
                }

            });
            if(_isdefined(sval.group.code))
                $('#group').val(sval.group.code);
            else
                $('#group').val('NA');
            
            $('#release-minute').val(sval.releaseMinutes);
            $('#minute-type').val(sval.minutesType);
            $('#release-type').val(sval.releaseType);
            $('#release-mode').val(sval.releaseMode);
            $('#release-code').val(sval.code);

            $('.seat-select-visibility2').css('background-color', 'none').attr("style", "");
            var color = $('#seat-assign-' + sval.code).css('background-color');
            var seat = '';
            $.each(sval.busSeatLayout, function (kb, bsval) {
                if (seat != '')
                    seat += ',';
                seat += bsval.seatName;

                $('div[data-codes="' + bsval.code + '"]').addClass('schedule-seat-visibility');
                if (bsval.code != '') {
                    $('div[data-codes="' + bsval.code + '"]').addClass('schedule-seat-visibility').css('background-color', color + " !important").addClass('seat-visible');
                }
            });
            $('#seat-selection-list').html('<h5>Selected seats</h5>' + seat);
            $(".toggle-seat-list2").show();//.show('slow');
            $('.seat-visibilty-list2').hide();//.hide('slow');
        }
    });
}
function clearSeatAutoRelease() {
    $('#group-seat-sch').val('');
    $('#user-seat-sch').val('');
    $('input[name="busweek"]').addClass('active').attr("checked");
    $('.seat-visible').removeClass('seat-visible');
    $('.grp-seat').remove();

    $.each(seatAssigns, function (k, sval) {

        var color = $('#seat-assign-' + sval.code).css('background-color');
        //busSeatLayout schedule-seat-visibility
        $.each(sval.busSeatLayout, function (kb, bsval) {

            if (bsval.code != '') {
                if ($('div[data-codes="' + bsval.code + '"]').hasClass("seat-visible")) {
                    if (!$('div[data-codes="' + bsval.code + '"]').find('i').hasClass('fa-users')) {
                        $('div[data-codes="' + bsval.code + '"]').css('background', 'none').append("<i class='fa fa-users grp-seat' ></i>");
                    }
                } else {
                    $('div[data-codes="' + bsval.code + '"]').css('background', color).addClass('seat-visible');
                }
            }
        });
    });
    $('.schedule-seat-visibility').removeClass('schedule-seat-visibility');
    $(".toggle-seat-list2").hide();//.slideUp(2000);
    $('#seat-selection-list').html('');
    $('.seat-visibilty-list2').show();//.slideDown(2000);
}

function deleteSeatAutoRelease(code) {
    if (confirm('Do you want to delete this schedule auto release?')) {
        var data = {}
        data.code = code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-seat-auto-release",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        getScheduleSeatAutoRelease();
                    }, 3000);
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


function getScheduleSeatPreference() {
    //$('#referenced').html(loading_small);
    var data = {}
    data.code = $('#sch_code').val();
    data.busType = $('#bus-type-sch-seat').val();
    $('#load_referenced').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/get-seat-preference",
        data: data,
        dataType: 'html',
        success: function (res) {
            //$('#referenced').html('');
            $("#dynamic-seat").html("");
            $('#seat-vis-list').html(res);
            $(".toggle-seat-list3").show();
            $("#toggle-seat3").show();
            $("#toggle-seat_header3").show();
            $('.err-act').html('');
            $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#load_referenced').html(res);
            $("#toggle-seat3").click(function () {
                $(".toggle-seat-list3").slideToggle("slow", function () {
                    if ($(".toggle-seat-list3").css('display') != 'none') {
                        $('.seat-visibilty-list3').hide();
                        $('.seat-select-visibility3').css('background-color', 'none').attr("style", "");
                    } else {
                        clearSeatPreference();
                        $('.seat-visibilty-list3').show();
                    }
                });
            });
            $(".toggle-seat-list3").hide();
            setContentHeight('#wizard_form');
            return true;
        }
    });
}

function clearSeatPreference() {
    $('#group-seat-sch').val('');
    $('#user-seat-sch').val('');
    $('input[name="busweek"]').addClass('active').attr("checked");
    $('.seat-visible').removeClass('seat-visible');
    $('.grp-seat').remove();

    $.each(seatAssignsp, function (k, sval) {
        var color = $('#seat-assign-' + sval.code).css('background-color');
        $.each(sval.busSeatLayout, function (kb, bsval) {
            if (bsval.code != '') {
                if ($('div[data-codesp="' + bsval.code + '"]').hasClass("seat-visible")) {
                    if (!$('div[data-codesp="' + bsval.code + '"]').find('i').hasClass('fa-users')) {
                        $('div[data-codesp="' + bsval.code + '"]').css('background', 'none').append("<i class='fa fa-users grp-seat' ></i>");
                    }
                } else {
                    $('div[data-codesp="' + bsval.code + '"]').css('background', color).addClass('seat-visible');
                }
            }
        });
    });
    $('.schedule-seat-visibility').removeClass('schedule-seat-visibility');
    $(".toggle-seat-list3").hide();//.slideUp(2000);
    $('#seat-selection-list').html('');
    $('.seat-visibilty-list3').show();//.slideDown(2000);
}

function saveSeatPreference() {
    var dateSch = $('#seat-sch-date-relp').val();
    var date = dateSch.split('|');
    var data = {}
    data.schedule = $('#sch_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.busCode = $('#bus-type-sch-seat').val();
    data.activeFlag = 1;
    var day = 0;
    data.dayOfWeek = $("#busTypeweekdaysref label").map(function () {
        return +($(this).hasClass("active"));
    }).get();

    var seat = new Array();
    $(".schedule-seat-visibility").each(function () {
        seat.push($(this).attr('data-codesp'));
    }).get();

    data.seatCode = seat;
    data.gender = $('#r-gender').val();
    data.code = $('#preference-code').val();

    $('.err-act').show();
    $('.err-act').html('');
    if (seat.length == 0) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one seat.</div>');
        return false;
    }
    if ($('#seat-sch-date-relp').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select date.</div>');
        return false;
    }
    if ($('#r-gender').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select gender.</div>');
        return false;
    }
    
    if ($('#seat-sch-groups').val() == null) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one group.</div>');
        return false;
    } else if($.inArray('ALL', $('#seat-sch-groups').val()) != -1) {
        data.groupList = [{ code: '' }];
    } else {
        data.groupList = $.map($('#seat-sch-groups').val() || [], function(val) {
            return { code: val };
        });
    }

    if (data.dayOfWeek.length == day) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one week days.</div>');
        return false;
    }

    $('.err-act').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/update-seat-preference",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('.err-act').html('<div class="alert fl alert-success">Your request has been completed successfully</div>');
                window.setTimeout(function () {
                    $('.err-act').html('');
                    $('.err-act').hide();
                    $('#ref').val(1);
                    getScheduleSeatPreference();
                }, 3000);
            } else {
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });
}

function editSeatPreference(code) {
    $('#seat-refer-code').val(code);
    $.each(seatAssignsp, function (k, sval) {
        if (sval.code == code) {
            if (sval.activeFrom != '' && sval.activeFrom != undefined && sval.activeTo != '' && sval.activeTo != undefined) {
                $('#seat-sch-date-relp').val(sval.activeFrom + " | " + sval.activeTo);
            }
            $('#busTypeweekdaysref').find('.active').removeClass('active').removeAttr("checked");
            var str = sval.dayOfWeek;
            var res = str.split("");
            $("input[name='busweeksf']").each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked");//.addClass('active');
                    $(this).parent().addClass('active');
                }

            });
            $('#r-gender').val(sval.preferenceGendar);
            $('#preference-code').val(sval.code);

            $('.seat-select-visibility3').css('background-color', 'none').attr("style", "");
            var color = $('#seat-assign-' + sval.code).css('background-color');
            var seat = '';
            $.each(sval.busSeatLayout, function (kb, bsval) {
                if (seat != '')
                    seat += ',';
                seat += bsval.seatName;

                $('div[data-codesp="' + bsval.code + '"]').addClass('schedule-seat-visibility');
                if (bsval.code != '') {
                    $('div[data-codesp="' + bsval.code + '"]').addClass('schedule-seat-visibility').css('background-color', color + " !important").addClass('seat-visible');
                }
            });
            $('#seat-selection-list').html('<h5>Selected seats</h5>' + seat);
            $(".toggle-seat-list3").show();//.show('slow');
            $('.seat-visibilty-list3').hide();//.hide('slow');
            
            $('#seat-sch-groups').val(sval.groupList.map(function(val){
                return val.code;
            })).multiselect('refresh');
            if(sval.groupList.length == 0) {
                $('#seat-sch-groups').val(['ALL']).multiselect('refresh');
            }
        }
    });
}


function deleteSeatPreference(code) {
    if (confirm('Do you want to delete this schedule seat preference?')) {
        var data = {}
        data.busCode = $('#bus-type-sch-seat').val();
        data.schedule = $('#sch_code').val();
        data.code = code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-seat-preference",
            data: data,
            success: function (response) {
            	if (response.status == 1) {
                    $('.del-seat-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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


function seatReleaseException(obj) {

    $('#rel-exp-form-buttons').show();
    $('#rel-exp-form-action-state').html('');
    $('#rel-exp-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    $('#rel-exception-dialog').css('background', '#fff');
    $('#rel-exception-dialog').removeClass('hide');
    $('#rel-exception-dialog').show();
    $('#rel-exception-dialog').dialog({
        autoOpen: true,
        height: 230,
        width: 580,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#rel-exp-scd-date').val('');
    $(".rel-ovr-exp-days").each(function (i) {
        $(this).attr("checked", "checked");
        $(this).parent().addClass('active');
    });
    var code = $(obj).attr('data-auto');
    $('#auto').val(code);
    $('#auto').focus();

}

function cancelReleaseExceptionDialog() {
    $('#rel-exception-dialog').dialog('destroy');
    $('#rel-exception-dialog').hide();
}


function saveReleaseExceptionDialog() {
    var data = {};

    var dateExp = $('#rel-exp-scd-date').val();
    var date = dateExp.split('|');
    var data = {}

    data.dayOfWeek = $("input[name='rel-except-week']").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    data.schedule = $('#sch_code').val();
    data.lookup = $('#auto').val();
    data.busCode = $('#bus-type-sch-seat').val();

    var err = 0;

    if ($('#rel-exp-scd-date').val() == '') {
        $('#rel-exp-scd-date').addClass('inp_error');
        err++;
    } else {
        $('#rel-exp-scd-date').removeClass('inp_error');
    }


    if (err > 0) {
        $('#rel-exp-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#rel-exp-form-action-state').html('Please enter the values in the field that are marked in red');
        $('#rel-exp-form-action-state').show();
        return false;
    } else {
        $('#rel-exp-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#rel-exp-form-action-state').hide();
    }


    $('#rel-exp-form-buttons').hide();
    $('#rel-exp-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#rel-exp-form-action-state').html(loading_popup);
    $('#rel-exp-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-release-exception",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#rel-exp-form-buttons').hide();
                $('#rel-exp-form-action-state').removeClass('alert-danger');
                $('#rel-exp-form-action-state').addClass('alert-success');
                $('#rel-exp-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelReleaseExceptionDialog();
                    getScheduleSeatAutoRelease();
                }, 3000);
            } else {
                $('#rel-exp-form-action-state').show();
                $('#rel-exp-form-action-state').addClass('alert-danger');
                $('#rel-exp-form-action-state').html(response.errorDesc);
                $('#rel-exp-form-buttons').show();
            }
        }
    })
}

function toogleAutoExceptionOverrideList(ele, code) {
    $(ele).toggleClass('active');
    $('.release-exp-' + code).toggle();
    $('.release-exp-row-' + code).toggle();
    setContentHeight('#wizard_form');
}

function updateScheduleBookingStatus(code, state, stg) {
    $('#load_' + code).html(loading_popup);
    var data = {};
    data.schedule = $('#sch_code').val();
    data.code = code;
    data.state = state;
    data.stg = stg;
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedule-booking",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#load_' + code).html('');
            }
        }
    })
}

function getSeatFare() {
    $('.err-act').html(loading_small);
    $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#seat_fare').html(loading_small);
    $('#err').html('');
    var data = {}
    data.code = $('#sch_code').val();
    data.busType = $('#bus-type-sch-seat').val();
    
    $("html, body").animate({scrollTop: 150}, "slow");

    $.ajax({
        type: "POST",
        url: "schedules/get-schedule-seat-fare",
        data: data,
        dataType: 'html',
        async: true,
        success: function (res) {

            $("#dynamic-seat").html("");
            $('#seat-vis-list').html(res);
            $(".toggle-seat-list").show();
            $("#toggle-seat").show();
            $("#toggle-seat_header").show();
            $('.err-act').html('');
            $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#seat_fare').html(res);
            $("#toggle-seats").click(function () {
                $(".toggle-seat-list").slideToggle("slow", function () {
                    if ($(".toggle-seat-list").css('display') != 'none') {
                        $('.seat-visibilty-list').hide();
                        $('.seat-select-visibility').css('background-color', 'none').attr("style", "");
                    } else {
                        clearSeatVisibilty();
                        $('.seat-visibilty-list').show();
                    }
                });
            });

            $(".toggle-seat-list").hide();
            //setContentHeight('#wizard_form');
            return true;
        }
    });
}
function clearSeatFare() {
    $('input[name="assignOption"]').removeAttr("checked");
    $('.assignee').hide();
    $('#group-seat-sch').val('');
    $('#user-seat-sch').val('');
    $('input[name="busweek"]').addClass('active').attr("checked");
    $('.seat-visible').removeClass('seat-visible');
    $('.grp-seat').remove();

    $.each(seatAssign, function (k, sval) {

        var color = $('#seat-assign-' + sval.code).css('background-color');
        //busSeatLayout schedule-seat-visibility
        $.each(sval.busSeatLayout, function (kb, bsval) {

            if (bsval.code != '') {
                if ($('div[data-code="' + bsval.code + '"]').hasClass("seat-visible")) {
                    if (!$('div[data-code="' + bsval.code + '"]').find('i').hasClass('fa-users')) {
                        $('div[data-code="' + bsval.code + '"]').css('background', 'none').append("<i class='fa fa-users grp-seat' ></i>");
                    }
                } else {
                    $('div[data-code="' + bsval.code + '"]').css('background', color).addClass('seat-visible');
                }
            }
        });
    });
    $('.schedule-seat-visibility').removeClass('schedule-seat-visibility');
    $(".toggle-seat-list").hide();
    $('#seat-selection-list').html('');
    $('.seat-visibilty-list').show();
}

function saveSeatFare() {
    var dateSch = $('#seat-sche-date').val();
    var date = dateSch.split('|');
    var data = {}
    data.schedule = $('#sch_code').val();
    data.code = $('#sch_seat_fare_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.busCode = $('#bus-type-sch-seat').val();
    data.activeFlag = 1;
    var day = 0;
    data.dayOfWeek = $("#busTypeweekdays label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    
    var seat = new Array();
    $(".schedule-seat-visibility").each(function () {
        seat.push($(this).attr('data-code'));
    }).get();

    data.seatCode = seat;
    data.group = $('#group-seat-sch').val();
    var stationCode = $('#sch-from').val();
    var station = stationCode.split('-');
    data.fromcode =station[0];
    data.tocode =station[1];
    data.fare =$('#seat-sch-fare').val();
    data.fareOverrideType = $('#sch-sf-type').val();
    $('.err-act').show();
    $('.err-act').html('');
    if (seat.length == 0) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one seat.</div>');
        return false;
    }
    if ($('#seat-sche-date').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select date.</div>');
        return false;
    }
    if ($('#seat-sch-fare').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please enter the fare.</div>');
        return false;
    }
   
    if (data.dayOfWeek.length == day) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleast one week days.</div>');
        return false;
    }
    if ( Number($('#seat-sch-fare').val()) > 9999){
    	$('#seat-sch-fare').addClass('parsely-error');
        $('.err-act').html('<div class="alert fl alert-danger">Sorry! Maximum Fare per Seat is Rs.9999.</div>');
        return false;
    } else {
        $('#seat-sch-fare').removeClass('parsely-error');
    }

    $('.err-act').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/update-schedule-seat-fare",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('.err-act').html('');
                 getSeatFare();
            } else {
                $('#log').val('');
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
                $('.booking-button').show();
            }
        }
    });
}

function deleteSeatFare(code) {
    if (confirm('Do you want to delete this schedule seat Fare?')) {
        var data = {}
        data.schedule = $('#sch_code').val();
        data.busCode = $('#bus-type-sch-seat').val();
        data.code = code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-seat-fare",
            data: data,
            success: function (response) {
            	if (response.status == 1) {
                    $('.del-seat-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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

function editSeatFare(code) {
    $('#sch_seat_fare_code').val(code);
    $.each(seatAssign, function (k, sval) {
        if (sval.code == code) {
            $('input[name="assignOption"]').removeAttr("checked");
            $('.assignee').hide();
            if (sval.activeFrom != '' && sval.activeFrom != undefined && sval.activeTo != '' && sval.activeTo != undefined) {
                $('#seat-sche-date').val(sval.activeFrom + " | " + sval.activeTo);
            }
            if (sval.group != undefined) {
              $('#group-seat-sch').val(sval.group.code);
            }
            
            if(_isdefined(sval.fromStation) ) {
                if(sval.fromStation.code != '' && sval.toStation.code != '') {
                    $('#sch-from').val(sval.fromStation.code+' - '+sval.toStation.code);
                }
            }
        
            if (sval.fare != '') {
                $('#seat-sch-fare').val(sval.seatFare);
             }
             
            if (sval.fareOverrideType != '') {
                $('#sch-sf-type').val(sval.fareOverrideType);
             } 
          
            $('#busTypeweekdays').find('.active').removeClass('active').removeAttr("checked");
            var str = sval.dayOfWeek;
            var res = str.split("");
            $("input[name='seatfarebusweek']").each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked");//.addClass('active');
                    $(this).parent().addClass('active');
                }

            });
            
            $('.seat-select-visibility').css('background-color', 'none').attr("style", "");
            var color = $('#seat-assign-' + sval.code).css('background-color');
            var seat = '';
            $.each(sval.busSeatLayout, function (kb, bsval) {
                if (seat != '')
                    seat += ',';
                seat += bsval.seatName;

                $('div[data-code="' + bsval.code + '"]').addClass('schedule-seat-visibility');
                if (bsval.code != '') {
                    $('div[data-code="' + bsval.code + '"]').addClass('schedule-seat-visibility').css('background-color', color + " !important").addClass('seat-visible');
                }
            });
            //$('#seat-selection-list').html('<h5>Selected seats</h5>' + seat);
            $(".toggle-seat-list").show();//.show('slow');

            $('.seat-visibilty-list').hide();//.hide('slow');



            //$("input[value='"+sval.roleType+"']").trigger('click');
        }
    });
}


function seatFareExceptionOverride(obj) {
    $('#visiblity-exception-dialog').css('background', '#fff');
    $('#visiblity-exception-dialog').removeClass('hide');
    $('#visiblity-exception-dialog').show();
    $('#visiblity-exception-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#vis-exp-scd-date,#vis-exp-scd-description,#vis-exp-scd-date,#vis-ovr-scd-date').val('');
    $('#vis-exp-code,#vis-ovr-code').val('');
    $('#vis-ovr-roleType').val(0);
    $(".vis-ovr-exp-days").each(function (i) {
        $(this).attr("checked", "checked");
        $(this).parent().addClass('active');
    });

    $('.vis-exp-date').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true
        //yearRange: '1930:+0',
    });
    $('#vis-expt-code,#vis-ovr-roleType,#vis-visibility-type,#vis-exov-code').val('');
    $('.seat-select-override').html('');
    var code = $(obj).data('viscode');
    $('#vis-expt-code').val(code);
    var eocode = $(obj).data('expcode');
    	$('#exp_code').val(eocode);
    if (seatAssign != undefined) {

        $.each(seatAssign, function (k, vval) {
            if (vval.code == code) {
                var seat = vval.busSeatLayout;
                var html = '';
                $('#vis-ovr-roleType').val(vval.roleType);
                if (vval.visibilityType == 'ACAT') {
                    $('#vis-visibility-type').val(1);
                } else {
                    $('#vis-visibility-type').val(2);
                }

                $.each(seat, function (k, sl) {
                    html += '<label class="pull-left p_r_5"><input type="checkbox" checked="checked" id="seat-override" class="seat-override-code" name="seat-override" value="' + sl.code + '" />' + sl.seatName + '</label>';
                });
                $('.seat-select-override').html(html);
                if (vval.overrideList != undefined) {
                    $.each(vval.overrideList, function (e, eov) {
                        if (eocode == eov.code) {
                            $('#schedule-seat-fare').val(eov.seatFare);
                            $('#vis-exov-code').val(eov.code);
                            var $date;
                            var $dayweek;
                            if ($(obj).attr('data-tab') != '' && $(obj).attr('data-tab') == "#stv-exp") {
                                $date = $('#vis-exp-scd-date');
                                $dayweek = $("input[name='vis-except-week']");
                                $('#tabs_stv_exp li a[href="#vis-expt"]').trigger('click');
                            } else {
                                $date = $('#vis-ovr-scd-date');
                                $dayweek = $("input[name='vis-ovr-week']");
                                $('#tabs_stv_exp li a[href="#vis-ovr"]').trigger('click');
                            }

                            if (eov.activeTo != '') {
                                $date.val(eov.activeFrom + " | " + eov.activeTo);
                            }
                            if (eov.dayOfWeek != '' && eov.dayOfWeek != 'null' && eov.dayOfWeek != ' ') {

                                var str = eov.dayOfWeek;
                                if ($.trim(str) === "") {

                                } else {
                                    $dayweek.each(function (i) {
                                        $(this).removeAttr("checked");
                                        $(this).parent().removeClass('active');
                                    });
                                    var res = str.split("");
                                    $dayweek.each(function (i) {
                                        if (res[i] == 1) {
                                            $(this).attr("checked", "checked");//.addClass('active');
                                            $(this).parent().addClass('active');
                                        }

                                    });
                                }
                            }
                        }
                    });
                }
            }

        });

    }
}

function cancelSeatFareExceptionDialog() {
    $('#visiblity-exception-dialog').dialog('destroy');
    $('#visiblity-exception-dialog').hide();
}

function saveSeatFareExceptionDialog() {
    $('#vis-expt-loading').html('');
    var data = {}
    var dateSch = $('#vis-exp-scd-date').val();
    var date = dateSch.split('|');
    data.schedule = $('#sch_code').val();
    data.code = $('#exp_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.busCode = $('#bus-type-sch-seat').val();
    data.activeFlag = 1;
    data.fare = -1;
    data.sfcode= $('#vis-expt-code').val();
    data.dayOfWeek = $("#vis-except-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();


    var err = 0;
    $('.parsley-error').removeClass('parsley-error');

    if (dateSch == '') {
        $('#vis-exp-scd-date').addClass('parsley-error');
        err++;
    }
   
    if (err > 0) {
        $('#vis-expt-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#vis-expt-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedule-seat-fare-exception-override",
        data: data,
        success: function (response) {
            if (response.status == 1) {
            	cancelSeatFareExceptionDialog();
                $('#vis-expt-loading').html('');
                getSeatFare();
                setContentHeight('#wizard_form');
            } else {
                $('#vis-expt-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}
function saveSeatFareOverrideDialog() {
    $('#vis-expt-loading').html('');
    var data = {}
    var dateSch = $('#vis-ovr-scd-date').val();
    var date = dateSch.split('|');
    data.busCode = $('#bus-type-sch-seat').val();
    var seat = new Array();
    $("input[name='seat-override']").each(function () {
        if ($(this).is(":checked") == true) {
            seat.push($(this).val());
        }
    }).get();
    data.schedule = $('#sch_code').val();
    data.code = $('#exp_code').val();
    data.sfcode = $('#vis-expt-code').val();
    data.seatCode = seat;
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.fare = $('#schedule-seat-fare').val();
    data.activeFlag = 1;

    data.dayOfWeek = $("#vis-ovr-week-days label").map(function () {
        return +($(this).hasClass("active"));
    }).get();


    var err = 0;
    $('.parsley-error').removeClass('parsley-error');

    if (dateSch == '') {
        $('#vis-ovr-scd-date').addClass('parsley-error');
        err++;
    }

    if (err > 0) {
        $('#vis-expt-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#vis-expt-loading').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-schedule-seat-fare-exception-override",
        data: data,
        success: function (response) {
            if (response.status == 1) {
            	cancelSeatFareExceptionDialog();
                $('#vis-expt-loading').html('');
                getSeatFare();
                setContentHeight('#wizard_form');
            } else {
                $('#vis-expt-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}



function deleteSeatFareExceptionschedules(obj) {
    var data = {}
    data.code = $('#sch_code').val();
    data.busCode = $('#bustype').val();
    data.activeFlag = 2;
    data.vcode = $(obj).attr('data-viscode');
    data.seatViscode = $(obj).attr('data-expcode');

    if (confirm('Do you want to delete this Seat Fare exception/override?')) {
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-seat-fare-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#stv-eo-del-' + data.seatViscode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
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

function getScheduleAutoOverride() {
    var data = {}
    data.code = $('#sch_code').val();
    data.jsonResponse = $('#load_schfare').is(':empty') ? 0 : 1;
    
    var $div = (data.jsonResponse == 0) ? $('#load_schfare') : $('#fao-list-table-div');
    $div.html(loading_small);
    
    $.ajax({
        type: "POST",
        dataType: data.jsonResponse == 0 ? 'html' : 'json',
        url: base_url + "schedules/get-schedule-auto-override",
        data: data,
        success: function (res) {
            if (res) {
                if(data.jsonResponse == 0) {
                    $div.html(res);
                    $('html, body').animate({scrollTop: 150}, 'slow');
                } else {
                    if(Array.isArray(res)) {
                        schfareOverride = res;
                    }
                }
                renderFaoRow();
            } else {
                $('.error_visib').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });

}

function clearFareOverrideFilter() {
    $('#fao-date-filter').val('');
}

function getScheduleTimeAutoOverride() {
   var data = {}
    data.code = $('#sch_code').val();
    $('#load_schtime').html(loading_small);
    $("html, body").animate({scrollTop: 150}, "slow");
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-schedule-time-auto-override",
        data: data,
        success: function (res) {
            if (res) {
                $('#load_schtime').html(res);
            }
        }
    }); 
}

function getDynamicPricingMaster() {
    var data = {}
    data.code = $('#sch_code').val();
    $('#schedule_dp').html(loading_small);
    $("html, body").animate({scrollTop: 150}, "slow");
    
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-schedule-dynamic-price",
        data: data,
        success: function (res) {
            if (res) {
                $('#schedule_dp').html(res);              
            }
        }
    });
}

function saveScheduleDynamicPricing() {
    $('#disc-form-action-state').html('');
    var data = {}
    data.schedule = $('#sch_code').val();
    data.code = $('#dp_code').val();  
    
    var dateSch = $('#date_dp').val();
    var date = dateSch.split('|');
    data.activeFrom = date[0];
    data.activeTo = date[1];
    data.dayOfWeek = $("#dp-weekdays label").map(function () {
        return +($(this).hasClass("active"));
    }).get();      
    data.activeFlag = 1;    

    var err = 0;
    $('.parsley-error').removeClass('parsley-error');

    if (dateSch == '') {
        $('#date_dp').addClass('parsley-error');
        err++;
    }
    var fares = [];
    var er = false;
    $('.farerow').each(function() {
        if (err == 0) {
            var t= {};
            t.fromcode = $(this).find('#fromcode').val();
            t.tocode = $(this).find('#tocode').val();
            t.minfare = $.trim($(this).find('.minfare').val());
            t.maxfare = $.trim($(this).find('.maxfare').val());

            if(isNaN(t.minfare)) {
                $('#disc-form-action-state').html('<div class="alert alert-danger">Min fare should be valid number</div>');
                err++;             
                $(this).find('.minfare').addClass('inp_error').focus();
            } else if(isNaN(t.maxfare)) {
                $('#disc-form-action-state').html('<div class="alert alert-danger">Max fare should be valid number</div>');
                err++;               
                $(this).find('.maxfare').addClass('inp_error').focus();
            } else if(Number(t.minfare)>0 && Number(t.minfare)<200) {
                $('#disc-form-action-state').html('<div class="alert alert-danger">Min fare must be greater than 200</div>');
                err++;
                $(this).find('.minfare').addClass('inp_error').focus();
            } else if(Number(t.maxfare)>5000) {
                $('#disc-form-action-state').html('<div class="alert alert-danger">Max fare must be less than 5000</div>');
                err++;
                $(this).find('.maxfare').addClass('inp_error').focus();
            } else if( Number(t.minfare)>Number(t.maxfare) && Number(t.minfare)>0) {
                $('#disc-form-action-state').html('<div class="alert alert-danger">Max fare should be greater than min fare</div>');
                err++;            
                $(this).find('.maxfare').addClass('inp_error').focus();
            }    
            
            if (err == 0 && Number(t.minfare)>0 && Number(t.maxfare)>0 ) {
               fares.push(t); 
            }
        }
    });

    if (err == 0) {
        if(fares.length==0) {
            $('#disc-form-action-state').html('<div class="alert alert-danger">Please update min & max fare for atleast one route</div>');
            return;
        }
        data.fares = fares;
        
        $('#disc-form-action-state').html(loading_small);    
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/update-dynamic-price",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#disc-form-action-state').html('');
                } else {
                    $('#disc-form-action-state').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
                }
            }
        })
    }
    
}

function getTravelStops() {
    var data = {}
    data.code = $('#sch_code').val();
    $('#schedule_stops').html(loading_small);
    $("html, body").animate({scrollTop: 150}, "slow");
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-schedule-travel-stops",
        data: data,
        success: function (res) {
            if (res) {
                $('#schedule_stops').html(res);                
            }
        }
    }); 
}

function showSheduleStopDialog(code) {
    $('#stp-form-buttons').show();
    $('#stp-form-action-state').html('');
    $('#stp-form-action-state').hide();
    
    $('#stp-stop').val('');
    $('#stp-station').val('');
    $('#stp-minutes').val('');
    
    $('.inp_error').removeClass('inp_error');
    $('#stops-dialog').css('background', '#fff');
    $('#stops-dialog').removeClass('hide');
    $('#stops-dialog').show();
    $('#stops-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    
    if(_isdefined(code)) {
        var t = _.find(m_stops, function(o) { return o.code == code; });        
        $('#stp-stop').val(t.code);
        $('#stp-station').val(t.stations.code);
        $('#stp-minutes').val(t.travelMinutes);
    }
}

function cancelScheduleStopDialog() {
    $('#stops-dialog').dialog('destroy');
    $('#stops-dialog').hide();
}

function deleteScheduleStop(code) {
    var t = _.find(m_stops, function(o) { return o.code == code; }); 
    var data = {};
    data.schedule_code = $('#sch_code').val();
    data.stop = t;
    if (confirm('Do you want to delete this stop?')) {
        data.stop.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedule-stops",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        getTravelStops();
                    }, 3000);
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

function saveScheduleStop() {
    var data = {};
    data.schedule_code = $('#sch_code').val();
    data.stop = $('#stp-stop').val();
    data.station = $('#stp-station').val();
    data.minutes = $.trim( $('#stp-minutes').val() );

    $('#stp-station, #stp-stop, #stp-minutes').removeClass('inp_error');
    $('#stp-form-action-state').removeClass('alert-success').removeClass('alert-danger');

    var err = 0;
    if (data.stop == '') {
        $('#stp-stop').addClass('inp_error');
        err++;
    } 

    if (data.station == '') {
        $('#stp-station').addClass('inp_error');
        err++;
    } 

    if (data.minutes == '') {
        $('#stp-minutes').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#stp-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#stp-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#stp-form-action-state').show();
        return false;
    } 

    $('#stp-form-buttons').hide();
    $('#stp-form-action-state').html(loading_popup);
    $('#stp-form-action-state').show();
    $.ajax({
        type: "POST",
        url: "schedules/update-schedule-stops",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) { 
                $('#stp-form-action-state').removeClass('alert-danger');
                $('#stp-form-action-state').addClass('alert-success');
                $('#stp-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelScheduleStopDialog();
                    getTravelStops();
                }, 3000);
            } else {
                $('#stp-form-action-state').addClass('alert-danger');
                $('#stp-form-action-state').html(res.errorDesc);
                $('#stp-form-buttons').show();
            }
        }
    });
}

function getScheduleGallery() {
   var data = {}
    data.code = $('#sch_code').val();
    $('#schedule_gallery').html(loading_small);
    $("html, body").animate({scrollTop: 150}, "slow");
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-schedule-gallery",
        data: data,
        success: function (res) {
            if (res) {
                $('#schedule_gallery').html(res);
                getScheduleGalleryPhotos();
            }
        }
    }); 
}

function getScheduleGalleryPhotos() {
    var data = {}
    data.code = $('#sch-gal-id').val();
    if(data.code=="") {
        return;
    }
    $('#sch-gallery-photos').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-schedule-gallery-photos",
        data: data,
        success: function (res) {
            if (res) {
                $('#sch-gallery-photos').html(res);
            }
        }
    }); 
}

function saveScheduleGallery(){
    var data = {}
    data.gallery_id  = $('#sch-gal-id').val();
    data.schedule_id = $('#sch_code').val();
    $('#save-gallery-state').removeClass('alert').removeClass('alert-success').removeClass('alert-danger');
    $('#save-gallery-state').html(loading_small);
    
    $.ajax({
        type: "POST",
        url: "schedules/save-schedule-gallery",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
               $('#save-gallery-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
               window.setTimeout(function () {
                   $('#save-gallery-state').removeClass('alert').removeClass('alert-success').removeClass('alert-danger');
                   $('#save-gallery-state').html('');
                }, 3000);
            } else {
               $('#save-gallery-state').addClass('alert').addClass('alert-danger').html(res.errorDesc); 
            }
        }
    });
}


function saveScheduleFare(fromSearch) {
    var dateSch = $('#fao-date_disc').val();
    var date = dateSch.split('|');
    var data = {}, err = 0;
    data.schedule = $('#sch_code').val();
    data.code = $('#fao-schfare_code').val();
    data.over_code = $('#fao-schfare_over_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.activeFlag = 1;
    data.type = $('#fao-schfare_type').val();
    data.lookup = $('#fao-schfare_code_lookup').val();
    data.busCode = $('#bus-type-sch-seat').val();
    var day = 0;
    data.dayOfWeek = $("#fao-exp-weekdays label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    
    if($('#fao-group-seat-sch').val() != null) {
        if($('#fao-group-seat-sch').val().indexOf("") < 0) {
            data.group = $('#fao-group-seat-sch').val().map(function(val){
                return { code: val };
            });     
        } else {
            data.group = [{ code: '' }];
        }
    } else {
        $('.fao-group-seat-sch').addClass('inp_error');
        err++;
    }
    data.routes = $('#fao-sch-from').val();
    data.fare =$('#fao-seat-sch-aofare').val();
    data.fareType = $('#fao-sch-fare-type').val();
    data.fareOverrideType = $('#fao-sch-fare-override-type').val();
    data.fareOverridemins = $('#fao-fare-ovr-min').val();
    data.busSeatTypeCode = $('#fao-fare-ovr-seat-type').val() || [];
    if(data.busSeatTypeCode.indexOf('ABST') > -1) {
        data.busSeatTypeCode = ['ABST'];
    }
    
    if ($('#fao-sch-from').val() == null) {
        $('.fao-sch-from').addClass('inp_error');
        err++;
    } else {
        $('.fao-sch-from').removeClass('inp_error');
    }
    if ($('#fao-seat-sch-aofare').val() == '') {
        $('#fao-seat-sch-aofare').addClass('inp_error');
        err++;
    } else {
        $('#fao-seat-sch-aofare').removeClass('inp_error');
    }
    if ($('#fao-sch-fare-type').val() == '') {
        $('#fao-sch-fare-type').addClass('inp_error');
        err++;
    } else {
        $('#fao-sch-fare-type').removeClass('inp_error');
    }
    if ($('#fao-date_disc').val() == '') {
        $('#fao-date_disc').addClass('inp_error');
        err++;
    } else {
        $('#fao-date_disc').removeClass('inp_error');
    }

    if ($('#fao-sch-fare-override-type').val() == '') {
        $('#fao-sch-fare-override-type').addClass('inp_error');
        err++;
    } else {
        $('#fao-sch-fare-override-type').removeClass('inp_error');
    }

    if (err > 0) {
        $('#fao-schfare-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#fao-schfare-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#fao-schfare-form-action-state').show();
        return false;
    } else {
        $('#fao-schfare-form-action-state').removeClass('alert-danger').addClass('alert-success');
        $('#fao-schfare-form-action-state').hide();
    }

    $('#fao-schfare-form-action-state').removeClass('alert-danger alert-success');
    $('#fao-schfare-form-action-state').html(loading_popup);
    $('#fao-schfare-form-action-state').show();
    $.ajax({
        type: "POST",
        url: "schedules/update-schedule-fare",
        data: data,
        dataType: 'json',
        success: function (res) {
        	if (res.status == 1) {
                $('#fao-schfare-form-action-state').addClass('alert-success');
                $('#fao-schfare-form-action-state').html('Your request has been completed successfully');
                if(fromSearch!=1) {
                    getScheduleAutoOverride();
                    $('#fao-schfare_code').val('');
                    $('#fao-seat-sch-aofare').val('');
                    $('#fao-schfare-form-action-state').hide();
                }
                window.setTimeout(function () {
                    if(fromSearch==1) {
                       cancelSheduleOverrideDialog();
                       load_fare_overrides()    // search.js                         
                    }
                }, 3000);
            } else {
                $('#fao-schfare-form-action-state').show();
                $('#fao-schfare-form-action-state').addClass('alert-danger');
                $('#fao-schfare-form-action-state').html(res.errorDesc);
                $('#fao-schfare-form-buttons').show();
            }
        }
    });
}

function clearSheduleOverrideDialog() {   
    $('.inp_error').removeClass('inp_error');
    $('#fao-schfare-form-action-state').hide();
    $('#fao-sch-from').html(fao_sch_from_html);
    $('#fao-sch-from').multiselect('rebuild');
    $('#stype-container').removeClass('hide');
    $('#fao-date_disc').val('').trigger('change');
    $('#fao-schfare_code').val('');
    $('#fao-schfare_over_code').val('');
    $('#fao-schfare_code_lookup').val('');
    $('#fao-exp-weekdays').find("input[name='fao-weeks']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');        
        $(this).parent().addClass('active');
    });
    $('#fao-group-seat-sch').val(['']).multiselect('refresh');
    $('#fao-sch-from').val(['']).multiselect('refresh');
    $('#fao-fare-ovr-seat-type').val(['ABST']).multiselect('refresh');
    $('#fao-seat-sch-aofare').val('');
}

function showSheduleTimeOverrideDialog(index) {
    $('#fao-schtime-form-buttons').show();
    $('#fao-schtime-form-action-state').html('');
    $('#fao-schtime-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    $('#tao-code').val('');
    
    $('#schtime-dialog').css('background', '#fff');
    $('#schtime-dialog').removeClass('hide');
    $('#schtime-dialog').show();
    $('#schtime-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 200,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    
    var mins = 0;
    if( _isdefined(index) ) {   //  edit mode
        item = timeOverrideList[index];
        $('#tao-code').val(item.code);
        $('#tao-station').val(item.station.code);
        if(item.reactionFlag==true) {
            $('#tao-reaction').val(1);
        }
        mins = item.overrideMinutes
    
        $('#tao-time').val(item.overrideMinutes);
        $('#tao-time-type').val(item.overrideType);
        $('#tao-daterange').val(item.activeFrom+' | '+item.activeTo);
        
        $('#tao-weekdays').find('.active').removeClass('active').removeAttr("checked");
        var str = item.dayOfWeek;
        var res = str.split("");
        $("input[name='tao-weeks']").each(function (i) {
            if (res[i] == 1) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            }
        });        
    }
    
    $("#tao-time").ionRangeSlider({
        type: "single",
        step: 1,
        postfix: "",
        from: mins,
        to: 5,
        max: 300,
        min: 0,
        // hideMinMax: true,               // hide Min and Max fields
        hideFromTo: true, // hide From and To fields
        onLoad: function (ui) {
            $('.irs-min').html("0 Mins");
            $('.irs-max').html("5 Hrs");
        },
        onChange: function (ui) {
            $('#tao-time-mins').val(ui.fromNumber);

            var hours = Math.floor(ui.fromNumber / 60);
            var minutes = ui.fromNumber - (hours * 60);
            if (hours.toString().length == 1)
                hours = '0' + hours;
            if (minutes.toString().length == 1)
                minutes = '0' + minutes;

            $('#tao-time-label').html(hours + ':' + minutes);
            //console.log($('#station-time-range').val());
        },
        hasGrid: false
    });
}

function cancelSheduleTimeOverrideDialog() {
    $('#schtime-dialog').dialog('destroy');
    $('#schtime-dialog').hide();
    $("#tao-time").ionRangeSlider("remove");
}

function saveScheduleTimeOverride() {
     $('.inp_error').removeClass('inp_error');
    var data = {};
    data.schedule = $('#sch_code').val();
    data.code = $('#tao-code').val();
    data.station = $('#tao-station').val();
    data.reaction = $('#tao-reaction').val();
    data.time = $('#tao-time-mins').val();
    data.timetype = $('#tao-time-type').val();
    data.daterange = $('#tao-daterange').val();
    data.weekdays = $("#tao-weekdays label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    
    if(data.time==0) {
        $('#tao-time').addClass('inp_error');
        return;
    } else if(data.timetype=="") {
        $('#tao-time-type').addClass('inp_error');
        return;
    } else if(data.daterange=="") {
        $('#tao-daterange').addClass('inp_error');
        return;
    }
    
    $('#fao-schtime-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#fao-schtime-form-action-state').html(loading_popup);
    $('#fao-schtime-form-action-state').show();
    $.ajax({
        type: "POST",
        url: "schedules/save-schedule-auto-time-override",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('#fao-schtime-form-buttons').hide();
                $('#fao-schtime-form-action-state').removeClass('alert-danger');
                $('#fao-schtime-form-action-state').addClass('alert-success');
                $('#fao-schtime-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelSheduleTimeOverrideDialog();
                    getScheduleTimeAutoOverride();
                }, 3000);
            } else {
                $('#fao-schtime-form-action-state').show();
                $('#fao-schtime-form-action-state').addClass('alert-danger');
                $('#fao-schtime-form-action-state').html(res.errorDesc);
                $('#fao-schtime-form-buttons').show();
            }
        }
    });
}

function deleteScheduleTimeOverride(opt) {
    if (confirm('Do you want to delete this schedule time override?')) {
        var data = {}
        data.scheduleCode = $('#sch_code').val();
        data.code = opt;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-time-override",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                    	getScheduleTimeAutoOverride();
                    }, 3000);
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


function showSheduleOverrideDialog(code, fare, fareType, fareOverrideType, group, datetype, from, to, week, fromcode, tocode, fareOverridemins, busSeatTypeCode, type, option) {
    $('#fao-schfare-form-buttons').show();
    $('#fao-schfare-form-action-state').html('');
    $('#fao-schfare-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    $('#schfare-dialog').css('background', '#fff');
    $('#schfare-dialog').removeClass('hide');
    $('#schfare-dialog').show();
    $('#schfare-dialog').dialog({
        autoOpen: true,
        height: 510,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();    
    $('#fao-sch-from').html(fao_sch_from_html);
    $('#fao-sch-from').multiselect('rebuild');
    $('#fao-group-seat-sch').html(fao_group_seat_sch_html);
    $('#fao-group-seat-sch').multiselect('rebuild');

    if (code != '' && code != undefined) {
        var schfare = schfareOverride.find(function(v) { return  v.code == code; });
        $('#fao-schfare_code').val(code);
        $('#fao-date_disc').val(from + ' | ' + to);
        if (schfare.groupList.length) {
            $('#fao-group-seat-sch').val(schfare.groupList.map(function(x){
                return x.code;
            })).multiselect('refresh');
        } else {
            $('#fao-group-seat-sch').val(['']).multiselect('refresh');
        }
        
        $('#fao-sch-from').val('');
        var routes = [];
        $(schfareOverride).each(function (i , item) {
            if(item.code == code){
                $(item.routeList).each(function (j , row) {
                    routes.push(this.fromStation.code + ' - ' + this.toStation.code);
                });
            }
        });
        $('#fao-sch-from').val(routes).multiselect('rebuild');
        if(!$('#fao-sch-from').val()){
            $('#fao-sch-from').val('NA').multiselect('rebuild');
        }
        $('#fao-seat-sch-aofare').val(fare);
        $('#fao-sch-fare-type').val(fareType);
        $('#fao-sch-fare-override-type').val(fareOverrideType);
        $('#fao-fare-ovr-min').val(fareOverridemins);
        
        if(schfare.busSeatTypeCodes.length == 0) {
            $('#fao-fare-ovr-seat-type').val(['ABST']).multiselect("refresh");            
        } else {
            $('#fao-fare-ovr-seat-type').val(schfare.busSeatTypeCodes).multiselect("refresh");
        }
                
        $('#fao-schfare_code').val(code);
        $('#fao-exp-weekdays ').find('.active').removeClass('active').removeAttr("checked");
        var str = week;
        var res = str.split("");
        $("input[name='fao-weeks']").each(function (i) {
            if (res[i] == 1) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            }
        });
        $('input[name=fao-sch-fare-type][value=' + fareType + ']').prop("checked", true);
        
        $('#fao-form-div').show();
        $('html, body').animate({
            scrollTop: $('#fao-form-div').offset().top - 55
        }, 'slow');
    }
    else {
        $('#fao-sch-from').val('').multiselect("refresh");
        $('#fao-group-seat-sch').val(['']).multiselect('refresh');
        $('#fao-seat-sch-fare').val('');
        $('#fao-date_disc').val('');
        $('#fao-group').val('all');
        $('#fao-sch-fare-type').val('');
        $('#fao-sch-fare-override-type').val('');
        $('#fao-seat-sch-aofare').val('');
        $('#fao-fare-ovr-min').val(0);
        $('#fao-schfare_code').val('');
        if($('#fao-fare-ovr-seat-type > option').length > 1){
            $('#fao-fare-ovr-seat-type').val(['ABST']).multiselect("refresh");
        }
        $('#fao-exp-weekdays').find("input[name='fao-weeks']").each(function (i) {
            $(this).attr("checked", "checked");//.addClass('active');        
            $(this).parent().addClass('active');
        });
    }

    if(fareType == 2){
        var schfare = schfareOverride.find(function(v) { return  v.code == fare; });
        $('#fao-schfare_code').val('');
        $('#fao-schfare_code_lookup').val(fare);
        $('#fao-schfare_type').val(1);
        $('#fao-sch-fare-type').val('FLT');
        $('#fao-sch-fare-override-type').val('FLFA');
        //$('#type1').addClass('hide');
        $('#fao-sch-from').addClass('hide');
        if($('#fao-fare-ovr-seat-type > option').length > 1){
            if(schfare.busSeatTypeCodes.length == 0) {
            $('#fao-fare-ovr-seat-type').val(['ABST']).multiselect("refresh");            
            } else {
                $('#fao-fare-ovr-seat-type').val(schfare.busSeatTypeCodes).multiselect("refresh");
            }
        }
        $('#stype-container').addClass('hide');
        $('#fao-fare-ovr-min, label[for=fao-fare-ovr-min]').addClass('hide');

        $('#fao-sch-from').html("<option value='NA'>All Routes</option>");
        $(schfareOverride).each(function (i , item) {
            if(item.code == fare){
                $(item.routeList).each(function (j , row) {
                    $('#fao-sch-from').append('<option value="'+this.fromStation.code + ' - ' + this.toStation.code+'">'+this.fromStation.name + ' - ' + this.toStation.name+'</option>');
                });
            }
        });
        $('#fao-sch-from').val(['NA']).multiselect("rebuild");
        
        $('#fao-group-seat-sch').html("<option value=''>All Group</option>");
        $(schfare.groupList).each(function (i , row) {
            $('#fao-group-seat-sch').append('<option value="' + row.code + '">' + row.name + '</option>');
        });
        $('#fao-group-seat-sch').val(['']).multiselect('rebuild');
        $('#stype-container').addClass('hide');

        //$('#fao-sch-from').html('');
//        $(schfareOverride).each(function (i , item) {
//            if(item.code == fare){
//                $(item.routeList).each(function (j , row) {
//                    $('#fao-sch-from').append('<option value="'+this.fromStation.code + ' - ' + this.toStation.code+'">'+this.fromStation.name + ' - ' + this.toStation.name+'</option>');
//                });
//            }
//        });
        $('#fao-sch-from').multiselect("rebuild");
        $('#fao-form-div').show();
        $('html, body').animate({
            scrollTop: $('#fao-form-div').offset().top - 55
        }, 'slow');
    }else{
        $('#fao-schfare_code_lookup').val('');
        $('#fao-schfare_code').val(code);
        //$('#type1').removeClass('hide');
        $('#stype-container').removeClass('hide');
        $('#fao-sch-from').removeClass('hide');
        $('#fao-fare-ovr-min, label[for=fao-fare-ovr-min]').removeClass('hide');   
        if($(option).data('ecode')) {
            var schfare = schfareOverride.find(function(v) { return  v.code == code; });        
            var schfareOver = schfare.overrideList.find(function(v) { return v.code == $(option).data('ecode'); });
            $('#fao-group-seat-sch').html('<option value="">All Group</option>');
            $(schfare.groupList).each(function (i , row) {
                $('#fao-group-seat-sch').append('<option value="' + row.code + '">' + row.name + '</option>');
            });
            if (schfareOver.groupList.length) {
                $('#fao-group-seat-sch').val(schfareOver.groupList.map(function(x){
                    return x.code;
                })).multiselect('rebuild');
            } else {
                $('#fao-group-seat-sch').val(['']).multiselect('rebuild');
            }
        }
    }
    
    if (_isdefined($(option).attr('data-edit'))) {
        $('#fao-schfare_code').val(fare);
        $('#fao-schfare_type').val(1);
        //$('#type1').addClass('hide');
        $('#fao-sch-from').addClass('hide');
        $('#fao-schfare_over_code').val($(option).attr('data-ecode'));
        $('#fao-schfare_code').val($(option).attr('data-ecode'));
        $('#stype-container').addClass('hide');
        $('#fao-fare-ovr-min, label[for=fao-fare-ovr-min]').addClass('hide');
        $('#fao-sch-from').html("<option value='NA'>All Routes</option>");
        $(schfareOverride).each(function (i , item) {
            if(item.code == code){
                $(item.routeList).each(function (j , row) {
                    $('#fao-sch-from').append('<option value="'+this.fromStation.code + ' - ' + this.toStation.code+'">'+this.fromStation.name + ' - ' + this.toStation.name+'</option>');
                });
            }
        });
        $('#fao-sch-from').multiselect("rebuild");
        var routes = [];
        $(schfareOverride).each(function (i , item) {
            if(item.code == code){
                $(item.overrideList).each(function (j , row) {
                    if(row.code == $(option).attr('data-ecode')){
                        $(row.routeList).each(function (k) {
                            routes.push(this.fromStation.code + ' - ' + this.toStation.code);
                        });
                    }
                });
            }
        });
        $('#fao-sch-from').val(routes).multiselect("refresh");
        if(!$('#fao-sch-from').val()){
            $('#fao-sch-from').val('NA').multiselect('rebuild');
        }
     }else{
        $('#fao-schfare_over_code').val('');
        //$('#fao-schfare_code').val(code);
     }
    }

function cancelSheduleOverrideDialog() {
    $('#schfare-dialog').dialog('destroy');
    $('#schfare-dialog').hide();
}
function deleteScheduleOverride(opt, fromSearch) {
    if (confirm('Do you want to delete this schedule fare override?')) {
        var data = {}
        data.scheduleCode = $('#sch_code').val();
        data.code = opt;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedules-override-fare",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                    	if(fromSearch==1) {
                            load_fare_overrides();  // search.js
                        } else {
                            getScheduleAutoOverride();
                        }
                    }, 3000);
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


function deleteScheduleOverrideException(code,opt, fromSearch) {
    if (confirm('Do you want to delete this schedule fare override?')) {
        var data = {}
        data.scheduleCode = $('#sch_code').val();
        data.lookcode = code;
        data.code = opt;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/delete-schedule-override-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                    	if(fromSearch==1) {
                            load_fare_overrides();  // search.js
                        } else {
                            getScheduleAutoOverride();
                        }
                    }, 3000);
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


function fareOverrideExceptionDialog(code, option) {
    $('.inp_error').removeClass('inp_error');
    $('#fare-date-disc').val('');
    $("input[name='fareover-weeks']").each(function (i) {
        $(this).attr("checked", "checked").prop('checked', true);
        $(this).parent().addClass('active');
    });
    $('#fareover-form-action-state').removeClass('alert-danger');
    $('#fareover-form-action-state').html('');
    $('#fareover-form-action-state').hide();
    $('#fare-override-exp-dialog').css('background', '#fff');
    $('#fare-override-exp-dialog').removeClass('hide');
    $('#fare-override-exp-dialog').show();
    $('#fare-override-exp-dialog').dialog({
        autoOpen: true,
        height: 320,
        width: 500,
        modal: true,
        resizable: false
    });

    if (_isdefined(code)){
        $('#exp-sch-routes').html("<option value='NA'>All Routes</option>");
        $('#exp-sch-group').html("<option value=''>All Groups</option>");
        $(schfareOverride).each(function (i , item) {
            if(item.code == code){
                $(item.routeList).each(function (j , row) {
                    $('#exp-sch-routes').append('<option value="'+this.fromStation.code + ' - ' + this.toStation.code+'">'+this.fromStation.name + ' - ' + this.toStation.name+'</option>');
                });
                $(item.groupList).each(function () {
                    $('#exp-sch-group').append('<option value="'+this.code + '">'+this.name + '</option>');
                });
            }
        });
        $('#exp-sch-routes').val(['NA']).multiselect('rebuild');
        $('#exp-sch-group').val(['']).multiselect('rebuild');
    }
    
    if (_isdefined($(option).attr('data-code'))) {
        $('#fare-date-disc').val($(option).attr('data-date'));
        $('#schfareoverride_exp_code').val($(option).attr('data-ecode'));
        if ($(option).attr('data-daysofweek') != '' && $(option).attr('data-daysofweek') != 'null' && $(option).attr('data-daysofweek') != ' ') {
            var str = $(option).attr('data-daysofweek');

            $('#fareover-exp-weekdays ').find('.active').removeClass('active').removeAttr("checked");
            var res = str.split("");
            $("input[name='fareover-week']").each(function (i) {
                if (res[i] == 1) {
                    $(this).attr("checked", "checked");//.addClass('active');
                    $(this).parent().addClass('active');
                }

            });

        }
        $('#exp-sch-routes').val('');
        var routes = [];
        $(schfareOverride).each(function (i , item) {
            if(item.code == code){
                $(item.overrideList).each(function (j , row) {
                    if($(option).attr('data-ecode') == row.code) {
                        $(row.routeList).each(function (k) {
                            routes.push(this.fromStation.code + ' - ' + this.toStation.code);
                        });
                        $('#exp-sch-group').val(row.groupList.map(function(x){
                            return x.code;
                        })).multiselect('rebuild');
                    }
                });
            }
        });
        $('#exp-sch-routes').val(routes).multiselect("refresh");
        if(!$('#exp-sch-routes').val()){
            $('#exp-sch-routes').val('NA').multiselect('rebuild');
        }
    }

    
    $('#schfareoverride_code').val(code);
    $(".ui-dialog-titlebar").hide();
    $('#fareover-form-buttons').show();
}

function saveFareOverrideExceptionDialog(fromSearch) {
    var data = {};
    var dateExp = $('#fare-date-disc').val();
    var date = dateExp.split('|');
    var data = {}
    data.dayOfWeek = '';
    data.dayOfWeek = $("#fareover-exp-weekdays label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    data.schedule = $('#sch_code').val();
    data.lookup = $('#schfareoverride_code').val();
    data.busCode = $('#bus-type-sch-seat').val();
    data.code = $('#schfareoverride_exp_code').val();
    data.routes = $('#exp-sch-routes').val();
    
    if($('#exp-sch-group').val() != null) {
        if($('#exp-sch-group').val().indexOf("") < 0) {
            data.group = $('#exp-sch-group').val().map(function(val){
                return { code: val };
            });     
        } else {
            data.group = [{ code: '' }];
        }
        $('.exp-sch-group').removeClass('inp_error');
    } else {
        $('.exp-sch-group').addClass('inp_error');
        err++;
    }

    var err = 0;
    if ($('#exp-sch-routes').val() == null) {
        $('.exp-sch-routes').addClass('inp_error');
        err++;
    } else {
        $('.exp-sch-routes').removeClass('inp_error');
    }
    if ($('#fare-date-disc').val() == '') {
        $('#fare-date-disc').addClass('inp_error');
        err++;
    } else {
        $('#fare-date-disc').removeClass('inp_error');
    }
    if (err > 0) {
        $('#fareover-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#fareover-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#fareover-form-action-state').show();
        return false;
    } else {
        $('#fareover-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#fareover-form-action-state').hide();
    }


    $('#fareover-form-buttons').hide();
    $('#fareover-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#fareover-form-action-state').html(loading_popup);
    $('#fareover-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-fare-override-exception",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#fareover-form-buttons').hide();
                $('#fareover-form-action-state').removeClass('alert-danger');
                $('#fareover-form-action-state').addClass('alert-success');
                $('#fareover-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelFareOverrideException();
                    
                    if(fromSearch==1) {
                        load_fare_overrides();
                    } else {
                        getScheduleAutoOverride();
                    }
                }, 3000);
            } else {
                $('#fareover-form-action-state').show();
                $('#fareover-form-action-state').addClass('alert-danger');
                $('#fareover-form-action-state').html(response.errorDesc);
                $('#fareover-form-buttons').show();
            }
        }
    })
}


function deleteFareOverrideExceptionDialog() {
    var data = {};
    var dateExp = $('#fare-date-disc').val();
    var date = dateExp.split('|');
    var data = {}
    data.dayOfWeek = '';
    data.dayOfWeek = $("input[name='fareover-weeks']").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    data.schedule = $('#sch_code').val();
    data.lookup = $('#schfareoverride_code').val();
    data.busCode = $('#bus-type-sch-seat').val();
    data.code = $('#schfareoverride_exp_code').val();

    var err = 0;
    if ($('#fare-date-disc').val() == '') {
        $('#fare-date-disc').addClass('inp_error');
        err++;
    } else {
        $('#fare-date-disc').removeClass('inp_error');
    }
    if (err > 0) {
        $('#fareover-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#fareover-form-action-state').html('Please select date');
        $('#fareover-form-action-state').show();
        return false;
    } else {
        $('#fareover-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#fareover-form-action-state').hide();
    }


    $('#fareover-form-buttons').hide();
    $('#fareover-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#fareover-form-action-state').html(loading_popup);
    $('#fareover-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-fare-override-exception",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#fareover-form-buttons').hide();
                $('#fareover-form-action-state').removeClass('alert-danger');
                $('#fareover-form-action-state').addClass('alert-success');
                $('#fareover-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelFareOverrideException();
                    getScheduleAutoOverride();
                }, 3000);
            } else {
                $('#fareover-form-action-state').show();
                $('#fareover-form-action-state').addClass('alert-danger');
                $('#fareover-form-action-state').html(response.errorDesc);
                $('#fareover-form-buttons').show();
            }
        }
    })
}


function cancelFareOverrideException() {
    $('#fare-override-exp-dialog').dialog('destroy');
    $('#fare-override-exp-dialog').hide();
}

function viewFareExceptionOverride(e, code) {
    var source = e.target || e.srcElement;
    if (source.nodeName != "SPAN" && source.nodeName != "TD")
        return;
    $('.routes-sch-exp-' + code + ',.routes-sch-ove-' + code).toggle('slow');
    $('#fareover-' + code).toggleClass('hover-background');
}

function changeToRoutes(value){
    $('#routes-schedules-to > option').removeAttr('hidden');
    $('#routes-schedules-to > option[value='+value+']').attr('hidden','');
    $('.routes-ext').each(function () {
        if ($(this).attr('data-from') == value) {
            $('#routes-schedules-to > option[value='+$(this).attr('data-to')+']').attr('hidden','');
        }
    });
}

function editBookingschedules(code){
    $(".toggle-booking-list").show();
    $('#hid-sch-bkg-code').val(code.code);
    $('#close-hour-booking').val(code.closeMinitues);
    $('#booking-group-schedules').val(code.group.code);
    if('fromStation' in code){
        $('#route_stg').val(code.fromStation.code+'-'+code.toStation.code);
    } else {
        $('#route_stg').val('');
    }
    if(code.allowBookingFlag == 1){
        $('#openclose').bootstrapSwitch('state', true);  
    } else {
        $('#openclose').bootstrapSwitch('state', false);  
    }
    $('#open-day-booking').val(parseInt(code.openMinitues/1440));
    $('#open-hour-booking').val(parseInt((code.openMinitues%1440)/60));
    $('#open-min-booking').val(parseInt(code.openMinitues%60));
    if (code.dayOfWeek != undefined && code.dayOfWeek != '') {
        if(!$('#adv-opt-row').is(":visible")){
            toggleAdvOpt();          
        }
        setTimeout(function () {
            setContentHeight('#wizard_form');
        },250);
        if(code.dayOfWeek == 'ALRNATE'){
            $("#rad-alt").prop("checked", true).trigger("change");
            $('#adv-date').val(code.activeFrom);
        } else {            
            $("#rad-day").prop("checked", true).trigger("change");
            $('#adv-week-days').find('.active').removeClass('active').removeAttr("checked");
            var str = code.dayOfWeek;
            var res = str.split("");
            $("input[name='adv-week-days']").each(function (i) {
                $(this).removeAttr("checked");            
                if (res[i] == 1) {
                    $(this).prop('checked', true);
                    $(this).parent().addClass('active');
                }
            });
            if(code.activeFrom != undefined && code.activeTo != undefined) {
                $("#adv-day-date").val(code.activeFrom+' | '+code.activeTo);
            }            
        }
        
    } else {
        if ($('#adv-opt-row').is(":visible")) {
            toggleAdvOpt();
        }
        $("input[name='adv-week-days']").each(function (i) {
            $(this).removeAttr("checked");
            $(this).parent().removeClass('active');
        });
        $("#rad-alt, #rad-day").prop("checked", false).trigger("change");
        $('#adv-date, #adv-day-date, #adv-type-selected').val('');
    }
}

function editBookingExpSchedules(code,expcode){
    $('#booking-schedules-exception').css('background', '#fff');
    $('#booking-schedules-exception').show();
    $('#booking-schedules-exception').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#booking-group-exp-schedules').val(code.group.code);
    $('#hid-bok-sch-exp-code').val(expcode);
    $.each(code.overrideList, function(i, exp) {
        if(exp.code == expcode){   
            $('#bok-exp-scd-date').val(exp.activeFrom+' | '+exp.activeTo);
            var str = exp.dayOfWeek;
            var res = str.split("");
            $("#bok-except-week-days input[name='bok-except-week']").each(function(i) {
                $(this).removeAttr("checked").parent().removeClass('active');;            
                if (res[i] == 1) {
                    $(this).prop('checked', true);
                    $(this).parent().addClass('active');
                }
            });
        }
    });
}

function editBookingOvrSchedules(code,ovrcode){
    $('#booking-schedules-exception').css('background', '#fff');
    $('#booking-schedules-exception').show();
    $('#booking-schedules-exception').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#tabs_bok_exp a[href="#bok-ovr"]').tab('show');
    $('#hid-bok-sch-ovr-code').val(ovrcode);
    $.each(code.overrideList, function(i, ovr) {
        if(ovr.code == ovrcode){   
            $('#bok-ovr-scd-date').val(ovr.activeFrom+' | '+ovr.activeTo);
            $('#open-day-ovr-booking').val(parseInt(ovr.openMinitues/1440));
            $('#open-hour-ovr-booking').val(parseInt((ovr.openMinitues%1440)/60));
            $('#open-min-ovr-booking').val(parseInt(ovr.openMinitues%60));
            $('#close-hour-exp-booking').val(ovr.closeMinitues);
            if(ovr.allowBookingFlag == 1){
                $('#bok-ovr-openclose').bootstrapSwitch('state', true);  
            } else {
                $('#bok-ovr-openclose').bootstrapSwitch('state', false);  
            }
            var str = ovr.dayOfWeek;
            var res = str.split("");
            $("#bok-ovr-week-days input[name='bok-ovr-week']").each(function(i) {
                $(this).removeAttr("checked").parent().removeClass('active');;            
                if (res[i] == 1) {
                    $(this).prop('checked', true);
                    $(this).parent().addClass('active');
                }
            });
        }
    });
}

function getScheduleCalendar(){
    var data = {};
    data.scheduleCode = $('#sch_code').val();
    if(data.scheduleCode=="") {
        return;
    }
    $('#sch-monthly-'+data.scheduleCode).html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/get-schedule-calendar",
        data: data,
        success: function (res) {
            if (res) {
                $('#sch-monthly-'+data.scheduleCode).html('');
                $('#sch-monthly-'+data.scheduleCode).monthly({
                    maxWidth: 800,
                    events: res,
                    dataType: 'json'
                });
                $('.bs_switch').bootstrapSwitch('size', 'small');
                $('.bs_switch').on('switchChange.bootstrapSwitch', function (e, data) {
                    var trip_code = $(this).attr('id');
                    var trip_status = $(this).attr('trip-status');
                    setCalendarTripStatus(trip_code,trip_status);
                });
            }
        }
    }); 
}

function setCalendarTripStatus(code, state) {
    var data = {};
    if(state == 'TPO' || state == 'NA'){
        data.trip_state = 'TPC';
    } else if(state == 'TPC'){
        data.trip_state = 'TPO';
    }
    data.trip_code = code;
    
    $('#loading-'+code).html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-trip",
        data: data,
        success: function (res) {
            $('#loading-'+code).html('');
            if (res.status == 1) {
                $("#schedule_caldr #"+code).attr('trip-status',data.trip_state);
            } else {
                $("#schedule_caldr #"+code).attr('trip-status',state);
            }
        }
    });
}

function toggleAdvOpt() {
    $('#adv-type-selected').val('');  
    if($('#adv-opt-row').is(":visible")){
        $('#adv-opt-row').hide('linear');      
    } else {
        $('#adv-opt-row').show('linear');          
    }
    setTimeout(function () {
        setContentHeight('#wizard_form');
    },250);
}

function getScheduleBusOverride() {
    var data = {}
    data.code = $('#sch_code').val();
    $('#load_sch_bus').html(loading_small);
    $("html, body").animate({scrollTop: 150}, "slow");
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-schedule-bus-override",
        data: data,
        success: function (res) {
            if (res) {
                $('#load_sch_bus').html(res);
            } else {
                $('#load_sch_bus').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });
}

function toggleBusOverride(code) {
    if(code  != undefined){
        var val = _.find(sch_bus_type_override, function(o) { return o.code == code; });
        $('#sch-bus-over-code').val(val.code);
        $('#sch-bus-over-date').val(val.activeFrom+' | '+val.activeTo);
        $('#sch-bus-over-type').val(val.bus.code).trigger('change');
        $("input[name='sch-bus-over-day']").each(function (i) {
            if (val.dayOfWeek[i] == 1) {
                $(this).attr("checked", "checked");
                $(this).parent().addClass('active');
            } else {
                $(this).removeAttr("checked");
                $(this).parent().removeClass('active');
            }
        });
        if(!$(".toggle-bus-override").is(':visible')){
            $(".toggle-bus-override").slideDown("slow");   
        }
    } else {
        clearBusTypeOverride();
        $(".toggle-bus-override").slideToggle("slow");
    }
}
function loadBusPreview(){
    var data = {}
    data.busType = $('#sch-bus-over-type').val();
    if(data.busType == ''){
        $('#sch-bus-over-seat-map').html('<br><div class="well well-large text-center"> Please select a Bus Type to load preview!</div>');
        return;
    }
    $('#sch-bus-over-seat-map').removeClass('hide');
    $('#sch-bus-over-seat-map').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/get-bus-seatmap",
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#sch-bus-over-seat-map').html(res);
        }
    });
}

function saveBusTypeOverride(){
    var data = {};
    var date = $('#sch-bus-over-date').val().split('|');
    data.activeFrom = date[0];
    data.activeTo = date[1];
    data.code = $('#sch-bus-over-code').val();
    data.scheduleCode = $('#sch_code').val();
    data.bus = $('#sch-bus-over-type').val();
    data.dayOfWeek = $("input[name='sch-bus-over-day']").map(function () {
        return + $(this).is(':checked');
    }).get().join('');

    var err = 0;
    $('.inp_error').removeClass('inp_error');
    if(data.activeFrom == ''){
        $('#sch-bus-over-date').addClass('inp_error');
        err++;
    }
    if(data.bus == ''){
        $('#sch-bus-over-type').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#sch-bus-over-action').removeClass('alert-success').addClass('alert-danger');
        $('#sch-bus-over-action').html('Please enter/select the values in the field that are marked in red');
        $('#sch-bus-over-action').show();
        return false;
    } else {
        $('#sch-bus-over-action').removeClass('alert-danger').addClass('alert-success');
        $('#sch-bus-over-action').hide();
    }

    $('#sch-bus-over-action').removeClass('alert-danger').removeClass('alert-success');
    $('#sch-bus-over-action').html(loading_small);
    $('#sch-bus-over-action').show();
    $.ajax({
        type: "POST",
        url: "schedules/update-schedule-bus-override",
        data: data,
        dataType: 'json',
        success: function (res) {
            if(res.status == 1){
                $('#sch-bus-over-action').removeClass('alert-danger');
                $('#sch-bus-over-action').addClass('alert-success');
                $('#sch-bus-over-action').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    getScheduleBusOverride();
                }, 2000);
            } else {
                $('#sch-bus-over-action').addClass('alert-danger');
                $('#sch-bus-over-action').html(res.errorDesc);
            }
        }
    });
}

function deleteBusOverride(code) {
    if (confirm('Do you want to delete this Bus Type Override?')) {
        var data = _.find(sch_bus_type_override, function(o) { return o.code == code; });
        data.activeFlag = 2;
        data.scheduleCode = data.schedule.code;
        data.bus = data.bus.code;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/update-schedule-bus-override",
            data: data,
            success: function (res) {
                if (res.status == 1) {                        
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    getScheduleBusOverride();
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
}

function busOverrideException(code, expcode){
    $('#bus-type-over-exp').css('background', '#fff');
    $('#bus-type-over-exp').removeClass('hide');
    $('#bus-type-over-exp').show();
    $('#bus-type-over-exp').dialog({
        autoOpen: true,
        height: 350,
        width: 550,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    $('#bus-type-ovr-code').val(code);
    if(expcode != undefined){
        var data = _.find(sch_bus_type_override, function(o) { return o.code == code; });
        var exp = _.find(data.overrideList, function(o) { return o.code == expcode; });
        $("#bus-type-exp-code").val(exp.code);
        $('#bus-type-exp-date').val(exp.activeFrom+' | '+exp.activeTo);
        $("input[name='bus-type-exp-day']").each(function (i) {
            if (exp.dayOfWeek[i] == 1) {
                $(this).attr("checked", "checked");
                $(this).parent().addClass('active');
            } else {
                $(this).removeAttr("checked");
                $(this).parent().removeClass('active');
            }
        });
    }
}

function clearBusTypeOverride(){
    $('#sch-bus-over-code').val('');
    $('#sch-bus-over-date').val('');
    $('#sch-bus-over-type').val('');
    $('#sch-bus-over-seat-map').html('<br><div class="well well-large text-center"> Please select a Bus Type to load preview!</div>');
    $('#sch-bus-over-day').find("input[name='sch-bus-over-day']").each(function (i) {
        $(this).attr("checked", "checked");//.addClass('active');
        $(this).parent().addClass('active');
    });
    $('#sch-bus-over-action').hide();
    $('.inp_error').removeClass('inp_error');
}

function saveBusTypeException(){
    var data = {};
    var date = $('#bus-type-exp-date').val().split('|');
    data.activeFrom = date[0];
    data.activeTo = date[1];
    data.code = $('#bus-type-exp-code').val();
    data.lookupCode = $('#bus-type-ovr-code').val();
    data.scheduleCode = $('#sch_code').val();
    data.dayOfWeek = $("input[name='bus-type-exp-day']").map(function () {
        return + $(this).is(':checked');
    }).get().join('');

    var err = 0;
    $('.inp_error').removeClass('inp_error');
    if(data.activeFrom == ''){
        $('#bus-type-exp-date').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#bus-type-exp-action').removeClass('alert-success').addClass('alert-danger');
        $('#bus-type-exp-action').html('Please enter/select the values in the field that are marked in red');
        $('#bus-type-exp-action').show();
        return false;
    } else {
        $('#bus-type-exp-action').removeClass('alert-danger').addClass('alert-success');
        $('#bus-type-exp-action').hide();
    }

    $('#bus-type-exp-action').removeClass('alert-danger').removeClass('alert-success');
    $('#bus-type-exp-action').html(loading_small);
    $('#bus-type-exp-action').show();
    $.ajax({
        type: "POST",
        url: "schedules/update-schedule-bus-override",
        data: data,
        dataType: 'json',
        success: function (res) {
            if(res.status == 1){
                $('#bus-type-exp-action').removeClass('alert-danger');
                $('#bus-type-exp-action').addClass('alert-success');
                $('#bus-type-exp-action').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelBusTypeException();
                    getScheduleBusOverride();
                }, 2000);
            } else {
                $('#bus-type-exp-action').addClass('alert-danger');
                $('#bus-type-exp-action').html(res.errorDesc);
            }
        }
    });
}

 function deleteBusTypeException(code, expcode){
    if (confirm('Do you want to delete this Bus Type Override Exception?')) {
        var ovr = _.find(sch_bus_type_override, function(o) { return o.code == code; });
        var data = _.find(ovr.overrideList, function(o) { return o.code == expcode; });
        data.activeFlag = 2;
        data.scheduleCode = ovr.schedule.code;
        data.bus = ovr.bus.code;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/update-schedule-bus-override",
            data: data,
            success: function (res) {
                if (res.status == 1) {                        
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    getScheduleBusOverride();
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
}

function cancelBusTypeException() {
    if ($("#bus-type-over-exp").hasClass('ui-dialog-content')) {
        $('#bus-type-over-exp').dialog('destroy');
    }
    $('#bus-type-over-exp').hide();
    $('#bus-type-exp-date').val('');
    $('#bus-type-exp-action').hide();
    $('.inp_error').removeClass('inp_error');
    $('#bus-type-exp-day').find("input[name='bus-type-exp-day']").each(function (i) {
        $(this).attr("checked", "checked");
        $(this).parent().addClass('active');
    });
}

function viewBusTypeException(code){
    $('.'+code).toggle('slow');
}

function getEnRouteBooking(code){
    var data = {};
    data.code = $('#sch_code').val();
    $('#en_route').html(loading_small);
    $("html, body").animate({scrollTop: 150}, "slow");
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-en-route-booking",
        data: data,
        success: function (res) {
            if (res) {
                $('#en_route').html(res);
            } else {
                $('#en_route').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
        }
    });
}
    
function enRouteBookingDialog(code) {
    $('#en-route-booking-dialog').css('background', '#fff');
    $('#en-route-booking-dialog').removeClass('hide');
    $('#en-route-booking-dialog').show();
    $('#en-route-booking-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('.inp_error').removeClass('inp_error');
    $('#en-route-action-state').hide();

    if(code != undefined){
        var enroute = _.find(enRouteData, function (o) { return o.code == code; });
        $('#en_route_stage').val('');
        $('#hid-en-route-code').val(enroute.code);
        $('#en_route_type').val(enroute.enRouteType.code);
        $('#en_route_release').val(enroute.releaseMinutes);
        var stages = [];
        $(enroute.stageList).each(function (i , item) {
            stages.push(item.fromStation.code + '-' + item.toStation.code);
        });
        $('#en_route_stage').multiselect('select', stages);
        $("input[name='enroute_day_of_week']").each(function (i) {
            if (enroute.dayOfWeek[i] == 1) {
                $(this).attr("checked", "checked");
                $(this).parent().addClass('active');
            } else {
                $(this).removeAttr("checked");
                $(this).parent().removeClass('active');
            }
        });
    } else {
        $('#en_route_stage').multiselect('deselectAll', false);
        $('#en_route_stage').multiselect('updateButtonText');
        $('#en_route_type').val('');
        $('#en_route_release').val('');
        $('#hid-en-route-code').val('');
        $("input[name='enroute_day_of_week']").each(function (i) {
            $(this).attr("checked", "checked");
            $(this).parent().addClass('active');
        });
    }
}

function closeEnRouteBookingDialog() {
    $('#en-route-booking-dialog').dialog('destroy');
    $('#en-route-booking-dialog').hide();
}

function saveEnRouteBooking() {
    var data = {};
    data.activeFlag = 1;
    data.code = $('#hid-en-route-code').val();
    data.schedule = $('#sch_code').val();        
    data.enRouteType = $('#en_route_type').val();
    data.releaseMinutes = $('#en_route_release').val();
    data.dayOfWeek = $("input[name='enroute_day_of_week']").map(function () {
        return +$(this).is(':checked');
    }).get().join('');
    data.stageList = [];

    $($('#en_route_stage').val()).each(function(i, stage) {
        data.stageList.push({
            fromStation : {
                code : stage.split('-')[0]
            },
            toStation   : {
                code : stage.split('-')[1]
            }
        });
    });

    var err = 0;
    $('.inp_error').removeClass('inp_error');
    if (data.stageList.length == 0) {
        $('.en_route_stage').addClass('inp_error');
        err++;
    }
    if (data.enRouteType == '') {
        $('#en_route_type').addClass('inp_error');
        err++;
    }
    if (data.releaseMinutes == '') {
        $('#en_route_release').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#en-route-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#en-route-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#en-route-action-state').show();
        return false;
    } else {
        $('#en-route-action-state').removeClass('alert-danger').addClass('alert-success');
        $('#en-route-action-state').hide();
    }

    $('#en-route-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#en-route-action-state').html(loading_small);
    $('#en-route-action-state').show();

    $.ajax({
        type: "POST",
        url: "schedules/update-en-route-booking",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                $('#en-route-action-state').removeClass('alert-danger');
                $('#en-route-action-state').addClass('alert-success');
                $('#en-route-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    closeEnRouteBookingDialog();
                    getEnRouteBooking();
                }, 2000);
            } else {
                $('#en-route-action-state').addClass('alert-danger');
                $('#en-route-action-state').html(res.errorDesc);
            }
        }
    });
}

function deleteEnRoute(code) {
    if (confirm('Do you want to delete this En Route?')) {
        var data = _.find(enRouteData, function (o) { return o.code == code; });
        data.activeFlag = 2;
        data.schedule = data.schedule.code;
        data.enRouteType = data.enRouteType.code;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/update-en-route-booking",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        getEnRouteBooking();
                    }, 2000);
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
        });
    }
}

function saveRoutesFareSchedulesv2() {
    var data = {};
    var err = 0;
    $('.inp_error').removeClass('inp_error');
    
    var fromStation = $.trim( $('#routes-schedules-from').val());
    var toStation = $.trim( $('#routes-schedules-to').val());
    var code = $.trim( $('#routes-code').val());
    
    if(fromStation == '') {
        $('#routes-schedules-from').addClass('inp_error');
        err++;
    }
    if(toStation == '') {
        $('#routes-schedules-to').addClass('inp_error');
        err++;
    }
    if(code == '' && $('#routefare-' + fromStation + toStation).length) {
        $('#routes-schedules-from').addClass('inp_error');
        $('#routes-schedules-to').addClass('inp_error');
        $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">Selected Route already added</div>');
        setContentHeight('#wizard_form');
        return false;
    }
    
    data.schcode = $('#sch_code').val();
    data.fares = $('.routes-fare.input').map(function() {
	var $this = $(this);
        var fare = $this.val();
        if(fare == '' || fare <= 0) {
            $this.addClass('inp_error');
            err++;
        }
        var obj = {};
        obj.busSeatType = {};
        obj.busSeatType.code = $this.data('seattype');
        obj.activeFlag = 1;
        obj.fare = fare;
        obj.fromStation = fromStation;
        obj.toStation = toStation;
        obj.code = $this.data('code');
	return obj;
    }).get();
    
    if (err > 0) {
        $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        setContentHeight('#wizard_form');
        return false;
    }

    $('#routes-fare-sch-loading').html(loading_small);
    
    $.ajax({
        type: "POST",
        url: "schedules/update-routes-fare-schedules-v2",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                load_routes(res.data.code);
                $('#routes-fare-sch-loading').html('<div class="alert alert-success">Your request has been completed successfully.</div>');
                window.setTimeout(function () {
                    $('#routes-fare-sch-loading').html('');
                }, 1500);
            } else {
                $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
            }
            setContentHeight('#wizard_form');
        }
    });
}

function deleteScheduleRouteFare(code) {
    if (!confirm('Do you want to delete this Route & Fare?')) {
        return
    }
    var fares = JSON.parse($('#routefare-' + code).val() || []);
    
    $.each(fares || [], function(i) {
        fares[i].activeFlag = 2;
    });
    
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    
    var data = {};
    data.fares = fares;
    data.schcode = $('#sch_code').val();
    
    $.ajax({
        type: "POST",
        url: "schedules/update-routes-fare-schedules-v2",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                load_routes();
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
            } else {
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Sorry!"
                });
            }
            window.setTimeout(function () {
                loading_overlay.hide();
            }, 1500);
        }
    });
}

function editScheduleRouteFare(code) {                    
    var $this = $(event.target);
    var fares = JSON.parse($('#routefare-' + code).val() || []);
    
    $('.routes-fare.input').val('').attr('data-code', '');
    $('.inp_error').removeClass('inp_error');
    $.each(fares || [], function(i, row) {
        $('.routes-fare.input[data-seattype="' + row.busSeatType.code + '"]')
                .val(row.fare)
                .attr('data-code', row.code);
    });
    
    $('#sch-route-fare-table tr:not(#routes-schedules-form-div)').show();
    $this.parents('tr:first').hide().after($('#routes-schedules-form-div'));
    
    $('#routes-schedules-from').val($('#routefare-' + code).data('from'));
    $('#routes-schedules-to').val($('#routefare-' + code).data('to'));
    $('#routes-code').val(code);
    
    if(!$('#routes-schedules-form-div').is(':visible')) {
        $('#routes-schedules-form-div').fadeToggle(function () {
            $(this).find('.routes-fare:first').trigger('focus');
            setContentHeight('#wizard_form');
        });
    } else {
        $('#routes-schedules-form-div').find('.routes-fare:first').trigger('focus');
    }
}

function getScheduleSectors() {
    var data = {};
    var $sectorselect = $('#sch-basic-sector').select2();
    
    $.ajax({
        type: "POST",
        url: "schedules/get-user-sectors",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {
                var options = $.map(res.data || [], function(val) {
                    return new Option(val.name, val.code);
                });
                $sectorselect.html(options);
                
                $.each($('#sch-basic-sector-val').data('value') || [], function (i, val) {
                    $sectorselect.find('[value=' + val.code + ']').prop('selected', true);
                });
                $sectorselect.select2();
            } else {
                $sectorselect.html('');
            }
        }
    });
}