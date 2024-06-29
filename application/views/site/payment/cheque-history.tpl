<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">
                Cheque History - {$chequeDetailsCode}
        </div>
        <div class="col-md-2">            
            <a class="align-right" onclick="closeChequeHistoryDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<div class="">
    <div class="ticket-history-list">
        
        {if count($cheque_history)<=0}
            <br><br><div class="text-center bold">Sorry! No history available.</div>
        {else}
            <div class="vertical-container dark-timeline" id="vertical-timeline">
                {foreach item=chq from=$cheque_history}
                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon {if $chq->event == 'deposited'}btn-primary{elseif $chq->event == 'realized'}btn-success{else}btn-warning{/if}">
                            <i class="fa {if $chq->event == 'deposited'}fa-credit-card{elseif $chq->event == 'realized'}fa-lightbulb-o{else}fa-pencil{/if}"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <div class="bold">{$chq->event|ucfirst}</div>
                            <p>
                                By : {$chq->audit->user->name|ucfirst}, {$chq->chequeLog}
                            </p>                    
                            <span class="vertical-date">
                                At : {$chq->audit->updatedAt|date_format:$ns_date_format}, {$chq->audit->updatedAt|date_format:'%I:%M:%S %p'}                         
                            </span>
                        </div>
                    </div>
                {/foreach}
            </div>
        {/if}       
    </div>
</div>        


