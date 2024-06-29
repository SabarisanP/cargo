<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">User Booking and Delivery Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$smarty.request.fromDate|date_format:$ns_date_format}  to {$smarty.request.toDate|date_format:$ns_date_format} </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br/>
<div class="clearfix"></div>
<table class="table table-bordered" width="99%">
    <thead>
        <tr class="success">
            <td align="center" rowspan="2">User</td>
            <td align="center" rowspan="2">{lang('lr')} Count</td>
            <td align="center" colspan="4">Booking</td>
            <td align="center" colspan="4">ToPay Delivery Commission</td>
            <td align="center" colspan="2">Delivery</td>
            <td align="center" rowspan="2">Net Payable (H = C+ F -G)</td>
        </tr>
        <tr class="success">
           <!-- booking CGBO -->
            <td align="center">{lang('lr')} Count</td>
            <td align="center">Net Amount (A)</td>
            <td align="center">Commission (B)</td>
            <td align="center">Payable (C = A-B)</td>
            <!-- TO pay then Paid CGTBO -->
            <td align="center">{lang('lr')} Count</td>
            <td align="center">Net Amount (D)</td>
            <td align="center">Commission (E)</td>
            <td align="center">Payable (F =D-E)</td>
            <!-- Delivery CGDL -->
            <td align="center">{lang('lr')} Count</td>
            <td align="center">Commission(G)</td>
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=tot_lr value=0}
        
        {assign var=cgbo_count value=0}
        {assign var=cgbo_netpay value=0}
        {assign var=cgbo_comm value=0}
        
        {assign var=cgtbo_count value=0}
        {assign var=cgtbo_netpay value=0}
        {assign var=cgtbo_comm value=0}
        
        {assign var=cgdl_count value=0}
        {assign var=cgdl_comm value=0}
        
        {assign var=tot_net value=0}
        
        {assign var=cgbo_payable value=0}
        {assign var=cgtbo_payable value=0}
        {assign var=cgdl_payable value=0}
        
        {assign var=tot_net value=0}

        {foreach item=row from=$summary key=user}
            <tr>
                <td align="left"><a href="javascript:;" onclick="userCollectionTable('{$row['user_code']}');">{$user}</a></td>
                <td align="right">{$row['CGBO']['count'] + $row['CGTBO']['count'] + $row['CGDL']['count']}</td>
                 <!-- booking CGBO -->
                <td align="right">{$row['CGBO']['count']+0}</td>
                <td align="right">{$row['CGBO']['net_amount']|number_format:2}</td>
                <td align="right">{$row['CGBO']['commission']|number_format:2}</td>
                <td align="right">{$row['CGBO']['payable']|number_format:2}</td>
                 <!-- TO pay then Paid CGTBO -->
                <td align="right">{$row['CGTBO']['count']+0}</td>
                <td align="right">{$row['CGTBO']['net_amount']|number_format:2}</td>
                <td align="right">{$row['CGTBO']['commission']|number_format:2}</td>
                <td align="right">{$row['CGTBO']['payable']|number_format:2}</td>
                <!-- CGDL -->
                <td align="right">{$row['CGDL']['count']+0}</td>
                <td align="right">{$row['CGDL']['commission']|number_format:2}</td>
                
                
                <td align="right">{($row['CGBO']['payable'] + $row['CGTBO']['payable'] - $row['CGDL']['commission'])|number_format:2}</td>
            </tr>
            {assign var=tot_lr value=$tot_lr + $row['CGBO']['count'] + $row['CGTBO']['count'] + $row['CGDL']['count']}
            {assign var=cgbo_count value=$cgbo_count + $row['CGBO']['count']}
            {assign var=cgbo_netpay value=$cgbo_netpay + $row['CGBO']['net_amount']}
            {assign var=cgbo_comm value=$cgbo_comm + $row['CGBO']['commission']}
            {assign var=cgbo_payable value=$cgbo_payable + $row['CGBO']['payable']}
            
            {assign var=cgtbo_count value=$cgtbo_count + $row['CGTBO']['count']}
            {assign var=cgtbo_netpay value=$cgtbo_netpay + $row['CGTBO']['net_amount']}
            {assign var=cgtbo_comm value=$cgtbo_comm + $row['CGTBO']['commission']}
            {assign var=cgtbo_payable value=$cgtbo_payable + $row['CGTBO']['payable']}
            
            {assign var=cgdl_count value=$cgdl_count + $row['CGDL']['count']}
            {assign var=cgdl_comm value=$cgdl_comm + $row['CGDL']['commission']}
            
            {assign var=tot_net value=$tot_net + ($row['CGBO']['payable'] + $row['CGTBO']['payable'] - $row['CGDL']['commission'])}
        {foreachelse}
            <tr>
                <td colspan="9" align="center">No Records Found!</td>
            </tr>
        {/foreach}
        {if $summary|count}
            <tr class="active">
                <td align="right" colspan="1" class="bold">Total</td>
                <td align="right" class="bold">{$tot_lr}</td>
                <td align="right" class="bold">{$cgbo_count}</td>
                <td align="right" class="bold">{$cgbo_netpay|number_format:2}</td>
                <td align="right" class="bold">{$cgbo_comm|number_format:2}</td>
                <td align="right" class="bold">{$cgbo_payable|number_format:2}</td>
                
                <td align="right" class="bold">{$cgtbo_count}</td>
                <td align="right" class="bold">{$cgtbo_netpay|number_format:2}</td>
                <td align="right" class="bold">{$cgtbo_comm|number_format:2}</td>
                <td align="right" class="bold">{$cgtbo_payable|number_format:2}</td>
                
                <td align="right" class="bold">{$cgdl_count}</td>
                <td align="right" class="bold">{$cgdl_comm|number_format:2}</td>
                
                <td align="right" class="bold">{$tot_net|number_format:2}</td>
            </tr>
        {/if}
    </tbody>
</table>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div>

<div id="user-collection-dialog" class="dialog-content-page" style="display: none">
    <a href="javascript:;" class="pull-right close-btn" onclick="closeUserCollection();"><i class="fa fa-times-circle fa-2x"></i></a>
    <div id="user-collection-cont"></div>
</div>

<script>
    var cargoUserCollection = {$summary|json_encode};

    function userCollectionTable(userCode) {
        $('#user-collection-cont').html(loading_popup);
        $('#user-collection-dialog').css('background', '#fff');
        $('#user-collection-dialog').removeClass('hide');
        $('#user-collection-dialog').dialog({
            autoOpen: true,
            height: 600,
            width: $(window).width() - 50,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();
        
        var data = {$smarty.request|json_encode};
        data.userCode = userCode;

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'cargo/user-collection-report-details',
            data: data,
            success: function (response) {
                $('#user-collection-cont').html(response);
            }
        });        
    }

    function closeUserCollection() {
        $('#user-collection-dialog').hide();
        $('#user-collection-dialog').dialog('destroy');
    }
</script>