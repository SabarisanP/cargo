<table border='1'>
    <tr>
        <td colspan="6" align="center"><b>{$namespace_name}</b></td>
    </tr>
    <tr>
        <td colspan="6" align="center"><b>Agent / Branch Collection : Based On Loaded Date</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; {$smarty.request.fromDate|date_format:$ns_date_format} to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; {$usr_login_name} </td>
    </tr>
</table>

{if isset($summary['BOOK']) || isset($summary['TRANSIT'])}
    <div class="row">
        <div class="col-md-6">
            <h4><b>Summary</b></h4>

            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <td colspan="2"><b>Collections</b></td>
                        <td colspan="2"><b>Less</b></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Paid Booking Freight</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['fright']|sigma:$t_total_collection}</td>
                        <td>Paid Booking Loading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['loading_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Paid Booking Loading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['loading']|sigma:$t_total_collection}</td>
                        <td>Paid Booking Door Pickup</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['doorpickup_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Paid Booking UnLoading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['user_unloading']|sigma:$t_total_collection}</td>
                        <td>Paid Delivery UnLoading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['PAD']['unloading_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Paid Booking Door Pickup</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['doorpickup']|sigma:$t_total_collection}</td>
                        <td>Paid Delivery Door Delivery</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['PAD']['doordelivery_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Paid Booking Door Delivery</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['user_doordelivery']|sigma:$t_total_collection}</td>
                        <td>Topay Booking Loading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['TOP']['loading_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Paid Booking Other Charges, GST Charges</td>
                        <td align="right" data-format="{$xlformat['currency']}">{($summary['BOOK']['PAD']['others'] + $summary['BOOK']['PAD']['gst'])|sigma:$t_total_collection}</td>
                        <td>Topay Booking Door Pickup</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['TOP']['doorpickup_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Paid Delivery Unloading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['PAD']['user_unloading']|sigma:$t_total_collection}</td>
                        <td>Topay Delivery UnLoading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['unloading_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Paid Delivery Door Delivery</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['PAD']['user_doordelivery']|sigma:$t_total_collection}</td>
                        <td>Topay Delivery Door Delivery</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['doordelivery_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Topay Delivery Freight</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['fright']|sigma:$t_total_collection}</td>
                        <td>OnAccount Booking Loading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['INP']['loading_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Topay Delivery Loading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['loading']|sigma:$t_total_collection}</td>
                        <td>OnAccount Booking Door Pickup</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['INP']['doorpickup_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Topay Delivery UnLoading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['unloading']|sigma:$t_total_collection}</td>
                        <td>OnAccount Delivery UnLoading</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['INP']['unloading_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Topay Delivery Door Pickup</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['doorpickup']|sigma:$t_total_collection}</td>
                        <td>OnAccount Delivery Door Delivery</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['INP']['doordelivery_commission']|sigma:$t_total_less}</td>
                    </tr>
                    <tr>
                        <td>Topay Delivery Door Delivery</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['doordelivery']|sigma:$t_total_collection}</td>
                        <td></td>
                        <td align="right"></td>
                    </tr>
                    <tr>
                        <td>Topay Delivery Other Charges, GST Charges</td>
                        <td align="right" data-format="{$xlformat['currency']}">{($summary['TRANSIT']['TOP']['others'] + $summary['TRANSIT']['TOP']['gst'])|sigma:$t_total_collection}</td>
                        <td></td>
                        <td align="right"></td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td><b>Total Collection (A)</b></td>
                        <td align="right" data-format="{$xlformat['currency']}"><b>{$t_total_collection}</b></td>
                        <td><b>Total Less (B)</b></td>
                        <td align="right" data-format="{$xlformat['currency']}"><b>{$t_total_less}</b></td>
                    </tr>
                    <tr>
                        <td colspan="3"><b>Net Collection (C=A-B)</b></td>
                        <td align="right" data-format="{$xlformat['currency']}"><b>{($t_total_collection - $t_total_less)|sigma:$t_net_collection}</b></td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div class="col-md-5">
            <h4><b>Statement</b></h4>

            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <td><b>Particulars</b></td>
                        <td><b>LR Count</b></td>
                        <td><b>Item Count</b></td>
                        <td><b>Freight</b></td>
                        <td><b>Commission (D)</b></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Paid Booking</td>
                        <td align="right">{$summary['BOOK']['PAD']['lrcount']|sigma:$t_booking_lrcount}</td>
                        <td align="right">{$summary['BOOK']['PAD']['itemcount']|sigma:$t_booking_itemcount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['fright']|sigma:$t_booking_fright}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['PAD']['fright_commission']|sigma:$t_booking_commission}</td>
                    </tr>
                    <tr>
                        <td>Topay Booking</td>
                        <td align="right">{$summary['BOOK']['TOP']['lrcount']|sigma:$t_booking_lrcount}</td>
                        <td align="right">{$summary['BOOK']['TOP']['itemcount']|sigma:$t_booking_itemcount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['TOP']['fright']|sigma:$t_booking_fright}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['TOP']['fright_commission']|sigma:$t_booking_commission}</td>
                    </tr>
                    <tr>
                        <td>OnAccount Booking</td>
                        <td align="right">{$summary['BOOK']['INP']['lrcount']|sigma:$t_booking_lrcount}</td>
                        <td align="right">{$summary['BOOK']['INP']['itemcount']|sigma:$t_booking_itemcount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['INP']['fright']|sigma:$t_booking_fright}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['BOOK']['INP']['fright_commission']|sigma:$t_booking_commission}</td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td><b>Total</b></td>
                        <td align="right"><b>{$t_booking_lrcount}</b></td>
                        <td align="right"><b>{$t_booking_itemcount}</b></td>
                        <td align="right" data-format="{$xlformat['currency']}"><b>{$t_booking_fright}</b></td>
                        <td align="right" data-format="{$xlformat['currency']}"><b>{$t_booking_commission}</b></td>
                    </tr>
                </tfoot>
            </table>

            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <td><b>Particulars</b></td>
                        <td><b>LR Count</b></td>
                        <td><b>Item Count</b></td>
                        <td><b>Freight</b></td>
                        <td><b>Commission (E)</b></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Paid Delivery</td>
                        <td align="right">{$summary['TRANSIT']['PAD']['lrcount']|sigma:$t_delivery_lrcount}</td>
                        <td align="right">{$summary['TRANSIT']['PAD']['itemcount']|sigma:$t_delivery_itemcount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['PAD']['fright']|sigma:$t_delivery_fright}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['PAD']['fright_commission']|sigma:$t_delivery_commission}</td>
                    </tr>
                    <tr>
                        <td>Topay Delivery</td>
                        <td align="right">{$summary['TRANSIT']['TOP']['lrcount']|sigma:$t_delivery_lrcount}</td>
                        <td align="right">{$summary['TRANSIT']['TOP']['itemcount']|sigma:$t_delivery_itemcount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['fright']|sigma:$t_delivery_fright}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['TOP']['fright_commission']|sigma:$t_delivery_commission}</td>
                    </tr>
                    <tr>
                        <td>OnAccount Delivery</td>
                        <td align="right">{$summary['TRANSIT']['INP']['lrcount']|sigma:$t_delivery_lrcount}</td>
                        <td align="right">{$summary['TRANSIT']['INP']['itemcount']|sigma:$t_delivery_itemcount}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['INP']['fright']|sigma:$t_delivery_fright}</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$summary['TRANSIT']['INP']['fright_commission']|sigma:$t_delivery_commission}</td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td><b>Total</b></td>
                        <td align="right"><b>{$t_delivery_lrcount}</b></td>
                        <td align="right"><b>{$t_delivery_itemcount}</b></td>
                        <td align="right" data-format="{$xlformat['currency']}"><b>{$t_delivery_fright}</b></td>
                        <td align="right" data-format="{$xlformat['currency']}"><b>{$t_delivery_commission}</b></td>
                    </tr>
                </tfoot>
            </table>

            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <td>Net Collection (C)</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$t_net_collection}</td>
                    </tr>
                    <tr>
                        <td>Booking Commission (D)</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$t_booking_commission}</td>
                    </tr>
                    <tr>
                        <td>Delivery Commission (E)</td>
                        <td align="right" data-format="{$xlformat['currency']}">{$t_delivery_commission}</td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td><b>Net Payable (C-D-E)</b></td>
                        <td align="right" data-format="{$xlformat['currency']}"><b>{($t_net_collection - $t_booking_commission - $t_delivery_commission)}</b></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
    <br>
{/if}

