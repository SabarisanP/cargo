<div class="brand_top"><h3>Refund Status</h3></div>
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
                                <div class="panel-body">
                                    <div class="col-md-12">
                                        <div class="panel panel-default">
                                            <div class="table-responsive">
                                                <table id="dt_refund_list" class="table table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Booking ID</th>
                                                            <th>Mobile Number</th>
                                                            <th>Route</th>
                                                            <th>Travel Date</th>
                                                            <th>Booked Date</th>
                                                            <th>Cancelled Date</th>
                                                            <th>Refund Amount </th>
                                                            <th>No of Seats</th>
                                                            <th>Status</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody class="body_table">
                                                        {foreach name=o item=row key=k from=$refund_list}
                                                            <tr id="refund_list_{$row->statuscode}">
                                                                <td>{$row->bookingCode}</td>
                                                                <td>{$row->passegerMobleNo}</td>
                                                                <td>{$row->fromStation->name}-{$row->toStation->name}</td>
                                                                <td>{$row->travelDateTime} </td>
                                                                <td>{$row->bookedAt}</td>
                                                                <td>{$row->cancelledAt}</td>
                                                                <td>{$row->totalRefundAmount}</td>
                                                                <td>{$row->seatCount}</td>
                                                                <td>
                                                                    {if $row->activeFlag==1}
                                                                        <button class="btn-app btn-success" type="button"   data-status="{$row->activeFlag}">Amount Refunded</button>
                                                                    {else}
                                                                        <button class="btn-app btn-danger" type="button"  onclick="updateStatus('REQ','{$row->transactionCode}')"  data-status="{$row->activeFlag}">update status</button>
                                                                    {/if}
                                                                </td>
                                                            </tr>
                                                        {/foreach}
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div><!--row end-->
                                </div><!--content end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div></div></div>
</div>
{literal}
    <script>

        function updateStatus(statusCode, transactionCode, obj) {
            var data = {};
            data.statusCode = statusCode;
            data.transactionCode = transactionCode;
            data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;

            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "report/updateRefund",
                data: data,
                success: function (response) {

                    if (response.status == 1) {
                        $('#refund_list_' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
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