function setContentHeight($wizard) {
    setTimeout(function() {
            var cur_height = $($wizard).children('.content').children('.body.current').outerHeight();
            $($wizard).find('.content').height(cur_height);
    },0);
}

function fillField(){
    var fval = $('#name_sch').val(); //service_sch ,service_sch
    $('#service_sch,#display_sch').val(fval);
}

$(document).ready(function(){
    var wizard_form = $('#wizard_form');
				// initialize wizard
                                if ($("#wizard_form").length) {
				wizard_form.steps({
					headerTag: 'h3',
					bodyTag: "section",
					enableAllSteps: true,
					titleTemplate: "<span class=\"number\">#index#.</span><span class=\"title\">#title#</span>",
					transitionEffect: "slideLeft",
					labels: {
						next: "Next Step <i class=\"fa fa-angle-right\"></i>",
						previous: "<i class=\"fa fa-angle-left\"></i> Previous Step",
						current: "",
						finish: "<i class=\"fa fa-check\"></i> Finished"
					},
					onStepChanging: function (event, currentIndex, newIndex) {
						var cursentStep = wizard_form.find('.content > .body').eq(currentIndex);
						// check input fields for errors
						cursentStep.find('[data-parsley-id]').each(function() {
							$(this).parsley().validate();
						});
                                                var result = '';
                                                $('.err-act').html('');
						if(currentIndex==0){
                                                    //service_sch,display_sch,name_sch,PNR_sch,RTB_sch
                                                         
                                                    var err = 0;
                                                    if($('#name_sch').val()==''){
                                                        $('#name_sch').addClass('parsley-error');
                                                        err++;
                                                    }else{
                                                        $('#name_sch').removeClass('parsley-error');
                                                    }
                                                    if($('#date_sch').val()==''){
                                                        $('#date_sch').addClass('parsley-error');
                                                        err++;
                                                    }else{
                                                        $('#date_sch').removeClass('parsley-error');
                                                    }
//                                                    if($('#service_sch').val()==''){
//                                                        $('#service_sch').addClass('parsley-error');
//                                                        err++;
//                                                    }else{
//                                                        $('#service_sch').removeClass('parsley-error');
//                                                    }
//                                                    if($('#display_sch').val()==''){
//                                                        $('#display_sch').addClass('parsley-error');
//                                                        err++;
//                                                    }else{
//                                                        $('#display_sch').removeClass('parsley-error');
//                                                    }
                                                    
                                                    if($('#PNR_sch').val()==''){
                                                        $('#PNR_sch').addClass('parsley-error');
                                                        err++;
                                                    }else{
                                                        $('#PNR_sch').removeClass('parsley-error');
                                                    }
                                                    if($('#RTB_sch').val()==''){
                                                        $('#RTB_sch').addClass('parsley-error');
                                                        err++;
                                                    }else{
                                                        $('#RTB_sch').removeClass('parsley-error');
                                                    }
                                                    if(!$("input[name='week']:checkbox:checked").length > 0){
                                                        $(".chk-btn").addClass('parsley-error');
                                                        err++
                                                    }else{
                                                        $(".chk-btn").removeClass('parsley-error');
                                                    }
                                                    if(err > 0){
                                                        $('.err-act').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
                                                        return false;
                                                    }
                                                    if($('#RTB_sch').val() > 59){
                                                        $('#RTB_sch').addClass('parsley-error');
                                                        $('.err-act').html('<div class="alert fl alert-danger">Please enter valid report time.</div>');
                                                        return false;
                                                    }
                                                    $('.err-act').html(loading_small);
                                                    
                                                    var dateSch = $('#date_sch').val();
                                                    var date = dateSch.split('|');
                                                    var data =  {}
                                                  
                                                    data.name = $('#name_sch').val();
                                                    data.serviceNumber = $('#service_sch').val();
                                                    data.activeFlag = $('#activeFlag').val();
                                                    data.mobileTicketFlag = $('#ph_bkg:checked').val()?1:0;
                                                    data.boardingReportingMinitues = $('#RTB_sch').val();
                                                    data.displayName = $('#display_sch').val();
                                                    data.pnrStartCode = $('#PNR_sch').val();
                                                    data.code = $('#sch_code').val();
                                                    data.activeTo = date[1];
                                                    data.activeFrom = date[0];
                                                    data.dayOfWeek = $("#weekdays :checkbox").map(function () {
                                                                        return +$(this).is(':checked');
                                                                     }).get(); 
                                                    
                                                       $.ajax({
                                                            type: "POST",
                                                            url: "schedules/update-schedules",
                                                            data: data,
                                                            dataType : 'json',
                                                            async: false,
                                                            success: function(res) {
                                                                 if(res.status==1){
                                                                   $('.err-act').html('');
                                                                   $('#sch_code').val(res.data.code);
                                                                   getSchedulesStation();
                                                                   setContentHeight('#wizard_form');
                                                                   return true;
                                                                 }else{
                                                                   $('.err-act').html('<div class="alert fl alert-danger">'+res.errorDesc+'</div>');
                                                                   return false;
                                                                 }
                                                            }
                                                      });
                                                      
                                                }
                                                if(currentIndex==1){
                                                  $('.err-act').html(loading_small);       
                                                    if(newIndex==0){
                                                        return true;
                                                    }
                                                    if($("input[name='station-sched-code']").val()==undefined || $("input[name='station-sched-code']").val()==''){
                                                          $('.err-act').html('<div class="alert fl alert-danger">Please add the stations.</div>');
                                                          return false;
                                                    }
                                                    var c = 0;
                                                    $("input[name='station-sched-code']").each(function(){
                                                       if($(this).val()!='') {
                                                           c++;
                                                       }
                                                    });
                                                    if(c < 2){
                                                          $('.err-act').html('<div class="alert fl alert-danger">Please add the stations.</div>');
                                                          return false;
                                                    }
                                                    $('.err-act').html('');
                                                }
                                                if(currentIndex==2){ 
                                                    $('.err-act').html(loading_small);
                                                    if(newIndex==1){
                                                        return true;
                                                    }
                                                    
                                                    var dateSch = $('#date_sch').val();
                                                    var date = dateSch.split('|');
                                                    var data =  {}
                                                    data.code = $('#sch_code').val();
                                                    data.activeTo = date[1];
                                                    data.activeFrom = date[0];
                                                    data.busCode = $('#bus-sch-code').val();
                                                    data.dayOfWeek = $("#weekdays :checkbox").map(function () {
                                                                        return +$(this).is(':checked');
                                                                     }).get(); 
                                                    data.amenities = $('#amenities').val();              
                                                    data.bustype = $('#bustype').val();
                                                    
                                                    if($('#bustype').val()==''){
                                                        $('#bustype').addClass('parsley-error');
                                                        $('.err-act').html('<div class="alert fl alert-danger">Please select the bus type</div>');
                                                        return false;
                                                    }else{
                                                        $('#bustype').removeClass('parsley-error');
                                                        $('.err-act').html('');
                                                    }
                                                    
                                                     $.ajax({
                                                            type: "POST",
                                                            url: "schedules/update-schedules-bustype",
                                                            data: data,
                                                            dataType : 'json',
                                                            async: false,
                                                            success: function(res) {
                                                                 if(res.status==1){
                                                                   $('.err-act').html('');
                                                                   setContentHeight('#wizard_form');
                                                                   //return true;
                                                                   $('#bus-sch-code').val(res.data.code);
                                                                   var html = "<option value='"+data.bustype+"' selected='selected'>"+$('#bustype').find(":selected").text()+"</option>";
                                                                   $('#bus-type-sch-seat').append(html);
                                                                 }else{
                                                                   $('.err-act').html('<div class="alert fl alert-danger">'+res.errorDesc+'</div>');
                                                                   return false;
                                                                 }
                                                            }
                                                      });
                                                      
                                                   load_routes();
                                                      
                                                }
                                                  if(currentIndex==3){ 
                                                    
                                                    if(newIndex==2){
                                                        return true;
                                                    }
                                                    var rout = 0;
                                                    $('.routes-map').each(function(i){
                                                        if($(this).val()!=''){
                                                            rout++;
                                                        }
                                                    })
                                                    var routesValue =$('.routes-map').html();
                                                   if(routesValue==undefined){
                                                       $('.err-act').html('<div class="alert fl alert-danger">Please add routes fare.</div>');
                                                       return false;
                                                   }else{
                                                       $('.err-act').html('');
                                                   }
                                                   
                                                      
                                                   cancelSchedules();
                                                      
                                                }
                                                if(currentIndex==4){ 
                                                    if(newIndex==3){
                                                        return true;
                                                    }
                                                  
                                                    //bookingschedules();
                                                    getSeatVisiblitySchedules();
                                                }
                                                if(currentIndex==5){ 
                                                    if(newIndex==4){
                                                        return true;
                                                    }
                                                    //bookingschedules();
                                                    bookingschedules();
                                                }
                                                 if(currentIndex==6){ 
                                                    if(newIndex==5){
                                                        return true;
                                                    }
                                                    reviewSchedules();
                                                    
                                                }
                                              
						// adjust wizard height
						
						
						if(cursentStep.find('.parsley-error').length) {
							return false;
						} else {
							return true;
						}
					},
					onStepChanged: function (event, currentIndex, priorIndex) {
						thisIndex = currentIndex;
						// adjust wizard height
						setContentHeight('#wizard_form');
					},
					onFinishing: function (event, currentIndex) {
						var cursentStep = wizard_form.find('.content > .body').eq(currentIndex);
						// check input fields for errors
						cursentStep.find('[data-parsley-id]').each(function() {
							$(this).parsley().validate();
						});
						
						// adjust wizard height
						setContentHeight('#wizard_form');
						
						if(cursentStep.find('.parsley-error').length) {
							return false;
						} else {
							return true;
						}
					},
					onFinished: function(event, currentIndex) {
						//alert("Submitted!");
                        //* uncomment the following line to submit form
                        //wizard_form.submit();
					}
				});
                                
                            }
                            //mr-r-40
                         $('a[href="#previous"]').parent().after('<li class="pull-left col-md-offset-1 err-act"></li>');
                         //$('a[href="#next"]').parent().addClass('mr-r-40');
                         $('input[name="date_sch"]').daterangepicker({
					buttonClasses: ['btn','btn-sm'],
                                        format: 'YYYY-MM-DD',
                                        separator: ' | '
			 });
                       
                         $( "#toggle-l" ).click(function() {          
                                
                             $( ".toggle-list" ).slideToggle( "slow" );
                                
                         });
                          $('.bs_switch').bootstrapSwitch('size', 'mini');
                             $('select.amenities').select2({
                                placeholder: "Select amenities",
                                escapeMarkup: function(markup) { return markup; }
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
    
   
                             
          
});
function stationSchedulesDialog(opt){
    $('#schedules-station-dialog').css('background','#fff');
    
    
    $('#schedules-station-dialog').removeClass('hide');
    $('#schedules-station-dialog').show();
    $('#schedules-station-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#station-sch-button').show();
    var h = $('#main_wrapper').height()+100;
    $('.ui-widget-overlay').height(h);
    //
    
    
    
     if(_isdefined(opt)){
         var stationtime = $('#station-sched-time-'+opt).val();
         $('#station_code').val(opt)
         $('#station-list-sch').val($('#station-sched-code-'+opt).val());
         $('#station-schedules-date').val($('#station-sched-daterange-'+opt).val());
         $('#station-sch-hours').val(stationtime);
     }
     $('#station-list-sch').select2({
	allowClear: true,
	placeholder: "Select..."
    });
      $("#station-sch-hours").ionRangeSlider({
				   type: "single",
				   step: 5,
				   postfix: "",
				   from: function(){
                                       if($('#station-sch-hours').val()!=''){
                                           return $('#station-sch-hours').val();
                                       }else{
                                           return 0;
                                       }
                                   },
                                   to:23.59,
                                   max: 1439,
                                   min:0,
                                  // hideMinMax: true,               // hide Min and Max fields
                                   hideFromTo: true,               // hide From and To fields
                                   onLoad: function(ui) { 
                                       $('.irs-min').html("0");
                                       $('.irs-max').html("23.59");
                                   },
                                   onChange: function(ui) {
                                          var hours = Math.floor(ui.fromNumber / 60);
                                          var minutes = ui.fromNumber - (hours * 60);                                          
                                          if(hours.toString().length == 1) hours = '0' + hours;
                                          if(minutes.toString().length == 1) minutes = '0' + minutes;
                                                
                                                $('#sch-time').html(hours+':'+minutes);
                                   },
				   hasGrid: false
				});
}

function cancelStationSchedulesDialog(){
    $('#schedules-station-dialog').dialog('destroy');
    $('#schedules-station-dialog').hide();
    $("#station-sch-hours").ionRangeSlider("remove");
    $('#station_code,#station-sch-hours').val('')
    $('#station-sch-loading').html('');
    $("#station-list-sch").select2("val", "");
}
function deleteStationschedules(opt){
    if(confirm('Do you want to delete this Station?')) {
        var dateSch = $('#date_sch').val();
        var date = dateSch.split('|');
        var data = {};        
        data.stationschedules = opt;
        data.code = $('#sch_code').val()
        data.activeTo = date[1];
        data.activeFrom = date[0];
        data.activeFlag = 2;
        data.stationcode = $('#station-sched-code-'+opt).val();
        data.stationtime = $('#station-sched-time-'+opt).val();
        
        data.dayOfWeek = $("#weekdays :checkbox").map(function () {
         return +$(this).is(':checked');
        }).get();
        
        var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
	 });
        $.ajax({
            type: "POST",
            dataType:'json',
            url: base_url+"schedules/delete-schedules-station",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                    $('.del-station-sch-'+opt).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                      loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		   }); 
                   $('#usr-viw-rslt').html('<div class="p_t_100"><div class="well well-large "> Click any of the user name to view more details.</div></div>');
                }else{                
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
function saveStationSchedules(){
    var dateSch = $('#date_sch').val();
    var date = dateSch.split('|');
    var data =  {}
    data.code = $('#sch_code').val();
    data.stationschedules = $('#station_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.activeFlag = $('#stationactiveFlag').val();
    data.stationcode = $('#station-list-sch').val();
    data.stationtime = $('#station-sch-hours').val();
    data.stationSequence = $('#stationSequence').val();
    data.dayOfWeek = $("#weekdays :checkbox").map(function () {
         return +$(this).is(':checked');
    }).get(); 
    if($('#station-schedules-date').val()!=''){
         var stationdate = $('#station-schedules-date').val();
         var sdate = stationdate.split('|');
         data.stationActiveTo = sdate[1];
         data.stationActiveFrom = sdate[0];
    }
    $('#station-sch-loading').html('');
    if($('#station-list-sch').val()==''){
        $('#station-sch-loading').html('<div class="alert pull-left alert-danger">Please select the station.</div>');
        return false;
    }
    var err=0;
    $('input[name="station-sched-code"]').each(function(){
      if($('#station-list-sch').val()==$(this).val() && (($('#station_code').val()=='') || $('#station_code').val()!=$(this).attr('data-code'))){
        err++;
      }
    });
    if(err > 0){
        $('#station-sch-loading').html('<div class="alert pull-left alert-danger">Already station added.</div>');
        return false;
    }
    
    $('#station-sch-loading').html(loading_small);
    $('#station-sch-button').hide();
    
    $.ajax({
            type: "POST",
            url: "schedules/update-schedules-station",
            data: data,
            dataType : 'json',
            success: function(res) {
                 if(res.status==1){
                     var code = res.data.code;
                   $('#station-sch-loading').html('');
                   cancelStationSchedulesDialog();
                   getSchedulesStation();
                   setContentHeight('#wizard_form');
                 }else{
                   $('#station-sch-loading').html('<div class="alert pull-left alert-danger">'+res.errorDesc+'</div>');
                   $('#station-sch-button').show();
                 }
            }
   });
    
}
function stationPointSchedulesDialog(code,scode,opt){
    $('#schedules-station-point-dialog').css('background','#fff');
    $('#schedules-station-point-dialog').removeClass('hide');
    $('#schedules-station-point-dialog').show();
    $('#schedules-station-point-dialog').dialog({
        autoOpen: true,
        height: 300,
        width: 400,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    
    $('#station_prt_code').val(code);
    $('#stationa_point_code,#station-point-sch').val('');
    var data = {}
    data.stationCode = code;
       $('#station-sch-loading').html(loading_small);
       $('#station-point-sch-button').hide();       
           $.ajax({
                    type: "POST",
                    url: "schedules/get-stationpoint-by-station-schedules",
                    data: data,
                    dataType : 'json',
                    async: false,
                    success: function(res) { 
                         if(res.status==1){
                             var html ='';
                             html +="<option value=''></option>";
                            $.each(res.data,function(keys1,cvalues){ 
                                 html +="<option value='"+cvalues.code+"'>"+cvalues.name+"</option>";
                            });
                            $('#station-point-sch').html(html);
                         }
                    }

           });
           if(_isdefined(opt)){ 
               var er = $('#station-point-code-'+opt).val();
               if(er!='' && er!=undefined){
                 $('#station-point-sch').val(er);
               }
               var st = $('#station-point-time-'+opt).val();
               
               if(st!='' && st!=undefined){
                    $('#point-station-sch-hours').val(st);               
                }
                
               $('#stationa_point_code').val(opt);
          } 
           
                     $("#point-station-sch-hours").ionRangeSlider({
				   type: "single",
				   step: 1,
				   postfix: "",
				   from: function(){
                                       if($('#point-station-sch-hours').val()!=''){
                                           return $('#point-station-sch-hours').val();
                                       }else{
                                           return 0;
                                       }
                                   },
                                   to:2,
                                   max: 120,
                                   min:0,
                                  // hideMinMax: true,               // hide Min and Max fields
                                   hideFromTo: true,               // hide From and To fields
                                   onLoad: function(ui) { 
                                       $('.irs-min').html("0");
                                       $('.irs-max').html("2");
                                   },
                                   onChange: function(ui) {
                                          var hours = Math.floor(ui.fromNumber / 60);
                                          var minutes = ui.fromNumber - (hours * 60);                                          
                                          if(hours.toString().length == 1) hours = '0' + hours;
                                          if(minutes.toString().length == 1) minutes = '0' + minutes;

                                                $('#sch-min-time').html(hours+':'+minutes);
                                                console.log($('#point-station-sch-hours').val());
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

function cancelStationPointSchedulesDialog(){
    $('#schedules-station-point-dialog').dialog('destroy');
    $('#schedules-station-point-dialog').hide();    
    $('#station-sch-loading').html('');
    $("#point-station-sch-hours").ionRangeSlider("remove");
    $('#station-point-sch,#station_prt_code,#station_point_code').val('');
    $("#ssstation-point-sch").select2("val", "");
}
function saveStationPointSchedulesDialog(){
    var dateSch = $('#date_sch').val();
    var date = dateSch.split('|');
    var data =  {}
    data.code = $('#sch_code').val();
    data.activeFlag   = $('#stationpointactiveFlag').val();
    data.station = $('#station_prt_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.stationtime = $('#station-sched-time-point-'+$('#station_prt_code').val()).val();
    data.minitues = $('#point-station-sch-hours').val();
    data.stationPoint = $('#station-point-sch').val();
    data.stationPointCode = $('#stationa_point_code').val();
    data.dayOfWeek = $("#weekdays :checkbox").map(function () {
         return +$(this).is(':checked');
    }).get(); 
    
    $('#station-point-sch-loading').html('');
    if(data.stationPoint==''){
        $('#station-point-sch-loading').html('<div class="alert pull-left alert-danger">Please select the station.</div>');
        return false;
    }
    
    var err=0;
    $('input[name="station-point-schedul-code"]').each(function(){      
      if($('#station-point-sch').val()==$(this).val() && (($('#stationa_point_code').val()!='' && $('#stationa_point_code').val()!=$(this).attr('data-code')) || $('#stationa_point_code').val()=='')){
        err++;
      }
    });
    if(err > 0){
        $('#station-point-sch-loading').html('<div class="alert pull-left alert-danger">Already station point added.</div>');
        return false;
    }
     
    $('#station-point-sch-loading').html(loading_small);
    //$('#station-sch-button').hide();
    
        $.ajax({
            type: "POST",
            url: "schedules/update-schedules-station-point",
            data: data,
            dataType : 'json',
            success: function(res) {
                 if(res.status==1){
                   $('#station-point-sch-loading').html('');
                    cancelStationPointSchedulesDialog();
                    getSchedulesStation();
                   setContentHeight('#wizard_form');
                 }else{
                   $('#station-sch-loading').html('<div class="alert pull-left alert-danger">'+res.errorDesc+'</div>');
                   $('#station-sch-button').show();
                 }
            }
   });
    
}
function stationpointSchedulesDelete(scode,opt){
        if(confirm('Do you want to delete this Station point?')) {
        var data = {};
        
        var dateSch = $('#date_sch').val();
        var date = dateSch.split('|');
    
        data.code = $('#sch_code').val();
        data.activeFlag   = $('#stationpointactiveFlag').val();
        data.station = scode;
        data.activeTo = date[1];
        data.activeFrom = date[0];
        
        data.stationPoint = $('#all-stp-code-'+opt).val();
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
            dataType:'json',
            url: base_url+"schedules/delete-station-point-schedules",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                    $('.del-st-p-'+opt).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                      loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		   }); 
               
                }else{                
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
function getSchedulesStation(){
      var data ={}
        data.code = $('#sch_code').val();
        $('.err-act').html(loading_small);
        $.ajax({
                type: "POST",
                url: "schedules/get-schedules-station",
                data: data,
                dataType : 'html',
                async: false,
                success: function(res) {
                     $('#station-schedules-list').html(res);
                     $('.err-act').html('');
                     return true;
                }
        });
}
function removeStationpoint(){
    //st-pnt-rm
    $('.st-pnt-rm').on('click',function(){
            $(this).parent().parent().remove();
        });
}
function removeStation(){
    //st-pnt-rm
    $('.st-rm').on('click',function(){
            var child = 'st-pt_'+$(this).attr('data-child');//st-pt_
            //$(this).parent().parent().remove();
             $(this).closest('tr').remove();
            $('#'+child).remove();
        });
}

function load_routes(){
     $('.err-act').html(loading_small);
        var data ={}
        data.code = $('#sch_code').val();
        data.bustype = $('#bustype').val();
       
        $.ajax({
                type: "POST",
                url: "schedules/get-schedules-routes",
                data: data,
                dataType : 'html',
                async: false,
                success: function(res) {
                     $('#rout-list').html(res);
                     setContentHeight('#wizard_form');
                     $('.err-act').html('');
                     return true;
                }
        });
}

function routesSchedulesDialog(opt){
    $('#routes-schedules-dialog').css('background','#fff');
    
    
    $('#routes-schedules-dialog').removeClass('hide');
    $('#routes-schedules-dialog').show();
    $('#routes-schedules-dialog').dialog({
        autoOpen: true,
        height: 300,
        width: 400,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#routes-sch-button').show();
    var h = $('#main_wrapper').height()+100;
    $('.ui-widget-overlay').height(h);
    $('#routes-sch-loading').html('');
    $('#routes-schedules-from,#routes-schedules-to').val('');
    /*$('#station-list-sch').select2({
	allowClear: true,
	placeholder: "Select..."
    });
     if(_isdefined(opt)){
         
     }*/
}
function cancelRoutesSchedulesDialog(){
    $('#routes-schedules-dialog').dialog('destroy');
    $('#routes-schedules-dialog').hide();
}
function addRoutesSchedules(){
    var from = $('#routes-schedules-from').val();
    var to = $('#routes-schedules-to').val();
    var err = 0;
    $('.parsley-error').removeClass('parsley-error')
    if(from==''){
        //parsley-error
        $('#routes-schedules-from').addClass('parsley-error');
        err++;
    }
    if(to==''){
        $('#routes-schedules-to').addClass('parsley-error');
        err++;
    }
    
    if(err > 0){
        $('#routes-sch-loading').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red.</div>');
        return false;
    }
    var ex = 0 ;
    $('.routes-ext').each(function() {
        if($(this).attr('data-from')==from && $(this).attr('data-to')==to){
            ex++;
            return false;
        }					
    });
     if(ex > 0){
        $('#routes-sch-loading').html('<div class="alert fl alert-danger">Already rotues are added.</div>');
        return false;
    }
    if(from==to){
        $('#routes-sch-loading').show();
        $('#routes-sch-loading').html('<div class="alert fl alert-danger">Same station point selected</div>');
        return false;
    }
    
    var html= '    <tr class="tr-bck">       \n\
                             <td class="bold">'+$("#routes-schedules-from" ).find(":selected").text()+' to '+$("#routes-schedules-to" ).find(":selected").text()+'</td>\n\
                             <td><a href="javascript:;" class="routes-ext" data-from="'+from+'" data-to="'+to+'" onclick="routesFareSchedulesDialog(this)">\n\
                                    <i class="fa fa-plus"></i>&nbsp;Add Fare\n\
                                </a>    &nbsp;&nbsp; \n\
                               <a href="javascript"><i class="fa fa-trash-o"></i></a>  \n\
                              </td> \n\
                   </tr>    \n\
                   <tr class="">\n\
                            <td colspan="2">\n\
                                <table class="table table-hover remove-border-top">\n\
                                    <tbody>\n\
                                        <tr>\n\
                                            <th>Seat</th>\n\
                                            <th>Group</th>\n\
                                            <th>Fare</th>\n\
                                            <th></th>\n\
                                        </tr>\n\
                                    </tbody>\n\
                                </table>\n\
                             </td>\n\
                   </tr>';
    $('.table-design tbody.routes-add').append(html);
    cancelRoutesSchedulesDialog();
}

function routesFareSchedulesDialog(obj){
    $('#routes-fare-schedules-dialog').css('background','#fff');    
    
    $('#routes-fare-schedules-dialog').removeClass('hide');
    $('#routes-fare-schedules-dialog').show();
    $('#routes-fare-schedules-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#routes-fare-sch-button').show();
    var h = $('#main_wrapper').height()+100;
    $('.ui-widget-overlay').height(h);
    
    if(_isdefined($(obj).attr('data-code'))){
           $('#routes-schedules-group').val($(obj).attr('data-group'));
           $('#routes-schedules-seat').val($(obj).attr('data-seat'));
           $('#routes-fare').val($(obj).attr('data-fare'));
           $('#routes-code').val($(obj).attr('data-code'));
           $('#routes-schedules-date').val($(obj).attr('data-date'));
    }
    $('#routes-from').val($(obj).attr('data-from'));
    $('#routes-to').val($(obj).attr('data-to'));
    
}
function cancelRoutesFareSchedules(){
    $('#routes-fare-schedules-dialog').dialog('destroy');
    $('#routes-fare-schedules-dialog').hide();
    $('#routes-schedules-group,#routes-schedules-seat,#routes-fare,#routes-code,#routes-schedules-date').val('');
}
function saveRoutesFareSchedules(obj){
    var data = {}
    data.from =  $('#routes-from').val();
    data.to =  $('#routes-to').val();
    data.code = $('#sch_code').val();
    data.Farecode = $('#routes-code').val();
    data.group = $('#routes-schedules-group').val();
    data.seatType = $('#routes-schedules-seat').val();
    data.fare = $('#routes-fare').val();
    data.fareStatus = 1;
    if($('#routes-schedules-date').val()!=''){
         var stationdate = $('#routes-schedules-date').val();
         var sdate = stationdate.split('|');
         data.routesActiveTo = sdate[1];
         data.routesActiveFrom = sdate[0];
    }
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');
      $('#routes-fare-sch-loading').html('');
    if(data.seatType==''){
        //parsley-error
        $('#routes-schedules-seat').addClass('parsley-error');
        err++;
    }
    if(data.fare==''){
        $('#routes-fare').addClass('parsley-error');
        err++;
    }
    if(err > 0){
        //
        $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }
    
    var ex = 0 ;
    
    $('.routes-seat-exit-'+data.from+'-'+data.to).each(function() {
        if(data.seatType==$(this).attr('data-seat') && data.Farecode=='' ){
            ex++;
        }					
    });
      
    if(ex > 0){
        $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">Already seat type are added.</div>');
        return false;
    }
     
     $('#routes-fare-sch-loading').html(loading_small);
        $.ajax({
                type: "POST",
                url: "schedules/update-routes-fare-schedules",
                data: data,
                dataType : 'json',
                async: false,
                success: function(res) {
                     if(res.status==1){
                         $('#routes-fare-sch-button').hide();
                         cancelRoutesFareSchedules();
                         load_routes();
                     }else{
                         $('#routes-fare-sch-loading').html('<div class="alert fl alert-danger">'+res.errorDesc+'</div>');
                     }
                }
        });
}
function visibleGroup(){
    $('.grp-dis').show();
}

function deleteRoutesFareSchedules(obj){
    if(confirm('Do you want to delete this Fare?')) {
        var data = {};
        data.Farecode = $(obj).attr('data-code');
        data.code = $('#sch_code').val();
        data.from =  $(obj).attr('data-from');
        data.to =  $(obj).attr('data-to');
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
            dataType:'json',
            url: base_url+"schedules/update-routes-fare-schedules",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                    $('#fare-'+data.Farecode).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                      loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		   }); 
               
                }else{                
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
function deleteRoutesAllScedules(rfrom,rto){
    if(confirm('Do you want to delete this Fare?')) { 
        //del-all-
        
        var fare = new Array();
        var from = new Array();
        var to = new Array();
        var seatType = new Array();
        var code = new Array();
        var Farecode = new Array();
        
        $('.del-all-'+rfrom+'-'+rto).each(function(){
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
            dataType:'json',
            url: base_url+"schedules/delete-routes-fare-schedules",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                    $('.del-all-remo-'+rfrom+'-'+rto).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                      loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		   }); 
               
                }else{                
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
function cancelSchedules(){
    $('.err-act').html(loading_small);
        var data ={}
        data.code = $('#sch_code').val();
        
        $.ajax({
                type: "POST",
                url: "schedules/get-schedules-cancel",
                data: data,
                dataType : 'html',
                async: false,
                success: function(res) {
                    $('.err-act').html('');
                     $('#cancel-list').html(res);
                     return true;
                }
        });
}
function savePolicyFareSchedules(){
    var data = {}
    
    data.code = $('#sch_code').val();
    data.policy = $('#cancel-schedules').val();
    data.group = $('#cancel-group-schedules').val();
    data.cancelCode = '';
    data.activeFlag = 1;
    if(data.policy==''){
        $('.err-act').html('<div class="alert fl alert-danger">Please select policy.</div>');
        return false;
    }
     $.ajax({
                type: "POST",
                url: "schedules/update-schedules-cancel",
                data: data,
                dataType : 'json',
                async: false,
                success: function(res) {
                     if(res.status==1){
                         $('#cancel-schedules,#cancel-group-schedules').val('');
                         cancelSchedules();
                     }else{
                         $('.err-act').html('<div class="alert fl alert-danger">'+res.errorDesc+'</div>');
                     }
                }
        });
}
function deleteCancelschedules(code,cnlcode){
     if(confirm('Do you want to delete this Policy?')) { 
      
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
            dataType:'json',
            url: base_url+"schedules/update-schedules-cancel",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                    $('#cancel-'+code).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                      loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		   }); 
               
                }else{                
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
function deleteBookingschedules(code){
     if(confirm('Do you want to delete this Booking?')) { 
      
        var data = {};
        
        data.code = $('#sch_code').val();
        data.cancelCode = code;
       var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
	 });

         $.ajax({
            type: "POST",
            dataType:'json',
            url: base_url+"schedules/delete-booking-schedules",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                    $('.del-all-remo-'+rfrom+'-'+rto).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                      loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		   }); 
               
                }else{                
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
function bookingschedules(){
      var data ={}
        data.code = $('#sch_code').val();
        $('#booking-list').html(loading_popup);
        $.ajax({
                type: "POST",
                url: "schedules/get-booking-schedules",
                data: data,
                dataType : 'html',
                async: false,
                success: function(res) {
                     $('#booking-list').html(res);
                     return true;
                }
        });
}
function saveBookingSchedules(){
    var dateSch = $('#date_sch').val();
    var date = dateSch.split('|');
    var data =  {}
    data.code = $('#sch_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.dayOfWeek = $("#weekdays :checkbox").map(function () {
         return +$(this).is(':checked');
    }).get();
    data.odays = $('#open-day-booking').val();
    data.ohours = $('#open-hour-booking').val();
    data.omin = $('#open-min-booking').val();
    data.chours = $('#close-hour-booking').val();
    data.cmin = $('#close-min-booking').val();
    data.group = $('#booking-group-schedules').val();
    $('.parsley-error').removeClass('parsley-error');
    var err = 0;
    if(data.odays==''){
        $('#open-day-booking').addClass('parsley-error');
        err++;
    }
    if(data.ohours==''){
        $('#open-hour-booking').addClass('parsley-error');
        err++;
    }
    if(data.omin==''){
        $('#open-min-booking').addClass('parsley-error');
        err++;
    }
    if(data.chours==''){
        $('#close-hour-booking').addClass('parsley-error');
        err++;
    }
    if(data.cmin==''){
        $('#close-min-booking').addClass('parsley-error');
        err++;
    }
   
    if(err >0){
        $('.err-act').html('<div class="alert fl alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }
    $('.booking-button').hide();
    $('.err-act').html(loading_popup);
            $.ajax({
                type: "POST",
                url: "schedules/update-schedules-booking",
                data: data,
                dataType : 'json',
                async: false,
                success: function(res) {
                     if(res.status==1){
                         $('.err-act').html('');
                         $('.booking-button').show();
                         bookingschedules();
                     }else{
                         $('.err-act').html('<div class="alert fl alert-danger">'+res.errorDesc+'</div>');
                         $('.booking-button').show();
                     }
                }
        });
    
    
}
function getSeatVisiblitySchedules() {
    $('.err-act').html(loading_small);
    $('#err').html('');
    var data = {}
    data.code = $('#sch_code').val();
    data.busType = $('#bus-type-sch-seat').val();

    $.ajax({
        type: "POST",
        url: "schedules/get-seat-visiblity-schedules",
        data: data,
        dataType: 'html',
        async: false,
        success: function(res) {
            
            $("#dynamic-seat").html("");
            $('#seat-vis-list').html(res);
            $(".toggle-seat-list").show();
            $("#toggle-seat").show();
            $("#toggle-seat_header").show();
            $('.err-act').html('');
            $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#seat_visiblity').html(res);
            $("#toggle-seat").click(function() {
                $(".toggle-seat-list").slideToggle("slow", function() {
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
function saveSeatSchedules() {
    var dateSch = $('#seat-sch-date').val();
    var date = dateSch.split('|');
    var data = {}
    data.code = $('#sch_code').val();
    data.activeTo = date[1];
    data.activeFrom = date[0];
    data.busCode = $('#bus-type-sch-seat').val();
    data.activeFlag = 1;
    var day = 0;
    data.dayOfWeek = $("#busTypeweekdays :checkbox").map(function() {
        if (!$(this).is(':checked')) {
            day++;
        }
        return +$(this).is(':checked');
    }).get();
    var seat = new Array();
    $(".schedule-seat-visibility").each(function() {
        seat.push($(this).attr('data-code'));
    }).get();

    data.seatCode = seat;
    data.viewStatus = $('input[name="viewstatus"]').is(":checked") == true ? 1 : 0;

    data.roleType = $("input[name='assignOption']:checked").val();
    data.seatViscode = $('#seat-visibily-code').val();
    $('.err-act').show();
    $('.err-act').html('');
    if (seat.length == 0) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleat one seat.</div>');
        return false;
    }
    if ($('#seat-sch-date').val() == '') {
        $('.err-act').html('<div class="alert fl alert-danger">Please select date.</div>');
        return false;
    }
    if (data.roleType == '' || data.roleType == undefined) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select role Type.</div>');
        return false;
    }

    if (data.roleType == 'GR') {
        /* if($('#group-seat-sch').val()==''){
         $('.err-act').html('<div class="alert fl alert-danger">Please select group.</div>');
         return false;
         }*/
        data.group = $('#group-seat-sch').val();
    } else if (data.roleType == 'UR') {
        if ($('#user-seat-sch').val() == '') {
            $('.err-act').html('<div class="alert fl alert-danger">Please select user.</div>');
            return false;
        }
        data.user = $('#user-seat-sch').val();
    }
    if (data.dayOfWeek.length == day) {
        $('.err-act').html('<div class="alert fl alert-danger">Please select atleat one week days.</div>');
        return false;
    }

     $('.err-act').html(loading_small); 
    $.ajax({
        type: "POST",
        url: "schedules/update-seat-visiblity-schedules",
        data: data,
        dataType: 'json',
        //async: false,
        success: function(res) {
            if (res.status == 1) {
                $('.err-act').html('');
                closeScheduleOptions();
                $('#schs-'+data.code).trigger('click');
                
            } else {
                $('.err-act').html('<div class="alert fl alert-danger">' + res.errorDesc + '</div>');
                $('.booking-button').show();
            }
        }
    });
}
function deleteSeatVisiblity(code) {
    var data = {}
    $.each(seatAssign, function(k, sval) {
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
    data.dayOfWeek = $("#busTypeweekdays :checkbox").map(function() {
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
            success: function(response) {
                if (response.status == 1) {
                    $('.del-seat-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
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
                window.setTimeout(function() {
                    loading_overlay.hide();
                    closeScheduleOptions();
                $('#schs-'+data.code).trigger('click');
                }, 2000);
            }
        })

    }

}
function editSeatVisiblity(code) {
    $('#seat-visibily-code').val(code);
    $.each(seatAssign, function(k, sval) {
        if (sval.code == code) {
            $('input[name="assignOption"]').removeAttr("checked");
            $('.assignee').hide();
            if (sval.activeFrom != '' && sval.activeFrom != undefined && sval.activeTo != '' && sval.activeTo != undefined) {
                $('#seat-sch-date').val(sval.activeFrom + " | " + sval.activeTo);
            }
            $("input[value='" + sval.roleType + "']").attr("checked", "checked");
            $("input[value='" + sval.roleType + "']").attr('checked', true);
            $("input[value='" + sval.roleType + "']").prop('checked', true);

            if (sval.roleType == 'GR') {
                if (sval.group != undefined) {
                    $('#group-seat-sch').val(sval.group.code);
                }
            }
            if (sval.roleType == 'UR') {
                $('#user-seat-sch').val(sval.user.code);
            }
            $('.' + $("input[value='" + sval.roleType + "']").attr('data-view')).show();
            $('#busTypeweekdays').find('.active').removeClass('active').removeAttr("checked");
            var str = sval.dayOfWeek;
            var res = str.split("");
            $("input[name='busweek']").each(function(i) {
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
            $.each(sval.busSeatLayout, function(kb, bsval) {
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
    $('#group-seat-sch').val('');
    $('#user-seat-sch').val('');
    $('input[name="busweek"]').addClass('active').attr("checked");
    $('.seat-visible').removeClass('seat-visible');
    $('.grp-seat').remove();

    $.each(seatAssign, function(k, sval) {

        var color = $('#seat-assign-' + sval.code).css('background-color');
        //busSeatLayout schedule-seat-visibility
        $.each(sval.busSeatLayout, function(kb, bsval) {

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


function reviewSchedules(){
    $('.name-schedules').html($('#name_sch').val());
    $('.date-schedules').html($('#date_sch').val());    
    $('.servicenumber-schedules').html($('#service_sch').val());    
    $('.display-name-schedules').html($('#display_sch').val());    
    $('.pnr-code-schedules').html($('#PNR_sch').val());    
    $('.report-time-schedules').html($('#RTB_sch').val()); 
    var html = '';
    var week = new Array('Sun','Mon','Tue','Wek','Thu','Fri','Sat')
    $("input[name='week']").each(function (i) {
            if($(this).is(':checked')){
                if(html!='') html +=',';
                html += week[i];
            }
     });
    var mob =  $('input[name="ph_bkg"]').is(":checked")== true ? "Yes" : "No";        
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
        if(selText!='')  selText +=',';
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
    $('#booking-schedules-accordion').html(bookingHtml);
    setContentHeight('#wizard_form');
    //
    $('#cancel-schedules-accordion .accordion-toggle').each(function(i){
       var id = $(this).attr('href');
       $(this).attr('href','#review-'+i);
        $('#cancel-schedules-accordion '+id).attr('id','review-'+i)
       
    });
   $('#cancel-schedules-accordion .del').remove();
    
}
function changesSteps(i){
    
    $('#wizard_form-t-'+i).trigger('click');
}

function toogleVisiblityExceptionOverrideList(ele, code) {
    $(ele).toggleClass('active');
    $('.ex-' + code).toggle();
    setContentHeight('#wizard_form');
}
/*$.fn.steps.setStep = function (step)
{

    var options = getOptions(this),
        state = getState(this);

    return _goToStep(this, options, state, step);

};*/

function seatVisiblityExceptionOverride(obj) {
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
    $(".vis-ovr-exp-days").each(function(i) {
        $(this).attr("checked", "checked");
        $(this).parent().addClass('active');
    });

    $('.vis-exp-date').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: false,
        showWeekNumbers: true,
        //yearRange: '1930:+0',
    });
    $('#vis-expt-code,#vis-ovr-roleType,#vis-visibility-type,#vis-exov-code').val('');
    $('.seat-select-override').html('');
    var code = $(obj).data('viscode');
    $('#vis-expt-code').val(code);
    var eocode = $(obj).data('expcode');

    if (seatAssign != undefined) {

        $.each(seatAssign, function(k, vval) {
            if (vval.code == code) {
                var seat = vval.busSeatLayout;
                var html = '';
                $('#vis-ovr-roleType').val(vval.roleType);
                if (vval.visibilityType == 'ACAT') {
                    $('#vis-visibility-type').val(1);
                } else {
                    $('#vis-visibility-type').val(2);
                }

                $.each(seat, function(k, sl) {
                    html += '<label class="pull-left p_r_5"><input type="checkbox" checked="checked" id="seat-override" class="seat-override-code" name="seat-override" value="' + sl.code + '" />' + sl.seatName + '</label>';
                });
                $('.seat-select-override').html(html);
                if (vval.overrideList != undefined) {
                    $.each(vval.overrideList, function(e, eov) {
                        if (eocode == eov.code) {
                            $('.seat-override-code').removeAttr('checked');
                            $('#vis-exp-scd-description').val(eov.description);
                            $('#vis-exov-code').val(eov.code);
                            if (eov.busSeatLayout != '') {
                                $.each(eov.busSeatLayout, function(i, vs) {
                                    $("input[value='" + vs.code + "']").prop('checked', true);

                                });
                                if (eov.visibilityType == 'ACAT') {
                                    $('input[name="view-ovr-status"]').prop('checked', true);
                                }
                            }
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
                                    $dayweek.each(function(i) {
                                        $(this).removeAttr("checked");
                                        $(this).parent().removeClass('active');
                                    });
                                    var res = str.split("");
                                    $dayweek.each(function(i) {
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
function saveVisiblityExceptionDialog() {
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
    data.busCode = $('#bus-sch-code').val();
    //data.busCode = $('#bustype').val(); //   from bus tab
    data.activeFlag = 1;
    data.seatViscode = $('#vis-exov-code').val();
    data.dayOfWeek = $("#vis-except-week-days label").map(function() {
        return +($(this).hasClass("active"));
    }).get();
    var err = 0;
    $('.parsley-error').removeClass('parsley-error');

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
        success: function(response) {
            if (response.status == 1) {
                cancelVisiblityExceptionDialog();
                $('#sta-exp-sch-loading').html('');
               // getSeatVisiblitySchedules();
                closeScheduleOptions();
                $('#schs-'+data.code).trigger('click');
                setContentHeight('#wizard_form');
            } else {
                $('#vis-expt-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}
function saveVisiblityOverrideDialog() {
    $('#vis-expt-loading').html('');
    var data = {}
    var dateSch = $('#vis-ovr-scd-date').val();
    var date = dateSch.split('|');
    var seat = new Array();
    $("input[name='seat-override']").each(function() {
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
    data.busCode = $('#bus-sch-code').val();
    //data.busCode = $('#bustype').val(); //   from bus tab
    data.activeFlag = 1;
    data.seatViscode = $('#vis-exov-code').val();

    data.dayOfWeek = $("#vis-ovr-week-days label").map(function() {
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
        url: base_url + "schedules/update-seat-visiblity-schedules",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                cancelVisiblityExceptionDialog();
                $('#sta-exp-sch-loading').html('');
              //  getSeatVisiblitySchedules();
               closeScheduleOptions();
                $('#schs-'+data.code).trigger('click');
                setContentHeight('#wizard_form');
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
            success: function(response) {
                if (response.status == 1) {
                    $('#stv-eo-del-' + data.seatViscode).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
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
                window.setTimeout(function() {
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

function getAuditLog(){
    var data = {}
            data.scheduleCode = $('#sch_code').val();
            $('#load_audit').html(loading_small);
           $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/schedule-audit-log",
            data: data,
            success: function(res) {
               //alert($('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#audit_log').html());
               $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#audit_log').html(res);
            }
            });
}