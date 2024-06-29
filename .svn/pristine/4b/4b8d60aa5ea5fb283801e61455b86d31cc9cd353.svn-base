<div class="brand_top"><h3>Payment Confirmation</h3> </div>
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
                                        <div id='load'></div>
                                        <div id="rpt_lst"></div>        
                                        <!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form id='prt_tick' name="prt_tick" method="get" action="search/confimation-payment" onsubmit="return false">
        <input type="hidden" name="pnr" class="form-control sdate" id="pnr"  value='{$smarty.get.orderCode}'>
        <input type="hidden" id="export" name="export" value="" />
    </form>

    <iframe name="ifrm_downloader" id="ifrm_downloader" style='display:none'></iframe>
    {literal}
        <script>
            var pnr = $('#pnr').val();
            if (pnr != '') {
                var html = '<div class="well well-lg" style="height:200px; text-align:center;vertical-align: middle;" > <br> <br> <br> Please wait...! Validating your transaction. <br> <br>'+loading_big+' </div>';    
                var data = {};
                data.ticketpnrcode = pnr;
                $('#load').html(html);
                
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "search/confimation-payment",
                    data: data,
                    success: function(response) {

                        if (response != '') {
                            $('#load').html('');
                            $('#rpt_lst').html(response);

                        } else {

                        }
                    }
                })

            } else {
                $('#rpt_lst').html('<div class="alert alert-danger" style="text-align:center"> Invalid transaction code or transaction code not passed.</div>');
            }
            function GetPdf() {
                document.prt_tick.target = "ifrm_downloader";
                $('#export').val(1);
                document.prt_tick.submit();
                return;
            }

        </script>
    {/literal}
