<div class="table-responsive" id="adv-report-grid">
            <table id="dt_adv_booking_report_table" class="table table-bordered ">
                <thead>
                    <tr class="info">
                        <th >Group Name&nbsp;<i class="fa fa-sort"></i></th>
                        <th >Payment Type&nbsp;<i class="fa fa-sort"></th>
                        <th >Name&nbsp;<i class="fa fa-sort"></th>
                        <th> Last Transaction Date&nbsp;<i class="fa fa-sort"></th>
                        <th> Days till last txn&nbsp;<i class="fa fa-sort"></th>
                        <th >Credit Limit&nbsp;<i class="fa fa-sort"></th> 
                        <th >Booking Commission&nbsp;<i class="fa fa-sort"></th>
                        <th >Cancellation Share&nbsp;<i class="fa fa-sort"></th>
                        <th >Current Balance&nbsp;<i class="fa fa-sort"></th>   
                        <th >Available Credit Limit&nbsp;<i class="fa fa-sort"></th>               
                    </tr> 
                </thead>
                <tbody class="body_table">              

                    {foreach from=$reports item=row}  
                        {assign var=c_balance value=$row->current_balance}
                        {assign var=a_c_limit value=$c_balance+$row->credit_limit}

                        <tr>
                            <td>{$row->user_group_name}</td>  
                            <td >{$row->payment_type_code}</td> 
                            <td>
                                {$row->first_name} <br> 
                                {$row->mobile_number} 
                            </td>  
                            <td>
                                {if $row->last_transaction_date!=""}
                                    {date('d/m/Y g:i A',strtotime($row->last_transaction_date))}
                                {else}
                                    -
                                {/if}
                            </td> 
                            <td>
                                {if $row->last_transaction_date!=""}
                                    {round( ($smarty.now - strtotime($row->last_transaction_date))/ (60 * 60 * 24) )}
                                {else}
                                    -
                                {/if}
                            </td> 
                            <td align="right">{$row->credit_limit|number_format:2}</td> 
                            <td align="right">{$row->booking_commission_value}</td> 
                            <td align="right">{$row->cancel_agent_share}</td> 
                            <td align="right">{$row->current_balance|number_format:2}</td> 
                            <td align="right">{$a_c_limit|number_format:2}</td>
                        </tr>

                    {/foreach}



                </tbody>
            </table>
        </div>




{literal}
    <script>
        $('#dt_adv_booking_report_table').DataTable({
            pageLength: 100,
            lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
            sDom: '<"well well-sm noprint"<"row"<"col-md-5 clearfix"l><"col-md-7 clearfix"f>r>>t<"row noprint"<"col-md-5 clearfix"i><"col-md-7 clearfix"p>>'
        });

    </script>
{/literal}


