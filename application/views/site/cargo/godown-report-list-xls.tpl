<table class="" width="99%" border='1'>
    <tr>
        <td colspan="8" align="center"><span style="font-weight:bold">Godown Report</span></td>
    </tr>
    <tr>
        <td width="50%"  colspan="4">
            <span style="font-weight:bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%" colspan="4">&nbsp;</td>
        <td width="50%" align="right" colspan="4"><span style="font-weight:bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<div class="table-responsive col-md-5 p_l_n">
    <table border='1'>
        <thead>
            <tr style="background-color: #64b92a">
                <td align="center"><b>{lang('cargo_code_term')}</b></td>          
                <td align="center"><b>Booked Date</b></td> 
                <td align="center"><b>{lang('booking_from_term')}</b></td>
                <td align="center"><b>User</b></td>                                 
                <td align="center"><b>{lang('booking_to_label')}</b></td>
                <td align="center"><b>{lang('booking_sender_term')}</b></td>
                <td align="center"><b>{lang('booking_receiver_term')}</b></td>
                <td align="center"><b>Payment Status</b></td>
                <td align="center"><b>Cargo Status</b></td>  
                <td align="center"><b>Qty</b></td> 
                <td align="center">Freight</td> 
            </tr>

        </thead>
        <tbody class="body_table" >
            
            {assign var=tot_fare value=0}
            {assign var=tot_items value=0}
                        
            {foreach item=row from=$result key=t}
                <tr>                    
                    <td align="center">{$row->cargo_code}</td> 
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="left">{$row->from_organization_name}</td>
                    <td align="left">{$row->user_first_name}</td>                                 
                    <td align="left">{$row->to_organization_name}</td>
                    <td align="left">{$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]} </td>           
                    <td align="center">{$row->total_item_count}</td>
                    <td align="right">{$row->total_amount|number_format:2}</td>
                    </td>
                </tr> 

                {assign var=tot_fare value=$tot_fare+$row->total_amount}                
                {assign var=tot_items value=$tot_items+$row->total_item_count}
            {/foreach}  
            
            <tr class="active">                    
                <td align="right" colspan="9" class="bold"><b>Total</b></td>
                <td align="center" class="bold"><b>{$tot_items}</b></td>
                <td align="center" class="bold"><b>{$tot_fare|number_format:2}</b></td>
            </tr>  

        </tbody>
    </table>
</div>