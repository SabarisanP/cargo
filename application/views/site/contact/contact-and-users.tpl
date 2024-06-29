<div class="brand_top">
    <h3> Contact & Users</h3>
    <a href="#contact/contact-category" target="_blank" class="btn btn-success text-white pull-right">Contact Category</a>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-5">
                <div class="row">
                    <div style="clear: both;"></div><br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <h4 class="pannel-title">User Management</h4>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h6>Select Category</h6>
                                        <ul class="nav nav-tabs" id="con-usr-tabs">
                                            <li class="active"><a data-toggle="tab" id="con-usr-trns" href="#transporter" style="padding: 10px 20px;">Transporter</a></li>
                                            <li><a data-toggle="tab" id="con-usr-branch-tab" href="#branch" style="padding: 10px 20px;">Branch</a></li>
                                            <li><a data-toggle="tab" id="con-usr-vendor" href="#vendor" style="padding: 10px 20px;">Vendor</a></li>
                                            <li><a data-toggle="tab" id="con-usr-bnk-det" href="#bank-details" style="padding: 10px 20px;">Namespace</a></li>
                                            <li><a data-toggle="tab" id="con-usr-expense" href="#expenses" style="padding: 10px 20px;">Expenses</a></li>
                                            <li class="dropdown">
                                                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Others <span class="caret"></span></a>
                                                <ul class="dropdown-menu">
                                                    {foreach item=row from=$contactCategory}
                                                        {if !in_array($row->actionCode, ['TRANS', 'BRCH', 'RAC', 'NMSP', 'EXP'])}
                                                            <li><a data-toggle="tab" class="con-usr-others" href="#contact-category-others" data-code="{$row->code}" data-type="{$row->actionCode}">{$row->name}</a></li>
                                                        {/if}
                                                    {/foreach}
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="contents" class="col-lg-7">
                {* <div class="row"> *}
                    <div style="clear: both;"></div><br>
                    <div class="panel panel-default">
                        <div class="panel-title pull-left">
                            <h4 id="con-usr-title">Transporter</h4>
                        </div>
                        <div class="pull-right">
                            <a href="javascript:;" class="btn btn-success text-white btn-sm" id="con-usr-add-btn" onclick="showAddNew()">Add Transporter</a>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div style="clear: both;"></div><br>
                    {* <div class="col-lg-12 mb-2"> *}
                        <div class="panel panel-default" id="con-usr-tab-pannel">
                            <div class="panel-body" >
                                <div class="tab-content">
                                    <div class="tab-pane fade in active" id="transporter">
                                        <div class="table table-responsive" id="con-usr-trns-data">
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="driver">
                                        <div class="table table-responsive" id="con-usr-drv-data">
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="supplier">
                                        <div class="table table-responsive" id="con-usr-splr-data">
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="branch">
                                        <div class="table table-responsive" id="con-usr-brn-data">
                                            
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="vendor">
                                        <div class="table table-responsive" id="con-usr-ven-data">
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="bank-details">
                                        <div class="table table-responsive" id="con-usr-bnk-det-data">
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="expenses">
                                        <div class="table table-responsive" id="con-usr-expense-data">
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="contact-category-others">
                                        <div class="table table-responsive" id="con-usr-others-data">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="none" id="con-usr-add">
                            <form role="form" id="form1" class="form-horizontal ">
                                <div class="panel panel-default">
                                    <h4 class="pannel-title">Basic Information</h4>
                                    <div class="panel-body" id="">
                                        {* <form role="form" id="form1" class="form-horizontal "> *}
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="col-lg-6 p_l_n">
                                                        <div>
                                                            <label for="con-usr-name" class="req">Name</label>
                                                            <input type="text" placeholder="Name" id="con-usr-name" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 p_l_n p_r_n">
                                                        <div>
                                                            <label for="con-usr-tradename" class="req">Trade Name</label>
                                                            <input type="text" placeholder="Trade Name" id="con-usr-tradename" class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="clear_fix_both"></div> <br>
                                                    <div class="col-lg-6 p_l_n ">
                                                        <div>
                                                            <label for="con-usr-gstin" class="req">GSTIN</label>
                                                            <input type="text" placeholder="GSTIN" id="con-usr-gstin" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 p_l_n p_r_n">
                                                        <div>
                                                            <label for="con-usr-contact" class="req">Contact Name</label>
                                                            <input type="text" placeholder="Contact Name" id="con-usr-contact" class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="clear_fix_both"></div> <br>
                                                    <div class="col-lg-12 p_l_n p_r_n" id="tags">
                                                        <div>
                                                            <label for="con-usr-tags" class="">Tags</label>
                                                            <select id="con-usr-tags" class="form-control col-md-6">
                                                                <option value="">Select Tag</option>
                                                                {foreach from=$cargotags item=val}
                                                                    <option value="{$val->code}">{$val->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div> 
                                                    <div class="clear_fix_both"></div> <br>
                                                    <div class="col-lg-6 p_l_n">
                                                        <div>
                                                            <label for="con-usr-mob" class="req">Mobile No</label>
                                                            <input type="number" placeholder="Mobile No" id="con-usr-mob" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 p_l_n p_r_n">
                                                        <div>
                                                            <label for="con-usr-email" class="req">Email</label>
                                                            <input type="text" placeholder="Email" id="con-usr-email" class="form-control">
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="clear_fix_both"></div> <br>
                                                    <div class="col-lg-12 p_l_n p_r_n">
                                                        <div>
                                                            <label for="con-usr-address" class="">Address</label>
                                                            <textarea  placeholder="Address" id="con-usr-address" class="form-control"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="clear_fix_both"></div> <br>
                                                    <div class="col-lg-6 p_l_n">
                                                        <div>
                                                            <label for="con-usr-latitude" class="">Latitude</label>
                                                            <input  placeholder="Latitude" id="con-usr-latitude" name="Latitude"  class="form-control rs_no">
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 p_l_n p_r_n">
                                                        <div>
                                                            <label for="con-usr-longitude" class="">Longitude</label>
                                                            <input  placeholder="Longitude" id="con-usr-longitude" name="Longitude"  class="form-control rs_no">
                                                        </div>
                                                    </div>
                                                    <div class="clear_fix_both"></div>
                                                    <div class="col-lg-6 p_l_n">
                                                        <div>
                                                            <label for="con-usr-taglist">Credit / Debit</label>
                                                            <span class="radio d-inline-block">
                                                                <label><input type="radio" name="con-usr-taglist" value="CREDIT" checked> Credit</label>
                                                            </span>&emsp;
                                                            <span class="radio d-inline-block">
                                                                <label><input type="radio" name="con-usr-taglist" value="DEBIT"> Debit</label>
                                                            </span>&emsp;
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div id="map_canvas" class="contact-map" style="width: 95%; height: 458px;"></div>
                                                </div>
                                            </div>
                                        {* </form> *}
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <h4 class="pannel-title">Financial Information</h4>
                                    <div class="panel-body" id="">
                                        <div class="row">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="con-usr-acc-name" class="req">Acc Holder Name</label>
                                                    <input type="text" placeholder="Acc Holder Name" id="con-usr-acc-name" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n p_r_n">
                                                <div>
                                                    <label for="con-usr-acc-no" class="req">Account No</label>
                                                    <input type="number" placeholder="Account No" id="con-usr-acc-no" class="form-control">
                                                </div>
                                            </div>
                                
                                            <div class="clear_fix_both"></div> <br>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="con-usr-ifc" class="req">IFSC Code</label>
                                                    <input type="text" placeholder="IFSC Code" id="con-usr-ifc" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n p_r_n">
                                                <div>
                                                    <label for="con-usr-bank-name" class="req">Bank Name</label>
                                                    <input type="text" placeholder="Bank Name" id="con-usr-bank-name" class="form-control">
                                                </div>
                                            </div>
                                
                                            <div class="clear_fix_both"></div> <br>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="con-usr-branch" class="req">Branch Location</label>
                                                    <input type="text" placeholder="Branch location" id="con-usr-branch" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n p_r_n">
                                                <div>
                                                    <label for="con-usr-acc-type" class="req">Acc Type</label>
                                                    <select id="con-usr-acc-type" class="form-control">
                                                        <option value="">Select</option>
                                                        <option value="CURR">Current Account</option>
                                                        <option value="SVGS">Savings Account</option>
                                                        <option value="SLRY">Salary Account</option>
                                                    </select>
                                                </div>
                                            </div>
                                
                                            <div class="clear_fix_both"></div> <br>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="con-usr-upi" class="req">UPI ID</label>
                                                    <input type="text" placeholder="UPI ID" id="con-usr-upi" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <input type="hidden" id="hid-con-usr-code">
                            <input type="hidden" id="hid-con-usr-bank-code">
                            <input type="hidden" id="hid-con-usr-address-code">
                            <input type="hidden" id="entity-type" value="TRANS">
                            <div class="clear_fix_both"></div> <br>                    
                            <div class="alert fl suc_cre" style="display: none;" id="con-usr-state"></div>
                            <div class="align-right">
                                <button class="btn btn-success" type="button" form="form1" onclick="saveContacts();">Save</button>
                                <button class="btn btn-default" type="button" form="form1" onclick="cancelAddNew();">Cancel</button>
                            </div>
                        </div>

                        {* add branch *}
                        <div class="none" id="add-branch">
                            <form role="form" id="form1" class="form-horizontal ">
                                <div class="panel panel-default">
                                    <div class="panel-body" id="">
                                        <div class="row">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="branch-taglist">Credit / Debit</label>
                                                    <span class="radio d-inline-block">
                                                        <label><input type="radio" name="branch-taglist" value="CREDIT" checked> Credit</label>
                                                    </span>&emsp;
                                                    <span class="radio d-inline-block">
                                                        <label><input type="radio" name="branch-taglist" value="DEBIT"> Debit</label>
                                                    </span>&emsp;
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <input type="hidden" id="hid-branch-code">
                            <div class="clear_fix_both"></div> <br>                    
                            <div class="alert fl suc_cre" style="display: none;" id="add-branch-state"></div>
                            <div class="align-right">
                                <button class="btn btn-success" type="button" form="form1" onclick="saveBranch();">Save</button>
                                <button class="btn btn-default" type="button" form="form1" onclick="cancelBranchDialog();">Cancel</button>
                            </div>
                        </div>

                        {* add bank details *}
                        <div class="none" id="add-namespace">
                            <form role="form" id="form1" class="form-horizontal ">
                                <div class="panel panel-default">
                                    <div class="panel-body" id="">
                                        <div class="row">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="namespace-taglist">Credit / Debit</label>
                                                    <span class="radio d-inline-block">
                                                        <label><input type="radio" name="namespace-taglist" value="CREDIT" checked> Credit</label>
                                                    </span>&emsp;
                                                    <span class="radio d-inline-block">
                                                        <label><input type="radio" name="namespace-taglist" value="DEBIT"> Debit</label>
                                                    </span>&emsp;
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <input type="hidden" id="hid-namespace-code">
                            <div class="clear_fix_both"></div> <br>                    
                            <div class="alert fl suc_cre" style="display: none;" id="add-namespace-state"></div>
                            <div class="align-right">
                                <button class="btn btn-success" type="button" form="form1" onclick="saveNamespace();">Save</button>
                                <button class="btn btn-default" type="button" form="form1" onclick="cancelNamespaceDialog();">Cancel</button>
                            </div>
                        </div>
                        <div class="none" id="add-bank-details">
                            <form role="form" id="form1" class="form-horizontal ">
                                <div class="panel panel-default">
                                    <h4 class="pannel-title">Financial Information</h4>
                                    <div class="panel-body" id="">
                                        <div class="row">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="add-bnk-acc-name" class="req">Acc Holder Name</label>
                                                    <input type="text" placeholder="Acc Holder Name" id="add-bnk-acc-name" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n p_r_n">
                                                <div>
                                                    <label for="add-bnk-acc-no" class="req">Account No</label>
                                                    <input type="number" placeholder="Account No" id="add-bnk-acc-no" class="form-control">
                                                </div>
                                            </div>
                                
                                            <div class="clear_fix_both"></div> <br>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="add-bnk-ifc" class="req">IFSC Code</label>
                                                    <input type="text" placeholder="IFSC Code" id="add-bnk-ifc" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n p_r_n">
                                                <div>
                                                    <label for="add-bnk-bank-name" class="req">Bank Name</label>
                                                    <input type="text" placeholder="Bank Name" id="add-bnk-bank-name" class="form-control">
                                                </div>
                                            </div>
                                
                                            <div class="clear_fix_both"></div> <br>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="add-bnk-branch" class="req">Branch Location</label>
                                                    <input type="text" placeholder="Branch location" id="add-bnk-branch" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n p_r_n">
                                                <div>
                                                    <label for="add-bnk-acc-type" class="req">Acc Type</label>
                                                    <select id="add-bnk-acc-type" class="form-control">
                                                        <option value="">Select</option>
                                                        <option value="CURR">Current Account</option>
                                                        <option value="SVGS">Savings Account</option>
                                                        <option value="SLRY">Salary Account</option>
                                                        <option value="CASH">Cash Account</option>
                                                    </select>
                                                </div>
                                            </div>
                                
                                            <div class="clear_fix_both"></div> <br>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="add-bnk-upi" class="req">UPI ID</label>
                                                    <input type="text" placeholder="UPI ID" id="add-bnk-upi" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <input type="hidden" id="hid-bank-detail-code">
                            <div class="clear_fix_both"></div> <br>                    
                            <div class="alert fl suc_cre" style="display: none;" id="add-bank-detail-state"></div>
                            <div class="align-right">
                                <button class="btn btn-success" type="button" form="form1" onclick="saveBankDetails();">Save</button>
                                <button class="btn btn-default" type="button" form="form1" onclick="cancelAddBankDetail();">Cancel</button>
                            </div>
                        </div>

                        {* add expense *}
                        <div class="none" id="add-expenses">
                            <form role="form" id="form1" class="form-horizontal ">
                                <div class="panel panel-default">
                                    <h4 class="pannel-title">Add Expense</h4>
                                    <div class="panel-body" id="">
                                        <div class="row">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="expense-taglist">Credit / Debit</label>
                                                    <span class="radio d-inline-block">
                                                        <label><input type="radio" name="expense-taglist" value="CREDIT" checked> Credit</label>
                                                    </span>&emsp;
                                                    <span class="radio d-inline-block">
                                                        <label><input type="radio" name="expense-taglist" value="DEBIT"> Debit</label>
                                                    </span>&emsp;
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="expense-name" class="req">Name</label>
                                                    <input type="text" placeholder="Expense" id="expense-name" class="form-control">
                                                </div>
                                            </div>

                                            <div class="clear_fix_both"></div><br>
                                            <div class="col-lg-12 p_l_n">
                                                <div>
                                                    <label for="expense-contact-name" class="req">Contact Name</label>
                                                    <input type="text" placeholder="Contact" id="expense-contact-name" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <input type="hidden" id="hid-expense-code">
                            <div class="clear_fix_both"></div> <br>                    
                            <div class="alert fl suc_cre" style="display: none;" id="add-expense-state"></div>
                            <div class="align-right">
                                <button class="btn btn-success" type="button" form="form1" onclick="saveExpense();">Save</button>
                                <button class="btn btn-default" type="button" form="form1" onclick="cancelExpenseDialog();">Cancel</button>
                            </div>
                        </div>

                        {* Add Other Contacts *}
                        <div class="none" id="add-other-contacts">
                            <form role="form" id="form1" class="form-horizontal ">
                                <div class="panel panel-default">
                                    <div class="panel-body" id="">
                                        <div class="row">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="other-taglist">Credit / Debit</label>
                                                    <span class="radio d-inline-block">
                                                        <label><input type="radio" name="other-taglist" value="CREDIT" checked> Credit</label>
                                                    </span>&emsp;
                                                    <span class="radio d-inline-block">
                                                        <label><input type="radio" name="other-taglist" value="DEBIT"> Debit</label>
                                                    </span>&emsp;
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="other-contact-name" class="req">Name</label>
                                                    <input type="text" id="other-contact-name" class="form-control">
                                                </div>
                                            </div>
                                            
                                            <div class="clear_fix_both"></div><br>
                                            <div class="col-lg-12 p_l_n">
                                                <div>
                                                    <label for="other-contact-contact-name" class="req">Contact Name</label>
                                                    <input type="text" placeholder="Contact" id="other-contact-contact-name" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <input type="hidden" id="hid-other-contact-code">
                            <div class="clear_fix_both"></div> <br>                    
                            <div class="alert fl suc_cre" style="display: none;" id="add-other-contact-state"></div>
                            <div class="align-right">
                                <button class="btn btn-success" type="button" form="form1" onclick="saveOtherContacts();">Save</button>
                                <button class="btn btn-default" type="button" form="form1" onclick="cancelOtherContacts();">Cancel</button>
                            </div>
                        </div>
                    {* </div> *}
                {* </div> *}
            </div>
        </div>
    </div>
</div>

<script>
    var contactCategoryData = {$contactCategory|json_encode}

    var data = {};
    data.entityTypeCode = 'TRANS';

    $.ajax({
        type: 'POST',
        dataType: 'html',
        url: base_url + 'contact/get-all-contacts',
        data: data,
        success: function (response) {
            $('#con-usr-trns-data').html(response);
        }
    });

    function init_contact(){
        init_contacts();
    }
</script>