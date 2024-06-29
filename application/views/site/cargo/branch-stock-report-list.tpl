<style>
    .table .dataTable {
        margin-top: 0 !important;
    }

    .FixedHeader_Header {
        margin-top: -1px !important;
        z-index: 0 !important;
    }
</style>
<table class="" width="99%">
    <tr>
        <td colspan="2" align="center"><span class="bold">Branch Stock Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            {$fromdate|date_format:$ns_date_format} to
            {$to_date|date_format:$ns_date_format}
        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span>
            {$smarty.now|date_format:$ns_datetime_format}</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br />
<div class="clearfix"></div>
<h5><b>Summary</b></h5>
<table class="table table-bordered " style="width: 45%;">
    <thead>
        <tr class="success">
            <th></th>
            {foreach item=statuscount key=statuscode from=$all_payment_status}
                <th class="text-center">{$cargo_payment_status[$statuscode]}</th>
            {/foreach}
            <th class="text-center" width="70">Total</th>
        </tr>
    </thead>
    <tbody>
        {foreach item=count from=$summary key=branch}
            <tr id="{$branch|replace:' ':''}" class="tr-hover" onclick="toggleToBranchHidRow('{$branch|replace:' ':''}')">
                <td align="left"><a href="javascript:;" onclick="filterBranch('{$branch|trim}')"><b>{$branch}</b></a></td>
                {foreach item=statuscount key=statuscode from=$all_payment_status}
                    <td align="right">{$count[$statuscode] + 0}</td>
                {/foreach}
                <td align="right" nowrap>
                    <b>{$count['total']}</b>
                    <i class="fa fa-caret-down fa-fw pull-right" style="margin-top: 2px;"></i>
                </td>
            </tr>
        {/foreach}
    </tbody>
    <tfoot>
        <tr>
            <th align="left"><b>Total</b></th>
            {assign var="tot" value=0}
            {foreach item=statuscount from=$all_payment_status}
                <th class="text-right">{$statuscount + 0}</th>
                {assign var="tot" value=$tot + $statuscount}
            {/foreach}
            <td class="text-right"><b>{$tot}</b></td>
        </tr>
    </tfoot>
</table>

<table class="hide">
    {foreach item=count from=$summary key=branch}
        <tr class="{$branch|replace:' ':''} hide summary-to-branch">
            <td>
                <table class="table table-bordered " width="100%">
                    <thead>
                        <tr class="active">
                            <th class="text-center">To Branch</th>
                            {foreach item=statuscount key=statuscode from=$all_payment_status}
                                <th class="text-center">{$cargo_payment_status[$statuscode]}</th>
                            {/foreach}
                            <th class="text-center">Total</th>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {foreach item=val from=$count['toOrganizationName'] key=toBranch}
                            <tr>
                                <td align="left"><b>{$toBranch}</b></td>
                                {foreach item=statuscount key=statuscode from=$all_payment_status}
                                    <td align="right">{$val[$statuscode] + 0}</td>
                                {/foreach}
                                <td align="right"><b>{$val['total']}</b></td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </td>
        </tr>
    {/foreach}
</table>
<div class="clearfix"></div>

<h5>
    <b>Transactions</b>
    {if $cargoStatusCode == 'CUL'}
        <button class="btn btn-default pull-right" onclick="print_branch_stock_delivary_report();"
            style="margin-bottom: 5px;"><i class="fa fa-print fa-lg"></i>Delivery Sheet</button>
    {/if}
</h5>
{* working *}

