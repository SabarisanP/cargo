{if $error ==''}
    <div id="main_wrapper" >
        <br/>   
        <div class="clear_fix_both"></div> 
        <div class=" pd_bt_45">

            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-3" style="font-size:13px">PNR Number : </label>
                    <label class="col-md-9" style="font-weight:lighter;font-size:13px">{$reports->code}</label>
                </div>
            </div>

            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-3" style="font-size:13px">Travel Date/Time:</label>
                    <label class="col-md-7" style="font-weight:lighter;font-size:13px">{date('d/m/Y g:i A',strtotime($reports->travelDate))}</label>
                </div>
            </div>   
            <div class="clear_fix_both"></div>


            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-3" style="font-size:13px">Route  :</label>
                    <label class="col-md-9" style="font-weight:lighter;font-size:13px">{$reports->fromStation->name} To {$reports->toStation->name}</label>
                </div>
            </div>
            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-3" style="font-size:13px">Bus Type  :</label>
                    <label class="col-md-9" style="font-weight:lighter;font-size:13px"> {formatBusCategory cate_code=$reports->bus->categoryCode} </label>
                </div>
            </div>
            <div class="clear_fix_both"></div>


            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-3">Boarding :</label>
                    <label class="col-md-9" style="font-weight:lighter">
                    {if $reports->fromStation->stationPoint[0]->name !=''}
                        {$reports->fromStation->stationPoint[0]->name}, {$reports->fromStation->stationPoint[0]->landmark}, 
                        {*at {$reports->fromStation->stationPoint[0]->dateTime|date_format:$ns_time_format},*} 
                        {$reports->fromStation->stationPoint[0]->address}.
                        {if $action_rights['EDIT-BRD-INFO']==1} 
                            <a href="javascript:;" class="btn-sm edat" data-toggle="tooltip" id="tkn_edt" title="Edit boarding point" 
                               data-pointname = "{$reports->fromStation->stationPoint[0]->name}"
                               data-landmark = "{$reports->fromStation->stationPoint[0]->landmark}"
                               data-address = "{$reports->fromStation->stationPoint[0]->address}" 
                               onclick='passengerBoardDialog("{$reports->tripCode}", "{$reports->tripStageCode}", "{$reports->code}", "{$reports->fromStation->stationPoint[0]->code}", "{$reports->fromStation->code}", "{$reports->toStation->code}", "{$reports->travelDate}") '>
                                <i class="fa fa-pencil igreen"></i>
                            </a>
                        {/if}
                    {else} - 
                    {/if}    
                        <br/>                    
                    </label>
                </div>

            </div>
            <div class="col-md-2"></div>

            <div class="col-xs-6 p_l_n">
                <div >
                    <label for="txt_m_name" class="col-md-3" >Dropping :</label>
                    <label class="col-md-9" style="font-weight:lighter">
                        {if $reports->toStation->stationPoint[0]->name !=''}
                            {$reports->toStation->stationPoint[0]->name},
                            {$reports->toStation->stationPoint[0]->landmark},
                            {$reports->toStation->stationPoint[0]->address}
                            
                            {if $action_rights['EDIT-BRD-INFO']==1} 
                            <a href="javascript:;" class="btn-sm edat" data-toggle="tooltip" id="tkn_drop" title="Edit dropping point" 
                               data-pointname = "{$reports->toStation->stationPoint[0]->name}"
                               data-landmark = "{$reports->toStation->stationPoint[0]->landmark}"
                               data-address = "{$reports->toStation->stationPoint[0]->address}" 
                               onclick='passengerDroppingDialog("{$reports->tripCode}", "{$reports->tripStageCode}", "{$reports->code}", "{$reports->toStation->stationPoint[0]->code}", "{$reports->fromStation->code}", "{$reports->toStation->code}", "{$reports->travelDate}") '>
                                <i class="fa fa-pencil igreen"></i>
                            </a>
                        {/if}
                            
                        {else}-{/if}
                    </label>

                </div>
            </div>


            <div class="clear_fix_both"></div>


            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-3">Passenger Mob :</label>
                    <label class="col-md-9" style="font-weight:lighter"><span id="mob_upd">{$reports->passegerMobleNo}</span>{if $action_rights['EDIT-PHN-NUMBER']>0}<a href="javascript:;" class="btn-sm edat" data-toggle="tooltip" id="tkn_edt" title="Edit mobile number" {if $action_rights['EDIT-PHN-NUMBER']!=2}onclick='editPassengerMobile("{$reports->passegerMobleNo}", "{$reports->code}")'{/if}><i class="fa fa-pencil igreen"></i></a>{/if}</label>                   
                </div>
            </div><div class="col-md-2"></div>
            <div class="col-xs-6 p_l_n">
                <div >
                    <label for="txt_m_name" class="col-md-3" >Booked At :</label>
                    <label class="col-md-9" style="font-weight:lighter">{date('d/m/Y g:i A',strtotime($reports->transactionDate))}</label>                   
                </div>
            </div>
                
            <div class="clear_fix_both"></div>
            <div class="col-xs-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="col-md-3" >GST Details :</label>
                    <label for="txt_m_name" id="cust-gst-details-txt" class="col-md-9" style="display: none;font-weight:lighter"></label>
                    <a href="javascript:;" class="col-md-9" id="cust-gst-update-btn" title="Update GST details" onclick="customerGstDialog('{$reports->code}');" >
                        Update GST details
                    </a>
                </div>
            </div>
        </div>

        <div class="clear_fix_both"></div>
        <div >
            <div class="table-responsive">
                <table id="dt_report_table" class="table">
                    <thead>
                        <tr bgcolor="#F5F5F5">

                            <th  style='border:1px solid #dddddd'>Passenger Name</th>
                            <th  style='border:1px solid #dddddd;text-align:center '>
                                Seat No
                                {if  $action_rights['EDIT-SEAT-NAME']>0}
                                    <a href="javascript:;" class="btn-sm edat" data-toggle="tooltip" id="tkn_edt" title="Edit boarding info" onclick='passengerSeatDialog("{$reports->tripCode}", "{$reports->tripStageCode}", "{$reports->code}", "{$reports->fromStation->code}", "{$reports->toStation->code}", "{$reports->travelDate}")'> <i class="fa fa-pencil igreen"></i> </a>
                                {/if}
                            </th>
                            <th  style='border:1px solid #dddddd;text-align:center '>Gender</th>
                            <th  style='border:1px solid #dddddd;text-align:center '>Age</th>                       
                            <th style='border:1px solid #dddddd;text-align:center '>Status</th>
                            <th style='border:1px solid #dddddd;text-align:center '>Fare</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {foreach item=row from=$reports->ticketDetails}
                            <tr id='seat-{$row->seatCode}' {if $row->seatStatus->code == 'CA' || $row->seatStatus->code == 'PCA'} class="cancelled-seat" {/if}>
                                <td style='border:1px solid #dddddd'><span id="new_name">{$row->passengerName} </span>{if $action_rights['EDIT-PASS-NAME']>0 && $row->seatStatus->code != 'CA' && $row->seatStatus->code != 'PCA'}<a href="javascript:;" class="btn-sm edat" data-toggle="tooltip" id="tkn_edt" title="Edit name" {if $action_rights['EDIT-PASS-NAME']==1} onclick='passengerNameDialog("{$row->seatCode}", "{$reports->code}", "{$row->passengerName}")'{/if}><i class="fa fa-pencil igreen"></i></a>{/if}</td>
                                <td style='border:1px solid #dddddd' align="center">{$row->seatName}</td>
                                <td style='border:1px solid #dddddd' align="center"><span id="new_gender">{if $row->passengerGendar=='M'}Male{else}Female{/if}</span>{if $action_rights['EDIT-PASS-GENDER']>0 && $row->seatStatus->code != 'CA' && $row->seatStatus->code != 'PCA'}<a href="javascript:;" class="btn-sm edat" data-toggle="tooltip" id="tkn_edt" title="Edit gender" {if $action_rights['EDIT-PASS-GENDER']==1} onclick='passengerGenderDialog("{$row->seatCode}", "{$reports->code}", "{$row->passengerGendar}")'{/if}><i class="fa fa-pencil igreen"></i></a>{/if}</td>
                                <td style='border:1px solid #dddddd' align="center"><span id="new_age">{$row->passengerAge}</span>{if $action_rights['EDIT-PASS-AGE']>0 && $row->seatStatus->code != 'CA' && $row->seatStatus->code != 'PCA'}<a href="javascript:;" class="btn-sm edat" data-toggle="tooltip" id="tkn_edt" title="Edit age" {if $action_rights['EDIT-PASS-AGE']==1} onclick='passengerAgeDialog("{$row->seatCode}", "{$reports->code}", "{$row->passengerAge}")'{/if}><i class="fa fa-pencil igreen"></i></a>{/if}</td>                            
                                <td style='border:1px solid #dddddd' align="center">{$row->seatStatus->name}</td>
                                <td style='border:1px solid #dddddd;' align="right"><i class="fa fa-inr"></i>&nbsp;{$row->seatFare|number_format:2:".":","}</td>
                        <input type="hidden" value="{$row->refundAmount}" id="refund">
                        <input type="hidden" value="{$code}" id="pnr_code">
                        </tr>
                    {/foreach}

                    </tbody>
                </table>
            </div>
            <span style="float:right"><button class="btn btn-default" type="button" onclick="cancelEditTck();">Close</button></span>
        </div>
    </div>
{else}
    <li class="er_msg" style="list-style-type:none">
        <div class="well well-large ">{$error}</div>
    </li>
    <span style="float:right"><button class="btn btn-default" type="button" onclick="cancelEditTck();">Close</button></span>
{/if}



