<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">Branch Revenue Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>

            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">
            {if $smarty.request.pcrFilterType == 'DETAILS'}
                {$smarty.request.organizationName}
            {else}
            &nbsp;
            {/if}
        </td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
    
</table>
<br/>
<div class="clearfix"></div>
<div class="overflow-x-auto">
<table class="table table-bordered">
    <thead>
        <tr class="success" nowrap>
            {if $smarty.request.pcrFilterType == 'DETAILS'}
            <td align="center" rowspan="3">{lang('cargo_code_term')}</td>
            <td align="center" rowspan="3">Cargo Payement Status</td>
            {/if}
            {if $smarty.request.pcrFilterType == 'SUMMARY'}
            <td align="center" rowspan="3">Branch Name</td>
            {/if}
            <td align="center" rowspan="3">Station</td>
            
            <td align="center" colspan="2">Paid Booking</td>
            <td align="center" colspan="2">ToPay Booking</td>
            <td align="center" colspan="2">OnAccount Booking</td>
            <td align="center" colspan="2">Topay Delivery</td>           
            <td align="center" colspan="10">Commissions</td>
            <td align="center" rowspan="2">Net Freight</td>
            <td align="center" rowspan="2">Total Commission</td>
            <td align="center" rowspan="2">Total {lang('other_charges')}</td>
        </tr>
        <tr class="success">
            <td>Freight</td>
            <td>{lang('other_charges')}</td>
            <td>Freight</td>
            <td>{lang('other_charges')}</td>
            <td>Freight</td>
            <td>{lang('other_charges')}</td>
            <td>Freight</td>
            <td>{lang('other_charges')}</td>
            <td>Paid Booking</td>
            <td>Topay Booking</td>
            <td>On Account</td> 
            <td>Paid Delivery</td>
            <td>Topay Delivery</td>
            <td>On Account Delivery</td> 
            <td>Loading Charges</td>
            <td>Unloading Charges</td>
            <td>Pickup Charges</td>             
            <td>Delivery Charges</td> 
        </tr>
        <tr class="success">
            <td class="small" align="center">F1</td>
            <td class="small" align="center">D1</td>
            <td class="small" align="center">F2</td>
            <td class="small" align="center">D2</td>
            <td class="small" align="center">F3</td>
            <td class="small" align="center">D3</td>
            <td class="small" align="center">F4</td>
            <td class="small" align="center">D4</td>
            <td class="small" align="center">C1</td>
            <td class="small" align="center">C2</td>
            <td class="small" align="center">C3</td>
            <td class="small" align="center">C4</td>
            <td class="small" align="center">C5</td>
            <td class="small" align="center">C6</td>
            <td class="small" align="center">C7</td>
            <td class="small" align="center">C8</td>
            <td class="small" align="center">C9</td>
            <td class="small" align="center">C10</td>
            <td class="small" align="center" nowrap>(F1+ F2+F3+F4)</td>
            <td class="small" align="center" nowrap>(C = C1 to C10)</td>
            <td class="small" align="center" nowrap>(D = D1+D2+D3+D4)</td>
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
            <tr>                
                {assign var=pd_other value=0}
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
                {if $smarty.request.pcrFilterType == 'DETAILS'}
                    <td align="left" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a></td>
                    <td align="center">{$cargo_payment_status[$row->payment_status_code]}</td>
                {/if}
                {if $smarty.request.pcrFilterType == 'SUMMARY'}
                <td align="left"><a href='javascript:;' title="more details" onclick='getRevenueDetails("{$row->organization_code}","{$row->organization_name}")'>{$row->organization_name}</a></td>
                {/if}
                <td align="left">{$row->station_name}</td>

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

                <td align="right">{$tot_collection|number_format:2}</td>
                <td align="right">{$tot_other|number_format:2}</td>
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
                <td align="right" colspan="{if $smarty.request.pcrFilterType == 'DETAILS'}3{else}2{/if}">Total</td>
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
                <td align="right">{$tot_net_comm|number_format:2}</td>
                <td align="right">{$tot_net_other|number_format:2}</td>
            </tr>
        {/if}

    </tbody>
</table>
</div>

<script>
    function getRevenueDetails(orgCode, name) {
        if (orgCode == "")
            return;
        var data = {};
        data.fromDate = $('#stock_rpt_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
        data.toDate = $('#stock_rpt_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
        data.organizationCode = orgCode;
        data.organizationName = name;
        data.pcrFilterType = "DETAILS";
        data.view = 'details';

        $('#dia-rev-details').removeClass('hide');
        $('#dia-rev-details').dialog({
            autoOpen: true,
            height: 650,
            width: 1400,
            modal: true,
            closeOnEscape: true,
            resizable: false,open: function () {
            if ($.ui && $.ui.dialog && !$.ui.dialog.prototype._allowInteractionRemapped && $(this).closest(".ui-dialog").length) {
                if ($.ui.dialog.prototype._allowInteraction) {
                    var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
                    $.ui.dialog.prototype._allowInteraction = function (e) {
                        if ($(e.target).closest('.select2-drop').length) return true;
                        return ui_dialog_interaction.apply(this, arguments);
                    };
                    $.ui.dialog.prototype._allowInteractionRemapped = true;
                }
            }
        },
        _allowInteraction: function (event) {
            return !!$(event.target).is(".select2-input") || this._super(event);
        }
        });
        $(".ui-dialog-titlebar").hide();
        $('#dia-rev-details').html(loading_small);

        
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/branch-revenue-report-list",
            data: data,
            success: function (res) {
                $('#dia-rev-details').html(res);
                $('#dia-rev-details').find('a').focus();
            }
        })
    }
</script>