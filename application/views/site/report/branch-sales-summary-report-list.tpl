<table width="95%">
    <tr>
        <td width="50%">
            From  {$fromDate|date_format:$ns_date_format}  To {$toDate|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right">
            <span class="bold">Report Date/Time :</span> {date("d-m-Y h:i:s A")}
        </td>
    </tr>
</table>
        
{assign var=tot_paid value=0}
{assign var=tot_topay value=0}
{assign var=paid_lrcount value=0}
{assign var=topay_lrcount value=0}
{assign var=tot_net_amt value=0}
<div class="table-responsive">
    <table class="table table-bordered widthed">
        <thead>
            <tr class="success">                
                <td>Branch</td>
                <td>Lr Count</td>
                <td>Paid Amount</td>
                <td>Lr Count</td>
                <td>To Pay Amount</td>
                <td>Total Amount</td>           
            </tr>
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$result key=t}
                <tr>
                    <td>
                        <a href="javascript:;" onclick="getBranchSalesDetails('{$row->organization_code}', '{$fromDate}', '{$toDate}')">{$row->organization_name}</a>
                    </td>
                    <td align="center">{$row->paid_cargo_count}</td>

                    {assign var=paid value=$row->paid_booking_amount}
                    <td align="right">{$paid|inr_format:2}</td>
                    <td align="center">{$row->topay_delivery_count}</td>

                    {assign var=topay value=$row->topay_delivery_amount}
                    <td align="right">{$topay|inr_format:2}</td>
                    <td align="right">{($paid+$topay)|inr_format:2}</td>
                </tr>

                {assign var=tot_paid value=$tot_paid+$paid}
                {assign var=tot_topay value=$tot_topay+$topay}
                {assign var=paid_lrcount value=$paid_lrcount+$row->paid_cargo_count}
                {assign var=topay_lrcount value=$topay_lrcount+$row->topay_delivery_count}
                {assign var=tot_net_amt value=$tot_net_amt+$paid+$topay}
            {foreachelse}
                <tr>
                    <td align="center" colspan="5">No data found !!!!</td>
                </tr>
            {/foreach}
        </tbody>
        <tfoot>
            <tr class="active">                    
                <td>Grand Total</td>
                <td align="center">{$paid_lrcount}</td>
                <td align="right">{$tot_paid|inr_format:2}</td>  
                <td align="center">{$topay_lrcount}</td>
                <td align="right">{$tot_topay|inr_format:2}</td>
                <td align="right">{$tot_net_amt|inr_format:2}</td>
            </tr>
        </tfoot>
    </table>                
</div> 

<script>
    var fromDate = {$fromDate|json_encode}
    var toDate = {$toDate|json_encode}
</script>