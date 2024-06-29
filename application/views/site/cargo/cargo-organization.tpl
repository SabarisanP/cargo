<style>
.brancheslist,
 {
	margin: 0;
	padding: 0;
}

.brancheslist li {
	display: inline-block;
	color: #222;
	padding: 0 0;
	letter-spacing: 0px;
}
.fonta-disable{
    color:#64b92a;
    position: relative;
    max-width: 10%;
    
}
.fonta-able{
    color:#db1313;
    position: relative;
    max-width: 10%;
    
}
.empty-space {
    width: 10px; 
    display: inline-block;
}
.able-disable h5{
   margin-bottom:35px;
}

</style>
<div class="brand_top">
    <h3>Cargo Branch</h3> 
</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <div class="row">
                                            <div class="col-lg-3 form-group">
                                                <label>Branch</label>
                                                <select id="branch-filter" class="form-control">
                                                    <option value="All">All Branch</option>
                                                    {foreach item=row from=$branches key=k}
                                                        <option value="{$row->code}">{$row->name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-lg-4 form-group">
                                                <label>&nbsp;</label>
                                                <button type="button" class="btn btn-default btn-clear" onclick="showAllBranch();">Clear</button>
                                            </div>
                                            <div class="col-lg-3"></div>
                                            <div class="col-lg-2">
                                                <label>&nbsp;</label>
                                                <h5> Enable <span class="fonta-disable"><i class="fa fa-location-arrow"></i></span>
                                                &nbsp;&nbsp;  Disable <span class="fonta-able"><i class="fa fa-location-arrow"></i></span></h5>
                                            </div>
                                        </div>
                                        <table id="organizations_table" class="table table-bordered">
                                        <thead>
                                            <tr class="success">
                                                <th>Branch Name</th>
                                                <th>Delivery from specific branch?</th> 
                                            </tr>
                                        </thead>
                                        <tbody class="body_table">
                                            {foreach item=row from=$branches key=k}
                                                {assign var="code" value=$row->code}
                                                <tr id="{$row->code}">
                                                    <td style="vertical-align:top;" class="brancheslist" valign="top"><li>{$row->name}</li></td>
                                                    <td>
                                                        <div class="row">
                                                            {foreach item=drow from=$branches key=dr}
                                                                {if $drow->code != $row->code}
                                                                    <div class="col-md-2 brancheslist"> 
                                                                        <li type="text" class="{$row->code}-dlvr">
                                                                            {if in_array($drow->code, $delivery_branches[$row->code])}
                                                                                <span class="fonta-disable"><i class="fa fa-location-arrow"></i></span>
                                                                            {else}
                                                                                <span class="fonta-able"> <i class="fa fa-location-arrow"></i></span>
                                                                            {/if} 
                                                                            {$drow->name}
                                                                        </li>
                                                                    </div>
                                                                {/if}
                                                            {/foreach}
                                                        </div>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                    
                                    </div>
                                </div>
                                
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>


<script>
$( document ).ready(function() {
    $('#branch-filter').select2();
    
    $('#branch-filter').on('change', function() {
        $('.body_table tr').addClass('hide');
      $('#'+this.value).removeClass("hide");

      if(this.value == "All"){
          showAllBranch();
        }
    });
});

function showAllBranch(){
    $('.body_table tr').removeClass('hide');
}

function toggleDlryBranch(code) {
    var chked = $('#'+code+'-toggle').is(':checked');
    $('input.' + code +'-dlvr').prop('checked', chked);
}
function togglePay(code) {
    var chked = $('#'+code+'-pay-toggle').is(':checked');
    $('input.pay-type-' + code).prop('checked', chked);
}
    
function updateOrganizationFlag(code,flag){  
    var data = {};
    data.code = code;
    if($('#' + code +'-bkg').is(":checked")){
        data.bookingFlag = '1';
    } else {
        data.bookingFlag = '0';
    }
    if($('#' + code +'-dlv').is(":checked")){
        data.deliveryFlag = '1';
    } else {
        data.deliveryFlag = '0';
    }
    data.bookingDeliveryFlag = data.bookingFlag+data.deliveryFlag;
    
    data.deliveryBranchList = [];
    $('input.' + code +'-dlvr:checkbox:checked').each(function () {
        data.deliveryBranchList.push( $(this).val() );
    });
    
    // data.payType = [];
    // $('input.pay-type-' + code +':checkbox:checked').each(function () {
    //     var val = $(this).val();
    //     data.payType.push({ code : val });
    // });
        
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-organization",
        data: data,
        success: function(response) {
            if (response.status == 1) {
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
    });    
}    
</script>    