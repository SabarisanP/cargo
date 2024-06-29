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

        {foreach item=tax from=$gst key=taxcode}

            {if $booking[$taxcode]['turnover'] > 0 || $booking[$taxcode]['sgst'] > 0 || $booking[$taxcode]['cgst'] > 0 || $booking[$taxcode]['igst'] > 0}       

                <div class="bold">State : {$tax['state']} - {$tax['gstin']}</div>
                <table id="dt_bp_report_table" class="table table-bordered">
                    <thead>
                        <tr>
                            <td align="center" class="bold">Turnover</td>
                            <td align="center" class="bold">SGST ({$tax['sgstSlab']}%)</td>
                            <td align="center" class="bold">CGST ({$tax['cgstSlab']}%)</td>
                            <td align="center" class="bold">IGST ({$tax['igstSlab']}%)</td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        <tr>                    
                            <td align="right">{$booking[$taxcode]['turnover']}</td>
                            <td align="right">{$booking[$taxcode]['sgst']|inr_format}</td>
                            <td align="right">{$booking[$taxcode]['cgst']|inr_format}</td>
                            <td align="right">{$booking[$taxcode]['igst']|inr_format}</td>
                        </tr>
                    </tbody>
                </table>

                {assign var="b_turnover" value=$b_turnover+$booking[$taxcode]['turnover']}
                {assign var="b_sgst" value=$b_sgst+$booking[$taxcode]['sgst']}
                {assign var="b_cgst" value=$b_cgst+$booking[$taxcode]['cgst']}
                {assign var="b_igst" value=$b_igst+$booking[$taxcode]['igst']}
                {assign var="b_tax" value=$b_tax+$booking[$taxcode]['sgst']+$booking[$taxcode]['cgst']+$booking[$taxcode]['igst']}
            {/if}

        {/foreach}

        <div class="bold">Total</div>
        <table id="dt_bp_report_table" class="table table-bordered " >
            <thead>
                <tr class="success">
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">
                <tr>                    
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

        {foreach item=tax from=$gst key=taxcode}

            {if $cancel[$taxcode]['turnover'] > 0 || $cancel[$taxcode]['sgst'] > 0 || $cancel[$taxcode]['cgst'] > 0 || $cancel[$taxcode]['igst'] > 0}       

                <div class="bold">State : {$tax['state']} - {$tax['gstin']}</div>
                <table id="dt_bp_report_table" class="table table-bordered " >
                    <thead>
                        <tr>
                            <td align="center" class="bold">Turnover</td>
                            <td align="center" class="bold">SGST ({$tax['sgstSlab']}%)</td>
                            <td align="center" class="bold">CGST ({$tax['cgstSlab']}%)</td>
                            <td align="center" class="bold">IGST ({$tax['igstSlab']}%)</td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        <tr>                    
                            <td align="right">{$cancel[$taxcode]['turnover']}</td>
                            <td align="right">{$cancel[$taxcode]['sgst']|inr_format}</td>
                            <td align="right">{$cancel[$taxcode]['cgst']|inr_format}</td>
                            <td align="right">{$cancel[$taxcode]['igst']|inr_format}</td>
                        </tr>
                    </tbody>
                </table>

                {assign var="c_turnover" value=$c_turnover+$cancel[$taxcode]['turnover']}
                {assign var="c_sgst" value=$c_sgst+$cancel[$taxcode]['sgst']}
                {assign var="c_cgst" value=$c_cgst+$cancel[$taxcode]['cgst']}
                {assign var="c_igst" value=$c_igst+$cancel[$taxcode]['igst']}
                {assign var="c_tax" value=$c_tax+$cancel[$taxcode]['sgst']+$cancel[$taxcode]['cgst']+$cancel[$taxcode]['igst']}
            {/if}

        {/foreach}

        <div class="bold">Total</div>
        <table id="dt_bp_report_table" class="table table-bordered " >
            <thead>
                <tr class="success">
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">
                <tr>                    
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
        <button class="btn btn-default" onclick="exportBoardingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>   
<iframe name="ifrm_boarding_downloader" id="ifrm_boarding_downloader" style="display:none" ></iframe>   

     