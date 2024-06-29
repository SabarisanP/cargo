function buildStationMappingList() {
    $('#search-status').html('');
    var data = {};
    data.state_code = $('#sel_state_id').val();
    if(data.state_code=="") {
       $('#search-status').html('Please select a state');
       return;
    }

    $('#address-book').html('<div align="left">'+loading_big+'</div>');
    $('#result-panel').show();
    $('#contact-card').hide();
    $.ajax({
        type: "POST",
        url: base_url+"config/get-stations/stationmap",
        data: data,
        success: function(response) {
           $('#address-book').html(response);
           
           $('#address-book').sliderNav();
            
        }
    });
    buildNameSpaceMappingList();
}
function buildNameSpaceMappingList() {
    $('#search-status').html('');
    $('#namespace').html('<div align="left">'+loading_big+'</div>');
    $('#result-panel').show();
    $('#contact-card').hide();
    $.ajax({
        type: "POST",
        url: base_url+"config/get-namespace-station",
        success: function(response) {
           $('#namespace').html(response);
            //$('#namespace').sliderNav();
        }
    })
}
function addNamespaceMapping() {
    var data = {};
    data.name = $('#station_list').find(":selected").text();
    data.activeFlag = 1;
    data.code = $('#station_list').val();
    data.stateCode = $('#sel_state_id').val();
    data.s_del = $('#s_delete').val();
    data.shortCode = '';
    
    if(data.stateCode=="") {
       $('#action-status').html('<span class="warning-text">Please select a state</span>');
       return;
    }  
    
    if(data.code=="") {
       $('#action-status').html('<span class="warning-text">Please select a station</span>');
       return;
    }    
      // $('#namespace').html('<div align="left">'+loading_big+'</div>');
      $('#action-status').html('<div align="left">'+loading_small+'</div>');
       $.ajax({
        type: "POST",
        url: base_url+"config/add-namespace-station",
        data: data,
        dataType:"json",
        success: function(response) {
            if(response.status==1 && !$("#ns-"+$('#station_list').val()).length){
                $('#action-status').html('');
                var li = $('li.st-db').clone();
                li.attr('id',"ns-"+response.data.code);
                li.find('.fl a').html($('#station_list').find(":selected").text());
                li.find('.fl a').attr('onclick','getStationPointsList("'+response.data.code+'","'+data.name+'")');
                li.removeClass('hide').removeClass('st-db');
                if(data.s_del > 0){
                    if(data.s_del==1){
                        li.find('.btn-xs').attr('onclick','deleteNamespaceMapping({"name":"'+data.name+'","code":"'+response.data.code+'","activeFlag":1,"stateCode":null})')
                    }else{
                        li.find('.btn-xs').attr('');
                    }
                } else {
                    li.find(".btn-xs").hide();
                }
                li.insertAfter($("#user_list_search li:first")).css('opacity','0.1').animate({opacity: 1.0}, 1500 ); 
            }else if($("#ns-"+$('#station_list').val()).length){
                $('#action-status').addClass('align-center alert alert-danger alert-error');
                $('#action-status').html('Sorry! '+data.name+' already added in your list');
                window.setTimeout( function() { 
                    $('#action-status').removeClass('align-center alert alert-danger alert-error');
                    $('#action-status').html('');
                }, 5000);
            }
        }
    });
    
    
}
function deleteNamespaceMapping(mapDetails) {
    if(_isdefined(mapDetails)) {
      if(confirm('Do you want to delete this station?')) {  
              var data = {};
                  data.name = mapDetails.name;
                  data.activeFlag = 2;
                  data.code = mapDetails.code;
                  data.stateCode = mapDetails.stateCode;
                  var loading_overlay = iosOverlay({
						text: "Loading",
						icon: "fa fa-spinner fa-spin"
					});  
               $.ajax({
                type: "POST",
                url: base_url+"config/delete-namespace-station",
                data: data,
                dataType: 'json',
                success: function(response) {
                   if(response.status==1) {
                        $('#action-status').html('');
                        $('#ns-'+mapDetails.code).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                        loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		        });
                   } else{     
                       loading_overlay.update({
                                    icon: "fa fa-times",
                                    text: "Sorry!"
		      });  
                        /*$('#action-status').addClass('align-center alert alert-danger alert-error');
                        $('#action-status').html('Sorry! Problem in processing your request.');
                        window.setTimeout( function() { 
                            $('#action-status').removeClass('align-center alert alert-danger alert-error');
                            $('#action-status').html('');
                        }, 3000);*/
                   }
                   window.setTimeout(function() {
                            loading_overlay.hide();
                    }, 2000);
                }
            });
      }
    }    
    
}
