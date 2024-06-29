
<div id="main_wrapper" class="voucher_transaction_details">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                    <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">
                                            <div id="search-panel-result">                                         
                                                    <div class="divide-10"></div>
                                                    <form id='test'>
                                                        <div class="form-group col-md-3">
                                                            <div class="input-group col-xs-12">
                                                                <select id="gru_users" class="form-control" name='users'>
                                                                    <option value="">Select User</option>
                                                                    {foreach name=o item=row from=$entity}
                                                                        <optgroup label="{$row['groupname']}">
                                                                            {foreach name=o item=usr from=$row["users"]}
                                                                                <option value='{$usr['code']}'>{$usr['name']}</option>
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-3">
                                                            <label class="sr-only" for="date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="date_from" class="form-control sdate" id="date_fromdate" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-3">
                                                            <label class="sr-only" for="date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="date_to" class="form-control sdate" id="date_todate" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <button class="btn btn-success" type="button" onclick="searchTransactionDetails();">Generate</button>
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearTransactionDetails();">Clear</button>
                                                    </form>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="usr-action-state"></div>
                                             </div><!--row end-->
                                          
                                        </div><!--search-panel-result end-->
                                    </div>
                                </div><!--panel-default end-->
                            </div>
                        </div>
                    </div>
                </div>
           </div>
       </div>
    </div>
    <div id="rpt_lst"></div>                                                 

    <script>
        $(document).ready(function() {
           
            $('#date_fromdate').datepicker({
                todayHighlight: true,
                format: 'yyyy-mm-dd',
                autoclose: true
            }).on('changeDate', function(e) {
                var fDate = new Date(e.date);
                var end = new Date(fDate.setDate(fDate.getDate() + 365));
                $('#date_todate').datepicker('setStartDate', e.date);
                $("#date_todate").datepicker("setEndDate", end)
            });
            $('#date_todate').datepicker({
                todayHighlight: true,
                startDate: '-0m',
                format: 'yyyy-mm-dd',
                maxDate: "+365D",
                autoclose: true
            }).on('changeDate', function(e) {
                $('#date_fromdate').datepicker('setEndDate', e.date)
            });
        });
    
    </script>