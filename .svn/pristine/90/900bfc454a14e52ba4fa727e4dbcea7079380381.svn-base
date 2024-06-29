<div>
    <table class="table table-hover table-design" id='trip-expenses-schedules-list' width="50%">
            <tr>
                <th>
                    Trip cash head
                </th>
                
                <th>
                    <table class="col-xs-6">
                        <tr><th colspan="2">Amount</th></tr>
                        <tr><td>Cr</td><td>Dr</td></tr>
                    </table>
                </th>
                <th>
                    Remark
                </th>
            </tr>
            {foreach item=txp from=$transexpn}
                <tr>
                    <td>{$txp->tripCashHeadIO->name}</td>
                    
                    <td>
                        <table class="col-xs-6">
                            <tr> 
                                <td><div class="col-md-12">{if $txp->tripCashHeadIO->creditDebitFlag=='Cr' || $txp->tripCashHeadIO->creditDebitFlag==''}{$txp->amount}{/if}</div></td>
                                <td><div class="col-md-12">{if $txp->tripCashHeadIO->creditDebitFlag=='Dr'}{$txp->amount}{/if}</div></td>
                            </tr>
                        </table>
                    </td>
                    <td>{$txp->remark}</td>
                </tr>
            {/foreach}    
                <tr>
                    <td></td>
                    
                    <td>
                        <table class="col-xs-6">
                            <tr> 
                                <td><div class="col-md-12 p_l_n">{$creditAmount}</div></td>
                                <td><div class="col-md-12 p_l_n">{$debitAmount}</div></td>
                            </tr>
                            <tr>
                                <td colspan="2"><div class="col-md-12" align="center"><span class="bold">Total </span>: {$totalAmount}</div></td>
                            </tr>
                        </table>
                    </td>
                    <td></td>
                </tr>
        </table>
        <form  role="form" id="form1" class="form-horizontal" >
            <a href="javascript:;"  class="pTip_top" title="Add new Expenses" id="toggle-expensive"><i class="fa fa-plus"></i>&nbsp;Trip Expenses</a>
            <div class="clear_fix_both"></div>
            <br />
            <div class="box_content  col-md-10 toggle-expensive-list">
                <div class="pull-left">                
                    <div class="pull-left">
                        <label> Name</label>
                        <div class="col-md-12 p_l_n">
                            <input type="text" class="form-control" id="exps-name" name="exps-name" data-parsley-required="true" value="">
                        </div>
                    </div>
                    <div class="pull-left">
                        <label>Transaction mode</label>
                        <div class="col-md-12  p_l_n">
                            <select id="exps-mode" class="form-control">
                                <option value="">Mode</option>
                                {foreach item=row from=$transmode} 
                                    {if $row->name!=''}
                                        <option value="{$row->code}">{$row->name}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="pull-left">
                        <label> Trip Cash Head</label>
                        <div class="col-md-12 p_l_n">
                            <select id="exps-head" class="form-control">
                                <option value="">Trip head</option>
                                {foreach item=row from=$triphead} 
                                    {if $row->name!=''}
                                        <option value="{$row->code}">{$row->name}</option>
                                    {/if}
                                {/foreach} 
                            </select>
                        </div>
                    </div>
                    <div class="pull-left">
                        <label> Amount</label>
                        <div class="col-md-12 p_l_n">
                            <input type="text" class="form-control" id="exps-amount" name="exps-amount" value="">
                        </div>
                    </div>
                    <div class="pull-left">
                        <label> Remarks</label>
                        <div class="col-md-12 p_l_n">
                            <input type="text" class="form-control" id="exps-remark" name="exps-remark" value="">
                        </div>
                    </div>
                    <div class="pull-left booking-button">
                        <label>&nbsp;</label>
                        <div class="col-md-12 p_l_n m-t-5">
                            <button class="btn btn-success btn-xs" type="button" onclick="saveTripExpensive()"><i class="fa fa-plus"></i>&nbsp;Add</button>
                        </div>
                    </div>
                </div>
               <div class="clear_fix_both"></div><br>
               <div id="sch-trp-exp"></div>
            </div>
        </form>               
</div>