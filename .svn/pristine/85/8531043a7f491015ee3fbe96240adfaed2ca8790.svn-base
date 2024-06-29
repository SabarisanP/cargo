<div class="brand_top"><h3>Recharge</h3>
    {if $action_rights['ADD-RECHRG']>0}
        <span class="align-rights">
            {*{if $action_rights['RECHRG-PENDING-ORDR']==1}
                <a href="#report/recharge-pending-order" class="btn btn-default  btn-sm">Pending Order</a>
            {/if}*}

            {if $action_rights['ADD-RECHRG']==1}
                <a href="javascript:;" class="btn btn-success  btn-sm" onclick="rechargeNow();">Recharge Now</a>
            {/if}
        </span>
    {/if} 
</div>

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
                                    <div class="col-md-12">

                                        <div>

                                            <div id="search-panel">                                         
                                                <div class="divide-10"></div>
                                                <form id='test'>
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="date_from" class="form-control sdate" id="date_from" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label class="sr-only" for="date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="date_to" class="form-control sdate" id="date_to" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        {if $action_rights['USR-FILTER-RECHRG']>0}
                                                            <div class="form-group col-md-2">                                                                
                                                                <select id="gru_users" class="form-control" name='gru_users'>
                                                                    <option value="NA">All User</option>
                                                                    {foreach name=o item=row from=$entity}
                                                                        <optgroup label="{$row['groupname']}">
                                                                            {foreach name=o item=usr from=$row["users"]}
                                                                                <option value='{$usr['code']}'>{$usr['name']}</option>
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>                                                                
                                                            </div>
                                                        {else}
                                                            <input type="hidden" value="{$login_user_code}" id="gru_users" id="gru_users">
                                                        {/if}
                                                    </div>

                                                    <div class="row">

                                                        <div class="form-group col-md-2">                                                                
                                                            <select id="trans_mode" class="form-control" name='trans_mode'>
                                                                <option value="NA">All Transaction Mode</option>
                                                                {foreach name=o key=k item=name from=$f_t_mode}
                                                                    <option value="{$k}">{$name}</option>
                                                                {/foreach} 
                                                            </select>                                                                
                                                        </div>

                                                        <div class="form-group col-md-2">                                                                
                                                            <select id="acknowledment_status" class="form-control" name='acknowledment_status'>
                                                                <option value="NA">All Acknowledment Status</option>
                                                                {foreach name=o key=k item=name from=$f_a_status}
                                                                    <option value="{$k}">{$name}</option>
                                                                {/foreach} 
                                                            </select>                                                                
                                                        </div>

                                                        <div class="col-md-2">
                                                            <button class="btn btn-success" type="button"  onclick="searchReport();">Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearReport();">Clear</button>
                                                        </div>     
                                                    </div>

                                                </form>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="usr-action-state"></div>
                                            </div>


                                            <!-- recharge -->

                                            <div class="clear_fix_both"></div>

                                            <div id="recharge-dialog" class="hide dialog-content-page">
                                                <div class="">
                                                    <form role="form" id="form1" class="form-horizontal ">

                                                        <div class="col-lg-6 p_l_n">
                                                            <div>
                                                                <label for="txt_m_name" class="req">Recharge to User</label>
                                                                {if $action_rights['USR-FILTER-RECHRG']>0}
                                                                    <select id="user" class="form-control col-md-6">
                                                                        <option value="">Select a user</option>
                                                                        {foreach name=o item=row from=$entity}
                                                                            <optgroup label="{$row['groupname']}">
                                                                                {foreach name=o item=usr from=$row["users"]}
                                                                                    <option value='{$usr['code']}'>{$usr['name']}</option>
                                                                                {/foreach}
                                                                            </optgroup>
                                                                        {/foreach}
                                                                    </select>
                                                                {else}
                                                                    <div class="col-md-6">
                                                                        {$usr_login_name}
                                                                    </div>
                                                                    <input type="hidden" value="{$login_user_code}" id="user">
                                                                {/if}
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-6 p_l_n">
                                                            <div>
                                                                <label for="txt_m_name" class="req">Transaction Mode</label>
                                                                <select id="t_mode" class="form-control col-md-6">
                                                                    <option value="">Select a mode</option>
                                                                    {foreach name=o item=row from=$t_mode}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach} 
                                                                </select>
                                                            </div>
                                                        </div>


                                                        <div class="clear_fix_both"></div>
                                                        <br />


                                                        <div class="col-lg-6 p_l_n">

                                                            <label for="txt_l_name" class="req">Amount Received Date</label>
                                                            <div class="input-group">
                                                                <input  placeholder="Date Received" id="Rdate" name="Rdate"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="col-lg-6 p_l_n">
                                                            <div>
                                                                <label for="txt_m_name" class="req">Amount</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                                                                    <input  placeholder="Amount" id="amt" name="amt"  class="form-control">                                                                    
                                                                </div>
                                                            </div>
                                                        </div>

                                                        {*<div class="col-lg-6 p_l_n hide">
                                                        <div>
                                                        <label for="txt_m_name">Name</label>
                                                        <input  placeholder="Name" id="name" name="name"  class="form-control">
                                                        </div>
                                                        </div>*}


                                                        <div class="clear_fix_both"></div>
                                                        <br />    


                                                        <div class="col-lg-12 p_l_n">
                                                            <div>
                                                                <label for="txt_m_name">Remarks</label>
                                                                <textarea id="remark"  placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="2" cols="10" name="remark" id="remark"></textarea>
                                                            </div>
                                                        </div>

                                                        <div class="clear_fix_both"></div>
                                                        <br />    
                                                    </form>
                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <div class="clear_fix_both">                       
                                                    <div class="alert fl suc_cre" style="display: none;" id="recharge-action-state"></div>
                                                    <div class="align-right cre_sve" id="form-bttons">
                                                        <button class="btn btn-success" type="button" onclick="saveRecharge();">Save</button>
                                                        <button class="btn btn-default" type="button" onclick="cancelRecharge();">Cancel</button>
                                                    </div>
                                                </div> 
                                            </div>
                                            <!-- recharge end -->
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="recharge-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="rpt_lst"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>                                            

                </div>                    
            </div>                
        </div>
    </div></div>

