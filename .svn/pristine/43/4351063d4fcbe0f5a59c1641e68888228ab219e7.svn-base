{function name="userBalance" data=[]}
    <div class="table-responsive">
        <table class="table table-bordered user-balance-table" width="98%">
            <thead>
                <tr class="success">
                    <th class="no-wrap">Group<i class="fa fa-sort pull-right"></i></th>
                    <th class="no-wrap">Payment Type<i class="fa fa-sort pull-right"></i></th>
                    <th class="no-wrap">Name<i class="fa fa-sort pull-right"></i></th>
                    <th class="no-wrap">Last Transaction Date<i class="fa fa-sort pull-right"></i></th>
                    {* <th class="no-wrap no-sort">Commission</th> *}
                    <th class="no-wrap">Current Balance<i class="fa fa-sort pull-right"></i></th>
                </tr>
            </thead>
            <tbody class="body_table">
                {foreach from=$data item=row}
                    {if $row->user_role_code == 'USER'}
                        <tr>
                            <td>{$row->user_group_name}</td>
                            <td>{$row->payment_type_code}</td>
                            <td>{$row->first_name}</td>
                            <td>{$row->last_transaction_date|date_format:$ns_datetime_format}</td>
                            {* <td width="650">
                                <div class="row">
                                    <div class="col-md-4"><b>Paid : </b>{$row->paid_commission}</div>
                                    <div class="col-md-4"><b>Topay : </b>{$row->topay_commission }</div>
                                    <div class="col-md-4"><b>Accpay : </b>{$row->accpay_commission }</div>
                                    <div class="col-md-4"><b>Loading : </b>{$row->loading_commission }</div>
                                    <div class="col-md-4"><b>Unloading : </b>{$row->unloading_commission }</div>
                                    <div class="col-md-4"><b>Delivery topay : </b>{$row->delivery_topay_commission}</div>
                                    <div class="col-md-4"><b>Delivery paid : </b>{$row->delivery_paid_commission }</div>
                                    <div class="col-md-4"><b>Delivery accpay : </b>{$row->delivery_accpay_commission}</div>
                                </div>
                            </td> *}
                            <td align="right">{$row->current_balance|inr_format}</td>
                        </tr>
                    {/if}
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
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$branchwise key=branchname item=branch}
                <tr class="point_cur" onclick="showBranchDetail('{$cnt}');">
                    <td>{$cnt}</td>
                    <td>{$branchname|ucwords}</td>
                    <td align="right">{$branch['total']|sigma:$total_amt|inr_format}</td>
                </tr>
                <tr>
                    <td colspan="3" class="hide brn-table"  id="brn-{$cnt}">
                        {call userBalance data=$branch['data']}
                    </td>
                </tr>
                {$cnt = $cnt+1}
            {/foreach}
        </tbody>
        {* <tfoot> *}
            <tr style="background-color: #f8f9fa;">
                <td colspan="2" align="right"><b>Total</b></td>
                <td align="right"><b>{$total_amt|inr_format}</b></td>
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
                        {call userBalance data=$branch['data']}
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
    {call userBalance data=$result}
{/if}

<script>
    $('.user-balance-table').DataTable({
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