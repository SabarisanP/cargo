//! CancellationRpt.debug.js
//

(function($) {


Type.registerNamespace('CancellationRpt');

////////////////////////////////////////////////////////////////////////////////
// CancellationRpt.Bus

CancellationRpt.Bus = function CancellationRpt_Bus() {
    /// <field name="categoryCode" type="String">
    /// </field>
    /// <field name="displayName" type="String">
    /// </field>
    /// <field name="totalSeatCount" type="Number" integer="true">
    /// </field>
    /// <field name="name" type="String">
    /// </field>
}
CancellationRpt.Bus.prototype = {
    categoryCode: null,
    displayName: null,
    totalSeatCount: 0,
    name: null
}


////////////////////////////////////////////////////////////////////////////////
// CancellationRpt.Schedule

CancellationRpt.Schedule = function CancellationRpt_Schedule() {
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
    /// <field name="mobileTicketFlag" type="Number" integer="true">
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
CancellationRpt.Schedule.prototype = {
    code: null,
    name: null,
    activeFrom: null,
    activeTo: null,
    dayOfWeek: null,
    mobileTicketFlag: 0,
    serviceNumber: null,
    displayName: null,
    pnrStartCode: null,
    boardingReportingMinitues: 0,
    serviceTax: 0
}


////////////////////////////////////////////////////////////////////////////////
// CancellationRpt.TripStatus

CancellationRpt.TripStatus = function CancellationRpt_TripStatus() {
    /// <field name="code" type="String">
    /// </field>
    /// <field name="name" type="String">
    /// </field>
    /// <field name="activeFlag" type="Number" integer="true">
    /// </field>
}
CancellationRpt.TripStatus.prototype = {
    code: null,
    name: null,
    activeFlag: 0
}


////////////////////////////////////////////////////////////////////////////////
// CancellationRpt.Datum

CancellationRpt.Datum = function CancellationRpt_Datum() {
    /// <field name="tripCode" type="String">
    /// </field>
    /// <field name="bus" type="CancellationRpt.Bus">
    /// </field>
    /// <field name="schedule" type="CancellationRpt.Schedule">
    /// </field>
    /// <field name="tripStatus" type="CancellationRpt.TripStatus">
    /// </field>
}
CancellationRpt.Datum.prototype = {
    tripCode: null,
    bus: null,
    schedule: null,
    tripStatus: null
}


////////////////////////////////////////////////////////////////////////////////
// CancellationRpt.Trip

CancellationRpt.Trip = function CancellationRpt_Trip() {
    /// <field name="status" type="Number" integer="true">
    /// </field>
    /// <field name="datetime" type="String">
    /// </field>
    /// <field name="data" type="Array" elementType="Datum">
    /// </field>
}
CancellationRpt.Trip.prototype = {
    status: 0,
    datetime: null,
    data: null
}


////////////////////////////////////////////////////////////////////////////////
// CancellationRpt.CancellationRpt

CancellationRpt.CancellationRpt = function CancellationRpt_CancellationRpt() {
}
CancellationRpt.CancellationRpt.inputParamRender = function CancellationRpt_CancellationRpt$inputParamRender(b, dataList) {
    /// <param name="b" type="Array">
    /// </param>
    /// <param name="dataList" type="Array" elementType="Datum">
    /// </param>
    /// <returns type="String"></returns>
    var parentBuffer = (b != null);
    b = b || [];
    b.add('<div><div class="form-group col-md-3"><label class="sr-only" for="date_from">From Date</label><div class="input-group"><input type="text" name="date_from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From"><span class="input-group-addon"><i class="fa fa-calendar"></i></span></div></div><div class="form-group col-md-3"><label class="sr-only" for="date_to">To Date</label><div class="input-group"><input type="text" name="date_to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To"><span class="input-group-addon"><i class="fa fa-calendar"></i></span></div></div><table rules="all" cellspacing="0" border="0" id="Table1" width="100%"><tbody><tr><td>Trip name:</td><td><select id="tripDropId">');
    if (dataList != null) {
        if (dataList.length !== 1) {
            b.add('<option value="-1">Select</option>');
        }
        for (var idx = 0; idx < dataList.length; idx++) {
            b.addRange([ '<option value="', dataList[idx].tripCode, '">', dataList[idx].schedule.name, '</option>' ]);
        }
    }
    b.add('</select></td></tr></tbody></table></div>$(\'#date_from\').datepicker({ // todayHighlight: true, format: \'yyyy-mm-dd\', autoclose: true, changeMonth: true, }).on(\'changeDate\', function(e) { var fDate = new Date(e.date); var end = new Date(fDate.setDate(fDate.getDate() + 365)); $(\'#date_to\').datepicker(\'setStartDate\', e.date); $("#date_to").datepicker("setEndDate", end) }); $(\'#date_to\').datepicker({ todayHighlight: true, startDate: \'-0m\', format: \'yyyy-mm-dd\', maxDate: "+365D", autoclose: true }).on(\'changeDate\', function(e) { $(\'#date_from\').datepicker(\'setEndDate\', e.date) });');
    return (parentBuffer) ? '' : b.join('');
}


////////////////////////////////////////////////////////////////////////////////
// CancellationRpt.CancellationRptMgr

CancellationRpt.CancellationRptMgr = function CancellationRpt_CancellationRptMgr() {
    /// <field name="_cntDiv" type="jQueryObject" static="true">
    /// </field>
}
CancellationRpt.CancellationRptMgr.start = function CancellationRpt_CancellationRptMgr$start() {
    CancellationRpt.CancellationRptMgr._cntDiv = $('#ContainerDiv');
    CancellationRpt.CancellationRptMgr._getCancellationReport();
}
CancellationRpt.CancellationRptMgr._getCancellationReport = function CancellationRpt_CancellationRptMgr$_getCancellationReport() {
    var curDate = Date.get_now().format('yyyy-MM-dd');
    var option = {};
    option.type = 'Get';
    option.url = 'report/cancellation_trip_list?tripDate=' + curDate;
    option.success = function(data, status, request) {
        var tripList = $.parseJSON(data.toString());
        var dataList = tripList.data;
        CancellationRpt.CancellationRptMgr._cntDiv.html(CancellationRpt.CancellationRpt.inputParamRender(null, dataList));
    };
    option.error = function(data, status, ex) {
        alert('Error');
    };
    CancellationRpt.CancellationRptMgr.registerEvent();
    $.ajax(option);
}
CancellationRpt.CancellationRptMgr.registerEvent = function CancellationRpt_CancellationRptMgr$registerEvent() {
    CancellationRpt.CancellationRptMgr._cntDiv.on('change click', function(e) {
        if (e.target.id === 'tripDropId') {
            CancellationRpt.CancellationRptMgr._cancellationRptRender();
        }
    });
}
CancellationRpt.CancellationRptMgr._cancellationRptRender = function CancellationRpt_CancellationRptMgr$_cancellationRptRender() {
    CancellationRpt.CancellationRptMgr._cntDiv.html('Cancellation Rpt testing.');
}


CancellationRpt.Bus.registerClass('CancellationRpt.Bus');
CancellationRpt.Schedule.registerClass('CancellationRpt.Schedule');
CancellationRpt.TripStatus.registerClass('CancellationRpt.TripStatus');
CancellationRpt.Datum.registerClass('CancellationRpt.Datum');
CancellationRpt.Trip.registerClass('CancellationRpt.Trip');
CancellationRpt.CancellationRpt.registerClass('CancellationRpt.CancellationRpt');
CancellationRpt.CancellationRptMgr.registerClass('CancellationRpt.CancellationRptMgr');
CancellationRpt.CancellationRptMgr._cntDiv = null;
})(jQuery);

//! This script was generated using Script# v0.7.4.0
