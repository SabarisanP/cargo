<div class="brand_top">
    <h3>Inventory</h3>
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="editInventory();">Add New Inventory</a>
    </span>
</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="content1" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">

                                <div class="panel-body">

                                    <div id="user-result-panel">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="align-center" id="user-action-status"></div>
                                                <div id="user-address-book" class="col-md-4">
                                                    <ul class="user_list " id="user_list_search">
                                                        <li class="hide amt-db"  >
                                                            <span class="sp_name col-xs-4"><a href="javascript:;" ></a></span>
                                                            <span class="sp_name1 col-xs-3" style='display:none'></span>
                                                            <span class="sp_status col-xs-2">
                                                                <span class="label label-success" id="lb">Active</span>
                                                            </span>
                                                            <span  class="sp_action col-md-6">
                                                                <div class="btn-group btn-group-xs">
                                                                    <a href="javascript:;" class="btn btn-default btn-sm edsts" title="Status" onclick="editProviderStatus('{$row->code}', '{$row->name}')">
                                                                        <i class="fa fa-times" id="sta" data-status="0"  title="Click to disable"></i>
                                                                    </a> 
                                                                    <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick="editInventoryStatus('{$row->code}', this)" data-status="{$row->activeFlag}">
                                                                        {if $row->activeFlag==0}
                                                                            <i class="fa fa-times" title="Click to disable"></i>
                                                                        {else}
                                                                            <i class="fa fa-check" title="Click to enable"></i>
                                                                        {/if}
                                                                        <i class="fa fa-pencil igreen"></i></a>
                                                                    <a href="javascript:;" class="btn btn-default btn-sm delam" title="Delete" onclick="deleteInventory('{$row->code}')"><i class="fa fa-trash-o ired"></i></a>

                                                                </div>
                                                            </span>
                                                        </li> 
                                                        {if count($inventory) > 0}
                                                            {foreach name=o item=row from=$inventory}
                                                                <li id="int-{$row->code}"  >
                                                                    <span class="sp_name col-xs-4"><a href="javascript:;" onclick="editInventoryGroup('{$row->code}');" id="{$row->code}"  title="Click to view group  details">{$row->name}</a></span>
                                                                    <span class="sp_name1 col-xs-3" style='display:none'>{$row->name}</span>
                                                                    <span class="sp_status col-xs-2">
                                                                        {if $row->activeFlag==1}
                                                                            <span class="label label-success" id="lb-{$row->code}">Active</span>
                                                                        {else}
                                                                            <span class="label label-danger" id="lb-{$row->code}">Disabled</span>    
                                                                        {/if}    
                                                                    </span>
                                                                    <span  class="sp_action col-xs-6">
                                                                        <div class="btn-group btn-group-xs">
                                                                            <a href="javascript:;" class="btn btn-default btn-sm est"  onclick="editInventoryStatus('{$row->code}', this)" data-status="{$row->activeFlag}">
                                                                                {if $row->activeFlag==1}
                                                                                    <i class="fa fa-times" title="Click to disable"></i>
                                                                                {else}
                                                                                    <i class="fa fa-check" title="Click to enable"></i>
                                                                                {/if}
                                                                            </a>
                                                                            <a href="javascript:;" title="edit" class="btn btn-default btn-sm edat" {if $row->activeFlag==0}style='display:none'{/if} id='inv_edt_{$row->code}' onclick='editInventory("{$row->code}")'><i class="fa fa fa-pencil igreen"></i></a>
                                                                            <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick="deleteInventory('{$row->code}')"><i class="fa fa-trash-o ired"></i></a>                                                                           </div>
                                                                    </span>
                                                                </li> 
                                                            {/foreach} 
                                                        {else}
                                                            <div class="well well-large ">No inventory found!</div>
                                                        {/if}  
                                                    </ul>

                                                </div>
                                                <div class="col-md-8" id="inventory-group">
                                                    {if count($inventory) > 0}
                                                        <div class="p_t_100">
                                                            <div class="well well-large "> Click any of the inventory name to view group details.</div>
                                                        </div>
                                                    {/if} 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>                               



                                <div class="clear_fix_both"></div>
                                <div id="inventory-dialog" style="display: none" class="dialog-content-page">
                                    <form role="form" id="form1" class="form-horizontal ">
                                        <div class="form-group">
                                            <div>
                                                <label for="txt_in_name" class="req">Inventory name</label>
                                                <input  placeholder="Inventory name" id="txt_in_name" name="txt_in_name"  class="form-control">
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <div>
                                                <label for="namespace" class="req">Namespace name</label>
                                                <select id="namespace" class="form-control">
                                                    <option value="">--Select--</option>
                                                    {foreach item=nb from=$namespaces}
                                                        <option value="{$nb->code}">{$nb->name}</option>
                                                    {/foreach}   
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="form-group pd_tp_23">
                                            <label class="col-sm-2 control-label api-tk" for="name">API Token</label>
                                            <div class="col-sm-6">
                                                <label class="col-xs-4 mob control-label lab_tkn" for="group" style="text-align:justify"><span class="light-txt" id="tkn_txt">{$pro_usr->apiToken}</span></label>
                                                <input type="text" placeholder="New API Token" id="token" class="form-control" value="" maxlength="15">
                                            </div>
                                            <div class="col-sm-3 pd_lt_31" id="edit-token-bttons">
                                                <a href="javascript:;" class="btn btn-default btn-sm edat" data-toggle="tooltip" id="tkn_edt" title="Edit" onclick='tknEdit()'><i class="fa fa-pencil igreen"></i></a>
                                                <button class="btn btn-success token_btn" type="button" onclick="UpdateToken();">Check Token</button>
                                            </div>
                                        </div>
                                        <div id="opr-lst" class="form-group"></div>

                                        <div class="clear_fix_both"></div><br />
                                        <div class="clear_fix_both">                       
                                            <div class="alert pull-left" style="display: none;" id="inventory-loading"></div>
                                            <div class="alert pull-left" style="display: none;" id="inventory-form-action-state"></div>
                                            <div class="align-right" id="inventory-bttons">
                                                <input type="hidden" name="in_id_code" id="in_id_code" value="" />
                                                <input type="hidden" name="activeFlag" id="activeFlag" value="1" />
                                                <button class="btn btn-success" type="button" onclick="saveInventory();">Save</button>
                                                <button class="btn btn-default" type="button" onclick="cancelInventory();">Cancel</button>
                                            </div>
                                        </div> 
                                    </form>
                                </div>



                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>

