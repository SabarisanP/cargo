<div class="brand_top"><h3>Retail Customer Tariff</h3> <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="addCustomerTariff();">Add Tariff</a></span></div>
<div id="main_wrapper">
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
                                    <div class="input-group table_filters pull-right" style="width: 25%;">
                                        <input type="search" class="form-control search-box" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
                                        <span class="input-group-addon point_cur" id="search-btn">
                                            <i class="fa fa-search"></i>
                                        </span>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover" id="customer-tariff-table">
                                            <thead>
                                                <tr class="success">
                                                    <th width="9%">From Station</th>
                                                    <th width="9%">To Station</th>
                                                    <th width="9%">From Branch</th>
                                                    <th width="9%">To Branch</th>
                                                    <th width="9%">Article</th>
                                                    <th width="9%">{lang('booking_UOM_label')}</th>
                                                    <th>Rate</th>
                                                    <th>Min.Unit</th>
                                                    <th>Loading Ch</th>
                                                    <th>Hamali Ch</th>
                                                    <th>Docket Ch</th>
                                                    <th>Door Pickup Ch</th>
                                                    <th>Door Delivery Ch</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach from=$tariff item=row key=key}
                                                    <tr>
                                                        {* Station *}
                                                        {if $row->routeType->code == 'RTE'}
                                                            <td>
                                                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                    {foreach from=$row->fromStationList item=val}
                                                                        <li>{$val->name|replace:"'":'"'}</li>
                                                                    {/foreach}
                                                                    </ul>'>
                                                                    {if $row->fromStationList}
                                                                        {foreach from=$row->fromStationList item=val}
                                                                            {$val->name}
                                                                            {break}
                                                                        {/foreach}
                                                                        {if ($row->fromStationList|@count) > 1}
                                                                            <span class="badge badge-info">{$row->fromStationList|@count}</span>
                                                                        {/if}
                                                                    {else}
                                                                        All Station
                                                                    {/if}
                                                                </a>
                                                            </td>
                                                            <td>
                                                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                    {foreach from=$row->toStationList item=val}
                                                                        <li>{$val->name|replace:"'":'"'}</li>
                                                                    {/foreach}
                                                                    </ul>'>
                                                                    {if $row->toStationList}
                                                                        {foreach from=$row->toStationList item=val}
                                                                            {$val->name}
                                                                            {break}
                                                                        {/foreach}
                                                                        {if ($row->toStationList|@count) > 1}
                                                                            <span class="badge badge-info">{$row->toStationList|@count}</span>
                                                                        {/if}
                                                                    {else}
                                                                        All Station
                                                                    {/if}
                                                                </a>
                                                            </td>
                                                        {else}
                                                            <td>-</td>
                                                            <td>-</td>
                                                        {/if}

                                                        {* Branch *}
                                                        {if $row->routeType->code == 'BRTE'}
                                                            <td>
                                                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                    {foreach from=$row->fromOrganizationList item=val}
                                                                        <li>{$val->name|replace:"'":'"'}</li>
                                                                    {/foreach}
                                                                    </ul>'>
                                                                    {if $row->fromOrganizationList}
                                                                        {foreach from=$row->fromOrganizationList item=val}
                                                                            {$val->name}
                                                                            {break}
                                                                        {/foreach}
                                                                        {if ($row->fromOrganizationList|@count) > 1}
                                                                            <span class="badge badge-info">{$row->fromOrganizationList|@count}</span>
                                                                        {/if}
                                                                    {else}
                                                                        All Branch
                                                                    {/if}
                                                                </a>
                                                            </td>
                                                            <td>
                                                                <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                    {foreach from=$row->toOrganizationList item=val}
                                                                        <li>{$val->name|replace:"'":'"'}</li>
                                                                    {/foreach}
                                                                    </ul>'>
                                                                    {if $row->toOrganizationList}
                                                                        {foreach from=$row->toOrganizationList item=val}
                                                                            {$val->name}
                                                                            {break}
                                                                        {/foreach}
                                                                        {if ($row->toOrganizationList|@count) > 1}
                                                                            <span class="badge badge-info">{$row->toOrganizationList|@count}</span>
                                                                        {/if}
                                                                    {else}
                                                                        All Branch
                                                                    {/if}
                                                                </a>
                                                            </td>
                                                        {else}
                                                            <td>-</td>
                                                            <td>-</td>
                                                        {/if}

                                                        <td>
                                                            <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                {foreach from=$row->itemDetailList item=val}
                                                                    {if $val->cargoItem->code == 'ALL'}
                                                                        <li>All Articles</li>
                                                                    {else}
                                                                        <li>{$val->cargoItem->name|replace:"'":'"'} - {$cnt = $val->cargoItem->description|@count}
                                                                        {foreach from=$val->cargoItem->description item=desc key=k}{$desc}{if $k< $cnt-1},{/if}{/foreach}</li>
                                                                    {/if}
                                                                {/foreach}
                                                                </ul>'>
                                                                {foreach from=$row->itemDetailList item=val}
                                                                    {if $val->cargoItem->code == 'ALL'}
                                                                        All Articles
                                                                    {else}
                                                                        {$val->cargoItem->name}
                                                                    {/if}
                                                                    {break}
                                                                {/foreach}
                                                                {if ($row->itemDetailList|@count) > 1}
                                                                    <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                                                                {/if}
                                                            </a>
                                                        </td>
                                        
                                                        <td>
                                                            <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                {foreach from=$row->itemDetailList item=val}
                                                                <li>{$val->unit->name|replace:"'":'"'} - {if $val->cargoItem->code == 'ALL'}All Articles{else}{$val->cargoItem->name}{/if}</li>
                                                                {/foreach}
                                                                </ul>'>
                                                                {foreach from=$row->itemDetailList item=val}
                                                                    {$val->unit->name}
                                                                    {break}
                                                                {/foreach}
                                                                {if ($row->itemDetailList|@count) > 1}
                                                                    <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                                                                {/if}
                                                            </a>
                                                        </td>
                                        
                                                        <td nowrap>
                                                            <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                {foreach from=$row->itemDetailList item=val}
                                                                <li>{if $val->cargoItem->code == 'ALL'}All Articles{else}{$val->cargoItem->name|replace:"'":'"'}{/if} - {$val->amount}</li>
                                                                {/foreach}
                                                                </ul>'>
                                                                {foreach from=$row->itemDetailList item=val}
                                                                    {$val->amount}
                                                                    {break}
                                                                {/foreach}
                                                                {if ($row->itemDetailList|@count) > 1}
                                                                    <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                                                                {/if}
                                                            </a>
                                                        </td>
                                        
                                                        <td>
                                                            <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                {foreach from=$row->itemDetailList item=val}
                                                                <li>{if $val->cargoItem->code == 'ALL'}All Articles{else}{$val->cargoItem->name|replace:"'":'"'}{/if} - {$val->minUnitValue}</li>
                                                                {/foreach}
                                                                </ul>'>
                                                                {foreach from=$row->itemDetailList item=val}
                                                                    {$val->minUnitValue}
                                                                    {break}
                                                                {/foreach}
                                                                {if ($row->itemDetailList|@count) > 1}
                                                                    <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                                                                {/if}
                                                            </a>
                                                        </td>

                                                        <td>
                                                            {assign var="itemLoadingCharge" value=0}
                                                            <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                {foreach from=$row->itemDetailList item=val}
                                                                {assign var="itemLoadingCharge" value=$itemLoadingCharge + $val->loadingCharge}
                                                                <li>{if $val->cargoItem->code == 'ALL'}All Articles{else}{$val->cargoItem->name|replace:"'":'"'}{/if} - {$val->loadingCharge|inr_format:2}</li>
                                                                {/foreach}
                                                                </ul>'>
                                                                {$itemLoadingCharge|inr_format:2}
                                                                {if $itemLoadingCharge > 0 && ($row->itemDetailList|@count) > 1}
                                                                    <span class="badge badge-info">{$row->itemDetailList|@count}</span>
                                                                {/if}
                                                            </a>
                                                        </td>
                                                        
                                                        <td align="right">{$row->hamaliCharge|inr_format:2}</td>
                                                        <td align="right">{$row->docketCharge|inr_format:2}</td>
                                                        <td align="right">{$row->doorPickupCharge|inr_format:2}</td>
                                                        <td align="right">{$row->doorDeliveryCharge|inr_format:2}</td>

                                                        <td nowrap>
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick='addCustomerTariff({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick='deleteTariff({$row|@json_encode})'><i class="fa fa-trash-o ired"></i></a>
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>
<div id="customer-tariff-dialog" class="hide dialog-content-page">
    <div class="clearfix">
        <h4 id="">Add Tariff</h4>
    </div>
    <div id="add-tariff">
        <div class="row">
            <div class="col-lg-3">
                <label for="ie-amount">&nbsp;</label>
                <div class="input-group">
                    <label class="radio-inline">
                        <input type="radio" name="customerTariffRadio" class="customer-tariff-type" value="STN" checked>Station
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="customerTariffRadio" class="customer-tariff-type" value="BRN">Branch
                    </label>
                </div>
            </div>

            {* Station *}
            <div id="customer-tariff-station">
                <div class="col-lg-3 p_l_n">
                    <div>
                        <label for="tf-frm-station" class="req">From Station</label>
                        <select id="tf-frm-station" class="form-control" multiple>
                            <option value=''>All Station</option>
                            {foreach item=station from=$stations}
                                <option value="{$station.code}">{$station.name}</option>
                            {/foreach}
                        </select> 
                    </div>
                </div>
                <div class="col-lg-3 p_l_n">
                    <div>
                        <label for="tf-to-station" class="req">To Station</label>
                        <select id="tf-to-station" class="form-control" multiple>
                            <option value=''>All Station</option>
                            {foreach item=station from=$stations}
                                <option value="{$station.code}">{$station.name}</option>
                            {/foreach}
                        </select> 
                    </div>
                </div>  
            </div> 

            {* Branch *}
            <div class="hide" id="customer-tariff-branch">
                <div class="col-lg-3 p_l_n">
                    <div>
                        <label for="tf-frm-branch" class="req">From Branch</label>
                        <select id="tf-frm-branch" class="form-control" multiple>
                            <option value=''>All Branch</option>
                            {foreach item=brn from=$organizations}
                                <option value="{$brn->code}">{$brn->name}</option>
                            {/foreach}
                        </select> 
                    </div>
                </div>
                <div class="col-lg-3 p_l_n">
                    <div>
                        <label for="tf-to-branch" class="req">To Branch</label>
                        <select id="tf-to-branch" class="form-control" multiple>
                            <option value=''>All Branch</option>
                            {foreach item=brn from=$organizations}
                                <option value="{$brn->code}">{$brn->name}</option>
                            {/foreach}
                        </select> 
                    </div>
                </div>  
            </div>
            <div class="col-lg-3 p_l_n">
                <div>
                    <label for="tf-hamali" class="req">Hamali Charge</label>
                    <input type="number" class="form-control" id="tf-hamali" placeholder="Hamali Charge" step="any">
                </div>
            </div> 
            <div class="clear_fix_both"><br></div>

            <div class="col-lg-3">
                <div>
                    <label for="tf-docket" class="req">Docket Charge</label>
                    <input type="number" class="form-control" id="tf-docket" placeholder="Docket Charge" step="any">
                </div>
            </div> 

            <div class="col-lg-3 p_l_n">
                <div>
                    <label for="tf-door-pick" class="req">Door Pickup Charge</label>
                    <input type="number" class="form-control" id="tf-door-pick" placeholder="Door Pickup Charge" step="any">
                </div>
            </div>    
            <div class="col-lg-3 p_l_n">
                <div>
                    <label for="tf-door-del" class="req">Door Delivery Charge</label>
                    <input type="number" class="form-control" id="tf-door-del" placeholder="Door Delivery Charge" step="any">
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </div> <br>
        <div class="table-responsive">
            <table class="table table-striped" id="article-table">
                <thead>
                    <tr>
                        <th class="req">Article</th>
                        <th class="req">{lang('booking_UOM_label')}</th>
                        <th class="req">Rate</th>
                        <th class="req">Min Unit</th>
                        {if in_array('VOL', $cargo_setting->cargoUnitModel)}
                            <th class="req">Vol. Feet Value</th>
                        {/if}
                        <th class="req">Loading Ch</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr id="tr_clone" class="tr_clone">
                        <td width='30%'>
                            <select id="tf-item" class="form-control clone-field" onchange="allArticles(this);">
                                <option value=''>Select</option>
                                <option value='ALL'>All Articles</option>
                                {foreach item=val from=$items}
                                    <option value="{$val->code}">{$val->name}</option>
                                {/foreach}
                            </select> 
                        </td>

                        <td width=''>
                            <select id="tf-uom" class="form-control clone-field" onchange="setUOMValue(this)">
                                <option value=''>Select</option>
                                {foreach item=name key=code from=$article_unit}
                                    {if in_array($code, $cargo_setting->cargoUnitModel)}
                                        <option value="{$code}">{$name}</option>
                                    {/if}
                                {/foreach}
                                {if in_array('VOL', $cargo_setting->cargoUnitModel)}
                                    <option value="VOLFT">Volumetric Feet</option>
                                {/if}
                                {if in_array($namespace, ["varahi","citycargo","cityparcel"])}
                                    <option value="PKPK">per Kg per KM</option>
                                    <option value="PTPK">per Ton per KM</option>
                                {/if}
                            </select> 
                        </td>

                        <td>
                            <input type="num" placeholder="Amount" id="tf-amount" value="" class="form-control clone-field" step="any">
                        </td>

                        <td>
                            <input  placeholder="Min Units" id="tf-min-unit" value="" class="form-control clone-field">
                        </td>

                        {if in_array('VOL', $cargo_setting->cargoUnitModel)}
                            <td>
                                <input  placeholder="Vol. Feet Value" id="tf-add-val" value="" class="form-control clone-field" disabled>
                            </td>
                        {/if}

                        <td>
                            <input type="number" class="form-control" id="tf-loading-ch" placeholder="Loading Charge" step="any"> 
                        </td>

                        <td width='5%' align="right">
                            <a href="javascript:;" onclick="removeArticleRow(this);" data-index="1" class="btn btn-sm btn-danger tr_remove" title="Remove"><i class="fa fa-times"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="javascript:;" class="btn btn-sm btn-primary" id="tr_add_btn" title="Add {lang('booking_article_label')}" onclick="addArticleRow(this)"> <i class="fa fa-plus"></i> </a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display:none;" id="customer-tariff-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" id="customer-tariff-code"/>
            <button class="btn btn-success" type="button" onclick="saveTariff();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelTariffDialog();">Cancel</button>
        </div>
    </div> 
