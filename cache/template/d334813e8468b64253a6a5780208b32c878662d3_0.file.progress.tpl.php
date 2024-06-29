<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 12:43:26
  from 'E:\xampp\htdocs\cargo\application\views\site\ticket\progress.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665d6d16288df9_71365194',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'd334813e8468b64253a6a5780208b32c878662d3' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\ticket\\progress.tpl',
      1 => 1716451523,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665d6d16288df9_71365194 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Live Booking</h3>
    <span class="align-right">
        refresh interval 1 min
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">

                            <div class="panel panel-default hidden" id="live-graph">
                                <div class="panel-body">

                                    <div class="row d-flex align-items-center">
                                        <div class="col-md-5">
                                            <div class="row live-cells">
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="paid_count">0</div>
                                                    <div class="text-center labeltxt">PAID</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="topay_count">0</div>
                                                    <div class="text-center labeltxt">TOPAY</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="inp_count">0</div>
                                                    <div class="text-center labeltxt">ON ACCOUNT</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="wtop_count">0</div>
                                                    <div class="text-center labeltxt">WAY TO PAY</div>
                                                </div>
                                            </div>
                                            <div class="row live-cells">
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="booked_count">0</div>
                                                    <div class="text-center labeltxt">BOOKED</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                    <div class="text-center count" id="failed_count">0</div>
                                                    <div class="text-center labeltxt">FAILED</div>
                                                </div>
                                                <div class="col-md-3 cell">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="text-center">
                                                <div id="gauge" style="width:200px; height: 150px;"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="text-center">
                                                <div class="text-center count">&nbsp;</div>
                                                <div id="timer" style="width:60px; height: 60px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <br>

                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-12">

                                            <table id="live-booking-table" class="table" style="width:99%">
                                                <thead>
                                                    <tr class="live-book-row bold">
                                                        <td>From Branch </td>
                                                        <td>From Station </td>
                                                        <td>To Branch </td>
                                                        <td>To Station </td>
                                                        <td><?php echo lang('booking_sender_term');?>
</td>
                                                        <td><?php echo lang('booking_receiver_term');?>
</td>
                                                        <td><?php echo lang('cargo_code_term');?>
</td>
                                                        <td>Pickup Type </td>
                                                        <td>Amount </td>
                                                        <td>Booked By</td>
                                                        <td>Payment Mode </td>
                                                        <td>Booked Status </td>
                                                        <td>Delivery Type </td>
                                                        <td>No Of Items </td>
                                                        <td>Booked Time</td>
                                                    </tr>
                                                </thead>
                                                <tbody class="body_table ticketslist">
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
    </div>
</div>

<?php echo '<script'; ?>
 id="template-ticket-row" type="text/template">
    <td id="fromBranch"></td>
    <td id="fromStation"></td>
    <td id="toBranch"></td>
    <td id="toStation"></td>
    <td id="fromCustomer"></td>
    <td id="toCustomer"></td>
    <td id="code"></td>
    <td id="pickupType"></td>
    <td id="totalAmount" align="right"></td>
    <td id="bookedUser"></td>
    <td id="paymentStatus"></td>
    <td id="cargoStatus"></td>
    <td id="deliveryType"></td>
    <td id="item" align="center"></td>
    <td id="bookedAt"></td>
<?php echo '</script'; ?>
>


    <?php echo '<script'; ?>
