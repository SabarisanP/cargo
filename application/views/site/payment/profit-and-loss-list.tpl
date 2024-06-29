<div class="col-md-12">
    <div class="text-center p-y-6">
        <h4><b>{$namespace_name}</b></h4>
    </div>
    <div class="text-center">
        <h5><b>Profit and Loss</b></h5>
    </div>
    <div class="text-center p-y-6 gist">
        From {$fromDate|date_format:$ns_date_format} To {$toDate|date_format:$ns_date_format}
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
                <td class="text-left"><a href="javascript:;" onclick="balanceSheet('BRNCLS');">Branch Closing</a></td>
                <td class="text-right">-</td>
                <td class="text-right">-</td>
                <td class="text-right">{$result['BRNCLS']|number_format:2}</td>
                {assign var=tot_income value=$tot_income + $result['BRNCLS']}
            </tr>
            <tr class="row-noborder">
                <td class="text-left"><a href="javascript:;" onclick="balanceSheet('RECPT');">Payment Receipt</a></td>
                <td class="text-right">-</td>
                <td class="text-right">-</td>
                <td class="text-right">{$result['RECPT']|number_format:2}</td>
                {assign var=tot_income value=$tot_income + $result['RECPT']}
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
            {foreach key=expense item=row from=$expenses}
                <tr class="row-noborder">
                    <td class="text-left">
                        {assign var=names value=implode(', ', $row['name'])}
                        {$expense} <span class="text-muted noprint">- ({$row['count']}) - 
                        {if strlen($names) > 50}
                            {$names|truncate:50}
                            <a href="javascript:;" data-toggle="tooltip" title="{implode('<br/>', $row['name'])}"><i class="fa fa-info-circle"></i></a>
                        {else}
                            {$names}
                        {/if}</span>
                    </td>
                    <td class="text-right"></td>
                    <td class="text-right"></td>
                    <td class="text-right">{$row['amount']|number_format:2}</td>
                </tr>
                {assign var=tot_expense value=$tot_expense + $row['amount']}
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
                        <th class="text-left">Vehicle / Transit / Branch / LR / Others</th>
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
        <div class="table-responsive" id="BRNCLS">
            <h5>Branch Closing</h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="bold hover-background">
                        <th class="text-left">Branch User</th>
                        <th class="text-right">Amount</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$result['data']['BRNCLS']}
                        <tr>
                            <td class="text-left">{$row->entity_name}</td>
                            <td class="text-right">{$row->entity_value|number_format:2}</td>
                        </tr>
                    {/foreach}
                    <tr class="bold">
                        <td class="text-right">Total</td>
                        <td class="text-right">{$result['BRNCLS']|number_format:2}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="table-responsive" id="RECPT">
            <h5>Payment Receipt</h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="bold hover-background">
                        <th class="text-left">Branch User</th>
                        <th class="text-right">Amount</th>
                    </tr>
                </thead>
                <tbody class="body_table">
                    {foreach item=row from=$result['data']['RECPT']}
                        <tr>
                            <td class="text-left">{$row->entity_name}</td>
                            <td class="text-right">{$row->entity_value|number_format:2}</td>
                        </tr>
                    {/foreach}
                    <tr class="bold">
                        <td class="text-right">Total</td>
                        <td class="text-right">{$result['RECPT']|number_format:2}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $('[data-toggle="tooltip"]').tooltip({
        html: true
    });
</script>

<style media="print">
    a {
        text-decoration: none;
    }
    table {
        border-collapse: collapse;
        border-spacing: 0;
        max-width: 100%;
        background-color: transparent
    }
    td, th {
        padding: 0
    }
    h4, h5 {
        font-family: inherit;
        font-weight: 500;
        line-height: 1.1;
        color: inherit;
        margin-top: 10px;
        margin-bottom: 10px
    }
    .text-left, th {
        text-align: left
    }
    .text-right {
        text-align: right
    }
    .text-center {
        text-align: center
    }
    .text-muted {
        color: #999
    }
    .col-md-12 {
        position: relative;
        min-height: 1px;
        padding-left: 15px;
        padding-right: 15px
    }
    @media (min-width:992px) {
        .col-md-12 {
            float: left;
            width: 100%
        }
    }
    .table {
        width: 100%;
        margin-bottom: 20px
    }
    .table>tbody>tr>td,
    .table>thead>tr>th {
        padding: 8px;
        line-height: 1.428571429;
        border-top: 1px dashed #ddd
    }
    .table>thead>tr>th {
        vertical-align: bottom;
        border-bottom: px solid #ddd
    }
    .table>tbody>tr>td {
        vertical-align: top
    }
    .table>thead:first-child>tr:first-child>th {
        border-top: 0
    }
    .table-bordered,
    .table-bordered>tbody>tr>td,
    .table-bordered>thead>tr>th {
        border: 1px solid #ddd
    }
    .table-bordered>thead>tr>th {
        border-bottom-width: 2px
    }
    .pull-right {
        float: right !important
    }
    .hide {
        display: none !important
    }
    h4 {
        font: 400 20px/23px"Open Sans", Arial, sans-serif
    }
    h5 {
        font: 400 16px/19px"Open Sans", Arial, sans-serif
    }
    .table>tbody>tr>td {
        vertical-align: middle
    }
    .table-bordered,
    .table-bordered tr:first-child th:first-child,
    .table-bordered tr:first-child th:last-child,
    .table-bordered tr:last-child td:first-child,
    .table-bordered tr:last-child td:last-child {
        -webkit-border-radius: 0;
        -moz-border-radius: 0;
        border-radius: 0
    }
    .clear_fix_both {
        clear: both
    }
    .table>tbody>tr>td,
    .table>thead>tr>th {
        padding: 5px !important
    }
    .bold {
        font-weight: 700 !important
    }
    .pd_16 {
        padding-top: 16px
    }
    .gist {
        font-size: 14px
    }
    .table>thead>tr>th {
        vertical-align: middle
    }
    .hover-background,
    .hover-background td,
    .hover-background th {
        background-color: #f3f3f3 !important;
    }
    tr.row-noborder td {
        border: 0 !important
    }
    .p-y-6 {
        padding: 6px 0
    }
</style>