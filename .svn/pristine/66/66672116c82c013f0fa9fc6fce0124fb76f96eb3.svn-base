<style>
    .pointer:hover {
        cursor: pointer;
        background-color: #FA9008 !important;
    }

    .pop-close a {
        display: block;
        margin-right: 10px;
    }

    .pop-close {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>
<div class="brand_top">
    <h3>Invoice</h3>
    <span class="align-right">
        <a href="#cargo/balance-sheet" class="btn btn-primary btn-sm">Summary</a>
        <a href="#cargo/vendor-booking-report" target="_blank" class="btn btn-primary btn-sm">RAC Booking Report</a>
        <a href="#cargo/vendor-due-report" target="_blank" class="btn btn-primary btn-sm">RAC Due Report</a>
        {if $cargo_setting->userAccountModel->code == 'DINV'}
            <a href="#cargo/generate-invoice-v2" class="btn btn-success btn-sm">Generate Invoice</a>
        {else}
            <a href="#cargo/generate-invoice" class="btn btn-success btn-sm">Generate Invoice</a>
        {/if}
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
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h5>Vendor Balance Sheet</h5>
                                    <table class="table table-bordered datatable">
                                        <thead>
                                            <tr class="success">
                                                <th align="center">Vendor</th>
                                                <th align="center">Branch</th>
                                                <th align="center">Paid,Wait for ack Amt</th>
                                                <th align="center">Unpaid Invoice Amount</th>
                                                <th align="center">Booking Trans Amt</th>
                                                <th align="center">Over all Amt</th>
                                            </tr>
                                        </thead>
                                        <tbody class="body_table">
                                            {assign var="total_paid_wait_ack_amt" value=0}
                                            {assign var="total_unpaid_invoice_amt" value=0}
                                            {assign var="total_booking_pending_amt" value=0}

                                            {foreach from=$data item=item key=key}
                                                {assign var='total_paid_wait_ack_amt' value=$total_paid_wait_ack_amt+$item.paid_wait_ack_amt}
                                                {assign var='total_unpaid_invoice_amt' value=$total_unpaid_invoice_amt+$item.unpaid_invoice_amt}
                                                {assign var='total_booking_pending_amt' value=$total_booking_pending_amt+$item.booking_pending_amt}
                                                {assign var='overAmount' value=$overAmount+$item.total_amt}

                                                <tr id="vou_22-23-tri-047" data-key="{$item.ven_unq}">
                                                    <td align="center" class="active fw-bolder pointer"
                                                        onClick="loadBalanceHistory('{$item.ven_unq}')">
                                                        {$item.ven_name}
                                                    </td>
                                                    <td>{$item.branch}</td>

                                                    <td align="right">{$item.paid_wait_ack_amt}</td>
                                                    <td align="right">{$item.unpaid_invoice_amt}</td>
                                                    <td align="right">{$item.booking_pending_amt}</td>
                                                    <td align="right">{$item.total_amt}</td>
                                                </tr>
                                            {/foreach}

                                        </tbody>
                                        <tfoot>
                                            <tr class="fw-2 well well-sm">
                                                <th align="center" class="fw-3" colspan="2">Total Amount</th>
                                                <th align="right">{$total_paid_wait_ack_amt}</th>
                                                <th align="right">{$total_unpaid_invoice_amt}</th>
                                                <th align="right">{$total_booking_pending_amt}</th>
                                                <th align="right">{$overAmount}</th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                <!--content end-->
                                {* popup start *}
                                {foreach from=$data item=child_data key=key}
                                    {assign var="child" value=$child_data.payment_details}
                                    {assign var="childbook" value=$child_data.booking_details}
                                    <form id="balanceReport{$child_data.ven_unq}" method="post" name="balanceReport{$child_data.ven_unq}" action="cargo/balance_sheet_list" onsubmit="return false;">
                                        <input type="hidden" id="ven_id{$child_data.ven_unq}" name="ven_id" value="{$child_data.ven_unq}">
                                        <input type="hidden" id="export{$child_data.ven_unq}" name="export" value="">
                                        <input type="hidden" id="print{$child_data.ven_unq}" name="print" value="">
                                        <div class="panel panel-default popup-container none popup-container{$child_data.ven_unq}">
                                            <div class="panel-body">
                                                <div class="well well-sm pop-close">
                                                    <div class="left-text">
                                                        <h4>{strtoupper($child_data.ven_name)}</h4>
                                                    </div>
                                                    <div class="right-btn">
                                                        <button class="btn btn-default" onclick="exportbalanceSheet('{$child_data.ven_unq}');"><i class="fa fa-download fa-lg"></i>Excel</button>
                                                        <button class="btn btn-default me-3" onclick="printSection('{$child_data.ven_unq}','{$child_data.ven_name}')"><i class="fa fa-print fa-lg"></i> Print</button>
                                                        <a class="align-right" style="padding: 10px 19px 10px;" onclick="closeDialog('{$child_data.ven_unq}')" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
                                                    </div>
                                                </div>
                                                {* //clone *}
                                                <div id="printCon{$child_data.ven_unq}">
                                                    <div>
                                                        <h5>Paid,Wait for ack Amt</h5>
                                                        <table class="table table-bordered" border="1px">
                                                            <thead>
                                                                <tr class="success">
                                                                    <th align="center">Invoice No</th>
                                                                    {* <th align="center">Cargo Code</th> *}
                                                                    <th align="center">Transaction Date</th>
                                                                    <th align="center">Invoice Amount</th>
                                                                    <th align="center">Payment Type</th>
                                                                    <th align="center">Payment Handle by</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                {assign var="paid_total" value=0}
                                                                {foreach from=$child item=unpaid key=key}
                                                                    {if $child_data.ven_unq==$unpaid.parent_id}
                                                                        {if $unpaid.type=='PAPAID' || $unpaid.type=="PAID"}
                                                                            <tr>
                                                                                <td><a href="javascript:;"
                                                                                        onclick="showInvoicePdfDialog('{$unpaid.invoice_id}');">{$unpaid.invoice_id}</a>
                                                                                </td>
                                                                                {* <td>{$unpaid.invoice_id}</td> *}
                                                                                {* <td>{$unpaid.cargo_code}</td> *}
                                                                                <td align="center">{$unpaid.booking_date|date_format:'%d %b,%Y - %I:%M %p'}
                                                                                </td>
                                                                                <td align="right">{$unpaid.user}</td>
                                                                                {$transaction_mode=config_item('transaction_mode')}
                                                                                <td align="center">{$transaction_mode[$unpaid.payment_status]}</td>
                                                                                <td align="right">{$unpaid.handleBy}</td>
                                                                            </tr>
                                                                            {assign var='paid_total' value=$paid_total+$unpaid.user}
                                                                        {/if}
                                                                    {/if}
                                                                {/foreach}
                                                            </tbody>
                                                            <tfoot>
                                                                <tr class="well well-sm">
                                                                    <th colspan="2"><span>Total Amount</span></th>
                                                                    {* <th colspan="3" ><div class="d-flex flex-row justify-content-between w-100"><div>{$paid_total}</div><div class="text-success"> Paid: {round($child_data.paid_wait_ack_amt-$paid_total)}</div> <div class="py-2 text-danger"> Remaining: {($child_data.paid_wait_ack_amt)}</div></div></th> *}
                                                                    <th align="right">
                                                                            <span>{$paid_total}</span>
                                                                    </th>
                                                                    <th align="center">
                                                                    <span class="text-success">Paid Amount:
                                                                                {abs($child_data.paid_wait_ack_amt - $paid_total)}
                                                                            </span>
                                                                    </th>
                                                                    <th align="center">
                                                                        <span class="py-2 text-danger">Balance Amount:
                                                                        {($child_data.paid_wait_ack_amt)}</span>
                                                                    </th>
                                                                </tr>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                    <br>
                                                    <div>
                                                        <h5>Unpaid Invoice Amount</h5>
                                                        <table class="table table-bordered" border="1px">
                                                            <thead>
                                                                <tr class="success">
                                                                    <th align="center">Invoice No</th>
                                                                    {* <th align="center">Cargo Code</th> *}
                                                                    <th align="center">Invoice Date</th>
                                                                    <th align="center">Invoice Amount</th>

                                                                    <th align="center">Payment Handle by</th>
                                                                </tr>
                                                            </thead>

                                                            {assign var="unpaid_total_result" value=0}
                                                            <tbody>
                                                                {foreach from=$child item=paid key=key}
                                                                    {if $child_data.ven_unq==$paid.parent_id}
                                                                        {if $paid.type=='INITD'}
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="javascript:;"
                                                                                        onclick="showInvoicePdfDialog('{$paid.invoice_id}');">{$paid.invoice_id}</a>
                                                                                </td>
                                                                                {* <td>{$paid.invoice_id}</td> *}
                                                                                {* <td>{$paid.cargo_code}</td> *}
                                                                                <td align="center">{$paid.booking_date|date_format:'%d %b,%Y - %I:%M %p'}</td>
                                                                                <td align="right">{$paid.user}</td>

                                                                                <td>{$paid.handleBy}</td>
                                                                                {* <td>{$paid.cargo_status}</td> *}
                                                                            </tr>
                                                                            {assign var='unpaid_total_result' value=$unpaid_total_result+$paid.user}
                                                                        {/if}
                                                                    {/if}
                                                                {/foreach}
                                                            </tbody>
                                                            <tfoot>
                                                                <tr class="well well-sm">
                                                                    <th colspan="2">Total Amount</th>
                                                                    <th colspan="2" align="right">{$unpaid_total_result}</th>
                                                                </tr>
                                                            </tfoot>

                                                        </table>
                                                    </div>

                                                    <div>
                                                    <h5>Bookings</h5>
                                                    <table class="table table-bordered" border="1px">
                                                        <thead>
                                                            <tr class="success">
                                                                <th>{lang('cargo_code_term')}</th>
                                                                <th>Booked Item</th>
                                                                <th>Booked Date</th>
                                                                <th>From Station</th>
                                                                <th>To Station</th>
                                                                <th>Booking Amount</th>
                                                                <th>Cargo Status</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            {assign var="booking_total" value=0}
                                                            {foreach from=$childbook item=booking key=key}
                                                                {if $child_data.ven_unq==$booking.parent_id}
                                                                    <tr>
                                                                    <td>
                                                                        <a href="javascript:;" onclick="getCargoDetails('{$booking.invoice_id}');">{$booking.invoice_id}</a>
                                                                    </td>
                                                                        {* <td>{$booking.invoice_id}</td> *}
                                                                        <td>{$booking.itemName}</td>
                                                                        <td>{$booking.booking_date|date_format:'%d %b,%Y - %I:%M %p'}
                                                                        </td>
                                                                        <td>{$booking.from_station}</td>
                                                                        <td>{$booking.toStationName}</td>
                                                                        <td>{$booking.booking_amt}</td>
                                                                        {$cargo_status=config_item('cargo_status')}
                                                                        <td>{$cargo_status[$booking.cargo_status]}</td>
                                                                    </tr>
                                                                    {assign var='booking_total' value=$booking_total+$booking.booking_amt}
                                                                {/if}
                                                            {/foreach}
                                                        </tbody>
                                                        <tfoot>
                                                            <tr class="well well-sm">
                                                                <th colspan="5">Total Amount</th>
                                                                <th colspan="2">{$booking_total}</th>
                                                            </tr>
                                                        </tfoot>
                                                    </table>
                                                    </div>
                                                </div>
                                                {* //clone *}
                                            </div>
                                        </div>
                                    </form>
                                {/foreach}
                                {* popup end *}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="balance-sheet-dialog"></div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>
<script src="assets/js/printDiv.js"></script>

<script>
    function loadBalanceHistory(con) {
        let popHtml = $('.popup-container' + con);
        popHtml.removeClass('none');
        $(popHtml).dialog({
            autoOpen: true,
            height: $(window).height() - 50,
            width: $(window).width() - 200,
            modal: true,
            resizable: false
        });
        // $('#balance-sheet-dialog').html(popHtml.html());
    }

    function closeDialog(con) {
        $('.popup-container' + con).dialog('destroy');
        $('.popup-container' + con).hide();
    }

    function exportbalanceSheet(venId){
        $('#export'+venId+'').val(1);
        $('#ven_id'+venId+'').val(venId);
        var formId = "balanceReport" + venId;
                                
        var form = document.getElementById(formId);
        if (form) {
            form.target = "ifrm_downloader";
            form.submit();
        }
    }

    function printSection(venId, venName) {
        let section = $('#printCon' + venId);

        function addTableBorder() {
            $(section).find('table').css('border', '1px solid black');
        }

        function removeTableBorder() {
            $(section).find('table').css('border', '');
        }

        $(section).printThis({
            importCSS: true,
            importStyle: true,
            loadCSS: "assets/bootstrap/css/bootstrap.min.css",
            header: "<h1>" + venName + " - RAC Summary</h1>",
            beforePrintEvent: addTableBorder,
            afterPrintEvent: removeTableBorder
        });
    }
</script>