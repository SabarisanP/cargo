<div class="brand_top">
    <h3>{lang('ogpl_local_transit')}</h3>
    <div class="align-right">
        <a href="#cargo/add-ogpl?back=local-transit" class="btn btn-success  btn-sm">Add {lang('ogpl_local_transit')}</a>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Local Transit - Transfer / Move the goods to Hub or near by branch.                 
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

                                                <form id="ogpl_form" method="post" name="ogpl_form" action="" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-3">
                                                            <label for="ogpl_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="ogpl_range" readonly placeholder="Date Range" value="{implode(' | ', array_filter([$ffromDate|date_format:'%d-%m-%Y', $ftoDate|date_format:'%d-%m-%Y']))}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl-vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ogpl-vehicle" name="vehicleCode" class="form-control">
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
                                                            <label for="ogpl_alias_code">{lang('ogpl_local_transit')} Number</label>
                                                            <input type="text" name="aliasCode" class="form-control sdate initialism" id="ogpl_alias_code" placeholder="{lang('ogpl_local_transit')} Number" value="{$faliasode}">
                                                        </div>
                                                                
                                                        <div class="form-group col-md-3">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="getOgplList();">Get {lang('ogpl_local_transit')}</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearOgplList();">Clear</button>
                                                            </div>
                                                        </div>

                                                    </div>  
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="ogpl_cargo_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="find-uncargo-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div id="find-uncargo-list"></div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_ogpl_lr_downloader" id="ifrm_ogpl_lr_downloader" style="display:none"></iframe>  

<script>
    $('#ogpl_range').daterangepicker({
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
    
    $('#ogpl-vehicle').select2();

    function getOgplList() {
        var data = {};
        var daterange = $('#ogpl_range').data('daterangepicker');
        data.fromDate = daterange.startDate.format('DD-MM-YYYY');
        data.toDate = daterange.endDate.format('DD-MM-YYYY');
        data.vehicleCode = $('#ogpl-vehicle').val();
        data.aliasCode = $('#ogpl_alias_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if(data.aliasCode == '') {
            if ($('#ogpl_range').val() == '') {
                $('#ogpl_range').addClass('inp_error');
                err++;
            }            
        }
        
        if (data.fromDate != '') {
            if (data.toDate == '') {
                $('#ogpl_to').removeClass('inp_error');

                var output = moment(data.fromDate, 'DD-MM-YYYY').add(1, 'month').format('DD-MM-YYYY');
                                   
                data.toDate = output;
                $('#ogpl_to').val(output);                
            }
        }

        if (data.fromDate != '' && data.toDate != '') {
            var a = moment(data.fromDate, 'DD-MM-YYYY');
            var b = moment(data.toDate, 'DD-MM-YYYY');
            var t = b.diff(a, 'days');
            if (t > 31) {
                $('#ogpl_to').addClass('inp_error');
                $('#ogpl_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#ogpl_cargo_action_state').html('Date range should be 31 days or less');
                $('#ogpl_cargo_action_state').show();
                err++;
                return false;
            }
        }

        if (err > 0) {
            $('#ogpl_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#ogpl_cargo_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#ogpl_cargo_action_state').show();
            return false;
        } else {
            $('#ogpl_cargo_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl_cargo_action_state').html('');
            $('#ogpl_cargo_action_state').hide();
        }

        $('#find-uncargo-list-container ').removeClass('hidden');
        $('#find-uncargo-list').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/local-transit-list",
            data: data,
            dataType: 'html',
            success: function (response) {
                $('#find-uncargo-list').html(response);
                $('#download-lr-btn').toggle($('#ogpl-trip-table-list table').length != 0);
                $("html, body").animate({
                    scrollTop: $('#find-uncargo-list-container').offset().top - 35
                }, "slow");
            }
        });
    }

    function clearOgplList() {
        $('#ogpl_range').val('');
        $('#ogpl_range').data('daterangepicker').setStartDate({});
        $('#ogpl_range').data('daterangepicker').setEndDate({});
        $('#ogpl-vehicle').val('').trigger('change');
        $('#ogpl_alias_code').val('');
        $('.inp_error').removeClass('inp_error');
        $('#find-uncargo-list-container ').addClass('hidden');
        $('#find-uncargo-list').html('');
        $('#ogpl_cargo_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#ogpl_cargo_action_state').html('');
        $('#ogpl_cargo_action_state').hide();
        $('#download-lr-btn').hide();
    }

    function downloadOGPLLR() {
        document.ogpl_form.target = "ifrm_ogpl_lr_downloader";
        document.ogpl_form.action = "cargo/export-ogpl-lr-list"
        $('#export').val(1);
        document.ogpl_form.submit();
        return;
    }
    
    if ($('#ogpl_range').val() != '') {
        getOgplList();
    }
</script>

<link href="assets/lib/leaflet/leaflet.css" rel="stylesheet" type="text/css" media="screen">
<script type="text/javascript" src="assets/lib/leaflet/leaflet.js"></script>