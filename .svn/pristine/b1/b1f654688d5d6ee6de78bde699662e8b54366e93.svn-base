{function name="branchBalance" data=[]}
    <div class="table-responsive" id="branch-table">
        <table class="table table-bordered branch-balance-table" width="98%">
            <thead>
                <tr class="success">
                    <th class="no-wrap">User<i class="fa fa-sort pull-right"></i></th>
                    {if $branchColumn}
                        <th class="no-wrap">Branch<i class="fa fa-sort pull-right"></i></th>
                    {/if}
                    <th class="no-wrap">Last Closed Date<i class="fa fa-sort pull-right"></i></th>
                    <th class="no-wrap">Balance<i class="fa fa-sort pull-right"></i></th>
                    <th class="no-wrap">Running Balance<i class="fa fa-sort pull-right"></i></th>
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach from=$data item=row}
                    <tr>
                        <td nowrap>{$row->user->name}</td>
                        {if $branchColumn}
                            <td>{$row->user->organization->name}</td>
                        {/if}
                        <td data-sort="{$row->closingDateTime|strtotime}">{$row->closingDateTime|date_format:$ns_datetime_format}</td>
                        <td align="right">{$row->closingBalance|inr_format}</td>
                        <td align="right">{$row->currentBalance|inr_format}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
{/function}

{if $filterby == 'BRANCH'}
    {$cnt = 1}
    <table class="table table-bordered noprint" style="width:60%;">
        <thead>
            <tr class="success">
                <th width="5%">S.No</th>
                <th>Branch</th>
                <th>Balance</th>
                <th>Running Balance</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$branchwise key=branchname item=branch}
                <tr class="point_cur" onclick="showBranchDetail('{$cnt}');">
                    <td>{$cnt}</td>
                    <td>{$branchname|ucwords}</td>
                    <td align="right">{$branch['total_balance']|sigma:$total_balance|inr_format}</td>
                    <td align="right">{$branch['total_running']|sigma:$total_running|inr_format}</td>
                </tr>
                <tr>
                    <td colspan="4" class="hide brn-table"  id="brn-{$cnt}">
                        {call branchBalance data=$branch['data']}
                    </td>
                </tr>
                {$cnt = $cnt+1}
            {/foreach}
        </tbody>
        {* <tfoot> *}
            <tr style="background-color: #f8f9fa;">
                <td colspan="2" align="right"><b>Total</b></td>
                <td align="right"><b>{$total_balance|inr_format}</b></td>
                <td align="right"><b>{$total_running|inr_format}</b></td>
            </tr>
        {* </tfoot> *}
    </table>
    
    {* print div *}
    <table class="hide" style="width:90%;">
        {* <thead> *}
            <tr>
                <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;Branch</th>
                <th align="right">Total &nbsp;&nbsp;&nbsp;&nbsp;</th>
            </tr>
        {* </thead> *}
        <tbody>
            {foreach from=$branchwise key=branchname item=branch}
                <tr>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;{$branchname|ucwords}</td>
                    <td align="right">{$branch['total']|sigma:$print_total_amt|inr_format}&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" class="hide brn-table"  id="brn-{$cnt}">
                        {call branchBalance data=$branch['data']}
                    </td>
                </tr>
            {/foreach}
        </tbody>
        <tr style="background-color: #f8f9fa;">
            <td align="right"><b>Total</b></td>
            <td align="right"><b>{$print_total_amt|inr_format}&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
        </tr>
    </table>
{elseif $filterby == 'USER'}
    {call branchBalance data=$result branchColumn=true}
{/if}

<script>
    $('.branch-balance-table').DataTable({
        info: false,
        searching: false,
        paging: false,
        order: [],
        sDom: 't',
        columnDefs: [{
            targets: 'no-sort',
            orderable: false,
        }]
    });

    function showBranchDetail(code){
        if($('#brn-'+code).hasClass('hide')){
            $('.brn-table').addClass('hide');
            $('#brn-'+code).removeClass('hide');
        }else{
            $('.brn-table').addClass('hide');
            $('#brn-'+code).addClass('hide');
        }
    }
</script>