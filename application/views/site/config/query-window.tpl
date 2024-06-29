<div class="brand_top">
    <h3>Query Window</h3>
    <div class="text-right noprint hidden" id="query-window-export">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportQueryWindow();"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
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

                                    <form id="query_window_form" method="post" name="query_window_form" action="config/execute-query" onsubmit="return false;">
                                        <textarea id="query-text" class="form-control" name="query" placeholder="QUERY"></textarea><br/>
                                        <input type="hidden" name="export" id="export" value="1">
                                        <button class="btn btn-success" id="execute-btn" onclick="executeQuery();">Execute</button>
                                        <button type="button" class="btn btn-default btn-clear pull-right" onclick="clearQuery();">Clear</button>
                                    </form>

                                </div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>

                    <div class="row hidden" id="query-window-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="query-window"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>
<iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe>

{literal}
    <script>
        function executeQuery() {
            var data = {};
            data.query = $('#query-text').val().trim();

            $('#query-text').removeClass('inp_error');
            if (data.query == '') {
                $('#query-text').addClass('inp_error');
                return;
            }

            $('#query-window').html(loading_small);
            $('#query-window-container').removeClass('hidden');
            $('#query-window-export').addClass('hidden');
            $('#execute-btn').prop('disabled', true);

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'config/execute-query',
                data: data,
                success: function (response) {
                    $('#query-window').html(response);
                    $('#query-window-container').removeClass('hidden');
                    $('#query-window-export').removeClass('hidden');
                    $('#execute-btn').prop('disabled', false);
                }
            });
        }

        function exportQueryWindow() {
            document.query_window_form.target = "irm_downloader";
            document.query_window_form.submit();
            return;
        }

        function clearQuery() {
            $('#query-text').val('');
            $('#query-window').html('');
            $('#execute-btn').prop('disabled', false);
            $('.inp_error').removeClass('inp_error');
            $('#query-window-container').addClass('hidden');
            $('#query-window-export').addClass('hidden');
        }
    </script>
{/literal}