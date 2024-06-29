<div class="tabbable tabs-left">
    <ul class="nav nav-tabs" id="tabs_extra">
        {if $action_rights['SCH-ALL-BOARDING-EXCEPT']==1}
        <li><a data-toggle="tab" href="#bulk_station_point_exception" id="x_bulk_station_point_exception" data-view="all-station-point-exceptions">All Station Point Exception</a></li>
        {/if}
        
        {if $action_rights['VIRTUAL-SEAT-BLOCKER']==1}
        <li class="hide"><a data-toggle="tab" href="#virtual_seat_blocker_div" id="x_virtual_seat_blocker" data-view="virtual_seat-blocker">Virtual Seat Blocker</a></li>
        {/if}
        
        {if $action_rights['TKT-TNSFR-TERMS']==1} 
        <li><a data-toggle="tab" href="#ticket_reschedule_terms_div" id="ticket_reschedule_terms" data-view="ticket-reschedule-terms">Ticket Transfer Terms</a></li>
        {/if}
        
        <li><a data-toggle="tab" href="#schedule_extras_discount_div" id="schedule_extras_discount" data-view="schedule_extras_discount">Schedule Discount</a></li>
        
        {if $action_rights['XTRA-FEMALE-BOOK-POLICY']==1} 
        <li><a data-toggle="tab" href="#schedule_extras_gender_rule_div" id="schedule_extras_gender_rule" data-view="schedule_extras_gender_rule">Female Booking Policy</a></li>
        {/if}

        <li><a data-toggle="tab" href="#schedule_extras_breakeven_div" id="schedule_extras_breakeven" data-view="schedule_extras_breakeven">Breakeven Settings</a></li>
    </ul>
    <div class="tab-content" id="tabs_content_extra">
        <div id="bulk_station_point_exception" class="tab-pane active fade in"></div>
        <div id="virtual_seat_blocker_div" class="tab-pane fade"></div>
        <div id="ticket_reschedule_terms_div" class="tab-pane fade"></div>
        <div id="schedule_extras_discount_div" class="tab-pane fade"></div>
        <div id="schedule_extras_gender_rule_div" class="tab-pane fade"></div>
        <div id="schedule_extras_breakeven_div" class="tab-pane fade"></div>
    </div>
</div>

<script>
    $('#x_bulk_station_point_exception').click(function () {
        if(!$('#bulk_station_point_exception').html()){
            getAllStationPointException();
        }
    });
    $('#x_virtual_seat_blocker').click(function () {
        if(!$('#virtual_seat_blocker_div').html()){
            getAllVirtualSeatBlocker();
        }
    });
    $('#ticket_reschedule_terms').click(function () {
        if(!$('#ticket_reschedule_terms_div').html()){
            getTicketRescheduleTerms();
        }
    });
    $('#schedule_extras_discount').click(function () {
        if(!$('#schedule_extras_discount_div').html()){
            getScheduleExtrasDiscount();
        }
    });
    $('#schedule_extras_gender_rule').click(function () {
        if(!$('#schedule_extras_gender_rule_div').html()){
            getScheduleExtrasGenderRules();
        }
    });
    $('#schedule_extras_breakeven').click(function () {
        if(!$('#schedule_extras_breakeven_div').html()){
            getBreakevenSettings();
        }
    });
</script>