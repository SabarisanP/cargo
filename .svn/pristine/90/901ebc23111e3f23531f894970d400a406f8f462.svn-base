<div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Cargo History - {$cargoCode}</div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeCargoHistoryDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>
</div>

<div class="row">
    <div class="ticket-history-list">

        {if count($transactions)<=0}
            <br><br>
            <div class="text-center bold">Sorry! No history available.</div>
        {else}
            <div class="vertical-container dark-timeline" id="vertical-timeline">
                {foreach item=trans from=$transactions}
                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon btn-info">
                            <i class="fa fa-history"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <div class="bold">{$trans->event|ucfirst}</div>
                            <p>
                                By : {$trans->user_first_name|ucfirst}, {$trans->details}
                            </p>
                            <p>Device medium : {$trans->device_medium}</p>
                            <span class="vertical-date">
                                At : {$trans->transaction_at|date_format:$ns_date_format}, {$trans->transaction_at|date_format:'%I:%M:%S %p'}
                            </span>
                        </div>
                    </div>
                {/foreach}
            </div>
        {/if}
    </div>
</div>