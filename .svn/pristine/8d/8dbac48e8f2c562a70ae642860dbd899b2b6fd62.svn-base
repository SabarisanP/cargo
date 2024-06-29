$(document).ready(function () {
    getSnapshot();

    if ($('.sales-summary-date').length > 0 && $('.pay-sales-summary-date').length > 0) {
        getSalesSummary(moment().format('YYYY-MM-DD'))
    }

    getUserBalance();
    getVendorUserBalance();
    getBranchBalance();
    getActiveBanners();
    getBranchPerformanceView();
    getBalanceTiles();

    $('#quick-find-term').keyup(function (event) {
        if (event.which == 13) {
            event.preventDefault();
            initQuickFindLR();
        }
    });

    if ($('.sales-summary-date').length || $('.pay-sales-summary-date').length) {
        let dayStart = 5, date_series = [];
        for (let i = dayStart; i > 0; i--) {
            let date = moment().subtract(i, 'd');
            date_series.push('<span class="label label-default date_series" id="bdg-' + i + '" style="margin-right: 1px;cursor: pointer;" onclick="getSalesSummary(\'' + date.format('YYYY-MM-DD') + '\', ' + i + ', \'org\')">' + date.format('ddd DD-MMM') + '</span>');
        }
        date_series.push('<span class="label label-success date_series" id="bdg-0" style="margin-right: 1px;cursor: pointer;" onclick="getSalesSummary(\'' + moment().format('YYYY-MM-DD') + '\', 0, \'org\')">Today</span>');

        $('.sales-summary-date, .pay-sales-summary-date').html(date_series);
    }

    
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
    let i;
    $('.date_series').on('click', function () {
        let id = $(this).attr('id');
        i = parseInt(id.substring(4)); // Extract the 'i' value from the id
    });

    $('input[type="radio"]').on('change', function () {
        if ($(this).attr('id') === 'opt1') {
            $('input[value="Nmt"]').prop('checked', true);
            $('input[name="exptyperadio"]').val('Nmt');
            window.setTimeout(function () {
                var val = i;
                if (typeof val === 'undefined') {
                    getSalesSummary(moment().subtract(i, 'd').format('YYYY-MM-DD'), 0, 'org');
                } else {
                    getSalesSummary(moment().subtract(i, 'd').format('YYYY-MM-DD'), val, 'org');
                }
            }, 1000);
        }
        if ($(this).attr('id') === 'opt2') {
            $('input[value="Fmt"]').prop('checked', true);
            $('input[name="exptyperadio"]').val('Fmt');
            window.setTimeout(function () {
                var val = i;
                if (typeof val === 'undefined') {
                    getSalesSummary(moment().subtract(i, 'd').format('YYYY-MM-DD'), 0, 'org');
                } else {
                    getSalesSummary(moment().subtract(i, 'd').format('YYYY-MM-DD'), val, 'org');
                }
            }, 1000);
        }
    });


    var sshot_opt = getCookie('b_sshot') ? getCookie('b_sshot') : 'pie';
    if (sshot_opt == 'pie') {
        $("#option1").attr('checked', 'checked');
        $("#option1").parent().addClass('active');
    } else {
        $("#option2").attr('checked', 'checked');
        $("#option2").parent().addClass('active');
    }

    $("#useropt input:radio").change(function () {
        $('#dash-user-bal').addClass('hide');
        $('#dash-vendor-bal').addClass('hide');

        if ($(this).val() == "user") {
            $('#dash-user-bal').removeClass('hide');
            setCookie('user_bal_opt', 'user', 15);
            // getUserBalance();
        } else {
            $('#dash-vendor-bal').removeClass('hide');
            setCookie('user_bal_opt', 'vendor', 15);
            // getVendorUserBalance();
        }
    });

    var usr_bal_opt = getCookie('user_bal_opt') ? getCookie('user_bal_opt') : 'user';
    if (usr_bal_opt == 'user') {
        $('#dash-vendor-bal').addClass('hide');
        $('#dash-user-bal').removeClass('hide');
        $("#user_bal_user").attr('checked', 'checked');
        $("#user_bal_user").parent().addClass('active');
        getUserBalance();
    } else {
        $('#dash-user-bal').addClass('hide');
        $('#dash-vendor-bal').removeClass('hide');
        $("#user_bal_vendor").attr('checked', 'checked');
        $("#user_bal_vendor").parent().addClass('active');
        getVendorUserBalance();
    }
});

