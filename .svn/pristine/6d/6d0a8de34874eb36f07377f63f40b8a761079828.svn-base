<div class="print-border-top"></div>
<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>

<div class="print-header" width="100%">
    <table border="1" cellpadding="2" width="100%" class="mytable">
        <tr>
            <td colspan="12">
                <img align="left" style="margin-left: 10px;margin-top:30px;"
                    src="{$base_url}/assets/img/seenutransports-logo.png" alt="logo" width="150px">
                <h1 align="center">Seenu Transports Pvt Ltd</h1>

                <h3 align="center">Ledger Wise Report</h3>
            </td>
        </tr>
    </table>
</div>


<table style="border:none" width="100%" class="body-start">
    <tr>
        <td colspan="6"> <span style="width:50px">Account No</span>:</td>
        <td colspan="6">
            <div style="display:inline-block;  width:80px"><span>From Date</span></div>
            <span>:{$fromDate|date_format:"d-M-Y"}</span>
        </td>
    </tr>
    <tr>
        <td colspan="6"><span style="width:50px font-size: 13px;">Account Name:{$accountName}</span></td>
        <td colspan="6">
            <div style="display:inline-block;  width:80px"><span>To Date</span></div>
            <span>:{$toDate|date_format:"d-M-Y"}</span>
        </td>
    </tr>
</table>

