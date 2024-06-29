<table width="100%">
    <tr>
        <td  colspan="10" align="center"><span class="bold">Feed Back </td>
    </tr>
</table>
<div class="table-responsive" id="adv-report-grid">
    <table id="dt_adv_booking_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th >Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Comments</th>  
                <th>FeedBack Date</th>
                <th></th>
            </tr>
        </thead>
        <tbody class="body_table">              
            {foreach from=$reports item=row}
                <tr>
                    <td>{$row->name}</td>
                    <td>{$row->email}</td>
                    <td>{$row->mobile}</td>
                    <td class="cmt-{$row->code}">{$row->comments}</td>
                    <td class="no-wrap">{$row->feedbackDate}</td>
                    <td>
                        <button class="btn btn-success" onclick="replyCustomerFeedback('{$row->code}');"><i class="fa fa-reply"></i> Reply</button>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

<div class="text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportFeedbackReport()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print()"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>
    
<script id="reply-div" type="text/template">
    <div class="col reply-div">
        <textarea class="form-control reply-txt m-b-4 m-t-4" rows="5" cols="50" style="resize: vertical;"></textarea>
        <div class="form-inline">
            <select class="form-control col reply-tpl">
                <option value="">Select Template</option>
                <option value="TNK">Thank you</option>
                <option value="APO">Apologize</option>
            </select>
            <select class="form-control col reply-mode">
                <option value="">Select Reply Mode</option> 
                <option value="SMS">SMS</option> 
                <option value="MAIL">MAIL</option> 
            </select>
            <button class="btn btn-success save" onclick="sendFeedbackReply()"><i class="fa fa-paper-plane"></i> Send</button>
            <button class="btn btn-default clear" onclick="clearFeedbackReply()">Clear</button>
        </div>
    </div>
</script>
<script>
    var customerFeedbacks = {$reports|json_encode}
    function replyCustomerFeedback(code){
        $('#'+code+'-div').remove();
        $('.cmt-'+code).append($('#reply-div').html());
        $('.cmt-'+code+' .reply-div').attr('id',code+'-div');
        $('.cmt-'+code+' .reply-txt').attr('id',code);
        $('.cmt-'+code+' .reply-mode').attr('id',code+'-mode');
        $('.cmt-'+code+' .reply-tpl').attr('id',code+'-tpl').attr('onchange', "toggleMailTemplate('"+code+"')");
        $('.cmt-'+code+' .save').attr('onclick',"sendFeedbackReply('"+code+"')");
        $('.cmt-'+code+' .clear').attr('onclick',"clearFeedbackReply('"+code+"')");
    }
    
    function clearFeedbackReply(code){
        $('#'+code+'-div').remove();
    }
    
    function toggleMailTemplate(code){
        var value = $('#'+code+'-tpl').val();
        var content = '';
        if(value == 'TNK') {
            content = 'Thank You for your feedback. We value your feedback and comments to provide the best services to our customers. \n'+
                    'Looking forward for your next journey with us.';
        } else if(value == 'APO') {
            content = 'Apologies for your experience. We value your feedback and comments, we will look into the matter and make sure it is not repeated. \n'+
                    'Looking forward for your next journey with us.';
        }
        $('.cmt-'+code+' .reply-txt').val(content);
    }
    
    function sendFeedbackReply(code){
        var fbk = _.find(customerFeedbacks, function (o) {
            return o.code == code;
        });
        var data = {};
        var err = 0;
        data.refferencecode = code;
        data.content = $.trim($('#'+code).val());
        data.notificationmode = $.trim($('#'+code+'-mode').val());        
        if(data.notificationmode == 'SMS'){
            data.participantaddress = fbk.mobile;
        } else if(data.notificationmode == 'MAIL'){
            data.participantaddress = fbk.email;
        }
        
        if(data.content == ''){
            $('#'+code).addClass('inp_error');
            err++;
        }
        if(data.notificationmode == ''){
            $('#'+code+'-mode').addClass('inp_error');
            err++;
        }
        if(err > 0){
            return;
        }
        
        var loading_overlay = iosOverlay({
            text: "Sending...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "report/reply-customer-feedback",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        clearFeedbackReply(code);
                        return;
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
</script>