//! CancRpt.debug.js
//

(function($) {


Type.registerNamespace('CancRpt');

////////////////////////////////////////////////////////////////////////////////
// CancRpt.Trip

CancRpt.Trip = function CancRpt_Trip() {
    /// <field name="status" type="Number" integer="true">
    /// </field>
    /// <field name="datetime" type="Date">
    /// </field>
    /// <field name="data" type="Array" elementType="Datum">
    /// </field>
}
CancRpt.Trip.prototype = {
    status: 0,
    datetime: null,
    data: null
}


////////////////////////////////////////////////////////////////////////////////
// CancRpt.colModel

CancRpt.colModel = function CancRpt_colModel() {
    /// <field name="name" type="String">
    /// </field>
    /// <field name="index" type="String">
    /// </field>
    /// <field name="width" type="Number" integer="true">
    /// </field>
    /// <field name="align" type="String">
    /// </field>
    /// <field name="formatter" type="String">
    /// </field>
    /// <field name="editable" type="String">
    /// </field>
    /// <field name="summaryType" type="String">
    /// </field>
    /// <field name="summaryTpl" type="String">
    /// </field>
    /// <field name="dataType" type="String">
    /// </field>
}
CancRpt.colModel.prototype = {
    name: null,
    index: null,
    width: 0,
    align: null,
    formatter: null,
    editable: null,
    summaryType: null,
    summaryTpl: null,
    dataType: null
}


////////////////////////////////////////////////////////////////////////////////
// CancRpt.Datum

CancRpt.Datum = function CancRpt_Datum() {
    /// <field name="tripCode" type="String">
    /// </field>
    /// <field name="bus" type="CancRpt.Bus">
    /// </field>
    /// <field name="schedule" type="CancRpt.Schedule">
    /// </field>
    /// <field name="tripStatus" type="CancRpt.TripStatus">
    /// </field>
}
CancRpt.Datum.prototype = {
    tripCode: null,
    bus: null,
    schedule: null,
    tripStatus: null
}


////////////////////////////////////////////////////////////////////////////////
// CancRpt.Bus

CancRpt.Bus = function CancRpt_Bus() {
    /// <field name="categoryCode" type="String">
    /// </field>
    /// <field name="displayName" type="String">
    /// </field>
    /// <field name="totalSeatCount" type="Number" integer="true">
    /// </field>
}
CancRpt.Bus.prototype = {
    categoryCode: null,
    displayName: null,
    totalSeatCount: 0
}


////////////////////////////////////////////////////////////////////////////////
// CancRpt.TripStatus

CancRpt.TripStatus = function CancRpt_TripStatus() {
    /// <field name="code" type="String">
    /// </field>
    /// <field name="name" type="String">
    /// </field>
    /// <field name="activeFlag" type="Number" integer="true">
    /// </field>
}
CancRpt.TripStatus.prototype = {
    code: null,
    name: null,
    activeFlag: 0
}


////////////////////////////////////////////////////////////////////////////////
// CancRpt.Schedule

CancRpt.Schedule = function CancRpt_Schedule() {
    /// <field name="code" type="String">
    /// </field>
    /// <field name="name" type="String">
    /// </field>
    /// <field name="activeFrom" type="String">
    /// </field>
    /// <field name="activeTo" type="String">
    /// </field>
    /// <field name="dayOfWeek" type="String">
    /// </field>
    /// <field name="mobileTicketFlag" type="String">
    /// </field>
    /// <field name="serviceNumber" type="String">
    /// </field>
    /// <field name="displayName" type="String">
    /// </field>
    /// <field name="pnrStartCode" type="String">
    /// </field>
    /// <field name="boardingReportingMinitues" type="Number" integer="true">
    /// </field>
    /// <field name="serviceTax" type="Number">
    /// </field>
}
CancRpt.Schedule.prototype = {
    code: null,
    name: null,
    activeFrom: null,
    activeTo: null,
    dayOfWeek: null,
    mobileTicketFlag: null,
    serviceNumber: null,
    displayName: null,
    pnrStartCode: null,
    boardingReportingMinitues: 0,
    serviceTax: 0
}


////////////////////////////////////////////////////////////////////////////////
// CancRpt.ReportData

CancRpt.ReportData = function CancRpt_ReportData() {
    /// <field name="status" type="Number" integer="true">
    /// </field>
    /// <field name="datetime" type="Date">
    /// </field>
    /// <field name="data" type="Array">
    /// </field>
}
CancRpt.ReportData.prototype = {
    status: 0,
    datetime: null,
    data: null
}


////////////////////////////////////////////////////////////////////////////////
// CancRpt.CancRptPg

CancRpt.CancRptPg = function CancRpt_CancRptPg() {
}
CancRpt.CancRptPg.rndrTripChartDD = function CancRpt_CancRptPg$rndrTripChartDD(b, dataList) {
    /// <param name="b" type="Array">
    /// </param>
    /// <param name="dataList" type="Array" elementType="Datum">
    /// </param>
    /// <returns type="String"></returns>
    var parentBuffer = (b != null);
    b = b || [];
    if (dataList != null) {
        if (dataList.length !== 1) {
            b.add('<option value="-1">Select</option>');
        }
        for (var idx = 0; idx < dataList.length; idx++) {
            b.add('<option value="');
            b.add(dataList[idx].tripCode);
            b.add('">');
            b.add(dataList[idx].schedule.displayName + ' ' + dataList[idx].schedule.serviceNumber + ' ' + dataList[idx].bus.displayName);
            b.add('</option>');
        }
    }
    return (parentBuffer) ? '' : b.join('');
}


////////////////////////////////////////////////////////////////////////////////
// CancRpt.CancRptMgr

CancRpt.CancRptMgr = function CancRpt_CancRptMgr() {
    /// <field name="_cntDiv" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_cancelRptGrid" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_tripDrpDwn" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_btnExport" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_dateFrom" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_dateTo" type="jQueryObject" static="true">
    /// </field>
}
CancRpt.CancRptMgr.start = function CancRpt_CancRptMgr$start() {
    CancRpt.CancRptMgr._cntDiv = $('#search-panel');
    CancRpt.CancRptMgr._filterRender();
}
CancRpt.CancRptMgr._filterRender = function CancRpt_CancRptMgr$_filterRender() {
    var curDate = Date.get_now().format('yyyy-MM-dd');
    var option = {};
    option.type = 'Get';
    option.url = 'report/cancellation_trip_list?tripDate=' + curDate;
    option.success = function(data, status, request) {
        var tripList = $.parseJSON(data.toString());
        var dataList = tripList.data;
        CancRpt.CancRptMgr._tripDrpDwn = $('#tripDropId');
        CancRpt.CancRptMgr._tripDrpDwn.html(CancRpt.CancRptPg.rndrTripChartDD(null, dataList));
        //$('#tripDropId'). multiselect({selectedList: 1,header: true});
        CancRpt.CancRptMgr._cancelRptGrid = $('#cancelGrid');
        CancRpt.CancRptMgr._btnExport = $('#btnExport');
        CancRpt.CancRptMgr._dateFrom = $('#date_from');
        CancRpt.CancRptMgr._dateTo = $('#date_to');
        $('#date_from').datepicker({format: 'yyyy-mm-dd',autoclose: true,todayHighlight: true, changeMonth: true });
        $('#date_to').datepicker({format: 'yyyy-mm-dd', autoclose: true, todayHighlight: true, changeMonth: true, /*startDate: '-0m',maxDate: '+365D'*/});
    };
    option.error = function(data, status, ex) {
        alert('Error');
    };
    CancRpt.CancRptMgr.unRegisterEvent();
    CancRpt.CancRptMgr.registerEvent();
    $.ajax(option);
}
CancRpt.CancRptMgr._getCancellationReport = function CancRpt_CancRptMgr$_getCancellationReport() {
    var reportCode = 'RPT001';
    var fromDate = $('#date_from').val();
    var toDate = $('#date_to').val();
    var tripId = $('#tripDropId').val();
    var groupby = $('#groupById').val();
    $('#cancl-result-panel').removeClass('hidden');
    $('#jqloader').html(loading_big).show();
    $('#cancelGrid').hide();
    var option = {};
    option.type = 'Get';
    option.url = String.format('report/get-report-data?reportCode={0}&fromDate={1}&toDate={2}&tripCode={3}&groupBy={4}', reportCode, fromDate, toDate,tripId,groupby);
    option.success = function(data, status, request) {
        $('#jqloader').hide();
        $('#cancelGrid').show();
        var obj = $.parseJSON(data.toString());
        var groupByValue = $('#groupById').val();
        var groupBy = groupByValue.split(',');
        var rows = obj.data;
        var colNames = rows[0];
        var myData = CancRpt.CancRptMgr._getGridData(rows);
        var colModal = CancRpt.CancRptMgr._getGridMeta(rows);
        if (rows != null && rows.length > 0) {
            RenderGrid(myData, colModal, colNames, 'Cacnellation report', groupBy, '#cancelRptTable'  );
        }
        else {
            var noRecFound = $('#noRecFoundDiv');
            noRecFound.show();
        }
    };
    option.error = function(data, status, ex) {
        alert('Error');
    };
    CancRpt.CancRptMgr.unRegisterEvent();
    CancRpt.CancRptMgr.registerEvent();
    $.ajax(option);
}
CancRpt.CancRptMgr._getGridMeta = function CancRpt_CancRptMgr$_getGridMeta(rows) {
    /// <param name="rows" type="Array">
    /// </param>
    /// <returns type="Array"></returns>
    var colNames = rows[0];
    var gridmeta = [];
    for (var colIdx = 0; colIdx < colNames.length; colIdx++) {
        var cm = new CancRpt.colModel();
        cm.name = colNames[colIdx];
        cm.index = colNames[colIdx];
        gridmeta.add(cm);
        if (cm.name.toUpperCase() === 'cancellationcharge' || cm.name.toUpperCase() === 'refundamount') {
            cm.formatter = 'float';
            cm.summaryType = 'sum';
            cm.align = 'right';
        }
    }
    return gridmeta;
}
CancRpt.CancRptMgr._getGridData = function CancRpt_CancRptMgr$_getGridData(rows) {
    /// <param name="rows" type="Array">
    /// </param>
    /// <returns type="Array"></returns>
    var colNames = rows[0];
    var gridData = [];
    for (var rowIdx = 1; rowIdx < rows.length; rowIdx++) {
        var row = {};
        for (var colIdx = 0; colIdx < rows[rowIdx].length; colIdx++) {
            row[colNames[colIdx]] = rows[rowIdx][colIdx];
        }
        gridData.add(row);
    }
    return gridData;
}
CancRpt.CancRptMgr.registerEvent = function CancRpt_CancRptMgr$registerEvent() {
    CancRpt.CancRptMgr._cntDiv.on('change', function(e) {
    });
    CancRpt.CancRptMgr._cntDiv.on('click', function(e) {
        if (e.target.id === 'btnSubmit') {
            CancRpt.CancRptMgr._getCancellationReport();
        }
    });
}
CancRpt.CancRptMgr.unRegisterEvent = function CancRpt_CancRptMgr$unRegisterEvent() {
    CancRpt.CancRptMgr._cntDiv.unbind();
}


CancRpt.Trip.registerClass('CancRpt.Trip');
CancRpt.colModel.registerClass('CancRpt.colModel');
CancRpt.Datum.registerClass('CancRpt.Datum');
CancRpt.Bus.registerClass('CancRpt.Bus');
CancRpt.TripStatus.registerClass('CancRpt.TripStatus');
CancRpt.Schedule.registerClass('CancRpt.Schedule');
CancRpt.ReportData.registerClass('CancRpt.ReportData');
CancRpt.CancRptPg.registerClass('CancRpt.CancRptPg');
CancRpt.CancRptMgr.registerClass('CancRpt.CancRptMgr');
CancRpt.CancRptMgr._cntDiv = null;
CancRpt.CancRptMgr._cancelRptGrid = null;
CancRpt.CancRptMgr._tripDrpDwn = null;
CancRpt.CancRptMgr._btnExport = null;
CancRpt.CancRptMgr._dateFrom = null;
CancRpt.CancRptMgr._dateTo = null;
})(jQuery);

//! This script was generated using Script# v0.7.4.0
