<style>
    .bold {
        font-weight: bold;
    }

    .bordered,
    .bordered tr th,
    .bordered tr td {
        border: 1px solid #000000;
    }

    .title {
        font-weight: bold;
        text-align: center;
    }

    .bold {
        font-weight: bold;
    }

    .bolder {
        font-weight: 900;
    }

    .border-top {
        border-top: 1px solid #000;
    }

    .bordered td {
        border: 1px solid #000;
    }

    .border-bottom {
        border-bottom: 1px solid #000;
    }

    .dotted-border-bottom {
        border-bottom: 1px dashed #000;
    }

    .border-outline {
        border: 1px solid #000;
    }

</style>

<table class="border-outline" width="100%" cellspacing="0" cellpadding="0">
    <thead>
        <tr class="bold">
            <td width="25%" align="right"><br><br>
                &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" width="50%">
                <h2 style="font-size: 17px;"> Seenu Transports Pvt.Ltd. </h2>
                <h2 style="font-size: 12px;">RP BILLS</h2>
            </td>
            <td align="center" width="25%">
            </td>
        </tr>
        <tr class="bold">
            <td width="25%" align="center">
                <h2 style="font-size: 8px;">BILL ID : {$result->code}</h2>
            </td>
            <td align="center" width="35%">
            </td>
            <td align="center" width="40%">
            </td>
        </tr>
        <tr class="bold">
            <td width="30%" align="center">
                <h2 style="font-size: 8px;">SENDING DATE : {$result->createdAt|date_format:$ns_datetime_format}</h2>
            </td>
            <td align="center" width="30%">
                <h2 style="font-size: 8px;">SENDING BY : {$result->createdUser->name}</h2>
            </td>
            <td align="center" width="40%">
                <h2 style="font-size: 8px;">FROM LOCATION : {$result->fromOrganization->name}</h2>
            </td>
        </tr>
        <tr class="bold">
            <td width="30%" align="center">
                <h2 style="font-size: 8px;">RECEIVED DATE : {$result->receivedAt|date_format:$ns_datetime_format}</h2>
            </td>
            <td align="center" width="30%">
                <h2 style="font-size: 8px;">RECEIVED BY : {$result->receivedUser->name} </h2>
            </td>
            <td align="center" width="40%">
                <h2 style="font-size: 8px;">TO LOCATION : {$result->toOrganization->name}</h2>
            </td>

        </tr>
    </thead>
</table>
<table border="1" class="bordered" cellpadding="5" width="100%">
    <thead>
        <tr class="bold">
            <th width="6%" nowrap>SNO</th>
            <th width="12%">GCNNO</th>
            <th width="12%">GCNDATE</th>
            <th width="12%">CONSIGNOR</th>
            <th width="12%">CONSIGNEE</th>
            <th width="12%"> AMOUNT</th>
            <th width="10%">MODE OF PAYMENT</th>
            <th width="12%">POD DATE</th>
            <th width="12%">REMARKS</th>
        </tr>
    </thead>
    <tbody>
        {foreach item=row from=$result->cargoList key=i}
            <tr>
                <td width="6%" align="left">{$i + 1}</td>
                <td width="12%" align="center">{$row->code}</td>
                <td width="12%" align="center">{$row->bookedAt|date_format:$ns_datetime_format}</td>
                <td width="12%" align="center">{$row->fromCustomer->name}</td>
                <td width="12%" align="center" nowrap>{$row->toCustomer->name}</td>
                <td width="12%" align="center">{$row->totalAmount}</td>
                <td width="10%" align="center">{$row->paymentType->name}</td>
                <td width="12%" align="center">{$row->cargoStatus->updatedAt|date_format:$ns_datetime_format}</td>
                <td width="12%" align="center"></td>
            </tr>
        {/foreach}
    </tbody>
</table>