<table class="table-bordered" id="stock-report" width="100%">
    <thead>
        <tr class="tab-backgroud">
            <td align="center">{lang('cargo_code_term')} <i class="fa fa-sort"></i></td>
            {if $cargo_status_code != 'CB'}
                <td align="center">OGPL No <i class="fa fa-sort"></i></td>
            {/if}
            <td align="center">Booked Date <i class="fa fa-sort"></i></td>
            <td align="center" class="dt-filter" data-filterid="from-branch-filter" width="13%">{lang('booking_from_term')} (Booking)<i class="fa fa-sort"></i></td>
            <td align="center" class="dt-filter" data-filterid="to-branch-filter" width="13%">{lang('booking_to_label')} <i class="fa fa-sort"></i></td>
            <td align="center" class="dt-filter" data-filterid="transit-branch-filter" width="13%">Transit Branch <i class="fa fa-sort"></i></td>
            <td align="center" class="dt-filter" data-filterid="pay-status-filter">Payment Status <i class="fa fa-sort"></i></td>
            <td align="center">Cargo Status <i class="fa fa-sort"></i></td>
            <td align="center">Hub Activity <i class="fa fa-sort"></i></td>
            <td align="center">No. Of Articles <i class="fa fa-sort"></i></td>
            <td align="center">Qty <i class="fa fa-sort"></i></td>
            <td align="center">Freight <i class="fa fa-sort"></i></td>
            {if $cargo_status_code == 'CMS'}
                <td align="center">{lang('ogpl')} <i class="fa fa-sort"></i></td>
                <td align="center">Reg No. <i class="fa fa-sort"></i></td>
                <td align="center">Updated By <i class="fa fa-sort"></i></td>
                <td align="center">Updated At <i class="fa fa-sort"></i></td>
            {/if}
        </tr>
    </thead>
    <tbody class="body_table">
        {assign var=t_item_count value=0}
        {assign var=t_total_item_count value=0}
        {assign var=t_total_amount value=0}
        {assign var=demurrage_date value=strtotime("-{$cargo_setting->demurrageDays} days")}

        {foreach item=row from=$result}
            <tr>
                <td align="left">
                    <a href='javascript:;' title="more details" onclick='getCargoDetails("{$row->cargo_code}")'>{$row->cargo_code}</a>

                    {if $cargo_status_code == 'CUL' && $cargo_setting->demurrageProcess->code != 'NOTAVL' && isNotNull($row->unloaded_at)}
                        {assign var=unloadDate value=strtotime($row->unloaded_at)}
                        {if $unload_date < $demurrage_date}
                            <span class="badge badge-warning">Demurrage</span>
                        {/if}
                    {/if}

                    <i class="fa fa-info-circle pull-right" data-toggle="popover" data-content='
                        <b>{lang('booking_sender_term')}  :</b> {$row->from_customer_name} - {$row->from_customer_mobile|mask_mobileno}<br/>
                        <b>{lang('booking_receiver_term')} :</b> {$row->to_customer_name} - {$row->to_customer_mobile|mask_mobileno}<br/>
                    '></i>
                </td>
                {if $cargo_status_code != 'CB'}
                    <td align="left">
                        <a href="#cargo/ogpl-chart-details?transitCode={$row->transit_code}&date={$row->trip_date|date_format:"Y-m-d"}" title="View Chart" target="_blank">{$row->alias_code}</a>
                    </td>
                {/if}
                <td align="left" nowrap>{$row->booked_at|date_format:'%d %b, %I:%M %p'}</td>
                <td align="left">{$row->from_organization_name|trim}</td>
                <td align="left">{$row->to_organization_name|trim}</td>
                <td align="left">{$row->transit_organization_name|trim}</td>
                <td align="left">
                    {$row->payment_type_code|_cargo_payment_status_badge}
                </td>
                <td align="left">
                    {$cargo_status[$row->cargo_status_code]}
                </td>
                <td align="center">
                    {if $row->hub_transit_tag}
                        {assign var="hubflags" value=comma_split($row->hub_transit_tag)}
                        {foreach from=$hubflags item=flag}
                            {if $flag == 'HL'}
                                <span class="badge badge-secondary">Hub.L</span>
                            {elseif $flag == 'HU'}
                                <span class="badge badge-secondary">Hub.UL</span>
                            {/if}
                        {/foreach}
                    {else}
                        -
                    {/if}
                </td>
                <td align="right">{$row->item_count}</td>
                <td align="right">{$row->total_item_count}</td>
                <td align="right">{$row->total_amount|inr_format}</td>
                {if $cargo_status_code == 'CMS'}
                    <td align="left">{(isNotNull($row->alias_code)) ? $row->alias_code : '-'}</td>
                    <td align="left">{$row->registration_number|default:'-'}</td>
                    <td align="left">{$row->status_updated_user_name|default:'-'} <br /><small class="text-muted" title="Branch">{$row->status_updated_organization_name}</small></td>
                    <td align="left" nowrap>
                        {(isNotNull($row->status_updated_at)) ? ($row->status_updated_at|date_format:$ns_datetime_format) : '-'}
                    </td>
                {/if}
            </tr>
            {assign var=t_item_count value=$t_item_count + $row->item_count}
            {assign var=t_total_item_count value=$t_total_item_count + $row->total_item_count}
            {assign var=t_total_amount value=$t_total_amount + $row->total_amount}
        {/foreach}
    </tbody>
    {if $result|count}
        <tfoot>
            <tr style="background-color: #bbbbbb; color: #fff;">
                <td colspan="{if $cargo_status_code != 'CB'}8{else}7{/if}" align="center">
                    {foreach from=$paytype_summary item=amt key=paytype}
                        <b>{$cargo_payment_status[$paytype]} : </b> {$amt|inr_format}&emsp;&emsp;&emsp;
                    {/foreach}
                </td>
                <td colspan="1" align="right"><b>Total</b></td>
                <td align='right'>{$t_item_count}</td>
                <td align='right'>{$t_total_item_count}</td>
                <td align='right'>{$t_total_amount|inr_format}</td>
                {if $cargo_status_code == 'CMS'}
                    <td colspan="4"></td>
                {/if}
            </tr>
        </tfoot>
    {/if}
