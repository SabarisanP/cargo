<div class="col-md-12">
    <div class="text-center p-y-6">
        <h4><b>{$namespace_name}</b></h4>
    </div>
    <div class="text-center">
        <h5><b>Profit and Loss</b></h5>
    </div>
    <div class="text-center p-y-6 gist">
        From {$smarty.request.fromDate|date_format:$ns_date_format} To {$smarty.request.toDate|date_format:$ns_date_format}
    </div>
    <div class="table-responsive pd_16">
        <table class="table gist">
            <tr class="row-noborder bold hover-background">
                <td class="text-left" width="61%">Income</td>
                <td class="text-right" width="13%">Paid</td>
                <td class="text-right" width="13%">Unpaid</td>
                <td class="text-right" width="13%">Total</td>
            </tr>
            {assign var=tot_income value=0}
            <tr class="row-noborder">
                <td class="text-left" width="61%"><a href="javascript:;" onclick="balanceSheet('VOU');">Voucher Income</a></td>
                <td class="text-right" width="13%">{($result['VOU_PAID'])|number_format:2}</td>
                <td class="text-right" width="13%">{($result['VOU_INT'])|number_format:2}</td>
                <td class="text-right" width="13%">{($result['VOU_PAID'] + $result['VOU_INT'])|number_format:2}</td>
                {assign var=tot_income value=$tot_income + ($result['VOU_PAID'] + $result['VOU_INT'])}
            </tr>
            <tr class="row-noborder">
                <td class="text-left" width="61%"><a href="javascript:;" onclick="balanceSheet('INV');">Invoice Income</a></td>
                <td class="text-right" width="13%">{($result['INV_PAID'])|number_format:2}</td>
                <td class="text-right" width="13%">{($result['INV_INT'])|number_format:2}</td>
                <td class="text-right" width="13%">{($result['INV_PAID'] + $result['INV_INT'])|number_format:2}</td>
                {assign var=tot_income value=$tot_income + ($result['INV_PAID'] + $result['INV_INT'])}
            </tr>
            <tr class="row-noborder">
                <td class="text-left"><a href="javascript:;" onclick="balanceSheet('INCOME');">Other Income</a></td>
                <td class="text-right">-</td>
                <td class="text-right">-</td>
                <td class="text-right">{$result['INCOME']|number_format:2}</td>
                {assign var=tot_income value=$tot_income + $result['INCOME']}
            </tr>
            <tr class="row-noborder bold">
                <td class="text-left" width="61%">Total</td>
                <td class="text-right" width="13%">{($result['VOU_PAID'] + $result['INV_PAID'])|number_format:2}</td>
                <td class="text-right" width="13%">{($result['VOU_INT'] + $result['INV_INT'])|number_format:2}</td>
                <td class="text-right" width="13%">{$tot_income|number_format:2}</td>
            </tr>
            <tr class="row-noborder">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr class="row-noborder bold hover-background">
                <td class="text-left">Expense</td>
                <td class="text-right"></td>
                <td class="text-right"></td>
                <td class="text-right">Total</td>
            </tr>
            {assign var=tot_expense value=0}
            {foreach item=row from=$result['data']['EXPANSE']}
                <tr class="row-noborder">
                    <td class="text-left">{$row->entity_attribute}</td>
                    <td class="text-right"></td>
                    <td class="text-right"></td>
                    <td class="text-right">{$row->entity_value|number_format:2}</td>
                </tr>
                {assign var=tot_expense value=$tot_expense + $row->entity_value}
            {/foreach}
            {if $result['data']['EXPANSE']|count}
                <tr class="row-noborder bold">
                    <td class="text-left">Total</td>
                    <td class="text-right"></td>
                    <td class="text-right"></td>
                    <td class="text-right">{$tot_expense|number_format:2}</td>
                </tr>
            {/if}
            <tr class="row-noborder">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr class="row-noborder bold">
                <td class="text-left">Net Profit/Loss</td>
                <td class="text-right"></td>
                <td class="text-right"></td>
                <td class="text-right">{($tot_income - $tot_expense)|number_format:2}</td>
            </tr>
        </table>
    </div>
</div>

<div id="balance-sheet-dialog" class="hide noprint">
    <a href="javascript:;" class="pull-right" onclick="closeBalanceSheet();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div class="clear_fix_both"></div>
    <div style="height:400px;overflow: auto;">
        <div class="table-responsive" id="VOU_INT">
            <h5>Voucher Unpaid</h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="bold hover-background">
                        <th class="text-left">Name</th>
                        <th class="text-right">Amount</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$result['data']['VOU_INT']}
                        <tr>
                            <td class="text-left">{$row->entity_name}</td>
                            <td class="text-right">{$row->entity_value|number_format:2}</td>
                        </tr>
                    {/foreach}
                    <tr class="bold">
                        <td class="text-left">Total</td>
                        <td class="text-right">{$result['VOU_INT']|number_format:2}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="table-responsive" id="VOU_PAID">
            <h5>Voucher Paid</h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="bold hover-background">
                        <th class="text-left">Name</th>
                        <th class="text-right">Amount</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$result['data']['VOU_PAID']}
                        <tr>
                            <td class="text-left">{$row->entity_name}</td>
                            <td class="text-right">{$row->entity_value|number_format:2}</td>
                        </tr>
                    {/foreach}
                    <tr class="bold">
                        <td class="text-left">Total</td>
                        <td class="text-right">{$result['VOU_PAID']|number_format:2}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="table-responsive" id="INV_INT">
            <h5>Invoice Unpaid</h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="bold hover-background">
                        <th class="text-left">Name</th>
                        <th class="text-right">Amount</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$result['data']['INV_INT']}
                        <tr>
                            <td class="text-left">{$row->entity_name}</td>
                            <td class="text-right">{$row->entity_value|number_format:2}</td>
                        </tr>
                    {/foreach}
                    <tr class="bold">
                        <td class="text-left">Total</td>
                        <td class="text-right">{$result['INV_INT']|number_format:2}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="table-responsive" id="INV_PAID">
            <h5>Invoice Paid</h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="bold hover-background">
                        <th class="text-left">Name</th>
                        <th class="text-right">Amount</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$result['data']['INV_PAID']}
                        <tr>
                            <td class="text-left">{$row->entity_name}</td>
                            <td class="text-right">{$row->entity_value|number_format:2}</td>
                        </tr>
                    {/foreach}
                    <tr class="bold">
                        <td class="text-left">Total</td>
                        <td class="text-right">{$result['INV_PAID']|number_format:2}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="table-responsive" id="INCOME">
            <h5>Income</h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="bold hover-background">
                        <th class="text-left">Name</th>
                        <th class="text-left">Branch</th>
                        <th class="text-right">Amount</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$result['data']['INCOME']}
                        <tr>
                            <td class="text-left">{$row->entity_attribute}</td>
                            <td class="text-left">{$row->entity_name}</td>
                            <td class="text-right">{$row->entity_value|number_format:2}</td>
                        </tr>
                    {/foreach}
                    <tr class="bold">
                        <td class="text-right" colspan="2">Total</td>
                        <td class="text-right">{$result['INCOME']|number_format:2}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>