<!-- Edit Mobile Popup Dialog -->
<div id="edt-tck-mob-dialog" class="hide dialog-content-page">

    <form role="form" id="form1" class="form-horizontal ">

        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name" class="req">Mobile Number</label>
                <input  placeholder="Mobile Number" id="n_mobile" name="n_mobile"  class="form-control">
            </div>
        </div>
        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name">Send Notification</label>
                <input type="checkbox" id="mob_noti" name ='mob_noti' class="bs_switch" data-on-text="Yes" data-off-text="No" data-size="small">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
    </form>

    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;position:relative;bottom:8px;left:15px" id="mob-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" name="seat_code" id="seat_code" value="" />
            <input type="hidden" name="o_mobile" id="o_mobile" value="" />
            <span class="mob_save">
                <button class="btn btn-success" type="button" onclick="editMobileNumber();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelMobileNumber();">Cancel</button>
            </span>
        </div>
    </div> 
</div>
<!-- Mobile Popup Ends -->

<!-- Edit Name Popup Dialog -->
<div id="edt-tck-name-dialog" class="hide dialog-content-page">

    <form role="form" id="form1" class="form-horizontal ">

        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name" class="req">Passenger Name</label>
                <input  placeholder="Passenger Name" id="pass_name" name="pass_name"  class="form-control">
            </div>
        </div>
        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name">Send Notification</label>
                <input type="checkbox" id="noti_name" name ='noti_name' class="bs_switch" data-on-text="Yes" data-off-text="No" data-size="small">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
    </form>

    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;position:relative;bottom:8px;left:15px" id="name-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" name="seat_code" id="seat_code" value="" />
            <input type="hidden" name="pnr_name" id="pnr_name" value="" />
            <input type="hidden" name="name_pass" id="name_pass" value="" />
            <span class="name_save">
                <button class="btn btn-success" type="button" onclick="editPassengerName();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelPassengerName();">Cancel</button></span>
        </div>
    </div> 
