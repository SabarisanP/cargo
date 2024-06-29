<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-25 19:28:18
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\prebooking-request.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667accfa344482_90701940',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '966a7961239a1ac5084a1497274bac422201ba66' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\prebooking-request.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667accfa344482_90701940 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="brand_top">
    <h3>Prebooking Request</h3>
    <div class="text-right noprint">
        <div class="btn-group btn-group-sm" id="excl_cons" style="display:none">
            <button class="btn btn-default" onclick="exportPrebookingExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
        <a href="#prebooking/pre-booking" class="btn btn-success btn-sm" target="_blank">Pre Book</a>
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
                                    <div class="col-md-12">
                                        <div class="">
                                            <div id="search-panel">
                                                <form id="prebooking_request_rpt" method="post" name="prebooking_request_rpt" action="cargo/prebooking-request-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-3">
                                                            <label for="cons_rpt_date_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="cons_rpt_date_range" readonly placeholder="Today" value="<?php echo implode(' | ',array_filter(array(smarty_modifier_date_format($_smarty_tpl->tpl_vars['ffromDate']->value,'%d-%m-%Y'),smarty_modifier_date_format($_smarty_tpl->tpl_vars['ftoDate']->value,'%d-%m-%Y'))));?>
">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-ONBEHALF-BOOKING'] == 1) {?>
                                                            <div class="form-group col-md-2">
                                                                <label for="prebook-from-station">From Station</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="prebook-from-station" name="fromStationCode" class="form-control">
                                                                        <option value="NA" selected="">All Stations</option>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['station']->value['name'];?>
</option>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                    </select>
                                                                </div>
                                                            </div>

                                                            <div class="form-group col-md-2">
                                                                <label for="prebook-to-station">To Station</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="prebook-to-station" name="toStationCode" class="form-control">
                                                                        <option value="NA" selected="">All Stations</option>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['station']->value['name'];?>
</option>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                                                                                                                                        <?php }?>

                                                        <div class="form-group col-md-2">
                                                            <label for="prebook-status">Status</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="prebook-status" name="preBookStatus" class="form-control">
                                                                    <option value="NA" selected="">All</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['prebook_status']->value, 'status', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['status']->value) {
?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['status']->value;?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" id="fromDate" name="fromDate">
                                                                <input type="hidden" id="toDate" name="toDate">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button" onclick="getPrebookRequest();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearPrebookRequest();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="prebook-action-state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="prebook-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="prebook-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<div id="prebooking-status-dialog" style="display: none">
    <div class="clearfix">
        <a href="javascript:;" class="pull-right" onclick="hidePrebookingStatusDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div class="clearfix" style="padding: 10px 5px;">
        <form onsubmit="return false;">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label>Status</label>
                        <select id="prebooking-status" class="form-control">
                            <option value="ACPTD">Accepted</option>
                            <option value="CANCL">Cancelled</option>
                        </select>
                    </div>
                </div>
                
                <div class="col-md-12 text-right">
                    <input type="hidden" id="pre-booking-code" value="">
                    <div class="alert hide" id="pre-booking-status-action-state"></div>
                    <button type="submit" class="btn btn-success" onclick="updatePrebookingStatus();">Save</button>&nbsp;
                    <button type="button" class="btn btn-default" onclick="hidePrebookingStatusDialog();">Cancel</button>&nbsp;
                </div>
            </div>
        </form>
    </div>
</div>


    <?php echo '<script'; ?>
>
        $('#cons_rpt_date_range').daterangepicker({
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

        function getPrebookRequest() {
            $("#prebook-list").html("");
            var data = {};
            var daterange = $('#cons_rpt_date_range').data('daterangepicker');
            data.fromDate = daterange.startDate.format('DD-MM-YYYY');
            data.toDate = daterange.endDate.format('DD-MM-YYYY');
            data.fromStationCode = $("#prebook-from-station").val();
            data.toStationCode = $("#prebook-to-station").val();
            data.preBookStatus = $("#prebook-status").val();

            var err = 0;

            if (err > 0) {
                $("#prebook-action-state").removeClass("alert-success").addClass("alert-danger").removeClass("hide");
                $("#prebook-action-state").html("Please enter/select the values in the field that are marked in red");
                $("#prebook-action-state").show();
                return false;
            } else {
                $("#prebook-action-state").removeClass("alert-success").removeClass("alert-danger");
                $("#prebook-action-state").html("");
                $("#prebook-action-state").hide();
            }
            var html = "";
            $("#prebook-to-date").removeClass("inp_error");
            $("#prebook-list-container").removeClass("hidden");
            $("#prebook-list").html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: "html",
                url: base_url + "cargo/prebooking-request-list",
                data: data,
                success: function(response) {
                    $("#prebook-list").html(response);
                    $("#excl_cons").show();
                    $("html, body").animate({
                        scrollTop: $("#prebook-list-container").offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearPrebookRequest() {
            $('#cons_rpt_date_range').val('');
            $('#cons_rpt_date_range').data('daterangepicker').setStartDate({});
            $('#cons_rpt_date_range').data('daterangepicker').setEndDate({});
            $("#prebook-list-container").addClass("hidden");
            $("#prebook-list").html("");
            $(".inp_error").removeClass("inp_error");
            $("#prebook-action-state").removeClass("alert-success").removeClass("alert-danger");
            $("#prebook-action-state").html("");
            $("#prebook-action-state").hide();
            $("#prebook-from-station").val("NA");
            $("#prebook-to-station").val("NA");
            $("#prebook-status").val("NA");
            $("#excl_cons").hide();
        }

        function editPrebookingStatus(code) {
            $('#prebooking-status-dialog').removeClass('hide');
            $('#prebooking-status-dialog').dialog({
                autoOpen: true,
                height: 300,
                width: 400,
                modal: true,
                resizable: false
            });
            $(".ui-dialog-titlebar").hide();

            $('#pre-booking-status-action-state').removeClass('alert-success, alert-danger').html('').addClass('hide');
            $('#pre-booking-code').val('');

            if (_isdefined(code)) {
                $('#pre-booking-code').val(code);
            }
        }

        function hidePrebookingStatusDialog() {
            $('#prebooking-status-dialog').dialog('destroy');
            $('#prebooking-status-dialog').hide();
        }

        function updatePrebookingStatus() {
            data = {};
            data.preBookCode = $('#pre-booking-code').val();
            data.statusCode = $('#prebooking-status').val();
            
            $('#pre-booking-status-action-state').removeClass('hide').html(loading_popup);
            
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/update-prebooking-status',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#pre-booking-status-action-state').removeClass('alert-danger');
                        $('#pre-booking-status-action-state').addClass('alert-success');
                        $('#pre-booking-status-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function() {
                            hidePrebookingStatusDialog();
                            getPrebookRequest();
                            return;
                        }, 3000);
                    } else {
                        $('#pre-booking-status-action-state').addClass('alert-danger');
                        $('#pre-booking-status-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function exportPrebookingExcel() {
            var daterange = $('#cons_rpt_date_range').data('daterangepicker');
            var fromDate = daterange.startDate.format('DD-MM-YYYY');
            var toDate = daterange.endDate.format('DD-MM-YYYY');
            $('#fromDate').val(fromDate);
            $('#toDate').val(toDate);
            $("#export").val(1);
            document.prebooking_request_rpt.target = "ifrm_downloader";
            document.prebooking_request_rpt.submit();
            return;
        }
    <?php echo '</script'; ?>
>
<?php }
}
