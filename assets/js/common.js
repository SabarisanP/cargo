function exit( status ) {
    var i;
    if (typeof status === 'string') {
        alert(status);
    }

    window.addEventListener('error', function (e) {e.preventDefault();e.stopPropagation();}, false);

    var handlers = [
        'copy', 'cut', 'paste',
        'beforeunload', 'blur', 'change', 'click', 'contextmenu', 'dblclick', 'focus', 'keydown', 'keypress', 'keyup', 'mousedown', 'mousemove', 'mouseout', 'mouseover', 'mouseup', 'resize', 'scroll',
        'DOMNodeInserted', 'DOMNodeRemoved', 'DOMNodeRemovedFromDocument', 'DOMNodeInsertedIntoDocument', 'DOMAttrModified', 'DOMCharacterDataModified', 'DOMElementNameChanged', 'DOMAttributeNameChanged', 'DOMActivate', 'DOMFocusIn', 'DOMFocusOut', 'online', 'offline', 'textInput',
        'abort', 'close', 'dragdrop', 'load', 'paint', 'reset', 'select', 'submit', 'unload'
    ];

    function stopPropagation (e) {
        e.stopPropagation();
        // e.preventDefault(); // Stop for the form controls, etc., too?
    }
    for (i=0; i < handlers.length; i++) {
        window.addEventListener(handlers[i], function (e) {stopPropagation(e);}, true);
    }

    if (window.stop) {
        window.stop();
    }

    throw '';
}
// for debugging start
function lineWithArg(argName=null){
    var line='';
        if(argName!=null){
        line=`-----------------------------${argName}-------------------------------------`;
        }else{
        line=`-----------------------------------------------------------------------------`;
        }
    console.log(line);
}

function printJson(data,argName=null){
        lineWithArg(argName);
        console.log(JSON.stringify(data, null, 3));
}

function print_r(data,argName=null){
        lineWithArg(argName);
        console.log(data);
}
// for debugging end

//export Excel Function  ex: exportExcel('table_id_name', 'excel file name');
var exportExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,';
    var template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head>' +
        '<style>th{  color: #fff; padding: 10px; } thead{ background-color: #64b92a; }</style>' +
        '<!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>' +
        '<x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions>' +
        '</x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->' +
        '<meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table style="font-weight:500;" border="1px" cellpadding="0" cellspacing="0" >{table}</table></body></html>';

        return function (tableId, name) {
        var table = document.getElementById(tableId);
        if (!table) {
            return;
        }
        
        var blob = new Blob([template.replace('{worksheet}', name || 'Worksheet').replace('{table}', table.innerHTML)], {
            type: 'application/vnd.ms-excel'
        });
    
        var link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = name + '.xls';
        link.click();
    };
})();

var exportTables = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,';
    var template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head>' +
        '<style>' +
        'th { color: #fff; padding: 10px; } ' +
        'thead { background-color: #64b92a; } ' +
        'table { margin-bottom: 20px; } ' +
        'tr.header { background-color: #64b92a; color: #fff; text-align: center; font-weight: bold; } ' +
        '</style>' +
        '<!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>' +
        '<x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions>' +
        '</x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->' +
        '<meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body>{content}</body></html>';

    function base64(s) {
        return window.btoa(unescape(encodeURIComponent(s)));
    }

    return function (tables, name) {
        var content = '';

        tables.forEach(function (tableInfo) {
            var heading = tableInfo[0];
            var tableId = tableInfo[1];
            var table = document.querySelector(tableId);
            if (!table) return;

            // Get the number of columns in the table
            var colCount = table.rows[0].cells.length;

            // Add heading row with merged columns
            content += '<table border="1" cellpadding="0" cellspacing="0">';
            content += '<tr class="header"><td colspan="' + colCount + '">' + heading + '</td></tr>';
            content += table.innerHTML;
            content += '</table><br/>';
        });

        var html = template.replace('{worksheet}', name || 'Worksheet').replace('{content}', content);
        var blob = new Blob([html], { type: 'application/vnd.ms-excel' });
        
        var link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = name + '.xls';
        link.click();
    };
})();

// export function end