function getRandomizer(bottom, top) {
    return function () {
        return Math.floor(Math.random() * (1 + top - bottom)) + bottom;
    }
}
var feeds = '';
function getSnapshot() {

    // if( $('#summary_pie').length == 0 ) { return; }

    $('#summary_ptype').html('<div class="col-md-offset-5" style="padding-top:110px"><img src="' + base_url + 'assets/img/loaders/20.gif" /></div>');
    $('#summary_pie').html('<div class="col-md-offset-5" style="padding-top:110px"><img src="' + base_url + 'assets/img/loaders/20.gif" /></div>');
    $('#dash-to-load, #dash-to-unload, #dash-pending-inwards, #dash-to-delivery, #dash-demurrage, #dash-lr-missing').find('tbody').html('<tr><td colspan="2">' + loading_small + '</td></tr>');
    $.ajax({
        type: "POST",
        url: base_url + "widget-cargo/snapshot",
        dataType: 'json',
        success: function (result) {
            feeds = result;
            $('.snapshot-last-updated-at').html('(As on ' + moment(result.responsetime).format('hh:mm A') + ')');

            renderKeyValTable(result, 'TO_LOAD_COUNT', $('#dash-to-load tbody'));
            renderKeyValTable(result, 'TO_UNLOAD_COUNT', $('#dash-to-unload tbody'));
            renderKeyValTable(result, 'INWARDS_COUNT', $('#dash-pending-inwards tbody'));
            renderKeyValTable(result, 'TO_DELIVERY_COUNT', $('#dash-to-delivery tbody'));
            renderKeyValTable(result, 'DEMURRAGE_COUNT', $('#dash-demurrage tbody'));
            renderKeyValTable(result, 'MISSING_COUNT', $('#dash-lr-missing tbody'));
        }
    });
}

var chartfeeds = '';
function getSalesSummary(date, id, type) {

    $('.date_series').removeClass('label-success label-default').addClass('label-default');
    $('.pay_date_series').removeClass('label-success label-default').addClass('label-default');

    $('span #bdg-' + id).removeClass('label-default').addClass('label-success');
    $('span #pay-bdg-' + id).removeClass('label-default').addClass('label-success');

    var data = {};
    data.date = date;

    if ($('#opt1').is(':checked')) {
        data.exptyperadio = "Nmt";
        $('#opt1').click();
    } else {
        data.exptyperadio = "Fmt";
        $('#opt2').click();
    }
    $('#summary_pie').addClass('hide');
    $('#summary_table').addClass('hide');
    var sshot_opt = getCookie('b_sshot') ? getCookie('b_sshot') : 'pie';
    if (sshot_opt == 'pie') {
        $('#summary_pie').removeClass('hide');
    } else {
        $('#summary_table').removeClass('hide');
    }

    $('#summary_ptype').html('<div class="col-md-offset-5" style="padding-top:110px"><img src="' + base_url + 'assets/img/loaders/20.gif" /></div>');
    $('#summary_pie').html('<div class="col-md-offset-5" style="padding-top:110px"><img src="' + base_url + 'assets/img/loaders/20.gif" /></div>');
    $('#summary_table').html('<div class="col-md-offset-5" style="padding-top:110px"><img src="' + base_url + 'assets/img/loaders/20.gif" /></div>');
    $.ajax({
        type: "POST",
        url: base_url + "widget-cargo/get-sales-summary",
        dataType: 'json',
        data: data,
        success: function (res) {
            chartfeeds = res;

            var organization = [];
            if (res.organization) {
                $.each(res.organization, function (index, val) {
                    organization.push(val);
                })
            }

            var paymentType = [];
            if (res.paymentType) {
                $.each(res.paymentType, function (index, val) {
                    paymentType.push(val);
                })
            }

            var freightAmt = [];
            if (res.freightAmt) {
                $.each(res.freightAmt, function (index, val) {
                    freightAmt.push(val);
                })
            }

            $('.snapshot-last-updated-at').html('(As on ' + moment(res.responsetime).format('hh:mm A') + ')');

            if (_isdefined(organization)) {
                organization = _.sortBy(organization, 'y').reverse();
                drawBranchStats(_.slice(organization, 0, 20));

                //   table.
                $('#summary_table').html($('#tmpl_sshottable').html());
                var totalFrightAmt = 0;

                $.each(organization || {}, function (i, r) {
                    let freight = Number(r.y).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
                    totalFrightAmt += parseFloat(r.y); // Use parseFloat to ensure proper addition of numbers

                    $('#sstblbody').append('<tr>' +
                        '<td align="left">' + r.name + '</td>' +
                        '<td align="right">' + freight + '</td>' +
                        '</tr>');
                });

                if (totalFrightAmt > 0) {
                    let totalFreightFormatted = totalFrightAmt.toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });

                    $('#sstblbody').append('<tr>' +
                        '<td align="left"><b>Total</b></td>' +
                        '<td align="right"><b>' + totalFreightFormatted + '</b></td>' +
                        '</tr>');
                }

            } else {
                $('#summary_pie').html('<div class="col-md-offset-5" style="padding-top:110px">No details found</div>');
                $('#summary_table').html('<div class="col-md-offset-5" style="padding-top:110px">No details found</div>');
            }

            if (_isdefined(paymentType)) {
                drawPaymentTypeStats(paymentType);
            } else {
                $('#summary_ptype').html('<div class="col-md-offset-5" style="padding-top:110px">No details found</div>');
            }
        }
    });
}

