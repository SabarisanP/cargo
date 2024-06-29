<div class="brand_top">
    <h3>Fare Rule</h3>
    <div class="text-right noprint">        
        <button class="btn btn-success" onclick="addNewFareRule();">Add New Rule</button>        
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel-body">

                                    <form id="farerulefrm" method="post" name="farerulefrm" action="">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <label class="req">Fare Rule</label>                                                
                                                <select id="farerules" name="farerules"  class="form-control" >
                                                    <option value="">Loading...</option>                                                                                                                     
                                                </select>
                                            </div> 
                                            <div class="col-md-2">
                                                <label >From Station</label>                                                
                                                <select id="fare-from" name="farerules"  class="form-control" >
                                                    <option value="NA">All Stations</option>
                                                    {foreach name=o item=row from=$stations}
                                                        <option value="{$row->code}" >{$row->name}</option>
                                                    {/foreach}                                                                                                                
                                                </select>
                                            </div> 
                                            <div class="col-md-2">
                                                <label >To Station</label>                                                
                                                <select id="fare-to" name="farerules"  class="form-control" >
                                                    <option value="NA">All Stations</option>
                                                    {foreach name=o item=row from=$stations}
                                                        <option value="{$row->code}">{$row->name}</option>
                                                    {/foreach}                                                                                                                    
                                                </select>
                                            </div> 

                                            <div class="col-md-2">
                                                <label >&nbsp;</label>   
                                                <button class="btn btn-success" type="button"  onclick="getFaresList();">Get Rules</button>
                                                <button type="button" class="btn btn-default btn-clear" onclick="clearFareForm();">Clear</button>                                                                                           
                                            </div>
                                        </div>
                                    </form>

                                </div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>

                    <div class="row hidden" id="fares-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="fares"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>

<div id="fare-rule-dialog" class="hide dialog-content-page">
    <form role="form" id="fare-rule-update-form"class="form-horizontal " onsubmit="return false;">
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="fare-rule-name" class="req">Name</label>
                <input id="fare-rule-name" class="form-control"/>
            </div>
        </div>
        <div class="clear_fix_both"></div> <br>
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="fare-rule-state" class="req">State</label>
                <select id="fare-rule-state" class="form-control">
                    <option value="">Select State</option>
                    {foreach from=$states item=row}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="col-lg-12 p_l_n p_r_n">
            <div class="clear_fix_both"></div> <br>
            <div class="alert fl col-md-12" style="display: none;" id="fare-rule-action-state"></div>
        </div>
    </form>
    <div class="row">
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" id="hid-fare-rule-code">
            <button class="btn btn-success" type="button" onclick="saveFareRule();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelFareRuleDialog();">Cancel</button>
        </div>
    </div>
</div>

<iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe>

{literal}
    <script>
        $('#fare-rule-state, #fare-from, #fare-to').select2();

        function getFareRules() {
            var data = {};
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'config/fare-rule-list',
                data: data,
                success: function (response) {
                    var html = '<option value="" >Choose a rule</option>';
                    if (response.length > 0) {
                        $(response).each(function (i) {
                            html += '<option value="' + response[i].code + '" > ' + response[i].name + ' </option>'
                        });
                    }
                    $('#farerules').html(html);
                }
            });
        }
        getFareRules();

        function getFaresList() {
            var data = {};
            data.rulecode = $('#farerules').val();
            data.fromStationCode = $('#fare-from').val();
            data.toStationCode = $('#fare-to').val();
            
            if(data.rulecode == '') {
                $('#farerules').addClass('inp_error');
                return;
            } else {
                $('#farerules').removeClass('inp_error');
            }
            
            $('#fares-container').removeClass('hidden');
            $('#fares').html(loading_popup);
            
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'config/fare-rule-farelist',
                data: data,
                success: function (response) {
                    $('#fares').html(response);
                }
            });
        }

        function addNewFareRule(code) {
            $('.inp_error').removeClass('inp_error');
            $('#fare-rule-action-state').hide();
            $('#fare-rule-dialog').css('background', '#fff');
            $('#fare-rule-dialog').removeClass('hide');
            $('#fare-rule-dialog').dialog({
                autoOpen: true,
                height: 320,
                width: 500,
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

            if (_isdefined(code)) {
                var data = sectorData[code];
                $('#fare-rule-name').val(data.name);
                $('#fare-rule-state').val(data.state.code);
                $('#hid-fare-rule-code').val(data.code);
            } else {
                $('#fare-rule-name').val('');
                $('#fare-rule-state').val('');
                $('#hid-sector-code').val('');
            }
        }

        function saveFareRule() {
            var data = {};
            data.activeFlag = 1;
            data.code = $.trim($('#hid-sector-code').val());
            data.name = $.trim($('#fare-rule-name').val());
            data.state = {};
            data.state.code = $('#fare-rule-state').val();

            var err = 0;
            if (data.name == '') {
                $('#fare-rule-name').addClass('inp_error');
                err++;
            } else {
                $('#fare-rule-name').removeClass('inp_error');
            }

            if (data.state.code == '') {
                $('#fare-rule-state').addClass('inp_error');
                err++;
            } else {
                $('#fare-rule-state').removeClass('inp_error');
            }

            if (err > 0) {
                $('#fare-rule-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#fare-rule-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#fare-rule-action-state').show();
                return false;
            } else {
                $('#fare-rule-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#fare-rule-action-state').hide();
            }

            $('#form-bttons').hide();
            $('#fare-rule-action-state').removeClass('alert-danger').removeClass('alert-success');
            $('#fare-rule-action-state').html(loading_popup);
            $('#fare-rule-action-state').show();

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/update-fare-rule",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        getFareRules();
                        $('#form-bttons').hide();
                        $('#fare-rule-action-state').removeClass('alert-danger');
                        $('#fare-rule-action-state').addClass('alert-success');
                        $('#fare-rule-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                            cancelFareRuleDialog();
                            checkURL();
                            return;
                        }, 3000);
                    } else {
                        $('#fare-rule-action-state').addClass('alert-danger');
                        $('#fare-rule-action-state').html(response.errorDesc);
                        $('#form-bttons').show();
                    }
                }
            });
        }

        function cancelFareRuleDialog() {
            
            $('#fare-rule-dialog').dialog('destroy');
            $('#fare-rule-dialog').hide();
        }
        
        function clearFareForm() {
            $('.inp_error').removeClass('inp_error');
            $('#farerules').val('').trigger('change');
            $('#fare-from, #fare-to').val('NA').trigger('change');
            $('#fares-container').addClass('hidden');
            $('#fares').html('');
        }
    </script>
{/literal}