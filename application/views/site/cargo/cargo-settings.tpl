<style>
.radius-8{
    border-radius:8px;
}
.example-section{
    border-radius: 8px;
    background-color: rgba(255, 255, 255, 0.92);
    padding:20px;
}
</style>
<div class="brand_top"><h3> Cargo Settings</h3></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12" >
                    <br>
                    <div class="panel panel-default radius-8">
                        <div class="panel-body">
                            <div id="account_setting" class="tab-pane">
                                <form role="form" id="form1" class="form-horizontal p_l_15" onsubmit="return false;">
                                    <div class="well radius-8">
                                     <h5 class="b_b_d"><b>BOOKING</b></h5>
                                        <div class="row">
                                            {* <h5 class="b_b_d fw-3">Booking</h5> *}

                                            <div class="col-md-6">
                                                <h4 class="heading_a">Booking Model</h4>
                                                <div class="btn-group btn-group-days bookingModelTag" data-toggle="buttons">
                                                    <label class="btn btn-success btn-xs chk-btn {if in_array('RGL', $result->bookingModelTag)}active{/if}" title="Regular Booking">
                                                        <input type="checkbox" {if in_array('RGL', $result->bookingModelTag)}checked="checked"{/if} name="booking_model_tag" value="RGL">Regular Booking
                                                    </label>
                                                    <label class="btn btn-success btn-xs chk-btn {if in_array('FTL', $result->bookingModelTag)}active{/if}" title="Full Truck Load">
                                                        <input type="checkbox" {if in_array('FTL', $result->bookingModelTag)}checked="checked"{/if} name="booking_model_tag" value="FTL">Full Truck Load
                                                    </label>
                                                    <label class="btn btn-success btn-xs chk-btn {if in_array('PTL', $result->bookingModelTag)}active{/if}" title="Partial Truck Load">
                                                        <input type="checkbox" {if in_array('PTL', $result->bookingModelTag)}checked="checked"{/if} name="booking_model_tag" value="PTL">Partial Truck Load
                                                    </label>
                                                </div> &emsp;
                                                <div class="btn-group btn-group-days bookingModelTag" data-toggle="buttons">
                                                    <label class="btn btn-success btn-xs chk-btn {if in_array('OUT', $result->bookingModelTag)}active{/if}" title="Out Station">
                                                        <input type="checkbox" {if in_array('OUT', $result->bookingModelTag)}checked="checked"{/if} name="booking_model_tag" value="OUT">Out Station
                                                    </label>
                                                    <label class="btn btn-success btn-xs chk-btn {if in_array('LOC', $result->bookingModelTag)}active{/if}" title="Local">
                                                        <input type="checkbox" {if in_array('LOC', $result->bookingModelTag)}checked="checked"{/if} name="booking_model_tag" value="LOC">Local
                                                    </label>
                                                </div> 
                                                {assign var="cargo_additional" value=config_item('cargo_additional')}
                                                <div class="btn-group btn-group-days  bookingModelTag" data-toggle="buttons" style="margin-top: 25px;">
                                                    <label class="btn btn-success btn-xs chk-btn {if in_array('EXPDL', $result->bookingModelTag)}active{/if}" title="Express Delivery">
                                                        <input type="checkbox" {if in_array('EXPDL', $result->bookingModelTag)}checked="checked" {/if} name="booking_model_tag" value="EXPDL">{$cargo_additional['EXPDL']['name']}
                                                    </label>
                                                    <label class="btn btn-success btn-xs chk-btn {if in_array('HDLWC', $result->bookingModelTag)}active{/if}" title="Handle With Care">
                                                        <input type="checkbox"{if in_array('HDLWC', $result->bookingModelTag)}checked="checked"{/if} name="booking_model_tag" value="HDLWC">{$cargo_additional['HDLWC']['name']}
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <h4 class="heading_a">UOM Model</h4>
                                                <select id="cargoUnitModel" class="form-control" multiple>
                                                    {foreach from=$article_unit item=name key=code}
                                                        <option value="{$code}">{$name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-sm-2">
                                                <h4 class="heading_a">Edit Booking Date Limit</h4>
                                                <input type="number" id="edit-booking-days-limit" class="form-control no-spin" placeholder="Value" value="{$result->bookingDateEditDaysLimit}" min="0" max="30">
                                            </div>
                                            <div class="clearfix"></div><br>

                                            <div class="col-sm-3 pb10">
                                                <h4 class="heading_a">Minimum Fright Amount to Levy GST</h4>
                                                <input type="text" style="width:60px"  value='{$result->minServiceTax}' class="he_25 form-control" id="minServiceTax">
                                            </div>

                                            <div class="col-sm-2 pb10">
                                                <h4 class="heading_a">Round off (Net Amount)</h4>
                                                <select class="form-control" id="rndOffreightAmt" style="width:60px">
                                                    <option value="-10" {if $result->totalFreightRoundOffValue == -10}selected="selected"{/if}>-10</option>
                                                    <option value="-5" {if $result->totalFreightRoundOffValue == -5}selected="selected"{/if}>-5</option>
                                                    <option value="-1" {if $result->totalFreightRoundOffValue == -1}selected="selected"{/if}>-1</option>
                                                    <option value="0" {if $result->totalFreightRoundOffValue == 0}selected="selected"{/if}>0</option>
                                                    <option value="1" {if $result->totalFreightRoundOffValue == 1}selected="selected"{/if}>1</option>
                                                    <option value="5" {if $result->totalFreightRoundOffValue == 5}selected="selected"{/if}>5</option>
                                                    <option value="10" {if $result->totalFreightRoundOffValue == 10}selected="selected"{/if}>10</option>
                                                </select>
                                            </div> 

                                            <div class="col-sm-2 pb10">
                                                <h4 class="heading_a">Round off (Delivery)</h4>
                                                <select class="form-control" id="deliveryRoundOffValue" style="width:60px">
                                                    <option value="-10" {if $result->deliveryRoundOffValue == -10}selected="selected"{/if}>-10</option>
                                                    <option value="-5" {if $result->deliveryRoundOffValue == -5}selected="selected"{/if}>-5</option>
                                                    <option value="-1" {if $result->deliveryRoundOffValue == -1}selected="selected"{/if}>-1</option>
                                                    <option value="0" {if $result->deliveryRoundOffValue == 0}selected="selected"{/if}>0</option>
                                                    <option value="1" {if $result->deliveryRoundOffValue == 1}selected="selected"{/if}>1</option>
                                                    <option value="5" {if $result->deliveryRoundOffValue == 5}selected="selected"{/if}>5</option>
                                                    <option value="10" {if $result->deliveryRoundOffValue == 10}selected="selected"{/if}>10</option>
                                                </select>
                                            </div> 

                                            <div class="col-sm-1 pb10">
                                                <h4 class="heading_a">GST %</h4>
                                                <input type="text" style="width:60px" value='{$result->serviceTaxPercentage}' class="he_25 form-control" id="serviceTaxPercentage" >
                                            </div>

                                            <div class="col-sm-1 pb10">
                                                <h4 class="heading_a">POD Charge</h4>
                                                <input type="text" style="width:60px" value='{$result->podCharge}' class="he_25 form-control" id="podCharge">
                                            </div>

                                            <div class="col-sm-2 pb10">
                                                <h4 class="heading_a">Minimum  Billable Kg</h4>
                                                <input type="text" style="width:60px" value='{$result->billableKg}' class="he_25 form-control" id="billableKg">
                                            </div> 
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h4 class="heading_a">Default Loading Charge</h4>
                                                <div class="form-group col-sm-5">
                                                    <input type="text" id="defaultLoadigCharge" class="form-control" value="{$result->defaultLoadigCharge}">
                                                </div>
                                                <div class="form-group col-sm-4">
                                                    <select id="loadingChargePercentageFlag" class="form-control">
                                                        <option value="0" {if $result->loadingChargePercentageFlag == false}selected="selected"{/if}>Flat</option>
                                                        <option value="1" {if $result->loadingChargePercentageFlag == true}selected="selected"{/if}>Percentage</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-sm-5">
                                                    <select id="loadingChargeEditFlag" class="form-control">
                                                        <option value="0" {if $result->loadingChargeEditFlag == false}selected="selected"{/if}>Editable</option>
                                                        <option value="1" {if $result->loadingChargeEditFlag == true}selected="selected"{/if}>Readonly</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-sm-2 pb10">
                                                <h4 class="heading_a">Round off (Loading Charge)</h4>
                                                <select class="form-control" id="rndOffLoadingCharge" style="width:60px">
                                                    <option value="-10" {if $result->loadingChargeRoundOffValue == -10}selected="selected"{/if}>-10</option>
                                                    <option value="-5" {if $result->loadingChargeRoundOffValue == -5}selected="selected"{/if}>-5</option>
                                                    <option value="-1" {if $result->loadingChargeRoundOffValue == -1}selected="selected"{/if}>-1</option>
                                                    <option value="0" {if $result->loadingChargeRoundOffValue == 0}selected="selected"{/if}>0</option>
                                                    <option value="1" {if $result->loadingChargeRoundOffValue == 1}selected="selected"{/if}>1</option>
                                                    <option value="5" {if $result->loadingChargeRoundOffValue == 5}selected="selected"{/if}>5</option>
                                                    <option value="10" {if $result->loadingChargeRoundOffValue == 10}selected="selected"{/if}>10</option>
                                                </select>
                                            </div>

                                            <div class="col-sm-3">
                                                <h4 class="heading_a">Default Docket Charge</h4>
                                                <div class="form-group col-sm-5">
                                                    <input type="text" id="defaultDocketCharge" class="form-control" value="{$result->defaultDocketCharge}">
                                                </div>
                                                <div class="form-group col-sm-4">
                                                    <select id="docketChargePercentageFlag" class="form-control" disabled>
                                                        <option value="0" {if $result->docketChargePercentageFlag == false}selected="selected"{/if}>Flat</option>
                                                        <option value="1" {if $result->docketChargePercentageFlag == true}selected="selected"{/if}>Percentage</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-sm-5">
                                                    <select id="docketChargeEditFlag" class="form-control">
                                                        <option value="0" {if $result->docketChargeEditFlag == false}selected="selected"{/if}>Editable</option>
                                                        <option value="1" {if $result->docketChargeEditFlag == true}selected="selected"{/if}>Readonly</option>
                                                    </select>
                                                </div>
                                            </div> 

                                            <div class="col-sm-2">
                                                <h4 class="heading_a">Min Total Freight Amount</h4>
                                                <input type="number" style="width:80px" value='{$result->minFreightAmount}' class="he_25 form-control no-spin" id="minFreightAmount" >
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-5">
                                                <h4 class="heading_a">Default UnLoading Charge</h4>
                                                <div class="p_l_n col-sm-6">
                                                    <select id="unloadingcharge-type" class="form-control">
                                                        <option value="DFT">Default Rate</option>
                                                        <option value="SLC">Same as Loading charges</option>
                                                        <option value="PFA">Percentage of Freight Amount</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-sm-3">
                                                    <input type="number" id="unloadingcharge-value" class="form-control no-spin" placeholder="Value" value="0">
                                                </div>
                                                <div class="form-group col-sm-3">
                                                    <select id="unloadingcharge-editable" class="form-control">
                                                        <option value="1">Editable</option>
                                                        <option value="0">Readonly</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <h4 class="heading_a">GST Model</h4>
                                                <select id="lrGstTaxModel" class="form-control">
                                                    <option value="RCMGST" {if $result->lrGstTaxModel == "RCMGST"}selected="selected"{/if}>RCMGST (Both sender and receiver)</option>
                                                    <option value="RCMEOGST" {if $result->lrGstTaxModel == "RCMEOGST"}selected="selected"{/if}>RCMGST (Either sender or receiver)</option>
                                                    <option value="RCMPYGST" {if $result->lrGstTaxModel == "RCMPYGST"}selected="selected"{/if}>RCMGST (Payment User Based)</option>
                                                    <option value="GST" {if $result->lrGstTaxModel == "GST"}selected="selected"{/if}>GST</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-2">
                                                <h4 class="heading_a">GST Compute Type</h4>
                                                <select id="lrGstTaxComputeType" class="form-control">
                                                    <option value="FRT" {if $result->lrGstTaxComputeType == "FRT"}selected="selected"{/if}>Freight Amount</option>
                                                    <option value="NET" {if $result->lrGstTaxComputeType == "NET"}selected="selected"{/if}>Net Amount</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-2">
                                            <h4 class="heading_a">GST Compute Model</h4>
                                            <select id="gstTaxComputeModel" class="form-control">
                                                <option value="EXGST" {if $result->gstTaxComputeModel == "EXGST"}selected="selected"{/if}>Exclusive GST</option>
                                                <option value="INGST" {if $result->gstTaxComputeModel == "INGST"}selected="selected"{/if}>Inclusive GST</option>
                                            </select>
                                        </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h4 class="heading_a">Connecting Charge</h4>
                                                <div class="form-group col-sm-7">
                                                    <input type="number" id="connectingChargeValue" class="form-control" value="{$result->connectingChargeValue}">
                                                </div>
                                                <div class="form-group col-sm-5">
                                                    <select id="connectingChargeType" class="form-control">
                                                        <option value="NA" {if $result->connectingChargeType == 'NA'}selected="selected"{/if}>Not Available</option>
                                                        <option value="FLT" {if $result->connectingChargeType == 'FLT'}selected="selected"{/if}>Flat</option>
                                                        <option value="QTY" {if $result->connectingChargeType == 'QTY'}selected="selected"{/if}>Quantity</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="showCustomerAddress" {if $result->showCustomerAddressFlag == 'true'}checked{/if}> Collect Customer Address
                                                </label>
                                            </div>
                                            
                                            <div class="col-sm-4 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="mandateAddressOnBooking" {if $result->mandateAddressOnBookingFlag == 'true'}checked{/if}> Mandate Customer Address, Pickup Charges & Delivery Charges
                                                </label>
                                            </div>

                                            <div class="col-sm-2">
                                                <h4 class="heading_a">Mobile Number Validation <a href="javascript:;" title="Remarks" data-toggle="popover" id="popup_msg" class="has-popover" data-content="Indian No: ^[6-9]\d&#123;9&#125;$ Or ^[06789]\d&#123;9&#125;$ <br>Repeated No: ^(?:(?!0000|1111|2222|3333|4444|5555|6666|7777|8888|9999).)*$ <br>Sequence No: ^(?:(?!12345|23456|34567|45678|56789|98765|87654|76543|654321).)*$"><i class="fa fa-info-circle" aria-hidden="true"></i></a> </h4>
                                                <input type="text" id="mobileNumberValidationRegex" class="form-control" value="{$result->mobileNumberValidationRegex|implode:','}">
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="organizationBookingControlFlag" {if $result->organizationBookingControlFlag == 'true'}checked{/if}> Branch Booking Control
                                                </label>
                                            </div>
                                            
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="loadingChargePerQuantity" {if $result->loadingChargePerQuantity == 'true'}checked{/if}> Calculate Loading Charge Per Quantity
                                                </label>
                                            </div>
                                            
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="bookingPreviewFlag" {if $result->bookingPreviewFlag == 'true'}checked{/if}> Show Preview Popup Before Create Booking
                                                </label>
                                            </div>

                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="mandateInvoiceAmountFlag" {if $result->mandateInvoiceAmountFlag == 'true'}checked{/if}> Mandatory to Collect Invoice Details
                                                </label>
                                            </div>
                                            <div class="col-sm-2 form-check-inline pb10">
                                                <br/>
                                                <label>
                                                    <input type="checkbox"  class="he_25 form-check-input" id="allowNewArticle" {if $result->allowNewArticle == 'true'}checked{/if}> Allow New Article
                                                </label>
                                            </div>

                                        </div>
                                        <div class="row">
                                            {if isNotNull($result->dayOfHour)}
                                                <div class="col-sm-3 form-check-inline pb10">
                                                    <br/>
                                                    <label title="{$result->dayOfHour}">
                                                        {assign var=dayofhourmin value=$result->dayOfHour|cat:' minutes'}
                                                        Day Of Hour - {strtotime($dayofhourmin, strtotime('today'))|date_format:$ns_time_format}
                                                    </label>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                    {* <br/> *}
                                    <hr>
                                    
                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>ACCOUNTS</b></h5>
                                    <div class="row">
                                        {* <h5 class="b_b_d">Accounts</h5> *}
                                        <div class="col-sm-2">
                                            <h4 class="heading_a">User Account Model</h4>
                                            <select class="he_25 form-control" name="userAccountModel" id="userAccountModel">
                                                <option value="VCHR" {if $result->userAccountModel->code == "VCHR"}selected="selected"{/if}>Voucher</option>
                                                <option value="RCPT" {if $result->userAccountModel->code == "RCPT"}selected="selected"{/if}>Individual GC</option>
                                                <option value="DINV" {if $result->userAccountModel->code == "DINV"}selected="selected"{/if}>Dedicated Invoice</option>
                                                <option value="BRN" {if $result->userAccountModel->code == "BRN"}selected="selected"{/if}>Branch</option>
                                                <option value="TXRT" {if $result->userAccountModel->code == "TXRT"}selected="selected"{/if}>Transaction Receipt</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">RAC Account Model</h4>
                                            <select class="he_25 form-control" name="racAccountModel" id="racAccountModel">
                                                <option value="INV" {if $result->racAccountModel->code == "INV"}selected="selected"{/if}>Invoice</option>
                                                <option value="GC" {if $result->racAccountModel->code == "GC"}selected="selected"{/if}>Individual GC</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Transaction User Based On</h4>
                                            <select class="he_25 form-control" name="transactionUserType" id="transactionUserType">
                                                <option value="1" {if $result->transactionUserType == "1"}selected="selected"{/if}>Delivery Branch Primary User</option>
                                                <option value="2" {if $result->transactionUserType == "2"}selected="selected"{/if}>Session User</option>                                                
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Paid Booking User Model</h4>
                                            <select class="he_25 form-control" name="paidBookingUserModel" id="paidBookingUserModel">
                                                <option value="BKUSR" {if $result->paidBookingUserModel->code == "BKUSR"}selected="selected"{/if}>Booked User</option>
                                                <option value="DLUSR" {if $result->paidBookingUserModel->code == "DLUSR"}selected="selected"{/if}>Delivery User</option>                                                
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-3 w-auto form-check-inline">
                                            <br/>
                                            <label>
                                                <input type="checkbox"  class="he_25 form-check-input" id="paymentReceiptAcknowledgeProcess" {if $result->paymentReceiptAcknowledgeProcess == 1}checked{/if}> Enable Payment Receipt Acknowledge Flow
                                            </label>
                                        </div>

                                        <div class="col-sm-3 w-auto form-check-inline">
                                            <br/>
                                            <label>
                                                <input type="checkbox"  class="he_25 form-check-input" id="creditLimitValidateFlag" {if $result->creditLimitValidateFlag == 'true'}checked{/if}> Credit Limit Validation On Booking
                                            </label>
                                        </div>

                                        <div class="col-sm-3 w-auto form-check-inline">
                                            <br/>
                                            <label>
                                                <input type="checkbox"  class="he_25 form-check-input" id="captureStateWiseCommissionFlag" {if $result->captureStateWiseCommissionFlag == 'true'}checked{/if}> Capture State Wise Commission
                                            </label>
                                        </div>

                                        <div class="col-sm-3 w-auto form-check-inline">
                                            <br/>
                                            <label>
                                                <input type="checkbox"  class="he_25 form-check-input" id="stateWiseEwayBillIntegrationFlag" {if $result->stateWiseEwayBillIntegrationFlag == 'true'}checked{/if}> State Wise Eway Bill Integration
                                            </label>
                                        </div>
                                        
                                            <div class="col-sm-3 w-auto form-check-inline">
                                                <br/>
                                                <label class="d-inline">Ledger -</label> <span class="d-inline">{if $result->allowLedger}Enabled{else}disabled {/if}</span>
                                            </div>
                                        
                                        
                                    </div>
                                    <br/>
                                    <div class="row">                                    
                                        <div class="col-sm-12">
                                            <table id="account-model-setup-table" class="table table-hover" width="100%">
                                                <thead>
                                                    <tr>
                                                        <td style="display: flex;justify-content: space-between;align-items: end;">
                                                            <span class="heading_a">Accounts Setup</span>
                                                            <a href="javascript:;" class="btn btn-sm btn-primary pull-right" onclick="addAccountModel()"> <i class="fa fa-plus"></i> Add Other Account Models</a>
                                                        </td>
                                                    </tr>
                                                </thead>
                                                <tbody id="account-model-rows">
                                                    {if $paymentModel|count == 0}
                                                        <tr class="account-model-row">
                                                            <td>
                                                                <table class="account-model-list" width="100%">
                                                                    <tr class="account-model-edit">
                                                                        <td colspan="4">
                                                                            <div class="row">
                                                                                <div class="col-sm-3">
                                                                                    {* <div class="form-group"> *}
                                                                                        <label for="account-model-group" class="req">Group</label>
                                                                                        <select class="form-control account-model-group" >
                                                                                            <option value='NA'>Default</option>
                                                                                            {foreach item=row from=$groups}
                                                                                                <option value="{$row->code}">{$row->name}</option>
                                                                                            {/foreach}
                                                                                        </select>
                                                                                    {* </div> *}
                                                                                </div>
                                                                                <div class="col-sm-9">
                                                                                    <label>&nbsp;</label>
                                                                                    <a href="javascript:;" class="btn btn-sm btn-danger pull-right" onclick="removeAccountModel(this)"> <i class="fa fa-times"></i> Remove</a>
                                                                                </div>
                                                                            </div>
                                                                            <br>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="account-model-edit">
                                                                        <!-- ON BOOKING -->
                                                                        <td width="25%">
                                                                            <table class="table table-bordered">
                                                                                <thead class="bold">
                                                                                    <tr>
                                                                                        <td>Events</td>
                                                                                        <td colspan="3" align="center">On Booking</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Booking Type</td>
                                                                                        <td>Branch / Vendor Due</td>
                                                                                        <td>Booking Commission</td>
                                                                                        <td>Delivery Commission</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>Paid</td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>ToPay</td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td nowrap>On Account</td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>

                                                                        <!-- ON LOAD TABLE -->
                                                                        <td width="25%">
                                                                            <table class="table table-bordered">
                                                                                <thead class="bold">
                                                                                    <tr>
                                                                                        <td colspan="3" align="center">On Load</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Branch / Vendor Due</td>
                                                                                        <td>Booking Commission</td>
                                                                                        <td>Delivery Commission</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                                <tfoot></tfoot>
                                                                            </table>
                                                                        </td>

                                                                        <!-- ON UN LOAD TABLE -->
                                                                        <td width="25%">
                                                                            <table class="table table-bordered">
                                                                                <thead class="bold">
                                                                                    <tr>
                                                                                        <td colspan="3" align="center">On Unloading</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Branch / Vendor Due</td>
                                                                                        <td>Booking Commission</td>
                                                                                        <td>Delivery Commission</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                                <tfoot></tfoot>
                                                                            </table>
                                                                        </td>

                                                                        <!-- ON DELIVEY TABLE -->
                                                                        <td width="25%">
                                                                            <table class="table table-bordered">
                                                                                <thead class="bold">
                                                                                    <tr>
                                                                                        <td colspan="3" align="center">On Delivery</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Branch / Vendor Due</td>
                                                                                        <td>Booking Commission</td>
                                                                                        <td>Delivery Commission</td>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" ame="pd_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch paid" name="pd_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch topay" name="tp_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_book_comm1" value="1">
                                                                                        </td>
                                                                                        <td>
                                                                                            <input type="radio" class="bsn_switch onaccount" name="oa_del_comm1" value="1">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                                <tfoot></tfoot>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    {/if}

                                                    {foreach from=$paymentModel item=payment_model key=key}
                                                        <tr class="account-model-row">
                                                            <td>
                                                                <table class="account-model-list" width="100%">
                                                                    <tbody>
                                                                        {if $payment_model->paidModel==""}
                                                                            {assign var=paid value='000000000000'}
                                                                        {else}
                                                                            {assign var=paid value=$payment_model->paidModel}
                                                                        {/if}
                                                                        {if $payment_model->toPayModel==""}
                                                                            {assign var=topay value='000000000000'}
                                                                        {else}
                                                                            {assign var=topay value=$payment_model->toPayModel}
                                                                        {/if}
                                                                        {if $payment_model->onAccountModel==""}
                                                                            {assign var=onaccount value='000000000000'}
                                                                        {else}
                                                                            {assign var=onaccount value=$payment_model->onAccountModel}
                                                                        {/if}
                                                                        <!-- View -->
                                                                        <tr class="account-model-view account-model-view-list point_cur" onclick="viewAccountModel(this);">
                                                                            <td colspan="3" class="bold">
                                                                                {if isNotNull($payment_model->group->code)}
                                                                                    {$payment_model->group->name}
                                                                                {else}
                                                                                    Default
                                                                                {/if}
                                                                            </td>
                                                                            <td>
                                                                                {if $payment_model->group->code != 'NA'}
                                                                                    <a href="javascript:;" class="btn btn-sm btn-danger pull-right" onclick="deleteAccountModel('{$payment_model->group->code}')"> <i class="fa fa-times"></i> Delete</a>
                                                                                {/if}
                                                                                <a href="javascript:;" class="btn btn-sm btn-light pull-right" onclick="editAccountModel(this)"> <i class="fa fa-pencil"></i> Edit</a>
                                                                                <br><br>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="account-model-view hide">
                                                                            <!-- ON BOOKING -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td>Events</td>
                                                                                            <td colspan="3" align="center">On Booking</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Booking Type</td>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>Paid</td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:0:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:1:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:2:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>ToPay</td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:0:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:1:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:2:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td nowrap>On Account</td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:0:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:1:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:2:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON LOAD TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Load</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:3:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:4:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:5:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:3:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:4:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:5:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:3:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:4:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:5:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON UN LOAD TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Unloading</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:6:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:7:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:8:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:6:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:7:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:8:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:6:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:7:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:8:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON DELIVEY TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Delivery</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:9:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:10:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $paid|substr:11:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:9:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:10:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $topay|substr:11:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:9:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:10:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                            <td align="center">
                                                                                                {if $onaccount|substr:11:1==1}<span class="badge badge-success">ON</span>{else}<span class="badge badge-danger">OFF</span>{/if}
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>
                                                                        </tr>

                                                                        <!-- Edit -->
                                                                        <tr class="account-model-edit hide">
                                                                            <td colspan="4">
                                                                                <div class="row">
                                                                                    <div class="col-sm-3">
                                                                                        {* <div class="form-group"> *}
                                                                                            <label for="account-model-group" class="req">Group</label>
                                                                                            <select class="form-control account-model-group"  id="account-model-group-id" data-group="{$payment_model->group->code}">
                                                                                                <option value='NA'>Default</option>
                                                                                                {foreach item=row from=$groups}
                                                                                                    <option value="{$row->code}" {if $payment_model->group->code == $row->code}selected{/if}>{$row->name}</option>
                                                                                                {/foreach}
                                                                                            </select>
                                                                                        {* </div> *}
                                                                                    </div>
                                                                                    <div class="col-sm-9">
                                                                                        <label>&nbsp;</label>
                                                                                        <a href="javascript:;" class="btn btn-sm btn-light pull-right" onclick="closeEditAccountModel(this)"> <i class="fa fa-times"></i> Close</a>
                                                                                    </div>
                                                                                </div>
                                                                                <br>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="account-model-edit hide">
                                                                            <!-- ON BOOKING -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td>Events</td>
                                                                                            <td colspan="3" align="center">On Booking</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Booking Type</td>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>Paid</td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:0:1==1}checked="checked"{/if} name="pd_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:1:1==1}checked="checked"{/if} name="pd_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:2:1==1}checked="checked"{/if}  name="pd_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>ToPay</td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:0:1==1}checked="checked"{/if} name="tp_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:1:1==1}checked="checked"{/if} name="tp_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:2:1==1}checked="checked"{/if}  name="tp_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td nowrap>On Account</td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:0:1==1}checked="checked"{/if} name="oa_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:1:1==1}checked="checked"{/if} name="oa_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:2:1==1}checked="checked"{/if}  name="oa_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                    <tfoot></tfoot>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON LOAD TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Load</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:3:1==1}checked="checked"{/if} name="pd_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:4:1==1}checked="checked"{/if} name="pd_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:5:1==1}checked="checked"{/if}  name="pd_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:3:1==1}checked="checked"{/if} name="tp_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:4:1==1}checked="checked"{/if} name="tp_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:5:1==1}checked="checked"{/if}  name="tp_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:3:1==1}checked="checked"{/if} name="oa_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:4:1==1}checked="checked"{/if} name="oa_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:5:1==1}checked="checked"{/if}  name="oa_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                    <tfoot></tfoot>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON UN LOAD TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Unloading</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:6:1==1}checked="checked"{/if} name="pd_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:7:1==1}checked="checked"{/if} name="pd_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:8:1==1}checked="checked"{/if}  name="pd_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:6:1==1}checked="checked"{/if} name="tp_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:7:1==1}checked="checked"{/if} name="tp_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:8:1==1}checked="checked"{/if}  name="tp_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:6:1==1}checked="checked"{/if} name="oa_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:7:1==1}checked="checked"{/if} name="oa_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:8:1==1}checked="checked"{/if}  name="oa_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                    <tfoot></tfoot>
                                                                                </table>
                                                                            </td>

                                                                            <!-- ON DELIVEY TABLE -->
                                                                            <td width="25%">
                                                                                <table class="table table-bordered">
                                                                                    <thead class="bold">
                                                                                        <tr>
                                                                                            <td colspan="3" align="center">On Delivery</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Branch / Vendor Due</td>
                                                                                            <td>Booking Commission</td>
                                                                                            <td>Delivery Commission</td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:9:1==1}checked="checked"{/if} name="pd_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:10:1==1}checked="checked"{/if} name="pd_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch paid" {if $paid|substr:11:1==1}checked="checked"{/if}  name="pd_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:9:1==1}checked="checked"{/if} name="tp_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:10:1==1}checked="checked"{/if} name="tp_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch topay" {if $topay|substr:11:1==1}checked="checked"{/if}  name="tp_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:9:1==1}checked="checked"{/if} name="oa_branch_vendor_due{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:10:1==1}checked="checked"{/if} name="oa_book_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="radio" class="bsn_switch onaccount" {if $onaccount|substr:11:1==1}checked="checked"{/if}  name="oa_del_comm{$key+1}" value="1">
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                    <tfoot></tfoot>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    {/foreach}
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td>
                                                            <div class="align-center alert alert-danger" style="display:none" id="account-madel-action-state"></div>
                                                            <a href="javascript:;" class="btn btn-sm btn-success pull-right" id="account-model-save-btn" onclick="saveAccountModel()"> Save</a>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                    </div>
                                    <hr>

                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>DELIVERY</b></h5>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Account Type</h4>
                                            <select class="he_25 form-control" name="userAccountableType" id="userAccountableType">
                                                {foreach from=$user_accountable_type item=row key=key}
                                                    <option value="{$key}" {if $result->userAccountableType->code == $key}selected="selected"{/if}>{$row}</option>
                                                {/foreach}
                                            </select>
                                        </div>

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Delivery Model</h4>
                                            <select class="he_25 form-control" name="deliveryModel" id="deliveryModel">
                                                <option value="BOOKING" {if $result->deliveryModel->code == "BOOKING"}selected="selected"{/if}>After Booking</option>
                                                <option value="LOAD" {if $result->deliveryModel->code == "LOAD"}selected="selected"{/if}>After Load</option>
                                                <option value="UNLOAD" {if $result->deliveryModel->code == "UNLOAD"}selected="selected"{/if}>After Unload</option>
                                                <option value="AFOFD" {if $result->deliveryModel->code == "AFOFD"}selected="selected"{/if}>After Out For Delivery</option>
                                            </select>
                                        </div>
                                            
                                        

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Default Delivery Charges</h4>
                                            <input type="text" style="width:60px" value='{$result->defaultDeliveryCharge}' class="he_25 form-control" id="defaultDeliveryCharge">
                                        </div>

                                        <div class="col-sm-12 form-check-inline">
                                            <br/>
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="otpValidateDeliveryFlag" {if $result->otpValidateDeliveryFlag == 1}checked{/if}> Mandate OTP while delivery
                                            </label>&emsp;
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="otpOverrideDeliveryFlag" {if $result->otpOverrideDeliveryFlag == 1}checked{/if}> Override OTP while delivery
                                            </label>&emsp;
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="podValidateDeliveryFlag" {if $result->podValidateDeliveryFlag == 1}checked{/if}> Mandate POD while delivery
                                            </label>
                                        </div>
                                    </div>
                                    </div>
                                    <hr>

                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>TRANSIT</b></h5>
                                    <div class="row">

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Transit Model</h4>
                                            <select class="he_25 form-control" name="ogplModelCode" id="ogplModelCode">
                                                <option value="DFLT" {if $result->ogplModelCode == "DFLT"}selected="selected"{/if}>Default</option>
                                                <option value="VER2" {if $result->ogplModelCode == "VER2"}selected="selected"{/if}>Version 2.0</option>
												<option value="VER3" {if $result->ogplModelCode == "VER3"}selected="selected"{/if}>Version 3.0</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-2">
                                            <h4 class="heading_a">Transit Location Mode</h4>
                                            <select class="he_25 form-control" name="transitLocationModelCode" id="transitLocationModelCode">
                                                <option value="STN" {if $result->transitLocationModelCode == "STN"}selected="selected"{/if}>Station</option>
                                                <option value="BRCH" {if $result->transitLocationModelCode == "BRCH"}selected="selected"{/if}>Branch</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-5">
                                            <h4 class="heading_a">Transit Mode</h4>
                                            {if $result->transitMode == ""}
                                                {assign var=day value='00000'}
                                            {else}
                                                {assign var=day value=$result->transitMode}
                                            {/if}
                                            <div class="btn-group btn-group-days transitMode" data-toggle="buttons">
                                                <label class="btn btn-success btn-xs chk-btn {if $day|substr:0:1==1}active{/if}" title="Available Vehicle">
                                                    <input type="checkbox" {if $day|substr:0:1==1}checked="checked"{/if} name="transit_mode_tag" value="1">Available Vehicle
                                                </label>
                                                <label class="btn btn-success btn-xs chk-btn {if $day|substr:1:1==1}active{/if}" title="Direct Load">
                                                    <input type="checkbox" {if $day|substr:1:1==1}checked="checked"{/if} name="transit_mode_tag" value="1">Direct Load
                                                </label>
                                                <label class="btn btn-success btn-xs chk-btn {if $day|substr:2:1==1}active{/if}" title="Link Load">
                                                    <input type="checkbox" {if $day|substr:2:1==1}checked="checked"{/if} name="transit_mode_tag" value="1">Link Load
                                                </label>
                                                <label class="btn btn-success btn-xs chk-btn {if $day|substr:3:1==1}active{/if}" title="Local Load">
                                                    <input type="checkbox" {if $day|substr:3:1==1}checked="checked"{/if} name="transit_mode_tag" value="1">Local Load
                                                </label>
                                                <label class="btn btn-success btn-xs chk-btn {if $day|substr:4:1==1}active{/if}" title="Out For Delivery">
                                                    <input type="checkbox" {if $day|substr:4:1==1}checked="checked"{/if} name="transit_mode_tag" value="1">Out For Delivery
                                                </label>
                                            </div>
                                        </div>

                                        {* <div class="col-sm-3 form-check-inline"><br>
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="mandateRouteWiseUnloadFlag" {if $result->mandateRouteWiseUnloadFlag == 1}checked{/if}> Mandate Routewise Unload
                                            </label>&emsp;
                                        </div> *}
                                        <div class="col-sm-1 form-check-inline"><br>
                                            <label class="d-inline">
                                                <input type="checkbox"  class="he_25 form-check-input" id="cargoPartitionFlag" {if $result->cargoPartitionFlag == 1}checked{/if}> Split LR
                                            </label>&emsp;
                                        </div>
                                        {* {$result->transitOdometerModelCode='RTEBSD'} *}
                                    <div class="col-sm-3 form-check-inline"><br>
                                        <label class="d-inline">Transit Odometer Model:</label>&emsp;
                                            <select class="form-control" id="transitOdometerModelCode">
                                            <option value="NA" {if $result->transitOdometerModelCode==='NA'}selected{/if}>Not Available</option>
                                            <option value="RTEBSD" {if $result->transitOdometerModelCode==='RTEBSD'}selected{/if}>Route Based Odometer / Unload</option>
                                            <option value="ORGDTN" {if $result->transitOdometerModelCode==='ORGDTN'}selected{/if}>Origin - Destn. Odometer</option>
                                            </select>
                                      </div>
                                    </div>
                                    </div>
                                    <hr>
                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>DEMURRAGE</b></h5>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <table class="table m-0">
                                                <thead>
                                                    <tr>
                                                        <th>Demurrage Days</th>
                                                        <th>Demurrage Charges</th>
                                                        <th>Demurrage Process</th>
                                                        <th>Calculate Based On</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody id="demurrage-terms-list">
                                                </tbody>
                                            </table>
                                            &ensp;<button class="btn btn-xs btn-primary m-t-5" onclick="addDemurrageTermRow()"><i class="fa fa-plus"></i> Add</button>
                                        </div>
                                        <div class="clearfix"></div><br>
                                    </div>
                                    </div>
                                    <hr>
                                    {* Sequence Patterns *}
                                    <div class="well radius-8">
                                    <h5 class="b_b_d"><b>SEQUENCE PATTERNS</b></h5>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <details>
                                                <summary class="point_cur" style="display: list-item;"><b>Example</b></summary>
                                                <p>
                                                    {literal}
                                                        <div class="example-section">
                                                            {fromOrg}-{toOrg}-{PayType:1|2|3|4}-{DATE1:YYYY-MMM-DD}--{DATE2:WWWW}-{SEQ:fromOrg-toOrg#4}<br/>
                                                            {fromOrg}-{toOrg}-{PayType:P|TP|C|F}-{DATE1:YY}-{SEQ:fromStation-toOrg} --ERROR}<br/>
                                                            {fromOrg}-{PayType:P|TP|C|F}-{SEQ:fromOrg-toOrg#4}}<br/>
                                                            {fromOrg}{SEQ:fromStation#4} ---> ABC0012}<br/>
                                                            REC{SEQ:fromStation-toStation#4}---> REC0012<br/>
                                                            {DATE1:YY}{PayType:P|TP|C|F}{SEQ:fromOrg-toOrg}<br/>
                                                            RAC{PayType:1|2|3|4}-{SEQ:fromStation-toStation}<br/>
                                                            {fromOrg}{toOrg}{SEQ:fromStation-toStation}<br/>
                                                            {fromOrg}-{toOrg}-{PayType:P|TP|C|F}-{DATE1:YY}-{SEQ:fromStation-toStation}<br/>
                                                            {shortCode}{fromOrg}{SEQ:fromOrg#4} ---> ABCMHR0213<br/>
                                                            {shortCode}{SEQ:namespace#4} ---> ABC0213<br/>
                                                            {shortCode}{vendorShortCode}{SEQ:vendor#3}<br/>
                                                            {manualCargoCode}<br/>
                                                            {sessionOrg}{SEQ:organization#3}<br/>
                                                            <br/>
                                                            <b>Cheque :</b><br/>
                                                            {shortCode}{SEQ:namespace#4}<br/>
                                                            {chequeOrg}{SEQ:namespace#3}<br/>
                                                            {chequeStn}{SEQ:namespace#3}<br/>
                                                            <br/>
                                                            <b>Delivery Acknowledgement :</b><br/>
                                                            {fromOrg}{toOrg}{SEQ:fromOrg#3}<br/>
                                                            {fromStation}{toStation}{SEQ:fromStation#4}<br/>
                                                            {shortCode}{SEQ:namespace#4}<br/>
                                                            <br/>
                                                            <b>Vendor Alias :</b><br/>
                                                            {categoryCode}{vendorOrg}{SEQ:namespace#0}<br/>
                                                        </div>
                                                    {/literal}
                                                </p>
                                            </details>
                                            <br>
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">{lang('lr')} Number</h4>
                                            <input type="text" value='{$result->cargoCodeTemplate}' class="he_25 form-control" id="cargoCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Manual {lang('lr')} Number</h4>
                                            <input type="text" value='{$result->manualCargoCodeTemplate}' class="he_25 form-control" id="manualCargoCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Vendor LR Number</h4>
                                            <input type="text" value='{$result->vendorCargoCodeTemplate}' class="he_25 form-control" id="vendorCargoCodeTemplate">
                                        </div>
                                        
                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Vendor Invoice Number</h4>
                                            <input type="text" value='{$result->invoiceCodeTemplate}' class="he_25 form-control" id="invoiceCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">{lang('ogpl')}</h4>
                                            <input type="text" value='{$result->ogclCodeTemplate}' class="he_25 form-control" id="ogclCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">{lang('ogpl_local_transit')}</h4>
                                            <input type="text" value='{$result->itclCodeTemplate}' class="he_25 form-control" id="itclCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">OFDY</h4>
                                            <input type="text" value='{$result->ofdyCodeTemplate}' class="he_25 form-control" id="ofdyCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Transaction Receipt</h4>
                                            <input type="text" value='{$result->transactionReceiptTemplate}' class="he_25 form-control" id="transactionReceiptTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Cheque</h4>
                                            <input type="text" value='{$result->chequeCodeTemplate}' class="he_25 form-control" id="chequeCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Delivery Acknowledgement</h4>
                                            <input type="text" value='{$result->deliveryAckCodeTemplate}' class="he_25 form-control" id="deliveryAckCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Full Truck Load</h4>
                                            <input type="text" value='{$result->ftlCodeTemplate}' class="he_25 form-control" id="ftlCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Partial Truck Load</h4>
                                            <input type="text" value='{$result->ptlCodeTemplate}' class="he_25 form-control" id="ptlCodeTemplate">
                                        </div>

                                        <div class="col-sm-6">
                                            <h4 class="heading_a">Vendor Alias</h4>
                                            <input type="text" value='{$result->vendorAliasCodeTemplate}' class="he_25 form-control" id="vendorAliasCodeTemplate">
                                        </div>

                                    </div>
                                    </div>
                                    <br><br>
                                    <div class="row radius-8">
                                        <div id="ur-org-loading"></div>
                                        <div class="col-md-6">
                                            <div class="align-center alert alert-danger" style="display:none" id="usr-org-state"></div>
                                        </div>
                                    
                                        {if $action_rights['EDIT-CGO-SETTINGS'] == 1}
                                            <div class="col-md-12 btn-align" style="display:flex;justify-content:flex-end" id="form-org-bttons">
                                                <button type="button" id="btn-save" class="btn btn-success" onclick="saveCargoSettings()">Save</button>
                                            </div>
                                        {/if}

                                    </div>
                                    </div>
                                    
                                </form>
                            </div>
                        </div><!--panel Body end-->
                    </div><!--panel end-->
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="demurrage-terms-tpl">
    <tr class="border-0 demurrage-term-row">
        <td width="25%">
            <input type="number" class=" form-control no-spin demurrage-days" placeholder="Days" min="0">
        </td>
        <td width="40%">
            <div class="d-flex">
                <div class="input-group">
                    <span class="input-group-addon "><i class="fa fa-inr"></i></span>
                    <input type="number" class="form-control no-spin demurrage-charge" placeholder="Charges">
                </div>
                <select class="form-control demurrage-chargetype w-auto">
                    <option value="FLT">Flat</option>
                    <option value="PER">Percentage</option>
                    <option value="FLTPD">Flat Per Day</option>
                    <option value="PERPD">Percentage Per Day</option>
                </select>
            </div>
        </td>
        <td>
            <select class="form-control demurrage-process">
                <option value="ARTCL">Article</option>
                <option value="FRGT">Freight</option>
                <option value="NETAM">Net Amount</option>
            </select>
        </td>
        <td>
            <select class="form-control demurrage-date-type">
                <option value="2">Unloaded Date</option>
                <option value="1">Booked Date</option>
                <option value="3">Demurrage Date</option>
            </select>
        </td>
        <td>
            <button class="btn btn-xs" onclick="removeDemurrageTermRow(this)"><i class="fa fa-times"></i></button>
        </td>
    </tr>
</script>

<script type="text/html" id="add-account-model-tpl">
    <tr class="account-model-row">
        <td>
            <table class="account-model-list" width="100%">
                <tr class="account-model-edit">
                    <td colspan="4">
                        <div class="row">
                            <div class="col-sm-3">
                                {* <div class="form-group"> *}
                                    <label for="account-model-group" class="req">Group</label>
                                    <select class="form-control account-model-group">
                                        <option value='NA' disabled>Default</option>
                                        {foreach item=row from=$groups}
                                            <option value="{$row->code}">{$row->name}</option>
                                        {/foreach}
                                    </select>
                                    <br>
                                {* </div> *}
                            </div>
                            <div class="col-sm-9">
                                <label>&nbsp;</label>
                                <a href="javascript:;" class="btn btn-sm btn-danger pull-right" onclick="removeAccountModel(this)"> <i class="fa fa-times"></i> Remove</a>
                            </div>
                        </div>
                        <br>
                    </td>
                </tr>
                <tr class="account-model-edit">
                    <!-- ON BOOKING -->
                    <td width="25%">
                        <table class="table table-bordered">
                            <thead class="bold">
                                <tr>
                                    <td>Events</td>
                                    <td colspan="3" align="center">On Booking</td>
                                </tr>
                                <tr>
                                    <td>Booking Type</td>
                                    <td>Branch / Vendor Due</td>
                                    <td>Booking Commission</td>
                                    <td>Delivery Commission</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Paid</td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>ToPay</td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap>On Account</td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_del_comm" value="1">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>

                    <!-- ON LOAD TABLE -->
                    <td width="25%">
                        <table class="table table-bordered">
                            <thead class="bold">
                                <tr>
                                    <td colspan="3" align="center">On Load</td>
                                </tr>
                                <tr>
                                    <td>Branch / Vendor Due</td>
                                    <td>Booking Commission</td>
                                    <td>Delivery Commission</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_del_comm" value="1">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>

                    <!-- ON UN LOAD TABLE -->
                    <td width="25%">
                        <table class="table table-bordered">
                            <thead class="bold">
                                <tr>
                                    <td colspan="3" align="center">On Unloading</td>
                                </tr>
                                <tr>
                                    <td>Branch / Vendor Due</td>
                                    <td>Booking Commission</td>
                                    <td>Delivery Commission</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_del_comm" value="1">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>

                    <!-- ON DELIVEY TABLE -->
                    <td width="25%">
                        <table class="table table-bordered">
                            <thead class="bold">
                                <tr>
                                    <td colspan="3" align="center">On Delivery</td>
                                </tr>
                                <tr>
                                    <td>Branch / Vendor Due</td>
                                    <td>Booking Commission</td>
                                    <td>Delivery Commission</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" ame="pd_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch paid" name="pd_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch topay" name="tp_del_comm" value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_branch_vendor_due" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_book_comm" value="1">
                                    </td>
                                    <td>
                                        <input type="radio" class="bsn_switch onaccount" name="oa_del_comm" value="1">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</script>

<script>
    var cargoSettingData = {$result|json_encode};
    var paymentModelData = {$paymentModel|json_encode};
    var paymentModelGroups = {$paymentModelGroups|json_encode} || [];

    $(document).ready(function () {
        $('.bsn_switch').bootstrapSwitch('size', 'mini');
        $('.account-model-group').select2();
        $('#cargoUnitModel').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '200px',
            dropLeft: true,
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            includeSelectAllOption: true,
            selectAllText: 'Select All',
            buttonClass: 'btn btn-default cargoUnitModel',
            templates: {
                ul: '<ul class="multiselect-container dropdown-menu" style="max-height: 200px; min-width: 100%; overflow: hidden auto;"></ul>',
            }
        });

        $('#edit-booking-days-limit').on('change', function() {
            let value = parseInt($(this).val());
            let min = parseInt($(this).attr('min'));
            let max = parseInt($(this).attr('max'));
            
            $(this).val(value);
            if (value < min) $(this).val(min);
            if (value > max) $(this).val(max);
        });

        if(menu_permission['EDIT-CGO-SETTINGS'] != 1) {
            $('#account_setting :input').attr('disabled', true);
        }

        $('#unloadingcharge-type').on('change', function () {
            if (this.value == 'SLC') {
                $('#unloadingcharge-value').prop('disabled', true).val('');
                return;
            }
            $('#unloadingcharge-value').prop('disabled', false);
        }).trigger('change');

        if (isNotNull(cargoSettingData) && isNotNull(cargoSettingData.unloadingChargeConfig)) {
            var unloadingChargeConfig = JSON.parse(cargoSettingData.unloadingChargeConfig);

            $.each(unloadingChargeConfig || {}, function (key, val) {
                $('#unloadingcharge-type').val(key);
                $('#unloadingcharge-editable').val(val.editable);
                $('#unloadingcharge-value').val(val.value);

                return false;
            });
        }

        $('#userAccountModel').on('change', function () {
            $('#racAccountModel [value="GC"]').prop('disabled', this.value == 'DINV');
        }).trigger('change');

        
        if (isNotNull(cargoSettingData) && isNotNull(cargoSettingData.demurrageTerms)) {
            $.each(cargoSettingData.demurrageTerms || [], function (i, term) {
                var $row = addDemurrageTermRow();

                $row.find('.demurrage-date-type').val(term.computeDateType);
                $row.find('.demurrage-process').val(term.demurrageProcess.code);
                $row.find('.demurrage-chargetype').val(term.demurrageChargeType);
                $row.find('.demurrage-charge').val(term.demurrageCharge);
                $row.find('.demurrage-days').val(term.demurrageDays);
            });
        }

        if (isNotNull(cargoSettingData) && Array.isArray(cargoSettingData.cargoUnitModel)) {
            $('#cargoUnitModel').val(cargoSettingData.cargoUnitModel).multiselect('refresh');
        }

        if (!$('#demurrage-terms-list .demurrage-term-row').length) {
            addDemurrageTermRow();
        }

		
		$('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');
		$('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'click');
		$('[data-toggle=popover]').popover({
			container: "body",
			html: true
		});

        $('#connectingChargeType').on('change', function () {
            if (this.value == 'NA') {
                $('#connectingChargeValue').prop('disabled', true).val('');
                return;
            }
            $('#connectingChargeValue').prop('disabled', false);
        }).trigger('change');
        // $('#account-model-group').select2();
    });
    
    function saveCargoSettings() {
        var err = 0;
        var data = {};
        data.activeFlag = 1;
        data.serviceTaxPercentage = $('#serviceTaxPercentage').val();
        data.billableKg = $('#billableKg').val();
        data.minServiceTax = $('#minServiceTax').val();
        data.defaultLoadigCharge = $('#defaultLoadigCharge').val();
        data.loadingChargePercentageFlag = $('#loadingChargePercentageFlag').val();
        data.loadingChargeEditFlag = $('#loadingChargeEditFlag').val();
        data.defaultDocketCharge = $('#defaultDocketCharge').val();
        data.docketChargePercentageFlag = $('#docketChargePercentageFlag').val();
        data.docketChargeEditFlag = $('#docketChargeEditFlag').val();
        data.loadingChargePerQuantity = $('#loadingChargePerQuantity').is(':checked');
        data.userAccountableType = $('#userAccountableType').val();
        data.paymentReceiptAcknowledgeProcess = +$('#paymentReceiptAcknowledgeProcess').is(':checked');
        data.showCustomerAddressFlag = $('#showCustomerAddress').is(':checked');
        data.mandateAddressOnBookingFlag = $('#mandateAddressOnBooking').is(':checked');
        data.bookingPreviewFlag = $('#bookingPreviewFlag').is(':checked');
        data.otpValidateDeliveryFlag = $('#otpValidateDeliveryFlag').is(':checked');
        data.otpOverrideDeliveryFlag = $('#otpOverrideDeliveryFlag').is(':checked');
        data.podValidateDeliveryFlag = $('#podValidateDeliveryFlag').is(':checked');
        data.defaultDeliveryCharge = $('#defaultDeliveryCharge').val();
        data.mandateInvoiceAmountFlag = $('#mandateInvoiceAmountFlag').is(':checked');
        data.allowNewArticle = $('#allowNewArticle').is(':checked');
        data.organizationBookingControlFlag = $('#organizationBookingControlFlag').is(':checked');
        data.ogplModelCode = $('#ogplModelCode').val();
        data.transitLocationModelCode = $('#transitLocationModelCode').val();
        // data.mandateRouteWiseUnloadFlag = $('#mandateRouteWiseUnloadFlag').is(':checked');
        data.transitOdometerModelCode = $('#transitOdometerModelCode').val();
        data.cargoPartitionFlag = $('#cargoPartitionFlag').is(':checked');
        data.cargoCodeTemplate = $('#cargoCodeTemplate').val();
        data.vendorCargoCodeTemplate = $('#vendorCargoCodeTemplate').val();
        data.invoiceCodeTemplate = $('#invoiceCodeTemplate').val();
        data.manualCargoCodeTemplate = $('#manualCargoCodeTemplate').val();
        data.ogclCodeTemplate = $('#ogclCodeTemplate').val();
        data.itclCodeTemplate = $('#itclCodeTemplate').val();
        data.ofdyCodeTemplate = $('#ofdyCodeTemplate').val();
        data.transactionReceiptTemplate = $('#transactionReceiptTemplate').val();
        data.chequeCodeTemplate = $('#chequeCodeTemplate').val();
        data.deliveryAckCodeTemplate = $('#deliveryAckCodeTemplate').val();
        data.ftlCodeTemplate = $('#ftlCodeTemplate').val();
        data.ptlCodeTemplate = $('#ptlCodeTemplate').val();
        data.vendorAliasCodeTemplate = $('#vendorAliasCodeTemplate').val();
        data.transactionUserType = $('#transactionUserType').val();
        data.podCharge = $('#podCharge').val();
        data.mobileNumberValidationRegex = $('#mobileNumberValidationRegex').val().split(',');
        data.deliveryModel = {};
        data.deliveryModel.code = $('#deliveryModel').val();
        data.paidBookingUserModel = {};
        data.paidBookingUserModel.code = $('#paidBookingUserModel').val();
        data.creditLimitValidateFlag = $('#creditLimitValidateFlag').is(':checked');
        data.captureStateWiseCommissionFlag = $('#captureStateWiseCommissionFlag').is(':checked');
        data.stateWiseEwayBillIntegrationFlag = $('#stateWiseEwayBillIntegrationFlag').is(':checked');
        data.minFreightAmount = $('#minFreightAmount').val();

        data.bookingDateEditDaysLimit = Number($('#edit-booking-days-limit').val());
        var bookingDateEditMin = Number($('#edit-booking-days-limit').attr('min'));
        var bookingDateEditMax = Number($('#edit-booking-days-limit').attr('max'));
        if (data.bookingDateEditDaysLimit < bookingDateEditMin || data.bookingDateEditDaysLimit > bookingDateEditMax) {
            $('#edit-booking-days-limit').addClass('inp_error');
            $('#usr-org-state').removeClass('alert-success hide').addClass('alert-danger').show();
            $('#usr-org-state').html('Edit Booking Days Limit should be between 0 1nd 10 only');
            return;
        }

        data.demurrageTerms = [];
        $('#demurrage-terms-list .demurrage-term-row').each(function(i, row) {
            var $row = $(row);
        
            var term = {};
            term.demurrageProcess = {};
            term.demurrageProcess.code = $row.find('.demurrage-process').val();
            term.demurrageChargeType = $row.find('.demurrage-chargetype').val();
            term.demurrageCharge = Number($row.find('.demurrage-charge').val()) || 0;
            term.demurrageDays = Number($row.find('.demurrage-days').val()) || 0;
            term.computeDateType = $row.find('.demurrage-date-type').val();

            if (!term.demurrageCharge && !term.demurrageDays) {
                return;
            }

            if (term.demurrageCharge <= 0) {
                $row.find('.demurrage-charge').addClass('inp_error');
                err++;
            } 
            if (term.demurrageDays <= 0) {
                $row.find('.demurrage-days').addClass('inp_error');
                err++;
            }

            if (term.demurrageCharge && term.demurrageDays) {
                data.demurrageTerms.push(term);
            }
        });

        data.totalFreightRoundOffValue = $('#rndOffreightAmt').val();
        data.loadingChargeRoundOffValue = $('#rndOffLoadingCharge').val();
        data.deliveryRoundOffValue = $('#deliveryRoundOffValue').val();

        data.lrGstTaxModel = $('#lrGstTaxModel').val();
        data.lrGstTaxComputeType = $('#lrGstTaxComputeType').val();
        data.gstTaxComputeModel = $('#gstTaxComputeModel').val();

        data.userAccountModel = {};
        data.userAccountModel.code = $.trim($('#userAccountModel').val());
        
        data.racAccountModel = {};
        data.racAccountModel.code = $.trim($('#racAccountModel').val());

        var unloadingChargeType = $.trim($('#unloadingcharge-type').val());
        data.unloadingChargeConfig = {};
        if (isNotNull(unloadingChargeType)) {
            data.unloadingChargeConfig[unloadingChargeType] = {};
            data.unloadingChargeConfig[unloadingChargeType].editable = +$('#unloadingcharge-editable').val();
            
            if (unloadingChargeType != 'SLC') {
                var unloadingChargeValue = +$('#unloadingcharge-value').val();
                data.unloadingChargeConfig[unloadingChargeType].value = unloadingChargeValue;

                if (isNaN(data.unloadingChargeConfig[unloadingChargeType].value) || unloadingChargeValue < 0) {
                    $('#unloadingcharge-value').addClass('inp_error');
                    err++;
                }
            }
        }
        data.unloadingChargeConfig = JSON.stringify(data.unloadingChargeConfig);

        data.connectingChargeType = $('#connectingChargeType').val();
        if (data.connectingChargeType != 'NA') {
            data.connectingChargeValue = $.trim($('#connectingChargeValue').val());
            if (isNull(data.connectingChargeValue) || isNaN(data.connectingChargeValue) || data.connectingChargeValue < 0) {
                $('#connectingChargeValue').addClass('inp_error');
                err++;
            }
        } else {
            data.connectingChargeValue = 0;
        }

        if (data.userAccountModel.code == '') {
            $('#userAccountModel').addClass('inp_error');
            err++;
        }
        if (data.racAccountModel.code == '') {
            $('#racAccountModel').addClass('inp_error');
            err++;
        }

        if (data.userAccountModel.code == 'DINV' && data.racAccountModel.code == 'GC') {
            $('#racAccountModel').addClass('inp_error');
            err++;
        }

        data.bookingModelTag = $('.bookingModelTag :checked').map(function () {
            return $(this).val();
        }).get();

        data.transitMode = $(".transitMode label").map(function () {
        return +($(this).hasClass("active"));
        }).get();

        data.cargoUnitModel = $('#cargoUnitModel').val() || [];

        if (data.cargoUnitModel.length == 0) {
            $('.cargoUnitModel').addClass('inp_error');
            err++;
        }
        
        if (err) {
            $('#usr-org-state').removeClass('alert-success hide').addClass('alert-danger').show();
            $('#usr-org-state').html('Please enter/select the values in the field that are marked in red');
            return;
        }

        $('.inp_error').removeClass('inp_error');
        $('#usr-org-state').removeClass('alert-danger alert-success').html('').hide();
        $('#ur-org-loading').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/update-cargo-settings",
            data: data,
            dataType: "json",
            success: function (response) {
                if (response.status == 1) {
                    $('#ur-org-loading').html('');
                    $('#usr-org-state').show();
                    $('#usr-org-state').removeClass('alert-danger');
                    $('#usr-org-state').addClass('alert-success');
                    $('#usr-org-state').html('Your request has been completed successfully');
                    // $('#form-org-bttons').html('');
                    window.setTimeout(function () {
                        $('#usr-org-state').hide();
                    }, 3000);
                } else {
                    $('#ur-org-loading').html('');
                    $('#usr-org-state').show();
                    $('#usr-org-state').removeClass('alert-success');
                    $('#usr-org-state').addClass('alert-danger');
                    $('#usr-org-state').html(response.errorDesc);
                }
            }
        });

    }

    function addDemurrageTermRow() {
        if ($('#demurrage-terms-list .demurrage-term-row').length >= 3) {
            alert('Allowed only maximum of 3 demurrage terms');
            return;
        }
        var partnersRow = $('#demurrage-terms-tpl').html();
        var $tpl = $(partnersRow);

        return $tpl.appendTo('#demurrage-terms-list');
    }

    function removeDemurrageTermRow(btn) {
        $(btn).closest('.demurrage-term-row').remove();
    }

    var tr_cnt = paymentModelData.length;
    function addAccountModel() {
        tr_cnt += 1
        var $accountModelRow = $('#add-account-model-tpl').html();
        var $tpl = $($accountModelRow);
        $tpl.find('.account-model-group').select2();
        $tpl.find('.bsn_switch').bootstrapSwitch('size', 'mini');

        // Paid
        $tpl.find('[name="pd_branch_vendor_due"]').attr('name', 'pd_branch_vendor_due'+tr_cnt);
        $tpl.find('[name="pd_book_comm"]').attr('name', 'pd_book_comm'+tr_cnt);
        $tpl.find('[name="pd_del_comm"]').attr('name', 'pd_del_comm'+tr_cnt);
        
        // To Pay
        $tpl.find('[name="tp_branch_vendor_due"]').attr('name', 'tp_branch_vendor_due'+tr_cnt);
        $tpl.find('[name="tp_book_comm"]').attr('name', 'tp_book_comm'+tr_cnt);
        $tpl.find('[name="tp_del_comm"]').attr('name', 'tp_del_comm'+tr_cnt);

        // On Account
        $tpl.find('[name="oa_branch_vendor_due"]').attr('name', 'oa_branch_vendor_due'+tr_cnt);
        $tpl.find('[name="oa_book_comm"]').attr('name', 'oa_book_comm'+tr_cnt);
        $tpl.find('[name="oa_del_comm"]').attr('name', 'oa_del_comm'+tr_cnt);

        $('#account-model-setup-table #account-model-rows').append($tpl);
        hideAccountsModelSaveBtn();
    }

    function removeAccountModel(btn) {
        $(btn).closest('tr.account-model-row').remove();
        hideAccountsModelSaveBtn();
    }

    function viewAccountModel(ele) {
        $(ele).closest('.account-model-list').find('.account-model-edit').addClass('hide');
        $(ele).next('.account-model-view').toggleClass('hide');
        hideAccountsModelSaveBtn();
    }

    function closeEditAccountModel(ele) {
        event && event.stopPropagation();
        $(ele).closest('.account-model-list').find('.account-model-view-list').toggleClass('hide');
        $(ele).closest('.account-model-list').find('.account-model-edit').toggleClass('hide');
        hideAccountsModelSaveBtn();
    }

    function editAccountModel(ele) {
        event && event.stopPropagation();
        $(ele).closest('.account-model-list').find('.account-model-view').addClass('hide');
        $(ele).closest('.account-model-list').find('.account-model-edit').toggleClass('hide');
        var group_d = $(ele).closest('.account-model-list').find('#account-model-group-id').val();
        if(group_d == 'NA'){
            $(ele).closest('.account-model-list').find('#account-model-group-id').prop('disabled', true);
        }
        hideAccountsModelSaveBtn();
    }

    function deleteAccountModel(groupCode) {
        event && event.stopPropagation();
        var data = {};
        data.accountModel = [];

        var accountModel = {};
        accountModel.activeFlag = 2;

        accountModel.group = {};
        accountModel.group.code = groupCode;

        data.accountModel.push(accountModel);

        if (isNull(groupCode)) {
            $('#account-madel-action-state').removeClass('alert-success hide').addClass('alert-danger').show();
            $('#account-madel-action-state').html('Please select a valid group');
            window.setTimeout(function () {
                $('#account-madel-action-state').removeClass('alert-danger alert-success').html('').hide();
            }, 3000);
            return false;
        }

        $('#account-madel-action-state').removeClass('alert-danger alert-success').html('').show();
        $('#account-madel-action-state').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/update-account-model",
            data: data,
            dataType: "json",
            success: function (response) {
                if (response.status == 1) {
                    $('#account-madel-action-state').show();
                    $('#account-madel-action-state').removeClass('alert-danger');
                    $('#account-madel-action-state').addClass('alert-success');
                    $('#account-madel-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        $('#account-madel-action-state').hide();
                        checkURL();
                    }, 3000);
                } else {
                    $('#account-madel-action-state').show();
                    $('#account-madel-action-state').removeClass('alert-success');
                    $('#account-madel-action-state').addClass('alert-danger');
                    $('#account-madel-action-state').html(response.errorDesc);
                }
            }
        });
    }

    hideAccountsModelSaveBtn();
    function hideAccountsModelSaveBtn() {
        var show = 0;
        $('#account-model-save-btn').addClass('hide');
        $('#account-model-setup-table .account-model-row').each(function() {
            if ($(this).find('.account-model-edit').hasClass('hide')) {
                return;
            }
            show += 1;
        });
        if (show > 0) {
            $('#account-model-save-btn').removeClass('hide');
        }
    }

    function saveAccountModel() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');
        var data = {};
        data.accountModel = [];
        var group = $.merge([], paymentModelGroups);
        $('#account-model-setup-table .account-model-row').each(function() {
            if ($(this).find('.account-model-edit').hasClass('hide')) {
                return;
            }
            var accountModel = {};
            accountModel.activeFlag = 1;

            var paidModel = $(this).find(".paid").map(function () {
                return +($(this).is(":checked"));
            }).get();

            var toPayModel = $(this).find(".topay").map(function () {
                return +($(this).is(":checked"));
            }).get();

            var onAccountModel = $(this).find(".onaccount").map(function () {
                return +($(this).is(":checked"));
            }).get();

            accountModel.paidModel = paidModel.join('');
            accountModel.toPayModel = toPayModel.join('');
            accountModel.onAccountModel = onAccountModel.join('');

            accountModel.group = {};
            accountModel.group.code = $(this).find('select.account-model-group').val();
            var oldGroup = $(this).find('select.account-model-group').data('group');
            
            if (($.inArray(accountModel.group.code, group) != -1 && isNull(oldGroup) && accountModel.group.code !='NA' || (isNotNull(oldGroup) && oldGroup != accountModel.group.code))) {
                $(this).find('select.account-model-group').addClass('inp_error');
                err++;
            }

            group.push(accountModel.group.code);
            data.accountModel.push(accountModel);
        });

        if (err > 0) {
            $('#account-madel-action-state').removeClass('alert-success hide').addClass('alert-danger').show();
            $('#account-madel-action-state').html('Please select a different group');

            window.setTimeout(function () {
                $('.inp_error').removeClass('inp_error');
                $('#account-madel-action-state').removeClass('alert-danger alert-success').html('').hide();
            }, 3000);
            return false;
        }

        $('#account-madel-action-state').removeClass('alert-danger alert-success').html('').show();
        $('#account-madel-action-state').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/update-account-model",
            data: data,
            dataType: "json",
            success: function (response) {
                if (response.status == 1) {
                    $('#account-madel-action-state').show();
                    $('#account-madel-action-state').removeClass('alert-danger');
                    $('#account-madel-action-state').addClass('alert-success');
                    $('#account-madel-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        $('#account-madel-action-state').hide();
                        checkURL();
                    }, 3000);
                } else {
                    $('#account-madel-action-state').show();
                    $('#account-madel-action-state').removeClass('alert-success');
                    $('#account-madel-action-state').addClass('alert-danger');
                    $('#account-madel-action-state').html(response.errorDesc);
                }
            }
        });
    }
</script>