<link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
<!--<link href="{$base_url}assets/css/print-medium.css?{$asset_ver}" rel="stylesheet">-->

    <table class="remove-border-top" cellpadding="5"  width="98%">
        <tr>
            <td width="100%" align="center" colspan="2">
                <h2>Agent Payment Collection Sheet</h2>
            </td>
        </tr>
        <tr>
            <td width='70%' align="left">
                <span style="font-weight:bold">Route : </span> {$smarty.request.route} &nbsp;&nbsp;&nbsp;
                
                <span style="font-weight:bold">Travel Date : </span>{$smarty.request.date|date_format:$ns_date_format}
            </td>
            <td width="30%" align="right" style="font-size:10px">Printed By {$tickets['user']} @ {date("d/m/Y h:i A")} </td>
        </tr>
    </table>

    <table class="table table-bordered" cellpadding="5" width="98%">
        <tr class="info bold">  
            <th rowspan="2" align="center">Name</th> 
            
            <th colspan="4" align="center">Booking</th>
            <th colspan="3" align="center">Cancellation</th>
            
            <th rowspan="2" align="center">Net Payable</th>            
        </tr>
        <tr class="info bold">            
            <th rowspan="2" align="center">Fare</th>
            <th rowspan="2" align="center">Commission</th>
            <th rowspan="2" align="center">A/C Tax</th>
            <th rowspan="2" align="center">Sub Total</th>
            
            <th rowspan="2" align="center">Fare</th>
            <th rowspan="2" align="center">Refund</th>   
            <th rowspan="2" align="center">Cancel Charges</th>                                 
        </tr>
        <tbody
        {assign var="bo_tk" value=0}    
        {foreach item=ticket from=$tickets key=t}   
            {if $ticket['bo_fare'] > 0 || $ticket['ca_fare'] > 0}
            <tr>                    
                <td align="left">{$ticket['agent_name']}</td>
                
                <td align="right">{$ticket['bo_fare']|number_format:2}</td>
                <td align="right">{$ticket['bo_comission']|number_format:2}</td>
                <td align="right">{$ticket['bo_ac_tax']|number_format:2}</td>
                <td align="right">{$ticket['bo_payable']|number_format:2}</td>
                
                <td align="right">{$ticket['ca_fare']|number_format:2}</td>
                <td align="right">{$ticket['ca_refund']|number_format:2}</td>
                <td align="right">{$ticket['ca_charges']|number_format:2}</td>
                
                <td align="right" style="font-weight: bold">
                    {$tot = $ticket['bo_payable']+$ticket['ca_charges']}
                    {$tot|number_format:2}
                </td>
                {assign var="bo_tk" value=$bo_tk+$tot}
            </tr>
            {/if}
        {/foreach}         
            <tr>                    
                <td align="right" colspan="8" style="font-weight: bold">Total </td>                
                <td align="right" style="font-weight: bold">{$bo_tk|number_format:2}</td>
            </tr>
        </tbody>
    </table>
    <br/>
              
    <script>
        window.print();
    </script>    
