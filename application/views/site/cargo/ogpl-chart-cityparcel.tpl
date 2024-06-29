<div class="brand_top">
    <h3>{lang('OGPL')} Trip Chart</h3>
    <span class="align-right">
        <a href="#cargo/ogpl?fill=1" class="btn btn-success  btn-sm"> <i class="fa fa-arrow-left"></i> Back</a>
    </span>
</div>

<div id="main-content">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div class="clear_fix_both"></div>
                <br />
                <div id="contents" class="col-lg-12">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <table width="100%">
                                    <tr>
                                        <td width="100%" colspan="2"><b>{lang('ogpl')} Number:</b> {$ogpl->aliasCode}</td>
                                    </tr>
                                    <tr>
                                        <td width="60%"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>
                                        <td width="40%"><b>Vehicle :</b> {$ogpl->busVehicle->registationNumber}</td>
                                    </tr>
                                    <tr>
                                        <td width="60%"><b>Route:</b> {$ogpl->fromOrganization->name} to {$ogpl->toOrganization->name}</td>
                                        <td width="40%"><b>Driver :</b> {$ogpl->vehicleDriver->name}, {$ogpl->vehicleDriver->mobileNumber}</td>
                                    </tr>
                                    {if count($ogpl->transitReference)}
                                        <tr>
                                            <td width="60%" colspan="2">
                                                <b>Related Transit(s):</b>
                                                {foreach from=$ogpl->transitReference item=row}
                                                    {if $row->cargoActivityType->code == 'TRNT'}
                                                        <a href="#cargo/ogpl-chart-details?transitCode={$row->code}" title="Related OGPL" target="_blank">{$row->name} ({$row->aliasCode})</a><br>
                                                    {elseif $row->cargoActivityType->code == 'INTRNT'}
                                                        <a href="#cargo/local-transit-chart-details?transitCode={$row->code}" title="Related Local Transit" target="_blank">{$row->name} ({$row->aliasCode})</a><br>
                                                    {elseif $row->cargoActivityType->code == 'OTFD'}
                                                        <a href="#cargo/out-for-delivery-chart-details?transitCode={$row->code}" title="Related Door pickup & Door Delivery" target="_blank">{$row->name} ({$row->aliasCode})</a><br>
                                                    {/if}
                                                {/foreach}
                                            </td>
                                        </tr>
                                    {/if}
                                    {if $ogpl->remarks}
                                        <tr>
                                            <td width="60%" colspan="2"><b>Remarks:</b> {$ogpl->remarks}</td>
                                        </tr>
                                    {/if}
                                </table>
                                <br>
                              
                                <table id="dt_adv_booking_report_table" class="table table-bordered">
                                <thead>
                                    <tr class="info bold">
                                        <td align="center" rowspan="2">S.No</td>
                                        <td align="center" rowspan="2">{lang('lr')}</td>
                                        <td align="center" rowspan="2">Qty</td>
                                        <td align="center" rowspan="2">Booked Date</td>
                                        <td align="center" rowspan="2">Booked At</td>
                                        <td align="center" rowspan="2">Delivery At</td>
                                        <td align="center" rowspan="2">E-way Bill No</td>
                                        <td align="center" rowspan="2">{lang('booking_sender_term')} Name</td>
                                        <td align="center" rowspan="2">{lang('booking_sender_term')} Mobile</td>
                                        <td align="center" rowspan="2">{lang('booking_receiver_term')} Name</td>
                                        <td align="center" rowspan="2">{lang('booking_receiver_term')} Mobile</td>
                                        <td align="center" rowspan="2">Booked By</td>
                                        <td align="center" rowspan="2">Payment Status</td>
                                        <td align="center" colspan="4">Amount</td>
                                    </tr>
                                    <tr class="info bold">
                                        <td align="center">Freight</td>
                                        <td align="center">Connecting Charges</td>
                                        <td align="center">Paid</td>
                                        <td nowrap align="center">To Pay</td>
                                    </tr>
                                </thead>
                                <tbody class="body_table">
                                    {assign var='total_qty' value=0}
                                    {assign var='sno' value=1}
                            
                                    {assign var='total_freight_amount' value=0}
                                    {assign var='total_connecting_charges_amount' value=0}
                                    {assign var='total_paid_amount' value=0}
                                    {assign var='total_to_pay_amount' value=0}
                            
                                    {foreach item=row1 from=$result key=t1}
                                        {assign var='sub_qty' value=0}
                                        {assign var='sub_freight_amount' value=0}
                                        {assign var='sub_connecting_charges_amount' value=0}
                                        {assign var='sub_paid_amount' value=0}
                                        {assign var='sub_to_pay_amount' value=0}
                            
                                        <tr>
                                            <td align="center" colspan="17" class="bold">{$routes[$t1]}</td>
                                        </tr>
                                        {foreach item=row from=$row1 key=t}
                            
                                            {assign var='total_qty' value=$total_qty+$row->total_item_count}
                                            {assign var='sub_qty' value=$sub_qty+$row->total_item_count}
                                            <tr>
                                                <td align="center">{$sno}</td>
                                                <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}<br></a>
                                                    <br>
                                                    {if isNotNull($row->eway_bill_no)}
                                                        <img src="{$base_url}assets/img/icons/eway.svg" width="30px" loading="lazy">
                                                    {/if}
                                                    {if isNotNull($row->invoice_number)}
                                                        <img src="{$base_url}assets/img/icons/invoice.svg" width="30px" loading="lazy">
                                                    {/if}
                                                </td>
                                                <td align="center">{$row->total_item_count}</td>
                                                <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td>
                                                <td align="center">{$row->from_organization_name}</td>
                                                <td align="center">{$row->to_organization_name}</td>
                                                <td align="center">{$row->eway_bill_no}</td>
                                                <td align="left">{$row->from_customer_name}</td>
                                                <td align="center">{$row->from_customer_mobile}</td>
                                                <td align="left">{$row->to_customer_name}</td>
                                                <td align="center">{$row->to_customer_mobile}</td>
                                                <td align="left">{$row->user_first_name}</td>
                                                <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>
                            
                                                <td align="right">
                                                    {($row->total_amount)|number_format:2}
                                                    {assign var='sub_freight_amount' value=$sub_freight_amount+$row->total_amount}
                                                    {assign var='total_freight_amount' value=$total_freight_amount+$row->total_amount}
                                                </td>
                                                <td align="right">
                                                    {($row->connecting_charge)|number_format:2}
                                                    {assign var='sub_connecting_charges_amount' value=$sub_connecting_charges_amount+$row->connecting_charge}
                                                    {assign var='total_connecting_charges_amount' value=$total_connecting_charges_amount+$row->connecting_charge}
                                                </td>
                                                <td align="right">
                                                    {assign var="paid" value=0}
                                                    {if $row->payment_status_code == 'PAD'}
                                                        {assign var="paid" value=($row->total_amount + $row->other_charges_amount)}
                                                        {$paid|number_format:2}
                                                        {assign var='sub_paid_amount' value=$sub_paid_amount+$paid}
                                                        {assign var='total_paid_amount' value=$total_paid_amount+$paid}
                                                    {else}
                                                        0.00
                                                    {/if}
                                                </td>
                                                <td align="right" nowrap>
                                                    {assign var="topay" value=0}
                                                    {if $row->payment_status_code == 'TOP' || $row->payment_status_code == 'TPPAD'}
                                                        {assign var="topay" value=($row->total_amount + $row->other_charges_amount)}
                                                        <span data-toggle="tooltip" data-placement="left" data-html="true"
                                                        title="
                                                        {if $row->total_amount}
                                                        <i wrap>Include Unloading & Demurage</i><hr>
                                                        Total Fright Amount : <b>{$row->total_amount|number_format:2} </b><br>
                                                        {/if}
                                                        {if $row->total_amount}
                                                            Other Charges : <b>{$row->other_charges_amount|number_format:2}</b>
                                                        {/if}"><i class="fa fa-info-circle"></i></span>
                                                        {$topay|number_format:2}
                                                        {assign var='sub_to_pay_amount' value=$sub_to_pay_amount+$topay}
                                                        {assign var='total_to_pay_amount' value=$total_to_pay_amount+$topay}
                                                    {else}
                                                        0.00
                                                    {/if}
                                                </td>
                                            </tr>
                                            {assign var='sno' value=$sno+1}
                                        {/foreach}
                                        <tr>
                                            <td align="center" class="active bold"></td>
                                            <td align="center" class="active bold">Subtotal</td>
                                            <td align="center" class="bold active">{$sub_qty}</td>
                                            <td colspan="10" class="active bold">&nbsp;</td>
                                            <td align="right" class="active bold">{$sub_freight_amount|number_format:2}</td>
                                            <td align="right" class="active bold">{$sub_connecting_charges_amount|number_format:2}</td>
                                            <td align="right" class="active bold">{$sub_paid_amount|number_format:2}</td>
                                            <td align="right" class="bold active">{$sub_to_pay_amount|number_format:2}</td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td align="center" colspan="16">Sorry! No cargo found</td>
                                        </tr>
                                    {/foreach}
                                    {if count($row1) >0 }
                                        <tr class="success">
                                            <td align="center" class="bold"></td>
                                            <td align="center" class="bold">Grandtotal</td>
                                            <td align="center" class="bold">{$total_qty}</td>
                                            <td colspan="10" class="bold">&nbsp;</td>
                                            <td align="right" class="bold">{$total_freight_amount|number_format:2}</td>
                                            <td align="right" class="bold">{$total_connecting_charges_amount|number_format:2}</td>
                                            <td align="right" class="bold">{$total_paid_amount|number_format:2}</td>
                                            <td align="right" class="bold">{$total_to_pay_amount|number_format:2}</td>
                                        </tr>
                                        {assign var="total_pay_topay" value=$total_paid_amount + $total_to_pay_amount}
                                        {if $total_pay_topay >= 1}
                                            <tr>
                                                <td colspan="15"  align="center" class="bold text-info">Summarize Total</td>
                                                <td colspan="2"  align="center" class="bold bg-info"> <span data-toggle="tooltip" data-placement="left" data-html="true"
                                                title="
                                                <b> Paid + To Pay </b>
                                                "><i class="fa fa-info-circle"></i></span> {$total_pay_topay|number_format:2}</td>
                                            </tr>
                                        {/if}
                                    {/if}
                                </tbody>
                            </table>
                              

                                <br />
                                {if $action_rights['OGPL-PAY-SUMRY']==1}
                                    <table width='100%'>
                                        <tr>
                                            <td><span class="bold">Summary</span></td>
                                        </tr>
                                    </table>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr class="info bold">
                                                <td align="center">{lang('lr')} Type</td>
                                                <td align="center">No.of {lang('lr')}s</td>
                                                <td align="center">No.of {lang('booking_article_label')}</td>
                                                <td align="center">Freight</td>
                                                <td align="center">Connecting Charges</td>
                                                <td align="center">Loading Charges</td>
                                                <td align="center">Unloading Charges</td>
                                                <td align="center">Delivery Charges</td>
                                                <td align="center">Service Tax</td>
                                                <td align="center">Other Amounts</td>

                                                <td align="center">Total</td>
                                            </tr>
                                            {assign var="total" value=0}
                                            {assign var="total_lr" value=0}
                                            {assign var="total_pkgs" value=0}
                                            {assign var="total_frieght" value=0}
                                            {assign var="total_loading" value=0}
                                            {assign var="total_unloading" value=0}
                                            {assign var="total_delivery" value=0}
                                            {assign var="total_service_tax" value=0}
                                            {assign var="total_otheramounts" value=0}
                                            {assign var="net_total" value=0}

                                        <tbody class="body_table">
                                            {foreach item=row from=$summary key=k }
                                                <tr>
                                                    {assign var=total value=$row['freight']+$row['loading']+$row['unloading']+$row['service_tax']+$row['delivery']+$row['connecting']+$row['remaining_amounts']}
                                                    <td align="center"><b>{$cargo_payment_status[$k]}</b></td>
                                                    <td align="center">{$row['lr']}</td>
                                                    <td align="center">{$row['packages']}</td>
                                                    <td align="center">{$row['freight']|number_format:2}</td>
                                                    <td align="center">{$row['connecting']|number_format:2}</td>
                                                    <td align="center">{$row['loading']|number_format:2}</td>
                                                    <td align="center">{$row['unloading']|number_format:2}</td>
                                                    <td align="center">{$row['delivery']|number_format:2}</td>
                                                    <td align="center">{$row['service_tax']|number_format:2}</td>
                                                    <td align="center">
                                                    <span data-toggle="tooltip" data-placement="left" data-html="true"
                                                            title="{$row['remaining_amounts_tooltip']}"><i class="fa fa-info-circle"></i></span>
                                                    {$row['remaining_amounts']|number_format:2}</td>
                                                    <td align="center">{$total|number_format:2}</td>
                                                </tr>

                                                {assign var="total_lr" value=$total_lr+$row['lr']}
                                                {assign var="total_pkgs" value=$total_pkgs+$row['packages']}
                                                {assign var="total_frieght" value=$total_frieght+$row['freight']}
                                                {assign var="total_loading" value=$total_loading+$row['loading']}
                                                {assign var="total_unloading" value=$total_unloading+$row['unloading']}
                                                {assign var="total_delivery" value=$total_delivery+$row['delivery']}
                                                {assign var="total_service_tax" value=$total_service_tax+$row['service_tax']}
                                                {assign var="total_otheramounts" value=$total_otheramounts+$row['remaining_amounts']}
                                                {assign var="total_connecting" value=$total_connecting+$row['connecting']}
                                                {assign var="net_total" value=$net_total+$total}
                                            {/foreach}
                                        </tbody>
                                        <tfoot>
                                            <tr class="success">
                                                <td align="center"><b>Total</b></td>
                                                <td align="center"><b>{$total_lr}</b></td>
                                                <td align="center"><b>{$total_pkgs}</b></td>
                                                <td align="center"><b>{$total_frieght|number_format:2}</b></td>
                                                <td align="center"><b>{$total_connecting|number_format:2}</b></td>
                                                <td align="center"><b>{$total_loading|number_format:2}</b></td>
                                                <td align="center"><b>{$total_unloading|number_format:2}</b></td>
                                                <td align="center"><b>{$total_delivery|number_format:2}</b></td>
                                                <td align="center"><b>{$total_service_tax|number_format:2}</b></td>
                                                <td align="center"><b>{$total_otheramounts|number_format:2}</b></td>
                                                <td align="center" class="bg-info"><b>{$net_total|number_format:2}</b></td>
                                            </tr>
                                        </tfoot>

                                        </thead>
                                    </table>
                                {/if}

                                <div class="text-right">
                                    <div class="col-md-3 pull-right p_r_n">
                                        <div class="input-group">
                                            <select id="ogpl-chart-print" class="form-control" multiple>
                                                <option value="" selected="">All Routes</option>
                                                {foreach item=name from=$routes key=code}
                                                    <option value="{$code}">{$name}</option>
                                                {/foreach}
                                            </select>
                                            <span class="input-group-btn">
                                                <div class="btn-group" style="display: flex;">
                                                    <button class="btn btn-success" type="button" onclick="print_cargo_ogpl_chart('{$smarty.request.transitCode}')">Print</button>
                                                    <button type="button" style="height:36px;" class="btn btn-success dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                        <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-right text-left" id="send-details-dd">
                                                        <li><a href="javascript:;" onclick="print_cargo_ogpl_chart('{$smarty.request.transitCode}', 'PAID');">Print Paid</a></li>
                                                        <li><a href="javascript:;" onclick="print_cargo_ogpl_chart('{$smarty.request.transitCode}', 'TOPAY');">Print Topay</a></li>
                                                    </ul>
                                                </div>
                                            </span>
                                        </div>
                                        <br>
                                        <div class="input-group">
                                            <span class="input-group-btn">
                                                <div class="btn-group" style="display: flex;justify-content: flex-end;">
                                                    <button class="btn btn-success" type="button" onclick="print_ogpl_driver_chart('{$smarty.request.transitCode}', 'LASERPRINT')">Drivers Print</button>
                                                    <button type="button" style="margin-left: 5px;" class="btn btn-success" onclick="print_ogpl_driver_chart('{$smarty.request.transitCode}', 'DOTMATRIX')">Drivers DM Print</button>
                                                </div>
                                            </span>
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

