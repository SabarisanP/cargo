<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">GST Collection Report</td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report For: </span> 
            {$smarty.request.from_date|date_format:$ns_date_format}  to {$smarty.request.to_date|date_format:$ns_date_format} 
        </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {date("d-m-Y h:i A")}</td>
    </tr>

</table>

<div class="row">
    <div class="col-md-4">
        <h5><b>Booking</b></h5>

        {assign var="b_turnover" value=0}
        {assign var="b_sgst" value=0}
        {assign var="b_cgst" value=0}
        {assign var="b_igst" value=0}
        {assign var="b_tax" value=0}
        
        <table id="dt_bp_report_table" class="table table-bordered">
            <thead>
                <tr>
                    <td align="center" class="bold">Category</td>
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">
            {foreach item=group from=$groups key=grp}

                {if $booking[$group]['turnover'] > 0 || $booking[$group]['sgst'] > 0 || $booking[$group]['cgst'] > 0 || $booking[$group]['igst'] > 0}
                    <tr>                    
                        <td align="left">{$group}</td>
                        <td align="right">{$booking[$group]['turnover']}</td>
                        <td align="right">{$booking[$group]['sgst']|inr_format}</td>
                        <td align="right">{$booking[$group]['cgst']|inr_format}</td>
                        <td align="right">{$booking[$group]['igst']|inr_format}</td>
                        <td align="right">{($booking[$group]['sgst']+$booking[$group]['cgst']+$booking[$group]['igst'])|inr_format}</td>
                    </tr>

                    {assign var="b_turnover" value=$b_turnover+$booking[$group]['turnover']}
                    {assign var="b_sgst" value=$b_sgst+$booking[$group]['sgst']}
                    {assign var="b_cgst" value=$b_cgst+$booking[$group]['cgst']}
                    {assign var="b_igst" value=$b_igst+$booking[$group]['igst']}
                    {assign var="b_tax" value=$b_tax+$booking[$group]['sgst']+$booking[$group]['cgst']+$booking[$group]['igst']}
                {/if}

            {/foreach}
                <tr>      
                    <td align="left">&nbsp;</td>
                    <td align="right" class="bold">{$b_turnover}</td>
                    <td align="right" class="bold">{$b_sgst|inr_format}</td>
                    <td align="right" class="bold">{$b_cgst|inr_format}</td>
                    <td align="right" class="bold">{$b_igst|inr_format}</td>
                    <td align="right" class="bold">{($b_sgst+$b_cgst+$b_igst)|inr_format}</td>
                </tr>
            </tbody>
        </table>
            
    </div>
    <div class="col-md-4">
        <h5><b>Cancellation Refunds</b></h5>   
        
        {assign var="c_turnover" value=0}
        {assign var="c_sgst" value=0}
        {assign var="c_cgst" value=0}
        {assign var="c_igst" value=0}
        {assign var="c_tax" value=0}
        
        <table id="dt_bp_report_table" class="table table-bordered " >
            <thead>
                <tr>
                    <td align="left" class="bold">Category</td>
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">                        
            {foreach item=group from=$groups key=grp}
                {if $cancel[$group]['turnover'] > 0 || $cancel[$group]['sgst'] > 0 || $cancel[$group]['cgst'] > 0 || $cancel[$group]['igst'] > 0}
                    <tr>
                        <td align="left">{$group}</td>
                        <td align="right">{$cancel[$group]['turnover']}</td>
                        <td align="right">{$cancel[$group]['sgst']|inr_format}</td>
                        <td align="right">{$cancel[$group]['cgst']|inr_format}</td>
                        <td align="right">{$cancel[$group]['igst']|inr_format}</td>
                        <td align="right">{($cancel[$group]['sgst']+$cancel[$group]['cgst']+$cancel[$group]['igst'])|inr_format}</td>
                    </tr>
                    {assign var="c_turnover" value=$c_turnover+$cancel[$group]['turnover']}
                    {assign var="c_sgst" value=$c_sgst+$cancel[$group]['sgst']}
                    {assign var="c_cgst" value=$c_cgst+$cancel[$group]['cgst']}
                    {assign var="c_igst" value=$c_igst+$cancel[$group]['igst']}
                    {assign var="c_tax" value=$c_tax+$cancel[$group]['sgst']+$cancel[$group]['cgst']+$cancel[$group]['igst']}
                {/if}
            {/foreach}
                <tr>
                    <td align="left">&nbsp;</td>
                    <td align="right" class="bold">{$c_turnover}</td>
                    <td align="right" class="bold">{$c_sgst|inr_format}</td>
                    <td align="right" class="bold">{$c_cgst|inr_format}</td>
                    <td align="right" class="bold">{$c_igst|inr_format}</td>
                    <td align="right" class="bold">{($c_sgst+$c_cgst+$c_igst)|inr_format}</td>
                </tr>
            </tbody>
        </table>

    </div>
    
    <div class="col-md-4">
        <h5><b>Summary</b></h5>   
        <table id="dt_bp_report_table" class="table table-bordered " >
            <thead>
                <tr class="success">
                    <td align="center" class="bold">Type</td>
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">
                <tr>                    
                    <td>Sales</td>
                    <td align="right">{$b_turnover|inr_format}</td>
                    <td align="right">{$b_sgst|inr_format}</td>
                    <td align="right">{$b_cgst|inr_format}</td>
                    <td align="right">{$b_igst|inr_format}</td>
                    <td align="right">{($b_sgst+$b_cgst+$b_igst)|inr_format}</td>
                </tr>
                <tr>                    
                    <td>Return</td>
                    <td align="right">{$c_turnover|inr_format}</td>
                    <td align="right">{$c_sgst|inr_format}</td>
                    <td align="right">{$c_cgst|inr_format}</td>
                    <td align="right">{$c_igst|inr_format}</td>
                    <td align="right">{($c_sgst+$c_cgst+$c_igst)|inr_format}</td>
                </tr>
                <tr>                    
                    <td class="bold">Payable</td>
                    <td class="bold" align="right">{($b_turnover-$c_turnover)|inr_format}</td>
                    <td class="bold" align="right">{($b_sgst-$c_sgst)|inr_format}</td>
                    <td class="bold" align="right">{($b_cgst-$c_cgst)|inr_format}</td>
                    <td class="bold" align="right">{($b_igst-$c_igst)|inr_format}</td>
                    <td class="bold" align="right">{(($b_sgst+$b_cgst+$b_igst)-($c_sgst+$c_cgst+$c_igst))|inr_format}</td>
                </tr>
            </tbody>
        </table>
    </div>
                
</div>    
    

    
   
    
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportGSTExcelGSTwise()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>   
<iframe name="ifrm_boarding_downloader" id="ifrm_boarding_downloader" style="display:none" ></iframe>   

     