>
        var stateclass = {
            "CB": '',
            "CL": 'list-group-item-info',
            "CUL": '',
            "CD": '',
            "CUD": '',
            "CR": 'list-group-item-warning',
            "CA": 'list-group-item-warning',
        }
        var t = null;
        var g1 = null;
        var ga = false;

        function refreshList() {
            t = null;
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "progress/progress-list",
                data: '',
                success: function(res) {
                    if (res.status == 1) {
                        var temp = $('#template-ticket-row').html();
                        $.each(res.tickets, function(key, tkt) {
                            if (Number(tkt.timeDiffMinute) >= 14) {
                                $('#' + tkt.unique).addClass('exis');
                            }

                            if ($('#' + tkt.unique).length > 0) {
                                var previousStatus = $('#' + tkt.unique).data('status'); //check previous state
                                $('#' + tkt.unique).find('#bookedAt').html(tkt.bookedAt);

                                if (previousStatus != tkt.cargoStatus) {
                                    if (tkt.cargoStatus == 'CB')
                                        $('#' + tkt.unique).removeClass('list-group-item-info', 5000).removeClass('list-group-item-warning', 5000);
                                    else
                                        $('#' + tkt.unique).removeClass('list-group-item-info').removeClass('list-group-item-warning');

                                    $('#' + tkt.unique).addClass(stateclass[tkt.cargoStatus], 5000);
                                }
                            } else {
                                var divhtml = $('<tr class="live-book-row"></tr>').html(temp).clone();

                                divhtml.attr('id', tkt.unique);
                                divhtml.attr('data-status', tkt.cargoStatus);
                                divhtml.find('#code').html("<a href='javascript:;'>" + tkt.code + "</a>");
                                divhtml.find('#code > a').attr('title', 'more details');
                                divhtml.find('#code > a').attr('onclick', 'getCargoDetails("' + tkt.code + '")');
                                divhtml.find('#bookedAt').html(tkt.bookedAt);
                                divhtml.find('#item').html(tkt.itemsCount);
                                divhtml.find('#bookedUser').html(tkt.bookedUser);
                                divhtml.find('#fromCustomer').html(tkt.fromCustomer +' - '+tkt.fromCustomerMobile);
                                divhtml.find('#toCustomer').html(tkt.toCustomer +' - '+tkt.toCustomerMobile);

                                divhtml.find('#fromStation').html(tkt.fromStation);
                                divhtml.find('#toStation').html(tkt.toStation);
                                divhtml.find('#paymentStatus').html('<label class="badge ' + res.cargo_payment_status_badge[tkt.paymentStatus] + '">' + res.cargo_payment_status[tkt.paymentStatus] + '</label>');
                                divhtml.find('#cargoStatus').html(res.cargo_status[tkt.cargoStatus]);
                                divhtml.find('#totalAmount').html(tkt.totalAmount);

                                divhtml.find('#fromBranch').html(tkt.fromBranch);
                                divhtml.find('#toBranch').html(tkt.toBranch);
                                divhtml.find('#pickupType').html(tkt.pickupType);
                                divhtml.find('#deliveryType').html(tkt.deliveryType);

                                $('.ticketslist').prepend(divhtml);
                                $('#' + tkt.unique).addClass(stateclass[tkt.cargoStatus], 5000);
                            }

                            if (!tkt.code) {
                                $('#' + tkt.unique).addClass('list-group-item-warning', 5000).removeClass('list-group-item-info', 5000);
                            }

                        });

                        if (!ga) {
                            g1 = new JustGage({
                                id: "gauge",
                                value: res.user_count,
                                min: 0,
                                max: 250,
                                title: "right now",
                                label: "Booked"
                            });
                            ga = true;
                        } else {
                            g1.refresh(res.user_count);
                        }

                        $('#paid_count').html(res.paymentStatusCount.PAD);
                        $('#topay_count').html(res.paymentStatusCount.TOP);
                        $('#inp_count').html(res.paymentStatusCount.INP);
                        $('#wtop_count').html(res.paymentStatusCount.FS);

                        $('#booked_count').html(Number(res.cargoStatusCount.CB) - Number(res.cargoStatusCount.FAIL));
                        $('#failed_count').html(Number(res.cargoStatusCount.FAIL) + Number(res.cargoStatusCount.CA));

                        $('#timer').html('');
                        // create the timer
                        $('#timer').polartimer({
                            timerSeconds: 60,
                            color: '#FF6040',
                            opacity: 0.9,
                            callback: function() {
                                $('#timer').polartimer('destroy');
                                refreshList();
                                $('#timer').html('<br>Refreshing...');
                            }
                        });
                        // start the timer
                        $('#timer').polartimer('start');
                    }
                }
            });

            $('#live-graph').removeClass('hidden');

            $('.exis').each(function() {
                $(this).animate({backgroundColor: '#c0392b'}, 5000, function() {
                    $(this).remove();
                });
            });
        }

        function init_progress() {
            refreshList();
        }
    <?php echo '</script'; ?>
>
<?php }
}