<script>
    $('select.form-select').select2({
        placeholder: "Select group",
        escapeMarkup: function (markup) {
            return markup;
        }
    });
    var inventory = {$inventory|json_encode};
    var namespace = {$namespaces|json_encode};
</script>
<script>
    $(document).ready(function () {
        $('#dpStart').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd'
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#dpEnd').datepicker('setStartDate', e.date);
            $("#dpEnd").datepicker("setEndDate", end)
        });
        $('#dpEnd').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
        }).on('changeDate', function (e) {
            $('#dpStart').datepicker('setEndDate', e.date)
        });
    });
</script>
{literal}
    <script>
        $('#token').hide();
        $('.token_btn').hide();
        $(function () {
            $("[data-toggle='tooltip']").tooltip();
        });
        function tknEdit() {
            $('.pd_lt_31').addClass('pd_lts_31').removeClass('pd_lt_31');
            $('.mr_17').addClass('mr_27').removeClass('mr_17');
            $('#token').show();
            $('#token').focus();
            $('.token_btn').show();
            $('.api-tk').addClass('req');
            $('#tkn_edt').hide();
            $('.lab_tkn').hide();
            $('#edit-token-bttons').show();
        }

        function rechargeUsr(option) {

            $('#recharge-usr-dialog').css('background', '#fff');
            $('#recharge-usr-dialog').removeClass('hide');
            $('#recharge-usr-dialog').dialog({
                autoOpen: true,
                height: 220,
                width: 700,
                modal: true,
                resizable: false
            });
            $(".ui-dialog-titlebar").hide();
            $('#form-bttons').show();
            $('#recharge-usr-action-state').html('');
            $('#recharge-usr-action-state').hide();
            $('.inp_error').removeClass('inp_error');
        }


        function cancelRecharge() {
            $('#recharge-usr-dialog').dialog('destroy');
            $('#recharge-usr-dialog').hide();

        }
        function usrRecharge() {
            var data = {};

            data.amount = $('#amount').val();
            data.gateway = $('#gateway').val();

            var err = 0;
            if ($('#amount').val() == '') {
                $('#amount').addClass('inp_error');
                err++;
            } else {
                $('#amount').removeClass('inp_error');
            }

            if ($('#gateway').val() == '') {
                $('#gateway').addClass('inp_error');
                err++;
            } else {
                $('#gateway').removeClass('inp_error');
            }


            if (err > 0) {
                $('#recharge-usr-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#recharge-usr-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#recharge-usr-action-state').show();
                return false;
            } else {
                $('#recharge-usr-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#recharge-usr-action-state').hide();
            }

            $('#form-bttons').hide();
            $('#recharge-usr-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#recharge-usr-action-state').html(loading_popup);
            $('#recharge-usr-action-state').show();

            $.ajax({
                type: "POST",
                dataType: 'json',
                //   url: base_url + "config/usr-recharge",
                data: data,
                success: function (response) {

                    if (response.status == 1) {

                    } else {
                        $('#recharge-usr-action-state').addClass('alert-danger');
                        $('#recharge-usr-action-state').html(response.errorDesc);
                        $('#form-bttons').show();
                    }
                }
            })
        }



    </script>
{/literal}
