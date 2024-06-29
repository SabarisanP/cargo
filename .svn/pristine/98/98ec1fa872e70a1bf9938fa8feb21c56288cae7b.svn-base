<style>
    .bold,
    .bold th,
    .bold td {
        font-weight: bold;
    }
    .text-center {
        text-align: center;
    }
    .text-right {
        text-align: right;
    }
    .hover-background,
    .hover-background td,
    .hover-background th {
        background-color: #f3f3f3;
    }
    table th, table td {
        padding: 5px;
    }
    h4 {
        font: 400 20px/23px"Open Sans", Arial, sans-serif
    }
    h5 {
        font: 400 16px/19px"Open Sans", Arial, sans-serif
    }
</style>

{strip}
<h4 class="text-center"><b>{$namespace_name}</b></h4>
<h5 class="text-center"><b>Profit and Loss</b></h5>
<div class="text-center">
    From {$fromDate|date_format:$ns_date_format} To {$toDate|date_format:$ns_date_format}
</div>
<div class="table-responsive pd_16">
    <table class="table gist" cellpadding="3">
        <tr class="row-noborder bold hover-background">
            <td class="text-left" width="61%">Income</td>
            <td class="text-right" width="13%">Paid</td>
            <td class="text-right" width="13%">Unpaid</td>
            <td class="text-right" width="13%">Total</td>
        </tr>
        {assign var=tot_income value=0}
        <tr class="row-noborder">
            <td class="text-left" width="61%">Voucher Income</td>
            <td class="text-right" width="13%">{($result['VOU_PAID'])|number_format:2}</td>
            <td class="text-right" width="13%">{($result['VOU_INT'])|number_format:2}</td>
            <td class="text-right" width="13%">{($result['VOU_PAID'] + $result['VOU_INT'])|number_format:2}</td>
            {assign var=tot_income value=$tot_income + ($result['VOU_PAID'] + $result['VOU_INT'])}
        </tr>
        <tr class="row-noborder">
            <td class="text-left" width="61%">Invoice Income</td>
            <td class="text-right" width="13%">{($result['INV_PAID'])|number_format:2}</td>
            <td class="text-right" width="13%">{($result['INV_INT'])|number_format:2}</td>
            <td class="text-right" width="13%">{($result['INV_PAID'] + $result['INV_INT'])|number_format:2}</td>
            {assign var=tot_income value=$tot_income + ($result['INV_PAID'] + $result['INV_INT'])}
        </tr>
        <tr class="row-noborder">
            <td class="text-left">Other Income</td>
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
                    {$expense}
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
{/strip}