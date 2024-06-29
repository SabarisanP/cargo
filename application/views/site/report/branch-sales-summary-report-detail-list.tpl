{* paid *}
{assign var=tot_articles value=0}
{assign var=tot_freight value=0}
{assign var=tot_loading_charge value=0}
{assign var=tot_unloading_charge value=0}
{assign var=tot_gst value=0}
{assign var=tot_other_charge value=0}
{assign var=tot_net_amt value=0}

{* topay *}
{assign var=tot_topay_articles value=0}
{assign var=tot_topay_freight value=0}
{assign var=tot_topay_loading_charge value=0}
{assign var=tot_topay_unloading_charge value=0}
{assign var=tot_topay_gst value=0}
{assign var=tot_topay_other_charge value=0}
{assign var=tot_topay_net_amt value=0}
<div class="table-responsive">
    <h5 class="bold ft_14">To Pay</h5>
    {* to pay *}
    <table class="table table-bordered-light">
        <thead>
            <tr class="success">                
                <td>S. No</td>
                <td>Booked Date</td>
                <td>Cargo Code</td>
                <td>Branch</td>
                <td>Payment Status</td>
                <td>No. of Articles</td>
                <td>Freight</td>
                <td>L. Charges</td>
                <td>UL. Charges</td>
                <td>GST</td>
                <td>Other Charges</td>
                <td>Net Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$details['TOP'] key=t}
                {assign var=topay_net_amt value=0}
                <tr>
                    <td>{$t+1}</td>
                    <td>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td>{$row->cargo_code}</td>
                    <td>{$row->from_organization_name} - {$row->to_organization_name}</td>
                    <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                    <td align="center">{$row->total_item_count}</td>
                    <td >{$row->total_amount|inr_format:2}</td>
                    <td >{$row->total_handling_amount|inr_format:2}</td>
                    <td >{$row->total_unload_handling_amount|inr_format:2}</td>
                    <td >{$row->service_tax|inr_format:2}</td>
                    <td >
                        {$row->other_charges_amount|inr_format:2}

                        {if $row->other_charges_amount != 0}
                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                <table>
                                    {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                        {if $cv == 0}
                                            {continue}
                                        {/if}
                                        <tr>
                                            <td><b>{$ck|_camelcase_to_titlecase}</b></td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                        </tr>
                                    {/foreach}
                                </table>
                            '></i>
                        {else}
                            <i class="fa fa-info-circle fa-inverse"></i>
                        {/if}
                    </td>

                    {assign var=topay_net_amt value=$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->other_charges_amount}
                    <td >{$topay_net_amt|inr_format:2}</td>
                </tr>

                {assign var=tot_topay_articles value=$tot_topay_articles+$row->total_item_count}
                {assign var=tot_topay_freight value=$tot_topay_freight+$row->total_amount}
                {assign var=tot_topay_loading_charge value=$tot_topay_loading_charge+$row->total_handling_amount}
                {assign var=tot_topay_unloading_charge value=$tot_topay_unloading_charge+$row->total_unload_handling_amount}
                {assign var=tot_topay_gst value=$tot_topay_gst+$row->service_tax}
                {assign var=tot_topay_other_charge value=$tot_topay_other_charge+$row->other_charges_amount}
                {assign var=tot_topay_net_amt value=$tot_topay_net_amt+$topay_net_amt}
            {foreachelse}
                <tr>
                    <td align="center" colspan="12">No data found !!!!</td>
                </tr>
            {/foreach}
        </tbody>
        <tfoot>
            <tr class="active">                    
                <td colspan="5" align="right">Grand Total</td>
                <td align="center">{$tot_topay_articles}</td>  
                <td >{$tot_topay_freight|inr_format:2}</td>  
                <td >{$tot_topay_loading_charge|inr_format:2}</td>  
                <td >{$tot_topay_unloading_charge|inr_format:2}</td>  
                <td >{$tot_topay_gst|inr_format:2}</td>  
                <td >{$tot_topay_other_charge|inr_format:2}</td>
                <td >{$tot_topay_net_amt|inr_format:2}</td>
            </tr>
        </tfoot>
    </table>  

    <h5 class="bold ft_14">Paid</h5>
    {* paid *}
    <table class="table table-bordered-light">
        <thead>
            <tr class="success">
                <td>S. No</td>
                <td>Booked Date</td>
                <td>Cargo Code</td>
                <td>Branch</td>
                <td>Payment Status</td>
                <td>No. of Articles</td>
                <td>Freight</td>
                <td>L. Charges</td>
                <td>UL. Charges</td>
                <td>GST</td>
                <td>Other Charges</td>
                <td>Net Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">               
            {foreach item=row from=$details['PAD'] key=t}
                {assign var=net_amt value=0}
                <tr>
                    <td>{$t+1}</td>
                    <td>{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td>{$row->cargo_code}</td>
                    <td>{$row->from_organization_name} - {$row->to_organization_name}</td>
                    <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                    <td align="center">{$row->total_item_count}</td>
                    <td >{$row->total_amount|inr_format:2}</td>
                    <td >{$row->total_handling_amount|inr_format:2}</td>
                    <td >{$row->total_unload_handling_amount|inr_format:2}</td>
                    <td >{$row->service_tax|inr_format:2}</td>

                    <td >
                        {$row->other_charges_amount|inr_format:2}
                        
                        {if $row->other_charges_amount != 0}
                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                <table>
                                    {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                        {if $cv == 0}
                                            {continue}
                                        {/if}
                                        <tr>
                                            <td><b>{$ck|_camelcase_to_titlecase}</b></td>
                                            <td>&ensp;:&ensp;</td>
                                            <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                        </tr>
                                    {/foreach}
                                </table>
                            '></i>
                        {else}
                            <i class="fa fa-info-circle fa-inverse"></i>
                        {/if}
                    </td>

                    {assign var=net_amt value=$row->total_amount+$row->total_handling_amount+$row->total_unload_handling_amount+$row->pickup_handling_amount+$row->delivery_handling_amount+$row->service_tax+$row->other_charges_amount}
                    <td >{$net_amt|inr_format:2}</td>
                </tr>

                {assign var=tot_articles value=$tot_articles+$row->total_item_count}
                {assign var=tot_freight value=$tot_freight+$row->total_amount}
                {assign var=tot_loading_charge value=$tot_loading_charge+$row->total_handling_amount}
                {assign var=tot_unloading_charge value=$tot_unloading_charge+$row->total_unload_handling_amount}
                {assign var=tot_gst value=$tot_gst+$row->service_tax}
                {assign var=tot_other_charge value=$tot_other_charge+$row->other_charges_amount}
                {assign var=tot_net_amt value=$tot_net_amt+$net_amt}
            {foreachelse}
                <tr>
                    <td align="center" colspan="12">No data found !!!!</td>
                </tr>
            {/foreach}
        </tbody>
        <tfoot>
            <tr class="active">                    
                <td colspan="5" align="right">Grand Total</td>
                <td align="center">{$tot_articles}</td>  
                <td >{$tot_freight|inr_format:2}</td>  
                <td >{$tot_loading_charge|inr_format:2}</td>  
                <td >{$tot_unloading_charge|inr_format:2}</td>  
                <td >{$tot_gst|inr_format:2}</td>  
                <td >{$tot_other_charge|inr_format:2}</td>
                <td >{$tot_net_amt|inr_format:2}</td>
            </tr>
        </tfoot>
    </table>                
</div> 

<script>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
</script>