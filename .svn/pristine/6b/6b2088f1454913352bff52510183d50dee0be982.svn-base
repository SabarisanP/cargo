<div class="row">
    <div class="col-md-12 bold">Trip Transactions</div>        
</div>  

{if count($transactions->data)<=0}
    <br><br><div class="text-center bold">Sorry! No history available.</div>
    {else}
    <div class="vertical-container dark-timeline" id="vertical-timeline">
       {foreach item=trans from=$transactions->data}
            <div class="vertical-timeline-block">
                <div class="vertical-timeline-icon {$meta[$trans->ticket_status_code]['icon-bg-class']}">
                    <i class="fa {$meta[$trans->ticket_status_code]['icon-class']}"></i>
                </div>

                <div class="vertical-timeline-content">
                    <div ><span class="bold">{$trans->ticket_status_code} - {$meta[$trans->ticket_status_code]['name']}</span>, {$trans->ticket_code}</div>
                    <p>
                        By : {$trans->user_name|ucfirst} ( {$trans->user_group_name} ) , {$trans->from_station_name} - {$trans->to_station_name},                        
                        {$trans->travel_date|date_format:$ns_date_format}, {$trans->seat_count} ({$trans->seat_name}) seats, 
                        <i class="fa fa-rupee"></i> {$trans->ticket_amount}, 
                        <i class="fa fa-phone"></i> {$trans->mobile_number}, {$trans->passenger_name}
                    </p>                    
                    <span class="vertical-date">
                        At : {$trans->transaction_date|date_format:$ns_datetime_format}                         
                    </span>
                </div>
            </div>
       {/foreach}    
    </div>
{/if} 