function getUserBalance() {
    if ($('#dash-user-bal').length == 0) { return; }

    var data = {};
    data.type = 'USER';

    $('#dash-user-bal').html(loading_small);
    $.ajax({
        type: "POST",
        data: data,
        url: base_url + "widget-cargo/get-user-balance",
        dataType: 'html',
        success: function (result) {
            $('#dash-user-bal').html(result);
        }
    });
}

function getVendorUserBalance() {
    if ($('#dash-vendor-bal').length == 0) { return; }

    var data = {};
    data.type = 'VENDOR';

    $('#dash-vendor-bal').html(loading_small);
    $.ajax({
        type: "POST",
        data: data,
        url: base_url + "widget-cargo/get-user-balance",
        dataType: 'html',
        success: function (result) {
            $('#dash-vendor-bal').html(result);
        }
    });
}

function getBranchBalance() {
    if ($('#dash-branch-bal').length == 0) { return; }

    $('#dash-branch-bal').html(loading_small);
    $.ajax({
        type: "POST",
        url: base_url + "widget-cargo/get-branch-balance",
        dataType: 'html',
        success: function (result) {
            $('#dash-branch-bal').html(result);
        }
    });
}

function drawPaymentTypeStats(brn) {
    var tmpl = '<div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 cell"><div class="text-center count countsmall" id="trip_count">0</div><div class="text-center labeltxt"></div></div>';
    masterItems = [];

    $('#paytypecounts').removeClass('hide');
    $('.live-cells').html('');
    var total = 0;
    $.each(brn, function (name, count) {
        var ti = [count.y, count.name];
        masterItems.push(ti);

        var html = $(tmpl);
        $(html).find('.count').text(INRFormat(count.y));
        $(html).find('.labeltxt').text(count.name);
        total += count.y;
        $('.live-cells').append(html);
    });

    if (total > 0) {   //  show total cell.
        var html = $(tmpl);
        $(html).find('.count').text(INRFormat(total));
        $(html).find('.labeltxt').text('Total');
        $('.live-cells').append(html);
    }

    $('#summary_ptype').highcharts({
        chart: {
            type: "pie",
            renderTo: "",
            options3d: {
                enabled: "1", alpha: 45
            }
        },
        title: { text: "" },
        xAxis: { categories: [] },
        yAxis: {
            stackLabels: {
                enabled: true
            }, min: 0
        },
        tooltip: {
            shared: false,
            useHTML: true,
            percentageDecimals: 1,
            formatter: function () {
                return '<b>' + this.key + '</b> : Rs ' + INRFormat(this.y)
            }
        },
        series: [{
            name: '',
            data: brn
        }
        ],
        credits: { enabled: false },
        legend: { enabled: false },
        exporting: { enabled: false },
        tooltipPie: {
            pointFormat: "<b>{point.percentage}%</b>",
            percentageDecimals: 1
        },
        colors: ["#FF6040", "#A05030", "#D0B090", "#6600FF", "#64E572", "#FF9655", "#FFF263", "#6AF9C4"],
        export: "",
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: "pointer",
                dataLabels: {
                    enabled: true,
                    formatter: function () { return '<b>' + this.point.name + '</b> : ' + Math.round(this.percentage) + ' %'; },
                    showInLegend: true,
                    percentageDecimals: 1,
                    valueDecimals: 2
                },
                showInLegend: true,
                innerSize: "",
                depth: ""
            }
        }
    });
}

