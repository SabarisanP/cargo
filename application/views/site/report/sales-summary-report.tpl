<div class="brand_top">
    <h3>Sales Summary Report</h3> 
    <div class="text-right noprint hidden" id="d_head_export_panel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportSalesSummaryExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/sales-summary-report-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="date_from">From Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="from_date" class="form-control sdate" id="ss_date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="date_to">To Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="to_date" class="form-control sdate" id="ss_date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ss_date_opt" name="date_option"  class="form-control" >  
                                                                    <option value="1">Travel Date</option>    
                                                                    <option value="0">Transaction Date</option>                                                                                                                                    
                                                                </select>       
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">

                                                        <div class="form-group col-md-2">
                                                            <label for="ss_user_code">Select User</label>
                                                            <select id="ss_user_code" name="user_code" class="form-control" name='users'>
                                                                <option value="NA">All User</option>
                                                                {foreach item=group key=groupname from=$groupusers.groupusers}
                                                                    <optgroup label="{$groupname}">
                                                                        {foreach item=usr from=$group}
                                                                            <option value="{$usr.code}">{$usr.name}</option>
                                                                        {/foreach}
                                                                    </optgroup>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                            
                                                        <div class="form-group col-md-2">
                                                            <label for="ss_group_code">User Group</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ss_group_code" name="group_code"  class="form-control" >
                                                                    <option value="NA" selected="">All Group/Roles</option>
                                                                    {foreach item=row from=$groupusers.groups}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-3">     
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateSalesSummaryReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearSalesSummary();">Clear</button>
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

                    <div class="row hidden" id="salessummary-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="salessummary-report-list"></div>                                    
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

        function exportSalesSummaryExcel () {
            document.brd_pnt.target = "irm_downloader";
            $('#export').val(1);
            document.brd_pnt.submit();
            return;
        }
        
        $('#ss_user_code').select2();
        $('#ss_group_code').select2();
        
        $('#ss_date_from').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
        });
        
        $('#ss_date_to').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
        });

        function generateSalesSummaryReport() {
            $('#salessummary-report-list').html('');
            var data = {};
            data.date_option = $('#ss_date_opt').val();
            data.from_date = $('#ss_date_from').val();
            data.to_date = $('#ss_date_to').val();
            data.user_code = $('#ss_user_code').val();
            data.group_code = $('#ss_group_code').val();

            var err = 0;

            if (data.from_date == '') {
                $('#ss_date_from').addClass('inp_error');
                err++;
            } else {
                $('#ss_date_from').removeClass('inp_error');
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
            
            $('#ss_date_to').removeClass('inp_error');
            $('#salessummary-report-list-container').removeClass('hidden');
            $('#salessummary-report-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/sales-summary-report-list",
                data: data,
                success: function (response) {
                    $('#salessummary-report-list').html(response);
                    $('#d_head_export_panel').removeClass('hidden');
                                        
                    $("html, body").animate({
                        scrollTop: $('#discount-usage-list-graph').offset().top - 35
                    }, "slow");
                    /*if(ticket_count>0) {
                        $('#discount-usage-list-graph').removeClass('hidden');
                        initDiscountGraphs();
                    }*/
                }
            });
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

        function clearSalesSummary() {
            $('#ss_date_opt').val(1);
            $('#ss_date_from').val('');
            $('#ss_date_to').val('');
            $('#ss_user_code').val('NA');
            $('#ss_group_code').val('NA');
            
            var fDate = new Date();
            var start = new Date(fDate.setDate(fDate.getDate() - 93));
            var tDate = new Date();
            var end = new Date(tDate.setDate(tDate.getDate() + 93));
            $('#ss_date_from').datepicker('setStartDate', start);
            $('#ss_date_from').datepicker('setEndDate', end);
           
            $('#ss_date_to').datepicker('setStartDate', start);
            $('#ss_date_to').datepicker('setEndDate', end);

            $('#salessummary-report-list-container').addClass('hidden');
            $('#salessummary-report-list').html('');
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