<div class="brand_top">
    <h3> Subscription</h3>
    <div class="text-right">
        {if $is_super_namespace==1}
            <button class="btn btn-primary" onclick="refreshBilling();"><i class="fa fa-refresh fa-lg"></i>Refresh</button>
            <a href="#report/subscription-report" target="_blank" class="btn btn-success">Subscription Report</a>
        {/if}
    </div>
</div>
<div id="main_wrapper">
    <div class="page_content" style="min-height: 350px;">
        <div id="container-fluid">
            <div class="row">
                <div id="subscription" class="">
                    <br>
                    <div class="col-md-offset-1 col-lg-10">

                        <div class="row">
                            <div class="col-lg-12 p_t_50 p_l_n">
                                <p class="bold">Once your initial setup payment has been cleared your billing cycle begins.</p>
                                <p>On a monthly basis, we charge you a fee per consignement number created, using the cargo platform during a calendar month</p>

                            </div>
                        </div>

                        <div class="row p_t_50">
                            <h3 class="header">Billing Overview</h3>
                            <div class="col-lg-12 p_l_n d-flex align-items-center">
                                <div class="col-md-3">
                                    <label for="">Consignment Counter</label>
                                    <div class="panel panel-default billing-text-box">
                                        <div class="panel-body">

                                            <div class="">
                                                <p class="billing-count">{$billing->gcCount}</p>
                                                <p class="subscription-type"> - GC/month</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="">SMS Counter</label>

                                    <div class="panel panel-default billing-text-box">
                                        <div class="panel-body">
                                            <div class="">
                                                <p class="billing-count">{$billing->smsCount}</p>
                                                <p class="subscription-type"> - SMS/month</p>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-md-3">
                                    <label for="">Whatsapp Counter</label>
                                    <div class="panel panel-default billing-text-box">
                                        <div class="panel-body">
                                            <div class="">
                                                <p class="billing-count">{$billing->whatsappCount}</p>
                                                <p class="subscription-type"> - MSG/month</p>
                                            </div>
                                        </div>
                                    </div>

                                    {* <p id="billing-not-activated">Not Activated</p> *}
                                </div>

                            </div>

                            <div class="col-lg-12 p_l_n d-flex align-items-center p_t_50">
                                <div class="col-md-3">
                                    <label for="">Ezeebot Counter</label>

                                    <div class="panel panel-default billing-text-box">
                                        <div class="panel-body">
                                            <div class="">
                                                <p class="billing-count">{$billing->ezeebotCount}</p>
                                                <p class="subscription-type"> - user/month</p>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-md-3">
                                    <label for="">Email Counter</label>
                                    <div class="panel panel-default billing-text-box">
                                        <div class="panel-body">
                                            <div class="">
                                                <p class="billing-count">{$billing->emailCount}</p>
                                                <p class="subscription-type"> - mail/month</p>
                                            </div>
                                        </div>
                                    </div>

                                    {* <p id="billing-not-activated">Not Activated</p> *}
                                </div>
                                <div class="col-md-3 p_l_n">
                                    <div>
                                        <ul id="subscription-terms">
                                            <li>GC charges applicable as per agreement.</li>
                                            <li>Local SMS charges applicable at Rs.0.25/SMS.</li>
                                            <li>International SMS charges applicable at Rs. 5/SMS.</li>
                                            <li>Email is free.</li>
                                            <li>All charges are exclusive of 18% GST.</li>
                                        </ul>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="row p_t_50">
                            <div class="col-lg-12 p_l_n">
                                <div class="col-md-3" id="subs-ratecard-table-div">

                                    <div class="panel panel-default">
                                        <div class="panel-body p-0">
                                            {if $billing->pricingModel == 'LRCNT'}
                                                <table class="table">
                                                    <thead>
                                                        <th>Total LR per month</th>
                                                        <th>Pricing</th>
                                                    </thead>
                                                    <tbody>
                                                        {foreach from=$billing->billingRateCard item=row}
                                                            <tr>
                                                                <td>{$row->fromValue} to {$row->toValue}</td>
                                                                <td>
                                                                    {$row->amount}
                                                                    {if $row->rateCardType->code == "METERED"}
                                                                        /GC
                                                                    {else}
                                                                        flat/month
                                                                    {/if}
                                                                </td>
                                                            </tr>
                                                        {/foreach}
                                                    </tbody>
                                                </table>
                                            {elseif $billing->pricingModel == 'LRVOL'}
                                                {foreach from=$billing->billingRateCard item=row}
                                                    <b>{$row->fromValue}% of Total Transactions per month</b><br><br>
                                                    {break}
                                                {/foreach}
                                            {/if}

                                            {foreach from=$billing->billingNotification item=row}
                                                {if $row->activeFlag == 1}
                                                    <span><b>{$row->notificationMedium->code} :</b> <i class="fa fa-inr"></i> {$row->amount} / per {$row->notificationMedium->code}</span> <br>
                                                {/if}
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="panel panel-default col-md-6">
                                        <div class="panel-body p-0">
                                            <p>Total charges till date : <b><i class="fa fa-inr"></i> {$billing->totalAmount|inr_format}</b> /month </p>
                                        </div>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                        <div class="p_t_30 pb10">
                                            {if $billing->pricingModel == 'LRCNT'}
                                                <p>
                                                    <b>For example: </b> If per month LR count is 2350/month then the pricing calculations will be
                                                    [ 0 to 1000 LR = ₹3000/Flat ] + [ 1001 to 2000 LR (1000*₹2.5) = ₹2500 ] + [ 2001 to 4000 LR (350*₹2) = ₹700 ],
                                                    then the total value will be ₹6200/month.
                                                </p>
                                            {/if}
                                        </div>
                                    <div class="clear_fix_both"></div>

                                    <div>
                                        <p class="bold f-15">Need Enterprise Setup?</p>
                                        <p>Using 30,000+ Receipts /Month</p>
                                        <p>Contact for Pricing</p>
                                    </div>
                                </div>
                                <div class="col-md-3">

                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <h3 class="header">Invoices</h3>

                            <div class="col-lg-12 p_l_n">
                                <div class="panel panel-default  ">
                                    <div class="panel-body p-0">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr class="success">                                                   
                                                    <th>Invoice Date</th>
                                                    <th>Invoice Month</th>
                                                    <th>Invoice Due</th>
                                                    <th>Status</th>
                                                    <th>Invoice Amount</th>
                                                    <th>Balance Due</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach from=$invoice item=row key=k}
                                                    {if $row->status->code == 3 || $row->status->code == 4  || $row->status->code == 5}
                                                        {assign var="amount" value=(($row->amount + $row->cgst + $row->sgst + $row->igst) + ($row->adjustment))}
                                                        {assign var="due" value=$row->balanceDue}
                                                        <tr>                                                            
                                                            <td>{$row->invoiceDate|date_format:"d-m-Y"}</td>
                                                            <td>{$row->invoiceMonth}</td>
                                                            <td>{$row->dueDate|date_format:"d-m-Y"}</td>
                                                            <td align="center"><span class="{$invoice_status[$row->status->code]['bg_class']}">{$invoice_status[$row->status->code]['name']}</span></td>
                                                            {if $row->status->code != 5}
                                                                <td align="right">{$amount|inr_format}</td>
                                                                <td align="right">{$due|inr_format}</td>
                                                            {else}
                                                                <td align="right">-</td>
                                                                <td align="right">-</td>
                                                            {/if}
                                                            <td align="left">   
                                                                {if $row->status->code != 5}
                                                                <a href="javascript:;" onclick="showPaymentQr({$row->code}, '{$due|inr_format}')" class="btn btn-primary btm-sm" ><i class="fa fa-money" aria-hidden="true"></i>Pay Now</a>                                                                    
                                                                &nbsp;
                                                                {/if}
                                                                <a href="{$vertex_domain}/api/{$accountCode}/{$accessToken}/invoice/{$row->code}/download" class="btn btn-default btm-sm invoice-download"  target="_blank" ><i class="fa fa-download" aria-hidden="true"></i>Download</a>
                                                            </td>
                                                        </tr>

                                                        {if $row->status->code != 5}
                                                            {assign var="invamount" value=$invamount + $amount}
                                                            {assign var="invdue" value=$invdue + $due}
                                                        {/if}
                                                    {/if}    
                                                {foreachelse}
                                                    <tr>
                                                        <td colspan="6" align="center">No Invoices Found</td>
                                                    </tr>
                                                {/foreach}
                                                <tr>
                                                    <td colspan="4" align="right">Total</td>
                                                    <td align="right">{$invamount|inr_format}</td>
                                                    <td align="right">{$invdue|inr_format}</td>
                                                    <td align="left">
                                                        <a href="javascript:;" onclick="showPaymentQr('ALL', '{$invdue|inr_format}')" class="btn btn-primary btm-sm" ><i class="fa fa-money" aria-hidden="true"></i>Pay Now</a>
                                                    </td>
                                                </tr>    
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row p_t_30">
                            <h3 class="header">Add On</h3>
                            <div class="col-lg-12 p_l_n">

                                <div class="col-md-4 p_l_n">
                                    <div class="panel panel-default p-0 addon-panel">
                                        <div class="panel-body">
                                            <p class="bold">Custom SMS masking</p>
                                            <p class="addon-text">When an SMS is delivered there is a 6 digit SMS mask used as the sender
                                                name. You would have probably noticed this while receiving OTP SMSs like
                                                'AB-ICICIB', etc. We could do the same thing for you. For example, SMS
                                                received by your customers could be from your company name.
                                            </p>

                                            <div class="row addon-bottom-div" data-code="S">
                                                <div class="col-md-10">
                                                    <p class="bold">Pricing : <span id="price">Rs.5000 </span> /One Time </p>
                                                </div>
                                                <div class="col-md-2">
                                                    <span class="badge" id="badge">Activated</span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="panel panel-default p-0 addon-panel">
                                        <div class="panel-body">
                                            <p class="bold">Custom Email masking</p>
                                            <p class="addon-text">When an email is sent using the platform, the name used in the email is your
                                                company name. However, the email ID used is no-reply@ezeeinfo.in. We could
                                                customize this for you to email ID of your preference.
                                                Note: Multiple email IDs can be added as well. For each email ID added an
                                                additional ₹ 5000 would be charged as one time activation fee.
                                            </p>

                                            <div class="row addon-bottom-div" data-code="E">
                                                <div class="col-md-10">
                                                    <p class="bold">Pricing : <span id="price">Rs.5000 </span> /One Time </p>
                                                </div>
                                                <div class="col-md-2">
                                                    <span class="badge" id="badge">Activated</span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="panel panel-default p-0 addon-panel">
                                        <div class="panel-body">
                                            <p class="bold">EzeeBot Notification</p>
                                            <div class="d-flex">
                                                <img src="assets/img/ezeebot.png" id="ezeebot-subs" alt="">
                                                <p class="addon-text">You can subscribe for Admin level notifications using this
                                                    platform, A dedicated App is provided for all types of
                                                    notifications & incidents happening inside the account.
                                                    beneficial & no cost.
                                                </p>
                                            </div>

                                            <div class="row addon-bottom-div" data-code="B">
                                                <div class="col-md-10">
                                                    <p class="bold">Pricing : <span id="price">Rs.5000 </span> /One Time </p>
                                                </div>
                                                <div class="col-md-2">
                                                    <span class="badge" id="badge">Activated</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row p_t_50">
                            <p>To get more information regarding any of these services please email support@ezeecargo.com or call +91 9500007529</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="payment-dialog" style="display: none">
    
    
    <div class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-sm-8">
                <span class="h5 bold font-17" id="lbl-amt"></span>
                <span id="amt-notes">[ Dues to be paid ]</span>
            </div>
            <div class="col-sm-4">
                <a href="javascript:;" class="pull-right" onclick="closePaymentDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
            </div>
        </div>
    </div>
    <hr>                                            
    <div class="clearfix" style="padding: 10px 5px;">
        <div class="row">

            <div class="col-sm-6">
                <div class="bank-details">
                    <div class="notes">
                        <span class="bold">Fund Transfer: </span> Transfer the bill amount to the below bank.
                    </div>
                    <div class="account-number">    
                        <div>Bank Details :</div>
                        <div>Bank : HDFC Bank</div>
                        <div>Name : EzeeInfo Cloud Solutions Pvt Ltd</div>
                        <div>Account No : 50200020457900</div>
                        <div>IFSC Code : HDFC0001297</div>
                        <div>Branch : Vadapalani, Chennai</div>
                        <div>Account Type : Current Account</div>
                    </div>                            
                </div>
            </div>
            <div class="col-sm-6 b_l">
                <div class="text-center">                           
                    <img src="assets/img/scan-pay.svg" width="150" class="img-fluid " alt="Scan & Pay">
                </div> 
                <div class="text-center">                           
                    <img src="assets/img/ezee-qr-code.svg" width="200" class="img-fluid " alt="QR">
                </div> 
                <div class="text-center font-17">                           
                    ezeeinfocloud.hdfc@upi
                </div>  
            </div>
            
        </div>
    </div>   
    <hr> 

    <div class="row">    
        <div class="col-sm-4">
            <div class="form-group">
                <label class="req">Reference</label>
                <input type="text" class="form-control" id="pay-ref" placeholder="Payment Reference" maxlength="50" value="">
            </div>
        </div>
        <div class="col-sm-3">
            <div class="form-group">
                <label class="req">Amount Paid</label>
                <input type="text" class="form-control" id="pay-amnt" placeholder="Paid Amount" maxlength="7" value="">
            </div>
        </div>
        <div class="col-sm-2">
            <div class="form-group">
                <label>&nbsp;</label>
                <button type="button" class="btn btn-success" onclick="recordPayment();">Record Payment</button>&nbsp;
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="alert" id="pmt-action">
               
            </div>                                    
        </div>
    </div>
    <input type="hidden" id="hid-inv-code" value="">
