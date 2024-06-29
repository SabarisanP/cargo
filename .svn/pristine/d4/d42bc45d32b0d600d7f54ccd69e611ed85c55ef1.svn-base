
function RenderGrid(data, caption, groupName, gridTableId) {
    $(gridTableId).jqGrid({
        data: data,
        datatype: "local",

        rowNum: 30,
        rowList: [10, 20, 30],
       // colNames: ['tripcode', 'Pnr Number', 'ticket Status', 'Travel Date', 'Booked by', 'Ticket date', 'Cancelled By', 'Cancelled Date', 'From Station', 'To station',
 // 'Seat Name', 'Fare', 'Cancellation Charge', 'Refund Amount'],
        colNames: ['Transaction Date', 'Transaction Type', 'Reference', 'Name', 'Mobile', 'SeatNbrs', 'fromstation','tostation', 'Travel Time', 'Fare', 'Commission Amount',
  'Cancel Charges', 'Current Balance', 'transactionMonth'],
        colModel: [
                { name: 'transactionDate', index: 'transactionDate', width: 90, sorttype: "date", formatter: "date" },
                { name: 'transactionType', index: 'transactiontype', editable: false, sorttype: "string" },
                { name: 'PnrNumber', index: 'PnrNumber', width: 80, sorttype: "string" },
                { name: 'seatName', index: 'seatName', width: 70, editable: false, sorttype: "string" },
                { name: 'Mobile', index: 'Mobile', width: 70, editable: false, sorttype: "string" },
                { name: 'seatCount', index: 'seatCount', width: 70, editable: false, sorttype: "string" },
                { name: 'fromStation', index: 'fromstation', width: 70, editable: false, sorttype: "string" },
                { name: 'tostation', index: 'tostation', width: 70, editable: false, sorttype: "string" },
               // { name: 'fromto', index: 'fromto', width: 70, editable: false },
                {name: 'Traveltime', index: 'Traveltime', width: 90, sorttype: "date", formatter: "date" },
                { name: 'fare', index: 'fare', width: 80, align: "right", sorttype: "float", formatter: "number", editable: false, summaryType: 'sum', summaryTpl: '<b>{0}</b>' },
                { name: 'commissionAmt', index: 'commissionAmt', width: 70, editable: false, sorttype: "float", formatter: "number", editable: false, summaryType: 'sum', summaryTpl: '<b>{0}</b>' },
                { name: 'CancellationCharge', index: 'CancellationCharge', width: 70, editable: false, sorttype: "float", formatter: "number", editable: false, summaryType: 'sum', summaryTpl: '<b>{0}</b>' },
            //    { name: 'credit', index: 'credit', width: 70, editable: false },
            //   { name: 'debit', index: 'debit', width: 70, editable: false },
                {name: 'BalanceAmt', index: 'BalanceAmt', width: 70, editable: false },
                { name: 'transactionMonth', index: 'transactionMonth', width: 10, editable: false ,  sorttype: "string"},
               
            ],
        pager: "#pager",
        shrinkToFit: false,
        viewrecords: true,
        toppager: true,
        sortname: 'transactionDate',
        grouping: true,
        groupingView: {
            groupField: ['transactionMonth','transactionDate']  , 
            groupSummary: [true, true],
            groupColumnShow: [true, true],
            groupText: ['<b>{0}</b>'],
            groupCollapse: false,
            groupOrder: ['asc', 'asc']
        },
        footerrow: true,
        gridComplete: function () {

            var canChargeTotal = $(this).jqGrid('getCol', 'CancellationCharge', false, 'sum');
            var commissionTotal = $(this).jqGrid('getCol', 'commissionAmt', false, 'sum');
            var amout = $(this).jqGrid('getCol', 'fare', false, 'sum');

            $(this).jqGrid('footerData', 'set', { CancellationCharge: canChargeTotal });
            $(this).jqGrid('footerData', 'set', { commissionAmt: commissionTotal });
            $(this).jqGrid('footerData', 'set', { fare: amout });
        }

    });


    $(gridTableId).jqGrid('navGrid', '#pager', {
        search: true,
        searchtext: "Search",  //  Make the Search icon have a "Search" label next to it
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
    onClickButton: function () {
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

