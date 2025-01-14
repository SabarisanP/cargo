<div class="brand_top"><h3>Rate Terms</h3></div>
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
                                    <div class="table-responsive">
                                        <table id="cargo_item_table" class="table table-bordered">
                                            <thead>
                                                <tr class="success">
                                                    <th>From</th>
                                                    <th>To</th>
                                                    <th>Distance</th>
                                                    <th>Rate Per Kg/km</th>
                                                    <th>Minimum Weight</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                <tr id="tr-rate-term-form">
                                                    <td width="20%">
                                                        <select id="from_branch" name="from_branch"  class="form-control from-branch" onclick="toggleToBranch('', '');">
                                                            <option value='' selected = 'selected'>From Branch</option>
                                                            {foreach item=branch from=$fromBranches key=bcode}
                                                                <option value="{$bcode}" {if $userDetail['login_branch']==$bcode} selected='selected' {/if}>{$branch}</option>
                                                            {/foreach}
                                                        </select>
                                                        <span class="from-ele"></span>
                                                    </td>
                                                    <td width="20%">
                                                        <select id="to_branch" name="to_branch"  class="form-control to-branch">
                                                            <option value="">To Branch</option>                                                            
                                                        </select>
                                                        <span class="to-ele"></span>
                                                    </td>
                                                    <td width="10%">
                                                        <input type="text" class="form-control rt-distance " maxlength="5" placeholder="Distance" value="" data-key="Distance">
                                                    </td>
                                                    <td width="10%">
                                                        <input type="text" class="form-control rt-kg" maxlength="5" placeholder="Rate per Kg" value="" data-key="Distance">
                                                    </td>
                                                    <td width="10%">
                                                        <input type="text" class="form-control rt-weight" maxlength="5" placeholder="Min Weight" value="" data-key="Distance">
                                                    </td>
                                                    <td width="15%">
                                                        <input type="hidden" name="code" id="code"/>
                                                        <div style="display: none;" class="rate-term-action-state"></div>
                                                        <div>
                                                            <button class="btn btn-success" type="button" onclick="saveRateTerms(this);">Save</button>
                                                            <a href="javascript:;" onclick="addRateTerm()" title="close" class="btn btn-default btn-xs btn-close" style="display: none;"><i class="fa fa fa-times"></i></a>
                                                        </div>
                                                    </td>
                                                </tr>
                                                {foreach item=row from=$result key=k}
                                                    <tr id='item_{$row->fromOrganization->code}_{$row->toOrganization->code}'>
                                                        <td width="20%">{$row->fromOrganization->name}</td>
                                                        <td width="20%">{$row->toOrganization->name}</td>
                                                        <td width="10%">{$row->distance} &nbsp;KMs</td>
                                                        <td width="10%">Rs. {$row->ratePerKg}</td>
                                                        <td width="10%">{$row->minimumWeight}&nbsp;KGs</td>
                                                        <td width="15%">
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not edat" title="Edit" onclick='editRateTerm(this,{$row|@json_encode});'><i class="fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not delam" title="Delete" onclick='deleteRateTerms({$row|@json_encode})'><i class="fa fa-trash-o ired"></i></a>
                                                        </td>
                                                    </tr>
                                                <div id="notify_mes_{$row->code}" style="display:none">{$row->description}</div>
                                            {/foreach} 
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="clear_fix_both"></div>
                                
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>


