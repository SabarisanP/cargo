<script type="text/javascript" src="assets/js/pages/cargo.js"></script>
<div class="brand_top">
    <h3>Registered Account Customer Pre Booking</h3>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body cargo-pre-booking-panel">

                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-6">
                                            <div class="btn-group btn-group-days {if !in_array('FTL', $cargo_setting->bookingModelTag) && !in_array('PTL', $cargo_setting->bookingModelTag)}hide{/if}" id="load-type-btns" data-toggle="buttons">
                                                <label class="btn btn-xs btn-success active" title="Regular Booking">
                                                    <input type="radio" name="lr-load-type" id="regular-load-cb" value="RGL" autocomplete="off" checked> Regular Booking
                                                </label>
                                                {if in_array('FTL', $cargo_setting->bookingModelTag)}
                                                    <label class="btn btn-xs btn-success" title="Full Truck Load">
                                                        <input type="radio" name="lr-load-type" id="ftl-load-cb" value="FTL" autocomplete="off"> Full Truck Load
                                                    </label>
                                                {/if}
                                                {if in_array('PTL', $cargo_setting->bookingModelTag)}
                                                    <label class="btn btn-xs btn-success" title="Partial truck Load">
                                                        <input type="radio" name="lr-load-type" id="ptl-load-cb" value="PTL" autocomplete="off"> Partial truck Load
                                                    </label>
                                                {/if}
                                                <br>
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="route-info">
                                    <div class="row">
                                        <div class="col-lg-offset-1 col-md-3">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h5> {lang('booking_from_label')}    
                                                        <label for="door-pickup" class="text-muted" style="display: inline;float: right;">Door Pickup  <input type="checkbox" id="door-pickup" name="door-pickup" onclick="setupDoorPickup();calculateAmounts();" />
                                                        </label>
                                                    </h5>
                                                    <div class="form-group">
                                                        <label for="from_branch" class="sr-only">Origin Branch</label>
                                                        <input type="text" class="form-control" id="from_branch" value="{$userDetail['org_code']}" onclick="toggleToBranch();">
                                                    </div>
                                                </div>
                                                {* <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="from_branch" class="sr-only">&nbsp;</label>
                                                        <div class="address-panel">
                                                        <label for="door-pickup"><input type="checkbox" id="door-pickup" name="door-pickup" onclick="setupDoorPickup();calculateAmounts();toggleStationBranch();" />
                                                            Door Pickup?</label>
                                                        </div>
                                                    </div>
                                                </div> *}
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            {* <h5>{lang('booking_to_label')}</h5> *}

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h5> {lang('booking_to_label')}    
                                                    <label for="door-delivery" class="text-muted" style="display: inline;float: right;"> Door Delivery <input type="checkbox" id="door-delivery" name="door-delivery" onclick="setupDoorDelivery();calculateAmounts();" />
                                                    </label>
                                                    </h5>
                                                    <div class="form-group">
                                                        <label for="to_branch" class="sr-only">To Station & Branch</label>
                                                        <input type="text" class="form-control" id="to_branch"/>
                                                    </div>
                                                </div>
                                                    {* <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="to_branch" class="sr-only">&nbsp;</label>
                                                            <div class="address-panel">
                                                            <label for="door-delivery"><input type="checkbox" id="door-delivery" name="door-delivery" onclick="setupDoorDelivery();calculateAmounts();toggleStationBranch();" />
                                                                Door Delivery?</label>
                                                            </div>
                                                        </div>
                                                    </div> *}
                                            </div>
                                        </div>

                                        {if $vendor_user->role->code != 'CGCUST'}
                                            <div class="col-md-2">
                                                <h5 for="">Vendor</h5>
                                                <div class="form-group">
                                                    <label for="prebook-vendor" class="sr-only">Vendor</label>
                                                    <input type="text" class="form-control" id="prebook-vendor">
                                                </div>
                                            </div>
                                        {/if}

                                        <div class="col-md-2">
                                            <h5 for="handover_at">Handover Date</h5>

                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <div class="input-group">
                                                        <input type="text" name="handover_at" class="form-control sdate" id="handover_at" readonly="true" placeholder="Date From">
                                                        <label class="input-group-addon" for="handover_at"><i class="fa fa-calendar"></i></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-offset-1 col-md-5">

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="from_phone" class="sr-only">Mobile</label>
                                                        <input type="Number" name="from_phone" value="" class="form-control" id="from_phone" maxlength="10" placeholder="CONSIGNOR / SENDER MOBILE" autocomplete="off" data-customerData="">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="from_name" class="sr-only">Name</label>
                                                        <input type="text" name="from_name" value="" class="form-control capitalize" id="from_name" maxlength="45" placeholder="CONSIGNOR / SENDER NAME" autocomplete="off">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row row-address-dropdown-1 hide">
                                                <div class="col-md-12">
                                                    <div class="dropdown form-group">
                                                        <button class="btn btn-default btn-xs dropdown-toggle form-control" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                            Choose Pick up Address
                                                            <span class="caret"></span>
                                                        </button>
                                                        <ul class="dropdown-menu checkbox-menu allow-focus col-md-12 address-dropdown-1" aria-labelledby="dropdownMenu1">


                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="from-address-components hide">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="fr_address">Pickup Address (Door No, Street)</label>
                                                            <input type="text" name="fr_address" value="" class="form-control" id="fr_address" maxlength="50" placeholder="Pickup Address (Door No, Street)" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <div>
                                                                <label for="txt_m_name">City</label>
                                                                <select id="fr_addr_station" class="form-control">
                                                                    <option value="">Select City</option>
                                                                    {foreach name=o item=row from=$stations}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="fr_landmark">Landmark</label>
                                                            <input type="text" name="fr_landmark" value="" class="form-control" id="fr_landmark" maxlength="50" placeholder="Landmark" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="fr_pincode">Pincode</label>
                                                            <input type="text" name="fr_pincode" value="" class="form-control" id="fr_pincode" maxlength="6" placeholder="Pincode" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-md-5">

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="to_phone" class="sr-only">Mobile</label>
                                                        <input type="Number" name="to_phone" value="" class="form-control" id="to_phone" maxlength="10" placeholder="CONSIGNEE / RECEIVER MOBILE"  autocomplete="off" data-customerData=""/>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="to_name" class="sr-only">Name</label>
                                                        <input type="text" name="to_name" value="" class="form-control capitalize" id="to_name" maxlength="45" placeholder="CONSIGNEE / RECEIVER NAME" autocomplete="off">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row row-address-dropdown-2 hide">
                                                <div class="col-md-12">
                                                    <div class="dropdown form-group">
                                                        <button class="btn btn-default btn-xs dropdown-toggle form-control" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                            Choose Delivery Address
                                                            <span class="caret"></span>
                                                        </button>
                                                        <ul class="dropdown-menu checkbox-menu allow-focus col-md-12 address-dropdown-2" aria-labelledby="dropdownMenu2">


                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="to-address-components hide">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="c_address1">Delivery Address (Door No, Street)</label>
                                                            <input type="text" name="to_address" value="" class="form-control" id="to_address" maxlength="50" placeholder="Delivery Address (Door No, Street)" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <div>
                                                                <label for="txt_m_name">City</label>
                                                                <select id="to_addr_station" class="form-control">
                                                                    <option value="">Select City</option>
                                                                    {foreach name=o item=row from=$stations}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="c_city">Landmark</label>
                                                            <input type="text" name="to_landmark" value="" class="form-control" id="to_landmark" maxlength="50" placeholder="Landmark" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="c_state">Pincode</label>
                                                            <input type="text" name="to_pincode" value="" class="form-control" id="to_pincode" maxlength="6" placeholder="Pincode" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-offset-1 col-md-10">
                                            <div class="table-responsive">
                                                <table class="table table-striped">
                                                    <thead>
                                                    <tr>
                                                        <th></th>
                                                        <th>{lang('booking_article_label')}</th>
                                                        <th>{lang('booking_article_description_label')}</th>
                                                        <th>{lang('booking_UOM_label')} {if lang('booking_UOM_label_info')}<i class="fa fa-info-circle" data-toggle="tooltip" data-title="{lang('booking_UOM_label_info')}"></i>{/if}</th>
                                                        <th>Actual wt.</th>
                                                        <th>Quantity</th>
                                                        <th>Freight Per Qty</th>
                                                        <th>Freight Total</th>
                                                        <th>Loading Charges</th>
                                                        <th>Unloading Charges</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="article_rows">

                                                    <tr id="article_row_1" data-index="1" class="article_row">
                                                        <td width="55"><a href="javascript:;" onclick="removeArticleRow(this);" data-index='1'  class="btn btn-sm btn-default tr_remove" title="Remove"><i class="fa fa-minus"></i></a></td>
                                                        <td width="300">
                                                            <input type="text" id="name" data-index='1' class="form-control" placeholder="Select {lang('booking_article_label')}"/>

                                                        </td>
                                                        <td width="300">
                                                            <input type="text" id="article-desc" class="form-control" placeholder="Select {lang('booking_article_description_label')}" data-mask="englishonly" maxlength="160"/>
                                                            <input type="hidden" id="article-unit-volumetric" value="">
                                                        </td>
                                                        <td width="200">
                                                            <div class="row">
                                                                <div class="col-md-5 p_r_n">
                                                                    <input type="text" class="form-control" onblur="calculateAmounts();" id="article-unit-val" value="1" data-mask="positivedecimal">
                                                                </div>
                                                                <div class="col-md-7 p_l_n">
                                                                    <select class="form-control" id="article-unit" onchange="setArticleUnit(this);setMinWeight(this);calculateAmounts();">
                                                                        {foreach item=value key=key from=$article_unit}
                                                                            <option value="{$key}">{$value}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td width="100">
                                                            <input type="text" class="form-control" id="actual-weight" value="0" data-mask="positivedecimal">
                                                        </td>
                                                        <td width="100"><input type="text" class="form-control" onblur="calculateAmounts();" id="qty" value="0" data-mask="positiveinteger"></td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="setArticleFreight(this); calculateAmounts();" disabled id="price" value="0" data-mask="inrcurrency">
                                                            </div>
                                                        </td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" id="total" disabled="" value="0">
                                                            </div>
                                                        </td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary" id="handling-type"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="validateMinHandling(this); calculateAmounts();" id="handling" value="0" data-mask="inrcurrency" {if $cargo_setting->loadingChargeEditFlag}disabled{/if}>
                                                            </div>
                                                        </td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="unloading" value="0" data-mask="inrcurrency">
                                                            </div>
                                                        </td>
                                                        <input type="hidden" class="form-control" id="code" value="">
                                                    </tr>


                                                    </tbody>
                                                    <tfoot>
                                                    <tr id="tr_add">
                                                        <td class="p-0" colspan="9">

                                                            <table class="table m-0">
                                                                <tr class="border-0">

                                                                    <td width="5%"><a href="javascript:;" class="btn btn-sm btn-primary" id="tr_add_btn" title="Add {lang('booking_article_label')}" onclick="addArticleRow()"> <i class="fa fa-plus"></i> </a></td>
                                                                    <td width="120">
                                                                        <div>
                                                                            <label for="from_phone">Total L. Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" id="total_loading_charges" value="0" disabled>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td width="120">
                                                                        <div id="pickup-charge-panel" class="hide">
                                                                            <label for="from_phone">Pickup Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="dp_charges" value="0" data-mask="inrcurrency">
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td width="120">
                                                                        <div id="delivery-charge-panel" class="hide">
                                                                            <label for="from_phone">Delivery Charges</label>
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="dd_charges" maxlength="6" value="0" data-mask="inrcurrency" {if $namespace == "srtparcel"} data-minvalue="250" onblur="setMinDeliveryCharges(this);"{else}{/if}>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>

                                                    <tr id="tr_clone" style="display:none">
                                                        <td width="55"><a href="javascript:;" onclick="removeArticleRow(this);" class="btn btn-sm btn-default tr_remove" title="Remove"><i class="fa fa-minus"></i></a></td>
                                                        <td width="300">
                                                            <input type="text" id="name" data-index='1' class="form-control" placeholder="Select Article"/>
                                                        </td>
                                                        <td width="300">
                                                            <input type="text" id="article-desc" class="form-control" placeholder="Select {lang('booking_article_description_label')}" data-mask="englishonly"/>
                                                            <input type="hidden" id="article-unit-volumetric" value="">
                                                        </td>
                                                        <td width="200">
                                                            <div class="row">
                                                                <div class="col-md-5 p_r_n">
                                                                    <input type="text" class="form-control" onblur="calculateAmounts();" id="article-unit-val" value="1" data-mask="positivedecimal">
                                                                </div>
                                                                <div class="col-md-7 p_l_n">
                                                                    <select class="form-control" id="article-unit" onchange="setArticleUnit(this);setMinWeight(this);calculateAmounts();">
                                                                        {foreach item=value key=key from=$article_unit}
                                                                            <option value="{$key}">{$value}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td width="100">
                                                            <input type="text" class="form-control" id="actual-weight" value="0" data-mask="positivedecimal">
                                                        </td>
                                                        <td width="100"><input type="text" class="form-control" onblur="calculateAmounts();" id="qty" value="0" data-mask="positiveinteger"></td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" disabled id="price" value="0" data-mask="inrcurrency">
                                                            </div>
                                                        </td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" id="total" disabled="" value="0">
                                                            </div>
                                                        </td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary" id="handling-type"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="validateMinHandling(this); calculateAmounts();" id="handling" value="0" data-mask="inrcurrency" {if $cargo_setting->loadingChargeEditFlag}disabled{/if}>
                                                            </div>
                                                        </td>
                                                        <td width="150">
                                                            <div class="input-group">
                                                                <span class="input-group-addon input-group-primary"><i class="fa fa-rupee"></i></span>
                                                                <input type="text" class="form-control" onblur="calculateAmounts();" id="unloading" value="0" data-mask="inrcurrency">
                                                            </div>
                                                        </td>
                                                        <input type="hidden" class="form-control" id="code" value="">
                                                    </tr>

                                                    </tfoot>
                                                </table>
                                            </div>

                                            <div class='row'>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label for="from_phone">Invoice Number(s)</label>
                                                        <input type="text" name="inv_numbers" class="form-control" id="inv_numbers"  placeholder="Invoice numbers" maxlength="60"/>
                                                    </div>
                                                </div>

                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label for="from_branch">Invoice Amount</label>
                                                        <input type="text" name="inv_amount" class="form-control" onblur="calculateAmounts();" id="inv_amount" placeholder="Total Invoice Amount" onblur="validateInvAmount()" maxlength="10" data-mask="inrcurrency"/>
                                                    </div>
                                                </div>

                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label for="from_phone">Invoice Date</label>
                                                        <input type="text" name="inv_date" class="form-control" id="inv_date"  placeholder="DD-MM-YYYY" readonly/>
                                                    </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="sender_sms">{lang('booking_sender_gst_term')}</label>
                                                        <input type="text" name="sender_gst" class="form-control" onblur="calculateAmounts();" id="sender_gst" placeholder="{lang('booking_sender_gst_term')}" maxlength="30"/>
                                                    </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="receiver_gst">{lang('booking_receiver_gst_term')}</label>
                                                        <input type="text" name="receiver_gst" class="form-control" onblur="calculateAmounts();" id="receiver_gst" placeholder="{lang('booking_receiver_gst_term')}" maxlength="30"/>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-12" style="display: flex; align-items: flex-end;">
                                                <div class="col-md-4">
                                                <label for="from_phone">E-Way Bill</label>
                                                <div class="input-group typeahead-input-group">
                                                   <input type="text" class="form-control" id="eway_bill" placeholder="E-Way Bill" maxlength="25" onblur="validateInvAmount()">
                                                   <span class="input-group-btn btn-group">
                                                   <button type="button" class="btn btn-default" title="Get E-Way Bill Details" id="eway_bill_validate_btn" onclick="getEwayBillDetails('eway_bill');" tabindex="-1"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                   </span>
                                                </div>
                                             </div>
                                                    <div style="flex-grow: 1;">
                                                        <input class="form-control" placeholder="Remarks" id="booking-remarks" data-mask="englishonly"/>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 small text-danger no-wrap" id="eway_bill_hint"></div>
                                                <div class="col-md-12">
                                                <div id="eway_bill_details"></div>
                                            </div>
                                            </div>
                                            <div class="row hide" id="invoice-table-panel">
                                                    <div class="col-md-8">
                                                        <div class="table-responsive">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th width="55"></th>
                                                                        <th>E-Way Bill Number</th>
                                                                        <th>Invoice Number</th>
                                                                        <th>Invoice Amount</th>
                                                                        <th>Invoice Date</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="invoice-list"></tbody>
                                                                <tfoot id="invoice-row-tpl" class="hide">
                                                                    <tr class="invoice-row">
                                                                        <td width="55">
                                                                            <a href="javascript:;" onclick="removeInvoiceRow(this);" class="btn btn-sm btn-default" title="Remove Invoice"><i class="fa fa-minus"></i></a>
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" class="form-control e_way_bill_number" placeholder="E-way bill number" maxlength="20" onchange="checkDuplicateEwayBill(this)"/>
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" class="form-control inv_number" placeholder="Invoice numbers" maxlength="20" />
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" class="form-control inv_amount" placeholder="Total Invoice Amount" onblur="calculateAmounts();validateInvAmount()" maxlength="9" data-mask="inrcurrency" />
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" class="form-control inv_date" placeholder="DD-MM-YYYY" readonly />
                                                                        </td>
                                                                    </tr>
                                                                </tfoot>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            <div class="clearfix_both"></div><br/>

                                            <div id="booking-action-state" class="alert alert-danger text-right" style="display: none"></div>
                                            <div class="well well-sm" id="confirm-row">
                                                <div class='row'>

                                                    <div class="col-md-offset-7 col-md-5 w-auto">
                                                        <div class="form-group" id="booking-form-bttons">
                                                            <label for="from_phone">&nbsp;</label>
                                                            <button class="btn btn-success" type="button" onclick="savePreBooking(1)">Preview & Confirm</button>&nbsp;
                                                            <button type="button" class="btn btn-default" onclick="checkURL();">Clear</button>&emsp;
                                                            <label for="remember-booking" class="d-inline">
                                                                <input type="checkbox" id="remember-booking" name="remember-booking"/>
                                                                Remember Details
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <input type="hidden" id="total_amount_roundoff">
                                                </div>
                                            </div>

                                        </div>


                                    </div>

                                    <input type="hidden" id="lr-prebooking-code">
                                </div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>