</div>
<!-- Name Popup Ends -->


<!-- Edit Gender Popup Dialog -->
<div id="edt-tck-gender-dialog" class="hide dialog-content-page">

    <form role="form" id="form1" class="form-horizontal ">

        <div class="col-lg-6 p_l_n" class="req">
            <div>
                <label>Select Gender</label>
                <input type="radio" name="pass_gender" id="pass_gender" value="M" class="grp_radio"> Male &nbsp;
                <input type="radio" name="pass_gender" id="pass_gender" value="F" class="grp_radio"> Female 
            </div>
        </div>
        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name">Send Notification</label>
                <input type="checkbox" id="noti_gen" name ='noti_gen' class="bs_switch" data-on-text="Yes" data-off-text="No" data-size="small">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
    </form>

    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;position:relative;bottom:8px;left:15px" id="gender-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" name="seat_code" id="seat_code" value="" />
            <input type="hidden" name="pnr_name" id="pnr_name" value="" />

            <span class="gender_save">
                <button class="btn btn-success" type="button" onclick="editPassengerGender();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelPassengerGender();">Cancel</button>
            </span></div>
    </div> 
</div>
<!-- Gender Popup Ends -->


<!-- Edit Age Popup Dialog -->
<div id="edt-tck-age-dialog" class="hide dialog-content-page">

    <form role="form" id="form1" class="form-horizontal ">

        <div class="col-lg-6 p_l_n" class="req">
            <div>
                <label>Age</label>
                <input type="text" placeholder="Age" name="pass_age" id="pass_age" value="" class="form-control">
            </div>
        </div>
        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name">Send Notification</label>
                <input type="checkbox" id="noti_age" name ='noti_age' class="bs_switch" data-on-text="Yes" data-off-text="No" data-size="small">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
    </form>

    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;position:relative;bottom:8px;left:15px" id="age-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" name="seat_code" id="seat_code" value="" />
            <input type="hidden" name="pnr_name" id="pnr_name" value="" />
            <span class="age_save">
                <button class="btn btn-success" type="button" onclick="editPassengerAge();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelPassengerAge();">Cancel</button>
            </span></div>
    </div> 
