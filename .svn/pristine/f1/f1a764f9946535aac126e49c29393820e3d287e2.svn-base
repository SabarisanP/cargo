<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>User Booking and delivery Report</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
    </tr>
</table>

<table  border='1'>
    <thead>
        <tr style="background-color: #64b92a; color: #fff;">
            <td align="center" rowspan="2">User</td>
            <td align="center" rowspan="2">{lang('lr')} Count</td>
            <td align="center" colspan="4">Booking</td>
            <td align="center" colspan="4">ToPay Delivery Commission</td>
            <td align="center" colspan="2">Delivery</td>
            <td align="center" rowspan="2">Net Payable (H = C+ F -G)</td>
        </tr>
        <tr style="background-color: #64b92a; color: #fff;">
            <!-- booking CGBO -->
            <td align="center">{lang('lr')} Count</td>
            <td align="center">Net Amount (A)</td>
            <td align="center">Commission (B)</td>
            <td align="center">Payable (C = A-B)</td>
            <!-- TO pay then Paid CGTBO -->
            <td align="center">{lang('lr')} Count</td>
            <td align="center">Net Amount (D)</td>
            <td align="center">Commission (E)</td>
            <td align="center">Payable (F =D-E)</td>
            <!-- Delivery CGDL -->
            <td align="center">{lang('lr')} Count</td>
            <td align="center">Commission(G)</td>
        </tr>
    </thead>
    <tbody>
        {assign var=tot_lr value=0}
        
        {assign var=cgbo_count value=0}
        {assign var=cgbo_netpay value=0}
        {assign var=cgbo_comm value=0}
        
        {assign var=cgtbo_count value=0}
        {assign var=cgtbo_netpay value=0}
        {assign var=cgtbo_comm value=0}
        
        {assign var=cgdl_count value=0}
        {assign var=cgdl_comm value=0}
        
        {assign var=tot_net value=0}
        
        {assign var=cgbo_payable value=0}
        {assign var=cgtbo_payable value=0}
        {assign var=cgdl_payable value=0}
        
        {assign var=tot_net value=0}

        {foreach item=row from=$summary key=user}
            <tr>
                <td align="left"><a href="javascript:;" onclick="userCollectionTable('{$row['user_code']}');">{$user}</a></td>
                <td align="right">{$row['CGBO']['count'] + $row['CGTBO']['count'] + $row['CGDL']['count']}</td>
                 <!-- booking CGBO -->
                <td align="right">{$row['CGBO']['count']+0}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row['CGBO']['net_amount']}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row['CGBO']['commission']}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row['CGBO']['payable']}</td>
                 <!-- TO pay then Paid CGTBO -->
                <td align="right">{$row['CGTBO']['count']+0}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row['CGTBO']['net_amount']}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row['CGTBO']['commission']}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row['CGTBO']['payable']}</td>
                <!-- CGDL -->
                <td align="right">{$row['CGDL']['count']+0}</td>
                <td align="right" data-format="{$xlformat['currency']}">{$row['CGDL']['commission']}</td>
                
                
                <td align="right" data-format="{$xlformat['currency']}">{($row['CGBO']['payable'] + $row['CGTBO']['payable'] - $row['CGDL']['commission'])}</td>
            </tr>
            {assign var=tot_lr value=$tot_lr + $row['CGBO']['count'] + $row['CGTBO']['count'] + $row['CGDL']['count']}
            {assign var=cgbo_count value=$cgbo_count + $row['CGBO']['count']}
            {assign var=cgbo_netpay value=$cgbo_netpay + $row['CGBO']['net_amount']}
            {assign var=cgbo_comm value=$cgbo_comm + $row['CGBO']['commission']}
            {assign var=cgbo_payable value=$cgbo_payable + $row['CGBO']['payable']}
            
            {assign var=cgtbo_count value=$cgtbo_count + $row['CGTBO']['count']}
            {assign var=cgtbo_netpay value=$cgtbo_netpay + $row['CGTBO']['net_amount']}
            {assign var=cgtbo_comm value=$cgtbo_comm + $row['CGTBO']['commission']}
            {assign var=cgtbo_payable value=$cgtbo_payable + $row['CGTBO']['payable']}
            
            {assign var=cgdl_count value=$cgdl_count + $row['CGDL']['count']}
            {assign var=cgdl_comm value=$cgdl_comm + $row['CGDL']['commission']}
            
            {assign var=tot_net value=$tot_net + ($row['CGBO']['payable'] + $row['CGTBO']['payable'] - $row['CGDL']['commission'])}
        {/foreach}
    </tbody>
    {if $summary|count}
        <tfoot>
            <tr class="active">
                <td align="right" colspan="1" class="bold">Total</td>
                <td align="right" class="bold">{$tot_lr}</td>
                <td align="right" class="bold">{$cgbo_count}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgbo_netpay}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgbo_comm}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgbo_payable}</td>
                
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgtbo_count}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgtbo_netpay}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgtbo_comm}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgtbo_payable}</td>
                
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgdl_count}</td>
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$cgdl_comm}</td>
                
                <td align="right" class="bold" data-format="{$xlformat['currency']}">{$tot_net}</td>
            </tr>
        </tfoot>
    {else}
        <tfoot>
            <tr>
                <td colspan="10" align="center">No Records Found</td>
            </tr>
        </tfoot>
    {/if}
</table>
