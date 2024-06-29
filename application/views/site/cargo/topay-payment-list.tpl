<table id="topay_pmt_table" class="table table-bordered">
    <thead>
        <tr class="success">
            <td align="center">{lang('cargo_code_term')}</td>           
            <td align="center">Booked Date</td>
            <td align="center">User</td>    
            <td align="center">{lang('booking_from_term')}</td>                              
            <td align="center">{lang('booking_to_label')}</td>
            <td align="center">Cargo Status</td>
            <td align="center">Net Payable</td>
            <td align="center">Paid</td>
            <td align="center" width="100px">To Pay</td>
            {if $action_rights['CGO-ONBEHF-PAY']==1}
                <td align="center" width="200px">On Behalf Of</td>
            {/if}
            <td align="center" width="100px">Make Delivery</td>  
            <td align="center" width="150px">Action</td>  
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=tot_topay value=0}
        {foreach item=row from=$result key=t}
            <tr>                    
                <td align="center"><a href='javascript:;' class="bold" title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>  
                <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                <td align="left">{$row->user_first_name}</td> 
                <td align="left">{$row->from_organization_name}</td>                                
                <td align="left">{$row->to_organization_name}</td>
                <td align="center">{$cargo_status[$row->cargo_status_code]}</td>   
                <td align="right">{($row->total_amount+$row->total_handling_amount+$row->pickup_handling_amount+$row->total_unload_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge)|number_format:2}</td>
                <td align="right">{$row->transaction_amount|number_format:2}</td>
                <td align="right">
                    {assign var="rtopay" value=($row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_charge+$row->service_tax+$row->hamali_charge+$row->pass_charge+$row->docket_charge+$row->pod_charge)-$row->transaction_amount}
                    <input type="text" class="form-control topay-pmt-input" id="{$row->cargo_code}" value="{$rtopay|number_format:2:'.':''}">
                </td>                
                {if $action_rights['CGO-ONBEHF-PAY']==1}
                    <td align="left">
                        <select class='cd-on-behalf-user' id="behalf-{$row->cargo_code}" class="form-control">
                            <option  value="">Select a user</option>
                            {foreach name=o item=grpusr from=$groupusers.groups}
                                <optgroup label="{$grpusr->name}">
                                {foreach name=o item=usr from=$groupusers.users} 
                                    {if $usr.groupcode == $grpusr->code && $usr.activeFlag == 1}
                                        <option value="{$usr.code}" {if $usr.code == $user_login_code}selected{/if}>{$usr.name}</option>      
                                    {/if}
                                {/foreach}      
                                </optgroup>
                            {/foreach}                                 
                        </select>
                    </td>
                {/if}
                <td align="center"><input type="checkbox" id="delivery-{$row->cargo_code}" checked></td>
                <td align="center" id="{$row->cargo_code}-action">                  
                    <span class="act-loading"></span>
                    <span class="act-status"></span>
                    <button class="btn btn-sm btn-success save-btn" onclick="updateTopayPayment('{$row->cargo_code}');">Save</button>
                </td>
            </tr> 
        {/foreach}  
    </tbody>
</table>     
<script>
    $('.cd-on-behalf-user').select2({
        width: '100%'
    });
    $('#topay_pmt_table input').keypress(function(event) {
        if (event.keyCode == 13) {
            updateTopayPayment($(this).attr('id'));
        }
    });
</script>