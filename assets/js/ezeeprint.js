const epStore = {
    config: null,
    labelConfig: null,
    localData: null
}

$(function () {
    var epSettings = localStorage.getItem('epSettings');
    epStore.localData = epSettings ? JSON.parse(epSettings) : {};

    ep.security.setCertificatePromise(function (resolve, reject) {

        //Alternate method 2 - direct
        resolve("-----BEGIN CERTIFICATE-----\n" +
            "MIIETzCCAzegAwIBAgIUfQ1xw6g7U6qNkP7Fgbqn2USiOuMwDQYJKoZIhvcNAQEL\n" +
            "BQAwgbUxCzAJBgNVBAYTAklOMRIwEAYDVQQIDAlUYW1pbG5hZHUxEDAOBgNVBAcM\n" +
            "B0NoZW5uYWkxKDAmBgNVBAoMH0V6ZWVJbmZvIENsb3VkIFNvbHV0aW9uIFB2dCBM\n" +
            "dGQxEzARBgNVBAsMCkNhcmdvIFRlYW0xEjAQBgNVBAMMCUV6ZWUgVGVjaDEtMCsG\n" +
            "CSqGSIb3DQEJARYecmFtYXNhbXlAZXplZWluZm9zb2x1dGlvbnMuY29tMCAXDTIx\n" +
            "MDcwMjAyMDQxNFoYDzIwNTIxMjI1MDIwNDE0WjCBtTELMAkGA1UEBhMCSU4xEjAQ\n" +
            "BgNVBAgMCVRhbWlsbmFkdTEQMA4GA1UEBwwHQ2hlbm5haTEoMCYGA1UECgwfRXpl\n" +
            "ZUluZm8gQ2xvdWQgU29sdXRpb24gUHZ0IEx0ZDETMBEGA1UECwwKQ2FyZ28gVGVh\n" +
            "bTESMBAGA1UEAwwJRXplZSBUZWNoMS0wKwYJKoZIhvcNAQkBFh5yYW1hc2FteUBl\n" +
            "emVlaW5mb3NvbHV0aW9ucy5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK\n" +
            "AoIBAQC8Fxfrev/LqmJxAlErtDn0LEmWDQa64fs4Q2y/tE/R0FeIxedB8rSdotrd\n" +
            "jxy1pXPNTOdd+fzdx1uzs75nU43toLS81MUkW2G27xs8Ta0zs4xy+z1FVNiG78dA\n" +
            "CQpYkqV2KYywI0qPpgA17ZhZXHrOUvZs07rHPm31I8GFBH1Rbk43cnSsYSLUUBR9\n" +
            "WqNTrcnJj8BTlsyJInRojcByj9DXXpZdg+/fdA/KTrT6KZtqEjzY7kmp6aSAHkLF\n" +
            "AoS6KtfTqfPXpBYSNsqm6qtQExoy0km7Q2/bcVBl0XPU6zK5hPca6aGmtPuYbVVt\n" +
            "4QGWPojDV1cYdxKZCrWHf7teUBZPAgMBAAGjUzBRMB0GA1UdDgQWBBTvLrc1qZrJ\n" +
            "bD/j6dVxxS2Y05aOlDAfBgNVHSMEGDAWgBTvLrc1qZrJbD/j6dVxxS2Y05aOlDAP\n" +
            "BgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQCebCvxBI+KFLHzDoqI\n" +
            "B1dF3UcwBljdjSCwExm2YuUUw94QfjMpzz1BSmFbH+w/a7308VslC7/DxWukdgdb\n" +
            "kO9emsKe/VyZh6StAYlmxG3OFh9J1GJsbk5WVb697FK2Zin56u7kPuwAqra2JmBC\n" +
            "oIj73lyLiGBro7UGLDv8TMJR9owuczl5Ko/59IWJk8AIK5RTI966c+hjW637vDC4\n" +
            "mB8jOxvUTZ+OkUTyn+aFdt3+fEDeqga0w6fyNc/Q/mKiqd/HEuLlqWyrw+Vu0PwO\n" +
            "61rxlFoxDBaByenWLUYEBrnA0AbP9dVqmx86gRm4amT9+4eWqSmIpBG2UoS7G4hq\n" +
            "sYLn\n" +
            "-----END CERTIFICATE-----");
    });

    if (epStore.localData.enabled) {
        $('#ep-navbar-status').show().find('.ep-print-status').addClass('btn-warning');
        epStore.config = ep.configs.create(epStore.localData.lr);
        epStore.labelConfig = ep.configs.create(epStore.localData.label);
        toggleEpConnection();
    }

    $('.ep-print-link').on('click', function () {
        var href = $(this).prop('href');
        if (!href || !ep.websocket.isActive()) {
            return;
        }
        epFetchAndPrint(href);
        return false;
    });
});

