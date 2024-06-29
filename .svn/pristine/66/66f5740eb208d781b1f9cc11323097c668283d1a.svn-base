// AgentRpt.js
(function($){
Type.registerNamespace('AgentRpt');AgentRpt.UserData=function(){}
AgentRpt.UserData.prototype={status:0,datetime:null,data:null}
AgentRpt.Datum=function(){}
AgentRpt.Datum.prototype={code:null,name:null,activeFlag:0,username:null,lastname:null}
AgentRpt.AgentRptPg=function(){}
AgentRpt.AgentRptPg.rndrTripChartDD=function(b,dataList){var $0=(b!=null);b=b||[];if(dataList!=null){if(dataList.length!==1){b.add('<option value="-1">Select</option>');}for(var $1=0;$1<dataList.length;$1++){b.addRange(['<option value="',dataList[$1].code,'">',dataList[$1].name,'</option>']);}}return ($0)?'':b.join('');}
AgentRpt.AgentRptMgr=function(){}
AgentRpt.AgentRptMgr.start=function(){AgentRpt.AgentRptMgr.$0=$('#containerDiv');AgentRpt.AgentRptMgr.$6();}
AgentRpt.AgentRptMgr.$6=function(){var $0=Date.get_now().format('yyyy-MM-dd');var $1={};$1.type='Get';$1.url='config/getAgents';$1.success=function($p1_0,$p1_1,$p1_2){
var $1_0=$.parseJSON($p1_0.toString());var $1_1=$1_0.data;AgentRpt.AgentRptMgr.$2=$('#userdd');AgentRpt.AgentRptMgr.$2.html(AgentRpt.AgentRptPg.rndrTripChartDD(null,$1_1));AgentRpt.AgentRptMgr.$1=$('#agentGrid');AgentRpt.AgentRptMgr.$4=$('#date_from');AgentRpt.AgentRptMgr.$5=$('#date_to');$('#date_from').datepicker({format: 'yyyy-mm-dd',autoclose: true,changeMonth: true,});$('#date_to').datepicker({format: 'yyyy-mm-dd',todayHighlight: true,startDate: '-0m',maxDate: '+365D'});};$1.error=function($p1_0,$p1_1,$p1_2){
alert('Error');};AgentRpt.AgentRptMgr.unRegisterEvent();AgentRpt.AgentRptMgr.registerEvent();$.ajax($1);}
AgentRpt.AgentRptMgr.$7=function(){var $0='RQE9OA7';var $1=$('#date_from').val();var $2=$('#date_to').val();var $3={};$3.type='Get';$3.url=String.format('report/get-report-data?reportCode={0}&fromDate={1}&toDate={2}',$0,$1,$2);$3.success=function($p1_0,$p1_1,$p1_2){
var $1_0=$.parseJSON($p1_0.toString());var $1_1='transactionDate'.split(',');var $1_2=$1_0.data;var $1_3=$1_2[0];var $1_4=AgentRpt.AgentRptMgr.$8($1_2);if($1_2!=null&&$1_2.length>0){RenderGrid(myData,  'Agent report', groupBy, '#agentRptTable'  );}else{var $1_5=$('#noRecFoundDiv');$1_5.show();}};$3.error=function($p1_0,$p1_1,$p1_2){
alert('Error');};AgentRpt.AgentRptMgr.unRegisterEvent();AgentRpt.AgentRptMgr.registerEvent();$.ajax($3);}
AgentRpt.AgentRptMgr.$8=function($p0){var $0=$p0[0];var $1=[];for(var $2=1;$2<$p0.length;$2++){var $3={};for(var $4=0;$4<$p0[$2].length;$4++){$3[$0[$4]]=$p0[$2][$4];}$1.add($3);}return $1;}
AgentRpt.AgentRptMgr.registerEvent=function(){AgentRpt.AgentRptMgr.$0.on('change',function($p1_0){
});AgentRpt.AgentRptMgr.$0.on('click',function($p1_0){
if($p1_0.target.id==='btnSubmit'){AgentRpt.AgentRptMgr.$7();}});}
AgentRpt.AgentRptMgr.unRegisterEvent=function(){AgentRpt.AgentRptMgr.$0.unbind();}
AgentRpt.UserData.registerClass('AgentRpt.UserData');AgentRpt.Datum.registerClass('AgentRpt.Datum');AgentRpt.AgentRptPg.registerClass('AgentRpt.AgentRptPg');AgentRpt.AgentRptMgr.registerClass('AgentRpt.AgentRptMgr');AgentRpt.AgentRptMgr.$0=null;AgentRpt.AgentRptMgr.$1=null;AgentRpt.AgentRptMgr.$2=null;AgentRpt.AgentRptMgr.$3=null;AgentRpt.AgentRptMgr.$4=null;AgentRpt.AgentRptMgr.$5=null;})(jQuery);// This script was generated using Script# v0.7.4.0
