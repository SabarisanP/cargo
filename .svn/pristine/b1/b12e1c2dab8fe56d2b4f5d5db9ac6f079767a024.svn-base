<div class="brand_top">
    <h3>Add-on Transaction Report</h3>
    <div class="text-right noprint hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportAddonExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                    <div class="col-md-12">
                                        <div class="">
                                            <div id="search-panel">
                                                <form id="addon_rpt_form" method="post" name="addon_rpt_form" action="report/addon-transaction-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="addon_date_from">From Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="from_date" class="form-control sdate" id="addon_date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="addon_date_to">To Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="to_date" class="form-control sdate" id="addon_date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="row">

                                                        <div class="form-group col-md-2">
                                                            <label for="addon_date_opt">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="addon_date_opt" name="date_option" class="form-control" >
                                                                    <option value="0">Transaction Date</option>
                                                                    <option value="1">Travel Date</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">Add-on Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="addon_addon_type" name="addon_type" class="form-control" >
                                                                    <option value="">Select Type</option>
                                                                    {foreach from=$addons_type item=name key=code}
                                                                    <option value="{$code}">{$name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-3">
                                                            <label for="">&nbsp;</label>
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button"  onclick="generateAddonTransactionReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearAddonTransactionReport();">Clear</button>
                                                        </div>
                                                    </div>
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="addon-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden noprint" id="addon-usage-list-graph">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-sm-4">
                                        <div class="bold" align="center">Groups</div>
                                        <div id="addon-usage-graph-group"  style="height:250px;"></div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="bold" align="center">Add-on Type</div>
                                        <div id="addon-usage-graph-type"  style="height:250px;"></div>
                                    </div>
                                    <div class="col-sm-4" align="center">
                                        <div class="bold">Routes</div>
                                        <div id="addon-usage-graph-route"  style="height:250px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="addon-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="addon-report-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe>

{literal}
    <script>

        function exportAddonExcel() {
            document.addon_rpt_form.target = "irm_downloader";
            $('#export').val(1);
            document.addon_rpt_form.submit();
            return;
        }

        $('#addon_date_from').datepicker({
            format: 'yyyy-mm-dd',
            startDate: '-3m',
            endDate: "+3m",
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#addon_date_to').datepicker('setStartDate', e.date);
            $("#addon_date_to").datepicker("setEndDate", end)
        });

        $('#addon_date_to').datepicker({
            startDate: '-3m',
            endDate: "+3m",
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#addon_date_from').datepicker('setStartDate', start);
            $('#addon_date_from').datepicker('setEndDate', e.date)
        });

        function generateAddonTransactionReport() {
            $('#addon-report-list').html('');
            var data = {};
            data.date_option = $('#addon_date_opt').val();
            data.from_date = $('#addon_date_from').val();
            data.to_date = $('#addon_date_to').val();
            data.addon_type = $('#addon_addon_type').val();

            var err = 0;

            if (data.from_date == '') {
                $('#addon_date_from').addClass('inp_error');
                err++;
            } else {
                $('#addon_date_from').removeClass('inp_error');
            }

            if (data.addon_type == '') {
                $('#addon_addon_type').addClass('inp_error');
                err++;
            } else {
                $('#addon_addon_type').removeClass('inp_error');
            }

            if (data.from_date != '') {
                if (data.to_date == '') {
                    $('#addon_date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to_date = output;
                    $('#addon_date_to').val(output);
                }
            }


            if (err > 0) {
                $('#addon-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#addon-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#addon-action-state').show();
                return false;
            } else {
                $('#addon-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#addon-action-state').html('');
                $('#addon-action-state').hide();

                $('#addon-usage-list-graph').addClass('hidden');
                $('#addon-usage-graph-group').html('');
                $('#addon-usage-graph-route').html('');
                $('#addon-usage-graph-type').html('');
            }

            $('#addon_date_to').removeClass('inp_error');
            $('#addon-report-list-container').removeClass('hidden');
            $('#addon-report-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/addon-transaction-report-list",
                data: data,
                success: function (response) {
                    $('#addon-report-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');

                    $("html, body").animate({
                        scrollTop: $('#addon-usage-list-graph').offset().top - 35
                    }, "slow");
                    if(ticket_count>0) {
                        $('#addon-usage-list-graph').removeClass('hidden');
                        initDiscountGraphs();
                    }
                }
            });
        }

        function initDiscountGraphs() {
            if(_isdefined( addonmeta ) ) {
                groupItems = [];
                $.each(addonmeta.group, function(name, count) {
                    var ti = [name,count.discount];
                    groupItems.push(ti);
                });

                $('#addon-usage-graph-group').highcharts({
                   chart:{
                       type:"pie",
                       renderTo:"",
                       options3d:{
                           enabled:"1", alpha:45
                       }
                   },
                   title:{text:""},
                   xAxis:{categories:[]},
                   yAxis:{
                       stackLabels:{
                           enabled:false
                       },min:0
                   },
                   tooltip:{
                       shared:false,
                       useHTML:true,
                       headerFormat:"<b>{point.key}</b><table>",
                       pointFormat:" : Rs {point.y}",
                       footerFormat:"</table>",
                       percentageDecimals:1
                   },
                   series:[{
                           name:'',
                           data:groupItems
                       }
                   ],
                   credits:{enabled:false},
                   legend:{enabled:true},
                   exporting:{enabled:false},
                   tooltipPie:{
                        pointFormat:"<b>{point.percentage}%</b>",
                        percentageDecimals:1
                    },
                    colors:["#FF6040","#A05030","#D0B090","#6600FF","#64E572","#FF9655","#FFF263","#6AF9C4"],
                    export:"",
                    plotOptions:{
                       pie:{
                           allowPointSelect:true,
                           cursor:"pointer",
                           dataLabels:{
                               enabled:false,
                               formatter:function () {return '<b>'+ this.point.name+'</b> : '+ Math.round(this.percentage) +' %';},
                               showInLegend:true,
                               percentageDecimals:1,
                               valueDecimals:2
                           },
                           showInLegend:true,
                           innerSize:"",
                           depth:""
                       }
                   }
                });

                //  discount type
                typeItems = [];
                $.each(addonmeta.type, function(name, count) {
                    var ti = [name,count.discount];
                    typeItems.push(ti);
                });

                $('#addon-usage-graph-type').highcharts({
                   chart:{
                       type:"pie",
                       renderTo:"",
                       options3d:{
                           enabled:"1", alpha:45
                       }
                   },
                   title:{text:""},
                   xAxis:{categories:[]},
                   yAxis:{
                       stackLabels:{
                           enabled:false
                       },min:0
                   },
                   tooltip:{
                       shared:false,
                       useHTML:true,
                       headerFormat:"<b>{point.key}</b><table>",
                       pointFormat:" : Rs {point.y}",
                       footerFormat:"</table>",
                       percentageDecimals:1
                   },
                   series:[{
                           name:'',
                           data:typeItems
                       }
                   ],
                   credits:{enabled:false},
                   legend:{enabled:true},
                   exporting:{enabled:false},
                   tooltipPie:{
                        pointFormat:"<b>{point.percentage}%</b>",
                        percentageDecimals:1
                    },
                    colors:["#FF6040","#A05030","#D0B090","#6600FF","#64E572","#FF9655","#FFF263","#6AF9C4"],
                    export:"",
                    plotOptions:{
                       pie:{
                           allowPointSelect:true,
                           cursor:"pointer",
                           dataLabels:{
                               enabled:false,
                               formatter:function () {return '<b>'+ this.point.name+'</b> : '+ Math.round(this.percentage) +' %';},
                               showInLegend:true,
                               percentageDecimals:1,
                               valueDecimals:2
                           },
                           showInLegend:true,
                           innerSize:"",
                           depth:""
                       }
                   }
                });

                //  route type
                routeItems = [];
                $.each(addonmeta.route, function(name, count) {
                    var ti = [name,count.discount];
                    routeItems.push(ti);
                });

                $('#addon-usage-graph-route').highcharts({
                   chart:{
                       type:"pie",
                       renderTo:"",
                       options3d:{
                           enabled:"1", alpha:45
                       }
                   },
                   title:{text:""},
                   xAxis:{categories:[]},
                   yAxis:{
                       stackLabels:{
                           enabled:false
                       },min:0
                   },
                   tooltip:{
                       shared:false,
                       useHTML:true,
                       headerFormat:"<b>{point.key}</b><table>",
                       pointFormat:" : Rs {point.y}",
                       footerFormat:"</table>",
                       percentageDecimals:1
                   },
                   series:[{
                           name:'',
                           data:routeItems
                       }
                   ],
                   credits:{enabled:false},
                   legend:{enabled:false},
                   exporting:{enabled:false},
                   tooltipPie:{
                        pointFormat:"<b>{point.percentage}%</b>",
                        percentageDecimals:1
                    },
                    colors:["#FF6040","#A05030","#D0B090","#6600FF","#64E572","#FF9655","#FFF263","#6AF9C4"],
                    export:"",
                    plotOptions:{
                       pie:{
                           allowPointSelect:true,
                           cursor:"pointer",
                           dataLabels:{
                               enabled:false,
                               formatter:function () {return '<b>'+ this.point.name+'</b> : '+ Math.round(this.percentage) +' %';},
                               showInLegend:true,
                               percentageDecimals:1,
                               valueDecimals:2
                           },
                           showInLegend:true,
                           innerSize:"",
                           depth:""
                       }
                   }
                });
            }
        }

        function clearAddonTransactionReport() {
            $('#addon_date_opt').val(1);
            $('#addon_date_from').val('');
            $('#addon_date_to').val('');

            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#addon_date_from').datepicker('setStartDate', start);
            $('#addon_date_from').datepicker('setEndDate', end);

            $('#addon_date_to').datepicker('setStartDate', start);
            $('#addon_date_to').datepicker('setEndDate', end);

            $('#addon-report-list-container').addClass('hidden');
            $('#addon-report-list').html('');
            $('#addon-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#addon-action-state').html('');
            $('#addon-action-state').hide();

            $('#addon-usage-list-graph').addClass('hidden');
            $('#addon-usage-graph-group').html('');
            $('#addon-usage-graph-route').html('');
            $('#addon-usage-graph-type').html('');

            $('#d_head_export_panel').addClass('hidden');
            $('.inp_error').removeClass('inp_error');
        }

    </script>
{/literal}