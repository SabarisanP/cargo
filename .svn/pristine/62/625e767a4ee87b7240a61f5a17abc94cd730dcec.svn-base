<style>
    .button {
        display: inline-block;
        background-color: #5cb85c; 
        color: #fff; 
        padding: 5px 10px;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.8.0/jszip.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.8.0/xlsx.js"></script>

<div class="brand_top">
    <h3>Import Consignments</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none"></div>
    <div class="text-right noprint"  align="right">
        <a id="link_1" href="#" class="button">Download Excel Basic Format</a>
        <a id="link_2" href="#" class="button">Download Excel Advance Format</a>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Import the consignment(s) received from other transport company.
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <label for="trns_rpt_date_from">1. Choose the Excel file</label>
                                    <div class="col-md-12">
                                        <form id='mytrans_form' name="trans_form" method="post" onsubmit="return false"
                                            enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="form-group col-md-3">
                                                    <div class="input-group">
                                                        <input type="file" name="upload_excel" class="form-control"
                                                            id="import_excel" placeholder="Browse a excel">
                                                        <span class="input-group-addon"><i
                                                                class="fa fa-upload"></i></span>
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-3">
                                                    <div class="input-group">
                                                        <button type="button" class="btn btn-default btn-clear"
                                                            onclick="clearImport()">Clear</button>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="align-center alert alert-danger pull-left"
                                                        style="display:none;" id="import_action_state"></div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row" id="booking-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <label>2. Vertify the consignment(s) to be imported.</label>

                                    <div class="col-md-12">
                                        <div id="excel-data-container">
                                            <div class="well well-lg">
                                                Upload a excel to pupulate the consignments available for import.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--content end-->
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_trans_downloader" id="ifrm_trans_downloader" style="display:none"></iframe>
{literal}
    <script>
        var ExcelToJSON = function() {

            this.parseExcel = function(file) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    var data = e.target.result;
                    var workbook = XLSX.read(data, {
                        type: 'binary'
                    });
                    workbook.SheetNames.forEach(function(sheetName) {
                        var XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[
                            sheetName]);
                        var json_object = JSON.stringify(XL_row_object);

                        //$('#excel-data-container').html(json_object);
                        var data = {};
                        data.rows = json_object;

                        $("#excel-data-container").html(
                            '<div class="alert alert-success">Populating excel data. Please wait...</div>'
                            );
                        $.ajax({
                            type: "POST",
                            dataType: 'html',
                            url: base_url + "import/process-excel-data",
                            data: data,
                            success: function(response) {
                                $('#excel-data-container').html(response);
                            }
                        });
                    })
                };

                reader.onerror = function(ex) {
                    console.log(ex);
                };

                reader.readAsBinaryString(file);
            };
        };

        $("#link_1").click(function (e) {
            e.preventDefault();
            window.location.href = "assets/excel/excel-format1.xlsx";
        });
        $("#link_2").click(function (e) {
            e.preventDefault();
            window.location.href = "assets/excel/excel-format2.xlsx";
        });

        function clearImport() {
            $('#import_excel').val("");
            $("#excel-data-container").html('<div class="well well-lg">Upload a excel to pupulate the consignments available for import.</div>');
        }

        function populateFromExcel(evt) {
            $('#import_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#import_action_state').html('');
            $('#import_action_state').hide();

            var files = evt.target.files;
            var fname = $('#import_excel').val();
            var re = /(\.xls|\.xlsx)$/i;
            if (!re.exec(fname)) {
                $('#import_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#import_action_state').html("Selected file format not supported. Please select excel file.");
                $('#import_action_state').show();
                return;
            }

            var xl2json = new ExcelToJSON();
            xl2json.parseExcel(files[0]);
        }
        document.getElementById('import_excel').addEventListener('change', populateFromExcel, false);

        function importLrs() {
            var err = 0;
            $('.inp_error').removeClass('inp_error');

            var data = {};
            data.importedlrs = [];
            data.allLrs = [];
            $('#excel-lr-table .excel-lr:checked').each(function() {
                var lrcode = $(this).val();
                data.allLrs.push({'code' : lrcode});
                var lrdata = _.find(excelLrs || [], i => i.v_lrno == lrcode);

                var from_station = $(this).closest('tr').find('select.imported-from-station option:selected').data(
                    'station');
                var from_branch = $(this).closest('tr').find('select.imported-from-station').val();
                var to_station = $(this).closest('tr').find('select.imported-to-station option:selected').data(
                    'station');
                var to_branch = $(this).closest('tr').find('select.imported-to-station').val();

                if (isNull(from_station) || isNull(from_station)) {
                    $(this).closest('tr').find('select.imported-from-station').addClass('inp_error');
                    err++;
                }

                if (isNull(to_station) || isNull(to_branch)) {
                    $(this).closest('tr').find('select.imported-to-station').addClass('inp_error');
                    err++;
                }

                lrdata.v_from_station = from_station;
                lrdata.v_from_branch = from_branch;
                lrdata.v_to_station = to_station;
                lrdata.v_to_branch = to_branch;

                if (isNotNull(from_station) && isNotNull(from_branch) && isNotNull(to_station) && isNotNull(
                        to_branch)) {
                    data.importedlrs.push(lrdata);
                }
            });

            if (err > 0) {
                $('#import-lr-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#import-lr-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#import-lr-action-state').show();
                return false;
            } else {
                $('#import-lr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#import-lr-action-state').hide();
            }

            if (data.importedlrs.length == 0) {
                $('#import-lr-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#import-lr-action-state').html('Please select atleast one LR');
                $('#import-lr-action-state').show();
                return false;
            } else {
                $('#import-lr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#import-lr-action-state').hide();
            }

            $('#import-lr-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#import-lr-action-state').html(loading_popup);
            $('#import-lr-action-state').show();
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "import/import-excel-lr",
                data: data,
                success: function(response) {
                    $.each(response || [], function(k, val) {
                        if (val.status == 1) {
                            $('.lr-code-' + val.lr).find('.lr-status').addClass('badge-success').text(
                                'Imported');
                            $('.lr-code-' + val.lr).find('.lr-status-message').removeClass('hide')
                                .attr('title', val.lr + ' imported successfully')
                                .tooltip('fixTitle');
                            $('.lr-code-' + val.lr).find('.excel-lr').addClass('hide');
                            $('.lr-code-' + val.lr).find(
                                'select.imported-from-station, select.imported-to-station').prop(
                                'disabled', true);

                            $('.lr-code-' + val.lr).find('.generated-lr').removeClass('hide')
                                .attr('onclick', 'getCargoDetails("' + val.generate_lr + '")')
                                .text(val.generate_lr);
                        } else {
                            $('.lr-code-' + val.lr).find('.lr-status').addClass('badge-danger').text(
                                'Failed');
                            $('.lr-code-' + val.lr).find('.lr-status-message').removeClass('hide')
                                .attr('title', val.message)
                                .tooltip('fixTitle');
                            $('.lr-code-' + val.lr).find('.excel-lr').removeClass('hide');
                            $('.lr-code-' + val.lr).find(
                                'select.imported-from-station, select.imported-to-station').prop(
                                'disabled', false);

                            $('.lr-code-' + val.lr).find('.generated-lr').addClass('hide')
                        }
                    });
                    $('#import-lr-action-state').removeClass('alert-danger').removeClass('alert-success');
                    $('#import-lr-action-state').html('').hide();
                }
            });
        }
    </script>
{/literal}