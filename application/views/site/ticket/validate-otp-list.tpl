<div class="table-responsive">

    {foreach item=row from=$result}
        {if $row->ticketStatus->code == 'BO'}
            <div class="pull-right">
                <button class="btn btn-success" onclick="sendPNROTP('{$row->ticketCode}');">Send OTP</button>
            </div>
            <table width="100%" cellpadding="10">
                <tr>
                    <td width="30%">
                        <strong>PNR Number</strong><br>
                        {$row->ticketCode}
                    </td>
                    <td width="20%">
                        <strong>Travel Date/Time</strong> <br>
                        {$row->travelDate|date_format:$ns_datetime_format}
                    </td>
                    <td width="30%">
                        <strong>Route</strong>  <br>
                        {$row->fromStation->name} - {$row->toStation->name}
                    </td>   
                    <td width="20%">
                        <strong>Passenger Mobile</strong><br>
                        {$row->passegerMobleNo}
                    </td> 
                </tr>
            </table>
            {assign var="operatorCode" value=$row->operator->code}
            {assign var="ticketCode" value=$row->ticketCode}
            {break}
        {/if}
    {/foreach}
</div>

<div id="validate-otp-dialog" class="hide">
    <div class="col-md-2 pull-right">
        <a class="pull-right" onclick="closeValidateOTPDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
    </div>
    <div class="clear_fix_both"></div>
    <div class="alert alert-danger" style="display:none;" id="send-otp-action-state" valign="middle"></div>
    <div class="clear_fix_both"></div>
    <form id="validate-otp" class="hide" onsubmit="return false;">
        <br><br>
        <div class="form-group col-md-3 col-md-offset-3">
            <label class="sr-only" for="mobile-no">Mobile Number</label>
            <div class="input-group col-md-12">
                <input type="text" name="mobile" class="form-control numeric" id="valid-otp" placeholder="OTP" maxlength="10" autocomplete="off">
            </div>
        </div>
        <input type="hidden" id="hid-validate-pnr" val=""/>
        <button class="btn btn-success" type="button" onclick="validatePNROTP();">Validate OTP</button>
    </form>
    <div class="text-center hide" id="down-mini-pdf">
        <button class="btn btn-success" type="button" id="down-mini-pdf-btn" onclick="printTktWindow('{$operatorCode}','{$ticketCode}','miniticket', '', 1);">Download Mini PDF</button>
    </div>
    <br>
    <div class="text-center alert alert-danger" style="display:none;" id="check-otp-action-state"></div>
</div>