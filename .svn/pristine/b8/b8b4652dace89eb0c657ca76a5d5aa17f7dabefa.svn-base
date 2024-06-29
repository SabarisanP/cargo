<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">User Booking and delivery Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<div class="clearfix"></div>
<h5><b>Booking</b></h5>
<table class="table table-bordered" width="99%">
    <thead>
        <tr class="success">
            <td align="left">S. No</td>
            <td align="left">{lang('cargo_code_term')}</td>
            <td align="center">Booked User</td>
            <td align="center">Booked Date</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Qty</td>
            <td align="center">Net Amount (A)</td>
            <td align="center">Commission (B)</td>
            <td align="center">Payable (C = A-B)</td>
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=sno value=1}
        {foreach item=CB from=$summary['CGBO'] key=type}
            <tr>
                <td align="center" colspan="10" class="active">{$cargo_payment_status[$type]}</td>
            </tr>
            {assign var=lr value=0}
            {assign var=net value=0}
            {assign var=com value=0}
            {assign var=tot value=0}
            {foreach item=row from=$CB}
                <tr>
                    <td align="left">{$sno}</td>
                    <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center" id='pay_state_{$row->cargo_code}'>
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="right">{$row->total_item_count}</td>
                    <td align="right">{($row->transaction_amount)|number_format:2}</td>
                    <td align="right">{$row->commission_amount|number_format:2}</td>
                    <td align="right">{($row->transaction_amount - $row->commission_amount)|number_format:2}</td>
                </tr>
                {assign var=sno value=$sno + 1}
                {assign var=lr value=$lr + $row->total_item_count}
                {assign var=net value=$net + $row->transaction_amount}
                {assign var=com value=$com + $row->commission_amount}
                {assign var=tot value=$tot + $row->transaction_amount - $row->commission_amount}
            {/foreach}
            <tr>
                <td align="right" colspan="6" class="bold">Total</td>
                <td align="right">{$lr}</td>
                <td align="right">{$net|number_format:2}</td>
                <td align="right">{$com|number_format:2}</td>
                <td align="right">{$tot|number_format:2}</td>
            </tr>
        {/foreach}
        {if count($summary['CGBO']) == 0}
            <tr>
                <td align="center" colspan="10">No Records Found</td>
            </tr>
        {/if}
    </tbody>
</table>
<br/>
<h5><b>ToPay Delivery Commission</b></h5>
<table class="table table-bordered" width="99%">
    <thead>
        <tr class="success">
            <td align="left">S. No</td>
            <td align="left">{lang('cargo_code_term')}</td>
            <td align="center">Payment collected by</td>
            <td align="center">Delivered User</td>
            <td align="center">Booked Date</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Qty</td>
            <td align="center">Net Amount (A)</td>
            <td align="center">Commission (B)</td>
            <td align="center">Payable (C = A-B)</td>
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=sno value=1}
        {foreach item=CB from=$summary['CGTBO'] key=type}
            <tr>
                <td align="center" colspan="11" class="active">{$cargo_payment_status[$type]}</td>
            </tr>
            {assign var=lr value=0}
            {assign var=net value=0}
            {assign var=com value=0}
            {assign var=tot value=0}
            {foreach item=row from=$CB}
                <tr>
                    <td align="left">{$sno}</td>
                    <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->delivered_user_first_name}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center" id='pay_state_{$row->cargo_code}'>
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="right">{$row->total_item_count}</td>
                    <td align="right">{($row->transaction_amount)|number_format:2}</td>
                    <td align="right">{$row->commission_amount|number_format:2}</td>
                    <td align="right">{($row->transaction_amount - $row->commission_amount)|number_format:2}</td>
                </tr>
                {assign var=sno value=$sno + 1}
                {assign var=lr value=$lr + $row->total_item_count}
                {assign var=net value=$net + $row->transaction_amount}
                {assign var=com value=$com + $row->commission_amount}
                {assign var=tot value=$tot + $row->transaction_amount - $row->commission_amount}
            {/foreach}
            <tr>
                <td align="right" colspan="7" class="bold">Total</td>
                <td align="right">{$lr}</td>
                <td align="right">{$net|number_format:2}</td>
                <td align="right">{$com|number_format:2}</td>
                <td align="right">{$tot|number_format:2}</td>
            </tr>
        {/foreach}
        {if count($summary['CGTBO']) == 0}
            <tr>
                <td align="center" colspan="11">No Records Found</td>
            </tr>
        {/if}
    </tbody>
</table>
<br/>
<h5><b>Delivery</b></h5>
<table class="table table-bordered" width="99%">
    <thead>
        <tr class="success">
            <td align="left">S. No</td>
            <td align="left">{lang('cargo_code_term')}</td>
            <td align="center">Booked User</td>
            <td align="center">Devivered User</td>
            <td align="center">Booked Date</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Qty</td>
            <td align="center">Commission</td>
        </tr>
    </thead>
    <tbody class="body_table" >
        {assign var=sno value=1}
        {foreach item=CB from=$summary['CGDL'] key=type}
            <tr>
                <td align="center" colspan="9" class="active">{$cargo_payment_status[$type]}</td>
            </tr>
            {assign var=lr value=0}
            {assign var=com value=0}
            {assign var=tot value=0}
            {foreach item=row from=$CB}
                <tr>
                    <td align="left">{$sno}</td>
                    <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left">{$row->user_first_name}</td>
                    <td align="left">{$row->delivered_user_first_name}</td>
                    <td align="left">{$row->booked_at|date_format:$ns_datetime_format}</td>
                    <td align="center" id='pay_state_{$row->cargo_code}'>
                        {$row->payment_status_code|_cargo_payment_status_badge}
                    </td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="right">{$row->total_item_count}</td>
                    <td align="right">{($row->commission_amount)|number_format:2}</td>
                    {assign var=sno value=$sno + 1}
                    {assign var=lr value=$lr + $row->total_item_count}
                    {assign var=com value=$com + $row->commission_amount}
                    {assign var=tot value=$tot + $row->transaction_amount}
                </tr>
            {/foreach}
            <tr>
                <td align="right" colspan="7" class="bold">Total</td>
                <td align="right">{$lr}</td>
                <td align="right">{$com|number_format:2}</td>
            </tr>
        {/foreach}

        {if count($summary['CGDL']) == 0}
            <tr>
                <td align="center" colspan="9">No Records Found</td>
            </tr>
        {/if}
    </tbody>
</table>