<script>
    var transitCode = {$ogpl|json_encode};
    var OGPLVehicles = {$vehicles|json_encode};
    var namespaceCode = {$namespaceCode|json_encode};
    var ogpl={$ogpl|json_encode};
    var odoDetails={$odoDetails|json_encode};
    var transitOgplcode='{$smarty.request.transitCode}';
    var user_login_branch = {$login_branch|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};
    var login_user = {$login_user|json_encode};
    var startOdoUpdated = odoDetails != null && odoDetails.startOdometer != null ? odoDetails.startOdometer : 0;
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
    $('#ogpl-chart-print').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        dropRight: true,
        buttonWidth: '100%',
        buttonClass: 'btn btn-default ogpl-chart-print',
        buttonContainer: '<div class="btn-group text-left dropup" />',
        enableFiltering: false,
        enableCaseInsensitiveFiltering: false,
    });

    function print_cargo_ogpl_chart(code, groupby) {
        if(checkOdoUpdation()){
            return;
        }
        var route = $('#ogpl-chart-print').val();
        var param = $.param({
            transitCode: code,
            groupby: groupby,
            route: (route || []).join(',')
        });

        var url = base_url + "cargo/ogpl-chart-details-print?" + param;
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        wo.print();
    }

    function print_ogpl_driver_chart(code, printType) {
        if(checkOdoUpdation()){
            return;
        }
        var params = {};
        var routes = $('#ogpl-chart-print').val();
        params.transitCode = code;
        params.type = 'DVR';
        params.route = (routes || []).join(',');
        switch (printType) {
            case 'LASERPRINT':
                params.printType = 'LASERPRINT';
                break;
            case 'DOTMATRIX':
                params.printType = 'DOTMATRIX';
                break;
            default:
                alert('Please select a print option');
                return;
        }

        var url = base_url + 'cargo/ogpl-chart-details-print?' + $.param(params);
       
        if (printType == 'LASERPRINT') {
            var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
            wo.print();
        } else if (epIsActive()) {
            if (printType == 'DOTMATRIX' && ['citycargo', 'cityparcel'].includes(namespaceCode)) {
                epPrintUrlCommands(url);
            }
        } else {
            window.open(url, '_blank');
        }
    }

    function checkOdoUpdation(){
       
   
    }
</script>