<a class="pull-right" href="javascript:;" id="quickEditButton" onclick="fareQuickEdit()"><i class="fa fa-pencil"></i> Quick edit</a>
<div id="fareQuickEdit" class="form-inline pull-right" style="display:none">
    <div class="form-group sepV_a">
        <div class="input-group">
            <span class="input-group-btn">
                <button type="button" class="btn btn-default" title="subtract" onclick="subtractFareWith()"><strong>-</strong></button>
            </span>
            <input type="text" class="form-control" id="customFare" value="50" maxlength="4">
            <span class="input-group-btn">
                <button type="button" class="btn btn-default" title="add" onclick="addFareWith()"><strong>+</strong></button>
            </span>
        </div>
    </div>
    <div class="form-group sepV_a">
        <input type="text" class="form-control" id="customFixedFare" placeholder="Fixed Fare" maxlength="4">
    </div>
    <button type="button" class="btn btn-success" id="setbtn" title="set fare" onclick="setFare()">Set</button>
    <button type="button" class="btn btn-default" id="rstbtn" title="Reset All" onclick="resetFare()">Reset</button>
</div>

<table class="table info_table table-hover" id="route-fare-tb" width="100%">
<thead>
    <tr>
        <th>
            <label>
                <input type="checkbox" class="qe-cb quick-fare-route-all hide" onchange="toggleAllRouteFareCb(this)" checked> &nbsp;
                Route
            </label>
        </th>
        {foreach from=$seatTypes item=row}
        <th>
            <label>
                <input type="checkbox" class="qe-cb seat-type hide" value="{$row['type']}" checked> &nbsp;
                {$row['name']} 
            </label>
        </th>
        {/foreach}
                        
    </tr>
</thead>
<tbody>
    {foreach from=$fares item=row}
        <tr>           
            <td valign="middle" nowrap>
                <label class="font-weight-normal">
                    <input type="checkbox" class="qe-cb quick-fare-route-cb hide" checked> &nbsp;
                    {$row['fromName']} - {$row['toName']}
                </label>
            </td>
            {foreach from=$seatTypes item=type}            
            <td>
                 <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-rupee"> </i></span>
                    <input type="input" class='form-control fare-cells' data-oldfare='{$row['stageFare'][$type['type']]->fare}' data-type='{$row['stageFare'][$type['type']]->seatType}' data-from='{$row['fromCode']}' data-to='{$row['toCode']}' data-minfare='{$row['stageFare'][$type['type']]->minFare}' data-maxfare='{$row['stageFare'][$type['type']]->maxFare}' maxlength="4" style="width:50px"  value="{$row['stageFare'][$type['type']]->fare}" />
                </div>
                <small class="text-muted">
                {if $row['stageFare'][$type['type']]->minFare > 0}
                Min {$row['stageFare'][$type['type']]->minFare}
                {/if}
                {if $row['stageFare'][$type['type']]->maxFare > 0}
                Max {$row['stageFare'][$type['type']]->maxFare}
                {/if}
                </small>
            </td>
            {/foreach}
        </tr>
    {/foreach}     
</tbody>
</table>

<div class="row">           
    <div class="col-lg-12 col-md-12 text-center" id='fare-action-error' ></div>
</div>

<div class="row" id="fare-action-button">           
    <div class="col-lg-11 col-md-11 text-right" >
        <button onclick="saveFareSetup()" class="btn btn-success btn-search" type="button">Update</button>
        &nbsp;
        <button class="btn btn-default btn-clear" type="button" onclick="clearFareSetup()">Clear</button>
    </div>
</div>