function showEpPrintDialog() {
    var $dialog = $('#ep-print-dialog');

    updateEpState();

    $dialog.dialog({
        autoOpen: true,
        height: 450,
        width: 500,
        modal: true,
        resizable: false
    });
}

function closeEpPrintDialog() {
    var $dialog = $('#ep-print-dialog');

    $dialog.dialog('destroy');
    $dialog.hide();
}

function updateEpState() {
    var $pannel = $('#ep-print-pannel');

    $pannel.find('#ep-action-state').addClass('hide');
    if (ep.websocket.isActive()) {
        $('#ep-navbar-status').show().find('.ep-print-status').removeClass('btn-warning btn-danger').addClass('btn-success');
        $pannel.find('#ep-connection-status').html('Active').removeClass('badge-danger').addClass('badge-success');
        $pannel.find('#ep-connect-btn').html('Disconnect').removeClass('hide btn-success').addClass('btn-danger');
        $pannel.find('#ep-lr-printers, #ep-ogpl-printers, #ep-label-printers').prop('disabled', false);
        $pannel.find('#ep-launch-btn').addClass('hide');
        findPrinters();
    } else {
        $('#ep-navbar-status').show().find('.ep-print-status').removeClass('btn-warning btn-success').addClass('btn-danger');
        $pannel.find('#ep-connection-status').html('Inactive').removeClass('badge-success').addClass('badge-danger');
        $pannel.find('#ep-connect-btn').html('Connect').removeClass('hide btn-danger').addClass('btn-success');
        $pannel.find('#ep-lr-printers, #ep-ogpl-printers, #ep-label-printers').prop('disabled', true);
        $pannel.find('#ep-launch-btn').removeClass('hide');
        // saveEpSettings();
    }
}

function toggleEpConnection() {
    if (ep.websocket.isActive()) {
        ep.websocket.disconnect().then(function () {
            updateEpState();
        }).catch(handleConnectionError);
        return;
    }

    ep.websocket.connect({ retries: 5, delay: 1 }).then(function () {
        updateEpState();
        findPrinters();
    });
}

function findPrinters() {
    ep.printers.find().then(function (data) {
        $('#ep-lr-printers, #ep-ogpl-printers, #ep-label-printers')
            .html(new Option('Select a Printer', ''))
            .append(data.map(printer => new Option(printer)))

        $('#ep-lr-printers').val(epStore.localData.lr || '');
        $('#ep-ogpl-printers').val(epStore.localData.ogpl || '');
        $('#ep-label-printers').val(epStore.localData.label || '');
    }).catch(handleConnectionError);
}

function handleConnectionError(err) {
    var $pannel = $('#ep-print-pannel');

    $pannel.find('#ep-connection-status').html('Error').removeClass('badge-success').addClass('badge-danger');
    $pannel.find('#ep-connect-btn').addClass('hide btn-success');

    if (err.target != undefined) {
        if (err.target.readyState >= 2) { //if CLOSING or CLOSED
            displayError("Connection to EP Tray was closed");
        } else {
            displayError("A connection error occurred, check log for details");
            console.error(err);
        }
    } else {
        displayError(err);
    }
}

function saveEpSettings() {
    var data = {};
    data.enabled = +ep.websocket.isActive();
    data.lr = $('#ep-lr-printers').val();
    data.ogpl = $('#ep-ogpl-printers').val();
    data.label = $('#ep-label-printers').val();

    epStore.config = ep.configs.create(data.lr);
    epStore.labelConfig = ep.configs.create(data.label);

    var json = JSON.stringify(data);
    epStore.localData = json;
    localStorage.setItem('epSettings', json);

    var alert = noty({
        layout: 'topRight',
        theme: 'tisa_theme',
        type: 'warning',
        text: 'Setting updated.',
        timeout: 2500
    });
}

