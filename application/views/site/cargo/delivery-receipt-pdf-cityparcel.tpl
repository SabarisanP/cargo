<style>
    .bordered td {
        border-right-width: 0.1px;
        border-top-width: 0.1px;
        border-left-width: 0.1px;
        border-bottom-width: 0.1px
    }

    .bordered .noborder {
        border: 1px solid #fff;
    }

    .bold {
        font-weight: bold;
    }

    .receipt-title {
        border: 1px solid #000;
        text-align: center;
        font-size: 9px;
    }

    .h-seperator {
        border-bottom: 1px dashed #000;
    }
</style>

{strip}
    {for $i=1 to $print_count}
        <table width="100%">
            <tr>
                <td>
                    {if $namespace == 'ktwoklogistics'}
                        <img src="{$base_url}assets/img/ktwoklogistics-header.jpg" max-width="200px;">
                    {else}
                        <table width="100%" cellpadding="3">
                            <tr>
                                <td align="center">
                                    <span style="font-weight:bold; font-size: 13px;">{$namespace_name}</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    {if isNotNull($nsprofile->namespaceProfile->address)}
                                        {$nsprofile->namespaceProfile->address}, {$nsprofile->namespaceProfile->city} - {$nsprofile->namespaceProfile->pincode}<br>
                                    {/if}
                                    {if isNotNull($summary->tax->gstin)}
                                        <b>GSTIN :</b> {$summary->tax->gstin}
                                    {/if}
                                </td>
                            </tr>
                        </table>
                    {/if}
                </td>
            </tr>
        </table>

        <table cellpadding="3">
            <tr>
                <td width="41%"></td>
                <td class="receipt-title" width="18%">DELIVERY RECEIPT</td>
                <td width="41%"></td>
            </tr>
        </table>

        <table cellpadding="3">
            <tr>
                <td></td>
                <td></td>
                <td align="right">
                    Delivery Date : {$summary->deliveredAt|date_format:$ns_datetime_format}
                </td>
            </tr>
        </table>

        <table class="bordered" cellpadding="3">
            <tr>
                <td>
                    <b>{lang('lr')} No : {$cargoCode}</b><br />
                    <b>Payment Type : {$payment_type_name|strtoupper}</b><br />
                    <b>Booked Date :</b> {$summary->bookedAt|date_format:$ns_datetime_format}
                </td>
                <td>
                    <b>From : </b>{$summary->fromOrganization->name}
                    {if $summary->fromOrganization->address1!=''}
                        <br>{$summary->fromOrganization->address1} {$summary->fromOrganization->address2}
                    {/if}
                    <br>{$summary->fromOrganization->contact}
                    <br><b>Sender :</b>{$summary->fromCustomer->name}
                    <br><b>{$summary->fromCustomer->mobileNumber}</b>
                </td>
                <td>
                    <b>To : </b>{$summary->toOrganization->name}
                    {if $summary->toOrganization->address1!=''}
                        <br>{$summary->toOrganization->address1} {$summary->toOrganization->address2}
                    {/if}
                    <br>{$summary->toOrganization->contact}
                    <br><b>Receiver :</b>{$summary->toCustomer->name}
                    <br><b>{$summary->toCustomer->mobileNumber}</b>
                </td>
            </tr>
        </table>
        <br>

        <br>
        <table>
            <tr>
                <td width="66%">
                    <table class="bordered" cellpadding="3">
                        <thead>
                            <tr>
                                <td align="center"><b>No. of Articles</b></td>
                                <td align="center"><b>Description</b></td>
                                <td align="center"><b>Weight KGs</b></td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$summary->itemDetails item=article}
                                <tr>
                                    <td align="center">{$article->itemCount}</td>
                                    <td align="left">{$article->cargoItem->name|truncate:25}</td>
                                    <td align="center">
                                        {$article->unitValue} {$article_unit[$article->unit->code]}
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
                <td width="1%"></td>
                <td width="33%" align="right">
                    <table class="bordered" cellpadding="3">
                        <thead>
                            <tr>
                                <td align="center"><b>Particulars</b></td>
                                <td align="center"><b>Amount</b></td>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td align="left"><b> Amount Paid </b></td>
                                <td align="right"><b>{$amountpaid|inr_format}</b></td>
                            </tr>
                        </tfoot>
                    </table>
                </td>
            </tr>
        </table>
    {/for}
{/strip}