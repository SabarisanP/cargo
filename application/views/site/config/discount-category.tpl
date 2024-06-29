 <div>
    <span class="align-rights">
        <button class="btn btn-success" type="button" onclick="addCategory()">
            <i class="fa fa-plus"></i> Add New Category
        </button>
	  </span>
 </div>
<div class="col-md-offset-3 col-md-6 ">
    <table class="table table-stripped" width="100%">
        <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach name=o item=row from=$category} 
                <tr>
                    <td width="35%">{$row->name}</td>
                    <td width="50%">{$row->description}</td>
                    <td>
                        <div class="btn-group btn-group-xs">
                            <a href="javascript:;" class="btn btn-default btn-sm" title="Edit" id='at_edt_{$row->code}' onclick='addCategory({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                            <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"   onclick="deleteCategory('{$row->code}')" ><i class="fa fa-trash-o ired"></i></a>
                        </div>
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="3" align="center">No Discount Categories Found!</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

<div class="clear_fix_both"></div>
<div id="category-dialog" class="hide dialog-content-page">
    <div class="">
        <form role="form" id="form1" class="form-horizontal ">
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="txt_oz_name" class="req">Name</label>
                    <input  placeholder="Name" id="name" name="name"  class="form-control">
                </div>
            </div>    
            <div class="clear_fix_both"></div>
            <br />  
            <div class="col-lg-13 p_l_n">
                <div>
                    <label for="txt_oz_name" class="req">Description</label>
                    <textarea rows="8" placeholder="Description" id="desc" name="desc"  class="form-control rs_no"></textarea>
                </div>
            </div>  
        </form>
    </div>
    <div class="clear_fix_both"></div>
    <br />
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="cat-form-action-state"></div>
        <div class="align-right cre_sve" id="cat-form-bttons">
            <input type="hidden" id="code">
            <button class="btn btn-success" type="button" onclick="saveDiscountCategory();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelDiscountCategory();">Cancel</button>
        </div>
    </div> 
</div>