function drawBranchStats(org) {
    $('#summary_pie').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            type: 'category',
            labels: {
                rotation: -65,
                style: { fontWeight: 'bold' }
            },
            crosshair: false,
            reversed: false
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Freight',
                style: { fontWeight: 'bold' }
            }
        },
        tooltip: {
            formatter: function () {
                return this.key + '<br/><b>Rs ' + INRFormat(this.y) + '</b>'
            }
        },
        credits: { enabled: false },
        legend: { enabled: true },
        exporting: { enabled: false },
        colors: ["#FF6040", "#A05030", "#D0B090", "#6600FF", "#64E572", "#FF9655", "#FFF263", "#6AF9C4"],
        series: [{
            name: 'Bookings',
            data: org,
            dataSorting: { enabled: true, sortKey: org.name },
            dataLabels: {
                enabled: true,
                rotation: -90,
                color: '#000',
                align: 'left',
                shadow: false,
                formatter: function () {
                    return Number(this.y).toLocaleString('en-IN', { maximumFractionDigits: 2 });
                },
                y: -5
            }
        }]
    });
}

function initQuickFindLR() {
    $('#quick-find-term').removeClass('inp_error');
    var term = $.trim($('#quick-find-term').val());
    if (term.length < 3) {
        $('#quick-find-term').addClass('inp_error');
        return;
    }

    $('#dashboard-lr-list-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 150,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });

    $('#dashboard-lr-list-dialog').html(loading_small);

    var data = {};
    data.code = term;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/dashboard-lr-list",
        data: data,
        success: function (response) {
            try {
                json = JSON.parse(response);
                closeDashLrListDialog();
                getCargoDetails(json.data[0].code);
            } catch (e) {
                $('#dashboard-lr-list-dialog').html(response);
            }
        }
    });
}

function closeDashLrListDialog() {
    $('#dashboard-lr-list-dialog').dialog('destroy');
    $('#dashboard-lr-list-dialog').hide();
}

function renderKeyValTable(obj = {}, type, $tbody, inrformat) {
    var sum = 0;
    var To_qty = 0;
    $tbody.html('');

    if (type == 'MISSING_COUNT' && isNull(obj['MISSING_COUNT'])) {
        $('#dash-lr-missing-section').addClass('hide');
    }
    $.each(obj[type] || {}, function (k, v) {
        sum += v.value;
        To_qty += v.qty;
        if (inrformat) {
            v.value = Number(v.value).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
            v.qty = Number(v.qty).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
        }
        $tbody.append('<tr>' +
            '<td align="left"><a href="javascript:;" class="dash-report" onclick=\'showDashReportDialog("' + type + '", "' + v.code + '", "' + v.name + '")\'>' + v.name + '</a></td>' +
            '<td align="right">' + v.value + '</td>' + '<td align="right">' + v.qty + '</td>' +
            '</tr>');
    });

    if (!$tbody.find('tr').length) {
        $tbody.append('<tr>' +
            '<td colspan="2" align="center">No details found</td>' +
            '</tr>');
        return;
    }
    if (inrformat) {
        sum = Number(sum).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
    }

    $tbody.append('<tr>' +
        '<td class="sticky-row-bottom" align="left"><b>Total</b></td>' +
        '<td class="sticky-row-bottom" align="right"><b>' + sum + '</b></td>' + '<td class="sticky-row-bottom" align="right"><b>' + To_qty + '</b></td>'+
        '</tr>');
}

function showDashReportDialog(type, orgcode, orgname) {
    if (type == 'USER_BALANCE') {
        return;
    }
    $('#dashboard-report-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 150,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });

    $('#dashboard-report-dialog').html(loading_small);

    var cargoStatusCode = {};
    cargoStatusCode['TO_LOAD_COUNT'] = 'CB';
    cargoStatusCode['TO_UNLOAD_COUNT'] = 'CL';
    cargoStatusCode['TO_DELIVERY_COUNT'] = 'CUL';
    cargoStatusCode['MISSING_COUNT'] = 'CMS';
    cargoStatusCode['INWARDS_COUNT'] = 'INW';

    var data = {};
    data.toDate = 'NA';
    data.stationCode = 'NA';
    data.transitOrganizationCode = orgcode;
    data.transitOrganizationName = orgname;
    data.cargoStatusCode = cargoStatusCode[type] || 'NA';
    data.filterType = 'DETAILS';

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/dashboard-branch-stock-list",
        data: data,
        success: function (response) {
            $('#dashboard-report-dialog').html(response);
        }
    });
}

function closeDashReportDialog() {
    $('#dashboard-report-dialog').dialog('destroy');
    $('#dashboard-report-dialog').hide();
}