//Print Element Function 
function printTable(elm,name) {
    // console.log(elm);
    let element=$("#"+elm+"");
    element.css('border', '1px solid black');
    element.printThis({
                importCSS: true,
                importStyle: true,
                loadCSS: "assets/bootstrap/css/bootstrap.min.css",
                header: "<h1>"+name+"</h1>",
                beforePrintEvent:element.css('border', '1px solid black'),
                afterPrintEvent: element.css('border', '1px solid black')
            });
} //example :  printTable('table_id','file name')
//Print Element function end

//get intersection values in an array (for payment types task)
function findIntersection(array1, array2) {
    return array1.filter(obj1 =>
        array2.some(obj2 =>
        Object.keys(obj1).every(key =>
            obj2.hasOwnProperty(key) && obj1[key] === obj2[key]
        )
        )
    );
}


//show Success or error message in page
var alertMsg = (function () {
    function successMsg(className, message, title = '') {
        var targetElement = $('.' + className);
            var titleContent = title !=""?`<strong>${title}</strong>`:'<strong>Success !</strong>';
            var html = `<div class="alert alert-success alert-dismissible show" w-100 role="alert">
                             ${titleContent} ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>`;
            targetElement.html(html);
            if(alertClosingtime !=false){
                setTimeout(() => {
                    targetElement.html('');
                }, alertClosingtime);
            }
    }

    function errorMsg(className, message, title = '') {
        var targetElement = $('.' + className);
        var titleContent = title !=""?`<strong>${title}</strong>`:'<strong>Attention !</strong>';
            var html = `<div class="alert alert-danger alert-dismissible w-100 show" role="alert">
                           ${titleContent} ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>`;
            targetElement.html(html);
            if(alertClosingtime !=false){
                setTimeout(() => {
                    targetElement.html('');
                }, alertClosingtime);
            }
    }

    function hideMsg(className) {
        var targetElement = $('.' + className);
        targetElement.html('');
    }

    return {
        successMsg: successMsg,
        errorMsg: errorMsg,
        hideMsg: hideMsg
    };
})();

//btn blocking 
function btnBlock(element){
    $(element).attr('disabled',true);
    setInterval(() => {
        $(element).attr("disabled", false);
    },2000);
}

function getOdometter(vehicleCode, transitCode) {
    var data = {};
    data.loadedVehicle = vehicleCode;
    data.transitCode = transitCode;
    $.ajax({
      type: "POST",
      url: base_url + "transit/ogpl-odometer-comman",
      data: data,
      success: function (response) {
        $("#cargo-invoice-iframe").html(response);
        $("#cargo-invoice-pdf-dialog").css("background", "#fff");
        $("#cargo-invoice-pdf-dialog").removeClass("hide");
        $("#cargo-invoice-pdf-dialog").dialog({
          autoOpen: true,
          height: 700,
          width: 850,
          modal: true,
          resizable: false,
          closeOnEscape: false,
        });
        $("#start-trip-dialog").show();
        $("#start-trip-dialog .inp_error").removeClass("inp_error");
        $("#start-trip-action-state")
          .removeClass("alert alert-danger alert-success")
          .html("");
        $(
          "#start-trip-odo, #start-trip-hire-amount, #start-trip-advance-amount, #start-trip-adv-paymode, #start-trip-fuel-litres, #start-trip-fuel-rate, #start-trip-fuel-coupon"
        ).val("");
        $("#start-trip-supervisor, #start-trip-fuel-vendor, #start-trip-adv-payby")
          .val("")
          .trigger("change");
        $("#start-trip-fuel-payment-mode").val("CASH").trigger("change");
        $("#start-trip-hiring-amt").removeClass("hide");
        $("#allowLoad").val(true);

        $("#trip-start-date").html(moment().format("DD MMM YYYY"));
        $("#trip-start-time").html(moment().format("hh : mm A"));
        var vehicle = _.find(OGPLVehicles, (o) => o.code == loadedVehicle) || {};
        $(".last-odometer").html(vehicle.lastOdometer);
      },
  });
  return true;
}

function hideStartTripDialogs() {
  $("#start-trip-dialog").hide();
}
