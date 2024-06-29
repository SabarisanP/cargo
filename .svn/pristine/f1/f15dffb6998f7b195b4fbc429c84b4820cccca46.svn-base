<div class="table-responsive">
    <table class="table table-bordered ">
        <thead>
            <tr class="success">
                <th align="left">PNR</th>
                <th align="left">Travel Date</th>
                <th align="left">Transaction Date</th>
                <th align="left">Route / Seats</th>
                <th align="left">User</th>                
                <th align="left">Seats</th>
                <th align="right">Fare</th>
                <th align="right">Discount</th>
                <th align="left">GST</th>
                <th align="right">Commission</th>
                <th align="left">Cancellation Charges</th>
                <th align="left">Cancel Commission</th>
                <th align="right">Revoke</th>
                <th align="right">Refund</th>
                <th align="right">Net Amount</th>
                <th align="right">Payable</th>
            </tr>
        </thead>
        <tbody>
            {assign var=t_seat_count value=0}
            {assign var=t_ac_bus_tax value=0}
            {assign var=t_cancel_commission value=0}
            {assign var=t_cancellation_charges value=0}
            {assign var=t_ticket_amount value=0}
            {assign var=t_addons_amount value=0}
            {assign var=t_commission_amount value=0}
            {assign var=t_refund_amount value=0}
            {assign var=t_revoke_commission_amount value=0}
            {assign var=t_net_amount value=0}

            {foreach item=type key=key from=$result}

                <tr class="active bold">
                    <td colspan="16">{$key|ucfirst}</td>
                </tr>

                {foreach item=row from=$type}
                    <tr>
                        <td align="left">{$row->ticket_code}</td>
                        <td align="left" nowrap>{$row->travel_date|date_format:$ns_date_format}</td>
                        <td align="left" nowrap>{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <td align="left">
                            {$row->from_station_name} - {$row->to_station_name} <br>
                            {$row->seat_name}
                        </td>
                        <td align="left">{$row->user_first_name}</td>                        
                        <td align="right">{$row->seat_count}</td>
                        <td align="right">{$row->ticket_amount|inr_format}</td>
                        <td align="right">{$row->addons_amount|inr_format}</td>
                        <td align="right">{$row->ac_bus_tax|inr_format}</td>
                        <td align="right">{$row->commission_amount|inr_format}</td>
                        <td align="right">{$row->cancellation_charges|inr_format}</td>
                        <td align="right">{$row->cancel_commission|inr_format}</td>
                        <td align="right">{$row->revoke_commission_amount|inr_format}</td>
                        <td align="right">{$row->refund_amount|inr_format}</td>
                        <td align="right">{$row->net_amount|inr_format}</td>
                        <td align="right">{($row->crossamount - $row->cancels + $row->revenue)|inr_format}</td>
                    </tr>

                    {assign var=t_seat_count value=$t_seat_count + $row->seat_count}
                    {assign var=t_ac_bus_tax value=$t_ac_bus_tax + $row->ac_bus_tax}
                    {assign var=t_cancel_commission value=$t_cancel_commission + $row->cancel_commission}
                    {assign var=t_cancellation_charges value=$t_cancellation_charges + $row->cancellation_charges}
                    {assign var=t_ticket_amount value=$t_ticket_amount + $row->ticket_amount}
                    {assign var=t_addons_amount value=$t_addons_amount + $row->addons_amount}
                    {assign var=t_commission_amount value=$t_commission_amount + $row->commission_amount}
                    {assign var=t_refund_amount value=$t_refund_amount + $row->refund_amount}
                    {assign var=t_revoke_commission_amount value=$t_revoke_commission_amount + $row->revoke_commission_amount}
                    {assign var=t_net_amount value=$t_net_amount + $row->net_amount}
                    {assign var=t_payable value=$t_payable + ($row->crossamount - $row->cancels + $row->revenue)}
                {/foreach}
            {/foreach}

            {if $result|count}
                <tr class="active bold">
                    <td colspan="5" align="right">Total</td>
                    <td align='right'>{$t_seat_count}</td>
                    <td align='right'>{$t_ticket_amount|inr_format}</td>
                    <td align='right'>{$t_addons_amount|inr_format}</td>
                    <td align='right'>{$t_ac_bus_tax|inr_format}</td>
                    <td align='right'>{$t_commission_amount|inr_format}</td>
                    <td align='right'>{$t_cancellation_charges|inr_format}</td>
                    <td align='right'>{$t_cancel_commission|inr_format}</td>
                    <td align='right'>{$t_revoke_commission_amount|inr_format}</td>
                    <td align='right'>{$t_refund_amount|inr_format}</td>
                    <td align='right'>{$t_net_amount|inr_format}</td>
                    <td align='right'>{$t_payable|inr_format}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>