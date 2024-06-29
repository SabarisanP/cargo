<style>
.content-center{
    display: flex;
    justify-content: center;
    align-items: center;
}
.content-top{
    display: flex;
    justify-content: center;
    align-items: flex-start;
}
.start-trip-dialog{
    padding-bottom: 0;
}
</style>
<div class="brand_top">
    <h3>{lang('OGPL')} Transit Chart</h3>
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
                                {if $cargo_setting->ogplModelCode == 'VER3'}
                                    {if $showTransitTypes|count > 1}
                                        <div class="col-md-2 pull-right p_r_n">
                                            <div class="input-group" style="width: 100%;">
                                                <select id="ogpl-chart-filter" class="form-control" onchange="filterData('{$smarty.request.transitCode}', this.value);">
                                                    <option value="ALL" {if $smarty.request.transitType == 'ALL'}selected{/if}>All</option>
                                                    {if in_array('DFLT', $showTransitTypes)}
                                                        <option value="DFLT" {if $smarty.request.transitType == 'DFLT'}selected{/if}>Direct Transit</option>
                                                    {/if}
                                                    {if in_array('HULD', $showTransitTypes)}
                                                        <option value="HULD" {if $smarty.request.transitType == 'HULD'}selected{/if}>Hubload Transit</option>
                                                    {/if}
                                                    {if in_array('LCLD', $showTransitTypes)}
                                                        <option value="LCLD" {if $smarty.request.transitType == 'LCLD'}selected{/if}>Local Transit</option>
                                                    {/if}
                                                    {if $cargo_setting->transitMode[4] && in_array('OFDLD', $showTransitTypes)}
                                                        <option value="OFDLD" {if $smarty.request.transitType == 'OFDLD'}selected{/if}>Out for Delivery</option>
                                                    {/if}
                                                </select>
                                            </div>
                                        </div>
                                    {/if}
                                {/if}
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
                                            {if $namespace =='srisendhursps'}
                                                <td align="center" rowspan="2">Article</td>
                                            {/if}
                                            <td align="center" rowspan="2">Qty{if $namespace == 'dishashree'} / Kg{/if}</td>
                                            {if $namespace == 'ktwoklogistics'}
                                                <td align="center" rowspan="2">Kg</td>
                                                <td align="center" rowspan="2">Act Kg</td>
                                                <td align="center" rowspan="2">Private Mark No</td>
                                            {/if}
                                            <td align="center" rowspan="2">Booked Date</td>
                                            {if $namespace !== 'ktwoklogistics'}
                                                <td align="center" rowspan="2">Booked At</td>
                                                <td align="center" rowspan="2">Delivery At</td>
                                            {/if}
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
                                            <td align="center">{lang('other_charges')}</td>
                                            <td align="center">Paid</td>
                                            <td align="center">To Pay</td>
                                        </tr>
                                    </thead>
                                    <tbody class="body_table">
                                        {assign var='o_qty' value=0}
                                        {assign var='o_kg' value=0}
                                        {assign var='ac_kg' value=0}
                                        {assign var='sno' value=1}

                                        {assign var='o_freight_tot_amount' value=0}
                                        {assign var='o_handling_tot_amount' value=0}
                                        {assign var='o_other_tot_amount' value=0}

                                        {assign var='o_pd_tot_amount' value=0}
                                        {assign var='o_pb_tot_amount' value=0}

                                        {foreach item=row1 from=$result key=t1}
                                            <tr>
                                                <td align="center" colspan="16" class="bold">{$routes[$t1]}</td>
                                            </tr>
                                            {foreach item=row from=$row1 key=t}

                                                {assign var='o_qty' value=$o_qty+$row->total_item_count}
                                                {assign var='o_kg' value=$o_kg+$row->total_unit_value}
                                                {assign var='ac_kg' value=$ac_kg+$row->total_actual_unit_value}

                                                <tr>
                                                    <td align="center">{$sno}</td>
                                                    <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>
                                                        <br>    
                                                        {if isNotNull($row->eway_bill_no)}
                                                            <img src="{$base_url}assets/img/icons/eway.svg" width="30px" loading="lazy">
                                                        {/if}
                                                        {if isNotNull($row->invoice_number)}
                                                            <img src="{$base_url}assets/img/icons/invoice.svg" width="30px" loading="lazy">
                                                        {/if}
                                                    </td>
                                                    {if $namespace =='srisendhursps'}
                                                    <td align="center" nowrap>{$row->cargo_item_name}</td>
                                                    {/if}
                                                    <td align="center">{$row->total_item_count}{if $namespace == 'dishashree'} / {$row->total_unit_value}{/if}</td>
                                                    {if $namespace == 'ktwoklogistics'}
                                                        <td align="center">{$row->total_unit_value}</td>
                                                        <td align="center">{$row->total_actual_unit_value}</td>
                                                        <td align="center">{$row->private_mark_number}</td>
                                                    {/if}
                                                    <td align="center">{$row->booked_at|date_format:$ns_date_format}</td>
                                                    {if $namespace !== 'ktwoklogistics'}
                                                        <td align="center">{$row->from_organization_name}</td>
                                                        <td align="center">{$row->to_organization_name}</td>
                                                    {/if}

                                                    <td align="left">{$row->from_customer_name}</td>
                                                    <td align="center">{$row->from_customer_mobile}</td>
                                                    <td align="left">{$row->to_customer_name}</td>
                                                    <td align="center">{$row->to_customer_mobile}</td>
                                                    <td align="left">{$row->user_first_name}</td>
                                                    <td align="center">{$row->payment_status_code|_cargo_payment_status_badge}</td>

                                                    <td align="right">
                                                        {($row->total_amount)|number_format:2}
                                                        {assign var='o_freight_tot_amount' value=$row->total_amount + $o_freight_tot_amount}
                                                    </td>
                                                    <td align="right">
                                                        {$row->other_charges_amount|number_format:2}

                                                        {if $row->other_charges_amount != 0}
                                                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                                                                <table>
                                                                    {foreach key=ck item=cv from=_parse_other_charges($row->other_charges)}
                                                                        {if $cv == 0}
                                                                            {continue}
                                                                        {/if}
                                                                        <tr>
                                                                            <td><b>{$ck|_snakecase_to_titlecase}</b></td>
                                                                            <td>&ensp;:&ensp;</td>
                                                                            <td align="right"><i class="fa fa-rupee"></i> {$cv|inr_format}</td>
                                                                        </tr>
                                                                    {/foreach}
                                                                </table>
                                                            '></i>
                                                        {else}
                                                            <i class="fa fa-info-circle fa-inverse"></i>
                                                        {/if}
                                                        {assign var=o_other_tot_amount value=$o_other_tot_amount + $row->other_charges_amount}
                                                    </td>
                                                    <td align="right">
                                                        {assign var="paid" value=0}
                                                        {if $row->payment_status_code == 'PAD'}
                                                            {assign var="paid" value=($row->total_amount + $row->other_charges_amount)}
                                                            {$paid|number_format:2}
                                                            {assign var='o_pd_tot_amount' value=$paid + $o_pd_tot_amount}
                                                        {else}
                                                            0.00
                                                        {/if}
                                                    </td>
                                                    <td align="right" >
                                                        {assign var="topay" value=0}
                                                        {if $row->payment_status_code == 'TOP' || $row->payment_status_code == 'TPPAD'}
                                                            {assign var="topay" value=($row->total_amount + $row->other_charges_amount)}
                                                            {$topay|number_format:2}
                                                            {assign var='o_pb_tot_amount' value=$topay+$o_pb_tot_amount}
                                                        {else}
                                                            0.00
                                                        {/if}
                                                    </td>
                                                </tr>
                                                {assign var='sno' value=$sno+1}
                                            {/foreach}
                                            <tr>
                                                <td class="transit-details-type" data-transit="{$t1|substr:-4}" style="display: none;"></td>
                                                <td align="center"></td>
                                                <td align="center"></td>
                                                <td align="center" class="bold">{$o_qty}{if $namespace == 'dishashree'} / {$o_kg}{/if}</td>
                                                <td colspan="{if $namespace == 'ktwoklogistics'}10{else}9{/if}">&nbsp;</td>
                                                <td align="right">{$o_freight_tot_amount|number_format:2}</td>
                                                <td align="right">{$o_other_tot_amount|number_format:2} <i class="fa fa-info-circle fa-inverse"></i></td>
                                                <td align="right">{$o_pd_tot_amount|number_format:2}</td>
                                                <td align="right" class="bold">{$o_pb_tot_amount|number_format:2}</td>
                                            </tr>
                                        {foreachelse}
                                            <tr>
                                                <td align="center" colspan="{if $namespace == 'ktwoklogistics'}16{else}16{/if}">Sorry! No cargo found</td>
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>

                                {if $namespace == 'newlinetrans'}
                                    <br />
                                    <b>Payments</b>
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="expenses-table">
                                            <thead class="sticky-row-top">
                                                <tr class="info bold">
                                                    <th>Category</th>
                                                    <th>Type </th>
                                                    <th>Payment Mode </th>
                                                    <th>Amount </th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                {foreach item=row from=array_reverse($expensesData)}
                                                    {if $row->cashbookType->code == 'HIRING' || $row->cashbookType->code == 'ADVANCE'}
                                                        <tr>
                                                            <td align="left">
                                                                {if $row->cashbookType->transactionType == 'Cr'}
                                                                    <span class='label label-sm label-primary'>Income</span>
                                                                {elseif $row->cashbookType->transactionType == 'Dr'}
                                                                    <span class='label label-sm label-danger'>Expense</span>
                                                                {else}
                                                                    -
                                                                {/if}
                                                            </td>
                                                            <td align="left">{$row->cashbookType->name}</td>
                                                            <td align="left">{$row->transactionMode->name}</td>
                                                            <td align="left">{$row->amount|default:'-'}</td>
                                                            <td align="right">
                                                                <span class="pull-left" data-toggle="tooltip" data-placement="top" title="{$row->user->name}<br/>{$row->transactionAt|date_format:$ns_datetime_format}"><i class="fa fa-info-circle"></i></span>
                                                            </td>
                                                        </tr>
                                                    {/if}
                                                {foreachelse}
                                                    <tr>
                                                        <td colspan="5" align="center">No Records Found!</td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="expenses-table">
                                            <thead class="sticky-row-top">
                                                <tr class="info bold">
                                                    <th>Category</th>
                                                    <th>Income / Expense Type </th>
                                                    <th>Payment Mode </th>
                                                    {* <th>Vendor/receiver Inc. </th> *}
                                                    <th>Inc. Amount </th>
                                                    <th>Exp. Amount</th>
                                                    {* <th>Remarks</th> *}
                                                    {* <th>Att.</th> *}
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                {foreach item=row from=$expensesData}
                                                    {if $row->cashbookType->code != 'HIRING' && $row->cashbookType->code != 'ADVANCE'}
                                                        <tr>
                                                            <td align="left">
                                                                {if $row->cashbookType->transactionType == 'Cr'}
                                                                    <span class='label label-sm label-primary'>Income</span>
                                                                {elseif $row->cashbookType->transactionType == 'Dr'}
                                                                    <span class='label label-sm label-danger'>Expense</span>
                                                                {/if}
                                                            </td>
                                                            <td align="left">{$row->cashbookType->name}</td>
                                                            <td align="left">{$row->transactionMode->name}</td>
                                                            {* <td align="left">{$row->cashbook_vendor_name|default:$row->cashbook_vendor_code|default:'-'}</td> *}
                                                            <td align="left">{if $row->cashbookType->transactionType == 'Cr'}{$row->amount|default:'-'}{else}-{/if}</td>
                                                            <td align="left">{if $row->cashbookType->transactionType == 'Dr'}{$row->amount|default:'-'}{else}-{/if}</td>
                                                            {* <td align="left"><span data-toggle="tooltip" data-placement="top" title="{$row->remarks}">{(($row->remarks) ? $row->remarks : '-')|truncate:35:'...'}</span></td> *}
                                                            {* <td align="center">
                                                            {if $row->imageCount > 0}
                                                                <div class="btn-group btn-group-xs">
                                                                    <button class="btn btn-default btn-sm" type="button"  onclick="showPRGallery('{$row->code}')"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                                                                </div>
                                                            {else}
                                                                -
                                                            {/if}
                                                        </td> *}
                                                            <td align="right">
                                                                <span class="pull-left" data-toggle="tooltip" data-placement="top" title="{$row->user->name}<br/>{$row->transactionAt|date_format:$ns_datetime_format}"><i class="fa fa-info-circle"></i></span>
                                                            </td>
                                                        </tr>
                                                    {/if}
                                                {foreachelse}
                                                    <tr>
                                                        <td colspan="6" align="center">No Records Found!</td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                {/if}

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
                                                {if $namespace == 'ktwoklogistics'}
                                                    <td align="center" rowspan="2">Kg</td>
                                                    <td align="center" rowspan="2">Act Kg</td>
                                                {/if}
                                                <td align="center">Freight</td>
                                                <td align="center">Loading Charges</td>
                                                <td align="center">Unloading Charges</td>
                                                <td align="center">Delivery Charges</td>
                                                <td align="center">Service Tax</td>
                                                <td align="center">Other Amounts</td>
                                                <td align="center">Total</td>
                                            </tr>
                                        </thead>

                                        <tbody class="body_table">
                                            {assign var="total" value=0}
                                            {assign var="total_lr" value=0}
                                            {assign var="total_pkgs" value=0}
                                            {assign var="total_frieght" value=0}
                                            {assign var="total_loading" value=0}
                                            {assign var="total_unloading" value=0}
                                            {assign var="total_delivery" value=0}
                                            {assign var="total_service_tax" value=0}
                                            {assign var="net_total" value=0}
                                            {assign var="kg_total" value=0}
                                            {assign var="ac_kg_total" value=0}

                                            {foreach item=row from=$summary key=k }
                                                <tr>
                                                    {assign var=total value=$row['freight']+$row['loading']+$row['unloading']+$row['service_tax']+$row['delivery']+$row['remaining_amounts']}
                                                    <td align="center"><b>{$cargo_payment_status[$k]}</b></td>
                                                    <td align="center">{$row['lr']}</td>
                                                    <td align="center">{$row['packages']}</td>
                                                    {if $namespace == 'ktwoklogistics'}
                                                        <td align="center">{$row['kg_val']}</td>
                                                        <td align="center">{$row['ac_kg_val']}</td>
                                                    {/if}
                                                    <td align="center">{$row['freight']|number_format:2}</td>
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
                                                {assign var="kg_total" value=$kg_total+$row['kg_val']}
                                                    {assign var="ac_kg_total" value=$ac_kg_total+$row['ac_kg_val']}
                                                    {assign var="total_otheramounts" value=$total_otheramounts+$row['remaining_amounts']}
                                                {assign var="net_total" value=$net_total+$total}
                                            {/foreach}
                                        </tbody>
                                        <tfoot>
                                            <tr class="success">
                                                <td align="center"><b>Total</b></td>
                                                <td align="center"><b>{$total_lr}</b></td>
                                                <td align="center"><b>{$total_pkgs}</b></td>
                                                {if $namespace == 'ktwoklogistics'}
                                                    <td align="center"><b>{$kg_total}</b></td>
                                                    <td align="center"><b>{$ac_kg_total}</b></td>
                                                {/if}
                                                <td align="center"><b>{$total_frieght|number_format:2}</b></td>
                                                <td align="center"><b>{$total_loading|number_format:2}</b></td>
                                                <td align="center"><b>{$total_unloading|number_format:2}</b></td>
                                                <td align="center"><b>{$total_delivery|number_format:2}</b></td>
                                                <td align="center"><b>{$total_service_tax|number_format:2}</b></td>
                                                <td align="center"><b>{$total_otheramounts|number_format:2}</b></td>
                                                <td align="center"><b>{$net_total|number_format:2}</b></td>
                                            </tr>
                                        </tfoot>
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



