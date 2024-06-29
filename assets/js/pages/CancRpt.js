// CancRpt.js
(function($){
Type.registerNamespace('CancRpt');CancRpt.Trip=function(){}
CancRpt.Trip.prototype={status:0,datetime:null,data:null}
CancRpt.colModel=function(){}
CancRpt.colModel.prototype={name:null,index:null,width:0,align:null,formatter:null,editable:null,summaryType:null,summaryTpl:null,dataType:null}
CancRpt.Datum=function(){}
CancRpt.Datum.prototype={tripCode:null,bus:null,schedule:null,tripStatus:null}
CancRpt.Bus=function(){}
CancRpt.Bus.prototype={categoryCode:null,displayName:null,totalSeatCount:0}
CancRpt.TripStatus=function(){}
CancRpt.TripStatus.prototype={code:null,name:null,activeFlag:0}
CancRpt.Schedule=function(){}
CancRpt.Schedule.prototype={code:null,name:null,activeFrom:null,activeTo:null,dayOfWeek:null,mobileTicketFlag:null,serviceNumber:null,displayName:null,pnrStartCode:null,boardingReportingMinitues:0,serviceTax:0}
CancRpt.ReportData=function(){}
CancRpt.ReportData.prototype={status:0,datetime:null,data:null}
CancRpt.CancRptPg=function(){}
CancRpt.CancRptPg.rndrTripChartDD=function(b,dataList){var $0=(b!=null);b=b||[];if(dataList!=null){if(dataList.length!==1){b.add('<option value="-1">Select</option>');}for(var $1=0;$1<dataList.length;$1++){b.add('<option value="');b.add(dataList[$1].tripCode);b.add('">');b.add(dataList[$1].schedule.displayName+' '+dataList[$1].schedule.serviceNumber+' '+dataList[$1].bus.displayName);b.add('</option>');}}return ($0)?'':b.join('');}
CancRpt.CancRptMgr=function(){}
CancRpt.CancRptMgr.start=function(){CancRpt.CancRptMgr.$0=$('#ContainerDiv');CancRpt.CancRptMgr.$6();}
CancRpt.CancRptMgr.$6=function(){var $0=Date.get_now().format('yyyy-MM-dd');var $1={};$1.type='Get';$1.url='report/cancellation_trip_list?tripDate='+$0;$1.success=function($p1_0,$p1_1,$p1_2){
var $1_0=$.parseJSON($p1_0.toString());var $1_1=$1_0.data;CancRpt.CancRptMgr.$2=$('#tripDropId');CancRpt.CancRptMgr.$2.html(CancRpt.CancRptPg.rndrTripChartDD(null,$1_1));$('#tripDropId'). multiselect({selectedList: 1,header: true});CancRpt.CancRptMgr.$1=$('#cancelGrid');CancRpt.CancRptMgr.$3=$('#btnExport');CancRpt.CancRptMgr.$4=$('#date_from');CancRpt.CancRptMgr.$5=$('#date_to');$('#date_from').datepicker({format: 'yyyy-mm-dd',autoclose: true,changeMonth: true,});$('#date_to').datepicker({format: 'yyyy-mm-dd',todayHighlight: true,startDate: '-0m',maxDate: '+365D'});};$1.error=function($p1_0,$p1_1,$p1_2){
alert('Error');};CancRpt.CancRptMgr.unRegisterEvent();CancRpt.CancRptMgr.registerEvent();$.ajax($1);}
CancRpt.CancRptMgr.$7=function(){var $0='RPT001';var $1=$('#date_from').val();var $2=$('#date_to').val();var $3={};$3.type='Get';$3.url=String.format('report/get-report-data?reportCode={0}&fromDate={1}&toDate={2}',$0,$1,$2);$3.success=function($p1_0,$p1_1,$p1_2){
var $1_0=$.parseJSON($p1_0.toString());var $1_1=$('#groupById').val();var $1_2=$1_1.split(',');var $1_3=$1_0.data;var $1_4=$1_3[0];var $1_5=CancRpt.CancRptMgr.$9($1_3);var $1_6=CancRpt.CancRptMgr.$8($1_3);if($1_3!=null&&$1_3.length>0){RenderGrid(myData, colModal, colNames, 'Cacnellation report', groupBy, '#cancelRptTable'  );}else{var $1_7=$('#noRecFoundDiv');$1_7.show();}};$3.error=function($p1_0,$p1_1,$p1_2){
alert('Error');};CancRpt.CancRptMgr.unRegisterEvent();CancRpt.CancRptMgr.registerEvent();$.ajax($3);}
CancRpt.CancRptMgr.$8=function($p0){var $0=$p0[0];var $1=[];for(var $2=0;$2<$0.length;$2++){var $3=new CancRpt.colModel();$3.name=$0[$2];$3.index=$0[$2];$1.add($3);if($3.name.toUpperCase()==='cancellationcharge'||$3.name.toUpperCase()==='refundamount'){$3.formatter='float';$3.summaryType='sum';$3.align='right';}}return $1;}
CancRpt.CancRptMgr.$9=function($p0){var $0=$p0[0];var $1=[];for(var $2=1;$2<$p0.length;$2++){var $3={};for(var $4=0;$4<$p0[$2].length;$4++){$3[$0[$4]]=$p0[$2][$4];}$1.add($3);}return $1;}
CancRpt.CancRptMgr.registerEvent=function(){CancRpt.CancRptMgr.$0.on('change',function($p1_0){
});CancRpt.CancRptMgr.$0.on('click',function($p1_0){
if($p1_0.target.id==='btnSubmit'){CancRpt.CancRptMgr.$7();}});}
CancRpt.CancRptMgr.unRegisterEvent=function(){CancRpt.CancRptMgr.$0.unbind();}
CancRpt.Trip.registerClass('CancRpt.Trip');CancRpt.colModel.registerClass('CancRpt.colModel');CancRpt.Datum.registerClass('CancRpt.Datum');CancRpt.Bus.registerClass('CancRpt.Bus');CancRpt.TripStatus.registerClass('CancRpt.TripStatus');CancRpt.Schedule.registerClass('CancRpt.Schedule');CancRpt.ReportData.registerClass('CancRpt.ReportData');CancRpt.CancRptPg.registerClass('CancRpt.CancRptPg');CancRpt.CancRptMgr.registerClass('CancRpt.CancRptMgr');CancRpt.CancRptMgr.$0=null;CancRpt.CancRptMgr.$1=null;CancRpt.CancRptMgr.$2=null;CancRpt.CancRptMgr.$3=null;CancRpt.CancRptMgr.$4=null;CancRpt.CancRptMgr.$5=null;})(jQuery);// This script was generated using Script# v0.7.4.0
