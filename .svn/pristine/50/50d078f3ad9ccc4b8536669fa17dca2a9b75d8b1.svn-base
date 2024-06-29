<div class="brand_top"><h3>Refund Pending</h3></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            
                            <div class="panel panel-default">
                                <div class="table-responsive">
                                    <table id="dt_ack" class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>S.No &nbsp;&nbsp;<i class="fa fa-sort"></i></th> 
                                                <th>Booking / Transaction Id&nbsp;&nbsp;<i class="fa fa-sort"></i></th>                                                                                                         
                                                <th>Route&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                                                <th>PNR&nbsp;&nbsp;<i class="fa fa-sort"></i></th> 
                                                <th>Travel Date&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                                                <th>Booked At&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                                                <th>Cancelled At&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                                                <th>Mobile&nbsp;&nbsp;<i class="fa fa-sort"></i> </th>
                                                <th>Email&nbsp;&nbsp;<i class="fa fa-sort"></i> </th>
                                                <th>Refund Amount&nbsp;&nbsp;<i class="fa fa-sort"></i> </th>
                                                <th>Seats&nbsp;&nbsp;<i class="fa fa-sort"></i> </th>
                                                <th>Action&nbsp;&nbsp;<i class="fa fa-sort"></i></th>
                                            </tr>
                                        </thead>
                                        <tbody class="body_table">

                                            {foreach name=o item=row key=k from=$ref}

                                                <tr id="pen_{$row->transactionCode}">	
                                                    <td>{$smarty.foreach.o.index+1}</td>
                                                    <td>{$row->bookingCode}</td>                                                    
                                                    <td>{$row->fromStation->name} - {$row->toStation->name}</td>
                                                    <td><a href="javascript:;" data-pnr="{$row->ticketCode}" class="pnr-popover" >{$row->ticketCode}</a></td>                                                                
                                                    <td nowrap>{$row->travelDateTime|date_format:$ns_datetime_format}</td>
                                                    <td nowrap>{$row->bookedAt|date_format:$ns_datetime_format}</td>
                                                    <td nowrap>{$row->canncelledAt|date_format:$ns_datetime_format}</td>
                                                    <td>{$row->passegerMobleNo}</td>
                                                    <td>{$row->passegerEmailId}</td>
                                                    <td align='center'>{$row->totalRefundAmount|number_format:2}</td>
                                                    <td align='center'>{$row->seatCount}</td>
                                                    <td> 
                                                        <button class="btn-app btn-success" type="button" onclick="cancelRefund('{$row->transactionCode}')">Refund</button>
                                                    </td>
                                                </tr>
                                            {/foreach}    
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                                    
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{literal}
    <script>
        $(document).ready(function () {
            $('#dt_ack').dataTable();
            $("select[name=dt_ack_length]").val("50").change();
            
            $('.pnr-popover').each( function(){
                $(this).popover({
                    container:'body',
                    content:loading_popup,
                    html:true,
                    placement:'top',
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
                                placement:'top',
                                trigger:'focus',
                            }).popover('show');
                            
                        }
                    });
                })
                
            });
               
        });

        
        function cancelRefund(transaction) {
            var data = {};
            data.code = transaction;
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "payment/update-cancel-refund",
                data: data,
                success: function (response) {

                    if (response.status == 1) {
                        $('#pen_' + data.code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                            $(this).remove();
                        });
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            });
        }




    </script>
{/literal}