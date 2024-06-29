<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Trip History</div>
        <div class="col-md-2">            
            <a class="align-right" onclick="closeTripHistoryDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<div class="row">
    <div class="ticket-history-list">
        
        {if count($transactions)<=0}
            <br><br><div class="text-center bold">Sorry! No history available.</div>
        {else}
            <div class="vertical-container dark-timeline" id="vertical-timeline">
               {foreach item=trans from=$transactions}
                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon btn-success">
                            <i class="fa fa-history"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <div class="bold">{$trans->event}</div>
                            <p>
                                By : {$trans->user_name|ucfirst} ( {$trans->user_group_name} ), 
                                At : {$trans->updated_at|date_format:$ns_date_format}, {$trans->updated_at|date_format:'%I:%M:%S %p'} 
                            </p>                            
                        </div>
                    </div>
               {/foreach}    
            </div>
        {/if}       
    </div>
</div>        