{* start trip *}
<div id="start-trip-dialog" class="hide content content-center">
     <img src="assets/loaders/odometer.gif" loading="lazy" width="200px" height="200px">
</div>

<script>
    var OGPLFormData = {$ogpl|json_encode};
    var ogpl={$ogpl|json_encode};
    var transitOgplcode='{$smarty.request.transitCode}';
    var user_login_branch = {$login_branch|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};
    var login_user = {$login_user|json_encode};
    var odoDetails = {$odoDetails|json_encode};
    if(cargoSetting.transitOdometerModelCode == "ORGDTN"){
        if(login_user != ogpl.fromOrganization.code && login_user != ogpl.toOrganization.code){
            if(odoDetails.startOdometer == 0 && odoDetails.toOdometerRange > 0 ){
             makeTripOption();
            }
        }
    }

    var startOdoUpdated = odoDetails != null && odoDetails.startOdometer != null ? odoDetails.startOdometer : 0;

    function makeTripOption(){
        var data = {};
        data.transitCode = transitOgplcode;
            $('#start-trip-dialog').removeClass('hide');
            $('#start-trip-dialog').dialog({
                autoOpen: true,
                width: 800,
                height:700,
                modal: true,
                closeOnEscape:true,
                resizable: true
            });
        $.ajax({
            type: "post",
            url: "cargo/make-start-trip",
            data: data,
            dataType: "html",
            success: function (response) {
                $('#start-trip-dialog').removeClass(".content-center")
                $('#start-trip-dialog').addClass(".content-top")
                $('#start-trip-dialog').html(response);
            }
        });
    }

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

    function filterData(code, url) {
        var param = $.param({
            transitCode: code,
            transitType: url,
        });
        var reqUrl =  base_url + "#cargo/ogpl-chart-details?" + param;
        location.href = reqUrl;
    }

    function print_cargo_ogpl_chart(code, groupby) {
        if(!startOdoUpdated && cargoSetting.transitOdometerModelCode != "NA"){
            makeTripOption();
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
    function hideStartTripDialog() {
            $('#start-trip-dialog').dialog('destroy');
            $('#start-trip-dialog').hide();
    }
    function setStartTripTransactionMode() {
            var mode = $('#start-trip-adv-paymode').val();

            $('#start-trip-adv-cheque-mode-panel').addClass('hide');
            $('#start-trip-adv-netbanking-mode-panel').addClass('hide');
            $('#start-trip-adv-upi-mode-panel').addClass('hide');

            if (mode == 'CASH') {
                return;
            }

            if (mode == 'CHEQUE') {
                $('#start-trip-adv-cheque-mode-panel').removeClass('hide');
            } else if (mode == 'NBK') {
                $('#start-trip-adv-netbanking-mode-panel').removeClass('hide');
            } else if (mode == 'UPI') {
                $('#start-trip-adv-upi-mode-panel').removeClass('hide');
            }
    }
    function startTransitV3Trip() {
            var allowLoading = $('#allowLoad').val();
            var vehicleLastOdometer = $('#lastOdometer').val();
            var ownershipCode = $('#ownership-code').val();
            var data = {}, err = 0;
            data.action = 'DEPARTURE';
            data.transitCode = OGPLFormData.code;
            data.transitCargo = {};
            data.transitCargo.code = OGPLFormData.code;
            data.fromOrganization = {};
            data.fromOrganization.code = user_login_branch;
            data.startOdometer = Number($('#start-trip-odo').val());
            data.departureAt = moment().format('YYYY-MM-DD HH:mm:ss');
            data.fromOrganizationContact = {};
            data.fromOrganizationContact.code = $('#start-trip-supervisor').val();

            $('.inp_error').removeClass('inp_error');
            if (isNaN(data.startOdometer) || data.startOdometer < 0 || data.startOdometer == '') {
                $('#start-trip-odo').addClass('inp_error');
                err++;
            }
            if (vehicleLastOdometer > 0 && data.startOdometer < vehicleLastOdometer) {
                $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#start-trip-action-state').html('Entered odometer value should be greater than last odometer value');
                return;
            }

            if (isNull(odoDetails) || (odoDetails && (odoDetails.startOdometer == 0))) {
                // fuel expense
                data.fuelExpenseCode = '';
                data.activeFlag = 1;
                data.fuelDate = moment().format('YYYY-MM-DD');
                data.vehicle = {};
                data.vehicle.code = OGPLFormData.busVehicle.code;
                
                data.vendorContact = {};
                data.vendorContact.code = $('#start-trip-fuel-vendor').val();

                data.transactionMode = {};
                data.transactionMode.code = $('#start-trip-fuel-payment-mode').val();

                data.litres = Number($('#start-trip-fuel-litres').val());
                data.pricePerLitre = Number($('#start-trip-fuel-rate').val());
                data.totalAmount = data.litres * data.pricePerLitre;
                data.billNumber = $.trim($('#start-trip-fuel-coupon').val());

                // hiring amount and advance amount
                data.ogpl = [];

                if ((cargoSetting.userAccountModel.code == 'TXRT' && ownershipCode == "HIRE") || cargoSetting.userAccountModel.code != 'TXRT') {
                    var hire = {};

                    hire.code = '';
                    hire.activeFlag = 1;
                    hire.amount = Number($('#start-trip-hire-amount').val());
                    hire.remarks = '';

                    hire.user = {};
                    hire.user.code = login_user;

                    hire.transitCargo = {};
                    hire.transitCargo.code = OGPLFormData.code;
                    
                    hire.cashbookType = {};
                    hire.cashbookType.code = 'HIRING';

                    if (Number(hire.amount) > 0) {
                        data.ogpl.push(hire);
                    }
                }
                
                var advance = {};

                advance.code = '';
                advance.activeFlag = 1;
                advance.amount = Number($('#start-trip-advance-amount').val());
                advance.remarks = '';

                advance.user = {};
                advance.user.code = login_user;

                advance.transitCargo = {};
                advance.transitCargo.code = OGPLFormData.code;

                advance.transactionMode = {};
                advance.transactionMode.code = $('#start-trip-adv-paymode').val();
                
                advance.cashbookType = {};
                advance.cashbookType.code = 'ADVANCE';

                advance.paymentByContact = {};
                advance.paymentByContact.code = $('#start-trip-adv-payby').val();

                if (advance.transactionMode.code == 'UPI') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#start-trip-adv-upi-orgbank').val();
                    advance.addAttr1 = $.trim($('#start-trip-adv-upi-id').val());
                    advance.addAttr2 = $.trim($('#start-trip-adv-upi-details').val());
                } else if (advance.transactionMode.code == 'NBK') {
                    advance.bankDetails = {};
                    advance.bankDetails.code = $('#start-trip-adv-netbanking-orgbank').val();
                    advance.addAttr1 = $.trim($('#start-trip-adv-netbanking-accholder').val());
                    advance.addAttr2 = $.trim($('#start-trip-adv-netbanking-bankname').val());
                    advance.addAttr3 = $.trim($('#start-trip-adv-netbanking-details').val());
                } else if (advance.transactionMode.code == 'CHEQUE') {
                    advance.chequeDetails = {};
                    advance.chequeDetails.code = $('#start-trip-adv-chq-code').val();
                    advance.chequeDetails.activeFlag = 1;

                    advance.chequeDetails.organization = {};
                    advance.chequeDetails.organization.code = '{$login_branch}';

                    advance.chequeDetails.bankDetails = $.trim($('#start-trip-adv-cheque-bankname').val());
                    advance.chequeDetails.payerDetails = $.trim($('#start-trip-adv-cheque-payer').val());

                    advance.chequeDetails.chequeDate = moment($('#start-trip-adv-cheque-date').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                    advance.chequeDetails.chequeNo = $.trim($('#start-trip-adv-cheque-no').val());
                    advance.chequeDetails.bankCity = $.trim($('#start-trip-adv-cheque-bankcity').val());

                    advance.chequeDetails.chequeStatus = {};
                    advance.chequeDetails.chequeStatus.code = 'NEW';

                    advance.chequeDetails.remarks = $.trim($('#start-trip-adv-cheque-remarks').val());
                }

                if (Number(advance.amount) > 0) {
                    data.ogpl.push(advance);
                }

                // advance amount
                if ((cargoSetting.userAccountModel.code == 'TXRT' && $.inArray(OGPLFormData.cargoActivityType.code, ['OTFD', 'INTRNT']) != -1 && ownershipCode == "OWN" && !isNull(hire) && hire.amount != '') || (cargoSetting.userAccountModel.code != 'TXRT' && !isNull(hire) && hire.amount != '') || advance.amount != '' || advance.transactionMode.code != '' || advance.paymentByContact.code != '') {
                    if (!isNull(hire) && hire.amount == '') {
                        $('#start-trip-hire-amount').addClass('inp_error');
                        err++;
                    }
                    
                    if (advance.amount == '') {
                        $('#start-trip-advance-amount').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == '') {
                        $('#start-trip-adv-paymode').addClass('inp_error');
                        err++;
                    }

                    if (advance.paymentByContact.code == '') {
                        $('#start-trip-adv-payby').addClass('inp_error');
                        err++;
                    }

                    if (advance.transactionMode.code == 'UPI') {
                        if (advance.addAttr1 == '') {
                            $('#start-trip-adv-upi-id').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-upi-orgbank').val() == '') {
                            $('#start-trip-adv-upi-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#start-trip-adv-upi-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'NBK') {
                        if (advance.addAttr1 == '') {
                            $('#start-trip-adv-netbanking-accholder').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr2 == '') {
                            $('#start-trip-adv-netbanking-bankname').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-netbanking-orgbank').val() == '') {
                            $('#start-trip-adv-netbanking-orgbank').addClass('inp_error');
                            err++;
                        }

                        if (advance.addAttr3 == '') {
                            $('#start-trip-adv-netbanking-details').addClass('inp_error');
                            err++;
                        }
                    } else if (advance.transactionMode.code == 'CHEQUE') {
                        if (advance.chequeDetails.payerDetails == '') {
                            $('#start-trip-adv-cheque-payer').addClass('inp_error');
                            err++;
                        }

                        if ($('#start-trip-adv-cheque-date').val() == '') {
                            $('#start-trip-adv-cheque-date').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.chequeNo == '') {
                            $('#start-trip-adv-cheque-no').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankDetails == '') {
                            $('#start-trip-adv-cheque-bankname').addClass('inp_error');
                            err++;
                        }

                        if (advance.chequeDetails.bankCity == '') {
                            $('#start-trip-adv-cheque-bankcity').addClass('inp_error');
                            err++;
                        }
                    }
                }

                // fuel expense
                if (data.vendorContact.code != '' || data.litres != '' || data.pricePerLitre != '' || data.billNumber != '') {
                    if (data.vendorContact.code == '') {
                        $('#start-trip-fuel-vendor').addClass('inp_error');
                        err++;
                    }

                    if (data.litres == '') {
                        $('#start-trip-fuel-litres').addClass('inp_error');
                        err++;
                    }

                    if (data.pricePerLitre == '') {
                        $('#start-trip-fuel-rate').addClass('inp_error');
                        err++;
                    }

                    if (data.billNumber == '') {
                        $('#start-trip-fuel-coupon').addClass('inp_error');
                        err++;
                    }
                }
            }
            
            if(err) {
                $('#start-trip-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
                $('#start-trip-action-state').html('Please enter/select the values in the field that are marked in red');
                return;
            }
            $('#start-trip-panel-btn').hide();
            $('#start-trip-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);
            var transitList = [];
                $('#transit-type [name="transit-type"]:checked').each(function() {
                    transitList.push($(this).val());
                });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-start-odometer",
                data: data,
                success: function (response) {
                    if (response.status == 1) {       
                        startOdoUpdated == 1;         
                        $('#start-trip-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                        window.setTimeout(function () {
                            hideStartTripDialog();
                            window.location.reload();
                        }, 3000);
                    } else {
                        $('#start-trip-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                        $('#start-trip-panel-btn').show();
                    }

                }
            });
    }


</script>