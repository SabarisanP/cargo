<div class="brand_top">
    <h3>{lang('dash_panel_user_balance')} Report</h3>  
</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">                        
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">                                        
                                        <div class="">                                             
                                            <div class="table-responsive" id="adv-report-grid">
                                                <table id="dt_adv_booking_report_table" class="table table-bordered ">
                                                    <thead>
                                                        <tr class="info">
                                                            <th >Group Name</th>
                                                            <th >Payment Type</th>
                                                            <th >Name</th>
                                                            <th> Last Transaction Date</th>
                                                            <th >Credit Limit</th> 
                                                            <th >Booking Commission</th>
                                                            <th >Cancellation Share</th>
                                                            <th >Current Balance</th>   
                                                            <th >Available Credit Limit</th>               
                                                        </tr> 
                                                    </thead>
                                                    <tbody class="body_table">              

                                                        {foreach from=$reports item=row}  
                                                            {assign var=c_balance value=$row->current_balance}
                                                            {assign var=a_c_limit value=$c_balance+$row->credit_limit}
                                                            
                                                            {if $row->user_group_code=='UGG7CFY71'} 
                                                                <tr>
                                                                    <td>{$row->user_group_name}</td>  
                                                                    <td >{$row->payment_type_code}</td> 
                                                                    <td>{$row->first_name}</td>  
                                                                    <td>{date('d/m/Y g:i A',strtotime($row->last_transaction_date))}</td> 
                                                                    <td align="right">{$row->credit_limit|number_format:2}</td> 
                                                                    <td align="right">{$row->booking_commission_value}</td> 
                                                                    <td align="right">{$row->cancel_agent_share}</td> 
                                                                    <td align="right">{$row->current_balance|number_format:2}</td> 
                                                                    <td align="right">{$a_c_limit|number_format:2}</td>
                                                                </tr>
                                                            {/if} 

                                                        {/foreach}



                                                    </tbody>
                                                </table>
                                            </div>


                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>                        


                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe id="irm_downloader" style="display: none"></iframe>                                            


