<div class="brand_top">
    <h3>Profit and Loss</h3>
    <div class="text-right noprint" id="export-balance-sheet" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBalanchPdf();"><i class="fa fa-print fa-lg"></i> PDF</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
            <button class="btn btn-default" onclick="exportBalanceSheet();"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div> 
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
                                            <form id="balance_sheet_form" name="balance_sheet_form" method="post" onsubmit="return false">
                                            <div class="row">
                                                <div class="form-group col-md-3">
                                                    <label for="balance_sheet_range">Date Range</label>
                                                    <div class="input-group">
                                                        <input type="text" name="daterange" class="form-control sdate" id="balance_sheet_range" readonly placeholder="Date Range">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <input type="hidden" name="pdf" id="pdf" value="">
                                                            <button class="btn btn-success" type="button"  onclick="searchBalanceSheet()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBalanceSheet()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="balance_sheet_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="balance-sheet-list-container">
                    <br>
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="balance-sheet-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_balance_sheet" id="ifrm_balance_sheet" style="display:none"></iframe>

{literal}
    <script>
        $('#balance_sheet_range').daterangepicker({
            buttonClasses: ['btn', 'btn-xs'],
            format: 'DD-MM-YYYY',
            separator: ' | ',
            ranges: {
                'Today': [moment(), moment()],
                'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                'Last 30 Days': [moment().subtract(29, 'days'), moment()],
            },
        }).on('show.daterangepicker', function (ev, picker) {
            picker.showCalendars()
        });

        function searchBalanceSheet() {
            $('#balance-sheet-list').html('');
            var data = {};
            data.daterange = $('#balance_sheet_range').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.fromDate == '') {
                $('#balance_sheet_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#balance_sheet_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#balance_sheet_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#balance_sheet_state').html('Please enter/select the values in the field that are marked in red');
                $('#balance_sheet_state').show();
                return false;
            }
            
            $('#balance_sheet_state').removeClass('alert-success').removeClass('alert-danger');
            $('#balance_sheet_state').html('').hide();
            
            $('#balance-sheet-list-container').removeClass('hidden');
            $('#balance-sheet-list').html(loading_popup);
            
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'payment/profit-and-loss-list',
                data: data,
                success: function (response) {
                    $('#balance-sheet-list').html(response);
                    $('#export-balance-sheet').show();
                }
            });
        }

        function clearBalanceSheet() {
            $('#balance_sheet_from').val('');
            $('#balance_sheet_to').val('');
            $('#balance-sheet-list-container').addClass('hidden');
            $('#balance-sheet-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#balance_sheet_state').removeClass('alert-success').removeClass('alert-danger');
            $('#balance_sheet_state').html('');
            $('#balance_sheet_state').hide();
            $('#export-balance-sheet').hide();
        }

        function balanceSheet(code) {
            $('#balance-sheet-dialog .table-responsive').addClass('hide');
            if(code == 'VOU') {
                $('#VOU_INT, #VOU_PAID').removeClass('hide');
            } else if(code == 'INV') {
                $('#INV_INT, #INV_PAID').removeClass('hide');
            } else if(code == 'BRNCLS') {
                $('#BRNCLS').removeClass('hide');
            } else if(code == 'RECPT') {
                $('#RECPT').removeClass('hide');
            } else if(code == 'INCOME') {
                $('#INCOME').removeClass('hide');
            }
            $('#balance-sheet-dialog').css('background', '#fff');
            $('#balance-sheet-dialog').removeClass('hide');
            $('#balance-sheet-dialog').dialog({
                autoOpen: true,
                height: 475,
                width: 750,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });
            $('.ui-dialog-titlebar').hide();
        }

        function closeBalanceSheet() {
            $('#balance-sheet-dialog').addClass('hide');
            $('#balance-sheet-dialog').dialog('destroy');
        }

        function exportBalanceSheet() {
            $('#export').val('1');
            $('#pdf').val('');
            document.balance_sheet_form.action = 'payment/profit-and-loss-list';
            document.balance_sheet_form.target = 'ifrm_balance_sheet';
            document.balance_sheet_form.submit();
            return;
        }

        function exportBalanchPdf() {
            $('#export').val('');
            $('#pdf').val('1');
            document.balance_sheet_form.action = 'payment/profit-and-loss-list';
            document.balance_sheet_form.target = 'ifrm_balance_sheet';
            document.balance_sheet_form.submit();
            return;
        }
    </script>
{/literal}