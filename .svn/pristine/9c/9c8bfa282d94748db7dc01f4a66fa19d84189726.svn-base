<div class="table-responsive">
    <table id="dt_voucher_table" class="table table-bordered widthed">
        <thead>
            <tr class="success">
                <td>#</td>
                <td>Actions</td>
                <td>Payment Code</td>
                <td>Transaction Date</td>
                <td>User</td>
                <td>Handled By</td>
                <td>Transaction Type</td>
                <td>Acknowledment Status</td>
                <td>Payment Date</td>
                <td>Transaction Mode</td>
                <td>Remarks</td>
                <td>Amount</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {if $voucher|count ==0}
                <tr>
                    <td colspan="12" align="center"> Sorry! No data found</td>
                </tr>
            {else}
                {assign var=total_amt value=0}
                {foreach item=row from=$voucher key =k}
                    {assign var=total_amt value=$total_amt+$row->transaction_amount}
                    <tr>
                        <td >{$k+1}</td>
                        <td nowrap="">
                            <a href="javascript:;" data-pnr="{$row->transaction_code}" class="pnr-popover" title="View details"> <i class="fa fa-search" ></i></a> &nbsp;
                            <a target="_blank" href="{$base_url}voucher/voucher-payment-summary?code={$row->transaction_code}" title="Print summary"> <i class="fa fa-print" ></i></a> &nbsp;
                            <a target="_blank" href="{$base_url}voucher/download?code={$row->transaction_code}" title="Download PDF"> <i class="fa fa-download" ></i></a>
                        </td>
                        <td nowrap="">{$row->transaction_code}<!--<a href="javascript:;" data-pnr="{$row->transaction_code}" class="pnr-popover">{$row->transaction_code}</a>--></td>
                        <td nowrap="">{$row->transaction_date|date_format:$ns_datetime_format}</td>
                        <td nowrap="">{$row->user_name}</td>
                        <td nowrap="">{$row->handled_user_name}</td>
                        <td nowrap="">{$f_t_type[$row->transaction_type]}</td>
                        <td nowrap="">{$f_a_status[$row->acknowledment_status]}</td>
                        <td nowrap="">{$row->received_date|date_format:$ns_date_format}</td>
                        <td nowrap="">{if $row->transaction_mode != ''}{$f_t_mode[$row->transaction_mode]}{else}NA{/if}</td>
                        <td >{$row->remarks}</td>
                        <td nowrap="">{$row->transaction_amount|number_format:2}</td>
                    </tr>
                {/foreach} 
                <tr class="success bold">
                    <td colspan="11" align="right" >Total Amount</td>
                    <td >{$total_amt|number_format:2}</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>



{if $voucher|count>0}
<script>
    
    $(document).ready(function() {
                
        $('.pnr-popover').each( function(){
            $(this).popover({
                container:'body',
                content:loading_popup,
                html:true,
                placement:'right',
                trigger:'focus',
            });

            $(this).on('show.bs.popover', function () {
                var ele = this;
                var data = {};
                data.paymentCode = $(this).attr('data-pnr');
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    url: base_url + "voucher/get-voucher-details",
                    data: data,
                    success: function (response) {
                        $(ele).popover('destroy').popover({
                            container:'body',
                            content:response,
                            html:true,
                            placement:'right',
                            trigger:'focus',
                        }).popover('show');

                    }
                });
            })
        });

    });
    
  

</script>
{/if}