</div>

<input type="hidden" id="item-data" value="{$items|json_encode|escape}">

<script>
    var cargo_setting = {$cargo_setting|json_encode};
</script>
{literal}
<script>
    $('#article-table #tr_clone').find('#tf-item').select2();
    $('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');
    $('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'hover');
    $('[data-toggle=popover]').popover({
        container: "body",
        html: true
    });

    $('#customer-tariff-table').dataTable({
        "bPaginate": false,
        "info": false,
        "dom": 'lrt'
    });

    $('.search-box').on( 'input', function () {
        $('#customer-tariff-table').dataTable().fnFilter($('.search-box').val());
        $('#customer-tariff-table tbody tr').removeClass('none');
    });

    $('#tf-frm-station').select2({
        placeholder: "Select From Station",
    });
    $('#tf-to-station').select2({
        placeholder: "Select To Station",
    });

    $('#tf-frm-branch').select2({
        placeholder: "Select From Branch",
    });
    $('#tf-to-branch').select2({
        placeholder: "Select To Branch",
    });

    var items = JSON.parse($('#item-data').val());
    var masterItems = [];
    h = '<option value="">Select Article</option>';	
    $.each(items, function(key, art) {
        h = h+'<option value="'+key+'">'+art.name+'</option>'; 
        
        var ti = {};
        ti.label = art.name;
        ti.value = key;
        
        masterItems.push(ti);
    });
    
    var tr_id = $('#article-table tbody .tr_clone').length;
    $('input[name=customerTariffRadio]').on('change', function() {
        var type = $(this).val();
        $('#customer-tariff-station, #customer-tariff-branch').addClass('hide');

        if (type == 'BRN') {
            $('#customer-tariff-branch').removeClass('hide');
        } else {
            $('#customer-tariff-station').removeClass('hide');
        }
    });

    function addCustomerTariff(option){
        event && event.stopPropagation();

        $('input[name=customerTariffRadio][value=STN]').prop('checked', true).trigger('change');
        $('#tf-item').val('').trigger('change');
        $('#tf-uom, #tf-amount, #tf-min-unit, #tf-loading-ch, #customer-tariff-code').val('');
        $('#tf-hamali, #tf-docket, #tf-door-pick, #tf-door-del').val('');
        $('#tf-frm-station, #tf-to-station, #tf-frm-branch, #tf-to-branch').val(null).trigger('change');
        $('.inp_error').removeClass('inp_error');
        $('#customer-tariff-action-state').html('').addClass('none').removeClass('alert-danger alert-success');
        $('#customer-tariff-dialog').removeClass('hide');
        $('#customer-tariff-dialog').dialog({
            autoOpen: true,
            width: 900,
            height: 550,
            resizable: false,
            closeOnEscape: true
        });
        $(".ui-dialog-titlebar").hide();
        
        if (_isdefined(option)) {
            $('#customer-tariff-code').val(option.code);
            if (option.routeType.code == 'RTE') {
                $('input[name=customerTariffRadio][value=STN]').prop('checked', true).trigger('change');

                // from station
                var frm_sta = [];
                $.each(option.fromStationList || [], function( key, value ) {
                    frm_sta.push(value.code);
                });
                if(frm_sta.length > 0){
                    $('#tf-frm-station').val(frm_sta).trigger('change');
                }else{
                    $('#tf-frm-station').val('').trigger('change');
                }

                // to station
                var to_sta = [];
                $.each(option.toStationList || [], function( key, value ) {
                    to_sta.push(value.code);
                });
                if(to_sta.length > 0){
                    $('#tf-to-station').val(to_sta).trigger('change');
                }else{
                    $('#tf-to-station').val('').trigger('change');
                }
            } else if (option.routeType.code == 'BRTE') {
                $('input[name=customerTariffRadio][value=BRN]').prop('checked', true).trigger('change');

                // from branch
                var frm_org = [];
                $.each(option.fromOrganizationList || [], function( key, value ) {
                    frm_org.push(value.code);
                });
                if(frm_org.length > 0){
                    $('#tf-frm-branch').val(frm_org).trigger('change');
                }else{
                    $('#tf-frm-branch').val('').trigger('change');
                }

                // to branch
                var to_org = [];
                $.each(option.toOrganizationList || [], function( key, value ) {
                    to_org.push(value.code);
                });
                if(to_org.length > 0){
                    $('#tf-to-branch').val(to_org).trigger('change');
                }else{
                    $('#tf-to-branch').val('').trigger('change');
                }
            }

            $('#tf-hamali').val(option.hamaliCharge);
            $('#tf-docket').val(option.docketCharge);
            $('#tf-door-pick').val(option.doorPickupCharge);
            $('#tf-door-del').val(option.doorDeliveryCharge);

            $.each(option.itemDetailList, function(key, val){
                if(key == 0){
                    $('#article-table tbody #tr_clone').find('#tf-item').val(val.cargoItem.code).trigger('change');
                    $('#article-table tbody #tr_clone').find('#tf-amount').val(val.amount);
                    $('#article-table tbody #tr_clone').find('#tf-uom').val(val.unit.code).trigger('change');
                    $('#article-table tbody #tr_clone').find('#tf-min-unit').val(val.minUnitValue);
                    $('#article-table tbody #tr_clone').find('#tf-add-val').val(val.additionalValue);
                    $('#article-table tbody #tr_clone').find('#tf-loading-ch').val(val.loadingCharge);
                }else{
                    $('.tr_clone:first-child').find('#tf-item').select2('destroy');

                    tr_id = tr_id+1;
                    var cloned_tr = $('.tr_clone:first-child').clone(true);

                    cloned_tr.attr({id: 'tr_clone' + (key+1)});
                    cloned_tr.find('#tf-item').select2();
                    $('.tr_clone:first-child').find('#tf-item').select2();
                    
                    cloned_tr.find('.tr_remove').attr('data-index', key+1);
                    cloned_tr.find('#tf-item').val(val.cargoItem.code).trigger('change');
                    cloned_tr.find('#tf-amount').val(val.amount);
                    cloned_tr.find('#tf-uom').val(val.unit.code).trigger('change');
                    cloned_tr.find('#tf-min-unit').val(val.minUnitValue);
                    cloned_tr.find('#tf-add-val').val(val.additionalValue);
                    cloned_tr.find('#tf-loading-ch').val(val.loadingCharge);

                    $('#article-table>tbody>tr').eq(-2).after(cloned_tr)
                }
            });
        }
    }
    
    function cancelTariffDialog(){
        tr_id = 1;
        $('#article-table tbody .tr_clone').not(':first-child').remove();
        $('#article-table tbody .tr_clone').attr({id: 'tr_clone'});
        $('#article-table tbody .tr_clone').find('.tr_remove').attr('data-index', 1);

        $('#customer-tariff-dialog').dialog('destroy');
        $('#customer-tariff-dialog').hide();
    }

    function addArticleRow(ele){
        $('.tr_clone:first-child').find('#tf-item').select2('destroy');
        tr_id = tr_id+1;    
        var cloned_tr = $('.tr_clone:first-child').clone(true);
        cloned_tr.attr({id: 'tr_clone' + tr_id});
        cloned_tr.find('.tr_remove').attr('data-index', tr_id);
        cloned_tr.find('.clone-field').val('');
        cloned_tr.find('#tf-item').select2();
        $('.tr_clone:first-child').find('#tf-item').select2();

        $('#article-table>tbody>tr').eq(-2).after(cloned_tr);
    }

    function removeArticleRow(ele) {
        if($('#article-table tbody tr').length >2){
            ele.closest('tr').remove();
        }
    }

    function setUOMValue(uomSelect) {
        $(uomSelect).closest('tr').find('#tf-add-val').val('').prop('disabled', uomSelect.value != 'VOLFT')
    }

    function saveTariff(){
        $('.inp_error').removeClass('inp_error');
        var err = 0;

        var data = {}
        data.code = $('#customer-tariff-code').val();
        data.activeFlag = 1;
        data.customerRole = {code:'RC'};

        var sta_stp = 0;
        var type = $('input[name=customerTariffRadio]:checked').val();
        if (type == 'STN') {
            if(($('#tf-frm-station').val() != '' && $('#tf-to-station').val() != '')){
                $.each($('#tf-frm-station').val() || [], function( key, value ) {
                    if(value != ''){
                        var index = $.inArray( value, $('#tf-to-station').val());
                        if( index != -1 ) {
                            alert('From station and to station contains same stations');
                            sta_stp = 1;
                            return false;
                        }
                    }
                });
            }

            if(sta_stp == 1){
                $('.inp_error').removeClass('inp_error');
                $('#customer-tariff-action-state').html('').addClass('none').removeClass('alert-danger');
                return;
            }

            if($('#tf-frm-station').val() == ''){
                data.fromStationList = [];
            }else{
                data.fromStationList = $.map($('#tf-frm-station').val() || [], (to_ven) => ({ code: to_ven }));
            }

            if($('#tf-to-station').val() == ''){
                data.toStationList = [];
            }else{
                data.toStationList = $.map($('#tf-to-station').val() || [], (val) => ({ code: val }));
            }

            data.routeType = {};
            data.routeType.code = 'RTE';
        } else if (type == 'BRN') {
            if(($('#tf-frm-branch').val() != '' && $('#tf-to-branch').val() != '')){
                $.each($('#tf-frm-branch').val() || [], function( key, value ) {
                    if(value != ''){
                        var index = $.inArray( value, $('#tf-to-branch').val());
                        if( index != -1 ) {
                            alert('From branch and to branch contains same branches');
                            sta_stp = 1;
                            return false;
                        }
                    }
                });
            }

            if(sta_stp == 1){
                $('.inp_error').removeClass('inp_error');
                $('#customer-tariff-action-state').html('').addClass('none').removeClass('alert-danger');
                return;
            }

            if($('#tf-frm-branch').val() == ''){
                data.fromOrganizationList = [];
            }else{
                data.fromOrganizationList = $.map($('#tf-frm-branch').val() || [], (to_ven) => ({ code: to_ven }));
            }

            if($('#tf-to-branch').val() == ''){
                data.toOrganizationList = [];
            }else{
                data.toOrganizationList = $.map($('#tf-to-branch').val() || [], (val) => ({ code: val }));
            }
            data.routeType = {};
            data.routeType.code = 'BRTE';
        }

        data.hamaliCharge = $('#tf-hamali').val();
        data.docketCharge = $('#tf-docket').val();
        data.doorPickupCharge = $('#tf-door-pick').val();
        data.doorDeliveryCharge = $('#tf-door-del').val();

        data.itemDetailList = [];
        $.each($('#article-table tbody tr').not(':last-child'), function(){
            var item_detail = {
                activeFlag: 1,
                cargoItem:{code:$(this).find('#tf-item').val()},
                amount:$(this).find('#tf-amount').val(),
                unit:{code:$(this).find('#tf-uom').val()},
                minUnitValue:$(this).find('#tf-min-unit').val(),
                additionalValue:$(this).find('#tf-add-val').val(),
                loadingCharge:$(this).find('#tf-loading-ch').val()
            };
            data.itemDetailList.push(item_detail);
        });
        if(data.hamaliCharge == ''){
            $('#tf-hamali').addClass('inp_error');
            err++;
        }

        if(data.docketCharge == ''){
            $('#tf-docket').addClass('inp_error');
            err++;
        }

        if(data.doorPickupCharge == ''){
            $('#tf-door-pick').addClass('inp_error');
            err++;
        }

        if(data.doorDeliveryCharge == ''){
            $('#tf-door-del').addClass('inp_error');
            err++;
        }

        if (data.itemDetailList.length >= 1) {
            $.each($('#article-table tbody tr').not(':last-child'), function(){
                if($(this).find('#tf-item').val() == ''){
                    $(this).find('#tf-item').addClass('inp_error');
                    err++;
                }

                if($(this).find('#tf-amount').val() == ''){
                    $(this).find('#tf-amount').addClass('inp_error');
                    err++;
                }

                if($(this).find('#tf-uom').val() == ''){
                    $(this).find('#tf-uom').addClass('inp_error');
                    err++;
                }

                if($(this).find('#tf-min-unit').val() == ''){
                    $(this).find('#tf-min-unit').addClass('inp_error');
                    err++;
                }

                if($(this).find('#tf-loading-ch').val() == ''){
                    $(this).find('#tf-loading-ch').addClass('inp_error');
                    err++;
                }
            });
        }
        
        if (err > 0) {
            $('#customer-tariff-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#customer-tariff-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#customer-tariff-action-state').show();
            return false;
        } else {
            $('#customer-tariff-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#customer-tariff-action-state').hide();
        }
        
        $('#customer-tariff-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#customer-tariff-action-state').html(loading_popup);
        $('#customer-tariff-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-customer-tariff",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#customer-tariff-action-state').removeClass('alert-danger');
                    $('#customer-tariff-action-state').addClass('alert-success');
                    $('#customer-tariff-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelTariffDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#customer-tariff-action-state').addClass('alert-danger');
                    $('#customer-tariff-action-state').html(response.errorDesc);
                }
            }
        });        
    }

    function deleteTariff(code){
        if (confirm('Do you want to delete this Tariff?')) {
            var data = code;
            data.activeFlag = 2;
            
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-customer-tariff",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        checkURL();
                    }, 2000);
                }
            });    
        }
    }

    function allArticles(ele) {
        var type = $(ele).val();
        $('#tr_add_btn').removeClass('hide');
        if (type == "ALL") {
            $('#tr_add_btn').addClass('hide');
            $('#article-table tbody tr').not(ele.closest('tr')).not(':last-child').remove();
        }
    }
</script>
{/literal}