function launchEP() {
    if (!ep.websocket.isActive()) {
        window.location.assign("ezeeprint:launch");
    }
}

function displayError(err) {
    $('#ep-print-pannel').find('#ep-action-state').removeClass('hide').addClass('alert-danger').html(err);
}

function epIsActive() {
    return ep.websocket.isActive();
}

function epPrintUrlCommands(url) {
    if (!url || !ep.websocket.isActive()) {
        var login_branch = ns_branchname ? ns_branchname : "";
        ga_track_event('Ezee Print Not Active', login_branch, '');
        return;
    }

    var alert = noty({
        layout: 'topRight',
        theme: 'tisa_theme',
        type: 'warning',
        text: 'Printing will be started once ready. Please wait...',
        timeout: 30000
    });

    $.ajax({
        type: "get",
        dataType: 'html',
        url: url,
        data: '',
        success: function (response) {
            epPrintCommands([ response ]);
            alert.close();
        }
    });
}

function epPrintUrlHtml(href, options = {}) {
    if (!ep.websocket.isActive()) {
        var login_branch = ns_branchname ? ns_branchname : "";
        ga_track_event('Ezee Print Not Active', login_branch, '');
        return false;
    }

    var alert = noty({
        layout: 'topRight',
        theme: 'tisa_theme',
        type: 'warning',
        text: 'Printing will be started once ready. Please wait...',
        timeout: 30000
    });

    $.ajax({
        type: "get",
        dataType: 'html',
        url: href,
        data: '',
        success: function (response) {
            epPrintHtml(response, options);
            alert.close();
        }
    });
    return true;
}

function epPrintHtml(html = '', options = {}) {
    var [receipt, token] = html.split('<!-- TOKEN -->');

    options.copies = options.copies || 1;
    for (var i = 0; i < options.copies; i++) {
        var data = [{
            type: 'pixel',
            format: 'html',
            flavor: 'plain',
            data: receipt
        }];
        ep.print(epStore.config, data).catch(handleConnectionError);
    }

    if (token) {
        var data = [{
            type: 'pixel',
            format: 'html',
            flavor: 'plain',
            data: token
        }];
        ep.print(epStore.config, data).catch(handleConnectionError);
    }

    ga_track_event('LR Print', 'Ezee Print Used', '');
}

function epPrintCommands(commandsList = [], printer) {
    var data = commandsList.map(command => [{ data: command }]);

    if (data.length == 0) {
        return;
    }

    var config = epStore.config;
    if (printer == 'LABEL') {
        config = epStore.labelConfig;
    }

    ep.print(config, data).catch(handleConnectionError);
    ga_track_event('LR Print', 'Ezee Print Used', '');
    if (printer == 'LABEL') {
        var login_branch = ns_branchname ? ns_branchname : "";
        ga_track_event('Label Print Used', login_branch, '');
    }
}

function epFetchAndPrint(url) {
    if (!url || !ep.websocket.isActive()) {
        return;
    }

    var alert = noty({
        layout: 'topRight',
        theme: 'tisa_theme',
        type: 'warning',
        text: 'Printing will be started once ready. Please wait...',
        timeout: 30000
    });

    fetch(url)
        .then(response => response.blob())
        .then(blob => {
            var reader = new FileReader();
            reader.onload = function () {
                epBase64Print(this.result)
                alert.close();
            };
            reader.readAsDataURL(blob);
        });
}

function epBase64Print(base64 = '') {
    var data = [{
        type: 'pixel',
        format: 'pdf',
        flavor: 'base64',
        data: base64.replace('data:application/pdf;base64,', '')
    }];
    ep.print(epStore.config, data).catch(handleConnectionError);
    ga_track_event('LR Print', 'Ezee Print Used', '');
}

function epTestPrint() {
    var lr = $('#ep-print-lr').val();
    if (lr != "") {
        epFetchAndPrint(base_url + 'cargo/print-cargo-summary?code=' + lr);
    }
}