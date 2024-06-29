<div class=""> 
    <h4 class=''>
        <span class="fa fa-list"></span>
        &nbsp;&nbsp;Cancellation Policy</h4> 
</div>
<div class="ovr_cancel">
    <ul class="list-unstyled">
        {foreach item=rows from=$cancel->policyList}
            {assign var='p' value=$rows->policyPattern}
            {assign var='f' value=$rows->fromValue}
            {assign var='ds' value=$rows->deductionAmount}
            {if $rows->fromValue < 1440 && $rows->fromValue > 60}
                {$f = ($rows->fromValue/60)|round}

            {else if $rows->fromValue >= 1440}
                {$f = ($rows->fromValue/(24*60))|round}
            {/if}
            {assign var='t' value=$rows->toValue}
            {if $rows->toValue < 1440 && $rows->toValue > 60}
                {$t = ($rows->toValue/60)|round}
                {$p = "hour"}
            {else if $rows->toValue >= 1440}
                {$t = ($rows->toValue/(24*60))|round}
                {$p = "days"}
            {else if $rows->toValue==0}
                {$t = ""}
                {$ds = "ANY TIME"}
            {/if}

            <li>Between {$f} {$p} {if $rows->toValue!=0}- {$t} {$p}{/if} - {$ds} % Deducation</li> 

        {/foreach} 
    </ul>
</div>
<div class="m-t-5" align="right"><a href="javascript:;" class="btn btn-default close-cancel">Close</a></div>