<style>
    .table {
        width: 72%;
        margin-bottom: 20px;
    }

    th {
  text-align: center;
}
</style>

<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">GST Collection Report</span></td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">Date :</span> <b>{$from_date|date_format:$ns_date_format} to
                {$to_date|date_format:$ns_date_format}</b></td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> <b>{date("d-m-Y h:i A")}</b></td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br />
<div class="row">
    <div class="col-md-5">

        <h5 class="noprint"><b>Summary</b></h5>
        <table class="table table-bordered noprint" style="width:100%;">
            <thead>
                <tr class="info bold">
                    <th>No of Recepient</th>
                    <th>No of Invoice</th>
                    <th>Total Invoice</th>  
                    <th>Total Taxable Value</th>       
                    <th>Cess Amount</th>   
                </tr>
            </thead>
{*      
            {assign var=noOfRecp value=0}
            {assign var=noOfInv value=0}
            {assign var=TotInv value=0} *}
            <tbody>
            <tr class="active bold">
            <td class="text-right" colspan="1"><b>{$noOfRecep}</b></td>
            <td class="text-right">{$noOfInvoice}</td>
            <td class="text-right">{$totalAmount|ceil|number_format:2}</td>   
            <td class="text-right">{$totalAmount|ceil|number_format:2}</td>
            <td class="text-right">{0|ceil|number_format:2}</td>      
        </tr>
            </tbody>
        </table>

    </div>
</div>
{*    
{function name="gstTable" data=[]}         *}
    {* {if $data.data}     *}
        <h5><b> Transactions</b></h5>
        <div class="clearfix"></div>
        <div class="table-responsive" style="overflow: auto;">
            <table class="table table-bordered" width="58%" nowrap>
                <thead>
                    <tr class="success">
                        <td align="center">GSTIN/UIN</td>
                        <td align="center">{lang('booking_receiver_term')}</td>
                        <td align="center">Invoice Number</td>
                        <td align="center">Invoice Date</td>
                        <td align="center">Invoice Value</td>
                        <td align="center">Place Of Supply</td>
                        <td align="center">Reverse Charge</td>
                        <td align="center">Applicable % of Tax</td>
                        <td align="center">Invoice Type</td>
                        <td align="center">E-commerce GSTIN</td>
                        <td align="center">Rate</td>
                        <td align="center">Taxable Value</td>
                        <td align="center">Cess Amount</td>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$result}
                        <tr>
                            <td align="left">{$row->gstin}</td>
                            <td align="left">{$row->customer_name} - {$row->customer_mobile|mask_mobileno}</td>
                            <td align="left">{$row->transaction_code}</td>
                            <td align="left">{$row->transaction_at}</td>
                            <td align="left">{$row->transaction_amount}</td>
                            <td align="left">{$row->state_name}</td>
                            {if $row->tax_payer_type == 'REG'}
                                <td align="left">Yes</td>
                            {else}
                                <td align="left">No</td>
                            {/if}
                            <td align="left">NIL</td>
                            {if $row->tax_payer_type == 'REG'}
                                <td align="left">Regular</td>
                            {else if $row->tax_payer_type == 'SEZ'}
                                <td align="left">Special Economic Zone</td>
                            {else if $row->tax_payer_type == 'CMP'}
                                <td align="left">Composition</td>
                            {else if $row->tax_payer_type == 'ISD'}
                                <td align="left">Input Service Distributor</td>
                            {else if $row->tax_payer_type == 'TDS'}
                                <td align="left">Tax Deductor at Source</td>
                            {else}
                                <td align="left">Tax Collector at Source</td>
                            {/if}
                            <td align="left">NIL</td>
                            <td align="left">5%</td>
                            <td align="left">{$row->transaction_amount}</td>
                            <td align="left">NIL</td>

                        </tr>
                    {foreachelse}
                        <tr>
                            <td colspan="100%" align="center">No Records Found!</td>
                        </tr>
                    {/foreach}

                </tbody>
            </table>
        </div>




        <div class="clear_fix_both text-right">
            <div class="btn-group btn-group-sm">
                <button class="btn btn-default" onclick="exportCargoTransExcel();"><i
                        class="fa fa-download fa-lg"></i>Excel</button>
            </div>
        </div>

        <script>
            var result = {$result|json_encode};
        </script>