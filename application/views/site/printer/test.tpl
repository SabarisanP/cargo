<div class="brand_top">
    <h3>Printer Test</h3> 
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
                                                
                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/agent-boarding-list" onsubmit="return false">
                                                    
                                                    <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label class="sr-only" for="date_from">Commands</label> 
                                                            <textarea class="form-control" id="print-commands" placeholder="Write printer commands here" rows="20" style="resize: vertical;"></textarea>                                                           
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="form-group col-md-6 text-right">
                                                            <button class="btn btn-success" type="button" id="btn-send-command" >Send Command</button>
                                                        </div>
                                                    </div>            
                                                
                                                </form>
                                                                                                
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    

                </div>                        
            </div>                    
        </div>
    </div>            
</div>



{literal}
<script>
$(function() {
    var storekey = "ls-prnt-cmds";
    $('#btn-send-command').click( function() {
        cmds = $('#print-commands').val();        
        if(cmds != "") {
            //console.log(cmds);            
            epCommandPrint(cmds);
        }
    });

    $('#print-commands').change( function() {
        var cmds = $(this).val();
        localStorage.setItem(storekey, cmds);
    });

    var cache =  localStorage.getItem(storekey);   
    if(cache) {
        $('#print-commands').val(cache);
    }
});
</script>
{/literal}