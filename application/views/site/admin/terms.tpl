<div class="brand_top"><h3>Ticket Booking Terms</h3></div>


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
                                    
                                    <table class="table table-striped terms" id="terms">
                                        <thead>
                                            <tr>
                                                <th><h4>Terms List</h4></th>
                                            </tr>
                                        </thead>
                                        <tbody>                                         
                                        </tbody>                                                   
                                    </table>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>                    
        </div>
    </div>            
</div>
                                                            
 
        
<script id="template-row" type="text/template">
    <tr id="terms_row">
        <td class="tms_name" width="80%">
            <input type="text" id="name" name="tms_name" class="form-control tms_name" value="">
            <input type="hidden" value="" id="code" />
            <input type="hidden" value="" id="sequence" />
            <input type="hidden" value="" id="activeflag" />
        </td>
        <td><a href="javascript:;" class="btn btn-sm btn-default tr_remove" onclick="removetr(this)">Remove</a></td>
    </tr>
</script>
<script id="template-row-buttons" type="text/template">
<tr id="tr_add">
    <td><div class="alert" style="" id="tms-form-action-state"></div></td>
    <td>
        <a href="javascript:;" class="btn btn-sm btn-primary addrow" id="tr_add_btn" onclick="add_row({});" >Add </a>
        <a href="javascript:;" class="btn btn-sm btn-success"  id="submit-button" onclick="save();">Save </a>
    </td>
</tr>
</script>


<script>
    var termslist = {$terms_list|json_encode};
    function init_terms() {
        init_terms_rows();
    }
</script>
        