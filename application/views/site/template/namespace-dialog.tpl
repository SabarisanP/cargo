<!-- dialog -->


<div id="pro-dialog" class="dialog-content-page hidden noprint" >
    <form role="form" class="form-horizontal">
        <div class="form-group ">
            <label class="col-sm-2 control-label" for="e_code">Code<span class="required">*</span></label>
            <div class="col-sm-7 np-code">
                <input type="text" placeholder="Code" id="e_code" class="form-control">
            </div>
            <div class="pull-left">
                <a title=" Code should be in alphabet small letters" class="pull-left"><span class="fa fa-question-circle "></span></a>
            </div>
            <div class="col-sm-7 display-code">

            </div>
        </div>
        <div class="form-group" style="">
            <label class="col-sm-2 control-label" for="e_name">Name<span class="required">*</span></label>
            <div class="col-sm-7">
                <input type="text" placeholder="Name" id="e_name" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="e_pin">Pin<span class="required">*</span></label>
            <div class="col-sm-7">
                <input type="text" placeholder="Pin" id="e_pin" class="form-control">
            </div>
        </div>
    </form>

    <input type="hidden" id="flag"  > 
    <div class="pull-left"  id="nsp-action-loading" ></div>
    <div class="alert alert-danger pull-left" style="display: none" id="nsp-action-state"></div>
    <div class="align-right nsp-btn" id="nsp-form-bttons">
        <button class="btn btn-success" type="button" onclick="saveNamespace();">Save</button>
        <button class="btn btn-default" type="button" onclick="cancelProAddEdit();">Cancel</button>
    </div>
</div>

<!--dialog end -->