{if $action_rights['USR-FILTER-RECHRG']>0}
    <script>
        $('#user').select2();
        $('#gru_users').select2();
    </script>
{/if}
<script>

    function rechargeNow() {

        $('.inp_error').removeClass('inp_error');
        $('#recharge-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#recharge-action-state').hide();
        $('#recharge-dialog').css('background', '#fff');
        $('#recharge-dialog').removeClass('hide');
        $('#recharge-dialog').dialog({
            autoOpen: true,
            height: 450,
            width: 600,
            modal: true,
            resizable: false,
            open: function () {
                if ($.ui && $.ui.dialog && !$.ui.dialog.prototype._allowInteractionRemapped && $(this).closest(".ui-dialog").length) {
                    if ($.ui.dialog.prototype._allowInteraction) {
                        var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
                        $.ui.dialog.prototype._allowInteraction = function (e) {
                            if ($(e.target).closest('.select2-drop').length)
                                return true;
                            return ui_dialog_interaction.apply(this, arguments);
                        };
                        $.ui.dialog.prototype._allowInteractionRemapped = true;
                    }
                }
            },
            _allowInteraction: function (event) {
                return !!$(event.target).is(".select2-input") || this._super(event);
            }
        });
        $(".ui-dialog-titlebar").hide();

        $('#form-bttons').show();
        $('#org-form-action-state').html('');
        $('#org-form-action-state').hide();
        $('.inp_error').removeClass('inp_error');

        $('#form1').trigger("reset");
        $('#user').val('').trigger('change');

    }
    function cancelRecharge() {
        $('#recharge-dialog').dialog('destroy');
        $('#recharge-dialog').hide();

    }


    $(document).ready(function () {
        $('#Rdate').datepicker({
            todayHighlight: true,
            startDate: '-3m',
            format: 'yyyy-mm-dd',
            autoclose: true
        });
        $('#date_from').datepicker({
            todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#date_to').datepicker('setStartDate', e.date);
            $("#date_to").datepicker("setEndDate", end)
        });
        $('#date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#date_from').datepicker('setEndDate', e.date)
        });

    });

    function saveRecharge() {
        var data = {};

        data.activeFlag = 1;
        data.Rdate = $('#Rdate').val();
        data.amt = $('#amt').val();
        data.name = $('#name').val();
        data.t_mode = $('#t_mode').val();
        data.user = $('#user').val();
        data.remark = $('#remark').val();

        var err = 0;
        if ($('#Rdate').val() == '') {
            $('#Rdate').addClass('inp_error');
            err++;
        } else {
            $('#Rdate').removeClass('inp_error');
        }
        if ($('#t_mode').val() == '') {
            $('#t_mode').addClass('inp_error');
            err++;
        } else {
            $('#t_mode').removeClass('inp_error');
        }
        if ($('#user').val() == '') {
            $('#user').addClass('inp_error');
            err++;
        } else {
            $('#user').removeClass('inp_error');
        }
        if ($('#amt').val() == '') {
            $('#amt').addClass('inp_error');
            err++;
        } else {
            $('#amt').removeClass('inp_error');
        }

        if (Number(data.amt) <= 0) {
            $('#amt').addClass('inp_error');
            err++;
        } else {
            $('#amt').removeClass('inp_error');
        }

        if (err > 0) {
            $('#recharge-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#recharge-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#recharge-action-state').show();
            return false;
        } else {
            $('#recharge-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#recharge-action-state').hide();
        }

        if (Number($('#amt').val()) > 5000000) {
            $('#amt').addClass('inp_error');
            $('#recharge-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#recharge-action-state').html('Sorry! Maximum recharge amount per transaction is 50L');
            $('#recharge-action-state').show();
            return false;
        } else {
            $('#amt').removeClass('inp_error');
        }

        $('#form-bttons').hide();
        $('#recharge-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#recharge-action-state').html(loading_popup);
        $('#recharge-action-state').show();
        console.log(data);
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-recharge",
            data: data,
            success: function (response) {

                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#recharge-action-state').removeClass('alert-danger');
                    $('#recharge-action-state').addClass('alert-success');
                    $('#recharge-action-state').html('Recharge request added successfully and waiting for approval.');
                    window.setTimeout(function () {
                        cancelRecharge();
                        // checkURL();
                        // return;
                    }, 3000);
                } else {
                    $('#recharge-action-state').addClass('alert-danger');
                    $('#recharge-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        })
    }

    function searchReport() {
        $('#rpt_lst').html('');
        var data = {};
        data.gru_users = $('#gru_users').val();
        data.date_from = $('#date_from').val();
        data.date_to = $('#date_to').val();

        data.trans_mode = $('#trans_mode').val();
        //data.trans_type = $('#trans_type').val();
        data.acknowledgementStatus = $('#acknowledment_status').val();

        var err = 0;
        /*if (data.user == '') {
         $('#gru_users').addClass('inp_error');
         err++;
         } else {
         $('#gru_users').removeClass('inp_error');
         }*/
        if (data.date_from == '') {
            $('#date_from').addClass('inp_error');
            err++;
        } else {
            $('#date_from').removeClass('inp_error');
        }

        if (data.date_from == '') {
            if (data.date_to == '') {
                $('#date_to').addClass('inp_error');
                err++;

            } else {
                $('#date_to').removeClass('inp_error');
            }
        }

        if (data.date_from != '') {
            if (data.date_to == '') {
                $('#date_to').removeClass('inp_error');
                var d = new Date();

                var month = d.getMonth() + 1;
                var day = d.getDate();

                var output = d.getFullYear() + '-' +
                        (('' + month).length < 2 ? '0' : '') + month + '-' +
                        (('' + day).length < 2 ? '0' : '') + day;

                data.date_to = output;
                $('#date_to').val(output);
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
        }
        var html = "";
        $('#date_to').removeClass('inp_error');
        $('#recharge-list-container').removeClass('hidden');
        $('#rpt_lst').html(loading_popup);
        console.log(data);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/get-recharge-list",
            data: data,
            success: function (response) {
                $('#rpt_lst').html(response);
            }
        })
    }

    function clearReport() {
        $('#rpt_lst').html('');
        $('.inp_error').removeClass('inp_error');
        $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-action-state').html('');
        $('#usr-action-state').hide();
        $('#recharge-list-container').addClass('hidden');
    }


</script>