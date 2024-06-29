<div class="wd_100 bold"> <i class="fa fa-ticket"></i>&nbsp;&nbsp;Ticket Details</div> 
<br>
<div>
    <div class="row">        
        <div class="col-sm-4 bold">PNR</div>
        <div class="col-sm-8" >{$reports->code}</div>        
    </div>
    
    <div class="row">        
        <div class="col-sm-4 bold">Pax Contact</div>
        <div class="col-sm-8" >{$reports->passegerMobleNo}, {$reports->passegerEmailId}</div>        
    </div>
    
    <div class="row">        
        <div class="col-sm-4 bold">Booking Code</div>
        <div class="col-sm-8" >{$reports->bookingCode}</div>        
    </div>
    
    <div class="row">        
        <div class="col-sm-4 bold">Route</div>
        <div class="col-sm-8" >{$reports->fromStation->name} - {$reports->toStation->name}</div>        
    </div>
    
    <div class="row">        
        <div class="col-sm-4 bold">Bus Type</div>
        <div class="col-sm-8" >{formatBusCategory cate_code=$reports->bus->categoryCode}</div>        
    </div>
    
    <div class="row">        
        <div class="col-sm-4 bold">Travel Date</div>
        <div class="col-sm-8" >{$reports->travelDate|date_format:$ns_datetime_format}</div>        
    </div>
    
    <div class="row">        
        <div class="col-sm-4 bold">Boarding Point</div>
        <div class="col-sm-8" >{$reports->fromStation->stationPoint[0]->name} ,&nbsp;{$reports->fromStation->stationPoint[0]->dateTime|date_format:$ns_time_format}</div>        
    </div>
   
    <div class="row">        
        <div class="col-sm-4 bold">Fare</div>
        <div class="col-sm-8" ><i class="fa fa-inr"></i>&nbsp;{$reports->totalFare|number_format:2}</div>        
    </div>   
    
</div>
    
<br>

<div class="wd_100 bold"> <span class="fa fa-user"></span> &nbsp;&nbsp;Passanger Details</div> 



<div class="table-responsive">
    <table id="dt_report_table" class="table table-striped">
        <thead>
            <tr>
                <th>Name</th>
                <th>Old Seat</th>
                <th>New Seat</th>
                <th>Gender</th>
                <th>Age</th>
                <th>Status</th>                 
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row from=$reports->ticketDetails}
                <tr id='seat-{$row->seatCode}' class="seat-list">                    
                    <td width="20%">{$row->passengerName}</td>
                    <td width="20%"  id="old-seat-no" data-code="{$row->seatCode}">{$row->seatName}</td>
                    <td width="20%" class="no_seat" id="new-seat-no" data-code=""></td>
                    <td width="10%">{$row->passengerGendar}</td>
                    <td width="20%">{$row->passengerAge}</td>
                    <td width="10%">{$row->seatStatus->code}</td>
                </tr>
            {/foreach}    
        </tbody>
    </table>
</div>   
        
<div align="center">
    <div class="form-group col-xs-12">
        <label class="col-xs-4">Remarks</label>
        <div class="col-xs-6">
            <textarea id="remarks" class="form-control remarks rs_no wid-250" placeholder="Remarks" name="remarks"></textarea>
        </div>
    </div>
</div>
             
<div align="center" class="clear_fix_both hidden" id="po-success-msg">
    <div class="alert alert-success">
        All the old seats are available for book.
    </div>
</div>
        
<div align="center" class="clear_fix_both hidden" id="po-action-msg"></div>       
        
<div align="center" id="po-action-button">
    <button class="btn btn-success" type="button" onclick="doConfirmPendingTicket('{$reports->code}')">Confirm ticket</button> 
    <button class="btn btn-danger" type="button" onclick="cancelPendingTicket('{$reports->code}', '{$reports->bookingCode}')">Cancel ticket</button> 
    <button class="btn btn-danger" type="button" onclick="refundPendingTicket('{$reports->code}', '{$reports->bookingCode}')">Issue Refund</button> 
    <button class="btn btn-default" type="button" onclick="closePendingTicketDialog()">Close</button> 
</div>

<input type="hidden" id="pending-order-ticketcode" value="{$reports->code}">
<input type="hidden" id="pending-order-tripcode" value="{$reports->tripCode}">
<input type="hidden" id="pending-order-fromcode" value="{$reports->fromStation->code}">
<input type="hidden" id="pending-order-tocode" value="{$reports->toStation->code}">
<input type="hidden" id="pending-order-traveldate" value="{$reports->travelDate}">