<div class="table-start">
    <table border="1" cellpadding="2" width="99%">
        <thead>
            <tr>
                <td align="center" style="font-size: 13px;"><b>Accounting Date</b></td>
                <td align="center" style="font-size: 13px;"><b>Account Name</b></td>
                <td align="center" style="font-size: 13px;"><b>Details</b></td>
                <td align="center" style="font-size: 13px;"><b>Reference/ Bill No.</b></td>
                {if $remarks_required == 1}
                    <th class="text-left" align="left" style="font-size: 13px;">Remarks</th>
                {/if}
                <td align="center" style="font-size: 13px;"><b>Costing Name</b></td>
                <td align="center" style="font-size: 13px;"><b>Payment Type</b></td>
                <td align="center" style="font-size: 13px;"><b>Debit</b></td>
                <td align="center" style="font-size: 13px;"><b>Credit</b></td>
            </tr>
        </thead>
        <tbody>
            {assign var=index value=0}
            <tr>
                {if $remarks_required == 1}
                    <td colspan="7" align="right" style="font-size: 13px;"><b>Opening Balance</b></td>
                {else}
                    <td colspan="6" align="right" style="font-size: 13px;" ><b>Opening Balance</b></td>
                {/if}

                <td align="right" style="font-size: 13px;" ><b>{$openingBalanceAmount|inr_format}</b></td>
                <td align="right" style="font-size: 13px;"><b>
                        {0.00|inr_format}</b></td>
            </tr>

            {foreach item=row from=$result}

                {if $index % 5 == 0}
                    <tr class="page-break"></tr>

                {/if}


                {if $row->activeFlag == 5}

                    {continue}

                {/if}
                <tr>
                    <td align="left" style="font-size: 13px;">{$row->createdAt|date_format:"d-M-Y"}</td>
                    <td align="left" style="font-size: 13px;">{$row->toContact->name|default:'-'}</td>
                    <td align="left" style="font-size: 13px;">{$row->description}</td>
                    <td align="left" style="font-size: 13px;">{$row->voucherNumber|default:'-'}</td>
                    <td></td>
                    {if $remarks_required == 1}
                        <td align="left" style="font-size: 13px;"><span
                                title="{$row->remarks}">{$row->remarks|truncate:30:"...":true}</span></td>
                    {/if}
                    <td align="left" style="font-size: 13px;">{$row->ledgerType->name|default:'-'}</td>
                    <td align="right" style="font-size: 13px;">{$row->debitAmount|inr_format}</td>
                    <td align="right" style="font-size: 13px;">{$row->creditAmount|inr_format}</td>
                </tr>

                {assign var=index value=$index+1}

            {foreachelse}
                <tr>
                    <td colspan="
            {if $remarks_required == 1}7
            {else}6
            {/if}" align="center">No data found</td>
                </tr>

            {/foreach}
        </tbody>
        {if $result|count}
            <tfoot>
                <tr>
                    <td></td>
                    {if $remarks_required == 1}
                        <td colspan="6" align="right" style="font-size: 13px;"><b>Total</b></td>
                    {else}
                        <td colspan="5" align="right" style="font-size: 13px;"><b>Total</b></td>
                    {/if}
                    <td style="font-size: 13px;" >{$openingBalanceAmount|inr_format}</td>
                    <td style="font-size: 13px;" >{$totalCredit}</td>
                </tr>
                <tr>
                    <td></td>
                    {if $remarks_required == 1}
                        <td colspan="6" align="right" style="font-size: 13px;"><b>Closing Balance</b></td>
                    {else}
                        <td colspan="5" align="right" style="font-size: 13px;"><b>Closing Balance</b></td>
                    {/if}
                        <td style="font-size: 13px;" align="right">{$closingBalanceAmount|inr_format}</td>
                        <td style="font-size: 13px;"  align="right">0.00</td>
                    </tr>
                </tfoot>
            {/if}
        </table>
        <br></br>
        <table border="1" cellpadding="2" width="100%">
            <thead>
                <tr>
                    <th align="center"><b>ACCOUNT TYPE</b></th>
                    <th align="center"><b>COUNT</b></th>
                    <th align="center"><b>Debit Amount</b></th>
                    <th align="center"><b>Credit Amount</b></th>
                </tr>
            </thead>
            <tbody>
                {assign var=count value=0}
                {assign var= debit value =0}
                {assign var= credit value =0}
                {foreach $accountType  as $key => $value}
                    <tr>
                        <td>{$key}</td>
                        <td align="right">{$value['count']}</td>
                        <td align="right">{$value['debit']}</td>
                        <td align="right">{$value['credit']}</td>
                        {assign var=count value=$count+$value['count']}
                        {assign var=debit value=$debit+$value['debit']}
                        {assign var=credit value=$credit+$value['credit']}
                    </tr>
                {foreachelse}
                    <tr>
                        <td colspan="4" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>

            {if $accountType|count}
                <tfoot>
                    <tr>
                        <td align="right"><b>Total</b></td>
                        <td align="right">{$count}</td>
                        <td align="right">{$debit}</td>
                        <td align="right">{$credit}</td>
                    </tr>
                </tfoot>
            {/if}

        </table>
    </div>
    <div class="print-footer" id="print-footer">
        <table>
            <tr>
                <td width="35%" style="font-size: 12px;"><b>Printed On : {$smarty.now|date_format:$ns_datetime_format}</b>
                </td>
                <td width="25%" style="font-size: 12px;"><b>Generated By: {$usr_login_name}</b></td>
                {foreach $ogpl->transitRoutes as $row}
                    {if isset($row->createdAt)}
                        <td width="25%">Booked Date & Time : {$row->createdAt|date_format:$ns_datetime_format}</td>
                    {/if}
                    {break}
                {{/foreach}}
            </tr>
        </table>
    </div>



    <style type="text/css" media="print">
        @media print {
            body {
                -webkit-print-color-adjust: exact !important;
                /* position: relative; */
                color-adjust: exact !important;
                font-family: sans-serif;
            }

            .table-head td {
                height: 15px;
                line-height: 25px;
            }

            .loadedByTable td {
                border: white !important;
            }

            div.print-border {
                position: fixed;
                bottom: 0px;
                left: 0px;
                width: 100%;
                height: 1px;
                /* Set the height of the border as needed */
                background-color: #000;
                /* Set the border color as needed */
            }

            .print-border-top {
                position: fixed;
                top: 0px;
                left: 0;
                width: 100%;
                height: 1px;
                /* Set the height of the border as needed */
                background-color: #000;
            }

            div.print-border-left,
            div.print-border-right {
                position: fixed;
                top: 0px;
                height: 100%;
                width: 1px;
                /* Set the width of the borders as needed */
                background-color: #000;
                /* Set the border color as needed */
                z-index: 1;
                /* Move the borders behind the content */
            }

            div.print-border-left {
                left: 0px;

            }

            div.print-border-right {
                right: 0px;

            }

            .print-footer {
                position: fixed;
                bottom: 0;
            }

            /* .main-table {
            position: static;
            top: 0;
        } */

            /* .page-break {
            page-break-before: always;
        } */

            .print-header {
                position: static;
                top: 10px;
                left: 0;
                width: 100%;
            }

            table {
                border-collapse: collapse;
            }

            .body-start {
                position: absolute;
                top: 108px;
            }

            .table-start {
                position: absolute;
                top: 150px;
            }

            .mytable {
                border: 1px solid black;
                position: absolute;
                top: 0px;
                left: 0px;
            }

            .print-footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }
        }

        @page {
            size: A4 landscape;
        }
    </style>