</div>


<script>
    var billing = {$billing|json_encode};

    if (_isdefined(billing.addonDetails)) {
        $.each(billing.addonDetails || [], function(index, value) {
            var row = $('.addon-bottom-div[data-code="' + value.code + '"]');
            $row = $(row);
            $row.find('#badge').removeClass('badge-warning').addClass('badge-primary').text('Activate');

            if (value.activeFlag == 1) {
                $row.find('#badge').removeClass('badge-primary').addClass('badge-warning').text('Enabled')
            }
            $row.find('#price').html('<i class="fa fa-inr"></i> ' + value.value);

        });
    }
    
    $(".invoice-download").bind( "click", function(event){
        ga_track_event('Subscription : Invoice Download', ns_username, '');
    });    

    function showPaymentQr(code, amt) {
        ga_track_event('Subscription : Invoice Paynow', ns_username, '');
        var $dialog = $('#payment-dialog');
        $dialog.dialog({
            autoOpen: true,
            height: 700,
            width: 850,
            modal: true,
            resizable: false
        });

        $('#lbl-amt').html('Rs. '+amt);
        $('#hid-inv-code').val(code);        
    }    
    
    function closePaymentDialog() {
        var $dialog = $('#payment-dialog');
        $dialog.dialog('destroy');
        $dialog.hide();
    }

    function recordPayment() {
        var data = {};
        data.invcode = $('#hid-inv-code').val();
        data.refno = $('#pay-ref').val();
        data.amount = $('#pay-amnt').val();

        var err = 0;
        if (data.refno == '') {
            $('#pay-ref').addClass('inp_error');
            err++;
        } else {
            $('#pay-ref').removeClass('inp_error');
        }

        if (data.amount == '') {
            $('#pay-amnt').addClass('inp_error');
            err++;
        } else {
            $('#pay-amnt').removeClass('inp_error');
        }
        
        if (err > 0) {
            $('#pmt-action').removeClass('alert-success')
                            .addClass('alert-danger')                            
                            .html('Please select the values in the field that are marked in red')
                            .show();            
            return false;
        } else {
            $('#pmt-action').removeClass('alert-success')
                            .removeClass('alert-danger')
                            .html(loading_popup)
                            .show();        
        }        

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "admin/subscription-payment-email",
            data: data,
            success: function(response) {
                if (response.status == 1) {    
                    $('#pmt-action').removeClass('alert-danger')
                                    .addClass('alert-success')
                                    .html('Payment email sent successfully. Your payment will be updated in the system within 48 hours, for instant updates please call your Account Managers.')
                                    .show();       
                } else {
                    $('#pmt-action').removeClass('alert-success')
                                    .addClass('alert-danger')
                                    .html('Payment email failed. Please contact your account managers if amount debited.')
                                    .show();
                }                
            }
        });
        ga_track_event('Subscription : Record Payment', ns_username, '');
    }


    function refreshBilling() {

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "admin/refresh-billing-status",
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });

                    window.setTimeout(function() {
                        loading_overlay.hide();
                        checkURL();
                    }, 1000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });

                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 1000);
                }
            }
        });
    }
</script>