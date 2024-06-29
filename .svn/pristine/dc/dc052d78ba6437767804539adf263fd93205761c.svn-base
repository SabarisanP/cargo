function RenderGrid(data, colModel, colNames, caption, groupName, gridTableId) {
    if (groupName == "") {
        $(gridTableId).jqGrid({
            data: JSON.stringify(data),
            datatype: "local",
            height: 'auto',
            rowNum: 30,
            rowList: [10, 20, 30],
            colNames: colNames,
            colModel: colModel,
            pager: "#pager",
            viewrecords: true,
            shrinkToFit: true,
            caption: caption
        });
    } else {
        $(gridTableId).jqGrid({
            data: data,
            autowidth: true,
            height:400,
            datatype: "local",
            rowNum: 30,
            rowList: [10, 20, 30, 50, 100],
            colNames: ['tripcode', 'Pnr Number', 'ticket Status', 'Travel Date', 'Booked by', 'Ticket date', 'Cancelled By', 'Cancelled Date', 'From Station', 'To station',
                'Seat Name', 'Fare', 'Cancellation Charge', 'Refund Amount'],
            colModel: [
                {name: 'tripcode', index: 'tripcode', width: 60, sorttype: "string"},
                {name: 'PnrNumber', index: 'PnrNumber', width: 80, sorttype: "string", summaryType: 'count', summaryTpl: '<b>{0} Item(s)</b>'},
                {name: 'ticketStatus', index: 'ticketStatus', width: '100%', sorttype: "string"},
                {name: 'TravelDate', index: 'TravelDate', width: 90, sorttype: "date", formatter: "date"},
                {name: 'UserId', index: 'UserId', width: 50, editable: false},
                {name: 'ticketdate', index: 'ticketdate', width: 90, sorttype: "date", formatter: "date"},
                {name: 'CancelledBy', index: 'CancelledBy', editable: false},
                {name: 'CancelledDate', index: 'CancelledDate', width: 90, sorttype: "date", formatter: "date"},
                {name: 'fromStation', index: 'fromStation', width: 70, editable: false},
                {name: 'tostation', index: 'tostation', width: 70, editable: false},
                {name: 'seatname', index: 'seatname', width: 70, editable: false},
                {name: 'fare', index: 'fare', width: 80, align: "right", sorttype: "float", formatter: "number", editable: false, summaryType: 'avg', summaryTpl: '<b>{0}</b>'},
                {name: 'CancellationCharge', index: 'CancellationCharge', width: 80, align: "right", sorttype: "float", formatter: "number", editable: false, summaryType: 'sum', summaryTpl: '<b>{0}</b>'},
                {name: 'RefundAmount', index: 'RefundAmount', width: 80, align: "right", sorttype: "float", formatter: "number", editable: false, summaryType: 'sum', summaryTpl: '<b>{0}</b>'}

            ],
            pager: "#pager",
            shrinkToFit: false,
            viewrecords: true,
            toppager: true,
            // sortname: groupName,
            grouping: true,
            groupingView: {
                groupField: groupName,
                groupSummary: [true],
                groupColumnShow: [true],
                groupText: ['<b>{0}</b>'],
                groupCollapse: false,
                groupOrder: ['asc']
            },
            footerrow: true,
            gridComplete: function() {
                var canChargeTotal = $(this).jqGrid('getCol', 'CancellationCharge', false, 'sum');
                var refundTotal = $(this).jqGrid('getCol', 'RefundAmount', false, 'sum');

                $(this).jqGrid('footerData', 'set', {CancellationCharge: canChargeTotal});
                $(this).jqGrid('footerData', 'set', {RefundAmount: refundTotal});
            }

        });
    }

    $(gridTableId).jqGrid('navGrid', '#pager', {
        search: true,
        searchtext: "Search", //  Make the Search icon have a "Search" label next to it
        edit: false,
        add: false,
        del: false,
        refresh: false
    },
    {}, // default settings for edit
            {}, // default settings for add
            {}, // delete
            {
                closeOnEscape: true, closeAfterSearch: true, ignoreCase: true, multipleSearch: false, multipleGroup: false, showQuery: false,
                sopt: ['cn', 'eq', 'ne'],
                defaultSearch: 'cn'
            }).navButtonAdd('#pager', {
        caption: "Export to Excel",
        buttonicon: "ui-icon-disk",
        onClickButton: function() {
            exportGrid(gridTableId);
        },
        position: "last"
    });

}

function exportGrid(tableId) {
    mya = $(tableId).getDataIDs(); // Get All IDs
    var data = $(tableId).getRowData(mya[0]); // Get First row to get the
    // labels
    var colNames = new Array();
    var ii = 0;
    for (var i in data) {
    colNames[ii++] = i;
    } // capture col names

    var html = "<html><head>"
        + "<style script=&quot;css/text&quot;>"
        + "table.tableList_1 th {border:1px solid black; text-align:center; "
        + "vertical-align: middle; padding:5px;}"
        + "table.tableList_1 td {border:1px solid black; text-align: left; vertical-align: top; padding:5px;}"
        + "</style>"
        + "</head>"
        + "<body style=&quot;page:land;&quot;>";


    for (var k = 0; k < colNames.length; k++) {
    html = html + "<th>" + colNames[k] + "</th>";
    }
    html = html + "</tr>"; // Output header with end of line
    for (i = 0; i < mya.length; i++) {
    html = html + "<tr>";
    data = $(tableId).getRowData(mya[i]); // get each row
    for (var j = 0; j < colNames.length; j++) {
        html = html + "<td>" + data[colNames[j]] + "</td>"; // output each Row as
        // tab delimited
    }
    html = html + "</tr>"; // output each row with end of line
    }
    html = html + "</table></body></html>"; // end of line at the end
    alert(html);
    html = html.replace(/'/g, '&apos;');
    var form = "<form name='pdfexportform' action='generategrid' method='post'>";
    form = form + "<input type='hidden' name='pdfBuffer' value='" + html + "'>";
    form = form + "</form><script>document.pdfexportform.submit();</sc"
        + "ript>";
    OpenWindow = window.open('', '');
    OpenWindow.document.write(form);
    OpenWindow.document.close();
}

