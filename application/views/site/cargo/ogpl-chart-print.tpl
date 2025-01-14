<html>

<head>
    <title>OGPL Chart</title>
    <base href="{$base_url}">
    <link href="{$base_url}assets/css/print.css?{$asset_ver}" rel="stylesheet">
    <style>
        .lr {
            font-size: 12pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .payment-status {
            font-size: 11pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }
    </style>
</head>

<body>
    {assign var='t_inv' value=0}
    {assign var='t_ew' value=0}
    {assign var="is_ogpl_completed" value=in_array('COMPLETE',$ogpl->activity)}
    {foreach item=row1 from=$result key=t1 }
        {foreach item=row from=$row1 key=t }
                {if isNotNull($row->eway_bill_no)}
                    {assign var='t_ew' value=$t_ew+1}
                {/if}
                {if isNotNull($row->invoice_number)}
                    {assign var='t_inv' value=$t_inv+1}
                {/if}
        {/foreach}
    {/foreach}
    <table cellpadding="5" width="100%">
        {if $is_header_available}
            <tr>
                <td width="100%" colspan="2" align="center">
                    <img src="assets/img/clientlogo/{$namespace}.jpg" alt="logo" width="100%"><br>
                </td>
            </tr>
        {else}
            <tr>
                <td width="100%" colspan="2" align="center" style="font-weight:bold; font-size: 20px;">
                    {$namespace_name}
                    {if $namespace == 'newlinetrans'}
                        <br><span style="font-weight:500; font-size: 15px;">Survey No 333/3 Kataria estate near St.joseph school
                            <br>Vapi karvad road Vapi-396191
                            <br>Mobile No: 8155052015,9328022015,9375281007</span><br><br>
                    {elseif in_array($namespace , ["citycargo","cityparcel"])}
                        <br><span style="font-weight:500; font-size: 15px;">{$userBranchData['address1']}
                            <br>{$userBranchData['address2']}</span><br><br>
                    {/if}
                </td>
            </tr>
        {/if}

        <tr>
            <td width="100%" colspan="3" align="center" style="font-weight:bold; font-size: 20px;">{$namespace_name}</td>
        </tr>
        <tr>
            <td width="100%" colspan="3"><b>{lang('ogpl')} Number:</b> {$ogpl->aliasCode}</td>
        </tr>
        <tr>
            <td width="40%"><b>Trip Date:</b> {$ogpl->tripDate|date_format:$ns_date_format}</td>
            <td width="40%"><b>Vehicle :</b> {$ogpl->busVehicle->registationNumber}</td>
            {if $is_ogpl_completed}
                <td width="20%"><b>Start Odometer:</b> {$odoDetails['fromOdoDetail']->startOdometer}</td>
            {else}
                <td><b>Start Odometer:</b>
                {if isset($odoDetails['myOdoDetail'])} 
                  {$odoDetails['myOdoDetail']->startOdometer}
                {else} 
                  0
                {/if}
                </td>
            {/if}
            
        </tr>
        <tr>
            <td width="40%"><b>Route:</b> {$ogpl->fromOrganization->name} to {$ogpl->toOrganization->name}</td>
            <td width="40%"><b>Driver :</b> {$ogpl->vehicleDriver->name}, {$ogpl->vehicleDriver->mobileNumber}</td>
            {if $is_ogpl_completed}
                <td width="20%"><b>End Odometer:</b> {$odoDetails['toOdoDetail']->endOdometer}</td>
            {else}
                <td></td>
            {/if}
           
        </tr>
        {if $ogpl->remarks}
            <tr>
                <td width="60%" colspan="2"><b>Remarks:</b> {$ogpl->remarks}</td>
            </tr>
        {/if}
        {if $namespace == 'arthitrans'}
            <tr>
                <td width="60%" colspan="2"><b>Invoice Count :</b> {$t_inv} ,&nbsp;&nbsp;<b>Eway Bill Count :</b> {$t_ew}</td>
            </tr>
        {/if}
    </table>
    <br />
    <table class="bordered" cellpadding="3" width="96%">
        <thead>
            <tr class="info bold">
                <td align="center" rowspan="2">S.No</td>
                <td align="center" rowspan="2">{lang('lr')}</td>
                {if $namespace == 'arthitrans'}
                    <td align="center" rowspan="2" nowrap>Article</td>
                {/if}
                <td align="center" rowspan="2" nowrap>Qty{if $namespace == 'dishashree'} / Kg{/if}</td>
                {if $namespace == 'ktwoklogistics'}
                    <td align="center" rowspan="2">Kg</td>
                    <td align="center" rowspan="2">Act Kg</td>
                {/if}
                {if in_array($namespace , ["ktwoklogistics"])}
                    <td align="center" rowspan="2">Private Mark No</td>
                {/if}
                {if in_array($namespace , ["knttransports", "kntlogistics", "vikascargo", "vikasecotrans"])}
                    <td align="center" rowspan="2" width="50">Description</td>
                {/if}
                {if !in_array($namespace , ["vikascargo", "vikasecotrans", "ktwoklogistics"])}
                    <td align="center" rowspan="2">Booked At</td>
                    {* <td align="center" rowspan="2">Booked At</td> *}
                    <td align="center" rowspan="2">Delivery At</td>
                {/if}
                {if in_array($namespace , ["citycargo","cityparcel"])}
                    <td align="center" rowspan="2">E-way Bill No</td>
                {/if}
                <td align="center" rowspan="2">{lang('booking_sender_term')} Name</td>
                {if $namespace != 'newlinetrans'}
                    <td align="center" rowspan="2">{lang('booking_sender_term')} Mobile</td>
                {/if}
                <td align="center" rowspan="2">{lang('booking_receiver_term')} Name</td>
                {if $namespace != 'newlinetrans'}
                    <td align="center" rowspan="2">{lang('booking_receiver_term')} Mobile</td>
                {/if}
                {* <td align="center" rowspan="2">Booked By</td> *}
                <td align="center" rowspan="2">Payment Status</td>
                <td align="center" colspan="{if in_array($namespace , ["knttransports", "kntlogistics"])}2{else}4{/if}">Amount</td>
            </tr>
            <tr class="info bold">
                {if !in_array($namespace , ["knttransports", "kntlogistics"])}
                    <td align="center">Freight</td>
                    {if !in_array($namespace , ["citycargo","cityparcel"])}
                        <td align="center">{if $namespace == 'srimaharaja'}Door Delivery Charges{else}{lang('other_charges')}{/if}</td>
                    {/if}
                    {if in_array($namespace , ["citycargo","cityparcel"])}
                        <td align="center">Connecting Charges</td>
                    {/if}
                {/if}
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

            {foreach item=row1 from=$result key=t1 }
                <tr>
                    <td align="center" colspan="{if in_array($namespace , ["vikascargo", "vikasecotrans", "knttransports", "kntlogistics"])}13{elseif $namespace == 'newlinetrans'}12{elseif in_array($namespace , ["citycargo","cityparcel"])}15{else}14{/if}"><b>{$routes[$t1]}</b></td>
                </tr>
                {foreach item=row from=$row1 key=t }

                    {assign var='o_qty' value=$o_qty+$row->total_item_count}
                    {assign var='o_kg' value=$o_kg+$row->total_unit_value}
                    {assign var='ac_kg' value=$ac_kg+$row->total_actual_unit_value}
                    <tr>
                        <td align="center">{$sno}</td>
                        <td align="center" class="lr">{$row->cargo_code}
                            <br>
                            {if isNotNull($row->eway_bill_no)}
                                <img src="{$base_url}assets/img/icons/eway.svg" width="30px" loading="lazy">
                            {/if}
                            {if isNotNull($row->invoice_number)}
                                <img src="{$base_url}assets/img/icons/invoice.svg" width="30px" loading="lazy">
                            {/if}
                        </td>
                        {if $namespace == 'arthitrans'}
                            <td align="center"> {$row->cargo_item_name|default:'-'}</td>
                        {/if}   
                        <td align="center">{$row->total_item_count}{if $namespace == 'dishashree'} / {$row->total_unit_value}{/if}</td>
                        {if $namespace =='ktwoklogistics'}
                            <td align="center"> {$row->total_unit_value|default:'-'}</td>
                            <td align="center"> {$row->total_actual_unit_value|default:'-'}</td>
                        {/if}
                        {if in_array($namespace , ["ktwoklogistics"])}
                            <td align="left">{$row->private_mark_number}</td>
                        {/if}
                        {if in_array($namespace , ["knttransports", "kntlogistics", "vikascargo", "vikasecotrans"])}
                            <td align="center" width="50">{$row->cargo_item_description}</td>
                        {/if}
                        {* <td align="center" nowrap>{$row->booked_at|date_format:$ns_date_format}</td> *}
                        {if !in_array($namespace , ["vikascargo", "vikasecotrans", "ktwoklogistics"])}
                            <td align="center">{$row->from_organization_name}</td>
                            <td align="center">{$row->to_organization_name}</td>
                        {/if}
                        {if in_array($namespace , ["citycargo","cityparcel"])}
                            <td align="left">{$row->eway_bill_no}</td>
                        {/if}
                        <td align="left">{$row->from_customer_name}</td>
                        {if $namespace != 'newlinetrans'}
                            <td align="center">{$row->from_customer_mobile}</td>
                        {/if}
                        <td align="left">{$row->to_customer_name}</td>

                        {if $namespace != 'newlinetrans'}
                            <td align="center">{$row->to_customer_mobile}</td>
                        {/if}
                        {* <td align="left">{$row->user_first_name}</td> *}
                        <td align="center" {if $namespace == 'tippusultan'}class="payment-status" {/if}>{$cargo_payment_status[$row->payment_status_code]|strtoupper}</td>

                        {if !in_array($namespace , ["knttransports", "kntlogistics"])}
                            <td align="right">
                                {($row->total_amount)|number_format:2}
                                {assign var='o_freight_tot_amount' value=$row->total_amount + $o_freight_tot_amount}
                            </td>
                            {if !in_array($namespace , ["citycargo","cityparcel"])}
                                <td align="right">
                                    {$row->other_charges_amount|number_format:2}
                                    {assign var=o_other_tot_amount value=$o_other_tot_amount + $row->other_charges_amount}
                                </td>
                            {/if}
                        {/if}
                        {if in_array($namespace , ["citycargo","cityparcel"])}
                            <td align="right">
                                {($row->connecting_charge)|number_format:2}
                                {assign var='o_connecting_tot_amount' value=$row->connecting_charge + $o_connecting_tot_amount }
                            </td>
                        {/if}
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
                        <td align="right">
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
                    <td align="center"></td>
                    <td align="center"></td>
                    {if $namespace == 'arthitrans'} <td align="center"></td>{/if}
                    <td align="center" class="bold">{$o_qty}{if $namespace == 'dishashree'} / {$o_kg}{/if}</td>
                    {if $namespace == 'ktwoklogistics'}
                        <td align="center" class="bold">{$o_kg}</td>
                        <td align="center" class="bold">{$ac_kg}</td>
                    {/if}
                    <td colspan="{if in_array($namespace , ["vikascargo", "vikasecotrans"])}6{elseif in_array($namespace , ["knttransports", "kntlogistics"])}8{elseif in_array($namespace,["newlinetrans"])}5{elseif in_array($namespace , ["citycargo","cityparcel"])}8{elseif $namespace == 'ktwoklogistics'}6{else}7{/if}">&nbsp;</td>
                    {if !in_array($namespace , ["knttransports", "kntlogistics"])}
                        <td align="right">{$o_freight_tot_amount|number_format:2}</td>
                        {if !in_array($namespace , ["citycargo","cityparcel"])}
                            <td align="right">{$o_other_tot_amount|number_format:2}</td>
                        {/if}
                    {/if}
                    {if in_array($namespace , ["citycargo","cityparcel"])}
                        <td align="right">{$o_connecting_tot_amount|number_format:2}</td>
                    {/if}
                    <td align="right">{$o_pd_tot_amount|number_format:2}</td>
                    <td align="right" class="bold">{$o_pb_tot_amount|number_format:2}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td align="center" colspan="{if in_array($namespace , ["vikascargo", "vikasecotrans", "knttransports", "kntlogistics"])}13{elseif $namespace == 'newlinetrans'}12{elseif in_array($namespace , ["citycargo","cityparcel"])}15{else}14{/if}">Sorry! No cargo found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
    {if $namespace == 'newlinetrans'}
        <br />
        <b>Payments</b>
        <div class="table-responsive">
            <table class="table table-bordered" cellpadding="3" width="96%">
                <thead class="sticky-row-top">
                    <tr class="info bold">
                        <td>Category</td>
                        <td>Type </td>
                        <td>Payment Mode </td>
                        <td>Amount </td>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=array_reverse($expensesData)}
                        {if $row->cashbookType->code == 'HIRING' || $row->cashbookType->code == 'ADVANCE'}
                            <tr>
                                <td align="left">
                                    {if $row->cashbookType->transactionType == 'Cr'}
                                        Income
                                    {elseif $row->cashbookType->transactionType == 'Dr'}
                                        Expense
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td align="left">{$row->cashbookType->name}</td>
                                <td align="left">{$row->transactionMode->name}</td>
                                <td align="left">{$row->amount|default:'-'}</td>
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
        <br>
        <div class="table-responsive">
            <table class="table table-bordered" cellpadding="3" width="96%">
                <thead class="sticky-row-top">
                    <tr class="info bold">
                        <td>Category</td>
                        <td>Income / Expense Type </td>
                        <td>Payment Mode </td>
                        {* <td>Vendor/receiver Inc. </td> *}
                        <td>Inc. Amount </td>
                        <td>Exp. Amount</td>
                        {* <td>Remarks</td> *}
                        {* <td>Att.</td> *}
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$expensesData}
                        {if $row->cashbookType->code != 'HIRING' && $row->cashbookType->code != 'ADVANCE'}
                            <tr>
                                <td align="left">
                                    {if $row->cashbookType->transactionType == 'Cr'}
                                        Income
                                    {elseif $row->cashbookType->transactionType == 'Dr'}
                                        Expense
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
    {if $action_rights['OGPL-PAY-SUMRY']==1 && $namespace != 'srimaharaja'}
        <table width='96%'>
            <tr>
                <td><span class="bold"><b>Summary</b></span></td>
            </tr>
        </table>
        <table width='96%' class="bordered" cellpadding="3">
            <thead>
                <tr class="success">
                    <td align="center">{lang('lr')} Type</td>
                    <td align="center">No.of {lang('lr')}s</td>
                    <td align="center">No.of {lang('booking_article_label')}</td>
                    {if $namespace == "ktwoklogistics"}
                        <td align="center" rowspan="2">Kg</td>
                        <td align="center">Act Kg</td>
                    {/if}
                    <td align="center">Freight</td>
                    {if in_array($namespace , ["citycargo","cityparcel"])}
                        <td align="center">Connecting Charges</td>
                    {/if}
                    <td align="center">Loading Charges</td>
                    <td align="center">Unloading Charges</td>
                    <td align="center">Delivery Charges</td>
                    <td align="center">Service Tax</td>
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
                {assign var="total_connecting" value=0}
                {assign var="net_total" value=0}
                {assign var="ac_kg_total" value=0}
                {assign var="kg_total" value=0}

            <tbody class="body_table">
                {foreach item=route from=$summary key=key}
                    <tr>
                        <td align="center" colspan="{if in_array($namespace , ["citycargo","cityparcel"])}10{else}9{/if}"><b>{$routes[$key]}</b></td>
                    </tr>
                    {foreach item=row from=$route key=k }
                        <tr>
                            {assign var=total value=$row['freight']+$row['loading']+$row['unloading']+$row['service_tax']+$row['delivery']+$row['connecting']}
                            <td align="center"><b>{$cargo_payment_status[$k]}</b></td>
                            <td align="center">{$row['lr']}</td>
                            <td align="center">{$row['packages']}</td>
                            {if $namespace == 'ktwoklogistics'}
                                <td align="center">{$row['kg_amt']}</td>
                                <td align="center">{$row['ac_kg']}</td>
                            {/if}
                            <td align="center">{$row['freight']|number_format:2}</td>
                            {if in_array($namespace , ["citycargo","cityparcel"])}
                                <td align="center">{$row['connecting']|number_format:2}</td>
                            {/if}
                            <td align="center">{$row['loading']|number_format:2}</td>
                            <td align="center">{$row['unloading']|number_format:2}</td>
                            <td align="center">{$row['delivery']|number_format:2}</td>
                            <td align="center">{$row['service_tax']|number_format:2}</td>
                            <td align="center">{$total|number_format:2}</td>
                        </tr>

                        {assign var="total_lr" value=$total_lr+$row['lr']}
                        {assign var="total_pkgs" value=$total_pkgs+$row['packages']}
                        {assign var="total_frieght" value=$total_frieght+$row['freight']}
                        {assign var="total_loading" value=$total_loading+$row['loading']}
                        {assign var="total_unloading" value=$total_unloading+$row['unloading']}
                        {assign var="total_delivery" value=$total_delivery+$row['delivery']}
                        {assign var="total_service_tax" value=$total_service_tax+$row['service_tax']}
                        {assign var="total_connecting" value=$total_connecting+$row['connecting']}
                        {assign var="net_total" value=$net_total+$total}
                        {assign var="ac_kg_total" value=$ac_kg_total+$row['ac_kg']}
                        {assign var="kg_total" value=$kg_total+$row['kg_amt']}
                    {/foreach}
                {/foreach}
                <tr>
                    <td align="center"><b>Total</b></td>
                    <td align="center"><b>{$total_lr}</b></td>
                    <td align="center"><b>{$total_pkgs}</b></td>
                    {if $namespace == 'ktwoklogistics'}
                        <td align="center"><b>{$kg_total}</b></td>
                        <td align="center"><b>{$ac_kg_total}</b></td>
                    {/if}
                    <td align="center"><b>{$total_frieght|number_format:2}</b></td>
                    {if in_array($namespace , ["citycargo","cityparcel"])}
                        <td align="center"><b>{$total_connecting|number_format:2}</b></td>
                    {/if}
                    <td align="center"><b>{$total_loading|number_format:2}</b></td>
                    <td align="center"><b>{$total_unloading|number_format:2}</b></td>
                    <td align="center"><b>{$total_delivery|number_format:2}</b></td>
                    <td align="center"><b>{$total_service_tax|number_format:2}</b></td>
                    <td align="center"><b>{$net_total|number_format:2}</b></td>
                </tr>
            </tbody>

            </thead>
        </table>
    {/if}

    <div class="background-image"></div>
</body>
<style>
    body {
        width: unset;
    }

    table {
        border-collapse: collapse;
    }

    table thead th,
    table thead td {
        font-weight: bold;
    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
    }

    {if $bgimg}
        .background-image {
            position: absolute;
            background-image: url({$bgimg}) !important;
            background-repeat: repeat-y !important;
            background-position: center !important;
            height: 950px;
            width: 100%;
            top: 0;
            left: 0;
            z-index: -1;
        }
    {/if}
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }
    }

    {if $namespace =="arthitrans"}
        @page {
            size: A4 landscape;
        }
    {else}
        @page {
        size: A4 portrait;
    }
    {/if}
</style>

</html>