{foreach item=paytypewise from=$items key=filtertype}
    {foreach item=userwise from=$paytypewise key=paystatus}
        <h4><b>Transactions : {$cargo_payment_status[$paystatus]} {$agent_collection_filtertype[$filtertype]} </b></h4>
        {if $category == 'TRANSIT' && $paystatus == 'PAD'}
            <p>Unload, Door Delivery Charges showing here are added / collected by delivery user.</p>
        {/if}
        <div class="overflow-x-auto">
            <table class="table table-bordered" width="99%">
                <thead>
                    <tr class="success">
                        <td align="center"><b>{lang('cargo_code_term')}</b></td>
                        <td align="center"><b>Booked Date</b></td>
                        <td align="center"><b>Loaded Date</b></td>
                        <td align="center"><b>User</b></td>
                        <td align="center"><b>{lang('booking_from_term')}</b></td>
                        <td align="center"><b>{lang('booking_to_label')}</b></td>

                        <td align="center"><b>Payment Status</b></td>
                        <td align="center"><b>Cargo Status</b></td>
                        <td align="center"><b>Qty</b></td>

                        <td align="center"><b>Freight</b></td>
                        <td align="center"><b>Loading</b></td>
                        <td align="center"><b>Door Pickup</b></td>

                        <td align="center"><b>UnLoading</b></td>
                        <td align="center"><b>Door Delivery</b></td>

                        <td align="center"><b>Other Charges</b></td>
                        <td align="center"><b>GST</b></td>

                        <td align="center"><b>Net Payable</b></td>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {$t_total_item_count = 0}
                    {$t_total_amount = 0}
                    {$t_total_handling_amount = 0}
                    {$t_pickup_handling_amount = 0}
                    {$t_total_unload_handling_amount = 0}
                    {$t_delivery_handling_amount = 0}
                    {$t_other_charges = 0}
                    {$t_service_tax = 0}
                    {$t_net_payable = 0}

                    {foreach key=user_name item=list from=$userwise}
                        <tr class="active">
                            <td colspan="17" align="center">{$user_name}</td>
                        </tr>
                        {foreach item=row from=$list}
                            <tr>
                                <td align="center">{$row->cargo_code}</td>
                                <td align="left" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                                <td align="left" nowrap>{$row->loaded_date|date_format:$ns_date_format}</td>
                                <td align="left">{$row->user_first_name}</td>
                                <td align="left">{$row->from_organization_name}</td>
                                <td align="left">{$row->to_organization_name}</td>

                                <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                                <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                                <td align="right">{$row->total_item_count|sigma:$t_total_item_count}</td>

                                <td align="right" data-format="{$xlformat['currency']}">{$row->total_amount|sigma:$t_total_amount}</td>
                                <td align="right" data-format="{$xlformat['currency']}">{$row->user_handling_amount|sigma:$t_total_handling_amount}</td>
                                <td align="right" data-format="{$xlformat['currency']}">{$row->user_pickup_handling_amount|sigma:$t_pickup_handling_amount}</td>

                                <td align="right" data-format="{$xlformat['currency']}">{$row->user_unload_handling_amount|sigma:$t_total_unload_handling_amount}</td>
                                <td align="right" data-format="{$xlformat['currency']}">{$row->user_delivery_handling_amount|sigma:$t_delivery_handling_amount}</td>

                                <td align="right" data-format="{$xlformat['currency']}">{$row->other_charges|sigma:$t_other_charges}</td>
                                <td align="right" data-format="{$xlformat['currency']}">{$row->service_tax|sigma:$t_service_tax}</td>

                                <td align="right" data-format="{$xlformat['currency']}">{$row->net_payable|sigma:$t_net_payable}</td>
                            </tr>
                        {/foreach}
                    {foreachelse}
                        <tr>
                            <td colspan="17" align="center">No Records Found!</td>
                        </tr>
                    {/foreach}
                </tbody>

                {if $list|count}
                    <tfoot>
                        <tr class="active">
                            <td align="right" colspan="8"><b>Total</b></td>
                            <td align="right"><b>{$t_total_item_count}</b></td>

                            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_total_amount}</b></td>
                            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_total_handling_amount}</b></td>
                            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_pickup_handling_amount}</b></td>

                            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_total_unload_handling_amount}</b></td>
                            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_delivery_handling_amount}</b></td>

                            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_other_charges}</b></td>
                            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_service_tax}</b></td>

                            <td align="right" data-format="{$xlformat['currency']}"><b>{$t_net_payable}</b></td>
                        </tr>
                    </tfoot>
                {/if}
            </table>
        </div>
    {/foreach}
{/foreach}