function getActiveBanners() {
    if ($('#dash-announcement').length == 0) { return; }

    $.ajax({
        type: "POST",
        url: base_url + "widget-cargo/get-active-banners",
        dataType: 'html',
        success: function (result) {
            var $response = $(result)
            $('#dash-announcement').html($response.find('#announcement-panel:has(.carousel-inner > .item)'));
            $('#dash-advertisement').html($response.find('#advertisement-panel:has(.carousel-inner > .item)'));
        }
    });
}

function closeSummaryReportDialog() {
    $('#dashboard-summary-dialog').dialog('destroy');
    $('#dashboard-summary-dialog').hide();
}

function vendorBookingSummary() {
    $('#dashboard-summary-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 100,
        width: $(window).width() - 250,
        modal: true,
        resizable: false
    });

    $('#dashboard-summary-dialog').html(loading_small);

    var data = {};

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "widget-cargo/vendor-booking-summary",
        data: data,
        success: function (response) {
            $('#dashboard-summary-dialog').html(response);
        }
    });
}

function branchBookingSummary(btn, date) {
    $('#dashboard-summary-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 100,
        width: $(window).width() - 250,
        modal: true,
        resizable: false
    });

    if (btn) {
        $(btn).siblings('.label-success').removeClass('label-success').addClass('label-default');
        $(btn).removeClass('label-default').addClass('label-success');
        $('#godown-summary-cont').html(loading_small);
    } else {
        $('#dashboard-summary-dialog').html(loading_small);
    }

    var data = {};
    data.date = date;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "widget-cargo/branch-booking-summary",
        data: data,
        success: function (response) {
            $('#dashboard-summary-dialog').html(response);
        }
    });
}

function godownBookingSummary() {
    $('#dashboard-summary-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 100,
        width: $(window).width() - 250,
        modal: true,
        resizable: false
    });

    $('#dashboard-summary-dialog').html(loading_small);

    var data = {};

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "widget-cargo/godown-booking-summary",
        data: data,
        success: function (response) {
            $('#dashboard-summary-dialog').html(response);
        }
    });
}

function showVendorReportDialog(vendorCode, vendorName) {
    $('#dashboard-report-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 150,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });

    $('#dashboard-report-dialog').html(loading_small);

    var data = {};
    data.vendorCode = vendorCode;
    data.vendorName = vendorName;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "widget-cargo/vendor-booking-list",
        data: data,
        success: function (response) {
            $('#dashboard-report-dialog').html(response);
        }
    });
}

function showBranchReportDialog(date, organizationCode, organizationName) {
    $('#dashboard-report-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 150,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });

    $('#dashboard-report-dialog').html(loading_small);

    var data = {};
    data.date = date;
    data.organizationCode = organizationCode;
    data.organizationName = organizationName;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "widget-cargo/branch-booking-list",
        data: data,
        success: function (response) {
            $('#dashboard-report-dialog').html(response);
        }
    });
}

function demurrageSummary() {
    $('#dashboard-summary-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 450,
        modal: true,
        resizable: false
    });

    var $html = $('#dash-demurrage-panel').clone();
    $html.find('.heading_b').append('<a class="align-right close-btn" onclick="closeSummaryReportDialog()" href="javascript:;"><i class="fa fa-times-circle ft_22"></i></a>');
    $('#dashboard-summary-dialog').html($html.html());
}

function getBranchPerformanceView() {
    if ($('#dash-brn-perf').length == 0) { return; }

    var data = {};

    $('#dash-brn-perf').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "widget-cargo/get-branch-performance",
        data: data,
        success: function (res) {
            $('#dash-brn-perf').html(res);
        }
    });
}

function getBalanceTiles() {
    if ($('#dash-expense-panel, #dash-dayclosing-cont').length == 0) {
        return;
    }

    var data = {};

    $('#dash-expense-cont, #dash-dayclosing-cont').html(loading_small);
    $.ajax({
        type: "POST",
        data: data,
        url: base_url + "widget-cargo/get-branch-tiles",
        dataType: 'html',
        success: function (result) {
            var $html = $(result);

            $expense = $html.find('#dash-expense-panel-table');
            if ($expense.length) {
                $('#dash-expense-panel .last-updated-at').html($expense.data('last-updated'));
                $('#dash-expense-cont').html($expense);
            } else {
                $('#dash-expense-cont').html('No Records Found');
            }

            $dayclosing = $html.find('#dash-dayclosing-panel-table');
            if ($dayclosing.length) {
                $('#dash-dayclosing-panel .last-updated-at').html($dayclosing.data('last-updated'));
                $('#dash-dayclosing-cont').html($dayclosing);
            } else {
                $('#dash-dayclosing-cont').html('No Records Found');
            }
        }
    });
}