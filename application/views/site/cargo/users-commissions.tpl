<div class="table-responsive">
    <table id="cargo_comm_table" class="table table-striped table-bordered">
        <thead>
            <tr>
                {if $cargo_setting->captureStateWiseCommissionFlag}
                    <th rowspan="2" class="valign-bottom">State</th>
                {/if}
                <th colspan="5" class="text-center">Booking Commissions</th>
                <th colspan="5" class="text-center">Delivery Commissions</th>
                <th rowspan="2" class="valign-bottom">Credit Limit</th>
                <th rowspan="2" width="60"></th>
            </tr>
            <tr>
                <th>Paid {lang('lr')}</th>
                <th>ToPay {lang('lr')}</th>
                <th>AccPay {lang('lr')}</th>
                <th>Door Pickup</th>
                <th>Loading Share</th>
                <th>Paid {lang('lr')}</th>
                <th>ToPay {lang('lr')}</th>
                <th>AccPay {lang('lr')}</th>
                <th>Door Delivery</th>
                <th>Unloading Share</th>
            </tr>
        </thead>
        <tbody class="body_table">
            {foreach from=$result item=$row}
                {if !$cargo_setting->captureStateWiseCommissionFlag && isNotNull($row->state->code)}
                    {continue}
                {/if}
                <tr>
                    {if $cargo_setting->captureStateWiseCommissionFlag}
                        <td>{$row->state->name|default:'Default'}</td>
                    {/if}
                    <td align="right" nowrap>
                        {if $row->paidCommissionTypeCode == 'PER'}
                            {$row->paidCommissionValue} %
                        {elseif $row->paidCommissionTypeCode == 'FLT'}
                            Rs. {$row->paidCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->toPayCommissionTypeCode == 'PER'}
                            {$row->toPayCommissionValue} %
                        {elseif $row->toPayCommissionTypeCode == 'FLT'}
                            Rs. {$row->toPayCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->accPayCommissionTypeCode == 'PER'}
                            {$row->accPayCommissionValue} %
                        {elseif $row->accPayCommissionTypeCode == 'FLT'}
                            Rs. {$row->accPayCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->doorPickupCommissionTypeCode == 'PER'}
                            {$row->doorPickupCommissionValue} %
                        {elseif $row->doorPickupCommissionTypeCode == 'FLT'}
                            Rs. {$row->doorPickupCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->loadingCommissionTypeCode == 'PER'}
                            {$row->loadingCommissionValue} %
                        {elseif $row->loadingCommissionTypeCode == 'FLT'}
                            Rs. {$row->loadingCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->deliveryPaidCommissionTypeCode == 'PER'}
                            {$row->delivaryPaidCommissionValue} %
                        {elseif $row->deliveryPaidCommissionTypeCode == 'FLT'}
                            Rs. {$row->delivaryPaidCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->deliveryTopayCommissionTypeCode == 'PER'}
                            {$row->delivaryTopayCommissionValue} %
                        {elseif $row->deliveryTopayCommissionTypeCode == 'FLT'}
                            Rs. {$row->delivaryTopayCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->deliveryAccpayCommissionTypeCode == 'PER'}
                            {$row->delivaryAccpayCommissionValue} %
                        {elseif $row->deliveryAccpayCommissionTypeCode == 'FLT'}
                            Rs. {$row->delivaryAccpayCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->doorDeliveryCommissionTypeCode == 'PER'}
                            {$row->doorDeliveryCommissionValue} %
                        {elseif $row->doorDeliveryCommissionTypeCode == 'FLT'}
                            Rs. {$row->doorDeliveryCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {if $row->unloadingCommissionTypeCode == 'PER'}
                            {$row->unloadingCommissionValue} %
                        {elseif $row->unloadingCommissionTypeCode == 'FLT'}
                            Rs. {$row->unloadingCommissionValue}
                        {else}
                            -
                        {/if}
                    </td>
                    <td align="right" nowrap>
                        {$row->creditLimit}
                    </td>
                    <td align="center">
                        <a class="edit" title="Edit" href="javascript:;" onclick="commissionsDialog({$row|json_encode|escape})"><i class="fa fa-pencil fa-lg"></i></a>&nbsp;
                        <a class="delete" title="Delete" href="javascript:;" onclick="deleteUserCommissions({$row|json_encode|escape}, '{$userCode}')"><i class="fa fa-trash-o fa-lg"></i></a>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
