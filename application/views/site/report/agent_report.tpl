<div id="main-content">

    <div class="container">
        <div class="row">
            <div id="content" class="col-lg-12">
                <!-- PAGE HEADER-->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-header">
                            <!-- STYLER -->

                            <!-- /STYLER -->

                            <div class="clearfix">
                                <h3 class="content-title pull-left">Agent Report</h3>
                            </div>

                        </div>
                    </div>
                </div>
                <!-- /PAGE HEADER -->

                <div class="panel panel-default">
                    <div class="panel-body">
                        <form class="form-inline" role="form">

                            <div class="form-group">                                
                                <div class="input-group">
                                    <input type="text" class="form-control" id="exampleInputPassword2" placeholder="Start Date">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                            <div class="form-group">                                
                                <div class="input-group">
                                    <input type="text" class="form-control" id="exampleInputPassword2" placeholder="End Date">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <select class="form-control" >
                                    <option>Select Agent</option>
                                    <option>Agent 1</option>
                                    <option>Agent 2</option>
                                    <option>Agent 3</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-light-grey" onclick="dosearch()">Search</button> 
                            <button type="button" class="btn btn-default">Clear</button>
                        </form>
                    </div>
                </div>
                <div id="result-panel" style="display: none;">
                    <table>
                        <tbody>
                            <tr><td align="left"><b>Agent Name :</b> XYZ Travels &nbsp; &nbsp; <b>Date Peroid:</b> 01/02/2014 To 21/02/2014</td></tr>
                            <tr><td align="left"><b>Opening Balance :</b> 3000.00 &nbsp; &nbsp; <b>Closing Balance:</b> 2000.00</td></tr>
                        </tbody>
                    </table>
                    <br/>
                    <div class='responsive-table1'>
                        <div class='table-responsive'>
                            <table id="datatable2" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover" >
                                <thead><tr>
                                        <th>Transaction Date</th>   		
                                        <th>Transaction Type</th>
                                        <th>Reference</th>
                                        <th>Name</th>
                                        <th>Mobile</th>
                                        <th>SeatNbrs</th>
                                        <th>From - To</th>
                                        <th>Travel Time</th>
                                        <th>Fare</th>
                                        <th>Commission Amount</th>
                                        <th>Cancel Charges</th>
                                        <th>Credit</th>
                                        <th>Debit</th>
                                        <th>Current Balance</th>
                                    </tr>
                                </thead>
                                <tbody>
                                   



                                    <tr>

                                        <td>Mon, Feb 17, 2014 10:12:45 AM</td>
                                        <td>Ticket Booked</td>


                                        <td align="center">
                                            <a onclick="gettickets('XYZE2HA64358')" href="#">XYZE2HA64358</a>
                                        </td>









                                        <td>periyannan</td>
                                        <td>8865670826</td>
                                        <td>13,14</td>
                                        <td>Chennai-Rasipuram</td>
                                        <td>2014-02-17 21:15:00</td>
                                        <td>840.00</td>


                                        <td align="right">84.00</td> 


                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">846.00</td>
                                        <td align="right">-76.0</td>
                                    </tr>



                                    <tr>

                                        <td>Mon, Feb 17, 2014 11:53:14 AM</td>
                                        <td>Ticket Booked</td>


                                        <td align="center">
                                            <a onclick="gettickets('XYZE2HA65514')" href="#">XYZE2HA65514</a>
                                        </td>









                                        <td>KUMAR.RSM</td>
                                        <td>8443716510</td>
                                        <td>34</td>
                                        <td>Rasipuram-Chennai</td>
                                        <td>2014-02-23 22:55:00</td>
                                        <td>470.00</td>


                                        <td align="right">47.00</td> 


                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">423.00</td>
                                        <td align="right">-488.0</td>
                                    </tr>



                                    <tr>

                                        <td>Mon, Feb 17, 2014 05:51:31 PM</td>
                                        <td>Ticket Booked</td>


                                        <td align="center">
                                            <a onclick="gettickets('XYZE2HA68827')" href="#">XYZE2HA68827</a>
                                        </td>









                                        <td>nandini</td>
                                        <td>8524828003</td>
                                        <td>10</td>
                                        <td>Rasipuram-Chennai</td>
                                        <td>2014-02-18 22:55:00</td>
                                        <td>470.00</td>


                                        <td align="right">47.00</td> 


                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">423.00</td>
                                        <td align="right">-822.0</td>
                                    </tr>



                                    <tr>

                                        <td>Mon, Feb 17, 2014 06:43:42 PM</td>
                                        <td>Ticket Booked</td>


                                        <td align="center">
                                            <a onclick="gettickets('XYZE2HA68603')" href="#">XYZE2HA68603</a>
                                        </td>









                                        <td>Jawaharj</td>
                                        <td>8443370225</td>
                                        <td>10</td>
                                        <td>Chennai-Senthamangalam</td>
                                        <td>2014-02-17 22:15:00</td>
                                        <td>470.00</td>


                                        <td align="right">47.00</td> 


                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">423.00</td>
                                        <td align="right">-1345.0</td>
                                    </tr>



                                    <tr>

                                        <td>Mon, Feb 17, 2014 06:50:52 PM</td>
                                        <td>Deposit</td>






                                        <td align="center">
                                            <a onclick="showTicket('/ezeebus/PaymentVoucher.ez?event=voucherDetailsPopUp&amp;receiptId=OREE2HA68706')" href="#">View Report</a><br>
                                            <a onclick="showTicket('/ezeebus/PaymentVoucher.ez?event=printReceiptForAgentReport&amp;receiptId=OREE2HA68706&amp;transactionAmount=3000.00&amp;receiptDate=Mon, Feb 17, 2014 06:50:52 PM&amp;userOfficeName=XYZ Travels&amp;tradingPartnerName=XYZ Travels')" href="#">View Receipt</a>
                                        </td>





                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td>3000.00</td>


                                        <td align="right">0.00</td> 


                                        <td align="right">0.00</td>
                                        <td align="right">3000.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">1655.0</td>
                                    </tr>



                                    <tr>

                                        <td>Tue, Feb 18, 2014 08:15:24 AM</td>
                                        <td>Ticket Booked</td>


                                        <td align="center">
                                            <a onclick="gettickets('XYZE2IA72288')" href="#">XYZE2IA72288</a>
                                        </td>









                                        <td>sundarrajan</td>
                                        <td>8865608147</td>
                                        <td>11,12</td>
                                        <td>Rasipuram-Chennai</td>
                                        <td>2014-02-18 22:55:00</td>
                                        <td>840.00</td>


                                        <td align="right">84.00</td> 


                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">846.00</td>
                                        <td align="right">808.0</td>
                                    </tr>



                                    <tr>

                                        <td>Wed, Feb 18, 2014 05:35:43 PM</td>
                                        <td>Ticket Booked</td>


                                        <td align="center">
                                            <a onclick="gettickets('XYZE2JA84881')" href="#">XYZE2JA84881</a>
                                        </td>









                                        <td>geetha</td>
                                        <td>8841048872</td>
                                        <td>5,6</td>
                                        <td>Rasipuram-Chennai</td>
                                        <td>2014-02-23 22:55:00</td>
                                        <td>840.00</td>


                                        <td align="right">84.00</td> 


                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">846.00</td>
                                        <td align="right">-37.0</td>
                                    </tr>



                                    <tr>

                                        <td>Wed, Feb 18, 2014 07:46:44 PM</td>
                                        <td>Ticket Booked</td>


                                        <td align="center">
                                            <a onclick="gettickets('XYZE2JA86481')" href="#">XYZE2JA86481</a>
                                        </td>









                                        <td>geetha</td>
                                        <td>8841048872</td>
                                        <td>1</td>
                                        <td>Rasipuram-Chennai</td>
                                        <td>2014-03-02 22:55:00</td>
                                        <td>470.00</td>


                                        <td align="right">47.00</td> 


                                        <td align="right">0.00</td>
                                        <td align="right">0.00</td>
                                        <td align="right">423.00</td>
                                        <td align="right">-460.0</td>
                                    </tr>

                                  
                                </tbody></table>
                        </div>
                    </div>
                    <br />
                  

            </div><!-- /CONTENT-->
        </div>
    </div>
</div>
{literal}
    <script>
        jQuery(document).ready(function() {
            App.setPage("dynamic_table");  //Set current page
            App.init(); //Initialise plugins and elements
        });

        function dosearch() {
            $('#result-panel').show();
        }
    </script>
{/literal}