<script>
    var branchRoutes = {$branchRoutes|json_encode};
    var deliveryBranch = {$delivery_branches|json_encode};
    addRateTerm();
    {literal}
    function toggleToBranch(fromCode, toCode) {
        var fromBranchCode = '';
        var toBranchCode = '';
        var selected = "selected = selected";
        if (fromCode == '') {
            fromBranchCode = $('#from_branch').val();
        } else if ((fromCode != '') && (toCode != '')) {
            fromBranchCode = fromCode;
            toBranchCode = toCode;
        }

        var toBranches = [];
        var tbhtml = '<option value="">To Branch</option>';
            if (fromBranchCode) {
                var route = _.find(branchRoutes, i => i.code == fromBranchCode);
                $.each(deliveryBranch[fromBranchCode] || [], function (fromOrganizationCode, toBranchesCodes) { 
                     toBranches.push(toBranchesCodes);
                     $.each(branchRoutes, function (index, allBranches) { 
                         if(allBranches.code == toBranchesCodes){
                            tbhtml += '<option value="' + allBranches.code + '"+>' + allBranches.name + '</option>';
                         }
                     });
                });
                
            } else {
            };
        $("#to_branch").select2("destroy");
        $('#to_branch').html(tbhtml);
        $("#to_branch").select2({
            width: 'resolve',
            dropdownParent: $('#cargo-item-dialog')
        });
        if (toBranchCode != '') {
            $('#to_branch').val(toBranchCode);
            $('#to_branch').trigger('change');
        }
    }
{/literal}
    
    function editRateTerm(el,option){
        var $tr = $(el).closest('tr');
        
        var $formtr = $('#tr-rate-term-form');
        $formtr.find(':input').val('');
        $formtr.find(':input').removeClass('inp_error');
        $formtr.find('.rate-term-action-state').html(''); 
        $formtr.find('input.rt-weight').val(option.minimumWeight);
        $formtr.find('input.rt-distance').val(option.distance);
        $formtr.find('input.rt-kg').val(option.ratePerKg);
        $formtr.find('select.from-branch').val(option.fromOrganization.code).trigger('change');
        
        $formtr.find('select.to-branch').val(option.toOrganization.code).trigger('change');
        toggleToBranch(option.fromOrganization.code , option.toOrganization.code);
        $formtr.find('.btn-close').show();
        
       $('#cargo_item_table tbody tr.hidden').removeClass('hidden');
        $tr.after($formtr).addClass('hidden');
        $formtr.find('input[data-key]:first').focus();
        
        $formtr.find('select.from-branch, select.to-branch').addClass('hide');
        $formtr.find('span.to-ele').html(option.toOrganization.name);
        $formtr.find('span.from-ele').html(option.fromOrganization.name);
    
    }
    function addRateTerm() {
        $('#from_branch').select2("destroy");
        $('#from_branch').select2({
            width: 'resolve',
            dropdownParent: $('#cargo-item-dialog')
        });
        $('#rt_kg,#rt_distance,#rt_weight,#from_branch,#to_branch').val('');
        $('#from_branch').val($('#from_branch option:eq(0)').val()).trigger('change');
        $('#to_branch').val($('#to_branch option:eq(0)').val()).trigger('change');
        var $formtr = $('#tr-rate-term-form').detach();
        $formtr.find(':input').val('').trigger('change');
        $formtr.find(':input').removeClass('inp_error');
        $formtr.find('.btn-close').hide();
        $formtr.find('span.from-ele').html('');
        $formtr.find('span.to-ele').html('');
        $formtr.find('select.from-branch, select.to-branch').removeClass('hide');
        $formtr.find('.rate-term-action-state').html(''); 
        $('#cargo_item_table tbody').prepend($formtr);
        $('#cargo_item_table tbody tr.hidden').removeClass('hidden');
    }    
    function saveRateTerms(el){
        var err = 0;
        
        $('#cargo_item_table .inp_error').removeClass('inp_error');
        
        var $tr = $(el).closest('tr');
        var data = {};
        data.activeFlag = 1;
        data.ratePerKg = $('input.rt-kg').val();
        data.distance = $('input.rt-distance').val();
        data.minimumWeight = $('input.rt-weight').val();
        data.fromcode = $tr.find('select.from-branch').val();
        data.tocode = $tr.find('select.to-branch').val();
        
        if (data.fromcode == '') {
            $tr.find('select.from-branch').addClass('inp_error');
            err++;
        }
        if (data.tocode == '') {
            $tr.find('select.to-branch').addClass('inp_error');
            err++;
        }
        if (data.minimumWeight == '') {
            $tr.find('input.rt-weight').addClass('inp_error');
            err++;
        }
        if (data.distance == '') {
            $tr.find('input.rt-distance').addClass('inp_error');
            err++;
        }
        if (data.ratePerKg == '') {
            $tr.find('input.rt-kg').addClass('inp_error');
            err++;
        }
        if(data.ratePerKg > 99.9){
            $tr.find('input.rt-kg').addClass('inp_error');
            $tr.find('.rate-term-action-state').removeClass('alert-success').addClass('alert-danger');
            $tr.find('.rate-term-action-state').html('Maximum rate per km is 99.9 Rs');
            $tr.find('.rate-term-action-state').show();
            return false;
        }
        if (err > 0) {
            $tr.find('.rate-term-action-state').removeClass('alert-success').addClass('alert-danger');
            $tr.find('.rate-term-action-state').html('Please enter/select the values in the field that are marked in red');
            $tr.find('.rate-term-action-state').show();
            return false;
        }

        $tr.find('.rate-term-action-state').removeClass('alert-danger').removeClass('alert-success');
        $tr.find('.rate-term-action-state').html(loading_popup);
        $tr.find('.rate-term-action-state').show();
        $tr.find('.btn-save').hide();
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-rate-terms",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $tr.find('.rate-term-action-state').removeClass('text-danger');
                    $tr.find('.rate-term-action-state').addClass('text-success');
                    $tr.find('.rate-term-action-state').html('Success').show();
                    setTimeout(function () {
                        checkURL();
                        return;
                    }, 2000);

                } else {
                    $tr.find('.rate-term-action-state').addClass('text-danger');
                    $tr.find('.rate-term-action-state').html(response.errorDesc).show();
                }
            }
        });
            
    }

    function deleteRateTerms(options) {
        if (confirm('Do you want to delete this item ?')) {
            var data = {};
            data.ratePerKg = options.ratePerKg;
            data.distance = options.distance;
            data.activeFlag = 2;
            data.minimumWeight = options.minimumWeight;
            data.fromcode = options.fromOrganization.code;
            data.tocode = options.toOrganization.code;

            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-rate-terms",
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
                        return;
                    }, 2000);
                }
            })
        }
    }

</script>    