<div id="proof-gallery-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hideProofGallery();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="proof-gallery-panel" class="clearfix" style="padding: 10px 5px;">
        <div>
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#tab_pob" role="tab" data-toggle="tab">POB</a></li>
                <li role="presentation"><a href="#tab_pod" role="tab" data-toggle="tab">POD</a></li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="tab_pob">
                    <label class="proof-gallery-document"></label>
                    <div class="file-upload-gallery dialog-gallery"></div>
                    <label class="webcam-proof-gallery-document"></label>
                    <div class="file-webcam-upload-gallery"></div>
                </div>
                <div role="tabpanel" class="tab-pane" id="tab_pod">
                    <label class="proof-gallery-document"></label>
                    <div class="file-upload-gallery dialog-gallery"></div>
                    <label class="webcam-proof-gallery-document"></label>
                    <div class="file-webcam-upload-gallery"></div>
                </div>
            </div>
        </div>

        <div id="proof-gallery-alert"></div>
    </div>
</div> 

<div id="proof-document-dialog" style="display: none">
    <div class="clearfix">
        <b id="proof-document-title"></b>
    </div>
    <div id="proof-document-panel" class="clearfix" style="padding: 10px 5px;">
        <div class="row" style="overflow-y: auto;">
            <div class="col-md-4">
                <label for="proof-document-type" class="req">Document Type</label>
                <select id="proof-document-type" class="form-control">
                    {foreach key=code item=name from=$proof_document_type}
                        <option value="{$code}">{$name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-lg-4 p_l_n">
                <label for="proof-document-no">Document Number</label>
                <input type="text" class="form-control" id="proof-document-no" placeholder="Document Number" maxlength="25">
            </div>
            <div class="col-lg-4 p_l_n">
                <label for="proof-mobile-no">Mobile Number</label>
                <input type="text" class="form-control" id="proof-mobile-no" placeholder="Mobile Number" maxlength="10" inputmode="decimal" data-mask="inrcurrency" oninput="validateNumberInput(this, 10)">
            </div>
        
            <div>
                {include file="site/cargo/file-webcam-store-component.tpl" id="webcam-proof-fileupload" axis="horizontal"}
            </div>

            <div class="col-md-12">
                {include file="site/cargo/file-store-component.tpl" id="proof-fileupload" axis="horizontal"}
            </div>

            <div class="col-md-12">
                <div id="proof-document-action-state"></div>
            </div>

            <div class="col-md-12 text-right" id="proof-document-panel-btn">
                <input type="hidden" id="proof-document-category" value="">
                <button type="button" class="btn btn-success" onclick="saveProofDocument();">Upload</button>&nbsp;
                <button type="button" class="btn btn-default" id="proof-document-cancel" onclick="hideProofDialog();">Cancel</button>&nbsp;
            </div>
        </div>
    </div>
</div>  
<script>
    var adhaarValue = $('#proof-document-type option:selected').val();
    if (adhaarValue == 'ADHR') {
        $('#proof-document-no').attr('maxlength', '12');
    } else {
        $('#proof-document-no').attr('maxlength', '25');
    }

    $('#proof-document-type').on('change', function() {
        var selectedValue = $('#proof-document-type option:selected').val();
        if (selectedValue == 'ADHR') {
            $('#proof-document-no').attr('maxlength', '12');
        } else {
            $('#proof-document-no').attr('maxlength', '25');
        }
        $('#proof-document-no').val('').trigger('change');
    });
</script>