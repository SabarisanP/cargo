{if $reports|count<=0}
    <div class="alert alert-info text-center"> Sorry! No data found. </div>
{else}    
    <table width="95%">
        <tr>
            <td  colspan="10" align="center">Payment Gateway Transactions Report</td>
        </tr>
        <tr>
            <td width="50%">                    
                <span class="bold">From </span> {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} 
            </td>
            <td width="50%" align="right">
                <span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}
            </td>
        </tr>
    </table>
        
    <h5><b>Summary</b></h5>
    <table class="table table-bordered" style="width:30%;">
        <tr>
            <td class="bold" >Booking (A)</td>
            <td class="text-right">{$amounts['booking']|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Refund (B)</td>
            <td class="text-right">{$amounts['refund']|number_format:2}</td>
        </tr>
        <tr>
            <td class="bold" >Service Charges (C)</td>
            <td class="text-right">{$amounts['service_charges']|number_format:2}</td>
        </tr>

        <tr>
            <td class="bold">Net Amount (A-B-C)</td>                                                                                           
            <td class="bold text-right">
                {($amounts['booking']-($amounts['refund']+$amounts['service_charges']))|number_format:2}
            </td>
        </tr>
    </table>    
    <h5><b>Transactions</b></h5>
    <div class="table-responsive" id="adv-report-grid">
        <table id="dt_adv_booking_report_table" class="table table-bordered ">
            <thead>
                <tr class="success">
                    <th >#</th>
                    <th >Order Code</th>
                    <th >Access Code</th>
                    <th >TXN Amount</th>
                    <th >Service Charge</th>
                    <th >TXN Date</th>
                    <th >TXN Type</th>
                    <th >Provider</th>                     
                    <th >Partner Name</th> 
                    <th >Provider Id</th> 
                    <th >Type Code</th>
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach from=$reports item=row name=fetrans}                
                    <tr>
                        <td>{$smarty.foreach.fetrans.index+1}</td> 
                        <td>{$row->order_code}</td> 
                        <td>{$row->payment_credentials_access_code}</td> 
                        <td>{$row->transaction_amount|number_format:2}</td> 
                        <td>{$row->service_charge|number_format:2}</td> 
                        <td nowrap>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <td>{$row->transaction_type_code}</td> 
                        <td>{$row->payment_gateway_provider_name}</td>                         
                        <td>{$row->payment_gateway_partner_name}</td>
                        <td>{$row->payment_gateway_provider_id}</td>
                        <td>{$row->payment_gateway_transaction_code}</td>                         
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    <div class="text-right">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportPaymentReport()"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>  
{/if}

