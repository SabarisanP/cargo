<div class="brand_top">
    <h3>Discount Utilization Report</h3> 
    <div class="text-right noprint hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportDiscountExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/discount-utilization-report-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="date_from">From Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="from_date" class="form-control sdate" id="dis_date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="date_to">To Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="to_date" class="form-control sdate" id="dis_date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="dis_date_opt" name="date_option"  class="form-control" >  
                                                                    <option value="0">Transaction Date</option>
                                                                    <option value="1">Travel Date</option>                                                                    
                                                                </select>       
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">Ticket Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ticket_status" name="ticket_status"  class="form-control" >                                                                    
                                                                    <option value="BO">Booked</option>
                                                                    <option value="CA">Cancelled</option>
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">Discount Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="discount_type" name="discount_type"  class="form-control" >                                                                    
                                                                    <option value="ALL">All Types</option>
                                                                    {foreach from=$discount_type item=typename key=typecode} 
                                                                    <option value="{$typecode}">{$typename}</option>
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-3">     
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateDiscountUtilizationReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearDiscountUtilizationReport();">Clear</button>
                                                        </div>
                                                    </div>            
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usr-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row hidden noprint" id="discount-usage-list-graph">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-sm-4">
                                        <div class="bold" align="center">Groups</div>
                                        <div id="discount-usage-graph-group"  style="height:250px;"></div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="bold" align="center">Disount Type</div>
                                        <div id="discount-usage-graph-type"  style="height:250px;"></div>
                                    </div>  
                                    <div class="col-sm-4" align="center">
                                        <div class="bold">Routes</div>
                                        <div id="discount-usage-graph-route"  style="height:250px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="discount-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="discount-report-list"></div>                                    
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

        function exportDiscountExcel() {
            document.brd_pnt.target = "irm_downloader";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }

        $('#dis_date_from').datepicker({
            format: 'yyyy-mm-dd',
            startDate: '-3m',
            endDate: "+3m",
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 31));
            $('#dis_date_to').datepicker('setStartDate', e.date);
            $("#dis_date_to").datepicker("setEndDate", end)
        });
        
        $('#dis_date_to').datepicker({
            startDate: '-3m',            
            endDate: "+3m",
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 31));
            $('#dis_date_from').datepicker('setStartDate', start);
            $('#dis_date_from').datepicker('setEndDate', e.date)
        });

        function generateDiscountUtilizationReport() {
            $('#discount-report-list').html('');
            var data = {};
            data.date_option = $('#dis_date_opt').val();
            data.from_date = $('#dis_date_from').val();
            data.to_date = $('#dis_date_to').val();
            data.ticket_status = $('#ticket_status').val();
            data.discount_type = $('#discount_type').val();            

            var err = 0;

            if (data.from_date == '') {
                $('#dis_date_from').addClass('inp_error');
                err++;
            } else {
                $('#dis_date_from').removeClass('inp_error');
            }
            
            if (data.from_date != '') {
                if (data.to_date == '') {
                    $('#dis_date_to').removeClass('inp_error');
                    var d = new Date();

                    var month = d.getMonth() + 1;
                    var day = d.getDate();

                    var output = d.getFullYear() + '-' +
                            (('' + month).length < 2 ? '0' : '') + month + '-' +
                            (('' + day).length < 2 ? '0' : '') + day;

                    data.to_date = output;
                    $('#dis_date_to').val(output);
                }
            }
            
            if (data.from_date != '' && data.to_date != '') {
                var f = data.from_date.split('-');
                var a = moment([f[0], f[1], f[2]]);
                
                var e = data.to_date.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if(t>31) {
                    $('#dis_date_to').addClass('inp_error');
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#usr-action-state').html('Date range should be 31 days or less');
                    $('#usr-action-state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#usr-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#usr-action-state').show();
                return false;
            } else {
                $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#usr-action-state').html('');
                $('#usr-action-state').hide();
                
                $('#discount-usage-list-graph').addClass('hidden');
                $('#discount-usage-graph-group').html('');
                $('#discount-usage-graph-route').html('');
                $('#discount-usage-graph-type').html('');
            }
            var html = "";
            
            $('#dis_date_to').removeClass('inp_error');
            $('#discount-report-list-container').removeClass('hidden');
            $('#discount-report-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/discount-utilization-report-list",
                data: data,
                success: function (response) {
                    $('#discount-report-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                                        
                    $("html, body").animate({
                        scrollTop: $('#discount-usage-list-graph').offset().top - 35
                    }, "slow");
                    if(ticket_count>0) {
                        $('#discount-usage-list-graph').removeClass('hidden');
                        initDiscountGraphs();
                    }
                }
            })
        }
        
        function initDiscountGraphs() {
            if(_isdefined( discountmeta ) ) {
                groupItems = [];
                $.each(discountmeta.group, function(name, count) {
                    var ti = [name,count.discount];
                    groupItems.push(ti);
                });

                $('#discount-usage-graph-group').highcharts({
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
                $.each(discountmeta.type, function(name, count) {
                    var ti = [name,count.discount];
                    typeItems.push(ti);
                });

                $('#discount-usage-graph-type').highcharts({
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
                $.each(discountmeta.route, function(name, count) {
                    var ti = [name,count.discount];
                    routeItems.push(ti);
                });

                $('#discount-usage-graph-route').highcharts({
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

        function clearDiscountUtilizationReport() {
            $('#dis_date_opt').val(1);
            $('#dis_date_from').val('');
            $('#dis_date_to').val('');
            $('#ticket_status').val('BO');            
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#dis_date_from').datepicker('setStartDate', start);
            $('#dis_date_from').datepicker('setEndDate', end);
           
            $('#dis_date_to').datepicker('setStartDate', start);
            $('#dis_date_to').datepicker('setEndDate', end);

            $('#discount-report-list-container').addClass('hidden');
            $('#discount-report-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
            
            $('#discount-usage-list-graph').addClass('hidden');
            $('#discount-usage-graph-group').html('');
            $('#discount-usage-graph-route').html('');
            $('#discount-usage-graph-type').html('');

            $('#d_head_export_panel').addClass('hidden');
        }

    </script>
{/literal}