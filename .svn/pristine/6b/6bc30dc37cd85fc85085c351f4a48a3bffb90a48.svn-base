<script src="{$base_url}assets/lib/qr-scanner/qr-scanner.umd.min.js?{$asset_ver}"></script>

<div class="clearfix">
    <a class="pull-right" href="javascript:;" title="click or press ESC to close" onclick="stopQRScanner();">
        <i class="fa fa-times-circle fa-2x"></i>
    </a>
</div>

<div class="video-preview">
    <video id="qr-scanner-video" height="350" width="100%"></video>
    <span id="camera-status" class="camera-status hide"></span>
</div>

<div>
    <a href="javascript:;"><label class="point_cur" for="qr-scanner-file">or scan from image</label></a>
    <input type="file" id="qr-scanner-file" class="hide" accept="image/png,image/jpeg" >
</div>

<script>
    QrScanner.WORKER_PATH = '{$base_url}assets/lib/qr-scanner/qr-scanner-worker.min.js?{$asset_ver}';

    const videoElem = document.querySelector('#qr-scanner-video');
    const fileSelector = document.querySelector('#qr-scanner-file');

    const qrScanner = new QrScanner(videoElem, scanOnSuccess);
    let hasCamera;

    QrScanner.hasCamera().then(function(bool) {
        $('#camera-status').html('Camera not deducted').toggleClass('hide', bool);
        // $('body').attr('data-hascamera', bool);
        hasCamera = bool;
    });

    function startQRScanner() {
        if (hasCamera === false) {
            return;
        }
        resetScanStatus();
        qrScanner.start();
    }

    function stopQRScanner() {
        qrScanner.stop();
        hideScanQRDialog();
    }

    function scanOnSuccess(result) {
        $(document).trigger('custom:qr-scanned', { result: result });
        stopQRScanner();
    }

    function scanOnFail(error) {
        $('#camera-status').html(error).removeClass('hide');
    }

    function resetScanStatus() {
        $('#camera-status').html('').addClass('hide');
    }

    fileSelector.addEventListener('change', function(event) {
        resetScanStatus();
        const file = fileSelector.files[0];
        if (!file) {
            return;
        }
        QrScanner.scanImage(file)
            .then(scanOnSuccess)
            .catch(scanOnFail);
    });
</script>
