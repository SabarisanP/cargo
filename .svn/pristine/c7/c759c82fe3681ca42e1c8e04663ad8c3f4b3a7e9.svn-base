
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
    }
    else {
        $(gridTableId).jqGrid({
            data: data,
            datatype: "local",

            rowNum: 30,
            rowList: [10, 20, 30],
            colNames: ['tripcode', 'Pnr Number', 'ticket Status', 'Travel Date', 'Booked by', 'Ticket date', 'Cancelled By', 'Cancelled Date', 'From Station', 'To station',
  'Seat Name', 'Fare', 'Cancellation Charge', 'Refund Amount'],
            colModel: [
                { name: 'tripcode', index: 'tripcode', width: 60, sorttype: "string" },
                { name: 'PnrNumber', index: 'PnrNumber', width: 80, sorttype: "string" , summaryType: 'count', summaryTpl: '<b>{0} Item(s)</b>'  },
                { name: 'ticketStatus', index: 'ticketStatus', width: 60, sorttype: "string" },
                { name: 'TravelDate', index: 'TravelDate', width: 90, sorttype: "date", formatter: "date" },
                { name: 'UserId', index: 'UserId', width: 50, editable: false },
                { name: 'ticketdate', index: 'ticketdate', width: 90, sorttype: "date", formatter: "date" },
                { name: 'CancelledBy', index: 'CancelledBy',  editable: false },
                { name: 'CancelledDate', index: 'CancelledDate', width: 90, sorttype: "date", formatter: "date" },
                { name: 'fromStation', index: 'fromStation', width: 70, editable: false },
                { name: 'tostation', index: 'tostation', width: 70, editable: false },
                { name: 'seatname', index: 'seatname', width: 70, editable: false },
                { name: 'fare', index: 'fare', width: 80, align: "right", sorttype: "float", formatter: "number", editable: false, summaryType: 'sum', summaryTpl: '<b>sum: {0}</b>' },
                { name: 'CancellationCharge', index: 'CancellationCharge', width: 80, align: "right", sorttype: "float", formatter: "number", editable: false, summaryType: 'sum', summaryTpl: '<b>sum: {0}</b>' },
                { name: 'RefundAmount', index: 'RefundAmount', width: 80, align: "right", sorttype: "float", formatter: "number", editable: false, summaryType: 'sum', summaryTpl: '<b>sum: {0}</b>' }

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
            userDataOnFooter: true,
            caption: caption
        });
    }
}

//var columnNames = new Array();
//var columnModels = new Array();


//function constructColNameAndColModel(gridMeta) {

//    var optionValue = "";
//    var selectionOption = "";
//    var frozn = false;
//    var fieldName = "";
//    var align;

//    jQuery.each(gridMeta, function (i, v) {
//        optionValue = "";

//        columnNames.push(v.name);  // for ColNames

//        selectionOption = v.DistColVal;
//        frozn = (i === 0) ? true : false;
//        fieldName = v.name;
//        if (fieldName !== null && fieldName != 'undefined') {
//            fieldName = fieldName.replace(/ /g, "_");
//        }
//        align = "left";
//        if (v.dataType == "NUMBER") {
//            align = "right";
//        }
//        columnModels.push({
//            name: fieldName,
//            index: fieldName,
//            align: align,
//            editable: true,
//            //// width: 100,
//            //editrules: { required: true },
//            //frozen: frozn
//        });
//    })

//}


