<style>
.transit-type{
color:#009a58;
}
</style>
<link href="assets/lib/leaflet/leaflet.css" rel="stylesheet" type="text/css" media="screen">
<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Transit Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<div class="clearfix"></div>
<h5><b>Summary</b></h5>
<table class="table table-bordered" style="width: 45%;">
    <thead>
        <tr class="success">
            <th class="text-center">Vechile Number</th>
            <th class="text-center">Route</th>
            <th class="text-center">Transit Code</th>
          
            <th class="text-center">KM</th>
            <th class="text-center" width="70">Total Lr</th>
        </tr>
    </thead>
    <tbody>
        {assign var="totalKm" value=0}
        {assign var="totalodm" value=0}
        {assign var="totalLr" value=0}
        {foreach item=singleCount from=$routewise key=branch}
            {assign var ="index" value = 0}
            {foreach item =count  from =$singleCount['transitCode'] key=key}  
                {assign var ="index" value = $index + 1}
                {assign var="rowCount" value=$singleCount['transitCode']|count}
                <tr id="{$branch|replace:' ':''}">
                    {if $index == 1}
                        <td align="left" rowspan="{$rowCount}"><a href="javascript:;" onclick="filterBranch('{$branch|trim}')"><b>{$branch}</b></a></td>
                    {/if}
                        <td align="left"><b>{$count->route|replace:'-':' - '}</b></td>
                        <td align="center" nowrap>
                            <span class="text-success">
                                <a title="Click to get OGPL Trip Chart" href="#cargo/ogpl-chart-details?transitCode={$count->transit_code}&date={$count->trip_date|date_format:'Y-m-d'}" title="View Chart" target="_blank">{$count->alias_code}</a>
                            </span>
                        </td>
                        </td>
                    {if $index == 1}
                        {assign var="totalKm" value=$totalKm + $singleCount['totalKm']}
                        <td align="right" rowspan="{$rowCount}">{$singleCount['totalKm']|default:0}</td>
                       
                    {/if}
                    <td align="right" nowrap>
                        <b>{$count->lr_count}</b>
                    </td>
                    {assign var="totalLr" value=$totalLr + $count->lr_count}
                </tr>
            {/foreach}
        {/foreach}
    </tbody>
    <tfoot>
        <tr>
            <td align="right" colspan="3"><b>Total </b></td>
            <td align="right"><b>{$totalKm}</b></td>
            <td class="text-right"><b>{$totalLr}</b></td>
        </tr>
    </tfoot>
</table>

<table class="hide" width="100">
{foreach item=val from=$routewise key=branch}
        <tr class="{$branch|replace:' ':''} hide summary-to-branch">
            <td>
                <table class="table table-bordered " width="100%">
                    <thead>
                        <tr class="active">
                            <th class="text-center">Route</th>
                            <th class="text-center">Transite Code</th>
                            <th class="text-center">ODM</th>
                            <th class="text-center">KM</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                       {foreach item=innerval from=$val['transitCode'] key=transitCode}
                            <tr>
                                <td align="center"><b>{$innerval->route}</b></td>
                                <td align="center" nowrap>
                                <span class="text-success">
                                <a title="Click to get OGPL Trip Chart"  href="#cargo/ogpl-chart-details?transitCode={$innerval->transit_code}&date={$innerval->trip_date|date_format:"Y-m-d"}" title="View Chart" target="_blank">{$innerval->alias_code}</a>
                                </span> 
                                </td>
                                <td align="center">{$innerval->km}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </td>
        </tr>
                    {/foreach}
</table>
<div class="clearfix"></div>


