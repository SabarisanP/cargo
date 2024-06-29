$(function() {
    $('.accordion-toggle').bind('click', function() {

    });
});
function busTypeDialog(code) { return;
    $('#back').show();
    $('#bus-type-dialog').show();
    $('#bus-type-dialog').dialog({
        autoOpen: true,
        height: 550,
        width: 1000,
        modal: true,
        resizable: false,
    });
    $(".ui-dialog-titlebar").hide()
    $('#bus-type-dialog').html('<br/><div align="center">' + loading_big + '</div><br/>');
    var data = {}
    if (_isdefined(code)) {
        data.code = code;
    }
    $.ajax({
        type: "POST",
        url: base_url + "config/get-bustype-category",
        data: data,
        success: function(response) {
            $('#bus-type-dialog').html(response);
            $('.buslayout', '#bus-type-dialog').busLayout();
            if (data.code != '' && data.code != undefined) {
                $('.nxt').trigger('click');
                $('#sel_layout').prop('disabled', true);
                $('#sel_climate').prop('disabled', true);
                $('#sel_chase').prop('disabled', true);
                $('#sel_make').prop('disabled', true);
                $('#sel_seatype').prop('disabled', true);
                $('#back').hide();
            }
        }
    });
}

function init_busmp_edit() {
    $('.buslayout', '#bus-type-dialog').busLayout();
    if (bus_code != '' && bus_code != undefined) {
        $('.nxt').trigger('click');
        $('#sel_layout').prop('disabled', true);
        $('#sel_climate').prop('disabled', true);
        $('#sel_chase').prop('disabled', true);
        $('#sel_make').prop('disabled', true);
        $('#sel_seatype').prop('disabled', true);
        $('#back').hide();
    }
}

function deletebusType(code) {
    if (confirm('Do you want to delete this bustype?')) {
        var data = {};
        data.code = code;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-bustype",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#bs-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
                        if ($('#accordion > .panel-info').not('.hide').html() == undefined) {
                            $('.well').show();
                        }
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
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}

function statusbusType(code, name, obj) {

    var data = {};
    data.name = name;
    data.code = code;
    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/status-bustype",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('#bs_edt_' + code).hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $('#bs_edt_' + code).show();
                    $(obj).find('.fa').removeClass('fa-check').addClass('fa-times').attr('title', 'Click to disable');//1
                }
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
            window.setTimeout(function() {
                loading_overlay.hide();
            }, 2000);
        }
    })

}

