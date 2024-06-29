//! AgentRpt.debug.js
//

(function($) {


Type.registerNamespace('AgentRpt');

////////////////////////////////////////////////////////////////////////////////
// AgentRpt.UserData

AgentRpt.UserData = function AgentRpt_UserData() {
    /// <field name="status" type="Number" integer="true">
    /// </field>
    /// <field name="datetime" type="Date">
    /// </field>
    /// <field name="data" type="Array" elementType="Datum">
    /// </field>
}
AgentRpt.UserData.prototype = {
    status: 0,
    datetime: null,
    data: null
}


////////////////////////////////////////////////////////////////////////////////
// AgentRpt.Datum

AgentRpt.Datum = function AgentRpt_Datum() {
    /// <field name="code" type="String">
    /// </field>
    /// <field name="name" type="String">
    /// </field>
    /// <field name="activeFlag" type="Number" integer="true">
    /// </field>
    /// <field name="username" type="String">
    /// </field>
    /// <field name="lastname" type="String">
    /// </field>
}
AgentRpt.Datum.prototype = {
    code: null,
    name: null,
    activeFlag: 0,
    username: null,
    lastname: null
}


////////////////////////////////////////////////////////////////////////////////
// AgentRpt.AgentRptPg

AgentRpt.AgentRptPg = function AgentRpt_AgentRptPg() {
}
AgentRpt.AgentRptPg.rndrTripChartDD = function AgentRpt_AgentRptPg$rndrTripChartDD(b, dataList) {
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
            b.addRange([ '<option value="', dataList[idx].code, '">', dataList[idx].name, '</option>' ]);
        }
    }
    return (parentBuffer) ? '' : b.join('');
}


////////////////////////////////////////////////////////////////////////////////
// AgentRpt.AgentRptMgr

AgentRpt.AgentRptMgr = function AgentRpt_AgentRptMgr() {
    /// <field name="_cntDiv" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_agentRptGrid" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_userdd" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_btnExport" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_dateFrom" type="jQueryObject" static="true">
    /// </field>
    /// <field name="_dateTo" type="jQueryObject" static="true">
    /// </field>
}
AgentRpt.AgentRptMgr.start = function AgentRpt_AgentRptMgr$start() {
    AgentRpt.AgentRptMgr._cntDiv = $('#containerDiv');
    AgentRpt.AgentRptMgr._filterRender();
}
AgentRpt.AgentRptMgr._filterRender = function AgentRpt_AgentRptMgr$_filterRender() {
    var curDate = Date.get_now().format('yyyy-MM-dd');
    var option = {};
    option.type = 'Get';
    option.url = 'config/getAgents';
    option.success = function(data, status, request) {
        var userData = $.parseJSON(data.toString());
        var dataList = userData.data;
        AgentRpt.AgentRptMgr._userdd = $('#userdd');
        AgentRpt.AgentRptMgr._userdd.html(AgentRpt.AgentRptPg.rndrTripChartDD(null, dataList));
        AgentRpt.AgentRptMgr._agentRptGrid = $('#agentGrid');
        AgentRpt.AgentRptMgr._dateFrom = $('#date_from');
        AgentRpt.AgentRptMgr._dateTo = $('#date_to');
        $('#date_from').datepicker({format: 'yyyy-mm-dd',autoclose: true,changeMonth: true,});
        $('#date_to').datepicker({format: 'yyyy-mm-dd',todayHighlight: true,startDate: '-0m',maxDate: '+365D'});
    };
    option.error = function(data, status, ex) {
        alert('Error');
    };
    AgentRpt.AgentRptMgr.unRegisterEvent();
    AgentRpt.AgentRptMgr.registerEvent();
    $.ajax(option);
}
AgentRpt.AgentRptMgr._getAgentReport = function AgentRpt_AgentRptMgr$_getAgentReport() {
    var reportCode = 'RQE9OA7';
    var fromDate = $('#date_from').val();
    var toDate = $('#date_to').val();
    var option = {};
    option.type = 'Get';
    option.url = String.format('report/get-report-data?reportCode={0}&fromDate={1}&toDate={2}', reportCode, fromDate, toDate);
    option.success = function(data, status, request) {
        var obj = $.parseJSON(data.toString());
        var groupBy = 'transactionDate'.split(',');
        var rows = obj.data;
        var colNames = rows[0];
        var myData = AgentRpt.AgentRptMgr._getGridData(rows);
        if (rows != null && rows.length > 0) {
            RenderGrid(myData,  'Agent report', groupBy, '#agentRptTable'  );
        }
        else {
            var noRecFound = $('#noRecFoundDiv');
            noRecFound.show();
        }
    };
    option.error = function(data, status, ex) {
        alert('Error');
    };
    AgentRpt.AgentRptMgr.unRegisterEvent();
    AgentRpt.AgentRptMgr.registerEvent();
    $.ajax(option);
}
AgentRpt.AgentRptMgr._getGridData = function AgentRpt_AgentRptMgr$_getGridData(rows) {
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
AgentRpt.AgentRptMgr.registerEvent = function AgentRpt_AgentRptMgr$registerEvent() {
    AgentRpt.AgentRptMgr._cntDiv.on('change', function(e) {
    });
    AgentRpt.AgentRptMgr._cntDiv.on('click', function(e) {
        if (e.target.id === 'btnSubmit') {
            AgentRpt.AgentRptMgr._getAgentReport();
        }
    });
}
AgentRpt.AgentRptMgr.unRegisterEvent = function AgentRpt_AgentRptMgr$unRegisterEvent() {
    AgentRpt.AgentRptMgr._cntDiv.unbind();
}


AgentRpt.UserData.registerClass('AgentRpt.UserData');
AgentRpt.Datum.registerClass('AgentRpt.Datum');
AgentRpt.AgentRptPg.registerClass('AgentRpt.AgentRptPg');
AgentRpt.AgentRptMgr.registerClass('AgentRpt.AgentRptMgr');
AgentRpt.AgentRptMgr._cntDiv = null;
AgentRpt.AgentRptMgr._agentRptGrid = null;
AgentRpt.AgentRptMgr._userdd = null;
AgentRpt.AgentRptMgr._btnExport = null;
AgentRpt.AgentRptMgr._dateFrom = null;
AgentRpt.AgentRptMgr._dateTo = null;
})(jQuery);

//! This script was generated using Script# v0.7.4.0
