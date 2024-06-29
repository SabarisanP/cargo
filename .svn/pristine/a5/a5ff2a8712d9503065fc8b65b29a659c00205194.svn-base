<div class="brand_top">
    <h3>Unload {lang('ogpl_local_transit')}</h3>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Unload the goods transfered from near by branch.                 
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

                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl_from">Created Date From</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="ogpl_from" readonly placeholder="Date From" value="{$ffromDate|date_format:$ns_date_format}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl_to">Created Date To</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="ogpl_to" readonly placeholder="Date To" value="{$ftoDate|date_format:$ns_date_format}">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl-vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ogpl-vehicle" name="vehicleCode" class="form-control">
                                                                    <option value="NA" selected="">All Vehicle</option>
                                                                    {foreach item=row from=$vehicles}
                                                                        {if $row->activeFlag == 1}
                                                                            <option {if $fvehicle==$row->code} selected="selected" {/if} value="{$row->code}">{$row->registationNumber} - {$row->vehicleType->name}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        
                                                        {if $action_rights['LCL-TNSIT-ALLBRNC']>0}
                                                            <div class="form-group col-md-2">
                                                                <label  for="rev_rpt_date_to">To Branch (Unloading Branch)</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="ogpl-organization" name="organizationCode"  class="form-control select2" >                                                                        
                                                                        {foreach item=branch from=$branches key=bcode}
                                                                            <option value="{$bcode}" {if $bcode==$login_branch} selected="selected" {/if} >{$branch}</option>
                                                                        {/foreach}
                                                                    </select>      
                                                                </div>
                                                            </div> 
                                                        {/if}

                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl_alias_code">{lang('ogpl_local_transit')} Number</label>
                                                            <input type="text" name="aliasCode" class="form-control sdate initialism" id="ogpl_alias_code" placeholder="{lang('ogpl_local_transit')} Number" value="{$faliasode}">
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
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
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="find-uncargo-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_ogpl_lr_downloader" id="ifrm_ogpl_lr_downloader" style="display:none"></iframe>  

<script>
    $('#ogpl_from').datepicker({
        //todayHighlight: true,
        format: 'dd-mm-yyyy',
        startDate: '-6m',
        endDate: "0D",
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 31));
        $('#ogpl_to').datepicker('setStartDate', e.date);
        $("#ogpl_to").datepicker("setEndDate", end);
    });
    
    $('#ogpl_to').datepicker({
        //todayHighlight: true,
        startDate: '-3m',
        endDate: "0D",
        format: 'dd-mm-yyyy',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#ogpl_from').datepicker('setEndDate', e.date);
    });

    if ($('#ogpl_from').val() == '' && $('#ogpl_to').val() == '') {
        $('#ogpl_to').datepicker('setDate', '0d');
        $('#ogpl_from').datepicker('setDate', '-3m');
    }

    if ($('#ogpl_from').val() != '' && $('#ogpl_to').val() != '') {
        getOgplList();
    }
    
    $('#ogpl-vehicle').select2();
    $('#ogpl-organization').select2();

    function getOgplList() {
        var data = {};
        data.fromDate = $('#ogpl_from').val();
        data.toDate = $('#ogpl_to').val();
        data.vehicleCode = $('#ogpl-vehicle').val();
        data.organizationCode = $('#ogpl-organization').val();
        data.aliasCode = $('#ogpl_alias_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if(data.aliasCode == '') {
            if ($('#ogpl_from').val() == '') {
                $('#ogpl_from').addClass('inp_error');
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

        // if (data.fromDate != '' && data.toDate != '') {
        //     var a = moment(data.fromDate, 'DD-MM-YYYY');
        //     var b = moment(data.toDate, 'DD-MM-YYYY');
        //     var t = b.diff(a, 'days');
        //     if (t > 31) {
        //         $('#ogpl_to').addClass('inp_error');
        //         $('#ogpl_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        //         $('#ogpl_cargo_action_state').html('Date range should be 31 days or less');
        //         $('#ogpl_cargo_action_state').show();
        //         err++;
        //         return false;
        //     }
        // }

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
            url: base_url + "cargo/local-transit-unload-list",
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
        $('#ogpl_from').val('');
        $('#ogpl_to').val('');
        $('#ogpl-vehicle').val('').trigger('change');
        $('#ogpl-organization').val('NA').trigger('change');
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
</script>