<!--Organization dialog-->                     
<div id="edit-user-organization" class="dialog-content-page" style="display: none">
    <form class="" action="#">
        <!-- <label>Please select a route</label>
        -->      
        <br/>
        <div class="form-group">                                
            <div class="input-group col-md-12" id="state-list">
                <label class="req">From Station</label>
                <select class="form-control" id="sel_route_frm_id" name ='Rf'>
                    <option value=''>Select</option>
                    {foreach item=rte from=$routes}
                        <option value="{$rte->code}">{$rte->name}</option>

                    {/foreach}
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="req">To Station</label>
            <div class="input-group col-md-12" id="state-list">
                <select class="form-control" id="sel_route_to_id" name ='Rt'>
                    <option value=''>Select</option>
                    {foreach item=rte from=$routes}
                        <option value="{$rte->code}">{$rte->name}</option>

                    {/foreach}
                </select>
            </div> 
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="req">Minimum Fare</label>
                    <input type="text" class="form-control no-spin" id="route_min_fare" maxlength="4">
                </div> 
            </div>
            <div class="col-md-6 p_l_n">
                <div class="form-group">
                    <label class="req">Maximum Fare</label>
                    <input type="text" class="form-control no-spin" id="route_max_fare" maxlength="4">
                </div> 
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>
        <input type="hidden" id="code">
        <input type='hidden' id='rt_disable' value={$action_rights['ROTE-DISABLE']}>
        <input type='hidden' id='rt_edit' value={$action_rights['ROTE-EDIT']}>
        <input type='hidden' id='rt_del' value={$action_rights['ROTE-DELETE']}>

        <div id="ur-org-loading"></div>
        <div class="col-md-12 p_r_n">
            <div class="align-center alert alert-danger pull-left rt_err" id="usr-org-state"></div>
            <div class="align-right" id="form-org-bttons">
                <button type="button" id="btn-save" class="btn btn-success" onclick="saveNewRoute()">Save</button>
                <button type="button" class="btn btn-default" onclick="cancelRoute()">Cancel</button>
            </div>
        </div>

    </form>
</div>
<!--Organization dialog end-->   
<script>
    $('#route_min_fare, #route_max_fare').on('input', function(){
        this.value = this.value.replace(/\D/g, '');
    });
</script>