</div>
<!-- Age Popup Ends -->

<!-- Boarding Point Popup Dialog -->
<div id="edt-tck-board-dialog" class="hide dialog-content-page">

    <form role="form" id="form1" class="form-horizontal ">

        <div class="col-xs-12 p_l_n">
            <div>
                <label>Choosed Boarding Point :</label>
                <label class="col-md-17" style="font-weight:lighter"><span id="brd"></span><br/>                    
                </label>
            </div>

        </div>

        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
        <div class="col-lg-6 p_l_n" class="req">
            <div>
                <label>Select Boarding Point</label>
                <span id="point"></span>

                </select>
            </div>
        </div>
        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name">Send Notification</label>
                <input type="checkbox" id="noti_brd" name ='noti_brd' class="bs_switch" data-on-text="Yes" data-off-text="No" data-size="small">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
        <div class="col-lg-12 p_l_n">
            <div>
                <label for="txt_m_name">Address</label>
                <span id="addr"></span>
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
    </form>

    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;position:relative;bottom:8px;left:15px" id="board-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" name="trip_code" id="trip_code" value="" />
            <input type="hidden" name="stage_code" id="stage_code" value="" />
            <input type="hidden" name="pnr_name" id="pnr_name" value="" />
            <input type="hidden" name="old_board" id="old_board" value="" />
            <span class="board_save">
                <button class="btn btn-success" type="button" onclick="editPassengerBoard();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelPassengerBoard();">Cancel</button>
            </span></div>
    </div> 
</div>
<!-- Boarding point Popup Ends -->

<!-- Dropping Point Popup Dialog -->
<div id="edt-tck-drop-dialog" class="hide dialog-content-page">

    <form role="form" id="form1" class="form-horizontal ">

        <div class="col-xs-12 p_l_n">
            <div>
                <label>Choosed Dropping Point :</label>
                <label class="col-md-17" style="font-weight:lighter"><span id="drop"></span><br/>                    
                </label>
            </div>

        </div>

        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
        <div class="col-lg-6 p_l_n" class="req">
            <div>
                <label>Select Dropping Point</label>
                <span id="dpoint"></span>                
            </div>
        </div>
        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name">Send Notification</label>
                <input type="checkbox" id="noti_drop" name ='noti_drop' class="bs_switch" data-on-text="Yes" data-off-text="No" data-size="small">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
        <div class="col-lg-12 p_l_n">
            <div>
                <label for="txt_m_name">Address</label>
                <span id="dropaddr"></span>
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />
        <div class="clear_fix_both"></div>
    </form>

    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;position:relative;bottom:8px;left:15px" id="drop-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" name="trip_code" id="trip_code" value="" />
            <input type="hidden" name="stage_code" id="stage_code" value="" />
            <input type="hidden" name="pnr_name" id="pnr_name" value="" />
            <input type="hidden" name="old_drop" id="old_drop" value="" />
            <span class="drop_save">
                <button class="btn btn-success" type="button" onclick="editPassengerDropping();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelPassengerDropping();">Cancel</button>
            </span></div>
    </div> 
</div>
<!-- Dropping point Popup Ends -->

