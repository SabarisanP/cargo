<div class="brand_top"><h3>Driver</h3> <span class="align-rights"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="addEditDriver();">Add New Driver</a></span></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="content" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-3 col-md-6">
                                        <div class="panel-group" id="accordion">
                                            <div class="panel panel-info hide" id="oz-dm">
                                                <div class="panel-heading">
                                                        
                                                </div>  
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clear_fix_both"></div>

                                    <div id="driver-dialog" class="hide dialog-content-page">
                                        <div class="">
                                            <form role="form" id="form1" class="form-horizontal ">

                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">Name</label>
                                                        <input  placeholder="Name" id="name" name="name"  class="form-control">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name">Last Name</label>
                                                        <input  placeholder="Last Name" id="lname" name="lname"  class="form-control">
                                                    </div>
                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <br />
                                                
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">D.O.B</label>
                                                        <div class="input-group">
                                                          <input  placeholder="D.O.B" id="dob" name="dob"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                                          <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name">Blood Group</label>
                                                        <select id="blood" class="form-control col-md-6">
                                                            <option value="">Select</option>
                                                            <option value="O+">O+</option>
                                                            <option value="O-">O-</option>
                                                            <option value="A+">A+</option>
                                                            <option value="A-">A-</option>
                                                            <option value="B+">B+</option>
                                                            <option value="B-">B-</option>
                                                            <option value="AB+">AB+</option>
                                                            <option value="AB-">AB-</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <br />
                                                
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">License Number</label>
                                                        <input  placeholder="License Number" id="license" name="license"  class="form-control">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">License Expiry Date</label>
                                                         <div class="input-group">
                                                          <input  placeholder="License Expiry Date" id="expiry" name="expiry"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                                          <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <br />
                                                
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name">Qualification</label>
                                                        <input  placeholder="Qualification" id="qtion" name="qtion"  class="form-control">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">Contact</label>
                                                        <input  placeholder="Contact" id="contact" name="contact"  class="form-control" maxlength="10">
                                                    </div>
                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <br />
                                                
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">Emergency Contact</label>
                                                        <input  placeholder="Emergency Contact" id="ecnt" name="ecnt"  class="form-control" maxlength="10">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name" class="req">Joining Date</label>
                                                        <div class="input-group">
                                                          <input  placeholder="Joining Date" id="jod" name="jod"  class="form-control" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                                          <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clear_fix_both"></div>
                                                <br />
                                                
                                                <div class="col-lg-12 p_l_n">
                                                    <div>
                                                        <label for="txt_m_name">Remarks</label>
                                                        <textarea id="remarks" class="form-control" style="resize:none" name="remarks" placeholder="Remarks"></textarea>
                                                    </div>
                                                </div>
                                                <div class="clear_fix_both"></div><br>
                                            </form>`
                                        </div>
                                        <div class="clear_fix_both"></div>
                                        <div class="clear_fix_both">                       
                                            <div class="alert fl suc_cre" style="display: none;" id="driver-form-action-state"></div>
                                            <div class="align-right cre_sve" id="form-bttons">
                                                <button class="btn btn-success" type="button" onclick="saveDriver();">Save</button>
                                                <button class="btn btn-default" type="button" onclick="cancelDriver();">Cancel</button>
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
    </div>
</div>
    <script>
        $(document).ready(function () {
            $('#dob').datepicker({
                todayHighlight: true,
                endDate: '+0d',
                format: 'yyyy-mm-dd'
            });
            $('#expiry').datepicker({
                todayHighlight: true,
                startDate: new Date(),  
                format: 'yyyy-mm-dd'
            });
            $('#jod').datepicker({
                todayHighlight: true,
                endDate: '+0d',
                format: 'yyyy-mm-dd'
            });
            
        });
    </script>

