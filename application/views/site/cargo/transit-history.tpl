<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">
            {if $filterType == 'VEHICLE'}
                Transit Vehicle History - {$transitCode}
            {elseif $filterType == 'TRANSIT'}
                Transit Load / Unload History - {$transitCode}
            {else}
                Cargo Transit History - {$transitCode}
            {/if}
        </div>
        <div class="col-md-2">            
            <a class="align-right" onclick="closeCargoTransitHistoryDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<div class="">
    <div class="ticket-history-list">
        
        {if count($transactions)<=0}
            <br><br><div class="text-center bold">Sorry! No history available.</div>
        {else}
            <div class="vertical-container dark-timeline" id="vertical-timeline">
                {assign var=whitelisted value=[]}
                {if $filterType == 'VEHICLE'}
                    {$whitelisted = ['CREATED', 'UPDATED']}
                {elseif $filterType == 'TRANSIT'}
                    {$whitelisted = ['LOADED', 'UNLOADED', 'REMOVED']}
                {/if}

                {foreach item=trans from=$transactions}
                    {assign var=eventCode value=clean_string(strrchr($trans->event, ' '))|strtoupper}
                    {if isNotNull($filterType) && !in_array($eventCode, $whitelisted)}
                        {continue}
                    {/if}
                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon btn-primary">
                            <i class="fa fa-truck"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <div class="bold">{$trans->event|ucfirst}</div>
                            <p>
                                By : {$trans->user_first_name|ucfirst}, {$trans->details}
                            </p>                    
                            <span class="vertical-date">
                                At : {$trans->updated_at|date_format:$ns_date_format}, {$trans->updated_at|date_format:'%I:%M:%S %p'}                         
                            </span>
                        </div>
                    </div>
                {/foreach}
            </div>
        {/if}       
    </div>
</div>        