<div class="overflow-x-auto">   
    <table id="cargo_revenue_report_table" class="table table-bordered table-bordered-1" width="98%;">
        <thead>
            <tr class="success">
                <td>Vehicle / Driver</td>
                <td>{lang('ogpl')} Number</td>
                <td>Route</td>
                <td>Via Stations</td>
                <td>Date of Created</td>
                <td>Total Odometer</td>
                <td>Number of {lang('lr')} loaded</td>
                <td>Number Of {lang('lr')} Un<br>Loaded</td>
                <td nowrap>Hub<br/>Loaded|<br/>Hub<br/>Un<br>Loaded</td>
                <td nowrap>E-way<br/>Bill A/B</td>
                <td align="center">Expenses</td>
                <td align="center" >Transit Amount</td>
                <td align="center">Fuel<br>LTR|<br>AMT</td>
                <td>Unloaded By</td>
                <td>Status</td>
               
            </tr>
        </thead>
        <tbody class="body_table" >

            {assign var=t_load_count value=0}
            {assign var=t_cargo_count value=0}
            {assign var=t_unload_count value=0}
            {assign var=t_total_amount value=0}
            {assign var=t_fuel_amount value=0}
            {assign var=t_transit_amount value=0}
            {assign var=t_hub_load_count value=0}
            {assign var=t_hub_unload_count value=0}
            {assign var=t_e_way_bill_A value=0}
            {assign var=t_e_way_bill_B value=0}

            {foreach item=row from=$result key=i}
              
                    <tr class = "message-box">
                                
                        {if $row->remarks|trim != ''}
                            <td align="left" rowspan="2">
                        {else}
                            <td align="left">
                        {/if}
                            <a href="javascript:;" title="Click to get Vehicle History" onclick="getTransitHistory('{$row->transit_code}', '{$row->alias_code}', 'VEHICLE')">{$row->registration_numer}</a><br>
                            <span class="text-muted" title="Driver">{(isNotNull($row->driver_name)) ? $row->driver_name : ''}</span>
                            </br>
                            {if $row->transit_type == 'TRNT'} 
                                <span class="badge badge-info"> Out Station </span>
                                    {elseif $row->transit_type == 'INTRNT'} 
                                <span class="badge badge-secondary"> Local Transit</span>
                                    {elseif $row->transit_type == 'OTFD'} 
                                <span class="badge badge-danger"> OFD </span>
                                    {elseif $row->transit_type == 'HBTRNT'}
                                <span class="badge transit-type"> Hub </span>
                            {/if}
                            </td>
                        <td align="left" >
                            <span class="text-success">
                                <a title="Click to get OGPL Trip Chart"  href="#cargo/ogpl-chart-details?transitCode={$row->transit_code}&date={$row->trip_date|date_format:"Y-m-d"}" title="View Chart" target="_blank">{$row->alias_code}</a>
                            </span> 
                            </br>
                            <span class="input-group-addon" title="Click to get Transit History" onclick="getTransitHistory('{$row->transit_code}', '{$row->alias_code}')"> <center><i class="fa fa-history" aria-hidden="true"></i></center></span>
                            <span class="input-group-addon"  title="Click to get Transit Odometer" > <center><svg onclick ="openRoutesModel('{$row->transit_code}')" xmlns="http://www.w3.org/2000/svg" style="text-align:center;width:16px;color:blue" viewBox="0 0 512 512"><path d="M512 96c0 50.2-59.1 125.1-84.6 155c-3.8 4.4-9.4 6.1-14.5 5H320c-17.7 0-32 14.3-32 32s14.3 32 32 32h96c53 0 96 43 96 96s-43 96-96 96H139.6c8.7-9.9 19.3-22.6 30-36.8c6.3-8.4 12.8-17.6 19-27.2H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320c-53 0-96-43-96-96s43-96 96-96h39.8c-21-31.5-39.8-67.7-39.8-96c0-53 43-96 96-96s96 43 96 96zM117.1 489.1c-3.8 4.3-7.2 8.1-10.1 11.3l-1.8 2-.2-.2c-6 4.6-14.6 4-20-1.8C59.8 473 0 402.5 0 352c0-53 43-96 96-96s96 43 96 96c0 30-21.1 67-43.5 97.9c-10.7 14.7-21.7 28-30.8 38.5l-.6 .7zM128 352a32 32 0 1 0 -64 0 32 32 0 1 0 64 0zM416 128a32 32 0 1 0 0-64 32 32 0 1 0 0 64z"/></svg></center></span>

                        </td>
                        <td align="left">{$row->from_station_name} - {$row->to_station_name}</td>
                        <td align="left">{$row->via_stations|replace:',':', '}</td>           
                        <td align="left">
                        <span nowrap>
                        {if isNotNull($row->audit_updated_at)}
                        {assign var="formatted_date" value=$row->audit_updated_at|date_format:"%d-%m-%Y"}
                        {assign var="formatted_time" value=$row->audit_updated_at|date_format:"%I:%M %p"}
                        {$formatted_date}<br/>{$formatted_time}
                        {/if}
                        </span>
                        </br>
                            <span class="text-muted" title="Created By">{$row->audit_user_name|default:'-'}</span>
                        </td>
                        <td align="left">
                        {if $row->start_odometer && $row->end_odometer}
                            {assign var='distance' value=$row->end_odometer - $row->start_odometer}
                            {$distance} Km
                        {else}
                            {if $row->start_odometer}
                                {assign var='endOdm' value=0}
                                {assign var='startOdm' value=$row->start_odometer}
                            {else if $row->end_odometer}
                                {assign var='endOdm' value=$row->end_odometer}
                                {assign var='startOdm' value=0}
                            {else}
                                {assign var='endOdm' value=0}
                                {assign var='startOdm' value=0}
                            {/if}
                            {assign var='distance' value=$endOdm - $startOdm}
                            {assign var='distance' value=abs($distance)|default:'-'}
                            {$distance} ODM
                        {/if}
                        </td>
                        <td align="center">{$row->cargo_count} </td>
                        <td align="center">{$row->unload_count}</td>
                        <td align="right">{$row->hub_load_count} | {$row->hub_unload_count}</td>
                        <td align="right">{$row->eway_bill_added_count|default:'0'} / {$row->eway_bill_part_b_updated_count|default:'0'}</td>
                        {assign var = "totalFuelLtr" value = 0}
                        {assign var = "totalFuelAmount" value =0}
                        <td align="right" nowrap>
                        {$row->total_fuel_amount|inr_format}&nbsp;
                        
                        {assign var="transit_fuel_details" value="|"|explode:$row->transit_fuel_details}
                        {assign var="fuelDetails" value=''}
                        {foreach from=$transit_fuel_details item=fuel}
                            {assign var="fuelArray" value=","|explode:$fuel}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'<b>Fuel Vendor : '|cat:$fuelArray[3]|cat:'</b><br>'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Payment Mode : '|cat:$fuelArray[0]|cat:'<br>'}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Litres : '|cat:$fuelArray[1]|cat:'<br>'}
                            {assign var = "totalFuelLtr" value = $totalFuelLtr + $fuelArray[1]}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'Amount : '|cat:$fuelArray[2]|cat:'<br>'}
                            {assign var = "totalFuelAmount" value = $totalFuelAmount + $fuelArray[2]}
                            {assign var="fuelDetails" value=$fuelDetails|cat:'<br>'}
                        {/foreach}
                        {if isNotNull($row->transit_fuel_details)}
                            <a href="javascript:;" data-toggle="popover" data-content="{$fuelDetails}" style="cursor:pointer; text-align:center;">
                                <i class="fa fa-info-circle" aria-hidden="true"></i>
                            </a>
                        {/if}
                        </td>
                        <td align="right">{$row->total_transit_amount|inr_format}</td>
                        <td align="right">{{$totalFuelLtr|cat:' L|'}}<br/>{{($totalFuelAmount|inr_format)}}</td>
                        <td align="left">
                            <span title="{$row->unloaded_user_name}" nowrap>{$row->unloaded_user_name|truncate:20|default:'-'}</span><br>
                            <span class="text-muted" title="Unloaded At">
                            {if $row->unloaded_at}
                            {assign var="formatted_date" value=$row->unloaded_at|date_format:"%d-%m-%Y"}
                            {assign var="formatted_time" value=$row->unloaded_at|date_format:"%I:%M %p"}
                            {$formatted_date}<br/>{$formatted_time}
                            {/if}
                        </span>                       
                        </td>
                        <td>
                            {if $row->transit_activity_status_code == 'NEW'}
                                <span class="badge badge-success">New</span>
                            {elseif $row->transit_activity_status_code == 'INTRN'}
                                <span class="badge badge-warning">In-Transit</span>
                            {elseif $row->transit_activity_status_code == 'CMPLT'}
                                <span class="badge badge-success">Completed</span>
                            {elseif $row->transit_activity_status_code == 'TRNSFR'}
                                <span class="badge badge-danger">Transferred</span>
                            {elseif $row->transit_activity_status_code == 'EMPLD'}
                                <span class="badge badge-danger">Empty Load</span>
                            {/if}
                        </td>                       
                        {if $row->remarks|trim != ''}
                            <tr>
                                <td align="left" colspan="14">{$row->remarks}</td>
                            </tr>
                        {/if}
                       
                    </tr>
              
                {assign var=t_load_count value=$t_load_count + $row->load_count}
                {assign var=t_cargo_count value=$t_cargo_count + $row->cargo_count}
                {assign var=t_unload_count value=$t_unload_count + $row->unload_count}
                {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
                {assign var=t_fuel_amount value=$t_fuel_amount + $row->total_fuel_amount}
                {assign var=t_transit_amount value=$t_transit_amount + $row->total_transit_amount}
                {assign var=t_hub_load_count value=$t_hub_load_count + $row->hub_load_count}
                {assign var=t_hub_unload_count value=$t_hub_unload_count + $row->hub_unload_count}
                {assign var=t_e_way_bill_A   value=$t_e_way_bill_A + $row->eway_bill_added_count}
                {assign var=t_e_way_bill_B   value=$t_e_way_bill_B + $row->eway_bill_part_b_updated_count}
            {foreachelse}
                <tr>
                    <td colspan="15" align="center">No Records Found</td>
                </tr>
            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr class="active bold">
                    <td colspan="6" align="right">Total</td>
                    <td align='right'>{($t_cargo_count)}</td>
                    <td align='right'>{($t_unload_count)}</td>
                    <td align='right'>{($t_hub_load_count)} / {($t_hub_unload_count)}</td>
                    <td align='right'>{($t_e_way_bill_A)|default:'0'} / {($t_e_way_bill_B)|default:'0'}</td>
                    <td align='right'>{($t_fuel_amount)|inr_format}</td>
                    <td align='right'>{($t_transit_amount)|inr_format}</td>
                    <td colspan="5"></td>
                </tr>
            </tfoot>
        {/if}
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportRevenueExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="{if in_array($namespace , ["rmtcargo","seenutransports","seenucargo"])}printOgplReport(){else}window.print(){/if}"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>
<div id="route-dialog" class="flex d-flex justify-content-center justify-center align-center align-item-center hide">
    <div id="route-dialog-container" style="width: 100%;">
        <div id="route-dialog-header" style="height: 30px;"> 
        <div class="pull-right"> 
          <a title="close" href="javascript:;" class="btn-lg" onclick="closeRoutesModel()"> <i class="fa fa-times-circle fa-lg"></i> </a>
        </div>
        </div>
        <div id="route-dialog-content">
           {* <img src="assets/img/loaders/truck_loading.gif"> *}
        </div>
    </div>
</div>
<script type="text/javascript" src="assets/lib/leaflet/leaflet.js"></script>
<script>
    var loading_spinner = "<div class='text-center'><img src='{$base_url}/assets/img/loaders/20.gif' /></div>"
var result = {$result|json_encode}

        //  $("#search").on("input", function () {
        //     $(this).css('border', '');
        //     var searchTerm = $(this).val().toLowerCase();

        //     $(".message-box").each(function () {
        //         var isVisible = $(this).text().toLowerCase().includes(searchTerm);
        //         $(this).closest('tr').toggle(isVisible);
        //     });
        // });


// let table = $('#cargo_revenue_report_table').DataTable({

//         pageLength: 250,
//         lengthMenu: [
//             [50, 100, 250, 500, -1],
//             [50, 100, 250, 500, "All"]
//         ],
//         initComplete: function() {
//             var datatable = this.api();
//             datatable.columns().iterator('column', function(context, index) {
//                 var column = datatable.column(index);
//                 var columnData = column.data().unique();
//                 if (!columnData.length || !$(column.header()).hasClass('dt-filter')) return;

//                 var select = $(
//                         '<select class="form-control text-left"><option value="">Select</option></select>'
//                     )
//                     .attr('id', column.header().dataset.filterid)
//                     .appendTo(column.header())
//                     .on('click change', function(e) {
//                         if ($(this).val() == '') {
//                             column.search($(this).val(), false, false).draw();
//                             return false;
//                         }
//                         column.search("^" + $(this).val() + "$", true, false, true).draw();
//                         return false;
//                     });

//                 $(select).select2({ width: '100%' })

//                 columnData.sort().each(function(d) {
//                     select.append(new Option($('<div/>').html(d).text()))
//                 });
//             });
//         }
// });

$('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    function openRoutesModel(transitCode){
        $('#route-dialog').removeClass('hide');
            $('#route-dialog').dialog({
                autoOpen: true,
                height: $(window).height() - 30,
                width: $(window).width() - 100,
                modal: true,
                resizable: false,
                closeOnEscape: true
        });

        var data = {};
        data.transitCode = transitCode;
        $('#route-dialog-content').html(loading_spinner);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/ogpl-odometer-report',
            data: data,
            success: function(res) {
                $('#route-dialog-content').html(res);
                $('.demo').html(res);
            }
        });
    }
    function closeRoutesModel() {
            $('#route-dialog').addClass('hide');
            $('#route-dialog').dialog('destroy');
        }

        function toggleToBranchHidRow(code) {
        if ($('.saleusrlist').hasClass(code)) {
            $('.saleusrlist .slide').slideToggle('linear', function() {
                $('.saleusrlist').remove();
            });
            return;
        }
        $('.saleusrlist').remove();
        var $trows = $('.summary-to-branch').filter('.' + code);
        $('#' + code).after('<tr class="saleusrlist ' + code +
            '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">' +
            $trows.html() + '</table></div></td></tr>');
        $('.saleusrlist .slide').slideToggle('linear');
    }

    function filterBranch(branch) {
        var searchTerm = branch.toLowerCase();
        $(".message-box").each(function () {
            console.log($(this));
        var isVisible = $(this).text().toLowerCase().includes(searchTerm);
        $(this).closest('tr').toggle(isVisible);
        });
        $('html, body').animate({
            scrollTop: $('#cargo_revenue_report_table').offset().top - 35
        }, 'slow');
    }

</script>