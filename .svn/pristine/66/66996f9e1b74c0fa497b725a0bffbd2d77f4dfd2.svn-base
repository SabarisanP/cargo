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
                    <td align="center" class="bold">Schedule</td>
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">
            {foreach item=schedule from=$schedules key=grp}
                {if $booking[$schedule]['turnover'] >0 || $booking[$schedule]['sgst'] > 0 || $booking[$schedule]['cgst'] > 0 || $booking[$schedule]['igst'] > 0}
                    <tr>                    
                        <td align="left">{$booking[$schedule]['servicename']} {if $booking[$schedule]['servicenumber']!=''} <br> <span class="warning-text">{$booking[$schedule]['servicenumber']}</span>  {/if}</td>
                        <td align="right">{$booking[$schedule]['turnover']}</td>
                        <td align="right">{$booking[$schedule]['sgst']|inr_format}</td>
                        <td align="right">{$booking[$schedule]['cgst']|inr_format}</td>
                        <td align="right">{$booking[$schedule]['igst']|inr_format}</td>
                        <td align="right">{($booking[$schedule]['sgst']+$booking[$schedule]['cgst']+$booking[$schedule]['igst'])|inr_format}</td>
                    </tr>

                    {assign var="b_turnover" value=$b_turnover+$booking[$schedule]['turnover']}
                    {assign var="b_sgst" value=$b_sgst+$booking[$schedule]['sgst']}
                    {assign var="b_cgst" value=$b_cgst+$booking[$schedule]['cgst']}
                    {assign var="b_igst" value=$b_igst+$booking[$schedule]['igst']}
                    {assign var="b_tax" value=$b_tax+$booking[$schedule]['sgst']+$booking[$schedule]['cgst']+$booking[$schedule]['igst']}
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
                    <td align="left" class="bold">Schedule</td>
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">                        
            {foreach item=schedule from=$schedules key=grp}
                {if $cancel[$schedule]['turnover'] >0 || $cancel[$schedule]['sgst'] > 0 || $cancel[$schedule]['cgst'] > 0 || $cancel[$schedule]['igst'] > 0}
                    <tr>
                        <td align="left">{$cancel[$schedule]['servicename']} {if $cancel[$schedule]['servicenumber']!=''} <br> <span class="warning-text"> {$cancel[$schedule]['servicenumber']} </span> {/if}</td>
                        <td align="right">{$cancel[$schedule]['turnover']}</td>
                        <td align="right">{$cancel[$schedule]['sgst']|inr_format}</td>
                        <td align="right">{$cancel[$schedule]['cgst']|inr_format}</td>
                        <td align="right">{$cancel[$schedule]['igst']|inr_format}</td>
                        <td align="right">{($cancel[$schedule]['sgst']+$cancel[$schedule]['cgst']+$cancel[$schedule]['igst'])|inr_format}</td>
                    </tr>
                    {assign var="c_turnover" value=$c_turnover+$cancel[$schedule]['turnover']}
                    {assign var="c_sgst" value=$c_sgst+$cancel[$schedule]['sgst']}
                    {assign var="c_cgst" value=$c_cgst+$cancel[$schedule]['cgst']}
                    {assign var="c_igst" value=$c_igst+$cancel[$schedule]['igst']}
                    {assign var="c_tax" value=$c_tax+$cancel[$schedule]['sgst']+$cancel[$schedule]['cgst']+$cancel[$schedule]['igst']}
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
        <button class="btn btn-default" onclick="exportGSTExcelSchedulewise()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>   
<iframe name="ifrm_boarding_downloader" id="ifrm_boarding_downloader" style="display:none" ></iframe>   

     