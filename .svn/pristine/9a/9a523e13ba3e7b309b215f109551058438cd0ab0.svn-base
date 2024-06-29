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
                    <td align="center" class="bold" nowrap>Travel Date</td>
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">
            {foreach item=schedule from=$schedules key=grp}
                {foreach item=bo from=$booking[$schedule] key=traveldate}
                    {if $bo['turnover'] > 0 || $bo['sgst'] > 0 || $bo['cgst'] > 0 || $bo['igst'] > 0}
                        <tr>
                            <td align="left">{$bo['servicename']} {if $bo['servicenumber']!=''} <br> <span class="warning-text">{$bo['servicenumber']}</span>  {/if}</td>
                            <td align="center" nowrap>{$traveldate|date_format:$ns_date_format}</td>
                            <td align="right">{$bo['turnover']}</td>
                            <td align="right">{$bo['sgst']|inr_format}</td>
                            <td align="right">{$bo['cgst']|inr_format}</td>
                            <td align="right">{$bo['igst']|inr_format}</td>
                            <td align="right">{($bo['sgst']+$bo['cgst']+$bo['igst'])|inr_format}</td>
                        </tr>

                        {assign var="b_turnover" value=$b_turnover+$bo['turnover']}
                        {assign var="b_sgst" value=$b_sgst+$bo['sgst']}
                        {assign var="b_cgst" value=$b_cgst+$bo['cgst']}
                        {assign var="b_igst" value=$b_igst+$bo['igst']}
                        {assign var="b_tax" value=$b_tax+$bo['sgst']+$bo['cgst']+$bo['igst']}
                    {/if}
                {/foreach}
            {/foreach}
                <tr>
                    <td align="left">&nbsp;</td>
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
                    <td align="center" class="bold" nowrap>Travel Date</td>
                    <td align="center" class="bold">Turnover</td>
                    <td align="center" class="bold">SGST</td>
                    <td align="center" class="bold">CGST</td>
                    <td align="center" class="bold">IGST</td>
                    <td align="center" class="bold">Total</td>
                </tr>
            </thead>
            <tbody class="body_table">
            {foreach item=schedule from=$schedules key=grp}
                {foreach item=ca from=$cancel[$schedule] key=traveldate}
                    {if $ca['turnover'] > 0 || $ca['sgst'] > 0 || $ca['cgst'] > 0 || $ca['igst'] > 0}
                        <tr>
                            <td align="left">{$ca['servicename']} {if $ca['servicenumber']!=''} <br> <span class="warning-text"> {$ca['servicenumber']} </span> {/if}</td>
                            <td align="center" nowrap>{$traveldate|date_format:$ns_date_format}</td>
                            <td align="right">{$ca['turnover']}</td>
                            <td align="right">{$ca['sgst']|inr_format}</td>
                            <td align="right">{$ca['cgst']|inr_format}</td>
                            <td align="right">{$ca['igst']|inr_format}</td>
                            <td align="right">{($ca['sgst']+$ca['cgst']+$ca['igst'])|inr_format}</td>
                        </tr>
                        {assign var="c_turnover" value=$c_turnover+$ca['turnover']}
                        {assign var="c_sgst" value=$c_sgst+$ca['sgst']}
                        {assign var="c_cgst" value=$c_cgst+$ca['cgst']}
                        {assign var="c_igst" value=$c_igst+$ca['igst']}
                        {assign var="c_tax" value=$c_tax+$ca['sgst']+$ca['cgst']+$ca['igst']}
                    {/if}
                {/foreach}
            {/foreach}
                <tr>
                    <td align="left">&nbsp;</td>
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
        <button class="btn btn-default" onclick="exportGSTExcelTripwise()"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div>
<iframe name="ifrm_boarding_downloader" id="ifrm_boarding_downloader" style="display:none" ></iframe>

     