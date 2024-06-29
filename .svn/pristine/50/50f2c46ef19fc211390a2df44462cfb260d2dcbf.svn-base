<div class="brand_top">
    <h3>Retail Customers</h3> 
{* <input type='hidden' id='customer-list' value="{$customers|json_encode}"> *}

    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="customerDialog();">Add New Retail Customer</a>
    </span>
</div>
<div id="main_wrapper" style="overflow: visible;">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="user-result-panel" style="min-height: 400px;">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="align-center" id="user-action-status"></div>
                                                <div id="user-address-book" class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="customer-branch" class="">Select Branch</label>
                                                        <select class="form-control" id="customer-branch">
                                                            <option value="">Select</option>
                                                            {foreach from=$stations item=val}
                                                                <option value="{$val->code}">{$val->name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    {* <ul class="user_list" id="usr_lst_ul">
                                                        {if count($customers) > 0} *}
                                                            <div class="well well-sm">
                                                                <input type="text" class="form-control" placeholder="Search Retail Customer / Mobile No / GSTIN" id="cust_search" >
                                                            </div>  
                                                            {* <div class="user_list_action bt_27">
                                                                <ul class="user_list " id="user_list_search">
                                                                    <div id="usr_scroll">
                                                                        {foreach name=o item=row from=$customers} 
                                                                            <li id="usr-{$row->code}">
                                                                                <div class="fl rt_8">
                                                                                    <a href="javascript:;" id="usr-viw-{$row->code}" onclick="custView('{$row->code}')" data-toggle="tooltip"  title="Click to view customer details">
                                                                                        {$row->name}
                                                                                    </a>
                                                                                </div>
                                                                            </li>
                                                                        {/foreach}
                                                                    </div>
                                                                </ul>
                                                            </div>
                                                        {else}
                                                            <li class="er_msg"><div class="well well-large "> No customers found!</div></li>
                                                            {/if}   
                                                    </ul> *}
                                                </div>
                                                <div class="col-md-9" id="cst-viw-rslt">
                                                    {* {if count($customers) > 0} *}
                                                        <div class="p_t_100" style="padding-top: 72px;">
                                                            <div class="well well-large "> Select any customer to view more details.</div>
                                                        </div>
                                                    {* {/if}  *}
                                                </div>
                                                <div id="addr_cust_view">
                                                </div>    
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="warning-text" id="useer-search-status"></div>
                                <div id="customer-dialog" class="dialog-content-page" style="display: none">
                                    <form class="form-horizontal " action="#">
                                        <div class="ov_fl_350">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label class="req">Name</label>
                                                    <input type="text" id="cust_name" class="form-control" placeholder="Name" maxlength="120">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label class="req">Retail Customer Group</label>
                                                    <select id="cust_group" class="form-control">
                                                        <option value=''>Select</option>
                                                        {foreach name=o item=rows from=$groups} 
                                                            <option value="{$rows->code}">{$rows->name}</option>  
                                                        {/foreach}    
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <br />    
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label class="req">Company Name</label>
                                                    <input type="text" id="cust_company" class="form-control" placeholder="Company Name" maxlength="120">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label class="req">Mobile</label>
                                                    <input type="text" id="cust_mobile" class="form-control" placeholder="Mobile">
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <br />    
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label class="req">Payment Type</label>
                                                    <select class="form-control" id="cust_mode" >
                                                        <option value="">Select Type</option>   
                                                        <option value="TOP">Payment To Pay</option>
                                                        <option value="INP">Payment Invoice/Acc Pay</option>
                                                        <option value="OATP">Payment Invoice/Acc ToPay</option>
                                                        <option value="PAD">Payment Paid</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label class="req">GSTIN Number</label>
                                                    <input type="text" id="cust_gstin" class="form-control" placeholder="GSTIN Number">
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <br />
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="cust_station" class="req">Station</label>
                                                    <select id="cust_station" class="form-control" multiple>
                                                        {foreach name=o item=row from=$stations} 
                                                            <option value="{$row->code}">{$row->name}</option>  
                                                        {/foreach}   
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label>Email</label>
                                                    <input type="email" id="cust_email" class="form-control" placeholder="Email" maxlength="64">
                                                </div>
                                            </div>
                                        </div>       
                                        <div class="clear_fix_both"></div><br>
                                        <input type="hidden" id="cust_code">
                                        <input type="hidden" id="cust_ref_code">
                                        <input type="hidden" id="cust_role">
                                        <div id="cust-form-loading" style="display:none"></div>
                                        <div class="align-center alert alert-danger pull-left rt_15" style="display: none;" id="cust-action-state"></div>
                                        <div class="align-right lt_15" id="cust-form-buttons">
                                            <button type="button" id="btn-save" class="btn btn-success" onclick="saveCustomer()">Save</button>
                                            <button type="button" class="btn btn-default" onclick="cancelCustomer()">Cancel</button>
                                        </div>
                                    </form>
                                </div>

                                <!-- Address Dialog -->
                                <div id="address-dialog" class="dialog-content-page" style="display: none">
                                    <div class="ov_fl_290">
                                        <form role="form" id="form-address" class="form-horizontal ">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Address Type</label>
                                                    <input  placeholder="Address Type" id="addr_name" name="addr_name"  value="" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Station</label>
                                                    <select id="addr_station" class="form-control">
                                                        <option value="">Select Station</option>
                                                        {foreach name=o item=row from=$stations} 
                                                            <option value="{$row->code}">{$row->name}</option>  
                                                        {/foreach}   
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <br />
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Flat, House no., Building, Company, Apartment</label>
                                                    <textarea id="addr1"  placeholder="Flat, House no., Building, Company, Apartment" style="resize:none" class="form-control" rows="3" cols="10" maxlength="180"></textarea>
                                                </div>
                                            </div>   
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Area, Colony, Street, Sector, Village</label>
                                                    <textarea id="addr2"  placeholder="Area, Colony, Street, Sector, Village" style="resize:none" class="form-control" rows="3" cols="10" maxlength="180"></textarea>
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <br />
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Landmark</label>
                                                    <input  placeholder="Landmark" id="landmark" name="landmark"  value="" class="form-control" maxlength="80">
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Pincode</label>
                                                    <input type="text" placeholder="Pincode" id="pincode" name="pincode"  value="" class="form-control" maxlength="6" data-mask="positiveinteger">
                                                </div>
                                            </div>
                                             <div class="clear_fix_both"></div>
                                        </form>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                    <div class="clear_fix_both">                       
                                        <div class="alert fl suc_cre" style="display:none;" id="addr-action-state"></div>
                                        <div class="align-right cre_sve" id="addr-form-buttons">
                                            <input type="hidden" id="addr_code">
                                            <input type="hidden" name="addr_user_id" id="addr_user_id"/>
                                            <button class="btn btn-success" type="button" onclick="saveAddress();">Save</button>
                                            <button class="btn btn-default" type="button" onclick="cancelAddress();">Cancel</button>
                                        </div>
                                    </div> 
                                </div>
                                <!-- Address ends -->                    
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>
<input type='hidden' id='custo_id'>

<script type="text/template" id="customer_detail_view">

    <div class="">
        <div class="btn-group pull-right">
            <!--<a class="btn btn-default edt_stu" href="javascript:;" onclick='editCustomerStatus()'>
            <i class="fa fa-times" data-status="0" title="Click to disable" data-toggle="tooltip"></i>
            </a>-->
            <a href="javascript:;" class="btn btn-default edt" title="Edit details" data-toggle="tooltip" onclick="customerDialog()">
            <i class="fa fa-pencil igreen"></i>
            </a>
            <a title="Delete" data-toggle="tooltip" class="btn btn-default del" href="javascript:;" onclick='deleteCustomer()'>
            <i class="fa fa-trash-o"></i>
            </a>
            <a title="Add address" data-toggle="tooltip" class="btn btn-default addr" href="javascript:;"  onclick='addressDialog()'>
            <i class="fa fa-reorder"></i>
            </a>
        </div>
        <div class="btn-group pull-left"><h4>Retail Customer Details</h4></div>         
    </div>


    <div class="clear_fix_both"></div>

    <br />

    <div class="box_content">
        <div class="row border-bottom" >
            <label class="col-md-2">Name:</label>
            <div class="col-md-3 viw_name"></div>
            <label class="col-md-2">Company Name:</label>
            <div class="col-md-3 cmp_name"></div>
        </div>
        <div class="row border-bottom">
            <label class="col-md-2">Mobile:</label>
            <div class="col-md-3 mobile"></div>
            <label class="col-md-2">Payment Type:</label>
            <div class="col-md-3 payment"></div>
        </div>
        <div class="row border-bottom" >
            <label class="col-md-2">Role:</label>
            <div class="col-md-3 role"></div>
            <label class="col-md-2">Reference:</label>
            <div class="col-md-3 ref"></div>
        </div>
        <div class="row border-bottom">        
            <label class="col-md-2">GSTIN Number:</label>
            <div class="col-md-3 gst_no"></div>            
            <label class="col-md-2">Stations:</label>
            <div class="col-md-3 stations">
                <a id="popup_msg" data-toggle="popover" data-trigger="hover">
                    <span class="badge badge-info"></span>
                </a>
            </div>
        </div>
        <div class="row border-bottom">        
            <label class="col-md-2">Email:</label>
            <div class="col-md-3 email"></div>
        </div>
        
    </div>
    <br />

</script>      

<style>
    .tt-menu {
        display: block!important;
        top: calc(36px + 20px)!important;
        z-index: 1!important;
        box-shadow: none;
        border: none;
    }
    .tt-suggestion {
        padding: 5px 10px 5px 5px!important;
        margin: 0!important;
        margin-bottom: 2px!important;
        border-bottom: 1px dashed #e8e8e8!important;
    }
</style>

<script>
    var ns = {$namespace|json_encode};
    var userStationCode = '{$userDetail['org_station_code']}';
    
    $('#customer-branch').select2();
    $('#customer-branch').val(userStationCode).trigger('change');

    $('#form-address [data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });

    function _init_customers(){
        init_customer_actions();
    }
    //var customerlist = {$customers|json_encode};
    
    $(document).ready(function () {

        //$('input#cust_search').quicksearch('#user_list_search #usr_scroll > li');
        $("#usr_scroll").css({
            'max-height': '350px',
        }).perfectScrollbar({
            wheelSpeed: 20,
            wheelPropagation: false
        });
     
        $('#cust_search').focus();
        $('#cust_station').select2({
            placeholder: 'Select Station'
        });

        $('#addr_station').select2();

        $('#addr_name').autocomplete({
            minLength: 0,
            source: [
                'Home',
                'Office',
            ],
            appendTo: '#address-dialog'
        }).focus(function(){
            $(this).autocomplete('search', '');
        });
    });


</script>







