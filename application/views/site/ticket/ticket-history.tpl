<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Ticket History - {$ticketCode}</div>
        <div class="col-md-2">            
            <a class="align-right" onclick="closeTicketHistoryDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
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
                    {if $trans->ticket_status_code != 'NA'}
                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon {$meta[$trans->ticket_status_code]['icon-bg-class']}">
                            <i class="fa {$meta[$trans->ticket_status_code]['icon-class']}"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <div class="bold">{$trans->ticket_status_code} - {$meta[$trans->ticket_status_code]['name']}</div>
                            <p>
                                By : {$trans->user_name|ucfirst} ( {$trans->user_group_name} ) , Action : {$trans->event|ucfirst} <br>
                                Device : {$trans->devicemedium}
                            </p>                    
                            <span class="vertical-date">
                                {$trans->transaction_date|date_format:$ns_date_format}, {$trans->transaction_date|date_format:'%I:%M:%S %p'}                         
                            </span>
                        </div>
                    </div>
                    {/if}
               {/foreach}    
            </div>
        {/if}       
    </div>
</div>        


