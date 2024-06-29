<script type="text/javascript" src="{$base_url}assets/lib/webcamjs/webcam.min.js?{$asset_ver}"></script>
<script type="text/javascript" src="{$base_url}assets/lib/webcamjs/webcam.js?{$asset_ver}"></script>

<div class="col-md-12 mt-10">
    <button class="btn btn-primary" id="delOpenButton" onclick="delOpenWebcam();">Open Webcam</button>
    <button class="btn btn-secondary" id="delCloseButton" onclick="delCloseWebcam()">Close Webcam</button>
    <button class="btn btn-success" id="delTakeSnapshot" onclick="del_take_snapshot()">Take snapshot</button>
    <button class="btn btn-danger" id="delClearSnapshot" onclick="del_clear_snapshot()">Clear snapshot</button>
    <div id="del_my_camera" style="margin-top: 3px;margin-bottom: 3px;"></div>
</div>

<div class="col-md-12" style="max-height: 100px;overflow-y: auto;">
    <div id="del_captured_image" ></div>
</div>

<script>
    Webcam.set({
        width: 200,
        height: 140,
        image_format: 'jpeg',
        jpeg_quality: 90
    });

    function delOpenWebcam() {
        Webcam.attach('#del_my_camera');
        $('#delOpenButton').prop('disabled', true);
        $('#delCloseButton').prop('disabled', false);
        $('#delTakeSnapshot').prop('disabled', false);
    }

    function delCloseWebcam() {
        Webcam.reset();
        $('#delOpenButton').prop('disabled', false);
        $('#delCloseButton').prop('disabled', true);
        $('#delTakeSnapshot').prop('disabled', true);
        $('#del_my_camera').removeAttr("style");
    }

    function del_clear_snapshot() {
        $('#del_captured_image').html('');
    }

    function del_take_snapshot() {
        Webcam.snap(function(data_uri) {
            $('#del_captured_image').append("<img style='width: 33%;' src='"+data_uri+"'/>");
        });
    }
</script>