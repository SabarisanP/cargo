<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Godown Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<div class="overflow-x-auto">
    <table id="cargo_revenue_report_table" class="table table-bordered " style="width:99%">
        <thead>
            <tr class="success">
                <td align="center">{lang('cargo_code_term')}</td>           
                <td align="center">Booked Date</td> 
                <td align="center">{lang('booking_from_term')}</td>
                <td align="center">User</td>                                 
                <td align="center">{lang('booking_to_label')}</td>
                <td align="center">{lang('booking_sender_term')}</td>
                <td align="center">{lang('booking_receiver_term')}</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>  
                <td align="center">Qty</td> 
                <td align="center">Freight</td> 
            </tr>

        </thead>
        <tbody class="body_table" >
            
            {assign var=tot_fare value=0}
            {assign var=tot_items value=0}
                        
            {foreach item=row from=$result key=t}
                <tr>                    
                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>  
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->user_first_name}</td>                                 
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="center">
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td> 
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>          
                    <td align="center">{$row->total_item_count}</td>   
                    <td align="right">{$row->total_amount|number_format:2}</td>
                </tr> 

                {assign var=tot_fare value=$tot_fare+$row->total_amount}
                {assign var=tot_items value=$tot_items+$row->total_item_count}
            {/foreach}  
            
            <tr class="active">                    
                <td align="right" colspan="9" class="bold">Total</td>  
                <td align="center" class="bold">{$tot_items}</td>
                <td align="right" class="bold">{$tot_fare|number_format:2}</td>
            </tr>  

        </tbody>
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportGodownExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>