<!-- Boarding Point Popup Dialog -->
<div id="edt-tck-seat-dialog" class="hide dialog-content-page">
    <br>
    <div class="col-lg-4">
        <br>
        <form role="form" id="form1" class="form-horizontal ">
            <div class="col-xs-6 p_l_n">
                <b>Current Seat No :</b>
            </div>
            <div class="col-xs-6 p_l_n p_r_n">
                <b>Select new seat No : </b>
            </div>
            {foreach item=row from=$reports->ticketDetails}
                {if $row->seatStatus->code != 'CA' && $row->seatStatus->code != 'PCA'}
                    <div class="clear_fix_both"></div>
                    <br />
                    <div class="col-xs-6 p_l_n" style="padding-top:8px">
                        <span style="font-weight:lighter" id="sel">{$row->seatName}</span>
                    </div>
                    <div class="col-xs-6 p_l_n p_r_n">
                        <span class="new_seat" data-oldseatcode="{$row->seatCode}" data-oldseatname="{$row->seatName}"></span>
                    </div>
                {/if}
            {/foreach}

            <div class="clear_fix_both"></div>
            <br />
            <div class="col-lg-12 p_l_n">
                <div>
                    <label for="txt_m_name">Send Notification : </label>
                    <input type="checkbox"  id="noti_seat" name ='noti_seat' class="bs_switch" data-on-text="Yes" data-off-text="No" data-size="small">
                </div>
            </div>



        </form>
    </div>
    <div class="col-lg-8">
        <div id="sch-workspace-content"></div>   
    </div>
    <div class="clear_fix_both">                       

        <br>        
        <div class="alert fl suc_cre" style="display: none;position:relative;bottom:8px;left:15px" id="seat-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" name="trip_code" id="trip_code" value="" />
            <input type="hidden" name="stage_code" id="stage_code" value="" />
            <input type="hidden" name="pnr_name" id="pnr_name" value="" />
            <input type="hidden" name="seat_old" id="seat_old" value="" />
            <span class="seat_save">
                <button class="btn btn-success" type="button" onclick="editPassengerSeat();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelPassengerSeat();">Cancel</button>
            </span></div>
    </div> 



    <div id="confirm_dialog" style="background-color: #fff;" class="hidden">
        <div id="busmap-1" class="col-sm-7"></div>
        <div id="po-c-ticket-details" class="col-sm-5"></div>
    </div>


    <script id="template-busmap-listedit" type="text/template">

        <div class="busmap-list">

        <div align="center" class="busmap col-xs-12">
        <div class="seat-map-over upper-layer col-md-12 hide">
        <div class="seat-map-over-all">
        <div class="col-xs-1">
        <p class="vertical-text">Upper</p>
        </div>
        <div class="col-xs-12 upper" style="width:auto;height: auto;">

        </div>
        </div>
        <div class="clear_fix_both"></div>
        </div>
        <div class="clear_fix_both"></div><br />
        <div class="seat-map-over col-xs-12">
        <div class="seat-map-over-all">
        <div class="col-xs-1 seat-map-driver-head">
        <div class="seat-map-driver">&nbsp;
        </div>
        <div class="seat-map-selayer hide">
        <p class="vertical-text">Lower</p>
        </div>
        </div>
        <div class="col-xs-12 lower" style="width:auto;height: auto;">

        </div>
        </div>
        <div class="clear_fix_both"></div>
        </div> 

        </div>
        <div class="clear_fix_both"></div>

        </div>

    </script>   

</div>
<!-- Boarding point Popup Ends -->

<div id="update-cust-gst-dialog" class="hide dialog-content-page">
    <form role="form" id="form1" class="form-horizontal">
        <div class="col-lg-12 p_l_n">
            <div>
                <label class="req" for="cust-gstin">GSTIN</label>
                <input class="form-control" id="cust-gstin" placeholder="GSTIN" maxlength="15">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n">
            <div>
                <label class="req" for="cust-gsttrade">GST Trade Name</label>
                <input class="form-control" id="cust-gsttrade" placeholder="GST Trade Name" maxlength="100">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n">
            <div>
                <label for="cust-gstemail">GST Email</label>
                <input class="form-control" id="cust-gstemail" placeholder="GST Email" maxlength="50">
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br/>
        <div class="col-lg-12 p_l_n">
            <div class="col-lg-12 alert fl hide" id="cust-gst-action-state"></div>
        </div>
    </form>
    <div class="clear_fix_both"></div>
    <div class="col-md-12 clear_fix_both">
        <div class="align-right cre_sve" id="form-bttons">
            <input type="hidden" id="cust-gst-pnr"/>
            <span class="mob_save">
                <button class="btn btn-success" type="button" onclick="saveCustomerGst();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelCustomerGst();">Cancel</button>
            </span>
        </div>
    </div>
</div>

{literal}
    <script>
        $('.bs_switch').bootstrapSwitch('size', 'medium');
    </script>    
{/literal}

