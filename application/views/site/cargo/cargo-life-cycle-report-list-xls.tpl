<table class="" width="99%" border='1'>
    <tr>
        <td colspan="8" align="center"><span style="font-weight:bold">Cargo Life Cycle Report</span></td>
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
            <tr style="background-color: #64b92a; color: #fff;">
                <td rowspan="2" align="center">{lang('lr')}</td>
                <td colspan="8" align="center">Booked</td>
                <td colspan="8" align="center">Load</td>
                <td colspan="3" align="center">Unload</td>
                <td colspan="3" align="center">Delivery</td>
            </tr>
            <tr style="background-color: #64b92a; color: #fff;">
                <td nowrap>Date Time</td>
                <td nowrap>User</td>
                <td nowrap>Payment Type</td>
                <td nowrap>From Station/Branch</td>
                <td nowrap>To Station/Branch</td>
                <td nowrap>Total Freight</td>
                <td nowrap>Other Changes</td>
                <td nowrap>Total</td>
                <td nowrap>Transit Start On With Age</td>
                <td nowrap>Date Time</td>
                <td nowrap>Vehicle</td>
                <td nowrap>Driver</td>
                <td nowrap>{lang('ogpl')} Code</td>
                <td nowrap>To Station Branch</td>
                <td nowrap>User</td>
                <td nowrap>Delivery Branch (Y/N)</td>
                <td nowrap>Date Time</td>
                <td nowrap>Branch</td>
                <td nowrap>User</td>
                <td nowrap>Ready For Datetime With Age</td>
                <td nowrap>User</td>
                <td nowrap>Date Time</td>
            </tr>
        </thead>
        <tbody>

            {foreach item=row from=$result}
                <tr>
                    <td align="left" nowrap>{$row->cargo_code}</td>
                    <td align="left" nowrap>{$row->booked_at|date_format:$ns_datetime_format|default:'-'}</td>
                    <td align="left" nowrap>{$row->booked_user_first_name|default:'-'}</td>
                    <td align="center" nowrap id="pay_state_{$row->cargo_code}">
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>
                    <td align="left" nowrap>{$row->from_organization_name|default:'-'}</td>
                    <td align="left" nowrap>{$row->to_organization_name|default:'-'}</td>
                    <td align="right" nowrap>{$row->total_amount|inr_format}</td>
                    <td align="right" nowrap>{$row->other_charges_amount|inr_format}</td>
                    <td align="right" nowrap>{($row->total_amount + $row->other_charges_amount + $row->service_charge + $row->service_tax + $row->total_handling_amount + $row->total_unload_handling_amount)|inr_format}</td>
                    <td align="center" nowrap>
                        {if $row->unloaded_at}
                            {assign var="days" value=$row->unloaded_at|daysBetween:$row->booked_at}
                            {if $days == 0}
                                Same day
                            {elseif $days == 1}
                                Next day
                            {else}
                                {$days} days
                            {/if} 
                        {else}-{/if}
                    </td>
                    <td align="left" nowrap>{$row->unloaded_at|date_format:$ns_datetime_format|default:'-'}</td>
                    <td align="left" nowrap>{$row->registration_numer|default:'-'}</td>
                    <td align="left" nowrap>{$row->driver_name|default:'-'}</td>
                    <td align="left" nowrap>{$row->alias_code|default:'-'}</td>
                    <td align="left" nowrap>{$row->loaded_to_organization_name|default:'-'}</td>
                    <td align="left" nowrap>{$row->loaded_user_first_name|default:'-'}</td>
                    <td align="center" nowrap>{if $row->loaded_to_organization_name === $row->to_organization_name}Yes{else}No{/if}</td>
                    <td align="left" nowrap>{$row->unloaded_at|date_format:$ns_datetime_format|default:'-'}</td>
                    <td align="left" nowrap>{$row->unloaded_organization_name|default:'-'}</td>
                    <td align="left" nowrap>{$row->unloaded_user_first_name|default:'-'}</td>
                    <td align="center" nowrap>
                        {if $row->delivered_at}                            
                            {assign var="days" value=$row->delivered_at|daysBetween}
                            {if $days == 0}
                                Same day
                            {elseif $days == 1}
                                Next day
                            {else}
                                {$days} days
                            {/if} 
                        {else}-{/if}</td>
                    <td align="left" nowrap>{$row->delivered_user_first_name|default:'-'}</td>
                    <td align="left" nowrap>{$row->delivered_at|date_format:$ns_datetime_format|default:'-'}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>