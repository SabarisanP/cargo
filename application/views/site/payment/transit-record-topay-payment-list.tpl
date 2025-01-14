{if $filter_type == 'SUMMARY'}
    <div class="col-md-12">
        <div class="text-right noprint">
            <div class="btn-group btn-group-sm">
                <button class="btn btn-default" onclick="excelTab()"><i class="fa fa-download fa-lg"></i>Excel</button>
                <button class="btn btn-default notpaytypeprint" onclick="printTab()"><i class="fa fa-print fa-lg"></i>
                    Print</button>
            </div>
        </div>
        <ul class="nav nav-tabs" id="report-tabs">
            <li><a data-toggle="tab" href="#ALL">ALL</a></li>
            <li><a data-toggle="tab" href="#PAID">PAID</a></li>
            <li class="active"> <a data-toggle="tab" href="#UNPAID">UNPAID</a></li>
        </ul>
        <div class="tab-content">
            <div id="ALL" class="tab-pane fade">
                {call summaryWiseTopayALL data=$summaryWiseall}
                {call topayAllRecord data=$stationWise}
                {call topayBranchwise data=$stationWise}
            </div>
            <div id="PAID" class="tab-pane fade">
                {call summaryWiseTopayPaid data=$summaryWisePaid}
                {call topayRecordPaidAmount data=$stationWise}
                {call topayPaidwise data=$stationWise}
            </div>
            <div id="UNPAID" class="tab-pane fade in active">
                {call summaryWiseTopayUnpaid data=$summaryWise}
                {call topayUnPaidRecord data=$stationWise}
                {call topayUnpaidwise data=$stationWise}
            </div>
        </div>
    </div>
{/if}
{function name="topayAllRecord" data=[]}
    {if $filter_type == 'SUMMARY'}
        <div style="overflow: auto;">
        <table id="transit_based_report_ogpl" class="table table-bordered transit-based-all">
            <thead>
                <tr class="success">
                    <td align="center" class="bold" nowrap>Date <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>{lang('ogpl')} No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Vehicle No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Route <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>From Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>To Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Remarks <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Action <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=t_payableAmt value=0}
                {assign var=t_paidAmt value=0}
                {assign var=t_balAmt value=0}

                {foreach item=rows from=$data}
                    {foreach item=row from=$rows}
                        <tr id="row-{$row['ogpl_no']}-{$row['code']}" class="tr-hover"
                            onclick="toggleTopayBranch('row-{$row['ogpl_no']}-{$row['code']}');">
                            <td nowrap>{$row['load_date']}</td>
                            <td>
                                <span class="text-success">
                                    <a class="tab-link"
                                        href="#cargo/ogpl-chart-details?transitCode={$row['transit_code']}&date={$row['load_date']}"
                                        title="View Chart" target="_blank">{$row['ogpl_no']}</a>
                                </span>
                            </td>
                            <td>{$row['vehicle']}</td>
                            <td nowrap> {($row['from_station_name']|cat:" to "|cat:$row['to_station_name'])|truncate:30}</td>
                            <td>{$row['from_station_name']}</td>
                            <td>{$row['to_station_name']}</td>
                            <td align="right">{$row['payable_amt']|number_format:2}</td>
                            <td align="right">{$row['paid_amt']|number_format:2} &nbsp;&nbsp;&nbsp; <a
                                    title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true"
                                        onclick="getTransitAllTransaction('{$row['transit_code']}','{$row['station_code']}','{$row['related_station_code']}')"></i>
                                </a></td>
                            {assign var="rtopay" value=($row['payable_amt']- $row['paid_amt'])}
                            {assign var=t_payableAmt value=$t_payableAmt+$row['payable_amt']}
                            {assign var=t_paidAmt value=$t_paidAmt + $row['paid_amt']}
                            {assign var=t_balAmt value=$t_balAmt + $rtopay}
                            {if $rtopay == 0}
                                <td align="right">{$rtopay|inr_format}</td>
                            {else}
                                <td align="right">
                                    <input type="text" class="form-control topay-pmt-input"
                                        id="{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                        value="{$rtopay|number_format:2:'.':''}"{if $action_rights['HIDE-SAVE-OPTION-TOPAY']<=0} readonly {/if}>
                                       
                                </td>
                            {/if}

                            {if $rtopay == 0}
                                <td align="center">{$row['remark']|trim:', '}</td>
                            {else}
                                {if $row['remark']|trim == '' || $row['remark'] == '' }
                                    <td align="center">
                                        <input type="text" class="form-control"
                                            id="remarks-{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                            maxlength="1000" value="">
                                    </td>
                                {else}
                                    <td>{$row['remark']}
                                        <a href="javascript:;" class="btn btn-sm btn-primary" title="Add Remarks" style="font-size: 5px;"
                                            onclick="remarkAdd('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}')"> <i
                                                class="fa fa-plus" style="font-size:10px;"></i></a>
                                        <br><br>
                                        <input type="text" class="form-control hide add_remark"
                                            id="remarks-{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                            maxlength="1000" value="">
                                    </td>
                                {/if}
                            {/if}

                            {if $rtopay == 0}
                                <td align="center" nowrap><span class="badge">Completed</span>
                                    {if $row['paid_amt'] > 0}
                                        {if $action_rights['HIDE-REVERT-OPTION-TOPAY'] > 0}
                                            <button class="btn-app btn-danger" type="button"
                                                onclick="RevertTransitTopayPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$row['paid_amt']}');">Revert</button>
                                        {/if}
                                    {/if}
                                </td>

                            {else}
                                <td align="center" id="{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}-action"
                                    nowrap>
                                    <span class="act-loading"></span>
                                    <span class="act-status"></span>
                                        {if $action_rights['HIDE-SAVE-OPTION-TOPAY']}
                                            <button class="btn btn-sm btn-success save-btn"
                                                onclick="updateTransitTopayPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$rtopay}');">Save</button>
                                        {/if}
                                        
                                        {if $row['paid_amt'] > 0}
                                        {if $action_rights['HIDE-REVERT-OPTION-TOPAY']>0 }
                                            <button class="btn-app btn-danger" type="button"
                                                onclick="RevertTransitTopayPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$row['paid_amt']}');">Revert</button>
                                        {/if}
                                    {/if}
                                </td>
                            {/if}
                        </tr>
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="11" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>
            {if count($stationWise) > 0}
                <tfoot>
                    <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                        <td colspan="6" align="right">Total</td>
                        <td align="right">{$t_payableAmt|number_format:2}</td>
                        <td align="right">{$t_paidAmt|number_format:2}</td>
                        <td align="right">{$t_balAmt|number_format:2}</td>
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                </tfoot>
            {/if}
        </table>
        </div>
    {/if}
{/function}
{function name="topayRecordPaidAmount" data=[]}
    {if $filter_type == 'SUMMARY'}
        <div style="overflow: auto;">
        <table id="transit_based_report_ogpl_paid" class="table table-bordered transit-based-paid">
            <thead>
                <tr class="success">
                    <td align="center" class="bold" nowrap>Date <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>{lang('ogpl')} No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Vehicle No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Route <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>From Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap> To Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Remarks <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Action <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=t_payableAmt value=0}
                {assign var=t_paidAmt value=0}
                {assign var=t_balAmt value=0}
                {foreach item=rows from=$data}
                    {foreach item=row from=$rows}
                        {assign var=paid_amount value=0}
                        {assign var="paid_amount" value=($row['payable_amt']- $row['paid_amt'])}
                        {if $paid_amount <= 0}
                            <tr id="brn-{$row['ogpl_no']}-{$row['code']}" class="tr-hover"
                                onclick="toggleTopayPaid('brn-{$row['ogpl_no']}-{$row['code']}');">
                                <td nowrap>{$row['load_date']}</td>
                                <td>
                                    <span class="text-success">
                                        <a class="tab-link"
                                            href="#cargo/ogpl-chart-details?transitCode={$row['transit_code']}&date={$row['load_date']}"
                                            title="View Chart" target="_blank">{$row['ogpl_no']}</a>
                                    </span>
                                </td>
                                <td>{$row['vehicle']}</td>
                                <td nowrap> {($row['from_station_name']|cat:" to "|cat:$row['to_station_name'])|truncate:30}</td>
                                <td>{$row['from_station_name']}</td>
                                <td>{$row['to_station_name']}</td>

                                <td align="right">{$row['payable_amt']|number_format:2}</td>
                                <td align="right">{$row['paid_amt']|number_format:2} &nbsp;&nbsp;&nbsp; <a
                                        title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true"
                                            onclick="getTransitAllTransaction('{$row['transit_code']}','{$row['station_code']}','{$row['related_station_code']}')"></i>
                                    </a></td>
                                {assign var="rtopay" value=($row['payable_amt']- $row['paid_amt'])}
                                {assign var=t_payableAmt value=$t_payableAmt+$row['payable_amt']}
                                {assign var=t_paidAmt value=$t_paidAmt + $row['paid_amt']}
                                {assign var=t_balAmt value=$t_balAmt + $rtopay}
                                {if $rtopay == 0}
                                    <td align="right">{$rtopay|inr_format}</td>
                                {else}
                                    <td align="right">
                                        <input type="text" class="form-control topay-pmt-input"
                                            id="{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                            value="{$rtopay|number_format:2:'.':''}" {if $action_rights['HIDE-SAVE-OPTION-TOPAY']<=0} readonly {/if}>
                                    </td>
                                {/if}

                                {if $rtopay == 0}
                                    <td align="center">{$row['remark']|trim:', '}</td>
                                {else}
                                    {if $row['remark']|trim == '' || $row['remark'] == null }
                                        <td align="center">
                                            <input type="text" class="form-control"
                                                id="remarks-{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                                maxlength="1000" value="">
                                        </td>
                                    {else}
                                        <td>{$row['remark']}
                                            <a href="javascript:;" class="btn btn-sm btn-primary" title="Add Remarks" style="font-size: 5px;"
                                                onclick="remarkAdd('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}')"> <i
                                                    class="fa fa-plus" style="font-size:10px;"></i></a>
                                            <br><br>
                                            <input type="text" class="form-control hide add_remark"
                                                id="remarks-{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                                maxlength="1000" value="">
                                        </td>
                                    {/if}
                                {/if}

                                {if $rtopay == 0}
                                    <td align="center" nowrap>
                                        <span class="badge">Completed</span>
                                        {if $row['paid_amt'] > 0}
                                            {if $action_rights['HIDE-REVERT-OPTION-TOPAY']>0}
                                                <button class="btn-app btn-danger" type="button"
                                                    onclick="RevertTransitTopayPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$row['paid_amt']}');">Revert</button>
                                            {/if}
                                        {/if}
                                    </td>
                                {else}
                                    <td align="center" id="{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}-action"
                                        nowrap>
                                        <span class="act-loading"></span>
                                        <span class="act-status"></span>
                                        
                                        {if $action_rights['HIDE-SAVE-OPTION-TOPAY']}
                                            <button class="btn btn-sm btn-success save-btn"
                                                onclick="updateTransitTopayPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$rtopay}');">Save</button>
                                        {/if}
                                      
                                        {if $row['paid_amt'] > 0}
                                            {if $action_rights['HIDE-REVERT-OPTION-TOPAY']>0}
                                                <button class="btn-app btn-danger" type="button"
                                                    onclick="RevertTransitTopayPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$row['paid_amt']}');">Revert</button>
                                            {/if}
                                        {/if}
                                    </td>
                                {/if}
                            </tr>
                        {/if}
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="11" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>
            {if count($stationWise) > 0}
                <tfoot>
                    <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                        <td colspan="6" align="right">Total</td>
                        <td align="right">{$t_payableAmt|number_format:2}</td>
                        <td align="right">{$t_paidAmt|number_format:2}</td>
                        <td align="right">{$t_balAmt|number_format:2}</td>
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                </tfoot>
            {/if}
        </table>
        </div>
    {/if}
{/function}
{function name="topayUnPaidRecord" data=[]}
    {if $filter_type == 'SUMMARY'}
        {* <button type="button" style="text-align:right;'" class="btn btn-success" id="makeAllPayment" onclick="showConfirmationPopup();" >Make Payment</button> *}
        <div  style="overflow: auto;">
        <button id="makeAllPayment" class="btn btn-success" style="display: none; float: right; margin-top: 10px;" onclick="showConfirmationPopup();">Make Payments</button>
        <table id="transit_based_report_ogpl_unpaid" class="table table-bordered transit-based-unpaid">
       
            <thead>
                <tr class="success">
                    <td align="center" class="bold" nowrap></td>
                    <td align="center" class="bold" nowrap>Date <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>{lang('ogpl')} No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Vehicle No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Route <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>From Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap> To Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Remarks <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Action <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                {assign var=t_payableAmt value=0}
                {assign var=t_paidAmt value=0}
                {assign var=t_balAmt value=0}
                {foreach item=rows from=$data}
                    {foreach item=row from=$rows}
                        {assign var=un_paid_amount value=0}
                        {assign var="un_paid_amount" value=($row['payable_amt']- $row['paid_amt'])}
                        {if $un_paid_amount > 0}
                            <tr id="un-{$row['ogpl_no']}-{$row['code']}" class="tr-hover"
                                onclick="toggleTopayUnPaid('un-{$row['ogpl_no']}-{$row['code']}');">
                                {assign var="rtopay" value=($row['payable_amt']- $row['paid_amt'])}
                                {assign var=t_payableAmt value=$t_payableAmt+$row['payable_amt']}
                                {assign var=t_paidAmt value=$t_paidAmt + $row['paid_amt']}
                                {assign var=t_balAmt value=$t_balAmt + $rtopay}
                                <td nowrap> <input type="checkbox" class="checked-list list-{$row['code']}"
                                        data-code="{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                        data-branch_code="{$row['branch_code']}"
                                        data-related_organization_code="{$row['related_organization_code']}"
                                        data-transit_code="{$row['transit_code']}" data-branch_code="{$row['branch_code']}"
                                        data-related_organization_code="{$row['related_organization_code']}" data-rtopay="{$rtopay}"
                                        onclick="makeCalculation(this);"></td>
                                <td nowrap>{$row['load_date']}</td>
                                <td>
                                    <span class="text-success">
                                        <a class="tab-link"
                                            href="#cargo/ogpl-chart-details?transitCode={$row['transit_code']}&date={$row['load_date']}"
                                            title="View Chart" target="_blank">{$row['ogpl_no']}</a>
                                    </span>
                                </td>
                                <td>{$row['vehicle']}</td>
                                <td nowrap> {($row['from_station_name']|cat:" to "|cat:$row['to_station_name'])|truncate:30}</td>
                                <td>{$row['from_station_name']}</td>
                                <td>{$row['to_station_name']}</td>

                                <td align="right">{$row['payable_amt']|number_format:2}</td>
                                <td align="right">{$row['paid_amt']|number_format:2} &nbsp;&nbsp;&nbsp; <a
                                        title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true"
                                            onclick="getTransitAllTransaction('{$row['transit_code']}','{$row['station_code']}','{$row['related_station_code']}')"></i>
                                    </a></td>

                                {if $rtopay == 0}
                                    <td align="right">{$rtopay|inr_format}</td>
                                {else}
                                    <td align="right">
                                        <input type="text" class="form-control topay-pmt-input"
                                            id="row-{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                            value="{$rtopay|number_format:2:'.':''}" {if $action_rights['HIDE-SAVE-OPTION-TOPAY']<=0} readonly {/if}>
                                    </td>
                                {/if}

                                {if $rtopay == 0}
                                    <td align="center">{$row['remark']|trim:', '}</td>
                                {else}
                                    {if $row['remark']|trim == '' || $row['remark'] == null }
                                        <td align="center">
                                            <input type="text" class="form-control"
                                                id="unpaid-{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                                maxlength="1000" value="">
                                        </td>
                                    {else}
                                        <td>{$row['remark']}
                                            <a href="javascript:;" class="btn btn-sm btn-primary" title="Add Remarks" style="font-size: 5px;"
                                                onclick="remarkAddUnpaid('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}')">
                                                <i class="fa fa-plus" style="font-size:10px;"></i></a>
                                            <br><br>
                                            <input type="text" class="form-control hide add_remark"
                                                id="unpaid-{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}"
                                                maxlength="1000" value="">
                                        </td>
                                    {/if}
                                {/if}

                                {if $rtopay == 0}
                                    <td align="left" nowrap>
                                        <span class="badge">Completed</span>
                                        {if $row['paid_amt'] > 0}
                                            {if $action_rights['HIDE-REVERT-OPTION-TOPAY']>0}
                                                <button class="btn-app btn-danger" type="button"
                                                    onclick="RevertTransitTopayPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$row['paid_amt']}');">Revert</button>
                                            {/if}
                                        {/if}
                                    </td>
                                {else}
                                    <td align="left" id="{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}-action"
                                        nowrap>
                                        <span class="act-loading"></span>
                                        <span class="act-status"></span>
                                    
                                        {if $action_rights['HIDE-SAVE-OPTION-TOPAY']}
                                            <button class="btn btn-sm btn-success save-btn myButton"
                                                onclick="updateTransitUnpaidPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$rtopay}');">Save</button>
                                        {/if}
                                      
                                        {if $row['paid_amt'] > 0}
                                            {if $action_rights['HIDE-REVERT-OPTION-TOPAY']>0}
                                                <button class="btn-app btn-danger" type="button"
                                                    onclick="RevertTransitTopayPayment('{$row['ogpl_no']}{$row['branch_code']}{$row['related_organization_code']}','{$row['transit_code']}','{$row['branch_code']}','{$row['related_organization_code']}','{$row['paid_amt']}');">Revert</button>
                                            {/if}
                                        {/if}
                                    </td>
                                {/if}
                            </tr>
                        {/if}
                    {/foreach}
                {foreachelse}
                    <tr>
                        <td colspan="11" align="center">No data found</td>
                    </tr>
                {/foreach}
            </tbody>
            {if count($stationWise) > 0}
                <tfoot>
                    <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                        <td colspan="7" align="right">Total</td>
                        <td align="right">{$t_payableAmt|number_format:2}</td>
                        <td align="right">{$t_paidAmt|number_format:2}</td>
                        <td align="right">{$t_balAmt|number_format:2}</td>
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                </tfoot>
            {/if}
        </table>
        </div>
    {/if}
{/function}
{if $filter_type == 'Trasaction_view'}
    <div>
        <div class="row">
            <div class="col-md-10 bold ft_14"></div>
            <div class="col-md-2">
                <a class="align-right" onclick="closeTransitTopayDialog()" href="javascript:;"
                    title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
            </div>
        </div>
    </div>
    <table id="transit_based_branch_report_table" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center">Date</td>
                <td align="center" nowrap>User</td>
                <td align="center" nowrap>Transaction (Rs)</td>
                <td align="center">Remarks</td>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach item=row from=$result}
                <tr>
                    <td align="center" nowrap>{$row->transactionAt|date_format:$ns_datetime_format}</td>
                    <td align="center">{$row->user->name}</td>
                    <td align="right">{if $row->transactionType->code =="PMT"}+{else} -{/if}{$row->transactionAmount|inr_format}
                    </td>
                    <td align="center">{$row->remarks|default:'-'}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="4" align="center">No data found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{/if}
{function name="topayBranchwise" data=[]}
    <table class="hide noprint branch-drill-down">
        {foreach item=brns from=$data}
            {foreach item=brn from=$brns}
                <tr class="row-{$brn['ogpl_no']}-{$brn['code']}  branch-drill-down">
                    <td>
                        <table id="transit_based_branch" class="table table-bordered table-bordered m_b_5">
                            <thead>
                                <tr class="success">
                                    <td align="center" width="10%">Date</td>
                                    <td align="center" width="10%">{lang('ogpl')} No.</td>
                                    <td align="center" width="10%">Vehicle No.</td>
                                    <td align="center" width="20%">Route</td>
                                    <td align="center" width="15%">From Station</td>
                                    <td align="center" width="15%">To Station</td>
                                    <td align="center" width="10%" nowrap>Branch Name</td>
                                    <td align="center" width="10%" nowrap>Net Payable</td>
                                </tr>
                            </thead>
                            <tbody class="body_table">
                                {assign var=t_payableAmt value=0}
                                {assign var=t_paidAmt value=0}
                                {assign var=t_balAmt value=0}
                                {foreach item=row from=$brn['data']}
                                    <tr>
                                        <td nowrap>{$row->loaded_date|date_format:$ns_date_format}</td>
                                        <td>
                                            <span class="text-success">
                                                <a class="tab-link"
                                                    href="#cargo/ogpl-chart-details?transitCode={$row->transit_code}&date={$row->trip_date}"
                                                    title="View Chart" target="_blank">{$row->transit_alias_code}</a>
                                            </span>
                                        </td>
                                        <td>{$row->registration_number}</td>
                                        <td nowrap>
                                            {($row->transit_from_station_name|cat:" to "|cat:$row->transit_to_station_name)|truncate:30}
                                        </td>
                                        <td>{$row->station_name}</td>
                                        <td>{$row->related_organization_name}</td>
                                        <td>{$row->organization_name}</td>
                                        <td align="right">
                                            {(($row->topay_amount)-($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount))|number_format:2}
                                        </td>
                                        {* <td align="right">{$row->transit_payment_amount|number_format:2} &nbsp;&nbsp;&nbsp; <a title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true" onclick="getTransitAllTransaction('{$row->transit_code}','{$row->organization_code}','{$row->related_organization_code}')"></i> </a></td> *}
                                        {assign var="rtopay" value=((($row->topay_amount) -($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount)) -($row->transit_payment_amount))}
                                        {assign var=t_payableAmt value=$t_payableAmt+($row->topay_amount)-($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount)}
                                        {assign var=t_paidAmt value=$t_paidAmt + $row->transit_payment_amount}
                                        {assign var=t_balAmt value=$t_balAmt + $rtopay}
                                    </tr>
                                {/foreach}
                            </tbody>
                            <tfoot>
                                <tr style=" font-weight: bold;">
                                    <td colspan="7" align="right">Total</td>
                                    <td align="right">{$t_payableAmt|number_format:2}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </td>
                </tr>
            {/foreach}
        {/foreach}
    </table>
{/function}
{function name="topayPaidwise" data=[]}
    <table class="hide noprint paid-drill-down">
        {foreach item=brns from=$data}
            {foreach item=brn from=$brns}
                <tr class="brn-{$brn['ogpl_no']}-{$brn['code']}  paid-drill-down">
                    <td>
                        <table id="transit_based_branch" class="table table-bordered table-bordered m_b_5">
                            <thead>
                                <tr class="success">
                                    <td align="center" width="10%">Date</td>
                                    <td align="center" width="10%">{lang('ogpl')} No.</td>
                                    <td align="center" width="10%">Vehicle No.</td>
                                    <td align="center" width="20%">Route</td>
                                    <td align="center" width="15%">From Station</td>
                                    <td align="center" width="15%">To Station</td>
                                    <td align="center" width="10%" nowrap>Branch Name</td>
                                    <td align="center" width="10%" nowrap>Net Payable</td>
                                </tr>
                            </thead>
                            <tbody class="body_table">
                                {assign var=t_payableAmt value=0}
                                {assign var=t_paidAmt value=0}
                                {assign var=t_balAmt value=0}
                                {foreach item=row from=$brn['data']}
                                    <tr>
                                        <td nowrap>{$row->loaded_date|date_format:$ns_date_format}</td>
                                        <td>
                                            <span class="text-success">
                                                <a class="tab-link"
                                                    href="#cargo/ogpl-chart-details?transitCode={$row->transit_code}&date={$row->trip_date}"
                                                    title="View Chart" target="_blank">{$row->transit_alias_code}</a>
                                            </span>
                                        </td>
                                        <td>{$row->registration_number}</td>
                                        <td nowrap>
                                            {($row->transit_from_station_name|cat:" to "|cat:$row->transit_to_station_name)|truncate:30}
                                        </td>
                                        <td>{$row->station_name}</td>
                                        <td>{$row->related_organization_name}</td>
                                        <td>{$row->organization_name}</td>
                                        <td align="right">
                                            {(($row->topay_amount)-($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount))|number_format:2}
                                        </td>
                                        {* <td align="right">{$row->transit_payment_amount|number_format:2} &nbsp;&nbsp;&nbsp; <a title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true" onclick="getTransitAllTransaction('{$row->transit_code}','{$row->organization_code}','{$row->related_organization_code}')"></i> </a></td> *}
                                        {assign var="rtopay" value=((($row->topay_amount) -($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount)) -($row->transit_payment_amount))}
                                        {assign var=t_payableAmt value=$t_payableAmt+($row->topay_amount)-($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount)}
                                        {assign var=t_paidAmt value=$t_paidAmt + $row->transit_payment_amount}
                                        {assign var=t_balAmt value=$t_balAmt + $rtopay}
                                    </tr>
                                {/foreach}
                            </tbody>
                            <tfoot>
                                <tr style=" font-weight: bold;">
                                    <td colspan="7" align="right">Total</td>
                                    <td align="right">{$t_payableAmt|number_format:2}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </td>
                </tr>
            {/foreach}
        {/foreach}
    </table>
{/function}

{function name="topayUnpaidwise" data=[]}
    <table class="hide noprint branch-drill-down">
        {foreach item=brns from=$data}
            {foreach item=brn from=$brns}
                <tr class="un-{$brn['ogpl_no']}-{$brn['code']}  un-paid-drill-down">
                    <td>
                        <table id="transit_based_branch" class="table table-bordered table-bordered m_b_5">
                            <thead>
                                <tr class="success">
                                    <td align="center" width="10%">Date</td>
                                    <td align="center" width="10%">{lang('ogpl')} No.</td>
                                    <td align="center" width="10%">Vehicle No.</td>
                                    <td align="center" width="20%">Route</td>
                                    <td align="center" width="15%">From Station</td>
                                    <td align="center" width="15%">To Station</td>
                                    <td align="center" width="10%" nowrap>Branch Name</td>
                                    <td align="center" width="10%" nowrap>Net Payable</td>
                                </tr>
                            </thead>
                            <tbody class="body_table">
                                {assign var=t_payableAmt value=0}
                                {assign var=t_paidAmt value=0}
                                {assign var=t_balAmt value=0}
                                {foreach item=row from=$brn['data']}
                                    <tr>
                                        <td nowrap>{$row->loaded_date|date_format:$ns_date_format}</td>
                                        <td>
                                            <span class="text-success">
                                                <a class="tab-link"
                                                    href="#cargo/ogpl-chart-details?transitCode={$row->transit_code}&date={$row->trip_date}"
                                                    title="View Chart" target="_blank">{$row->transit_alias_code}</a>
                                            </span>
                                        </td>
                                        <td>{$row->registration_number}</td>
                                        <td nowrap>
                                            {($row->transit_from_station_name|cat:" to "|cat:$row->transit_to_station_name)|truncate:30}
                                        </td>
                                        <td>{$row->station_name}</td>
                                        <td>{$row->related_organization_name}</td>
                                        <td>{$row->organization_name}</td>
                                        <td align="right">
                                            {(($row->topay_amount)-($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount))|number_format:2}
                                        </td>
                                        {* <td align="right">{$row->transit_payment_amount|number_format:2} &nbsp;&nbsp;&nbsp; <a title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true" onclick="getTransitAllTransaction('{$row->transit_code}','{$row->organization_code}','{$row->related_organization_code}')"></i> </a></td> *}
                                        {assign var="rtopay" value=((($row->topay_amount) -($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount)) -($row->transit_payment_amount))}
                                        {assign var=t_payableAmt value=$t_payableAmt+($row->topay_amount)-($row->topay_hamali_charge + $row->topay_demurrage_charge+ $row->topay_unload_handling_amount)}
                                        {assign var=t_paidAmt value=$t_paidAmt + $row->transit_payment_amount}
                                        {assign var=t_balAmt value=$t_balAmt + $rtopay}
                                    </tr>
                                {/foreach}
                            </tbody>
                            <tfoot>
                                <tr style=" font-weight: bold;">
                                    <td colspan="7" align="right">Total</td>
                                    <td align="right">{$t_payableAmt|number_format:2}</td>
                                </tr>
                            </tfoot>
                        </table>
                    </td>
                </tr>
            {/foreach}
        {/foreach}
    </table>
{/function}
{function name="summaryWiseTopayALL" data=[]}
    {if $filterCode == "NA"}
        <div class="row">
            <div class="col-md-4"><br><br>
                <table id="transit_based_summary_all" class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {assign var=t_payable value=0}
                        {assign var=t_paid value=0}
                        {assign var=t_bal value=0}
                        {foreach item=row from=$data}
                            {if $row['name'] =="ALL"}
                                <tr>
                                    <td>{$row['to_station_name']}</td>
                                    <td align="right">{$row['payable_amt']|number_format:2}</td>
                                    <td align="right">{$row['paid_amt']|number_format:2}</td>
                                    <td align="right">{$row['bal_amt']}</td>
                                </tr>
                                {assign var=t_payable value=$t_payable+$row['payable_amt']}
                                {assign var=t_paid value=$t_paid+$row['paid_amt']}
                                {assign var=t_bal value=$t_bal+$row['bal_amt']}
                            {/if}

                        {/foreach}
                    </tbody>
                    {if count($summaryWise) > 0}
                        <tfoot>
                            <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                                <td align="right">Total</td>
                                <td align="right">{$t_payable|number_format:2}</td>
                                <td align="right">{$t_paid|number_format:2}</td>
                                <td align="right">{$t_bal|number_format:2}</td>

                            </tr>
                        </tfoot>
                    {/if}
                </table>
            </div>
            <div class="col-md-4"></div>
            <div class="col-md-4"></div>
        </div>
    {/if}
{/function}
{function name="summaryWiseTopayPaid" data=[]}
    {if $filterCode == "NA"}
        <div class="row">
            <div class="col-md-4"><br><br>
                <table id="transit_based_summary_paid" class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        {assign var=t_payable value=0}
                        {assign var=t_paid value=0}
                        {assign var=t_bal value=0}
                        {foreach item=row from=$data}
                            {if $row['name'] =="PAID"}
                                <tr>
                                    <td>{$row['to_station_name']}</td>
                                    <td align="right">{$row['payable_amt']|number_format:2}</td>
                                    <td align="right">{$row['paid_amt']|number_format:2}</td>
                                    <td align="right">{$row['bal_amt']}</td>
                                </tr>
                                {assign var=t_payable value=$t_payable+$row['payable_amt']}
                                {assign var=t_paid value=$t_paid+$row['paid_amt']}
                                {assign var=t_bal value=$t_bal+$row['bal_amt']}
                            {/if}
                       
                        {/foreach}
                    </tbody>
                    {if count($summaryWise) > 0}
                        <tfoot>
                            <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                                <td align="right">Total</td>
                                <td align="right">{$t_payable|number_format:2}</td>
                                <td align="right">{$t_paid|number_format:2}</td>
                                <td align="right">{$t_bal|number_format:2}</td>
                            </tr>
                        </tfoot>
                    {/if}
                </table>
            </div>
            <div class="col-md-4"></div>
            <div class="col-md-4"></div>
        </div>
    {/if}
{/function}
{function name="summaryWiseTopayUnpaid" data=[]}
    {if $filterCode == "NA"}
        <div class="row">
            <div class="col-md-4"><br><br>
                <table id="transit_based_summary_unpaid" class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">

                        {assign var=t_payable value=0}
                        {assign var=t_paid value=0}
                        {assign var=t_bal value=0}
                        {foreach item=row from=$data}
                            {if $row['name'] =="UNPAID"}
                                <tr>
                                    <td>{$row['to_station_name']}</td>
                                    <td align="right">{$row['payable_amt']|number_format:2}</td>
                                    <td align="right">{$row['paid_amt']|number_format:2}</td>
                                    <td align="right">{$row['bal_amt']}</td>
                                </tr>
                                {assign var=t_payable value=$t_payable+$row['payable_amt']}
                                {assign var=t_paid value=$t_paid+$row['paid_amt']}
                                {assign var=t_bal value=$t_bal+$row['bal_amt']}
                            {/if}
                        {/foreach}
                    </tbody>
                    {if count($summaryWise) > 0}
                        <tfoot>
                            <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                                <td align="right">Total</td>
                                <td align="right">{$t_payable|number_format:2}</td>
                                <td align="right">{$t_paid|number_format:2}</td>
                                <td align="right">{$t_bal|number_format:2}</td>

                            </tr>
                        </tfoot>
                    {/if}
                </table>
            </div>
            <div class="col-md-4"></div>
            <div class="col-md-4"></div>
        </div>
    {/if}
    <div id="confirmation-modal" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Payments</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                <div>
                <label for ="total-amount">Total Selected Amount:  <b><span class="total-selected-amount"></span></b></label>
                <input type="number" class="form-control" id="total-amount">
                </div>
                <div>
                    <label for ="total-amount">Remarks</label>
                    <textarea id="common-remarks" name="remarks" class="form-control"
                        placeholder="Enter remarks for all selected payments"></textarea>
                 </div>
                </div>
                <div class="modal-footer">
                    <div class="alert fl" id="action-state">Haridas</div> 
                    <button type="button" class="btn btn-primary" onclick="confirmPayments()">Save</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
{/function}
<script>
    var lrdata ={$stationWise|json_encode}

    if (isNotNull(lrdata)) {
        $('#transit_based_summary_unpaid,#transit_based_summary_paid,#transit_based_summary_all').dataTable({
            "bPaginate": false,
            "info": false,
            "dom": 'lrt',
            "aaSorting": [
                [0, "asc"]
            ]
        });
    }
    if (isNotNull(lrdata)) {
        $('.transit-based-unpaid,.transit-based-paid ,.transit-based-all').DataTable({
            info: false,
            searching: true,
            paging: false,
            order: [
                [0, 'asc']
            ],
            columnDefs: [{
                targets: 'no-sort',
                orderable: false,
            }]
        });
    }

    var namespaceCode = {$namespaceCode|json_encode};
    $('[data-toggle="popover"]').popover({
        placement: 'bottom',
        html: true,
        trigger: 'hover'
    });

    $('#transit_based_branch_report_table input').keypress(function(event) {
        if (event.keyCode == 13) {
            updateTransitTopayPayment($(this).attr('id'));
            remarkAdd($(this).attr('id'));
        }
    });

    function toggleTopayBranch(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();

        var $trows = $('.branch-drill-down').filter('.' + code);
        $('#' + code).after('<tr class="branchlist ' + code +
            '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">' +
            $trows.html() + '</table></div></td></tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function toggleTopayPaid(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();

        var $trows = $('.paid-drill-down').filter('.' + code);

        $('#' + code).after('<tr class="branchlist ' + code +
            '"> <td colspan = "100%" ><div class = "slide"style = "display: none;" ><table width = "100%" > ' +
            $trows.html() + '</table> </div> </td> </tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function toggleTopayUnPaid(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();
        var $trows = $('.un-paid-drill-down').filter('.' + code);
        $('#' + code).after('<tr class="branchlist ' + code +
            '"><td colspan="100%"> <div class="slide" style="display: none;"> <table width = "100%" > ' +
            $trows.html() + '</table></div></td></tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function excelTab() {
        var activeTab = $("#report-tabs li.active a").attr("href");
        if (activeTab === "#ALL") {
            exportTransitToPayExcel("ALL");
        } else if (activeTab === "#PAID") {
            exportTransitToPayExcel("PAID");
        } else if (activeTab === "#UNPAID") {
            exportTransitToPayExcel("UNPAID");
        }
    }

    function printTab() {
        var activeTab = $("#report-tabs li.active a").attr("href");
        if (activeTab === "#ALL") {
            printTransitToPay("ALL");
        } else if (activeTab === "#PAID") {
            printTransitToPay("PAID");
        } else if (activeTab === "#UNPAID") {
            printTransitToPay("UNPAID");
        }
    }

    function makeCalculation(elm) {
      let $row = $(elm).closest('tr');
        if ($(elm).is(':checked')) {
            $row.find('.topay-pmt-input').prop('disabled', true);
            $row.find('.save-btn').hide();
        } else {
            $row.find('.topay-pmt-input').prop('disabled', false);
            $row.find('.save-btn').show();
        }

        if($('.checked-list:checked').length > 0){
            $('#makeAllPayment').show();
        }else{
            $('#makeAllPayment').hide();
        }
        selectedLists();
    }

    function selectedLists() {
        var data = [];
        $('.checked-list:checked').each(function() {
            // handeBtn('hide');
            $('#unpaid-' + code).attr('disabled', true);
            $('#row-' + code + '-action .save-btn').addClass('hide');

            var code = $(this).data('code');
            var frmOrgCode = $(this).data('branch_code');
            var relOrgCode = $(this).data('related_organization_code');
            var transitCode = $(this).data('transit_code');
            var rtopay = $(this).data('rtopay');
            var list = {};
            list.code = '';
            transactionType = {};
            list.transactionType = "PMT";

            list.transactionAmount = $.trim($('#row-' + code).val());
            list.remarks ="";
            list.fromOrganization = frmOrgCode;
            list.organization = relOrgCode;
            list.transitCargo = transitCode;
            // var paid_amount = parseInt(rtopay);
            data.push(list);
        });
        return data;
    }
    function showConfirmationPopup() {
      let totalAmount =  0 ;
      selectedLists().forEach(obj => {
        totalAmount += Number(obj.transactionAmount);
      });
      $('.total-selected-amount').text(totalAmount);
      $('#total-amount').val(totalAmount);

      $('#confirmation-modal').modal('show');

    }
    
    $(document).ready(function(){
        $('#makeAllPayment').hide();
    })

</script>