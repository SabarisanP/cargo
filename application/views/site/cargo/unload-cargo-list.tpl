 
<h5><b>{lang('lr')} List</b></h5>
<table id="dt_adv_booking_report_table" class="table table-bordered " style="width:99%" >
    <thead>
        <tr class="success">
            <td align="center"><input type="checkbox" onchange="selectAll(this);"/></td>
            <td align="center">{lang('lr')} No</td>           
            <td align="center">Booked Date</td> 
            <td align="center">Booked by</td>  
            <td align="center">{lang('booking_from_term')}</td>                                           
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">{lang('booking_sender_term')}</td>
            <td align="center">{lang('booking_receiver_term')}</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td> 
            <td align="center">Items</td>
            <td align="center">Qty</td> 
            <td align="center">Payable</td>
        </tr>

    </thead>
    <tbody class="body_table" >
                    
        {foreach item=row from=$result key=t}
            <tr>            
                <td align="center"><input type="checkbox" class='lritems' data-from='{$row->from_station_code}' data-to='{$row->to_station_code}' onchange="selectBooking(this)" data-items='{$row->total_item_count}' value="{$row->cargo_code}" /></td>
                <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>    
                <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->user_first_name}</td>    
                <td align="left">{$row->from_organization_name} - {$row->from_station_name}</td>                                             
                <td align="left">{$row->to_organization_name} - {$row->to_station_name}</td>
                <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile}</td>
                <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile}</td>
                <td align="left">
                    {$row->payment_status_code|_cargo_payment_status_badge}
                </td> 
                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>        
                <td align="left">{$row->cargo_item_name}</td>
                <td align="center">{$row->total_item_count}</td>                
                <td align="right">{$row->total_booking_amount+$row->total_handing_amount+$row->total_unload_handling_amount+$row->total_handing_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax}</td>
            </tr> 

        {/foreach}  

    </tbody>
</table> 
        
        <div id='loadpanel' class='well well-sm' style='position: fixed; top:50px; right:40px; width: 300px; padding: 10px; border: 1px solid #ccc;'>           
                
            <div class="panel panel-default" >
                <div class="panel-body">                 
                    <div class="form-group">
                        <span class='bold'>Total {lang('lr')} :</span> <span id='flrcount'>0</span>
                    </div>
                    <div class="form-group">
                        <span class='bold'>Total Items :</span> <span id='fitemcount'>0</span>
                    </div>
                            
                    <div class="form-group">
                        <div id='form-action' class="alert"></div>
                        
                        <div class="text-right" id='form-bttons'>
                            <button class="btn btn-success" type="button"  onclick="unloadBookings();">Unload</button>&nbsp;
                        </div>
                        
                        
                    </div>
                </div>
            </div> 
            
        </div>
        
<script>
    var lrlist = {$result|json_encode};
    
    function selectAll(value){
        if($(value).is(":checked")){
            $('input[class=lritems]').each(function() {
                $(this).prop('checked', true);
                selectBooking(this);
            });
        } else {
            $('input[class=lritems]').each(function() {
                $(this).prop('checked', false);
                selectBooking(this);
            });
        }
    }
</script>
