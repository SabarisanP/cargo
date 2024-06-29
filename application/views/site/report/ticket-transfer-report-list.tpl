<table class="" width="95%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Ticket Transfer Details Report</span></td>
    </tr>
    <tr>
        <td width="50%">From  {$smarty.request.from|date_format:$ns_date_format}  To {$smarty.request.to|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report Date/Time :</span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
</table>
<div class="table-responsive">
    <table id="tkt-tfr-table" class="table table-bordered" width="99%">
        <thead>
            <tr class="success">
                <th align="center" rowspan="2">#</th>
                <th align="center" colspan="4" class="text-center">First Ticket</th>
                <th align="center" colspan="4" class="text-center">Resheduled Ticket</th> 
                <th align="center" rowspan="2">Seats</th> 
            </tr>
            <tr class="success">                
                <th align="center">PNR</th>                
                <th align="center">User</th>                  
                <th align="center">Travel Date</th> 
                <th align="center">Transaction Date</th> 
                <th align="center">PNR</th>                
                <th align="center">User</th>                  
                <th align="center">Travel Date</th> 
                <th align="center">Transaction Date</th>              
            </tr>
        </thead>
        <tbody class="body_table">            
            {foreach item=row from=$result key=k}                
                <tr>                    
                    <td align='left'>{$k+1}</td>
                    <td align='left'><a href="javascript:;" data-pnr="{$row->source_ticket_code}" class="pnr-popover">{$row->source_ticket_code}</a></td>         
                    <td align='left'>{$row->source_user_name}</td>                          
                    <td align='left'>{$row->source_travel_date|date_format:$ns_date_format}</td>      
                    <td align='left'>{$row->source_transaction_date|date_format:$ns_datetime_format}</td>  
                    <td align='left'><a href="javascript:;" data-pnr="{$row->ticket_code}" class="pnr-popover">{$row->ticket_code}</a></td>       
                    <td align='left'>{$row->user_name}</td>                          
                    <td align='left'>{$row->travel_date|date_format:$ns_date_format}</td>    
                    <td align='left'>{$row->transaction_date|date_format:$ns_datetime_format}</td>                     
                    <td align='left'>{count(","|explode:$row->seat_name)}</td> 
                </tr>
            {foreachelse}
                <tr>                    
                    <td colspan="10" align="center">No data found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>                
</div>
        
<script>
    $('.pnr-popover').each( function(){
        $(this).popover({
            container:'body',
            content:loading_popup,
            html:true,
            placement:'right',
            trigger:'focus',
        });

        $(this).on('show.bs.popover', function () {
            var ele = this;
            var data = {};
            data.ticketpnrcode = $(this).attr('data-pnr');
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/get-ticket-details",
                data: data,
                success: function (response) {
                    $(ele).popover('destroy').popover({
                        container:'body',
                        content:response,
                        html:true,
                        placement:'right',
                        trigger:'focus',
                    }).popover('show');

                }
            });
        })
    });
</script>
