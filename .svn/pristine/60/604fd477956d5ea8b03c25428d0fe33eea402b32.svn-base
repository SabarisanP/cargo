// CancellationRpt.js
(function($){
Type.registerNamespace('CancellationRpt');CancellationRpt.Bus=function(){}
CancellationRpt.Bus.prototype={categoryCode:null,displayName:null,totalSeatCount:0,name:null}
CancellationRpt.Schedule=function(){}
CancellationRpt.Schedule.prototype={code:null,name:null,activeFrom:null,activeTo:null,dayOfWeek:null,mobileTicketFlag:0,serviceNumber:null,displayName:null,pnrStartCode:null,boardingReportingMinitues:0,serviceTax:0}
CancellationRpt.TripStatus=function(){}
CancellationRpt.TripStatus.prototype={code:null,name:null,activeFlag:0}
CancellationRpt.Datum=function(){}
CancellationRpt.Datum.prototype={tripCode:null,bus:null,schedule:null,tripStatus:null}
CancellationRpt.Trip=function(){}
CancellationRpt.Trip.prototype={status:0,datetime:null,data:null}
CancellationRpt.CancellationRpt=function(){}
CancellationRpt.CancellationRpt.inputParamRender=function(b,dataList){var $0=(b!=null);b=b||[];b.add('<div><div class="form-group col-md-3"><label class="sr-only" for="date_from">From Date</label><div class="input-group"><input type="text" name="date_from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From"><span class="input-group-addon"><i class="fa fa-calendar"></i></span></div></div><div class="form-group col-md-3"><label class="sr-only" for="date_to">To Date</label><div class="input-group"><input type="text" name="date_to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To"><span class="input-group-addon"><i class="fa fa-calendar"></i></span></div></div><table rules="all" cellspacing="0" border="0" id="Table1" width="100%"><tbody><tr><td>Trip name:</td><td><select id="tripDropId">');if(dataList!=null){if(dataList.length!==1){b.add('<option value="-1">Select</option>');}for(var $1=0;$1<dataList.length;$1++){b.addRange(['<option value="',dataList[$1].tripCode,'">',dataList[$1].schedule.name,'</option>']);}}b.add('</select></td></tr></tbody></table></div>$(\'#date_from\').datepicker({ // todayHighlight: true, format: \'yyyy-mm-dd\', autoclose: true, changeMonth: true, }).on(\'changeDate\', function(e) { var fDate = new Date(e.date); var end = new Date(fDate.setDate(fDate.getDate() + 365)); $(\'#date_to\').datepicker(\'setStartDate\', e.date); $("#date_to").datepicker("setEndDate", end) }); $(\'#date_to\').datepicker({ todayHighlight: true, startDate: \'-0m\', format: \'yyyy-mm-dd\', maxDate: "+365D", autoclose: true }).on(\'changeDate\', function(e) { $(\'#date_from\').datepicker(\'setEndDate\', e.date) });');return ($0)?'':b.join('');}
CancellationRpt.CancellationRptMgr=function(){}
CancellationRpt.CancellationRptMgr.start=function(){CancellationRpt.CancellationRptMgr.$0=$('#ContainerDiv');CancellationRpt.CancellationRptMgr.$1();}
CancellationRpt.CancellationRptMgr.$1=function(){var $0=Date.get_now().format('yyyy-MM-dd');var $1={};$1.type='Get';$1.url='report/cancellation_trip_list?tripDate='+$0;$1.success=function($p1_0,$p1_1,$p1_2){
var $1_0=$.parseJSON($p1_0.toString());var $1_1=$1_0.data;CancellationRpt.CancellationRptMgr.$0.html(CancellationRpt.CancellationRpt.inputParamRender(null,$1_1));};$1.error=function($p1_0,$p1_1,$p1_2){
alert('Error');};CancellationRpt.CancellationRptMgr.registerEvent();$.ajax($1);}
CancellationRpt.CancellationRptMgr.registerEvent=function(){CancellationRpt.CancellationRptMgr.$0.on('change click',function($p1_0){
if($p1_0.target.id==='tripDropId'){CancellationRpt.CancellationRptMgr.$2();}});}
CancellationRpt.CancellationRptMgr.$2=function(){CancellationRpt.CancellationRptMgr.$0.html('Cancellation Rpt testing.');}
CancellationRpt.Bus.registerClass('CancellationRpt.Bus');CancellationRpt.Schedule.registerClass('CancellationRpt.Schedule');CancellationRpt.TripStatus.registerClass('CancellationRpt.TripStatus');CancellationRpt.Datum.registerClass('CancellationRpt.Datum');CancellationRpt.Trip.registerClass('CancellationRpt.Trip');CancellationRpt.CancellationRpt.registerClass('CancellationRpt.CancellationRpt');CancellationRpt.CancellationRptMgr.registerClass('CancellationRpt.CancellationRptMgr');CancellationRpt.CancellationRptMgr.$0=null;})(jQuery);// This script was generated using Script# v0.7.4.0
