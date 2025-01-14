<table class="" width="95%">
    <tr>
        <td colspan="2" align="center"><span class="bold">{iflang('Delivery Ledger Report')}</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$fromDate|date_format:$ns_date_format} to {$toDate|date_format:$ns_date_format}
        <td width="50%" align="right"><span class="bold">Report At : </span>
            {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$username} </td>
    </tr>
</table>

<h5><b>Transactions</b></h5>

<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered ">
        <thead>
            <tr class="success">
                <th style="text-align: center;">S.No</th>
                <th style="text-align: center;">Ogpl No.</th>
                <th style="text-align: center;">Created Date</th>
                <th style="text-align: center;">From </th>
                <th style="text-align: center;">To </th>
                <th style="text-align: center;">Vehicle No</th>
                <th style="text-align: center;">Vehicle Type</th>
                <th style="text-align: center;">Total Amount</th>
                <th style="text-align: center;">Tot LR</th>
                <th style="text-align: center;">Driver Name</th>
                <th style="text-align: center;">Status</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {assign var=s_no value=1}
            {foreach $groupedOgpl as $key=>$value}
                {assign var=index value=0}
                {foreach  $value as $innerKey=>$innerValue}
                    {if strpos($innerValue->alias_code, 'DD') == false}
                       <tr>
                       {if $index == 0}
                           <td align="center" rowspan="{$value|count}">{$s_no++c}</td>
                       {/if}
                           <td align="center" nowrap><a href='javascript:;' title="more details"
                                   onclick='printDeliveryReport2("{$innerValue->transit_code}" , "{$innerValue->from_organization_code}", "{$innerValue->to_organization_code}")'>{$innerValue->alias_code}</a></td>
                           <td align="center">{$innerValue->loaded_at|date_format}</td>
                           <td align="center">{$innerValue->transit_from_organization_name}</td>
                           <td align="center">{$innerValue->transit_to_organization_name}</td>
                           <td align="center">{$innerValue->registration_number}</td>
                           <td align="center">{$innerValue->vehicle_type_code}</td>
                           <td align="center">{$innerValue->total_amount}</td>
                           <td align="center">{$innerValue->cargo_count}</td>
                           <td align="center">{$innerValue->driver_name}</td>
                           <td align="center">{$innerValue->transit_activity_status_code}</td>
       
                       </tr>
                       {assign var=index  value=$index+1}
                    {/if}
                {/foreach}
            {/foreach}
        </tbody>
    </table>
</div>


<script>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });

    // function showTransactionReceiptPdfDialog(code) {
    //         $('#cargo-invoice-iframe').html('');
    //         $('#cargo-invoice-pdf-dialog').css('background', '#fff');
    //         $('#cargo-invoice-pdf-dialog').removeClass('hide');
    //         $('#cargo-invoice-pdf-dialog').dialog({
    //             autoOpen: true,
    //             height: 700,
    //             width: 1100,
    //             modal: true,
    //             resizable: false,
    //             closeOnEscape: true
    //         });
    //         $('.ui-dialog-titlebar').hide();

    //         var $iframe = $('<iframe />');
    //         $iframe.attr('src', base_url + 'cargo/delivery_ledger_report_print?code=' + code);
    //         $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
    //         $('#cargo-invoice-iframe').html($iframe);
    //     }
</script>