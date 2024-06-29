<div>
  <span class="align-rights">
    <button class="btn btn-success" type="button" onclick="addCoupon()">
	  <i class="fa fa-plus"></i> Add New Coupon
    </button>
  </span>
</div>
<div class="col-md-offset-3 col-md-6 ">
    <table class="table table-stripped" width="100%">
        <thead>
            <tr>
                <th>Name</th>
                <th>Category</th>
                <th>Description</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach name=o item=row from=$coupon} 
                <tr>
                    <td width="25%">{$row->coupon}</td>
                    <td width="25%">{$row->discountCategory->name}</td>
                    <td width="35%">{$row->description}</td>
                    <td>
                        <div class="btn-group btn-group-xs">
                            <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" id='at_edt_{$row->code}' onclick='addCoupon({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                            <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"   onclick="deleteCoupon('{$row->code}')" ><i class="fa fa-trash-o ired"></i></a>
                        </div>
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="4" align="center">No Discount Coupon Found!</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

 <div class="clear_fix_both"></div>
<div id="coupon-dialog" class="hide dialog-content-page">
    <div class="">
        <form role="form" id="form1" class="form-horizontal ">
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="txt_oz_name" class="req">Coupon Name</label>
                    <input  placeholder="Name" id="cop-name" name="cop-name"  class="form-control">
                </div>
            </div>  
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="req">Discount Category</label>
                    <select id="cop-category" class="form-control col-md-6">
                        <option value="">Select Category</option>
                        {foreach name=o item=row from=$category}
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach} 
                    </select>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            <br />  
            <div class="col-lg-13 p_l_n">
                <div>
                    <label for="txt_oz_name" class="req">Description</label>
                    <textarea rows="8" placeholder="Description" id="cop-desc" name="cop-desc"  class="form-control rs_no"></textarea>
                </div>
            </div>  
        </form>
    </div>
    <div class="clear_fix_both"></div>
    <br />
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="cops-form-action-state"></div>
        <div class="align-right cre_sve" id="cops-form-bttons">
            <input type="hidden" id="cop-code">
            <button class="btn btn-success" type="button" onclick="saveDiscountCoupon();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelDiscountCoupon();">Cancel</button>
        </div>
    </div> 
</div>
<script>
    var coupon_list = {$coupon|json_encode};
</script>