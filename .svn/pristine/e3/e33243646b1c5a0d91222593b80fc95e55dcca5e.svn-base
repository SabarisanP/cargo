<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Billing Report</td>
    </tr>
    <tr>
        <td width="50%"><span class="bold">For the month of :</span> {$smarty.request.month}  </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>

</table>
<div class="table-responsive" id="adv-bp-grid">
    <table id="dt_bp_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="center" width='1%'>#</th>
                <th align="center">Operator Name</th>
                {foreach item=head from=$entity_head key=h}
                    <th>{$head}</th>
                {/foreach}                
            </tr>
        </thead>
        <tbody class="body_table">            
            {foreach item=entity from=$entities key=e name=bill}
                <tr>
                    <td>{$smarty.foreach.bill.index+1}</td>
                    <td>{$e}</td>
                    {foreach item=head from=$entity_head key=h}
                        <td>
                            {foreach item=headitem from=$entity[$head] key=ei}                                
                                {$headitem['value']}
                                {if $headitem['attribute'] !=''} - {$headitem['attribute']} {/if}
                                <br> 
                            {/foreach}
                        </td>
                    {/foreach} 
                </tr>                
            {/foreach}  

        </tbody>
    </table>                
</div>
<div class="text-right noprint">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportBillingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <!--<button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>-->
    </div>
</div>   

     