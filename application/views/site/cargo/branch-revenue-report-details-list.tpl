<div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Cargo Revenue Details - {$smarty.request.organizationName}
        </div>
        <div class="col-md-2"> 

            <a class="align-right" onclick="closeRevenueDetailsDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>
<br/>
<div class="clearfix"></div>
<div class="overflow-x-auto">
    <table class="table table-bordered" width="96%">
        <thead>
            <tr class="success" nowrap>
                <td align="center" rowspan="2">{lang('cargo_code_term')}</td>
                <td align="center" rowspan="2">Station</td>
                <td align="center" rowspan="2">Cargo Status</td>
                <td align="center" rowspan="2">Cargo paymeent Status</td>

                <td align="center" colspan="2">Paid Booking</td>
                <td align="center" colspan="2">ToPay Booking</td>
                <td align="center" colspan="2">OnAccount Booking</td>
                <td align="center" colspan="2">Topay Delivery</td>           
                <td align="center" colspan="10">Commissions</td>
                <td align="center" rowspan="2">Net Freight (F1+ F2+F3+F4)</td>
                <td align="center" rowspan="2">Collection (F1+F4)</td>
                <td align="center" rowspan="2">Total Commission (C = C1 to C10)</td>
                <td align="center" rowspan="2">Total {lang('other_charges')} (D = D1+D2+D3+D4)</td>
                <td align="center" rowspan="2">Net Collection (F1+F4-C+D)</td>
            </tr>
            <tr class="success">
                <td>Freight F1</td>
                <td>{lang('other_charges')} D1</td>
                <td>Freight F2</td>
                <td>{lang('other_charges')} D2</td>
                <td>Freight F3</td>
                <td>{lang('other_charges')} D3</td>
                <td>Freight F4</td>
                <td>{lang('other_charges')} D4</td>
                <td>Paid Booking C1</td>
                <td>Topay Booking C2</td>
                <td>On Account C3</td> 
                <td>Paid Delivery C4</td>
                <td>Topay Delivery C5</td>
                <td>On Account Delivery C6</td> 
                <td>Loading Charges C7</td>
                <td>Unloading Charges C8</td>
                <td>Pickup Charges C9</td>             
                <td>Delivery Charges C10</td> 
            </tr>
        </thead>
        {assign var=tot_pad_freight value=0}
        {assign var=tot_pad_other_charges value=0}

        {assign var=tot_tpay_freight value=0}
        {assign var=tot_tpay_other_charges value=0}

        {assign var=tot_onacc_freight value=0}
        {assign var=tot_onacc_other_charges value=0}

        {assign var=tot_tpaydel_freight value=0}
        {assign var=tot_tpaydel_other_charges value=0}


        {assign var=tot_pad_book_comm value=0}
        {assign var=tot_tpay_book_comm value=0}
        {assign var=tot_onacc_book_comm value=0}
        {assign var=tot_tpaydel_comm value=0}

        {assign var=tot_pad_del_comm value=0}
        {assign var=tot_tpay_del_comm value=0}
        {assign var=tot_onacc_del_comm value=0}

        {assign var=tot_net_freight value=0}
        {assign var=tot_net_comm value=0}
        {assign var=tot_net_other value=0}

        {assign var=tot_net_collection value=0}
        {assign var=tot_net_amount value=0}

        {assign var=tot_loading_charges value=0}                
        {assign var=tot_unloading_charges value=0}
        {assign var=tot_pickup_charges value=0}
        {assign var=tot_delivery_charges value=0}    

        <tbody class="body_table">
            {foreach item=row from=$result}
                <tr> {assign var=pd_other value=0}
                {assign var=tp_other value=0}
                {assign var=onacc_other value=0}
                {assign var=tpdel_other value=0}
                {assign var=tot_other value=0}

                {assign var=loading_charges value=0}
                {assign var=unloading_charges value=0}

                {assign var=loading_charges value=$loading_charges+ $row->paid_loading_commission+$row->topay_loading_commission+$row->onacc_loading_commission}                
                {assign var=unloading_charges value=$unloading_charges+$row->paid_unloading_commission+$row->topay_unloading_commission+$row->onacc_unloading_commission} 
                
                
                {assign var=tot_collection value=0}
                
                {assign var=tot_loading_charges value=$tot_loading_charges+ $loading_charges}                
                {assign var=tot_unloading_charges value=$tot_unloading_charges+ $unloading_charges} 
                
                {assign var=tot_pickup_charges value=$tot_pickup_charges+$row->paid_door_pickup_commission+$row->onacc_door_pickup_commission+$row->topay_door_pickup_commission}                
                {assign var=tot_delivery_charges value=$tot_delivery_charges+$row->paid_door_delivery_commission+$row->onacc_door_delivery_commission+$row->topay_door_delivery_commission}   
                
                
                {assign var=tot_collection value=$tot_collection + $row->paid_booking_commission_amount+$row->topay_booking_commission_amount+$row->onacc_booking_commission_amount+$row->paid_booking_delivery_commission_amount+$row->topay_booking_delivery_commission_amount+$row->onacc_booking_delivery_commission_amount+$loading_charges+$unloading_charges+$row->paid_door_pickup_commission+$row->onacc_door_pickup_commission+$row->topay_door_pickup_commission+$row->paid_door_delivery_commission+$row->onacc_door_delivery_commission+$row->topay_door_delivery_commission}
                <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="left">{$row->station_name}</td>
                    <td align="left">{$cargo_status[$row->cargo_status_code]}</td>
                    <td align="left">{$cargo_payment_status[$row->payment_status_code]}</td>

                    <td align="right">{$row->paid_booking_amount|number_format:2}</td>                
                    <td align="right">
                        {if $row->paid_booking_amount > 0}                        
                            {assign var=pd_other value=$pd_other+$row->paid_other_charges_amount}                        
                            {$pd_other}
                        {else}
                            0.00
                        {/if}                  
                    </td>                
                    <td align="right">{$row->topay_booking_amount|number_format:2}</td>
                    <td align="right">
                        {if $row->topay_booking_amount > 0}
                            {assign var=tp_other value=$tp_other+$row->topay_other_charges_amount}       
                            {$tp_other}                         
                        {else}
                            0.00
                        {/if}                 
                    </td>                
                    <td align="right">{$row->onacc_booking_amount|number_format:2}</td>
                    <td align="right">
                        {if $row->onacc_booking_amount > 0}
                            {assign var=onacc_other value=$onacc_other+$row->onacc_other_charges_amount}
                            {$onacc_other}     
                        {else}
                            0.00
                        {/if}                 
                    </td>

                    <td align="right">{$row->topay_delivery_amount|number_format:2}</td>
                    <td align="right">
                        {if $row->topay_delivery_amount > 0}                        
                            {assign var=tpdel_other value=$tpdel_other+$row->topay_delivery_other_charges_amount}
                            {$tpdel_other}     
                        {else}
                            0.00
                        {/if}                
                    </td> 
                    {assign var=tot_other value=$pd_other+$tp_other+$onacc_other+$tpdel_other}              

                    <td align="right">{$row->paid_booking_commission_amount|number_format:2}</td>                
                    <td align="right">{$row->topay_booking_commission_amount|number_format:2}</td>            
                    <td align="right">{$row->onacc_booking_commission_amount|number_format:2}</td>  

                    <td align="right">{$row->paid_booking_delivery_commission_amount|number_format:2}</td>                
                    <td align="right">{$row->topay_booking_delivery_commission_amount|number_format:2}</td>            
                    <td align="right">{$row->onacc_booking_delivery_commission_amount|number_format:2}</td>  


                    <td align="right">{$loading_charges|number_format:2}</td> 
                    <td align="right">{$unloading_charges|number_format:2}</td>
                    <td align="right">{($row->paid_door_pickup_commission+$row->onacc_door_pickup_commission+$row->topay_door_pickup_commission)|number_format:2}</td>            
                    <td align="right">{($row->paid_door_delivery_commission+$row->onacc_door_delivery_commission+$row->topay_door_delivery_commission)|number_format:2}</td>

                    <td align="right">{($row->paid_booking_amount + $row->topay_booking_amount + $row->onacc_booking_amount + $row->topay_delivery_amount)|number_format:2}</td>
                    <td align="right">{($row->paid_booking_amount + $row->topay_delivery_amount)|number_format:2}</td>

                    <td align="right">{$tot_collection|number_format:2}</td>
                    <td align="right">{$tot_other|number_format:2}</td>

                    <td align="right">{($row->paid_booking_amount + $row->topay_delivery_amount - $tot_collection + $tot_other)|number_format:2}</td>
                </tr>

                {assign var=tot_net_collection value=$tot_net_collection+$row->paid_booking_amount+$row->topay_delivery_amount}
                {assign var=tot_net_amount value=$tot_net_amount+($row->paid_booking_amount + $row->topay_delivery_amount - $tot_collection + $tot_other)}

                {assign var=tot_pad_freight value=$tot_pad_freight+$row->paid_booking_amount}
                {assign var=tot_pad_other_charges value=$tot_pad_other_charges+$pd_other}

                {assign var=tot_tpay_freight value=$tot_tpay_freight+$row->topay_booking_amount}
                {assign var=tot_tpay_other_charges value=$tot_tpay_other_charges+$tp_other}

                {assign var=tot_onacc_freight value=$tot_onacc_freight+$row->onacc_booking_amount}
                {assign var=tot_onacc_other_charges value=$tot_onacc_other_charges+$onacc_other}

                {assign var=tot_tpaydel_freight value=$tot_tpaydel_freight+$row->topay_delivery_amount}
                {assign var=tot_tpaydel_comm value=$tot_tpaydel_comm+$onacc_collection}
                {assign var=tot_tpaydel_other_charges value=$tot_tpaydel_other_charges+$tpdel_other}


                {assign var=tot_pad_book_comm value=$tot_pad_book_comm+$row->paid_booking_commission_amount}
                {assign var=tot_tpay_book_comm value=$tot_tpay_book_comm+$row->topay_booking_commission_amount}
                {assign var=tot_onacc_book_comm value=$tot_onacc_book_comm+$row->onacc_booking_commission_amount}

                {assign var=tot_pad_del_comm value=$tot_pad_del_comm+$row->paid_booking_delivery_commission_amount}
                {assign var=tot_tpay_del_comm value=$tot_tpay_del_comm+$row->topay_booking_delivery_commission_amount}
                {assign var=tot_onacc_del_comm value=$tot_onacc_del_comm+$row->onacc_booking_delivery_commission_amount}

                {assign var=tot_net_freight value=$tot_net_freight + $row->paid_booking_amount + $row->topay_booking_amount + $row->onacc_booking_amount + $row->topay_delivery_amount}
                {assign var=tot_net_comm value=$tot_net_comm+$tot_collection}
                {assign var=tot_net_other value=$tot_net_other+$tot_other}
            {foreachelse}
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>
            {/foreach}
            {if $result}
                <tr class="active bold">
                    <td align="right" colspan="4">Total</td>
                    <td align="right">{$tot_pad_freight|number_format:2}</td>
                    <td align="right">{$tot_pad_other_charges|number_format:2}</td>
                    <td align="right">{$tot_tpay_freight|number_format:2}</td>
                    <td align="right">{$tot_tpay_other_charges|number_format:2}</td>
                    <td align="right">{$tot_onacc_freight|number_format:2}</td>
                    <td align="right">{$tot_onacc_other_charges|number_format:2}</td>                
                    <td align="right">{$tot_tpaydel_freight|number_format:2}</td>
                    <td align="right">{$tot_tpaydel_other_charges|number_format:2}</td>               
                    <td align="right">{$tot_pad_book_comm|number_format:2}</td>
                    <td align="right">{$tot_tpay_book_comm|number_format:2}</td>
                    <td align="right">{$tot_onacc_book_comm|number_format:2}</td>
                    <td align="right">{$tot_pad_del_comm|number_format:2}</td>
                    <td align="right">{$tot_tpay_del_comm|number_format:2}</td>
                    <td align="right">{$tot_onacc_del_comm|number_format:2}</td>
                    <td align="right">{$tot_loading_charges|number_format:2}</td>
                    <td align="right">{$tot_unloading_charges|number_format:2}</td>
                    <td align="right">{$tot_pickup_charges|number_format:2}</td>
                    <td align="right">{$tot_delivery_charges|number_format:2}</td>               
                    <td align="right">{$tot_net_freight|number_format:2}</td>
                    <td align="right">{$tot_net_collection|number_format:2}</td>
                    <td align="right">{$tot_net_comm|number_format:2}</td>
                    <td align="right">{$tot_net_other|number_format:2}</td>
                    <td align="right">{$tot_net_amount|number_format:2}</td>   
                </tr>

            {/if}

        </tbody>
    </table>
</div>
