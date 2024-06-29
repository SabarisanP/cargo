<script type="text/javascript" src="{$base_url}assets/lib/webcamjs/webcam.min.js?{$asset_ver}"></script>
<script type="text/javascript" src="{$base_url}assets/lib/webcamjs/webcam.js?{$asset_ver}"></script>

<div class="col-md-12 mt-10">
    <button class="btn btn-primary" id="openButton" onclick="openWebcam();">Open Webcam</button>
    <button class="btn btn-secondary" id="closeButton" onclick="closeWebcam()">Close Webcam</button>
    <button class="btn btn-success" id="takeSnapshot" onclick="take_snapshot()">Take snapshot</button>
    <button class="btn btn-danger" id="clearSnapshot" onclick="clear_snapshot()">Clear snapshot</button>
    <div id="my_camera" style="margin-top: 3px;margin-bottom: 3px;"></div>
</div>

<div class="col-md-12" style="max-height: 100px;overflow-y: auto;">
    <div id="captured_image" ></div>
</div>

<script>
    Webcam.set({
        width: 200,
        height: 140,
        image_format: 'jpeg',
        jpeg_quality: 90
    });

    function openWebcam() {
        Webcam.attach('#my_camera');
        $('#openButton').prop('disabled', true);
        $('#closeButton').prop('disabled', false);
        $('#takeSnapshot').prop('disabled', false);
    }

    function closeWebcam() {
        Webcam.reset();
        $('#openButton').prop('disabled', false);
        $('#closeButton').prop('disabled', true);
        $('#takeSnapshot').prop('disabled', true);
        $('#my_camera').removeAttr("style");
    }

    function clear_snapshot() {
        $('#captured_image').html('');
    }

    function take_snapshot() {
        Webcam.snap(function(data_uri) {
            $('#captured_image').append("<img style='width: 33%;' src='"+data_uri+"'/>");
        });
    }
</script>