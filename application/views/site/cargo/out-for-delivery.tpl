<div class="brand_top">
    <h3>Door Pickup & Door Delivery</h3>
    <span class="align-right">
        <a href="#cargo/add-out-for-delivery" class="btn btn-success  btn-sm">Add Transit</a>
    </span>
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

                                                <form id="out_for_del_form" method="post" name="out_for_del_form" action="" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-3">
                                                            <label for="out_for_del_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="out_for_del_range" readonly placeholder="Date Range" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="out-for-del-vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="out-for-del-vehicle" name="vehicleCode" class="form-control">
                                                                    <option value="" selected="">All Vehicle</option>
                                                                    {foreach item=row from=$vehicles}
                                                                        {if $row->activeFlag == 1}
                                                                            <option {if $fvehicle==$row->code} selected="selected" {/if} value="{$row->code}">{$row->registationNumber} - {$row->vehicleType->name}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="out_for_del_alias_code">Transit Number</label>
                                                            <input type="text" name="aliasCode" class="form-control sdate initialism" id="out_for_del_alias_code" placeholder="Transit Number" value="{$faliasode}">
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="getOutForDelList();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearOutForDelList();">Clear</button>
                                                            </div>
                                                        </div>

                                                    </div>  
                                                </form> 
                                            </div>
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="out_for_del_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="ofd-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div id="ofd-lists"></div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>

<script>
    $('#out_for_del_range').daterangepicker({
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

    $('#out-for-del-vehicle').select2();

    function getOutForDelList() {
        var data = {};
        var daterange = $('#out_for_del_range').data('daterangepicker');
        data.fromDate = daterange.startDate.format('DD-MM-YYYY');
        data.toDate = daterange.endDate.format('DD-MM-YYYY');
        data.vehicleCode = $('#out-for-del-vehicle').val();
        data.aliasCode = $('#out_for_del_alias_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        
        if ($('#out_for_del_range').val() == '') {
            $('#out_for_del_range').addClass('inp_error');
            err++;
        } 
        
        if (data.fromDate != '') {
            if (data.toDate == '') {
                var output = moment(data.fromDate, 'DD-MM-YYYY').add(1, 'month').format('DD-MM-YYYY');
                data.toDate = output;              
            }
        }

        if (data.fromDate != '' && data.toDate != '') {
            var a = moment(data.fromDate, 'DD-MM-YYYY');
            var b = moment(data.toDate, 'DD-MM-YYYY');
            var t = b.diff(a, 'days');
            
            if (t > 31) {
                $('#ogpl_to').addClass('inp_error');
                $('#out_for_del_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#out_for_del_action_state').html('Date range should be 31 days or less').show();
                err++;
                return false;
            }
        }

        if (err > 0) {
            $('#out_for_del_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#out_for_del_action_state').html('Please enter/select the values in the field that are marked in red').show();
            return false;
        } else {
            $('#out_for_del_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#out_for_del_action_state').html('').hide();
        }

        $('#ofd-list-container').removeClass('hidden');
        $('#ofd-lists').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/out-for-delivery-list",
            data: data,
            dataType: 'html',
            success: function (response) {
                $('#ofd-lists').html(response);
                $("html, body").animate({
                    scrollTop: $('#ofd-list-container').offset().top - 35
                }, "slow");
            }
        });
    }

    function clearOutForDelList() {
        $('#out_for_del_range').val('');
        $('#out_for_del_range').data('daterangepicker').setStartDate({});
        $('#out_for_del_range').data('daterangepicker').setEndDate({});
        $('#out-for-del-vehicle').val('').trigger('change');
        $('#out_for_del_alias_code').val('');
        $('.inp_error').removeClass('inp_error');
        $('#ofd-list-container').addClass('hidden');
        $('#ofd-lists').html('');
        $('#out_for_del_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#out_for_del_action_state').html('').hide();
    }

    if ($('#out_for_del_range').val() != '') {
        getOutForDelList();
    }
</script>

<link href="assets/lib/leaflet/leaflet.css" rel="stylesheet" type="text/css" media="screen">
<script type="text/javascript" src="assets/lib/leaflet/leaflet.js"></script>