<script id="branch-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-9">
            <b class="branch-name"></b><br>
            <span class="station-name text-muted small"></span>
        </div>
        <div class="col-xs-3 text-right">
            <b class="branch-code"></b><br>
            <span class="station-code text-muted small"></span>
        </div>
    </div>
</script>

<script id="vendor-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-9">
            <b class="vendor-name d-inline-block" style="max-width: 350px; overflow: hidden;"></b><br>
            <span class="station-name text-muted small"></span>
        </div>
        <div class="col-xs-3 text-right">
            <b class="vendor-code"></b><br>
            <span class="station-code text-muted small"></span>
        </div>
    </div>
</script>

<script id="station-select-tpl" type="text/html">
    <div class="row">
        <div class="col-xs-9">
            <b class="station-name"></b>
        </div>
        <div class="col-xs-3 text-right">
            <b class="station-code"></b>
        </div>
    </div>
</script>

<div id="volumetric-calc-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideVolumetricDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="volumetric-calc-panel" class="clearfix" style="padding: 10px 5px;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="req">Dimension Unit</label>
                        <select id="volumetric-unit" class="form-control">
                            <option value="CM">Centimeters</option>
                            <option value="IN">Inches</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="req">Length</label>
                        <input type="text" class="form-control" placeholder="Length" id="volumetric-length" data-mask="positivedecimal"/>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="req">Width</label>
                        <input type="text" class="form-control" placeholder="Width" id="volumetric-width" data-mask="positivedecimal"/>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="req">Height</label>
                        <input type="text" class="form-control" placeholder="Height" id="volumetric-height" data-mask="positivedecimal"/>
                    </div>
                </div>
                <div class="col-md-12">
                    <div id="volumetric-calc-action-state"></div>
                </div>

                <div class="col-md-12 text-right" id="volumetric-calc-panel-btn">
                    <button type="submit" class="btn btn-success" id="volumetric-calc-btn" onclick="calcVolumetricUOM();">Calculate</button>&nbsp;
                    <button type="button" class="btn btn-default" onclick="hideVolumetricDialog();">Cancel</button>&nbsp;
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    var p_address = {};
    var d_address = {};

    var p_c_address = '';
    var d_c_address = '';

    var customers = {$customers|json_encode};
    var drivers = {$drivers|json_encode};
    var items = {$items|json_encode};
    var vendor = {$vendor_user|json_encode};
    var deliveryBranch = {$delivery_branches|json_encode};

    var vendors = {$vendors|json_encode};

    var branchRoutes = {$branchRoutes|json_encode};
    var cargoSetting = {$cargo_setting|json_encode};
    var payTypeConfig = {$pay_type|json_encode};
    var cargoRemarksList = {$cargoremarks|json_encode};

    var userBranchCode = '{$userDetail['org_code']}';
    var userStationCode = '{$userDetail['org_station_code']}';

    var cargoRateTermsRoute = [];
    var ns = {$namespace|json_encode};
    
    if (vendor.role.code == 'CGCUST') {
        var ven_data = _.find(vendors, function(o) { return o.user.code == vendor.code; });
    }

    $(document).on('click', '.allow-focus', function (e) {
      e.stopPropagation();
    });

    $('[data-toggle="tooltip"]').tooltip();

    function _init_cargo_pre_booking_page() {
        init_cargo_pre_booking_page_actions();
    }

    $('#handover_at').datepicker({
        //     todayHighlight: true,
        format: 'yyyy-mm-dd',
        startDate: '0d',
        autoclose: true,
        changeMonth: true,
    })

    $('#inv_date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-1d',
        endDate:'0d'
    });

    $('[data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });

    var branchSelectTpl = $('#branch-select-tpl').html();

    function formatResult(branch) {
        if (!branch.id) return branch.text;

        var $tpl = $(branchSelectTpl);
        $tpl.find('.branch-name').text(branch.name);
        $tpl.find('.branch-code').text(branch.shortCode);
        $tpl.find('.station-name').text(branch.station.name);
        $tpl.find('.station-code').text(branch.station.shortCode);
        return $tpl;
    };

    function getEwayBillData() {
        var data = {};
        data.ewayBillNo = $('#eway_bill').val();

        if (isNull(data.ewayBillNo)) {
            return;
        }

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-ewaybill-data',
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    if (isNotNull(res.data.fromTaxPayerDetails.tradeName)) {
                        $('#from_name').typeahead('val', res.data.fromTaxPayerDetails.tradeName);

                        var $firstOption = $('.tt-dataset-SENDER_NAME .tt-suggestion:first');
                        if ($firstOption.length) {
                            var selectedData = $firstOption.data(); 
                            selectFromCustomer(selectedData.ttSelectableObject);
                        }
                    }

                    if (isNotNull(res.data.toTaxPayerDetails.tradeName)) {
                        $('#to_name').typeahead('val', res.data.toTaxPayerDetails.tradeName);

                        var $firstOption = $('.tt-dataset-RECEIVER_NAME .tt-suggestion:first');
                        if ($firstOption.length) {
                            var selectedData = $firstOption.data(); 
                            selectToCustomer(selectedData.ttSelectableObject);
                        }
                    }

                    if (isNotNull(res.data.fromTaxPayerDetails.gstin)) {
                        $('#sender_gst').typeahead('val', res.data.fromTaxPayerDetails.gstin);
                    }
                    
                    if (isNotNull(res.data.toTaxPayerDetails.gstin)) {
                        $('#receiver_gst').typeahead('val', res.data.toTaxPayerDetails.gstin);
                    }
                }
            }
        });
        }
                                                                

    var vendorSelectTpl = $('#vendor-select-tpl').html();

    function formatVendorResult(vendor) {
        if (!vendor.id) return vendor.text;

        var $tpl = $(vendorSelectTpl);
        $tpl.find('.vendor-name').text(vendor.companyName);
        $tpl.find('.vendor-code').text(vendor.shortCode);
        $tpl.find('.station-name').text(vendor.station.name);
        $tpl.find('.station-code').text(vendor.station.shortCode);
        return $tpl;
    };

    function formatStationResult(station) {
        if (!station.id) return station.text;
        
        var $tpl = $($('#station-select-tpl').html());
        $tpl.find('.station-name').text(station.name);
        return $tpl;
    };

    function sortResults(results, container, query) {
        return results.sort((a, b) => a.text.toLowerCase().localeCompare(b.text.toLowerCase()));
    };

    function matcher(term, text, branch) {
        text = [branch.name, branch.shortCode, branch.station.name, branch.station.shortCode].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    function vendorMatcher(term, text, vendor) {
        text = [vendor.name, vendor.shortCode, vendor.station.name, vendor.station.shortCode].join(' ');
        return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
    };

    $(function () {
        var fromBranches = [];
        
        $.each(branchRoutes || [], function (i, row) {
            // if (row.bookingDeliveryFlag.charAt(0) != '1') return;

            var branch = row;
            branch.id = branch.code;
            branch.text = branch.name;

            fromBranches.push(branch);
        });

        $('#from_branch').select2({
            data: { results: fromBranches },
            placeholder: 'Select From Branch',
            formatResult: formatResult,
            formatSelection: formatResult,
            sortResults: sortResults,
            matcher: matcher
        });

        var vendorList = [];
        $.each(vendors || [], function (i, vendor) {
            if (vendor.activeFlag == 1) {
                vendor.id = vendor.code;
                vendor.text = vendor.name;
                vendorList.push(vendor);
            }
        });

        $('#prebook-vendor').select2({
            width: '100%',
            data: { results: vendorList },
            placeholder: 'Select Vendor',
            formatResult: formatVendorResult,
            formatSelection: formatVendorResult,
            matcher: vendorMatcher
        });

        toggleToBranch();

      
        $('input[name=lr-load-type], #door-pickup, #door-delivery').on('change', function() {
            var loadType = $('input[name=lr-load-type]:checked').val();
          
            if(loadType != 'RGL'){
                toggleStationBranch();
            }else{
                toggleStationBranch();
            }
        })
    });

    function toggleStationBranch(){
        var fromBranches = [];
        var fromStation = [];
        var station_code = [];
        var type = $('input[name="lr-load-type"]:checked').val();

        $.each(branchRoutes || [], function (i, row) {
            // if (row.bookingDeliveryFlag.charAt(0) != '1') return;

            var branch = row;
            branch.id = branch.code;
            branch.text = branch.name;
            
            if(station_code.indexOf(row.station.code) === -1){
                station_code.push(row.station.code);
                var station = row.station;
                station.id = station.code;
                station.text = station.name;
                fromStation.push(station);
            }
            fromBranches.push(branch);
        });
        
        if((isNotNull(type) && type == 'FTL') || (isNotNull(type) && type == 'PTL')){
            $('#from_branch').select2({
                data: { results: fromStation },
                placeholder: 'Select From Station',
                formatResult: formatStationResult,
                formatSelection: formatStationResult,
                sortResults: sortResults,
                matcher: matcher
            });
            $('#from_branch').val(userStationCode).trigger('change');
        }else{
            $('#from_branch').select2({
                data: { results: fromBranches },
                placeholder: 'Select From Branch',
                formatResult: formatResult,
                formatSelection: formatResult,
                sortResults: sortResults,
                matcher: matcher
            });
            $('#from_branch').val(userBranchCode).trigger('change');
        }
        toggleToBranch(type);
    }

    // work
    function toggleToBranch() {
        var fromBranch = $('#from_branch').select2('data');
        var fromBranchCode = $('#from_branch').val();
        var type = $('input[name="lr-load-type"]:checked').val();
        
        var toStation = [];
        var to_station_code = [];
        var toBranches = [];

        if (fromBranchCode) {
            if ($('#door-pickup').prop('checked') == true || $('#door-delivery').prop('checked') == true || (isNotNull(type) && type == 'FTL') || (isNotNull(type) && type == 'PTL')) {
                var route = _.find(branchRoutes, i => i.station.code == fromBranch.code);
            } else {
                var route = _.find(branchRoutes, i => i.code == fromBranch.code);
            }

               $.each(deliveryBranch[fromBranchCode] || [],(i,isBranch)=>{
                    $.each(branchRoutes || [],(j,branch)=>{
                        if(branch.code == isBranch){   
                            branch.id = branch.code;
                            branch.text = branch.name;
                            toBranches.push(branch);  
                        }
                    })
                })
        } else {
            $('#from_branch').val('').trigger('change');
        };

        $('#to_branch').select2('destroy');

        if($('#door-pickup').prop('checked') == true || $('#door-delivery').prop('checked') == true  || (isNotNull(type) && type == 'FTL') || (isNotNull(type) && type == 'PTL')){
            $('#to_branch').select2({
                data: { results: toStation },
                placeholder: 'Select To Station',
                formatResult: formatStationResult,
                formatSelection: formatStationResult,
                sortResults: sortResults,
                matcher: matcher
            });
        }else{
            $('#to_branch').select2({
                data: { results: toBranches },
                placeholder: 'Select To Branch',
                formatResult: formatResult,
                formatSelection: formatResult,
                sortResults: sortResults,
                matcher: matcher
            });
        }

        $('#to_branch').val('').trigger('change');
    }

    function setArticleUnit(unitsel) {
        var price = 0;
        var article_row = $(unitsel).closest('.article_row');
        var unitValue = $(article_row).find('#article-unit-val').val();
        var unit = $(article_row).find('#article-unit').val();
        var billableKG = Number(cargoSetting.billableKg) || 0;

        if (isNaN(unitValue) || unitValue < 1 || unit == 'NPPKG') {
            unitValue = 1;
            $(article_row).find('#article-unit-val').val(unitValue);
        }
        var article = $(article_row).find('#name').data('uiAutocomplete').selectedItem;
        if (menu_permission['PB-RATE-CARD'] == 1) {
            if (article) {
                var itemDetail = {};
                $.each(cargoRateTermsRoute || [], function (i, item) {
                    if (item.cargoItem.code == article.code) {
                        itemDetail = _.find(item.itemDetailList || [], d => d.unit.code == unit);
                        return false;
                    }
                });

                if (itemDetail) {
                    unitValue = (unitValue < itemDetail.minUnitValue) ? itemDetail.minUnitValue : Number(unitValue);
                    $(article_row).find('#article-unit-val').val(unitValue);
                    $(article_row).find('#price').val(itemDetail.amount);
                }
            }
        } else {
            if (unit == 'KG' && unitValue < billableKG) {
                unitValue = billableKG;
                $(article_row).find('#article-unit-val').val(billableKG);
            }
            if (article) {
                price = article.defaultRate;
            }
            $(article_row).find('#price').val(price);
        }

        if (unit == 'VOL') {
            showVolumetricDialog(article_row);
        }
    }

    function setMinWeight(unitsel){
        var article_row = $(unitsel).closest('.article_row');
        if(unitsel.value == 'KG'){
            $(article_row).find('#article-unit-val').val(cargoSetting.billableKg || 0).trigger('change');
        }
    }

    function validateMinHandling(el) {
        var $handlinginp = $(el);
        var minHandling = $handlinginp.data('min') || 0;

        if ($handlinginp.val() < minHandling) {
            $handlinginp.val(minHandling);
        }
    }

    function setVendorFromTo(ven){
        if(!ven) {
            return;
        }
        
        var cus = {};
        cus.from_phone = $.trim( $('#from_phone').val() );
        cus.from_name = $.trim( $('#from_name').val() );
        cus.to_phone = $.trim( $('#to_phone').val() );
        cus.to_name = $.trim( $('#to_name').val() );

        if (cus.from_phone == '' && cus.from_name == '') {
            $('#from_phone').val(ven.mobileNumber);
            $('#from_name').val(ven.name);
        }
    }

    function setVendorSettings(ven, pos, clear = true) {
        if(!ven) {
            return;
        }

        if(clear && isArticleSelected()) {
            alert('Selected Articles will be cleared');
            resetArticles();
            return;
        }

        var $article_row = $(pos ? ('#article_row_' + pos) : '.article_row');

        if (ven.loadingCharge > 0) {
            $article_row.find('#handling').val(ven.loadingCharge).data('min', ven.loadingCharge);
        } else if (ven.loadingCharge == -1) {
            $article_row.find('#handling').val(0).data('min', 0);
        }

        if (ven.unloadingCharge > 0) {
            $article_row.find('#unloading').val(ven.unloadingCharge).data('min', ven.unloadingCharge).trigger('blur');
        } else if (ven.loadingCharge == -1) {
            $article_row.find('#unloading').val(0).data('min', 0).trigger('blur');
        }
    }

    function isArticleSelected() {
        return $('.article_row').length > 1 || $('.article_row:first').find('#name').val() != '';
    }

    function resetArticles() {
        $('.article_row .tr_remove').trigger('click');
        addArticleRow(false);
    }

    function hasRCMBasedGST() {
        if (cargoSetting.lrGstTaxModel == 'RCMGST') {
            var senderGST = $.trim($('#sender_gst').val());
            var receiverGST = $.trim($('#receiver_gst').val());

            return isValidGstin(senderGST) && isValidGstin(receiverGST);
        }

        return false;
    }

    function getAllInputs() {
        inputs = $(document).find('input,select,#dropdownMenu1,#dropdownMenu2').filter(':visible:not([readonly]):not([type="hidden"]):not([disabled])');
    }
    
    function validateInvAmount() {
        var invoiceamount = Number($('#inv_amount').val());
        if (!isNaN(invoiceamount) && invoiceamount < 50000) {
            $('#eway_bill_hint').html('&nbsp;');
            return;
        }

        $('#eway_bill_hint').html('E-Way Bill required for Invoice Amount greater than 50,000');
    }

    function setArticleFreight(freightinp) {
        if (!freightinp) {
            return;
        }

        var article_row = $(freightinp).closest('.article_row');
        var item = $(article_row).find('#name').data('uiAutocomplete').selectedItem;
        if (!item) {
            return;
        }
        
        var fromOrg = $('#from_branch').select2('data') || {};
        if (!fromOrg.deviationPercentage && !item.minFreightAmount) {
            return;
        }
        
        var minValue = item.minFreightAmount;

        if (fromOrg.deviationPercentage > 0) {
            var percentValue = fromOrg.deviationPercentage / 100 * item.minFreightAmount;
            minValue = Math.floor(item.minFreightAmount - percentValue);
        }

        if (freightinp.value < minValue) {
            $(freightinp).val(minValue);
        }
    }

    function setMinDeliveryCharges(input) {
        var minvalue = $(input).data('minvalue') || 0;

        if (!minvalue || minvalue < Number(input.value)) return;
        $(input).val(minvalue);
    }

    if (menu_permission['PB-RATE-CARD'] == 1) {
    $('#route-info').on('change', function(e) {
        var data = {};
        var lrLoadType = $('[name="lr-load-type"]:checked').val();

        data.fromStation = {};
        var fromOrgData = $('#from_branch').select2('data') || {};
        if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
            data.fromStation.code = fromOrgData && fromOrgData.code;
        } else {
            data.fromStation.code = fromOrgData.station && fromOrgData.station.code;
        }
        
        data.toStation = {};
        var toOrgData = $('#to_branch').select2('data') || {};
        if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
            data.toStation.code = toOrgData && toOrgData.code;
        } else {
            data.toStation.code = toOrgData.station && toOrgData.station.code;
        }

        data.vendorUser = {};

        if (vendor.role.code == 'CGCUST') {
            data.vendorUser.code = ven_data.code;
        } else {
            data.vendorUser.code = $('#prebook-vendor').val();
        }
                
        data.fromCustomer = {};
        data.fromCustomer.mobile = $('#from_phone').val();

        var toCustomer = $('#to_phone').data('customerData') || {};
        data.toCustomer = {};
        data.toCustomer.mobile = $('#to_phone').val();

        if (!data.fromStation.code || !data.toStation.code) {
            return;
        }
        
        if (!data.fromCustomer.mobile || !data.toCustomer.mobile) {
            return;
        }
        
        noty({
            layout: 'topRight',
            theme: 'tisa_theme',
            type: 'information',
            text: 'Tariff Rate Card Loading...',
            closeWith: [],
            killer: true,
            timeout: 30000
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "prebooking/get-tariff-rate-card",
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    noty({
                        layout: 'topRight',
                        theme: 'tisa_theme',
                        type: 'success',
                        text: 'Tariff Rate Card Loaded Successfully',
                        closeWith: ['button'],
                        killer: true,
                        timeout: 5000
                    });
                    cargoRateTermsRoute = res.data.itemDetailList || [];

                    masterItems = [];
                    itemsMapped = _.keyBy(cargoRateTermsRoute, o => o.cargoItem.code);
                    $.each(items || [], function (i, item) {
                        if (itemsMapped[item.code]) {
                            masterItems.push(item);
                        }
                    });
                    resetArticles();
                } else {
                    noty({
                        layout: 'topRight',
                        theme: 'tisa_theme',
                        type: 'error',
                        text: res.errorDesc,
                        closeWith: ['button'],
                        killer: true,
                        timeout: 5000
                    });
                }
            }
        });
    });
    }

    function showVolumetricDialog(article_row) {
        $('#volumetric-calc-dialog').removeClass('hide');
        $('#volumetric-calc-dialog').dialog({
            autoOpen: true,
            height: 320,
            width: 550,
            modal: true,
            closeOnEscape:true,
            resizable: false
        });
        $('#volumetric-calc-dialog .inp_error').removeClass('inp_error');
        $('#volumetric-unit').val(localStorage.getItem('booking_volumetric_unit') || 'CM');
        $('#volumetric-length').val('');
        $('#volumetric-width').val('');
        $('#volumetric-height').val('');

        $('#volumetric-length').focus();
        $('#volumetric-calc-btn').data('article_row', article_row);
    }

    function hideVolumetricDialog() {
        $('#volumetric-calc-dialog').dialog('destroy');
        $('#volumetric-calc-dialog').hide();
        
        var article_row = $('#volumetric-calc-btn').data('article_row');
        $(article_row).find('#article-unit').val('NPPKG').trigger('change');
    }

    function calcVolumetricUOM() {
        var unit = $.trim($('#volumetric-unit').val());
        var length = $.trim($('#volumetric-length').val());
        var width = $.trim($('#volumetric-width').val());
        var height = $.trim($('#volumetric-height').val());

        var err = 0;
        $('#volumetric-calc-dialog .inp_error').removeClass('inp_error');
        if (unit == '') {
            $('#volumetric-unit').addClass('inp_error');
            err++;
        }
        if (length == '' || isNaN(length)) {
            $('#volumetric-length').addClass('inp_error');
            err++;
        }
        if (width == '' || isNaN(width)) {
            $('#volumetric-width').addClass('inp_error');
            err++;
        }
        if (height == '' || isNaN(height)) {
            $('#volumetric-height').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            return;
        }
        
        var article_row = $('#volumetric-calc-btn').data('article_row');

        if (unit == 'CM') {
            var denominator = 28316;
        } else if (unit == 'IN') {
            var denominator = 1728;
        }
        var capacity = Math.round((parseFloat(length) * parseFloat(width) * parseFloat(height)) / denominator * 6);
        $(article_row).find('#article-unit-val').val(capacity);
        $(article_row).find('#article-unit-volumetric').val('(' + [length, width, height].join('X') + ' ' + unit + ')');
        //

        calculateAmounts();
        $('#volumetric-calc-dialog').dialog('destroy');
        $('#volumetric-calc-dialog').hide();

        localStorage.setItem('booking_volumetric_unit', unit);
    }
</script>
