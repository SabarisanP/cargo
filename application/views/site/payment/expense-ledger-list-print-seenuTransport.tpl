<div class="print-border-top"></div>
<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>
<table border="1" class="bordered main-table" cellpadding="2" width="101.5%">
    <thead>
        <tr class="table-column">
            <td align="center" colspan="12" style="border:white">
                <h2 style="margin:0;">Seenu Transports Pvt Ltd</h2>
                <span style="margin:0;">Regd.off : NO: 10, Transport city Main road, Sonia Gandhi nagar,
                    Mettupalayam,
                    Pondicherry-605 009.
                    Ph: 0413
                    2274540 / 9380279070.</span>
                <br>
                <br>
                <table>
                    <tr>
                        <td align="center"><u>Voucher</u></td>
                    </tr>
                    <tr>
                        <td align="center">[cash]</td>
                    </tr>

                    <tr>
                        <td align="center">Acc Date:{($expense|date_format:"%d-%b-%Y %I:%M %p")|substr:0:11}</td>
                    </tr>
                </table>
                <br><br>
                <table width="100%">
                    <tr>
                        <td colspan="6" align="left">LR No:</td>
                        <td colspan="6" align="right">Voucher No:{$voucherNumber}</td>
                    </tr>
                </table>

            </td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SEQ</td>
            <td>Account</td>
            <td>charged to Vendor/Remarks </td>
            <td>Evidence<br>Type/Date/Currency/Rate</td>
            <td>Debit Amount</td>
            <td>Credit Amount</td>
        </tr>
        <tr>
            <td>1</td>
            <td align="left">{$account[0]}</td>
            <td align="left">{$chargedTo}</td>
            <td align="left">Expenses {($expense|date_format:"%d-%b-%Y %I:%M %p")|substr:0:11}</td>
            <td align="right">{$debitAmount}</td>
            <td align="right">0</td>
        </tr>
        <tr>
            <td>2</td>
            <td align="left">{$account[1]}</td>
            <td align="left">{$chargedTo}</td>
            <td align="left">Expenses {($expense|date_format:"%d-%b-%Y %I:%M %p")|substr:0:11}</td>
            <td align="right">0</td>
            <td align="right">{$debitAmount}</td>
        </tr>
        <tr>
            <td colspan="4" align="right"><b>Total</b></td>
            <td align="right">{$debitAmount}</td>
            <td align="right">{$debitAmount}</td>
        </tr>
    </tbody>
</table>
<table class="print-footer" cellpadding="3" width="100%">
    <tr>
        <td align="left" width="15%" class="bold">Prepared By : {$usr_login_name}</td>
        <td align="left" width="25%" class="bold">SeenuTransport.Pvt LTd</td>
    </tr>
</table>


<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            color-adjust: exact !important;
            font-family: sans-serif;
        }

        table {
            border-collapse: collapse;
        }

        @page {
            size: A4 portrait;
        }

        div.print-border {
            position: fixed;
            bottom: 28px;
            left: 7px;
            width: 100%;
            height: 1px;
            /* Set the height of the border as needed */
            background-color: #000;
            /* Set the border color as needed */
        }

        .print-border-top {
            position: fixed;
            top: 10px;
            width: 100%;
            height: 1px;
            /* Set the height of the border as needed */
            background-color: #000;
        }

        div.print-border-left,
        div.print-border-right {
            position: fixed;
            top: 6px;
            height: 97%;
            width: 1px;
            /* Set the width of the borders as needed */
            background-color: #000;
            /* Set the border color as needed */
            z-index: 1;
            /* Move the borders behind the content */
        }

        div.print-border-left {
            left: 7px;

        }

        div.print-border-right {
            right: 0px;

        }

        .print-footer {
            position: fixed;
            bottom: 0;
        }
    }
</style>