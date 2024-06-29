{assign var="child" value=$data[0]['payment_details']}
{assign var="childbook" value=$data[0]['booking_details']}

<h1 style="text-bold">{$data[0]['ven_name']}</h1>
<br>
<h3 align="center">Paid, Wait for Ack Amt</h3>
<table border='1' class="table table-bordered">
    <thead>
        <tr class="success">
            <th>Invoice No</th>
            <th>Transaction Date</th>
            <th>Invoice Amount</th>

            <th>Payment Type</th>
            <th>Payment Handle by</th>
        </tr>
    </thead>
    <tbody>
        {assign var="paid_total" value=0}
        {foreach from=$child item=unpaid key=key}
            {if $unpaid['type']=='PAPAID' || $unpaid['type']=="PAID"}
                <tr>
                    <td>
                        <a href="javascript:;"
                            onclick="showInvoicePdfDialog('{$unpaid['invoice_id']}');">
                            {$unpaid['invoice_id']}
                        </a>
                    </td>
                    <td>{$unpaid['booking_date']|date_format:'%d %b,%Y - %I:%M %p'}</td>
                    <td>{$unpaid['user']}</td>
                    {$transaction_mode=config_item('transaction_mode')}
                    <td>{$transaction_mode[$unpaid['payment_status']]}</td>
                    <td>{$unpaid['handleBy']}</td>
                </tr>
                {assign var='paid_total' value=$paid_total+$unpaid.user}
            {/if}
        {/foreach}
    </tbody>
    <tfoot>
        <tr class="well well-sm">
            <th colspan="2"><span>Total Amount</span></th>
            <th>{$paid_total}</th>
            <th>
                <div class="text-success">
                    Paid Amount: {abs($data[0]['paid_wait_ack_amt'] - $paid_total)}
                </div>
            </th>
            <th>
                <div class="py-2 text-danger">
                    Balance Amount: {$data[0]['paid_wait_ack_amt']}
                </div>
            </th>
        </tr>
    </tfoot>
</table>

<h3 align="center">Unpaid Invoice Amount</h3>
<table border='1' class="table table-bordered">
    <thead>
        <tr class="success">
            <th>Invoice No</th>
            {* <th>Cargo Code</th> *}
            <th>Invoice Date</th>
            <th>Invoice Amount</th>
            <th>Payment Handle by</th>
        </tr>
    </thead>

    {assign var="unpaid_total_result" value=0}
    <tbody>
        {foreach from=$child item=paid key=key}
            {* {if $child['parent_id']==$paid['parent_id']} *}
                {if $paid.type=='INITD'}
                    <tr>
                        <td>
                            <a href="javascript:;"
                                onclick="showInvoicePdfDialog('{$paid.invoice_id}');">{$paid.invoice_id}</a>
                        </td>
                        
                        <td>{$paid.booking_date|date_format:'%d %b,%Y - %I:%M %p'}</td>
                        <td>{$paid['user']}</td>

                        <td>{$paid.handleBy}</td>
                        {* <td>{$paid.cargo_status}</td> *}
                    </tr>
                    {assign var='unpaid_total_result' value=$unpaid_total_result+$paid.user}
                {/if}
            {* {/if} *}
        {/foreach}
    </tbody>
    <tfoot>
        <tr class="well well-sm">
            <th colspan="2">Total Amount</th>
            <th align="left" colspan="2">{$unpaid_total_result}</th>
        </tr>
    </tfoot>

</table>

<h3 align="center">Bookings</h3>
<table border='1' class="table table-bordered">
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
        {$cargo_status=config_item('cargo_status')}
        {foreach from=$childbook item=booking key=key}
            <tr>
                <td>
                    <a href="javascript:;"
                        onclick="getCargoDetails('{$booking.invoice_id}');">
                        {$booking.invoice_id}
                    </a>
                </td>
                <td>{$booking.itemName}</td>
                <td>{$booking.booking_date|date_format:'%d %b,%Y - %I:%M %p'}</td>
                <td>{$booking.from_station}</td>
                <td>{$booking.toStationName}</td>
                <td>{$booking.booking_amt}</td>
                <td>{$cargo_status[$booking.cargo_status]}</td>
            </tr>
            {assign var='booking_total' value=$booking_total+$booking.booking_amt}
        {/foreach}
    </tbody>
    <tfoot>
        <tr class="well well-sm">
            <th colspan="5">Total Amount</th>
            <th align="left" colspan="2">{$booking_total}</th>
        </tr>
    </tfoot>
</table> 