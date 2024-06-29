<div id="ep-print-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="closeEpPrintDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="ep-print-pannel" class="clearfix" style="padding: 10px 5px;">
        <div class="row">
            <div class="col-md-6">
                <span class="h5 bold">Connection : </span>
                <span class="badge" id="ep-connection-status"></span>
            </div>
            <div class="col-md-6 text-right">
                <button class="btn btn-info hide" data-toggle="tooltip" title="Launch EzeePrint Application" id="ep-launch-btn" href="#" onclick="launchEP();">
                    <i class="fa fa-external-link"></i> Launch
                </button> &nbsp;
                <button class="btn hide" id="ep-connect-btn" onclick="toggleEpConnection()">Connect</button>
            </div>
            <div class="clearfix"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="req">LR Printer</label>
                    <select class="form-control" id="ep-lr-printers" onchange="saveEpSettings()"></select>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="req">OGPL Printer</label>
                    <select class="form-control" id="ep-ogpl-printers" onchange="saveEpSettings()"></select>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="req">Label Printer</label>
                    <select class="form-control" id="ep-label-printers" onchange="saveEpSettings()"></select>
                </div>
            </div>
            <div class="col-md-12">
                <div class="alert hide" id="ep-action-state"></div>
            </div>
        </div>   
        <br> <br> 
        <div class="row">    
            <div class="col-md-6">
                <div class="form-group">
                    <label class="req">Enter a valid {lang('lr')} number</label>
                    <input type="text" class="form-control sdate" id="ep-print-lr" placeholder="{lang('lr')} Number" value="">
                </div>
            </div>
            <div class="col-md-2 p_l_n p_r_n">
                <div class="form-group">
                    <label>&nbsp;</label>
                    <button type="button" class="btn btn-success" onclick="epTestPrint();">Test Print</button>&nbsp;
                </div>
            </div>
        </div>
    </div>
</div>
