<span class="align-right">
    <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showSheduleStopDialog()">New Stop</a>
</span>

<br><br><br>

<div class="row">
    <div class="col-md-12" >
    {if $stops|@count > 0}    
        <table class="table" width="100%">
            <tr>
                <th align="center">Stop Name</th>
                <th align="center">Travel Duration</th>
                <th align="center">Halt Duration</th>
                <th align="center">Amenities</th>
                <th align="center">Rest Room</th>
                <th align="center">Position</th>                
                <th align="center"></th>
            </tr>
            {foreach key=key from=$stops item=stop}
                <tr>
                    <td>{$stop->name}</td>
                    <td>{$stop->travelMinutes} minutes from {$stations[$stop->stations->code]}</td>
                    <td>{$stop->minutes} minutes</td>
                    <td>{', '|implode:$stop->amenities}</td>
                    <td>{$stop->restRoom}</td>
                    <td><a href="http://www.google.com/maps/place/{$stop->latitude},{$stop->longitude}" target="_blank">Map Link</a></td>
                    <td>
                        <!--<a class="edit pTip_top" title="edit" href="javascript:;" onclick="showSheduleStopDialog('{$stop->code}')">
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>&nbsp; -->
                        <a class="delete pTip_top" title="delete" href="javascript:;" onclick="deleteScheduleStop('{$stop->code}')">
                            <i class="fa fa-trash-o fa-lg"></i>
                        </a>&nbsp;
                    </td>
                </tr>   
            {/foreach}
        </table>    
    {else}
        <div class="well well-large "> No details dound!</div>
    {/if}  
    </div>
</div>
    
<div id="stops-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal ">
        
        <div class="row">
            <div class="col-lg-6">            
                <label for="txt_oz_name" class="req">Stop Place</label>
                <select id="stp-stop" class="form-control col-md-4"> 
                    <option value="">Select a stop</option>
                    {foreach name=o item=row from=$m_stops}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}   
                </select>            
            </div>

            <div class="col-lg-6">
                <label for="txt_l_name" class="req">Previous Station</label>
                <select id="stp-station" class="form-control">
                    <option value="">Select a station</option>
                    {foreach name=o key=stcode item=stname from=$stations}
                        <option value="{$stcode}">{$stname}</option>
                    {/foreach}  
                </select>
            </div>
        </div>
                <br>
        <div class="row">
            <div class="col-lg-6">
                <label for="txt_l_name" class="req">Travel Minutes To Reach </label>
                <input type="number" name="stp-minutes" id="stp-minutes" class="inp_error form-control"  value="">
            </div>
        </div>        
        
    </form>
    <br>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="stp-form-action-state"></div>
        <div class="align-right" id="stp-form-buttons">
            <input type="hidden" name="stp-code" id="stp-code" value="" />
            <button class="btn btn-success" type="button" onclick="saveScheduleStop();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelScheduleStopDialog();">Cancel</button>
        </div>
    </div> 
</div>
                
                

<script>
var m_stops = {$stops|json_encode};    
</script>