</table>



<div class="table table-responsive print-branch-stock-delivary hide">
    <table class="table table-bordered">
        {* <thead> *}
        <tr>
            <td colspan="11" align="center"><b>{$operatorName}</b></td>
        </tr>
        <tr>
            <td colspan="4" align="left"><b>Report Date :</b>&nbsp;
                {$smarty.request.fromDate|date_format:$ns_date_format} to
                {$smarty.request.toDate|date_format:$ns_date_format} </td>
            <td align="left" colspan="2">Paid - {$all_payment_status['PAD']} &nbsp;&nbsp;&nbsp;ToPay -
                {$all_payment_status['TOP']}</td>
            <td colspan="5" align="right">{$usr_login_name} @ {$smarty.now|date_format:$ns_datetime_format}</td>
        </tr>
        <tr>
            <th align="left">Booked</th>
            <th align="left">LR</th>
            <th align="left">Receiver</th>
            <th align="left">Mobile</th>
            <th align="left">Items</th>
            <th align="left">Qty</th>
            <th align="right">Paid</th>
            <th align="right">To Pay</th>
            <th align="left">UL&nbsp;&nbsp;</th>
            <th align="left">Total</th>
            <th>Sign&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        </tr>
        {* </thead>  *}
        <tbody class="body_table">
            {foreach item=row from=$result}
                <tr>
                    <td align="left">{date('d-M', strtotime($row->booked_at))}</td>
                    <td align="left">{$row->cargo_code}</td>

                    {$rcv = ucfirst(strtolower($row->to_customer_name))}
                    {if strlen($rcv) > 30}
                        <td align="left">{substr_replace($rcv, "...", 30)}</td>
                    {else}
                        <td align="left">{$rcv}</td>
                    {/if}

                    <td align="left">{$row->to_customer_mobile|mask_mobileno}</td>
                    <td align="left" wrap>{$row->cargo_item_name}</td>
                    <td align="left">{$row->total_item_count}</td>
                    <td align="right" data-format="{$xlformat['currency']}">
                        {if $row->payment_type_code == 'PAD'}
                            {$row->total_amount}
                        {else}
                            0.00
                        {/if}
                    </td>
                    <td align="right" data-format="{$xlformat['currency']}">
                        {if $row->payment_type_code == 'TOP'}
                            {$row->total_amount}
                        {else}
                            0.00
                        {/if}
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
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

    // working
    let table = $('#stock-report').DataTable({

        pageLength: 250,
        lengthMenu: [
            [50, 100, 250, 500, -1],
            [50, 100, 250, 500, "All"]
        ],
        initComplete: function() {
            var datatable = this.api();
            datatable.columns().iterator('column', function(context, index) {
                var column = datatable.column(index);
                var columnData = column.data().unique();
                if (!columnData.length || !$(column.header()).hasClass('dt-filter')) return;

                var select = $(
                        '<select class="form-control text-left"><option value="">Select</option></select>'
                    )
                    .attr('id', column.header().dataset.filterid)
                    .appendTo(column.header())
                    .on('click change', function(e) {
                        if ($(this).val() == '') {
                            column.search($(this).val(), false, false).draw();
                            return false;
                        }
                        column.search("^" + $(this).val() + "$", true, false, true).draw();
                        return false;
                    });

                $(select).select2({ width: '100%' })

                columnData.sort().each(function(d) {
                    select.append(new Option($('<div/>').html(d).text()))
                });
            });
        }
    });
    new $.fn.dataTable.FixedHeader(table);




    function filterBranch(branch) {
        var groupby = '{$summary_group_by}';

        if (groupby == 'transit_organization_name') {
            $('#transit-branch-filter').val(branch).trigger('change');
        } else if (groupby == 'from_organization_name') {
            $('#from-branch-filter').val(branch).trigger('change');
        }

        $('html, body').animate({
            scrollTop: $('#stock-report').offset().top - 35
        }, 'slow');
    }

    function toggleToBranchHidRow(code) {
        if ($('.saleusrlist').hasClass(code)) {
            $('.saleusrlist .slide').slideToggle('linear', function() {
                $('.saleusrlist').remove();
            });
            return;
        }
        $('.saleusrlist').remove();
        var $trows = $('.summary-to-branch').filter('.' + code);
        $('#' + code).after('<tr class="saleusrlist ' + code +
            '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">' +
            $trows.html() + '</table></div></td></tr>');
        $('.saleusrlist .slide').slideToggle('linear');
    }

    function hideElements() {
        $('.FixedHeader_Cloned.fixedHeader.FixedHeader_Header').hide();
        $('#stock-report thead').removeClass("dataTable");
    }

    $('a').click(function(e) {
        var hrefValue = $(this).attr('href');
        if (hrefValue && hrefValue !== "javascript:;" && hrefValue !== "#top") {
            hideElements();
        }
    });
</script>