/* row, col, */
$.fn.busLayout = function(options) {

    $('#low_select').hide();
    //alert('sd')
    var defaults = {rows: 6, cols: 15};
    var opts = $.extend(defaults, options);
    var o = $.meta ? $.extend({}, opts, $$.data()) : opts;
    var ele = $(this);
    $(ele).append('<table width="350" align="center" id="buslayout-selectable-container"><td class="lty" align="center"><strong>Lower</strong></td><tr><td class="buslayout-container br_bus"></tr></table>');
    $('.buslayout-container', ele).append('<ul class="ui-selectable" id="buslayout-selectable"></ul>');
    var r = 1;

    while (r <= o.rows) {
        var c = 1;
        while (c <= o.cols) {
            var h = '<li class="ui-state-default ui-selectee l1-' + r + '-' + c + '"  id="' + r + ',' + c + '">';
            h += '</li>';
            $('#buslayout-selectable', ele).append(h);
            c++;
        }
        r++;
    }

    $(ele).append('<br>');
    $(ele).append('<table width="350" align="center" id="buslayout-selectable-container-double" class="hide"><td class="lty" align="center"><strong>Upper</strong></td><tr><td class="buslayout-container-double br_bus"></tr></table>');
    $('.buslayout-container-double', ele).append('<ul class="ui-selectable" id="buslayout-selectable-double"></ul>');
    var r = 1;
    while (r <= o.rows) {
        var c = 1;
        while (c <= o.cols) {
            var h = '<li class="ui-state-default ui-selectee l2-' + r + '-' + c + '" id="' + r + ',' + c + '">';
            h += '</li>';
            $('#buslayout-selectable-double', ele).append(h);
            c++;
        }
        r++;
    }
    $('.lty').hide();

    $("#buslayout-selectable").bind("mousedown", function(e) {
        e.metaKey = true;
    }).selectable();

    $("#buslayout-selectable-double").bind("mousedown", function(e) {
        e.metaKey = true;
    }).selectable();
    if (bustypelayer != null && bustypelayer != '') {
        $.each(bustypelayer, function(keys, values) {
            $('.l' + values.layer + '-' + values.rowPos + '-' + values.colPos).addClass('ui-selected');
        });
    }
    $('#continue', ele).click(function() {

        var auto_set = false;
        $('#buslayout-selectable li', ele).each(function() {

            $(this).addClass('ui-large');
            if ($(this).hasClass('ui-selected')) {
                if ($(this).find('#buslayout-seat-meta1').length === 0) {
                    var h = '';
                    //h+= '<div id="buslayout-seat-meta" class="popover top hide"><div class="arrow"></div>';
                    h += '<div id="buslayout-seat-meta1">';
                    h += '<input class="buslayout-seat-name" type="text" name="name_' + $(this).attr('id') + '" id="seat_name" value="" onblur="buslayout_validate_seatname(this)" />';
                    // h += '<select id="bl_sel_seatname" onchange=""><option value="SS" selected="selected">SS</option><option value="SL">SL</option></select>';

                    h += '<select id="bl_sel_seatname">';
                    $.each(busseattype, function(key, vals) {
                        h += "<option value='" + vals.code + "'";

                        h += ">" + vals.code + "</option>";
                    });
                    h += '</select>'
                    h += '</div>';

                    $(this).append(h);
                }
                $(this).find('#buslayout-seat-meta1').show();
            } else {
                $(this).addClass('ui-unselected');
            }
        });


        $('#back').show();
        $('#back').removeClass('hide');


    });
    if (bustypelayer != null && bustypelayer != '') {
        $.each(bustypelayer, function(keys, values) {
            if (values.layer == 2) {
                $('#sel_layer').val(2).trigger('change');
            }
        });
    }
    $('#back').click(function() {
        $('.buylayout_error').removeClass('buylayout_error');
        $('#low_select').hide();
        $('#up_select').hide();
        $('#test_upper').hide();
        $('#test_lower').hide();

        $('#sel_layer').prop('disabled', false);
        $("#buslayout-selectable").selectable({disabled: false});
        $("#buslayout-selectable-double").selectable({disabled: false});

        $('#buslayout-selectable-container-double').css({"left": "0px"});

        $('#buslayout-selectable-double .ui-large').css({"height": "20px"});
        $('#buslayout-selectable .ui-large').css({"height": "20px"});


        $('#buslayout-selectable-container,#buslayout-selectable-container-double').attr("width", "350");
        $('#buslayout-selectable li', ele).each(function() {
            $(this).removeClass('ui-large');
            $(this).removeClass('ui-unselected');
            $(this).find('#buslayout-seat-meta1').hide();
        });
        $('#buslayout-selectable-double li', ele).each(function() {
            $(this).removeClass('ui-large');
            $(this).removeClass('ui-unselected');
            $(this).find('#buslayout-seat-meta2').hide();
        });
        $('.nxt').show();
        $(this).hide();
        $('.save').hide();
    });

}
function buttonSelection() {

    if ($('#sel_layer').val() == 1) {

        if ($('#buslayout-selectable li.ui-selected').length > 0) {
            $('#bustype-state').removeClass('alert-success').removeClass('alert-danger').removeClass('hide');
            $('#bustype-state').html('');
            $('#bustype-state').hide();
        } else {
            $('#bustype-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#bustype-state').html('Please select atleast one seat');
            $('#bustype-state').show();
            return false;
        }
    }

    if ($('#sel_layer').val() == 2) {
        if ($('#buslayout-selectable li.ui-selected').length > 0) {
            $('#bustype-state').removeClass('alert-success').removeClass('alert-danger').removeClass('hide');
            $('#bustype-state').html('');
            $('#bustype-state').hide();
        } else {
            $('#bustype-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#bustype-state').html('Please select atleast one lower seat');
            $('#bustype-state').show();
            return false;
        }
        if ($('#buslayout-selectable-double li.ui-selected').length > 0) {
            $('#bustype-state').removeClass('alert-success').removeClass('alert-danger').removeClass('hide');
            $('#bustype-state').html('');
            $('#bustype-state').hide();
        } else {
            $('#bustype-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#bustype-state').html('Please select atleast one upper seat');
            $('#bustype-state').show();
            return false;
        }
    }

    $('#sel_layer').prop('disabled', true);
    $("#buslayout-selectable").selectable({disabled: true});
    $("#buslayout-selectable-double").selectable({disabled: true});

    $("#buslayout-selectable").css({"opacity": "1"});
    $("#buslayout-selectable-double").css({"opacity": "1"});
    if ($('#sel_layer').val() == 2) {
        $('#up_select').show();
    }
    $('#low_select').show();

    $('#test_upper').show();
    $('#test_lower').show();

    var ele = $('.buslayout');
    var ts = $('#continue');
    var auto_set = false;
    $('#buslayout-selectable li', ele).each(function() {
        $(this).addClass('ui-large');
        if ($(this).hasClass('ui-selected')) {

            if ($(this).find('#buslayout-seat-meta1').length === 0) {
                var idcl = $(this).attr('id').replace(",", "-");
                var h = '';
                //h+= '<div id="buslayout-seat-meta" class="popover top hide"><div class="arrow"></div>';
                h += '<div id="buslayout-seat-meta1">';
                h += '<input class="buslayout-seat-name la1' + idcl + '" type="text" name="name_' + $(this).attr('id') + '" id="seat_name" value="" onblur="buslayout_validate_seatname(this)" />';
                h += '<input type="hidden" name="rows_cols" value="' + $(this).attr('id') + '" />';
                h += '<select id="bl_sel_seatname" class="upper_bus" name="seatname">';
                $.each(busseattype, function(key, vals) {
                    h += "<option value='" + vals.code + "'";

                    h += ">" + vals.code + "</option>";
                });
                h += '</select>'
                h += '</div>';


                $(this).append(h);
            }
            $(this).find('#buslayout-seat-meta1').show();
        } else {
            $(this).addClass('ui-unselected');
        }
    });

    $('#buslayout-selectable-double li', ele).each(function() {
        $(this).addClass('ui-large');
        if ($(this).hasClass('ui-selected')) {
            if ($(this).find('#buslayout-seat-meta2').length === 0) {
                var idcl = $(this).attr('id').replace(",", "-");
                var h = '';
                //h+= '<div id="buslayout-seat-meta" class="popover top hide"><div class="arrow"></div>';
                h += '<div id="buslayout-seat-meta2">';
                h += '<input class="buslayout-seat-name la2' + idcl + '" type="text" name="sname_' + $(this).attr('id') + '" id="seat_name" value="" onblur="buslayout_validate_seatname(this)" />';
                h += '<input type="hidden" name="rows_cols2" value="' + $(this).attr('id') + '" />';
                h += '<select id="bl_sel_seatname" class="lower_bus" name="seatname2">';
                $.each(busseattype, function(key, vals) {
                    h += "<option value='" + vals.code + "'";

                    h += ">" + vals.code + "</option>";
                });
                h += '</select>';
                h += '</div>';

                $(this).append(h);
            }
            $(this).find('#buslayout-seat-meta2').show();
        } else {
            $(this).addClass('ui-unselected');
        }
    });
    if (bustypelayer != null && bustypelayer != '') {
        $.each(bustypelayer, function(keys, values) {
            var html = '<input type="hidden" class="code-id" name="l' + values.layer + '-' + values.rowPos + '-' + values.colPos + '" value="' + values.code + '" />';
            $(html).insertAfter('.la' + values.layer + '' + values.rowPos + '-' + values.colPos);
            $('.la' + values.layer + '' + values.rowPos + '-' + values.colPos).val(values.seatName);
            $('.la' + values.layer + '' + values.rowPos + '-' + values.colPos).parent().find('select').val(values.busSeatType.code);
        });
    }


    $("#buslayout-selectable").bind("mousedown", function(e) {
        $(this).addClass('ui-selected');
    }).selectable();


    $('#buslayout-selectable-container,#buslayout-selectable-container-double').attr("width", "1027");
    //
    $('#buslayout-selectable-container-double').css({"position": "relative", "left": "50px"});
    // $('#buslayout-selectable-container,#buslayout-selectable-container-double').css({"position": "relative", "left": "50px"});

    $('#back').show();
    $('#back').removeClass('hide');

    $('.nxt').hide();
    $('.save').show();
    $('.save').removeClass('hide');

    // Select upper 





    $('.upper_bus').hide();
    $('#buslayout-selectable-double .ui-large').css({"height": "23px"});
    $('#buslayout-selectable-double .buslayout-seat-name').css({"border": "0px solid #CCCCCC"});

    $('.lower_bus').hide();
    $('#buslayout-selectable .ui-large').css({"height": "23px"});
    $('#buslayout-selectable .buslayout-seat-name').css({"border": "0px solid #CCCCCC"});

    $('#test_upper').click(function() {
        $('.lower_bus').show();
        $('#buslayout-selectable-double .ui-large').css({"height": "50px"});
        $('#buslayout-selectable-double .buslayout-seat-name').css({"border": "1px solid #CCCCCC"});

    });
    $('#test_lower').click(function() {
        $('.upper_bus').show();
        $('#buslayout-selectable .ui-large').css({"height": "50px"});
        $('#buslayout-selectable .buslayout-seat-name').css({"border": "1px solid #CCCCCC"});
        $('#up_select').removeClass('up_sel_bs').addClass('up_sel');
    });


    $('#upper_option').on('change', function() {
        $('.lower_bus').val('');
        $('.lower_bus').val(this.value);
    });

    $('#lower_option').on('change', function() {
        $('.upper_bus').val('');
        $('.upper_bus').val(this.value);
    });


}
function saveBusType() {
    var data = {}
    data.code = $('#bus_code').val();
    data.activeFlag = $('#bus_status').val();
    data.rcs = $('input[name="rows_cols"]').serializeArray();
    data.seatname = $('select[name="seatname"]').serializeArray();
    data.busname = $('#txt_bus_name').val();
    data.layout = $('#sel_layout').val();
    data.climate = $('#sel_climate').val();
    data.chase = $('#sel_chase').val();
    data.make = $('#sel_make').val();
    data.seatype = $('#sel_seatype').val();
    data.layer = $('#sel_layer').val();
    data.sid = new Array();
    data.code_id = $('.code-id').serializeObject();
    var err = 0;
    if ($('#txt_bus_name').val() == '') {
        $('#txt_bus_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_bus_name').removeClass('inp_error');
    }

    if ($('#sel_layout').val() == '') {
        $('#sel_layout').addClass('inp_error');
        err++;
    } else {
        $('#sel_layout').removeClass('inp_error');
    }

    if ($('#sel_climate').val() == '') {
        $('#sel_climate').addClass('inp_error');
        err++;
    } else {
        $('#sel_climate').removeClass('inp_error');
    }

    if ($('#sel_chase').val() == '') {
        $('#sel_chase').addClass('inp_error');
        err++;
    } else {
        $('#sel_chase').removeClass('inp_error');
    }

    if ($('#sel_make').val() == '') {
        $('#sel_make').addClass('inp_error');
        err++;
    } else {
        $('#sel_make').removeClass('inp_error');
    }

    if ($('#sel_seatype').val() == '') {
        $('#sel_seatype').addClass('inp_error');
        err++;
    } else {
        $('#sel_seatype').removeClass('inp_error');
    }

    if ($('#sel_layer').val() == '') {
        $('#sel_layer').addClass('inp_error');
        err++;
    } else {
        $('#sel_layer').removeClass('inp_error');
    }


    $('#buslayout-selectable li.ui-selected .buslayout-seat-name').each(function() {
        if ($(this).val() == '') {
            $(this).parent().parent().addClass('buylayout_error');
            return false;
        }
        else {
            $(this).parent().parent().removeClass('buylayout_error');
        }
    });
    $('#buslayout-selectable-double li.ui-selected .buslayout-seat-name').each(function() {
        if ($(this).val() == '') {
            $(this).parent().parent().addClass('buylayout_error');
            return false;
        } else {
            $(this).parent().parent().removeClass('buylayout_error');
        }
    });
    if ($('#sel_layer').val() == 2) {

        data.rcs2 = $('input[name="rows_cols2"]').serializeArray();
        data.seatname2 = $('select[name="seatname2"]').serializeArray();
        data.sid2 = new Array();
        $.each(data.rcs2, function(keys, values) {
            if ($.trim( $('input[name="sname_' + values.value + '"]').val() ) == '') {
                $('input[name="sname_' + values.value + '"]').addClass('buylayout_error');
                err++;
            } else {
                data.sid2[keys] = $.trim( $('input[name="sname_' + values.value + '"]').val() );
            }
        });
    }
    $.each(data.rcs, function(keys, values) {
        if ($.trim( $('input[name="name_' + values.value + '"]').val() ) == '') {
            $('input[name="name_' + values.value + '"]').addClass('buylayout_error');
            err++;
        } else {
            data.sid[keys] = $.trim( $('input[name="name_' + values.value + '"]').val() );
        }
    });





    if (err > 0) {
        $('#bustype-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#bustype-state').html('Please enter/select the values in the field that are marked in red');
        $('#bustype-state').show();
        return false;
    } else {
        $('#bustype-state').removeClass('alert-success').removeClass('alert-danger').removeClass('hide');
        $('#bustype-state').html('');
        $('#bustype-state').hide();
    }
    if ($('#sel_layer').val() == 2) {
        var namelist = $.merge($.merge([], data.sid), data.sid2);
    } else {
        var namelist = data.sid;
    }
    var resutlArray = uniqueArray(namelist);
    if (!(jQuery(resutlArray).size() === jQuery(namelist).size())) {
        $('#bustype-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#bustype-state').html('Seat name is duplicated.');
        $('#bustype-state').show();
        return false;
    }

    // $('#form-btn-bustype').hide();
    $('#bustype_loading').html(loading_popup);
    $('#bustype_loading').show();
    $('#form-btn-bustype').hide();

    $.ajax({
        type: "POST",
        url: base_url + "config/save-bustype",
        data: data,
        dataType: 'json',
        success: function(response) {
            if (response.status) {
                $('#bustype_loading').html('');
                $('#bustype_loading').hide();
                $('#bustype-state').removeClass('alert-danger').addClass('alert-success');
                $('#bustype-state').show();

                $('#bustype-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    //cancelBusType();
                    window.location.href="#config/bus-type";
                    checkURL();
                }, 3000);
            } else {
                $('#bustype_loading').html('');
                $('#bustype_loading').hide();
                $('#form-btn-bustype').show();
                $('#bustype-state').removeClass('alert-success').addClass('alert-danger');
                $('#bustype-state').show();
                $('#bustype-state').html(response.errorDesc);
            }


        }
    });


}
function buslayout_validate_seatname(inp) {
    cur_val = $(inp).val();
    cur_name = $(inp).attr('name');
    //$(inp).parent().removeClass('buylayout_error');
    $('#buslayout-selectable li.ui-selected .buslayout-seat-name').each(function() {
        if ($(this).val() != '' && cur_val === $(this).val() && cur_name !== $(this).attr('name')) {
            $(inp).parent().parent().addClass('buylayout_error');
            $(this).parent().parent().addClass('buylayout_error');
        } else {
            //$(this).parent().parent().removeClass('buylayout_error');
        }

    });
}
var auto_set = false;
function bus_layout_autoset_type(inp) {
    cur_val = $(inp).val();
    if (!auto_set) {
        $('#buslayout-selectable li.ui-selected #bl_sel_seatname').each(function() {
            $(this).val(cur_val);
        });
        auto_set = true;
    }
}
function cancelBusType() {
    $('#bus-type-dialog').dialog('destroy');
    $('#bus-type-dialog').hide();
}
function view_layer(obj) {
    if ($(obj).val() == 2) {
        $('#buslayout-selectable-container-double').removeClass('hide');
        $('.lty').show();
    } else {
        $('#buslayout-selectable-container-double').addClass('hide');
        $('.lty').hide();
        $('#up_select').hide();
    }
}
