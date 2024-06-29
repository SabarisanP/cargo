<div class="brand_top">
    <h3>Items</h3>
    <div class="text-right">
        <button class="btn btn-default" onclick="exportCargoItemsExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-success  btn-sm" onclick="cargoItemDialog();">Add New Item</button>
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
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table id="cargo_item_table" class="table table-bordered">
                                            <thead>
                                                <tr class="success">
                                                    <th>#</th>
                                                    <th>Name</th>
                                                    <th>Description</th>
                                                    <th>GST Exemption</th>
                                                    <th>Default Handling Rate</th>
                                                    <th>Default Rate</th>
                                                    <th>Minimum Freight Amount</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody class="body_table">
                                                {foreach item=row from=$items key=k}
                                                    <tr id='item_{$row->code}'>
                                                        <td style='width:50px'>{$k+1}</td>
                                                        <td style='width:50px'>{$row->name}</td>
                                                        <td style='width:100px'>
                                                            <a id="popup_msg" 
                                                                data-content='<ul class="p_l_15">
                                                                {foreach from=$row->description item=desc}
                                                                    <li>{$desc|replace:"'":'"'}</li>
                                                                {/foreach}
                                                                </ul>'>
                                                                {if $row->description[0]}
                                                                    {$row->description[0]|truncate:30} <span class="badge badge-info">{$row->description|@count}</span>
                                                                {else}
                                                                    -
                                                                {/if}
                                                            </a></td>
                                                        <td style='width:50px'>{($row->gstExemptedFlag) ? 'Yes' : 'No'}</td>
                                                        <td style='width:50px'>{$row->defaultHandlingRate}</td>
                                                        <td style='width:50px'>{$row->defaultRate}</td>
                                                        <td style='width:50px'>{$row->minFreightAmount}</td>
                                                        <td style="width:100px">
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not edat" title="Edit" onclick='cargoItemDialog({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" class="btn btn-default btn-sm-not delam" title="Delete" onclick='deleteItems({$row|@json_encode})'><i class="fa fa-trash-o ired"></i></a>
                                                        </td>
                                                    </tr>
                                                <div id="notify_mes_{$row->code}" style="display:none">{$row->description}</div>
                                            {/foreach} 
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="clear_fix_both"></div>
                                <div id="cargo-item-dialog" class="hide dialog-content-page">
                                    <div class="">
                                        <form role="form" id="form1" class="form-horizontal ">
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Name</label>
                                                    <input  placeholder="Name" id="name" name="name" maxlength="80"  value="" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Default Rate</label>
                                                    <input  placeholder="Default Rate" id="def_rate" name="def_rate"  value="" class="form-control">
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <br />
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="txt_m_name" class="req">Default Handling Rate</label>
                                                    <input  placeholder="Default Handling Rate" id="def_hnd_rate" name="def_hnd_rate"  value="" class="form-control">
                                                </div>
                                            </div>   
                                            <div class="col-lg-6 p_l_n">
                                                <div>
                                                    <label for="min_freight_amt">Minimum Freight Amount</label>
                                                    <input type="number"  placeholder="Minimum Freight Amount" id="min_freight_amt" min="0" name="min_freight_amt"  value="" class="form-control no-spin">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n  form-check-inline items-doc-flag">
                                                <br>
                                                <div>
                                                    <label for="req_flg">
                                                    <input type="checkbox" id="req_flg" name ='req_flg' class="bs_switch1 form-check-input" data-size="small" checked="checked"> Doc required
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p_l_n  form-check-inline">
                                                <br>
                                                <div>
                                                    <label for="gstExemptedFlag">
                                                    <input type="checkbox" id="gstExemptedFlag" name ='gstExemptedFlag' class="bs_switch1 form-check-input" data-size="small"> Exempt GST
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <br />

                                        </form>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                    <div class="col-md-12 p_l_n p_r_n">
                                        <label for="txt_m_name" class="req">Description</label>
                                        <div style="max-height: 200px; overflow: auto; margin: 0 -5px;">
                                            <table class="table" id="desc-table"> 
                                                <tbody>
                                                    <tr class="border-0">
                                                        <td>
                                                            <div>
    {*                                                            <textarea id="desc"  placeholder="Enter your description here..." style="resize:none" class="desc form-control he_40" rows="3" cols="10" name="message"></textarea>*}
                                                                <input type="text" placeholder="Enter your description here..." id="desc" class="desc form-control" >
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>

                                    </div>
                                    <div class="clear_fix_both">                       
                                        <div class="alert fl suc_cre" style="display:none;" id="itm-form-action-state"></div>
                                        <div class="align-right cre_sve" id="form-bttons">
                                            <input type="hidden" name="code" id="code"/>
                                            <button class="btn btn-success" type="button" onclick="saveItems();">Save</button>
                                            <button class="btn btn-default" type="button" onclick="cancelItems();">Cancel</button>
                                        </div>
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
<form role="form" name="items_form" action="cargo/items" method="POST" onsubmit="return false">
    <input type="hidden" id="export" name="export" value="1">
</form>


<script>
    function exportCargoItemsExcel() {
        document.items_form.target = "ifrm_downloader";
        document.items_form.submit();
        return;
    }

    $('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');
    $('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'hover');
    $('[data-toggle=popover]').popover({
        container: "body",
        html: true
    });

    $(document).ready(function () {
        $('.usr').hide();
        $('[data-toggle="popover"]').popover();

        $('#desc-table').on('input', '.desc', function () {
            var $emptyrows = $('#desc-table tbody tr').filter(function () {
                return $.trim($(this).find('.desc').val()) === '' ;
            });

            $emptyrows.not($(this).parents('tr')).remove();

            if ($emptyrows.length < 2) {
                addDescRow();
            }
        });



    });
    
    function addDescRow() {
        var $tr = $('#desc-table tbody tr:first-child').clone();
        $tr.find('input').val('').end();
        $('#desc-table tbody').append($tr);
    }

</script>    