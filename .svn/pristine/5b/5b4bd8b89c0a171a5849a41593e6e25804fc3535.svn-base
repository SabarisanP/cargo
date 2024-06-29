function GetTicketPdf() {
    document.ticket_print.target = "ifrm_downloader_ticket";
    $('#export').val(1);
    document.ticket_print.submit();
    return;
}

function PrintTicket(code) {
    var url = base_url + "search/print-sheet?pnrCode=" + code;    
    //window.open(url,'_blank');
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
}