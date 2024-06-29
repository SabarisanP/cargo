<style>

    table td {
        background-color: white;
        width: 100%;
        font-size: 10px;
    }
    .bold {
        font-weight: bold;
        font-size: 10pt;
        padding: 15px;
       
    }
    .data {
        font-size: 9pt;
        padding: 15px;
    }
</style>

<div class="row">
    <div class="col-md-12">
        <table border="1" class="table">
            <thead>
                <tr class="bold" >
                    <td align="center" style="border: 1px solid block;  background-color: white; font-size: 10pt;">No.of Recepients</td>
                    <td style="border: 1px solid block; background-color: white; font-size: 10pt;"></td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">No.of Invoices</td>
                    <td style="border: 1px solid block; background-color: white; font-size: 10pt;"></td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Total Invoice Value</td>
                    <td style="border: 1px solid block; background-color: white; font-size: 10pt;"></td>
                    <td style="border: 1px solid block; background-color: white; font-size: 10pt;"></td>
                    <td style="border: 1px solid block; background-color: white; font-size: 10pt;"></td>
                    <td style="border: 1px solid block; background-color: white; font-size: 10pt;"></td>
                    <td style="border: 1px solid block; background-color: white; font-size: 10pt;"></td>
                    <td style="border: 1px solid block; background-color: white; font-size: 10pt;"></td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Total Taxable Amount</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Total Cess</td>
                </tr>
            </thead>
            <tbody>
                <tr class="data">
                    <td align="center" colspan="1" style="border: 1px solid block; font-size: 9pt; width:100%;"><b>{$noOfRecep}</b>
                    </td>
                    <td style="border: 1px solid block; font-size: 9pt; width:100%;"></td>
                    <td align="center" style="border: 1px solid block; font-size: 9pt;">{$noOfInvoice}</td>
                    <td style="border: 1px solid block; font-size: 9pt;"></td>
                    <td align="right" style="border: 1px solid block; font-size: 9pt;">{$totalAmount|ceil|number_format:2}</td>
                    <td style="border: 1px solid block; font-size: 9pt;"></td>
                    <td style="border: 1px solid block; font-size: 9pt;"></td>
                    <td style="border: 1px solid block; font-size: 9pt;"></td>
                    <td style="border: 1px solid block; font-size: 9pt;"></td>
                    <td style="border: 1px solid block; font-size: 9pt;"></td>
                    <td style="border: 1px solid block; font-size: 9pt;"></td>
                    <td align="right" style="border: 1px solid block; font-size: 9pt;">{$totalAmount|ceil|number_format:2}</td>
                    <td align="right" style="border: 1px solid block; font-size: 9pt;">{0.00|ceil|number_format:2}</td>
                </tr>
            </tbody>
            <thead>
                <tr class="bold">
                    <td align="center" width="100%" style="border: 1px solid block; background-color: white; font-size: 10pt;  width:100%;">GSTIN/UIN of Recipients</td>
                    <td align="center" width="100%" style="border: 1px solid block; background-color: white; font-size: 10pt;  width:100%;">Receiver Name</td> 
                        {* {lang('booking_receiver_term')}</td> *}
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;  width:100%;">Invoice Number</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Invoice Date</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Invoice Value</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Place Of Supply</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Reverse Charge</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Applicable % of Tax Rate</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Invoice Type</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">E-commerce</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Rate</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Taxable Value</td>
                    <td align="center" style="border: 1px solid block; background-color: white; font-size: 10pt;">Cess Amount</td>
                </tr>
            </thead>
            <tbody>
                {foreach item=row from=$result}
                    <tr class="data">
                        <td align="left" style="border: 1px solid block; font-size: 9pt; width:500px;  width:100%;">{$row->gstin}</td>
                        {* <td align="left" style="border: 1px solid block; font-size: 9pt;  width:100%;">{$row->customer_name} - {$row->customer_mobile|mask_mobileno}</td> *}
                        <td align="left" style="border: 1px solid block; font-size: 9pt;">{assign var=customer_parts value=explode('-', $row->customer_name)}{$customer_parts[0]}</td>
                        <td align="left" style="border: 1px solid block; font-size: 9pt;">{$row->transaction_code}</td>
                        
                        <td align="center" style="border: 1px solid block; font-size: 9pt;">{$row->transaction_at|date_format:"d-M-Y"}</td>
                        <td align="right" style="border: 1px solid block; font-size: 9pt;">{number_format($row->transaction_amount, 2)}</td>
                        
                        <td align="left" style="border: 1px solid block; font-size: 9pt;">{$row->gstin|substr:0:2}-{$row->state_name}</td>
                    
                        {if $row->tax_payer_type == 'REG'}
                            <td align="center" style="border: 1px solid block; font-size: 9pt;">Y</td>
                        {else}
                            <td align="center" style="border: 1px solid block; font-size: 9pt;">N</td>
                        {/if}
                        <td align="left" style="border: 1px solid block; font-size: 9pt;"> </td>
                        {if $row->tax_payer_type == 'REG'}
                            <td align="center" style="border: 1px solid block; font-size: 9pt;">Regular</td>
                        {else if $row->tax_payer_type == 'SEZ'}
                            <td align="center" style="border: 1px solid block; font-size: 9pt;">Special Economic Zone</td>
                        {else if $row->tax_payer_type == 'CMP'}
                            <td align="center" style="border: 1px solid block; font-size: 9pt;">Composition</td>
                        {else if $row->tax_payer_type == 'ISD'}
                            <td align="center" style="border: 1px solid block; font-size: 9pt;">Input Service Distributor</td>
                        {else if $row->tax_payer_type == 'TDS'}
                            <td align="center" style="border: 1px solid block; font-size: 9pt;">Tax Deductor at Source</td>
                        {else}
                            <td align="center" style="border: 1px solid block; font-size: 9pt;">Tax Collector at Source</td>
                        {/if}
                        <td align="left" style="border: 1px solid block; font-size: 9pt;"> </td>
                        <td align="right" style="border: 1px solid block; font-size: 9pt;">{number_format(5.00, 2)}</td>
                        <td align="right" style="border: 1px solid block; font-size: 9pt;">{number_format($row->transaction_amount,2)}</td>
                        <td align="left" style="border: 1px solid block; font-size: 9pt;"></td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td colspan="13" align="center" style="border: 1px solid block; font-size: 9pt;">No Records Found!</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
</div>


<script>
    var result = {$result|json_encode};
</script>