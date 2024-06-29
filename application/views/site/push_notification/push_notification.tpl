<div class="brand_top">
    <h3>Push Notification</h3>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12"> <br>
                <!-- PAGE HEADER-->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-12">
                                    <div class="">
                                        <div id="search-panel">
                                            <form id="push-noti-form" autocomplete="off" onsubmit="return false;">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="push-mobile">Mobile Number(s)</label>
                                                            <textarea class="form-control" id="push-mobile" placeholder="Mobile Numbers (comma seperated)" rows="20" style="resize: vertical;"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="push-title">Notification Title</label>
                                                            <input type="text" class="form-control" id="push-title" placeholder="Title" maxlength="50">
                                                            <span class="text-muted">Upto 50 charactors</span>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="push-content">Notification Content</label>
                                                            <textarea class="form-control" id="push-content" placeholder="Content" maxlength="120" rows="7" style="resize: vertical;"></textarea>
                                                            <span class="text-muted">Upto 120 charactors</span>
                                                        </div>
                                                        <div class="form-group" id="image-upload">
                                                            <a id="pickfiles" class="btn btn-info btn-sm"  href="javascript:;">Upload image</a>
                                                            <span id="filelist"></span>
                                                        </div>
                                                        <div class="align-center alert alert-danger pull-left" style="display:none;" id="push-noti-alert"></div>
                                                        <div class="clear_fix_both"></div><br/>
                                                        <button class="btn btn-success" type="submit" onclick="processPush();"> Send</button>
                                                        <button class="btn btn-default" type="reset" onclick="clearPush();"> Clear</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="push-noti-cont">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="push-noti-list">
                                    <div class="progress progress-striped">
                                        <div style="width:0%" role="progressbar" class="progress-bar" id="push-progress"></div>
                                    </div>
                                    <div class="pull-left">Sending to <span id="prog-mob"></span></div>
                                    <div class="pull-right">Remaining <span id="prog-rem"></span> of <span id="prog-tot"></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{literal}
<script>
    $('#push-title, #push-content').on('input', function(){
        //this.value = this.value.replace(/[^a-zA-Z\d\s:]/, '');
    });
    
    $('#push-mobile').on('input', function(){
        //this.value = this.value.replace(/[^\d\,]/, '').replace(/\,{2,}/g, ',');
    });
    
    function clearPush() {
        $('#push-title').val('');
        $('#push-content').val('');
        $('#push-mobile').val('');
        $('#push-noti-cont').addClass('hidden');
        $('.inp_error').removeClass('inp_error');
        $('#push-noti-alert').removeClass('alert-success').removeClass('alert-danger');
        $('#push-noti-alert').html('').hide();
        $('#push-progress').css({width: '0%'});
        $('#filelist').data('fileurl', '').html('');
    }
    
    function processPush() {
        var data = {};
        data.title = $('#push-title').val().trim();
        data.content = $('#push-content').val().trim();
        data.image = $('#filelist').data('fileurl');
        var mobileNo = $('#push-mobile').val().trim();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if (data.title === '') {
            $('#push-title').addClass('inp_error');
            err++;
        }
        if (data.content === '') {
            $('#push-content').addClass('inp_error');
            err++;
        }        
        if (mobileNo === '') {
            $('#push-mobile').addClass('inp_error');
            err++;
        }
        
        mobileNo = mobileNo.replace(/\s{1,}/g, '').replace(/\,{2,}/g, ',').replace(/(^,)|(,$)/g, '').split(',');
        $.each(mobileNo, function(i, mobile) {
            if(!/^\d{10}$/.test(mobile)){
                $('#push-mobile').addClass('inp_error');
                err++;
            }
        });

        if (err > 0) {
            $('#push-noti-alert').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#push-noti-alert').html('Please enter/select the values in the field that are marked in red');
            $('#push-noti-alert').show();
            return false;
        } else {
            $('#push-noti-alert').removeClass('alert-success').removeClass('alert-danger');
            $('#push-noti-alert').html('');
            $('#push-noti-alert').hide();
        }
        $('#push-noti-cont').removeClass('hidden');
        $('#push-progress').css({width: '0%'});
        $('#prog-tot').html(mobileNo.length);
        
        if(confirm('Do you want to send Notification?')) {
            sendPush(data, mobileNo);
        }
    }
    
    function sendPush(data, mobileNo, i = 0) {
        $('#prog-rem').html(mobileNo.length - i);
        if(i === mobileNo.length || location.hash !== '#push-notification') {
            $('#push-noti-cont').addClass('hidden');
            $('#push-noti-alert').addClass('alert-success').removeClass('alert-danger');
            $('#push-noti-alert').html('Sent Successfully');
            $('#push-noti-alert').show();
            return;
        }
        data.mobileNumber = mobileNo[i];
        $('#prog-mob').html(data.mobileNumber);
        
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'push-notification/send',
            data: data,
            success: function (res) {
                if(res.status === 1) {
                    var per = ((i+1)/mobileNo.length) * 100;
                    $('#push-progress').css({width: per + '%'});
                }
                sendPush(data, mobileNo, i+1);
            }
        });
    }

    var uploader = new plupload.Uploader({
        runtimes: 'html5',
        browse_button: 'pickfiles',
        container: document.getElementById('image-upload'), 
        url: base_url + 'push-notification/upload-image',
        resize: { width: 1038, height: 1038, quality: 100 },
        multi_selection: false,
        filters: {
            mime_types : [
                { title : 'Image files', extensions : 'jpg,png' }
            ],
            max_file_size: '3mb'
        },
        init: {
            PostInit: function () {
                document.getElementById('filelist').innerHTML = '';
            },
            FilesAdded: function (up, files) {
                $('#filelist').data('fileurl', '');
                plupload.each(files, function (file) {
                    document.getElementById('filelist').innerHTML = '<span id="' + file.id + '">&nbsp;' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></span>';
                });
                up.start();
            },
            FileUploaded: function (up, files, res) {
                var json = JSON.parse(res.response);
                $('#filelist').data('fileurl', json.fileurl || '');
            },
            UploadProgress: function (up, file) {
                document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
            },
            Error: function (up, err) {
                document.getElementById('console').appendChild(document.createTextNode("\nError #" + err.code + ": " + err.message));
            }
        }
    });
    uploader.init();
</script>
{/literal}