<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div style="clear: both;"></div><br>
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form role="form" id="form1" class="form-horizontal ">
                               <!-- <div class="col-lg-2 p_l_n">
                                    <label for="txt_m_name" class="req">Category</label>
                                    <select id="disc-grp" class="form-control col-md-6">
                                        <option value="">Select Category</option>
                                        {foreach name=o item=row from=$category}
                                            <option value="{$row->code}">{$row->name}</option>
                                        {/foreach} 
                                    </select>
                                </div>-->
                                <div class="col-lg-2 p_l_n">
                                    <div>
                                        <label for="txt_oz_name" class="req">Discount Name</label>
                                        <select id="disc-coup-code" class="form-control disc-coup-code ov_fl_height">
                                            <option value="">Select</option>
                                            {foreach item=amt from=$coupon}
                                                <option value="{$amt->code}">{$amt->coupon}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div> 
                                <div class="col-lg-2 p_l_n">
                                <label for="discount_report">&nbsp;</label>
                                <div class="pull-right" id="cop-form-buttons">
                                    <button class="btn btn-success" type="button" onclick="getdiscountreport()">View Discount</button>
                                </div>
                                </div>
                                <div class="col-lg-6 p_l_n">
                                <div class="alert fl suc_cre" style="display: none;" id="coup-form-action-state"></div>
                                </div>
                             </form>
                        </div><!--panel Body end-->
                    </div>
                </div>
            </div>
            
             <div class="row hidden" id="disc-coupon-rpt-list-container">
                <br>
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div id="disc-coupon-rpt-list"></div>                                    
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 </div>


    <script>
        $(function () {

            $('select.disc-coup-code,select.coup_schedule,select.coup_route').select2({
                placeholder: "All Selected",
                escapeMarkup: function (markup) {
                    return markup;
                }
            });

            $('input[name="date_cop"]').daterangepicker({
                buttonClasses: ['btn', 'btn-sm'],
                format: 'YYYY-MM-DD',
                separator: ' | ',
                showDropdowns: true,
                showWeekNumbers: true,
            });

            $('.selectpicker').selectpicker();

        });

       

        $('#disc_type').change(function () {
            if (this.checked) {
                $('#per').show();
                $('#rs').hide();
            }
            else {
                $('#per').hide();
                $('#rs').show();
            }
        });

    </script>